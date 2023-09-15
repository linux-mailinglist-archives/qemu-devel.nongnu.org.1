Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3297A2188
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 16:53:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhA3O-0000Fe-Cb; Fri, 15 Sep 2023 10:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qhA3C-00009y-88
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 10:44:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qhA3A-0004yz-KI
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 10:44:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694789042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gQUOFlnWfu6bZkZbbxmD78OSzWs56jzvPn0oUS/WOds=;
 b=KReA5wM1gxn1C79r00ArwDaJ8TccYuv1lLyiIrJlXb1y63pU25aieXzrkXcuhqYG/70KKn
 BZkKCp4sPILTunFI8vPzLrJSmbwyw+njTB94BFijzxDPRo9EktX7ccXaYeiBIHb5LUQYwi
 aCYLXtjI9ERNcNK353ELJMIUCSog3JQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-329-d6N9eEIWPRu8LKuQO8U_RA-1; Fri, 15 Sep 2023 10:44:01 -0400
X-MC-Unique: d6N9eEIWPRu8LKuQO8U_RA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 18D96955969;
 Fri, 15 Sep 2023 14:44:01 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.146])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 799E52026D4B;
 Fri, 15 Sep 2023 14:44:00 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 15/28] block: Mark bdrv_child_perm() GRAPH_RDLOCK
Date: Fri, 15 Sep 2023 16:43:31 +0200
Message-ID: <20230915144344.238596-16-kwolf@redhat.com>
In-Reply-To: <20230915144344.238596-1-kwolf@redhat.com>
References: <20230915144344.238596-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
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

This adds GRAPH_RDLOCK annotations to declare that callers of
bdrv_child_perm() need to hold a reader lock for the graph because
some implementations access the children list of a node.

The callers of bdrv_child_perm() conveniently already hold the lock.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20230911094620.45040-16-kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block_int-common.h | 10 +++++-----
 block.c                          | 11 ++++++-----
 block/copy-before-write.c        | 10 +++++-----
 3 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index f82c14fb9c..3feb67ec4a 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -451,11 +451,11 @@ struct BlockDriver {
      * permissions, but those that will be needed after applying the
      * @reopen_queue.
      */
-     void (*bdrv_child_perm)(BlockDriverState *bs, BdrvChild *c,
-                             BdrvChildRole role,
-                             BlockReopenQueue *reopen_queue,
-                             uint64_t parent_perm, uint64_t parent_shared,
-                             uint64_t *nperm, uint64_t *nshared);
+     void GRAPH_RDLOCK_PTR (*bdrv_child_perm)(
+        BlockDriverState *bs, BdrvChild *c, BdrvChildRole role,
+        BlockReopenQueue *reopen_queue,
+        uint64_t parent_perm, uint64_t parent_shared,
+        uint64_t *nperm, uint64_t *nshared);
 
     /**
      * Register/unregister a buffer for I/O. For example, when the driver is
diff --git a/block.c b/block.c
index 186efda70f..0f7f78f8de 100644
--- a/block.c
+++ b/block.c
@@ -2228,11 +2228,12 @@ bdrv_parent_perms_conflict(BlockDriverState *bs, Error **errp)
     return false;
 }
 
-static void bdrv_child_perm(BlockDriverState *bs, BlockDriverState *child_bs,
-                            BdrvChild *c, BdrvChildRole role,
-                            BlockReopenQueue *reopen_queue,
-                            uint64_t parent_perm, uint64_t parent_shared,
-                            uint64_t *nperm, uint64_t *nshared)
+static void GRAPH_RDLOCK
+bdrv_child_perm(BlockDriverState *bs, BlockDriverState *child_bs,
+                BdrvChild *c, BdrvChildRole role,
+                BlockReopenQueue *reopen_queue,
+                uint64_t parent_perm, uint64_t parent_shared,
+                uint64_t *nperm, uint64_t *nshared)
 {
     assert(bs->drv && bs->drv->bdrv_child_perm);
     GLOBAL_STATE_CODE();
diff --git a/block/copy-before-write.c b/block/copy-before-write.c
index 9a0e2b69d9..aeaff3bb82 100644
--- a/block/copy-before-write.c
+++ b/block/copy-before-write.c
@@ -341,11 +341,11 @@ static void cbw_refresh_filename(BlockDriverState *bs)
             bs->file->bs->filename);
 }
 
-static void cbw_child_perm(BlockDriverState *bs, BdrvChild *c,
-                           BdrvChildRole role,
-                           BlockReopenQueue *reopen_queue,
-                           uint64_t perm, uint64_t shared,
-                           uint64_t *nperm, uint64_t *nshared)
+static void GRAPH_RDLOCK
+cbw_child_perm(BlockDriverState *bs, BdrvChild *c, BdrvChildRole role,
+               BlockReopenQueue *reopen_queue,
+               uint64_t perm, uint64_t shared,
+               uint64_t *nperm, uint64_t *nshared)
 {
     if (!(role & BDRV_CHILD_FILTERED)) {
         /*
-- 
2.41.0


