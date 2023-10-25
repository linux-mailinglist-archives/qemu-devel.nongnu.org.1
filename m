Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC0A7D7494
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 21:42:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvjjD-0000sa-Rl; Wed, 25 Oct 2023 15:39:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1qvjjB-0000sD-TX
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 15:39:41 -0400
Received: from mail-qv1-xf2f.google.com ([2607:f8b0:4864:20::f2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1qvjj9-00069H-Db
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 15:39:41 -0400
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-66d134a019cso753296d6.3
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 12:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1698262778; x=1698867578; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GL6cpR12l80oXg3yMpIzAIPLap4SikzmVMX/10PRhJc=;
 b=R7LOucNlazFhwAy3UKTtl6ARgsZ52EnOyoO9rUTbOG4qF1rMepKC8b6lZlGA7MxBbK
 CpmiFnxL7biLTlJqZaqUphDC1nzBxxfKJCVUtSdKhsUSPt6HVbgtfnGUriBgKlBmLbJ/
 tDbM80xtPz+5WOhZVosEW5RX/ZloYTE4pVfBleruSa3Trvc4cbqDPFficKJv8ZDZ7ZZ+
 GJnHGIAiEFrEgrWQW6m5rM88lBmdBYLjsnSM5TC3wM1tWrmmjywxxNlFYY+X3VACpK75
 T2DjiHT4vjV+aUgRQ3JQ0qgmXhtZp5dT5Vi/6rNf+wQYXPvhg1+6aSpoHpLuipQIiAia
 4ipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698262778; x=1698867578;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GL6cpR12l80oXg3yMpIzAIPLap4SikzmVMX/10PRhJc=;
 b=g/5S7dcONAHhak6tg5ArodjPa3SGfc6sZ7G4AOjoInCK2wVbw4jhWOr6VKh1pCFdrG
 Qu/ei7iNiTHMe4bDNfxFW5OiKvcia6LFsZ/0FbFO8ispPQmoFkoCoibr+U2iFUPvLql/
 3dMB1DrNoY7YMNcgmAnyqC7u0e8S20//t/8vGtAqcFP5ElTRpgtjrFC4LTDgIPTpkACi
 7OCV7+2ipAq2E6FRyYVPfEV20zc7wxw9Z110fGs5ygmzNMkonH79D7u7pJV7DamXkF2W
 6JSOQzkbmLGAoTvuDY1bt6DDWttRBvitW9/RVGHOqPKb0L0BZEKVauWRslAGb5ajCtvT
 3+HA==
X-Gm-Message-State: AOJu0YwhWS7x8JVcLYkgJqUML7EjTbb6G1cmDuXeRXuH/AcSdpaHCHg1
 XtjuFidbuX8HKtA+ex/Wap/h6w==
X-Google-Smtp-Source: AGHT+IEAQUd9RA0/oKIsJF6C4TXMuA9wJBKrEk2NwBPWZadBVa5BM2Ldw7ez3ML2YHzT0nK3F9ITSQ==
X-Received: by 2002:ad4:5b86:0:b0:66d:44c9:ac8 with SMTP id
 6-20020ad45b86000000b0066d44c90ac8mr19340935qvp.24.1698262778227; 
 Wed, 25 Oct 2023 12:39:38 -0700 (PDT)
Received: from n231-230-216.byted.org ([147.160.184.135])
 by smtp.gmail.com with ESMTPSA id
 o8-20020a05620a228800b0076cdc3b5beasm4453721qkh.86.2023.10.25.12.39.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 12:39:37 -0700 (PDT)
From: Hao Xiang <hao.xiang@bytedance.com>
To: quintela@redhat.com, peterx@redhat.com, marcandre.lureau@redhat.com,
 bryan.zhang@bytedance.com, qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH 07/16] util/dsa: Implement zero page checking in DSA task.
Date: Wed, 25 Oct 2023 19:38:13 +0000
Message-Id: <20231025193822.2813204-8-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231025193822.2813204-1-hao.xiang@bytedance.com>
References: <20231025193822.2813204-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2f;
 envelope-from=hao.xiang@bytedance.com; helo=mail-qv1-xf2f.google.com
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

Create DSA task with operation code DSA_OPCODE_COMPVAL.
Here we create two types of DSA tasks, a single DSA task and
a batch DSA task. Batch DSA task reduces task submission overhead
and hence should be the default option. However, due to the way DSA
hardware works, a DSA batch task must contain at least two individual
tasks. There are times we need to submit a single task and hence a
single DSA task submission is also required.

Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
---
 include/qemu/dsa.h |  16 +++
 util/dsa.c         | 252 +++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 247 insertions(+), 21 deletions(-)

diff --git a/include/qemu/dsa.h b/include/qemu/dsa.h
index 23f55185be..b10e7b8fb7 100644
--- a/include/qemu/dsa.h
+++ b/include/qemu/dsa.h
@@ -49,6 +49,22 @@ struct buffer_zero_batch_task {
 
 #endif
 
+/**
+ * @brief Initializes a buffer zero batch task.
+ *
+ * @param task A pointer to the batch task to initialize.
+ * @param batch_size The number of DSA tasks in the batch.
+ */
+void buffer_zero_batch_task_init(struct buffer_zero_batch_task *task,
+                                 int batch_size);
+
+/**
+ * @brief Performs the proper cleanup on a DSA batch task.
+ *
+ * @param task A pointer to the batch task to cleanup.
+ */
+void buffer_zero_batch_task_destroy(struct buffer_zero_batch_task *task);
+
 /**
  * @brief Initializes DSA devices.
  *
diff --git a/util/dsa.c b/util/dsa.c
index 0e68013ffb..3cc017b8a0 100644
--- a/util/dsa.c
+++ b/util/dsa.c
@@ -75,6 +75,7 @@ uint64_t max_retry_count;
 static struct dsa_device_group dsa_group;
 static struct dsa_completion_thread completion_thread;
 
+static void buffer_zero_dsa_completion(void *context);
 
 /**
  * @brief This function opens a DSA device's work queue and
@@ -208,7 +209,6 @@ dsa_device_group_start(struct dsa_device_group *group)
  *
  * @param group A pointer to the DSA device group.
  */
-__attribute__((unused))
 static void
 dsa_device_group_stop(struct dsa_device_group *group)
 {
@@ -244,7 +244,6 @@ dsa_device_group_cleanup(struct dsa_device_group *group)
  * @return struct dsa_device* A pointer to the next available DSA device
  *         in the group.
  */
-__attribute__((unused))
 static struct dsa_device *
 dsa_device_group_get_next_device(struct dsa_device_group *group)
 {
@@ -319,7 +318,6 @@ dsa_task_enqueue(struct dsa_device_group *group,
  * @param group A pointer to the DSA device group.
  * @return buffer_zero_batch_task* The DSA task being dequeued.
  */
-__attribute__((unused))
 static struct buffer_zero_batch_task *
 dsa_task_dequeue(struct dsa_device_group *group)
 {
@@ -376,22 +374,6 @@ submit_wi_int(void *wq, struct dsa_hw_desc *descriptor)
     return 0;
 }
 
-/**
- * @brief Synchronously submits a DSA work item to the
- *        device work queue.
- *
- * @param wq A pointer to the DSA worjk queue's device memory.
- * @param descriptor A pointer to the DSA work item descriptor.
- *
- * @return int Zero if successful, non-zero otherwise.
- */
-__attribute__((unused))
-static int
-submit_wi(void *wq, struct dsa_hw_desc *descriptor)
-{
-    return submit_wi_int(wq, descriptor);
-}
-
 /**
  * @brief Asynchronously submits a DSA work item to the
  *        device work queue.
@@ -400,7 +382,6 @@ submit_wi(void *wq, struct dsa_hw_desc *descriptor)
  *
  * @return int Zero if successful, non-zero otherwise.
  */
-__attribute__((unused))
 static int
 submit_wi_async(struct buffer_zero_batch_task *task)
 {
@@ -428,7 +409,6 @@ submit_wi_async(struct buffer_zero_batch_task *task)
  *
  * @return int Zero if successful, non-zero otherwise.
  */
-__attribute__((unused))
 static int
 submit_batch_wi_async(struct buffer_zero_batch_task *batch_task)
 {
@@ -678,6 +658,231 @@ static void dsa_completion_thread_stop(void *opaque)
     qemu_sem_destroy(&thread_context->sem_init_done);
 }
 
+/**
+ * @brief Initializes a buffer zero comparison DSA task.
+ *
+ * @param descriptor A pointer to the DSA task descriptor.
+ * @param completion A pointer to the DSA task completion record.
+ */
+static void
+buffer_zero_task_init_int(struct dsa_hw_desc *descriptor,
+                          struct dsa_completion_record *completion)
+{
+    descriptor->opcode = DSA_OPCODE_COMPVAL;
+    descriptor->flags = IDXD_OP_FLAG_RCR | IDXD_OP_FLAG_CRAV;
+    descriptor->comp_pattern = (uint64_t)0;
+    descriptor->completion_addr = (uint64_t)completion;
+}
+
+/**
+ * @brief Initializes a buffer zero batch task.
+ *
+ * @param task A pointer to the batch task to initialize.
+ * @param batch_size The number of DSA tasks in the batch.
+ */
+void
+buffer_zero_batch_task_init(struct buffer_zero_batch_task *task,
+                            int batch_size)
+{
+    int descriptors_size = sizeof(*task->descriptors) * batch_size;
+    memset(task, 0, sizeof(*task));
+
+    task->descriptors =
+        (struct dsa_hw_desc *)qemu_memalign(64, descriptors_size);
+    memset(task->descriptors, 0, descriptors_size);
+    task->completions = (struct dsa_completion_record *)qemu_memalign(
+        32, sizeof(*task->completions) * batch_size);
+    task->results = g_new0(bool, batch_size);
+    task->batch_size = batch_size;
+
+    task->batch_completion.status = DSA_COMP_NONE;
+    task->batch_descriptor.completion_addr = (uint64_t)&task->batch_completion;
+    // TODO: Ensure that we never send a batch with count <= 1
+    task->batch_descriptor.desc_count = 0;
+    task->batch_descriptor.opcode = DSA_OPCODE_BATCH;
+    task->batch_descriptor.flags = IDXD_OP_FLAG_RCR | IDXD_OP_FLAG_CRAV;
+    task->batch_descriptor.desc_list_addr = (uintptr_t)task->descriptors;
+    task->status = DSA_TASK_READY;
+    task->group = &dsa_group;
+    task->device = dsa_device_group_get_next_device(&dsa_group);
+
+    for (int i = 0; i < task->batch_size; i++) {
+        buffer_zero_task_init_int(&task->descriptors[i],
+                                  &task->completions[i]);
+    }
+
+    qemu_sem_init(&task->sem_task_complete, 0);
+    task->completion_callback = buffer_zero_dsa_completion;
+}
+
+/**
+ * @brief Performs the proper cleanup on a DSA batch task.
+ *
+ * @param task A pointer to the batch task to cleanup.
+ */
+void
+buffer_zero_batch_task_destroy(struct buffer_zero_batch_task *task)
+{
+    qemu_vfree(task->descriptors);
+    qemu_vfree(task->completions);
+    g_free(task->results);
+
+    qemu_sem_destroy(&task->sem_task_complete);
+}
+
+/**
+ * @brief Resets a buffer zero comparison DSA batch task.
+ *
+ * @param task A pointer to the batch task.
+ * @param count The number of DSA tasks this batch task will contain.
+ */
+static void
+buffer_zero_batch_task_reset(struct buffer_zero_batch_task *task, size_t count)
+{
+    task->batch_completion.status = DSA_COMP_NONE;
+    task->batch_descriptor.desc_count = count;
+    task->task_type = DSA_BATCH_TASK;
+    task->status = DSA_TASK_READY;
+}
+
+/**
+ * @brief Sets a buffer zero comparison DSA task.
+ *
+ * @param descriptor A pointer to the DSA task descriptor.
+ * @param buf A pointer to the memory buffer.
+ * @param len The length of the buffer.
+ */
+static void
+buffer_zero_task_set_int(struct dsa_hw_desc *descriptor,
+                         const void *buf,
+                         size_t len)
+{
+    struct dsa_completion_record *completion =
+        (struct dsa_completion_record *)descriptor->completion_addr;
+
+    descriptor->xfer_size = len;
+    descriptor->src_addr = (uintptr_t)buf;
+    completion->status = 0;
+    completion->result = 0;
+}
+
+/**
+ * @brief Resets a buffer zero comparison DSA batch task.
+ *
+ * @param task A pointer to the DSA batch task.
+ */
+static void
+buffer_zero_task_reset(struct buffer_zero_batch_task *task)
+{
+    task->completions[0].status = DSA_COMP_NONE;
+    task->task_type = DSA_TASK;
+    task->status = DSA_TASK_READY;
+}
+
+/**
+ * @brief Sets a buffer zero comparison DSA task.
+ *
+ * @param task A pointer to the DSA task.
+ * @param buf A pointer to the memory buffer.
+ * @param len The buffer length.
+ */
+static void
+buffer_zero_task_set(struct buffer_zero_batch_task *task,
+                     const void *buf,
+                     size_t len)
+{
+    buffer_zero_task_reset(task);
+    buffer_zero_task_set_int(&task->descriptors[0], buf, len);
+}
+
+/**
+ * @brief Sets a buffer zero comparison batch task.
+ *
+ * @param batch_task A pointer to the batch task.
+ * @param buf An array of memory buffers.
+ * @param count The number of buffers in the array.
+ * @param len The length of the buffers.
+ */
+static void
+buffer_zero_batch_task_set(struct buffer_zero_batch_task *batch_task,
+                           const void **buf, size_t count, size_t len)
+{
+    assert(count > 0);
+    assert(count <= batch_task->batch_size);
+
+    buffer_zero_batch_task_reset(batch_task, count);
+    for (int i = 0; i < count; i++) {
+        buffer_zero_task_set_int(&batch_task->descriptors[i], buf[i], len);
+    }
+}
+
+/**
+ * @brief Asychronously perform a buffer zero DSA operation.
+ *
+ * @param task A pointer to the batch task structure.
+ * @param buf A pointer to the memory buffer.
+ * @param len The length of the memory buffer.
+ *
+ * @return int Zero if successful, otherwise an appropriate error code.
+ */
+__attribute__((unused))
+static int
+buffer_zero_dsa_async(struct buffer_zero_batch_task *task,
+                      const void *buf, size_t len)
+{
+    buffer_zero_task_set(task, buf, len);
+
+    return submit_wi_async(task);
+}
+
+/**
+ * @brief Sends a memory comparison batch task to a DSA device and wait
+ *        for completion.
+ *
+ * @param batch_task The batch task to be submitted to DSA device.
+ * @param buf An array of memory buffers to check for zero.
+ * @param count The number of buffers.
+ * @param len The buffer length.
+ */
+__attribute__((unused))
+static int
+buffer_zero_dsa_batch_async(struct buffer_zero_batch_task *batch_task,
+                            const void **buf, size_t count, size_t len)
+{
+    assert(count <= batch_task->batch_size);
+    buffer_zero_batch_task_set(batch_task, buf, count, len);
+
+    return submit_batch_wi_async(batch_task);
+}
+
+/**
+ * @brief The completion callback function for buffer zero
+ *        comparison DSA task completion.
+ *
+ * @param context A pointer to the callback context.
+ */
+static void
+buffer_zero_dsa_completion(void *context)
+{
+    assert(context != NULL);
+
+    struct buffer_zero_batch_task *task =
+        (struct buffer_zero_batch_task *)context;
+    qemu_sem_post(&task->sem_task_complete);
+}
+
+/**
+ * @brief Wait for the asynchronous DSA task to complete.
+ *
+ * @param batch_task A pointer to the buffer zero comparison batch task.
+ */
+__attribute__((unused))
+static void
+buffer_zero_dsa_wait(struct buffer_zero_batch_task *batch_task)
+{
+    qemu_sem_wait(&batch_task->sem_task_complete);
+}
+
 /**
  * @brief Check if DSA is running.
  *
@@ -753,6 +958,11 @@ void dsa_cleanup(void)
 
 #else
 
+void buffer_zero_batch_task_init(struct buffer_zero_batch_task *task,
+                                 int batch_size) {}
+
+void buffer_zero_batch_task_destroy(struct buffer_zero_batch_task *task) {}
+
 bool dsa_is_running(void)
 {
     return false;
-- 
2.30.2


