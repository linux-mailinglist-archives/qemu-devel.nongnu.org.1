Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9B47DC908
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 10:07:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxkdv-0000KF-Bd; Tue, 31 Oct 2023 05:02:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxkdp-00007r-3u
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 05:02:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxkdm-0006sb-G5
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 05:02:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698742945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kNC+yhxdlGzjH/kuVa1H0qDLD4e1tNF8NnwPKMQwLmo=;
 b=TA69bXKcgHji4T28UMUBX1yWokylCPFVOtjoUjrd7MFIKkhSy2Z0Lfh4B60MWpMiYxef/Y
 nrzWFITJeRWAL+ToJ0dUqF8i8R9TvefAo0pcLN8+0mhiccpUIz7fH/8IrtAZ45VkytJEaf
 qdDAXhGB5YBCkM8D/jtCreKVEVLtGQI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-55-Co5VoTzzMeanaWxsz-VF-Q-1; Tue,
 31 Oct 2023 05:02:12 -0400
X-MC-Unique: Co5VoTzzMeanaWxsz-VF-Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 998DB29AB3EA;
 Tue, 31 Oct 2023 09:02:11 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3A0AA1C060AE;
 Tue, 31 Oct 2023 09:02:09 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, libvir-list@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>, qemu-block@nongnu.org,
 Fabiano Rosas <farosas@suse.de>
Subject: [PULL 09/38] migration: Remove save_page_use_compression()
Date: Tue, 31 Oct 2023 10:01:13 +0100
Message-ID: <20231031090142.13122-10-quintela@redhat.com>
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

After previous patch, we disable the posiblity that we use compression
together with xbzrle.  So we can use directly migrate_compress().

Once there, now we don't need the rs parameter, so remove it.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20231019110724.15324-4-quintela@redhat.com>
---
 migration/ram.c | 34 +++++++---------------------------
 1 file changed, 7 insertions(+), 27 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index e0ad732ee8..8246663f64 100644
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


