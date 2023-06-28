Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0A5740E2F
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 12:07:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qES4K-0008FQ-9V; Wed, 28 Jun 2023 06:06:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mzamazal@redhat.com>)
 id 1qES4D-0008EM-C1
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 06:06:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mzamazal@redhat.com>)
 id 1qES4B-0005d3-KA
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 06:06:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687946786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rm1LACQ5G3+lR4W5rqh9AwU38Czu1EsnreeQOu+ityI=;
 b=PX/8kEr/14M1QE78Qz8j0upVT2feTD/nk7GkAwVuNjgHvBxTOqcmCJRwmjalZ3CfoDK9nC
 Zo8Kwu3mCzW8lWEmK/o7JYPjIR2SeTi9yEA9p7BKkuGji67z7cxRTDbE6ATFKpUAAYBdVm
 UXdKihx8tKZOwW5K+LDUJuZU2uGbT5I=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-413-mGcGrx9QNY2GN-fTlqQKtg-1; Wed, 28 Jun 2023 06:06:25 -0400
X-MC-Unique: mGcGrx9QNY2GN-fTlqQKtg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AE2383C108CF;
 Wed, 28 Jun 2023 10:06:24 +0000 (UTC)
Received: from nuthatch.redhat.com (unknown [10.45.226.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6E7B515230A0;
 Wed, 28 Jun 2023 10:06:23 +0000 (UTC)
From: Milan Zamazal <mzamazal@redhat.com>
To: qemu-devel@nongnu.org
Cc: Milan Zamazal <mzamazal@redhat.com>, mst@redhat.com, stefanha@redhat.com,
 alex.bennee@linaro.org, thuth@redhat.com, vincent.guittot@linaro.org
Subject: [PATCH v3 2/3] hw/virtio: Add vhost-user-scmi-pci boilerplate
Date: Wed, 28 Jun 2023 12:05:23 +0200
Message-Id: <20230628100524.342666-3-mzamazal@redhat.com>
In-Reply-To: <20230628100524.342666-1-mzamazal@redhat.com>
References: <20230628100524.342666-1-mzamazal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mzamazal@redhat.com;
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

This allows is to instantiate a vhost-user-scmi device as part of a PCI bus.
It is mostly boilerplate similar to the other vhost-user-*-pci boilerplates
of similar devices.

Signed-off-by: Milan Zamazal <mzamazal@redhat.com>
---
 hw/virtio/meson.build           |  1 +
 hw/virtio/vhost-user-scmi-pci.c | 68 +++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)
 create mode 100644 hw/virtio/vhost-user-scmi-pci.c

diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index 4a4d7e1c27..c4f4fe05fa 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -36,6 +36,7 @@ specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_RNG', if_true: files('vhost-user
 specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_GPIO', if_true: files('vhost-user-gpio.c'))
 specific_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_GPIO'], if_true: files('vhost-user-gpio-pci.c'))
 specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_SCMI', if_true: files('vhost-user-scmi.c'))
+specific_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_SCMI'], if_true: files('vhost-user-scmi-pci.c'))
 
 virtio_pci_ss = ss.source_set()
 virtio_pci_ss.add(when: 'CONFIG_VHOST_VSOCK', if_true: files('vhost-vsock-pci.c'))
diff --git a/hw/virtio/vhost-user-scmi-pci.c b/hw/virtio/vhost-user-scmi-pci.c
new file mode 100644
index 0000000000..7f53af7fce
--- /dev/null
+++ b/hw/virtio/vhost-user-scmi-pci.c
@@ -0,0 +1,68 @@
+/*
+ * Vhost-user SCMI virtio device PCI glue
+ *
+ * SPDX-FileCopyrightText: Red Hat, Inc.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/qdev-properties.h"
+#include "hw/virtio/vhost-user-scmi.h"
+#include "hw/virtio/virtio-pci.h"
+
+struct VHostUserSCMIPCI {
+    VirtIOPCIProxy parent_obj;
+    VHostUserSCMI vdev;
+};
+
+typedef struct VHostUserSCMIPCI VHostUserSCMIPCI;
+
+#define TYPE_VHOST_USER_SCMI_PCI "vhost-user-scmi-pci-base"
+
+DECLARE_INSTANCE_CHECKER(VHostUserSCMIPCI, VHOST_USER_SCMI_PCI,
+                         TYPE_VHOST_USER_SCMI_PCI)
+
+static void vhost_user_scmi_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
+{
+    VHostUserSCMIPCI *dev = VHOST_USER_SCMI_PCI(vpci_dev);
+    DeviceState *vdev = DEVICE(&dev->vdev);
+
+    vpci_dev->nvectors = 1;
+    qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
+}
+
+static void vhost_user_scmi_pci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
+    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
+    k->realize = vhost_user_scmi_pci_realize;
+    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
+    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
+    pcidev_k->device_id = 0; /* Set by virtio-pci based on virtio id */
+    pcidev_k->revision = 0x00;
+    pcidev_k->class_id = PCI_CLASS_COMMUNICATION_OTHER;
+}
+
+static void vhost_user_scmi_pci_instance_init(Object *obj)
+{
+    VHostUserSCMIPCI *dev = VHOST_USER_SCMI_PCI(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VHOST_USER_SCMI);
+}
+
+static const VirtioPCIDeviceTypeInfo vhost_user_scmi_pci_info = {
+    .base_name = TYPE_VHOST_USER_SCMI_PCI,
+    .non_transitional_name = "vhost-user-scmi-pci",
+    .instance_size = sizeof(VHostUserSCMIPCI),
+    .instance_init = vhost_user_scmi_pci_instance_init,
+    .class_init = vhost_user_scmi_pci_class_init,
+};
+
+static void vhost_user_scmi_pci_register(void)
+{
+    virtio_pci_types_register(&vhost_user_scmi_pci_info);
+}
+
+type_init(vhost_user_scmi_pci_register);
-- 
2.40.1


