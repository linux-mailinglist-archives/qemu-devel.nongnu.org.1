Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 194967BD7CC
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 12:01:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpn3X-0006bF-J5; Mon, 09 Oct 2023 06:00:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qpn3I-0006W0-HE
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 05:59:53 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qpn39-000821-Ki
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 05:59:52 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2c008042211so51776681fa.2
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 02:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696845582; x=1697450382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8ZLrHME1wBG4Of8U83q/fTy2Klxn13LEqES8DHG+aSU=;
 b=fWC5cGYLxjnwk3OjINcSLAU9jGtG/6ZnqIjhoJgC5fwaEuEnE0nZpP3K1mVomTVS4A
 q0aJOkuSwfkl9DfEYwkBSx04Qe1h4hl/SIl9d+Q2kFciKIRo1DahsPSpn6gejvA8bCtJ
 aAKfQ7uzsuObnn4r8wjNhqd3wWmt+SpvHjLC/QUZyNRsNzkRMbS4ppgiO8GsxaxT4FoZ
 MCZvt6y9HPxGilwACOvmgHI6Bsc6Ya4IvWkzM0zsE60PFplGtEpWtn30YBYiTeEhXTjP
 9gUKVprNygh3nw5kX+9v5y1KvBmNBV6NceOcS8HF6h6t4GQNy8urH8cPES8EXI/fywwD
 nWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696845582; x=1697450382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8ZLrHME1wBG4Of8U83q/fTy2Klxn13LEqES8DHG+aSU=;
 b=YebnYL2WTmSYsl+dUJlWwMfBqzj6S2YMg11k/Ih1ierjjeZC7ZiM2SgkHQxNpbQNaX
 f24feIQ70GqElRWwv/MIwF43R/sYXLntht/5iGncF1ovlnshFN7WIrw4gxNaXtYRFQUC
 6hwcnYramCtgMmPaTCpzgzFOfl34rfghfzSiKSm/2/EI8YTDunz36mHIUeTMeEEedvJP
 qKbCu/BfrugikK2lLdjNF4qrvreQqrhOTole6mog//xKgRF4n32Xp3vyrOyg9DAVh8ku
 cCxNynv/5pDU56l5+FSNcHiiAvCj2+5p2Pd/RxDOOAH3MVsD7SwOkzziNQnRP6BMGFnj
 JslQ==
X-Gm-Message-State: AOJu0YydjcWFQx7n1tmvel/J93B/no/2qyIDFho0nmR812dsVzV+ZxNW
 OyY1RpPnvnL0rZlrk1Rz+xc9SA==
X-Google-Smtp-Source: AGHT+IE6Ux/qPhrLUL9LLuu6Lih8qEIt+MrNmU9FRuWwxkpyFEdMVw0PMEtc8kt7He4Enoz+kQ2ySw==
X-Received: by 2002:a05:6512:3103:b0:505:713a:4bb8 with SMTP id
 n3-20020a056512310300b00505713a4bb8mr11836211lfb.27.1696845581966; 
 Mon, 09 Oct 2023 02:59:41 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 n22-20020a7bcbd6000000b004060f0a0fdbsm13037716wmi.41.2023.10.09.02.59.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Oct 2023 02:59:41 -0700 (PDT)
Received: from zen.linaroharston (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D377F1FFC0;
 Mon,  9 Oct 2023 10:59:38 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Erik Schilling <erik.schilling@linaro.org>, Fam Zheng <fam@euphon.net>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Viresh Kumar <viresh.kumar@linaro.org>, virtio-fs@redhat.com,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Markus Armbruster <armbru@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v4 5/6] hw/virtio: add vhost-user-snd and virtio-snd-pci
 devices
Date: Mon,  9 Oct 2023 10:59:36 +0100
Message-Id: <20231009095937.195728-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231009095937.195728-1-alex.bennee@linaro.org>
References: <20231009095937.195728-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x231.google.com
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

---
v1
  - import and test
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
index f3e1ccc9c9..e00de61da9 100644
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


