Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 62914707526
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 00:12:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzPM1-0003ZJ-VA; Wed, 17 May 2023 18:10:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1pzPM0-0003Yy-Cm
 for qemu-devel@nongnu.org; Wed, 17 May 2023 18:10:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1pzPLy-0002SI-L9
 for qemu-devel@nongnu.org; Wed, 17 May 2023 18:10:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684361438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RXMA7sqy2vuXoTTqUl+VUv8v7FFhFPNT89EZySBaASY=;
 b=e8S3k/NQQUr+/Q52PVXxi9RUiPOH8ulNON7h0Nhd4Ewvpbi70kPdGP4T+NZ/MOm1FUdkaz
 kLiU7y2ExV9qAyFf5c2bi0gOKnmFUm/AreJ0nyFS/CSWjccRBESx9gIPZ2p8AxPudAyBnn
 aZ9I+zRlNO4HQ6uXYcHZNzfXtM7RHmI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-274-PzJp_SQIOtapVDQqpnz-qw-1; Wed, 17 May 2023 18:10:34 -0400
X-MC-Unique: PzJp_SQIOtapVDQqpnz-qw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BAB96857FB2;
 Wed, 17 May 2023 22:10:33 +0000 (UTC)
Received: from localhost (unknown [10.39.192.14])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1EF702166B31;
 Wed, 17 May 2023 22:10:32 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, Julia Suvorova <jusual@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Stefano Garzarella <sgarzare@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Paul Durrant <paul@xen.org>, Anthony Perard <anthony.perard@citrix.com>,
 Aarushi Mehta <mehta.aaru20@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH 3/6] block/blkio: convert to blk_io_plug_call() API
Date: Wed, 17 May 2023 18:10:19 -0400
Message-Id: <20230517221022.325091-4-stefanha@redhat.com>
In-Reply-To: <20230517221022.325091-1-stefanha@redhat.com>
References: <20230517221022.325091-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

Stop using the .bdrv_co_io_plug() API because it is not multi-queue
block layer friendly. Use the new blk_io_plug_call() API to batch I/O
submission instead.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/blkio.c | 40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/block/blkio.c b/block/blkio.c
index 0cdc99a729..f2a1dc1fb2 100644
--- a/block/blkio.c
+++ b/block/blkio.c
@@ -325,16 +325,28 @@ static void blkio_detach_aio_context(BlockDriverState *bs)
                        false, NULL, NULL, NULL, NULL, NULL);
 }
 
-/* Call with s->blkio_lock held to submit I/O after enqueuing a new request */
-static void blkio_submit_io(BlockDriverState *bs)
+/*
+ * Called by blk_io_unplug() or immediately if not plugged. Called without
+ * blkio_lock.
+ */
+static void blkio_unplug_fn(BlockDriverState *bs)
 {
-    if (qatomic_read(&bs->io_plugged) == 0) {
-        BDRVBlkioState *s = bs->opaque;
+    BDRVBlkioState *s = bs->opaque;
 
+    WITH_QEMU_LOCK_GUARD(&s->blkio_lock) {
         blkioq_do_io(s->blkioq, NULL, 0, 0, NULL);
     }
 }
 
+/*
+ * Schedule I/O submission after enqueuing a new request. Called without
+ * blkio_lock.
+ */
+static void blkio_submit_io(BlockDriverState *bs)
+{
+    blk_io_plug_call(blkio_unplug_fn, bs);
+}
+
 static int coroutine_fn
 blkio_co_pdiscard(BlockDriverState *bs, int64_t offset, int64_t bytes)
 {
@@ -345,9 +357,9 @@ blkio_co_pdiscard(BlockDriverState *bs, int64_t offset, int64_t bytes)
 
     WITH_QEMU_LOCK_GUARD(&s->blkio_lock) {
         blkioq_discard(s->blkioq, offset, bytes, &cod, 0);
-        blkio_submit_io(bs);
     }
 
+    blkio_submit_io(bs);
     qemu_coroutine_yield();
     return cod.ret;
 }
@@ -378,9 +390,9 @@ blkio_co_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
 
     WITH_QEMU_LOCK_GUARD(&s->blkio_lock) {
         blkioq_readv(s->blkioq, offset, iov, iovcnt, &cod, 0);
-        blkio_submit_io(bs);
     }
 
+    blkio_submit_io(bs);
     qemu_coroutine_yield();
 
     if (use_bounce_buffer) {
@@ -423,9 +435,9 @@ static int coroutine_fn blkio_co_pwritev(BlockDriverState *bs, int64_t offset,
 
     WITH_QEMU_LOCK_GUARD(&s->blkio_lock) {
         blkioq_writev(s->blkioq, offset, iov, iovcnt, &cod, blkio_flags);
-        blkio_submit_io(bs);
     }
 
+    blkio_submit_io(bs);
     qemu_coroutine_yield();
 
     if (use_bounce_buffer) {
@@ -444,9 +456,9 @@ static int coroutine_fn blkio_co_flush(BlockDriverState *bs)
 
     WITH_QEMU_LOCK_GUARD(&s->blkio_lock) {
         blkioq_flush(s->blkioq, &cod, 0);
-        blkio_submit_io(bs);
     }
 
+    blkio_submit_io(bs);
     qemu_coroutine_yield();
     return cod.ret;
 }
@@ -472,22 +484,13 @@ static int coroutine_fn blkio_co_pwrite_zeroes(BlockDriverState *bs,
 
     WITH_QEMU_LOCK_GUARD(&s->blkio_lock) {
         blkioq_write_zeroes(s->blkioq, offset, bytes, &cod, blkio_flags);
-        blkio_submit_io(bs);
     }
 
+    blkio_submit_io(bs);
     qemu_coroutine_yield();
     return cod.ret;
 }
 
-static void coroutine_fn blkio_co_io_unplug(BlockDriverState *bs)
-{
-    BDRVBlkioState *s = bs->opaque;
-
-    WITH_QEMU_LOCK_GUARD(&s->blkio_lock) {
-        blkio_submit_io(bs);
-    }
-}
-
 typedef enum {
     BMRR_OK,
     BMRR_SKIP,
@@ -1009,7 +1012,6 @@ static void blkio_refresh_limits(BlockDriverState *bs, Error **errp)
         .bdrv_co_pwritev         = blkio_co_pwritev, \
         .bdrv_co_flush_to_disk   = blkio_co_flush, \
         .bdrv_co_pwrite_zeroes   = blkio_co_pwrite_zeroes, \
-        .bdrv_co_io_unplug       = blkio_co_io_unplug, \
         .bdrv_refresh_limits     = blkio_refresh_limits, \
         .bdrv_register_buf       = blkio_register_buf, \
         .bdrv_unregister_buf     = blkio_unregister_buf, \
-- 
2.40.1


