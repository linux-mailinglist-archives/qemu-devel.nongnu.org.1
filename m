Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB899E3144
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Dec 2024 03:14:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIes3-00040Z-7F; Tue, 03 Dec 2024 21:12:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1tIes1-0003zx-MT
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 21:12:05 -0500
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1tIerz-0005Q2-Nh
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 21:12:05 -0500
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-6ef66fd2183so47773207b3.1
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 18:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1733278321; x=1733883121; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=081ar3D+q2I5dbHey0ExnsftyZ/LMfe2DNt/cF/PLBs=;
 b=CwUKRX9yc1EqNO9Y/guveAkQE8tY+hOkuR4KB/ne8BO3SFDYZ2hrBRajO7L3ZwvmKP
 XzDVg1QU1dndww63cPFk3VrSyta39JZnV1ozv2DRyzoUn9JqMiaZRWWiMS1diwP4Hnm8
 iyGp1oQuIpX3bb4exHB1MpmSRzNIgB4DMOo3E10aIpulRyaFj/wM2/twAhEBUs5yFJxH
 ugj4vNNVn/MQRPnEOqmvAdRfsMsORLHXiJK1LulDPO6Bvux3iD2vjiGiXxhisxZF4Lwa
 WWYJJUCPH68eCs3fZB7P/LwRalxRuX8jTat4P8g9K47RKouDuzXr/sdE1URDOFFt1b4r
 atZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733278321; x=1733883121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=081ar3D+q2I5dbHey0ExnsftyZ/LMfe2DNt/cF/PLBs=;
 b=R+HXlykFFCpfa8UDhULcxStBJ5OAm2SACESicaJpWaYd1Jggu1vST+Ap8GbUkH5WLa
 i391MaLTIS6HfWwflMlVtqUONx/JmD8Y/mwcXNESRBhIG922TdoToFQDwykjQHQOexM1
 cRwV9qqnFktnaB20FZIgBc0Y7kP7uxjhKc355KumQzEI5vY/4bjqy2CX6wMsngPW3FeM
 MdGN0Tycqoi8I4QZt7ntkKg3SPIftfXkHQj8rcHRhyOQpO82U3KrIgaN3ErlYcQBobJ4
 jMtb7j22UC42JtVjkBCBrLUJ3J6GI4rNQYz2kXpqEFY0omia/2q2qoUEFVD5tsJUmfAD
 9uoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWx0Q70d65BoTFJEfyN3iDwI76caRUmPTLLUnZSqfHSDyekXOmve7jZJa3q60AFw1qK1y30oshMXfdh@nongnu.org
X-Gm-Message-State: AOJu0YxHB00aFRDx0IUFO+At8TANUgO9mQ9aX9+m+LVizEBWL0aE2u1F
 /54Yj3/zspcMPZro3rERMCmMArmWM2+C/mCaLh8IMF/bl//rIj5gfg4GK0UMQic=
X-Gm-Gg: ASbGncvHGzLoepRkGucwRN+5y4FHW0Eof315xM2/4/wWwRFU/ObZILPQMtV2MmP1xfD
 W85oQYB6G4j/G0tt0d/62X0RPliTEYuzyUyYc6g//O8avbUBphXw3W2NG3JOSbYeoU8ucNJKAF9
 XIiKLqYHU9DtRwYJgS0PMhglvj3lob9/hAO1UICn+JIRKcvkWs0o0q31A9rorXJaZlZIFbSZN6Z
 Tu7zmNoRBdUr0GntIvttxcDA7EDV5pLyfksgG7gdj2/Qhpd4VWua+8nVYf901oXkWGPciex7HDL
 UK/h4fds1/yo2pctGg==
X-Google-Smtp-Source: AGHT+IFPMp7SnZB+j2aApaYONqwE+4GR6+Yv2XqI/150LFU00r0dVanpAeD5J9wgtq27fwfAqrD8yA==
X-Received: by 2002:a05:690c:4a10:b0:6ef:61b9:e003 with SMTP id
 00721157ae682-6efad2f6fd7mr68582587b3.36.1733278320553; 
 Tue, 03 Dec 2024 18:12:00 -0800 (PST)
Received: from DY4X0N7X05.bytedance.net
 ([2601:646:8900:323:644e:288b:2b6d:d94c])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d87ec537ebsm63488986d6.30.2024.12.03.18.11.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Dec 2024 18:12:00 -0800 (PST)
From: Yichen Wang <yichen.wang@bytedance.com>
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Hao Xiang" <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 "Shivam Kumar" <shivam.kumar1@nutanix.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 "Yichen Wang" <yichen.wang@bytedance.com>,
 Bryan Zhang <bryan.zhang@bytedance.com>
Subject: [PATCH v8 03/12] util/dsa: Implement DSA device start and stop logic.
Date: Tue,  3 Dec 2024 18:11:32 -0800
Message-Id: <20241204021142.24184-4-yichen.wang@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241204021142.24184-1-yichen.wang@bytedance.com>
References: <20241204021142.24184-1-yichen.wang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=yichen.wang@bytedance.com; helo=mail-yw1-x1129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Hao Xiang <hao.xiang@linux.dev>

* DSA device open and close.
* DSA group contains multiple DSA devices.
* DSA group configure/start/stop/clean.

Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
---
 include/qemu/dsa.h |  99 ++++++++++++++++
 util/dsa.c         | 280 +++++++++++++++++++++++++++++++++++++++++++++
 util/meson.build   |   3 +
 3 files changed, 382 insertions(+)
 create mode 100644 include/qemu/dsa.h
 create mode 100644 util/dsa.c

diff --git a/include/qemu/dsa.h b/include/qemu/dsa.h
new file mode 100644
index 0000000000..fbf0dcd692
--- /dev/null
+++ b/include/qemu/dsa.h
@@ -0,0 +1,99 @@
+/*
+ * Interface for using Intel Data Streaming Accelerator to offload certain
+ * background operations.
+ *
+ * Copyright (C) Bytedance Ltd.
+ *
+ * Authors:
+ *  Hao Xiang <hao.xiang@bytedance.com>
+ *  Yichen Wang <yichen.wang@bytedance.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef QEMU_DSA_H
+#define QEMU_DSA_H
+
+#include "qapi/error.h"
+#include "qemu/thread.h"
+#include "qemu/queue.h"
+
+#ifdef CONFIG_DSA_OPT
+
+#pragma GCC push_options
+#pragma GCC target("enqcmd")
+
+#include <linux/idxd.h>
+#include "x86intrin.h"
+
+typedef struct {
+    void *work_queue;
+} QemuDsaDevice;
+
+typedef QSIMPLEQ_HEAD(QemuDsaTaskQueue, QemuDsaBatchTask) QemuDsaTaskQueue;
+
+typedef struct {
+    QemuDsaDevice *dsa_devices;
+    int num_dsa_devices;
+    /* The index of the next DSA device to be used. */
+    uint32_t device_allocator_index;
+    bool running;
+    QemuMutex task_queue_lock;
+    QemuCond task_queue_cond;
+    QemuDsaTaskQueue task_queue;
+} QemuDsaDeviceGroup;
+
+/**
+ * @brief Initializes DSA devices.
+ *
+ * @param dsa_parameter A list of DSA device path from migration parameter.
+ *
+ * @return int Zero if successful, otherwise non zero.
+ */
+int qemu_dsa_init(const strList *dsa_parameter, Error **errp);
+
+/**
+ * @brief Start logic to enable using DSA.
+ */
+void qemu_dsa_start(void);
+
+/**
+ * @brief Stop the device group and the completion thread.
+ */
+void qemu_dsa_stop(void);
+
+/**
+ * @brief Clean up system resources created for DSA offloading.
+ */
+void qemu_dsa_cleanup(void);
+
+/**
+ * @brief Check if DSA is running.
+ *
+ * @return True if DSA is running, otherwise false.
+ */
+bool qemu_dsa_is_running(void);
+
+#else
+
+static inline bool qemu_dsa_is_running(void)
+{
+    return false;
+}
+
+static inline int qemu_dsa_init(const strList *dsa_parameter, Error **errp)
+{
+    error_setg(errp, "DSA accelerator is not enabled.");
+    return -1;
+}
+
+static inline void qemu_dsa_start(void) {}
+
+static inline void qemu_dsa_stop(void) {}
+
+static inline void qemu_dsa_cleanup(void) {}
+
+#endif
+
+#endif
diff --git a/util/dsa.c b/util/dsa.c
new file mode 100644
index 0000000000..57f1cbe68f
--- /dev/null
+++ b/util/dsa.c
@@ -0,0 +1,280 @@
+/*
+ * Use Intel Data Streaming Accelerator to offload certain background
+ * operations.
+ *
+ * Copyright (C) Bytedance Ltd.
+ *
+ * Authors:
+ *  Hao Xiang <hao.xiang@bytedance.com>
+ *  Bryan Zhang <bryan.zhang@bytedance.com>
+ *  Yichen Wang <yichen.wang@bytedance.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/queue.h"
+#include "qemu/memalign.h"
+#include "qemu/lockable.h"
+#include "qemu/cutils.h"
+#include "qemu/dsa.h"
+#include "qemu/bswap.h"
+#include "qemu/error-report.h"
+#include "qemu/rcu.h"
+
+#pragma GCC push_options
+#pragma GCC target("enqcmd")
+
+#include <linux/idxd.h>
+#include "x86intrin.h"
+
+#define DSA_WQ_PORTAL_SIZE 4096
+#define MAX_DSA_DEVICES 16
+
+uint32_t max_retry_count;
+static QemuDsaDeviceGroup dsa_group;
+
+
+/**
+ * @brief This function opens a DSA device's work queue and
+ *        maps the DSA device memory into the current process.
+ *
+ * @param dsa_wq_path A pointer to the DSA device work queue's file path.
+ * @return A pointer to the mapped memory, or MAP_FAILED on failure.
+ */
+static void *
+map_dsa_device(const char *dsa_wq_path)
+{
+    void *dsa_device;
+    int fd;
+
+    fd = open(dsa_wq_path, O_RDWR);
+    if (fd < 0) {
+        error_report("Open %s failed with errno = %d.",
+                dsa_wq_path, errno);
+        return MAP_FAILED;
+    }
+    dsa_device = mmap(NULL, DSA_WQ_PORTAL_SIZE, PROT_WRITE,
+                      MAP_SHARED | MAP_POPULATE, fd, 0);
+    close(fd);
+    if (dsa_device == MAP_FAILED) {
+        error_report("mmap failed with errno = %d.", errno);
+        return MAP_FAILED;
+    }
+    return dsa_device;
+}
+
+/**
+ * @brief Initializes a DSA device structure.
+ *
+ * @param instance A pointer to the DSA device.
+ * @param work_queue A pointer to the DSA work queue.
+ */
+static void
+dsa_device_init(QemuDsaDevice *instance,
+                void *dsa_work_queue)
+{
+    instance->work_queue = dsa_work_queue;
+}
+
+/**
+ * @brief Cleans up a DSA device structure.
+ *
+ * @param instance A pointer to the DSA device to cleanup.
+ */
+static void
+dsa_device_cleanup(QemuDsaDevice *instance)
+{
+    if (instance->work_queue != MAP_FAILED) {
+        munmap(instance->work_queue, DSA_WQ_PORTAL_SIZE);
+    }
+}
+
+/**
+ * @brief Initializes a DSA device group.
+ *
+ * @param group A pointer to the DSA device group.
+ * @param dsa_parameter A list of DSA device path from are separated by space
+ * character migration parameter. Multiple DSA device path.
+ *
+ * @return Zero if successful, non-zero otherwise.
+ */
+static int
+dsa_device_group_init(QemuDsaDeviceGroup *group,
+                      const strList *dsa_parameter,
+                      Error **errp)
+{
+    if (dsa_parameter == NULL) {
+        error_setg(errp, "dsa device path is not supplied.");
+        return -1;
+    }
+
+    int ret = 0;
+    const char *dsa_path[MAX_DSA_DEVICES];
+    int num_dsa_devices = 0;
+
+    while (dsa_parameter) {
+        dsa_path[num_dsa_devices++] = dsa_parameter->value;
+        if (num_dsa_devices == MAX_DSA_DEVICES) {
+            break;
+        }
+        dsa_parameter = dsa_parameter->next;
+    }
+
+    group->dsa_devices =
+        g_new0(QemuDsaDevice, num_dsa_devices);
+    group->num_dsa_devices = num_dsa_devices;
+    group->device_allocator_index = 0;
+
+    group->running = false;
+    qemu_mutex_init(&group->task_queue_lock);
+    qemu_cond_init(&group->task_queue_cond);
+    QSIMPLEQ_INIT(&group->task_queue);
+
+    void *dsa_wq = MAP_FAILED;
+    for (int i = 0; i < num_dsa_devices; i++) {
+        dsa_wq = map_dsa_device(dsa_path[i]);
+        if (dsa_wq == MAP_FAILED && ret != -1) {
+            error_setg(errp, "map_dsa_device failed MAP_FAILED.");
+            ret = -1;
+        }
+        dsa_device_init(&group->dsa_devices[i], dsa_wq);
+    }
+
+    return ret;
+}
+
+/**
+ * @brief Starts a DSA device group.
+ *
+ * @param group A pointer to the DSA device group.
+ */
+static void
+dsa_device_group_start(QemuDsaDeviceGroup *group)
+{
+    group->running = true;
+}
+
+/**
+ * @brief Stops a DSA device group.
+ *
+ * @param group A pointer to the DSA device group.
+ */
+__attribute__((unused))
+static void
+dsa_device_group_stop(QemuDsaDeviceGroup *group)
+{
+    group->running = false;
+}
+
+/**
+ * @brief Cleans up a DSA device group.
+ *
+ * @param group A pointer to the DSA device group.
+ */
+static void
+dsa_device_group_cleanup(QemuDsaDeviceGroup *group)
+{
+    if (!group->dsa_devices) {
+        return;
+    }
+    for (int i = 0; i < group->num_dsa_devices; i++) {
+        dsa_device_cleanup(&group->dsa_devices[i]);
+    }
+    g_free(group->dsa_devices);
+    group->dsa_devices = NULL;
+
+    qemu_mutex_destroy(&group->task_queue_lock);
+    qemu_cond_destroy(&group->task_queue_cond);
+}
+
+/**
+ * @brief Returns the next available DSA device in the group.
+ *
+ * @param group A pointer to the DSA device group.
+ *
+ * @return struct QemuDsaDevice* A pointer to the next available DSA device
+ *         in the group.
+ */
+__attribute__((unused))
+static QemuDsaDevice *
+dsa_device_group_get_next_device(QemuDsaDeviceGroup *group)
+{
+    if (group->num_dsa_devices == 0) {
+        return NULL;
+    }
+    uint32_t current = qatomic_fetch_inc(&group->device_allocator_index);
+    current %= group->num_dsa_devices;
+    return &group->dsa_devices[current];
+}
+
+/**
+ * @brief Check if DSA is running.
+ *
+ * @return True if DSA is running, otherwise false.
+ */
+bool qemu_dsa_is_running(void)
+{
+    return false;
+}
+
+static void
+dsa_globals_init(void)
+{
+    max_retry_count = UINT32_MAX;
+}
+
+/**
+ * @brief Initializes DSA devices.
+ *
+ * @param dsa_parameter A list of DSA device path from migration parameter.
+ *
+ * @return int Zero if successful, otherwise non zero.
+ */
+int qemu_dsa_init(const strList *dsa_parameter, Error **errp)
+{
+    dsa_globals_init();
+
+    return dsa_device_group_init(&dsa_group, dsa_parameter, errp);
+}
+
+/**
+ * @brief Start logic to enable using DSA.
+ *
+ */
+void qemu_dsa_start(void)
+{
+    if (dsa_group.num_dsa_devices == 0) {
+        return;
+    }
+    if (dsa_group.running) {
+        return;
+    }
+    dsa_device_group_start(&dsa_group);
+}
+
+/**
+ * @brief Stop the device group and the completion thread.
+ *
+ */
+void qemu_dsa_stop(void)
+{
+    QemuDsaDeviceGroup *group = &dsa_group;
+
+    if (!group->running) {
+        return;
+    }
+}
+
+/**
+ * @brief Clean up system resources created for DSA offloading.
+ *
+ */
+void qemu_dsa_cleanup(void)
+{
+    qemu_dsa_stop();
+    dsa_device_group_cleanup(&dsa_group);
+}
+
diff --git a/util/meson.build b/util/meson.build
index 5d8bef9891..5ec2158f9e 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -123,6 +123,9 @@ if cpu == 'aarch64'
   util_ss.add(files('cpuinfo-aarch64.c'))
 elif cpu in ['x86', 'x86_64']
   util_ss.add(files('cpuinfo-i386.c'))
+  if config_host_data.get('CONFIG_DSA_OPT')
+    util_ss.add(files('dsa.c'))
+  endif
 elif cpu == 'loongarch64'
   util_ss.add(files('cpuinfo-loongarch.c'))
 elif cpu in ['ppc', 'ppc64']
-- 
Yichen Wang


