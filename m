Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F14278B8C3
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 21:57:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaiL4-0002ZM-5t; Mon, 28 Aug 2023 15:55:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qaiKw-0002Uu-J2
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 15:55:47 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qaiKt-0005Cb-5y
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 15:55:46 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-31c6cd238e0so2924955f8f.0
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 12:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693252541; x=1693857341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GGvxepFjLGp8ahCNZf3OhOljpuMctCwr1Aq27miiOzo=;
 b=Da//qOEBsiWLcG7Iil1yhsFYct1bVgOKgkdDDdhN3Dxb/V5aCZ7RMs7WvrYKxNk+/G
 zV1LIgUecFAQsCuHGkEzTmyqIGHBS+DxsT2bg0QukgH9BrnGQvThU6C+wu7Xs322cAkZ
 2GmAaflnhfm06YsXEd+fXoE3ERi8hS+kxHZ9NgglGQrLm8UHZAs3a7YWIf64G+TP79lV
 6Bi3a3sE5B5j7LDMllWFuNHwOoD3MaMZ2TZ0Bs0rmPI24DMCmuMZjDQWCFAWryCuOT7T
 L6rPGcnjvBAS0Dzcmn5jJFloO8RG1kI/XpkHkndcyWy9RfNW/KUPxnlpqBGgIKAIc2Ag
 rwCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693252541; x=1693857341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GGvxepFjLGp8ahCNZf3OhOljpuMctCwr1Aq27miiOzo=;
 b=j5up57j9zeHUVN6DDiWK8u8F5TgQt5j0AL0aP84wAizDjxBr4EBu60S5OS2zVk6JOY
 zEdQ+PFmmgBdmMs271H2oTIm6QSyHlbPFXOGPdAHYC3nYz9vGRNaadzzwwd0O45opFoV
 s6+0miJAO2jqql3VDiUg2r2e4F9YP9to6nrNKbmlVPfYtOHUknRTVgn5zThGRbRXmMdA
 UtkYOrm/p7HA3tyfSRbK7VNtZk9prPCeDi+G7ftGaETDzyEa3k/sXpWCGddv1IMkwsYZ
 szDgesMTerNUW21KsQPsA6DJDPTwngL4eTE4Gfo3a0XLgASsGuGKHldfgVR2y1Mt2sEs
 dpdQ==
X-Gm-Message-State: AOJu0Yx2KMKEuQkI0Pe/5cUZKsfRNtDSjxVgSdgMCWzuzGt5XQApBNBv
 40e6NJ4a/dW7N7MKewBcwFth1P8qUgi6z+x10VM=
X-Google-Smtp-Source: AGHT+IHMhQ8NVBl0Eqx0BDKypdma3J7ckEOcUjIjrOZqJBsrCNbCLp5J7no73tEACLiuHcJEufdMsw==
X-Received: by 2002:a5d:67c1:0:b0:30e:56b3:60fe with SMTP id
 n1-20020a5d67c1000000b0030e56b360femr367411wrw.4.1693252541485; 
 Mon, 28 Aug 2023 12:55:41 -0700 (PDT)
Received: from localhost.localdomain (adsl-194.37.6.2.tellas.gr. [37.6.2.194])
 by smtp.gmail.com with ESMTPSA id
 l9-20020a056000022900b0031c8a43712asm7529717wrz.69.2023.08.28.12.55.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 12:55:41 -0700 (PDT)
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v8 02/12] Add virtio-sound-pci device
Date: Mon, 28 Aug 2023 22:54:59 +0300
Message-Id: <8de966a86bc21358528eeee66ffe74f8a82bb687.1693252037.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1693252037.git.manos.pitsidianakis@linaro.org>
References: <cover.1693252037.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x433.google.com
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

This patch adds a PCI wrapper device for the virtio-sound device.
It is necessary to instantiate a virtio-snd device in a guest.
All sound logic will be added to the virtio-snd device in the following
commits.

To add this device with a guest, you'll need a >=5.13 kernel compiled
with CONFIG_SND_VIRTIO=y, which at the time of writing most distros have
off by default.

Use with following flags in the invocation:

Pulseaudio:
  -audio driver=pa,model=virtio
  or
  -audio driver=pa,model=virtio,server=/run/user/1000/pulse/native
sdl:
  -audio driver=sdl,model=virtio
coreaudio (macos/darwin):
  -audio driver=coreaudio,model=virtio
etc.

Based-on: https://github.com/OpenSynergy/qemu/commit/5a2f350eec5d157b90d9c7b40a8e603f4da92471
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
Signed-off-by: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/virtio/meson.build      |  1 +
 hw/virtio/virtio-snd-pci.c | 97 ++++++++++++++++++++++++++++++++++++++
 softmmu/qdev-monitor.c     |  1 +
 3 files changed, 99 insertions(+)
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
index 0000000000..a6a530d161
--- /dev/null
+++ b/hw/virtio/virtio-snd-pci.c
@@ -0,0 +1,97 @@
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
+#include "qapi/error.h"
+#include "hw/audio/soundhw.h"
+#include "hw/virtio/virtio-pci.h"
+#include "hw/virtio/virtio-snd.h"
+
+typedef struct VirtIOSoundPCI VirtIOSoundPCI;
+
+/*
+ * virtio-snd-pci: This extends VirtioPCIProxy.
+ */
+#define TYPE_VIRTIO_SND_PCI "virtio-sound-pci"
+DECLARE_INSTANCE_CHECKER(VirtIOSoundPCI, VIRTIO_SND_PCI,
+                         TYPE_VIRTIO_SND_PCI)
+
+struct VirtIOSoundPCI {
+    VirtIOPCIProxy parent;
+    VirtIOSound vdev;
+};
+
+static Property virtio_snd_pci_properties[] = {
+    DEFINE_AUDIO_PROPERTIES(VirtIOSoundPCI, vdev.card),
+    DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
+                    VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
+    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
+                       DEV_NVECTORS_UNSPECIFIED),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void virtio_snd_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
+{
+    VirtIOSoundPCI *dev = VIRTIO_SND_PCI(vpci_dev);
+    DeviceState *vdev = DEVICE(&dev->vdev);
+
+    if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
+        vpci_dev->nvectors = 2;
+    }
+
+    virtio_pci_force_virtio_1(vpci_dev);
+    qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
+}
+
+static void virtio_snd_pci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtioPCIClass *vpciklass = VIRTIO_PCI_CLASS(klass);
+
+    device_class_set_props(dc, virtio_snd_pci_properties);
+    dc->desc = "Virtio Sound";
+    set_bit(DEVICE_CATEGORY_SOUND, dc->categories);
+
+    vpciklass->realize = virtio_snd_pci_realize;
+}
+
+static void virtio_snd_pci_instance_init(Object *obj)
+{
+    VirtIOSoundPCI *dev = VIRTIO_SND_PCI(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VIRTIO_SND);
+}
+
+static const VirtioPCIDeviceTypeInfo virtio_snd_pci_info = {
+    .generic_name  = TYPE_VIRTIO_SND_PCI,
+    .instance_size = sizeof(VirtIOSoundPCI),
+    .instance_init = virtio_snd_pci_instance_init,
+    .class_init    = virtio_snd_pci_class_init,
+};
+
+/* Create a Virtio Sound PCI device, so '-audio driver,model=virtio' works. */
+static int virtio_snd_pci_init(PCIBus *bus, const char *audiodev)
+{
+    DeviceState *dev;
+
+    dev = qdev_new(TYPE_VIRTIO_SND_PCI);
+    qdev_prop_set_string(dev, "audiodev", audiodev);
+    qdev_realize_and_unref(dev, BUS(bus), &error_fatal);
+    return 0;
+}
+
+static void virtio_snd_pci_register(void)
+{
+    virtio_pci_types_register(&virtio_snd_pci_info);
+    pci_register_soundhw("virtio", "Virtio Sound", virtio_snd_pci_init);
+}
+
+type_init(virtio_snd_pci_register);
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


