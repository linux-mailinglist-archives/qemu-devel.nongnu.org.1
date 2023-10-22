Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA4A7D2256
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 11:31:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quUjG-0000fH-VT; Sun, 22 Oct 2023 05:26:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUj2-0000YT-Uq
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:26:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUiy-0000wE-MJ
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:26:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697966779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YyodsRp2ZRofBm0jV3rXv9QfLn6gfTg2fAVnLonYmZE=;
 b=CGTKPPz1uhlWSgQI0md4TXgb8qf3QxQnO4YsgSREW/V4NSNfet/q2Z+RtHMgyRyQhSqPjA
 lJMKPrI1c8Ek3jJ5ERccXakiA+gkxDXp/2npt3UV78s9ZnxcYmPr5gwhfYfo8KuP8Vl60h
 xNHplxjxaRBzP/RDD3LRViqf7jQYmu4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-fR8u0383P_iQn6ejTwEaYQ-1; Sun, 22 Oct 2023 05:26:07 -0400
X-MC-Unique: fR8u0383P_iQn6ejTwEaYQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40768556444so14533985e9.3
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 02:26:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697966765; x=1698571565;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YyodsRp2ZRofBm0jV3rXv9QfLn6gfTg2fAVnLonYmZE=;
 b=OrufvtCOpWumCy8vHf8VnIQolcosUiAJ2qagWL0xURy8li1dNIWga1Zg9LuLGVsw7J
 gKYJLybf3/5WAZU/ChOInz97RizuEjThGyN7ujJPyVEKdNNFXkQpTg9NVk7C/gw3b2qU
 YL9eWO170tzxk7qcJ7vgPey7Ho2cetkFfRvw79pD/h8YxKqK4k8H+QTZD0PKwOFC2HdT
 Q6XENpc776/iSZmxExWs45+UXF6dqDp3LYMcDUqJCbLkB7v2IBvwCd49uhUDEdql6703
 GN5i+hYs4/42G74e6QQacUt01B8jlWE7fuOFNKc/TRc5Y863poiP2pYNpL17Fch9vsJ1
 aiEg==
X-Gm-Message-State: AOJu0YzzsZSqIJ6vC5eE6ictpxFkqF4cX9Q0TZlfHfboEx33sY1m0KaD
 oaaHiMbtNC3+0I3B0qY5lXXjoNGHB8zR+LJUnd6Gpk/u86ealnyd0pJtk5VX2B39nbrWO1IBFT2
 y/tk7dH2H3WSKEhd/tSh2pHnYsdjdbNeEaz/1Lnk45w5b2/nGinXBAl1hC34oeYVJZ8zu
X-Received: by 2002:a05:600c:3d87:b0:3fe:1232:93fa with SMTP id
 bi7-20020a05600c3d8700b003fe123293famr4910454wmb.22.1697966765623; 
 Sun, 22 Oct 2023 02:26:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsx4Pxz7e89vtkpIScwtDDfVuTZ7rbZIvPEwdkMYVb7pm3rayItN8RREGlMo00yum1qLrHMg==
X-Received: by 2002:a05:600c:3d87:b0:3fe:1232:93fa with SMTP id
 bi7-20020a05600c3d8700b003fe123293famr4910439wmb.22.1697966765354; 
 Sun, 22 Oct 2023 02:26:05 -0700 (PDT)
Received: from redhat.com ([2.52.1.53]) by smtp.gmail.com with ESMTPSA id
 n10-20020adffe0a000000b003200c918c81sm5275949wrr.112.2023.10.22.02.25.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 02:26:04 -0700 (PDT)
Date: Sun, 22 Oct 2023 05:25:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Li Feng <fengli@smartx.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PULL v3 54/62] vhost-user-scsi: start vhost when guest kicks
Message-ID: <a6a30a7ec01c743fe71ab7461655d89afe152fcf.1697966402.git.mst@redhat.com>
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

From: Li Feng <fengli@smartx.com>

Let's keep the same behavior as vhost-user-blk.

Some old guests kick virtqueue before setting VIRTIO_CONFIG_S_DRIVER_OK.

Signed-off-by: Li Feng <fengli@smartx.com>
Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
Message-Id: <20231009044735.941655-5-fengli@smartx.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/scsi/vhost-user-scsi.c | 48 +++++++++++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index 24c250d3f8..258fba5c69 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -92,8 +92,48 @@ static void vhost_user_scsi_set_status(VirtIODevice *vdev, uint8_t status)
     }
 }
 
-static void vhost_dummy_handle_output(VirtIODevice *vdev, VirtQueue *vq)
+static void vhost_user_scsi_handle_output(VirtIODevice *vdev, VirtQueue *vq)
 {
+    VHostUserSCSI *s = (VHostUserSCSI *)vdev;
+    DeviceState *dev = DEVICE(vdev);
+    VHostSCSICommon *vsc = VHOST_SCSI_COMMON(s);
+    VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(dev);
+
+    Error *local_err = NULL;
+    int i, ret;
+
+    if (!vdev->start_on_kick) {
+        return;
+    }
+
+    if (!s->connected) {
+        return;
+    }
+
+    if (vhost_dev_is_started(&vsc->dev)) {
+        return;
+    }
+
+    /*
+     * Some guests kick before setting VIRTIO_CONFIG_S_DRIVER_OK so start
+     * vhost here instead of waiting for .set_status().
+     */
+    ret = vhost_user_scsi_start(s, &local_err);
+    if (ret < 0) {
+        error_reportf_err(local_err, "vhost-user-scsi: vhost start failed: ");
+        qemu_chr_fe_disconnect(&vs->conf.chardev);
+        return;
+    }
+
+    /* Kick right away to begin processing requests already in vring */
+    for (i = 0; i < vsc->dev.nvqs; i++) {
+        VirtQueue *kick_vq = virtio_get_queue(vdev, i);
+
+        if (!virtio_queue_get_desc_addr(vdev, i)) {
+            continue;
+        }
+        event_notifier_set(virtio_queue_get_host_notifier(kick_vq));
+    }
 }
 
 static int vhost_user_scsi_connect(DeviceState *dev, Error **errp)
@@ -220,9 +260,9 @@ static void vhost_user_scsi_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    virtio_scsi_common_realize(dev, vhost_dummy_handle_output,
-                               vhost_dummy_handle_output,
-                               vhost_dummy_handle_output, &err);
+    virtio_scsi_common_realize(dev, vhost_user_scsi_handle_output,
+                               vhost_user_scsi_handle_output,
+                               vhost_user_scsi_handle_output, &err);
     if (err != NULL) {
         error_propagate(errp, err);
         return;
-- 
MST


