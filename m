Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2FF7C7267
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 18:24:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqyT9-0003oN-37; Thu, 12 Oct 2023 12:23:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qqyT6-0003ng-E6
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 12:23:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qqySi-0000g3-NH
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 12:23:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697127779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mE+TZ/5eyJTk91lDVBUR/Z7OwFCPvWJC1OIhkEinneQ=;
 b=cCp0Jc+ARW4RKHD+kJvm02rld58T6ckGmpNlAs7XjWcoEQZ3qgdRHIM5T2s/CeTHg3wvsc
 3EVzgt4u1H4pkfRFLeIzP33aNU72t/YL/SNWHN/V6IKpQlt4x0RSQUgev5fjbc2PN9pm5D
 t6Kln4wdI7paZ+WuxcAqlWvxO2VGcUA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-311-tkKEVATSOXSbt1DQtz4s-g-1; Thu, 12 Oct 2023 12:22:56 -0400
X-MC-Unique: tkKEVATSOXSbt1DQtz4s-g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2BE7C85828A;
 Thu, 12 Oct 2023 16:22:56 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.192.233])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 90C4A20296DB;
 Thu, 12 Oct 2023 16:22:55 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 25/26] block: Protect bs->children with graph_lock
Date: Thu, 12 Oct 2023 18:22:23 +0200
Message-ID: <20231012162224.240535-26-kwolf@redhat.com>
In-Reply-To: <20231012162224.240535-1-kwolf@redhat.com>
References: <20231012162224.240535-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Almost all functions that access the child links already take the graph
lock now. Add locking to the remaining users and finally annotate the
struct field itself as protected by the graph lock.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20230929145157.45443-22-kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block_int-common.h | 4 ++--
 block.c                          | 2 ++
 block/replication.c              | 3 ++-
 tests/unit/test-bdrv-drain.c     | 4 ++++
 4 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index 0e37acd976..b8d9d24f39 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -1042,7 +1042,7 @@ struct BdrvChild {
      */
     bool quiesced_parent;
 
-    QLIST_ENTRY(BdrvChild) next;
+    QLIST_ENTRY(BdrvChild GRAPH_RDLOCK_PTR) next;
     QLIST_ENTRY(BdrvChild GRAPH_RDLOCK_PTR) next_parent;
 };
 
@@ -1176,7 +1176,7 @@ struct BlockDriverState {
      * See also comment in include/block/block.h, to learn how backing and file
      * are connected with BdrvChildRole.
      */
-    QLIST_HEAD(, BdrvChild) children;
+    QLIST_HEAD(, BdrvChild GRAPH_RDLOCK_PTR) children;
     BdrvChild *backing;
     BdrvChild *file;
 
diff --git a/block.c b/block.c
index 2ac7406c77..f9cf05ddcf 100644
--- a/block.c
+++ b/block.c
@@ -2973,6 +2973,8 @@ static void bdrv_child_free(BdrvChild *child)
 {
     assert(!child->bs);
     GLOBAL_STATE_CODE();
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     assert(!child->next.le_prev); /* not in children list */
 
     g_free(child->name);
diff --git a/block/replication.c b/block/replication.c
index 3459f50669..d522c7396f 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -430,7 +430,8 @@ static void backup_job_completed(void *opaque, int ret)
     backup_job_cleanup(bs);
 }
 
-static bool check_top_bs(BlockDriverState *top_bs, BlockDriverState *bs)
+static bool GRAPH_RDLOCK
+check_top_bs(BlockDriverState *top_bs, BlockDriverState *bs)
 {
     BdrvChild *child;
 
diff --git a/tests/unit/test-bdrv-drain.c b/tests/unit/test-bdrv-drain.c
index d734829778..f67e9df01c 100644
--- a/tests/unit/test-bdrv-drain.c
+++ b/tests/unit/test-bdrv-drain.c
@@ -1034,9 +1034,13 @@ static void coroutine_fn test_co_delete_by_drain(void *opaque)
         blk_co_unref(blk);
     } else {
         BdrvChild *c, *next_c;
+        bdrv_graph_co_rdlock();
         QLIST_FOREACH_SAFE(c, &bs->children, next, next_c) {
+            bdrv_graph_co_rdunlock();
             bdrv_co_unref_child(bs, c);
+            bdrv_graph_co_rdlock();
         }
+        bdrv_graph_co_rdunlock();
     }
 
     dbdd->done = true;
-- 
2.41.0


