Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CABEA72E66F
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 16:59:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q95TU-0006Bm-M3; Tue, 13 Jun 2023 10:58:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q95TJ-00069V-2O
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 10:58:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q95TH-0007XT-ER
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 10:58:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686668289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C6yxy1+QPusVaX/KeEp2OOi+RCNSn5LXBnmxFqvZF/g=;
 b=c0758YnxgiXsTAMkQ0qB8deV9gQtkmt/W+8CkXKMXN6CGsA9ZsVP/qxXjQqVZ4e4/5J/Ai
 N+jmqVVrGuyR7FUJlU1PL302DbpNcas06+JypVPTJcISLsFS3bJmtOlvKICj5FMaT0y40I
 PqtVLmqGODry7MU4suda+MKxTaZWybY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-67-WwSCVexKOlCVSeZmOdTiig-1; Tue, 13 Jun 2023 10:58:07 -0400
X-MC-Unique: WwSCVexKOlCVSeZmOdTiig-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A4E448030D3;
 Tue, 13 Jun 2023 14:58:04 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9537A40C6F5C;
 Tue, 13 Jun 2023 14:58:03 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Juan Quintela <quintela@redhat.com>
Subject: [PATCH 04/18] migration: Remove save_page_use_compression()
Date: Tue, 13 Jun 2023 16:57:43 +0200
Message-Id: <20230613145757.10131-5-quintela@redhat.com>
In-Reply-To: <20230613145757.10131-1-quintela@redhat.com>
References: <20230613145757.10131-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

After previous patch, we disable the posiblity that we use compression
together with xbzrle.  So we can use directly migrate_compress().

Once there, now we don't need the rs parameter, so remove it.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 34 +++++++---------------------------
 1 file changed, 7 insertions(+), 27 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 88a6c82e63..d4943b982f 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1274,8 +1274,6 @@ update_compress_thread_counts(const CompressParam *param, int bytes_xmit)
     compression_counters.pages++;
 }
 
-static bool save_page_use_compression(RAMState *rs);
-
 static int send_queued_data(CompressParam *param)
 {
     PageSearchStatus *pss = &ram_state->pss[RAM_CHANNEL_PRECOPY];
@@ -1312,9 +1310,9 @@ static int send_queued_data(CompressParam *param)
     return len;
 }
 
-static void ram_flush_compressed_data(RAMState *rs)
+static void ram_flush_compressed_data(void)
 {
-    if (!save_page_use_compression(rs)) {
+    if (!migrate_compress()) {
         return;
     }
 
@@ -1375,7 +1373,7 @@ static int find_dirty_block(RAMState *rs, PageSearchStatus *pss)
              * Also If xbzrle is on, stop using the data compression at this
              * point. In theory, xbzrle can do better than compression.
              */
-            ram_flush_compressed_data(rs);
+            ram_flush_compressed_data();
 
             /* Hit the end of the list */
             pss->block = QLIST_FIRST_RCU(&ram_list.blocks);
@@ -2024,24 +2022,6 @@ int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len)
     return 0;
 }
 
-static bool save_page_use_compression(RAMState *rs)
-{
-    if (!migrate_compress()) {
-        return false;
-    }
-
-    /*
-     * If xbzrle is enabled (e.g., after first round of migration), stop
-     * using the data compression. In theory, xbzrle can do better than
-     * compression.
-     */
-    if (rs->xbzrle_started) {
-        return false;
-    }
-
-    return true;
-}
-
 /*
  * try to compress the page before posting it out, return true if the page
  * has been properly handled by compression, otherwise needs other
@@ -2050,7 +2030,7 @@ static bool save_page_use_compression(RAMState *rs)
 static bool save_compress_page(RAMState *rs, PageSearchStatus *pss,
                                RAMBlock *block, ram_addr_t offset)
 {
-    if (!save_page_use_compression(rs)) {
+    if (!migrate_compress()) {
         return false;
     }
 
@@ -2065,7 +2045,7 @@ static bool save_compress_page(RAMState *rs, PageSearchStatus *pss,
      * much CPU resource.
      */
     if (block != pss->last_sent_block) {
-        ram_flush_compressed_data(rs);
+        ram_flush_compressed_data();
         return false;
     }
 
@@ -3115,7 +3095,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
              * page is sent in one chunk.
              */
             if (migrate_postcopy_ram()) {
-                ram_flush_compressed_data(rs);
+                ram_flush_compressed_data();
             }
 
             /*
@@ -3210,7 +3190,7 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
         }
         qemu_mutex_unlock(&rs->bitmap_mutex);
 
-        ram_flush_compressed_data(rs);
+        ram_flush_compressed_data();
         ram_control_after_iterate(f, RAM_CONTROL_FINISH);
     }
 
-- 
2.40.1


