Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6206791379
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 10:33:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd501-0005dN-7q; Mon, 04 Sep 2023 04:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.zhadchenko@virtuozzo.com>)
 id 1qd4zo-0005bP-Bf; Mon, 04 Sep 2023 04:31:44 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.zhadchenko@virtuozzo.com>)
 id 1qd4zh-0003nd-FC; Mon, 04 Sep 2023 04:31:43 -0400
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=debian.fritz.box)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.zhadchenko@virtuozzo.com>)
 id 1qd4wY-00DKZj-2o; Mon, 04 Sep 2023 10:31:21 +0200
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org, den@virtuozzo.com
Subject: [PATCH 1/2] blockdev: qmp_transaction: harden transaction properties
 for bitmaps
Date: Mon,  4 Sep 2023 10:31:15 +0200
Message-Id: <20230904083116.568912-1-andrey.zhadchenko@virtuozzo.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.zhadchenko@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>
From:  Andrey Zhadchenko via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Unlike other transaction commands, bitmap operations do not drain target
bds. If we have an IOThread, this may result in some inconsistencies, as
bitmap content may change during transaction command.
Add bdrv_drained_begin()/end() to bitmap operations.

Signed-off-by: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>
---
 blockdev.c | 46 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 39 insertions(+), 7 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index e6eba61484..7a376fce90 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1932,10 +1932,19 @@ typedef struct BlockDirtyBitmapState {
     bool was_enabled;
 } BlockDirtyBitmapState;
 
+static void block_dirty_bitmap_state_clean(void *opaque)
+{
+    g_autofree BlockDirtyBitmapState *state = opaque;
+
+    if (state->bs) {
+        bdrv_drained_end(state->bs);
+    }
+}
+
 static void block_dirty_bitmap_add_abort(void *opaque);
 TransactionActionDrv block_dirty_bitmap_add_drv = {
     .abort = block_dirty_bitmap_add_abort,
-    .clean = g_free,
+    .clean = block_dirty_bitmap_state_clean,
 };
 
 static void block_dirty_bitmap_add_action(BlockDirtyBitmapAdd *action,
@@ -1946,6 +1955,12 @@ static void block_dirty_bitmap_add_action(BlockDirtyBitmapAdd *action,
 
     tran_add(tran, &block_dirty_bitmap_add_drv, state);
 
+    state->bs = bdrv_lookup_bs(action->node, action->node, errp);
+    if (!state->bs) {
+        return;
+    }
+    bdrv_drained_begin(state->bs);
+
     /* AIO context taken and released within qmp_block_dirty_bitmap_add */
     qmp_block_dirty_bitmap_add(action->node, action->name,
                                action->has_granularity, action->granularity,
@@ -1975,7 +1990,7 @@ static void block_dirty_bitmap_free_backup(void *opaque);
 TransactionActionDrv block_dirty_bitmap_clear_drv = {
     .abort = block_dirty_bitmap_restore,
     .commit = block_dirty_bitmap_free_backup,
-    .clean = g_free,
+    .clean = block_dirty_bitmap_state_clean,
 };
 
 static void block_dirty_bitmap_clear_action(BlockDirtyBitmap *action,
@@ -1993,6 +2008,8 @@ static void block_dirty_bitmap_clear_action(BlockDirtyBitmap *action,
         return;
     }
 
+    bdrv_drained_begin(state->bs);
+
     if (bdrv_dirty_bitmap_check(state->bitmap, BDRV_BITMAP_DEFAULT, errp)) {
         return;
     }
@@ -2019,7 +2036,7 @@ static void block_dirty_bitmap_free_backup(void *opaque)
 static void block_dirty_bitmap_enable_abort(void *opaque);
 TransactionActionDrv block_dirty_bitmap_enable_drv = {
     .abort = block_dirty_bitmap_enable_abort,
-    .clean = g_free,
+    .clean = block_dirty_bitmap_state_clean,
 };
 
 static void block_dirty_bitmap_enable_action(BlockDirtyBitmap *action,
@@ -2031,12 +2048,14 @@ static void block_dirty_bitmap_enable_action(BlockDirtyBitmap *action,
 
     state->bitmap = block_dirty_bitmap_lookup(action->node,
                                               action->name,
-                                              NULL,
+                                              &state->bs,
                                               errp);
     if (!state->bitmap) {
         return;
     }
 
+    bdrv_drained_begin(state->bs);
+
     if (bdrv_dirty_bitmap_check(state->bitmap, BDRV_BITMAP_ALLOW_RO, errp)) {
         return;
     }
@@ -2057,7 +2076,7 @@ static void block_dirty_bitmap_enable_abort(void *opaque)
 static void block_dirty_bitmap_disable_abort(void *opaque);
 TransactionActionDrv block_dirty_bitmap_disable_drv = {
     .abort = block_dirty_bitmap_disable_abort,
-    .clean = g_free,
+    .clean = block_dirty_bitmap_state_clean,
 };
 
 static void block_dirty_bitmap_disable_action(BlockDirtyBitmap *action,
@@ -2075,6 +2094,8 @@ static void block_dirty_bitmap_disable_action(BlockDirtyBitmap *action,
         return;
     }
 
+    bdrv_drained_begin(state->bs);
+
     if (bdrv_dirty_bitmap_check(state->bitmap, BDRV_BITMAP_ALLOW_RO, errp)) {
         return;
     }
@@ -2095,7 +2116,7 @@ static void block_dirty_bitmap_disable_abort(void *opaque)
 TransactionActionDrv block_dirty_bitmap_merge_drv = {
     .commit = block_dirty_bitmap_free_backup,
     .abort = block_dirty_bitmap_restore,
-    .clean = g_free,
+    .clean = block_dirty_bitmap_state_clean,
 };
 
 static void block_dirty_bitmap_merge_action(BlockDirtyBitmapMerge *action,
@@ -2105,6 +2126,12 @@ static void block_dirty_bitmap_merge_action(BlockDirtyBitmapMerge *action,
 
     tran_add(tran, &block_dirty_bitmap_merge_drv, state);
 
+    state->bs = bdrv_lookup_bs(action->node, action->node, errp);
+    if (!state->bs) {
+        return;
+    }
+    bdrv_drained_begin(state->bs);
+
     state->bitmap = block_dirty_bitmap_merge(action->node, action->target,
                                              action->bitmaps, &state->backup,
                                              errp);
@@ -2115,7 +2142,7 @@ static void block_dirty_bitmap_remove_abort(void *opaque);
 TransactionActionDrv block_dirty_bitmap_remove_drv = {
     .commit = block_dirty_bitmap_remove_commit,
     .abort = block_dirty_bitmap_remove_abort,
-    .clean = g_free,
+    .clean = block_dirty_bitmap_state_clean,
 };
 
 static void block_dirty_bitmap_remove_action(BlockDirtyBitmap *action,
@@ -2125,6 +2152,11 @@ static void block_dirty_bitmap_remove_action(BlockDirtyBitmap *action,
 
     tran_add(tran, &block_dirty_bitmap_remove_drv, state);
 
+    state->bs = bdrv_lookup_bs(action->node, action->node, errp);
+    if (!state->bs) {
+        return;
+    }
+    bdrv_drained_begin(state->bs);
 
     state->bitmap = block_dirty_bitmap_remove(action->node, action->name,
                                               false, &state->bs, errp);
-- 
2.39.2


