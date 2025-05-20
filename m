Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A698ABD4ED
	for <lists+qemu-devel@lfdr.de>; Tue, 20 May 2025 12:31:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHKFF-0007oc-Vw; Tue, 20 May 2025 06:30:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uHKEt-0006mv-50; Tue, 20 May 2025 06:30:27 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uHKEr-00051K-Ai; Tue, 20 May 2025 06:30:26 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id AEB0543B18;
 Tue, 20 May 2025 12:30:18 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com, stefanha@redhat.com,
 eblake@redhat.com, jsnow@redhat.com, vsementsov@yandex-team.ru,
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, berto@igalia.com,
 fam@euphon.net, ari@tuxera.com
Subject: [PATCH v2 07/24] block: mark bdrv_child_change_aio_context()
 GRAPH_RDLOCK
Date: Tue, 20 May 2025 12:29:55 +0200
Message-Id: <20250520103012.424311-8-f.ebner@proxmox.com>
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

This is a small step in preparation to mark bdrv_drained_begin() as
GRAPH_UNLOCKED. More concretely, it is in preparatoin to move the
drain out of bdrv_change_aio_context() and marking that function as
GRAPH_RDLOCK.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---

New in v2.

 include/block/block-global-state.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/block/block-global-state.h b/include/block/block-global-state.h
index 9be34b3c99..aad160956a 100644
--- a/include/block/block-global-state.h
+++ b/include/block/block-global-state.h
@@ -274,9 +274,10 @@ int bdrv_debug_remove_breakpoint(BlockDriverState *bs, const char *tag);
 int bdrv_debug_resume(BlockDriverState *bs, const char *tag);
 bool bdrv_debug_is_suspended(BlockDriverState *bs, const char *tag);
 
-bool bdrv_child_change_aio_context(BdrvChild *c, AioContext *ctx,
-                                   GHashTable *visited, Transaction *tran,
-                                   Error **errp);
+bool GRAPH_RDLOCK
+bdrv_child_change_aio_context(BdrvChild *c, AioContext *ctx,
+                              GHashTable *visited, Transaction *tran,
+                              Error **errp);
 int bdrv_try_change_aio_context(BlockDriverState *bs, AioContext *ctx,
                                 BdrvChild *ignore_child, Error **errp);
 
-- 
2.39.5



