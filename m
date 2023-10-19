Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44ADA7CF4B5
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 12:07:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtPuW-0004Tq-Lu; Thu, 19 Oct 2023 06:05:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qtPu5-0004LG-Al
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:05:27 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qtPu3-0003Pe-20
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:05:21 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-50797cf5b69so8255167e87.2
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 03:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697709916; x=1698314716; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ipx7XDSBlczboGn3aWGqV/PfmxngKWxT3vd3oOmhsxM=;
 b=Y73uxoINXgoctSO6ABpH4O4sgE9UkbFl4UXoxW6MJ/wB4XjTMKIIjGkDezivtWWWBv
 ZpSMQHFg8irYUIaV6uwhpXrpS8NIhplfmKqe3voz4pdDcUlgSDHjnQTtDCrQjnFvMsYy
 Wq7vF5HajmLruM7JgFuVWlre3k0YoD6c4EezMm3UCoq4P54AtnuMgxhxBqbxhCkSbcPS
 0A8RY68lNuJA5ciYC32U5mjyVvEkzs5DSHQOwqDiMqOfXSKFvO5RIGbrPRHMH2SX+nWF
 Kwa/G1VEwfFGBzjqL5wewCFfKpKxiBRJ+0AN8Nw9Y8QcRrnKkcw2NUhefozud2kvgOV8
 hdQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697709916; x=1698314716;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ipx7XDSBlczboGn3aWGqV/PfmxngKWxT3vd3oOmhsxM=;
 b=r8+VkP5/Ti+p1834YjgGiMoJfY/hDhrPHtlpnsTsuJyhsSpRkaZF1QQOL3mn8EO/B7
 B2u6hUIZCZ0FkTNpZFMCxE/5hdEKvduAh4vvR36f0oiysYLmvY21GFdU6J3/qBBg0QHN
 5YFHYZDBoUIkzRCQtp0X1WMa/GbgB2l64bjv8sKBw7fvVTfKzl2K8pNyUJNvV0V2XTae
 ceZkAoznNnhAoYoIm0lVVYfmmWBpz30ndpzrnJyviVxuJy2TluG/lDgMxdvpGU0CCa+N
 EysjQ5qenlg4Tf0aTRwr8AwVNg2iFKhJAHv+3GUXlpDPAGVFTLniCq7J3RJrqLXBLC7K
 xtlA==
X-Gm-Message-State: AOJu0YwXTXiGX2lHQNbLZ5kvv1gbO1yxtcO7NIg+I8QTubfaaHoV0mLe
 3l7AONUDbbtLnwAsazPOaHV4wUuZitZI8A0QZfU=
X-Google-Smtp-Source: AGHT+IHVzKC+HVhSNVa8B+kLTM3a7DlFUnoLzoQy9qr9g5gH3ijphCcJLHnvtRaqn3TxBIgKYvZ4OA==
X-Received: by 2002:a05:6512:3e21:b0:507:b14e:b10d with SMTP id
 i33-20020a0565123e2100b00507b14eb10dmr1493621lfv.66.1697709916393; 
 Thu, 19 Oct 2023 03:05:16 -0700 (PDT)
Received: from localhost.localdomain (adsl-141.37.6.162.tellas.gr.
 [37.6.162.141]) by smtp.gmail.com with ESMTPSA id
 d13-20020a5d538d000000b003232d122dbfsm4110307wrv.66.2023.10.19.03.05.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 03:05:15 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
	"Gerd Hoffmann" <kraxel@redhat.com>
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Igor Skalkin" <Igor.Skalkin@opensynergy.com>,
 "Anton Yakovlev" <Anton.Yakovlev@opensynergy.com>,
 "Paolo Bonzini" <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Eduardo Habkost" <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?= <DirtY.iCE.hu@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Mark Cave-Ayland" <mark.cave-ayland@ilande.co.uk>,
 "Stefano Garzarella" <sgarzare@redhat.com>
Subject: [PATCH v12 02/11] Add virtio-sound-pci device
Date: Thu, 19 Oct 2023 13:03:46 +0300
Message-Id: <f68a8f30642a95f2a64a943beede32815c43fcdb.1697709630.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697709630.git.manos.pitsidianakis@linaro.org>
References: <cover.1697709630.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x136.google.com
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
 MAINTAINERS               |  1 +
 hw/audio/meson.build      |  1 +
 hw/audio/virtio-snd-pci.c | 93 +++++++++++++++++++++++++++++++++++++++
 system/qdev-monitor.c     |  1 +
 4 files changed, 96 insertions(+)
 create mode 100644 hw/audio/virtio-snd-pci.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 3b7c467280..cd2663ada8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2272,6 +2272,7 @@ M: Gerd Hoffmann <kraxel@redhat.com>
 R: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 S: Supported
 F: hw/audio/virtio-snd.c
+F: hw/audio/virtio-snd-pci.c
 F: include/hw/audio/virtio-snd.h
 
 nvme
diff --git a/hw/audio/meson.build b/hw/audio/meson.build
index 7a503be1fd..2990974449 100644
--- a/hw/audio/meson.build
+++ b/hw/audio/meson.build
@@ -14,3 +14,4 @@ system_ss.add(when: 'CONFIG_SB16', if_true: files('sb16.c'))
 system_ss.add(when: 'CONFIG_VT82C686', if_true: files('via-ac97.c'))
 system_ss.add(when: 'CONFIG_WM8750', if_true: files('wm8750.c'))
 system_ss.add(when: ['CONFIG_VIRTIO_SND', 'CONFIG_VIRTIO'], if_true: files('virtio-snd.c'))
+system_ss.add(when: ['CONFIG_VIRTIO_SND', 'CONFIG_VIRTIO', 'CONFIG_VIRTIO_PCI'], if_true: files('virtio-snd-pci.c'))
diff --git a/hw/audio/virtio-snd-pci.c b/hw/audio/virtio-snd-pci.c
new file mode 100644
index 0000000000..0f92e0752b
--- /dev/null
+++ b/hw/audio/virtio-snd-pci.c
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
+#include "hw/audio/virtio-snd.h"
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
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 1b8005ae55..f007ee6953 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -111,6 +111,7 @@ static const QDevAlias qdev_alias_table[] = {
     { "virtio-serial-device", "virtio-serial", QEMU_ARCH_VIRTIO_MMIO },
     { "virtio-serial-ccw", "virtio-serial", QEMU_ARCH_VIRTIO_CCW },
     { "virtio-serial-pci", "virtio-serial", QEMU_ARCH_VIRTIO_PCI},
+    { "virtio-sound-pci", "virtio-sound", QEMU_ARCH_VIRTIO_PCI},
     { "virtio-tablet-device", "virtio-tablet", QEMU_ARCH_VIRTIO_MMIO },
     { "virtio-tablet-ccw", "virtio-tablet", QEMU_ARCH_VIRTIO_CCW },
     { "virtio-tablet-pci", "virtio-tablet", QEMU_ARCH_VIRTIO_PCI },
-- 
2.39.2


