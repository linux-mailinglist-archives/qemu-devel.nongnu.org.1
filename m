Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6CD7D7481
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 21:40:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvjjC-0000sB-6C; Wed, 25 Oct 2023 15:39:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1qvjjA-0000rz-EQ
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 15:39:40 -0400
Received: from mail-qv1-xf2c.google.com ([2607:f8b0:4864:20::f2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1qvjj8-000691-IO
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 15:39:40 -0400
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-66cfd874520so756556d6.2
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 12:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1698262777; x=1698867577; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CLTEEKCthFs57uSw9LUby1piyRPg7rqXrvYS7xVttXM=;
 b=V3wINHsxfSZpOgEhyAw7ysR07Xh3C0fBUDXD0BZZQMUibLb3zyfS8as6Ulmmd+37rV
 pRuEE5zO425HOOH5OCKBWjDN3SgW2XkNCJTk4VT7TrRpnQ12z0RSJpTj48k0TSMTD9YH
 CHl1ugQVNh61V7P18lCUFebssFDAydfXGo3eKjkYrkq7LwoRhorE21IVUQnRVVaimPSh
 utVoW8hbeY+SAIs90ufkM8m6C4j7jpYa9pewiIZoUVnnkQ/OPMYn78v/LZUbKOU2AvYV
 7QGk31ds/3I7asPB3BG19YE0+1gpUbBDTeUfjtUAWIaf/IVCRC1YrXZZ3iKnAdm37AES
 JWIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698262777; x=1698867577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CLTEEKCthFs57uSw9LUby1piyRPg7rqXrvYS7xVttXM=;
 b=KGPjqMqyzBwcQYPnQgsw0D021jP3Ze0EUdbX6IqMyVi6tWpjCnykFhxbVJdq9Xr2Ns
 d0cIyjsf28LQ/jUNJzpjc/EY8J21W7OD+jWv5FS5XIq269AVSbg+YOE8Ky6IV2OSX6Ji
 9Nd/Jrl3ayi+IuffVmqRZUKOQzIrv60X5qgQjy/ZvXXNl9QunrjazQYbP9MwdAdQLip1
 2/doYGeZeaAXtQRBIzP5VOjGSJy5F8OAvIYXbyvyQrykeyY9ugTZhjf3lby1hDQo2kc1
 uQOoGZ7o+QwP+7kCOMQOAnVZEuBUVAKmFqxsx/uZq3tSECXAvUfsHdxABD/QNj6xr/KM
 5LEA==
X-Gm-Message-State: AOJu0YzFMsjJU4rJC4HEGGQJcS/c4U84+pEr0YJhok71kJtnN5X3qbuT
 LxOsEAvNGTTm6v7S5DVO6+zjkQ==
X-Google-Smtp-Source: AGHT+IH0bHJZNyTzeLOzPEzX0h8hx60BC26KU+4v9x5tBYfjxVm1VVnWuKiHk7Y+u9PAWF8nBR0+OQ==
X-Received: by 2002:a05:6214:5281:b0:66c:ff4f:a35f with SMTP id
 kj1-20020a056214528100b0066cff4fa35fmr17363092qvb.51.1698262776875; 
 Wed, 25 Oct 2023 12:39:36 -0700 (PDT)
Received: from n231-230-216.byted.org ([147.160.184.135])
 by smtp.gmail.com with ESMTPSA id
 o8-20020a05620a228800b0076cdc3b5beasm4453721qkh.86.2023.10.25.12.39.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 12:39:36 -0700 (PDT)
From: Hao Xiang <hao.xiang@bytedance.com>
To: quintela@redhat.com, peterx@redhat.com, marcandre.lureau@redhat.com,
 bryan.zhang@bytedance.com, qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH 06/16] util/dsa: Implement DSA task asynchronous completion
 thread model.
Date: Wed, 25 Oct 2023 19:38:12 +0000
Message-Id: <20231025193822.2813204-7-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231025193822.2813204-1-hao.xiang@bytedance.com>
References: <20231025193822.2813204-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2c;
 envelope-from=hao.xiang@bytedance.com; helo=mail-qv1-xf2c.google.com
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

* Create a dedicated thread for DSA task completion.
* DSA completion thread runs a loop and poll for completed tasks.
* Start and stop DSA completion thread during DSA device start stop.

User space application can directly submit task to Intel DSA
accelerator by writing to DSA's device memory (mapped in user space).
Once a task is submitted, the device starts processing it and write
the completion status back to the task. A user space application can
poll the task's completion status to check for completion. This change
uses a dedicated thread to perform DSA task completion checking.

Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
---
 util/dsa.c | 243 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 242 insertions(+), 1 deletion(-)

diff --git a/util/dsa.c b/util/dsa.c
index f82282ce99..0e68013ffb 100644
--- a/util/dsa.c
+++ b/util/dsa.c
@@ -44,6 +44,7 @@
 
 #define DSA_WQ_SIZE 4096
 #define MAX_DSA_DEVICES 16
+#define DSA_COMPLETION_THREAD "dsa_completion"
 
 typedef QSIMPLEQ_HEAD(dsa_task_queue, buffer_zero_batch_task) dsa_task_queue;
 
@@ -61,8 +62,18 @@ struct dsa_device_group {
     dsa_task_queue task_queue;
 };
 
+struct dsa_completion_thread {
+    bool stopping;
+    bool running;
+    QemuThread thread;
+    int thread_id;
+    QemuSemaphore sem_init_done;
+    struct dsa_device_group *group;
+};
+
 uint64_t max_retry_count;
 static struct dsa_device_group dsa_group;
+static struct dsa_completion_thread completion_thread;
 
 
 /**
@@ -439,6 +450,234 @@ submit_batch_wi_async(struct buffer_zero_batch_task *batch_task)
     return dsa_task_enqueue(device_group, batch_task);
 }
 
+/**
+ * @brief Poll for the DSA work item completion.
+ *
+ * @param completion A pointer to the DSA work item completion record.
+ * @param opcode The DSA opcode.
+ *
+ * @return Zero if successful, non-zero otherwise.
+ */
+static int
+poll_completion(struct dsa_completion_record *completion,
+                enum dsa_opcode opcode)
+{
+    uint8_t status;
+    uint64_t retry = 0;
+
+    while (true) {
+        // The DSA operation completes successfully or fails.
+        status = completion->status;
+        if (status == DSA_COMP_SUCCESS ||
+            status == DSA_COMP_PAGE_FAULT_NOBOF ||
+            status == DSA_COMP_BATCH_PAGE_FAULT ||
+            status == DSA_COMP_BATCH_FAIL) {
+            break;
+        } else if (status != DSA_COMP_NONE) {
+            /* TODO: Error handling here on unexpected failure. */
+            fprintf(stderr, "DSA opcode %d failed with status = %d.\n",
+                    opcode, status);
+            exit(1);
+        }
+        retry++;
+        if (retry > max_retry_count) {
+            fprintf(stderr, "Wait for completion retry %lu times.\n", retry);
+            exit(1);
+        }
+        _mm_pause();
+    }
+
+    return 0;
+}
+
+/**
+ * @brief Complete a single DSA task in the batch task.
+ *
+ * @param task A pointer to the batch task structure.
+ */
+static void
+poll_task_completion(struct buffer_zero_batch_task *task)
+{
+    assert(task->task_type == DSA_TASK);
+
+    struct dsa_completion_record *completion = &task->completions[0];
+    uint8_t status;
+
+    poll_completion(completion, task->descriptors[0].opcode);
+
+    status = completion->status;
+    if (status == DSA_COMP_SUCCESS) {
+        task->results[0] = (completion->result == 0);
+        return;
+    }
+
+    assert(status == DSA_COMP_PAGE_FAULT_NOBOF);
+}
+
+/**
+ * @brief Poll a batch task status until it completes. If DSA task doesn't
+ *        complete properly, use CPU to complete the task.
+ *
+ * @param batch_task A pointer to the DSA batch task.
+ */
+static void
+poll_batch_task_completion(struct buffer_zero_batch_task *batch_task)
+{
+    struct dsa_completion_record *batch_completion = &batch_task->batch_completion;
+    struct dsa_completion_record *completion;
+    uint8_t batch_status;
+    uint8_t status;
+    bool *results = batch_task->results;
+    uint32_t count = batch_task->batch_descriptor.desc_count;
+
+    poll_completion(batch_completion,
+                    batch_task->batch_descriptor.opcode);
+
+    batch_status = batch_completion->status;
+
+    if (batch_status == DSA_COMP_SUCCESS) {
+        if (batch_completion->bytes_completed == count) {
+            // Let's skip checking for each descriptors' completion status
+            // if the batch descriptor says all succedded.
+            for (int i = 0; i < count; i++) {
+                assert(batch_task->completions[i].status == DSA_COMP_SUCCESS);
+                results[i] = (batch_task->completions[i].result == 0);
+            }
+            return;
+        }
+    } else {
+        assert(batch_status == DSA_COMP_BATCH_FAIL ||
+            batch_status == DSA_COMP_BATCH_PAGE_FAULT);
+    }
+
+    for (int i = 0; i < count; i++) {
+
+        completion = &batch_task->completions[i];
+        status = completion->status;
+
+        if (status == DSA_COMP_SUCCESS) {
+            results[i] = (completion->result == 0);
+            continue;
+        }
+
+        if (status != DSA_COMP_PAGE_FAULT_NOBOF) {
+            fprintf(stderr,
+                    "Unexpected completion status = %u.\n", status);
+            assert(false);
+        }
+    }
+}
+
+/**
+ * @brief Handles an asynchronous DSA batch task completion.
+ *
+ * @param task A pointer to the batch buffer zero task structure.
+ */
+static void
+dsa_batch_task_complete(struct buffer_zero_batch_task *batch_task)
+{
+    batch_task->status = DSA_TASK_COMPLETION;
+    batch_task->completion_callback(batch_task);
+}
+
+/**
+ * @brief The function entry point called by a dedicated DSA
+ *        work item completion thread.
+ *
+ * @param opaque A pointer to the thread context.
+ *
+ * @return void* Not used.
+ */
+static void *
+dsa_completion_loop(void *opaque)
+{
+    struct dsa_completion_thread *thread_context =
+        (struct dsa_completion_thread *)opaque;
+    struct buffer_zero_batch_task *batch_task;
+    struct dsa_device_group *group = thread_context->group;
+
+    rcu_register_thread();
+
+    thread_context->thread_id = qemu_get_thread_id();
+    qemu_sem_post(&thread_context->sem_init_done);
+
+    while (thread_context->running) {
+        batch_task = dsa_task_dequeue(group);
+        assert(batch_task != NULL || !group->running);
+        if (!group->running) {
+            assert(!thread_context->running);
+            break;
+        }
+        if (batch_task->task_type == DSA_TASK) {
+            poll_task_completion(batch_task);
+        } else {
+            assert(batch_task->task_type == DSA_BATCH_TASK);
+            poll_batch_task_completion(batch_task);
+        }
+
+        dsa_batch_task_complete(batch_task);
+    }
+
+    rcu_unregister_thread();
+    return NULL;
+}
+
+/**
+ * @brief Initializes a DSA completion thread.
+ *
+ * @param completion_thread A pointer to the completion thread context.
+ * @param group A pointer to the DSA device group.
+ */
+static void
+dsa_completion_thread_init(
+    struct dsa_completion_thread *completion_thread,
+    struct dsa_device_group *group)
+{
+    completion_thread->stopping = false;
+    completion_thread->running = true;
+    completion_thread->thread_id = -1;
+    qemu_sem_init(&completion_thread->sem_init_done, 0);
+    completion_thread->group = group;
+
+    qemu_thread_create(&completion_thread->thread,
+                       DSA_COMPLETION_THREAD,
+                       dsa_completion_loop,
+                       completion_thread,
+                       QEMU_THREAD_JOINABLE);
+
+    /* Wait for initialization to complete */
+    while (completion_thread->thread_id == -1) {
+        qemu_sem_wait(&completion_thread->sem_init_done);
+    }
+}
+
+/**
+ * @brief Stops the completion thread (and implicitly, the device group).
+ *
+ * @param opaque A pointer to the completion thread.
+ */
+static void dsa_completion_thread_stop(void *opaque)
+{
+    struct dsa_completion_thread *thread_context =
+        (struct dsa_completion_thread *)opaque;
+
+    struct dsa_device_group *group = thread_context->group;
+
+    qemu_mutex_lock(&group->task_queue_lock);
+
+    thread_context->stopping = true;
+    thread_context->running = false;
+
+    dsa_device_group_stop(group);
+
+    qemu_cond_signal(&group->task_queue_cond);
+    qemu_mutex_unlock(&group->task_queue_lock);
+
+    qemu_thread_join(&thread_context->thread);
+
+    qemu_sem_destroy(&thread_context->sem_init_done);
+}
+
 /**
  * @brief Check if DSA is running.
  *
@@ -446,7 +685,7 @@ submit_batch_wi_async(struct buffer_zero_batch_task *batch_task)
  */
 bool dsa_is_running(void)
 {
-    return false;
+    return completion_thread.running;
 }
 
 static void
@@ -481,6 +720,7 @@ void dsa_start(void)
         return;
     }
     dsa_device_group_start(&dsa_group);
+    dsa_completion_thread_init(&completion_thread, &dsa_group);
 }
 
 /**
@@ -496,6 +736,7 @@ void dsa_stop(void)
         return;
     }
 
+    dsa_completion_thread_stop(&completion_thread);
     dsa_empty_task_queue(group);
 }
 
-- 
2.30.2


