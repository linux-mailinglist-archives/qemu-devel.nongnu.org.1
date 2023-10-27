Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D68077D9D97
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 17:56:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwPAJ-0004ZC-OC; Fri, 27 Oct 2023 11:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qwPA8-0003hL-DX
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 11:54:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qwPA0-0002ql-9d
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 11:54:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698422046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gpL/KtmpVIqThlM8BLmlN6PH2UjUT2DtdwR9cJu4xJs=;
 b=BEHR8HPACxRw0vGaUch4WSmnIX15wKmP6SmXex+4JxAhNACyHMSsqQVQXPhRmxDhvSR4S8
 fv+RbyrtQ/bm8vKlavX8Ry+If1Ba3SgYHyjsq4lOG5/lDH/EL1V3paOssjHFeF8GAARw0G
 eFxZZANqBfF5hNv71k4nFXo9twDvRDY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-REorJkxLOeCmvFk5mNRDEw-1; Fri, 27 Oct 2023 11:54:03 -0400
X-MC-Unique: REorJkxLOeCmvFk5mNRDEw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D9069101A52D;
 Fri, 27 Oct 2023 15:54:02 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AAFE05027;
 Fri, 27 Oct 2023 15:54:01 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, eesposit@redhat.com,
 eblake@redhat.com, pbonzini@redhat.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org
Subject: [PATCH 15/24] block: Mark bdrv_replace_node_common() GRAPH_WRLOCK
Date: Fri, 27 Oct 2023 17:53:24 +0200
Message-ID: <20231027155333.420094-16-kwolf@redhat.com>
In-Reply-To: <20231027155333.420094-1-kwolf@redhat.com>
References: <20231027155333.420094-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
hold it when calling bdrv_replace_node_common(). Basically everthing in
the function needs the lock and its callers may already want to hold the
graph lock and so wouldn't be able to call functions that take it
internally.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 68 ++++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 43 insertions(+), 25 deletions(-)

diff --git a/block.c b/block.c
index dc43e36f69..c7409cf658 100644
--- a/block.c
+++ b/block.c
@@ -5412,6 +5412,9 @@ bdrv_replace_node_noperm(BlockDriverState *from,
 }
 
 /*
+ * Switch all parents of @from to point to @to instead. @from and @to must be in
+ * the same AioContext and both must be drained.
+ *
  * With auto_skip=true bdrv_replace_node_common skips updating from parents
  * if it creates a parent-child relation loop or if parent is block-job.
  *
@@ -5421,10 +5424,9 @@ bdrv_replace_node_noperm(BlockDriverState *from,
  * With @detach_subchain=true @to must be in a backing chain of @from. In this
  * case backing link of the cow-parent of @to is removed.
  */
-static int bdrv_replace_node_common(BlockDriverState *from,
-                                    BlockDriverState *to,
-                                    bool auto_skip, bool detach_subchain,
-                                    Error **errp)
+static int GRAPH_WRLOCK
+bdrv_replace_node_common(BlockDriverState *from, BlockDriverState *to,
+                         bool auto_skip, bool detach_subchain, Error **errp)
 {
     Transaction *tran = tran_new();
     g_autoptr(GSList) refresh_list = NULL;
@@ -5433,16 +5435,9 @@ static int bdrv_replace_node_common(BlockDriverState *from,
 
     GLOBAL_STATE_CODE();
 
-    /* Make sure that @from doesn't go away until we have successfully attached
-     * all of its parents to @to. */
-    bdrv_ref(from);
-
-    assert(qemu_get_current_aio_context() == qemu_get_aio_context());
+    assert(from->quiesce_counter);
+    assert(to->quiesce_counter);
     assert(bdrv_get_aio_context(from) == bdrv_get_aio_context(to));
-    bdrv_drained_begin(from);
-    bdrv_drained_begin(to);
-
-    bdrv_graph_wrlock(to);
 
     if (detach_subchain) {
         assert(bdrv_chain_contains(from, to));
@@ -5483,33 +5478,51 @@ static int bdrv_replace_node_common(BlockDriverState *from,
 
 out:
     tran_finalize(tran, ret);
-    bdrv_graph_wrunlock();
-
-    bdrv_drained_end(to);
-    bdrv_drained_end(from);
-    bdrv_unref(from);
-
     return ret;
 }
 
 int bdrv_replace_node(BlockDriverState *from, BlockDriverState *to,
                       Error **errp)
 {
+    int ret;
+
     GLOBAL_STATE_CODE();
 
-    return bdrv_replace_node_common(from, to, true, false, errp);
+    /* Make sure that @from doesn't go away until we have successfully attached
+     * all of its parents to @to. */
+    bdrv_ref(from);
+    bdrv_drained_begin(from);
+    bdrv_drained_begin(to);
+    bdrv_graph_wrlock(to);
+
+    ret = bdrv_replace_node_common(from, to, true, false, errp);
+
+    bdrv_graph_wrunlock();
+    bdrv_drained_end(to);
+    bdrv_drained_end(from);
+    bdrv_unref(from);
+
+    return ret;
 }
 
 int bdrv_drop_filter(BlockDriverState *bs, Error **errp)
 {
     BlockDriverState *child_bs;
+    int ret;
 
     GLOBAL_STATE_CODE();
+
     bdrv_graph_rdlock_main_loop();
     child_bs = bdrv_filter_or_cow_bs(bs);
     bdrv_graph_rdunlock_main_loop();
 
-    return bdrv_replace_node_common(bs, child_bs, true, true, errp);
+    bdrv_drained_begin(child_bs);
+    bdrv_graph_wrlock(bs);
+    ret = bdrv_replace_node_common(bs, child_bs, true, true, errp);
+    bdrv_graph_wrunlock();
+    bdrv_drained_end(child_bs);
+
+    return ret;
 }
 
 /*
@@ -5957,15 +5970,15 @@ int bdrv_drop_intermediate(BlockDriverState *top, BlockDriverState *base,
 
     bdrv_ref(top);
     bdrv_drained_begin(base);
-    bdrv_graph_rdlock_main_loop();
+    bdrv_graph_wrlock(base);
 
     if (!top->drv || !base->drv) {
-        goto exit;
+        goto exit_wrlock;
     }
 
     /* Make sure that base is in the backing chain of top */
     if (!bdrv_chain_contains(top, base)) {
-        goto exit;
+        goto exit_wrlock;
     }
 
     /* If 'base' recursively inherits from 'top' then we should set
@@ -5997,6 +6010,8 @@ int bdrv_drop_intermediate(BlockDriverState *top, BlockDriverState *base,
      * That's a FIXME.
      */
     bdrv_replace_node_common(top, base, false, false, &local_err);
+    bdrv_graph_wrunlock();
+
     if (local_err) {
         error_report_err(local_err);
         goto exit;
@@ -6029,8 +6044,11 @@ int bdrv_drop_intermediate(BlockDriverState *top, BlockDriverState *base,
     }
 
     ret = 0;
+    goto exit;
+
+exit_wrlock:
+    bdrv_graph_wrunlock();
 exit:
-    bdrv_graph_rdunlock_main_loop();
     bdrv_drained_end(base);
     bdrv_unref(top);
     return ret;
-- 
2.41.0


