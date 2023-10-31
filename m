Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 922517DC917
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 10:08:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxkdo-0008TJ-UN; Tue, 31 Oct 2023 05:02:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxkdl-0008EN-4k
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 05:02:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxkdi-0006sC-U6
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 05:02:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698742942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FD/xrtx5Ex3UkXu99HPCWJPi/sgl1QuP9uITLor6Oos=;
 b=Zk19yZEjBaQ1qEhS/wqbf0eGKuSCf55NVtYLX+Yyof9bUV2fXPJfL8u57sndlp/zcSpkzs
 pCKnc1a9GUYqR3Uyb7qnbUk+7Q/d+AnW1fuOlRZ08mGNinV1H8qtPjWq0miFZaVbotOtRl
 34PaqzkF/jFa9k1Lxa9pZiHPPf/5c9I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-58hp-CY1N3a9YPu57ENTng-1; Tue, 31 Oct 2023 05:02:15 -0400
X-MC-Unique: 58hp-CY1N3a9YPu57ENTng-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8141485A58B;
 Tue, 31 Oct 2023 09:02:14 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E13B31C060AE;
 Tue, 31 Oct 2023 09:02:11 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, libvir-list@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>, qemu-block@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Lukas Straub <lukasstraub2@web.de>
Subject: [PULL 10/38] migration: Make compress_data_with_multithreads return
 bool
Date: Tue, 31 Oct 2023 10:01:14 +0100
Message-ID: <20231031090142.13122-11-quintela@redhat.com>
In-Reply-To: <20231031090142.13122-1-quintela@redhat.com>
References: <20231031090142.13122-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
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

Reviewed-by: Lukas Straub <lukasstraub2@web.de>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20231019110724.15324-5-quintela@redhat.com>
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
index 8246663f64..63a575ae90 100644
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


