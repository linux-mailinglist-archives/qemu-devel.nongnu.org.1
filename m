Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 101AF7EAA2B
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 06:42:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2mBi-0007HE-C9; Tue, 14 Nov 2023 00:42:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1r2mBS-0007F4-SU
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 00:41:58 -0500
Received: from mail-qk1-x729.google.com ([2607:f8b0:4864:20::729])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1r2mBQ-0001TZ-U6
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 00:41:58 -0500
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7789923612dso329310585a.0
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 21:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1699940516; x=1700545316; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xf50/lsBngLq8SDa+dxmzDJFoeEv3vJJjISvORIZOJw=;
 b=il9jFP5WljuvjHlGyxHhMnsAhn45prWOFew9U6rBqyXegdkXYdBeDy4U5MWbHQyYn+
 PtMMsnR1IOnbDqT25hBI4XHBr9G6cqexf18xyNjXoYusZ3oEfUCylxcMY0WkbIFmKodg
 Oc3ePt3z6wm4/RMfZG7vum8Yel4BOZ8PdYwKiYXNvsgeAt3A61pALqwMZuHIzOD68/i9
 ro0IDTlZ4lATFAU5czk+GhuxdW3Ww6FB2m67nCiw5BaFJJZxLOHCOh+aRCaQtHIrQQpE
 9K80KpjBQL4Jetv3Nwk1SHI0JI16x1OPauAhbxUzeIimh5NGBO4PJPO4XB9Ob75cYDZq
 Tr6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699940516; x=1700545316;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xf50/lsBngLq8SDa+dxmzDJFoeEv3vJJjISvORIZOJw=;
 b=B07B3V1eOBOogZAa/W4SnXg6tVkanGj2Xq9jTCv1E5jtYWnXfxvRTxIpnSp/nrtAcG
 o7MOmJ+KMzfHLW/ReCOTO+bB/L/987V/t3+BhUJiaFeS8RD2AJEyqVccRCt7NSOvsDAJ
 tAM3E9hix7OwtDcgapzC0+a8cq88i27xmP3o9wCwwo6N07YGQMtFKYjCB3GBrfV6OLq4
 z8iVGq9zZtNHpqagOnn2l06S9deSfCKSvVwualHtTMQ/vtJPlCxNiJn2avXIVA5xjsuh
 6GffLpwjs3NFaNlRf5Z6V1sT8ICOvJNJebOFZ4JihxYMitfxRu9DlTfKh734tu0eiAfs
 Zxog==
X-Gm-Message-State: AOJu0YzC72xPl1zXfV/1RXxcQShlxCIJEfwgyNAtfMYpAlOfIYP42fvz
 Q34ZorbEfU+h0Y0212ryREaMKQ==
X-Google-Smtp-Source: AGHT+IFlF2FtpMQCXLpcZW9q2WQtJxlo0IwOsUKekl368VZCdXaDvoTErHM8oNQvZCueO5T+M83ztQ==
X-Received: by 2002:a05:620a:4395:b0:77b:be50:9cbe with SMTP id
 a21-20020a05620a439500b0077bbe509cbemr1627558qkp.57.1699940515759; 
 Mon, 13 Nov 2023 21:41:55 -0800 (PST)
Received: from n231-230-216.byted.org ([130.44.212.104])
 by smtp.gmail.com with ESMTPSA id
 w2-20020a05620a094200b0077891d2d12dsm2400367qkw.43.2023.11.13.21.41.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 21:41:55 -0800 (PST)
From: Hao Xiang <hao.xiang@bytedance.com>
To: farosas@suse.de, peter.maydell@linaro.org, quintela@redhat.com,
 peterx@redhat.com, marcandre.lureau@redhat.com, bryan.zhang@bytedance.com,
 qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH v2 13/20] migration/multifd: Prepare to introduce DSA
 acceleration on the multifd path.
Date: Tue, 14 Nov 2023 05:40:25 +0000
Message-Id: <20231114054032.1192027-14-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231114054032.1192027-1-hao.xiang@bytedance.com>
References: <20231114054032.1192027-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::729;
 envelope-from=hao.xiang@bytedance.com; helo=mail-qk1-x729.google.com
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
 migration/multifd.c | 82 ++++++++++++++++++++++++++++++++++++---------
 migration/multifd.h |  3 ++
 2 files changed, 70 insertions(+), 15 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 1198ffde9c..68ab97f918 100644
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
@@ -574,6 +576,11 @@ void multifd_save_cleanup(void)
         p->name = NULL;
         multifd_pages_clear(p->pages);
         p->pages = NULL;
+        g_free(p->addr);
+        p->addr = NULL;
+        buffer_zero_batch_task_destroy(p->batch_task);
+        qemu_vfree(p->batch_task);
+        p->batch_task = NULL;
         p->packet_len = 0;
         g_free(p->packet);
         p->packet = NULL;
@@ -678,13 +685,66 @@ int multifd_send_sync_main(QEMUFile *f)
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
+    const void **buf = (const void **)p->addr;
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
+        p->addr[i] = (ram_addr_t)(rb->host + p->pages->offset[i]);
+    }
+
+    if (use_multifd_zero_page) {
+        buffer_is_zero_use_cpu(p);
+    } else {
+        // No zero page checking. All pages are normal pages.
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
 
@@ -710,7 +770,6 @@ static void *multifd_send_thread(void *opaque)
         qemu_mutex_lock(&p->mutex);
 
         if (p->pending_job) {
-            RAMBlock *rb = p->pages->block;
             uint64_t packet_num = p->packet_num;
             uint32_t flags;
 
@@ -723,18 +782,7 @@ static void *multifd_send_thread(void *opaque)
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
@@ -976,6 +1024,10 @@ int multifd_save_setup(Error **errp)
         p->pending_job = 0;
         p->id = i;
         p->pages = multifd_pages_init(page_count);
+        p->addr = g_new0(ram_addr_t, page_count);
+        p->batch_task =
+            (struct buffer_zero_batch_task *)qemu_memalign(64, sizeof(*p->batch_task));
+        buffer_zero_batch_task_init(p->batch_task, page_count);
         p->packet_len = sizeof(MultiFDPacket_t)
                       + sizeof(uint64_t) * page_count;
         p->packet = g_malloc0(p->packet_len);
diff --git a/migration/multifd.h b/migration/multifd.h
index 13762900d4..62f31b03c0 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -119,6 +119,9 @@ typedef struct {
      * pending_job != 0 -> multifd_channel can use it.
      */
     MultiFDPages_t *pages;
+    /* Address of each pages in pages */
+    ram_addr_t *addr;
+    struct buffer_zero_batch_task *batch_task;
 
     /* thread local variables. No locking required */
 
-- 
2.30.2


