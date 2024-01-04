Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 989108239DB
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 01:50:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLBs4-0008Kb-5n; Wed, 03 Jan 2024 19:46:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rLBrq-0008He-An
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 19:45:51 -0500
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rLBrn-0007SA-Be
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 19:45:49 -0500
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-78104f6f692so74504985a.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 16:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1704329145; x=1704933945; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3R4Bv/Au5sInDWUt9t13t/X4Bjb20Y+cKOiAtsdqXWo=;
 b=VkfoGWFzfPLSimsBwT7fOMdI16mR9UOZrH2Pkp6Z99OaeFi7WzL/AF+wF+mg8+JVuE
 Pdoeh+AbSNZZX3kAvO6ga5b/OdDHe+hJKzbTMzVOu/Rqm3KGav1hc58PowUJpmYTdIG5
 Byg4uCAOa84TOQ2EqNWGLnc8Qgmbr0nKDKp314Q8wXdmoCUExv75E8CwES60AcvcT176
 l6iGZ74MWATbnx/vlb0w9sLpCyuiX7zwTKEi3d/U2NrOhhg6hAZeDKwg7Ou2tUg2KWnG
 eWuhixQDQnEjeFBjCh0X0C7frXQeC9aLtC0XOIwO46l7uzTi6q/Wgx0/zganNUZr5huF
 ruCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704329145; x=1704933945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3R4Bv/Au5sInDWUt9t13t/X4Bjb20Y+cKOiAtsdqXWo=;
 b=MCoj4I1QpbJXCqGojVmSghrCxHC8fVt943TQYHI0nryrqtlK1p4Mt9GADJDFCEAotI
 oOf+IVmG8ESGqAQPK6lNODMQm48zWUG4KqMKiRmChpQ4nZO8JahJ6Lsuw9K04BhrZ+5z
 v7/sMGxHluUk5Fot+buEwreAfa76LLctmozUxPWQKj+SZKhz9DvCWI4aU5hdVBCB+9+D
 BBnIgohtF+1tDAMk04NmfTQ8MSPOUxVIEF9HvXe8wyqg1eRJMgjfBgUgabbai6izA093
 L3NCg91JnMsYmDLuOOY6GAo6exp8TrT/EqWhGpKphsm2/7pTqTbEKD8f109EnCe+EJB/
 QaAw==
X-Gm-Message-State: AOJu0YyxBylRC1kmroZlf5HoMZHWlNAHyOgvnoDj8Wg4/Ij4tfzxrFHd
 Uk87Da/Z5gQxN2hq8/vExEfSI42OfR9eOQ==
X-Google-Smtp-Source: AGHT+IHXdOfHHPd1iPakoHu/9aWLdClBxIdG4T8OguRFCGV0EMEjR03SGjKc3B6+evVZOX60tyozMA==
X-Received: by 2002:a05:620a:2a12:b0:781:5fdf:a8c1 with SMTP id
 o18-20020a05620a2a1200b007815fdfa8c1mr3000236qkp.55.1704329145474; 
 Wed, 03 Jan 2024 16:45:45 -0800 (PST)
Received: from n231-230-216.byted.org ([147.160.184.87])
 by smtp.gmail.com with ESMTPSA id
 x19-20020ae9f813000000b0077d66e5b2e6sm10646087qkh.3.2024.01.03.16.45.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 16:45:45 -0800 (PST)
From: Hao Xiang <hao.xiang@bytedance.com>
To: farosas@suse.de, peter.maydell@linaro.org, peterx@redhat.com,
 marcandre.lureau@redhat.com, bryan.zhang@bytedance.com,
 qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH v3 10/20] util/dsa: Implement zero page checking in DSA task.
Date: Thu,  4 Jan 2024 00:44:42 +0000
Message-Id: <20240104004452.324068-11-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240104004452.324068-1-hao.xiang@bytedance.com>
References: <20240104004452.324068-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::731;
 envelope-from=hao.xiang@bytedance.com; helo=mail-qk1-x731.google.com
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
 include/qemu/dsa.h |  18 ++++
 util/dsa.c         | 247 +++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 244 insertions(+), 21 deletions(-)

diff --git a/include/qemu/dsa.h b/include/qemu/dsa.h
index 2513192a2b..645e6fc367 100644
--- a/include/qemu/dsa.h
+++ b/include/qemu/dsa.h
@@ -73,6 +73,24 @@ void dsa_cleanup(void);
  */
 bool dsa_is_running(void);
 
+/**
+ * @brief Initializes a buffer zero batch task.
+ *
+ * @param task A pointer to the batch task to initialize.
+ * @param results A pointer to an array of zero page checking results.
+ * @param batch_size The number of DSA tasks in the batch.
+ */
+void
+buffer_zero_batch_task_init(struct dsa_batch_task *task,
+                            bool *results, int batch_size);
+
+/**
+ * @brief Performs the proper cleanup on a DSA batch task.
+ *
+ * @param task A pointer to the batch task to cleanup.
+ */
+void buffer_zero_batch_task_destroy(struct dsa_batch_task *task);
+
 #else
 
 static inline bool dsa_is_running(void)
diff --git a/util/dsa.c b/util/dsa.c
index 003c4f47d9..9db4cfcf1d 100644
--- a/util/dsa.c
+++ b/util/dsa.c
@@ -76,6 +76,7 @@ uint64_t max_retry_count;
 static struct dsa_device_group dsa_group;
 static struct dsa_completion_thread completion_thread;
 
+static void buffer_zero_dsa_completion(void *context);
 
 /**
  * @brief This function opens a DSA device's work queue and
@@ -207,7 +208,6 @@ dsa_device_group_start(struct dsa_device_group *group)
  *
  * @param group A pointer to the DSA device group.
  */
-__attribute__((unused))
 static void
 dsa_device_group_stop(struct dsa_device_group *group)
 {
@@ -243,7 +243,6 @@ dsa_device_group_cleanup(struct dsa_device_group *group)
  * @return struct dsa_device* A pointer to the next available DSA device
  *         in the group.
  */
-__attribute__((unused))
 static struct dsa_device *
 dsa_device_group_get_next_device(struct dsa_device_group *group)
 {
@@ -320,7 +319,6 @@ dsa_task_enqueue(struct dsa_device_group *group,
  * @param group A pointer to the DSA device group.
  * @return dsa_batch_task* The DSA task being dequeued.
  */
-__attribute__((unused))
 static struct dsa_batch_task *
 dsa_task_dequeue(struct dsa_device_group *group)
 {
@@ -378,22 +376,6 @@ submit_wi_int(void *wq, struct dsa_hw_desc *descriptor)
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
@@ -402,7 +384,6 @@ submit_wi(void *wq, struct dsa_hw_desc *descriptor)
  *
  * @return int Zero if successful, non-zero otherwise.
  */
-__attribute__((unused))
 static int
 submit_wi_async(struct dsa_batch_task *task)
 {
@@ -431,7 +412,6 @@ submit_wi_async(struct dsa_batch_task *task)
  *
  * @return int Zero if successful, non-zero otherwise.
  */
-__attribute__((unused))
 static int
 submit_batch_wi_async(struct dsa_batch_task *batch_task)
 {
@@ -713,6 +693,231 @@ static void dsa_completion_thread_stop(void *opaque)
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
+ * @param results A pointer to an array of zero page checking results.
+ * @param batch_size The number of DSA tasks in the batch.
+ */
+void
+buffer_zero_batch_task_init(struct dsa_batch_task *task,
+                            bool *results, int batch_size)
+{
+    int descriptors_size = sizeof(*task->descriptors) * batch_size;
+    memset(task, 0, sizeof(*task));
+
+    task->descriptors =
+        (struct dsa_hw_desc *)qemu_memalign(64, descriptors_size);
+    memset(task->descriptors, 0, descriptors_size);
+    task->completions = (struct dsa_completion_record *)qemu_memalign(
+        32, sizeof(*task->completions) * batch_size);
+    task->results = results;
+    task->batch_size = batch_size;
+
+    task->batch_completion.status = DSA_COMP_NONE;
+    task->batch_descriptor.completion_addr = (uint64_t)&task->batch_completion;
+    /* TODO: Ensure that we never send a batch with count <= 1 */
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
+buffer_zero_batch_task_destroy(struct dsa_batch_task *task)
+{
+    qemu_vfree(task->descriptors);
+    qemu_vfree(task->completions);
+    task->results = NULL;
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
+buffer_zero_batch_task_reset(struct dsa_batch_task *task, size_t count)
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
+buffer_zero_task_reset(struct dsa_batch_task *task)
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
+buffer_zero_task_set(struct dsa_batch_task *task,
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
+buffer_zero_batch_task_set(struct dsa_batch_task *batch_task,
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
+buffer_zero_dsa_async(struct dsa_batch_task *task,
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
+buffer_zero_dsa_batch_async(struct dsa_batch_task *batch_task,
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
+    struct dsa_batch_task *task = (struct dsa_batch_task *)context;
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
+buffer_zero_dsa_wait(struct dsa_batch_task *batch_task)
+{
+    qemu_sem_wait(&batch_task->sem_task_complete);
+}
+
 /**
  * @brief Check if DSA is running.
  *
-- 
2.30.2


