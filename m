Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F373C7CE261
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 18:11:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8xD-0001r4-7G; Wed, 18 Oct 2023 11:59:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8x8-0001mC-RV
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:59:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8x6-0007hh-VG
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:59:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697644760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YyodsRp2ZRofBm0jV3rXv9QfLn6gfTg2fAVnLonYmZE=;
 b=hBZX9GUDL+/OhCrP3nUZ8pnB2H69KuHn19ZyzOVkIDUiBSOfdI9AYRgKX9Q+OMBHJTguL6
 5T08wFmrWapCV/Scu6P1VFixT6CnXNxar7rSBLU0CAFWb3FBj48YMT/MoWZwdaKY4Z7wup
 uFYCk5ShhnwBT5D/xExx42wS7E5UvVY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-efzkeRniMFezNMF_KKwVIA-1; Wed, 18 Oct 2023 11:59:14 -0400
X-MC-Unique: efzkeRniMFezNMF_KKwVIA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4083c9b426fso4671665e9.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 08:59:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697644752; x=1698249552;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YyodsRp2ZRofBm0jV3rXv9QfLn6gfTg2fAVnLonYmZE=;
 b=ssioAEqd0ah7CjfYBNtR0kLHjwwYw/rqPQcy5UEwFLCdZes3gY/1OrVqc6LNdc8Flx
 lE4bxBPR+AngNSxhek7XlR7zgGZOVC8XF4iesySRoV+B7IjYQCaf4xngVNvBaLmJU+Lv
 er9IIRmxPr8DZgnYv90uJWo1Nzc6JRoWUyHec9y5jujSga+RmL1OabNN3ae1AkGK3ZKq
 /QfZOB364UshyTXyn9/gAV3PN0wEcGFUm5Ujue0y9QvFiAz3TEC53NlG87D++P1F4J/d
 eQ908ZP44I3uhRKTVozJVqwyX11YHzT3u3JPZqCf2jPDjGnOKz9mLZMuFSYEJK0QuSBz
 SpRg==
X-Gm-Message-State: AOJu0Yzkk8HyU/Pms48X5CalYRtDz4icFaXQpJRoPwuEra0dEmGhTFrf
 YoJCFtY98myDATTQQDc5g9lr9YByPoWVCGjRuvNtxHN0f3nKJnJW5Pc8v0TMhC5wxOSR2w9iw5m
 ztqynxxQHOi5ZdN097oKAlt1+H54hD5c+XVkVIQRFnAG8C2XRmOFetnfWChyYE2o41swO+Jw=
X-Received: by 2002:a05:600c:3c99:b0:405:5ffd:21d2 with SMTP id
 bg25-20020a05600c3c9900b004055ffd21d2mr4657879wmb.19.1697644752245; 
 Wed, 18 Oct 2023 08:59:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6VqOL9QHNjqlYbTdBUG6i2+7Xp4w0XSnLg1FarPMAehZPhH4fsubSsVM1hoWyZP3f5sq0mQ==
X-Received: by 2002:a05:600c:3c99:b0:405:5ffd:21d2 with SMTP id
 bg25-20020a05600c3c9900b004055ffd21d2mr4657852wmb.19.1697644751837; 
 Wed, 18 Oct 2023 08:59:11 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 d3-20020adfef83000000b0032dc2110d01sm2402717wro.61.2023.10.18.08.59.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:59:11 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:59:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Li Feng <fengli@smartx.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PULL 75/83] vhost-user-scsi: start vhost when guest kicks
Message-ID: <02c4863bd64f206011faecf3c0c934d9e1052b25.1697644299.git.mst@redhat.com>
References: <cover.1697644299.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697644299.git.mst@redhat.com>
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


