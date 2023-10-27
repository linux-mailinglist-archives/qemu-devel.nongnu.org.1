Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B937D9DB2
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 17:58:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwPAN-00050d-Qs; Fri, 27 Oct 2023 11:54:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qwPAB-0003w8-60
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 11:54:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qwPA8-0002xW-85
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 11:54:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698422054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jl38o7KrgvZtj4eg7a/TDouHaS5kFEIXQFL4JOtaoac=;
 b=NWluw0O8K8th7v7KplURTqwlyTseDo0vMnnwDAE0cfC62/n0WEglBWGIiz/uf3hQLSw77N
 tjSj19KaWzBb5Cqcsc9gWlyontOBou61P+0zo9QvNkuxy2yoECrsvqu7iE5uzI3pkauFmy
 0FNktxaydnleq//zxoBeNB2duVVwAQo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-0q4kjAKCM6SP-apAgD8jYw-1; Fri, 27 Oct 2023 11:54:07 -0400
X-MC-Unique: 0q4kjAKCM6SP-apAgD8jYw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 23985857CE9;
 Fri, 27 Oct 2023 15:54:07 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E6D1B5027;
 Fri, 27 Oct 2023 15:54:05 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, eesposit@redhat.com,
 eblake@redhat.com, pbonzini@redhat.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org
Subject: [PATCH 18/24] blkverify: Add locking for request_fn
Date: Fri, 27 Oct 2023 17:53:27 +0200
Message-ID: <20231027155333.420094-19-kwolf@redhat.com>
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

This is either bdrv_co_preadv() or bdrv_co_pwritev() which both need to
have the graph locked. Annotate the function pointer accordingly and add
locking to its callers.

This shouldn't actually have resulted in a bug because the graph lock is
already held by blkverify_co_prwv(), which waits for the coroutines to
terminate. Annotate with GRAPH_RDLOCK as well to make this clearer.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/blkverify.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/block/blkverify.c b/block/blkverify.c
index dae9716a26..9ea2cb4cc5 100644
--- a/block/blkverify.c
+++ b/block/blkverify.c
@@ -33,8 +33,8 @@ typedef struct BlkverifyRequest {
     uint64_t bytes;
     int flags;
 
-    int (*request_fn)(BdrvChild *, int64_t, int64_t, QEMUIOVector *,
-                      BdrvRequestFlags);
+    int GRAPH_RDLOCK_PTR (*request_fn)(
+        BdrvChild *, int64_t, int64_t, QEMUIOVector *, BdrvRequestFlags);
 
     int ret;                    /* test image result */
     int raw_ret;                /* raw image result */
@@ -170,8 +170,11 @@ static void coroutine_fn blkverify_do_test_req(void *opaque)
     BlkverifyRequest *r = opaque;
     BDRVBlkverifyState *s = r->bs->opaque;
 
+    bdrv_graph_co_rdlock();
     r->ret = r->request_fn(s->test_file, r->offset, r->bytes, r->qiov,
                            r->flags);
+    bdrv_graph_co_rdunlock();
+
     r->done++;
     qemu_coroutine_enter_if_inactive(r->co);
 }
@@ -180,13 +183,16 @@ static void coroutine_fn blkverify_do_raw_req(void *opaque)
 {
     BlkverifyRequest *r = opaque;
 
+    bdrv_graph_co_rdlock();
     r->raw_ret = r->request_fn(r->bs->file, r->offset, r->bytes, r->raw_qiov,
                                r->flags);
+    bdrv_graph_co_rdunlock();
+
     r->done++;
     qemu_coroutine_enter_if_inactive(r->co);
 }
 
-static int coroutine_fn
+static int coroutine_fn GRAPH_RDLOCK
 blkverify_co_prwv(BlockDriverState *bs, BlkverifyRequest *r, uint64_t offset,
                   uint64_t bytes, QEMUIOVector *qiov, QEMUIOVector *raw_qiov,
                   int flags, bool is_write)
@@ -222,7 +228,7 @@ blkverify_co_prwv(BlockDriverState *bs, BlkverifyRequest *r, uint64_t offset,
     return r->ret;
 }
 
-static int coroutine_fn
+static int coroutine_fn GRAPH_RDLOCK
 blkverify_co_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
                     QEMUIOVector *qiov, BdrvRequestFlags flags)
 {
@@ -251,7 +257,7 @@ blkverify_co_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
     return ret;
 }
 
-static int coroutine_fn
+static int coroutine_fn GRAPH_RDLOCK
 blkverify_co_pwritev(BlockDriverState *bs, int64_t offset, int64_t bytes,
                      QEMUIOVector *qiov, BdrvRequestFlags flags)
 {
-- 
2.41.0


