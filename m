Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 641FB7EAA2F
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 06:43:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2mBS-0007Ee-E1; Tue, 14 Nov 2023 00:41:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1r2mBP-0007EG-9Y
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 00:41:55 -0500
Received: from mail-qk1-x733.google.com ([2607:f8b0:4864:20::733])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1r2mBL-0001Sa-2J
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 00:41:53 -0500
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-778a92c06d6so322123185a.2
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 21:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1699940504; x=1700545304; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T/zXpgGhSxq4NM4ugG+KYN+fyKZfpH/m9Za1mhIGsuQ=;
 b=PJu46kq/S9ZV6QaFFE6X8TRffVZdaeSwyC/igDX+cUfIITRHmniHyAVnNKFA5se7Z+
 mrtNPnNCXxMog6UnwFbgTOsNH2fnPILfbSXwoQRccSiL0aYW0NJ5SOhRAC+VnA6iliRW
 S2rWTs+BYcxaUAXRBUFzohVUAe7b6RNxOL/UM+ehFuCHJgCzCXzwJCGPy+UsiowW9HdY
 WCYe53Xl/iAmk4fJ3WAQ7/U2nPqJPjgLpJa4uRFIfptel1RyPj1WiOBrKUA3S4VUzEBZ
 Q0tYG0iYfqrs8sSBaWT+Cvyr8NbtXblmvjaGv3cSA4XFdqorAK3567QxCvg3VFbUuQqo
 DdxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699940504; x=1700545304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T/zXpgGhSxq4NM4ugG+KYN+fyKZfpH/m9Za1mhIGsuQ=;
 b=Kn+WeTswaYE3CRwMAH/9icir3C7XoyK8zc0ueKRz2k7NkKSdti9YotLj5DvZQ1aqDC
 ZTTGZtUN9431nbFad90B8E/nqlDANMSDOijNa7uGWZjfgunlE+8UMP5CTzuK4YNpj3hu
 l316U3oc6DJJZdkWiK58ijlXhBdDA0vRnnFH9Me6oe5T4S7tvlyHw8KpNrT/mtmXfL/z
 +zlHHk3+nLdwjop8xZdwUZ5wvVXFgaHY99wy54PhDGKNfhFaGj5yNxeUdixUNghBQYuH
 GBJewXLzvlgk8Sz1+SuyPanr0qHj38SYe8bzuaa4NDOHQAzRBgFnwJrDI0GVq+EpjZ2D
 Sb4A==
X-Gm-Message-State: AOJu0YzKMC3wWrtf4IOz0Rd3ttQibxZ/AI55X/H7Ohs7oEb1pwUaXr8r
 FNaGJfD1YVX0AMN5z1UoKwu4AXvTy46hA0mqzuY=
X-Google-Smtp-Source: AGHT+IFFAiIu1YXz/W1XplSN3Wz3PkIgmDjYuq0yYum66V8nwnXDTWfESm8LRo2t3IsQTc9O3kj70g==
X-Received: by 2002:a05:620a:2a0b:b0:773:fd71:6e7c with SMTP id
 o11-20020a05620a2a0b00b00773fd716e7cmr1473403qkp.59.1699940504196; 
 Mon, 13 Nov 2023 21:41:44 -0800 (PST)
Received: from n231-230-216.byted.org ([130.44.212.104])
 by smtp.gmail.com with ESMTPSA id
 w2-20020a05620a094200b0077891d2d12dsm2400367qkw.43.2023.11.13.21.41.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 21:41:43 -0800 (PST)
From: Hao Xiang <hao.xiang@bytedance.com>
To: farosas@suse.de, peter.maydell@linaro.org, quintela@redhat.com,
 peterx@redhat.com, marcandre.lureau@redhat.com, bryan.zhang@bytedance.com,
 qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH v2 08/20] util/dsa: Implement DSA task enqueue and dequeue.
Date: Tue, 14 Nov 2023 05:40:20 +0000
Message-Id: <20231114054032.1192027-9-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231114054032.1192027-1-hao.xiang@bytedance.com>
References: <20231114054032.1192027-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::733;
 envelope-from=hao.xiang@bytedance.com; helo=mail-qk1-x733.google.com
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
 include/qemu/dsa.h |  35 ++++++++
 util/dsa.c         | 196 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 231 insertions(+)

diff --git a/include/qemu/dsa.h b/include/qemu/dsa.h
index 30246b507e..23f55185be 100644
--- a/include/qemu/dsa.h
+++ b/include/qemu/dsa.h
@@ -12,6 +12,41 @@
 #include <linux/idxd.h>
 #include "x86intrin.h"
 
+enum dsa_task_type {
+    DSA_TASK = 0,
+    DSA_BATCH_TASK
+};
+
+enum dsa_task_status {
+    DSA_TASK_READY = 0,
+    DSA_TASK_PROCESSING,
+    DSA_TASK_COMPLETION
+};
+
+typedef void (*buffer_zero_dsa_completion_fn)(void *);
+
+typedef struct buffer_zero_batch_task {
+    struct dsa_hw_desc batch_descriptor;
+    struct dsa_hw_desc *descriptors;
+    struct dsa_completion_record batch_completion __attribute__((aligned(32)));
+    struct dsa_completion_record *completions;
+    struct dsa_device_group *group;
+    struct dsa_device *device;
+    buffer_zero_dsa_completion_fn completion_callback;
+    QemuSemaphore sem_task_complete;
+    enum dsa_task_type task_type;
+    enum dsa_task_status status;
+    bool *results;
+    int batch_size;
+    QSIMPLEQ_ENTRY(buffer_zero_batch_task) entry;
+} buffer_zero_batch_task;
+
+#else
+
+struct buffer_zero_batch_task {
+    bool *results;
+};
+
 #endif
 
 /**
diff --git a/util/dsa.c b/util/dsa.c
index 8edaa892ec..f82282ce99 100644
--- a/util/dsa.c
+++ b/util/dsa.c
@@ -245,6 +245,200 @@ dsa_device_group_get_next_device(struct dsa_device_group *group)
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
+                 struct buffer_zero_batch_task *task)
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
+        fprintf(stderr, "DSA: Tried to queue task to stopped device queue\n");
+        qemu_mutex_unlock(task_queue_lock);
+        return -1;
+    }
+
+    // The queue is empty. This enqueue operation is a 0->1 transition.
+    if (QSIMPLEQ_EMPTY(task_queue))
+        notify = true;
+
+    QSIMPLEQ_INSERT_TAIL(task_queue, task, entry);
+
+    // We need to notify the waiter for 0->1 transitions.
+    if (notify)
+        qemu_cond_signal(task_queue_cond);
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
+ * @return buffer_zero_batch_task* The DSA task being dequeued.
+ */
+__attribute__((unused))
+static struct buffer_zero_batch_task *
+dsa_task_dequeue(struct dsa_device_group *group)
+{
+    struct buffer_zero_batch_task *task = NULL;
+    dsa_task_queue *task_queue = &group->task_queue;
+    QemuMutex *task_queue_lock = &group->task_queue_lock;
+    QemuCond *task_queue_cond = &group->task_queue_cond;
+
+    qemu_mutex_lock(task_queue_lock);
+
+    while (true) {
+        if (!group->running)
+            goto exit;
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
+            fprintf(stderr, "Submit work retry %lu times.\n", retry);
+            exit(1);
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
+submit_wi_async(struct buffer_zero_batch_task *task)
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
+    if (ret != 0)
+        return ret;
+
+    return dsa_task_enqueue(device_group, task);
+}
+
+/**
+ * @brief Asynchronously submits a DSA batch work item to the
+ *        device work queue.
+ *
+ * @param batch_task A pointer to the batch buffer zero task.
+ *
+ * @return int Zero if successful, non-zero otherwise.
+ */
+__attribute__((unused))
+static int
+submit_batch_wi_async(struct buffer_zero_batch_task *batch_task)
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
+    if (ret != 0)
+        return ret;
+
+    return dsa_task_enqueue(device_group, batch_task);
+}
+
 /**
  * @brief Check if DSA is running.
  *
@@ -301,6 +495,8 @@ void dsa_stop(void)
     if (!group->running) {
         return;
     }
+
+    dsa_empty_task_queue(group);
 }
 
 /**
-- 
2.30.2


