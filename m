Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 607957CF641
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 13:10:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtQsq-0001vK-8O; Thu, 19 Oct 2023 07:08:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtQsY-0001ky-DK
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 07:07:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtQsW-0000gT-CZ
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 07:07:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697713667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1S0MdEPDopjZwdIjA/scTxF1B0hg8WBNV2ShFi+1GsU=;
 b=DzdCZPodi7q9sWV2w0pe579a4jM3jGYZDjTpv/1PBEOtesCdFdKO8+dCxidVLNroxSQ79Z
 MEoImKohKd4HNWyYWR2h1GdvYTpRWtoE1gi7RAFSPbWmmmj6NF5gPPgUiSBAUTo/oYsmOY
 HyrQei0Q6dORIoOTzAtKfpBU7mo7CeA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-660-jkJGzg5tOieOIQYyT6e_-g-1; Thu, 19 Oct 2023 07:07:38 -0400
X-MC-Unique: jkJGzg5tOieOIQYyT6e_-g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 605713C0F44F;
 Thu, 19 Oct 2023 11:07:38 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7EEE38BE;
 Thu, 19 Oct 2023 11:07:37 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>
Subject: [PATCH v2 09/11] migration: Move ram_flush_compressed_data() to
 ram-compress.c
Date: Thu, 19 Oct 2023 13:07:22 +0200
Message-ID: <20231019110724.15324-10-quintela@redhat.com>
In-Reply-To: <20231019110724.15324-1-quintela@redhat.com>
References: <20231019110724.15324-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

As we export it, rename it compress_flush_data().

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram-compress.h |  1 +
 migration/ram-compress.c |  9 +++++++++
 migration/ram.c          | 17 ++++-------------
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/migration/ram-compress.h b/migration/ram-compress.h
index 636281ed97..7ba01e2882 100644
--- a/migration/ram-compress.h
+++ b/migration/ram-compress.h
@@ -73,5 +73,6 @@ uint64_t ram_compressed_pages(void);
 void update_compress_thread_counts(const CompressParam *param, int bytes_xmit);
 void compress_update_rates(uint64_t page_count);
 int compress_send_queued_data(CompressParam *param);
+void compress_flush_data(void);
 
 #endif
diff --git a/migration/ram-compress.c b/migration/ram-compress.c
index af42cab0fe..1443a1cb45 100644
--- a/migration/ram-compress.c
+++ b/migration/ram-compress.c
@@ -558,3 +558,12 @@ void compress_update_rates(uint64_t page_count)
             compression_counters.compressed_size;
     }
 }
+
+void compress_flush_data(void)
+{
+    if (!migrate_compress()) {
+        return;
+    }
+
+    flush_compressed_data(compress_send_queued_data);
+}
diff --git a/migration/ram.c b/migration/ram.c
index d8b38ed999..4a07406c9a 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1300,15 +1300,6 @@ int compress_send_queued_data(CompressParam *param)
     return len;
 }
 
-static void ram_flush_compressed_data(void)
-{
-    if (!migrate_compress()) {
-        return;
-    }
-
-    flush_compressed_data(compress_send_queued_data);
-}
-
 #define PAGE_ALL_CLEAN 0
 #define PAGE_TRY_AGAIN 1
 #define PAGE_DIRTY_FOUND 2
@@ -1364,7 +1355,7 @@ static int find_dirty_block(RAMState *rs, PageSearchStatus *pss)
              * Also If xbzrle is on, stop using the data compression at this
              * point. In theory, xbzrle can do better than compression.
              */
-            ram_flush_compressed_data();
+            compress_flush_data();
 
             /* Hit the end of the list */
             pss->block = QLIST_FIRST_RCU(&ram_list.blocks);
@@ -2036,7 +2027,7 @@ static bool save_compress_page(RAMState *rs, PageSearchStatus *pss,
      * much CPU resource.
      */
     if (pss->block != pss->last_sent_block) {
-        ram_flush_compressed_data();
+        compress_flush_data();
         return false;
     }
 
@@ -3083,7 +3074,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
              * page is sent in one chunk.
              */
             if (migrate_postcopy_ram()) {
-                ram_flush_compressed_data();
+                compress_flush_data();
             }
 
             /*
@@ -3184,7 +3175,7 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
         }
         qemu_mutex_unlock(&rs->bitmap_mutex);
 
-        ram_flush_compressed_data();
+        compress_flush_data();
 
         int ret = rdma_registration_stop(f, RAM_CONTROL_FINISH);
         if (ret < 0) {
-- 
2.41.0


