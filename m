Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FF77E47C2
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 19:04:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0QPg-00085r-8e; Tue, 07 Nov 2023 13:02:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0QPd-00085R-Dm
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:02:53 -0500
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0QPZ-0000da-JO
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:02:53 -0500
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-50797cf5b69so7874938e87.2
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 10:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699380168; x=1699984968; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U/L+/R9I1yfBj6o+8eLRddAUSD5NHpc8+ptyW7v8dOM=;
 b=Enzlx+zxphe+p9wnHdhmu82jpbRd7DL6EEwOr15t621uZB696gPoM/iXUDrLp/VemL
 qBkxPp3ANPflOPCAObqF4LjbKMcQA1schPFR7takHi8rsnOM0DSrPjHcZJgcB+ORMZUq
 RRQJcvZAD9a4SVRG567gPFgCaDGeDQH7TbUvpAgw1VQcPMO5TDv2nIpHWmZRYjU//kn0
 vuWiMkM2T9NeRpa4knimYLdLHq1Jy8jqczZ+9dzgHkXoRy5CQe+ICKjv3Ak7aDyhIBsU
 0Z92acqZRFXUyc1RHs4cWkepLZaZchLZfneeakdxyZ11Z7p5iWfAUZM84i5AcwmTgwPE
 krqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699380168; x=1699984968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U/L+/R9I1yfBj6o+8eLRddAUSD5NHpc8+ptyW7v8dOM=;
 b=iyqWGdnzmuFbVPGj1s8s9WEePFwmTq05uylJCO+LyQjqhym0DqhxaP/4hrbjd3q3oi
 Muc5q2U0+rYg394p+ot4KFOqNunA9Aw+k7k12d7y7vSKKqvEuW2kJ54nzFEpHw3y2oAm
 7lp83KcQ7/ZFuXhQ9uXHRY/0yfvhdh7KaYq7lt8n89Cw7FL2uXISoDmz8fPlQpql5bmE
 IThrnHj/TCUmSprUHFPx9gr6U6JTdYbYaYOMkeYA84vvV8/rul19ks0kYExYmvsS+nIC
 4EvZbFvMh73eAA/xy1g95r/XNKRDBdALDuwmUUxzi02I2uUHFA4HsY8HykcaFfjqPwkz
 tq2A==
X-Gm-Message-State: AOJu0YxwFnt2XHGZCekn1ej1SkWuo5Fwi+dxDnxSrgoVNaAucrYGUOp0
 XMJtiB/Tp9/B08OuV2DpawXTHg==
X-Google-Smtp-Source: AGHT+IGJzK6kCaqETKZg6ljDg4YNZtg8+FRZ7JaB1vADuvX/YhL5QrA9em6/5p/gXxMInjAhNSUNFA==
X-Received: by 2002:a05:6512:21c2:b0:507:a9e1:5a3b with SMTP id
 d2-20020a05651221c200b00507a9e15a3bmr22595107lft.0.1699380167772; 
 Tue, 07 Nov 2023 10:02:47 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 k25-20020a05600c1c9900b004067e905f44sm16760409wms.9.2023.11.07.10.02.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 10:02:47 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C00476572D;
 Tue,  7 Nov 2023 18:02:46 +0000 (GMT)
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
Subject: [PATCH v7 1/7] virtio: split into vhost-user-base and
 vhost-user-device
Date: Tue,  7 Nov 2023 18:02:40 +0000
Message-Id: <20231107180246.3456598-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231107180246.3456598-1-alex.bennee@linaro.org>
References: <20231107180246.3456598-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12b.google.com
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

Lets keep a cleaner split between the base class and the derived
vhost-user-device which we can use for generic vhost-user stubs. This
includes an update to introduce the vq_size property so the number of
entries in a virtq can be defined.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v5
  - s/parent/parent_obj/
  - remove left over vhost-user-device.h
  - use DEFINE_TYPES
v6
  - rebase and set .abstract = true for vhost-user-device
v7
  - checkpatch line length + MAINTAINERS
  - s/abstract = true/dc->user_creatable = false/ for both mmio and pci
---
 MAINTAINERS                                   |   6 +
 ...{vhost-user-device.h => vhost-user-base.h} |  21 +-
 hw/virtio/vhost-user-base.c                   | 346 ++++++++++++++++++
 hw/virtio/vhost-user-device-pci.c             |  13 +-
 hw/virtio/vhost-user-device.c                 | 338 +----------------
 hw/virtio/meson.build                         |   1 +
 6 files changed, 383 insertions(+), 342 deletions(-)
 rename include/hw/virtio/{vhost-user-device.h => vhost-user-base.h} (71%)
 create mode 100644 hw/virtio/vhost-user-base.c

diff --git a/MAINTAINERS b/MAINTAINERS
index b86ea7f75a..2ff908d039 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2263,6 +2263,12 @@ F: include/sysemu/rng*.h
 F: backends/rng*.c
 F: tests/qtest/virtio-rng-test.c
 
+vhost-user-stubs
+M: Alex Bennée <alex.bennee@linaro.org>
+S: Maintained
+F: hw/virtio/vhost-user-base.c
+F: hw/virtio/vhost-user-device*
+
 vhost-user-rng
 M: Mathieu Poirier <mathieu.poirier@linaro.org>
 S: Supported
diff --git a/include/hw/virtio/vhost-user-device.h b/include/hw/virtio/vhost-user-base.h
similarity index 71%
rename from include/hw/virtio/vhost-user-device.h
rename to include/hw/virtio/vhost-user-base.h
index 3ddf88a146..51d0968b89 100644
--- a/include/hw/virtio/vhost-user-device.h
+++ b/include/hw/virtio/vhost-user-base.h
@@ -6,8 +6,8 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
-#ifndef QEMU_VHOST_USER_DEVICE_H
-#define QEMU_VHOST_USER_DEVICE_H
+#ifndef QEMU_VHOST_USER_BASE_H
+#define QEMU_VHOST_USER_BASE_H
 
 #include "hw/virtio/vhost.h"
 #include "hw/virtio/vhost-user.h"
@@ -17,11 +17,13 @@
 OBJECT_DECLARE_TYPE(VHostUserBase, VHostUserBaseClass, VHOST_USER_BASE)
 
 struct VHostUserBase {
-    VirtIODevice parent;
+    VirtIODevice parent_obj;
+
     /* Properties */
     CharBackend chardev;
     uint16_t virtio_id;
     uint32_t num_vqs;
+    uint32_t vq_size; /* can't exceed VIRTIO_QUEUE_MAX */
     uint32_t config_size;
     /* State tracking */
     VhostUserState vhost_user;
@@ -31,16 +33,17 @@ struct VHostUserBase {
     bool connected;
 };
 
-    /* needed so we can use the base realize after specialisation
-       tweaks */
+/*
+ * Needed so we can use the base realize after specialisation
+ * tweaks
+ */
 struct VHostUserBaseClass {
-    /*< private >*/
     VirtioDeviceClass parent_class;
-    /*< public >*/
+
     DeviceRealize parent_realize;
 };
 
-/* shared for the benefit of the derived pci class */
+
 #define TYPE_VHOST_USER_DEVICE "vhost-user-device"
 
-#endif /* QEMU_VHOST_USER_DEVICE_H */
+#endif /* QEMU_VHOST_USER_BASE_H */
diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
new file mode 100644
index 0000000000..620fa5cb4a
--- /dev/null
+++ b/hw/virtio/vhost-user-base.c
@@ -0,0 +1,346 @@
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
+                        virtio_add_queue(vdev, vub->vq_size,
+                                         vub_handle_output));
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
+static const TypeInfo vub_types[] = {
+    {
+        .name = TYPE_VHOST_USER_BASE,
+        .parent = TYPE_VIRTIO_DEVICE,
+        .instance_size = sizeof(VHostUserBase),
+        .class_init = vub_class_init,
+        .class_size = sizeof(VHostUserBaseClass),
+        .abstract = true
+    }
+};
+
+DEFINE_TYPES(vub_types)
diff --git a/hw/virtio/vhost-user-device-pci.c b/hw/virtio/vhost-user-device-pci.c
index 41f9b7905b..efaf55d3dd 100644
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
@@ -39,6 +36,10 @@ static void vhost_user_device_pci_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
     PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
+
+    /* Reason: stop users confusing themselves */
+    dc->user_creatable = false;
+
     k->realize = vhost_user_device_pci_realize;
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
     pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
diff --git a/hw/virtio/vhost-user-device.c b/hw/virtio/vhost-user-device.c
index 2b028cae08..67aa934710 100644
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
@@ -358,6 +42,9 @@ static void vud_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
+    /* Reason: stop inexperienced users confusing themselves */
+    dc->user_creatable = false;
+
     device_class_set_props(dc, vud_properties);
     dc->vmsd = &vud_vmstate;
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
@@ -366,14 +53,11 @@ static void vud_class_init(ObjectClass *klass, void *data)
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


