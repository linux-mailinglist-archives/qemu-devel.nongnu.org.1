Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCE081C00D
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 22:26:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGQWn-0007hg-QR; Thu, 21 Dec 2023 16:24:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rGQWj-0007MN-CQ
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 16:24:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rGQWh-00084s-Ap
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 16:24:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703193858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HOlY/UHLpbwih8IlglS/FB+polD3t6sdyX3kh+yI1Ao=;
 b=QtU8xHBYuPcqxiF9oJE/E3l9zMR3dH0r+L8BtEXD0TteUscsI77XY7djySqf4Qz+j0g4d+
 RHtvmcgVhDYCuqF/DdvCuItJnM3+zluBRb+1pSNjd4AfnMOgLnNPvGYtL8sQZLxstJIsL4
 heBvOyOESuSh5ftWp2d8DsKoDk0PomI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-7bSGIw64N7-c18rE-N0_Fw-1; Thu, 21 Dec 2023 16:24:17 -0500
X-MC-Unique: 7bSGIw64N7-c18rE-N0_Fw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D2B3A88F561;
 Thu, 21 Dec 2023 21:24:16 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 266DBC15968;
 Thu, 21 Dec 2023 21:24:14 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 12/33] virtio-scsi: don't lock AioContext around
 virtio_queue_aio_attach_host_notifier()
Date: Thu, 21 Dec 2023 22:23:17 +0100
Message-ID: <20231221212339.164439-13-kwolf@redhat.com>
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

From: Stefan Hajnoczi <stefanha@redhat.com>

virtio_queue_aio_attach_host_notifier() does not require the AioContext
lock. Stop taking the lock and add an explicit smp_wmb() because we were
relying on the implicit barrier in the AioContext lock before.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20231204164259.1515217-3-stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/scsi/virtio-scsi-dataplane.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/hw/scsi/virtio-scsi-dataplane.c b/hw/scsi/virtio-scsi-dataplane.c
index 1e684beebe..135e23fe54 100644
--- a/hw/scsi/virtio-scsi-dataplane.c
+++ b/hw/scsi/virtio-scsi-dataplane.c
@@ -149,23 +149,17 @@ int virtio_scsi_dataplane_start(VirtIODevice *vdev)
 
     memory_region_transaction_commit();
 
-    /*
-     * These fields are visible to the IOThread so we rely on implicit barriers
-     * in aio_context_acquire() on the write side and aio_notify_accept() on
-     * the read side.
-     */
     s->dataplane_starting = false;
     s->dataplane_started = true;
+    smp_wmb(); /* paired with aio_notify_accept() */
 
     if (s->bus.drain_count == 0) {
-        aio_context_acquire(s->ctx);
         virtio_queue_aio_attach_host_notifier(vs->ctrl_vq, s->ctx);
         virtio_queue_aio_attach_host_notifier_no_poll(vs->event_vq, s->ctx);
 
         for (i = 0; i < vs->conf.num_queues; i++) {
             virtio_queue_aio_attach_host_notifier(vs->cmd_vqs[i], s->ctx);
         }
-        aio_context_release(s->ctx);
     }
     return 0;
 
-- 
2.43.0


