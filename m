Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04772761129
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 12:47:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOFXr-0008EC-J9; Tue, 25 Jul 2023 06:45:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qOFXp-0008Dt-VL
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 06:45:33 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qOFXn-00037J-Q8
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 06:45:33 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6862842a028so2981032b3a.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 03:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1690281810; x=1690886610;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VOUIT8kGELsnE/AoIXIltAsJSkBIdaBBGe0R8el5eWY=;
 b=UVsunI7IukB2yvUPsH1Vkr8Ej2h63JJZAS4Qo7sV/Xy8secs/D7/i2BTG3mNYvye7f
 Ff971PbuwMQspryrm4swJ1Ku39zJEFoxT40dlpQR+NjF/wqAT18KZdL4PK+P+r2li4Xw
 hZ64NBkW5btuW0+ZH5+RN2BV4HAK69lCptWFqTwf7Yl33kURb60oxGAK/msSiSi+zQXj
 /KREa8XKphPj9CzxySP3u+6IFPm6MrIVkXFumX/lush3I00LAFAdLvK9hfR3aPcEYcAK
 9jAvLfaQxc2wYnLGMhz0p4o8SbBLyfI/jUneAhto6M1I9Wm2B4R2lWeNOgLibiRai4Zd
 Sdxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690281810; x=1690886610;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VOUIT8kGELsnE/AoIXIltAsJSkBIdaBBGe0R8el5eWY=;
 b=M7LkNtndmJ9DJwQJqlI0oXTLD/b8wcCskAe4SqRpqiaL9kulupH4MN8y+4Id0UCraz
 XgpGRV2XzsYeE3vXHfa82+CwKKybD1ryctCVasPBBaSPrfvhlyZOUDq1LKowyU5S2VJl
 EKoiaa71/pkKNahA0hMBoyhuk4Fnp2is53nvpEDnRrXYBRwjJeE/+T7TzyAqPPxMXiR7
 JqdQONKYtT4OzaJXljfigNTW3KvWVa68020qD9jzXN/grEPR/BC8yfv8WmOHR1VQbJng
 53X5CMehngwEaec07ldqYmN+th6YAAPmJOmVkAIlf1ybFxcYUNaBXVNo9VMRCCB1uAIz
 6R5Q==
X-Gm-Message-State: ABy/qLZnQ0oxsaXUX0ARtRknCTjmz1dR2kNQfL0tYJ9lJiKHiMIvuqWp
 QAr9ges7ehybfIDxhuVkJ9MoVQ==
X-Google-Smtp-Source: APBJJlG/WsVOhCa922xgJgr2F3mr+2Llbib3Yh9PVKkz756jGMDsFHqVEDJGmvJPjFX950U6nicriQ==
X-Received: by 2002:a05:6a20:7d87:b0:10f:f672:6e88 with SMTP id
 v7-20020a056a207d8700b0010ff6726e88mr13708080pzj.4.1690281810191; 
 Tue, 25 Jul 2023 03:43:30 -0700 (PDT)
Received: from localhost.localdomain.gitgo.cc ([47.75.78.161])
 by smtp.gmail.com with ESMTPSA id
 c20-20020aa78c14000000b0062cf75a9e6bsm9343165pfd.131.2023.07.25.03.43.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jul 2023 03:43:29 -0700 (PDT)
From: Li Feng <fengli@smartx.com>
To: Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 qemu-block@nongnu.org (open list:Block layer core),
 qemu-devel@nongnu.org (open list:All patches CC here)
Cc: Li Feng <fengli@smartx.com>
Subject: [PATCH v2 4/4] vhost-user-scsi: support reconnect to backend
Date: Tue, 25 Jul 2023 18:42:47 +0800
Message-ID: <20230725104256.4861-5-fengli@smartx.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104256.4861-1-fengli@smartx.com>
References: <20230721105205.1714449-1-fengli@smartx.com>
 <20230725104256.4861-1-fengli@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::430;
 envelope-from=fengli@smartx.com; helo=mail-pf1-x430.google.com
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
 hw/scsi/vhost-scsi-common.c           |   6 +
 hw/scsi/vhost-user-scsi.c             | 220 +++++++++++++++++++++++---
 include/hw/virtio/vhost-scsi-common.h |   3 +
 include/hw/virtio/vhost-user-scsi.h   |   3 +
 4 files changed, 211 insertions(+), 21 deletions(-)

diff --git a/hw/scsi/vhost-scsi-common.c b/hw/scsi/vhost-scsi-common.c
index 664adb15b4..3fde477eee 100644
--- a/hw/scsi/vhost-scsi-common.c
+++ b/hw/scsi/vhost-scsi-common.c
@@ -81,6 +81,7 @@ int vhost_scsi_common_start(VHostSCSICommon *vsc)
         error_report("Error start vhost dev");
         goto err_guest_notifiers;
     }
+    vsc->started_vu = true;
 
     /* guest_notifier_mask/pending not used yet, so just unmask
      * everything here.  virtio-pci will do the right thing by
@@ -106,6 +107,11 @@ void vhost_scsi_common_stop(VHostSCSICommon *vsc)
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
     int ret = 0;
 
+    if (!vsc->started_vu) {
+        return;
+    }
+    vsc->started_vu = false;
+
     vhost_dev_stop(&vsc->dev, vdev, true);
 
     if (k->set_guest_notifiers) {
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index ee99b19e7a..bd32dcf999 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -46,20 +46,25 @@ enum VhostUserProtocolFeature {
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
 
+    if (should_start) {
         ret = vhost_scsi_common_start(vsc);
         if (ret < 0) {
             error_report("unable to start vhost-user-scsi: %s", strerror(-ret));
-            exit(1);
+            qemu_chr_fe_disconnect(&vs->conf.chardev);
         }
     } else {
         vhost_scsi_common_stop(vsc);
@@ -85,8 +90,160 @@ static void vhost_user_scsi_reset(VirtIODevice *vdev)
     }
 }
 
-static void vhost_dummy_handle_output(VirtIODevice *vdev, VirtQueue *vq)
+static void vhost_user_scsi_handle_output(VirtIODevice *vdev, VirtQueue *vq)
 {
+    VHostUserSCSI *s = (VHostUserSCSI *)vdev;
+    DeviceState *dev = &s->parent_obj.parent_obj.parent_obj.parent_obj;
+    VHostSCSICommon *vsc = VHOST_SCSI_COMMON(s);
+    VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(dev);
+
+    Error *local_err = NULL;
+    int i, ret;
+
+    if (!vdev->start_on_kick) {
+        return;
+    }
+
+    if (!s->connected) {
+        return;
+    }
+
+    if (vhost_dev_is_started(&vsc->dev)) {
+        return;
+    }
+
+    /*
+     * Some guests kick before setting VIRTIO_CONFIG_S_DRIVER_OK so start
+     * vhost here instead of waiting for .set_status().
+     */
+    ret = vhost_scsi_common_start(vsc);
+    if (ret < 0) {
+        error_reportf_err(local_err, "vhost-user-blk: vhost start failed: ");
+        qemu_chr_fe_disconnect(&vs->conf.chardev);
+        return;
+    }
+
+    /* Kick right away to begin processing requests already in vring */
+    for (i = 0; i < vsc->dev.nvqs; i++) {
+        VirtQueue *kick_vq = virtio_get_queue(vdev, i);
+
+        if (!virtio_queue_get_desc_addr(vdev, i)) {
+            continue;
+        }
+        event_notifier_set(virtio_queue_get_host_notifier(kick_vq));
+    }
+}
+
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
 }
 
 static void vhost_user_scsi_realize(DeviceState *dev, Error **errp)
@@ -94,18 +251,18 @@ static void vhost_user_scsi_realize(DeviceState *dev, Error **errp)
     VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(dev);
     VHostUserSCSI *s = VHOST_USER_SCSI(dev);
     VHostSCSICommon *vsc = VHOST_SCSI_COMMON(s);
-    struct vhost_virtqueue *vqs = NULL;
     Error *err = NULL;
     int ret;
+    int retries = VU_REALIZE_CONN_RETRIES;
 
     if (!vs->conf.chardev.chr) {
         error_setg(errp, "vhost-user-scsi: missing chardev");
         return;
     }
 
-    virtio_scsi_common_realize(dev, vhost_dummy_handle_output,
-                               vhost_dummy_handle_output,
-                               vhost_dummy_handle_output, &err);
+    virtio_scsi_common_realize(dev, vhost_user_scsi_handle_output,
+                               vhost_user_scsi_handle_output,
+                               vhost_user_scsi_handle_output, &err);
     if (err != NULL) {
         error_propagate(errp, err);
         return;
@@ -115,18 +272,28 @@ static void vhost_user_scsi_realize(DeviceState *dev, Error **errp)
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
@@ -135,8 +302,12 @@ static void vhost_user_scsi_realize(DeviceState *dev, Error **errp)
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
@@ -146,16 +317,23 @@ static void vhost_user_scsi_unrealize(DeviceState *dev)
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
index 18f115527c..daa183018c 100644
--- a/include/hw/virtio/vhost-scsi-common.h
+++ b/include/hw/virtio/vhost-scsi-common.h
@@ -37,6 +37,9 @@ struct VHostSCSICommon {
     bool migratable;
 
     struct vhost_inflight *inflight;
+
+    /* vhost_scsi_common_start/vhost_scsi_common_stop */
+    bool started_vu;
 };
 
 int vhost_scsi_common_start(VHostSCSICommon *vsc);
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
-- 
2.41.0


