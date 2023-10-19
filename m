Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C8B7CF64A
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 13:11:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtQsd-0001oQ-9b; Thu, 19 Oct 2023 07:07:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtQsO-0001TX-Qn
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 07:07:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtQsJ-0000e5-1X
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 07:07:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697713652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=99Xo9O3yZngmIzx0R6UKHpA7F+L8C7a6yZ1nNGOIyMo=;
 b=KXdSJS2sNcUYWhpgpsnJKfGX7yjw4anK2a7NzEsKuVT51Z91mMuRgJqx+jk6vU2d9mHROO
 oGQrpZy2IYbWLBM2DnyazwH9uvFljy9D9YnnEWZYxvVhYZU1oZmQYZVwEZKwTUJuZ/ZcNb
 loR1dTOoQi9UvOaNSoH1r6ZLh2O6OzY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-522-_tRzXdtOO6y5O-lS8WPtlA-1; Thu, 19 Oct 2023 07:07:31 -0400
X-MC-Unique: _tRzXdtOO6y5O-lS8WPtlA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DCB6E1C06521;
 Thu, 19 Oct 2023 11:07:30 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0536525C8;
 Thu, 19 Oct 2023 11:07:29 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>
Subject: [PATCH v2 03/11] migration: Remove save_page_use_compression()
Date: Thu, 19 Oct 2023 13:07:16 +0200
Message-ID: <20231019110724.15324-4-quintela@redhat.com>
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

After previous patch, we disable the posiblity that we use compression
together with xbzrle.  So we can use directly migrate_compress().

Once there, now we don't need the rs parameter, so remove it.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 34 +++++++---------------------------
 1 file changed, 7 insertions(+), 27 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 16c30a9d7a..42b704ac40 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1291,8 +1291,6 @@ static int ram_save_multifd_page(QEMUFile *file, RAMBlock *block,
     return 1;
 }
 
-static bool save_page_use_compression(RAMState *rs);
-
 static int send_queued_data(CompressParam *param)
 {
     PageSearchStatus *pss = &ram_state->pss[RAM_CHANNEL_PRECOPY];
@@ -1329,9 +1327,9 @@ static int send_queued_data(CompressParam *param)
     return len;
 }
 
-static void ram_flush_compressed_data(RAMState *rs)
+static void ram_flush_compressed_data(void)
 {
-    if (!save_page_use_compression(rs)) {
+    if (!migrate_compress()) {
         return;
     }
 
@@ -1393,7 +1391,7 @@ static int find_dirty_block(RAMState *rs, PageSearchStatus *pss)
              * Also If xbzrle is on, stop using the data compression at this
              * point. In theory, xbzrle can do better than compression.
              */
-            ram_flush_compressed_data(rs);
+            ram_flush_compressed_data();
 
             /* Hit the end of the list */
             pss->block = QLIST_FIRST_RCU(&ram_list.blocks);
@@ -2042,24 +2040,6 @@ int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len)
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
@@ -2068,7 +2048,7 @@ static bool save_page_use_compression(RAMState *rs)
 static bool save_compress_page(RAMState *rs, PageSearchStatus *pss,
                                ram_addr_t offset)
 {
-    if (!save_page_use_compression(rs)) {
+    if (!migrate_compress()) {
         return false;
     }
 
@@ -2083,7 +2063,7 @@ static bool save_compress_page(RAMState *rs, PageSearchStatus *pss,
      * much CPU resource.
      */
     if (pss->block != pss->last_sent_block) {
-        ram_flush_compressed_data(rs);
+        ram_flush_compressed_data();
         return false;
     }
 
@@ -3135,7 +3115,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
              * page is sent in one chunk.
              */
             if (migrate_postcopy_ram()) {
-                ram_flush_compressed_data(rs);
+                ram_flush_compressed_data();
             }
 
             /*
@@ -3236,7 +3216,7 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
         }
         qemu_mutex_unlock(&rs->bitmap_mutex);
 
-        ram_flush_compressed_data(rs);
+        ram_flush_compressed_data();
 
         int ret = rdma_registration_stop(f, RAM_CONTROL_FINISH);
         if (ret < 0) {
-- 
2.41.0


