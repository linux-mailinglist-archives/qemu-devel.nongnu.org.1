Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA1C7919CA
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 16:39:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdAhK-000263-7J; Mon, 04 Sep 2023 10:37:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qdAhI-00023e-20
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 10:37:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qdAhD-0001iW-1d
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 10:36:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693838214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OdoQiLz2BMc/nsOsbqK8huIaKJO8bkdXKGI8zqVOERM=;
 b=RZsbojqQoAn7kxz1mHO99M1nGv9Kg2Xvnws3V2ywz3ywvjW0T/l0SC5nEaYnM58uTm/VQw
 qpEOYwBWdKtqUzS01S78KplijF7M+KjXeoC+bE3UMWCiTO9sdojc2VMZVCSc+WYDO5a3Co
 d3uDMtTrr1YHQDdU4qwS/2zhFoHEw1s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-244-OhGw3KtrNZOavhvyyLa54A-1; Mon, 04 Sep 2023 10:36:53 -0400
X-MC-Unique: OhGw3KtrNZOavhvyyLa54A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AAE29912B62;
 Mon,  4 Sep 2023 14:36:52 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.211])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1C05C493114;
 Mon,  4 Sep 2023 14:36:52 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 04/14] block: change reqs_lock to QemuMutex
Date: Mon,  4 Sep 2023 16:36:33 +0200
Message-ID: <20230904143643.259916-5-kwolf@redhat.com>
In-Reply-To: <20230904143643.259916-1-kwolf@redhat.com>
References: <20230904143643.259916-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
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

From: Stefan Hajnoczi <stefanha@redhat.com>

CoMutex has poor performance when lock contention is high. The tracked
requests list is accessed frequently and performance suffers in QEMU
multi-queue block layer scenarios.

It is not necessary to use CoMutex for the requests lock. The lock is
always released across coroutine yield operations. It is held for
relatively short periods of time and it is not beneficial to yield when
the lock is held by another coroutine.

Change the lock type from CoMutex to QemuMutex to improve multi-queue
block layer performance. fio randread bs=4k iodepth=64 with 4 IOThreads
handling a virtio-blk device with 8 virtqueues improves from 254k to
517k IOPS (+203%). Full benchmark results and configuration details are
available here:
https://gitlab.com/stefanha/virt-playbooks/-/commit/980c40845d540e3669add1528739503c2e817b57

In the future we may wish to introduce thread-local tracked requests
lists to avoid lock contention completely. That would be much more
involved though.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20230808155852.2745350-3-stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block_int-common.h |  2 +-
 block.c                          |  4 +++-
 block/io.c                       | 24 ++++++++++++------------
 3 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index 74195c3004..7a1e678031 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -1231,7 +1231,7 @@ struct BlockDriverState {
     unsigned int write_gen;               /* Current data generation */
 
     /* Protected by reqs_lock.  */
-    CoMutex reqs_lock;
+    QemuMutex reqs_lock;
     QLIST_HEAD(, BdrvTrackedRequest) tracked_requests;
     CoQueue flush_queue;                  /* Serializing flush queue */
     bool active_flush_req;                /* Flush request in flight? */
diff --git a/block.c b/block.c
index 0af890f647..b79b1ce7fe 100644
--- a/block.c
+++ b/block.c
@@ -415,7 +415,7 @@ BlockDriverState *bdrv_new(void)
     for (i = 0; i < BLOCK_OP_TYPE_MAX; i++) {
         QLIST_INIT(&bs->op_blockers[i]);
     }
-    qemu_co_mutex_init(&bs->reqs_lock);
+    qemu_mutex_init(&bs->reqs_lock);
     qemu_mutex_init(&bs->dirty_bitmap_mutex);
     bs->refcnt = 1;
     bs->aio_context = qemu_get_aio_context();
@@ -5476,6 +5476,8 @@ static void bdrv_delete(BlockDriverState *bs)
 
     bdrv_close(bs);
 
+    qemu_mutex_destroy(&bs->reqs_lock);
+
     g_free(bs);
 }
 
diff --git a/block/io.c b/block/io.c
index 4f32d6aa6e..525c94b16a 100644
--- a/block/io.c
+++ b/block/io.c
@@ -591,9 +591,9 @@ static void coroutine_fn tracked_request_end(BdrvTrackedRequest *req)
         qatomic_dec(&req->bs->serialising_in_flight);
     }
 
-    qemu_co_mutex_lock(&req->bs->reqs_lock);
+    qemu_mutex_lock(&req->bs->reqs_lock);
     QLIST_REMOVE(req, list);
-    qemu_co_mutex_unlock(&req->bs->reqs_lock);
+    qemu_mutex_unlock(&req->bs->reqs_lock);
 
     /*
      * At this point qemu_co_queue_wait(&req->wait_queue, ...) won't be called
@@ -627,9 +627,9 @@ static void coroutine_fn tracked_request_begin(BdrvTrackedRequest *req,
 
     qemu_co_queue_init(&req->wait_queue);
 
-    qemu_co_mutex_lock(&bs->reqs_lock);
+    qemu_mutex_lock(&bs->reqs_lock);
     QLIST_INSERT_HEAD(&bs->tracked_requests, req, list);
-    qemu_co_mutex_unlock(&bs->reqs_lock);
+    qemu_mutex_unlock(&bs->reqs_lock);
 }
 
 static bool tracked_request_overlaps(BdrvTrackedRequest *req,
@@ -793,9 +793,9 @@ bdrv_wait_serialising_requests(BdrvTrackedRequest *self)
         return;
     }
 
-    qemu_co_mutex_lock(&bs->reqs_lock);
+    qemu_mutex_lock(&bs->reqs_lock);
     bdrv_wait_serialising_requests_locked(self);
-    qemu_co_mutex_unlock(&bs->reqs_lock);
+    qemu_mutex_unlock(&bs->reqs_lock);
 }
 
 void coroutine_fn bdrv_make_request_serialising(BdrvTrackedRequest *req,
@@ -803,12 +803,12 @@ void coroutine_fn bdrv_make_request_serialising(BdrvTrackedRequest *req,
 {
     IO_CODE();
 
-    qemu_co_mutex_lock(&req->bs->reqs_lock);
+    qemu_mutex_lock(&req->bs->reqs_lock);
 
     tracked_request_set_serialising(req, align);
     bdrv_wait_serialising_requests_locked(req);
 
-    qemu_co_mutex_unlock(&req->bs->reqs_lock);
+    qemu_mutex_unlock(&req->bs->reqs_lock);
 }
 
 int bdrv_check_qiov_request(int64_t offset, int64_t bytes,
@@ -3002,7 +3002,7 @@ int coroutine_fn bdrv_co_flush(BlockDriverState *bs)
         goto early_exit;
     }
 
-    qemu_co_mutex_lock(&bs->reqs_lock);
+    qemu_mutex_lock(&bs->reqs_lock);
     current_gen = qatomic_read(&bs->write_gen);
 
     /* Wait until any previous flushes are completed */
@@ -3012,7 +3012,7 @@ int coroutine_fn bdrv_co_flush(BlockDriverState *bs)
 
     /* Flushes reach this point in nondecreasing current_gen order.  */
     bs->active_flush_req = true;
-    qemu_co_mutex_unlock(&bs->reqs_lock);
+    qemu_mutex_unlock(&bs->reqs_lock);
 
     /* Write back all layers by calling one driver function */
     if (bs->drv->bdrv_co_flush) {
@@ -3100,11 +3100,11 @@ out:
         bs->flushed_gen = current_gen;
     }
 
-    qemu_co_mutex_lock(&bs->reqs_lock);
+    qemu_mutex_lock(&bs->reqs_lock);
     bs->active_flush_req = false;
     /* Return value is ignored - it's ok if wait queue is empty */
     qemu_co_queue_next(&bs->flush_queue);
-    qemu_co_mutex_unlock(&bs->reqs_lock);
+    qemu_mutex_unlock(&bs->reqs_lock);
 
 early_exit:
     bdrv_dec_in_flight(bs);
-- 
2.41.0


