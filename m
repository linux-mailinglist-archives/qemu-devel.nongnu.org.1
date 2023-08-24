Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC287868DE
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 09:45:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ50R-0001ay-7h; Thu, 24 Aug 2023 03:43:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qZ50P-0001aL-Dc
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 03:43:49 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qZ50L-00048b-GV
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 03:43:49 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-68bed28818fso504787b3a.2
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 00:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1692862904; x=1693467704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DYhaBgdJtds96WYpoue74AAWuPp3SkCXlJzfVY0iv9Y=;
 b=lK+kA2HlA7118vkn7V7DfttctFXeizIumameZQdjWPmlN5qRv5CI2RjRo00Ko2Yydg
 stMz2ZHivFgv39vz/MQExnRUb7c5vn0vv9rXK164RKNjjrcSha17B4HlnZG/c8hP566n
 YcWoeazKXWGyrWJa1BR2gBDB+jqK/W63ASyjVWazlst0dxamH5HuFiOn+5lTclXUCDRX
 XNaowVsd+IpFq7/fICV9EQKCxMlb6grvY51g8lVBORNEgPSQlzGVieEo0tY+8ro7FE8o
 5G2s6BPUrBEfOl9QgrppvYDulNOt6W3O9NvAmNsVeP4XWhwG4ZTyBbq90A0w20ZPSRW1
 MIeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692862904; x=1693467704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DYhaBgdJtds96WYpoue74AAWuPp3SkCXlJzfVY0iv9Y=;
 b=Fd2ei9Ov6OHYM3lpSR1I+1qLU0AJ9DHPkVJgUS/9LxN3jjgJPQSvjxukMPOrdQPQ/s
 BVMp8hgcIzVFMHfA3gWuXKOXHdI6NV0dFMS2D61MdACsojBK/qwb0QDhk5ujOUKzEoZg
 DOU3kr7phN/bqUg7lPzRETk//nT9lSGWG+1qhZbFHfZLbvyYfUYbMQA4SrYH9I2PD2Ec
 ofOBoYXif+bNHNf0uJb7D5LlXyhIZfRMdYwb87jLGy4xWxer5T8758+4aNEB/q2eWPO2
 9lp+qgkD5sfncJtKM4iPBdtM6TwFjxyneFpgQSHMGhSLuEtteRViIha62bzHYm264QWR
 dBUg==
X-Gm-Message-State: AOJu0YztM0mwxcRo2QA3vPw3Q3QrQVl0CQyh8YbnY6yahROJAyDjZB4h
 fWg73HJnGmxOOiyPO1wDOQmbS9IJbhP5/R2EXiB56iLD
X-Google-Smtp-Source: AGHT+IGL8v/p/tOm57uqbUI4mOnMmgUzdp2G7kXxVMBo1ITVln6FwLwmHFcjaz89qsSxmZtcpJ10Ig==
X-Received: by 2002:a05:6a20:5524:b0:138:60e:9bb with SMTP id
 ko36-20020a056a20552400b00138060e09bbmr10666200pzb.28.1692862903708; 
 Thu, 24 Aug 2023 00:41:43 -0700 (PDT)
Received: from 64217.gitgo.cc ([8.210.91.195])
 by smtp.gmail.com with ESMTPSA id
 jk8-20020a170903330800b001b672af624esm12070112plb.164.2023.08.24.00.41.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 00:41:43 -0700 (PDT)
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
Subject: [PATCH v2 2/2] vhost: Add Error parameter to vhost_scsi_common_start()
Date: Thu, 24 Aug 2023 15:41:02 +0800
Message-ID: <20230824074115.93897-3-fengli@smartx.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824074115.93897-1-fengli@smartx.com>
References: <20230804052954.2918915-1-fengli@smartx.com>
 <20230824074115.93897-1-fengli@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::429;
 envelope-from=fengli@smartx.com; helo=mail-pf1-x429.google.com
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


