Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB00D8239DF
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 01:50:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLBs5-0008Kt-71; Wed, 03 Jan 2024 19:46:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rLBrr-0008Hi-1p
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 19:45:51 -0500
Received: from mail-qk1-x72e.google.com ([2607:f8b0:4864:20::72e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rLBro-0007UL-TY
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 19:45:50 -0500
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-78109a21144so2199485a.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 16:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1704329148; x=1704933948; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hjqc0MDwZ2dIuPp0XnT06qNhonHSsnXQ8jjps1IW7I4=;
 b=OvMGFFvqO3iiPoAXxHmMXn7NMJZBf59rL/UoVk8gKZ5NVsmGlV7NkIj0kpLKaxNWks
 8W60U1d2O7QFowOgQ+Zhh2CqaxWHkXqrH4XzeZQt8VnHm9+fKJ5yp0KzP2MajLo5YQwj
 tQRj/OHprNqw45cXqBwuzK4B2mCHYTYohd7pJIuLg7FLZBuTG6zt5ZNjyNrLYcwfLnuR
 LrrfUg2QVvzLuHzmOmNJxC6Lo6zx+uc94q+Kq22TofivZIzra85iRVYmnNIR2f/5zoBt
 etMWEHZhYofiksC0KJSMx3KSGGeEdsh7YBTa8VltIvbJp9/lp8MOvIurkn2T4AZomUxi
 iOVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704329148; x=1704933948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hjqc0MDwZ2dIuPp0XnT06qNhonHSsnXQ8jjps1IW7I4=;
 b=TknvEIYnd03WSZBq5s9FAmpV7NtsdHHYXhDAcSKfFsrIUWeKksNI4v8kKrlgcmMwGE
 MnGR97kx+2CtnBCXBp8DsfNFLgygdGyua4ZubS/mE9Yg4Qoydck6yjdniEmnHVQdgtGz
 qYk83+b9HF8tfts4ernWyLbe4Dpl561PicWTnIpQgIgJ7sxlxnYvto+jsT9AjdL9DwE3
 xwayliTYoHPgLS7tg4i4VQ1ktWM+R0ww53O/LPEeO3N7Zt2XJI4ROhvFiI0XwjZbnhXA
 ovRw9FCnm4062xgDiq672lZL5XqAh5zXLMDZc8FtJfBAnWl6G/z+KOPZJ1mgpniGTw0I
 TAFw==
X-Gm-Message-State: AOJu0Ywzl/rurmiFnAPS1fXBi5eDgXm+HS3k+y+jrgWHgz0J1qsSwgsl
 O3k/o6F7mVZKC4guNLwTQr6JfIBWv74yjA==
X-Google-Smtp-Source: AGHT+IGV4Nh38By5szJYxgYG929XzfNXH5PRcSxcqgWAkUAfBBbFSBoDdBAdD2haH+U25gjtrWpDDg==
X-Received: by 2002:a05:620a:6015:b0:781:eff2:fd00 with SMTP id
 dw21-20020a05620a601500b00781eff2fd00mr253913qkb.122.1704329148096; 
 Wed, 03 Jan 2024 16:45:48 -0800 (PST)
Received: from n231-230-216.byted.org ([147.160.184.87])
 by smtp.gmail.com with ESMTPSA id
 x19-20020ae9f813000000b0077d66e5b2e6sm10646087qkh.3.2024.01.03.16.45.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 16:45:47 -0800 (PST)
From: Hao Xiang <hao.xiang@bytedance.com>
To: farosas@suse.de, peter.maydell@linaro.org, peterx@redhat.com,
 marcandre.lureau@redhat.com, bryan.zhang@bytedance.com,
 qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH v3 13/20] migration/multifd: Prepare to introduce DSA
 acceleration on the multifd path.
Date: Thu,  4 Jan 2024 00:44:45 +0000
Message-Id: <20240104004452.324068-14-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240104004452.324068-1-hao.xiang@bytedance.com>
References: <20240104004452.324068-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72e;
 envelope-from=hao.xiang@bytedance.com; helo=mail-qk1-x72e.google.com
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

1. Refactor multifd_send_thread function.
2. Implement buffer_is_zero_use_cpu to handle CPU based zero page
checking.
3. Introduce the batch task structure in MultiFDSendParams.

Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
---
 include/qemu/dsa.h  | 43 +++++++++++++++++++++++--
 migration/multifd.c | 77 ++++++++++++++++++++++++++++++++++++---------
 migration/multifd.h |  2 ++
 util/dsa.c          | 51 +++++++++++++++++++++++++-----
 4 files changed, 148 insertions(+), 25 deletions(-)

diff --git a/include/qemu/dsa.h b/include/qemu/dsa.h
index e002652879..fe7772107a 100644
--- a/include/qemu/dsa.h
+++ b/include/qemu/dsa.h
@@ -2,6 +2,7 @@
 #define QEMU_DSA_H
 
 #include "qemu/error-report.h"
+#include "exec/cpu-common.h"
 #include "qemu/thread.h"
 #include "qemu/queue.h"
 
@@ -42,6 +43,20 @@ typedef struct dsa_batch_task {
     QSIMPLEQ_ENTRY(dsa_batch_task) entry;
 } dsa_batch_task;
 
+#endif
+
+struct batch_task {
+    /* Address of each pages in pages */
+    ram_addr_t *addr;
+    /* Zero page checking results */
+    bool *results;
+#ifdef CONFIG_DSA_OPT
+    struct dsa_batch_task *dsa_batch;
+#endif
+};
+
+#ifdef CONFIG_DSA_OPT
+
 /**
  * @brief Initializes DSA devices.
  *
@@ -74,7 +89,7 @@ void dsa_cleanup(void);
 bool dsa_is_running(void);
 
 /**
- * @brief Initializes a buffer zero batch task.
+ * @brief Initializes a buffer zero DSA batch task.
  *
  * @param task A pointer to the batch task to initialize.
  * @param results A pointer to an array of zero page checking results.
@@ -102,7 +117,7 @@ void buffer_zero_batch_task_destroy(struct dsa_batch_task *task);
  * @return Zero if successful, otherwise non-zero.
  */
 int
-buffer_is_zero_dsa_batch_async(struct dsa_batch_task *batch_task,
+buffer_is_zero_dsa_batch_async(struct batch_task *batch_task,
                                const void **buf, size_t count, size_t len);
 
 #else
@@ -128,6 +143,30 @@ static inline void dsa_stop(void) {}
 
 static inline void dsa_cleanup(void) {}
 
+static inline int
+buffer_is_zero_dsa_batch_async(struct batch_task *batch_task,
+                               const void **buf, size_t count, size_t len)
+{
+    exit(1);
+}
+
 #endif
 
+/**
+ * @brief Initializes a general buffer zero batch task.
+ *
+ * @param task A pointer to the general batch task to initialize.
+ * @param batch_size The number of zero page checking tasks in the batch.
+ */
+void
+batch_task_init(struct batch_task *task, int batch_size);
+
+/**
+ * @brief Destroys a general buffer zero batch task.
+ *
+ * @param task A pointer to the general batch task to destroy.
+ */
+void
+batch_task_destroy(struct batch_task *task);
+
 #endif
diff --git a/migration/multifd.c b/migration/multifd.c
index eece85569f..e7c549b93e 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -14,6 +14,8 @@
 #include "qemu/cutils.h"
 #include "qemu/rcu.h"
 #include "qemu/cutils.h"
+#include "qemu/dsa.h"
+#include "qemu/memalign.h"
 #include "exec/target_page.h"
 #include "sysemu/sysemu.h"
 #include "exec/ramblock.h"
@@ -574,6 +576,8 @@ void multifd_save_cleanup(void)
         p->name = NULL;
         multifd_pages_clear(p->pages);
         p->pages = NULL;
+        batch_task_destroy(p->batch_task);
+        p->batch_task = NULL;
         p->packet_len = 0;
         g_free(p->packet);
         p->packet = NULL;
@@ -678,13 +682,66 @@ int multifd_send_sync_main(QEMUFile *f)
     return 0;
 }
 
+static void set_page(MultiFDSendParams *p, bool zero_page, uint64_t offset)
+{
+    RAMBlock *rb = p->pages->block;
+    if (zero_page) {
+        p->zero[p->zero_num] = offset;
+        p->zero_num++;
+        ram_release_page(rb->idstr, offset);
+    } else {
+        p->normal[p->normal_num] = offset;
+        p->normal_num++;
+    }
+}
+
+static void buffer_is_zero_use_cpu(MultiFDSendParams *p)
+{
+    const void **buf = (const void **)p->batch_task->addr;
+    assert(!migrate_use_main_zero_page());
+
+    for (int i = 0; i < p->pages->num; i++) {
+        p->batch_task->results[i] = buffer_is_zero(buf[i], p->page_size);
+    }
+}
+
+static void set_normal_pages(MultiFDSendParams *p)
+{
+    for (int i = 0; i < p->pages->num; i++) {
+        p->batch_task->results[i] = false;
+    }
+}
+
+static void multifd_zero_page_check(MultiFDSendParams *p)
+{
+    /* older qemu don't understand zero page on multifd channel */
+    bool use_multifd_zero_page = !migrate_use_main_zero_page();
+
+    RAMBlock *rb = p->pages->block;
+
+    for (int i = 0; i < p->pages->num; i++) {
+        p->batch_task->addr[i] = (ram_addr_t)(rb->host + p->pages->offset[i]);
+    }
+
+    if (use_multifd_zero_page) {
+        buffer_is_zero_use_cpu(p);
+    } else {
+        /* No zero page checking. All pages are normal pages. */
+        set_normal_pages(p);
+    }
+
+    for (int i = 0; i < p->pages->num; i++) {
+        uint64_t offset = p->pages->offset[i];
+        bool zero_page = p->batch_task->results[i];
+        set_page(p, zero_page, offset);
+    }
+}
+
 static void *multifd_send_thread(void *opaque)
 {
     MultiFDSendParams *p = opaque;
     MigrationThread *thread = NULL;
     Error *local_err = NULL;
-    /* qemu older than 8.2 don't understand zero page on multifd channel */
-    bool use_multifd_zero_page = !migrate_use_main_zero_page();
     int ret = 0;
     bool use_zero_copy_send = migrate_zero_copy_send();
 
@@ -710,7 +767,6 @@ static void *multifd_send_thread(void *opaque)
         qemu_mutex_lock(&p->mutex);
 
         if (p->pending_job) {
-            RAMBlock *rb = p->pages->block;
             uint64_t packet_num = p->packet_num;
             uint32_t flags;
 
@@ -723,18 +779,7 @@ static void *multifd_send_thread(void *opaque)
                 p->iovs_num = 1;
             }
 
-            for (int i = 0; i < p->pages->num; i++) {
-                uint64_t offset = p->pages->offset[i];
-                if (use_multifd_zero_page &&
-                    buffer_is_zero(rb->host + offset, p->page_size)) {
-                    p->zero[p->zero_num] = offset;
-                    p->zero_num++;
-                    ram_release_page(rb->idstr, offset);
-                } else {
-                    p->normal[p->normal_num] = offset;
-                    p->normal_num++;
-                }
-            }
+            multifd_zero_page_check(p);
 
             if (p->normal_num) {
                 ret = multifd_send_state->ops->send_prepare(p, &local_err);
@@ -975,6 +1020,8 @@ int multifd_save_setup(Error **errp)
         p->pending_job = 0;
         p->id = i;
         p->pages = multifd_pages_init(page_count);
+        p->batch_task = g_malloc0(sizeof(struct batch_task));
+        batch_task_init(p->batch_task, page_count);
         p->packet_len = sizeof(MultiFDPacket_t)
                       + sizeof(uint64_t) * page_count;
         p->packet = g_malloc0(p->packet_len);
diff --git a/migration/multifd.h b/migration/multifd.h
index 13762900d4..97b5f888a7 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -119,6 +119,8 @@ typedef struct {
      * pending_job != 0 -> multifd_channel can use it.
      */
     MultiFDPages_t *pages;
+    /* Zero page checking batch task */
+    struct batch_task *batch_task;
 
     /* thread local variables. No locking required */
 
diff --git a/util/dsa.c b/util/dsa.c
index 5a2bf33651..f6224a27d4 100644
--- a/util/dsa.c
+++ b/util/dsa.c
@@ -802,7 +802,7 @@ buffer_zero_task_init_int(struct dsa_hw_desc *descriptor,
 }
 
 /**
- * @brief Initializes a buffer zero batch task.
+ * @brief Initializes a buffer zero DSA batch task.
  *
  * @param task A pointer to the batch task to initialize.
  * @param results A pointer to an array of zero page checking results.
@@ -1107,29 +1107,64 @@ void dsa_cleanup(void)
  * @return Zero if successful, otherwise non-zero.
  */
 int
-buffer_is_zero_dsa_batch_async(struct dsa_batch_task *batch_task,
+buffer_is_zero_dsa_batch_async(struct batch_task *batch_task,
                                const void **buf, size_t count, size_t len)
 {
-    if (count <= 0 || count > batch_task->batch_size) {
+    struct dsa_batch_task *dsa_batch = batch_task->dsa_batch;
+
+    if (count <= 0 || count > dsa_batch->batch_size) {
         return -1;
     }
 
-    assert(batch_task != NULL);
+    assert(dsa_batch != NULL);
     assert(len != 0);
     assert(buf != NULL);
 
     if (count == 1) {
         /* DSA doesn't take batch operation with only 1 task. */
-        buffer_zero_dsa_async(batch_task, buf[0], len);
+        buffer_zero_dsa_async(dsa_batch, buf[0], len);
     } else {
-        buffer_zero_dsa_batch_async(batch_task, buf, count, len);
+        buffer_zero_dsa_batch_async(dsa_batch, buf, count, len);
     }
 
-    buffer_zero_dsa_wait(batch_task);
-    buffer_zero_cpu_fallback(batch_task);
+    buffer_zero_dsa_wait(dsa_batch);
+    buffer_zero_cpu_fallback(dsa_batch);
 
     return 0;
 }
 
 #endif
 
+/**
+ * @brief Initializes a general buffer zero batch task.
+ *
+ * @param task A pointer to the general batch task to initialize.
+ * @param batch_size The number of zero page checking tasks in the batch.
+ */
+void
+batch_task_init(struct batch_task *task, int batch_size)
+{
+    task->addr = g_new0(ram_addr_t, batch_size);
+    task->results = g_new0(bool, batch_size);
+#ifdef CONFIG_DSA_OPT
+    task->dsa_batch = qemu_memalign(64, sizeof(struct dsa_batch_task));
+    buffer_zero_batch_task_init(task->dsa_batch, task->results, batch_size);
+#endif
+}
+
+/**
+ * @brief Destroys a general buffer zero batch task.
+ *
+ * @param task A pointer to the general batch task to destroy.
+ */
+void
+batch_task_destroy(struct batch_task *task)
+{
+    g_free(task->addr);
+    g_free(task->results);
+#ifdef CONFIG_DSA_OPT
+    buffer_zero_batch_task_destroy(task->dsa_batch);
+    qemu_vfree(task->dsa_batch);
+#endif
+}
+
-- 
2.30.2


