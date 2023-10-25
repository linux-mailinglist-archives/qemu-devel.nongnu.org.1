Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECCD7D7497
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 21:42:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvjjA-0000ro-4c; Wed, 25 Oct 2023 15:39:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1qvjj7-0000r3-V5
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 15:39:37 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1qvjj5-00068U-Mi
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 15:39:37 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-581b6b93bd1so98031eaf.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 12:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1698262774; x=1698867574; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k0ANuzGnWOEFY5fWYAHlg+spNpTdLgGmhcWmwSge4rg=;
 b=Ou1NDxwzxseImjq5CdH69l6PjrdSsblSGfKMgI1vmaGknmAOCRBfWhcZe4IQD6X9kc
 p/74ks4Q53XRqnXq2rf3EFhuPJ6Gd3x6pqkazpSTj2k+pBNn7hLVdNEEIq6rweN1CWSh
 aFw5MBJhfPgftc1Y5hm5BPdpoqt5lbo9uTBdQUVrBw86s1ZXl94qMkijkazIX+YSeGrj
 TmqX2VAQxmUnQXzpx00Ot86UGdID/WEGMFxbBLCKl1VS+U83I+jAEsAw30nKzg0QxLjt
 ojwX+lgTMu4JSn9tq2+/RsjHFRCC3DyCB/a0oZEjH3CC5IKQFephnnaRRVK3ZmxSB5nb
 c5Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698262774; x=1698867574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k0ANuzGnWOEFY5fWYAHlg+spNpTdLgGmhcWmwSge4rg=;
 b=gd8rkT6qqNXtX1gXNyZSNBoxA44DE6jQhMoXjXXwP5yWyJ3M31gxefDdmkCx+qXqGe
 r20Yg8Ru3zoseRiBhTEwyeiLD84tv0XdMCSmPkVBQJLd9w2ii/wdRLVqce6ziiuK1q58
 ldavgXBB37xxMTgRbcNEIoXU6zqkZOGcmmZFPPBUCAAc2xOuyHiFy8dLaPvjDixYDTWO
 Bfd3oUIp6eiupp9FvzHhm3lYjjtutW7yaEBCm7clOoG7P0hbUE2ICUQ2l2d/uA503M1F
 9GaPTNYptUyFzMs8JcbO4gmwNF9roJhsNznEVxO0aBTGnc8Ipy+0OojZGFgOqRBqDe0Q
 ieIw==
X-Gm-Message-State: AOJu0YxbfMrI4RpTKsJfh0hOIc9un6DaAzMqfNasQKWHEqMb2gskGg3L
 5xB+BKcScs75ymomxygedrq/vg==
X-Google-Smtp-Source: AGHT+IFBilC6466lqF/eda52hPHX3w8gTnz8NDR3vD8wB+uzfpBleORPytdybh1pxpgDRLHW7JmgYQ==
X-Received: by 2002:a05:6358:cd04:b0:168:d0a3:202f with SMTP id
 gv4-20020a056358cd0400b00168d0a3202fmr13387175rwb.15.1698262774119; 
 Wed, 25 Oct 2023 12:39:34 -0700 (PDT)
Received: from n231-230-216.byted.org ([147.160.184.135])
 by smtp.gmail.com with ESMTPSA id
 o8-20020a05620a228800b0076cdc3b5beasm4453721qkh.86.2023.10.25.12.39.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 12:39:33 -0700 (PDT)
From: Hao Xiang <hao.xiang@bytedance.com>
To: quintela@redhat.com, peterx@redhat.com, marcandre.lureau@redhat.com,
 bryan.zhang@bytedance.com, qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH 04/16] util/dsa: Implement DSA device start and stop logic.
Date: Wed, 25 Oct 2023 19:38:10 +0000
Message-Id: <20231025193822.2813204-5-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231025193822.2813204-1-hao.xiang@bytedance.com>
References: <20231025193822.2813204-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=hao.xiang@bytedance.com; helo=mail-oo1-xc30.google.com
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
index c4827fd70a..96b916a981 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -83,6 +83,7 @@ if have_block or have_ga
 endif
 if have_block
   util_ss.add(files('aio-wait.c'))
+  util_ss.add(files('dsa.c'))
   util_ss.add(files('buffer.c'))
   util_ss.add(files('bufferiszero.c'))
   util_ss.add(files('hbitmap.c'))
-- 
2.30.2


