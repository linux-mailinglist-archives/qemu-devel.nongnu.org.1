Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7647C4E76
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 11:23:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqVQk-0007JD-Fj; Wed, 11 Oct 2023 05:23:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVQc-0007IN-1a
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:22:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVQa-0004vv-BL
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:22:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697016170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q0yXgpPfuJGMOTx7JfJEcpROD9f0qrRSu787II4EblM=;
 b=Y6dISzGNGbA5KGkMlUWWlbnCEzIYHSBAVxnLM/mfz7/CLeksUgYupqDbY6b9tJUHzMY6jr
 Kgtzq90+Iy5wF8cNerW2QFr0nT8bGoUWiS2hibYKChF0w0ZaXy2jBNWC2meGEay+3q2UL1
 9PSaPCsp1w442VdUlY0phA+8FDN0n+c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-654-3_DjlNEEODmO3-iPWzcPbg-1; Wed, 11 Oct 2023 05:22:47 -0400
X-MC-Unique: 3_DjlNEEODmO3-iPWzcPbg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4042985A5BD;
 Wed, 11 Oct 2023 09:22:47 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 867E51C060AE;
 Wed, 11 Oct 2023 09:22:45 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Leonardo Bras <leobras@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 20/65] migration/rdma: Drop qemu_rdma_search_ram_block() error
 handling
Date: Wed, 11 Oct 2023 11:21:18 +0200
Message-ID: <20231011092203.1266-21-quintela@redhat.com>
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

qemu_rdma_search_ram_block() can't fail.  Return void, and drop the
unreachable error handling.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20230928132019.2544702-14-armbru@redhat.com>
---
 migration/rdma.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 466725dbf0..b412dad542 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -1231,15 +1231,13 @@ static int qemu_rdma_reg_whole_ram_blocks(RDMAContext *rdma)
  *
  * Once the block is found, also identify which 'chunk' within that
  * block that the page belongs to.
- *
- * This search cannot fail or the migration will fail.
  */
-static int qemu_rdma_search_ram_block(RDMAContext *rdma,
-                                      uintptr_t block_offset,
-                                      uint64_t offset,
-                                      uint64_t length,
-                                      uint64_t *block_index,
-                                      uint64_t *chunk_index)
+static void qemu_rdma_search_ram_block(RDMAContext *rdma,
+                                       uintptr_t block_offset,
+                                       uint64_t offset,
+                                       uint64_t length,
+                                       uint64_t *block_index,
+                                       uint64_t *chunk_index)
 {
     uint64_t current_addr = block_offset + offset;
     RDMALocalBlock *block = g_hash_table_lookup(rdma->blockmap,
@@ -1251,8 +1249,6 @@ static int qemu_rdma_search_ram_block(RDMAContext *rdma,
     *block_index = block->index;
     *chunk_index = ram_chunk_index(block->local_host_addr,
                 block->local_host_addr + (current_addr - block->offset));
-
-    return 0;
 }
 
 /*
@@ -2341,12 +2337,8 @@ static int qemu_rdma_write(RDMAContext *rdma,
         rdma->current_length = 0;
         rdma->current_addr = current_addr;
 
-        ret = qemu_rdma_search_ram_block(rdma, block_offset,
-                                         offset, len, &index, &chunk);
-        if (ret) {
-            error_report("ram block search failed");
-            return ret;
-        }
+        qemu_rdma_search_ram_block(rdma, block_offset,
+                                   offset, len, &index, &chunk);
         rdma->current_index = index;
         rdma->current_chunk = chunk;
     }
-- 
2.41.0


