Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A247EAA26
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 06:42:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2mBX-0007FP-EB; Tue, 14 Nov 2023 00:42:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1r2mBS-0007F5-TT
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 00:41:58 -0500
Received: from mail-qv1-xf2f.google.com ([2607:f8b0:4864:20::f2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1r2mBL-0001SS-2t
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 00:41:58 -0500
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6707401e22eso31967646d6.2
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 21:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1699940502; x=1700545302; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZfD9z1HLcfPZkYP1HElkReRnlB4vX27c4pSPWIDl3KA=;
 b=fE8W46W0rzJReqDuX9bNB2BDcQd6u6fQMbb7nz3f/8vRBt9zeViG5sQ+BCfnXcooWm
 ZgfEwtDGzcRYiXvuwV2MGBidd7Q7T/0dbYw66/2gHwtrGx76yLCAWFNh6nDcOhkGzR2U
 epfycjpwZHTwdDx1RIDoHf4NPwy04tdC6ARGWuiFjX92HPFrTwmX21RbtjGu2auxR1VE
 rNYPyV+pZTi4KczCcMxeLNNBXSLallMNDsvYGj4P6SL9NQ52xPPsBtkx5MSE3+7CKSSo
 ZfoPxU/QsJJpK1Z3OGZDq73iXcZeV4rlBWSmUuGjPBG9vV1nDl6RaauGzs8MEi7Ugyuq
 eCZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699940502; x=1700545302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZfD9z1HLcfPZkYP1HElkReRnlB4vX27c4pSPWIDl3KA=;
 b=kVOrWaLqOJQIUFSojOu/IeB+t8zMRu+m09qh9ea54PiyyIu9OW0MHGuDv5mQyre2iF
 rnGI1Uaruyt6/L4DgK6v1dCEacFzP8Ka2tH+5oRSiT5N2kSvdWEEYMkub3KhNbSzEC34
 8xGqFNLRrY+RDTvZSIm84eVHMbhzl/S0X7Zt0Y2u56BinBbm6gma8dJr2LXDuN8dFtof
 srsE70CO3vHXLJr43gu0j/Cm4Ri67mhAkP48z1cjyy6HQ7Itp/7NTHAHEHpKCfh839vk
 9pJlg+sps4ysKuLGhq7FzCxHtM5+z8ldCdta1DJhKjzVFl3PmB+54WldJ/wbvA3V8nnZ
 ca/w==
X-Gm-Message-State: AOJu0YwdKjokYhW/LQNIj98YJv83c3AegQ520y4H0GHMp659JBPiiguB
 iJZwZP8/bCVkbjV0zFaFWKzlkw==
X-Google-Smtp-Source: AGHT+IG/wfd/yn52jPopbWbNFjzu9Vcx6W9F6zyrrR3O+441rjArYi16j1d8TPG3Xw7oJpwiN8eHDw==
X-Received: by 2002:a05:6214:400e:b0:675:5058:d028 with SMTP id
 kd14-20020a056214400e00b006755058d028mr1692818qvb.10.1699940502626; 
 Mon, 13 Nov 2023 21:41:42 -0800 (PST)
Received: from n231-230-216.byted.org ([130.44.212.104])
 by smtp.gmail.com with ESMTPSA id
 w2-20020a05620a094200b0077891d2d12dsm2400367qkw.43.2023.11.13.21.41.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 21:41:42 -0800 (PST)
From: Hao Xiang <hao.xiang@bytedance.com>
To: farosas@suse.de, peter.maydell@linaro.org, quintela@redhat.com,
 peterx@redhat.com, marcandre.lureau@redhat.com, bryan.zhang@bytedance.com,
 qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH v2 07/20] util/dsa: Implement DSA device start and stop logic.
Date: Tue, 14 Nov 2023 05:40:19 +0000
Message-Id: <20231114054032.1192027-8-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231114054032.1192027-1-hao.xiang@bytedance.com>
References: <20231114054032.1192027-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2f;
 envelope-from=hao.xiang@bytedance.com; helo=mail-qv1-xf2f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

* DSA device open and close.
* DSA group contains multiple DSA devices.
* DSA group configure/start/stop/clean.

Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
---
 include/qemu/dsa.h |  49 +++++++
 util/dsa.c         | 338 +++++++++++++++++++++++++++++++++++++++++++++
 util/meson.build   |   1 +
 3 files changed, 388 insertions(+)
 create mode 100644 include/qemu/dsa.h
 create mode 100644 util/dsa.c

diff --git a/include/qemu/dsa.h b/include/qemu/dsa.h
new file mode 100644
index 0000000000..30246b507e
--- /dev/null
+++ b/include/qemu/dsa.h
@@ -0,0 +1,49 @@
+#ifndef QEMU_DSA_H
+#define QEMU_DSA_H
+
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
+#endif
+
+/**
+ * @brief Initializes DSA devices.
+ *
+ * @param dsa_parameter A list of DSA device path from migration parameter.
+ * @return int Zero if successful, otherwise non zero.
+ */
+int dsa_init(const char *dsa_parameter);
+
+/**
+ * @brief Start logic to enable using DSA.
+ */
+void dsa_start(void);
+
+/**
+ * @brief Stop logic to clean up DSA by halting the device group and cleaning up
+ * the completion thread.
+ */
+void dsa_stop(void);
+
+/**
+ * @brief Clean up system resources created for DSA offloading.
+ *        This function is called during QEMU process teardown.
+ */
+void dsa_cleanup(void);
+
+/**
+ * @brief Check if DSA is running.
+ *
+ * @return True if DSA is running, otherwise false.
+ */
+bool dsa_is_running(void);
+
+#endif
\ No newline at end of file
diff --git a/util/dsa.c b/util/dsa.c
new file mode 100644
index 0000000000..8edaa892ec
--- /dev/null
+++ b/util/dsa.c
@@ -0,0 +1,338 @@
+/*
+ * Use Intel Data Streaming Accelerator to offload certain background
+ * operations.
+ *
+ * Copyright (c) 2023 Hao Xiang <hao.xiang@bytedance.com>
+ *                    Bryan Zhang <bryan.zhang@bytedance.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/queue.h"
+#include "qemu/memalign.h"
+#include "qemu/lockable.h"
+#include "qemu/cutils.h"
+#include "qemu/dsa.h"
+#include "qemu/bswap.h"
+#include "qemu/error-report.h"
+#include "qemu/rcu.h"
+
+#ifdef CONFIG_DSA_OPT
+
+#pragma GCC push_options
+#pragma GCC target("enqcmd")
+
+#include <linux/idxd.h>
+#include "x86intrin.h"
+
+#define DSA_WQ_SIZE 4096
+#define MAX_DSA_DEVICES 16
+
+typedef QSIMPLEQ_HEAD(dsa_task_queue, buffer_zero_batch_task) dsa_task_queue;
+
+struct dsa_device {
+    void *work_queue;
+};
+
+struct dsa_device_group {
+    struct dsa_device *dsa_devices;
+    int num_dsa_devices;
+    uint32_t index;
+    bool running;
+    QemuMutex task_queue_lock;
+    QemuCond task_queue_cond;
+    dsa_task_queue task_queue;
+};
+
+uint64_t max_retry_count;
+static struct dsa_device_group dsa_group;
+
+
+/**
+ * @brief This function opens a DSA device's work queue and
+ *        maps the DSA device memory into the current process.
+ *
+ * @param dsa_wq_path A pointer to the DSA device work queue's file path.
+ * @return A pointer to the mapped memory.
+ */
+static void *
+map_dsa_device(const char *dsa_wq_path)
+{
+    void *dsa_device;
+    int fd;
+
+    fd = open(dsa_wq_path, O_RDWR);
+    if (fd < 0) {
+        fprintf(stderr, "open %s failed with errno = %d.\n",
+                dsa_wq_path, errno);
+        return MAP_FAILED;
+    }
+    dsa_device = mmap(NULL, DSA_WQ_SIZE, PROT_WRITE,
+                      MAP_SHARED | MAP_POPULATE, fd, 0);
+    close(fd);
+    if (dsa_device == MAP_FAILED) {
+        fprintf(stderr, "mmap failed with errno = %d.\n", errno);
+        return MAP_FAILED;
+    }
+    return dsa_device;
+}
+
+/**
+ * @brief Initializes a DSA device structure.
+ *
+ * @param instance A pointer to the DSA device.
+ * @param work_queue  A pointer to the DSA work queue.
+ */
+static void
+dsa_device_init(struct dsa_device *instance,
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
+dsa_device_cleanup(struct dsa_device *instance)
+{
+    if (instance->work_queue != MAP_FAILED) {
+        munmap(instance->work_queue, DSA_WQ_SIZE);
+    }
+}
+
+/**
+ * @brief Initializes a DSA device group.
+ *
+ * @param group A pointer to the DSA device group.
+ * @param num_dsa_devices The number of DSA devices this group will have.
+ *
+ * @return Zero if successful, non-zero otherwise.
+ */
+static int
+dsa_device_group_init(struct dsa_device_group *group,
+                      const char *dsa_parameter)
+{
+    if (dsa_parameter == NULL || strlen(dsa_parameter) == 0) {
+        return 0;
+    }
+
+    int ret = 0;
+    char *local_dsa_parameter = g_strdup(dsa_parameter);
+    const char *dsa_path[MAX_DSA_DEVICES];
+    int num_dsa_devices = 0;
+    char delim[2] = " ";
+
+    char *current_dsa_path = strtok(local_dsa_parameter, delim);
+
+    while (current_dsa_path != NULL) {
+        dsa_path[num_dsa_devices++] = current_dsa_path;
+        if (num_dsa_devices == MAX_DSA_DEVICES) {
+            break;
+        }
+        current_dsa_path = strtok(NULL, delim);
+    }
+
+    group->dsa_devices =
+        malloc(sizeof(struct dsa_device) * num_dsa_devices);
+    group->num_dsa_devices = num_dsa_devices;
+    group->index = 0;
+
+    group->running = false;
+    qemu_mutex_init(&group->task_queue_lock);
+    qemu_cond_init(&group->task_queue_cond);
+    QSIMPLEQ_INIT(&group->task_queue);
+
+    void *dsa_wq = MAP_FAILED;
+    for (int i = 0; i < num_dsa_devices; i++) {
+        dsa_wq = map_dsa_device(dsa_path[i]);
+        if (dsa_wq == MAP_FAILED) {
+            fprintf(stderr, "map_dsa_device failed MAP_FAILED, "
+                    "using simulation.\n");
+            ret = -1;
+            goto exit;
+        }
+        dsa_device_init(&dsa_group.dsa_devices[i], dsa_wq);
+    }
+
+exit:
+    g_free(local_dsa_parameter);
+    return ret;
+}
+
+/**
+ * @brief Starts a DSA device group.
+ *
+ * @param group A pointer to the DSA device group.
+ * @param dsa_path An array of DSA device path.
+ * @param num_dsa_devices The number of DSA devices in the device group.
+ */
+static void
+dsa_device_group_start(struct dsa_device_group *group)
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
+dsa_device_group_stop(struct dsa_device_group *group)
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
+dsa_device_group_cleanup(struct dsa_device_group *group)
+{
+    if (!group->dsa_devices) {
+        return;
+    }
+    for (int i = 0; i < group->num_dsa_devices; i++) {
+        dsa_device_cleanup(&group->dsa_devices[i]);
+    }
+    free(group->dsa_devices);
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
+ * @return struct dsa_device* A pointer to the next available DSA device
+ *         in the group.
+ */
+__attribute__((unused))
+static struct dsa_device *
+dsa_device_group_get_next_device(struct dsa_device_group *group)
+{
+    if (group->num_dsa_devices == 0) {
+        return NULL;
+    }
+    uint32_t current = qatomic_fetch_inc(&group->index);
+    current %= group->num_dsa_devices;
+    return &group->dsa_devices[current];
+}
+
+/**
+ * @brief Check if DSA is running.
+ *
+ * @return True if DSA is running, otherwise false.
+ */
+bool dsa_is_running(void)
+{
+    return false;
+}
+
+static void
+dsa_globals_init(void)
+{
+    max_retry_count = UINT64_MAX;
+}
+
+/**
+ * @brief Initializes DSA devices.
+ *
+ * @param dsa_parameter A list of DSA device path from migration parameter.
+ * @return int Zero if successful, otherwise non zero.
+ */
+int dsa_init(const char *dsa_parameter)
+{
+    dsa_globals_init();
+
+    return dsa_device_group_init(&dsa_group, dsa_parameter);
+}
+
+/**
+ * @brief Start logic to enable using DSA.
+ *
+ */
+void dsa_start(void)
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
+ * @brief Stop logic to clean up DSA by halting the device group and cleaning up
+ * the completion thread.
+ *
+ */
+void dsa_stop(void)
+{
+    struct dsa_device_group *group = &dsa_group;
+
+    if (!group->running) {
+        return;
+    }
+}
+
+/**
+ * @brief Clean up system resources created for DSA offloading.
+ *        This function is called during QEMU process teardown.
+ *
+ */
+void dsa_cleanup(void)
+{
+    dsa_stop();
+    dsa_device_group_cleanup(&dsa_group);
+}
+
+#else
+
+bool dsa_is_running(void)
+{
+    return false;
+}
+
+int dsa_init(const char *dsa_parameter)
+{
+    fprintf(stderr, "Intel Data Streaming Accelerator is not supported "
+                    "on this platform.\n");
+    return -1;
+}
+
+void dsa_start(void) {}
+
+void dsa_stop(void) {}
+
+void dsa_cleanup(void) {}
+
+#endif
+
diff --git a/util/meson.build b/util/meson.build
index c2322ef6e7..f7277c5e9b 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -85,6 +85,7 @@ if have_block or have_ga
 endif
 if have_block
   util_ss.add(files('aio-wait.c'))
+  util_ss.add(files('dsa.c'))
   util_ss.add(files('buffer.c'))
   util_ss.add(files('bufferiszero.c'))
   util_ss.add(files('hbitmap.c'))
-- 
2.30.2


