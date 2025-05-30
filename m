Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EBFAC9269
	for <lists+qemu-devel@lfdr.de>; Fri, 30 May 2025 17:19:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uL1PM-0003lx-KT; Fri, 30 May 2025 11:12:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uL1PB-0003LB-Pg; Fri, 30 May 2025 11:12:22 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uL1P8-0002Hx-R2; Fri, 30 May 2025 11:12:21 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 82CD144B56;
 Fri, 30 May 2025 17:11:46 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com, stefanha@redhat.com,
 eblake@redhat.com, jsnow@redhat.com, vsementsov@yandex-team.ru,
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, berto@igalia.com,
 fam@euphon.net, ari@tuxera.com
Subject: [PATCH v4 23/48] block: never use atomics to access
 bs->quiesce_counter
Date: Fri, 30 May 2025 17:11:00 +0200
Message-Id: <20250530151125.955508-24-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250530151125.955508-1-f.ebner@proxmox.com>
References: <20250530151125.955508-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

All accesses of bs->quiesce_counter are in the main thread, either
after a GLOBAL_STATE_CODE() macro or in a function with GRAPH_WRLOCK
annotation.

This is essentially a revert of 414c2ec358 ("block: access
quiesce_counter with atomic ops"). At that time, neither the
GLOBAL_STATE_CODE() macro nor the GRAPH_WRLOCK annotation existed.
Even if the field was only accessed in the main thread back then (did
not check if that is actually the case), it wouldn't have been easy to
verify.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---
 block/io.c                       | 7 ++-----
 include/block/block_int-common.h | 2 +-
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/block/io.c b/block/io.c
index ac5c7174f6..9bd8ba8431 100644
--- a/block/io.c
+++ b/block/io.c
@@ -361,7 +361,7 @@ static void bdrv_do_drained_begin(BlockDriverState *bs, BdrvChild *parent,
     GLOBAL_STATE_CODE();
 
     /* Stop things in parent-to-child order */
-    if (qatomic_fetch_inc(&bs->quiesce_counter) == 0) {
+    if (bs->quiesce_counter++ == 0) {
         GRAPH_RDLOCK_GUARD_MAINLOOP();
         bdrv_parent_drained_begin(bs, parent);
         if (bs->drv && bs->drv->bdrv_drain_begin) {
@@ -401,8 +401,6 @@ bdrv_drained_begin(BlockDriverState *bs)
  */
 static void bdrv_do_drained_end(BlockDriverState *bs, BdrvChild *parent)
 {
-    int old_quiesce_counter;
-
     IO_OR_GS_CODE();
 
     if (qemu_in_coroutine()) {
@@ -415,8 +413,7 @@ static void bdrv_do_drained_end(BlockDriverState *bs, BdrvChild *parent)
     assert(bs->quiesce_counter > 0);
 
     /* Re-enable things in child-to-parent order */
-    old_quiesce_counter = qatomic_fetch_dec(&bs->quiesce_counter);
-    if (old_quiesce_counter == 1) {
+    if (--bs->quiesce_counter == 0) {
         GRAPH_RDLOCK_GUARD_MAINLOOP();
         if (bs->drv && bs->drv->bdrv_drain_end) {
             bs->drv->bdrv_drain_end(bs);
diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index 925a3e7353..e96c6a6a03 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -1253,7 +1253,7 @@ struct BlockDriverState {
     /* do we need to tell the quest if we have a volatile write cache? */
     int enable_write_cache;
 
-    /* Accessed with atomic ops.  */
+    /* Accessed only in the main thread. */
     int quiesce_counter;
 
     unsigned int write_gen;               /* Current data generation */
-- 
2.39.5



