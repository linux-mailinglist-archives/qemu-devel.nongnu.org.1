Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA157A4B3E
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 16:49:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiFSA-0002t0-Sk; Mon, 18 Sep 2023 10:42:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFS2-0002ri-QI
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:42:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFS0-0002Zx-3U
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:42:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695048130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pepCr2yk+wfEvOitliZG/utwoxvVW0Go0qMMH0tFqHs=;
 b=PTKs30mnn1bf43Mbor1fW4DxK+CGxpP73Zbq6pgRCagdOUlGIw2nzpnC3l4PZ3QSQMz+VO
 Vp/BQLSu4VikMjlZXNh2K+P48qcdpoAbUWtbPJhUnhxh0PXxK2SX9R8E+p4wWrTgJ9vSFb
 Kr7bQe7n1bO/OyxEbVig9TNX/C9krZ4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-92-xBQ85uWbO42x-xnY-qcHOQ-1; Mon, 18 Sep 2023 10:42:09 -0400
X-MC-Unique: xBQ85uWbO42x-xnY-qcHOQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4A93F855310
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 14:42:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2892C20268CC
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 14:42:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0BE2521E6913; Mon, 18 Sep 2023 16:42:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com,
	peterx@redhat.com,
	leobras@redhat.com
Subject: [PATCH 12/52] migration/rdma: Drop qemu_rdma_search_ram_block() error
 handling
Date: Mon, 18 Sep 2023 16:41:26 +0200
Message-ID: <20230918144206.560120-13-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-1-armbru@redhat.com>
References: <20230918144206.560120-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

qemu_rdma_search_ram_block() can't fail.  Return void, and drop the
unreachable error handling.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 migration/rdma.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 2b0f9d52d8..98520a42b4 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -1234,12 +1234,12 @@ static int qemu_rdma_reg_whole_ram_blocks(RDMAContext *rdma)
  *
  * This search cannot fail or the migration will fail.
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
@@ -1251,8 +1251,6 @@ static int qemu_rdma_search_ram_block(RDMAContext *rdma,
     *block_index = block->index;
     *chunk_index = ram_chunk_index(block->local_host_addr,
                 block->local_host_addr + (current_addr - block->offset));
-
-    return 0;
 }
 
 /*
@@ -2321,12 +2319,8 @@ static int qemu_rdma_write(QEMUFile *f, RDMAContext *rdma,
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


