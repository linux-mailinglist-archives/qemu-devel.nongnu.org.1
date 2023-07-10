Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9275374DA02
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 17:37:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIsvb-0005pj-RD; Mon, 10 Jul 2023 11:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qIsvP-0005lA-PH
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 11:35:43 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qIsvG-0004lu-5u
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 11:35:43 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3fba8e2aa52so52003395e9.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 08:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689003331; x=1691595331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kRIoDdd0p00qTB3TzSNz7mfmNIx5ZZ+GLtrFSZRsJqY=;
 b=O3VTuUFMnfLjPnQpb53j5d0/kpCeJ9CbjO/9oPjJpRb9vm5cVbo0rCgAhWC4AUTFSS
 pMU2//4xRY7IrXsrruKU5D4VnTO0yQPAFQFOxHXTNsTCoLSxnxnPKvgchOnlEG6M9PO8
 sT+IlKO3XNPQrvhLf8eoB6sb2YltSyVvpBKc+OXmpQ/akEqBOZ1EnbccVQ6+HyjgfxOk
 tmkFNh8u+5nQZmvWP8VF4kINDOCzd0j7WghbVaNth/lP/uAd6wstmOWb0xH5ZnZT6cg1
 PcJVWB8UvNwGgLLuMmNzMt1EnwxqbBHN7l9C8qz8dfLFT+QBhuYI8bz224978+P2xPvH
 8JHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689003331; x=1691595331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kRIoDdd0p00qTB3TzSNz7mfmNIx5ZZ+GLtrFSZRsJqY=;
 b=MUWDNraCO62Z28mkaKv4bvlf7C008h2oko5eMZr3253WUfLA68/PXD3XOrgl3fd+/y
 gpp4Ouhm31zaLxpdDbRFC6tVQIZ5wEH8ubHIKPcSQlk2jkQ9ufkka3v0PqPhRy0zgL8j
 fa0OMzzR+oYEAufkfQLJ3tgp0PYET1ig9Ez1Nf2bx8jcstQFufjWxc5ASXEMnuCzlGen
 fsHYd3cXsk+NpdDJ/0sibmeqMraDWdc8GCrBLqgf5KryYaQqqKc/9FmdPAC7Du15NKTb
 rKAm0IfDST0aktcF/KdlM5qMjcnZcV77QsNLkEO4pmZsrB+yXq7chW8FhU7qdZWHF1wx
 rT5g==
X-Gm-Message-State: ABy/qLZyci54GZNe5iFLJvmfHlsU2sKdi+kVu+fJgDHSadJPbdnFSNej
 lWOSS6nam17eas9y0i4OAKGMBA==
X-Google-Smtp-Source: APBJJlEG3zp7TR++9OKfbL4ZZy8aJC47GrIv8yw8J71FPzq3guM1ZTxOARYbWjtK5hODiSaIEaUWXw==
X-Received: by 2002:a7b:c39a:0:b0:3fb:ef86:e2e with SMTP id
 s26-20020a7bc39a000000b003fbef860e2emr13254161wmj.19.1689003331099; 
 Mon, 10 Jul 2023 08:35:31 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 u10-20020a7bcb0a000000b003fb739d27aesm10538415wmj.35.2023.07.10.08.35.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 08:35:29 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 035211FFC2;
 Mon, 10 Jul 2023 16:35:23 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Erik Schilling <erik.schilling@linaro.org>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fam Zheng <fam@euphon.net>,
 virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v3 07/20] virtio: add vhost-user-base and a generic
 vhost-user-device
Date: Mon, 10 Jul 2023 16:35:09 +0100
Message-Id: <20230710153522.3469097-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230710153522.3469097-1-alex.bennee@linaro.org>
References: <20230710153522.3469097-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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

In theory we shouldn't need to repeat so much boilerplate to support
vhost-user backends. This provides a generic vhost-user-base QOM
object and a derived vhost-user-device for which the user needs to
provide the few bits of information that aren't currently provided by
the vhost-user protocol. This should provide a baseline implementation
from which the other vhost-user stub can specialise.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - split into vub and vud
---
 include/hw/virtio/vhost-user-device.h |  45 ++++
 hw/virtio/vhost-user-device.c         | 324 ++++++++++++++++++++++++++
 hw/virtio/meson.build                 |   2 +
 3 files changed, 371 insertions(+)
 create mode 100644 include/hw/virtio/vhost-user-device.h
 create mode 100644 hw/virtio/vhost-user-device.c

diff --git a/include/hw/virtio/vhost-user-device.h b/include/hw/virtio/vhost-user-device.h
new file mode 100644
index 0000000000..9105011e25
--- /dev/null
+++ b/include/hw/virtio/vhost-user-device.h
@@ -0,0 +1,45 @@
+/*
+ * Vhost-user generic virtio device
+ *
+ * Copyright (c) 2023 Linaro Ltd
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef QEMU_VHOST_USER_DEVICE_H
+#define QEMU_VHOST_USER_DEVICE_H
+
+#include "hw/virtio/vhost.h"
+#include "hw/virtio/vhost-user.h"
+
+#define TYPE_VHOST_USER_BASE "vhost-user-base"
+
+OBJECT_DECLARE_TYPE(VHostUserBase, VHostUserBaseClass, VHOST_USER_BASE)
+
+struct VHostUserBase {
+    VirtIODevice parent;
+    /* Properties */
+    CharBackend chardev;
+    uint16_t virtio_id;
+    uint32_t num_vqs;
+    /* State tracking */
+    VhostUserState vhost_user;
+    struct vhost_virtqueue *vhost_vq;
+    struct vhost_dev vhost_dev;
+    GPtrArray *vqs;
+    bool connected;
+};
+
+    /* needed so we can use the base realize after specialisation
+       tweaks */
+struct VHostUserBaseClass {
+    /*< private >*/
+    VirtioDeviceClass parent_class;
+    /*< public >*/
+    DeviceRealize parent_realize;
+};
+
+/* shared for the benefit of the derived pci class */
+#define TYPE_VHOST_USER_DEVICE "vhost-user-device"
+
+#endif /* QEMU_VHOST_USER_DEVICE_H */
diff --git a/hw/virtio/vhost-user-device.c b/hw/virtio/vhost-user-device.c
new file mode 100644
index 0000000000..b0239fa033
--- /dev/null
+++ b/hw/virtio/vhost-user-device.c
@@ -0,0 +1,324 @@
+/*
+ * Generic vhost-user stub. This can be used to connect to any
+ * vhost-user backend. All configuration details must be handled by
+ * the vhost-user daemon itself
+ *
+ * Copyright (c) 2023 Linaro Ltd
+ * Author: Alex Bennée <alex.bennee@linaro.org>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/qdev-properties.h"
+#include "hw/virtio/virtio-bus.h"
+#include "hw/virtio/vhost-user-device.h"
+#include "qemu/error-report.h"
+
+static void vub_start(VirtIODevice *vdev)
+{
+    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
+    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
+    VHostUserBase *vub = VHOST_USER_BASE(vdev);
+    int ret, i;
+
+    if (!k->set_guest_notifiers) {
+        error_report("binding does not support guest notifiers");
+        return;
+    }
+
+    ret = vhost_dev_enable_notifiers(&vub->vhost_dev, vdev);
+    if (ret < 0) {
+        error_report("Error enabling host notifiers: %d", -ret);
+        return;
+    }
+
+    ret = k->set_guest_notifiers(qbus->parent, vub->vhost_dev.nvqs, true);
+    if (ret < 0) {
+        error_report("Error binding guest notifier: %d", -ret);
+        goto err_host_notifiers;
+    }
+
+    vub->vhost_dev.acked_features = vdev->guest_features;
+
+    ret = vhost_dev_start(&vub->vhost_dev, vdev, true);
+    if (ret < 0) {
+        error_report("Error starting vhost-user-device: %d", -ret);
+        goto err_guest_notifiers;
+    }
+
+    /*
+     * guest_notifier_mask/pending not used yet, so just unmask
+     * everything here. virtio-pci will do the right thing by
+     * enabling/disabling irqfd.
+     */
+    for (i = 0; i < vub->vhost_dev.nvqs; i++) {
+        vhost_virtqueue_mask(&vub->vhost_dev, vdev, i, false);
+    }
+
+    return;
+
+err_guest_notifiers:
+    k->set_guest_notifiers(qbus->parent, vub->vhost_dev.nvqs, false);
+err_host_notifiers:
+    vhost_dev_disable_notifiers(&vub->vhost_dev, vdev);
+}
+
+static void vub_stop(VirtIODevice *vdev)
+{
+    VHostUserBase *vub = VHOST_USER_BASE(vdev);
+    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
+    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
+    int ret;
+
+    if (!k->set_guest_notifiers) {
+        return;
+    }
+
+    vhost_dev_stop(&vub->vhost_dev, vdev, true);
+
+    ret = k->set_guest_notifiers(qbus->parent, vub->vhost_dev.nvqs, false);
+    if (ret < 0) {
+        error_report("vhost guest notifier cleanup failed: %d", ret);
+        return;
+    }
+
+    vhost_dev_disable_notifiers(&vub->vhost_dev, vdev);
+}
+
+static void vub_set_status(VirtIODevice *vdev, uint8_t status)
+{
+    VHostUserBase *vub = VHOST_USER_BASE(vdev);
+    bool should_start = virtio_device_should_start(vdev, status);
+
+    if (vhost_dev_is_started(&vub->vhost_dev) == should_start) {
+        return;
+    }
+
+    if (should_start) {
+        vub_start(vdev);
+    } else {
+        vub_stop(vdev);
+    }
+}
+
+/*
+ * For an implementation where everything is delegated to the backend
+ * we don't do anything other than return the full feature set offered
+ * by the daemon (module the reserved feature bit).
+ */
+static uint64_t vub_get_features(VirtIODevice *vdev,
+                                 uint64_t requested_features, Error **errp)
+{
+    VHostUserBase *vub = VHOST_USER_BASE(vdev);
+    /* This should be set when the vhost connection initialises */
+    g_assert(vub->vhost_dev.features);
+    return vub->vhost_dev.features & ~(1ULL << VHOST_USER_F_PROTOCOL_FEATURES);
+}
+
+static void vub_handle_output(VirtIODevice *vdev, VirtQueue *vq)
+{
+    /*
+     * Not normally called; it's the daemon that handles the queue;
+     * however virtio's cleanup path can call this.
+     */
+}
+
+static void do_vhost_user_cleanup(VirtIODevice *vdev, VHostUserBase *vub)
+{
+    vhost_user_cleanup(&vub->vhost_user);
+
+    for (int i = 0; i < vub->num_vqs; i++) {
+        VirtQueue *vq = g_ptr_array_index(vub->vqs, i);
+        virtio_delete_queue(vq);
+    }
+
+    virtio_cleanup(vdev);
+}
+
+static int vub_connect(DeviceState *dev)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VHostUserBase *vub = VHOST_USER_BASE(vdev);
+
+    if (vub->connected) {
+        return 0;
+    }
+    vub->connected = true;
+
+    /* restore vhost state */
+    if (virtio_device_started(vdev, vdev->status)) {
+        vub_start(vdev);
+    }
+
+    return 0;
+}
+
+static void vub_disconnect(DeviceState *dev)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VHostUserBase *vub = VHOST_USER_BASE(vdev);
+
+    if (!vub->connected) {
+        return;
+    }
+    vub->connected = false;
+
+    if (vhost_dev_is_started(&vub->vhost_dev)) {
+        vub_stop(vdev);
+    }
+}
+
+static void vub_event(void *opaque, QEMUChrEvent event)
+{
+    DeviceState *dev = opaque;
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VHostUserBase *vub = VHOST_USER_BASE(vdev);
+
+    switch (event) {
+    case CHR_EVENT_OPENED:
+        if (vub_connect(dev) < 0) {
+            qemu_chr_fe_disconnect(&vub->chardev);
+            return;
+        }
+        break;
+    case CHR_EVENT_CLOSED:
+        vub_disconnect(dev);
+        break;
+    case CHR_EVENT_BREAK:
+    case CHR_EVENT_MUX_IN:
+    case CHR_EVENT_MUX_OUT:
+        /* Ignore */
+        break;
+    }
+}
+
+static void vub_device_realize(DeviceState *dev, Error **errp)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VHostUserBase *vub = VHOST_USER_BASE(dev);
+    int ret;
+
+    if (!vub->chardev.chr) {
+        error_setg(errp, "vhost-user-device: missing chardev");
+        return;
+    }
+
+    if (!vub->virtio_id) {
+        error_setg(errp, "vhost-user-device: need to define device id");
+        return;
+    }
+
+    if (!vub->num_vqs) {
+        vub->num_vqs = 1; /* reasonable default? */
+    }
+
+    if (!vhost_user_init(&vub->vhost_user, &vub->chardev, errp)) {
+        return;
+    }
+
+    virtio_init(vdev, vub->virtio_id, 0);
+
+    /*
+     * Disable guest notifiers, by default all notifications will be via the
+     * asynchronous vhost-user socket.
+     */
+    vdev->use_guest_notifier_mask = false;
+
+    /* Allocate queues */
+    vub->vqs = g_ptr_array_sized_new(vub->num_vqs);
+    for (int i = 0; i < vub->num_vqs; i++) {
+        g_ptr_array_add(vub->vqs,
+                        virtio_add_queue(vdev, 4, vub_handle_output));
+    }
+
+    vub->vhost_dev.nvqs = vub->num_vqs;
+    vub->vhost_dev.vqs = g_new0(struct vhost_virtqueue, vub->vhost_dev.nvqs);
+
+    /* connect to backend */
+    ret = vhost_dev_init(&vub->vhost_dev, &vub->vhost_user,
+                         VHOST_BACKEND_TYPE_USER, 0, errp);
+
+    if (ret < 0) {
+        do_vhost_user_cleanup(vdev, vub);
+    }
+
+    qemu_chr_fe_set_handlers(&vub->chardev, NULL, NULL, vub_event, NULL,
+                             dev, NULL, true);
+}
+
+static void vub_device_unrealize(DeviceState *dev)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VHostUserBase *vub = VHOST_USER_BASE(dev);
+    struct vhost_virtqueue *vhost_vqs = vub->vhost_dev.vqs;
+
+    /* This will stop vhost backend if appropriate. */
+    vub_set_status(vdev, 0);
+    vhost_dev_cleanup(&vub->vhost_dev);
+    g_free(vhost_vqs);
+    do_vhost_user_cleanup(vdev, vub);
+}
+
+static void vub_class_init(ObjectClass *klass, void *data)
+{
+    VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
+
+    vdc->realize = vub_device_realize;
+    vdc->unrealize = vub_device_unrealize;
+    vdc->get_features = vub_get_features;
+    vdc->set_status = vub_set_status;
+}
+
+static const TypeInfo vub_info = {
+    .name = TYPE_VHOST_USER_BASE,
+    .parent = TYPE_VIRTIO_DEVICE,
+    .instance_size = sizeof(VHostUserBase),
+    .class_init = vub_class_init,
+    .class_size = sizeof(VHostUserBaseClass),
+    .abstract = true
+};
+
+
+/*
+ * The following is a concrete implementation of the base class which
+ * allows the user to define the key parameters via the command line.
+ */
+
+static const VMStateDescription vud_vmstate = {
+    .name = "vhost-user-device",
+    .unmigratable = 1,
+};
+
+static Property vud_properties[] = {
+    DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
+    DEFINE_PROP_UINT16("virtio-id", VHostUserBase, virtio_id, 0),
+    DEFINE_PROP_UINT32("num_vqs", VHostUserBase, num_vqs, 1),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void vud_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_props(dc, vud_properties);
+    dc->vmsd = &vud_vmstate;
+    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
+}
+
+static const TypeInfo vud_info = {
+    .name = TYPE_VHOST_USER_DEVICE,
+    .parent = TYPE_VHOST_USER_BASE,
+    .instance_size = sizeof(VHostUserBase),
+    .class_init = vud_class_init,
+    .class_size = sizeof(VHostUserBaseClass),
+};
+
+static void vu_register_types(void)
+{
+    type_register_static(&vub_info);
+    type_register_static(&vud_info);
+}
+
+type_init(vu_register_types)
diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index f32b22f61b..b87c5523e7 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -15,7 +15,9 @@ if have_vhost
   softmmu_virtio_ss.add(files('vhost.c'))
   specific_virtio_ss.add(files('vhost-backend.c', 'vhost-iova-tree.c'))
   if have_vhost_user
+    # fixme - this really should be generic
     specific_virtio_ss.add(files('vhost-user.c'))
+    softmmu_virtio_ss.add(files('vhost-user-device.c'))
   endif
   if have_vhost_vdpa
     specific_virtio_ss.add(files('vhost-vdpa.c', 'vhost-shadow-virtqueue.c'))
-- 
2.39.2


