Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C46247868DD
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 09:45:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ50Q-0001ag-Ar; Thu, 24 Aug 2023 03:43:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qZ50N-0001ZI-IS
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 03:43:47 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qZ50I-00048N-0c
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 03:43:47 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1bf3a2f4528so48373895ad.2
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 00:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1692862900; x=1693467700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ah+7NJjI2wmps4ellUI5NdP+x8wwsBqSV+DDR/0rhDg=;
 b=ByIBbNbsXq3E8CW72Y9e5ioEavn5XqecBk4KlE8am0JsfJxu9W7lW0IieIz8dvVZJe
 7lrOUvi8CWs9oEzDOGdSZy18DGMq9byhI68F4bN94nldZql7x8ShzP/qf1F8I6OrOIKf
 tT5x/k4P3bsZUQqPqwfr/g84kE96i7eKlcssucjJ+1WhHGDMlhakfmEuFyxD9kUdghsv
 Y8K8WxAPJpw2AwntGvZlyCd/YWdJKi/LDbnoNuVeZP/VotEFfS5n5n9Cue20de/AkCZK
 LkRpkYW7wXAmnG6coC1V43YtR1MDE3cdH3fmP/5jSUXNWKwmYs49QvtWEDENlMjJT+A8
 W9Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692862900; x=1693467700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ah+7NJjI2wmps4ellUI5NdP+x8wwsBqSV+DDR/0rhDg=;
 b=RYooQACmtb6e2x+ZoXMPrVfBEDYZ1v1I4PQ9EWknjrwtTJxrLdrQiPwGImqIQODPCO
 YZC2X+/kKmX2b449zRwL4x9LavLpmSVtlUpLHU7DEaA/7hdhYeEN1sTriGuXXvqoWaGv
 zBtUeHnxsRVx1EgoIzk8aQwIhNX1TFlH9LwqG+GjKYl4eUheuav0md3cgs+SMkq/zQX2
 bxLGrq5E/VDcfkHSW4Q7+XthTFp4XpjOe+UXOYgbGXOtem4W2/4LM3uTgm+D/4i55dMa
 2MpredU8yoI2DP7Tm1BlTfG/PYNRfhHxloKdo49HysxBCSlKLcUDmY0bQNFtPHSYSwK7
 QoEw==
X-Gm-Message-State: AOJu0Yy3RDTQbyR0qy2ooodVb5u4eavSJNtTHFLomOKeTnMQHyEsd0Xk
 AtgM8B5+mcPa0v/fdjhJqTjz6A==
X-Google-Smtp-Source: AGHT+IHQ2Yng7smX9sT+/bUYPI2Iq9F4XlO0BYfI9zit4/Jang+7BfG787oLiDG2jtdowyxe73BjBg==
X-Received: by 2002:a17:902:9b94:b0:1bc:16cf:fc30 with SMTP id
 y20-20020a1709029b9400b001bc16cffc30mr14327689plp.63.1692862900239; 
 Thu, 24 Aug 2023 00:41:40 -0700 (PDT)
Received: from 64217.gitgo.cc ([8.210.91.195])
 by smtp.gmail.com with ESMTPSA id
 jk8-20020a170903330800b001b672af624esm12070112plb.164.2023.08.24.00.41.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 00:41:39 -0700 (PDT)
From: Li Feng <fengli@smartx.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 qemu-block@nongnu.org (open list:Block layer core),
 qemu-devel@nongnu.org (open list:All patches CC here)
Cc: Li Feng <fengli@smartx.com>
Subject: [PATCH v2 1/2] vhost-user: Fix lost reconnect
Date: Thu, 24 Aug 2023 15:41:01 +0800
Message-ID: <20230824074115.93897-2-fengli@smartx.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824074115.93897-1-fengli@smartx.com>
References: <20230804052954.2918915-1-fengli@smartx.com>
 <20230824074115.93897-1-fengli@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62c;
 envelope-from=fengli@smartx.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: 14
X-Spam_score: 1.4
X-Spam_bar: +
X-Spam_report: (1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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
---
 hw/block/vhost-user-blk.c      |  2 +-
 hw/scsi/vhost-user-scsi.c      |  3 ++-
 hw/virtio/vhost-user-gpio.c    |  2 +-
 hw/virtio/vhost-user.c         | 10 ++++++++--
 include/hw/virtio/vhost-user.h |  4 +++-
 5 files changed, 15 insertions(+), 6 deletions(-)

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
index a7fa8e8df2..e931df9f5b 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -236,7 +236,8 @@ static void vhost_user_scsi_event(void *opaque, QEMUChrEvent event)
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
index d9979aa5db..04c2cc79f4 100644
--- a/hw/virtio/vhost-user-gpio.c
+++ b/hw/virtio/vhost-user-gpio.c
@@ -283,7 +283,7 @@ static void vu_gpio_event(void *opaque, QEMUChrEvent event)
     case CHR_EVENT_CLOSED:
         /* defer close until later to avoid circular close */
         vhost_user_async_close(dev, &gpio->chardev, &gpio->vhost_dev,
-                               vu_gpio_disconnect);
+                               vu_gpio_disconnect, vu_gpio_event);
         break;
     case CHR_EVENT_BREAK:
     case CHR_EVENT_MUX_IN:
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 8dcf049d42..9540766dd3 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -2643,6 +2643,7 @@ typedef struct {
     DeviceState *dev;
     CharBackend *cd;
     struct vhost_dev *vhost;
+    IOEventHandler *event_cb;
 } VhostAsyncCallback;
 
 static void vhost_user_async_close_bh(void *opaque)
@@ -2657,7 +2658,10 @@ static void vhost_user_async_close_bh(void *opaque)
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
@@ -2669,7 +2673,9 @@ static void vhost_user_async_close_bh(void *opaque)
  */
 void vhost_user_async_close(DeviceState *d,
                             CharBackend *chardev, struct vhost_dev *vhost,
-                            vu_async_close_fn cb)
+                            vu_async_close_fn cb,
+                            IOEventHandler *event_cb
+                            )
 {
     if (!runstate_check(RUN_STATE_SHUTDOWN)) {
         /*
diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-user.h
index 191216a74f..5fdc711d4e 100644
--- a/include/hw/virtio/vhost-user.h
+++ b/include/hw/virtio/vhost-user.h
@@ -84,6 +84,8 @@ typedef void (*vu_async_close_fn)(DeviceState *cb);
 
 void vhost_user_async_close(DeviceState *d,
                             CharBackend *chardev, struct vhost_dev *vhost,
-                            vu_async_close_fn cb);
+                            vu_async_close_fn cb,
+                            IOEventHandler *event_cb
+                            );
 
 #endif
-- 
2.41.0


