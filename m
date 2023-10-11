Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10AA27C4F31
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 11:38:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqVQg-0007IE-Kp; Wed, 11 Oct 2023 05:22:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVQZ-0007Ht-66
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:22:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVQX-0004vl-IR
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:22:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697016168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RCzyJUuVUv4iEgTIsyyPCJp3BtcSvAhBLFUDCawGIrI=;
 b=ccdsZEPc9Wwew5S9WM0cax6GGtFcnJMzTcvqGaIq6vtHV7wYb+66QFKeG2ZhQEYQLEAuxt
 XeK3zn0PYGwlOE3r4a/DvvclxQPlJ8wIXGowe6cbxGf8GT6Gesobwkw1kd1EfOfYRGoIxq
 C6aN7SSnM3lkbr1rMvLVpE6q5EPWopU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-134-dfhZUEj5OBeuZGOGgiQ9vw-1; Wed, 11 Oct 2023 05:22:45 -0400
X-MC-Unique: dfhZUEj5OBeuZGOGgiQ9vw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 417AE811E88;
 Wed, 11 Oct 2023 09:22:45 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 80FD11C060B1;
 Wed, 11 Oct 2023 09:22:43 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Leonardo Bras <leobras@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 19/65] migration/rdma: Drop rdma_add_block() error handling
Date: Wed, 11 Oct 2023 11:21:17 +0200
Message-ID: <20231011092203.1266-20-quintela@redhat.com>
In-Reply-To: <20231011092203.1266-1-quintela@redhat.com>
References: <20231011092203.1266-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
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

From: Markus Armbruster <armbru@redhat.com>

rdma_add_block() can't fail.  Return void, and drop the unreachable
error handling.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20230928132019.2544702-13-armbru@redhat.com>
---
 migration/rdma.c | 30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index c858d3fbe4..466725dbf0 100644
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
@@ -2491,11 +2487,7 @@ static int qemu_rdma_source_init(RDMAContext *rdma, bool pin_all, Error **errp)
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
@@ -3438,11 +3430,7 @@ static int qemu_rdma_accept(RDMAContext *rdma)
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


