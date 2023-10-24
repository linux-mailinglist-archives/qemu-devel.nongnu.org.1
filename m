Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 454F07D5181
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 15:21:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvHFE-0005N0-E7; Tue, 24 Oct 2023 09:14:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvHEq-000533-1L
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 09:14:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvHEn-0001C2-2L
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 09:14:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698153264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kNC+yhxdlGzjH/kuVa1H0qDLD4e1tNF8NnwPKMQwLmo=;
 b=jR0YATtQEurjpdEqt6zHYQks88Yp8xLYda5PFNyQpNzqkJ4XcUn9yduWO288T7WFvch+YT
 6XA9n4Sw/PfBBH9AcR/HYs4p3rVK+0G7arDrocESd6sG/MkuWcmP4NqcmskArC4bW20xId
 pGvDR1ROslXdvhr3QJJIIfDXNzxuI7w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-qs7AU8bWPk6w1TA8VVALbw-1; Tue, 24 Oct 2023 09:14:19 -0400
X-MC-Unique: qs7AU8bWPk6w1TA8VVALbw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7D1A3857CFA;
 Tue, 24 Oct 2023 13:14:14 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2AE101C060AE;
 Tue, 24 Oct 2023 13:14:08 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Corey Minyard <minyard@acm.org>, Li Zhijian <lizhijian@fujitsu.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Hanna Reitz <hreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Corey Minyard <cminyard@mvista.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Kevin Wolf <kwolf@redhat.com>, qemu-s390x@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 libvir-list@redhat.com, Stefan Weil <sw@weilnetz.de>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Fam Zheng <fam@euphon.net>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Eric Farman <farman@linux.ibm.com>, Juan Quintela <quintela@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-ppc@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org
Subject: [PULL 09/39] migration: Remove save_page_use_compression()
Date: Tue, 24 Oct 2023 15:12:35 +0200
Message-ID: <20231024131305.87468-10-quintela@redhat.com>
In-Reply-To: <20231024131305.87468-1-quintela@redhat.com>
References: <20231024131305.87468-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


