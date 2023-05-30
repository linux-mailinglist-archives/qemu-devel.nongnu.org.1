Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 968307169AD
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 18:34:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q42IG-0008MN-VR; Tue, 30 May 2023 12:33:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q42HY-0006mQ-Gc
 for qemu-devel@nongnu.org; Tue, 30 May 2023 12:33:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q42HU-0008KW-J4
 for qemu-devel@nongnu.org; Tue, 30 May 2023 12:33:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685464386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+7Wp8DiMjYAUrSaD97YErLoCGfd5rYj141d9403xFD4=;
 b=bUwZNOEBpm3Elj1y4lL8J8A1kDuEGzB5sqIP72hUOwtnrUfbTTtbBVI4XGrtxKyFdisrZQ
 7FIiTZEpKVyTB+WTDWsg7DCtfxGHa9kRwscXrpCtLQ9FdoCZ5Aulrb/B9Gd/MoScyXB7IH
 z3zHJaJGE7KC0NcBNPSf4GnScoxvSkw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-344-rN0FKSf2OMOGmc_SKOwnQw-1; Tue, 30 May 2023 12:33:02 -0400
X-MC-Unique: rN0FKSf2OMOGmc_SKOwnQw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4F9211C01E94;
 Tue, 30 May 2023 16:33:02 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.194.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 96DE4C15612;
 Tue, 30 May 2023 16:33:01 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 16/32] virtio-scsi: stop using aio_disable_external() during
 unplug
Date: Tue, 30 May 2023 18:32:23 +0200
Message-Id: <20230530163239.576632-17-kwolf@redhat.com>
In-Reply-To: <20230530163239.576632-1-kwolf@redhat.com>
References: <20230530163239.576632-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This patch is part of an effort to remove the aio_disable_external()
API because it does not fit in a multi-queue block layer world where
many AioContexts may be submitting requests to the same disk.

The SCSI emulation code is already in good shape to stop using
aio_disable_external(). It was only used by commit 9c5aad84da1c
("virtio-scsi: fixed virtio_scsi_ctx_check failed when detaching scsi
disk") to ensure that virtio_scsi_hotunplug() works while the guest
driver is submitting I/O.

Ensure virtio_scsi_hotunplug() is safe as follows:

1. qdev_simple_device_unplug_cb() -> qdev_unrealize() ->
   device_set_realized() calls qatomic_set(&dev->realized, false) so
   that future scsi_device_get() calls return NULL because they exclude
   SCSIDevices with realized=false.

   That means virtio-scsi will reject new I/O requests to this
   SCSIDevice with VIRTIO_SCSI_S_BAD_TARGET even while
   virtio_scsi_hotunplug() is still executing. We are protected against
   new requests!

2. scsi_qdev_unrealize() already contains a call to
   scsi_device_purge_requests() so that in-flight requests are cancelled
   synchronously. This ensures that no in-flight requests remain once
   qdev_simple_device_unplug_cb() returns.

Thanks to these two conditions we don't need aio_disable_external()
anymore.

Cc: Zhengui Li <lizhengui@huawei.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20230516190238.8401-5-stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/scsi/virtio-scsi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index ae314af3de..c1a7ea9ae2 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -1091,7 +1091,6 @@ static void virtio_scsi_hotunplug(HotplugHandler *hotplug_dev, DeviceState *dev,
     VirtIODevice *vdev = VIRTIO_DEVICE(hotplug_dev);
     VirtIOSCSI *s = VIRTIO_SCSI(vdev);
     SCSIDevice *sd = SCSI_DEVICE(dev);
-    AioContext *ctx = s->ctx ?: qemu_get_aio_context();
     VirtIOSCSIEventInfo info = {
         .event   = VIRTIO_SCSI_T_TRANSPORT_RESET,
         .reason  = VIRTIO_SCSI_EVT_RESET_REMOVED,
@@ -1101,9 +1100,7 @@ static void virtio_scsi_hotunplug(HotplugHandler *hotplug_dev, DeviceState *dev,
         },
     };
 
-    aio_disable_external(ctx);
     qdev_simple_device_unplug_cb(hotplug_dev, dev, errp);
-    aio_enable_external(ctx);
 
     if (s->ctx) {
         virtio_scsi_acquire(s);
-- 
2.40.1


