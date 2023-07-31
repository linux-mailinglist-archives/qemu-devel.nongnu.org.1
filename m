Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F27B7695CD
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 14:14:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQRm3-0003Gl-Rb; Mon, 31 Jul 2023 08:13:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qQRly-0003FE-Fb
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 08:13:15 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qQRlv-000595-RB
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 08:13:14 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-686b9964ae2so2930148b3a.3
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 05:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1690805470; x=1691410270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U6hnNimq9gNOgoPdgNvDGfaGEO+kLFO1RzZStHFpC58=;
 b=EUUf5xO39D5qtB5YEtBmWSgAcEXm/XvUhQBuXkb2EWPhW3WJNEcjYxxag+IInPfiAV
 epA64C88qKLSZUwe01nmceDsGSDwuT54fV6X8UBkXI5TSHvLEKVrIGHTukK+flNjbWXD
 QS7z+bdRkTgkIay7VGXWeZB3nrv3dSs1FKUATgXxprOFrun4GvESTbm8bAJcfcYBKERI
 9zkwbbwwrQfxvjAri/LEL8Xdod1veH3SDvv7tzwWlPRt0iHTKmLFVKgej7l6yDgC8h5b
 58JaEmFkt+kI9nEgUEhNfMesKU43qXV17QxpsrkrtbGSrBhR3NNtL8DH9xQz0zann4JQ
 G4Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690805470; x=1691410270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U6hnNimq9gNOgoPdgNvDGfaGEO+kLFO1RzZStHFpC58=;
 b=kl1xHCgM4TfaRqX4aFZduI+4DbFv5LAaDIYoCyCDqKqeYsztIQWiwni/nLbx4zoiur
 76bEUHIu08YvnDGUeHRZ2oXIrlForGVveiCZdxoLc+pCGbKhBYRIFQ76YKKV8XBQxvl8
 RwQzm1W58sW6bWTq4GSbL9m//zz1IzKTT99V0cmZfJg2wBvfIt/uilFM2jTqKKklFNo2
 h4D+alxaRJ4lRGHKt6Z8/JdQMNNLotiKtyViC5r0dewp5HLJf4qo47+JZiTx3T+qju8h
 2detDZTBRSz3uwF683i4C1ez3NKg+UOEd6VBqZQsjN6VhB1kUvs0tRPc/+K26j/xFySb
 PEoA==
X-Gm-Message-State: ABy/qLYsz8btH7DTCpB70QRBpGZLMD7j1k9O0wU7TMss10q3b6LaDHmw
 vFT/G9D6OZZHnjkN4gexYLe4vA==
X-Google-Smtp-Source: APBJJlFPyD51QNitsaut6fZI7lVWk8EHlHKu8thh48KNkDkHVJuXY3eezMaEr782mY/KaZe4DYuCuw==
X-Received: by 2002:a05:6a20:644:b0:138:60e:9c4 with SMTP id
 4-20020a056a20064400b00138060e09c4mr6306011pzm.23.1690805469665; 
 Mon, 31 Jul 2023 05:11:09 -0700 (PDT)
Received: from localhost.localdomain.gitgo.cc ([47.75.78.161])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a62bd0a000000b005d22639b577sm7385690pff.165.2023.07.31.05.11.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Jul 2023 05:11:09 -0700 (PDT)
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
Subject: [PATCH v3 4/5] vhost-user-scsi: support reconnect to backend
Date: Mon, 31 Jul 2023 20:10:09 +0800
Message-ID: <20230731121018.2856310-5-fengli@smartx.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230731121018.2856310-1-fengli@smartx.com>
References: <20230721105205.1714449-1-fengli@smartx.com>
 <20230731121018.2856310-1-fengli@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42a;
 envelope-from=fengli@smartx.com; helo=mail-pf1-x42a.google.com
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

If the backend crashes and restarts, the device is broken.
This patch adds reconnect for vhost-user-scsi.

Tested with spdk backend.

Signed-off-by: Li Feng <fengli@smartx.com>
---
 hw/scsi/vhost-user-scsi.c           | 199 +++++++++++++++++++++++++---
 include/hw/virtio/vhost-user-scsi.h |   4 +
 2 files changed, 184 insertions(+), 19 deletions(-)

diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index ee99b19e7a..5bf012461b 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -43,26 +43,54 @@ enum VhostUserProtocolFeature {
     VHOST_USER_PROTOCOL_F_RESET_DEVICE = 13,
 };
 
+static int vhost_user_scsi_start(VHostUserSCSI *s)
+{
+    VHostSCSICommon *vsc = VHOST_SCSI_COMMON(s);
+    int ret;
+
+    ret = vhost_scsi_common_start(vsc);
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
+        ret = vhost_user_scsi_start(s);
         if (ret < 0) {
             error_report("unable to start vhost-user-scsi: %s", strerror(-ret));
-            exit(1);
+            qemu_chr_fe_disconnect(&vs->conf.chardev);
         }
     } else {
-        vhost_scsi_common_stop(vsc);
+        vhost_user_scsi_stop(s);
     }
 }
 
@@ -89,14 +117,126 @@ static void vhost_dummy_handle_output(VirtIODevice *vdev, VirtQueue *vq)
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
+        ret = vhost_user_scsi_start(s);
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
     VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(dev);
     VHostUserSCSI *s = VHOST_USER_SCSI(dev);
     VHostSCSICommon *vsc = VHOST_SCSI_COMMON(s);
-    struct vhost_virtqueue *vqs = NULL;
     Error *err = NULL;
     int ret;
+    int retries = VU_REALIZE_CONN_RETRIES;
 
     if (!vs->conf.chardev.chr) {
         error_setg(errp, "vhost-user-scsi: missing chardev");
@@ -115,18 +255,28 @@ static void vhost_user_scsi_realize(DeviceState *dev, Error **errp)
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
@@ -135,8 +285,12 @@ static void vhost_user_scsi_realize(DeviceState *dev, Error **errp)
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
@@ -146,16 +300,23 @@ static void vhost_user_scsi_unrealize(DeviceState *dev)
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


