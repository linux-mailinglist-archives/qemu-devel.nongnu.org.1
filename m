Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D107CF483
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 11:57:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtPlQ-00050w-Da; Thu, 19 Oct 2023 05:56:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qtPlJ-0004zz-Pg
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 05:56:17 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qtPlG-0006RB-Hu
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 05:56:17 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4083740f92dso18494925e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 02:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697709373; x=1698314173; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lduTavRcCfn71OP3vn2vOZKlMzIY+6vyIEy/6u1EHpo=;
 b=opBdgUxy9C2Ujqshq5HKbrGjnyUXFIlP9nrL+UPWADZaVcR5OeTQIHah+l8IWnvWyJ
 WatVGtoE1aqqZ4VTgbbAL+7+BkW2PjeGjoLnuoIoh8AbJk2d9qLYTyTQdRBFDw3seLeb
 TLCXNtmeS+PNF29Ig5SbumzFqcBtfh0Hv2NYlTVSKaME6+mE73J/UKy7m0HerFIzZoZ0
 lL3+PqoqFzNJxQW3cNPJBA7SGH9hr8+MsqQYYMA0gq6y+ksdVLkqMmMYN6oY2D1a70HA
 SmDshvKe/1JdMJVBqhXMWaO52UsvQbBHXOPJVF9/tBFkMvPC+ywSexndiOIXV6JJEZsF
 8OKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697709373; x=1698314173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lduTavRcCfn71OP3vn2vOZKlMzIY+6vyIEy/6u1EHpo=;
 b=RfKv6DRrjhmG5955dVevLN9a89n5szrdI1ZKaUVgicMPP++jd4ymhpJNcG7wliOWaP
 Qr3xvuco4Y53hpr0K5bcQr2/+WHxe5xiqmqLEsvg6zHRZ+yM69Ly6CI67lyBcZh+R+2E
 kLexf4MDzPj3yQlLt5+Z6Au2FZ9JginYLVXrXPSpO8fcRrSXgaEtSiJApcTVIiKDNRE4
 /BptF7bvyJPx6V8Ft2BMXC2kSOA/b0NP43orlYyxRuN/FXpKqqVVLOwrTfAgFjZidHAd
 st5ZWP1qLKMpXvyfP8yFSk2ikqdrp25C21xotFWef69TDvyk3tyPMN080xASKSIdoBqT
 HzIw==
X-Gm-Message-State: AOJu0YwuEumYY32IAIe0xjONLWSxfc7yWWTHvCQmt2ckHQVd7vmq89aj
 +YOw+FsDLkHtMV+nONa88/kH3g==
X-Google-Smtp-Source: AGHT+IGW8N2LTDkUQbFgTgo2B3tD9aPj24UQcKVFkFp82oN57C5/bDWvhIX+Mvw1vxFEr6tJmEiRVg==
X-Received: by 2002:a05:600c:a05:b0:405:3251:47a1 with SMTP id
 z5-20020a05600c0a0500b00405325147a1mr1413119wmp.40.1697709372865; 
 Thu, 19 Oct 2023 02:56:12 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 v18-20020a05600c15d200b004063d8b43e7sm3959801wmf.48.2023.10.19.02.56.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 02:56:11 -0700 (PDT)
Received: from zen.linaroharston (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8EB981FFBD;
 Thu, 19 Oct 2023 10:56:10 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 virtio-fs@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Fam Zheng <fam@euphon.net>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Erik Schilling <erik.schilling@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: [PATCH v5 2/6] hw/virtio: derive vhost-user-rng from vhost-user-base
Date: Thu, 19 Oct 2023 10:56:06 +0100
Message-Id: <20231019095610.2818087-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231019095610.2818087-1-alex.bennee@linaro.org>
References: <20231019095610.2818087-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Message-Id: <20231009095937.195728-3-alex.bennee@linaro.org>

---
v5
  - don't remove the in-QEMU RNG emulation!
---
 include/hw/virtio/vhost-user-rng.h |  11 +-
 hw/virtio/vhost-user-rng.c         | 278 +++--------------------------
 hw/virtio/meson.build              |   9 +-
 3 files changed, 31 insertions(+), 267 deletions(-)

diff --git a/include/hw/virtio/vhost-user-rng.h b/include/hw/virtio/vhost-user-rng.h
index ddd9f01eea..6cffe28807 100644
--- a/include/hw/virtio/vhost-user-rng.h
+++ b/include/hw/virtio/vhost-user-rng.h
@@ -12,21 +12,14 @@
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/vhost.h"
 #include "hw/virtio/vhost-user.h"
-#include "chardev/char-fe.h"
+#include "hw/virtio/vhost-user-base.h"
 
 #define TYPE_VHOST_USER_RNG "vhost-user-rng"
 OBJECT_DECLARE_SIMPLE_TYPE(VHostUserRNG, VHOST_USER_RNG)
 
 struct VHostUserRNG {
     /*< private >*/
-    VirtIODevice parent;
-    CharBackend chardev;
-    struct vhost_virtqueue *vhost_vq;
-    struct vhost_dev vhost_dev;
-    VhostUserState vhost_user;
-    VirtQueue *req_vq;
-    bool connected;
-
+    VHostUserBase parent;
     /*< public >*/
 };
 
diff --git a/hw/virtio/vhost-user-rng.c b/hw/virtio/vhost-user-rng.c
index efc54cd3fb..01879c863d 100644
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
@@ -13,281 +13,47 @@
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
-    vhost_virtqueue_mask(&rng->vhost_dev, vdev, idx, mask);
-}
-
-static bool vu_rng_guest_notifier_pending(VirtIODevice *vdev, int idx)
-{
-    VHostUserRNG *rng = VHOST_USER_RNG(vdev);
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
index 51c3f97c2d..b5c1a461e3 100644
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


