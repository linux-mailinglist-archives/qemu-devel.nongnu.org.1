Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3937E47C5
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 19:04:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0QQ2-0008D1-IL; Tue, 07 Nov 2023 13:03:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0QPl-00088M-Mm
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:03:04 -0500
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0QPf-0000hP-UP
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:03:01 -0500
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-507d1cc0538so8064483e87.2
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 10:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699380173; x=1699984973; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bi9MKFK4Q99oQi+hX8lTv9WtemkHSdUftaqOJ7AOKBs=;
 b=FrGO0mpGtWi1uyxNEDjuCl7vZaW6ltWeHjid0lEGtb/vFA/o5ALFTOUUoAwuzxcw6V
 17StB5m4NlMgP2rJBPPNPEXAbMxjyFk7twbO/ChIv/QA0Yz9Jp45VTj7LpmMbE+MgrPw
 lDQHd/if/h4XVmbjG5k25rNKfoTb6XPB12M7dve+VO/yaXhrnCLSZaGpy9L5XxqzqCK6
 mwvySa3roCHS/3eS80ehtG3voNYwi224nIv5jWMdn4eUTdO9psk/3HLbB1O3bBSQSvBV
 3gZJicLlB4ckthK7ZA33R7VDg7RXWjFQtWVSmpd/oc8RiMClPvz6PCgcrcb9dKh98mMb
 Sh9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699380173; x=1699984973;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bi9MKFK4Q99oQi+hX8lTv9WtemkHSdUftaqOJ7AOKBs=;
 b=o5eoLagNF7hJHvCDCpsqB68VhjB0Dq5OzPk6oCbqLoZnWY4kPup3QzelEsNsViA4ei
 KhqNbbWRnYHlcn3kU3/uQscDlnm+QrGHZ560XQTsvwJ88wEhT6eAGVQ99yltRozqvYQZ
 z6eBsi32ZKh2t0EJwiUw/XhCZRySooqIfZPLsscNIyjjXejcTCoQunxjDwu8RP1M8lFH
 vWyJ4hVT8YFBf7NqCRFFiUgjCi6wGhaE+Qdl8mexfb4ko4zfIskyC5SCyFEnmq+YIAT8
 XaiWqTRGAy+WNRAiBIi2TodyeBShQtWgO2arkFqwgve7yrp6HaYgB9Wu57GCli90hFPh
 I3Rw==
X-Gm-Message-State: AOJu0YzZMehm9YRC1X7mHgxZq6oZU9tKqWLFB8JXGIwP52C2JwRG/ZBQ
 353/woDA82nXt0H0RUU0KdcRhA==
X-Google-Smtp-Source: AGHT+IFHWOeh+3xhWNA+4fRrcVAXeJ4hc3VfX8aclBQqI4rgZWqW7YyBcbeaNrw2pXAn1uo8bMpWPA==
X-Received: by 2002:a2e:7e0e:0:b0:2c0:34ed:b5ea with SMTP id
 z14-20020a2e7e0e000000b002c034edb5eamr23796734ljc.45.1699380172979; 
 Tue, 07 Nov 2023 10:02:52 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 fm15-20020a05600c0c0f00b00405391f485fsm16903810wmb.41.2023.11.07.10.02.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 10:02:50 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 31A206575A;
 Tue,  7 Nov 2023 18:02:47 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fam Zheng <fam@euphon.net>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Erik Schilling <erik.schilling@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, virtio-fs@redhat.com,
 Kevin Wolf <kwolf@redhat.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: [PATCH v7 5/7] hw/virtio: derive vhost-user-i2c from vhost-user-base
Date: Tue,  7 Nov 2023 18:02:44 +0000
Message-Id: <20231107180246.3456598-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231107180246.3456598-1-alex.bennee@linaro.org>
References: <20231107180246.3456598-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Now we can take advantage of the new base class and make
vhost-user-i2c a much simpler boilerplate wrapper. Also as this
doesn't require any target specific hacks we only need to build the
stubs once.

Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v7
  - s/parent/parent_obj/
---
 include/hw/virtio/vhost-user-i2c.h |  14 +-
 hw/virtio/vhost-user-i2c.c         | 272 ++---------------------------
 hw/virtio/meson.build              |   5 +-
 3 files changed, 23 insertions(+), 268 deletions(-)

diff --git a/include/hw/virtio/vhost-user-i2c.h b/include/hw/virtio/vhost-user-i2c.h
index 0f7acd40e3..a9b5612ad0 100644
--- a/include/hw/virtio/vhost-user-i2c.h
+++ b/include/hw/virtio/vhost-user-i2c.h
@@ -9,23 +9,17 @@
 #ifndef QEMU_VHOST_USER_I2C_H
 #define QEMU_VHOST_USER_I2C_H
 
+#include "hw/virtio/virtio.h"
 #include "hw/virtio/vhost.h"
 #include "hw/virtio/vhost-user.h"
+#include "hw/virtio/vhost-user-base.h"
 
 #define TYPE_VHOST_USER_I2C "vhost-user-i2c-device"
+
 OBJECT_DECLARE_SIMPLE_TYPE(VHostUserI2C, VHOST_USER_I2C)
 
 struct VHostUserI2C {
-    VirtIODevice parent;
-    CharBackend chardev;
-    struct vhost_virtqueue *vhost_vq;
-    struct vhost_dev vhost_dev;
-    VhostUserState vhost_user;
-    VirtQueue *vq;
-    bool connected;
+    VHostUserBase parent_obj;
 };
 
-/* Virtio Feature bits */
-#define VIRTIO_I2C_F_ZERO_LENGTH_REQUEST		0
-
 #endif /* QEMU_VHOST_USER_I2C_H */
diff --git a/hw/virtio/vhost-user-i2c.c b/hw/virtio/vhost-user-i2c.c
index 4eef3f0633..a464f5e039 100644
--- a/hw/virtio/vhost-user-i2c.c
+++ b/hw/virtio/vhost-user-i2c.c
@@ -14,253 +14,22 @@
 #include "qemu/error-report.h"
 #include "standard-headers/linux/virtio_ids.h"
 
-static const int feature_bits[] = {
-    VIRTIO_I2C_F_ZERO_LENGTH_REQUEST,
-    VIRTIO_F_RING_RESET,
-    VHOST_INVALID_FEATURE_BIT
+static Property vi2c_properties[] = {
+    DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
+    DEFINE_PROP_END_OF_LIST(),
 };
 
-static void vu_i2c_start(VirtIODevice *vdev)
-{
-    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
-    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
-    VHostUserI2C *i2c = VHOST_USER_I2C(vdev);
-    int ret, i;
-
-    if (!k->set_guest_notifiers) {
-        error_report("binding does not support guest notifiers");
-        return;
-    }
-
-    ret = vhost_dev_enable_notifiers(&i2c->vhost_dev, vdev);
-    if (ret < 0) {
-        error_report("Error enabling host notifiers: %d", -ret);
-        return;
-    }
-
-    ret = k->set_guest_notifiers(qbus->parent, i2c->vhost_dev.nvqs, true);
-    if (ret < 0) {
-        error_report("Error binding guest notifier: %d", -ret);
-        goto err_host_notifiers;
-    }
-
-    i2c->vhost_dev.acked_features = vdev->guest_features;
-
-    ret = vhost_dev_start(&i2c->vhost_dev, vdev, true);
-    if (ret < 0) {
-        error_report("Error starting vhost-user-i2c: %d", -ret);
-        goto err_guest_notifiers;
-    }
-
-    /*
-     * guest_notifier_mask/pending not used yet, so just unmask
-     * everything here. virtio-pci will do the right thing by
-     * enabling/disabling irqfd.
-     */
-    for (i = 0; i < i2c->vhost_dev.nvqs; i++) {
-        vhost_virtqueue_mask(&i2c->vhost_dev, vdev, i, false);
-    }
-
-    return;
-
-err_guest_notifiers:
-    k->set_guest_notifiers(qbus->parent, i2c->vhost_dev.nvqs, false);
-err_host_notifiers:
-    vhost_dev_disable_notifiers(&i2c->vhost_dev, vdev);
-}
-
-static void vu_i2c_stop(VirtIODevice *vdev)
-{
-    VHostUserI2C *i2c = VHOST_USER_I2C(vdev);
-    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
-    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
-    int ret;
-
-    if (!k->set_guest_notifiers) {
-        return;
-    }
-
-    vhost_dev_stop(&i2c->vhost_dev, vdev, true);
-
-    ret = k->set_guest_notifiers(qbus->parent, i2c->vhost_dev.nvqs, false);
-    if (ret < 0) {
-        error_report("vhost guest notifier cleanup failed: %d", ret);
-        return;
-    }
-
-    vhost_dev_disable_notifiers(&i2c->vhost_dev, vdev);
-}
-
-static void vu_i2c_set_status(VirtIODevice *vdev, uint8_t status)
-{
-    VHostUserI2C *i2c = VHOST_USER_I2C(vdev);
-    bool should_start = virtio_device_should_start(vdev, status);
-
-    if (vhost_dev_is_started(&i2c->vhost_dev) == should_start) {
-        return;
-    }
-
-    if (should_start) {
-        vu_i2c_start(vdev);
-    } else {
-        vu_i2c_stop(vdev);
-    }
-}
-
-static uint64_t vu_i2c_get_features(VirtIODevice *vdev,
-                                    uint64_t requested_features, Error **errp)
-{
-    VHostUserI2C *i2c = VHOST_USER_I2C(vdev);
-
-    virtio_add_feature(&requested_features, VIRTIO_I2C_F_ZERO_LENGTH_REQUEST);
-    return vhost_get_features(&i2c->vhost_dev, feature_bits, requested_features);
-}
-
-static void vu_i2c_handle_output(VirtIODevice *vdev, VirtQueue *vq)
-{
-    /*
-     * Not normally called; it's the daemon that handles the queue;
-     * however virtio's cleanup path can call this.
-     */
-}
-
-static void vu_i2c_guest_notifier_mask(VirtIODevice *vdev, int idx, bool mask)
-{
-    VHostUserI2C *i2c = VHOST_USER_I2C(vdev);
-
-    /*
-     * We don't support interrupts, return early if index is set to
-     * VIRTIO_CONFIG_IRQ_IDX.
-     */
-    if (idx == VIRTIO_CONFIG_IRQ_IDX) {
-        return;
-    }
-
-    vhost_virtqueue_mask(&i2c->vhost_dev, vdev, idx, mask);
-}
-
-static bool vu_i2c_guest_notifier_pending(VirtIODevice *vdev, int idx)
-{
-    VHostUserI2C *i2c = VHOST_USER_I2C(vdev);
-
-    /*
-     * We don't support interrupts, return early if index is set to
-     * VIRTIO_CONFIG_IRQ_IDX.
-     */
-    if (idx == VIRTIO_CONFIG_IRQ_IDX) {
-        return false;
-    }
-
-    return vhost_virtqueue_pending(&i2c->vhost_dev, idx);
-}
-
-static void do_vhost_user_cleanup(VirtIODevice *vdev, VHostUserI2C *i2c)
-{
-    vhost_user_cleanup(&i2c->vhost_user);
-    virtio_delete_queue(i2c->vq);
-    virtio_cleanup(vdev);
-}
-
-static int vu_i2c_connect(DeviceState *dev)
+static void vi2c_realize(DeviceState *dev, Error **errp)
 {
-    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
-    VHostUserI2C *i2c = VHOST_USER_I2C(vdev);
+    VHostUserBase *vub = VHOST_USER_BASE(dev);
+    VHostUserBaseClass *vubc = VHOST_USER_BASE_GET_CLASS(dev);
 
-    if (i2c->connected) {
-        return 0;
-    }
-    i2c->connected = true;
+    /* Fixed for I2C */
+    vub->virtio_id = VIRTIO_ID_I2C_ADAPTER;
+    vub->num_vqs = 1;
+    vub->vq_size = 4;
 
-    /* restore vhost state */
-    if (virtio_device_started(vdev, vdev->status)) {
-        vu_i2c_start(vdev);
-    }
-
-    return 0;
-}
-
-static void vu_i2c_disconnect(DeviceState *dev)
-{
-    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
-    VHostUserI2C *i2c = VHOST_USER_I2C(vdev);
-
-    if (!i2c->connected) {
-        return;
-    }
-    i2c->connected = false;
-
-    if (vhost_dev_is_started(&i2c->vhost_dev)) {
-        vu_i2c_stop(vdev);
-    }
-}
-
-static void vu_i2c_event(void *opaque, QEMUChrEvent event)
-{
-    DeviceState *dev = opaque;
-    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
-    VHostUserI2C *i2c = VHOST_USER_I2C(vdev);
-
-    switch (event) {
-    case CHR_EVENT_OPENED:
-        if (vu_i2c_connect(dev) < 0) {
-            qemu_chr_fe_disconnect(&i2c->chardev);
-            return;
-        }
-        break;
-    case CHR_EVENT_CLOSED:
-        vu_i2c_disconnect(dev);
-        break;
-    case CHR_EVENT_BREAK:
-    case CHR_EVENT_MUX_IN:
-    case CHR_EVENT_MUX_OUT:
-        /* Ignore */
-        break;
-    }
-}
-
-static void vu_i2c_device_realize(DeviceState *dev, Error **errp)
-{
-    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
-    VHostUserI2C *i2c = VHOST_USER_I2C(dev);
-    int ret;
-
-    if (!i2c->chardev.chr) {
-        error_setg(errp, "vhost-user-i2c: missing chardev");
-        return;
-    }
-
-    if (!vhost_user_init(&i2c->vhost_user, &i2c->chardev, errp)) {
-        return;
-    }
-
-    virtio_init(vdev, VIRTIO_ID_I2C_ADAPTER, 0);
-
-    i2c->vhost_dev.nvqs = 1;
-    i2c->vq = virtio_add_queue(vdev, 4, vu_i2c_handle_output);
-    i2c->vhost_dev.vqs = g_new0(struct vhost_virtqueue, i2c->vhost_dev.nvqs);
-
-    ret = vhost_dev_init(&i2c->vhost_dev, &i2c->vhost_user,
-                         VHOST_BACKEND_TYPE_USER, 0, errp);
-    if (ret < 0) {
-        g_free(i2c->vhost_dev.vqs);
-        do_vhost_user_cleanup(vdev, i2c);
-    }
-
-    qemu_chr_fe_set_handlers(&i2c->chardev, NULL, NULL, vu_i2c_event, NULL,
-                             dev, NULL, true);
-}
-
-static void vu_i2c_device_unrealize(DeviceState *dev)
-{
-    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
-    VHostUserI2C *i2c = VHOST_USER_I2C(dev);
-    struct vhost_virtqueue *vhost_vqs = i2c->vhost_dev.vqs;
-
-    /* This will stop vhost backend if appropriate. */
-    vu_i2c_set_status(vdev, 0);
-    vhost_dev_cleanup(&i2c->vhost_dev);
-    g_free(vhost_vqs);
-    do_vhost_user_cleanup(vdev, i2c);
+    vubc->parent_realize(dev, errp);
 }
 
 static const VMStateDescription vu_i2c_vmstate = {
@@ -268,30 +37,21 @@ static const VMStateDescription vu_i2c_vmstate = {
     .unmigratable = 1,
 };
 
-static Property vu_i2c_properties[] = {
-    DEFINE_PROP_CHR("chardev", VHostUserI2C, chardev),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
 static void vu_i2c_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-    VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
+    VHostUserBaseClass *vubc = VHOST_USER_BASE_CLASS(klass);
 
-    device_class_set_props(dc, vu_i2c_properties);
     dc->vmsd = &vu_i2c_vmstate;
+    device_class_set_props(dc, vi2c_properties);
+    device_class_set_parent_realize(dc, vi2c_realize,
+                                    &vubc->parent_realize);
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
-    vdc->realize = vu_i2c_device_realize;
-    vdc->unrealize = vu_i2c_device_unrealize;
-    vdc->get_features = vu_i2c_get_features;
-    vdc->set_status = vu_i2c_set_status;
-    vdc->guest_notifier_mask = vu_i2c_guest_notifier_mask;
-    vdc->guest_notifier_pending = vu_i2c_guest_notifier_pending;
 }
 
 static const TypeInfo vu_i2c_info = {
     .name = TYPE_VHOST_USER_I2C,
-    .parent = TYPE_VIRTIO_DEVICE,
+    .parent = TYPE_VHOST_USER_BASE,
     .instance_size = sizeof(VHostUserI2C),
     .class_init = vu_i2c_class_init,
 };
diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index 87042e5901..0a4d29ace6 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -22,12 +22,15 @@ if have_vhost
     # MMIO Stubs
     system_virtio_ss.add(files('vhost-user-device.c'))
     system_virtio_ss.add(when: 'CONFIG_VHOST_USER_GPIO', if_true: files('vhost-user-gpio.c'))
+    system_virtio_ss.add(when: 'CONFIG_VHOST_USER_I2C', if_true: files('vhost-user-i2c.c'))
     system_virtio_ss.add(when: 'CONFIG_VHOST_USER_RNG', if_true: files('vhost-user-rng.c'))
 
     # PCI Stubs
     system_virtio_ss.add(when: 'CONFIG_VIRTIO_PCI', if_true: files('vhost-user-device-pci.c'))
     system_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_GPIO'],
                          if_true: files('vhost-user-gpio-pci.c'))
+    system_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_I2C'],
+                         if_true: files('vhost-user-i2c-pci.c'))
     system_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_RNG'],
                          if_true: files('vhost-user-rng-pci.c'))
   endif
@@ -46,7 +49,6 @@ specific_virtio_ss.add(when: 'CONFIG_VHOST_VSOCK', if_true: files('vhost-vsock.c
 specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_VSOCK', if_true: files('vhost-user-vsock.c'))
 specific_virtio_ss.add(when: 'CONFIG_VIRTIO_RNG', if_true: files('virtio-rng.c'))
 specific_virtio_ss.add(when: 'CONFIG_VIRTIO_MEM', if_true: files('virtio-mem.c'))
-specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_I2C', if_true: files('vhost-user-i2c.c'))
 specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_SCMI', if_true: files('vhost-user-scmi.c'))
 specific_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_SCMI'], if_true: files('vhost-user-scmi-pci.c'))
 
@@ -54,7 +56,6 @@ virtio_pci_ss = ss.source_set()
 virtio_pci_ss.add(when: 'CONFIG_VHOST_VSOCK', if_true: files('vhost-vsock-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VHOST_USER_VSOCK', if_true: files('vhost-user-vsock-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VHOST_USER_BLK', if_true: files('vhost-user-blk-pci.c'))
-virtio_pci_ss.add(when: 'CONFIG_VHOST_USER_I2C', if_true: files('vhost-user-i2c-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VHOST_USER_INPUT', if_true: files('vhost-user-input-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VHOST_USER_SCSI', if_true: files('vhost-user-scsi-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VHOST_SCSI', if_true: files('vhost-scsi-pci.c'))
-- 
2.39.2


