Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDC4836D4C
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 18:27:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRy4G-0005kB-0j; Mon, 22 Jan 2024 12:26:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rRy4D-0005jW-7s
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 12:26:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rRy4A-0001TA-Mg
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 12:26:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705944394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=9kBXs81mqglvKyOPFJWJBRYqq0XhlWSlS1HFKMbhSWo=;
 b=cix5mYsyGgehpnN2i70znkhOvMbI5pdJpbn30XT7aW2UrtPx1Rwl23Wa8Wf4Cstjx90a6a
 LPuFqYc4hxG9q9DM+6Oe2R7Od9v3TXSqPheaZqys68iBPqexKitcTcsxDZC3baSL41+btw
 91BQY9vJo5vruTCRh/xT+TOPxE5Ehcc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-zUqOTiA9MV6WXC-_PPvpYw-1; Mon, 22 Jan 2024 12:26:31 -0500
X-MC-Unique: zUqOTiA9MV6WXC-_PPvpYw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A464C87281C;
 Mon, 22 Jan 2024 17:26:27 +0000 (UTC)
Received: from localhost (unknown [10.39.194.240])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 02CA91530;
 Mon, 22 Jan 2024 17:26:26 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: <qemu-block@nongnu.org>, <qemu-stable@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH] virtio-blk: avoid using ioeventfd state in irqfd conditional
Date: Mon, 22 Jan 2024 12:26:25 -0500
Message-ID: <20240122172625.415386-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.289,
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

Requests that complete in an IOThread use irqfd to notify the guest
while requests that complete in the main loop thread use the traditional
qdev irq code path. The reason for this conditional is that the irq code
path requires the BQL:

  if (s->ioeventfd_started && !s->ioeventfd_disabled) {
      virtio_notify_irqfd(vdev, req->vq);
  } else {
      virtio_notify(vdev, req->vq);
  }

There is a corner case where the conditional invokes the irq code path
instead of the irqfd code path:

  static void virtio_blk_stop_ioeventfd(VirtIODevice *vdev)
  {
      ...
      /*
       * Set ->ioeventfd_started to false before draining so that host notifiers
       * are not detached/attached anymore.
       */
      s->ioeventfd_started = false;

      /* Wait for virtio_blk_dma_restart_bh() and in flight I/O to complete */
      blk_drain(s->conf.conf.blk);

During blk_drain() the conditional produces the wrong result because
ioeventfd_started is false.

Use qemu_in_iothread() instead of checking the ioeventfd state.

Buglink: https://issues.redhat.com/browse/RHEL-15394
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
Based-on: https://repo.or.cz/qemu/kevin.git/shortlog/c14962c3ea6f0998d028142ed14affcb9dfccf28

Stable backport notes: dataplane_started is being renamed to
ioeventfd_started in the next block pull request. This patch can be
safely applied to -stable although the variable name has changed and
git-am will complain.

 hw/block/virtio-blk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 227d83569f..287c31ee3c 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -64,7 +64,7 @@ static void virtio_blk_req_complete(VirtIOBlockReq *req, unsigned char status)
     iov_discard_undo(&req->inhdr_undo);
     iov_discard_undo(&req->outhdr_undo);
     virtqueue_push(req->vq, &req->elem, req->in_len);
-    if (s->ioeventfd_started && !s->ioeventfd_disabled) {
+    if (qemu_in_iothread()) {
         virtio_notify_irqfd(vdev, req->vq);
     } else {
         virtio_notify(vdev, req->vq);
-- 
2.43.0


