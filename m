Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 248417C5702
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 16:37:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqaJm-0000M9-7m; Wed, 11 Oct 2023 10:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qqaJU-0000Fu-In
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:35:56 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qqaJQ-0005O6-V2
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:35:51 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3248ac76acbso6093710f8f.1
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 07:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697034944; x=1697639744; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bdoyLGD8Hh5MRb4py1jwZd/5mvisOOEae55CfDMdmAI=;
 b=nA98+kJI1/vVhYxFEz/45I9jJtEtIJoMw9dhOeyh39JMwptWRGbPsqtsBS5peI8Ftd
 a1K4vaFxb7kZ26ian40Lzhr7iXj/3sTY+5nI84iZ5uIU+2actxGesOEaa47q77w2hCdo
 Xl6VzNrB2s4lP0ookKOQ2RXvrDU2z5rqvb1exLyuZ76dUtz03RhPXACqiKeWfjLymnj7
 +Ahoo7GCVfthgp7fc5w+RAiUJkCB35QpvZeE4nlBHoz/W/jCS5fCsGEji6ADiDbb69u5
 ElNZGCi7NXT0SqmWxev6I6D4cjn4PTcBOEF+jGZxKj8mpjPGfmOLCTX42arG2Jk70Vu4
 g8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697034944; x=1697639744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bdoyLGD8Hh5MRb4py1jwZd/5mvisOOEae55CfDMdmAI=;
 b=K4tWyKGcb5e3aMihiLnCeZZsJcAad6we7IAgnlElVXXQ3fZPb8+SoImrWHnsTFIyp2
 RXk9WQDjwaiuUFUgGYaaC7/64CXlaOhpXSjnHk1W1w7L3iZOqJlfR2jYyc0R6A4zPABt
 EuoofPD3cULQ5+J4Xlaplx/SshyrKbSUpsCKVkOCBrNmf6abb15XMdYcPTWqcqtxoEKo
 OjzzTSrWhVzk3CWL3D5U7QGoD8JYAR/5mO8LWCe8aeG32X4FO6iMKaEzfJxbGHj+O6Db
 Ji2SQZCnlayxP2GxKhW28iufe2Yav2UMz5pVkUFZzOYGm7ok+MV64IGCPfu18VC44EGK
 05fA==
X-Gm-Message-State: AOJu0YwuQvunL2ES4Z08j39GfKLrudlsfBe8cnyQNNuCcZprgPlM+jmN
 IpkAdE8Bjo7SVqAgwLWSCd9/gNf3C7dIJDlHA6w=
X-Google-Smtp-Source: AGHT+IF6oz21uFMzJ3HWqsUH8BjReVhew07F+33+gL9m6gwZx1Aa8971WfRfqXQ7pSPggFqRhqEZaA==
X-Received: by 2002:a5d:6c69:0:b0:32c:eeee:d438 with SMTP id
 r9-20020a5d6c69000000b0032ceeeed438mr5350560wrz.54.1697034944496; 
 Wed, 11 Oct 2023 07:35:44 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 n8-20020a5d4208000000b003253523d767sm15599869wrq.109.2023.10.11.07.35.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 07:35:43 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Google-Original-From: Manos Pitsidianakis <manos@pitsidianak.is>
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
 "Mark Cave-Ayland" <mark.cave-ayland@ilande.co.uk>,
 "Stefano Garzarella" <sgarzare@redhat.com>
Subject: [PATCH v11 02/11] Add virtio-sound-pci device
Date: Wed, 11 Oct 2023 17:34:47 +0300
Message-Id: <ba49f45eb3fa507811131bad03e9a053d59d68f3.1696935992.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1696935992.git.manos.pitsidianakis@linaro.org>
References: <cover.1696935992.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42a.google.com
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

From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>

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
 hw/virtio/meson.build            |  1 +
 hw/virtio/virtio-snd-pci.c (new) | 93 ++++++++++++++++++++++++++++++++
 hw/virtio/virtio-snd.c           | 14 ++++-
 system/qdev-monitor.c            |  1 +
 4 files changed, 107 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index d0572b298c..6233795018 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -67,6 +67,7 @@ virtio_pci_ss.add(when: 'CONFIG_VIRTIO_SERIAL', if_true: files('virtio-serial-pc
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
index adce9f371e..14bc32f476 100644
--- a/hw/virtio/virtio-snd.c
+++ b/hw/virtio/virtio-snd.c
@@ -63,36 +63,46 @@ static void
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
 virtio_snd_set_config(VirtIODevice *vdev, const uint8_t *config)
 {
     VirtIOSound *s = VIRTIO_SND(vdev);
     const virtio_snd_config *sndconfig =
         (const virtio_snd_config *)config;
 
 
    trace_virtio_snd_set_config(vdev,
                                s->snd_conf.jacks,
                                sndconfig->jacks,
                                s->snd_conf.streams,
                                sndconfig->streams,
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
  * Queue handler stub.
  *
  * @vdev: VirtIOSound device
  * @vq: virtqueue
  */
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 74f4e41338..2e9835ad88 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -68,48 +68,49 @@ typedef struct QDevAlias
 /* Please keep this table sorted by typename. */
 static const QDevAlias qdev_alias_table[] = {
     { "AC97", "ac97" }, /* -soundhw name */
     { "e1000", "e1000-82540em" },
     { "ES1370", "es1370" }, /* -soundhw name */
     { "ich9-ahci", "ahci" },
     { "lsi53c895a", "lsi" },
     { "virtio-9p-device", "virtio-9p", QEMU_ARCH_VIRTIO_MMIO },
     { "virtio-9p-ccw", "virtio-9p", QEMU_ARCH_VIRTIO_CCW },
     { "virtio-9p-pci", "virtio-9p", QEMU_ARCH_VIRTIO_PCI },
     { "virtio-balloon-device", "virtio-balloon", QEMU_ARCH_VIRTIO_MMIO },
     { "virtio-balloon-ccw", "virtio-balloon", QEMU_ARCH_VIRTIO_CCW },
     { "virtio-balloon-pci", "virtio-balloon", QEMU_ARCH_VIRTIO_PCI },
     { "virtio-blk-device", "virtio-blk", QEMU_ARCH_VIRTIO_MMIO },
     { "virtio-blk-ccw", "virtio-blk", QEMU_ARCH_VIRTIO_CCW },
     { "virtio-blk-pci", "virtio-blk", QEMU_ARCH_VIRTIO_PCI },
     { "virtio-gpu-device", "virtio-gpu", QEMU_ARCH_VIRTIO_MMIO },
     { "virtio-gpu-ccw", "virtio-gpu", QEMU_ARCH_VIRTIO_CCW },
     { "virtio-gpu-pci", "virtio-gpu", QEMU_ARCH_VIRTIO_PCI },
     { "virtio-gpu-gl-device", "virtio-gpu-gl", QEMU_ARCH_VIRTIO_MMIO },
     { "virtio-gpu-gl-pci", "virtio-gpu-gl", QEMU_ARCH_VIRTIO_PCI },
     { "virtio-input-host-device", "virtio-input-host", QEMU_ARCH_VIRTIO_MMIO },
     { "virtio-input-host-ccw", "virtio-input-host", QEMU_ARCH_VIRTIO_CCW },
     { "virtio-input-host-pci", "virtio-input-host", QEMU_ARCH_VIRTIO_PCI },
     { "virtio-iommu-pci", "virtio-iommu", QEMU_ARCH_VIRTIO_PCI },
     { "virtio-keyboard-device", "virtio-keyboard", QEMU_ARCH_VIRTIO_MMIO },
     { "virtio-keyboard-ccw", "virtio-keyboard", QEMU_ARCH_VIRTIO_CCW },
     { "virtio-keyboard-pci", "virtio-keyboard", QEMU_ARCH_VIRTIO_PCI },
     { "virtio-mouse-device", "virtio-mouse", QEMU_ARCH_VIRTIO_MMIO },
     { "virtio-mouse-ccw", "virtio-mouse", QEMU_ARCH_VIRTIO_CCW },
     { "virtio-mouse-pci", "virtio-mouse", QEMU_ARCH_VIRTIO_PCI },
     { "virtio-net-device", "virtio-net", QEMU_ARCH_VIRTIO_MMIO },
     { "virtio-net-ccw", "virtio-net", QEMU_ARCH_VIRTIO_CCW },
     { "virtio-net-pci", "virtio-net", QEMU_ARCH_VIRTIO_PCI },
     { "virtio-rng-device", "virtio-rng", QEMU_ARCH_VIRTIO_MMIO },
     { "virtio-rng-ccw", "virtio-rng", QEMU_ARCH_VIRTIO_CCW },
     { "virtio-rng-pci", "virtio-rng", QEMU_ARCH_VIRTIO_PCI },
     { "virtio-scsi-device", "virtio-scsi", QEMU_ARCH_VIRTIO_MMIO },
     { "virtio-scsi-ccw", "virtio-scsi", QEMU_ARCH_VIRTIO_CCW },
     { "virtio-scsi-pci", "virtio-scsi", QEMU_ARCH_VIRTIO_PCI },
     { "virtio-serial-device", "virtio-serial", QEMU_ARCH_VIRTIO_MMIO },
     { "virtio-serial-ccw", "virtio-serial", QEMU_ARCH_VIRTIO_CCW },
     { "virtio-serial-pci", "virtio-serial", QEMU_ARCH_VIRTIO_PCI},
+    { "virtio-sound-pci", "virtio-sound", QEMU_ARCH_VIRTIO_PCI},
     { "virtio-tablet-device", "virtio-tablet", QEMU_ARCH_VIRTIO_MMIO },
     { "virtio-tablet-ccw", "virtio-tablet", QEMU_ARCH_VIRTIO_CCW },
     { "virtio-tablet-pci", "virtio-tablet", QEMU_ARCH_VIRTIO_PCI },
     { }
 };
-- 
2.39.2


