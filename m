Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 852B17CE27D
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 18:15:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8xH-0001zM-Vw; Wed, 18 Oct 2023 11:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8x9-0001nj-O9
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:59:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8x7-0007in-O5
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:59:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697644761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZZl0LxwNYNj5QaupWvqvSXF37965ruXYyQiuuTdBRxU=;
 b=WZk/yzEK/+dVIWP5Abx5AqmlmC+4ax0zY2v37atZ91nE0C3HNciVGfKjaief6ehVehp2GU
 y3ACr2r0G3QiAlFUZ+BtnV502vclhd/wkgR2ISncNJdetijy76+rAMGfcBItCdvzwajyQW
 wkvi1nujf9wiyY2uypFKNduEOGsorSM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-CuRZf2zENJCjat-boX3xgQ-1; Wed, 18 Oct 2023 11:59:20 -0400
X-MC-Unique: CuRZf2zENJCjat-boX3xgQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4083717431eso9052425e9.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 08:59:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697644758; x=1698249558;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZZl0LxwNYNj5QaupWvqvSXF37965ruXYyQiuuTdBRxU=;
 b=dOdnZkKXqC5OmQUWgCBxtHUG+dQNc07Wldh5fFEjrsZ9N/EDFLQO/yat2lk1BEXX57
 zyuoWDfXtnXFszmR1HNQ9u/zYgvYpsQZwjCnXPPMXeL8+Zxy2tM0k2fstCz9fch2oLnV
 +axvkK6eKFrNmyOWsjXdMum+X1BNmPF+d/A8XtGQ1Z/XdR3M94J1PneiPmS0J3McKVvh
 YT3hEcH8BlK8uodwfWcLLPeajBGmh12DZPZxchJlEuWGYonfz2Lr4fbP337sPhrRDPpH
 ZlPX2C8dNhYGyut9G7Qwbfl9ATpEyIx5rv6xjVTjmjnb7GvAKXU0N3bVdsds22xC5Ukl
 7b+w==
X-Gm-Message-State: AOJu0YzBAcIlvrNZIlB68H9DydaO+jGOLmwZ6ntZVmrjQ+HrRIsMgjir
 +8bpQO6PuUFklMFtJNkUqpm3gANB6gUYEAKiZQEY7ZLsFAp5jXVfWpjRBalXuBTHDrwGwHmEu+8
 7IfBVRkgiAc5KQeIpi/SA7y6bn0pW4YrkLRMetIoNeTFkmVtT3PVugFsUOuhmzMRbKwcGIi4=
X-Received: by 2002:a05:600c:4fc8:b0:406:53ab:a9af with SMTP id
 o8-20020a05600c4fc800b0040653aba9afmr4314891wmq.10.1697644758189; 
 Wed, 18 Oct 2023 08:59:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5n39XHQJZhjxqhdJMaWIkbpHVmekLLH0iPnHaKdEPhjqDEETOaXDPvyFCU12mimdmCDkvWQ==
X-Received: by 2002:a05:600c:4fc8:b0:406:53ab:a9af with SMTP id
 o8-20020a05600c4fc800b0040653aba9afmr4314869wmq.10.1697644757827; 
 Wed, 18 Oct 2023 08:59:17 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 je6-20020a05600c1f8600b004063ea92492sm2051575wmb.22.2023.10.18.08.59.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:59:17 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:59:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Li Feng <fengli@smartx.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, qemu-block@nongnu.org
Subject: [PULL 76/83] vhost-user: fix lost reconnect
Message-ID: <a68c0148e9bf105f9e83ff5e763b8fcb6f7ba9be.1697644299.git.mst@redhat.com>
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

From: Li Feng <fengli@smartx.com>

When the vhost-user is reconnecting to the backend, and if the vhost-user fails
at the get_features in vhost_dev_init(), then the reconnect will fail
and it will not be retriggered forever.

The reason is:
When the vhost-user fails at get_features, the vhost_dev_cleanup will be called
immediately.

vhost_dev_cleanup calls 'memset(hdev, 0, sizeof(struct vhost_dev))'.

The reconnect path is:
vhost_user_blk_event
   vhost_user_async_close(.. vhost_user_blk_disconnect ..)
     qemu_chr_fe_set_handlers <----- clear the notifier callback
       schedule vhost_user_async_close_bh

The vhost->vdev is null, so the vhost_user_blk_disconnect will not be
called, then the event fd callback will not be reinstalled.

All vhost-user devices have this issue, including vhost-user-blk/scsi.

With this patch, if the vdev->vdev is null, the fd callback will still
be reinstalled.

Fixes: 71e076a07d ("hw/virtio: generalise CHR_EVENT_CLOSED handling")

Signed-off-by: Li Feng <fengli@smartx.com>
Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
Message-Id: <20231009044735.941655-6-fengli@smartx.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/vhost-user.h |  3 ++-
 hw/block/vhost-user-blk.c      |  2 +-
 hw/scsi/vhost-user-scsi.c      |  3 ++-
 hw/virtio/vhost-user-gpio.c    |  2 +-
 hw/virtio/vhost-user.c         | 10 ++++++++--
 5 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-user.h
index 9f9ddf878d..6b06ecb1bd 100644
--- a/include/hw/virtio/vhost-user.h
+++ b/include/hw/virtio/vhost-user.h
@@ -106,6 +106,7 @@ typedef void (*vu_async_close_fn)(DeviceState *cb);
 
 void vhost_user_async_close(DeviceState *d,
                             CharBackend *chardev, struct vhost_dev *vhost,
-                            vu_async_close_fn cb);
+                            vu_async_close_fn cb,
+                            IOEventHandler *event_cb);
 
 #endif
diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 3c69fa47d5..95c758200d 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -391,7 +391,7 @@ static void vhost_user_blk_event(void *opaque, QEMUChrEvent event)
     case CHR_EVENT_CLOSED:
         /* defer close until later to avoid circular close */
         vhost_user_async_close(dev, &s->chardev, &s->dev,
-                               vhost_user_blk_disconnect);
+                               vhost_user_blk_disconnect, vhost_user_blk_event);
         break;
     case CHR_EVENT_BREAK:
     case CHR_EVENT_MUX_IN:
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index 258fba5c69..4486500cac 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -212,7 +212,8 @@ static void vhost_user_scsi_event(void *opaque, QEMUChrEvent event)
     case CHR_EVENT_CLOSED:
         /* defer close until later to avoid circular close */
         vhost_user_async_close(dev, &vs->conf.chardev, &vsc->dev,
-                               vhost_user_scsi_disconnect);
+                               vhost_user_scsi_disconnect,
+                               vhost_user_scsi_event);
         break;
     case CHR_EVENT_BREAK:
     case CHR_EVENT_MUX_IN:
diff --git a/hw/virtio/vhost-user-gpio.c b/hw/virtio/vhost-user-gpio.c
index fc784e4213..aff2d7eff6 100644
--- a/hw/virtio/vhost-user-gpio.c
+++ b/hw/virtio/vhost-user-gpio.c
@@ -289,7 +289,7 @@ static void vu_gpio_event(void *opaque, QEMUChrEvent event)
     case CHR_EVENT_CLOSED:
         /* defer close until later to avoid circular close */
         vhost_user_async_close(dev, &gpio->chardev, &gpio->vhost_dev,
-                               vu_gpio_disconnect);
+                               vu_gpio_disconnect, vu_gpio_event);
         break;
     case CHR_EVENT_BREAK:
     case CHR_EVENT_MUX_IN:
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index f9414f03de..b8a7b5542d 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -2756,6 +2756,7 @@ typedef struct {
     DeviceState *dev;
     CharBackend *cd;
     struct vhost_dev *vhost;
+    IOEventHandler *event_cb;
 } VhostAsyncCallback;
 
 static void vhost_user_async_close_bh(void *opaque)
@@ -2770,7 +2771,10 @@ static void vhost_user_async_close_bh(void *opaque)
      */
     if (vhost->vdev) {
         data->cb(data->dev);
-    }
+    } else if (data->event_cb) {
+        qemu_chr_fe_set_handlers(data->cd, NULL, NULL, data->event_cb,
+                                 NULL, data->dev, NULL, true);
+   }
 
     g_free(data);
 }
@@ -2782,7 +2786,8 @@ static void vhost_user_async_close_bh(void *opaque)
  */
 void vhost_user_async_close(DeviceState *d,
                             CharBackend *chardev, struct vhost_dev *vhost,
-                            vu_async_close_fn cb)
+                            vu_async_close_fn cb,
+                            IOEventHandler *event_cb)
 {
     if (!runstate_check(RUN_STATE_SHUTDOWN)) {
         /*
@@ -2798,6 +2803,7 @@ void vhost_user_async_close(DeviceState *d,
         data->dev = d;
         data->cd = chardev;
         data->vhost = vhost;
+        data->event_cb = event_cb;
 
         /* Disable any further notifications on the chardev */
         qemu_chr_fe_set_handlers(chardev,
-- 
MST


