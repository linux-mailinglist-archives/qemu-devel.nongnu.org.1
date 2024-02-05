Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E3984A0B3
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Feb 2024 18:28:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rX2kX-0008Tk-34; Mon, 05 Feb 2024 12:27:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rX2kU-0008Si-9h
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 12:27:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rX2kS-0006Oa-8G
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 12:27:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707154031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iAGCvQx28RrLJakkek/T62S1VRBhS+KJNVJlhZaHy24=;
 b=fp9E2h9lDB4aJMuN59DtNnyPKIw4VUdFRwNVDvH8Dey1fRFwvVMvtPpp9Eu/3zVSPSC8UF
 3QSNHNOeT+nzXm5AiGV81Dk8vk7nTe+hv6DgtJCIXzTfoOvZSXy9bhS9dAjq0LpioQbtrR
 eRoniCDsM2CpOMpBPPU3ibGaFdW60v8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-6-qU1hgiJTOumHvQJHYM0ajw-1; Mon,
 05 Feb 2024 12:27:09 -0500
X-MC-Unique: qU1hgiJTOumHvQJHYM0ajw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C2CD2299E741;
 Mon,  5 Feb 2024 17:27:08 +0000 (UTC)
Received: from localhost (unknown [10.39.192.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 339541C060AF;
 Mon,  5 Feb 2024 17:27:07 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org
Subject: [PATCH 3/5] virtio-blk: add vq_rq[] bounds check in
 virtio_blk_dma_restart_cb()
Date: Mon,  5 Feb 2024 12:26:57 -0500
Message-ID: <20240205172659.476970-4-stefanha@redhat.com>
In-Reply-To: <20240205172659.476970-1-stefanha@redhat.com>
References: <20240205172659.476970-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.285,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hanna Czenczek <hreitz@redhat.com> noted that the array index in
virtio_blk_dma_restart_cb() is not bounds-checked:

  g_autofree VirtIOBlockReq **vq_rq = g_new0(VirtIOBlockReq *, num_queues);
  ...
  while (rq) {
      VirtIOBlockReq *next = rq->next;
      uint16_t idx = virtio_get_queue_index(rq->vq);

      rq->next = vq_rq[idx];
                 ^^^^^^^^^^

The code is correct because both rq->vq and vq_rq[] depend on
num_queues, but this is indirect and not 100% obvious. Add an assertion.

Suggested-by: Hanna Czenczek <hreitz@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/block/virtio-blk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index a0735a9bca..f3193f4b75 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1209,6 +1209,7 @@ static void virtio_blk_dma_restart_cb(void *opaque, bool running,
         VirtIOBlockReq *next = rq->next;
         uint16_t idx = virtio_get_queue_index(rq->vq);
 
+        assert(idx < num_queues);
         rq->next = vq_rq[idx];
         vq_rq[idx] = rq;
         rq = next;
-- 
2.43.0


