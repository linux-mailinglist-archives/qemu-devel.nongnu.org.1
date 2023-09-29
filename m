Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 836737B3450
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 16:10:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmEBx-0008HN-2L; Fri, 29 Sep 2023 10:10:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qmEBb-0008Fd-Lt
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 10:09:43 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qmEBX-0004GI-0n
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 10:09:43 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-405497850dbso122019415e9.0
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 07:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695996575; x=1696601375; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b4TXUPJpj7FOShB8/2CxA/pwawx+hlQQYL2HyFjt5rQ=;
 b=Ra8HQXQxuZQkY/c3Usid4nV9PBjOZ1AvAKsI6nKQZAwHHq31hs9BFuxMXLZoQQil8a
 Har7G9VAcXiUTDrJ3UH5XaCEGx8D80K+4I8B2oJmfRiAmqq/Z8f2fa9lXI2bm1tvGyfs
 6WoI5bVdP3TowLbblpZr+mtEAoUxyGzVdMTamcAmLQVXSCs9LHpAZKCqOMQcUKsf0bZa
 WUyl40NGHuFyX3cCsQVKI9DBD8Uj9+Cp02YbjSDIkvSeB7mRTtHCE4AfPasv1krYR8mW
 5ZYUIWlPy/gUkinErkZh27qk8ehjJM+5GFilZNKzSGkR9bfKZ3aQlNzTHBBJ8O/JRJKq
 7dIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695996575; x=1696601375;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b4TXUPJpj7FOShB8/2CxA/pwawx+hlQQYL2HyFjt5rQ=;
 b=AZoAF0ZEJFxnUnaHd5J2NN2s21Bi1AbRhvXtQoTmyzX4pzOyahYxRWBHpbhYnpoS3V
 XddV5pEGeqGvHs0vbe86PLerjKVpbtGXVCaUkpXCgLW4NzDasMxrzocpLwSVMIC0Mfth
 PPTg8j/gqVA0bcfmfO22lmfVorR5AhU861JT6jf/CFCnMXmgsKWplaIH0WBVzdkexI6N
 chtQ8Ws0QbPzwBp1wJYsJMqTLf2JB6KOIG7HlBt5ol33HYCKET3dW7tBpR+TM5eUqAXm
 Y2EIwps/lvnF9afQTownDV8tC0yS490onozt19BN/wHTS8CcQzJV/f5G22t1kgS4sJCj
 n7SQ==
X-Gm-Message-State: AOJu0YzwFYLhamW5mWfKmSHswBio7fGnd6G9sc3Du4CYn5R8hEDPHbIY
 PjVIQdhIiESGrIsgFhMK/9GHvvR0+K8X0zl4s6I=
X-Google-Smtp-Source: AGHT+IHoF6H8TTCzI1lJTID3qPPsorttVFobpVFBcjbCWsmhMevR+Bur1VIVeUa4Hk0KOSBphqWIPQ==
X-Received: by 2002:a7b:cc15:0:b0:405:499a:7fc1 with SMTP id
 f21-20020a7bcc15000000b00405499a7fc1mr4065662wmh.40.1695996575059; 
 Fri, 29 Sep 2023 07:09:35 -0700 (PDT)
Received: from localhost.localdomain (adsl-98.37.6.1.tellas.gr. [37.6.1.98])
 by smtp.gmail.com with ESMTPSA id
 y20-20020a7bcd94000000b004030e8ff964sm1505232wmj.34.2023.09.29.07.09.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Sep 2023 07:09:34 -0700 (PDT)
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Mark Cave-Ayland" <mark.cave-ayland@ilande.co.uk>
Subject: [PATCH v10 02/11] Add virtio-sound-pci device
Date: Fri, 29 Sep 2023 17:08:22 +0300
Message-Id: <82138b9c7d11ae2ae3c9bed4a6c51deab2e3fa84.1695996196.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1695996196.git.manos.pitsidianakis@linaro.org>
References: <cover.1695996196.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32b.google.com
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
 hw/virtio/virtio-snd-pci.c | 93 ++++++++++++++++++++++++++++++++++++++
 hw/virtio/virtio-snd.c     | 14 +++++-
 softmmu/qdev-monitor.c     |  1 +
 4 files changed, 107 insertions(+), 2 deletions(-)
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
index 0000000000..afe50a5354
--- /dev/null
+++ b/hw/virtio/virtio-snd-pci.c
@@ -0,0 +1,93 @@
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
+#include "qom/object.h"
+#include "qapi/error.h"
+#include "hw/audio/soundhw.h"
+#include "hw/virtio/virtio-pci.h"
+#include "hw/virtio/virtio-snd.h"
+
+/*
+ * virtio-snd-pci: This extends VirtioPCIProxy.
+ */
+#define TYPE_VIRTIO_SND_PCI "virtio-sound-pci"
+OBJECT_DECLARE_SIMPLE_TYPE(VirtIOSoundPCI, VIRTIO_SND_PCI)
+
+struct VirtIOSoundPCI {
+    VirtIOPCIProxy parent_obj;
+
+    VirtIOSound vdev;
+};
+
+static Property virtio_snd_pci_properties[] = {
+    DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
+                    VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
+    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors, 2),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void virtio_snd_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
+{
+    VirtIOSoundPCI *dev = VIRTIO_SND_PCI(vpci_dev);
+    DeviceState *vdev = DEVICE(&dev->vdev);
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
+    DeviceState *vdev = NULL;
+    VirtIOSoundPCI *dev = NULL;
+
+    vdev = qdev_new(TYPE_VIRTIO_SND_PCI);
+    assert(vdev);
+    dev = VIRTIO_SND_PCI(vdev);
+    qdev_prop_set_string(DEVICE(&dev->vdev), "audiodev", audiodev);
+    qdev_realize_and_unref(vdev, BUS(bus), &error_fatal);
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
diff --git a/hw/virtio/virtio-snd.c b/hw/virtio/virtio-snd.c
index a8204e8a02..46e10ad7e0 100644
--- a/hw/virtio/virtio-snd.c
+++ b/hw/virtio/virtio-snd.c
@@ -63,12 +63,18 @@ static void
 virtio_snd_get_config(VirtIODevice *vdev, uint8_t *config)
 {
     VirtIOSound *s = VIRTIO_SND(vdev);
+    virtio_snd_config *sndconfig =
+        (virtio_snd_config *)config;
     trace_virtio_snd_get_config(vdev,
                                 s->snd_conf.jacks,
                                 s->snd_conf.streams,
                                 s->snd_conf.chmaps);
 
-    memcpy(config, &s->snd_conf, sizeof(s->snd_conf));
+    memcpy(sndconfig, &s->snd_conf, sizeof(s->snd_conf));
+    cpu_to_le32s(&sndconfig->jacks);
+    cpu_to_le32s(&sndconfig->streams);
+    cpu_to_le32s(&sndconfig->chmaps);
+
 }
 
 static void
@@ -87,7 +93,11 @@ virtio_snd_set_config(VirtIODevice *vdev, const uint8_t *config)
                                s->snd_conf.chmaps,
                                sndconfig->chmaps);
 
-    memcpy(&s->snd_conf, sndconfig, sizeof(s->snd_conf));
+    memcpy(&s->snd_conf, sndconfig, sizeof(virtio_snd_config));
+    le32_to_cpus(&s->snd_conf.jacks);
+    le32_to_cpus(&s->snd_conf.streams);
+    le32_to_cpus(&s->snd_conf.chmaps);
+
 }
 
 /*
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


