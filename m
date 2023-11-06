Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 532C37E2CB3
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 20:16:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r054Y-0007vl-CM; Mon, 06 Nov 2023 14:15:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r054W-0007v1-AD
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 14:15:40 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r054F-0005js-QI
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 14:15:40 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-409299277bbso34070955e9.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 11:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699298121; x=1699902921; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q4GXVCT0h3aOuJrUKXks6Wem9BLFnGtf8W3Df6B2wjU=;
 b=TCeHWUJPNcinJQIr2cTD38JCaFT5XMIGsxArVIaIvPARMaZGlGP/syRW1yDkeU3NRh
 pS0sRdCf8lwnIrifBvXO5yaOYH+ainL5nTutaOJJALGs54Qikt6TMqeGPlPIoWM/LgWi
 GS2Od21cww5HrVNZUKA7C0BnJSp+GcxN2I/okd0EFUZPzYMI6nxDdYioWjZ0I13GCefp
 RCPZZyD2e31/a65rKOZlxbXjZsCiolwy4GqiE22of7O+1+BTQRGVTssY7iG6kf7w1DCv
 HfZfUwUYNRlMIIEC5W8H6gRDKdQmdfxd+D6LSNmXx0iO/TWYklRCF2ffpliPwt2F3TtA
 bARw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699298121; x=1699902921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q4GXVCT0h3aOuJrUKXks6Wem9BLFnGtf8W3Df6B2wjU=;
 b=I9XNt2tAWLWIsWp1k8+dqnu9XgLfBOCcQS14E0c62mHCF9eOH2hW/cbINmSly6le4A
 EdQlag/opltGHTmxNl30YSnnQuvTS5vRfQGTx2yZANLuzr+qzzyKTz9ariQYs9rv6vM8
 T+HxvHE4dFnVD0NP5t9CWoUxopw+PlUGF1WZ5C+/PB6AHYlb4Al9SeauSbchR3xeA2S7
 SHut2zBsSoFfbdVyHIpDPS3Bcx9tbZ+AogA9Xr+LbNBc7U8+BbYRSk8dLv8o+2eDe5aq
 fkdooID5m1xm3JUn8z8ZehthqxIyOcX6zYDDTARWBqlDxXmyMv0f+ISR6l5zGFR7UMUj
 3w8A==
X-Gm-Message-State: AOJu0YwWiEfBC7BY8tH6is64hu1z4wAkZ3BYOYGBgUWqI+8cII4r9H2r
 cumLD4zWDTpuPMDx0+SYi8w8Pw==
X-Google-Smtp-Source: AGHT+IE+YqfNrd5NzNSKoo1J+4LWHzj9Kwod5ZHeZuQ7l/5g2n/z/+jvMqMJnRVWJSLLAwUc1gJIAQ==
X-Received: by 2002:a05:600c:4754:b0:401:daf2:2735 with SMTP id
 w20-20020a05600c475400b00401daf22735mr531692wmo.31.1699298121377; 
 Mon, 06 Nov 2023 11:15:21 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 t14-20020a05600c198e00b00405d9a950a2sm13328439wmq.28.2023.11.06.11.15.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 11:15:19 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9AF4D6575A;
 Mon,  6 Nov 2023 19:15:16 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, virtio-fs@redhat.com,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Kevin Wolf <kwolf@redhat.com>, Erik Schilling <erik.schilling@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v6 5/6] hw/virtio: add vhost-user-snd and virtio-snd-pci
 devices
Date: Mon,  6 Nov 2023 19:15:14 +0000
Message-Id: <20231106191515.2801863-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231106191515.2801863-1-alex.bennee@linaro.org>
References: <20231106191515.2801863-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Tested with rust-vmm vhost-user-sound daemon:

    RUST_LOG=trace cargo run --bin vhost-user-sound -- --socket /tmp/snd.sock --backend null

Invocation:

    qemu-system-x86_64  \
            -qmp unix:./qmp-sock,server,wait=off  \
            -m 4096 \
            -numa node,memdev=mem \
            -object memory-backend-file,id=mem,size=4G,mem-path=/dev/shm,share=on \
            -D qemu.log \
            -d guest_errors,trace:\*snd\*,trace:\*sound\*,trace:\*vhost\* \
            -chardev socket,id=vsnd,path=/tmp/snd.sock \
            -device vhost-user-snd-pci,chardev=vsnd,id=snd \
            /path/to/disk

[AJB: imported from https://github.com/epilys/qemu-virtio-snd/commit/54ae1cdd15fef2d88e9e387a175f099a38c636f4.patch]

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231009095937.195728-6-alex.bennee@linaro.org>
---
 include/hw/virtio/vhost-user-snd.h | 26 +++++++++++
 hw/virtio/vhost-user-snd-pci.c     | 75 ++++++++++++++++++++++++++++++
 hw/virtio/vhost-user-snd.c         | 67 ++++++++++++++++++++++++++
 hw/virtio/Kconfig                  |  5 ++
 hw/virtio/meson.build              |  3 ++
 5 files changed, 176 insertions(+)
 create mode 100644 include/hw/virtio/vhost-user-snd.h
 create mode 100644 hw/virtio/vhost-user-snd-pci.c
 create mode 100644 hw/virtio/vhost-user-snd.c

diff --git a/include/hw/virtio/vhost-user-snd.h b/include/hw/virtio/vhost-user-snd.h
new file mode 100644
index 0000000000..a1627003a0
--- /dev/null
+++ b/include/hw/virtio/vhost-user-snd.h
@@ -0,0 +1,26 @@
+/*
+ * Vhost-user Sound virtio device
+ *
+ * Copyright (c) 2021 Mathieu Poirier <mathieu.poirier@linaro.org>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef QEMU_VHOST_USER_SND_H
+#define QEMU_VHOST_USER_SND_H
+
+#include "hw/virtio/virtio.h"
+#include "hw/virtio/vhost.h"
+#include "hw/virtio/vhost-user.h"
+#include "hw/virtio/vhost-user-base.h"
+
+#define TYPE_VHOST_USER_SND "vhost-user-snd"
+OBJECT_DECLARE_SIMPLE_TYPE(VHostUserSound, VHOST_USER_SND)
+
+struct VHostUserSound {
+    /*< private >*/
+    VHostUserBase parent;
+    /*< public >*/
+};
+
+#endif /* QEMU_VHOST_USER_SND_H */
diff --git a/hw/virtio/vhost-user-snd-pci.c b/hw/virtio/vhost-user-snd-pci.c
new file mode 100644
index 0000000000..d61cfdae63
--- /dev/null
+++ b/hw/virtio/vhost-user-snd-pci.c
@@ -0,0 +1,75 @@
+/*
+ * Vhost-user Sound virtio device PCI glue
+ *
+ * Copyright (c) 2023 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/qdev-properties.h"
+#include "hw/virtio/vhost-user-snd.h"
+#include "hw/virtio/virtio-pci.h"
+
+struct VHostUserSoundPCI {
+    VirtIOPCIProxy parent_obj;
+    VHostUserSound vdev;
+};
+
+typedef struct VHostUserSoundPCI VHostUserSoundPCI;
+
+#define TYPE_VHOST_USER_SND_PCI "vhost-user-snd-pci-base"
+
+DECLARE_INSTANCE_CHECKER(VHostUserSoundPCI, VHOST_USER_SND_PCI,
+                         TYPE_VHOST_USER_SND_PCI)
+
+static Property vhost_user_snd_pci_properties[] = {
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void vhost_user_snd_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
+{
+    VHostUserSoundPCI *dev = VHOST_USER_SND_PCI(vpci_dev);
+    DeviceState *vdev = DEVICE(&dev->vdev);
+
+    vpci_dev->nvectors = 1;
+
+    qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
+}
+
+static void vhost_user_snd_pci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
+    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
+    k->realize = vhost_user_snd_pci_realize;
+    set_bit(DEVICE_CATEGORY_SOUND, dc->categories);
+    device_class_set_props(dc, vhost_user_snd_pci_properties);
+    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
+    pcidev_k->device_id = 0; /* Set by virtio-pci based on virtio id */
+    pcidev_k->revision = 0x00;
+    pcidev_k->class_id = PCI_CLASS_MULTIMEDIA_AUDIO;
+}
+
+static void vhost_user_snd_pci_instance_init(Object *obj)
+{
+    VHostUserSoundPCI *dev = VHOST_USER_SND_PCI(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VHOST_USER_SND);
+}
+
+static const VirtioPCIDeviceTypeInfo vhost_user_snd_pci_info = {
+    .base_name = TYPE_VHOST_USER_SND_PCI,
+    .non_transitional_name = "vhost-user-snd-pci",
+    .instance_size = sizeof(VHostUserSoundPCI),
+    .instance_init = vhost_user_snd_pci_instance_init,
+    .class_init = vhost_user_snd_pci_class_init,
+};
+
+static void vhost_user_snd_pci_register(void)
+{
+    virtio_pci_types_register(&vhost_user_snd_pci_info);
+}
+
+type_init(vhost_user_snd_pci_register);
diff --git a/hw/virtio/vhost-user-snd.c b/hw/virtio/vhost-user-snd.c
new file mode 100644
index 0000000000..9a217543f8
--- /dev/null
+++ b/hw/virtio/vhost-user-snd.c
@@ -0,0 +1,67 @@
+/*
+ * Vhost-user snd virtio device
+ *
+ * Copyright (c) 2023 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+ *
+ * Simple wrapper of the generic vhost-user-device.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/qdev-properties.h"
+#include "hw/virtio/virtio-bus.h"
+#include "hw/virtio/vhost-user-snd.h"
+#include "standard-headers/linux/virtio_ids.h"
+#include "standard-headers/linux/virtio_snd.h"
+
+static const VMStateDescription vu_snd_vmstate = {
+    .name = "vhost-user-snd",
+    .unmigratable = 1,
+};
+
+static Property vsnd_properties[] = {
+    DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void vu_snd_base_realize(DeviceState *dev, Error **errp)
+{
+    VHostUserBase *vub = VHOST_USER_BASE(dev);
+    VHostUserBaseClass *vubs = VHOST_USER_BASE_GET_CLASS(dev);
+
+    vub->virtio_id = VIRTIO_ID_SOUND;
+    vub->num_vqs = 4;
+    vub->config_size = sizeof(struct virtio_snd_config);
+    vub->vq_size = 64;
+
+    vubs->parent_realize(dev, errp);
+}
+
+static void vu_snd_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VHostUserBaseClass *vubc = VHOST_USER_BASE_CLASS(klass);
+
+    dc->vmsd = &vu_snd_vmstate;
+    device_class_set_props(dc, vsnd_properties);
+    device_class_set_parent_realize(dc, vu_snd_base_realize,
+                                    &vubc->parent_realize);
+
+    set_bit(DEVICE_CATEGORY_SOUND, dc->categories);
+}
+
+static const TypeInfo vu_snd_info = {
+    .name = TYPE_VHOST_USER_SND,
+    .parent = TYPE_VHOST_USER_BASE,
+    .instance_size = sizeof(VHostUserSound),
+    .class_init = vu_snd_class_init,
+};
+
+static void vu_snd_register_types(void)
+{
+    type_register_static(&vu_snd_info);
+}
+
+type_init(vu_snd_register_types)
diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
index 92c9cf6c96..aa63ff7fd4 100644
--- a/hw/virtio/Kconfig
+++ b/hw/virtio/Kconfig
@@ -101,6 +101,11 @@ config VHOST_VDPA_DEV
     default y
     depends on VIRTIO && VHOST_VDPA && LINUX
 
+config VHOST_USER_SND
+    bool
+    default y
+    depends on VIRTIO && VHOST_USER
+
 config VHOST_USER_SCMI
     bool
     default y
diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index 0a4d29ace6..118d4d4da7 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -24,6 +24,7 @@ if have_vhost
     system_virtio_ss.add(when: 'CONFIG_VHOST_USER_GPIO', if_true: files('vhost-user-gpio.c'))
     system_virtio_ss.add(when: 'CONFIG_VHOST_USER_I2C', if_true: files('vhost-user-i2c.c'))
     system_virtio_ss.add(when: 'CONFIG_VHOST_USER_RNG', if_true: files('vhost-user-rng.c'))
+    system_virtio_ss.add(when: 'CONFIG_VHOST_USER_SND', if_true: files('vhost-user-snd.c'))
 
     # PCI Stubs
     system_virtio_ss.add(when: 'CONFIG_VIRTIO_PCI', if_true: files('vhost-user-device-pci.c'))
@@ -33,6 +34,8 @@ if have_vhost
                          if_true: files('vhost-user-i2c-pci.c'))
     system_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_RNG'],
                          if_true: files('vhost-user-rng-pci.c'))
+    system_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_SND'],
+                         if_true: files('vhost-user-snd-pci.c'))
   endif
   if have_vhost_vdpa
     system_virtio_ss.add(files('vhost-vdpa.c'))
-- 
2.39.2


