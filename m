Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AE6710C5D
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 14:49:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2AOD-0000HY-0U; Thu, 25 May 2023 08:48:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q2ANv-0008Gh-Vj
 for qemu-devel@nongnu.org; Thu, 25 May 2023 08:48:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q2ANs-00021C-SK
 for qemu-devel@nongnu.org; Thu, 25 May 2023 08:48:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685018857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dFC09pXA9tuh88zbKA5lHFRjabbl46zk18uGxqCNxas=;
 b=JVJOgY+EUPRQwc+KiBmuWJQLnn9RQZlBHKcgGYRITHiFl8kgk2rS9+7RWq5XTMbnGfESaW
 P9GNrmO25cAWdpubDhJT+UV7b8VDM+1qsKnTwhqxROfCpQ+G64xLqmQGpIT2buwEAw+AHO
 I4VS3JU4XjROkQKVh6hOIPcKtvhtpak=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-103-O7GXs3ihOX2PTvee5DScmw-1; Thu, 25 May 2023 08:47:35 -0400
X-MC-Unique: O7GXs3ihOX2PTvee5DScmw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8FC212A59541;
 Thu, 25 May 2023 12:47:35 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.166])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8C7F47AF5;
 Thu, 25 May 2023 12:47:34 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, hreitz@redhat.com,
 eblake@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH 10/12] block: Fix AioContext locking in bdrv_insert_node()
Date: Thu, 25 May 2023 14:47:11 +0200
Message-Id: <20230525124713.401149-11-kwolf@redhat.com>
In-Reply-To: <20230525124713.401149-1-kwolf@redhat.com>
References: <20230525124713.401149-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

While calling bdrv_new_open_driver_opts(), the main AioContext lock must
be held, not the lock of the AioContext of the block subtree it will be
added to afterwards.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/block.c b/block.c
index e368a43761..d8cc145b77 100644
--- a/block.c
+++ b/block.c
@@ -5393,12 +5393,17 @@ static void bdrv_delete(BlockDriverState *bs)
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
@@ -5419,8 +5424,14 @@ BlockDriverState *bdrv_insert_node(BlockDriverState *bs, QDict *options,
 
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


