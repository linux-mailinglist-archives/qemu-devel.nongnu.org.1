Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C696D7B7662
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 03:47:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnqxa-0000wR-If; Tue, 03 Oct 2023 21:45:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qnqxN-0000uZ-6f
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 21:45:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qnqxK-0003RI-7s
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 21:45:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696383941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=shRHyR1nxnb2BQrxMeZmP1n/TeAPtkgV8J0Z5HKWjl4=;
 b=XRAn8CeqxhmClcdmDloA1LTzYFUtQDWU52nyiNab6jiApT2vHZVPlsjmqTbdAb6zCB5iqJ
 /txjB00kCpehF+PyEYaZNn1aB7mGfW8as6VsHJ8x1MrMKUc5oMUNqacT9SWhq0++ybAKCf
 bDLqE9b6HwIuOiuoXwQtlxxKoPoNoDg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-541-K3QLPWUvOvuj5gn-JxnULw-1; Tue, 03 Oct 2023 21:45:37 -0400
X-MC-Unique: K3QLPWUvOvuj5gn-JxnULw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CFB2D29AA39A;
 Wed,  4 Oct 2023 01:45:36 +0000 (UTC)
Received: from localhost (unknown [10.39.192.46])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4D10AC154CA;
 Wed,  4 Oct 2023 01:45:36 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, hreitz@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 eperezma@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v2 1/3] vhost-user: do not send RESET_OWNER on device reset
Date: Tue,  3 Oct 2023 21:45:30 -0400
Message-ID: <20231004014532.1228637-2-stefanha@redhat.com>
In-Reply-To: <20231004014532.1228637-1-stefanha@redhat.com>
References: <20231004014532.1228637-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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

The VHOST_USER_RESET_OWNER message is deprecated in the spec:

   This is no longer used. Used to be sent to request disabling all
   rings, but some back-ends interpreted it to also discard connection
   state (this interpretation would lead to bugs).  It is recommended
   that back-ends either ignore this message, or use it to disable all
   rings.

The only caller of vhost_user_reset_device() is vhost_user_scsi_reset().
It checks that F_RESET_DEVICE was negotiated before calling it:

  static void vhost_user_scsi_reset(VirtIODevice *vdev)
  {
      VHostSCSICommon *vsc = VHOST_SCSI_COMMON(vdev);
      struct vhost_dev *dev = &vsc->dev;

      /*
       * Historically, reset was not implemented so only reset devices
       * that are expecting it.
       */
      if (!virtio_has_feature(dev->protocol_features,
                              VHOST_USER_PROTOCOL_F_RESET_DEVICE)) {
          return;
      }

      if (dev->vhost_ops->vhost_reset_device) {
          dev->vhost_ops->vhost_reset_device(dev);
      }
  }

Therefore VHOST_USER_RESET_OWNER is actually never sent by
vhost_user_reset_device(). Remove the dead code. This effectively moves
the vhost-user protocol specific code from vhost-user-scsi.c into
vhost-user.c where it belongs.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/scsi/vhost-user-scsi.c |  9 ---------
 hw/virtio/vhost-user.c    | 13 +++++++++----
 2 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index ee99b19e7a..8582b2e8ab 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -71,15 +71,6 @@ static void vhost_user_scsi_reset(VirtIODevice *vdev)
     VHostSCSICommon *vsc = VHOST_SCSI_COMMON(vdev);
     struct vhost_dev *dev = &vsc->dev;
 
-    /*
-     * Historically, reset was not implemented so only reset devices
-     * that are expecting it.
-     */
-    if (!virtio_has_feature(dev->protocol_features,
-                            VHOST_USER_PROTOCOL_F_RESET_DEVICE)) {
-        return;
-    }
-
     if (dev->vhost_ops->vhost_reset_device) {
         dev->vhost_ops->vhost_reset_device(dev);
     }
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 8dcf049d42..7bed9ad7d5 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1492,12 +1492,17 @@ static int vhost_user_reset_device(struct vhost_dev *dev)
 {
     VhostUserMsg msg = {
         .hdr.flags = VHOST_USER_VERSION,
+        .hdr.request = VHOST_USER_RESET_DEVICE,
     };
 
-    msg.hdr.request = virtio_has_feature(dev->protocol_features,
-                                         VHOST_USER_PROTOCOL_F_RESET_DEVICE)
-        ? VHOST_USER_RESET_DEVICE
-        : VHOST_USER_RESET_OWNER;
+    /*
+     * Historically, reset was not implemented so only reset devices
+     * that are expecting it.
+     */
+    if (!virtio_has_feature(dev->protocol_features,
+                            VHOST_USER_PROTOCOL_F_RESET_DEVICE)) {
+        return -ENOSYS;
+    }
 
     return vhost_user_write(dev, &msg, NULL, 0);
 }
-- 
2.41.0


