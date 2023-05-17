Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C42706EB6
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 18:52:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzKNG-0003y3-Nb; Wed, 17 May 2023 12:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1pzKND-0003wv-S2
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:51:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1pzKNA-0001PS-RG
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:51:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684342292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rtYEhNwoqKmyFYlOKgNH+j3C8ts0K1Kmcu9S3dJv66Y=;
 b=Y3yMA8sKQpSNDINWP0e6OKFBbirXGQF4zXV2yGoLRnjgzQY9Q4Tz1gVBjj+WnSUfShG8UF
 6wNdriuxCDfCPsbpzF5hntkd684RRrsG5hg5FzJlqPUAJzX1Nkmbhs1/d8Ip2OcwAy27ct
 mC2bgAhd4uW0lPErfDKULjkU0oRYeQc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-65-ipqEFAU7NcCCWS1qWPf6Ow-1; Wed, 17 May 2023 12:51:28 -0400
X-MC-Unique: ipqEFAU7NcCCWS1qWPf6Ow-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5EAC938184E4;
 Wed, 17 May 2023 16:51:28 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A4ACD40C6EC4;
 Wed, 17 May 2023 16:51:27 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 05/18] blockdev: use state.bitmap in block-dirty-bitmap-add
 action
Date: Wed, 17 May 2023 18:51:03 +0200
Message-Id: <20230517165116.475123-6-kwolf@redhat.com>
In-Reply-To: <20230517165116.475123-1-kwolf@redhat.com>
References: <20230517165116.475123-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Other bitmap related actions use the .bitmap pointer in .abort action,
let's do same here:

1. It helps further refactoring, as bitmap-add is the only bitmap
   action that uses state.action in .abort

2. It must be safe: transaction actions rely on the fact that on
   .abort() the state is the same as at the end of .prepare(), so that
   in .abort() we could precisely rollback the changes done by
   .prepare().
   The only way to remove the bitmap during transaction should be
   block-dirty-bitmap-remove action, but it postpones actual removal to
   .commit(), so we are OK on any rollback path. (Note also that
   bitmap-remove is the only bitmap action that has .commit() phase,
   except for simple g_free the state on .clean())

3. Again, other bitmap actions behave this way: keep the bitmap pointer
   during the transaction.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Message-Id: <20230510150624.310640-6-vsementsov@yandex-team.ru>
[kwolf: Also remove the now unused BlockDirtyBitmapState.prepared]
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 blockdev.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index a2ebaa5afc..4bf15566b2 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1979,7 +1979,6 @@ typedef struct BlockDirtyBitmapState {
     BdrvDirtyBitmap *bitmap;
     BlockDriverState *bs;
     HBitmap *backup;
-    bool prepared;
     bool was_enabled;
 } BlockDirtyBitmapState;
 
@@ -2008,7 +2007,8 @@ static void block_dirty_bitmap_add_action(BlkActionState *common,
                                &local_err);
 
     if (!local_err) {
-        state->prepared = true;
+        state->bitmap = block_dirty_bitmap_lookup(action->node, action->name,
+                                                  NULL, &error_abort);
     } else {
         error_propagate(errp, local_err);
     }
@@ -2016,15 +2016,10 @@ static void block_dirty_bitmap_add_action(BlkActionState *common,
 
 static void block_dirty_bitmap_add_abort(void *opaque)
 {
-    BlockDirtyBitmapAdd *action;
     BlockDirtyBitmapState *state = opaque;
 
-    action = state->common.action->u.block_dirty_bitmap_add.data;
-    /* Should not be able to fail: IF the bitmap was added via .prepare(),
-     * then the node reference and bitmap name must have been valid.
-     */
-    if (state->prepared) {
-        qmp_block_dirty_bitmap_remove(action->node, action->name, &error_abort);
+    if (state->bitmap) {
+        bdrv_release_dirty_bitmap(state->bitmap);
     }
 }
 
-- 
2.40.1


