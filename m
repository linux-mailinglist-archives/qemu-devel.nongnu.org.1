Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A1170623C
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 10:09:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzC6w-0003A6-R6; Wed, 17 May 2023 04:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pzC6Q-00024o-VI; Wed, 17 May 2023 04:01:44 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pzC6L-0000at-Cm; Wed, 17 May 2023 04:01:41 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6D347675B;
 Wed, 17 May 2023 11:00:59 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id F3A0D5E13;
 Wed, 17 May 2023 11:00:58 +0300 (MSK)
Received: (nullmailer pid 3624132 invoked by uid 1000);
 Wed, 17 May 2023 08:00:56 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-stable@nongnu.org
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Eric Blake <eblake@redhat.com>
Subject: [PATCH v8.0.1 18/36] block/export: call blk_set_dev_ops(blk, NULL,
 NULL)
Date: Wed, 17 May 2023 11:00:38 +0300
Message-Id: <20230517080056.3623993-18-mjt@msgid.tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <<20230517073442.3622973-0-mjt@msgid.tls.msk.ru>
References: <20230517073442.3622973-0-mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Stefan Hajnoczi <stefanha@redhat.com>

Most export types install BlockDeviceOps pointers. It is easy to forget
to remove them because that happens automatically via the "drive" qdev
property in hw/ but not block/export/.

Put blk_set_dev_ops(blk, NULL, NULL) calls in the core export.c code so
the export types don't need to remember.

This fixes the nbd and vhost-user-blk export types.

Fixes: fd6afc501a01 ("nbd/server: Use drained block ops to quiesce the server")
Fixes: ca858a5fe94c ("vhost-user-blk-server: notify client about disk resize")
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20230502211119.720647-1-stefanha@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
(cherry picked from commit de79b52604e43fdeba6cee4f5af600b62169f2d2)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 block/export/export.c    | 2 ++
 block/export/vduse-blk.c | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/export/export.c b/block/export/export.c
index 28a91c9c42..cdef298902 100644
--- a/block/export/export.c
+++ b/block/export/export.c
@@ -192,6 +192,7 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
     return exp;
 
 fail:
+    blk_set_dev_ops(exp->blk, NULL, NULL);
     blk_unref(blk);
     aio_context_release(ctx);
     if (exp) {
@@ -219,6 +220,7 @@ static void blk_exp_delete_bh(void *opaque)
     assert(exp->refcount == 0);
     QLIST_REMOVE(exp, next);
     exp->drv->delete(exp);
+    blk_set_dev_ops(exp->blk, NULL, NULL);
     blk_unref(exp->blk);
     qapi_event_send_block_export_deleted(exp->id);
     g_free(exp->id);
diff --git a/block/export/vduse-blk.c b/block/export/vduse-blk.c
index f7ae44e3ce..b53ef39da0 100644
--- a/block/export/vduse-blk.c
+++ b/block/export/vduse-blk.c
@@ -346,7 +346,6 @@ static void vduse_blk_exp_delete(BlockExport *exp)
 
     blk_remove_aio_context_notifier(exp->blk, blk_aio_attached, blk_aio_detach,
                                     vblk_exp);
-    blk_set_dev_ops(exp->blk, NULL, NULL);
     ret = vduse_dev_destroy(vblk_exp->dev);
     if (ret != -EBUSY) {
         unlink(vblk_exp->recon_file);
-- 
2.39.2


