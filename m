Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AEAE974DA05
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 17:38:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIsvj-0005xa-61; Mon, 10 Jul 2023 11:36:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qIsvX-0005py-PQ
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 11:35:52 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qIsvG-0004mA-3w
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 11:35:50 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3fbf1b82de7so34220695e9.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 08:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689003332; x=1691595332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9tMjRjVxXlcAyveN1BbPQH3Nll2IHvq76/Eq339lGng=;
 b=cFywZH65UhJ2Zn1R3CgaqM6BYfFdCW0Yj3VxquSqETsDyfA+KJZjJRIW6OUhvcqPQd
 zJi0/bHT+9HdYfAeOTLHZOk6L3fAllmPYDtD20KsYbPyROgJs1sFrXsfzlRW40R5vxv+
 MBy/RS9K/WxjFg9LaSzuqki7fzXzXhia0PhE2TUpg6TQqoBYOMFE6TmVcu4PvnSYBZ6s
 iZbNQ+6vR6bOf9Q5fX+BpDpwxDWLIIvuwSohm5Fc1hxjT59NFa3yQLfZfc/t0vAKIKel
 TQ5fORkMHNia2Cec4y07yxltaaPPAUOtkifD3qm0Vm3gvGox45kwbH2OoyOH29nlAkUl
 7k6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689003332; x=1691595332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9tMjRjVxXlcAyveN1BbPQH3Nll2IHvq76/Eq339lGng=;
 b=e+K2Lwq2s5aCEsB5DXVq3E752VRsk59Wvzx1u+tAYek1qlBrJlJ2yPzUefu3oZLGu4
 G6bJmdzb7PYSoJZDY/PZMfFyQ5v+xC5TiBtzSzy2PL2b4HTbM4v/yBPVUAaj2cTwgrcP
 7xAU+B0Z1zWb1F9uQdbdN5hrGPvfBnDAR99kFqksRELqJm0DG4pR4z+aeyJBAwEiM7t8
 3iL1cS9J/SrofnqEGKACwbRTQlBiyrvCkxlHPZHz4R+8gXdhm2kAOf5hiGbzk/sIUwEa
 yMGspSs7qKKzyYo+P3WRtl7j1xtoikGiFpa/+gzTB6OcOIRzXIeVc6P7LERDozlT8vc7
 kZwQ==
X-Gm-Message-State: ABy/qLbNIOyN110TvEjWswRvnOEdGGKJW8dMchLvCxjgdfKprN+a1wlW
 VgkTt6TmsFynry8q7sF5eIYNUw==
X-Google-Smtp-Source: APBJJlHuurQYsmtTGdBEHkr6qwIU8LjdbO/OsJJu+VU0epv2knSpnX0XyuGGk5QLOgZ6kL9ON4iQ3Q==
X-Received: by 2002:a05:600c:35c3:b0:3fa:125c:8d65 with SMTP id
 r3-20020a05600c35c300b003fa125c8d65mr14771442wmq.3.1689003332066; 
 Mon, 10 Jul 2023 08:35:32 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 s21-20020a7bc395000000b003fbc89af035sm183251wmj.17.2023.07.10.08.35.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 08:35:29 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1D95A1FFC3;
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
Subject: [PATCH v3 08/20] virtio: add PCI stub for vhost-user-device
Date: Mon, 10 Jul 2023 16:35:10 +0100
Message-Id: <20230710153522.3469097-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230710153522.3469097-1-alex.bennee@linaro.org>
References: <20230710153522.3469097-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

This is all pretty much boilerplate.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Erik Schilling <erik.schilling@linaro.org>
---
 hw/virtio/vhost-user-device-pci.c | 71 +++++++++++++++++++++++++++++++
 hw/virtio/meson.build             |  1 +
 2 files changed, 72 insertions(+)
 create mode 100644 hw/virtio/vhost-user-device-pci.c

diff --git a/hw/virtio/vhost-user-device-pci.c b/hw/virtio/vhost-user-device-pci.c
new file mode 100644
index 0000000000..41f9b7905b
--- /dev/null
+++ b/hw/virtio/vhost-user-device-pci.c
@@ -0,0 +1,71 @@
+/*
+ * Vhost-user generic virtio device PCI glue
+ *
+ * Copyright (c) 2023 Linaro Ltd
+ * Author: Alex Bennée <alex.bennee@linaro.org>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/qdev-properties.h"
+#include "hw/virtio/vhost-user-device.h"
+#include "hw/virtio/virtio-pci.h"
+
+struct VHostUserDevicePCI {
+    VirtIOPCIProxy parent_obj;
+    VHostUserBase vub;
+};
+
+typedef struct VHostUserDevicePCI VHostUserDevicePCI;
+
+#define TYPE_VHOST_USER_DEVICE_PCI "vhost-user-device-pci-base"
+
+DECLARE_INSTANCE_CHECKER(VHostUserDevicePCI,
+                         VHOST_USER_DEVICE_PCI,
+                         TYPE_VHOST_USER_DEVICE_PCI)
+
+static void vhost_user_device_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
+{
+    VHostUserDevicePCI *dev = VHOST_USER_DEVICE_PCI(vpci_dev);
+    DeviceState *vdev = DEVICE(&dev->vub);
+
+    vpci_dev->nvectors = 1;
+    qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
+}
+
+static void vhost_user_device_pci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
+    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
+    k->realize = vhost_user_device_pci_realize;
+    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
+    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
+    pcidev_k->device_id = 0; /* Set by virtio-pci based on virtio id */
+    pcidev_k->revision = 0x00;
+    pcidev_k->class_id = PCI_CLASS_COMMUNICATION_OTHER;
+}
+
+static void vhost_user_device_pci_instance_init(Object *obj)
+{
+    VHostUserDevicePCI *dev = VHOST_USER_DEVICE_PCI(obj);
+
+    virtio_instance_init_common(obj, &dev->vub, sizeof(dev->vub),
+                                TYPE_VHOST_USER_DEVICE);
+}
+
+static const VirtioPCIDeviceTypeInfo vhost_user_device_pci_info = {
+    .base_name = TYPE_VHOST_USER_DEVICE_PCI,
+    .non_transitional_name = "vhost-user-device-pci",
+    .instance_size = sizeof(VHostUserDevicePCI),
+    .instance_init = vhost_user_device_pci_instance_init,
+    .class_init = vhost_user_device_pci_class_init,
+};
+
+static void vhost_user_device_pci_register(void)
+{
+    virtio_pci_types_register(&vhost_user_device_pci_info);
+}
+
+type_init(vhost_user_device_pci_register);
diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index b87c5523e7..1e1df77783 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -18,6 +18,7 @@ if have_vhost
     # fixme - this really should be generic
     specific_virtio_ss.add(files('vhost-user.c'))
     softmmu_virtio_ss.add(files('vhost-user-device.c'))
+    softmmu_virtio_ss.add(when: 'CONFIG_VIRTIO_PCI', if_true: files('vhost-user-device-pci.c'))
   endif
   if have_vhost_vdpa
     specific_virtio_ss.add(files('vhost-vdpa.c', 'vhost-shadow-virtqueue.c'))
-- 
2.39.2


