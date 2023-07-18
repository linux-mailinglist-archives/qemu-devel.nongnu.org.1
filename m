Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B7075841A
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 20:05:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLp4J-0002Te-OU; Tue, 18 Jul 2023 14:05:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qLp4I-0002TV-5K
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 14:05:02 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qLp4A-0003cd-CZ
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 14:05:01 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fbdfda88f4so55053135e9.1
 for <qemu-devel@nongnu.org>; Tue, 18 Jul 2023 11:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689703493; x=1692295493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pvX1gzaCp6IVUg7pYmLy16cx+207MWS651hRae7I0tc=;
 b=m9WfNwrVeIKP01n0ssYSDOvikVoj+BaS0Jj58U5M+2qsf2ZHx0a/0yv/YsEkG3BGWT
 xfmPXltEU+eD8NtkbWIaH0D7jRlGPixi/IiSIGmXj+ulS40LI26lYz0WFc15M+SHIWmG
 CZgAvz0ISropbWbEqxoPF4J1XSTklHKoyfMF4SvSLyai++C9XSFDvidVG4sHZEIH/nep
 /6YfCIQs8Jq21A3xm3lLClVVUysbJ0DMLjvLcPppRjAM9h58ytPHeCH9sK7eTakUmEKT
 qGXISZZkqYCwzKB3lvIQ5eirgVuvqvEJ2j5nm+2AfDLHwzvXUO0+6NvBacPmC8lHJKiE
 m5Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689703493; x=1692295493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pvX1gzaCp6IVUg7pYmLy16cx+207MWS651hRae7I0tc=;
 b=JsQkI//k0oQrjnpfSc8zLMwl00Rii+8KDtPtW+A0cd256tBc8AmmOtJM4/fWPYWBRX
 Jw4bXjYpi4IHpwLbI/CF1I6lycFsmU5e14Wi0gt0iv0CyYPhjKq3SsJhJNQay/aH79mY
 XSVVbJP5rH3MByF5OIgdl504cvYyBv1bPQhf0m6AA3Teri3bYGQmTVf+khpaZ2SAVmBt
 K0abirADuOWLmddCj8xVfnH8DuGuP+Uq6pRWB0rT8c/9KCcWlIgbK2OuOK2VZ9A+t+fY
 mxM2F3cCdbDBxRFQhW7seI8kEoUjThhAJ1npxr/xMS4k6cgCL/hcSq4/S4uHT1ox92Wy
 HGWQ==
X-Gm-Message-State: ABy/qLa4nRSZWYCICl2r8BmhOQvtm04P/H61O6aasad7OFBs7RD2nFO4
 Rh0WIfx63TvRsjJ7ZIJKEUrCb2ASgyYspjLSmB14nyBq
X-Google-Smtp-Source: APBJJlG3G2E2ZlQcwoRTNG7Wsf4I5i6/cGiqNK3oK7eHjCTiXfpfnWgz52pXnEWGWQQW1mTtXQyCHQ==
X-Received: by 2002:a7b:c302:0:b0:3fb:dd5d:76b with SMTP id
 k2-20020a7bc302000000b003fbdd5d076bmr2420673wmj.7.1689703492811; 
 Tue, 18 Jul 2023 11:04:52 -0700 (PDT)
Received: from localhost.localdomain (adsl-17.37.6.3.tellas.gr. [37.6.3.17])
 by smtp.gmail.com with ESMTPSA id
 m9-20020a7bca49000000b003fc17e8a1efsm10764311wml.45.2023.07.18.11.04.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jul 2023 11:04:52 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
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
 "Alex Bennee" <alex.bennee@linaro.org>
Subject: [PATCH v3 2/3] Add virtio-sound-pci device
Date: Tue, 18 Jul 2023 21:04:15 +0300
Message-Id: <36373d92fad69081d3117a3ca59650bd4e2eef0a.1689692765.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1689692765.git.manos.pitsidianakis@linaro.org>
References: <cover.1689692765.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32e.google.com
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

To test this, you'll need a >=5.13 kernel compiled with
CONFIG_SND_VIRTIO=y, which at the time of writing most distros have off
by default.

Use with following flags in the invocation:

  -device virtio-sound-pci,disable-legacy=on

And an audio backend listed with `-audio driver=help` that works on
your host machine, e.g.:

Pulseaudio:
  -audio driver=pa,model=virtio-sound
sdl:
  -audio driver=sdl,model=virtio-sound
coreaudio (macos/darwin):
  -audio driver=coreaudio,model=virtio-sound
etc.

You can use speaker-test from alsa-tools to play noise, sines, or
WAV files.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/virtio/meson.build      |   1 +
 hw/virtio/virtio-snd-pci.c | 101 +++++++++++++++++++++++++++++++++++++
 include/hw/pci/pci.h       |   1 +
 softmmu/qdev-monitor.c     |   1 +
 4 files changed, 104 insertions(+)
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
index 0000000000..44b1edd718
--- /dev/null
+++ b/hw/virtio/virtio-snd-pci.c
@@ -0,0 +1,101 @@
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
+    VirtIOSound *vsnd = VIRTIO_SND(&dev->vdev);
+
+    /*
+     * According to spec, non-legacy virtio PCI devices are always little
+     * endian
+     */
+    vsnd->virtio_access_is_big_endian = false;
+
+
+    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus), errp);
+
+    qdev_prop_set_string(vdev, "audiodev", audiodev_id);
+
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


