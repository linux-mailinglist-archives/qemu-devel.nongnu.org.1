Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B4B7C4F41
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 11:39:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqVQp-0007Jf-LM; Wed, 11 Oct 2023 05:23:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVQe-0007Ib-6h
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:22:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVQc-0004wL-NA
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:22:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697016174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5QN3m4ddXULXb+g+LA4PT/6Hk4h/19ighlXHfJb6nAw=;
 b=JZ/f1Ak7XiqyyFHmPQdEZ5v1x/p0SYDeJ0oOjw8GQL3m+JaRbYaPFOlnl1ax5A1Oc1RJOh
 cD4y88KBjGQmfyhMm9ODZclw/J+FiPWO0SRJkrFgQbtssf7MRw2cUT1KvSEdcVPg09LnUX
 Kghhu9J1of3iJx1yqPNq7EYvLCV3l6w=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-505-0TPFmhYRPnCpTgKCowQt2A-1; Wed, 11 Oct 2023 05:22:49 -0400
X-MC-Unique: 0TPFmhYRPnCpTgKCowQt2A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3DA263814584;
 Wed, 11 Oct 2023 09:22:49 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8492D1C060AE;
 Wed, 11 Oct 2023 09:22:47 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Leonardo Bras <leobras@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 21/65] migration/rdma: Make qemu_rdma_buffer_mergeable() return
 bool
Date: Wed, 11 Oct 2023 11:21:19 +0200
Message-ID: <20231011092203.1266-22-quintela@redhat.com>
In-Reply-To: <20231011092203.1266-1-quintela@redhat.com>
References: <20231011092203.1266-1-quintela@redhat.com>
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

qemu_rdma_buffer_mergeable() is semantically a predicate.  It returns
int 0 or 1.  Return bool instead, and fix the function name's
spelling.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20230928132019.2544702-15-armbru@redhat.com>
---
 migration/rdma.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index b412dad542..2e62d2cd0a 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -2264,7 +2264,7 @@ static int qemu_rdma_write_flush(RDMAContext *rdma)
     return 0;
 }
 
-static inline int qemu_rdma_buffer_mergable(RDMAContext *rdma,
+static inline bool qemu_rdma_buffer_mergeable(RDMAContext *rdma,
                     uint64_t offset, uint64_t len)
 {
     RDMALocalBlock *block;
@@ -2272,11 +2272,11 @@ static inline int qemu_rdma_buffer_mergable(RDMAContext *rdma,
     uint8_t *chunk_end;
 
     if (rdma->current_index < 0) {
-        return 0;
+        return false;
     }
 
     if (rdma->current_chunk < 0) {
-        return 0;
+        return false;
     }
 
     block = &(rdma->local_ram_blocks.block[rdma->current_index]);
@@ -2284,29 +2284,29 @@ static inline int qemu_rdma_buffer_mergable(RDMAContext *rdma,
     chunk_end = ram_chunk_end(block, rdma->current_chunk);
 
     if (rdma->current_length == 0) {
-        return 0;
+        return false;
     }
 
     /*
      * Only merge into chunk sequentially.
      */
     if (offset != (rdma->current_addr + rdma->current_length)) {
-        return 0;
+        return false;
     }
 
     if (offset < block->offset) {
-        return 0;
+        return false;
     }
 
     if ((offset + len) > (block->offset + block->length)) {
-        return 0;
+        return false;
     }
 
     if ((host_addr + len) > chunk_end) {
-        return 0;
+        return false;
     }
 
-    return 1;
+    return true;
 }
 
 /*
@@ -2329,7 +2329,7 @@ static int qemu_rdma_write(RDMAContext *rdma,
     int ret;
 
     /* If we cannot merge it, we flush the current buffer first. */
-    if (!qemu_rdma_buffer_mergable(rdma, current_addr, len)) {
+    if (!qemu_rdma_buffer_mergeable(rdma, current_addr, len)) {
         ret = qemu_rdma_write_flush(rdma);
         if (ret) {
             return ret;
-- 
2.41.0


