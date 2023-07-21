Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE6375C516
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 12:55:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMnmI-0001EQ-BD; Fri, 21 Jul 2023 06:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qMnmE-0001E6-J1
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 06:54:26 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qMnmA-0004tN-K0
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 06:54:26 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1b89600a37fso11573265ad.2
 for <qemu-devel@nongnu.org>; Fri, 21 Jul 2023 03:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1689936737; x=1690541537;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6W8C7rFibqHDhrw6L5RpAzolrzeEfVWE3BtgA5JGR5w=;
 b=Qyey+dmrqrlX0ENCnHOe0epKbnANB5sig7gp5men4vosNeOd6WS3zMaoefUEH+u5V8
 gHZ722gW0bWgOhk29Gv4X42CnxT9wxP+g0QEqNEtDbd8J0oD3VzXLdtFnCm0u10NoX4D
 bs6CfhuFc33yem6lxAuyMfWFm+YmB6tD9z0Z6F3oH/ESdUgsCQTdDWyFnENObPbjkusv
 bhOrwFoGSu25peaPcoC+YTFYeVIRM+PRfkJ7l1iG0redZG2Tf36V1EcvRn6Q4JZ5/5W6
 +eI++R+Ep1V85nbG6G+XE7MKLXiqBTw4n/WJMdHTXXvqJKFP5Y+stlBdG+HrxEbqmgOV
 KjWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689936737; x=1690541537;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6W8C7rFibqHDhrw6L5RpAzolrzeEfVWE3BtgA5JGR5w=;
 b=Tr5bGr9JxhBTdUScwsG9ny/C+h6lpKyN5OEWvP2UMgidnCpazlKe+jdhL5w24j3rqK
 0hCKvQpclnuyNkIlPvdPrXZQzkUl4VqIaI+9QuhqaGqZiGs6WmrTdHKt55Z3Ryy5YdU+
 0ghMGW7hN60mEI4s5VPwU4yWZghcONmVIbnV4casU2GKl5Jo6zC6w7LQsHyTRcezd8BO
 iOyuQD4zSn2rFbtGsjJtW969bir3gY2JyiZ2HWbBv9Dmkk9N48IziUTAY0hAjYpTDvYQ
 9dxV9U+QzpsW+V/I6PnDoI1I012ZZvh20eunQm/uoWkhtl3BcqpoWbZLvNK5+y3dSqpQ
 h9Mw==
X-Gm-Message-State: ABy/qLZdKP9Uhz4vYlPNfasXYBMgdjrDEKRoH66ZbzamyDq8SXVNjaWc
 7s7oxlJNuSoiKavBafen9+Ittg==
X-Google-Smtp-Source: APBJJlFsYEt4PN2pd00Yr5T8PE72AwblgARkCt+3onHI/ht3s1UV1YD/SC9LuwEY3wZPn7qa6CmEMw==
X-Received: by 2002:a17:902:ec84:b0:1b9:de3e:7a59 with SMTP id
 x4-20020a170902ec8400b001b9de3e7a59mr1747300plg.10.1689936737179; 
 Fri, 21 Jul 2023 03:52:17 -0700 (PDT)
Received: from localhost.localdomain.gitgo.cc ([47.75.78.161])
 by smtp.gmail.com with ESMTPSA id
 je15-20020a170903264f00b001b8ad8382a4sm3124254plb.216.2023.07.21.03.52.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jul 2023 03:52:16 -0700 (PDT)
From: Li Feng <fengli@smartx.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org (open list:Block layer core),
 qemu-devel@nongnu.org (open list:All patches CC here)
Cc: lifeng1519@gmail.com,
	Li Feng <fengli@smartx.com>
Subject: [PATCH] vhost-user-scsi: support reconnect to backend
Date: Fri, 21 Jul 2023 18:51:59 +0800
Message-ID: <20230721105205.1714449-1-fengli@smartx.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::632;
 envelope-from=fengli@smartx.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

If the backend crashes and restarts, the device is broken.
This patch adds reconnect for vhost-user-scsi.

Tested with spdk backend.

Signed-off-by: Li Feng <fengli@smartx.com>
---
 hw/block/vhost-user-blk.c           |   2 -
 hw/scsi/vhost-scsi-common.c         |  27 ++---
 hw/scsi/vhost-user-scsi.c           | 163 +++++++++++++++++++++++++---
 include/hw/virtio/vhost-user-scsi.h |   3 +
 include/hw/virtio/vhost.h           |   2 +
 5 files changed, 165 insertions(+), 32 deletions(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index eecf3f7a81..f250c740b5 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -32,8 +32,6 @@
 #include "sysemu/sysemu.h"
 #include "sysemu/runstate.h"
 
-#define REALIZE_CONNECTION_RETRIES 3
-
 static const int user_feature_bits[] = {
     VIRTIO_BLK_F_SIZE_MAX,
     VIRTIO_BLK_F_SEG_MAX,
diff --git a/hw/scsi/vhost-scsi-common.c b/hw/scsi/vhost-scsi-common.c
index a06f01af26..08801886b8 100644
--- a/hw/scsi/vhost-scsi-common.c
+++ b/hw/scsi/vhost-scsi-common.c
@@ -52,16 +52,22 @@ int vhost_scsi_common_start(VHostSCSICommon *vsc)
 
     vsc->dev.acked_features = vdev->guest_features;
 
-    assert(vsc->inflight == NULL);
-    vsc->inflight = g_new0(struct vhost_inflight, 1);
-    ret = vhost_dev_get_inflight(&vsc->dev,
-                                 vs->conf.virtqueue_size,
-                                 vsc->inflight);
+    ret = vhost_dev_prepare_inflight(&vsc->dev, vdev);
     if (ret < 0) {
-        error_report("Error get inflight: %d", -ret);
+        error_report("Error setting inflight format: %d", -ret);
         goto err_guest_notifiers;
     }
 
+    if (!vsc->inflight->addr) {
+        ret = vhost_dev_get_inflight(&vsc->dev,
+                                    vs->conf.virtqueue_size,
+                                    vsc->inflight);
+        if (ret < 0) {
+            error_report("Error get inflight: %d", -ret);
+            goto err_guest_notifiers;
+        }
+    }
+
     ret = vhost_dev_set_inflight(&vsc->dev, vsc->inflight);
     if (ret < 0) {
         error_report("Error set inflight: %d", -ret);
@@ -85,9 +91,6 @@ int vhost_scsi_common_start(VHostSCSICommon *vsc)
     return ret;
 
 err_guest_notifiers:
-    g_free(vsc->inflight);
-    vsc->inflight = NULL;
-
     k->set_guest_notifiers(qbus->parent, vsc->dev.nvqs, false);
 err_host_notifiers:
     vhost_dev_disable_notifiers(&vsc->dev, vdev);
@@ -111,12 +114,6 @@ void vhost_scsi_common_stop(VHostSCSICommon *vsc)
     }
     assert(ret >= 0);
 
-    if (vsc->inflight) {
-        vhost_dev_free_inflight(vsc->inflight);
-        g_free(vsc->inflight);
-        vsc->inflight = NULL;
-    }
-
     vhost_dev_disable_notifiers(&vsc->dev, vdev);
 }
 
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index ee99b19e7a..e0e88b0c42 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -89,14 +89,126 @@ static void vhost_dummy_handle_output(VirtIODevice *vdev, VirtQueue *vq)
 {
 }
 
+static int vhost_user_scsi_connect(DeviceState *dev, Error **errp)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VHostUserSCSI *s = VHOST_USER_SCSI(vdev);
+    VHostSCSICommon *vsc = VHOST_SCSI_COMMON(s);
+    VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(dev);
+    int ret = 0;
+
+    if (s->connected) {
+        return 0;
+    }
+    s->connected = true;
+
+    vsc->dev.num_queues = vs->conf.num_queues;
+    vsc->dev.nvqs = VIRTIO_SCSI_VQ_NUM_FIXED + vs->conf.num_queues;
+    vsc->dev.vqs = s->vhost_vqs;
+    vsc->dev.vq_index = 0;
+    vsc->dev.backend_features = 0;
+
+    ret = vhost_dev_init(&vsc->dev, &s->vhost_user, VHOST_BACKEND_TYPE_USER, 0,
+                         errp);
+    if (ret < 0) {
+        return ret;
+    }
+
+    /* restore vhost state */
+    if (virtio_device_started(vdev, vdev->status)) {
+        ret = vhost_scsi_common_start(vsc);
+        if (ret < 0) {
+            return ret;
+        }
+    }
+
+    return 0;
+}
+
+static void vhost_user_scsi_event(void *opaque, QEMUChrEvent event);
+
+static void vhost_user_scsi_disconnect(DeviceState *dev)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VHostUserSCSI *s = VHOST_USER_SCSI(vdev);
+    VHostSCSICommon *vsc = VHOST_SCSI_COMMON(s);
+    VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(dev);
+
+    if (!s->connected) {
+        return;
+    }
+    s->connected = false;
+
+    vhost_scsi_common_stop(vsc);
+
+    vhost_dev_cleanup(&vsc->dev);
+
+    /* Re-instate the event handler for new connections */
+    qemu_chr_fe_set_handlers(&vs->conf.chardev, NULL, NULL,
+                             vhost_user_scsi_event, NULL, dev, NULL, true);
+}
+
+static void vhost_user_scsi_event(void *opaque, QEMUChrEvent event)
+{
+    DeviceState *dev = opaque;
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VHostUserSCSI *s = VHOST_USER_SCSI(vdev);
+    VHostSCSICommon *vsc = VHOST_SCSI_COMMON(s);
+    VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(dev);
+    Error *local_err = NULL;
+
+    switch (event) {
+    case CHR_EVENT_OPENED:
+        if (vhost_user_scsi_connect(dev, &local_err) < 0) {
+            error_report_err(local_err);
+            qemu_chr_fe_disconnect(&vs->conf.chardev);
+            return;
+        }
+        break;
+    case CHR_EVENT_CLOSED:
+        /* defer close until later to avoid circular close */
+        vhost_user_async_close(dev, &vs->conf.chardev, &vsc->dev,
+                               vhost_user_scsi_disconnect);
+        break;
+    case CHR_EVENT_BREAK:
+    case CHR_EVENT_MUX_IN:
+    case CHR_EVENT_MUX_OUT:
+        /* Ignore */
+        break;
+    }
+}
+
+static int vhost_user_scsi_realize_connect(VHostUserSCSI *s, Error **errp)
+{
+    DeviceState *dev = &s->parent_obj.parent_obj.parent_obj.parent_obj;
+    VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(dev);
+    int ret;
+
+    s->connected = false;
+
+    ret = qemu_chr_fe_wait_connected(&vs->conf.chardev, errp);
+    if (ret < 0) {
+        return ret;
+    }
+
+    ret = vhost_user_scsi_connect(dev, errp);
+    if (ret < 0) {
+        qemu_chr_fe_disconnect(&vs->conf.chardev);
+        return ret;
+    }
+    assert(s->connected);
+
+    return 0;
+}
+
 static void vhost_user_scsi_realize(DeviceState *dev, Error **errp)
 {
     VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(dev);
     VHostUserSCSI *s = VHOST_USER_SCSI(dev);
     VHostSCSICommon *vsc = VHOST_SCSI_COMMON(s);
-    struct vhost_virtqueue *vqs = NULL;
     Error *err = NULL;
     int ret;
+    int retries = REALIZE_CONNECTION_RETRIES;
 
     if (!vs->conf.chardev.chr) {
         error_setg(errp, "vhost-user-scsi: missing chardev");
@@ -112,21 +224,31 @@ static void vhost_user_scsi_realize(DeviceState *dev, Error **errp)
     }
 
     if (!vhost_user_init(&s->vhost_user, &vs->conf.chardev, errp)) {
-        goto free_virtio;
+        goto free_vhost;
     }
 
-    vsc->dev.nvqs = VIRTIO_SCSI_VQ_NUM_FIXED + vs->conf.num_queues;
-    vsc->dev.vqs = g_new0(struct vhost_virtqueue, vsc->dev.nvqs);
-    vsc->dev.vq_index = 0;
-    vsc->dev.backend_features = 0;
-    vqs = vsc->dev.vqs;
+    vsc->inflight = g_new0(struct vhost_inflight, 1);
+    s->vhost_vqs = g_new0(struct vhost_virtqueue,
+                          VIRTIO_SCSI_VQ_NUM_FIXED + vs->conf.num_queues);
+
+    assert(!*errp);
+    do {
+        if (*errp) {
+            error_prepend(errp, "Reconnecting after error: ");
+            error_report_err(*errp);
+            *errp = NULL;
+        }
+        ret = vhost_user_scsi_realize_connect(s, errp);
+    } while (ret < 0 && retries--);
 
-    ret = vhost_dev_init(&vsc->dev, &s->vhost_user,
-                         VHOST_BACKEND_TYPE_USER, 0, errp);
     if (ret < 0) {
-        goto free_vhost;
+        goto free_vqs;
     }
 
+    /* we're fully initialized, now we can operate, so add the handler */
+    qemu_chr_fe_set_handlers(&vs->conf.chardev,  NULL, NULL,
+                             vhost_user_scsi_event, NULL, (void *)dev,
+                             NULL, true);
     /* Channel and lun both are 0 for bootable vhost-user-scsi disk */
     vsc->channel = 0;
     vsc->lun = 0;
@@ -134,10 +256,15 @@ static void vhost_user_scsi_realize(DeviceState *dev, Error **errp)
 
     return;
 
+free_vqs:
+    g_free(s->vhost_vqs);
+    s->vhost_vqs = NULL;
+    g_free(vsc->inflight);
+    vsc->inflight = NULL;
+
 free_vhost:
     vhost_user_cleanup(&s->vhost_user);
-    g_free(vqs);
-free_virtio:
+
     virtio_scsi_common_unrealize(dev);
 }
 
@@ -146,16 +273,22 @@ static void vhost_user_scsi_unrealize(DeviceState *dev)
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VHostUserSCSI *s = VHOST_USER_SCSI(dev);
     VHostSCSICommon *vsc = VHOST_SCSI_COMMON(s);
-    struct vhost_virtqueue *vqs = vsc->dev.vqs;
+    VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(dev);
 
     /* This will stop the vhost backend. */
     vhost_user_scsi_set_status(vdev, 0);
+    qemu_chr_fe_set_handlers(&vs->conf.chardev, NULL, NULL, NULL, NULL, NULL,
+                             NULL, false);
 
     vhost_dev_cleanup(&vsc->dev);
-    g_free(vqs);
+    vhost_dev_free_inflight(vsc->inflight);
+    g_free(s->vhost_vqs);
+    s->vhost_vqs = NULL;
+    g_free(vsc->inflight);
+    vsc->inflight = NULL;
 
-    virtio_scsi_common_unrealize(dev);
     vhost_user_cleanup(&s->vhost_user);
+    virtio_scsi_common_unrealize(dev);
 }
 
 static Property vhost_user_scsi_properties[] = {
diff --git a/include/hw/virtio/vhost-user-scsi.h b/include/hw/virtio/vhost-user-scsi.h
index 521b08e559..c66acc68b7 100644
--- a/include/hw/virtio/vhost-user-scsi.h
+++ b/include/hw/virtio/vhost-user-scsi.h
@@ -29,6 +29,9 @@ OBJECT_DECLARE_SIMPLE_TYPE(VHostUserSCSI, VHOST_USER_SCSI)
 struct VHostUserSCSI {
     VHostSCSICommon parent_obj;
     VhostUserState vhost_user;
+    bool connected;
+
+    struct vhost_virtqueue *vhost_vqs;
 };
 
 #endif /* VHOST_USER_SCSI_H */
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 6a173cb9fa..b904346fe1 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -8,6 +8,8 @@
 #define VHOST_F_DEVICE_IOTLB 63
 #define VHOST_USER_F_PROTOCOL_FEATURES 30
 
+#define REALIZE_CONNECTION_RETRIES 3
+
 /* Generic structures common for any vhost based device. */
 
 struct vhost_inflight {
-- 
2.41.0


