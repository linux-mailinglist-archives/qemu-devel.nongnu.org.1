Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7BE7CF648
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 13:11:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtQsf-0001v3-3g; Thu, 19 Oct 2023 07:07:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtQsc-0001sD-73
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 07:07:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtQsa-0000iN-KW
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 07:07:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697713671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NtlaEy+a5gWfE0TGKB2llmczW7hoEesHFsw/QDYHiY4=;
 b=KuDpV9u3bEfQMBxoIXd71YPCoKheuh7NFLDUVRrcSc1WrgNffDqf8W2ZXn2HFagRCPN9QO
 p3mETtgvSV9g9JfGfFDtkEHbyyGQhsgk4L4MOpYTB/Ce91LC8xUXsF85vFvJ8vyxaHb1ht
 uITngx/fcgin+G5A3sfU/hgSrXgxkTk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-101-Xi0H6dUHOiiTmNIDYYrxbg-1; Thu, 19 Oct 2023 07:07:32 -0400
X-MC-Unique: Xi0H6dUHOiiTmNIDYYrxbg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 430571C06510;
 Thu, 19 Oct 2023 11:07:32 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 281BA25C8;
 Thu, 19 Oct 2023 11:07:31 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>
Subject: [PATCH v2 04/11] migration: Make compress_data_with_multithreads
 return bool
Date: Thu, 19 Oct 2023 13:07:17 +0200
Message-ID: <20231019110724.15324-5-quintela@redhat.com>
In-Reply-To: <20231019110724.15324-1-quintela@redhat.com>
References: <20231019110724.15324-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reviewed-by: Lukas Straub <lukasstraub2@web.de>
---
 migration/ram-compress.h |  4 ++--
 migration/ram-compress.c | 17 ++++++++++-------
 migration/ram.c          |  3 +--
 3 files changed, 13 insertions(+), 11 deletions(-)

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
index d037dfe6cf..ef03d60a6d 100644
--- a/migration/ram-compress.c
+++ b/migration/ram-compress.c
@@ -260,10 +260,13 @@ static inline void set_compress_params(CompressParam *param, RAMBlock *block,
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
-    int  thread_count, pages = -1;
+    int thread_count;
     bool wait = migrate_compress_wait_thread();
 
     thread_count = migrate_compress_threads();
@@ -281,8 +284,8 @@ retry:
 
             qemu_cond_signal(&param->cond);
             qemu_mutex_unlock(&param->mutex);
-            pages = 1;
-            break;
+            qemu_mutex_unlock(&comp_done_lock);
+            return true;
         }
     }
 
@@ -290,13 +293,13 @@ retry:
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
index 42b704ac40..de7878c46e 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2067,8 +2067,7 @@ static bool save_compress_page(RAMState *rs, PageSearchStatus *pss,
         return false;
     }
 
-    if (compress_page_with_multi_thread(pss->block, offset,
-                                        send_queued_data) > 0) {
+    if (compress_page_with_multi_thread(pss->block, offset, send_queued_data)) {
         return true;
     }
 
-- 
2.41.0


