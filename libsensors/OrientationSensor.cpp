/*
 * Copyright (C) 2008 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <fcntl.h>
#include <errno.h>
#include <math.h>
#include <poll.h>
#include <string.h>
#include <unistd.h>
#include <dirent.h>
#include <sys/select.h>
#include <cutils/log.h>
#include <cutils/properties.h>

#include "OrientationSensor.h"

/*****************************************************************************/

OrientationSensor::OrientationSensor()
    : SensorBase(NULL, "orientation"),
      mEnabled(0),
      mDelay(-1),
      mInputReader(4),
      mHasPendingEvent(false)
{
    mPendingEvent.version = sizeof(sensors_event_t);
    mPendingEvent.sensor = ID_O;
    mPendingEvent.type = SENSOR_TYPE_ORIENTATION;
    memset(mPendingEvent.data, 0, sizeof(mPendingEvent.data));

    if (data_fd >= 0) {
        strcpy(input_sysfs_path, "/sys/class/input/");
        strcat(input_sysfs_path, input_name);
        strcat(input_sysfs_path, "/device/");
        input_sysfs_path_len = strlen(input_sysfs_path);
        ALOGD("OrientationSensor: sysfs_path=%s", input_sysfs_path);
    } else {
        input_sysfs_path[0] = '\0';
        input_sysfs_path_len = 0;
    }
}

OrientationSensor::~OrientationSensor() {
    if (mEnabled) {
        setEnable(0, 0);
    }
}

bool OrientationSensor::hasPendingEvents() const {
    return mHasPendingEvent;
}

int OrientationSensor::setEnable(int32_t handle, int enabled) {
    int err = 0;
    char buffer[2];

    /* handle check */
    if (handle != ID_O) {
        ALOGE("OrientationSensor: Invalid handle (%d)", handle);
        return -EINVAL;
    }

    buffer[0] = '\0';
    buffer[1] = '\0';

    if (mEnabled <= 0) {
        if(enabled) buffer[0] = '1';
    } else if (mEnabled == 1) {
        if(!enabled) buffer[0] = '0';
    }

    if (buffer[0] != '\0') {
        strcpy(&input_sysfs_path[input_sysfs_path_len], "enable");
        err = write_sys_attribute(input_sysfs_path, buffer, 1);
        if (err != 0) {
            return err;
        }
        ALOGD("OrientationSensor: Control set %s", buffer);
    }

    if (enabled) {
        mEnabled++;
        if (mEnabled > 32767) mEnabled = 32767;
    } else {
        mEnabled--;
        if (mEnabled < 0) mEnabled = 0;
    }
    ALOGD("OrientationSensor: mEnabled = %d", mEnabled);

    return err;
}

int OrientationSensor::setDelay(int32_t handle, int64_t delay_ns)
{
    int err = 0;
    char buffer[16];
    int bytes;

    /* handle check */
    if (handle != ID_O) {
        ALOGE("OrientationSensor: Invalid handle (%d)", handle);
        return -EINVAL;
    }

    // Some flooring to match stock value
    delay_ns = delay_ns / 10000000 * 10;

    if (mDelay != delay_ns) {
        strcpy(&input_sysfs_path[input_sysfs_path_len], "poll_delay");
        bytes = sprintf(buffer, "%lld", delay_ns);
        err = write_sys_attribute(input_sysfs_path, buffer, bytes);
        if (err == 0) {
            mDelay = delay_ns;
        }
    }

    return err;
}

int64_t OrientationSensor::getDelay(int32_t handle)
{
    return (handle == ID_O) ? mDelay : 0;
}

int OrientationSensor::getEnable(int32_t handle)
{
    return (handle == ID_O) ? mEnabled : 0;
}

int OrientationSensor::readEvents(sensors_event_t* data, int count)
{
    if (count < 1)
        return -EINVAL;

    if (mHasPendingEvent) {
        mHasPendingEvent = false;
        mPendingEvent.timestamp = getTimestamp();
        *data = mPendingEvent;
        return mEnabled ? 1 : 0;
    }

    ssize_t n = mInputReader.fill(data_fd);
    if (n < 0)
        return n;

    int numEventReceived = 0;
    input_event const* event;

    while (count && mInputReader.readEvent(&event)) {
        int type = event->type;
        if (type == EV_ABS) {
            float value = event->value;
            if (event->code == EVENT_TYPE_YAW) {
                mPendingEvent.orientation.azimuth = value * CONVERT_O_A;
            } else if (event->code == EVENT_TYPE_PITCH) {
                mPendingEvent.orientation.pitch = value * CONVERT_O_P;
            } else if (event->code == EVENT_TYPE_ROLL) {
                mPendingEvent.orientation.roll = value * CONVERT_O_R;
            }
        } else if (type == EV_SYN) {
            mPendingEvent.timestamp = timevalToNano(event->time);
            if (mEnabled) {
                *data++ = mPendingEvent;
                count--;
                numEventReceived++;
            }
        } else {
            ALOGE("OrientationSensor: unknown event (type=%d, code=%d)",
                   type, event->code);
        }
        mInputReader.next();
    }

    return numEventReceived;
}
