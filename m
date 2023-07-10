Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2351A74E1E6
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 01:08:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzuK-0003YI-6b; Mon, 10 Jul 2023 19:03:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzuI-0003Re-84
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:03:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzuG-0004A0-6P
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:03:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689030179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nqd/Fy8W0/ZAKxo97suoRR5PKde+OrdOQHeLimuza+w=;
 b=EUZMjUw8XiOReZIC296qN/Y/QQaBjVmqpYejvQm3RsGxhczClLVs714+VeokUxWt1vdSyu
 UtrRO/j40Tbo3yxx7h2SNAMTZdkBEsSjYUOGvGmYhkOiJ3Ma0Jyd7pPM4O+yF/4hqgT6cu
 CxGteB1MqbW1ZUgoHyvylRT4TN4o60o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-AWO9IX7PNq-oyR6LpGCJSw-1; Mon, 10 Jul 2023 19:02:58 -0400
X-MC-Unique: AWO9IX7PNq-oyR6LpGCJSw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f5fa06debcso34382805e9.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 16:02:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689030176; x=1691622176;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nqd/Fy8W0/ZAKxo97suoRR5PKde+OrdOQHeLimuza+w=;
 b=EkZnQKyRlqZ9TmSaBg4971fQgyG0OVusLLMesLdue5LcT///DJLhxxS07wFGzKP2Fp
 BTlSVBN0UJvosCB9twkqTzJHKW2VxLhHXpddgZI0jw3CyEKTnN++pC8CF7X7aaagafdX
 Jgadwoa06jcJ5aor94R/vp0K9mGi+W41tgrh8scEC9SU+OsJQiPdNwskXhtG4XP+8KrU
 vUQxVRakG3XtBz6s5l0knviSfxLeMXDBYgbIaZUDJsFAJcc5g7dVuSNG1uvKQM+kb5bL
 d1R69kad2o3ninA9tuilq7LwMNd/RHek9ZnjC94GLcLUdNocPxjIrS0o/ZypKTI9xHFT
 Ttig==
X-Gm-Message-State: ABy/qLbkyqLoqLRzs8/Rxv6dhaQhE5gyyfv0pW0AK+rrxGWeWc+vn5OK
 TgXg2aj6NQ9nvzRwZwy9dMxZ0wAIQIqRFmcy4Sz5xleN0ikGapCDIoIFJ2jG22OSYy4QXX3kQk4
 z2LP4hW9DTDjwdpRnKBn42eRh413qRwbDuagGksJVqU7ItF8el2ebjllq+1/9MZiV2Goq
X-Received: by 2002:a1c:ed14:0:b0:3fb:cf8e:c934 with SMTP id
 l20-20020a1ced14000000b003fbcf8ec934mr13961604wmh.27.1689030176704; 
 Mon, 10 Jul 2023 16:02:56 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHEC4j3aFf9friRFInab0Cw4b6VVlb2bNSP4JAQNOapiNOsZAzyJ1sz/fz4EZvngeb+P3TL8A==
X-Received: by 2002:a1c:ed14:0:b0:3fb:cf8e:c934 with SMTP id
 l20-20020a1ced14000000b003fbcf8ec934mr13961590wmh.27.1689030176397; 
 Mon, 10 Jul 2023 16:02:56 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 hn32-20020a05600ca3a000b003fbdd5d0758sm939466wmb.22.2023.07.10.16.02.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 16:02:55 -0700 (PDT)
Date: Mon, 10 Jul 2023 19:02:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Milan Zamazal <mzamazal@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 10/66] tests/qtest: enable tests for virtio-scmi
Message-ID: <b6f53ae005a1c05034769beebf799e861b82d48a.1689030052.git.mst@redhat.com>
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

We don't have a virtio-scmi implementation in QEMU and only support a
vhost-user backend.  This is very similar to virtio-gpio and we add the same
set of tests, just passing some vhost-user messages over the control socket.

Signed-off-by: Milan Zamazal <mzamazal@redhat.com>
Acked-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20230628100524.342666-4-mzamazal@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/libqos/virtio-scmi.h |  34 ++++++
 tests/qtest/libqos/virtio-scmi.c | 174 +++++++++++++++++++++++++++++++
 tests/qtest/vhost-user-test.c    |  44 ++++++++
 MAINTAINERS                      |   1 +
 tests/qtest/libqos/meson.build   |   1 +
 5 files changed, 254 insertions(+)
 create mode 100644 tests/qtest/libqos/virtio-scmi.h
 create mode 100644 tests/qtest/libqos/virtio-scmi.c

diff --git a/tests/qtest/libqos/virtio-scmi.h b/tests/qtest/libqos/virtio-scmi.h
new file mode 100644
index 0000000000..cb5670da6e
--- /dev/null
+++ b/tests/qtest/libqos/virtio-scmi.h
@@ -0,0 +1,34 @@
+/*
+ * virtio-scmi structures
+ *
+ * SPDX-FileCopyrightText: Red Hat, Inc.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef TESTS_LIBQOS_VIRTIO_SCMI_H
+#define TESTS_LIBQOS_VIRTIO_SCMI_H
+
+#include "qgraph.h"
+#include "virtio.h"
+#include "virtio-pci.h"
+
+typedef struct QVhostUserSCMI QVhostUserSCMI;
+typedef struct QVhostUserSCMIPCI QVhostUserSCMIPCI;
+typedef struct QVhostUserSCMIDevice QVhostUserSCMIDevice;
+
+struct QVhostUserSCMI {
+    QVirtioDevice *vdev;
+    QVirtQueue **queues;
+};
+
+struct QVhostUserSCMIPCI {
+    QVirtioPCIDevice pci_vdev;
+    QVhostUserSCMI scmi;
+};
+
+struct QVhostUserSCMIDevice {
+    QOSGraphObject obj;
+    QVhostUserSCMI scmi;
+};
+
+#endif
diff --git a/tests/qtest/libqos/virtio-scmi.c b/tests/qtest/libqos/virtio-scmi.c
new file mode 100644
index 0000000000..ce8f4d5c06
--- /dev/null
+++ b/tests/qtest/libqos/virtio-scmi.c
@@ -0,0 +1,174 @@
+/*
+ * virtio-scmi nodes for testing
+ *
+ * SPDX-FileCopyrightText: Linaro Ltd
+ * SPDX-FileCopyrightText: Red Hat, Inc.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Based on virtio-gpio.c, doing basically the same thing.
+ */
+
+#include "qemu/osdep.h"
+#include "standard-headers/linux/virtio_config.h"
+#include "../libqtest.h"
+#include "qemu/module.h"
+#include "qgraph.h"
+#include "virtio-scmi.h"
+
+static QGuestAllocator *alloc;
+
+static void virtio_scmi_cleanup(QVhostUserSCMI *scmi)
+{
+    QVirtioDevice *vdev = scmi->vdev;
+    int i;
+
+    for (i = 0; i < 2; i++) {
+        qvirtqueue_cleanup(vdev->bus, scmi->queues[i], alloc);
+    }
+    g_free(scmi->queues);
+}
+
+/*
+ * This handles the VirtIO setup from the point of view of the driver
+ * frontend and therefore doesn't present any vhost specific features
+ * and in fact masks of the re-used bit.
+ */
+static void virtio_scmi_setup(QVhostUserSCMI *scmi)
+{
+    QVirtioDevice *vdev = scmi->vdev;
+    uint64_t features;
+    int i;
+
+    features = qvirtio_get_features(vdev);
+    features &= ~QVIRTIO_F_BAD_FEATURE;
+    qvirtio_set_features(vdev, features);
+
+    scmi->queues = g_new(QVirtQueue *, 2);
+    for (i = 0; i < 2; i++) {
+        scmi->queues[i] = qvirtqueue_setup(vdev, alloc, i);
+    }
+    qvirtio_set_driver_ok(vdev);
+}
+
+static void *qvirtio_scmi_get_driver(QVhostUserSCMI *v_scmi,
+                                     const char *interface)
+{
+    if (!g_strcmp0(interface, "vhost-user-scmi")) {
+        return v_scmi;
+    }
+    if (!g_strcmp0(interface, "virtio")) {
+        return v_scmi->vdev;
+    }
+
+    g_assert_not_reached();
+}
+
+static void *qvirtio_scmi_device_get_driver(void *object,
+                                            const char *interface)
+{
+    QVhostUserSCMIDevice *v_scmi = object;
+    return qvirtio_scmi_get_driver(&v_scmi->scmi, interface);
+}
+
+/* virtio-scmi (mmio) */
+static void qvirtio_scmi_device_destructor(QOSGraphObject *obj)
+{
+    QVhostUserSCMIDevice *scmi_dev = (QVhostUserSCMIDevice *) obj;
+    virtio_scmi_cleanup(&scmi_dev->scmi);
+}
+
+static void qvirtio_scmi_device_start_hw(QOSGraphObject *obj)
+{
+    QVhostUserSCMIDevice *scmi_dev = (QVhostUserSCMIDevice *) obj;
+    virtio_scmi_setup(&scmi_dev->scmi);
+}
+
+static void *virtio_scmi_device_create(void *virtio_dev,
+                                       QGuestAllocator *t_alloc,
+                                       void *addr)
+{
+    QVhostUserSCMIDevice *virtio_device = g_new0(QVhostUserSCMIDevice, 1);
+    QVhostUserSCMI *interface = &virtio_device->scmi;
+
+    interface->vdev = virtio_dev;
+    alloc = t_alloc;
+
+    virtio_device->obj.get_driver = qvirtio_scmi_device_get_driver;
+    virtio_device->obj.start_hw = qvirtio_scmi_device_start_hw;
+    virtio_device->obj.destructor = qvirtio_scmi_device_destructor;
+
+    return &virtio_device->obj;
+}
+
+/* virtio-scmi-pci */
+static void qvirtio_scmi_pci_destructor(QOSGraphObject *obj)
+{
+    QVhostUserSCMIPCI *scmi_pci = (QVhostUserSCMIPCI *) obj;
+    QOSGraphObject *pci_vobj =  &scmi_pci->pci_vdev.obj;
+
+    virtio_scmi_cleanup(&scmi_pci->scmi);
+    qvirtio_pci_destructor(pci_vobj);
+}
+
+static void qvirtio_scmi_pci_start_hw(QOSGraphObject *obj)
+{
+    QVhostUserSCMIPCI *scmi_pci = (QVhostUserSCMIPCI *) obj;
+    QOSGraphObject *pci_vobj =  &scmi_pci->pci_vdev.obj;
+
+    qvirtio_pci_start_hw(pci_vobj);
+    virtio_scmi_setup(&scmi_pci->scmi);
+}
+
+static void *qvirtio_scmi_pci_get_driver(void *object, const char *interface)
+{
+    QVhostUserSCMIPCI *v_scmi = object;
+
+    if (!g_strcmp0(interface, "pci-device")) {
+        return v_scmi->pci_vdev.pdev;
+    }
+    return qvirtio_scmi_get_driver(&v_scmi->scmi, interface);
+}
+
+static void *virtio_scmi_pci_create(void *pci_bus, QGuestAllocator *t_alloc,
+                                    void *addr)
+{
+    QVhostUserSCMIPCI *virtio_spci = g_new0(QVhostUserSCMIPCI, 1);
+    QVhostUserSCMI *interface = &virtio_spci->scmi;
+    QOSGraphObject *obj = &virtio_spci->pci_vdev.obj;
+
+    virtio_pci_init(&virtio_spci->pci_vdev, pci_bus, addr);
+    interface->vdev = &virtio_spci->pci_vdev.vdev;
+    alloc = t_alloc;
+
+    obj->get_driver = qvirtio_scmi_pci_get_driver;
+    obj->start_hw = qvirtio_scmi_pci_start_hw;
+    obj->destructor = qvirtio_scmi_pci_destructor;
+
+    return obj;
+}
+
+static void virtio_scmi_register_nodes(void)
+{
+    QPCIAddress addr = {
+        .devfn = QPCI_DEVFN(4, 0),
+    };
+
+    QOSGraphEdgeOptions edge_opts = { };
+
+    /* vhost-user-scmi-device */
+    edge_opts.extra_device_opts = "id=scmi,chardev=chr-vhost-user-test "
+        "-global virtio-mmio.force-legacy=false";
+    qos_node_create_driver("vhost-user-scmi-device",
+                            virtio_scmi_device_create);
+    qos_node_consumes("vhost-user-scmi-device", "virtio-bus", &edge_opts);
+    qos_node_produces("vhost-user-scmi-device", "vhost-user-scmi");
+
+    /* virtio-scmi-pci */
+    edge_opts.extra_device_opts = "id=scmi,addr=04.0,chardev=chr-vhost-user-test";
+    add_qpci_address(&edge_opts, &addr);
+    qos_node_create_driver("vhost-user-scmi-pci", virtio_scmi_pci_create);
+    qos_node_consumes("vhost-user-scmi-pci", "pci-bus", &edge_opts);
+    qos_node_produces("vhost-user-scmi-pci", "vhost-user-scmi");
+}
+
+libqos_init(virtio_scmi_register_nodes);
diff --git a/tests/qtest/vhost-user-test.c b/tests/qtest/vhost-user-test.c
index dfb8003597..d4e437265f 100644
--- a/tests/qtest/vhost-user-test.c
+++ b/tests/qtest/vhost-user-test.c
@@ -33,6 +33,7 @@
 #include "standard-headers/linux/virtio_ids.h"
 #include "standard-headers/linux/virtio_net.h"
 #include "standard-headers/linux/virtio_gpio.h"
+#include "standard-headers/linux/virtio_scmi.h"
 
 #ifdef CONFIG_LINUX
 #include <sys/vfs.h>
@@ -145,6 +146,7 @@ enum {
 enum {
     VHOST_USER_NET,
     VHOST_USER_GPIO,
+    VHOST_USER_SCMI,
 };
 
 typedef struct TestServer {
@@ -1157,3 +1159,45 @@ static void register_vhost_gpio_test(void)
                  "vhost-user-gpio", test_read_guest_mem, &opts);
 }
 libqos_init(register_vhost_gpio_test);
+
+static uint64_t vu_scmi_get_features(TestServer *s)
+{
+    return 0x1ULL << VIRTIO_F_VERSION_1 |
+        0x1ULL << VIRTIO_SCMI_F_P2A_CHANNELS |
+        0x1ULL << VHOST_USER_F_PROTOCOL_FEATURES;
+}
+
+static void vu_scmi_get_protocol_features(TestServer *s, CharBackend *chr,
+                                          VhostUserMsg *msg)
+{
+    msg->flags |= VHOST_USER_REPLY_MASK;
+    msg->size = sizeof(m.payload.u64);
+    msg->payload.u64 = 1ULL << VHOST_USER_PROTOCOL_F_MQ;
+
+    qemu_chr_fe_write_all(chr, (uint8_t *)msg, VHOST_USER_HDR_SIZE + msg->size);
+}
+
+static struct vhost_user_ops g_vu_scmi_ops = {
+    .type = VHOST_USER_SCMI,
+
+    .append_opts = append_vhost_gpio_opts,
+
+    .get_features = vu_scmi_get_features,
+    .set_features = vu_net_set_features,
+    .get_protocol_features = vu_scmi_get_protocol_features,
+};
+
+static void register_vhost_scmi_test(void)
+{
+    QOSGraphTestOptions opts = {
+        .before = vhost_user_test_setup,
+        .subprocess = true,
+        .arg = &g_vu_scmi_ops,
+    };
+
+    qemu_add_opts(&qemu_chardev_opts);
+
+    qos_add_test("scmi/read-guest-mem/memfile",
+                 "vhost-user-scmi", test_read_guest_mem, &opts);
+}
+libqos_init(register_vhost_scmi_test);
diff --git a/MAINTAINERS b/MAINTAINERS
index 504dddb7dd..8f642141d0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2222,6 +2222,7 @@ R: mzamazal@redhat.com
 S: Supported
 F: hw/virtio/vhost-user-scmi*
 F: include/hw/virtio/vhost-user-scmi.h
+F: tests/qtest/libqos/virtio-scmi.*
 
 virtio-crypto
 M: Gonglei <arei.gonglei@huawei.com>
diff --git a/tests/qtest/libqos/meson.build b/tests/qtest/libqos/meson.build
index cc209a8de5..90aae42a22 100644
--- a/tests/qtest/libqos/meson.build
+++ b/tests/qtest/libqos/meson.build
@@ -46,6 +46,7 @@ libqos_srcs = files(
         'virtio-serial.c',
         'virtio-iommu.c',
         'virtio-gpio.c',
+        'virtio-scmi.c',
         'generic-pcihost.c',
 
         # qgraph machines:
-- 
MST


