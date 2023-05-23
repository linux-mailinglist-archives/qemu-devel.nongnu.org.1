Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F62716FB4
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 23:29:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q46ss-0004OG-7t; Tue, 30 May 2023 17:28:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mzamazal@redhat.com>)
 id 1q45eP-0005Gw-7F
 for qemu-devel@nongnu.org; Tue, 30 May 2023 16:09:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mzamazal@redhat.com>)
 id 1q45eJ-0008PK-Eh
 for qemu-devel@nongnu.org; Tue, 30 May 2023 16:09:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685477334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wYEicFXBq89pEXm0o82iac+c7i14XLlx4VHXnpqIxKo=;
 b=gyM2nrZFOGuT6F/s1vJn9rLp6qiXevjtmsyCWHq4joXvxQaGd0H+YgOPz7T7oiED9+7rbF
 1F7DHk8QLJijBjhL0PBrcNHaGEZ4e9uxRI/oPDzc63ZlSsNnbcguNjhG2oEkKr/HBzXgtn
 M+uK4sgbi6/4LJ8Wly3hfjmAaiRzyFk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-Aeev7evnOPG-tWhlkukAyQ-1; Tue, 30 May 2023 16:07:44 -0400
X-MC-Unique: Aeev7evnOPG-tWhlkukAyQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-96fd6bd135dso539408366b.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 13:07:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685477263; x=1688069263;
 h=mime-version:user-agent:message-id:references:date:in-reply-to
 :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wYEicFXBq89pEXm0o82iac+c7i14XLlx4VHXnpqIxKo=;
 b=OscWIeFTDL9ALBYeR4UacNHPWFV76mZtHN6m8oudmPn0iBNkJxOKEQuKdxWfgFSpS9
 MBdXdXNW4lz6eLWsqeKEmZgAXExKmkvI9yQFg5Jm7kkM8+vz89LqxSYP+BAXprxSTpw6
 Fd8iVuPLDPDes0wJMi05K3at/XSDGdnIoCZrVFpfFHORkE1vCJl18mE6B0sG0DR22Xq3
 3rj7QZeQXdLPQk5V7tBC8lJcw+GX+g/lBDJHaOGjLx+m/yhvrRjNvDzxMmO+Nj5MhjE1
 P0IFnZEObc8+4caahWi1GaxZBGjj0NzZsP0GH2k+rxSeMH13u+P6pQdKyf9CX8nRbJmo
 L5Cg==
X-Gm-Message-State: AC+VfDxvoXffWkQZj0CIUEiRHj9QKCSbGNNJLaSDcv15c2Wm+Y14QUYb
 N/7jxYHWElEU0RfVU7DhLSaGE469jyKccVuTs/0GgU+uoOYFSixRaIOdLIPwE7M5V6aZ1gNPTWC
 nhgyIHzV7Na/XHpc=
X-Received: by 2002:a17:907:72c2:b0:974:2100:a2be with SMTP id
 du2-20020a17090772c200b009742100a2bemr3202461ejc.7.1685477263243; 
 Tue, 30 May 2023 13:07:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5zbV8+W9mmheIVZJtMy/qUgHhx1UF2fpRS/liWLPRetI6Vq8IiivCl76Fqi1kyp1NeVnAQBg==
X-Received: by 2002:a17:907:72c2:b0:974:2100:a2be with SMTP id
 du2-20020a17090772c200b009742100a2bemr3202445ejc.7.1685477262933; 
 Tue, 30 May 2023 13:07:42 -0700 (PDT)
Received: from nuthatch (ip-77-48-47-2.net.vodafone.cz. [77.48.47.2])
 by smtp.gmail.com with ESMTPSA id
 j23-20020a17090643d700b0095850aef138sm7789623ejn.6.2023.05.30.13.07.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 13:07:42 -0700 (PDT)
From: Milan Zamazal <mzamazal@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com,
    stefanha@redhat.com,
    alex.bennee@linaro.org
Subject: [PATCH 1/4] hw/virtio: Add boilerplate for vhost-user-scmi device
In-Reply-To: <cover.1685476786.git.mzamazal@redhat.com>
Date: Tue, 23 May 2023 10:02:11 +0200
References: <cover.1685476786.git.mzamazal@redhat.com>
Message-Id: <7d73441dab998ebe99d78f8f47293bc8ad27f061.1685476786.git.mzamazal@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mzamazal@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 17
X-Spam_score: 1.7
X-Spam_bar: +
X-Spam_report: (1.7 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIM_INVALID=0.1, DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 30 May 2023 17:28:00 -0400
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
index 4b025a7b63..1ce2f3dabe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2202,6 +2202,12 @@ F: hw/virtio/vhost-user-gpio*
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
index 89e9e426d8..2515d4ff68 100644
--- a/hw/virtio/Kconfig
+++ b/hw/virtio/Kconfig
@@ -90,3 +90,8 @@ config VHOST_VDPA_DEV
     bool
     default y
     depends on VIRTIO && VHOST_VDPA && LINUX
+
+config VHOST_USER_SCMI
+    bool
+    default y
+    depends on VIRTIO && VHOST_USER
diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index bdec78bfc6..c3eeb23942 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -32,6 +32,7 @@ specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_I2C', if_true: files('vhost-user
 specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_RNG', if_true: files('vhost-user-rng.c'))
 specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_GPIO', if_true: files('vhost-user-gpio.c'))
 specific_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_GPIO'], if_true: files('vhost-user-gpio-pci.c'))
+specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_SCMI', if_true: files('vhost-user-scmi.c'))
 specific_virtio_ss.add(when: 'CONFIG_VHOST_VDPA_DEV', if_true: files('vdpa-dev.c'))
 
 virtio_pci_ss = ss.source_set()
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
2.38.5


