Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D6DAC922A
	for <lists+qemu-devel@lfdr.de>; Fri, 30 May 2025 17:12:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uL1Oo-0002sp-Eb; Fri, 30 May 2025 11:11:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uL1Ok-0002qF-Ht; Fri, 30 May 2025 11:11:54 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uL1Oh-0002EU-EJ; Fri, 30 May 2025 11:11:54 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id B5EA144978;
 Fri, 30 May 2025 17:11:40 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com, stefanha@redhat.com,
 eblake@redhat.com, jsnow@redhat.com, vsementsov@yandex-team.ru,
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, berto@igalia.com,
 fam@euphon.net, ari@tuxera.com
Subject: [PATCH v4 04/48] block: move drain outside of read-locked
 bdrv_inactivate_recurse()
Date: Fri, 30 May 2025 17:10:41 +0200
Message-Id: <20250530151125.955508-5-f.ebner@proxmox.com>
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

This is in preparation to mark bdrv_drained_begin() as GRAPH_UNLOCKED.

More granular draining is not trivially possible, because
bdrv_inactivate_recurse() can recursively call itself.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/block.c b/block.c
index 3065d5c91e..fa55dfba68 100644
--- a/block.c
+++ b/block.c
@@ -6989,6 +6989,8 @@ bdrv_inactivate_recurse(BlockDriverState *bs, bool top_level)
 
     GLOBAL_STATE_CODE();
 
+    assert(bs->quiesce_counter > 0);
+
     if (!bs->drv) {
         return -ENOMEDIUM;
     }
@@ -7032,9 +7034,7 @@ bdrv_inactivate_recurse(BlockDriverState *bs, bool top_level)
         return -EPERM;
     }
 
-    bdrv_drained_begin(bs);
     bs->open_flags |= BDRV_O_INACTIVE;
-    bdrv_drained_end(bs);
 
     /*
      * Update permissions, they may differ for inactive nodes.
@@ -7059,20 +7059,26 @@ int bdrv_inactivate(BlockDriverState *bs, Error **errp)
     int ret;
 
     GLOBAL_STATE_CODE();
-    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
+    bdrv_drain_all_begin();
+    bdrv_graph_rdlock_main_loop();
 
     if (bdrv_has_bds_parent(bs, true)) {
         error_setg(errp, "Node has active parent node");
-        return -EPERM;
+        ret = -EPERM;
+        goto out;
     }
 
     ret = bdrv_inactivate_recurse(bs, true);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Failed to inactivate node");
-        return ret;
+        goto out;
     }
 
-    return 0;
+out:
+    bdrv_graph_rdunlock_main_loop();
+    bdrv_drain_all_end();
+    return ret;
 }
 
 int bdrv_inactivate_all(void)
@@ -7082,7 +7088,9 @@ int bdrv_inactivate_all(void)
     int ret = 0;
 
     GLOBAL_STATE_CODE();
-    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
+    bdrv_drain_all_begin();
+    bdrv_graph_rdlock_main_loop();
 
     for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
         /* Nodes with BDS parents are covered by recursion from the last
@@ -7098,6 +7106,9 @@ int bdrv_inactivate_all(void)
         }
     }
 
+    bdrv_graph_rdunlock_main_loop();
+    bdrv_drain_all_end();
+
     return ret;
 }
 
-- 
2.39.5



