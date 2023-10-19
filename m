Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1E17D01DB
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:37:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXha-00019s-1Y; Thu, 19 Oct 2023 14:24:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXh8-0000A4-VY
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:24:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXh5-0002Vz-LI
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:24:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697739867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IfCJRn8r77VYMrjpWnu9brJ2+zJiZU2dGmOU5Pe2LJc=;
 b=ejYMTRoyBy7iCz0/E68NvUGppLiF5p+xOSlcyIrSxXYXhOj37OYbPijYV3QTIco5FCuZpg
 AA/0tyrzis56ZU+1/yXkL4w2PNeY+MNClasg4SrvYu3UWGG7ptGx181ligShNuVM3ec4Uf
 dLSty+bqhIYK+3jAo8zjnjQjnLxUf2M=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-BuBXIBuRNOW-UFwTWxvZkg-1; Thu, 19 Oct 2023 14:24:20 -0400
X-MC-Unique: BuBXIBuRNOW-UFwTWxvZkg-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2c5032ab59eso68971341fa.3
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:24:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697739858; x=1698344658;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IfCJRn8r77VYMrjpWnu9brJ2+zJiZU2dGmOU5Pe2LJc=;
 b=de19OMIbUa6UPtyoEmr9qCHQlo/qYC2FER2wk/3dy+TYZ3rZkkfL4jPpurD8p1l125
 pscCCTy+6VEoP/NYa3Q5BC/qvQmxCrHF3HW6qdCkb92seri2N7vbUuZPKuL09zHwh4ve
 +jz7bq9+GUdXlXXoG3VtZQnd9aprVh1CBfb1c+0//1EQ+7x7GChnx2ewZKTcs3rLxSBp
 /ja6ZbF4F1R5GFJJl9kJbrRiauXnRHyptCr7GCvq3vGmubs/PqLj8mmp5gDlsyfygh5D
 z+QMCAFv5U6TCyHL5stnnIFNQGBoYAvrFcfc0ymmngu07VimGcJzMFGabov4QWKW4Vk+
 jNXw==
X-Gm-Message-State: AOJu0Yx8B1oZrl4h+x32AOvOrjX7KLeJNbIO3KsCyWe7d9aUsWy6qw3+
 qpDSjwTidzsTNWL+Ggkns9NG6fn4bR/0rP+XCUmaySF6Ej32GER8qp+xeVO7DqsZuhuThmOQdsU
 b4FNvj5sEeUkKYmMV1wue9hHE0xM44bzfkfxXAlgjRaJAQOZlTnJFEZFcSbebkBvnkBFa
X-Received: by 2002:a05:651c:4c7:b0:2bf:eccb:548 with SMTP id
 e7-20020a05651c04c700b002bfeccb0548mr3076034lji.0.1697739858302; 
 Thu, 19 Oct 2023 11:24:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3zurUF5odlPFuYJvgiAp5cjMChPU6iSConeG29wKdJiU6U8nl4WKay6HST+ZZjUSIE9AXbg==
X-Received: by 2002:a05:651c:4c7:b0:2bf:eccb:548 with SMTP id
 e7-20020a05651c04c700b002bfeccb0548mr3076020lji.0.1697739857954; 
 Thu, 19 Oct 2023 11:24:17 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 e34-20020a5d5962000000b003143c9beeaesm4996764wri.44.2023.10.19.11.24.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 11:24:17 -0700 (PDT)
Date: Thu, 19 Oct 2023 14:24:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Li Feng <fengli@smartx.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: [PULL v2 69/78] vhost-user-scsi: support reconnect to backend
Message-ID: <9dd0ffb1b904619ccc5e6b176c75877ed82be42f.1697739629.git.mst@redhat.com>
References: <cover.1697739629.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697739629.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Li Feng <fengli@smartx.com>

If the backend crashes and restarts, the device is broken.
This patch adds reconnect for vhost-user-scsi.

This patch also improves the error messages, and reports some silent errors.

Tested with spdk backend.

Signed-off-by: Li Feng <fengli@smartx.com>
Message-Id: <20231009044735.941655-4-fengli@smartx.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 include/hw/virtio/vhost-scsi-common.h |   2 +-
 include/hw/virtio/vhost-user-scsi.h   |   6 +
 hw/scsi/vhost-scsi-common.c           |  16 +-
 hw/scsi/vhost-scsi.c                  |   6 +-
 hw/scsi/vhost-user-scsi.c             | 201 +++++++++++++++++++++++---
 5 files changed, 201 insertions(+), 30 deletions(-)

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
diff --git a/include/hw/virtio/vhost-user-scsi.h b/include/hw/virtio/vhost-user-scsi.h
index 521b08e559..78fe616ccb 100644
--- a/include/hw/virtio/vhost-user-scsi.h
+++ b/include/hw/virtio/vhost-user-scsi.h
@@ -28,7 +28,13 @@ OBJECT_DECLARE_SIMPLE_TYPE(VHostUserSCSI, VHOST_USER_SCSI)
 
 struct VHostUserSCSI {
     VHostSCSICommon parent_obj;
+
+    /* Properties */
+    bool connected;
+    bool started_vu;
+
     VhostUserState vhost_user;
+    struct vhost_virtqueue *vhost_vqs;
 };
 
 #endif /* VHOST_USER_SCSI_H */
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
index 443f67daa4..95cadb93e7 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -75,6 +75,7 @@ static int vhost_scsi_start(VHostSCSI *s)
     int ret, abi_version;
     VHostSCSICommon *vsc = VHOST_SCSI_COMMON(s);
     const VhostOps *vhost_ops = vsc->dev.vhost_ops;
+    Error *local_err = NULL;
 
     ret = vhost_ops->vhost_scsi_get_abi_version(&vsc->dev, &abi_version);
     if (ret < 0) {
@@ -88,14 +89,15 @@ static int vhost_scsi_start(VHostSCSI *s)
         return -ENOSYS;
     }
 
-    ret = vhost_scsi_common_start(vsc);
+    ret = vhost_scsi_common_start(vsc, &local_err);
     if (ret < 0) {
+        error_reportf_err(local_err, "Error starting vhost-scsi");
         return ret;
     }
 
     ret = vhost_scsi_set_endpoint(s);
     if (ret < 0) {
-        error_report("Error setting vhost-scsi endpoint");
+        error_reportf_err(local_err, "Error setting vhost-scsi endpoint");
         vhost_scsi_common_stop(vsc);
     }
 
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index b7c6100f3e..24c250d3f8 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -39,26 +39,56 @@ static const int user_feature_bits[] = {
     VHOST_INVALID_FEATURE_BIT
 };
 
+static int vhost_user_scsi_start(VHostUserSCSI *s, Error **errp)
+{
+    VHostSCSICommon *vsc = VHOST_SCSI_COMMON(s);
+    int ret;
+
+    ret = vhost_scsi_common_start(vsc, errp);
+    s->started_vu = !(ret < 0);
+
+    return ret;
+}
+
+static void vhost_user_scsi_stop(VHostUserSCSI *s)
+{
+    VHostSCSICommon *vsc = VHOST_SCSI_COMMON(s);
+
+    if (!s->started_vu) {
+        return;
+    }
+    s->started_vu = false;
+
+    vhost_scsi_common_stop(vsc);
+}
+
 static void vhost_user_scsi_set_status(VirtIODevice *vdev, uint8_t status)
 {
     VHostUserSCSI *s = (VHostUserSCSI *)vdev;
+    DeviceState *dev = DEVICE(vdev);
     VHostSCSICommon *vsc = VHOST_SCSI_COMMON(s);
-    bool start = (status & VIRTIO_CONFIG_S_DRIVER_OK) && vdev->vm_running;
+    VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(dev);
+    bool should_start = virtio_device_should_start(vdev, status);
+    Error *local_err = NULL;
+    int ret;
 
-    if (vhost_dev_is_started(&vsc->dev) == start) {
+    if (!s->connected) {
         return;
     }
 
-    if (start) {
-        int ret;
+    if (vhost_dev_is_started(&vsc->dev) == should_start) {
+        return;
+    }
 
-        ret = vhost_scsi_common_start(vsc);
+    if (should_start) {
+        ret = vhost_user_scsi_start(s, &local_err);
         if (ret < 0) {
-            error_report("unable to start vhost-user-scsi: %s", strerror(-ret));
-            exit(1);
+            error_reportf_err(local_err, "unable to start vhost-user-scsi: %s",
+                              strerror(-ret));
+            qemu_chr_fe_disconnect(&vs->conf.chardev);
         }
     } else {
-        vhost_scsi_common_stop(vsc);
+        vhost_user_scsi_stop(s);
     }
 }
 
@@ -66,14 +96,124 @@ static void vhost_dummy_handle_output(VirtIODevice *vdev, VirtQueue *vq)
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
+        ret = vhost_user_scsi_start(s, errp);
+    }
+
+    return ret;
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
+    vhost_user_scsi_stop(s);
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
+    DeviceState *dev = DEVICE(s);
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
+    ERRP_GUARD();
     VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(dev);
     VHostUserSCSI *s = VHOST_USER_SCSI(dev);
     VHostSCSICommon *vsc = VHOST_SCSI_COMMON(s);
-    struct vhost_virtqueue *vqs = NULL;
     Error *err = NULL;
     int ret;
+    int retries = VU_REALIZE_CONN_RETRIES;
 
     if (!vs->conf.chardev.chr) {
         error_setg(errp, "vhost-user-scsi: missing chardev");
@@ -92,18 +232,28 @@ static void vhost_user_scsi_realize(DeviceState *dev, Error **errp)
         goto free_virtio;
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
         goto free_vhost;
     }
 
+    /* we're fully initialized, now we can operate, so add the handler */
+    qemu_chr_fe_set_handlers(&vs->conf.chardev,  NULL, NULL,
+                             vhost_user_scsi_event, NULL, (void *)dev,
+                             NULL, true);
     /* Channel and lun both are 0 for bootable vhost-user-scsi disk */
     vsc->channel = 0;
     vsc->lun = 0;
@@ -112,8 +262,12 @@ static void vhost_user_scsi_realize(DeviceState *dev, Error **errp)
     return;
 
 free_vhost:
+    g_free(s->vhost_vqs);
+    s->vhost_vqs = NULL;
+    g_free(vsc->inflight);
+    vsc->inflight = NULL;
     vhost_user_cleanup(&s->vhost_user);
-    g_free(vqs);
+
 free_virtio:
     virtio_scsi_common_unrealize(dev);
 }
@@ -123,16 +277,23 @@ static void vhost_user_scsi_unrealize(DeviceState *dev)
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
+    g_free(s->vhost_vqs);
+    s->vhost_vqs = NULL;
+
+    vhost_dev_free_inflight(vsc->inflight);
+    g_free(vsc->inflight);
+    vsc->inflight = NULL;
 
-    virtio_scsi_common_unrealize(dev);
     vhost_user_cleanup(&s->vhost_user);
+    virtio_scsi_common_unrealize(dev);
 }
 
 static Property vhost_user_scsi_properties[] = {
-- 
MST


