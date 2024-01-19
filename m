Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB5B832ADE
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 14:59:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQpOG-0004hb-Vh; Fri, 19 Jan 2024 08:58:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rQpOA-0004Uu-B9
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 08:58:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rQpO4-0000YD-5l
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 08:58:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705672702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+Rk6942XyH/VX2bOHvbeFM89fcGmgkQjl81ORVJ0QBY=;
 b=ae3/Lgpx8F6uWi8e2mgU8fbR7fmlgaWK8DP9Li0zDNT2Hz4oi9sror+XGCQobFEOIL3lLz
 WRZYI21nGZU/BOOLtuEG5phR6wriyumhX2jfcf555HiROTzqL8Fj5HPLve/Lukb1JrxB0s
 SMlFgVNxjq2kvnqpfQkXXGlZNyTYA8A=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-C-yg1EimOAmVbBbp8S_lyg-1; Fri,
 19 Jan 2024 08:58:21 -0500
X-MC-Unique: C-yg1EimOAmVbBbp8S_lyg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 27DA91C05134;
 Fri, 19 Jan 2024 13:58:21 +0000 (UTC)
Received: from localhost (unknown [10.39.195.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7F5BE492BE2;
 Fri, 19 Jan 2024 13:58:20 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/6] virtio-blk: restart s->rq reqs in vq AioContexts
Date: Fri, 19 Jan 2024 08:57:46 -0500
Message-ID: <20240119135748.270944-5-stefanha@redhat.com>
In-Reply-To: <20240119135748.270944-1-stefanha@redhat.com>
References: <20240119135748.270944-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

A virtio-blk device with the iothread-vq-mapping parameter has
per-virtqueue AioContexts. It is not thread-safe to process s->rq
requests in the BlockBackend AioContext since that may be different from
the virtqueue's AioContext to which this request belongs. The code
currently races and could crash.

Adapt virtio_blk_dma_restart_cb() to first split s->rq into per-vq lists
and then schedule a BH each vq's AioContext as necessary. This way
requests are safely processed in their vq's AioContext.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/block/virtio-blk.c | 44 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 11 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index e342cb2cfb..4525988d92 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1156,16 +1156,11 @@ static void virtio_blk_handle_output(VirtIODevice *vdev, VirtQueue *vq)
 
 static void virtio_blk_dma_restart_bh(void *opaque)
 {
-    VirtIOBlock *s = opaque;
+    VirtIOBlockReq *req = opaque;
+    VirtIOBlock *s = req->dev; /* we're called with at least one request */
 
-    VirtIOBlockReq *req;
     MultiReqBuffer mrb = {};
 
-    WITH_QEMU_LOCK_GUARD(&s->rq_lock) {
-        req = s->rq;
-        s->rq = NULL;
-    }
-
     while (req) {
         VirtIOBlockReq *next = req->next;
         if (virtio_blk_handle_request(req, &mrb)) {
@@ -1195,16 +1190,43 @@ static void virtio_blk_dma_restart_cb(void *opaque, bool running,
                                       RunState state)
 {
     VirtIOBlock *s = opaque;
+    uint16_t num_queues = s->conf.num_queues;
 
     if (!running) {
         return;
     }
 
-    /* Paired with dec in virtio_blk_dma_restart_bh() */
-    blk_inc_in_flight(s->conf.conf.blk);
+    /* Split the device-wide s->rq request list into per-vq request lists */
+    g_autofree VirtIOBlockReq **vq_rq = g_new0(VirtIOBlockReq *, num_queues);
+    VirtIOBlockReq *rq;
 
-    aio_bh_schedule_oneshot(blk_get_aio_context(s->conf.conf.blk),
-            virtio_blk_dma_restart_bh, s);
+    WITH_QEMU_LOCK_GUARD(&s->rq_lock) {
+        rq = s->rq;
+        s->rq = NULL;
+    }
+
+    while (rq) {
+        VirtIOBlockReq *next = rq->next;
+        uint16_t idx = virtio_get_queue_index(rq->vq);
+
+        rq->next = vq_rq[idx];
+        vq_rq[idx] = rq;
+        rq = next;
+    }
+
+    /* Schedule a BH to submit the requests in each vq's AioContext */
+    for (uint16_t i = 0; i < num_queues; i++) {
+        if (!vq_rq[i]) {
+            continue;
+        }
+
+        /* Paired with dec in virtio_blk_dma_restart_bh() */
+        blk_inc_in_flight(s->conf.conf.blk);
+
+        aio_bh_schedule_oneshot(s->vq_aio_context[i],
+                                virtio_blk_dma_restart_bh,
+                                vq_rq[i]);
+    }
 }
 
 static void virtio_blk_reset(VirtIODevice *vdev)
-- 
2.43.0


