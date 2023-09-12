Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DCD79CAC0
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 10:57:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfzCO-0008P9-3h; Tue, 12 Sep 2023 04:56:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qfzBm-0008E4-Ar
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 04:56:07 -0400
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qfzBk-0002C0-47
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 04:56:06 -0400
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-572a7141434so3090858eaf.2
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 01:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1694508843; x=1695113643;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZngRalemChwakz8wrbTdzeq+OAAg9Tm3RzDMb6BGc10=;
 b=O6gLf8NhIJgjzA/Xc81o5KC5CLyK0iinAMP/vOXoKS2cNtND1gGAyQSyqjwYkwQddW
 irG3RZqXgSNX1mHQxFn2r4Euxn1nyhQBUh0H7jsm+AMehMcH+arR/anInptLo1CWHd0F
 6Nk3BxzvvlfX4my0hpJc+Jv1+S2vk5biMFOCSkRF8sAWIlENduHbaUmNOF7hW9u82qbU
 k0zg6ktVeVf+ZLkAlIw8RZMdZnngwNp0wk/JEsqoSNk9z2EsOKsL/xM1BKvyxorNNhWA
 9Ioh+fsaKio+TEaE3E2B3kwcm/Z70I62qiGLDRj8AlfsRWYSEkWwb4gSh8s4BWLW1+ky
 a7CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694508843; x=1695113643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZngRalemChwakz8wrbTdzeq+OAAg9Tm3RzDMb6BGc10=;
 b=cdnn2FMh8OmfqoeHEGsaqL8Ftmr25LLq9gHWO354evfo/lHvwMljjTbGKnUS5CYzzY
 OLs983G9/qmWWppAmpiSWSET40nYD08onmXpqIL7GBk6pZD4x67ukEZGIaUdNIMDl2I0
 P2/hXvzseV/x9jhNYfGccPluetAO84GZxKI48WMKuQ0Vg9VtHLJxvXSNS7NvNTTPf35i
 jTwfKHgbZ/R9vndzmC8o52X1kvPX6CudqrLZRWyla+5vlK56jbXWhRYYEU/q8q8t5GfZ
 Q24JXQMTD/7TmJIGENsliq3cxnZaGJGlWsvO25klHeAGAlz1HeLx3h/gwPz4xvHxjzfT
 12rw==
X-Gm-Message-State: AOJu0Yz9Kh4DepSTl+dwJrDfrqHdY3lsUTJLQh+ckKry/PE7BLPJr7K5
 4WRCGOXSAQXK1xUVJ89tLJFpRg==
X-Google-Smtp-Source: AGHT+IFGbt9vQaNXPVAuhW90D5Tn3O/t6/5Io0taecRANDY8WpyhrJX13sC+2ZotOSuYj8jwxXfuoQ==
X-Received: by 2002:a05:6359:4e97:b0:141:10f4:1cbc with SMTP id
 os23-20020a0563594e9700b0014110f41cbcmr2559945rwb.14.1694508842505; 
 Tue, 12 Sep 2023 01:54:02 -0700 (PDT)
Received: from 64217.gitgo.cc ([8.210.91.195])
 by smtp.gmail.com with ESMTPSA id
 m6-20020a637d46000000b00570668ccd5bsm6523754pgn.14.2023.09.12.01.53.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 01:54:02 -0700 (PDT)
From: Li Feng <fengli@smartx.com>
To: Markus Armbruster <armbru@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 qemu-block@nongnu.org (open list:Block layer core),
 qemu-devel@nongnu.org (open list:All patches CC here)
Cc: Li Feng <fengli@smartx.com>
Subject: [PATCH v4 5/5] vhost-user: fix lost reconnect
Date: Tue, 12 Sep 2023 16:52:47 +0800
Message-ID: <20230912085315.2524857-6-fengli@smartx.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912085315.2524857-1-fengli@smartx.com>
References: <20230721105205.1714449-1-fengli@smartx.com>
 <20230912085315.2524857-1-fengli@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::c29;
 envelope-from=fengli@smartx.com; helo=mail-oo1-xc29.google.com
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
 hw/block/vhost-user-blk.c      | 2 +-
 hw/virtio/vhost-user-gpio.c    | 2 +-
 hw/virtio/vhost-user.c         | 9 +++++++--
 include/hw/virtio/vhost-user.h | 3 ++-
 4 files changed, 11 insertions(+), 5 deletions(-)

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
index 8dcf049d42..12c4a41f30 100644
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
@@ -2669,7 +2673,8 @@ static void vhost_user_async_close_bh(void *opaque)
  */
 void vhost_user_async_close(DeviceState *d,
                             CharBackend *chardev, struct vhost_dev *vhost,
-                            vu_async_close_fn cb)
+                            vu_async_close_fn cb,
+                            IOEventHandler *event_cb)
 {
     if (!runstate_check(RUN_STATE_SHUTDOWN)) {
         /*
diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-user.h
index 191216a74f..649e9dd54f 100644
--- a/include/hw/virtio/vhost-user.h
+++ b/include/hw/virtio/vhost-user.h
@@ -84,6 +84,7 @@ typedef void (*vu_async_close_fn)(DeviceState *cb);
 
 void vhost_user_async_close(DeviceState *d,
                             CharBackend *chardev, struct vhost_dev *vhost,
-                            vu_async_close_fn cb);
+                            vu_async_close_fn cb,
+                            IOEventHandler *event_cb);
 
 #endif
-- 
2.41.0


