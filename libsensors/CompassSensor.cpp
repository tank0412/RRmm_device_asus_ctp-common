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

#include "CompassSensor.h"

/*****************************************************************************/

CompassSensor::CompassSensor()
    : SensorBase(NULL, "geomagnetic"),
      mEnabled(0),
      mDelay(-1),
      mInputReader(4),
      mHasPendingEvent(false)
{
    mPendingEvent.version = sizeof(sensors_event_t);
    mPendingEvent.sensor = ID_M;
    mPendingEvent.type = SENSOR_TYPE_MAGNETIC_FIELD;
    memset(mPendingEvent.data, 0, sizeof(mPendingEvent.data));

    if (data_fd >= 0) {
        strcpy(input_sysfs_path, "/sys/class/input/");
        strcat(input_sysfs_path, input_name);
        strcat(input_sysfs_path, "/device/");
        input_sysfs_path_len = strlen(input_sysfs_path);
        ALOGD("CompassSensor: sysfs_path=%s", input_sysfs_path);
    } else {
        input_sysfs_path[0] = '\0';
        input_sysfs_path_len = 0;
    }
}

CompassSensor::~CompassSensor() {
    if (mEnabled) {
        setEnable(0, 0);
    }
}

bool CompassSensor::hasPendingEvents() const {
    return mHasPendingEvent;
}

int CompassSensor::setEnable(int32_t handle, int enabled) {
    int err = 0;
    char buffer[2];

    /* handle check */
    if (handle != ID_M) {
        ALOGE("CompassSensor: Invalid handle (%d)", handle);
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
        ALOGD("CompassSensor: Control set %s", buffer);
    }

    if (enabled) {
        mEnabled++;
        if (mEnabled > 32767) mEnabled = 32767;
    } else {
        mEnabled--;
        if (mEnabled < 0) mEnabled = 0;
    }
    ALOGD("CompassSensor: mEnabled = %d", mEnabled);

    return err;
}

int CompassSensor::setDelay(int32_t handle, int64_t delay_ns)
{
    int err = 0;
    char buffer[16];
    int bytes;
    int val;

    /* handle check */
    if (handle != ID_M) {
        ALOGE("CompassSensor: Invalid handle (%d)", handle);
        return -EINVAL;
    }

    // Kernel driver only support specific values
    if (delay_ns < 20000000L) {
        val = 1;
    } else if (delay_ns < 60000000L) {
        val = 20;
    } else if (delay_ns < 200000000L) {
        val = 60;
    } else if (delay_ns < 1000000000L) {
        val = 200;
    } else {
        val = 1000;
    }

    if (mDelay != val) {
        strcpy(&input_sysfs_path[input_sysfs_path_len], "poll_delay");
        bytes = sprintf(buffer, "%d", val);
        err = write_sys_attribute(input_sysfs_path, buffer, bytes);
        if (err == 0) {
            mDelay = val;
        }
    }

    return err;
}

int64_t CompassSensor::getDelay(int32_t handle)
{
    return (handle == ID_M) ? mDelay : 0;
}

int CompassSensor::getEnable(int32_t handle)
{
    return (handle == ID_M) ? mEnabled : 0;
}

int CompassSensor::readEvents(sensors_event_t* data, int count)
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
            if (event->code == EVENT_TYPE_MAGV_X) {
                mPendingEvent.magnetic.x = value * CONVERT_M_X;
            } else if (event->code == EVENT_TYPE_MAGV_Y) {
                mPendingEvent.magnetic.y = value * CONVERT_M_Y;
            } else if (event->code == EVENT_TYPE_MAGV_Z) {
                mPendingEvent.magnetic.z = value * CONVERT_M_Z;
            }
        } else if (type == EV_SYN) {
            mPendingEvent.timestamp = timevalToNano(event->time);
            if (mEnabled) {
                *data++ = mPendingEvent;
                count--;
                numEventReceived++;
            }
        } else {
            ALOGE("CompassSensor: unknown event (type=%d, code=%d)",
                   type, event->code);
        }
        mInputReader.next();
    }

    return numEventReceived;
}
