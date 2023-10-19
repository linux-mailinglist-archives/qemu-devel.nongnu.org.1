Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E0B7D0180
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:30:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXhK-0000NE-TH; Thu, 19 Oct 2023 14:24:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXfX-0006r1-5E
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:22:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXfV-0000nr-FX
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:22:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697739763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n62ZCYLMWQB+v9G4ohwIMDOGfFG/zqXCKAbKv3KvAW8=;
 b=HgQkb0FwJoDhANSq6cK1qUvZEVAWVzK0XpwtQsbTr3c8ClsaW9OOH0Djbh75lzPeTiFS/K
 XL0K7ZU66gEYzVbYaQ6jQDxw27OoPOMCuH6qJ7IWTdNOTBOFMjAWU+vjynzJifA9yOQNK9
 hPPZVeRCGUl0cNmT0dVEmH6N8SHewvE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-hdJQDVQONDy3m9TiZze6Ow-1; Thu, 19 Oct 2023 14:22:41 -0400
X-MC-Unique: hdJQDVQONDy3m9TiZze6Ow-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4065d52a83aso52305155e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:22:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697739759; x=1698344559;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n62ZCYLMWQB+v9G4ohwIMDOGfFG/zqXCKAbKv3KvAW8=;
 b=JUP5I7Yw9SNh3a4PH/GxBvfxPclnEhFtvKFKv5QxM0raLdBepMr7X7EyHB+WVh+daM
 oRhzNFD+eq0XBg0EVMIiLWjhi+3v/ovzOH1V0MRNAAFiSQo7Zc9buUwCQIzDxd0LmWhD
 om75ZmnyIKb+7OkxqHDqwVuczEUApnJPnTZZ/bUj+LqTEVtbZCr4OZUWlbeSQO/PZ8pa
 T46vkFSremc9z77oJ+T36lm8J+7dyUTrpMxpc7s7GwoAhdEScVeaM+K52dELLkZTPj4Z
 DuypsQKtGXx/9594iKVfkk6Je9YbktBhmNxWE6mk+Msc4jZo7oJu8YQRNUn2mFiMtjDN
 Pl5g==
X-Gm-Message-State: AOJu0YxLWjHBv5S/Q51LwucCjG+dlanKnWFUfhTwLnkphsZkkou7Kib1
 nYm92ifIDIn61vNjIiBb/77A42JORqus0OlWI36Tr4ecw+/O3TqiEyu8DoQT6Vt/EwWmeH9IbTa
 /rOBLZ7ZZQ5HQCySXdEVUrSDuQIkrRWhu4/xrxjamHpz3io/5nJm4r5EFtjHprlvBLsEN
X-Received: by 2002:a05:600c:4684:b0:408:3eaa:aea6 with SMTP id
 p4-20020a05600c468400b004083eaaaea6mr2391881wmo.7.1697739758764; 
 Thu, 19 Oct 2023 11:22:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBUY47WFnVNilDvRdWECvQjpWIPIXmD8iePN1nq+Q50RQuoTZXMeE1qL+dZN28iQjYJO0ehg==
X-Received: by 2002:a05:600c:4684:b0:408:3eaa:aea6 with SMTP id
 p4-20020a05600c468400b004083eaaaea6mr2391863wmo.7.1697739758396; 
 Thu, 19 Oct 2023 11:22:38 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 z15-20020a05600c078f00b0040849ce7116sm1866983wmo.43.2023.10.19.11.22.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 11:22:37 -0700 (PDT)
Date: Thu, 19 Oct 2023 14:22:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PULL v2 32/78] vhost-user: do not send RESET_OWNER on device reset
Message-ID: <36d91da4a0e163a16fe2bb56855b11a48882efe9.1697739629.git.mst@redhat.com>
References: <cover.1697739629.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697739629.git.mst@redhat.com>
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


