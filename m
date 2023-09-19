Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 699A07A6198
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 13:44:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiZ8X-0007sk-A7; Tue, 19 Sep 2023 07:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qiZ8V-0007rx-G4
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 07:43:23 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qiZ8T-0004Go-S6
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 07:43:23 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-690bd8f89baso875586b3a.2
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 04:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1695123680; x=1695728480;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zEHWKIJ/jlcW2XJm2YoMaGjRhjLSx9EfJkS7TRjaaVY=;
 b=ukKaax96/pmwiLBVLBAagPrOMEqbJUx2Dck5RENMCUIKcRLcY2F8zKX3/WX18+MAkZ
 BY7bTwn2KyLGKJ1yPnD0fgT15HKHI1/+hQ6UNFt1fUd7wXvynmNP0kcVCn6v2jYajYgj
 yaZhzkeZVH0ODZ0qGu/mJeQ9Oue6/1ZuzPlSZP0sc0gnoU4xoM7XpT0UK8WhTrpe8Vj5
 aBy1oCWY4ghanw9TxkH6N9oGSdR6AGaskpWiqulBAwO9FtqLiTmLk77TCA+MRqtW6qMa
 im8v4beSi0N+5+9oM3h4yE2+zm+7GCDvAuWENQKxi2ZBRSrLBTlVG5YFFlcSknwUyBds
 n0cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695123680; x=1695728480;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zEHWKIJ/jlcW2XJm2YoMaGjRhjLSx9EfJkS7TRjaaVY=;
 b=S513LsKzgTEXbc0KGaY4n9SkDxID+J77yBKDy/1XMQqoXNY57mpw+bilKupkVHN9H2
 3vyLexe1Z5YTLXBVS2wX0VHHUY0Om/uyCQCz/KjhHqgn+DIYn77def6kXi1D16kejy1V
 MEa3RCZin4Rc6wfck/LUb9jFazRyHgMEceAj1QpXWfChI+LwgHqDICOEcIOOPojMXJui
 LZAhq0depN5Cu1XAHjt7WHl9jSvx5bBU6s1YifltPTRWFZFQxwefAz4perlqUnQSJOmp
 D0MU7EhDY036Xu5jlTPOrEKAnlaDijjuzlmDEFw+PXV/088U7DSsSn8iYcIsrC9D3VjU
 vYyQ==
X-Gm-Message-State: AOJu0YwjPxfB6dFkeLzGFl4VcYOlAN4DJj7WA8CbwsSJAZ9TDdBSyKkb
 q0LRDJ+1GSvxZF5AvnTFrj+kcw==
X-Google-Smtp-Source: AGHT+IEVY+j0o0niFXBzQToLnxkV6h5ezezXNBTG5QG3u7D4Qcb5c8wuxlSAtIw0klaTb34NWZEzZA==
X-Received: by 2002:a05:6a00:10c4:b0:68f:e810:e86f with SMTP id
 d4-20020a056a0010c400b0068fe810e86fmr10294630pfu.28.1695123680352; 
 Tue, 19 Sep 2023 04:41:20 -0700 (PDT)
Received: from 64217.gitgo.cc ([8.210.91.195])
 by smtp.gmail.com with ESMTPSA id
 z24-20020aa791d8000000b006887be16675sm8487030pfa.205.2023.09.19.04.41.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 04:41:19 -0700 (PDT)
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
Subject: [PATCH v5 5/5] vhost-user: fix lost reconnect
Date: Tue, 19 Sep 2023 19:40:26 +0800
Message-ID: <20230919114030.280414-6-fengli@smartx.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230919114030.280414-1-fengli@smartx.com>
References: <20230721105205.1714449-1-fengli@smartx.com>
 <20230919114030.280414-1-fengli@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42d;
 envelope-from=fengli@smartx.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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
 hw/scsi/vhost-user-scsi.c      | 3 ++-
 hw/virtio/vhost-user-gpio.c    | 2 +-
 hw/virtio/vhost-user.c         | 9 +++++++--
 include/hw/virtio/vhost-user.h | 3 ++-
 5 files changed, 13 insertions(+), 6 deletions(-)

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
index 53a62c3170..0effbb4787 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -238,7 +238,8 @@ static void vhost_user_scsi_event(void *opaque, QEMUChrEvent event)
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


