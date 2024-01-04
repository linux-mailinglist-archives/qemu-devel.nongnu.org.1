Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 319E88239D6
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 01:49:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLBs3-0008K3-ND; Wed, 03 Jan 2024 19:46:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rLBrn-0008HO-W4
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 19:45:48 -0500
Received: from mail-qk1-x732.google.com ([2607:f8b0:4864:20::732])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rLBrk-0007Qf-KA
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 19:45:47 -0500
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-78158569dc6so1722385a.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 16:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1704329143; x=1704933943; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0Nn1ssbzQh7749OGk7op/YMx6S9uuoqlciLqDvgXEOU=;
 b=KCW1in9zDByz/W3q9rVgLCGxnwOhECaiQXvRnrqBoodzojnsQD4G1Ou6ITXOg50KO+
 ASTo7S1ArqaUaeOmTMk/EQrkR2ABfQLiuVI9hAzkLuiCx7LcJG3g8sd7qLS6QfMH/Wja
 DnRe7VFHUSpiBgzUonD4mpWJ1eoFDpmO1DKrTxP6cUHyIMUcijtce3sLjsoiV0MYoq8Y
 ZVbcLmSig4rU9ROBWvigcqkAkmFBGl07tyjeAEZOx5toYlxQKoFch9V/JoEPeeEUSslf
 U2fi/0SqWNhxpN56+tIzKgrzPNTDy5145XrUrbO8fG7DxTcqOTejGUamMfjhB9hJCkKx
 N/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704329143; x=1704933943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0Nn1ssbzQh7749OGk7op/YMx6S9uuoqlciLqDvgXEOU=;
 b=toDydMullPDdiXvmxwUU8NZpfzrsgPhQVMnYkSXbz2aOie8lKMKTF2qCqcrH35cuMo
 D41aywR//Ztwc6k6xk8BQTg10txaX3+Hgw6/RYFhZp5sjjIgssrrRRK+wY8hCyMQLufF
 32GKwAECB2Op/1bmRgtuF7VzowXfgpknw6CjImdLHzCVZB2AqJGLw7zJPk4ljfCw34OX
 BnQY3z//6mjCrZFsT2inUKcstjqR9L8mQmNS8CZ1uHmH18xI2l5SjCPRM08OsMsFG7XC
 Rgs6zNm9peC6n4ySC56O45zry/oTSnN3haH3llR0sp/vvsOFvuJzG3SjvhqQQe1mVBwd
 aaeA==
X-Gm-Message-State: AOJu0Yz8QY7TTPy9tlNbyHUNh0a4qkMohDl1nlpMIsGkemQUxPthOEvb
 i2XkUKC5newI+wruWVrT+DLfxMCnhoMXjw==
X-Google-Smtp-Source: AGHT+IEE/uczBbdLydtyAolbhxAPjYzSvCEU5xaPn9PfgK5OB+BvFFRUIZT4okgvpRj6Q0c9xeaOng==
X-Received: by 2002:a05:620a:1aa4:b0:781:5c56:8962 with SMTP id
 bl36-20020a05620a1aa400b007815c568962mr17846605qkb.152.1704329143571; 
 Wed, 03 Jan 2024 16:45:43 -0800 (PST)
Received: from n231-230-216.byted.org ([147.160.184.87])
 by smtp.gmail.com with ESMTPSA id
 x19-20020ae9f813000000b0077d66e5b2e6sm10646087qkh.3.2024.01.03.16.45.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 16:45:42 -0800 (PST)
From: Hao Xiang <hao.xiang@bytedance.com>
To: farosas@suse.de, peter.maydell@linaro.org, peterx@redhat.com,
 marcandre.lureau@redhat.com, bryan.zhang@bytedance.com,
 qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH v3 08/20] util/dsa: Implement DSA task enqueue and dequeue.
Date: Thu,  4 Jan 2024 00:44:40 +0000
Message-Id: <20240104004452.324068-9-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240104004452.324068-1-hao.xiang@bytedance.com>
References: <20240104004452.324068-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::732;
 envelope-from=hao.xiang@bytedance.com; helo=mail-qk1-x732.google.com
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

* Use a safe thread queue for DSA task enqueue/dequeue.
* Implement DSA task submission.
* Implement DSA batch task submission.

Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
---
 include/qemu/dsa.h |  28 +++++++
 util/dsa.c         | 201 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 229 insertions(+)

diff --git a/include/qemu/dsa.h b/include/qemu/dsa.h
index f15c05ee85..37cae8d9d2 100644
--- a/include/qemu/dsa.h
+++ b/include/qemu/dsa.h
@@ -13,6 +13,34 @@
 #include <linux/idxd.h>
 #include "x86intrin.h"
 
+typedef enum DsaTaskType {
+    DSA_TASK = 0,
+    DSA_BATCH_TASK
+} DsaTaskType;
+
+typedef enum DsaTaskStatus {
+    DSA_TASK_READY = 0,
+    DSA_TASK_PROCESSING,
+    DSA_TASK_COMPLETION
+} DsaTaskStatus;
+
+typedef void (*dsa_completion_fn)(void *);
+
+typedef struct dsa_batch_task {
+    struct dsa_hw_desc batch_descriptor;
+    struct dsa_hw_desc *descriptors;
+    struct dsa_completion_record batch_completion __attribute__((aligned(32)));
+    struct dsa_completion_record *completions;
+    struct dsa_device_group *group;
+    struct dsa_device *device;
+    dsa_completion_fn completion_callback;
+    QemuSemaphore sem_task_complete;
+    DsaTaskType task_type;
+    DsaTaskStatus status;
+    int batch_size;
+    QSIMPLEQ_ENTRY(dsa_batch_task) entry;
+} dsa_batch_task;
+
 /**
  * @brief Initializes DSA devices.
  *
diff --git a/util/dsa.c b/util/dsa.c
index 05bbf8e31a..75739a1af6 100644
--- a/util/dsa.c
+++ b/util/dsa.c
@@ -244,6 +244,205 @@ dsa_device_group_get_next_device(struct dsa_device_group *group)
     return &group->dsa_devices[current];
 }
 
+/**
+ * @brief Empties out the DSA task queue.
+ *
+ * @param group A pointer to the DSA device group.
+ */
+static void
+dsa_empty_task_queue(struct dsa_device_group *group)
+{
+    qemu_mutex_lock(&group->task_queue_lock);
+    dsa_task_queue *task_queue = &group->task_queue;
+    while (!QSIMPLEQ_EMPTY(task_queue)) {
+        QSIMPLEQ_REMOVE_HEAD(task_queue, entry);
+    }
+    qemu_mutex_unlock(&group->task_queue_lock);
+}
+
+/**
+ * @brief Adds a task to the DSA task queue.
+ *
+ * @param group A pointer to the DSA device group.
+ * @param context A pointer to the DSA task to enqueue.
+ *
+ * @return int Zero if successful, otherwise a proper error code.
+ */
+static int
+dsa_task_enqueue(struct dsa_device_group *group,
+                 struct dsa_batch_task *task)
+{
+    dsa_task_queue *task_queue = &group->task_queue;
+    QemuMutex *task_queue_lock = &group->task_queue_lock;
+    QemuCond *task_queue_cond = &group->task_queue_cond;
+
+    bool notify = false;
+
+    qemu_mutex_lock(task_queue_lock);
+
+    if (!group->running) {
+        error_report("DSA: Tried to queue task to stopped device queue.");
+        qemu_mutex_unlock(task_queue_lock);
+        return -1;
+    }
+
+    /* The queue is empty. This enqueue operation is a 0->1 transition. */
+    if (QSIMPLEQ_EMPTY(task_queue)) {
+        notify = true;
+    }
+
+    QSIMPLEQ_INSERT_TAIL(task_queue, task, entry);
+
+    /* We need to notify the waiter for 0->1 transitions. */
+    if (notify) {
+        qemu_cond_signal(task_queue_cond);
+    }
+
+    qemu_mutex_unlock(task_queue_lock);
+
+    return 0;
+}
+
+/**
+ * @brief Takes a DSA task out of the task queue.
+ *
+ * @param group A pointer to the DSA device group.
+ * @return dsa_batch_task* The DSA task being dequeued.
+ */
+__attribute__((unused))
+static struct dsa_batch_task *
+dsa_task_dequeue(struct dsa_device_group *group)
+{
+    struct dsa_batch_task *task = NULL;
+    dsa_task_queue *task_queue = &group->task_queue;
+    QemuMutex *task_queue_lock = &group->task_queue_lock;
+    QemuCond *task_queue_cond = &group->task_queue_cond;
+
+    qemu_mutex_lock(task_queue_lock);
+
+    while (true) {
+        if (!group->running) {
+            goto exit;
+        }
+        task = QSIMPLEQ_FIRST(task_queue);
+        if (task != NULL) {
+            break;
+        }
+        qemu_cond_wait(task_queue_cond, task_queue_lock);
+    }
+
+    QSIMPLEQ_REMOVE_HEAD(task_queue, entry);
+
+exit:
+    qemu_mutex_unlock(task_queue_lock);
+    return task;
+}
+
+/**
+ * @brief Submits a DSA work item to the device work queue.
+ *
+ * @param wq A pointer to the DSA work queue's device memory.
+ * @param descriptor A pointer to the DSA work item descriptor.
+ *
+ * @return Zero if successful, non-zero otherwise.
+ */
+static int
+submit_wi_int(void *wq, struct dsa_hw_desc *descriptor)
+{
+    uint64_t retry = 0;
+
+    _mm_sfence();
+
+    while (true) {
+        if (_enqcmd(wq, descriptor) == 0) {
+            break;
+        }
+        retry++;
+        if (retry > max_retry_count) {
+            error_report("Submit work retry %lu times.", retry);
+            return -1;
+        }
+    }
+
+    return 0;
+}
+
+/**
+ * @brief Synchronously submits a DSA work item to the
+ *        device work queue.
+ *
+ * @param wq A pointer to the DSA worjk queue's device memory.
+ * @param descriptor A pointer to the DSA work item descriptor.
+ *
+ * @return int Zero if successful, non-zero otherwise.
+ */
+__attribute__((unused))
+static int
+submit_wi(void *wq, struct dsa_hw_desc *descriptor)
+{
+    return submit_wi_int(wq, descriptor);
+}
+
+/**
+ * @brief Asynchronously submits a DSA work item to the
+ *        device work queue.
+ *
+ * @param task A pointer to the buffer zero task.
+ *
+ * @return int Zero if successful, non-zero otherwise.
+ */
+__attribute__((unused))
+static int
+submit_wi_async(struct dsa_batch_task *task)
+{
+    struct dsa_device_group *device_group = task->group;
+    struct dsa_device *device_instance = task->device;
+    int ret;
+
+    assert(task->task_type == DSA_TASK);
+
+    task->status = DSA_TASK_PROCESSING;
+
+    ret = submit_wi_int(device_instance->work_queue,
+                        &task->descriptors[0]);
+    if (ret != 0) {
+        return ret;
+    }
+
+    return dsa_task_enqueue(device_group, task);
+}
+
+/**
+ * @brief Asynchronously submits a DSA batch work item to the
+ *        device work queue.
+ *
+ * @param dsa_batch_task A pointer to the batch buffer zero task.
+ *
+ * @return int Zero if successful, non-zero otherwise.
+ */
+__attribute__((unused))
+static int
+submit_batch_wi_async(struct dsa_batch_task *batch_task)
+{
+    struct dsa_device_group *device_group = batch_task->group;
+    struct dsa_device *device_instance = batch_task->device;
+    int ret;
+
+    assert(batch_task->task_type == DSA_BATCH_TASK);
+    assert(batch_task->batch_descriptor.desc_count <= batch_task->batch_size);
+    assert(batch_task->status == DSA_TASK_READY);
+
+    batch_task->status = DSA_TASK_PROCESSING;
+
+    ret = submit_wi_int(device_instance->work_queue,
+                        &batch_task->batch_descriptor);
+    if (ret != 0) {
+        return ret;
+    }
+
+    return dsa_task_enqueue(device_group, batch_task);
+}
+
 /**
  * @brief Check if DSA is running.
  *
@@ -300,6 +499,8 @@ void dsa_stop(void)
     if (!group->running) {
         return;
     }
+
+    dsa_empty_task_queue(group);
 }
 
 /**
-- 
2.30.2


