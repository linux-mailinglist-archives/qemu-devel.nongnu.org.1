Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 757F27C7291
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 18:29:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqySp-0003Ze-2E; Thu, 12 Oct 2023 12:23:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qqySb-0003VS-9d
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 12:22:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qqySZ-0000Zv-9D
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 12:22:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697127766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xhRjK0CkJeSfmGW7btIs42sjpQGNMMyXDeiFbIv0svE=;
 b=dnVVjjKU6KZiGEkAoM7aUzR2+ENhvUG2mvfmU5LLrStXop5HAqDO8K0dNRRqMllydnE93J
 YqUoDFUQ+kTlEnNJCAK48Ufff1055ZNJiBiRaJDEaFLdB43O9N3woK9tvisSPyiCLg/0iC
 Mh+xhCKOVOoAisbZbd0MOmuYafF0eGY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-6M7Crlq-Pb20PrL-RJRqGQ-1; Thu, 12 Oct 2023 12:22:44 -0400
X-MC-Unique: 6M7Crlq-Pb20PrL-RJRqGQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BCC2381D9E2;
 Thu, 12 Oct 2023 16:22:43 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.192.233])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2C8922026831;
 Thu, 12 Oct 2023 16:22:43 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 10/26] block: Mark bdrv_parent_cb_resize() and callers
 GRAPH_RDLOCK
Date: Thu, 12 Oct 2023 18:22:08 +0200
Message-ID: <20231012162224.240535-11-kwolf@redhat.com>
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
bdrv_parent_cb_resize() need to hold a reader lock for the graph.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20230929145157.45443-7-kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/io.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/block/io.c b/block/io.c
index e2e846d37d..527a1de04e 100644
--- a/block/io.c
+++ b/block/io.c
@@ -42,7 +42,9 @@
 /* Maximum bounce buffer for copy-on-read and write zeroes, in bytes */
 #define MAX_BOUNCE_BUFFER (32768 << BDRV_SECTOR_BITS)
 
-static void bdrv_parent_cb_resize(BlockDriverState *bs);
+static void coroutine_fn GRAPH_RDLOCK
+bdrv_parent_cb_resize(BlockDriverState *bs);
+
 static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
     int64_t offset, int64_t bytes, BdrvRequestFlags flags);
 
@@ -2027,7 +2029,7 @@ bdrv_co_write_req_prepare(BdrvChild *child, int64_t offset, int64_t bytes,
     }
 }
 
-static inline void coroutine_fn
+static inline void coroutine_fn GRAPH_RDLOCK
 bdrv_co_write_req_finish(BdrvChild *child, int64_t offset, int64_t bytes,
                          BdrvTrackedRequest *req, int ret)
 {
@@ -3530,9 +3532,13 @@ int coroutine_fn bdrv_co_copy_range(BdrvChild *src, int64_t src_offset,
                                    bytes, read_flags, write_flags);
 }
 
-static void bdrv_parent_cb_resize(BlockDriverState *bs)
+static void coroutine_fn GRAPH_RDLOCK
+bdrv_parent_cb_resize(BlockDriverState *bs)
 {
     BdrvChild *c;
+
+    assert_bdrv_graph_readable();
+
     QLIST_FOREACH(c, &bs->parents, next_parent) {
         if (c->klass->resize) {
             c->klass->resize(c);
-- 
2.41.0


