Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C3470E2A7
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 19:14:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1VZe-0004cN-Rx; Tue, 23 May 2023 13:13:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q1VZY-0004Xk-V2
 for qemu-devel@nongnu.org; Tue, 23 May 2023 13:13:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q1VZX-00032o-8B
 for qemu-devel@nongnu.org; Tue, 23 May 2023 13:13:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684861998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3FPGvS4E8XhJl458NpT+4AaqENtWEqDNIS9t7Nd8CmQ=;
 b=EesUVfQ6n503Cqx9uB61hT85qWlbV6147STBzL37tFf+/mOxvLmibMY1x6vbPgh0R7ANdr
 7NXwvrQpTF8FvHXbiMb0R6furkNFjl+7ipDP3M2xEZb+FGboD/iVXuYpcfrkdxhceJkfVU
 2LCUu3IiaR0N88ylnZo4bVHLnr7un94=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-179-gp84_tuxOQSN9WPS2-uenQ-1; Tue, 23 May 2023 13:13:16 -0400
X-MC-Unique: gp84_tuxOQSN9WPS2-uenQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 60B711C08784;
 Tue, 23 May 2023 17:13:15 +0000 (UTC)
Received: from localhost (unknown [10.39.195.107])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D1EC01121314;
 Tue, 23 May 2023 17:13:14 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Aarushi Mehta <mehta.aaru20@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Fam Zheng <fam@euphon.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 xen-devel@lists.xenproject.org, eblake@redhat.com,
 Anthony Perard <anthony.perard@citrix.com>, qemu-block@nongnu.org
Subject: [PATCH v2 5/6] block/linux-aio: convert to blk_io_plug_call() API
Date: Tue, 23 May 2023 13:12:59 -0400
Message-Id: <20230523171300.132347-6-stefanha@redhat.com>
In-Reply-To: <20230523171300.132347-1-stefanha@redhat.com>
References: <20230523171300.132347-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/block/raw-aio.h |  7 -------
 block/file-posix.c      | 28 ----------------------------
 block/linux-aio.c       | 41 +++++++++++------------------------------
 3 files changed, 11 insertions(+), 65 deletions(-)

diff --git a/include/block/raw-aio.h b/include/block/raw-aio.h
index da60ca13ef..0f63c2800c 100644
--- a/include/block/raw-aio.h
+++ b/include/block/raw-aio.h
@@ -62,13 +62,6 @@ int coroutine_fn laio_co_submit(int fd, uint64_t offset, QEMUIOVector *qiov,
 
 void laio_detach_aio_context(LinuxAioState *s, AioContext *old_context);
 void laio_attach_aio_context(LinuxAioState *s, AioContext *new_context);
-
-/*
- * laio_io_plug/unplug work in the thread's current AioContext, therefore the
- * caller must ensure that they are paired in the same IOThread.
- */
-void laio_io_plug(void);
-void laio_io_unplug(uint64_t dev_max_batch);
 #endif
 /* io_uring.c - Linux io_uring implementation */
 #ifdef CONFIG_LINUX_IO_URING
diff --git a/block/file-posix.c b/block/file-posix.c
index 7baa8491dd..ac1ed54811 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2550,26 +2550,6 @@ static int coroutine_fn raw_co_pwritev(BlockDriverState *bs, int64_t offset,
     return raw_co_prw(bs, offset, bytes, qiov, QEMU_AIO_WRITE);
 }
 
-static void coroutine_fn raw_co_io_plug(BlockDriverState *bs)
-{
-    BDRVRawState __attribute__((unused)) *s = bs->opaque;
-#ifdef CONFIG_LINUX_AIO
-    if (s->use_linux_aio) {
-        laio_io_plug();
-    }
-#endif
-}
-
-static void coroutine_fn raw_co_io_unplug(BlockDriverState *bs)
-{
-    BDRVRawState __attribute__((unused)) *s = bs->opaque;
-#ifdef CONFIG_LINUX_AIO
-    if (s->use_linux_aio) {
-        laio_io_unplug(s->aio_max_batch);
-    }
-#endif
-}
-
 static int coroutine_fn raw_co_flush_to_disk(BlockDriverState *bs)
 {
     BDRVRawState *s = bs->opaque;
@@ -3914,8 +3894,6 @@ BlockDriver bdrv_file = {
     .bdrv_co_copy_range_from = raw_co_copy_range_from,
     .bdrv_co_copy_range_to  = raw_co_copy_range_to,
     .bdrv_refresh_limits = raw_refresh_limits,
-    .bdrv_co_io_plug        = raw_co_io_plug,
-    .bdrv_co_io_unplug      = raw_co_io_unplug,
     .bdrv_attach_aio_context = raw_aio_attach_aio_context,
 
     .bdrv_co_truncate                   = raw_co_truncate,
@@ -4286,8 +4264,6 @@ static BlockDriver bdrv_host_device = {
     .bdrv_co_copy_range_from = raw_co_copy_range_from,
     .bdrv_co_copy_range_to  = raw_co_copy_range_to,
     .bdrv_refresh_limits = raw_refresh_limits,
-    .bdrv_co_io_plug        = raw_co_io_plug,
-    .bdrv_co_io_unplug      = raw_co_io_unplug,
     .bdrv_attach_aio_context = raw_aio_attach_aio_context,
 
     .bdrv_co_truncate                   = raw_co_truncate,
@@ -4424,8 +4400,6 @@ static BlockDriver bdrv_host_cdrom = {
     .bdrv_co_pwritev        = raw_co_pwritev,
     .bdrv_co_flush_to_disk  = raw_co_flush_to_disk,
     .bdrv_refresh_limits    = cdrom_refresh_limits,
-    .bdrv_co_io_plug        = raw_co_io_plug,
-    .bdrv_co_io_unplug      = raw_co_io_unplug,
     .bdrv_attach_aio_context = raw_aio_attach_aio_context,
 
     .bdrv_co_truncate                   = raw_co_truncate,
@@ -4552,8 +4526,6 @@ static BlockDriver bdrv_host_cdrom = {
     .bdrv_co_pwritev        = raw_co_pwritev,
     .bdrv_co_flush_to_disk  = raw_co_flush_to_disk,
     .bdrv_refresh_limits    = cdrom_refresh_limits,
-    .bdrv_co_io_plug        = raw_co_io_plug,
-    .bdrv_co_io_unplug      = raw_co_io_unplug,
     .bdrv_attach_aio_context = raw_aio_attach_aio_context,
 
     .bdrv_co_truncate                   = raw_co_truncate,
diff --git a/block/linux-aio.c b/block/linux-aio.c
index 442c86209b..5021aed68f 100644
--- a/block/linux-aio.c
+++ b/block/linux-aio.c
@@ -15,6 +15,7 @@
 #include "qemu/event_notifier.h"
 #include "qemu/coroutine.h"
 #include "qapi/error.h"
+#include "sysemu/block-backend.h"
 
 /* Only used for assertions.  */
 #include "qemu/coroutine_int.h"
@@ -46,7 +47,6 @@ struct qemu_laiocb {
 };
 
 typedef struct {
-    int plugged;
     unsigned int in_queue;
     unsigned int in_flight;
     bool blocked;
@@ -236,7 +236,7 @@ static void qemu_laio_process_completions_and_submit(LinuxAioState *s)
 {
     qemu_laio_process_completions(s);
 
-    if (!s->io_q.plugged && !QSIMPLEQ_EMPTY(&s->io_q.pending)) {
+    if (!QSIMPLEQ_EMPTY(&s->io_q.pending)) {
         ioq_submit(s);
     }
 }
@@ -277,7 +277,6 @@ static void qemu_laio_poll_ready(EventNotifier *opaque)
 static void ioq_init(LaioQueue *io_q)
 {
     QSIMPLEQ_INIT(&io_q->pending);
-    io_q->plugged = 0;
     io_q->in_queue = 0;
     io_q->in_flight = 0;
     io_q->blocked = false;
@@ -354,31 +353,11 @@ static uint64_t laio_max_batch(LinuxAioState *s, uint64_t dev_max_batch)
     return max_batch;
 }
 
-void laio_io_plug(void)
+static void laio_unplug_fn(void *opaque)
 {
-    AioContext *ctx = qemu_get_current_aio_context();
-    LinuxAioState *s = aio_get_linux_aio(ctx);
+    LinuxAioState *s = opaque;
 
-    s->io_q.plugged++;
-}
-
-void laio_io_unplug(uint64_t dev_max_batch)
-{
-    AioContext *ctx = qemu_get_current_aio_context();
-    LinuxAioState *s = aio_get_linux_aio(ctx);
-
-    assert(s->io_q.plugged);
-    s->io_q.plugged--;
-
-    /*
-     * Why max batch checking is performed here:
-     * Another BDS may have queued requests with a higher dev_max_batch and
-     * therefore in_queue could now exceed our dev_max_batch. Re-check the max
-     * batch so we can honor our device's dev_max_batch.
-     */
-    if (s->io_q.in_queue >= laio_max_batch(s, dev_max_batch) ||
-        (!s->io_q.plugged &&
-         !s->io_q.blocked && !QSIMPLEQ_EMPTY(&s->io_q.pending))) {
+    if (!s->io_q.blocked && !QSIMPLEQ_EMPTY(&s->io_q.pending)) {
         ioq_submit(s);
     }
 }
@@ -410,10 +389,12 @@ static int laio_do_submit(int fd, struct qemu_laiocb *laiocb, off_t offset,
 
     QSIMPLEQ_INSERT_TAIL(&s->io_q.pending, laiocb, next);
     s->io_q.in_queue++;
-    if (!s->io_q.blocked &&
-        (!s->io_q.plugged ||
-         s->io_q.in_queue >= laio_max_batch(s, dev_max_batch))) {
-        ioq_submit(s);
+    if (!s->io_q.blocked) {
+        if (s->io_q.in_queue >= laio_max_batch(s, dev_max_batch)) {
+            ioq_submit(s);
+        } else {
+            blk_io_plug_call(laio_unplug_fn, s);
+        }
     }
 
     return 0;
-- 
2.40.1


