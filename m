Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9495A8239CB
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 01:47:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLBs4-0008Ks-Rp; Wed, 03 Jan 2024 19:46:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rLBrq-0008Hd-BF
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 19:45:51 -0500
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rLBrm-0007RC-8q
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 19:45:49 -0500
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-42836ebe0a8so24861cf.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 16:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1704329145; x=1704933945; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YNNi+iDO4dO4E6G1WEgdM1CeYW/1K8rq3XfZGS9H9Sc=;
 b=KUNB+XZhfJa0klivKzlbGpZIurrJz7aQ58fBFxYKGlpN3/5c+qly7Ek5lhumDmo5Zo
 OcQGP/uwza27PmjoWpveSaV4ghVZpisM/ObCcbcZTYyLksb1UdNjspKyqxCO9ealMgyu
 jUMeApc7lFe70QHoiA1K6RvWiXx25F3Pj8TE/UJSnLKVrgi3CUsqgXSI5xj89t4z6mXz
 GAV7ph6fXDSc3bD378ywK1/sjaJf23NWkcuugL+sW40wsxZi9cCfIO2CaQCVuOSexZg5
 lw29r1QGTKljMGSiFgd9aIn0mgDb4S/oIHF1vNO4HsdMa6DbgjgebxCEgaVPhlf45fto
 SC2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704329145; x=1704933945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YNNi+iDO4dO4E6G1WEgdM1CeYW/1K8rq3XfZGS9H9Sc=;
 b=CwKMAA2bMmcBmDUy6U3Awdlxzg8nmAf2eu6SlFXz2HnerUPAEFv/H45PE4EiROUnjA
 CGjWUM9EvpKM11f4TYScsPOC2NQolzMJEWRFhBNRp0zoP83a8Qxts5YcSko1jUwmgoHf
 MiTGPNDxLo1zdAZFBZGj5FfhvOAv6ZZy8zPF0F0E85x94rU61xt9+AOKo950IctvCBsz
 IjibIKre6eaOHO1MMgfa4mojk0Hw8WnNjktYgmsrCxaXJuGrX5l5j9nuMhlNIlFUswTM
 MeXT7DPtHfkFQddYAnwtGJ18uqmRR2DunW71LdreKgCJynmAJaXxIKcqfmgt4+JHNsHL
 OI0g==
X-Gm-Message-State: AOJu0YzVnrgXulJ37edwkpiusLW1Fri1rrR4x7Xzb4flyCwOjuyozQl6
 U4zhApWtwQDD1OL+6PiuA6q/fLtxTIBWTQ==
X-Google-Smtp-Source: AGHT+IEOUYQ0hRE/x2Oqlr6pL4bysMwvSH7FeJ+EA4XKlL/Kz+IbvX8rKmf88xY9nxzrTdQiYazjiw==
X-Received: by 2002:a05:6214:d82:b0:680:b8c8:3278 with SMTP id
 e2-20020a0562140d8200b00680b8c83278mr5751774qve.114.1704329144717; 
 Wed, 03 Jan 2024 16:45:44 -0800 (PST)
Received: from n231-230-216.byted.org ([147.160.184.87])
 by smtp.gmail.com with ESMTPSA id
 x19-20020ae9f813000000b0077d66e5b2e6sm10646087qkh.3.2024.01.03.16.45.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 16:45:44 -0800 (PST)
From: Hao Xiang <hao.xiang@bytedance.com>
To: farosas@suse.de, peter.maydell@linaro.org, peterx@redhat.com,
 marcandre.lureau@redhat.com, bryan.zhang@bytedance.com,
 qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH v3 09/20] util/dsa: Implement DSA task asynchronous completion
 thread model.
Date: Thu,  4 Jan 2024 00:44:41 +0000
Message-Id: <20240104004452.324068-10-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240104004452.324068-1-hao.xiang@bytedance.com>
References: <20240104004452.324068-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::835;
 envelope-from=hao.xiang@bytedance.com; helo=mail-qt1-x835.google.com
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
 include/qemu/dsa.h |   1 +
 util/dsa.c         | 274 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 274 insertions(+), 1 deletion(-)

diff --git a/include/qemu/dsa.h b/include/qemu/dsa.h
index 37cae8d9d2..2513192a2b 100644
--- a/include/qemu/dsa.h
+++ b/include/qemu/dsa.h
@@ -38,6 +38,7 @@ typedef struct dsa_batch_task {
     DsaTaskType task_type;
     DsaTaskStatus status;
     int batch_size;
+    bool *results;
     QSIMPLEQ_ENTRY(dsa_batch_task) entry;
 } dsa_batch_task;
 
diff --git a/util/dsa.c b/util/dsa.c
index 75739a1af6..003c4f47d9 100644
--- a/util/dsa.c
+++ b/util/dsa.c
@@ -44,6 +44,7 @@
 
 #define DSA_WQ_SIZE 4096
 #define MAX_DSA_DEVICES 16
+#define DSA_COMPLETION_THREAD "dsa_completion"
 
 typedef QSIMPLEQ_HEAD(dsa_task_queue, dsa_batch_task) dsa_task_queue;
 
@@ -62,8 +63,18 @@ struct dsa_device_group {
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
@@ -443,6 +454,265 @@ submit_batch_wi_async(struct dsa_batch_task *batch_task)
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
+        /* The DSA operation completes successfully or fails. */
+        status = completion->status;
+        if (status == DSA_COMP_SUCCESS ||
+            status == DSA_COMP_PAGE_FAULT_NOBOF ||
+            status == DSA_COMP_BATCH_PAGE_FAULT ||
+            status == DSA_COMP_BATCH_FAIL) {
+            break;
+        } else if (status != DSA_COMP_NONE) {
+            error_report("DSA opcode %d failed with status = %d.",
+                    opcode, status);
+            return 1;
+        }
+        retry++;
+        if (retry > max_retry_count) {
+            error_report("DSA wait for completion retry %lu times.", retry);
+            return 1;
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
+ *
+ * @return Zero if successful, otherwise non-zero.
+ */
+static int
+poll_task_completion(struct dsa_batch_task *task)
+{
+    assert(task->task_type == DSA_TASK);
+
+    struct dsa_completion_record *completion = &task->completions[0];
+    uint8_t status;
+    int ret;
+
+    ret = poll_completion(completion, task->descriptors[0].opcode);
+    if (ret != 0) {
+        goto exit;
+    }
+
+    status = completion->status;
+    if (status == DSA_COMP_SUCCESS) {
+        task->results[0] = (completion->result == 0);
+        goto exit;
+    }
+
+    assert(status == DSA_COMP_PAGE_FAULT_NOBOF);
+
+exit:
+    return ret;
+}
+
+/**
+ * @brief Poll a batch task status until it completes. If DSA task doesn't
+ *        complete properly, use CPU to complete the task.
+ *
+ * @param batch_task A pointer to the DSA batch task.
+ *
+ * @return Zero if successful, otherwise non-zero.
+ */
+static int
+poll_batch_task_completion(struct dsa_batch_task *batch_task)
+{
+    struct dsa_completion_record *batch_completion =
+        &batch_task->batch_completion;
+    struct dsa_completion_record *completion;
+    uint8_t batch_status;
+    uint8_t status;
+    bool *results = batch_task->results;
+    uint32_t count = batch_task->batch_descriptor.desc_count;
+    int ret;
+
+    ret = poll_completion(batch_completion,
+                          batch_task->batch_descriptor.opcode);
+    if (ret != 0) {
+        goto exit;
+    }
+
+    batch_status = batch_completion->status;
+
+    if (batch_status == DSA_COMP_SUCCESS) {
+        if (batch_completion->bytes_completed == count) {
+            /*
+             * Let's skip checking for each descriptors' completion status
+             * if the batch descriptor says all succedded.
+             */
+            for (int i = 0; i < count; i++) {
+                assert(batch_task->completions[i].status == DSA_COMP_SUCCESS);
+                results[i] = (batch_task->completions[i].result == 0);
+            }
+            goto exit;
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
+        assert(status == DSA_COMP_PAGE_FAULT_NOBOF);
+
+        if (status != DSA_COMP_PAGE_FAULT_NOBOF) {
+            error_report("Unexpected DSA completion status = %u.", status);
+            ret = 1;
+            goto exit;
+        }
+    }
+
+exit:
+    return ret;
+}
+
+/**
+ * @brief Handles an asynchronous DSA batch task completion.
+ *
+ * @param task A pointer to the batch buffer zero task structure.
+ */
+static void
+dsa_batch_task_complete(struct dsa_batch_task *batch_task)
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
+    struct dsa_batch_task *batch_task;
+    struct dsa_device_group *group = thread_context->group;
+    int ret;
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
+            ret = poll_task_completion(batch_task);
+        } else {
+            assert(batch_task->task_type == DSA_BATCH_TASK);
+            ret = poll_batch_task_completion(batch_task);
+        }
+
+        if (ret != 0) {
+            goto exit;
+        }
+
+        dsa_batch_task_complete(batch_task);
+    }
+
+exit:
+    if (ret != 0) {
+        error_report("DSA completion thread exited due to internal error.");
+    }
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
+    qemu_sem_wait(&completion_thread->sem_init_done);
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
+    /* Prevent the compiler from setting group->running first. */
+    barrier();
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
@@ -450,7 +720,7 @@ submit_batch_wi_async(struct dsa_batch_task *batch_task)
  */
 bool dsa_is_running(void)
 {
-    return false;
+    return completion_thread.running;
 }
 
 static void
@@ -486,6 +756,7 @@ void dsa_start(void)
         return;
     }
     dsa_device_group_start(&dsa_group);
+    dsa_completion_thread_init(&completion_thread, &dsa_group);
 }
 
 /**
@@ -500,6 +771,7 @@ void dsa_stop(void)
         return;
     }
 
+    dsa_completion_thread_stop(&completion_thread);
     dsa_empty_task_queue(group);
 }
 
-- 
2.30.2


