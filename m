Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7887C729F
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 18:30:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqyTL-0003tu-VB; Thu, 12 Oct 2023 12:23:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qqyTA-0003pW-Ry
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 12:23:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qqySy-0000iL-7w
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 12:23:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697127795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nUk0LEhDC8wzkomDUXax6IERTNH3jaa23XaMvin57E4=;
 b=i4ljv5nslER5XH0BuI7LNOttekY0/RPVmdSuWilDeKhZIuTpZUvRFVB6BJ0CKPIxcyfViy
 GosiCAM24DC1ecBQrwn29fc2QgpjXYqZs6ORpyeglz1Gp/+ek21MSTyH8Xad7fhe+MIfVH
 1411oBYygMxtEtOvtFZIfyudnUQakUY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-444-_wukAmEwOaWhanQ2HoVzQg-1; Thu, 12 Oct 2023 12:22:48 -0400
X-MC-Unique: _wukAmEwOaWhanQ2HoVzQg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CBD9628AC1CD;
 Thu, 12 Oct 2023 16:22:47 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.192.233])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3BB1520296DB;
 Thu, 12 Oct 2023 16:22:47 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 15/26] block: Mark bdrv_primary_child() and callers GRAPH_RDLOCK
Date: Thu, 12 Oct 2023 18:22:13 +0200
Message-ID: <20231012162224.240535-16-kwolf@redhat.com>
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
bdrv_primary_child() need to hold a reader lock for the graph
because it accesses the children list of a node.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20230929145157.45443-12-kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block_int-io.h |  5 +++--
 block.c                      | 11 ++++++++++-
 block/snapshot.c             |  3 +++
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/include/block/block_int-io.h b/include/block/block_int-io.h
index eb0da7232e..2b6004ab93 100644
--- a/include/block/block_int-io.h
+++ b/include/block/block_int-io.h
@@ -133,7 +133,7 @@ bdrv_refresh_total_sectors(BlockDriverState *bs, int64_t hint);
 BdrvChild *bdrv_cow_child(BlockDriverState *bs);
 BdrvChild *bdrv_filter_child(BlockDriverState *bs);
 BdrvChild *bdrv_filter_or_cow_child(BlockDriverState *bs);
-BdrvChild *bdrv_primary_child(BlockDriverState *bs);
+BdrvChild * GRAPH_RDLOCK bdrv_primary_child(BlockDriverState *bs);
 BlockDriverState *bdrv_skip_filters(BlockDriverState *bs);
 BlockDriverState *bdrv_backing_chain_next(BlockDriverState *bs);
 
@@ -155,7 +155,8 @@ static inline BlockDriverState *bdrv_filter_or_cow_bs(BlockDriverState *bs)
     return child_bs(bdrv_filter_or_cow_child(bs));
 }
 
-static inline BlockDriverState *bdrv_primary_bs(BlockDriverState *bs)
+static inline BlockDriverState * GRAPH_RDLOCK
+bdrv_primary_bs(BlockDriverState *bs)
 {
     IO_CODE();
     return child_bs(bdrv_primary_child(bs));
diff --git a/block.c b/block.c
index 142e1d5e2b..6ce3e2ad7a 100644
--- a/block.c
+++ b/block.c
@@ -6692,7 +6692,8 @@ void coroutine_fn bdrv_co_debug_event(BlockDriverState *bs, BlkdebugEvent event)
     bs->drv->bdrv_co_debug_event(bs, event);
 }
 
-static BlockDriverState *bdrv_find_debug_node(BlockDriverState *bs)
+static BlockDriverState * GRAPH_RDLOCK
+bdrv_find_debug_node(BlockDriverState *bs)
 {
     GLOBAL_STATE_CODE();
     while (bs && bs->drv && !bs->drv->bdrv_debug_breakpoint) {
@@ -6711,6 +6712,8 @@ int bdrv_debug_breakpoint(BlockDriverState *bs, const char *event,
                           const char *tag)
 {
     GLOBAL_STATE_CODE();
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     bs = bdrv_find_debug_node(bs);
     if (bs) {
         return bs->drv->bdrv_debug_breakpoint(bs, event, tag);
@@ -6722,6 +6725,8 @@ int bdrv_debug_breakpoint(BlockDriverState *bs, const char *event,
 int bdrv_debug_remove_breakpoint(BlockDriverState *bs, const char *tag)
 {
     GLOBAL_STATE_CODE();
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     bs = bdrv_find_debug_node(bs);
     if (bs) {
         return bs->drv->bdrv_debug_remove_breakpoint(bs, tag);
@@ -6733,6 +6738,8 @@ int bdrv_debug_remove_breakpoint(BlockDriverState *bs, const char *tag)
 int bdrv_debug_resume(BlockDriverState *bs, const char *tag)
 {
     GLOBAL_STATE_CODE();
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     while (bs && (!bs->drv || !bs->drv->bdrv_debug_resume)) {
         bs = bdrv_primary_bs(bs);
     }
@@ -6747,6 +6754,8 @@ int bdrv_debug_resume(BlockDriverState *bs, const char *tag)
 bool bdrv_debug_is_suspended(BlockDriverState *bs, const char *tag)
 {
     GLOBAL_STATE_CODE();
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     while (bs && bs->drv && !bs->drv->bdrv_debug_is_suspended) {
         bs = bdrv_primary_bs(bs);
     }
diff --git a/block/snapshot.c b/block/snapshot.c
index 554065578b..ad2bf6e068 100644
--- a/block/snapshot.c
+++ b/block/snapshot.c
@@ -311,7 +311,10 @@ int bdrv_snapshot_goto(BlockDriverState *bs,
          * respective option (with the qdict_put_str() call above).
          * Assert that .bdrv_open() has attached the right BDS as primary child.
          */
+        bdrv_graph_rdlock_main_loop();
         assert(bdrv_primary_bs(bs) == fallback_bs);
+        bdrv_graph_rdunlock_main_loop();
+
         bdrv_unref(fallback_bs);
         return ret;
     }
-- 
2.41.0


