Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C955AC922E
	for <lists+qemu-devel@lfdr.de>; Fri, 30 May 2025 17:12:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uL1On-0002sJ-SZ; Fri, 30 May 2025 11:11:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uL1Oj-0002pe-3a; Fri, 30 May 2025 11:11:53 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uL1Og-0002EK-RO; Fri, 30 May 2025 11:11:52 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 28B654484B;
 Fri, 30 May 2025 17:11:40 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com, stefanha@redhat.com,
 eblake@redhat.com, jsnow@redhat.com, vsementsov@yandex-team.ru,
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, berto@igalia.com,
 fam@euphon.net, ari@tuxera.com
Subject: [PATCH v4 01/48] block: remove outdated comments about AioContext
 locking
Date: Fri, 30 May 2025 17:10:38 +0200
Message-Id: <20250530151125.955508-2-f.ebner@proxmox.com>
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

AioContext locking was removed in commit b49f4755c7 ("block: remove
AioContext locking").

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/block.c b/block.c
index f222e1a50a..a5399888ba 100644
--- a/block.c
+++ b/block.c
@@ -4359,8 +4359,6 @@ bdrv_recurse_has_child(BlockDriverState *bs, BlockDriverState *child)
  * bs_queue, or the existing bs_queue being used.
  *
  * bs is drained here and undrained by bdrv_reopen_queue_free().
- *
- * To be called with bs->aio_context locked.
  */
 static BlockReopenQueue * GRAPH_RDLOCK
 bdrv_reopen_queue_child(BlockReopenQueue *bs_queue, BlockDriverState *bs,
@@ -4519,7 +4517,6 @@ bdrv_reopen_queue_child(BlockReopenQueue *bs_queue, BlockDriverState *bs,
     return bs_queue;
 }
 
-/* To be called with bs->aio_context locked */
 BlockReopenQueue *bdrv_reopen_queue(BlockReopenQueue *bs_queue,
                                     BlockDriverState *bs,
                                     QDict *options, bool keep_old_opts)
@@ -7278,10 +7275,6 @@ bool bdrv_op_blocker_is_empty(BlockDriverState *bs)
     return true;
 }
 
-/*
- * Must not be called while holding the lock of an AioContext other than the
- * current one.
- */
 void bdrv_img_create(const char *filename, const char *fmt,
                      const char *base_filename, const char *base_fmt,
                      char *options, uint64_t img_size, int flags, bool quiet,
-- 
2.39.5



