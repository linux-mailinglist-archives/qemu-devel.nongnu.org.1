Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4DA81BFFE
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 22:24:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGQWg-00073G-Bh; Thu, 21 Dec 2023 16:24:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rGQWa-0006te-49
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 16:24:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rGQWW-00081M-Od
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 16:24:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703193846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/1plhi7/rmQlLmF3SLPd2wso3aHYkXAnGPLJXWhvvOI=;
 b=G3RGjamX9QenPPDag75TL79u1XkAYASe2fGn9WTPsatwURAsTVOUh0qaauGLFIyrpC1r5J
 F0j/MAXwGOY4ZbImkPI0EeUlVFqlSe23a66+wFxVpTu2QDSFWXrJUqX6G/JJZb6FYI5/bN
 CMu5nGWSuYPNdpBFbfakctMR2WWgphI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-XFfHjnaHM0iNsqsuD4StjA-1; Thu, 21 Dec 2023 16:24:03 -0500
X-MC-Unique: XFfHjnaHM0iNsqsuD4StjA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3AD41185A783;
 Thu, 21 Dec 2023 21:24:03 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 75F8FC15968;
 Thu, 21 Dec 2023 21:24:01 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 06/33] virtio-blk: don't lock AioContext in the completion code
 path
Date: Thu, 21 Dec 2023 22:23:11 +0100
Message-ID: <20231221212339.164439-7-kwolf@redhat.com>
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

Nothing in the completion code path relies on the AioContext lock
anymore. Virtqueues are only accessed from one thread at any moment and
the s->rq global state is protected by its own lock now.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20230914140101.1065008-4-stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/block/virtio-blk.c | 34 ++++------------------------------
 1 file changed, 4 insertions(+), 30 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index ee38e089bc..f5315df042 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -105,7 +105,6 @@ static void virtio_blk_rw_complete(void *opaque, int ret)
     VirtIOBlock *s = next->dev;
     VirtIODevice *vdev = VIRTIO_DEVICE(s);
 
-    aio_context_acquire(blk_get_aio_context(s->conf.conf.blk));
     while (next) {
         VirtIOBlockReq *req = next;
         next = req->mr_next;
@@ -138,7 +137,6 @@ static void virtio_blk_rw_complete(void *opaque, int ret)
         block_acct_done(blk_get_stats(s->blk), &req->acct);
         virtio_blk_free_request(req);
     }
-    aio_context_release(blk_get_aio_context(s->conf.conf.blk));
 }
 
 static void virtio_blk_flush_complete(void *opaque, int ret)
@@ -146,19 +144,13 @@ static void virtio_blk_flush_complete(void *opaque, int ret)
     VirtIOBlockReq *req = opaque;
     VirtIOBlock *s = req->dev;
 
-    aio_context_acquire(blk_get_aio_context(s->conf.conf.blk));
-    if (ret) {
-        if (virtio_blk_handle_rw_error(req, -ret, 0, true)) {
-            goto out;
-        }
+    if (ret && virtio_blk_handle_rw_error(req, -ret, 0, true)) {
+        return;
     }
 
     virtio_blk_req_complete(req, VIRTIO_BLK_S_OK);
     block_acct_done(blk_get_stats(s->blk), &req->acct);
     virtio_blk_free_request(req);
-
-out:
-    aio_context_release(blk_get_aio_context(s->conf.conf.blk));
 }
 
 static void virtio_blk_discard_write_zeroes_complete(void *opaque, int ret)
@@ -168,11 +160,8 @@ static void virtio_blk_discard_write_zeroes_complete(void *opaque, int ret)
     bool is_write_zeroes = (virtio_ldl_p(VIRTIO_DEVICE(s), &req->out.type) &
                             ~VIRTIO_BLK_T_BARRIER) == VIRTIO_BLK_T_WRITE_ZEROES;
 
-    aio_context_acquire(blk_get_aio_context(s->conf.conf.blk));
-    if (ret) {
-        if (virtio_blk_handle_rw_error(req, -ret, false, is_write_zeroes)) {
-            goto out;
-        }
+    if (ret && virtio_blk_handle_rw_error(req, -ret, false, is_write_zeroes)) {
+        return;
     }
 
     virtio_blk_req_complete(req, VIRTIO_BLK_S_OK);
@@ -180,9 +169,6 @@ static void virtio_blk_discard_write_zeroes_complete(void *opaque, int ret)
         block_acct_done(blk_get_stats(s->blk), &req->acct);
     }
     virtio_blk_free_request(req);
-
-out:
-    aio_context_release(blk_get_aio_context(s->conf.conf.blk));
 }
 
 #ifdef __linux__
@@ -229,10 +215,8 @@ static void virtio_blk_ioctl_complete(void *opaque, int status)
     virtio_stl_p(vdev, &scsi->data_len, hdr->dxfer_len);
 
 out:
-    aio_context_acquire(blk_get_aio_context(s->conf.conf.blk));
     virtio_blk_req_complete(req, status);
     virtio_blk_free_request(req);
-    aio_context_release(blk_get_aio_context(s->conf.conf.blk));
     g_free(ioctl_req);
 }
 
@@ -672,7 +656,6 @@ static void virtio_blk_zone_report_complete(void *opaque, int ret)
 {
     ZoneCmdData *data = opaque;
     VirtIOBlockReq *req = data->req;
-    VirtIOBlock *s = req->dev;
     VirtIODevice *vdev = VIRTIO_DEVICE(req->dev);
     struct iovec *in_iov = data->in_iov;
     unsigned in_num = data->in_num;
@@ -763,10 +746,8 @@ static void virtio_blk_zone_report_complete(void *opaque, int ret)
     }
 
 out:
-    aio_context_acquire(blk_get_aio_context(s->conf.conf.blk));
     virtio_blk_req_complete(req, err_status);
     virtio_blk_free_request(req);
-    aio_context_release(blk_get_aio_context(s->conf.conf.blk));
     g_free(data->zone_report_data.zones);
     g_free(data);
 }
@@ -829,10 +810,8 @@ static void virtio_blk_zone_mgmt_complete(void *opaque, int ret)
         err_status = VIRTIO_BLK_S_ZONE_INVALID_CMD;
     }
 
-    aio_context_acquire(blk_get_aio_context(s->conf.conf.blk));
     virtio_blk_req_complete(req, err_status);
     virtio_blk_free_request(req);
-    aio_context_release(blk_get_aio_context(s->conf.conf.blk));
 }
 
 static int virtio_blk_handle_zone_mgmt(VirtIOBlockReq *req, BlockZoneOp op)
@@ -882,7 +861,6 @@ static void virtio_blk_zone_append_complete(void *opaque, int ret)
 {
     ZoneCmdData *data = opaque;
     VirtIOBlockReq *req = data->req;
-    VirtIOBlock *s = req->dev;
     VirtIODevice *vdev = VIRTIO_DEVICE(req->dev);
     int64_t append_sector, n;
     uint8_t err_status = VIRTIO_BLK_S_OK;
@@ -905,10 +883,8 @@ static void virtio_blk_zone_append_complete(void *opaque, int ret)
     trace_virtio_blk_zone_append_complete(vdev, req, append_sector, ret);
 
 out:
-    aio_context_acquire(blk_get_aio_context(s->conf.conf.blk));
     virtio_blk_req_complete(req, err_status);
     virtio_blk_free_request(req);
-    aio_context_release(blk_get_aio_context(s->conf.conf.blk));
     g_free(data);
 }
 
@@ -944,10 +920,8 @@ static int virtio_blk_handle_zone_append(VirtIOBlockReq *req,
     return 0;
 
 out:
-    aio_context_acquire(blk_get_aio_context(s->conf.conf.blk));
     virtio_blk_req_complete(req, err_status);
     virtio_blk_free_request(req);
-    aio_context_release(blk_get_aio_context(s->conf.conf.blk));
     return err_status;
 }
 
-- 
2.43.0


