Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9698D7D9D8A
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 17:54:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwPAG-0004HJ-Q8; Fri, 27 Oct 2023 11:54:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qwPA4-0003cb-DM
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 11:54:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qwPA0-0002qh-4z
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 11:54:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698422046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8n1p1gBw9ivIpdFQwDES/eILOv+tD05l554oZG6yHTk=;
 b=Bp/rVhQ5QwiCfOJIUei6ii1ZhNS2Jx3/itQsrFVfUrisQeKAU9nErd1YDqShiJf09aWY4Z
 4nFJ1K7Qz/tLBdxSOECInHoYQVws4iWt9ZTRi6VsIuS4FQwxcgbjEH/WsVcrSIhOX7N5pe
 khmBfbCpNqeEKMQUHcztU3pKvGZUHjA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-9-Y_BfRiMN-aarNYkc4_HQ-1; Fri,
 27 Oct 2023 11:53:47 -0400
X-MC-Unique: 9-Y_BfRiMN-aarNYkc4_HQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 323622800B37;
 Fri, 27 Oct 2023 15:53:47 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 03CF85027;
 Fri, 27 Oct 2023 15:53:45 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, eesposit@redhat.com,
 eblake@redhat.com, pbonzini@redhat.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org
Subject: [PATCH 04/24] block: Mark bdrv_root_attach_child() GRAPH_WRLOCK
Date: Fri, 27 Oct 2023 17:53:13 +0200
Message-ID: <20231027155333.420094-5-kwolf@redhat.com>
In-Reply-To: <20231027155333.420094-1-kwolf@redhat.com>
References: <20231027155333.420094-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Instead of taking the writer lock internally, require callers to already
hold it when calling bdrv_root_attach_child(). These callers will
typically already hold the graph lock once the locking work is
completed, which means that they can't call functions that take it
internally.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block_int-global-state.h | 13 +++++++------
 block.c                                |  5 +----
 block/block-backend.c                  |  2 ++
 blockjob.c                             |  2 ++
 4 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/include/block/block_int-global-state.h b/include/block/block_int-global-state.h
index 074b677838..afce6c4416 100644
--- a/include/block/block_int-global-state.h
+++ b/include/block/block_int-global-state.h
@@ -196,12 +196,13 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
                             BlockCompletionFunc *cb, void *opaque,
                             JobTxn *txn, Error **errp);
 
-BdrvChild *bdrv_root_attach_child(BlockDriverState *child_bs,
-                                  const char *child_name,
-                                  const BdrvChildClass *child_class,
-                                  BdrvChildRole child_role,
-                                  uint64_t perm, uint64_t shared_perm,
-                                  void *opaque, Error **errp);
+BdrvChild * GRAPH_WRLOCK
+bdrv_root_attach_child(BlockDriverState *child_bs, const char *child_name,
+                       const BdrvChildClass *child_class,
+                       BdrvChildRole child_role,
+                       uint64_t perm, uint64_t shared_perm,
+                       void *opaque, Error **errp);
+
 void GRAPH_WRLOCK bdrv_root_unref_child(BdrvChild *child);
 
 void GRAPH_RDLOCK bdrv_get_cumulative_perm(BlockDriverState *bs, uint64_t *perm,
diff --git a/block.c b/block.c
index d85738b7dc..5f92eb4950 100644
--- a/block.c
+++ b/block.c
@@ -3214,8 +3214,6 @@ BdrvChild *bdrv_root_attach_child(BlockDriverState *child_bs,
 
     GLOBAL_STATE_CODE();
 
-    bdrv_graph_wrlock(child_bs);
-
     child = bdrv_attach_child_common(child_bs, child_name, child_class,
                                    child_role, perm, shared_perm, opaque,
                                    tran, errp);
@@ -3228,9 +3226,8 @@ BdrvChild *bdrv_root_attach_child(BlockDriverState *child_bs,
 
 out:
     tran_finalize(tran, ret);
-    bdrv_graph_wrunlock();
 
-    bdrv_unref(child_bs);
+    bdrv_schedule_unref(child_bs);
 
     return ret < 0 ? NULL : child;
 }
diff --git a/block/block-backend.c b/block/block-backend.c
index 53cf3bb8b8..075a0dfa95 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -931,10 +931,12 @@ int blk_insert_bs(BlockBackend *blk, BlockDriverState *bs, Error **errp)
     ThrottleGroupMember *tgm = &blk->public.throttle_group_member;
     GLOBAL_STATE_CODE();
     bdrv_ref(bs);
+    bdrv_graph_wrlock(bs);
     blk->root = bdrv_root_attach_child(bs, "root", &child_root,
                                        BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY,
                                        blk->perm, blk->shared_perm,
                                        blk, errp);
+    bdrv_graph_wrunlock();
     if (blk->root == NULL) {
         return -EPERM;
     }
diff --git a/blockjob.c b/blockjob.c
index 953dc1b6dc..48559fc154 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -248,8 +248,10 @@ int block_job_add_bdrv(BlockJob *job, const char *name, BlockDriverState *bs,
         }
         aio_context_acquire(ctx);
     }
+    bdrv_graph_wrlock(bs);
     c = bdrv_root_attach_child(bs, name, &child_job, 0, perm, shared_perm, job,
                                errp);
+    bdrv_graph_wrunlock();
     if (need_context_ops) {
         aio_context_release(ctx);
         if (job->job.aio_context != qemu_get_aio_context()) {
-- 
2.41.0


