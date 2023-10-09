Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FAC7BD7D1
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 12:01:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpn3N-0006Xk-B1; Mon, 09 Oct 2023 05:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qpn3F-0006VO-58
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 05:59:50 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qpn37-00081K-Ju
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 05:59:48 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3248aa5cf4eso4320249f8f.1
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 02:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696845580; x=1697450380; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kvgwZHCPs/MJ1K1NpHP6qhfx9XJYJ+put5LnOga6wjk=;
 b=s0ZzJ8YvvoKBTn750iBnRSxCmZWTkaor0bXjj9WRJzCgJ4k3X+GpYnsg+xOwMUUwXa
 7G6/om5Dv+S5opiIVciHA61Er84gYFl2Epd/wi9zlaaIwHlD6Mt1xKHeoUz8AyeCSN0I
 IIn2E388giKQZQzBYWxLj+ywIkR/4ba4Pvi4nxBp5Yldsvc+swpQzrjDUxon+HD3X1h4
 uIKvsmxSejlxQDIhwICcNct5Lup8gdrvwZxMUSMZg7igPKYRrJTdZ4761i/ZDx9f5tCc
 cepfAJD6BR4zusbmxsZw9Bntm2QMn0eob9WYWSSOcZlZI5kEnSZAk7qH972hF50VoFPO
 f82A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696845580; x=1697450380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kvgwZHCPs/MJ1K1NpHP6qhfx9XJYJ+put5LnOga6wjk=;
 b=O2p5oJwtxLk8FUV3OqW7jNEYoNuy0x5vvf6FMaqfqz3B7E0dGHuCxJGHJWQaCu9NSL
 cWM+3Ir4VWaSMlyKSY3Dv/OyGewUwMIOPzhsIAS/sbf0a0CEoR5evS6A7qWcXbL3n5gW
 qBqWLjS2bd0qYzoBTZ+G+8PRu4bXrh+5fsLDXKStYHZgFKHkcF5qYEZc1TkJORRx+2um
 RVTkjce7uhcmuJm+cZ+yBSlTVRhPPAFQjygG7auCGJMSTgQ8gyQesuVgYyXHjPD9l/3e
 yQ0LwxTW9w3ESeccwybylZgLsbhHHn8Kzv2jG1qvZY7ILFqE4+IzQILN81wsFELohpEo
 iAjQ==
X-Gm-Message-State: AOJu0YwkBCiF/gYQKLmglayfhkm3O9RrYu3/mjPTFncy/9mUrvmjWmMi
 w4x0ifINZDxRWHKALugON/9jZQ==
X-Google-Smtp-Source: AGHT+IGr1D2KTY95rajVOarxNHUPfSclIDm7yU9Mx/b7sy6q1G95LnGCOB/UrJjzb0ZLa8dgAj/AnA==
X-Received: by 2002:adf:e607:0:b0:31f:b9ea:76c with SMTP id
 p7-20020adfe607000000b0031fb9ea076cmr12303198wrm.48.1696845579711; 
 Mon, 09 Oct 2023 02:59:39 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 m8-20020a056000180800b00321773bb933sm9129665wrh.77.2023.10.09.02.59.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Oct 2023 02:59:39 -0700 (PDT)
Received: from zen.linaroharston (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4F6B41FFBC;
 Mon,  9 Oct 2023 10:59:38 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Erik Schilling <erik.schilling@linaro.org>, Fam Zheng <fam@euphon.net>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Viresh Kumar <viresh.kumar@linaro.org>, virtio-fs@redhat.com,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Markus Armbruster <armbru@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v4 1/6] virtio: split into vhost-user-base and
 vhost-user-device
Date: Mon,  9 Oct 2023 10:59:32 +0100
Message-Id: <20231009095937.195728-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231009095937.195728-1-alex.bennee@linaro.org>
References: <20231009095937.195728-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Lets keep a cleaner split between the base class and the derived
vhost-user-device which we can use for generic vhost-user stubs. This
includes an update to introduce the vq_size property so the number of
entries in a virtq can be defined.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v1
  - merge and re-base, reset testing/review tags
---
 include/hw/virtio/vhost-user-base.h |  49 ++++
 hw/virtio/vhost-user-base.c         | 348 ++++++++++++++++++++++++++++
 hw/virtio/vhost-user-device-pci.c   |  10 +-
 hw/virtio/vhost-user-device.c       | 335 +-------------------------
 hw/virtio/meson.build               |   1 +
 5 files changed, 410 insertions(+), 333 deletions(-)
 create mode 100644 include/hw/virtio/vhost-user-base.h
 create mode 100644 hw/virtio/vhost-user-base.c

diff --git a/include/hw/virtio/vhost-user-base.h b/include/hw/virtio/vhost-user-base.h
new file mode 100644
index 0000000000..cad377468b
--- /dev/null
+++ b/include/hw/virtio/vhost-user-base.h
@@ -0,0 +1,49 @@
+/*
+ * Vhost-user generic virtio device
+ *
+ * Copyright (c) 2023 Linaro Ltd
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef QEMU_VHOST_USER_BASE_H
+#define QEMU_VHOST_USER_BASE_H
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
+
+    /* Properties */
+    CharBackend chardev;
+    uint16_t virtio_id;
+    uint32_t num_vqs;
+    uint32_t vq_size; /* can't exceed VIRTIO_QUEUE_MAX */
+    uint32_t config_size;
+    /* State tracking */
+    VhostUserState vhost_user;
+    struct vhost_virtqueue *vhost_vq;
+    struct vhost_dev vhost_dev;
+    GPtrArray *vqs;
+    bool connected;
+};
+
+/*
+ * Needed so we can use the base realize after specialisation
+ * tweaks
+ */
+struct VHostUserBaseClass {
+    VirtioDeviceClass parent_class;
+
+    DeviceRealize parent_realize;
+};
+
+
+#define TYPE_VHOST_USER_DEVICE "vhost-user-device"
+
+#endif /* QEMU_VHOST_USER_BASE_H */
diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
new file mode 100644
index 0000000000..a8b811c394
--- /dev/null
+++ b/hw/virtio/vhost-user-base.c
@@ -0,0 +1,348 @@
+/*
+ * Base vhost-user-base implementation. This can be used to derive a
+ * more fully specified vhost-user backend either generically (see
+ * vhost-user-device) or via a specific stub for a device which
+ * encapsulates some fixed parameters.
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
+#include "hw/virtio/vhost-user-base.h"
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
+        error_report("Error starting vhost-user-base: %d", -ret);
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
+/*
+ * To handle VirtIO config we need to know the size of the config
+ * space. We don't cache the config but re-fetch it from the guest
+ * every time in case something has changed.
+ */
+static void vub_get_config(VirtIODevice *vdev, uint8_t *config)
+{
+    VHostUserBase *vub = VHOST_USER_BASE(vdev);
+    Error *local_err = NULL;
+
+    /*
+     * There will have been a warning during vhost_dev_init, but lets
+     * assert here as nothing will go right now.
+     */
+    g_assert(vub->config_size && vub->vhost_user.supports_config == true);
+
+    if (vhost_dev_get_config(&vub->vhost_dev, config,
+                             vub->config_size, &local_err)) {
+        error_report_err(local_err);
+    }
+}
+
+/*
+ * When the daemon signals an update to the config we just need to
+ * signal the guest as we re-read the config on demand above.
+ */
+static int vub_config_notifier(struct vhost_dev *dev)
+{
+    virtio_notify_config(dev->vdev);
+    return 0;
+}
+
+const VhostDevConfigOps vub_config_ops = {
+    .vhost_dev_config_notifier = vub_config_notifier,
+};
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
+    struct vhost_dev *vhost_dev = &vub->vhost_dev;
+
+    if (vub->connected) {
+        return 0;
+    }
+    vub->connected = true;
+
+    /*
+     * If we support VHOST_USER_GET_CONFIG we must enable the notifier
+     * so we can ping the guest when it updates.
+     */
+    if (vub->vhost_user.supports_config) {
+        vhost_dev_set_config_notifier(vhost_dev, &vub_config_ops);
+    }
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
+        error_setg(errp, "vhost-user-base: missing chardev");
+        return;
+    }
+
+    if (!vub->virtio_id) {
+        error_setg(errp, "vhost-user-base: need to define device id");
+        return;
+    }
+
+    if (!vub->num_vqs) {
+        vub->num_vqs = 1; /* reasonable default? */
+    }
+
+    if (!vub->vq_size) {
+        vub->vq_size = 64;
+    }
+
+    /*
+     * We can't handle config requests unless we know the size of the
+     * config region, specialisations of the vhost-user-base will be
+     * able to set this.
+     */
+    if (vub->config_size) {
+        vub->vhost_user.supports_config = true;
+    }
+
+    if (!vhost_user_init(&vub->vhost_user, &vub->chardev, errp)) {
+        return;
+    }
+
+    virtio_init(vdev, vub->virtio_id, vub->config_size);
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
+                        virtio_add_queue(vdev, vub->vq_size, vub_handle_output));
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
+    vdc->get_config = vub_get_config;
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
+static void vu_register_types(void)
+{
+    type_register_static(&vub_info);
+}
+
+type_init(vu_register_types)
diff --git a/hw/virtio/vhost-user-device-pci.c b/hw/virtio/vhost-user-device-pci.c
index 41f9b7905b..22a5e95b9c 100644
--- a/hw/virtio/vhost-user-device-pci.c
+++ b/hw/virtio/vhost-user-device-pci.c
@@ -9,21 +9,18 @@
 
 #include "qemu/osdep.h"
 #include "hw/qdev-properties.h"
-#include "hw/virtio/vhost-user-device.h"
+#include "hw/virtio/vhost-user-base.h"
 #include "hw/virtio/virtio-pci.h"
 
 struct VHostUserDevicePCI {
     VirtIOPCIProxy parent_obj;
+
     VHostUserBase vub;
 };
 
-typedef struct VHostUserDevicePCI VHostUserDevicePCI;
-
 #define TYPE_VHOST_USER_DEVICE_PCI "vhost-user-device-pci-base"
 
-DECLARE_INSTANCE_CHECKER(VHostUserDevicePCI,
-                         VHOST_USER_DEVICE_PCI,
-                         TYPE_VHOST_USER_DEVICE_PCI)
+OBJECT_DECLARE_SIMPLE_TYPE(VHostUserDevicePCI, VHOST_USER_DEVICE_PCI)
 
 static void vhost_user_device_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
 {
@@ -39,6 +36,7 @@ static void vhost_user_device_pci_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
     PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
+
     k->realize = vhost_user_device_pci_realize;
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
     pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
diff --git a/hw/virtio/vhost-user-device.c b/hw/virtio/vhost-user-device.c
index 2b028cae08..4adc1e8991 100644
--- a/hw/virtio/vhost-user-device.c
+++ b/hw/virtio/vhost-user-device.c
@@ -1,7 +1,10 @@
 /*
- * Generic vhost-user stub. This can be used to connect to any
- * vhost-user backend. All configuration details must be handled by
- * the vhost-user daemon itself
+ * Generic vhost-user-device implementation for any vhost-user-backend
+ *
+ * This is a concrete implementation of vhost-user-base which can be
+ * configured via properties. It is useful for development and
+ * prototyping. It expects configuration details (if any) to be
+ * handled by the vhost-user daemon itself.
  *
  * Copyright (c) 2023 Linaro Ltd
  * Author: Alex Bennée <alex.bennee@linaro.org>
@@ -13,329 +16,9 @@
 #include "qapi/error.h"
 #include "hw/qdev-properties.h"
 #include "hw/virtio/virtio-bus.h"
-#include "hw/virtio/vhost-user-device.h"
+#include "hw/virtio/vhost-user-base.h"
 #include "qemu/error-report.h"
 
-static void vub_start(VirtIODevice *vdev)
-{
-    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
-    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
-    VHostUserBase *vub = VHOST_USER_BASE(vdev);
-    int ret, i;
-
-    if (!k->set_guest_notifiers) {
-        error_report("binding does not support guest notifiers");
-        return;
-    }
-
-    ret = vhost_dev_enable_notifiers(&vub->vhost_dev, vdev);
-    if (ret < 0) {
-        error_report("Error enabling host notifiers: %d", -ret);
-        return;
-    }
-
-    ret = k->set_guest_notifiers(qbus->parent, vub->vhost_dev.nvqs, true);
-    if (ret < 0) {
-        error_report("Error binding guest notifier: %d", -ret);
-        goto err_host_notifiers;
-    }
-
-    vub->vhost_dev.acked_features = vdev->guest_features;
-
-    ret = vhost_dev_start(&vub->vhost_dev, vdev, true);
-    if (ret < 0) {
-        error_report("Error starting vhost-user-device: %d", -ret);
-        goto err_guest_notifiers;
-    }
-
-    /*
-     * guest_notifier_mask/pending not used yet, so just unmask
-     * everything here. virtio-pci will do the right thing by
-     * enabling/disabling irqfd.
-     */
-    for (i = 0; i < vub->vhost_dev.nvqs; i++) {
-        vhost_virtqueue_mask(&vub->vhost_dev, vdev, i, false);
-    }
-
-    return;
-
-err_guest_notifiers:
-    k->set_guest_notifiers(qbus->parent, vub->vhost_dev.nvqs, false);
-err_host_notifiers:
-    vhost_dev_disable_notifiers(&vub->vhost_dev, vdev);
-}
-
-static void vub_stop(VirtIODevice *vdev)
-{
-    VHostUserBase *vub = VHOST_USER_BASE(vdev);
-    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
-    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
-    int ret;
-
-    if (!k->set_guest_notifiers) {
-        return;
-    }
-
-    vhost_dev_stop(&vub->vhost_dev, vdev, true);
-
-    ret = k->set_guest_notifiers(qbus->parent, vub->vhost_dev.nvqs, false);
-    if (ret < 0) {
-        error_report("vhost guest notifier cleanup failed: %d", ret);
-        return;
-    }
-
-    vhost_dev_disable_notifiers(&vub->vhost_dev, vdev);
-}
-
-static void vub_set_status(VirtIODevice *vdev, uint8_t status)
-{
-    VHostUserBase *vub = VHOST_USER_BASE(vdev);
-    bool should_start = virtio_device_should_start(vdev, status);
-
-    if (vhost_dev_is_started(&vub->vhost_dev) == should_start) {
-        return;
-    }
-
-    if (should_start) {
-        vub_start(vdev);
-    } else {
-        vub_stop(vdev);
-    }
-}
-
-/*
- * For an implementation where everything is delegated to the backend
- * we don't do anything other than return the full feature set offered
- * by the daemon (module the reserved feature bit).
- */
-static uint64_t vub_get_features(VirtIODevice *vdev,
-                                 uint64_t requested_features, Error **errp)
-{
-    VHostUserBase *vub = VHOST_USER_BASE(vdev);
-    /* This should be set when the vhost connection initialises */
-    g_assert(vub->vhost_dev.features);
-    return vub->vhost_dev.features & ~(1ULL << VHOST_USER_F_PROTOCOL_FEATURES);
-}
-
-/*
- * To handle VirtIO config we need to know the size of the config
- * space. We don't cache the config but re-fetch it from the guest
- * every time in case something has changed.
- */
-static void vub_get_config(VirtIODevice *vdev, uint8_t *config)
-{
-    VHostUserBase *vub = VHOST_USER_BASE(vdev);
-    Error *local_err = NULL;
-
-    /*
-     * There will have been a warning during vhost_dev_init, but lets
-     * assert here as nothing will go right now.
-     */
-    g_assert(vub->config_size && vub->vhost_user.supports_config == true);
-
-    if (vhost_dev_get_config(&vub->vhost_dev, config,
-                             vub->config_size, &local_err)) {
-        error_report_err(local_err);
-    }
-}
-
-/*
- * When the daemon signals an update to the config we just need to
- * signal the guest as we re-read the config on demand above.
- */
-static int vub_config_notifier(struct vhost_dev *dev)
-{
-    virtio_notify_config(dev->vdev);
-    return 0;
-}
-
-const VhostDevConfigOps vub_config_ops = {
-    .vhost_dev_config_notifier = vub_config_notifier,
-};
-
-static void vub_handle_output(VirtIODevice *vdev, VirtQueue *vq)
-{
-    /*
-     * Not normally called; it's the daemon that handles the queue;
-     * however virtio's cleanup path can call this.
-     */
-}
-
-static void do_vhost_user_cleanup(VirtIODevice *vdev, VHostUserBase *vub)
-{
-    vhost_user_cleanup(&vub->vhost_user);
-
-    for (int i = 0; i < vub->num_vqs; i++) {
-        VirtQueue *vq = g_ptr_array_index(vub->vqs, i);
-        virtio_delete_queue(vq);
-    }
-
-    virtio_cleanup(vdev);
-}
-
-static int vub_connect(DeviceState *dev)
-{
-    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
-    VHostUserBase *vub = VHOST_USER_BASE(vdev);
-    struct vhost_dev *vhost_dev = &vub->vhost_dev;
-
-    if (vub->connected) {
-        return 0;
-    }
-    vub->connected = true;
-
-    /*
-     * If we support VHOST_USER_GET_CONFIG we must enable the notifier
-     * so we can ping the guest when it updates.
-     */
-    if (vub->vhost_user.supports_config) {
-        vhost_dev_set_config_notifier(vhost_dev, &vub_config_ops);
-    }
-
-    /* restore vhost state */
-    if (virtio_device_started(vdev, vdev->status)) {
-        vub_start(vdev);
-    }
-
-    return 0;
-}
-
-static void vub_disconnect(DeviceState *dev)
-{
-    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
-    VHostUserBase *vub = VHOST_USER_BASE(vdev);
-
-    if (!vub->connected) {
-        return;
-    }
-    vub->connected = false;
-
-    if (vhost_dev_is_started(&vub->vhost_dev)) {
-        vub_stop(vdev);
-    }
-}
-
-static void vub_event(void *opaque, QEMUChrEvent event)
-{
-    DeviceState *dev = opaque;
-    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
-    VHostUserBase *vub = VHOST_USER_BASE(vdev);
-
-    switch (event) {
-    case CHR_EVENT_OPENED:
-        if (vub_connect(dev) < 0) {
-            qemu_chr_fe_disconnect(&vub->chardev);
-            return;
-        }
-        break;
-    case CHR_EVENT_CLOSED:
-        vub_disconnect(dev);
-        break;
-    case CHR_EVENT_BREAK:
-    case CHR_EVENT_MUX_IN:
-    case CHR_EVENT_MUX_OUT:
-        /* Ignore */
-        break;
-    }
-}
-
-static void vub_device_realize(DeviceState *dev, Error **errp)
-{
-    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
-    VHostUserBase *vub = VHOST_USER_BASE(dev);
-    int ret;
-
-    if (!vub->chardev.chr) {
-        error_setg(errp, "vhost-user-device: missing chardev");
-        return;
-    }
-
-    if (!vub->virtio_id) {
-        error_setg(errp, "vhost-user-device: need to define device id");
-        return;
-    }
-
-    if (!vub->num_vqs) {
-        vub->num_vqs = 1; /* reasonable default? */
-    }
-
-    /*
-     * We can't handle config requests unless we know the size of the
-     * config region, specialisations of the vhost-user-device will be
-     * able to set this.
-     */
-    if (vub->config_size) {
-        vub->vhost_user.supports_config = true;
-    }
-
-    if (!vhost_user_init(&vub->vhost_user, &vub->chardev, errp)) {
-        return;
-    }
-
-    virtio_init(vdev, vub->virtio_id, vub->config_size);
-
-    /*
-     * Disable guest notifiers, by default all notifications will be via the
-     * asynchronous vhost-user socket.
-     */
-    vdev->use_guest_notifier_mask = false;
-
-    /* Allocate queues */
-    vub->vqs = g_ptr_array_sized_new(vub->num_vqs);
-    for (int i = 0; i < vub->num_vqs; i++) {
-        g_ptr_array_add(vub->vqs,
-                        virtio_add_queue(vdev, 4, vub_handle_output));
-    }
-
-    vub->vhost_dev.nvqs = vub->num_vqs;
-    vub->vhost_dev.vqs = g_new0(struct vhost_virtqueue, vub->vhost_dev.nvqs);
-
-    /* connect to backend */
-    ret = vhost_dev_init(&vub->vhost_dev, &vub->vhost_user,
-                         VHOST_BACKEND_TYPE_USER, 0, errp);
-
-    if (ret < 0) {
-        do_vhost_user_cleanup(vdev, vub);
-    }
-
-    qemu_chr_fe_set_handlers(&vub->chardev, NULL, NULL, vub_event, NULL,
-                             dev, NULL, true);
-}
-
-static void vub_device_unrealize(DeviceState *dev)
-{
-    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
-    VHostUserBase *vub = VHOST_USER_BASE(dev);
-    struct vhost_virtqueue *vhost_vqs = vub->vhost_dev.vqs;
-
-    /* This will stop vhost backend if appropriate. */
-    vub_set_status(vdev, 0);
-    vhost_dev_cleanup(&vub->vhost_dev);
-    g_free(vhost_vqs);
-    do_vhost_user_cleanup(vdev, vub);
-}
-
-static void vub_class_init(ObjectClass *klass, void *data)
-{
-    VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
-
-    vdc->realize = vub_device_realize;
-    vdc->unrealize = vub_device_unrealize;
-    vdc->get_features = vub_get_features;
-    vdc->get_config = vub_get_config;
-    vdc->set_status = vub_set_status;
-}
-
-static const TypeInfo vub_info = {
-    .name = TYPE_VHOST_USER_BASE,
-    .parent = TYPE_VIRTIO_DEVICE,
-    .instance_size = sizeof(VHostUserBase),
-    .class_init = vub_class_init,
-    .class_size = sizeof(VHostUserBaseClass),
-    .abstract = true
-};
-
-
 /*
  * The following is a concrete implementation of the base class which
  * allows the user to define the key parameters via the command line.
@@ -349,6 +32,7 @@ static const VMStateDescription vud_vmstate = {
 static Property vud_properties[] = {
     DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
     DEFINE_PROP_UINT16("virtio-id", VHostUserBase, virtio_id, 0),
+    DEFINE_PROP_UINT32("vq_size", VHostUserBase, vq_size, 64),
     DEFINE_PROP_UINT32("num_vqs", VHostUserBase, num_vqs, 1),
     DEFINE_PROP_UINT32("config_size", VHostUserBase, config_size, 0),
     DEFINE_PROP_END_OF_LIST(),
@@ -366,14 +50,11 @@ static void vud_class_init(ObjectClass *klass, void *data)
 static const TypeInfo vud_info = {
     .name = TYPE_VHOST_USER_DEVICE,
     .parent = TYPE_VHOST_USER_BASE,
-    .instance_size = sizeof(VHostUserBase),
     .class_init = vud_class_init,
-    .class_size = sizeof(VHostUserBaseClass),
 };
 
 static void vu_register_types(void)
 {
-    type_register_static(&vub_info);
     type_register_static(&vud_info);
 }
 
diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index c0055a7832..51c3f97c2d 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -17,6 +17,7 @@ if have_vhost
   if have_vhost_user
     # fixme - this really should be generic
     specific_virtio_ss.add(files('vhost-user.c'))
+    system_virtio_ss.add(files('vhost-user-base.c'))
     system_virtio_ss.add(files('vhost-user-device.c'))
     system_virtio_ss.add(when: 'CONFIG_VIRTIO_PCI', if_true: files('vhost-user-device-pci.c'))
   endif
-- 
2.39.2


