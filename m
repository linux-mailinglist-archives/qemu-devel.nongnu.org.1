Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2058E7169B0
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 18:34:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q42IM-0000EV-QX; Tue, 30 May 2023 12:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q42HY-0006nP-V1
 for qemu-devel@nongnu.org; Tue, 30 May 2023 12:33:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q42HU-0008M1-JG
 for qemu-devel@nongnu.org; Tue, 30 May 2023 12:33:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685464387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vNX5d1MVjTiz6h8ElDqn9RxFOn0J+KmMVLk3KNi4vbk=;
 b=CWzbnKbP1IzwBqM+9dyMOwP0MAGCOp7czXJj2KFR1UBgHTyGCMBU6hv1slMReY8+yUbtFB
 ZueDx2jv9OiR06f2sGrcF3y7r9zcODZxckaYLzQSxNszdoYkkcyZOEEyPewLucrvjKqvDi
 hEY7moOPaTzif1Zlw1oO/ozjJgf48Fw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-479-GvmR2AiBPf-518At2W9WkA-1; Tue, 30 May 2023 12:32:57 -0400
X-MC-Unique: GvmR2AiBPf-518At2W9WkA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A6600800969;
 Tue, 30 May 2023 16:32:56 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.194.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E9738C154D3;
 Tue, 30 May 2023 16:32:55 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 10/32] block: Fix AioContext locking in bdrv_insert_node()
Date: Tue, 30 May 2023 18:32:17 +0200
Message-Id: <20230530163239.576632-11-kwolf@redhat.com>
In-Reply-To: <20230530163239.576632-1-kwolf@redhat.com>
References: <20230530163239.576632-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

While calling bdrv_new_open_driver_opts(), the main AioContext lock must
be held, not the lock of the AioContext of the block subtree it will be
added to afterwards.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20230525124713.401149-11-kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/block.c b/block.c
index 29dea3a6a1..ec65fcf732 100644
--- a/block.c
+++ b/block.c
@@ -5399,12 +5399,17 @@ static void bdrv_delete(BlockDriverState *bs)
  * empty set of options. The reference to the QDict belongs to the block layer
  * after the call (even on failure), so if the caller intends to reuse the
  * dictionary, it needs to use qobject_ref() before calling bdrv_open.
+ *
+ * The caller holds the AioContext lock for @bs. It must make sure that @bs
+ * stays in the same AioContext, i.e. @options must not refer to nodes in a
+ * different AioContext.
  */
 BlockDriverState *bdrv_insert_node(BlockDriverState *bs, QDict *options,
                                    int flags, Error **errp)
 {
     ERRP_GUARD();
     int ret;
+    AioContext *ctx = bdrv_get_aio_context(bs);
     BlockDriverState *new_node_bs = NULL;
     const char *drvname, *node_name;
     BlockDriver *drv;
@@ -5425,8 +5430,14 @@ BlockDriverState *bdrv_insert_node(BlockDriverState *bs, QDict *options,
 
     GLOBAL_STATE_CODE();
 
+    aio_context_release(ctx);
+    aio_context_acquire(qemu_get_aio_context());
     new_node_bs = bdrv_new_open_driver_opts(drv, node_name, options, flags,
                                             errp);
+    aio_context_release(qemu_get_aio_context());
+    aio_context_acquire(ctx);
+    assert(bdrv_get_aio_context(bs) == ctx);
+
     options = NULL; /* bdrv_new_open_driver() eats options */
     if (!new_node_bs) {
         error_prepend(errp, "Could not create node: ");
-- 
2.40.1


