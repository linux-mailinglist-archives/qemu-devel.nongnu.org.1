Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A843379CAC1
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 10:57:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfzBn-00086W-84; Tue, 12 Sep 2023 04:56:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qfzBf-000848-PQ
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 04:55:59 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qfzBc-0002BE-Ut
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 04:55:59 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-575f45e255dso3271694eaf.2
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 01:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1694508835; x=1695113635;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+XH7wdtDBHjkJj1TRjhNqIG/+/Tyzm+qcFAhIy62ShA=;
 b=eGkFNge31C2jcb5NNce7IHkFw2K7yYw0pjU83EWY+mj7Pqt/KR0A9gQXD7h8ulkf60
 v7k8o/gfswLFbBrlYhMqsZj/9FiU0oenkO+I3lGo0jKoR4OjqgndfPt7atMRdQ6hNiE5
 2cZMzVjRcpCVSgr7xOUPZQ6VfjtwJsyhBXbt1g27tYmZzWqXNUdyWL7AyC9Sa8HT12HL
 wf4ZFE0AZNtfEFIjB2K2zesr+V9rIJvx0z6l+QIopCrK9UibQUUTtBglHgnACc3/0xpN
 PcetfjNyg8XQ3m5KkAZvKJhHrQS3MjkRxKSXclL8Z1UXHxltEVraxOWFXg/lY6WQXSck
 Lr+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694508835; x=1695113635;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+XH7wdtDBHjkJj1TRjhNqIG/+/Tyzm+qcFAhIy62ShA=;
 b=tZlcDVMqEsdYZcHFoaY9TLTSHotMqKI6bIuk3GHzipKfTU6livVGclEsP0WGcrXQdN
 6mOOOZPCCX7cXsbWLCAPm+KFrbnU4rNsx7i/5vuEh69UKbyqbncjWHb8SBjTzHzRqL0g
 0FI4QSwtDLP9QbBmRBqc47rolAjPcA7oRCpJXeWBBUFX1+1yQv/BeTVPOC+cgZzqBrSY
 rM6raNL3U6dELu0NGcd8OZUS7f2X4BnI7Fhz045GKOK+PUkAFTk7AEfn0L94sefxyNhL
 Qf8oKFrOgvZtEtHmH8KzzXyvnUa7xtq6ONhhfrej1UTZVTVk94X/ECOjuHNs7gDOruIX
 8Gtw==
X-Gm-Message-State: AOJu0Yz5AgiT/nL1E2HI4I+gK3tQwDRUWioklYTXGcJSReZINFVcT+gd
 bDvpyVG7hel2P22k2iaQCzXAxg==
X-Google-Smtp-Source: AGHT+IEuhR8gYZZpzK7HzrPM7ldpFlE7g5uaAKJBaBHdudFUzdhqwOpMzUGKXHqjym3uP7SgeM596Q==
X-Received: by 2002:a05:6871:296:b0:1bf:174b:a17e with SMTP id
 i22-20020a056871029600b001bf174ba17emr13535556oae.22.1694508835349; 
 Tue, 12 Sep 2023 01:53:55 -0700 (PDT)
Received: from 64217.gitgo.cc ([8.210.91.195])
 by smtp.gmail.com with ESMTPSA id
 m6-20020a637d46000000b00570668ccd5bsm6523754pgn.14.2023.09.12.01.53.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 01:53:54 -0700 (PDT)
From: Li Feng <fengli@smartx.com>
To: Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 qemu-block@nongnu.org (open list:Block layer core),
 qemu-devel@nongnu.org (open list:All patches CC here)
Cc: Li Feng <fengli@smartx.com>
Subject: [PATCH v4 3/5] vhost-user-scsi: support reconnect to backend
Date: Tue, 12 Sep 2023 16:52:45 +0800
Message-ID: <20230912085315.2524857-4-fengli@smartx.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912085315.2524857-1-fengli@smartx.com>
References: <20230721105205.1714449-1-fengli@smartx.com>
 <20230912085315.2524857-1-fengli@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=fengli@smartx.com; helo=mail-oo1-xc2b.google.com
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

If the backend crashes and restarts, the device is broken.
This patch adds reconnect for vhost-user-scsi.

This patch also improves the error messages, and reports some silent errors.

Tested with spdk backend.

Signed-off-by: Li Feng <fengli@smartx.com>
---
 hw/scsi/vhost-scsi-common.c           |  16 +-
 hw/scsi/vhost-scsi.c                  |   5 +-
 hw/scsi/vhost-user-scsi.c             | 204 +++++++++++++++++++++++---
 include/hw/virtio/vhost-scsi-common.h |   2 +-
 include/hw/virtio/vhost-user-scsi.h   |   4 +
 5 files changed, 201 insertions(+), 30 deletions(-)

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
index ee99b19e7a..dc109154ad 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -43,26 +43,56 @@ enum VhostUserProtocolFeature {
     VHOST_USER_PROTOCOL_F_RESET_DEVICE = 13,
 };
 
+static int vhost_user_scsi_start(VHostUserSCSI *s, Error **errp)
+{
+    VHostSCSICommon *vsc = VHOST_SCSI_COMMON(s);
+    int ret;
+
+    ret = vhost_scsi_common_start(vsc, errp);
+    s->started_vu = (ret < 0 ? false : true);
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
+    DeviceState *dev = &s->parent_obj.parent_obj.parent_obj.parent_obj;
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
 
@@ -89,14 +119,127 @@ static void vhost_dummy_handle_output(VirtIODevice *vdev, VirtQueue *vq)
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
@@ -115,18 +258,28 @@ static void vhost_user_scsi_realize(DeviceState *dev, Error **errp)
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
@@ -135,8 +288,12 @@ static void vhost_user_scsi_realize(DeviceState *dev, Error **errp)
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
@@ -146,16 +303,23 @@ static void vhost_user_scsi_unrealize(DeviceState *dev)
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
index 521b08e559..b405ec952a 100644
--- a/include/hw/virtio/vhost-user-scsi.h
+++ b/include/hw/virtio/vhost-user-scsi.h
@@ -29,6 +29,10 @@ OBJECT_DECLARE_SIMPLE_TYPE(VHostUserSCSI, VHOST_USER_SCSI)
 struct VHostUserSCSI {
     VHostSCSICommon parent_obj;
     VhostUserState vhost_user;
+    bool connected;
+    bool started_vu;
+
+    struct vhost_virtqueue *vhost_vqs;
 };
 
 #endif /* VHOST_USER_SCSI_H */
-- 
2.41.0


