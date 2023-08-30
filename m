Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 587F678D2E2
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 07:00:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbDJD-0007wF-5Z; Wed, 30 Aug 2023 01:00:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qbDIy-0007ua-EP
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 00:59:50 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qbDIq-00041n-34
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 00:59:47 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-56c2e882416so2602405a12.3
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 21:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1693371459; x=1693976259;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DYhaBgdJtds96WYpoue74AAWuPp3SkCXlJzfVY0iv9Y=;
 b=OGVVy7dInTY9mmwoQGdvU26hEWy7AUMoUhnfJQ4Hm8U7UDWJhklXga0xysc/Okwkrw
 VyJgLglNqDwfpMUFTgN0w7HW4UqOsuylYHD1CVgpgKTJiFGhiWSx2kgKXwmjlyXN7jRf
 EZPbIXcpUvJh15e66Plo4qiPpoMECnzqUP7L76Vw2ZFafIIoCIFTJYxa5K0h2chMemUB
 4JHe5icJAFSiAGbIEoWWsmWzHHlL4rx2NzpEbveEfNYQRFaGssiTgoEgs14izGSAKLh7
 1fKRfoBX68MWHg/88rjGUS/pcB25XBwYm9AnDWU+2vXxpI16BB9gs9TpdjMZuuquoxTg
 CBhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693371459; x=1693976259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DYhaBgdJtds96WYpoue74AAWuPp3SkCXlJzfVY0iv9Y=;
 b=XvSl0hikmOKoBkbgIvWyFHOP/Ur2gORQQ6A0p7hveSV8ZTB9eyCzfOjtR/wqqkDOX6
 y7xuRMxESLgNGlDzzMws2qvojF9XKyloMY/rJJt7DC+gwg+0zrKkCWoPNEvP2H9/jwB6
 VpQ/gcyRmOlIRjeXGvM9AuNRcE6EW2yjTeAJiJGeVPtBFxP1WI2+hRh+3emGZDHYywa2
 NghktydbwXy1LIkrZlqAgT05ZovDIWkgabLPKeB0GFIhYNmQPKCni5vmO60hfcmWEnQe
 rLEiI3PwFgTKKhOz3u5YFvJFkXersmS1+G0lvH3rucOuW5kEeQ/URz4vfxi34pKWM/sl
 BWcA==
X-Gm-Message-State: AOJu0Yw8wxwP4OVTzfaQzJet+DgLxwIN4sr6pPKJdFvbUZuaA7arB9z8
 FtebMFSlQFsWYLwoPxLbM30QMw==
X-Google-Smtp-Source: AGHT+IE2ynpzfGWaybdZrAH0Vrqp8hJmK9tnFW523ym2FMzw2JjusJKiwB/hXeaTdA2IKuA4NpYiJw==
X-Received: by 2002:a17:90a:f417:b0:26f:b158:ef2b with SMTP id
 ch23-20020a17090af41700b0026fb158ef2bmr1153079pjb.23.1693371458544; 
 Tue, 29 Aug 2023 21:57:38 -0700 (PDT)
Received: from 64217.gitgo.cc ([8.210.91.195])
 by smtp.gmail.com with ESMTPSA id
 t11-20020a170902a5cb00b001bfd92ec592sm10183553plq.292.2023.08.29.21.57.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 21:57:38 -0700 (PDT)
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
Subject: [PATCH v3 2/2] vhost: Add Error parameter to vhost_scsi_common_start()
Date: Wed, 30 Aug 2023 12:57:14 +0800
Message-ID: <20230830045722.611224-3-fengli@smartx.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230830045722.611224-1-fengli@smartx.com>
References: <20230804052954.2918915-1-fengli@smartx.com>
 <20230830045722.611224-1-fengli@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::52b;
 envelope-from=fengli@smartx.com; helo=mail-pg1-x52b.google.com
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

Add a Error parameter to report the real error, like vhost-user-blk.

Signed-off-by: Li Feng <fengli@smartx.com>
---
 hw/scsi/vhost-scsi-common.c           | 16 +++++++++-------
 hw/scsi/vhost-scsi.c                  |  5 +++--
 hw/scsi/vhost-user-scsi.c             | 14 ++++++++------
 include/hw/virtio/vhost-scsi-common.h |  2 +-
 4 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/hw/scsi/vhost-scsi-common.c b/hw/scsi/vhost-scsi-common.c
index a61cd0e907..4c8637045d 100644
--- a/hw/scsi/vhost-scsi-common.c
+++ b/hw/scsi/vhost-scsi-common.c
@@ -16,6 +16,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "hw/virtio/vhost.h"
@@ -25,7 +26,7 @@
 #include "hw/virtio/virtio-access.h"
 #include "hw/fw-path-provider.h"
 
-int vhost_scsi_common_start(VHostSCSICommon *vsc)
+int vhost_scsi_common_start(VHostSCSICommon *vsc, Error **errp)
 {
     int ret, i;
     VirtIODevice *vdev = VIRTIO_DEVICE(vsc);
@@ -35,18 +36,19 @@ int vhost_scsi_common_start(VHostSCSICommon *vsc)
     VirtIOSCSICommon *vs = (VirtIOSCSICommon *)vsc;
 
     if (!k->set_guest_notifiers) {
-        error_report("binding does not support guest notifiers");
+        error_setg(errp, "binding does not support guest notifiers");
         return -ENOSYS;
     }
 
     ret = vhost_dev_enable_notifiers(&vsc->dev, vdev);
     if (ret < 0) {
+        error_setg_errno(errp, -ret, "Error enabling host notifiers");
         return ret;
     }
 
     ret = k->set_guest_notifiers(qbus->parent, vsc->dev.nvqs, true);
     if (ret < 0) {
-        error_report("Error binding guest notifier");
+        error_setg_errno(errp, -ret, "Error binding guest notifier");
         goto err_host_notifiers;
     }
 
@@ -54,7 +56,7 @@ int vhost_scsi_common_start(VHostSCSICommon *vsc)
 
     ret = vhost_dev_prepare_inflight(&vsc->dev, vdev);
     if (ret < 0) {
-        error_report("Error setting inflight format: %d", -ret);
+        error_setg_errno(errp, -ret, "Error setting inflight format");
         goto err_guest_notifiers;
     }
 
@@ -64,21 +66,21 @@ int vhost_scsi_common_start(VHostSCSICommon *vsc)
                                         vs->conf.virtqueue_size,
                                         vsc->inflight);
             if (ret < 0) {
-                error_report("Error getting inflight: %d", -ret);
+                error_setg_errno(errp, -ret, "Error getting inflight");
                 goto err_guest_notifiers;
             }
         }
 
         ret = vhost_dev_set_inflight(&vsc->dev, vsc->inflight);
         if (ret < 0) {
-            error_report("Error setting inflight: %d", -ret);
+            error_setg_errno(errp, -ret, "Error setting inflight");
             goto err_guest_notifiers;
         }
     }
 
     ret = vhost_dev_start(&vsc->dev, vdev, true);
     if (ret < 0) {
-        error_report("Error start vhost dev");
+        error_setg_errno(errp, -ret, "Error starting vhost dev");
         goto err_guest_notifiers;
     }
 
diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index 443f67daa4..01a3ab4277 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -75,6 +75,7 @@ static int vhost_scsi_start(VHostSCSI *s)
     int ret, abi_version;
     VHostSCSICommon *vsc = VHOST_SCSI_COMMON(s);
     const VhostOps *vhost_ops = vsc->dev.vhost_ops;
+    Error *local_err = NULL;
 
     ret = vhost_ops->vhost_scsi_get_abi_version(&vsc->dev, &abi_version);
     if (ret < 0) {
@@ -88,14 +89,14 @@ static int vhost_scsi_start(VHostSCSI *s)
         return -ENOSYS;
     }
 
-    ret = vhost_scsi_common_start(vsc);
+    ret = vhost_scsi_common_start(vsc, &local_err);
     if (ret < 0) {
         return ret;
     }
 
     ret = vhost_scsi_set_endpoint(s);
     if (ret < 0) {
-        error_report("Error setting vhost-scsi endpoint");
+        error_reportf_err(local_err, "Error setting vhost-scsi endpoint");
         vhost_scsi_common_stop(vsc);
     }
 
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index e931df9f5b..62fc98bb1c 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -43,12 +43,12 @@ enum VhostUserProtocolFeature {
     VHOST_USER_PROTOCOL_F_RESET_DEVICE = 13,
 };
 
-static int vhost_user_scsi_start(VHostUserSCSI *s)
+static int vhost_user_scsi_start(VHostUserSCSI *s, Error **errp)
 {
     VHostSCSICommon *vsc = VHOST_SCSI_COMMON(s);
     int ret;
 
-    ret = vhost_scsi_common_start(vsc);
+    ret = vhost_scsi_common_start(vsc, errp);
     s->started_vu = (ret < 0 ? false : true);
 
     return ret;
@@ -73,6 +73,7 @@ static void vhost_user_scsi_set_status(VirtIODevice *vdev, uint8_t status)
     VHostSCSICommon *vsc = VHOST_SCSI_COMMON(s);
     VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(dev);
     bool should_start = virtio_device_should_start(vdev, status);
+    Error *local_err = NULL;
     int ret;
 
     if (!s->connected) {
@@ -84,9 +85,10 @@ static void vhost_user_scsi_set_status(VirtIODevice *vdev, uint8_t status)
     }
 
     if (should_start) {
-        ret = vhost_user_scsi_start(s);
+        ret = vhost_user_scsi_start(s, &local_err);
         if (ret < 0) {
-            error_report("unable to start vhost-user-scsi: %s", strerror(-ret));
+            error_reportf_err(local_err, "unable to start vhost-user-scsi: %s",
+                              strerror(-ret));
             qemu_chr_fe_disconnect(&vs->conf.chardev);
         }
     } else {
@@ -139,7 +141,7 @@ static void vhost_user_scsi_handle_output(VirtIODevice *vdev, VirtQueue *vq)
      * Some guests kick before setting VIRTIO_CONFIG_S_DRIVER_OK so start
      * vhost here instead of waiting for .set_status().
      */
-    ret = vhost_user_scsi_start(s);
+    ret = vhost_user_scsi_start(s, &local_err);
     if (ret < 0) {
         error_reportf_err(local_err, "vhost-user-scsi: vhost start failed: ");
         qemu_chr_fe_disconnect(&vs->conf.chardev);
@@ -184,7 +186,7 @@ static int vhost_user_scsi_connect(DeviceState *dev, Error **errp)
 
     /* restore vhost state */
     if (virtio_device_started(vdev, vdev->status)) {
-        ret = vhost_user_scsi_start(s);
+        ret = vhost_user_scsi_start(s, errp);
         if (ret < 0) {
             return ret;
         }
diff --git a/include/hw/virtio/vhost-scsi-common.h b/include/hw/virtio/vhost-scsi-common.h
index 18f115527c..c5d2c09455 100644
--- a/include/hw/virtio/vhost-scsi-common.h
+++ b/include/hw/virtio/vhost-scsi-common.h
@@ -39,7 +39,7 @@ struct VHostSCSICommon {
     struct vhost_inflight *inflight;
 };
 
-int vhost_scsi_common_start(VHostSCSICommon *vsc);
+int vhost_scsi_common_start(VHostSCSICommon *vsc, Error **errp);
 void vhost_scsi_common_stop(VHostSCSICommon *vsc);
 char *vhost_scsi_common_get_fw_dev_path(FWPathProvider *p, BusState *bus,
                                         DeviceState *dev);
-- 
2.41.0


