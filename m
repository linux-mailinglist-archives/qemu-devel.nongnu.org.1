Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6FF717D93
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 13:05:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4JcT-0007kJ-CO; Wed, 31 May 2023 07:03:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q4Jby-0007Re-H6
 for qemu-devel@nongnu.org; Wed, 31 May 2023 07:03:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q4Jbu-0001gJ-07
 for qemu-devel@nongnu.org; Wed, 31 May 2023 07:03:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685530975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eP84yjY4yh8iUNxvdcXbErwPb+zs45cUJLLBTjlwO2A=;
 b=UYGOYj8RIt8TwydiGNcHzq8BLuZC4zW6qRwjIuGiubHHGGLV1SzwdWe7yQ1jVLZ5XtgzjF
 985l8rys8Fhx45GigoPMq7bEFv+Gce/W7Xh5CrvldQLuOXGxBximE2RH+NVSxuyKm5uNV0
 y6L75GAayiIQnxcXZxemKaeWLA2nfV0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-249-vs171-jgO3iC_gSbuSkhAw-1; Wed, 31 May 2023 07:02:54 -0400
X-MC-Unique: vs171-jgO3iC_gSbuSkhAw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B512C101A593;
 Wed, 31 May 2023 11:02:53 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BE8172029F6D;
 Wed, 31 May 2023 11:02:52 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, hreitz@redhat.com,
 eblake@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH 10/11] graph-lock: Unlock the AioContext while polling
Date: Wed, 31 May 2023 13:02:30 +0200
Message-Id: <20230531110231.262251-11-kwolf@redhat.com>
In-Reply-To: <20230531110231.262251-1-kwolf@redhat.com>
References: <20230531110231.262251-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
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

If the caller keeps the AioContext lock for a block node in an iothread,
polling in bdrv_graph_wrlock() deadlocks if the condition isn't
fulfilled immediately.

Now that all callers make sure to actually have the AioContext locked
when they call bdrv_replace_child_noperm() like they should, we can
change bdrv_graph_wrlock() to take a BlockDriverState whose AioContext
lock the caller holds (NULL if it doesn't) and unlock it temporarily
while polling.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/graph-lock.h |  6 ++++--
 block.c                    |  4 ++--
 block/graph-lock.c         | 23 ++++++++++++++++++++++-
 3 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/include/block/graph-lock.h b/include/block/graph-lock.h
index 7574a2de5b..7e04f98ff0 100644
--- a/include/block/graph-lock.h
+++ b/include/block/graph-lock.h
@@ -111,10 +111,12 @@ void unregister_aiocontext(AioContext *ctx);
  * The wrlock can only be taken from the main loop, with BQL held, as only the
  * main loop is allowed to modify the graph.
  *
+ * If @bs is non-NULL, its AioContext is temporarily released.
+ *
  * This function polls. Callers must not hold the lock of any AioContext other
- * than the current one.
+ * than the current one and the one of @bs.
  */
-void bdrv_graph_wrlock(void) TSA_ACQUIRE(graph_lock) TSA_NO_TSA;
+void bdrv_graph_wrlock(BlockDriverState *bs) TSA_ACQUIRE(graph_lock) TSA_NO_TSA;
 
 /*
  * bdrv_graph_wrunlock:
diff --git a/block.c b/block.c
index d5f8231f31..f94cee8930 100644
--- a/block.c
+++ b/block.c
@@ -2854,7 +2854,7 @@ uint64_t bdrv_qapi_perm_to_blk_perm(BlockPermission qapi_perm)
  * Replaces the node that a BdrvChild points to without updating permissions.
  *
  * If @new_bs is non-NULL, the parent of @child must already be drained through
- * @child.
+ * @child and the caller must hold the AioContext lock for @new_bs.
  */
 static void bdrv_replace_child_noperm(BdrvChild *child,
                                       BlockDriverState *new_bs)
@@ -2893,7 +2893,7 @@ static void bdrv_replace_child_noperm(BdrvChild *child,
     }
 
     /* TODO Pull this up into the callers to avoid polling here */
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock(new_bs);
     if (old_bs) {
         if (child->klass->detach) {
             child->klass->detach(child);
diff --git a/block/graph-lock.c b/block/graph-lock.c
index a92c6ae219..3bf2591dc4 100644
--- a/block/graph-lock.c
+++ b/block/graph-lock.c
@@ -110,8 +110,10 @@ static uint32_t reader_count(void)
 }
 #endif
 
-void bdrv_graph_wrlock(void)
+void bdrv_graph_wrlock(BlockDriverState *bs)
 {
+    AioContext *ctx = NULL;
+
     GLOBAL_STATE_CODE();
     /*
      * TODO Some callers hold an AioContext lock when this is called, which
@@ -120,7 +122,22 @@ void bdrv_graph_wrlock(void)
      */
 #if 0
     assert(!qatomic_read(&has_writer));
+#endif
+
+    /*
+     * Release only non-mainloop AioContext. The mainloop often relies on the
+     * BQL and doesn't lock the main AioContext before doing things.
+     */
+    if (bs) {
+        ctx = bdrv_get_aio_context(bs);
+        if (ctx != qemu_get_aio_context()) {
+            aio_context_release(ctx);
+        } else {
+            ctx = NULL;
+        }
+    }
 
+#if 0
     /* Make sure that constantly arriving new I/O doesn't cause starvation */
     bdrv_drain_all_begin_nopoll();
 
@@ -150,6 +167,10 @@ void bdrv_graph_wrlock(void)
 
     bdrv_drain_all_end();
 #endif
+
+    if (ctx) {
+        aio_context_acquire(bdrv_get_aio_context(bs));
+    }
 }
 
 void bdrv_graph_wrunlock(void)
-- 
2.40.1


