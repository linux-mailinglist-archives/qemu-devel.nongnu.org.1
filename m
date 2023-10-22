Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D50D7D2227
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 11:24:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quUgG-0004Sc-Pz; Sun, 22 Oct 2023 05:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUgE-0004E7-70
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:23:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUg9-0000Of-8M
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:23:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697966604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n62ZCYLMWQB+v9G4ohwIMDOGfFG/zqXCKAbKv3KvAW8=;
 b=HOzcwkP2yZrVG3XVM8L8ufRQYVUjeF83BHPrtZP5ERqAPe78TdGiF/GOxT/9JidPNKmeBP
 iCOxoxeyXMIEJBgX1F5UhYaaueqoZtH1wHVfdxa8Rj5Hr2WE9IOlLZ313iLSUHl/pxpOtB
 Yp+kUgK8/U92jyvaVnU1fowG621Amj0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-nbk0nM2NPyS56RN93x-KGA-1; Sun, 22 Oct 2023 05:23:12 -0400
X-MC-Unique: nbk0nM2NPyS56RN93x-KGA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-407f9d07b41so14237055e9.0
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 02:23:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697966591; x=1698571391;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n62ZCYLMWQB+v9G4ohwIMDOGfFG/zqXCKAbKv3KvAW8=;
 b=fQndtVgHX2QSkvg+527WFsa/IoX278yiLXIwSmR1bidp4pJMruQZ22rWRCX6UqVavZ
 pLdQ9oAFGI5XhAC5fNtu2MlZlzXsOdWAgJsXUaXzH4KoOJuYrfvPsj6jcxcUUMy4aKw0
 nvEltZSD0c2YUNIi7WYQrMcEZoD5KI63Ea5X1XqBuVV+W08LzHDUAN1fKe55zu5ZBnZ1
 fEZdiQcILMgVZ9Bx8aA5C0pkVUd62jwsmP+ubXp0/g9d54wQLudh14zHzSNDXMiyY8Tb
 d4DISYcaWXwNv6uLlA4oI7b5IW71NdUOTRQ9AtxTUs+0uQroZRX4K7D0SdhWqO5o75O0
 A9Ng==
X-Gm-Message-State: AOJu0Yy22P5gLkE4dVwpuJhWG5tfcSzuNRPeP/MK/n65tfl2MwHZ/9I1
 Olz0aDgg6Snbpb31peOmpJaKmKP3gJuLk2sbm/kfI8NCQeFank5OTDQPktacwxhpRcr+sfVT2Aj
 nIJcMWcbSj87ZaX9zbPVCLdxVWgqqe6totkIAKBSR4fb9mm6ynW4KTMbzXNLVyQ3SB15o
X-Received: by 2002:a05:600c:3c87:b0:406:eef6:3540 with SMTP id
 bg7-20020a05600c3c8700b00406eef63540mr4671406wmb.0.1697966591027; 
 Sun, 22 Oct 2023 02:23:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnyxE7PiXwcXKGpeDw9yhldlAi2K7G1wsYSd5QDvDgJbBsrC5Iunl9f3Y/NZenfz7NxIXEBg==
X-Received: by 2002:a05:600c:3c87:b0:406:eef6:3540 with SMTP id
 bg7-20020a05600c3c8700b00406eef63540mr4671386wmb.0.1697966590559; 
 Sun, 22 Oct 2023 02:23:10 -0700 (PDT)
Received: from redhat.com ([2.52.1.53]) by smtp.gmail.com with ESMTPSA id
 p5-20020a05600c358500b004053a6b8c41sm6477353wmq.12.2023.10.22.02.22.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 02:23:09 -0700 (PDT)
Date: Sun, 22 Oct 2023 05:22:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PULL v3 16/62] vhost-user: do not send RESET_OWNER on device reset
Message-ID: <22d2464f7ee6242114733e62541eed14cde15977.1697966402.git.mst@redhat.com>
References: <cover.1697966402.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697966402.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Message-Id: <20231004014532.1228637-2-stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
---
 hw/scsi/vhost-user-scsi.c |  9 ---------
 hw/virtio/vhost-user.c    | 13 +++++++++----
 2 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index df6b66cc1a..78aef4765f 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -67,15 +67,6 @@ static void vhost_user_scsi_reset(VirtIODevice *vdev)
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
index 427ee0ebfb..f9414f03de 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1482,12 +1482,17 @@ static int vhost_user_reset_device(struct vhost_dev *dev)
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
MST


