Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E25977CFAE3
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:23:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtSyS-0005ks-CR; Thu, 19 Oct 2023 09:22:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qtSwQ-0004UI-9f; Thu, 19 Oct 2023 09:20:05 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qtSwM-0004Gc-Vt; Thu, 19 Oct 2023 09:19:58 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 4047E430E7;
 Thu, 19 Oct 2023 15:19:41 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, vsementsov@yandex-team.ru, jsnow@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com,
 t.lamprecht@proxmox.com
Subject: [PATCH 2/3] block: avoid potential deadlock during
 bdrv_graph_wrlock() in bdrv_close()
Date: Thu, 19 Oct 2023 15:19:35 +0200
Message-Id: <20231019131936.414246-3-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231019131936.414246-1-f.ebner@proxmox.com>
References: <20231019131936.414246-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

by passing the BlockDriverState along, so the held AioContext can be
dropped before polling. See commit 31b2ddfea3 ("graph-lock: Unlock the
AioContext while polling") which introduced this functionality for
more information.

The only way to reach bdrv_close() is via bdrv_unref() and for calling
that the BlockDriverState's AioContext lock is supposed to be held.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---

Is it safe to expect callers of bdrv_unref() to hold the appropriate
AioContext lock?

 block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block.c b/block.c
index f9cf05ddcf..a527aa1a4c 100644
--- a/block.c
+++ b/block.c
@@ -5200,7 +5200,7 @@ static void bdrv_close(BlockDriverState *bs)
         bs->drv = NULL;
     }
 
-    bdrv_graph_wrlock(NULL);
+    bdrv_graph_wrlock(bs);
     QLIST_FOREACH_SAFE(child, &bs->children, next, next) {
         bdrv_unref_child(bs, child);
     }
-- 
2.39.2



