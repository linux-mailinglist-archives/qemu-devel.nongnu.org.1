Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1019D76F993
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 07:34:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRnR4-0003rd-Nt; Fri, 04 Aug 2023 01:33:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qRnQm-0003dt-4A
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 01:32:56 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qRnQh-0003RT-89
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 01:32:55 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1bc02bd4eafso14771625ad.1
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 22:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1691127039; x=1691731839;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EoWKMRQRQvee5AHqMGvEiCAid/6peZU+GJ4Uu3wHwRQ=;
 b=16ZiA+k9aIzzlOyD3kZKe8xTk57E127Yp4X8puZN0XDBUQxf6fNLEW04JCPZyOdP/p
 ZnhBgMOBwRiygyFm4Qn9c8O+Oe1yIcxzhIz3vOsM4PJTb2lG/v/NY1t/1zs9vUmsyLkm
 bJajU9rFbDRaBRuWEeSDAyGGL1yGOwh++OXohalgoF/Xwns+40WW8wVE/jhzapAHWKfn
 RdA3pjTiHHDIEyCBNZRgFsqpByudZM4xv1iKVW38MaOawLodOpMjeIDr2KdhiU0E36R3
 kBoRXKIGVHTOc/0bpsHiZPsmdLbo5tih8zUiSvxNvumPt17WXjciTLc/NROMFXki1459
 kRVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691127039; x=1691731839;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EoWKMRQRQvee5AHqMGvEiCAid/6peZU+GJ4Uu3wHwRQ=;
 b=bIjpSZiZlfuFhWk4prwkNs3bcHMrXHj456z640yoAcXSoub4KwY6sqyWDrIB+RFFr2
 2reQ7+tUu+mg7OmpOYgODdtnhmExcXgRWSZwpMR2YKTZOEA6FUvfVMdIgx6NO5Y+BgfU
 ROFiFJ6BJooq9EJ97DMjwcSn3Kk2822UMkFQjN5qKOiuI4S7Zl075TMpnmk3I9baWcBY
 HaXiI9nsVEYiJuYzDKUqcIatCDzqCCgcApuzD4DHJjNlfU+XuVTKQf33zukYcLrYQuw4
 DbpSJ8kM1vEfzS7s1A4279fPcTI1eouVnrl8rMAttp2vxY4BFQRXDW1GO8mygMPKBoSW
 XTyw==
X-Gm-Message-State: AOJu0Yy/Hy4ZHTmtdcMugLh91+2xv6ziJujmd0Xr1VFqHE0J1iakkD0P
 QqBEJsOA/+Xt6bn/flLWq3tvCQ==
X-Google-Smtp-Source: AGHT+IFoFclPjVBRAwqsnvFJSuttMGnaD3/hv7VqABnu5uXhjxpCo/5DWsV8rjklgOZAfCLFHMetKQ==
X-Received: by 2002:a17:902:e847:b0:1bb:d860:9efd with SMTP id
 t7-20020a170902e84700b001bbd8609efdmr976815plg.15.1691127038538; 
 Thu, 03 Aug 2023 22:30:38 -0700 (PDT)
Received: from bogon.gitgo.cc ([47.75.78.161])
 by smtp.gmail.com with ESMTPSA id
 p7-20020a170902bd0700b001bc2831e1a8sm781183pls.80.2023.08.03.22.30.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Aug 2023 22:30:38 -0700 (PDT)
From: Li Feng <fengli@smartx.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Raphael Norwitz <raphael.norwitz@nutanix.com>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Cc: Li Feng <fengli@smartx.com>
Subject: [PATCH 2/2] vhost: Add Error parameter to vhost_scsi_common_start()
Date: Fri,  4 Aug 2023 13:29:48 +0800
Message-ID: <20230804052954.2918915-3-fengli@smartx.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230804052954.2918915-1-fengli@smartx.com>
References: <20230804052954.2918915-1-fengli@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::634;
 envelope-from=fengli@smartx.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
 hw/scsi/vhost-scsi-common.c           | 17 ++++++++++-------
 hw/scsi/vhost-scsi.c                  |  5 +++--
 hw/scsi/vhost-user-scsi.c             | 14 ++++++++------
 include/hw/virtio/vhost-scsi-common.h |  2 +-
 4 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/hw/scsi/vhost-scsi-common.c b/hw/scsi/vhost-scsi-common.c
index a61cd0e907..392587dfb5 100644
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
+        error_setg_errno(errp, -ret, "Error setting inflight format: %d", -ret);
         goto err_guest_notifiers;
     }
 
@@ -64,21 +66,22 @@ int vhost_scsi_common_start(VHostSCSICommon *vsc)
                                         vs->conf.virtqueue_size,
                                         vsc->inflight);
             if (ret < 0) {
-                error_report("Error getting inflight: %d", -ret);
+                error_setg_errno(errp, -ret, "Error getting inflight: %d",
+                                 -ret);
                 goto err_guest_notifiers;
             }
         }
 
         ret = vhost_dev_set_inflight(&vsc->dev, vsc->inflight);
         if (ret < 0) {
-            error_report("Error setting inflight: %d", -ret);
+            error_setg_errno(errp, -ret, "Error setting inflight: %d", -ret);
             goto err_guest_notifiers;
         }
     }
 
     ret = vhost_dev_start(&vsc->dev, vdev, true);
     if (ret < 0) {
-        error_report("Error start vhost dev");
+        error_setg_errno(errp, -ret, "Error start vhost dev");
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
index a7fa8e8df2..d368171e28 100644
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


