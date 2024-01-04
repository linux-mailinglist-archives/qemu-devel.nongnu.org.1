Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCE2824A15
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 22:12:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLUzl-0007vx-K4; Thu, 04 Jan 2024 16:11:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rLUyR-0006vm-S3
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 16:09:55 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rLUyO-0007S3-AJ
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 16:09:54 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3366e78d872so814704f8f.3
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 13:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704402591; x=1705007391; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xQ8hd0QsqUAs9Wsy9pGcftHF7w2pIduJuDBfpTEm2Uk=;
 b=wqAS3/qzfkFHWfvIZPloQPniep3M6GRjs71N9zOKsc4uxelAP5qFU//ZvBD0AM0DKv
 CYxqGMwlAEaVZ7eT2z+riSMO5CrT09BBIB5oW6VjEmO9q3EzXF7PCdTIeblp9BG6oaBK
 VC1+y/bRs7Gk26ikJMce4rOGFz9d5P0MIfEkMfBGFN5vtoa8GWQ6M3hnwuFX+Oji8U+h
 fV6qXW+sEJFuyxs33Ym/R+c2LZ1L9i85kKCUbogszCVrNpPMAyCg4Se42Rl8q4Gji+li
 Hso3TWqqu9y+Cgl0NLUa74llyIcds8j9PghJK7koUpTgEZJn+ddwlG7PQPxYIADAtu0M
 6EQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704402591; x=1705007391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xQ8hd0QsqUAs9Wsy9pGcftHF7w2pIduJuDBfpTEm2Uk=;
 b=mJtIZv4bWaDFKbCnZnBZoFoKmaTdBYs6+S/e8B0QScDEjG7A0YfPRHhAI2bj5GNHn2
 EtL4DB8bp9cAVkVa672hJMqdqzN6fqG075DnOy/KREWP9hyA9e5rZBshy6i6SAv7zyET
 SoSVwIuY/zEueIyGfNFccAR/YKvWXVx56Ir7vATK5fVEl81QSVA/wTS3seu54lsu/5cW
 XKmeFYpDge1ZTYDHgqW3JyJIJImrr+nj+oJoRECL5rpe6mXs5UeFOAsIA93xIQ1zjwn/
 IbfXR4RceDDV3WZkZ2ybZqPmvLJDZbtATgMOplKcb/oiltm+gc62NjO6FBNWKTwS21M3
 Yv8g==
X-Gm-Message-State: AOJu0Yzvok98NdOCS5ldMANc92o//ohaI5c7ZZyPStSFQ5J1Q1LzOkKm
 nXgu8dcKaJHR3GIbPFL6WPyPtAaMJoNJQw==
X-Google-Smtp-Source: AGHT+IEbodbHEhkJzdbDn2bX3G7/C94gNGUTfG7TBdePoDmBTwNaEaDRUx4bFfGE9hw/GgWSb+uCNA==
X-Received: by 2002:a5d:58d7:0:b0:336:5cc0:db75 with SMTP id
 o23-20020a5d58d7000000b003365cc0db75mr344227wrf.209.1704402590893; 
 Thu, 04 Jan 2024 13:09:50 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 t3-20020a0560001a4300b003374555d88esm106960wry.56.2024.01.04.13.09.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 13:09:48 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5F78D5F936;
 Thu,  4 Jan 2024 21:09:45 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Jason Wang <jasowang@redhat.com>,
 Erik Schilling <erik.schilling@linaro.org>, Eric Blake <eblake@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, virtio-fs@redhat.com,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v9 03/11] hw/virtio: derive vhost-user-rng from vhost-user-base
Date: Thu,  4 Jan 2024 21:09:37 +0000
Message-Id: <20240104210945.1223134-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240104210945.1223134-1-alex.bennee@linaro.org>
References: <20240104210945.1223134-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Now we can take advantage of our new base class and make
vhost-user-rng a much simpler boilerplate wrapper. Also as this
doesn't require any target specific hacks we only need to build the
stubs once.

Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v5
  - don't remove the in-QEMU RNG emulation!
v7
  - s/parent/parent_obj/
v8
  - fix merge conflict (idx == VIRTIO_CONFIG_IRQ_IDX not needed as
    base doesn't use notifiers)
---
 include/hw/virtio/vhost-user-rng.h |  13 +-
 hw/virtio/vhost-user-rng.c         | 294 +++--------------------------
 hw/virtio/meson.build              |   9 +-
 3 files changed, 31 insertions(+), 285 deletions(-)

diff --git a/include/hw/virtio/vhost-user-rng.h b/include/hw/virtio/vhost-user-rng.h
index ddd9f01eea6..10868c7de4d 100644
--- a/include/hw/virtio/vhost-user-rng.h
+++ b/include/hw/virtio/vhost-user-rng.h
@@ -12,22 +12,13 @@
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/vhost.h"
 #include "hw/virtio/vhost-user.h"
-#include "chardev/char-fe.h"
+#include "hw/virtio/vhost-user-base.h"
 
 #define TYPE_VHOST_USER_RNG "vhost-user-rng"
 OBJECT_DECLARE_SIMPLE_TYPE(VHostUserRNG, VHOST_USER_RNG)
 
 struct VHostUserRNG {
-    /*< private >*/
-    VirtIODevice parent;
-    CharBackend chardev;
-    struct vhost_virtqueue *vhost_vq;
-    struct vhost_dev vhost_dev;
-    VhostUserState vhost_user;
-    VirtQueue *req_vq;
-    bool connected;
-
-    /*< public >*/
+    VHostUserBase parent_obj;
 };
 
 #endif /* QEMU_VHOST_USER_RNG_H */
diff --git a/hw/virtio/vhost-user-rng.c b/hw/virtio/vhost-user-rng.c
index 24ac1a22c83..01879c863df 100644
--- a/hw/virtio/vhost-user-rng.c
+++ b/hw/virtio/vhost-user-rng.c
@@ -3,7 +3,7 @@
  *
  * Copyright (c) 2021 Mathieu Poirier <mathieu.poirier@linaro.org>
  *
- * Implementation seriously tailored on vhost-user-i2c.c
+ * Simple wrapper of the generic vhost-user-device.
  *
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
@@ -13,297 +13,47 @@
 #include "hw/qdev-properties.h"
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/vhost-user-rng.h"
-#include "qemu/error-report.h"
 #include "standard-headers/linux/virtio_ids.h"
 
-static const int feature_bits[] = {
-    VIRTIO_F_RING_RESET,
-    VHOST_INVALID_FEATURE_BIT
-};
-
-static void vu_rng_start(VirtIODevice *vdev)
-{
-    VHostUserRNG *rng = VHOST_USER_RNG(vdev);
-    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
-    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
-    int ret;
-    int i;
-
-    if (!k->set_guest_notifiers) {
-        error_report("binding does not support guest notifiers");
-        return;
-    }
-
-    ret = vhost_dev_enable_notifiers(&rng->vhost_dev, vdev);
-    if (ret < 0) {
-        error_report("Error enabling host notifiers: %d", -ret);
-        return;
-    }
-
-    ret = k->set_guest_notifiers(qbus->parent, rng->vhost_dev.nvqs, true);
-    if (ret < 0) {
-        error_report("Error binding guest notifier: %d", -ret);
-        goto err_host_notifiers;
-    }
-
-    rng->vhost_dev.acked_features = vdev->guest_features;
-    ret = vhost_dev_start(&rng->vhost_dev, vdev, true);
-    if (ret < 0) {
-        error_report("Error starting vhost-user-rng: %d", -ret);
-        goto err_guest_notifiers;
-    }
-
-    /*
-     * guest_notifier_mask/pending not used yet, so just unmask
-     * everything here. virtio-pci will do the right thing by
-     * enabling/disabling irqfd.
-     */
-    for (i = 0; i < rng->vhost_dev.nvqs; i++) {
-        vhost_virtqueue_mask(&rng->vhost_dev, vdev, i, false);
-    }
-
-    return;
-
-err_guest_notifiers:
-    k->set_guest_notifiers(qbus->parent, rng->vhost_dev.nvqs, false);
-err_host_notifiers:
-    vhost_dev_disable_notifiers(&rng->vhost_dev, vdev);
-}
-
-static void vu_rng_stop(VirtIODevice *vdev)
-{
-    VHostUserRNG *rng = VHOST_USER_RNG(vdev);
-    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
-    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
-    int ret;
-
-    if (!k->set_guest_notifiers) {
-        return;
-    }
-
-    vhost_dev_stop(&rng->vhost_dev, vdev, true);
-
-    ret = k->set_guest_notifiers(qbus->parent, rng->vhost_dev.nvqs, false);
-    if (ret < 0) {
-        error_report("vhost guest notifier cleanup failed: %d", ret);
-        return;
-    }
-
-    vhost_dev_disable_notifiers(&rng->vhost_dev, vdev);
-}
-
-static void vu_rng_set_status(VirtIODevice *vdev, uint8_t status)
-{
-    VHostUserRNG *rng = VHOST_USER_RNG(vdev);
-    bool should_start = virtio_device_should_start(vdev, status);
-
-    if (vhost_dev_is_started(&rng->vhost_dev) == should_start) {
-        return;
-    }
-
-    if (should_start) {
-        vu_rng_start(vdev);
-    } else {
-        vu_rng_stop(vdev);
-    }
-}
-
-static uint64_t vu_rng_get_features(VirtIODevice *vdev,
-                                    uint64_t requested_features, Error **errp)
-{
-    VHostUserRNG *rng = VHOST_USER_RNG(vdev);
-
-    return vhost_get_features(&rng->vhost_dev, feature_bits,
-                              requested_features);
-}
-
-static void vu_rng_handle_output(VirtIODevice *vdev, VirtQueue *vq)
-{
-    /*
-     * Not normally called; it's the daemon that handles the queue;
-     * however virtio's cleanup path can call this.
-     */
-}
-
-static void vu_rng_guest_notifier_mask(VirtIODevice *vdev, int idx, bool mask)
-{
-    VHostUserRNG *rng = VHOST_USER_RNG(vdev);
-
-    /*
-     * We don't support interrupts, return early if index is set to
-     * VIRTIO_CONFIG_IRQ_IDX.
-     */
-    if (idx == VIRTIO_CONFIG_IRQ_IDX) {
-        return;
-    }
-
-    vhost_virtqueue_mask(&rng->vhost_dev, vdev, idx, mask);
-}
-
-static bool vu_rng_guest_notifier_pending(VirtIODevice *vdev, int idx)
-{
-    VHostUserRNG *rng = VHOST_USER_RNG(vdev);
-
-    /*
-     * We don't support interrupts, return early if index is set to
-     * VIRTIO_CONFIG_IRQ_IDX.
-     */
-    if (idx == VIRTIO_CONFIG_IRQ_IDX) {
-        return false;
-    }
-
-    return vhost_virtqueue_pending(&rng->vhost_dev, idx);
-}
-
-static void vu_rng_connect(DeviceState *dev)
-{
-    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
-    VHostUserRNG *rng = VHOST_USER_RNG(vdev);
-
-    if (rng->connected) {
-        return;
-    }
-
-    rng->connected = true;
-
-    /* restore vhost state */
-    if (virtio_device_started(vdev, vdev->status)) {
-        vu_rng_start(vdev);
-    }
-}
-
-static void vu_rng_disconnect(DeviceState *dev)
-{
-    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
-    VHostUserRNG *rng = VHOST_USER_RNG(vdev);
-
-    if (!rng->connected) {
-        return;
-    }
-
-    rng->connected = false;
-
-    if (vhost_dev_is_started(&rng->vhost_dev)) {
-        vu_rng_stop(vdev);
-    }
-}
-
-static void vu_rng_event(void *opaque, QEMUChrEvent event)
-{
-    DeviceState *dev = opaque;
-
-    switch (event) {
-    case CHR_EVENT_OPENED:
-        vu_rng_connect(dev);
-        break;
-    case CHR_EVENT_CLOSED:
-        vu_rng_disconnect(dev);
-        break;
-    case CHR_EVENT_BREAK:
-    case CHR_EVENT_MUX_IN:
-    case CHR_EVENT_MUX_OUT:
-        /* Ignore */
-        break;
-    }
-}
-
-static void vu_rng_device_realize(DeviceState *dev, Error **errp)
-{
-    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
-    VHostUserRNG *rng = VHOST_USER_RNG(dev);
-    int ret;
-
-    if (!rng->chardev.chr) {
-        error_setg(errp, "missing chardev");
-        return;
-    }
-
-    if (!vhost_user_init(&rng->vhost_user, &rng->chardev, errp)) {
-        return;
-    }
-
-    virtio_init(vdev, VIRTIO_ID_RNG, 0);
-
-    rng->req_vq = virtio_add_queue(vdev, 4, vu_rng_handle_output);
-    if (!rng->req_vq) {
-        error_setg_errno(errp, -1, "virtio_add_queue() failed");
-        goto virtio_add_queue_failed;
-    }
-
-    rng->vhost_dev.nvqs = 1;
-    rng->vhost_dev.vqs = g_new0(struct vhost_virtqueue, rng->vhost_dev.nvqs);
-    ret = vhost_dev_init(&rng->vhost_dev, &rng->vhost_user,
-                         VHOST_BACKEND_TYPE_USER, 0, errp);
-    if (ret < 0) {
-        error_setg_errno(errp, -ret, "vhost_dev_init() failed");
-        goto vhost_dev_init_failed;
-    }
-
-    qemu_chr_fe_set_handlers(&rng->chardev, NULL, NULL, vu_rng_event, NULL,
-                             dev, NULL, true);
-
-    return;
-
-vhost_dev_init_failed:
-    g_free(rng->vhost_dev.vqs);
-    virtio_delete_queue(rng->req_vq);
-virtio_add_queue_failed:
-    virtio_cleanup(vdev);
-    vhost_user_cleanup(&rng->vhost_user);
-}
-
-static void vu_rng_device_unrealize(DeviceState *dev)
-{
-    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
-    VHostUserRNG *rng = VHOST_USER_RNG(dev);
-    struct vhost_virtqueue *vhost_vqs = rng->vhost_dev.vqs;
-
-    vu_rng_set_status(vdev, 0);
-
-    vhost_dev_cleanup(&rng->vhost_dev);
-    g_free(vhost_vqs);
-    virtio_delete_queue(rng->req_vq);
-    virtio_cleanup(vdev);
-    vhost_user_cleanup(&rng->vhost_user);
-}
-
-static struct vhost_dev *vu_rng_get_vhost(VirtIODevice *vdev)
-{
-    VHostUserRNG *rng = VHOST_USER_RNG(vdev);
-    return &rng->vhost_dev;
-}
-
 static const VMStateDescription vu_rng_vmstate = {
     .name = "vhost-user-rng",
     .unmigratable = 1,
 };
 
-static Property vu_rng_properties[] = {
-    DEFINE_PROP_CHR("chardev", VHostUserRNG, chardev),
+static Property vrng_properties[] = {
+    DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static void vu_rng_base_realize(DeviceState *dev, Error **errp)
+{
+    VHostUserBase *vub = VHOST_USER_BASE(dev);
+    VHostUserBaseClass *vubs = VHOST_USER_BASE_GET_CLASS(dev);
+
+    /* Fixed for RNG */
+    vub->virtio_id = VIRTIO_ID_RNG;
+    vub->num_vqs = 1;
+    vub->vq_size = 4;
+
+    vubs->parent_realize(dev, errp);
+}
+
 static void vu_rng_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-    VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
+    VHostUserBaseClass *vubc = VHOST_USER_BASE_CLASS(klass);
 
-    device_class_set_props(dc, vu_rng_properties);
     dc->vmsd = &vu_rng_vmstate;
-    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
+    device_class_set_props(dc, vrng_properties);
+    device_class_set_parent_realize(dc, vu_rng_base_realize,
+                                    &vubc->parent_realize);
 
-    vdc->realize = vu_rng_device_realize;
-    vdc->unrealize = vu_rng_device_unrealize;
-    vdc->get_features = vu_rng_get_features;
-    vdc->set_status = vu_rng_set_status;
-    vdc->guest_notifier_mask = vu_rng_guest_notifier_mask;
-    vdc->guest_notifier_pending = vu_rng_guest_notifier_pending;
-    vdc->get_vhost = vu_rng_get_vhost;
+    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
 }
 
 static const TypeInfo vu_rng_info = {
     .name = TYPE_VHOST_USER_RNG,
-    .parent = TYPE_VIRTIO_DEVICE,
+    .parent = TYPE_VHOST_USER_BASE,
     .instance_size = sizeof(VHostUserRNG),
     .class_init = vu_rng_class_init,
 };
diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index 51c3f97c2d0..b5c1a461e34 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -18,8 +18,15 @@ if have_vhost
     # fixme - this really should be generic
     specific_virtio_ss.add(files('vhost-user.c'))
     system_virtio_ss.add(files('vhost-user-base.c'))
+
+    # MMIO Stubs
     system_virtio_ss.add(files('vhost-user-device.c'))
+    system_virtio_ss.add(when: 'CONFIG_VHOST_USER_RNG', if_true: files('vhost-user-rng.c'))
+
+    # PCI Stubs
     system_virtio_ss.add(when: 'CONFIG_VIRTIO_PCI', if_true: files('vhost-user-device-pci.c'))
+    system_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_RNG'],
+                         if_true: files('vhost-user-rng-pci.c'))
   endif
   if have_vhost_vdpa
     system_virtio_ss.add(files('vhost-vdpa.c'))
@@ -37,7 +44,6 @@ specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_VSOCK', if_true: files('vhost-us
 specific_virtio_ss.add(when: 'CONFIG_VIRTIO_RNG', if_true: files('virtio-rng.c'))
 specific_virtio_ss.add(when: 'CONFIG_VIRTIO_MEM', if_true: files('virtio-mem.c'))
 specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_I2C', if_true: files('vhost-user-i2c.c'))
-specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_RNG', if_true: files('vhost-user-rng.c'))
 specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_GPIO', if_true: files('vhost-user-gpio.c'))
 specific_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_GPIO'], if_true: files('vhost-user-gpio-pci.c'))
 specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_SCMI', if_true: files('vhost-user-scmi.c'))
@@ -49,7 +55,6 @@ virtio_pci_ss.add(when: 'CONFIG_VHOST_USER_VSOCK', if_true: files('vhost-user-vs
 virtio_pci_ss.add(when: 'CONFIG_VHOST_USER_BLK', if_true: files('vhost-user-blk-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VHOST_USER_I2C', if_true: files('vhost-user-i2c-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VHOST_USER_INPUT', if_true: files('vhost-user-input-pci.c'))
-virtio_pci_ss.add(when: 'CONFIG_VHOST_USER_RNG', if_true: files('vhost-user-rng-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VHOST_USER_SCSI', if_true: files('vhost-user-scsi-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VHOST_SCSI', if_true: files('vhost-scsi-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VHOST_USER_FS', if_true: files('vhost-user-fs-pci.c'))
-- 
2.39.2


