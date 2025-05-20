Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB6BABD4FF
	for <lists+qemu-devel@lfdr.de>; Tue, 20 May 2025 12:33:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHKFO-00009O-Lt; Tue, 20 May 2025 06:30:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uHKFF-00082n-FA; Tue, 20 May 2025 06:30:49 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uHKFD-00052K-GG; Tue, 20 May 2025 06:30:49 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id A1ABE43B8D;
 Tue, 20 May 2025 12:30:20 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com, stefanha@redhat.com,
 eblake@redhat.com, jsnow@redhat.com, vsementsov@yandex-team.ru,
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, berto@igalia.com,
 fam@euphon.net, ari@tuxera.com
Subject: [PATCH v2 14/24] block: move drain outside of quorum_add_child()
Date: Tue, 20 May 2025 12:30:02 +0200
Message-Id: <20250520103012.424311-15-f.ebner@proxmox.com>
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

This is part of resolving the deadlock mentioned in commit "block:
move draining out of bdrv_change_aio_context() and mark GRAPH_RDLOCK".

The quorum_add_child() callback runs under the graph lock, so it is
not allowed to drain. It is only called as the .bdrv_add_child()
callback, which is only called in the bdrv_add_child() function, which
also runs under the graph lock.

The bdrv_add_child() function is called by qmp_x_blockdev_change(),
where a drained section is introduced.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---

Changes in v2:
* Split up into smaller pieces, flesh out commit messages.

 block/quorum.c | 2 --
 blockdev.c     | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/quorum.c b/block/quorum.c
index ea17b0ec13..ed8ce801ee 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -1096,10 +1096,8 @@ quorum_add_child(BlockDriverState *bs, BlockDriverState *child_bs, Error **errp)
     /* We can safely add the child now */
     bdrv_ref(child_bs);
 
-    bdrv_drain_all_begin();
     child = bdrv_attach_child(bs, child_bs, indexstr, &child_of_bds,
                               BDRV_CHILD_DATA, errp);
-    bdrv_drain_all_end();
     if (child == NULL) {
         s->next_child_index--;
         return;
diff --git a/blockdev.c b/blockdev.c
index 750beba41f..bd5ca77619 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3531,6 +3531,7 @@ void qmp_x_blockdev_change(const char *parent, const char *child,
     BlockDriverState *parent_bs, *new_bs = NULL;
     BdrvChild *p_child;
 
+    bdrv_drain_all_begin();
     bdrv_graph_wrlock();
 
     parent_bs = bdrv_lookup_bs(parent, parent, errp);
@@ -3568,6 +3569,7 @@ void qmp_x_blockdev_change(const char *parent, const char *child,
 
 out:
     bdrv_graph_wrunlock();
+    bdrv_drain_all_end();
 }
 
 BlockJobInfoList *qmp_query_block_jobs(Error **errp)
-- 
2.39.5



