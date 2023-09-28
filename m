Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 493D57B1E2F
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 15:25:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlqwu-0003k4-52; Thu, 28 Sep 2023 09:21:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlqwW-0003W4-7R
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:20:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlqwM-0008Bf-Rn
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:20:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695907226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FEnX5LSTQ17/Hg9gfdq1/pjzHw7sZILu+IYLdvjzMO8=;
 b=f29JgvwpYsncjmze3UUCsTZGSg3pok5o0sCxw1Vvfw7AVHCPNAMkdIjfBMfarqGWpGWrOv
 CjdCeeNoY2HeWmy5EsKs5sJ4u1KWA05M798J7L6AZiYOSebA2n3EykefRSo9njFZmNwKxp
 u6OnQjCV/ZVddcEDQ175dXcU1eLMlHw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-483-pFVWDaoYMzKMdD7Nsc8Z7g-1; Thu, 28 Sep 2023 09:20:22 -0400
X-MC-Unique: pFVWDaoYMzKMdD7Nsc8Z7g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 43254280A9C4;
 Thu, 28 Sep 2023 13:20:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 20AD2C154CA;
 Thu, 28 Sep 2023 13:20:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E9AE621E6916; Thu, 28 Sep 2023 15:20:19 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, leobras@redhat.com,
 farosas@suse.de, lizhijian@fujitsu.com, eblake@redhat.com
Subject: [PATCH v2 14/53] migration/rdma: Make qemu_rdma_buffer_mergeable()
 return bool
Date: Thu, 28 Sep 2023 15:19:40 +0200
Message-ID: <20230928132019.2544702-15-armbru@redhat.com>
In-Reply-To: <20230928132019.2544702-1-armbru@redhat.com>
References: <20230928132019.2544702-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

qemu_rdma_buffer_mergeable() is semantically a predicate.  It returns
int 0 or 1.  Return bool instead, and fix the function name's
spelling.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
---
 migration/rdma.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 7bea4d3947..73dd34d8f3 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -2244,7 +2244,7 @@ static int qemu_rdma_write_flush(QEMUFile *f, RDMAContext *rdma)
     return 0;
 }
 
-static inline int qemu_rdma_buffer_mergable(RDMAContext *rdma,
+static inline bool qemu_rdma_buffer_mergeable(RDMAContext *rdma,
                     uint64_t offset, uint64_t len)
 {
     RDMALocalBlock *block;
@@ -2252,11 +2252,11 @@ static inline int qemu_rdma_buffer_mergable(RDMAContext *rdma,
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
@@ -2264,29 +2264,29 @@ static inline int qemu_rdma_buffer_mergable(RDMAContext *rdma,
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
@@ -2309,7 +2309,7 @@ static int qemu_rdma_write(QEMUFile *f, RDMAContext *rdma,
     int ret;
 
     /* If we cannot merge it, we flush the current buffer first. */
-    if (!qemu_rdma_buffer_mergable(rdma, current_addr, len)) {
+    if (!qemu_rdma_buffer_mergeable(rdma, current_addr, len)) {
         ret = qemu_rdma_write_flush(f, rdma);
         if (ret) {
             return ret;
-- 
2.41.0


