Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC3278D2E3
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 07:00:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbDJD-0007w3-AC; Wed, 30 Aug 2023 01:00:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qbDIw-0007uR-8x
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 00:59:49 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qbDIm-00041X-DA
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 00:59:45 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1bf11b1c7d0so3535245ad.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 21:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1693371455; x=1693976255;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7MzIajxlynAc7cZYmUnN0op416U5kko2ZZOVqw7m+l4=;
 b=ZzLol42ms8yOEm5GTaz+wPYn6pnTLbPtJA6Bat6gM/yIiJqC+EfN+KFx/CyYdjniUD
 42MeprMYSi2HTrdOeVhcHQoawf5o4wsSQ+OMySCdDbUBIqLcUxdBlKXPOVnPjzEUa5Mh
 nD5hSj2a2wU4dyTjCjXxdGbDXGjli8dsrGyqephMNcN9vQytbstd9UU8eDHB9MOtA2kC
 7WwL6QsquVSckMPiuJkN6UZyWYazVqSAFFeBK6EiRt6jJabHUag3aYygz5ztcb9vUK6L
 iDWgtCPQgHnvN1tfjVmtzv/heF3ynMWaz68L7pq1k7YU9tk6SOwdAbfJnRcpuDxOt3NN
 MFiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693371455; x=1693976255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7MzIajxlynAc7cZYmUnN0op416U5kko2ZZOVqw7m+l4=;
 b=fbRIFvoXXBaVCV+ebzJHCJsOyZKO2dqPo5OGm0zdwsl9IdNJsGxwBpGt2xnhO+sozO
 FA/gWI00BkGflcf8IMoq9hJig+dqET7C4fRk/U77GlPfs4r4wLsv2d24s+NaRX7QHPNp
 9LSrkqufsiIHPGaQ+AOTCz9GX6hB1OO0dcpc1G4rbnlwJGX7xMsyQ/VcO7oBAgGLBokh
 g+dMcxYBv1Y87nMeJgKpqq27G4HOumvbRPusqnJVBKSDpiEHPDmfdJUUcTyskp29DL1t
 xnjIT0eFbCxslOxUTNhwj1KqOK9VhaJPDtQOfLa6HS6DfV61GU1fW1/IA0/yuSFd2DU2
 ppGA==
X-Gm-Message-State: AOJu0YzyXX/hCAYOym+z2chXX/QatmNPaOLTE88DcgSqE2YxD6CO1g/u
 x3KZeRJmZEPafqgBtX20toXJQg==
X-Google-Smtp-Source: AGHT+IFO6SNQhekFb9XbMDM1rw0CVh1dFA6dwoQUqviYhI1VTisLX7Ls00pLXL9qluzCsuNKWGWRDA==
X-Received: by 2002:a17:902:ed55:b0:1c0:bcbc:d66 with SMTP id
 y21-20020a170902ed5500b001c0bcbc0d66mr1896408plb.7.1693371455059; 
 Tue, 29 Aug 2023 21:57:35 -0700 (PDT)
Received: from 64217.gitgo.cc ([8.210.91.195])
 by smtp.gmail.com with ESMTPSA id
 t11-20020a170902a5cb00b001bfd92ec592sm10183553plq.292.2023.08.29.21.57.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 21:57:34 -0700 (PDT)
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
Subject: [PATCH v3 1/2] vhost-user: Fix lost reconnect
Date: Wed, 30 Aug 2023 12:57:13 +0800
Message-ID: <20230830045722.611224-2-fengli@smartx.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230830045722.611224-1-fengli@smartx.com>
References: <20230804052954.2918915-1-fengli@smartx.com>
 <20230830045722.611224-1-fengli@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62d;
 envelope-from=fengli@smartx.com; helo=mail-pl1-x62d.google.com
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


