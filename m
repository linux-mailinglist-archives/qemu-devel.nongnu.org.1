Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8637CE21E
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 18:05:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8wd-00013z-T4; Wed, 18 Oct 2023 11:58:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8u8-0003Lt-Ie
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:56:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8u7-0006xF-1N
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:56:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697644574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n62ZCYLMWQB+v9G4ohwIMDOGfFG/zqXCKAbKv3KvAW8=;
 b=h6MPsRSwexB1piUbv1g4SgLlXCKXC3QmZqMaOukHxSP7dlVwex9KkFvPF8ZcHax8TAtt6M
 yAjOOQfI6Zp8w6Z/6qRRYDCosPKGth+xmtYmTVaW6kJ4tquMdz4myZpmP4ZTDmUK+vt2yE
 ZpMtOFJy2atVMNkaS3YK/0aLGdzlCFc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-rqgZ_0V4N_milR0Z4MKygg-1; Wed, 18 Oct 2023 11:56:13 -0400
X-MC-Unique: rqgZ_0V4N_milR0Z4MKygg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4053a5c6a59so44803295e9.3
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 08:56:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697644571; x=1698249371;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n62ZCYLMWQB+v9G4ohwIMDOGfFG/zqXCKAbKv3KvAW8=;
 b=X/837KvuataE/IufwmsBySsXikf5IbGRzxc4eC8Wyhh210QJ9YPpV0tC3EGnYNI1JG
 /FrPyEExp4okCDfDrHTWSgfrb5A6Fax3cFqMzzoqj65VcRD8BHxLyg5XUTpEMB6EaHzs
 xW2CVXAMagKMdSzQkvQ2D+bxHbbsUBtwEWpysrbkhz0iciw40bXEsz4998uJn9f3c1yF
 3I8JBPOML0omV7tztCHcvFDXAmS05eJQQKF+ujRrBTJaaqUkEgMDEsboFeWzJaLtiQZp
 LtIhndLeE97QrjxXNfFP/ZvyKAZNPl4IQvWY051rOepCPDzbsGUonUjuP65v0FQFhrgB
 rxpg==
X-Gm-Message-State: AOJu0Yy8JzQNYv3CaVHxOTAVh2/dS6qXqbjJERtKP1yZxBRZRc+N4phR
 jO9LY9Z0czSBXIJ5NJBY4xKPT/dVSCGEqOH7+I7doRQL5QVXvHKvQ8AFfV0TJ5oucyhEqJZM0qm
 dxW99UO0f3BlWXrN3N/T99qFRvqVaLhio+peMKvTSZ5mQJthjqCyX9EUuqEXaTRBqG+wq+JM=
X-Received: by 2002:a05:600c:46c6:b0:406:7d74:a2a6 with SMTP id
 q6-20020a05600c46c600b004067d74a2a6mr4371134wmo.24.1697644571153; 
 Wed, 18 Oct 2023 08:56:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDvMbCkZcCP+baXwAbNV0BwtseK+A+qqmRi04dO+1BFvCnCOH6f0hFRFZ3wEyq19QH1Og+gA==
X-Received: by 2002:a05:600c:46c6:b0:406:7d74:a2a6 with SMTP id
 q6-20020a05600c46c600b004067d74a2a6mr4371119wmo.24.1697644570744; 
 Wed, 18 Oct 2023 08:56:10 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 v21-20020a05600c12d500b004081a011c0esm1957200wmd.12.2023.10.18.08.56.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:56:10 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:56:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PULL 37/83] vhost-user: do not send RESET_OWNER on device reset
Message-ID: <984f07e6172035498cd9c9614074a3ee0e775c13.1697644299.git.mst@redhat.com>
References: <cover.1697644299.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697644299.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


