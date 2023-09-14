Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E618A7A06C5
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 16:02:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgmuU-0007vf-Fl; Thu, 14 Sep 2023 10:01:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qgmuB-0007qT-Dc
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 10:01:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qgmu9-00016S-Lk
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 10:01:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694700073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=86KzCOvFJg2LMFfuLkPAliW+kHglL9eVmg7cS+AqMcE=;
 b=aWWC8CbYr/LJ4qP7qP1+relXQc2E7p90uVRuQNbQnbh09R8BYsz9hgl5oTOALSsXvVTMxa
 eP+tA8GUjDyhk4rMRDjFF31/FrMeTE54k0OD9Q3+awQ87tQOYWAPZdeKP8zXcLfMCIv+oo
 L+ZWl6Zoo/eEW9gXYVYVz10xycND/Xs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-189-D0DmRMC_Ozud6bEfO53eZw-1; Thu, 14 Sep 2023 10:01:09 -0400
X-MC-Unique: D0DmRMC_Ozud6bEfO53eZw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 10CE788B7A2;
 Thu, 14 Sep 2023 14:01:09 +0000 (UTC)
Received: from localhost (unknown [10.39.194.105])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8F1EE1054FC1;
 Thu, 14 Sep 2023 14:01:08 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 <qemu-block@nongnu.org>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 3/4] virtio-blk: don't lock AioContext in the completion code
 path
Date: Thu, 14 Sep 2023 10:01:00 -0400
Message-ID: <20230914140101.1065008-4-stefanha@redhat.com>
In-Reply-To: <20230914140101.1065008-1-stefanha@redhat.com>
References: <20230914140101.1065008-1-stefanha@redhat.com>
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

Nothing in the completion code path relies on the AioContext lock
anymore. Virtqueues are only accessed from one thread at any moment and
the s->rq global state is protected by its own lock now.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
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
2.41.0


