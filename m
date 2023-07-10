Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9419774E1F5
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 01:09:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzuK-0003ZD-Fa; Mon, 10 Jul 2023 19:03:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzuI-0003RX-6V
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:03:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzuA-000498-Rd
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:03:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689030174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MzgY2YQ6D5tMY/mE621QwwjCaplHfEWxVWzGlVYyn5w=;
 b=JAPbkF4BcujVgJWz+agyrhGJk9R8Fe7OaQP/mqey4wCyX8FARmnXmbNAiSENc4BO3w1KEV
 q4VKhvkMkqvFY2u0wlJYhlUUB2Qy01brrZRDxxPgt5tB/4D9IE4jPLAiNwjEWF7DgOUQrn
 bTi3BeNFHKKeCkdbhjgDyaK+nip9Gg0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-lXFfgUZLNvus971uwOsxUA-1; Mon, 10 Jul 2023 19:02:53 -0400
X-MC-Unique: lXFfgUZLNvus971uwOsxUA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fa8cd898e0so34200825e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 16:02:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689030171; x=1691622171;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MzgY2YQ6D5tMY/mE621QwwjCaplHfEWxVWzGlVYyn5w=;
 b=YRGOgMDoRS3G1+7SS+aOmgdOcEQQqfRQTWEN+0hoZtIeyfY4WOID9tlleph0GQwKlj
 6H28WjqGqJmDh8y5IBxDMFfe8oKuUFjrGaxSb02Z/bGBwx6IcmeKELXKC5ARRMIeDPYY
 1RsHm4C0P6gtPm+Oz6DuSKVVT2cgkr1OTE0i09AbekwAHBgP148rz8DLKeITDnNsqhtn
 UjuiGwScHH3WxpuUvWfSf5ARR1trLJWaeXdRGWSzQxgmAj0NeFW+UBMSQGGIj7Am7K5R
 rH3Zq/TcHj7EHH05x601Cb+ZsSGCVsD1K/V7FltFmwaXCUZCEEKccjGj+Q9aga1tU5x+
 6KbA==
X-Gm-Message-State: ABy/qLbfroIGMK28AIM7y2xlZ45IdZTjvEHyEHHZuwdMZSwX66YqMGdF
 1YVnx6hlcQKh928AnuSmyOF8aXJC9C72DTNiUSNqbu8xej4NbsOKO8dvbT0bSIGuRyDh5dCJ3wl
 Ngl2Jii37xM9uk67N3B4V3BR/oc9Nqwhjs/MAwZQukHwINXiZR6KCttxn1ddUx+7uoFJe
X-Received: by 2002:a1c:7505:0:b0:3f9:846:d892 with SMTP id
 o5-20020a1c7505000000b003f90846d892mr13357815wmc.9.1689030171251; 
 Mon, 10 Jul 2023 16:02:51 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGo98k6FF772kTLtyapMoRsF8Nl2piqOg9JSgEXH3ipBU9CaOgU9w47nNDpdRkcdG9Om0XxRA==
X-Received: by 2002:a1c:7505:0:b0:3f9:846:d892 with SMTP id
 o5-20020a1c7505000000b003f90846d892mr13357800wmc.9.1689030170917; 
 Mon, 10 Jul 2023 16:02:50 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 o6-20020adfeac6000000b00314145e6d61sm612554wrn.6.2023.07.10.16.02.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 16:02:50 -0700 (PDT)
Date: Mon, 10 Jul 2023 19:02:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Milan Zamazal <mzamazal@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 08/66] hw/virtio: Add boilerplate for vhost-user-scmi device
Message-ID: <a5dab090e1425929a1a5a3034768cb33dab69bf4.1689030052.git.mst@redhat.com>
References: <cover.1689030052.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1689030052.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Milan Zamazal <mzamazal@redhat.com>

This creates the QEMU side of the vhost-user-scmi device which connects to
the remote daemon.  It is based on code of similar vhost-user devices.

Signed-off-by: Milan Zamazal <mzamazal@redhat.com>
Message-Id: <20230628100524.342666-2-mzamazal@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/vhost-user-scmi.h |  30 +++
 hw/virtio/vhost-user-scmi.c         | 306 ++++++++++++++++++++++++++++
 MAINTAINERS                         |   6 +
 hw/virtio/Kconfig                   |   5 +
 hw/virtio/meson.build               |   1 +
 5 files changed, 348 insertions(+)
 create mode 100644 include/hw/virtio/vhost-user-scmi.h
 create mode 100644 hw/virtio/vhost-user-scmi.c

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
diff --git a/MAINTAINERS b/MAINTAINERS
index 1817cfc62f..504dddb7dd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2217,6 +2217,12 @@ F: hw/virtio/vhost-user-gpio*
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
-- 
MST


