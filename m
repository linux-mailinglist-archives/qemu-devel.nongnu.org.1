Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D45740E2C
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 12:07:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qES4K-0008FT-FK; Wed, 28 Jun 2023 06:06:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mzamazal@redhat.com>)
 id 1qES4D-0008EN-Dv
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 06:06:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mzamazal@redhat.com>)
 id 1qES4B-0005Xa-79
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 06:06:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687946785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xLkVCYV6eT+noTbrApKE6i72yvD0mufgKuJt9CFL3UA=;
 b=UH6YIOsLi1FlsyblSlVrsJc8z9C7SJdJDULF2lhGpuzmJ4UDyB73RF4ucXYWxfcL3sEm+3
 W3KMXisPuYhvkaZ+2FxbgRk+iaRWo22Bf6JNxcJwL1VFW1pWlmjMRcRkS27kHoikqBLPt0
 aZatCAeL24WUhMQENZ/ZD6hGCk2fomQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-192-xcB9XdJIMtWasVa6C6CvVA-1; Wed, 28 Jun 2023 06:06:23 -0400
X-MC-Unique: xcB9XdJIMtWasVa6C6CvVA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F64A185A792;
 Wed, 28 Jun 2023 10:06:23 +0000 (UTC)
Received: from nuthatch.redhat.com (unknown [10.45.226.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C490C15230A0;
 Wed, 28 Jun 2023 10:06:21 +0000 (UTC)
From: Milan Zamazal <mzamazal@redhat.com>
To: qemu-devel@nongnu.org
Cc: Milan Zamazal <mzamazal@redhat.com>, mst@redhat.com, stefanha@redhat.com,
 alex.bennee@linaro.org, thuth@redhat.com, vincent.guittot@linaro.org
Subject: [PATCH v3 1/3] hw/virtio: Add boilerplate for vhost-user-scmi device
Date: Wed, 28 Jun 2023 12:05:22 +0200
Message-Id: <20230628100524.342666-2-mzamazal@redhat.com>
In-Reply-To: <20230628100524.342666-1-mzamazal@redhat.com>
References: <20230628100524.342666-1-mzamazal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mzamazal@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This creates the QEMU side of the vhost-user-scmi device which connects to
the remote daemon.  It is based on code of similar vhost-user devices.

Signed-off-by: Milan Zamazal <mzamazal@redhat.com>
---
 MAINTAINERS                         |   6 +
 hw/virtio/Kconfig                   |   5 +
 hw/virtio/meson.build               |   1 +
 hw/virtio/vhost-user-scmi.c         | 306 ++++++++++++++++++++++++++++
 include/hw/virtio/vhost-user-scmi.h |  30 +++
 5 files changed, 348 insertions(+)
 create mode 100644 hw/virtio/vhost-user-scmi.c
 create mode 100644 include/hw/virtio/vhost-user-scmi.h

diff --git a/MAINTAINERS b/MAINTAINERS
index e07746ac7d..7ddb8268fe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2210,6 +2210,12 @@ F: hw/virtio/vhost-user-gpio*
 F: include/hw/virtio/vhost-user-gpio.h
 F: tests/qtest/libqos/virtio-gpio.*
 
+vhost-user-scmi
+R: mzamazal@redhat.com
+S: Supported
+F: hw/virtio/vhost-user-scmi*
+F: include/hw/virtio/vhost-user-scmi.h
+
 virtio-crypto
 M: Gonglei <arei.gonglei@huawei.com>
 S: Supported
diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
index de7a35429a..a9ee09062f 100644
--- a/hw/virtio/Kconfig
+++ b/hw/virtio/Kconfig
@@ -96,3 +96,8 @@ config VHOST_VDPA_DEV
     bool
     default y
     depends on VIRTIO && VHOST_VDPA && LINUX
+
+config VHOST_USER_SCMI
+    bool
+    default y
+    depends on VIRTIO && VHOST_USER
diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index f32b22f61b..4a4d7e1c27 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -35,6 +35,7 @@ specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_I2C', if_true: files('vhost-user
 specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_RNG', if_true: files('vhost-user-rng.c'))
 specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_GPIO', if_true: files('vhost-user-gpio.c'))
 specific_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_GPIO'], if_true: files('vhost-user-gpio-pci.c'))
+specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_SCMI', if_true: files('vhost-user-scmi.c'))
 
 virtio_pci_ss = ss.source_set()
 virtio_pci_ss.add(when: 'CONFIG_VHOST_VSOCK', if_true: files('vhost-vsock-pci.c'))
diff --git a/hw/virtio/vhost-user-scmi.c b/hw/virtio/vhost-user-scmi.c
new file mode 100644
index 0000000000..d386fb2df9
--- /dev/null
+++ b/hw/virtio/vhost-user-scmi.c
@@ -0,0 +1,306 @@
+/*
+ * Vhost-user SCMI virtio device
+ *
+ * SPDX-FileCopyrightText: Red Hat, Inc.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Implementation based on other vhost-user devices in QEMU.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "hw/virtio/virtio-bus.h"
+#include "hw/virtio/vhost-user-scmi.h"
+#include "standard-headers/linux/virtio_ids.h"
+#include "standard-headers/linux/virtio_scmi.h"
+#include "trace.h"
+
+/*
+ * In this version, we don't support VIRTIO_SCMI_F_SHARED_MEMORY.
+ * Note that VIRTIO_SCMI_F_SHARED_MEMORY is currently not supported in
+ * Linux VirtIO SCMI guest driver.
+ */
+static const int feature_bits[] = {
+    VIRTIO_F_VERSION_1,
+    VIRTIO_F_NOTIFY_ON_EMPTY,
+    VIRTIO_RING_F_INDIRECT_DESC,
+    VIRTIO_RING_F_EVENT_IDX,
+    VIRTIO_F_RING_RESET,
+    VIRTIO_SCMI_F_P2A_CHANNELS,
+    VHOST_INVALID_FEATURE_BIT
+};
+
+static int vu_scmi_start(VirtIODevice *vdev)
+{
+    VHostUserSCMI *scmi = VHOST_USER_SCMI(vdev);
+    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
+    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
+    struct vhost_dev *vhost_dev = &scmi->vhost_dev;
+    int ret, i;
+
+    if (!k->set_guest_notifiers) {
+        error_report("binding does not support guest notifiers");
+        return -ENOSYS;
+    }
+
+    ret = vhost_dev_enable_notifiers(vhost_dev, vdev);
+    if (ret < 0) {
+        error_report("Error enabling host notifiers: %d", ret);
+        return ret;
+    }
+
+    ret = k->set_guest_notifiers(qbus->parent, vhost_dev->nvqs, true);
+    if (ret < 0) {
+        error_report("Error binding guest notifier: %d", ret);
+        goto err_host_notifiers;
+    }
+
+    vhost_ack_features(&scmi->vhost_dev, feature_bits, vdev->guest_features);
+
+    ret = vhost_dev_start(&scmi->vhost_dev, vdev, true);
+    if (ret < 0) {
+        error_report("Error starting vhost-user-scmi: %d", ret);
+        goto err_guest_notifiers;
+    }
+
+    /*
+     * guest_notifier_mask/pending not used yet, so just unmask
+     * everything here. virtio-pci will do the right thing by
+     * enabling/disabling irqfd.
+     */
+    for (i = 0; i < scmi->vhost_dev.nvqs; i++) {
+        vhost_virtqueue_mask(&scmi->vhost_dev, vdev, i, false);
+    }
+    return 0;
+
+err_guest_notifiers:
+    k->set_guest_notifiers(qbus->parent, vhost_dev->nvqs, false);
+err_host_notifiers:
+    vhost_dev_disable_notifiers(vhost_dev, vdev);
+
+    return ret;
+}
+
+static void vu_scmi_stop(VirtIODevice *vdev)
+{
+    VHostUserSCMI *scmi = VHOST_USER_SCMI(vdev);
+    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
+    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
+    struct vhost_dev *vhost_dev = &scmi->vhost_dev;
+    int ret;
+
+    if (!k->set_guest_notifiers) {
+        return;
+    }
+
+    vhost_dev_stop(vhost_dev, vdev, true);
+
+    ret = k->set_guest_notifiers(qbus->parent, vhost_dev->nvqs, false);
+    if (ret < 0) {
+        error_report("vhost guest notifier cleanup failed: %d", ret);
+        return;
+    }
+    vhost_dev_disable_notifiers(vhost_dev, vdev);
+}
+
+static void vu_scmi_set_status(VirtIODevice *vdev, uint8_t status)
+{
+    VHostUserSCMI *scmi = VHOST_USER_SCMI(vdev);
+    bool should_start = virtio_device_should_start(vdev, status);
+
+    if (!scmi->connected) {
+        return;
+    }
+    if (vhost_dev_is_started(&scmi->vhost_dev) == should_start) {
+        return;
+    }
+
+    if (should_start) {
+        vu_scmi_start(vdev);
+    } else {
+        vu_scmi_stop(vdev);
+    }
+}
+
+static uint64_t vu_scmi_get_features(VirtIODevice *vdev, uint64_t features,
+                                     Error **errp)
+{
+    VHostUserSCMI *scmi = VHOST_USER_SCMI(vdev);
+
+    return vhost_get_features(&scmi->vhost_dev, feature_bits, features);
+}
+
+static void vu_scmi_handle_output(VirtIODevice *vdev, VirtQueue *vq)
+{
+    /*
+     * Not normally called; it's the daemon that handles the queue;
+     * however virtio's cleanup path can call this.
+     */
+}
+
+static void vu_scmi_guest_notifier_mask(VirtIODevice *vdev, int idx, bool mask)
+{
+    VHostUserSCMI *scmi = VHOST_USER_SCMI(vdev);
+
+    if (idx == VIRTIO_CONFIG_IRQ_IDX) {
+        return;
+    }
+
+    vhost_virtqueue_mask(&scmi->vhost_dev, vdev, idx, mask);
+}
+
+static bool vu_scmi_guest_notifier_pending(VirtIODevice *vdev, int idx)
+{
+    VHostUserSCMI *scmi = VHOST_USER_SCMI(vdev);
+
+    return vhost_virtqueue_pending(&scmi->vhost_dev, idx);
+}
+
+static void vu_scmi_connect(DeviceState *dev)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VHostUserSCMI *scmi = VHOST_USER_SCMI(vdev);
+
+    if (scmi->connected) {
+        return;
+    }
+    scmi->connected = true;
+
+    /* restore vhost state */
+    if (virtio_device_started(vdev, vdev->status)) {
+        vu_scmi_start(vdev);
+    }
+}
+
+static void vu_scmi_disconnect(DeviceState *dev)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VHostUserSCMI *scmi = VHOST_USER_SCMI(vdev);
+
+    if (!scmi->connected) {
+        return;
+    }
+    scmi->connected = false;
+
+    if (vhost_dev_is_started(&scmi->vhost_dev)) {
+        vu_scmi_stop(vdev);
+    }
+}
+
+static void vu_scmi_event(void *opaque, QEMUChrEvent event)
+{
+    DeviceState *dev = opaque;
+
+    switch (event) {
+    case CHR_EVENT_OPENED:
+        vu_scmi_connect(dev);
+        break;
+    case CHR_EVENT_CLOSED:
+        vu_scmi_disconnect(dev);
+        break;
+    case CHR_EVENT_BREAK:
+    case CHR_EVENT_MUX_IN:
+    case CHR_EVENT_MUX_OUT:
+        /* Ignore */
+        break;
+    }
+}
+
+static void do_vhost_user_cleanup(VirtIODevice *vdev, VHostUserSCMI *scmi)
+{
+    virtio_delete_queue(scmi->cmd_vq);
+    virtio_delete_queue(scmi->event_vq);
+    g_free(scmi->vhost_dev.vqs);
+    virtio_cleanup(vdev);
+    vhost_user_cleanup(&scmi->vhost_user);
+}
+
+static void vu_scmi_device_realize(DeviceState *dev, Error **errp)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VHostUserSCMI *scmi = VHOST_USER_SCMI(dev);
+    int ret;
+
+    if (!scmi->chardev.chr) {
+        error_setg(errp, "vhost-user-scmi: chardev is mandatory");
+        return;
+    }
+
+    vdev->host_features |= (1ULL << VIRTIO_SCMI_F_P2A_CHANNELS);
+
+    if (!vhost_user_init(&scmi->vhost_user, &scmi->chardev, errp)) {
+        return;
+    }
+
+    virtio_init(vdev, VIRTIO_ID_SCMI, 0);
+
+    scmi->cmd_vq = virtio_add_queue(vdev, 256, vu_scmi_handle_output);
+    scmi->event_vq = virtio_add_queue(vdev, 256, vu_scmi_handle_output);
+    scmi->vhost_dev.nvqs = 2;
+    scmi->vhost_dev.vqs = g_new0(struct vhost_virtqueue, scmi->vhost_dev.nvqs);
+
+    ret = vhost_dev_init(&scmi->vhost_dev, &scmi->vhost_user,
+                         VHOST_BACKEND_TYPE_USER, 0, errp);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret,
+                         "vhost-user-scmi: vhost_dev_init() failed");
+        do_vhost_user_cleanup(vdev, scmi);
+        return;
+    }
+
+    qemu_chr_fe_set_handlers(&scmi->chardev, NULL, NULL, vu_scmi_event, NULL,
+                             dev, NULL, true);
+
+    return;
+}
+
+static void vu_scmi_device_unrealize(DeviceState *dev)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VHostUserSCMI *scmi = VHOST_USER_SCMI(dev);
+
+    vu_scmi_set_status(vdev, 0);
+    vhost_dev_cleanup(&scmi->vhost_dev);
+    do_vhost_user_cleanup(vdev, scmi);
+}
+
+static const VMStateDescription vu_scmi_vmstate = {
+    .name = "vhost-user-scmi",
+    .unmigratable = 1,
+};
+
+static Property vu_scmi_properties[] = {
+    DEFINE_PROP_CHR("chardev", VHostUserSCMI, chardev),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void vu_scmi_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
+
+    device_class_set_props(dc, vu_scmi_properties);
+    dc->vmsd = &vu_scmi_vmstate;
+    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
+    vdc->realize = vu_scmi_device_realize;
+    vdc->unrealize = vu_scmi_device_unrealize;
+    vdc->get_features = vu_scmi_get_features;
+    vdc->set_status = vu_scmi_set_status;
+    vdc->guest_notifier_mask = vu_scmi_guest_notifier_mask;
+    vdc->guest_notifier_pending = vu_scmi_guest_notifier_pending;
+}
+
+static const TypeInfo vu_scmi_info = {
+    .name = TYPE_VHOST_USER_SCMI,
+    .parent = TYPE_VIRTIO_DEVICE,
+    .instance_size = sizeof(VHostUserSCMI),
+    .class_init = vu_scmi_class_init,
+};
+
+static void vu_scmi_register_types(void)
+{
+    type_register_static(&vu_scmi_info);
+}
+
+type_init(vu_scmi_register_types)
diff --git a/include/hw/virtio/vhost-user-scmi.h b/include/hw/virtio/vhost-user-scmi.h
new file mode 100644
index 0000000000..6175a74ebd
--- /dev/null
+++ b/include/hw/virtio/vhost-user-scmi.h
@@ -0,0 +1,30 @@
+/*
+ * Vhost-user SCMI virtio device
+ *
+ * Copyright (c) 2023 Red Hat, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef _QEMU_VHOST_USER_SCMI_H
+#define _QEMU_VHOST_USER_SCMI_H
+
+#include "hw/virtio/virtio.h"
+#include "hw/virtio/vhost.h"
+#include "hw/virtio/vhost-user.h"
+
+#define TYPE_VHOST_USER_SCMI "vhost-user-scmi"
+OBJECT_DECLARE_SIMPLE_TYPE(VHostUserSCMI, VHOST_USER_SCMI);
+
+struct VHostUserSCMI {
+    VirtIODevice parent;
+    CharBackend chardev;
+    struct vhost_virtqueue *vhost_vqs;
+    struct vhost_dev vhost_dev;
+    VhostUserState vhost_user;
+    VirtQueue *cmd_vq;
+    VirtQueue *event_vq;
+    bool connected;
+};
+
+#endif /* _QEMU_VHOST_USER_SCMI_H */
-- 
2.40.1


