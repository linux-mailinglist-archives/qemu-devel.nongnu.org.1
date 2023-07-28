Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B5B766F0D
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 16:12:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPNh5-0006UL-Ft; Fri, 28 Jul 2023 09:39:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qPNgy-0006QM-Nl; Fri, 28 Jul 2023 09:39:40 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qPNgw-0007MX-Tl; Fri, 28 Jul 2023 09:39:40 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 81D2841EFA;
 Fri, 28 Jul 2023 15:39:34 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, fam@euphon.net, eblake@redhat.com,
 vsementsov@yandex-team.ru, jsnow@redhat.com, quintela@redhat.com,
 peterx@redhat.com, leobras@redhat.com, qemu-block@nongnu.org
Subject: [RFC] migration/block-dirty-bitmap: make loading bitmap for device
 with iothread future-proof
Date: Fri, 28 Jul 2023 15:39:28 +0200
Message-Id: <20230728133928.256898-1-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The bdrv_create_dirty_bitmap() function (which is also called by
bdrv_dirty_bitmap_create_successor()) uses bdrv_getlength(bs). This is
a wrapper around a coroutine, and when not called in coroutine context
would use bdrv_poll_co(). Such a call would trigger an assert() if the
correct AioContext hasn't been acquired before, because polling would
try to release the AioContext.

The issue does not happen for migration, because the call happens
from process_incoming_migration_co(), i.e. in coroutine context. So
the bdrv_getlength() wrapper will just call bdrv_co_getlength()
directly without polling.

The issue would happen for snapshots, but won't in practice, because
saving a snapshot with a block dirty bitmap is currently not possible.
The reason is that dirty_bitmap_save_iterate() returns whether it has
completed the bulk phase, which only happens in postcopy, so
qemu_savevm_state_iterate() will always return 0, meaning the call
to iterate will be repeated over and over again without ever reaching
the completion phase.

Still, this would make the code more robust for the future.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---

We ran into this issue downstream, because we have a custom snapshot
mechanism which does support dirty bitmaps and does not run in
coroutine context during load.

 migration/block-dirty-bitmap.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 032fc5f405..e1ae3b7316 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -805,8 +805,11 @@ static int dirty_bitmap_load_start(QEMUFile *f, DBMLoadState *s)
                      "destination", bdrv_dirty_bitmap_name(s->bitmap));
         return -EINVAL;
     } else {
+        AioContext *ctx = bdrv_get_aio_context(s->bs);
+        aio_context_acquire(ctx);
         s->bitmap = bdrv_create_dirty_bitmap(s->bs, granularity,
                                              s->bitmap_name, &local_err);
+        aio_context_release(ctx);
         if (!s->bitmap) {
             error_report_err(local_err);
             return -EINVAL;
@@ -833,7 +836,10 @@ static int dirty_bitmap_load_start(QEMUFile *f, DBMLoadState *s)
 
     bdrv_disable_dirty_bitmap(s->bitmap);
     if (flags & DIRTY_BITMAP_MIG_START_FLAG_ENABLED) {
+        AioContext *ctx = bdrv_get_aio_context(s->bs);
+        aio_context_acquire(ctx);
         bdrv_dirty_bitmap_create_successor(s->bitmap, &local_err);
+        aio_context_release(ctx);
         if (local_err) {
             error_report_err(local_err);
             return -EINVAL;
-- 
2.39.2



