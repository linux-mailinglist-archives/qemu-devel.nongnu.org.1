Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C017CF484
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 11:58:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtPlc-00055q-0j; Thu, 19 Oct 2023 05:56:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qtPlM-00050v-PE
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 05:56:22 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qtPlH-0006Ri-Sg
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 05:56:20 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40839652b97so16544095e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 02:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697709374; x=1698314174; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q4GXVCT0h3aOuJrUKXks6Wem9BLFnGtf8W3Df6B2wjU=;
 b=qROaXc5eAES7FTJdeJ2Bk09m974ZDda30uL+FKpt1jMf+6J4H/ux5i9CDUnTeJiYBl
 RE6IVpi5McDPghdOuj23SIi83CnDQ05ssnUFJTeCziNeqG8NACoBLaH+ZlKHXRk8JcD2
 ZIFUUvsHyzyzDzr2CPDCPauliSCoS+Y3CdOzDSy2dxBeQ0ouXdltRb3bPUjF+PjtGVTM
 +20ghLYKMNG+xpLJNqE7HyZKV5cu3cg9/1OL3W4ekt+5A98C/6fXu5Et9KeJghIvhtdZ
 JUKf1yRDj0o7PZE7Eh3jLFC5QRxu/zhmYkflGOokwZ+THy1Kw5jx6QoYhaGthUs0or3h
 yFmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697709374; x=1698314174;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q4GXVCT0h3aOuJrUKXks6Wem9BLFnGtf8W3Df6B2wjU=;
 b=wU/8HgStxYLj991Gva8AyS9cj+vUkJ5aOVKRACov8qz6hjHzpKxVaocC4png4FHAOu
 9JjKsKr4ppbDRhHP3xoOILF1vXgPb4zJ+KHE3kDkD2zI+j+aREptBDYPPRajUXF+Xvbn
 B7wTyjNEvbgQj9A54tdvgDlx/j1S6ipYpu2xyEnDCM4thwC99f3SZ2iEIqvRa1kjcPiN
 6Uv0o2tBD4JqvtGI/1tRwH1OK6q3bQSbKtphCT/E7pbEM3Ompi8L82HMvDDoHeHyV/ru
 rBl6jqE2AbtVc9bo/xCVMZmGBYbOyXySl3x7vss0FHu52RzURzOVYFPoFZDhloRCSpxi
 wxtQ==
X-Gm-Message-State: AOJu0Yz8jK0OGGbz2mcf9IeuLsSW/U/+q1+pbvlbKcUjPTTor38PZXzs
 qSSoekxVwhoCKNNBFjF3iOVK8Q==
X-Google-Smtp-Source: AGHT+IFNZCw4WSENcEd/nmrQW4QFsB2mhH6e2bjGJyrwNhHvPzKkYO1fNCvORVy87nVf5YjvJZpIoA==
X-Received: by 2002:a5d:408f:0:b0:319:7472:f0b6 with SMTP id
 o15-20020a5d408f000000b003197472f0b6mr1071243wrp.15.1697709374506; 
 Thu, 19 Oct 2023 02:56:14 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 b9-20020a5d4d89000000b0032d9548240fsm4083836wru.82.2023.10.19.02.56.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 02:56:12 -0700 (PDT)
Received: from zen.linaroharston (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 02C451FFC0;
 Thu, 19 Oct 2023 10:56:11 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 virtio-fs@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Fam Zheng <fam@euphon.net>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Erik Schilling <erik.schilling@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v5 5/6] hw/virtio: add vhost-user-snd and virtio-snd-pci
 devices
Date: Thu, 19 Oct 2023 10:56:09 +0100
Message-Id: <20231019095610.2818087-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231019095610.2818087-1-alex.bennee@linaro.org>
References: <20231019095610.2818087-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


