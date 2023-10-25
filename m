Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C55EC7D748A
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 21:41:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvjjF-0000tB-Cx; Wed, 25 Oct 2023 15:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1qvjjD-0000sb-Ek
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 15:39:43 -0400
Received: from mail-qk1-x734.google.com ([2607:f8b0:4864:20::734])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1qvjjB-00069W-Fx
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 15:39:43 -0400
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-778a47bc09aso9238385a.3
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 12:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1698262780; x=1698867580; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3DH9IahCxHNZhgGh3NSSJ8rC6cgU5W5EjmHIaRYa9EQ=;
 b=FCjjf3HpXsE59DCTCyGaYTw58vKBcT9tAPQ2Ngt5yYGTLWiAA0JaU7eDww9wYx5LFw
 8SoCwNIFJOZIe3sSlyxih/0p3zD1uoSKuN3sriVW0sJcQ0IHeCQzQjQLwXEMK20nWeKc
 JhXHLoc27I1m/zPaSp/5xKv4c2xvYi3Ahu8sU/H/KRj1SnunclW1ElUyL75yhdp3KKnz
 UFDbitn617Bcg7fyvas0l0BA6dlkTNn+6+yzypwVvvHbwAVwGhpH2JLs5e9OlpR16OeH
 sFYl879Ekx4CtIr11zFEmlBLw/bMSjlmxqbaHYRvsqxW+iY98fYjFHhjEpvlp5DfjjQP
 d8jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698262780; x=1698867580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3DH9IahCxHNZhgGh3NSSJ8rC6cgU5W5EjmHIaRYa9EQ=;
 b=Dhd8N+BDdhZ43Wr9s776eyLwWNn0HYZBBpsCq8IR6SxVohdAF3wBm77TKPQ7Qk9WUY
 MIaFQ5TdMZg5JfWHguzN5GygDRbr+7IBYMMxmXgubWin2IY45gTqLDxb+Sm6LPrteRmQ
 cUjisR8bivNKL8Sl+WWgABZEkUhS932+bqynokuGQKHuWBWiETBAkppia+QVoSw6anKZ
 7iUi87HgnyWgGaQhkveEk6OwwMQyBjSkVCrvSrSRB6lDsThEUmaicIMaNix+J2ugBiUM
 2ixDS4BMK72kK+TLitKUnI8xzZUrgst9HR3d9jobf0Z0rtZ+KE5a5gAyjKXjkttYLkIB
 68HA==
X-Gm-Message-State: AOJu0YyiEr5/eEBgyoavi48TsX0IwjRTSLgzGANq3CUp/dDo7j9UjeWH
 1MohhKy8vDmowIRD7xedHeJb2gumDcmgR1QF0rE=
X-Google-Smtp-Source: AGHT+IG+UOeZqkyuGmp09o0Bcotzyfe7GgvDIfe6XZau5AYgXj5C7qi+7ChdR0upsGVIh9w6q4lheA==
X-Received: by 2002:a05:620a:1a27:b0:774:2915:d180 with SMTP id
 bk39-20020a05620a1a2700b007742915d180mr18821794qkb.37.1698262780129; 
 Wed, 25 Oct 2023 12:39:40 -0700 (PDT)
Received: from n231-230-216.byted.org ([147.160.184.135])
 by smtp.gmail.com with ESMTPSA id
 o8-20020a05620a228800b0076cdc3b5beasm4453721qkh.86.2023.10.25.12.39.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 12:39:39 -0700 (PDT)
From: Hao Xiang <hao.xiang@bytedance.com>
To: quintela@redhat.com, peterx@redhat.com, marcandre.lureau@redhat.com,
 bryan.zhang@bytedance.com, qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH 08/16] util/dsa: Implement DSA task asynchronous submission
 and wait for completion.
Date: Wed, 25 Oct 2023 19:38:14 +0000
Message-Id: <20231025193822.2813204-9-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231025193822.2813204-1-hao.xiang@bytedance.com>
References: <20231025193822.2813204-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::734;
 envelope-from=hao.xiang@bytedance.com; helo=mail-qk1-x734.google.com
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


