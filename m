Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 71587ABD50A
	for <lists+qemu-devel@lfdr.de>; Tue, 20 May 2025 12:33:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHKFJ-00082G-Bu; Tue, 20 May 2025 06:30:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uHKEv-0006zU-QW; Tue, 20 May 2025 06:30:30 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uHKEt-00052F-3Q; Tue, 20 May 2025 06:30:29 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id B817E43BB1;
 Tue, 20 May 2025 12:30:20 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com, stefanha@redhat.com,
 eblake@redhat.com, jsnow@redhat.com, vsementsov@yandex-team.ru,
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, berto@igalia.com,
 fam@euphon.net, ari@tuxera.com
Subject: [PATCH v2 18/24] blockdev: drain while unlocked in
 external_snapshot_action()
Date: Tue, 20 May 2025 12:30:06 +0200
Message-Id: <20250520103012.424311-19-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250520103012.424311-1-f.ebner@proxmox.com>
References: <20250520103012.424311-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---

Changes in v2:
* Check that associated bs did not change with the drain.

 blockdev.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/blockdev.c b/blockdev.c
index 506755bef1..2e7fda6780 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1377,9 +1377,10 @@ static void external_snapshot_action(TransactionAction *action,
     const char *new_image_file;
     ExternalSnapshotState *state = g_new0(ExternalSnapshotState, 1);
     uint64_t perm, shared;
+    BlockDriverState *check_bs;
 
     /* TODO We'll eventually have to take a writer lock in this function */
-    GRAPH_RDLOCK_GUARD_MAINLOOP();
+    bdrv_graph_rdlock_main_loop();
 
     tran_add(tran, &external_snapshot_drv, state);
 
@@ -1412,11 +1413,25 @@ static void external_snapshot_action(TransactionAction *action,
 
     state->old_bs = bdrv_lookup_bs(device, node_name, errp);
     if (!state->old_bs) {
+        bdrv_graph_rdunlock_main_loop();
         return;
     }
 
+    /* Need to drain while unlocked. */
+    bdrv_graph_rdunlock_main_loop();
     /* Paired with .clean() */
     bdrv_drained_begin(state->old_bs);
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
+    /* Make sure the associated bs did not change with the drain. */
+    check_bs = bdrv_lookup_bs(device, node_name, errp);
+    if (state->old_bs != check_bs) {
+        if (check_bs) {
+            error_setg(errp, "Block node of device '%s' unexpectedly changed",
+                       device);
+        } /* else errp is already set */
+        return;
+    }
 
     if (!bdrv_is_inserted(state->old_bs)) {
         error_setg(errp, "Device '%s' has no medium",
-- 
2.39.5



