Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F04FC7A06CD
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 16:02:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgmup-00080X-HV; Thu, 14 Sep 2023 10:01:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qgmuH-0007tw-5n
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 10:01:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qgmuB-00016t-RQ
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 10:01:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694700075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ggWYSS4tCysLcdQD+okbR5l6Rp8lQ+134dpLIuJ4Qkw=;
 b=KWoNIEY3nForrqARPSawXvXZR8Xkzl7Qxut5DJrLWqSfh082FP1CMA5pklWhJg8btZ9YOS
 ZkqEPSYCtFbUHOnzluKdMc7/xezSiCNEgiHBHWzK3hnBg1Ju1tLHwQA6JBKnspbKQjY+DW
 kAPNuclH3S320rzNiYHxaOhnOfhxAH8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-50-XQ3CJS9ZMSuYPN9I8yTznA-1; Thu, 14 Sep 2023 10:01:11 -0400
X-MC-Unique: XQ3CJS9ZMSuYPN9I8yTznA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E98B788B7AC;
 Thu, 14 Sep 2023 14:01:10 +0000 (UTC)
Received: from localhost (unknown [10.39.194.105])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6D7359A;
 Thu, 14 Sep 2023 14:01:10 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 <qemu-block@nongnu.org>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 4/4] virtio-blk: don't lock AioContext in the submission code
 path
Date: Thu, 14 Sep 2023 10:01:01 -0400
Message-ID: <20230914140101.1065008-5-stefanha@redhat.com>
In-Reply-To: <20230914140101.1065008-1-stefanha@redhat.com>
References: <20230914140101.1065008-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
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

There is no need to acquire the AioContext lock around blk_aio_*() or
blk_get_geometry() anymore. I/O plugging (defer_call()) also does not
require the AioContext lock anymore.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/block/virtio-blk.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index f5315df042..e110f9718b 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1111,7 +1111,6 @@ void virtio_blk_handle_vq(VirtIOBlock *s, VirtQueue *vq)
     MultiReqBuffer mrb = {};
     bool suppress_notifications = virtio_queue_get_notification(vq);
 
-    aio_context_acquire(blk_get_aio_context(s->blk));
     defer_call_begin();
 
     do {
@@ -1137,7 +1136,6 @@ void virtio_blk_handle_vq(VirtIOBlock *s, VirtQueue *vq)
     }
 
     defer_call_end();
-    aio_context_release(blk_get_aio_context(s->blk));
 }
 
 static void virtio_blk_handle_output(VirtIODevice *vdev, VirtQueue *vq)
@@ -1168,7 +1166,6 @@ static void virtio_blk_dma_restart_bh(void *opaque)
         s->rq = NULL;
     }
 
-    aio_context_acquire(blk_get_aio_context(s->conf.conf.blk));
     while (req) {
         VirtIOBlockReq *next = req->next;
         if (virtio_blk_handle_request(req, &mrb)) {
@@ -1192,8 +1189,6 @@ static void virtio_blk_dma_restart_bh(void *opaque)
 
     /* Paired with inc in virtio_blk_dma_restart_cb() */
     blk_dec_in_flight(s->conf.conf.blk);
-
-    aio_context_release(blk_get_aio_context(s->conf.conf.blk));
 }
 
 static void virtio_blk_dma_restart_cb(void *opaque, bool running,
-- 
2.41.0


