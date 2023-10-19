Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B86AB7CFAE1
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:23:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtSyW-0005wo-Br; Thu, 19 Oct 2023 09:22:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qtSwQ-0004UM-C1; Thu, 19 Oct 2023 09:20:05 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qtSwO-0004Ge-OD; Thu, 19 Oct 2023 09:19:58 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 40EE4430E8;
 Thu, 19 Oct 2023 15:19:41 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, vsementsov@yandex-team.ru, jsnow@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com,
 t.lamprecht@proxmox.com
Subject: [PATCH 1/3] blockjob: drop AioContext lock before calling
 bdrv_graph_wrlock()
Date: Thu, 19 Oct 2023 15:19:34 +0200
Message-Id: <20231019131936.414246-2-f.ebner@proxmox.com>
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

Same rationale as in 31b2ddfea3 ("graph-lock: Unlock the AioContext
while polling"). Otherwise, a deadlock can happen.

The alternative would be to pass a BlockDriverState along to
bdrv_graph_wrlock(), but there is no BlockDriverState readily
available and it's also better conceptually, because the lock is held
for the job.

The function is always called with the job's AioContext lock held, via
one of the .abort, .clean, .free or .prepare job driver functions.
Thus, it's safe to drop it.

While mirror_exit_common() does hold a second AioContext lock while
calling block_job_remove_all_bdrv(), that is for the main thread's
AioContext and does not need to be dropped (bdrv_graph_wrlock(bs) also
skips dropping the lock if bdrv_get_aio_context(bs) ==
qemu_get_aio_context()).

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---
 blockjob.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/blockjob.c b/blockjob.c
index 807f992b59..953dc1b6dc 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -198,7 +198,9 @@ void block_job_remove_all_bdrv(BlockJob *job)
      * one to make sure that such a concurrent access does not attempt
      * to process an already freed BdrvChild.
      */
+    aio_context_release(job->job.aio_context);
     bdrv_graph_wrlock(NULL);
+    aio_context_acquire(job->job.aio_context);
     while (job->nodes) {
         GSList *l = job->nodes;
         BdrvChild *c = l->data;
-- 
2.39.2



