Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C60117C7298
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 18:30:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqySz-0003jZ-OU; Thu, 12 Oct 2023 12:23:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qqySx-0003hI-B8
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 12:23:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qqySf-0000eF-Un
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 12:23:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697127777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C7taCFILHNBmj2WAttz6AXh+cJx3404j+p6XGcZyuh8=;
 b=W7VvGJ6X3vHPe4ibrA1UcQQSc8SmC+pN1Q8LDm6iNADab3Shocw+GpxJaTmiLAcebzc5iK
 HyCOztA/e/0WpQN1E8FQBahckHnIPyWNGrBBJPcKpr00OFkwJyR9onZk2lbuemGjVwse+2
 rsbjUQ6M4Zs9KZFWUHOlPU6MjamwMBU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-426-rLyz5B6nN6azVcK3LEQkGQ-1; Thu, 12 Oct 2023 12:22:55 -0400
X-MC-Unique: rLyz5B6nN6azVcK3LEQkGQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 882AC81D9EC;
 Thu, 12 Oct 2023 16:22:54 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.192.233])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EC85620296DB;
 Thu, 12 Oct 2023 16:22:53 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 23/26] block: Mark bdrv_get_specific_info() and callers
 GRAPH_RDLOCK
Date: Thu, 12 Oct 2023 18:22:21 +0200
Message-ID: <20231012162224.240535-24-kwolf@redhat.com>
In-Reply-To: <20231012162224.240535-1-kwolf@redhat.com>
References: <20231012162224.240535-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
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

This adds GRAPH_RDLOCK annotations to declare that callers of
bdrv_get_specific_info() need to hold a reader lock for the graph.
This removes an assume_graph_lock() call in vmdk's implementation.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20230929145157.45443-20-kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block-io.h         | 5 +++--
 include/block/block_int-common.h | 4 ++--
 block/vmdk.c                     | 6 ++----
 qemu-io-cmds.c                   | 3 +++
 4 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/block/block-io.h b/include/block/block-io.h
index e051e9bed6..ad270b6ad2 100644
--- a/include/block/block-io.h
+++ b/include/block/block-io.h
@@ -198,8 +198,9 @@ bdrv_co_get_info(BlockDriverState *bs, BlockDriverInfo *bdi);
 int co_wrapper_mixed_bdrv_rdlock
 bdrv_get_info(BlockDriverState *bs, BlockDriverInfo *bdi);
 
-ImageInfoSpecific *bdrv_get_specific_info(BlockDriverState *bs,
-                                          Error **errp);
+ImageInfoSpecific * GRAPH_RDLOCK
+bdrv_get_specific_info(BlockDriverState *bs, Error **errp);
+
 BlockStatsSpecific *bdrv_get_specific_stats(BlockDriverState *bs);
 void bdrv_round_to_subclusters(BlockDriverState *bs,
                                int64_t offset, int64_t bytes,
diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index d971d73f8f..024262b5a2 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -728,8 +728,8 @@ struct BlockDriver {
     int coroutine_fn GRAPH_RDLOCK_PTR (*bdrv_co_get_info)(
         BlockDriverState *bs, BlockDriverInfo *bdi);
 
-    ImageInfoSpecific *(*bdrv_get_specific_info)(BlockDriverState *bs,
-                                                 Error **errp);
+    ImageInfoSpecific * GRAPH_RDLOCK_PTR (*bdrv_get_specific_info)(
+        BlockDriverState *bs, Error **errp);
     BlockStatsSpecific *(*bdrv_get_specific_stats)(BlockDriverState *bs);
 
     int coroutine_fn GRAPH_RDLOCK_PTR (*bdrv_co_save_vmstate)(
diff --git a/block/vmdk.c b/block/vmdk.c
index e50965bc37..8a3b152798 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -2990,16 +2990,14 @@ vmdk_co_check(BlockDriverState *bs, BdrvCheckResult *result, BdrvCheckMode fix)
     return ret;
 }
 
-static ImageInfoSpecific *vmdk_get_specific_info(BlockDriverState *bs,
-                                                 Error **errp)
+static ImageInfoSpecific * GRAPH_RDLOCK
+vmdk_get_specific_info(BlockDriverState *bs, Error **errp)
 {
     int i;
     BDRVVmdkState *s = bs->opaque;
     ImageInfoSpecific *spec_info = g_new0(ImageInfoSpecific, 1);
     VmdkExtentInfoList **tail;
 
-    assume_graph_lock(); /* FIXME */
-
     *spec_info = (ImageInfoSpecific){
         .type = IMAGE_INFO_SPECIFIC_KIND_VMDK,
         .u = {
diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index 3f75d2f5a6..f5d7202a13 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -2037,6 +2037,9 @@ static int info_f(BlockBackend *blk, int argc, char **argv)
     char s1[64], s2[64];
     int ret;
 
+    GLOBAL_STATE_CODE();
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     if (bs->drv && bs->drv->format_name) {
         printf("format name: %s\n", bs->drv->format_name);
     }
-- 
2.41.0


