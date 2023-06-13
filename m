Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E2372E695
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 17:04:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q95TX-0006EY-9l; Tue, 13 Jun 2023 10:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q95TP-0006AV-B9
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 10:58:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q95TL-0007YQ-Dv
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 10:58:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686668294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c767jYGipjzdAjfPD7K5FSit3BxPU+40ApOONyr+N+Y=;
 b=feovnpNrdz1yR+e9lifWjLAndeQoOCJO3HW982QSwC2mXC/BxCCPoMqS9xMOS4aR1Ze/U3
 BxEdnSXeVmC+OCcSPk5y8nL0Wb6s1DYxULjx5U8+OYogityoLmh3dghwiTdyWcmg7C9eZF
 4j7Qm+bAM/WtjTlpGEbSY01jI71fw4g=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-90-ylHaB08LPiu1wT6mDZpJ6A-1; Tue, 13 Jun 2023 10:58:13 -0400
X-MC-Unique: ylHaB08LPiu1wT6mDZpJ6A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D73E93C11CD3;
 Tue, 13 Jun 2023 14:58:10 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EA3E040C6CD7;
 Tue, 13 Jun 2023 14:58:09 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Juan Quintela <quintela@redhat.com>
Subject: [PATCH 09/18] migration: Make compress_data_with_multithreads return
 bool
Date: Tue, 13 Jun 2023 16:57:48 +0200
Message-Id: <20230613145757.10131-10-quintela@redhat.com>
In-Reply-To: <20230613145757.10131-1-quintela@redhat.com>
References: <20230613145757.10131-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram-compress.h |  4 ++--
 migration/ram-compress.c | 17 ++++++++++-------
 migration/ram.c          |  2 +-
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/migration/ram-compress.h b/migration/ram-compress.h
index e55d3b50bd..b228640092 100644
--- a/migration/ram-compress.h
+++ b/migration/ram-compress.h
@@ -60,8 +60,8 @@ void compress_threads_save_cleanup(void);
 int compress_threads_save_setup(void);
 
 void flush_compressed_data(int (send_queued_data(CompressParam *)));
-int compress_page_with_multi_thread(RAMBlock *block, ram_addr_t offset,
-                                int (send_queued_data(CompressParam *)));
+bool compress_page_with_multi_thread(RAMBlock *block, ram_addr_t offset,
+                                      int (send_queued_data(CompressParam *)));
 
 int wait_for_decompress_done(void);
 void compress_threads_load_cleanup(void);
diff --git a/migration/ram-compress.c b/migration/ram-compress.c
index 47b600d62b..8ce9519f3d 100644
--- a/migration/ram-compress.c
+++ b/migration/ram-compress.c
@@ -262,10 +262,13 @@ static inline void set_compress_params(CompressParam *param, RAMBlock *block,
     param->trigger = true;
 }
 
-int compress_page_with_multi_thread(RAMBlock *block, ram_addr_t offset,
-                                int (send_queued_data(CompressParam *)))
+/*
+ * Return true when it compress a page
+ */
+bool compress_page_with_multi_thread(RAMBlock *block, ram_addr_t offset,
+                                     int (send_queued_data(CompressParam *)))
 {
-    int idx, thread_count, pages = -1;
+    int idx, thread_count;
     bool wait = migrate_compress_wait_thread();
 
     thread_count = migrate_compress_threads();
@@ -283,8 +286,8 @@ retry:
 
             qemu_cond_signal(&param->cond);
             qemu_mutex_unlock(&param->mutex);
-            pages = 1;
-            break;
+            qemu_mutex_unlock(&comp_done_lock);
+            return true;
         }
     }
 
@@ -292,13 +295,13 @@ retry:
      * wait for the free thread if the user specifies 'compress-wait-thread',
      * otherwise we will post the page out in the main thread as normal page.
      */
-    if (pages < 0 && wait) {
+    if (wait) {
         qemu_cond_wait(&comp_done_cond, &comp_done_lock);
         goto retry;
     }
     qemu_mutex_unlock(&comp_done_lock);
 
-    return pages;
+    return false;
 }
 
 /* return the size after decompression, or negative value on error */
diff --git a/migration/ram.c b/migration/ram.c
index 53dec4d305..2a3ff2c36e 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2034,7 +2034,7 @@ static bool save_compress_page(RAMState *rs, PageSearchStatus *pss,
         return false;
     }
 
-    if (compress_page_with_multi_thread(block, offset, send_queued_data) > 0) {
+    if (compress_page_with_multi_thread(block, offset, send_queued_data)) {
         return true;
     }
 
-- 
2.40.1


