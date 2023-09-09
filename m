Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CE479985B
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 15:09:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qexbo-0003L8-Kw; Sat, 09 Sep 2023 09:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qexbh-0002wD-2A; Sat, 09 Sep 2023 09:02:37 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qexbe-0002o9-5Z; Sat, 09 Sep 2023 09:02:36 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 82B5A205A9;
 Sat,  9 Sep 2023 16:01:18 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 5A6F426E0F;
 Sat,  9 Sep 2023 16:00:27 +0300 (MSK)
Received: (nullmailer pid 353136 invoked by uid 1000);
 Sat, 09 Sep 2023 13:00:22 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Stefan Hajnoczi <stefanha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.5 27/43] block-migration: Ensure we don't crash during
 migration cleanup
Date: Sat,  9 Sep 2023 15:59:53 +0300
Message-Id: <20230909130020.352951-27-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.5-20230909155813@cover.tls.msk.ru>
References: <qemu-stable-8.0.5-20230909155813@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Fabiano Rosas <farosas@suse.de>

We can fail the blk_insert_bs() at init_blk_migration(), leaving the
BlkMigDevState without a dirty_bitmap and BlockDriverState. Account
for the possibly missing elements when doing cleanup.

Fix the following crashes:

Thread 1 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
0x0000555555ec83ef in bdrv_release_dirty_bitmap (bitmap=0x0) at ../block/dirty-bitmap.c:359
359         BlockDriverState *bs = bitmap->bs;
 #0  0x0000555555ec83ef in bdrv_release_dirty_bitmap (bitmap=0x0) at ../block/dirty-bitmap.c:359
 #1  0x0000555555bba331 in unset_dirty_tracking () at ../migration/block.c:371
 #2  0x0000555555bbad98 in block_migration_cleanup_bmds () at ../migration/block.c:681

Thread 1 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
0x0000555555e971ff in bdrv_op_unblock (bs=0x0, op=BLOCK_OP_TYPE_BACKUP_SOURCE, reason=0x0) at ../block.c:7073
7073        QLIST_FOREACH_SAFE(blocker, &bs->op_blockers[op], list, next) {
 #0  0x0000555555e971ff in bdrv_op_unblock (bs=0x0, op=BLOCK_OP_TYPE_BACKUP_SOURCE, reason=0x0) at ../block.c:7073
 #1  0x0000555555e9734a in bdrv_op_unblock_all (bs=0x0, reason=0x0) at ../block.c:7095
 #2  0x0000555555bbae13 in block_migration_cleanup_bmds () at ../migration/block.c:690

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Message-id: 20230731203338.27581-1-farosas@suse.de
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
(cherry picked from commit f187609f27b261702a17f79d20bf252ee0d4f9cd)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/migration/block.c b/migration/block.c
index b2497bbd32..ece746e788 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -366,7 +366,9 @@ static void unset_dirty_tracking(void)
     BlkMigDevState *bmds;
 
     QSIMPLEQ_FOREACH(bmds, &block_mig_state.bmds_list, entry) {
-        bdrv_release_dirty_bitmap(bmds->dirty_bitmap);
+        if (bmds->dirty_bitmap) {
+            bdrv_release_dirty_bitmap(bmds->dirty_bitmap);
+        }
     }
 }
 
@@ -674,13 +676,18 @@ static int64_t get_remaining_dirty(void)
 static void block_migration_cleanup_bmds(void)
 {
     BlkMigDevState *bmds;
+    BlockDriverState *bs;
     AioContext *ctx;
 
     unset_dirty_tracking();
 
     while ((bmds = QSIMPLEQ_FIRST(&block_mig_state.bmds_list)) != NULL) {
         QSIMPLEQ_REMOVE_HEAD(&block_mig_state.bmds_list, entry);
-        bdrv_op_unblock_all(blk_bs(bmds->blk), bmds->blocker);
+
+        bs = blk_bs(bmds->blk);
+        if (bs) {
+            bdrv_op_unblock_all(bs, bmds->blocker);
+        }
         error_free(bmds->blocker);
 
         /* Save ctx, because bmds->blk can disappear during blk_unref.  */
-- 
2.39.2


