Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBE981C017
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 22:27:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGQWh-00077l-Ix; Thu, 21 Dec 2023 16:24:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rGQWb-0006un-CF
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 16:24:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rGQWY-00081Y-DS
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 16:24:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703193847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NsSWWyVtSV5YSYH4pxqsz3RLrng8hdq2TqSJEEQngak=;
 b=aQgX94YwNE9/aPlSY6OjW4fCOLtSbZ1SvrGeKwp9t6mK8yxGw99ViIhRQmhXSrqi0ZWhDD
 0Hxea2xXz/i74t1+9Uj1bjPBI9CJ5WdU0Ay8XlIw5xic54nXheNElyHXlFPFKmjsBA45gb
 +sj13hYUQGJHG+LyM9ki9zTsyh11FpQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-bAIws7FZNLabogNLNF1oMQ-1; Thu, 21 Dec 2023 16:24:06 -0500
X-MC-Unique: bAIws7FZNLabogNLNF1oMQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BE9D5833A06;
 Thu, 21 Dec 2023 21:24:05 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C9EBDC15968;
 Thu, 21 Dec 2023 21:24:03 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 07/33] virtio-blk: don't lock AioContext in the submission code
 path
Date: Thu, 21 Dec 2023 22:23:12 +0100
Message-ID: <20231221212339.164439-8-kwolf@redhat.com>
In-Reply-To: <20231221212339.164439-1-kwolf@redhat.com>
References: <20231221212339.164439-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.061,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Stefan Hajnoczi <stefanha@redhat.com>

There is no need to acquire the AioContext lock around blk_aio_*() or
blk_get_geometry() anymore. I/O plugging (defer_call()) also does not
require the AioContext lock anymore.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20230914140101.1065008-5-stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
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
2.43.0


