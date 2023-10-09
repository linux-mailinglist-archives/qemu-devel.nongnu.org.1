Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5007BD2A1
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 06:49:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpiBu-0008Pn-MZ; Mon, 09 Oct 2023 00:48:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qpiBq-0008OY-Rp
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 00:48:22 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qpiBm-0003TS-6t
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 00:48:22 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1c434c33ec0so23526375ad.3
 for <qemu-devel@nongnu.org>; Sun, 08 Oct 2023 21:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1696826896; x=1697431696;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vgl7M3mhj7Pxor3wgDZDJWDAgFxGD3ZOBxs//ou5GXo=;
 b=l/234esQliHP+9ccfVrh6FQ14Rt2ZChcmsnSK3g77neGfuUfUA5mGjS9EiHZxDoFSz
 qUCDVThqGbCEbVDbUg3VaOGuwCNKJSmvVgafQEewtjKy3tapRZPOw2/1wkfhPhE1CG+t
 CzbNzRx4azdLxO/aTdMP2G+2ss/LHKYsVyIGLl6G5oUfQoRHuMNUfYOOmEIcPV/434Hl
 eugsi9dQGSAsZUrukKwAIamvMJvl6Ee/UOv35KIUrSyagwAYdxXodCv3erGYn2Fo1+HN
 FLJWiSdOMA0/dy8bhLNid3DzE9R3c4/71b3zcW8I9S1nfjAoKsuSr9eXkUTYiAg3OOkz
 Xosg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696826896; x=1697431696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vgl7M3mhj7Pxor3wgDZDJWDAgFxGD3ZOBxs//ou5GXo=;
 b=imUhySqrgOTQ+bn7LAmmZ9f8v2yscGLdtyW91za9ZorjJa9vTh/6sl4vNHg9vsifIS
 GlD8iZNvw71iVm7uGo0I7NKRRYmhAFxlBei1ukgpXNDibeEj5IGBLG6CrN01QB/GS5S7
 2jEGagnk3A2MnHNmC0BK/LkBWoTq3He4QKunYz7JLd9C5jBCfJjkKgEQLHe7a31+k259
 e5MtuYpROw4GRP07vmzCmXt4uCGdSt1q3l6vIMwuakU+4m3m4O93xTr3XxUSULoqfHWb
 qNoWiV67fmf38HBmDp37kyQjUaDT8n3jjvhE+jCYH4MqBGwkloU6RUsLTOJHxRs1ypUO
 xMFQ==
X-Gm-Message-State: AOJu0Yz9VKz0t8oJpiruYTOVCLorWFFw/xtpwl/Gp1v8ZfzCO1cbK5pr
 cPdspGkK2gV0E8vFz/kmM3eEsg==
X-Google-Smtp-Source: AGHT+IFMBtekZC4tW/u4SlyJZjEekDYkyfpyc2WFf99+whJSKaHq2rS45zebxCsA2gKSd/+RE44rPA==
X-Received: by 2002:a17:902:7008:b0:1c5:cbfb:c16f with SMTP id
 y8-20020a170902700800b001c5cbfbc16fmr11277377plk.25.1696826895678; 
 Sun, 08 Oct 2023 21:48:15 -0700 (PDT)
Received: from 64217.gitgo.cc ([8.210.91.195])
 by smtp.gmail.com with ESMTPSA id
 l4-20020a170902ec0400b001c452f827casm8406010pld.257.2023.10.08.21.48.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Oct 2023 21:48:15 -0700 (PDT)
From: Li Feng <fengli@smartx.com>
To: Markus Armbruster <armbru@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 qemu-block@nongnu.org (open list:Block layer core),
 qemu-devel@nongnu.org (open list:All patches CC here)
Cc: Li Feng <fengli@smartx.com>
Subject: [PATCH v8 5/5] vhost-user: fix lost reconnect
Date: Mon,  9 Oct 2023 12:47:01 +0800
Message-ID: <20231009044735.941655-6-fengli@smartx.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009044735.941655-1-fengli@smartx.com>
References: <20231009044735.941655-1-fengli@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::631;
 envelope-from=fengli@smartx.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
---
 hw/block/vhost-user-blk.c      |  2 +-
 hw/scsi/vhost-user-scsi.c      |  3 ++-
 hw/virtio/vhost-user-gpio.c    |  2 +-
 hw/virtio/vhost-user.c         | 10 ++++++++--
 include/hw/virtio/vhost-user.h |  3 ++-
 5 files changed, 14 insertions(+), 6 deletions(-)

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
index 2457b950e1..61e4050682 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -231,7 +231,8 @@ static void vhost_user_scsi_event(void *opaque, QEMUChrEvent event)
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
index 3766b415f8..7395bfc531 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -2765,6 +2765,7 @@ typedef struct {
     DeviceState *dev;
     CharBackend *cd;
     struct vhost_dev *vhost;
+    IOEventHandler *event_cb;
 } VhostAsyncCallback;
 
 static void vhost_user_async_close_bh(void *opaque)
@@ -2779,7 +2780,10 @@ static void vhost_user_async_close_bh(void *opaque)
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
@@ -2791,7 +2795,8 @@ static void vhost_user_async_close_bh(void *opaque)
  */
 void vhost_user_async_close(DeviceState *d,
                             CharBackend *chardev, struct vhost_dev *vhost,
-                            vu_async_close_fn cb)
+                            vu_async_close_fn cb,
+                            IOEventHandler *event_cb)
 {
     if (!runstate_check(RUN_STATE_SHUTDOWN)) {
         /*
@@ -2807,6 +2812,7 @@ void vhost_user_async_close(DeviceState *d,
         data->dev = d;
         data->cd = chardev;
         data->vhost = vhost;
+        data->event_cb = event_cb;
 
         /* Disable any further notifications on the chardev */
         qemu_chr_fe_set_handlers(chardev,
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
-- 
2.41.0


