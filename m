Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A2602716FB3
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 23:29:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q46su-0004RJ-Sl; Tue, 30 May 2023 17:28:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mzamazal@redhat.com>)
 id 1q45gk-0005Xo-VX
 for qemu-devel@nongnu.org; Tue, 30 May 2023 16:11:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mzamazal@redhat.com>)
 id 1q45gj-0000Mu-AI
 for qemu-devel@nongnu.org; Tue, 30 May 2023 16:11:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685477484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qwq4WGliWyi5M0GOYrCBfVerBIOzlsWqb7IJX2cJ28M=;
 b=WxnOHmIsActcHhvi4q1/0ZUzr9xSpGo33AspNcEA4t89pKd6GdwIY0p+E5QWuE9yWyoaFB
 KESjvmPTuu/9sl88WbB94VhQlHuMjpBvq2bhMrwb6nwqn4SCxJ5D6zjAnWEQWsZF0HUziC
 yiRFyrroEIqDos4DC2MQTRamcVKeI90=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-RcWSFMlBOTOjOZWfrFvsxQ-1; Tue, 30 May 2023 16:07:57 -0400
X-MC-Unique: RcWSFMlBOTOjOZWfrFvsxQ-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-514abe67064so1433636a12.0
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 13:07:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685477275; x=1688069275;
 h=mime-version:user-agent:message-id:references:date:in-reply-to
 :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qwq4WGliWyi5M0GOYrCBfVerBIOzlsWqb7IJX2cJ28M=;
 b=dHBnJhfmryHizWWxLVJxx2MLHzeU2evMZKfig20bCqx9ADp9o3BIx5B5qhJkzXaexq
 WKCeu7JLb6gcfjPoPf/n/UkkOEQJtkxN2DdrJVAAv6Xg3D3nLwMVNxwuXjRdIAJMBZjB
 P3C5tjYdcd27NQgbkYhfW1K1ULLlXkG55R9h7FH2lPT/lD5oxEE7+ROUlmOvFkPu1ZHC
 cSuiwxAE7uQVy1QIyRp1ifSDYApr7L/leWGeQWHAYs4RYDHHuByZ5tOqs8F5cP6hS3RM
 raHAoJGwtjbsCTP74dAaqcJHVnyHJ8N5Suo7PTRESi0LyO9X5ffusBnXiJxBzdA6mMkP
 fvbA==
X-Gm-Message-State: AC+VfDyMSVasJSCdHVProupBIvO2msEWUstRn+2ltJZg9cPlDId2q9x4
 hYYP0GlXKA089udUqFgz7Is6qm8Vi7edggsklOsIwsIZtKxYl+7GHrl1kZvyWR6P8sU83ZW9Dal
 z4q+/74WfwAoT5cWMI/w5W9s=
X-Received: by 2002:a17:907:2d0a:b0:974:1ef7:1e33 with SMTP id
 gs10-20020a1709072d0a00b009741ef71e33mr3390602ejc.8.1685477275573; 
 Tue, 30 May 2023 13:07:55 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4mibgyJwxiIyU+QExUuhO42uPYcAQAEhu4L53Kb5nRU7DYWiYl40leV6OhLNDeH0T23820lA==
X-Received: by 2002:a17:907:2d0a:b0:974:1ef7:1e33 with SMTP id
 gs10-20020a1709072d0a00b009741ef71e33mr3390592ejc.8.1685477275339; 
 Tue, 30 May 2023 13:07:55 -0700 (PDT)
Received: from nuthatch (ip-77-48-47-2.net.vodafone.cz. [77.48.47.2])
 by smtp.gmail.com with ESMTPSA id
 gz24-20020a170906f2d800b00965c529f103sm7771631ejb.86.2023.05.30.13.07.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 13:07:54 -0700 (PDT)
From: Milan Zamazal <mzamazal@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com,
    stefanha@redhat.com,
    alex.bennee@linaro.org
Subject: [PATCH 2/4] hw/virtio: Add vhost-user-scmi-pci boilerplate
In-Reply-To: <cover.1685476786.git.mzamazal@redhat.com>
Date: Tue, 23 May 2023 10:19:03 +0200
References: <cover.1685476786.git.mzamazal@redhat.com>
Message-Id: <0c2293785dcef01d5f1e64aa7e7f8236b501bade.1685476786.git.mzamazal@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mzamazal@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIMWL_WL_HIGH=-0.167, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
index c3eeb23942..bdea57b2ef 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -33,6 +33,7 @@ specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_RNG', if_true: files('vhost-user
 specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_GPIO', if_true: files('vhost-user-gpio.c'))
 specific_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_GPIO'], if_true: files('vhost-user-gpio-pci.c'))
 specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_SCMI', if_true: files('vhost-user-scmi.c'))
+specific_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_SCMI'], if_true: files('vhost-user-scmi-pci.c'))
 specific_virtio_ss.add(when: 'CONFIG_VHOST_VDPA_DEV', if_true: files('vdpa-dev.c'))
 
 virtio_pci_ss = ss.source_set()
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
2.38.5


