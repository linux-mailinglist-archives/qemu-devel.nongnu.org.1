Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED5B74E1A9
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 01:03:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzuG-0003Jy-PS; Mon, 10 Jul 2023 19:03:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzuE-0003JE-Lw
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:02:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzuD-00049f-4M
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:02:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689030176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZkQdbFHoz6KUjwAnffgufnSjDWO7ahW1tpRCAX7lWrg=;
 b=LHqWz4VnT672KmE9pHn8MMiKomonJxekbbv2+j7ojhaBTeselzMAqOXpzxKOBbK+zNvTSe
 wFq32UIRHiqXD2J2v77tGpmpsj2ZbPoWxyhVnhECfQ2A64tKdWzyOb8iOAzdDGJGjucCjg
 EhjZRNsjJxpStgXLuLtxok/4teYIskg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-_RNvyqTfPfSbFSsETxTh6g-1; Mon, 10 Jul 2023 19:02:55 -0400
X-MC-Unique: _RNvyqTfPfSbFSsETxTh6g-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3fb40ec952bso29651055e9.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 16:02:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689030173; x=1691622173;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZkQdbFHoz6KUjwAnffgufnSjDWO7ahW1tpRCAX7lWrg=;
 b=CXkjnFjanAHpFObgSfUUc+gw8tjOR3vx+sE25epj47UDh6j0Az5flUwEfkwyzyZUWo
 Yep8hx8RnP8EflgC4yVcBXGSgeW0WrYI8+wFtLGZySTuInwp+HsIs0vozNCedFmFI3Wz
 pzjK98xpk6F2OP+/X0ZiW81V8yYil90sqXQL0hrIIODzKtc3D2nk5nUOgyv71brCPKK9
 SsusQ0G7xeERj5/YcVMy2PwuuxBj+ev3Ul9hhlgUbbckQRMt3PEgQUsg8+3yvTpSfBsv
 VUT9PIIHd8/0ZqL/33jghbqe8KbBjRT2gla6yK5A4U4OtSVCDCgxMOPAaCd0w/XDuDl3
 fyZQ==
X-Gm-Message-State: ABy/qLbQNwXOANxWdJ7hsZ4XFiasP9Xi/4DMHKUUjoYk4EqnEizi+sOv
 ULbpeJumKa/HQ6Z+cgEyHqghUy5eO4o3txIxKM1mzJaOgFrQzkihVunFomVxQ7lNsKttTxdN6O7
 FgxJuYEGf+EOzyIwxoBoH1rQrditYaYTqiQs/pUn9c5sFjSyi0e5oGjllgrekh+MsXJug
X-Received: by 2002:a7b:c050:0:b0:3fc:10:b25b with SMTP id
 u16-20020a7bc050000000b003fc0010b25bmr11219426wmc.21.1689030173663; 
 Mon, 10 Jul 2023 16:02:53 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH3/azalc04vxyMD8YY7HUwguMIFWHiZC7zaZVNU/HvhgKwKbcLC5vS5VfBSmhV1zWmL02MiQ==
X-Received: by 2002:a7b:c050:0:b0:3fc:10:b25b with SMTP id
 u16-20020a7bc050000000b003fc0010b25bmr11219414wmc.21.1689030173404; 
 Mon, 10 Jul 2023 16:02:53 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 13-20020a05600c228d00b003fbe4cecc3bsm11371169wmf.16.2023.07.10.16.02.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 16:02:53 -0700 (PDT)
Date: Mon, 10 Jul 2023 19:02:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Milan Zamazal <mzamazal@redhat.com>
Subject: [PULL 09/66] hw/virtio: Add vhost-user-scmi-pci boilerplate
Message-ID: <c46b20cf83ed5088626671447e214de165ca5297.1689030052.git.mst@redhat.com>
References: <cover.1689030052.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1689030052.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

This allows is to instantiate a vhost-user-scmi device as part of a PCI bus.
It is mostly boilerplate similar to the other vhost-user-*-pci boilerplates
of similar devices.

Signed-off-by: Milan Zamazal <mzamazal@redhat.com>
Message-Id: <20230628100524.342666-3-mzamazal@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-user-scmi-pci.c | 68 +++++++++++++++++++++++++++++++++
 hw/virtio/meson.build           |  1 +
 2 files changed, 69 insertions(+)
 create mode 100644 hw/virtio/vhost-user-scmi-pci.c

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
-- 
MST


