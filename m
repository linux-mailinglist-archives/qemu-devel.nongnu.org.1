Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE128C4C34
	for <lists+qemu-devel@lfdr.de>; Tue, 14 May 2024 08:16:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6lRI-0005in-UD; Tue, 14 May 2024 02:15:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1s6lRF-0005gs-6L
 for qemu-devel@nongnu.org; Tue, 14 May 2024 02:15:02 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1s6lRC-0001vj-EM
 for qemu-devel@nongnu.org; Tue, 14 May 2024 02:15:00 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6f4ed9dc7beso1887260b3a.1
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 23:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1715667174; x=1716271974;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5U88MQ1EYnI1xEBI7BtZA3bCgLHI2CS0/Ml/sSklTY0=;
 b=HEumDjibxNzDDectm4FX5oTUDcRn9fEK04ZaiuhNnTm5DTHWLl6INVPaNqhEdMkyah
 Jr6/8qff6shuTw3rx6o8K/fsFPrQR/CvCtXr3IFR41+4cg8tA2LGNauI81TlqAANQZWw
 n9XOAszKOsykXL/CLSm7Apyr2syscFhLcmTM3PoJV3Dk3josq74IKVZhQKRYkVlZhmYd
 DInB61OaYZKzKn2Glo9NUYyUF2Uembs8tgWbSs7pHLHOleJBvRazmqB0SBrooK0Fn++d
 U0zD51GA9HnZf/op95imOPSkvSjyH2qaS8oLDrA+RG7dxQFMqs7GZiXXr/4JD+9ydYjw
 PmBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715667174; x=1716271974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5U88MQ1EYnI1xEBI7BtZA3bCgLHI2CS0/Ml/sSklTY0=;
 b=k52Jt/66smPLVF02Jrwv3ghmjZEoMRnKkOn1R2f8TRV94F5/eRZE6UFpYhl46+pzDO
 +v1PRU/V9fgmEyl8G2drIStlXBGbuLmNT/lKwm9oQXLrl59XRE8TNQgqQUHPtalMUhZI
 xNrszElmyIvIzI4pSeeCVxWmuDiEPyWFq5R2R1tpEpDQbSCcPw6h5L+bGW9Jc+2efU4w
 KVLl0B4YMXxc6jHOVSXq1mGf650QueQubKtdVOluNNsYN6iZyF17Mr3XbfenkIdRvOlA
 vCQPEDwbrBIoA0xdAnxOgtIiplKJ3QSsQB8nt6f1NXcnZuTzSGGdc3jrSeaTXOSOMY3d
 8wDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyhjFIDwJGZ18wMkyp0c8IR2iAzN2zljWKizVYpA4IbZscv1d9vvkhE8aITBvTgtcFMzEvD2onwlozNqQg+jpn6Az49yQ=
X-Gm-Message-State: AOJu0Yys/ikR4q2W7bvtF1qQXZpjWCtHehTCFsmSNMXd/jyBVvPyAxpW
 FXudVfNFEUZ/CXJvL6z6kxUILcs+jdThIKZZdh58H6YHrPlxXFyE3E4zwaxAFh0=
X-Google-Smtp-Source: AGHT+IGrTLNxS5eKWBTmHGQSnqKYSEFm/x50FhLJq+kLIZ1WBh3tr9l9iEBHTyKmWMW5JPbWQRlhBQ==
X-Received: by 2002:a05:6a00:2d05:b0:6f3:8468:8bb with SMTP id
 d2e1a72fcca58-6f4df44e1c1mr17875618b3a.17.1715667174060; 
 Mon, 13 May 2024 23:12:54 -0700 (PDT)
Received: from localhost.localdomain.cc (vps-bd302c4a.vps.ovh.ca.
 [15.235.142.94]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4d2a9d94csm8624098b3a.95.2024.05.13.23.12.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 23:12:53 -0700 (PDT)
From: Li Feng <fengli@smartx.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-block@nongnu.org (open list:Block layer core),
 qemu-devel@nongnu.org (open list:All patches CC here)
Cc: Yajun Wu <yajunw@nvidia.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v3 1/2] Revert "vhost-user: fix lost reconnect"
Date: Tue, 14 May 2024 14:12:27 +0800
Message-ID: <20240514061239.86461-2-fengli@smartx.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514061239.86461-1-fengli@smartx.com>
References: <20240514061239.86461-1-fengli@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::436;
 envelope-from=fengli@smartx.com; helo=mail-pf1-x436.google.com
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

This reverts commit f02a4b8e6431598612466f76aac64ab492849abf.

Since the current patch cannot completely fix the lost reconnect
problem, there is a scenario that is not considered:
- When the virtio-blk driver is removed from the guest os,
  s->connected has no chance to be set to false, resulting in
  subsequent reconnection not being executed.

The next patch will completely fix this issue with a better approach.

Signed-off-by: Li Feng <fengli@smartx.com>
---
 hw/block/vhost-user-blk.c      |  2 +-
 hw/scsi/vhost-user-scsi.c      |  3 +--
 hw/virtio/vhost-user-base.c    |  2 +-
 hw/virtio/vhost-user.c         | 10 ++--------
 include/hw/virtio/vhost-user.h |  3 +--
 5 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 9e6bbc6950..41d1ac3a5a 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -384,7 +384,7 @@ static void vhost_user_blk_event(void *opaque, QEMUChrEvent event)
     case CHR_EVENT_CLOSED:
         /* defer close until later to avoid circular close */
         vhost_user_async_close(dev, &s->chardev, &s->dev,
-                               vhost_user_blk_disconnect, vhost_user_blk_event);
+                               vhost_user_blk_disconnect);
         break;
     case CHR_EVENT_BREAK:
     case CHR_EVENT_MUX_IN:
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index a63b1f4948..48a59e020e 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -214,8 +214,7 @@ static void vhost_user_scsi_event(void *opaque, QEMUChrEvent event)
     case CHR_EVENT_CLOSED:
         /* defer close until later to avoid circular close */
         vhost_user_async_close(dev, &vs->conf.chardev, &vsc->dev,
-                               vhost_user_scsi_disconnect,
-                               vhost_user_scsi_event);
+                               vhost_user_scsi_disconnect);
         break;
     case CHR_EVENT_BREAK:
     case CHR_EVENT_MUX_IN:
diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
index a83167191e..4b54255682 100644
--- a/hw/virtio/vhost-user-base.c
+++ b/hw/virtio/vhost-user-base.c
@@ -254,7 +254,7 @@ static void vub_event(void *opaque, QEMUChrEvent event)
     case CHR_EVENT_CLOSED:
         /* defer close until later to avoid circular close */
         vhost_user_async_close(dev, &vub->chardev, &vub->vhost_dev,
-                               vub_disconnect, vub_event);
+                               vub_disconnect);
         break;
     case CHR_EVENT_BREAK:
     case CHR_EVENT_MUX_IN:
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index cdf9af4a4b..c929097e87 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -2776,7 +2776,6 @@ typedef struct {
     DeviceState *dev;
     CharBackend *cd;
     struct vhost_dev *vhost;
-    IOEventHandler *event_cb;
 } VhostAsyncCallback;
 
 static void vhost_user_async_close_bh(void *opaque)
@@ -2791,10 +2790,7 @@ static void vhost_user_async_close_bh(void *opaque)
      */
     if (vhost->vdev) {
         data->cb(data->dev);
-    } else if (data->event_cb) {
-        qemu_chr_fe_set_handlers(data->cd, NULL, NULL, data->event_cb,
-                                 NULL, data->dev, NULL, true);
-   }
+    }
 
     g_free(data);
 }
@@ -2806,8 +2802,7 @@ static void vhost_user_async_close_bh(void *opaque)
  */
 void vhost_user_async_close(DeviceState *d,
                             CharBackend *chardev, struct vhost_dev *vhost,
-                            vu_async_close_fn cb,
-                            IOEventHandler *event_cb)
+                            vu_async_close_fn cb)
 {
     if (!runstate_check(RUN_STATE_SHUTDOWN)) {
         /*
@@ -2823,7 +2818,6 @@ void vhost_user_async_close(DeviceState *d,
         data->dev = d;
         data->cd = chardev;
         data->vhost = vhost;
-        data->event_cb = event_cb;
 
         /* Disable any further notifications on the chardev */
         qemu_chr_fe_set_handlers(chardev,
diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-user.h
index d7c09ffd34..324cd8663a 100644
--- a/include/hw/virtio/vhost-user.h
+++ b/include/hw/virtio/vhost-user.h
@@ -108,7 +108,6 @@ typedef void (*vu_async_close_fn)(DeviceState *cb);
 
 void vhost_user_async_close(DeviceState *d,
                             CharBackend *chardev, struct vhost_dev *vhost,
-                            vu_async_close_fn cb,
-                            IOEventHandler *event_cb);
+                            vu_async_close_fn cb);
 
 #endif
-- 
2.45.0


