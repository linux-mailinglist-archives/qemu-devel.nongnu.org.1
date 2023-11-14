Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0897EAA2D
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 06:43:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2mBS-0007F2-MF; Tue, 14 Nov 2023 00:41:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1r2mBO-0007EE-Rf
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 00:41:55 -0500
Received: from mail-qk1-x732.google.com ([2607:f8b0:4864:20::732])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1r2mBL-0001Ss-3B
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 00:41:54 -0500
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7789a4c01easo338437085a.0
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 21:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1699940509; x=1700545309; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3DH9IahCxHNZhgGh3NSSJ8rC6cgU5W5EjmHIaRYa9EQ=;
 b=BjGZi4HkKc/1gCNU6pauq8gbd+RDaMnfCIoGZF/4Fs6F8ukg3vGNp3F7nuSbxHos65
 9j5qH6nTqaeWNNmGHdbE9ntBXznZaUU5BYx/gao3j4g8rWpfja+d+sgoy3Q43luDhTTB
 HvlNH8URp1+nr1ynt5x0TaorV5SPGSrWYlmsY1dkYLwSvai/rLTBaZrY3BSUF5hP5GLw
 r+0pWLJGOTFQ6CLNjAgYrVaHcNqdEf2WSEt29a7Fxkn7SsXZ3EsoTF5LIUCl/ZV1TO9s
 0k/2hMyPkm+iT5A4tOQMTEk4AkVCqZfJhX9VdFi2heV/oHKInIUG6UibHGxBwMztIsmX
 mJRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699940509; x=1700545309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3DH9IahCxHNZhgGh3NSSJ8rC6cgU5W5EjmHIaRYa9EQ=;
 b=RJ2EsuUVeghR7ApYGTnt8ORg2LAJ5lWuQ3cG4g3aSfGVZgImPbSSW4IsaSZsGnPZaR
 fB9xM3xFSHR4znWhpFdoCx5ZGuWG6ewBYQ9W5C+NsBuUhRY+3wUkkVEa7CWFlPvFNQ2z
 vUyoCibnStAWZL7AWseqHsoLsIknK4Nhq/rWWCY9gyXVVfTroxOLQ49l2G3CBa+a02SG
 8mxftAwv6Txikc02IykrASZv2WaX9I8dbECRlK00G38CQGRVtG3QbZCb9a2SyYGFnPKR
 zMLLqF/DCJPaN9z38WiIBfCDJnP2IrYWHagfI2F6cQW7ZbNZUcu/OphJgevLmkMIwrjv
 ndkA==
X-Gm-Message-State: AOJu0YwkD8olOhVKY+X9nexrmPIoIVaWXbcHBFqSDPJaNBNOBqc5HQmr
 1mvj9DN1hIoxGcBOrwMDBvQ1pw==
X-Google-Smtp-Source: AGHT+IHyGB9ekwmVMcTep8nrAGfWbU50QvwWWfH27MJjhIl3G7AwPe7FbHW2RtpOxtWEDKhuCHioqw==
X-Received: by 2002:a05:620a:d85:b0:77a:a2c:679a with SMTP id
 q5-20020a05620a0d8500b0077a0a2c679amr1364274qkl.42.1699940509069; 
 Mon, 13 Nov 2023 21:41:49 -0800 (PST)
Received: from n231-230-216.byted.org ([130.44.212.104])
 by smtp.gmail.com with ESMTPSA id
 w2-20020a05620a094200b0077891d2d12dsm2400367qkw.43.2023.11.13.21.41.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 21:41:48 -0800 (PST)
From: Hao Xiang <hao.xiang@bytedance.com>
To: farosas@suse.de, peter.maydell@linaro.org, quintela@redhat.com,
 peterx@redhat.com, marcandre.lureau@redhat.com, bryan.zhang@bytedance.com,
 qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH v2 11/20] util/dsa: Implement DSA task asynchronous submission
 and wait for completion.
Date: Tue, 14 Nov 2023 05:40:23 +0000
Message-Id: <20231114054032.1192027-12-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231114054032.1192027-1-hao.xiang@bytedance.com>
References: <20231114054032.1192027-1-hao.xiang@bytedance.com>
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

* Add a DSA task completion callback.
* DSA completion thread will call the tasks's completion callback
on every task/batch task completion.
* DSA submission path to wait for completion.
* Implement CPU fallback if DSA is not able to complete the task.

Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
---
 include/qemu/dsa.h |  14 +++++
 util/dsa.c         | 153 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 164 insertions(+), 3 deletions(-)

diff --git a/include/qemu/dsa.h b/include/qemu/dsa.h
index b10e7b8fb7..3f8ee07004 100644
--- a/include/qemu/dsa.h
+++ b/include/qemu/dsa.h
@@ -65,6 +65,20 @@ void buffer_zero_batch_task_init(struct buffer_zero_batch_task *task,
  */
 void buffer_zero_batch_task_destroy(struct buffer_zero_batch_task *task);
 
+/**
+ * @brief Performs buffer zero comparison on a DSA batch task asynchronously.
+ *
+ * @param batch_task A pointer to the batch task.
+ * @param buf An array of memory buffers.
+ * @param count The number of buffers in the array.
+ * @param len The buffer length.
+ *
+ * @return Zero if successful, otherwise non-zero.
+ */
+int
+buffer_is_zero_dsa_batch_async(struct buffer_zero_batch_task *batch_task,
+                               const void **buf, size_t count, size_t len);
+
 /**
  * @brief Initializes DSA devices.
  *
diff --git a/util/dsa.c b/util/dsa.c
index 3cc017b8a0..06c6fbf2ca 100644
--- a/util/dsa.c
+++ b/util/dsa.c
@@ -470,6 +470,41 @@ poll_completion(struct dsa_completion_record *completion,
     return 0;
 }
 
+/**
+ * @brief Use CPU to complete a single zero page checking task.
+ *
+ * @param task A pointer to the task.
+ */
+static void
+task_cpu_fallback(struct buffer_zero_batch_task *task)
+{
+    assert(task->task_type == DSA_TASK);
+
+    struct dsa_completion_record *completion = &task->completions[0];
+    const uint8_t *buf;
+    size_t len;
+
+    if (completion->status == DSA_COMP_SUCCESS) {
+        return;
+    }
+
+    /*
+     * DSA was able to partially complete the operation. Check the
+     * result. If we already know this is not a zero page, we can
+     * return now.
+     */
+    if (completion->bytes_completed != 0 && completion->result != 0) {
+        task->results[0] = false;
+        return;
+    }
+
+    /* Let's fallback to use CPU to complete it. */
+    buf = (const uint8_t *)task->descriptors[0].src_addr;
+    len = task->descriptors[0].xfer_size;
+    task->results[0] = buffer_is_zero(buf + completion->bytes_completed,
+                                      len - completion->bytes_completed);
+}
+
 /**
  * @brief Complete a single DSA task in the batch task.
  *
@@ -548,6 +583,62 @@ poll_batch_task_completion(struct buffer_zero_batch_task *batch_task)
     }
 }
 
+/**
+ * @brief Use CPU to complete the zero page checking batch task.
+ *
+ * @param batch_task A pointer to the batch task.
+ */
+static void
+batch_task_cpu_fallback(struct buffer_zero_batch_task *batch_task)
+{
+    assert(batch_task->task_type == DSA_BATCH_TASK);
+
+    struct dsa_completion_record *batch_completion =
+        &batch_task->batch_completion;
+    struct dsa_completion_record *completion;
+    uint8_t status;
+    const uint8_t *buf;
+    size_t len;
+    bool *results = batch_task->results;
+    uint32_t count = batch_task->batch_descriptor.desc_count;
+
+    // DSA is able to complete the entire batch task.
+    if (batch_completion->status == DSA_COMP_SUCCESS) {
+        assert(count == batch_completion->bytes_completed);
+        return;
+    }
+
+    /*
+     * DSA encounters some error and is not able to complete
+     * the entire batch task. Use CPU fallback.
+     */
+    for (int i = 0; i < count; i++) {
+        completion = &batch_task->completions[i];
+        status = completion->status;
+        if (status == DSA_COMP_SUCCESS) {
+            continue;
+        }
+        assert(status == DSA_COMP_PAGE_FAULT_NOBOF);
+
+        /*
+         * DSA was able to partially complete the operation. Check the
+         * result. If we already know this is not a zero page, we can
+         * return now.
+         */
+        if (completion->bytes_completed != 0 && completion->result != 0) {
+            results[i] = false;
+            continue;
+        }
+
+        /* Let's fallback to use CPU to complete it. */
+        buf = (uint8_t *)batch_task->descriptors[i].src_addr;
+        len = batch_task->descriptors[i].xfer_size;
+        results[i] =
+            buffer_is_zero(buf + completion->bytes_completed,
+                           len - completion->bytes_completed);
+    }
+}
+
 /**
  * @brief Handles an asynchronous DSA batch task completion.
  *
@@ -825,7 +916,6 @@ buffer_zero_batch_task_set(struct buffer_zero_batch_task *batch_task,
  *
  * @return int Zero if successful, otherwise an appropriate error code.
  */
-__attribute__((unused))
 static int
 buffer_zero_dsa_async(struct buffer_zero_batch_task *task,
                       const void *buf, size_t len)
@@ -844,7 +934,6 @@ buffer_zero_dsa_async(struct buffer_zero_batch_task *task,
  * @param count The number of buffers.
  * @param len The buffer length.
  */
-__attribute__((unused))
 static int
 buffer_zero_dsa_batch_async(struct buffer_zero_batch_task *batch_task,
                             const void **buf, size_t count, size_t len)
@@ -876,13 +965,29 @@ buffer_zero_dsa_completion(void *context)
  *
  * @param batch_task A pointer to the buffer zero comparison batch task.
  */
-__attribute__((unused))
 static void
 buffer_zero_dsa_wait(struct buffer_zero_batch_task *batch_task)
 {
     qemu_sem_wait(&batch_task->sem_task_complete);
 }
 
+/**
+ * @brief Use CPU to complete the zero page checking task if DSA
+ *        is not able to complete it.
+ *
+ * @param batch_task A pointer to the batch task.
+ */
+static void
+buffer_zero_cpu_fallback(struct buffer_zero_batch_task *batch_task)
+{
+    if (batch_task->task_type == DSA_TASK) {
+        task_cpu_fallback(batch_task);
+    } else {
+        assert(batch_task->task_type == DSA_BATCH_TASK);
+        batch_task_cpu_fallback(batch_task);
+    }
+}
+
 /**
  * @brief Check if DSA is running.
  *
@@ -956,6 +1061,41 @@ void dsa_cleanup(void)
     dsa_device_group_cleanup(&dsa_group);
 }
 
+/**
+ * @brief Performs buffer zero comparison on a DSA batch task asynchronously.
+ *
+ * @param batch_task A pointer to the batch task.
+ * @param buf An array of memory buffers.
+ * @param count The number of buffers in the array.
+ * @param len The buffer length.
+ *
+ * @return Zero if successful, otherwise non-zero.
+ */
+int
+buffer_is_zero_dsa_batch_async(struct buffer_zero_batch_task *batch_task,
+                               const void **buf, size_t count, size_t len)
+{
+    if (count <= 0 || count > batch_task->batch_size) {
+        return -1;
+    }
+
+    assert(batch_task != NULL);
+    assert(len != 0);
+    assert(buf != NULL);
+
+    if (count == 1) {
+        // DSA doesn't take batch operation with only 1 task.
+        buffer_zero_dsa_async(batch_task, buf[0], len);
+    } else {
+        buffer_zero_dsa_batch_async(batch_task, buf, count, len);
+    }
+
+    buffer_zero_dsa_wait(batch_task);
+    buffer_zero_cpu_fallback(batch_task);
+
+    return 0;
+}
+
 #else
 
 void buffer_zero_batch_task_init(struct buffer_zero_batch_task *task,
@@ -981,5 +1121,12 @@ void dsa_stop(void) {}
 
 void dsa_cleanup(void) {}
 
+int
+buffer_is_zero_dsa_batch_async(struct buffer_zero_batch_task *batch_task,
+                               const void **buf, size_t count, size_t len)
+{
+    exit(1);
+}
+
 #endif
 
-- 
2.30.2


