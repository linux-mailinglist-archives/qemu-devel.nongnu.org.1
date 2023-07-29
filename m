Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BCF767E5B
	for <lists+qemu-devel@lfdr.de>; Sat, 29 Jul 2023 12:56:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPhLX-0007rK-VX; Sat, 29 Jul 2023 06:38:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qPhLV-0007pg-Lb
 for qemu-devel@nongnu.org; Sat, 29 Jul 2023 06:38:49 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qPhLT-000138-SK
 for qemu-devel@nongnu.org; Sat, 29 Jul 2023 06:38:49 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3fbc244d384so29749715e9.0
 for <qemu-devel@nongnu.org>; Sat, 29 Jul 2023 03:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690627125; x=1691231925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TK1fciw7LUKtOLqmUperb6ROHdP0V6/TZkVSUmHfwKY=;
 b=FKlX/BbmvW2qc/KGcDWazV0rFsrcwWHoOpWP+KGqZqHmBbgHarhYnzzcI+VPX8jktJ
 G5tD5AN2ri4/1PjpbkZhy09X/hvxK1xYpqImdqZfQKQhIlnnOTwycPGFPlhbQxDh1Z/A
 YKhH6XVtx/U98lnzQlKWtvNahtvxmfJStI4NcrMX7Mg+UsWef5DvHCf6qiG0CQnjuMAn
 KV1I41ar41DznTGLQO8h9GdkrJw7lqAbnIay+O5X232ymndCwXfIOsmkSFzYeKRm7GeM
 RpAg/8sdgyh2LL8X+CMHIDJ1KdC++Q2OH52B1jManhUJwpqw9gP90MJUGZVlbKaSjdvV
 45CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690627125; x=1691231925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TK1fciw7LUKtOLqmUperb6ROHdP0V6/TZkVSUmHfwKY=;
 b=fjXa3eJleviMjFJbYHqM5nLx3wkLhvcLFjVLj/YWo4mkyFZ9WeLfzKGORgY1rrobNY
 TZOxk41IXSbNhNlhcVQ3ihy2//XlJyad84k/XSpda8TT+pW/MfSD++g0FduHu+tcTryl
 NFCUmqlg3Cs0Ci0ZFt0uIuEC01TE8uYZ7oaairbKtHMYEYGPn25G2kuJnwW8adeewJv7
 mlNMAxmPRzT/G3iw22u9fZgpcmx3znno8Oro34JxZrUAoRzqQnjSJ8qZ9m3h9lVMtTaj
 qUcpCJfy8KRJC9tx243qIULd7wi31v+kuNBJc3AHMOAprYFsLJrw/jlJMsMIIlYDkef2
 rJXA==
X-Gm-Message-State: ABy/qLa0t+Ex0ypsRRfgmLAes6xT6yL35SXrZm2ekCHBNaV1OUnRa7/e
 WSkjYcJw9CFjx7+kt78yLxNv27/vMVjgMlb2ECoraw==
X-Google-Smtp-Source: APBJJlFXhqVkVK8KsFlozDxL4Ebp0Fr9dZZK14r8i+MyGHL168od+keZsV4+T7sG0VBUtq65iwX8pg==
X-Received: by 2002:a5d:5247:0:b0:317:61de:abb5 with SMTP id
 k7-20020a5d5247000000b0031761deabb5mr3028560wrc.69.1690627124402; 
 Sat, 29 Jul 2023 03:38:44 -0700 (PDT)
Received: from localhost.localdomain (adsl-200.37.6.161.tellas.gr.
 [37.6.161.200]) by smtp.gmail.com with ESMTPSA id
 x20-20020a1c7c14000000b003fc01f7b415sm8984777wmc.39.2023.07.29.03.38.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Jul 2023 03:38:43 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Igor Skalkin" <Igor.Skalkin@opensynergy.com>,
 "Anton Yakovlev" <Anton.Yakovlev@opensynergy.com>,
 "Paolo Bonzini" <pbonzini@redhat.com>, "Gerd Hoffmann" <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Eduardo Habkost" <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?= <DirtY.iCE.hu@gmail.com>,
 "Alex Bennee" <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 02/12] Add virtio-sound-pci device
Date: Sat, 29 Jul 2023 13:36:54 +0300
Message-Id: <035be510f829a871c237d91f10c5aa3d532d1bbf.1690626150.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1690626150.git.manos.pitsidianakis@linaro.org>
References: <cover.1690626150.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32f.google.com
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

This patch adds a PCI wrapper device for the virtio-sound device.
It is necessary to instantiate a virtio-snd device in a guest.
All sound logic will be added to the virtio-snd device in the following
commits.

To add this device with a guest, you'll need a >=5.13 kernel compiled
with CONFIG_SND_VIRTIO=y, which at the time of writing most distros have
off by default.

Use with following flags in the invocation:

  -device virtio-sound-pci,disable-legacy=on

And an audio backend listed with `-audio driver=help` that works on
your host machine, e.g.:

Pulseaudio:
  -audio driver=pa,model=virtio-sound
  or
  -audio driver=pa,model=virtio-sound,server=/run/user/1000/pulse/native
sdl:
  -audio driver=sdl,model=virtio-sound
coreaudio (macos/darwin):
  -audio driver=coreaudio,model=virtio-sound
etc.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/virtio/meson.build      |  1 +
 hw/virtio/virtio-snd-pci.c | 91 ++++++++++++++++++++++++++++++++++++++
 include/hw/pci/pci.h       |  1 +
 softmmu/qdev-monitor.c     |  1 +
 4 files changed, 94 insertions(+)
 create mode 100644 hw/virtio/virtio-snd-pci.c

diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index 120d4bfa0a..5e5a83a4ee 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -63,6 +63,7 @@ virtio_pci_ss.add(when: 'CONFIG_VIRTIO_SERIAL', if_true: files('virtio-serial-pc
 virtio_pci_ss.add(when: 'CONFIG_VIRTIO_PMEM', if_true: files('virtio-pmem-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VIRTIO_IOMMU', if_true: files('virtio-iommu-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VIRTIO_MEM', if_true: files('virtio-mem-pci.c'))
+virtio_pci_ss.add(when: 'CONFIG_VIRTIO_SND', if_true: files('virtio-snd-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VHOST_VDPA_DEV', if_true: files('vdpa-dev-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VIRTIO_MD', if_true: files('virtio-md-pci.c'))
 
diff --git a/hw/virtio/virtio-snd-pci.c b/hw/virtio/virtio-snd-pci.c
new file mode 100644
index 0000000000..53070b85f6
--- /dev/null
+++ b/hw/virtio/virtio-snd-pci.c
@@ -0,0 +1,91 @@
+/*
+ * VIRTIO Sound Device PCI Bindings
+ *
+ * Copyright (c) 2023 Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.  See the COPYING file in the
+ * top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/audio/soundhw.h"
+#include "hw/virtio/virtio-pci.h"
+#include "hw/virtio/virtio-snd.h"
+
+typedef struct VirtIOSoundPCI VirtIOSoundPCI;
+
+/*
+ * virtio-snd-pci: This extends VirtioPCIProxy.
+ */
+#define TYPE_VIRTIO_SND_PCI "virtio-sound-pci-base"
+DECLARE_INSTANCE_CHECKER(VirtIOSoundPCI, VIRTIO_SOUND_PCI,
+                         TYPE_VIRTIO_SND_PCI)
+
+struct VirtIOSoundPCI {
+    VirtIOPCIProxy parent;
+    VirtIOSound vdev;
+};
+
+static Property virtio_snd_pci_properties[] = {
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static const char *audiodev_id;
+
+static int virtio_snd_init_pci(PCIBus *init_bus, const char *audiodev)
+{
+    audiodev_id = audiodev;
+    return 0;
+}
+
+static void virtio_snd_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
+{
+    VirtIOSoundPCI *dev = VIRTIO_SOUND_PCI(vpci_dev);
+    DeviceState *vdev = DEVICE(&dev->vdev);
+
+    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus), errp);
+    qdev_prop_set_string(vdev, "audiodev", audiodev_id);
+    object_property_set_bool(OBJECT(vdev), "realized", true, errp);
+}
+
+static void virtio_snd_pci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtioPCIClass *vpciklass = VIRTIO_PCI_CLASS(klass);
+    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
+
+    vpciklass->realize = virtio_snd_pci_realize;
+    set_bit(DEVICE_CATEGORY_SOUND, dc->categories);
+
+    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
+    pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_SND;
+    pcidev_k->revision = VIRTIO_PCI_ABI_VERSION;
+    pcidev_k->class_id = PCI_CLASS_MULTIMEDIA_AUDIO;
+    device_class_set_props(dc, virtio_snd_pci_properties);
+}
+
+static void virtio_snd_pci_instance_init(Object *obj)
+{
+    VirtIOSoundPCI *dev = VIRTIO_SOUND_PCI(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VIRTIO_SND);
+}
+
+static const VirtioPCIDeviceTypeInfo virtio_snd_pci_info = {
+    .base_name     = TYPE_VIRTIO_SND_PCI,
+    .generic_name  = "virtio-sound-pci",
+    .instance_size = sizeof(VirtIOSoundPCI),
+    .instance_init = virtio_snd_pci_instance_init,
+    .class_init    = virtio_snd_pci_class_init,
+};
+
+static void virtio_snd_pci_register(void)
+{
+    virtio_pci_types_register(&virtio_snd_pci_info);
+    pci_register_soundhw("virtio-sound", "Virtio Sound Device",
+                         virtio_snd_init_pci);
+}
+
+type_init(virtio_snd_pci_register);
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index abdc1ef103..3cd5712035 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -85,6 +85,7 @@ extern bool pci_available;
 #define PCI_DEVICE_ID_VIRTIO_RNG         0x1005
 #define PCI_DEVICE_ID_VIRTIO_9P          0x1009
 #define PCI_DEVICE_ID_VIRTIO_VSOCK       0x1012
+#define PCI_DEVICE_ID_VIRTIO_SND         0x1019
 
 /*
  * modern virtio-pci devices get their id assigned automatically,
diff --git a/softmmu/qdev-monitor.c b/softmmu/qdev-monitor.c
index 74f4e41338..2e9835ad88 100644
--- a/softmmu/qdev-monitor.c
+++ b/softmmu/qdev-monitor.c
@@ -108,6 +108,7 @@ static const QDevAlias qdev_alias_table[] = {
     { "virtio-serial-device", "virtio-serial", QEMU_ARCH_VIRTIO_MMIO },
     { "virtio-serial-ccw", "virtio-serial", QEMU_ARCH_VIRTIO_CCW },
     { "virtio-serial-pci", "virtio-serial", QEMU_ARCH_VIRTIO_PCI},
+    { "virtio-sound-pci", "virtio-sound", QEMU_ARCH_VIRTIO_PCI},
     { "virtio-tablet-device", "virtio-tablet", QEMU_ARCH_VIRTIO_MMIO },
     { "virtio-tablet-ccw", "virtio-tablet", QEMU_ARCH_VIRTIO_CCW },
     { "virtio-tablet-pci", "virtio-tablet", QEMU_ARCH_VIRTIO_PCI },
-- 
2.39.2


