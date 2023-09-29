Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF857B362B
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 16:57:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmErA-0005ip-Bv; Fri, 29 Sep 2023 10:52:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qmEr7-0005hN-Fy
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 10:52:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qmEqm-0004f3-Rg
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 10:52:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695999136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/6wIV5G0eEDo4XQmlPm6sf3NQEj/JZ1pmtrh++bBJv8=;
 b=I0bUanqD29r/+HIZGkN+6qDwjQPwxsy6pLBMp0BsIA+AdgEm85XL7lIqp9olVsbp8sTNR4
 fD2MX4rmq0saiG/A6omqP2nuDj8EOMpY9BgMP7x8E7NlErozESwLB3zgi1tpY50l2RsDRe
 aA5AQVEY1j70tAd8wuSb9sp7hJ/0bm4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649-luT-y6RPOOiBZ_oD0nj9sg-1; Fri, 29 Sep 2023 10:52:12 -0400
X-MC-Unique: luT-y6RPOOiBZ_oD0nj9sg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2BB9E38041C5;
 Fri, 29 Sep 2023 14:52:12 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.159])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F09112026D4B;
 Fri, 29 Sep 2023 14:52:10 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, eesposit@redhat.com,
 eblake@redhat.com, pbonzini@redhat.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org
Subject: [PATCH 06/22] block: Mark bdrv_parent_cb_resize() and callers
 GRAPH_RDLOCK
Date: Fri, 29 Sep 2023 16:51:41 +0200
Message-ID: <20230929145157.45443-7-kwolf@redhat.com>
In-Reply-To: <20230929145157.45443-1-kwolf@redhat.com>
References: <20230929145157.45443-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
---
 block/io.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/block/io.c b/block/io.c
index 63f248d672..df3000bd52 100644
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
 
@@ -2026,7 +2028,7 @@ bdrv_co_write_req_prepare(BdrvChild *child, int64_t offset, int64_t bytes,
     }
 }
 
-static inline void coroutine_fn
+static inline void coroutine_fn GRAPH_RDLOCK
 bdrv_co_write_req_finish(BdrvChild *child, int64_t offset, int64_t bytes,
                          BdrvTrackedRequest *req, int ret)
 {
@@ -3575,9 +3577,13 @@ int coroutine_fn bdrv_co_copy_range(BdrvChild *src, int64_t src_offset,
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


