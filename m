Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD5D7A4B56
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 16:53:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiFSV-00035J-1c; Mon, 18 Sep 2023 10:42:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFSN-0002y8-E1
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:42:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFS2-0002ae-Oj
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:42:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695048131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CaZ0rOeVOeTdJlqiSpGYpItPgtwHBNWjsvsMWQtxwlc=;
 b=OqjzCntgOJ9ltpzVu4DYqMWa9Im/ELZflAMs4ocZJt9vGsBaU9EoZIPSmSui1fEgtGjd0r
 +5CuFJN4wsQ/+FyrXeU/jh+8coHvAfIECBTrf0AEPgJHTby/vce4adhJ7Wy1ls/3Sn11oc
 hQ44WujLYh6bT1j2RWHD1ar1337lbYQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-401-gznIVLpNM-mQudfpjTsaFQ-1; Mon, 18 Sep 2023 10:42:09 -0400
X-MC-Unique: gznIVLpNM-mQudfpjTsaFQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 41DF93800BA8
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 14:42:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1FDEF140E950
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 14:42:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 08F4A21E6912; Mon, 18 Sep 2023 16:42:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com,
	peterx@redhat.com,
	leobras@redhat.com
Subject: [PATCH 11/52] migration/rdma: Drop rdma_add_block() error handling
Date: Mon, 18 Sep 2023 16:41:25 +0200
Message-ID: <20230918144206.560120-12-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-1-armbru@redhat.com>
References: <20230918144206.560120-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

rdma_add_block() can't fail.  Return void, and drop the unreachable
error handling.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 migration/rdma.c | 30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 960fff5860..2b0f9d52d8 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -559,9 +559,9 @@ static inline uint8_t *ram_chunk_end(const RDMALocalBlock *rdma_ram_block,
     return result;
 }
 
-static int rdma_add_block(RDMAContext *rdma, const char *block_name,
-                         void *host_addr,
-                         ram_addr_t block_offset, uint64_t length)
+static void rdma_add_block(RDMAContext *rdma, const char *block_name,
+                           void *host_addr,
+                           ram_addr_t block_offset, uint64_t length)
 {
     RDMALocalBlocks *local = &rdma->local_ram_blocks;
     RDMALocalBlock *block;
@@ -615,8 +615,6 @@ static int rdma_add_block(RDMAContext *rdma, const char *block_name,
                          block->nb_chunks);
 
     local->nb_blocks++;
-
-    return 0;
 }
 
 /*
@@ -630,7 +628,8 @@ static int qemu_rdma_init_one_block(RAMBlock *rb, void *opaque)
     void *host_addr = qemu_ram_get_host_addr(rb);
     ram_addr_t block_offset = qemu_ram_get_offset(rb);
     ram_addr_t length = qemu_ram_get_used_length(rb);
-    return rdma_add_block(opaque, block_name, host_addr, block_offset, length);
+    rdma_add_block(opaque, block_name, host_addr, block_offset, length);
+    return 0;
 }
 
 /*
@@ -638,7 +637,7 @@ static int qemu_rdma_init_one_block(RAMBlock *rb, void *opaque)
  * identify chunk boundaries inside each RAMBlock and also be referenced
  * during dynamic page registration.
  */
-static int qemu_rdma_init_ram_blocks(RDMAContext *rdma)
+static void qemu_rdma_init_ram_blocks(RDMAContext *rdma)
 {
     RDMALocalBlocks *local = &rdma->local_ram_blocks;
     int ret;
@@ -646,14 +645,11 @@ static int qemu_rdma_init_ram_blocks(RDMAContext *rdma)
     assert(rdma->blockmap == NULL);
     memset(local, 0, sizeof *local);
     ret = foreach_not_ignored_block(qemu_rdma_init_one_block, rdma);
-    if (ret) {
-        return ret;
-    }
+    assert(!ret);
     trace_qemu_rdma_init_ram_blocks(local->nb_blocks);
     rdma->dest_blocks = g_new0(RDMADestBlock,
                                rdma->local_ram_blocks.nb_blocks);
     local->init = true;
-    return 0;
 }
 
 /*
@@ -2471,11 +2467,7 @@ static int qemu_rdma_source_init(RDMAContext *rdma, bool pin_all, Error **errp)
         goto err_rdma_source_init;
     }
 
-    ret = qemu_rdma_init_ram_blocks(rdma);
-    if (ret) {
-        ERROR(errp, "rdma migration: error initializing ram blocks!");
-        goto err_rdma_source_init;
-    }
+    qemu_rdma_init_ram_blocks(rdma);
 
     /* Build the hash that maps from offset to RAMBlock */
     rdma->blockmap = g_hash_table_new(g_direct_hash, g_direct_equal);
@@ -3430,11 +3422,7 @@ static int qemu_rdma_accept(RDMAContext *rdma)
         goto err_rdma_dest_wait;
     }
 
-    ret = qemu_rdma_init_ram_blocks(rdma);
-    if (ret) {
-        error_report("rdma migration: error initializing ram blocks!");
-        goto err_rdma_dest_wait;
-    }
+    qemu_rdma_init_ram_blocks(rdma);
 
     for (idx = 0; idx < RDMA_WRID_MAX; idx++) {
         ret = qemu_rdma_reg_control(rdma, idx);
-- 
2.41.0


