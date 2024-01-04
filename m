Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33BD18239D1
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 01:47:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLBs6-0008LD-AS; Wed, 03 Jan 2024 19:46:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rLBrq-0008Hg-CI
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 19:45:51 -0500
Received: from mail-qk1-x733.google.com ([2607:f8b0:4864:20::733])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rLBrn-0007Sc-H1
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 19:45:49 -0500
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7812275feccso1765085a.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 16:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1704329146; x=1704933946; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=thGFDBbtNtxUYxf1HYRG6UycJNIqRo4s5FukU8XP+so=;
 b=J0Faked8gtB2HElPSWvo8C7opzQk93+uwt+Z7aic5zbJYg5kKfFnKzOnswuQ9xPYyQ
 My4fzPUl+tOEH/Tr5WsUzPdUnFxaPeF22GFdhYIdAl1B/z5CFQrCwWqY1xa6OIrUdGyU
 yYxiSZ+YWWjcmKAqc1FPEyXD7UFDVV/QMGTzb7sULlI23Slxtktv7AqP0l+iuO0xG3kq
 jFJvM/tLtJBivTAXGsnvVxiOf0u+/vzsJYTM2iMT+q7zgHC1gJPyIzS/e6cpTarl4RAE
 iOEim6bBZNUbPIPecGshONY/SYN2CfnuywSJAVKkB9Gb5csmt0JUqmn0KWe6Ee1WMvS0
 PFpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704329146; x=1704933946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=thGFDBbtNtxUYxf1HYRG6UycJNIqRo4s5FukU8XP+so=;
 b=YL2L9gqpnW7b0q8UEyYeO640H3pd272mV6F9HkqXtXOn4kpBkPE21N50kBdMKGMUgB
 xatusTRthzf8+Aq2reie2DCjRkDaNFL14wC3lnPAoAXFVCafqtx5d9aytnUcHZo/TJ5G
 idSqKk3WWvWuE71wBDp9lp/m6St1WLapVs+Gn0Up1TjVHRyNfQpLuj2bVtaVN7t5FVtY
 vPC5Cv3L7ze3eHKYRHSZ7MMWkyuS0/gXGNQogvNPXa+7YsNblorcBkLvh6Bep6OisqRS
 JyAw7oTZWBEfzF0YiZA+lU7cEjABiJ7z/Z8DIdpEgiV2Cm319g67dW+03wkBq6Y0H0eW
 fe6w==
X-Gm-Message-State: AOJu0YzlepDn55q/X00pwUt7RqgS5D8jabZuyd4fPXXiebSI2+KgHSlt
 fQk05zMi7aWQdK/CE/t5DVN8HHfP9BkV8w==
X-Google-Smtp-Source: AGHT+IHDmAfQVYM645Jj0sd4EtYbmJtWw0J47FFudU+3Jp/uloKTzstmQL3d7Ci1cJdadyazuHfn9Q==
X-Received: by 2002:a05:620a:5595:b0:781:1e38:d878 with SMTP id
 vq21-20020a05620a559500b007811e38d878mr25169815qkn.76.1704329146634; 
 Wed, 03 Jan 2024 16:45:46 -0800 (PST)
Received: from n231-230-216.byted.org ([147.160.184.87])
 by smtp.gmail.com with ESMTPSA id
 x19-20020ae9f813000000b0077d66e5b2e6sm10646087qkh.3.2024.01.03.16.45.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 16:45:45 -0800 (PST)
From: Hao Xiang <hao.xiang@bytedance.com>
To: farosas@suse.de, peter.maydell@linaro.org, peterx@redhat.com,
 marcandre.lureau@redhat.com, bryan.zhang@bytedance.com,
 qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH v3 11/20] util/dsa: Implement DSA task asynchronous submission
 and wait for completion.
Date: Thu,  4 Jan 2024 00:44:43 +0000
Message-Id: <20240104004452.324068-12-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240104004452.324068-1-hao.xiang@bytedance.com>
References: <20240104004452.324068-1-hao.xiang@bytedance.com>
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

* Add a DSA task completion callback.
* DSA completion thread will call the tasks's completion callback
on every task/batch task completion.
* DSA submission path to wait for completion.
* Implement CPU fallback if DSA is not able to complete the task.

Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
---
 include/qemu/dsa.h |  14 +++++
 util/dsa.c         | 147 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 158 insertions(+), 3 deletions(-)

diff --git a/include/qemu/dsa.h b/include/qemu/dsa.h
index 645e6fc367..e002652879 100644
--- a/include/qemu/dsa.h
+++ b/include/qemu/dsa.h
@@ -91,6 +91,20 @@ buffer_zero_batch_task_init(struct dsa_batch_task *task,
  */
 void buffer_zero_batch_task_destroy(struct dsa_batch_task *task);
 
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
+buffer_is_zero_dsa_batch_async(struct dsa_batch_task *batch_task,
+                               const void **buf, size_t count, size_t len);
+
 #else
 
 static inline bool dsa_is_running(void)
diff --git a/util/dsa.c b/util/dsa.c
index 9db4cfcf1d..5a2bf33651 100644
--- a/util/dsa.c
+++ b/util/dsa.c
@@ -473,6 +473,57 @@ poll_completion(struct dsa_completion_record *completion,
     return 0;
 }
 
+/**
+ * @brief Helper function to use CPU to complete a single
+ *        zero page checking task.
+ *
+ * @param completion A pointer to a DSA task completion record.
+ * @param descriptor A pointer to a DSA task descriptor.
+ * @param result A pointer to the result of a zero page checking.
+ */
+static void
+task_cpu_fallback_int(struct dsa_completion_record *completion,
+                      struct dsa_hw_desc *descriptor, bool *result)
+{
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
+        *result = false;
+        return;
+    }
+
+    /* Let's fallback to use CPU to complete it. */
+    buf = (const uint8_t *)descriptor->src_addr;
+    len = descriptor->xfer_size;
+    *result = buffer_is_zero(buf + completion->bytes_completed,
+                             len - completion->bytes_completed);
+}
+
+/**
+ * @brief Use CPU to complete a single zero page checking task.
+ *
+ * @param task A pointer to the task.
+ */
+static void
+task_cpu_fallback(struct dsa_batch_task *task)
+{
+    assert(task->task_type == DSA_TASK);
+
+    task_cpu_fallback_int(&task->completions[0],
+                          &task->descriptors[0],
+                          &task->results[0]);
+}
+
 /**
  * @brief Complete a single DSA task in the batch task.
  *
@@ -574,6 +625,47 @@ exit:
     return ret;
 }
 
+/**
+ * @brief Use CPU to complete the zero page checking batch task.
+ *
+ * @param batch_task A pointer to the batch task.
+ */
+static void
+batch_task_cpu_fallback(struct dsa_batch_task *batch_task)
+{
+    assert(batch_task->task_type == DSA_BATCH_TASK);
+
+    struct dsa_completion_record *batch_completion =
+        &batch_task->batch_completion;
+    struct dsa_completion_record *completion;
+    uint8_t status;
+    bool *results = batch_task->results;
+    uint32_t count = batch_task->batch_descriptor.desc_count;
+
+    /* DSA is able to complete the entire batch task. */
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
+
+        completion = &batch_task->completions[i];
+        status = completion->status;
+
+        assert(status == DSA_COMP_SUCCESS ||
+            status == DSA_COMP_PAGE_FAULT_NOBOF);
+
+        task_cpu_fallback_int(completion,
+                              &batch_task->descriptors[i],
+                              &results[i]);
+    }
+}
+
 /**
  * @brief Handles an asynchronous DSA batch task completion.
  *
@@ -861,7 +953,6 @@ buffer_zero_batch_task_set(struct dsa_batch_task *batch_task,
  *
  * @return int Zero if successful, otherwise an appropriate error code.
  */
-__attribute__((unused))
 static int
 buffer_zero_dsa_async(struct dsa_batch_task *task,
                       const void *buf, size_t len)
@@ -880,7 +971,6 @@ buffer_zero_dsa_async(struct dsa_batch_task *task,
  * @param count The number of buffers.
  * @param len The buffer length.
  */
-__attribute__((unused))
 static int
 buffer_zero_dsa_batch_async(struct dsa_batch_task *batch_task,
                             const void **buf, size_t count, size_t len)
@@ -911,13 +1001,29 @@ buffer_zero_dsa_completion(void *context)
  *
  * @param batch_task A pointer to the buffer zero comparison batch task.
  */
-__attribute__((unused))
 static void
 buffer_zero_dsa_wait(struct dsa_batch_task *batch_task)
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
+buffer_zero_cpu_fallback(struct dsa_batch_task *batch_task)
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
@@ -990,5 +1096,40 @@ void dsa_cleanup(void)
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
+buffer_is_zero_dsa_batch_async(struct dsa_batch_task *batch_task,
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
+        /* DSA doesn't take batch operation with only 1 task. */
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
 #endif
 
-- 
2.30.2


