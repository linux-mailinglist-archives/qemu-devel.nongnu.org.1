Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A66FF7C726F
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 18:25:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqySw-0003fM-Ai; Thu, 12 Oct 2023 12:23:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qqySt-0003dG-CW
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 12:23:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qqySb-0000dA-UI
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 12:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697127773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jEAQXZ7nPkyIQXMGmzvHo0o30n05BeF5a2ngP1GHsOg=;
 b=S8bqI28URVypWf42TvfOH56+DWSj0vcnXuIMB8PVd3bJd5p26iJARIrWsweTtNwtuE7NGR
 jD3gn0E6+xiDTMyUhX50+DRkXf7YzB6pc/FU8J5pCTfQoQAptN58hs1Naky8LVqBIUf8AH
 bBVOsaquGbWbthaRmZwNUtkihWULWQc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-16-pZvPFpIGNTWmBNmGlRwvaA-1; Thu, 12 Oct 2023 12:22:51 -0400
X-MC-Unique: pZvPFpIGNTWmBNmGlRwvaA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4DDBC8DBAE1;
 Thu, 12 Oct 2023 16:22:51 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.192.233])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B277B2026831;
 Thu, 12 Oct 2023 16:22:50 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 19/26] qcow2: Mark qcow2_inactivate() and callers GRAPH_RDLOCK
Date: Thu, 12 Oct 2023 18:22:17 +0200
Message-ID: <20231012162224.240535-20-kwolf@redhat.com>
In-Reply-To: <20231012162224.240535-1-kwolf@redhat.com>
References: <20231012162224.240535-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This adds GRAPH_RDLOCK annotations to declare that callers of
qcow2_inactivate() need to hold a reader lock for the graph because it
calls bdrv_get_device_or_node_name(), which accesses the parents list of
a node.

qcow2_do_close() is a bit strange because it is called from different
contexts. If close_data_file = true, we know that we were called from
non-coroutine main loop context (more specifically, we're coming from
qcow2_close()) and can safely drop the reader lock temporarily with
bdrv_graph_rdunlock_main_loop() and acquire the writer lock.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20230929145157.45443-16-kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 137c036ea4..aa01d9e7b5 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2737,14 +2737,12 @@ fail_nometa:
     return ret;
 }
 
-static int qcow2_inactivate(BlockDriverState *bs)
+static int GRAPH_RDLOCK qcow2_inactivate(BlockDriverState *bs)
 {
     BDRVQcow2State *s = bs->opaque;
     int ret, result = 0;
     Error *local_err = NULL;
 
-    assume_graph_lock(); /* FIXME */
-
     qcow2_store_persistent_dirty_bitmaps(bs, true, &local_err);
     if (local_err != NULL) {
         result = -EINVAL;
@@ -2774,7 +2772,8 @@ static int qcow2_inactivate(BlockDriverState *bs)
     return result;
 }
 
-static void qcow2_do_close(BlockDriverState *bs, bool close_data_file)
+static void coroutine_mixed_fn GRAPH_RDLOCK
+qcow2_do_close(BlockDriverState *bs, bool close_data_file)
 {
     BDRVQcow2State *s = bs->opaque;
     qemu_vfree(s->l1_table);
@@ -2801,18 +2800,24 @@ static void qcow2_do_close(BlockDriverState *bs, bool close_data_file)
     g_free(s->image_backing_format);
 
     if (close_data_file && has_data_file(bs)) {
+        GLOBAL_STATE_CODE();
+        bdrv_graph_rdunlock_main_loop();
         bdrv_graph_wrlock(NULL);
         bdrv_unref_child(bs, s->data_file);
         bdrv_graph_wrunlock();
         s->data_file = NULL;
+        bdrv_graph_rdlock_main_loop();
     }
 
     qcow2_refcount_close(bs);
     qcow2_free_snapshots(bs);
 }
 
-static void qcow2_close(BlockDriverState *bs)
+static void GRAPH_UNLOCKED qcow2_close(BlockDriverState *bs)
 {
+    GLOBAL_STATE_CODE();
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     qcow2_do_close(bs, true);
 }
 
-- 
2.41.0


