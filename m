Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7F4728459
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 17:57:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7I0K-0005Wo-PK; Thu, 08 Jun 2023 11:56:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1q7I0G-0005W3-0E
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 11:56:49 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1q7I0E-0000WQ-8c
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 11:56:47 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3f7e7fc9fe6so7246505e9.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 08:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686239804; x=1688831804;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aybT6UL78NLonUc1tWPB0Kb1vjetHrTvcGJ9R5o8QOQ=;
 b=woM1mNsaRhAvtI9dcTkDW//UceOoCdasijVUJ5+3pAl6pX0Qefn3EeIb8efLcy2g28
 2kkzL6+qiYsyaH1ThPjgKvzhAbQg9QJNFODM/MXHT8Avg688U5JNljQo16cl6sfPn7U3
 /GBVssmo4RITMoi7dkdZWAxmhMX6pzXlq1RsxoEB5kS4uAkkVbgTaiUGOlLmlF2vikBa
 q8hjKL/WYp1NxItiTKLSa5yx2B0iT31q+rBCVdScC/6se8wgndmxTnIQRBeMCI17OHBF
 Rpr61EtHRbHj1ZYjO9JlFjIJP0dUSFz3JuOyTmzmZl2w02dUmLrP0WlIjUMBEzcOI2yN
 HfCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686239804; x=1688831804;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aybT6UL78NLonUc1tWPB0Kb1vjetHrTvcGJ9R5o8QOQ=;
 b=QCnluwukb6yNOjjbr9EZ0At/w/eBpMR713rpgfhyMbiugIOXpzFg/B6YuSsCG1woXG
 EK83khxSJiX3l41x4yBnWt+JVjZr0TH2ezOjDQm6vcDSRsMk7oUNHl3+K0HF4dr0yJ6T
 buqDHRNyTjdl+tNm+G9AqIhsuSvStm58uxn++it4OV+8YX5AsWvrHzSPyx/6/RBxtp+p
 gJLOzAGejsTIhsvyLVgvI8JQggZk2bze/48ecSJgGHP50wGxxpePh/Q7vJ46X/gprXbR
 VWEe0P7dX+shirhE5F6iOCohDEBaqtwrcJGO5WmDi4+/yeN8aHveCv6QUS/cQnjcqqeu
 9lEA==
X-Gm-Message-State: AC+VfDz8ubI+NDb9fx+LEAdxiSamnir+XA5nz4o0OARWHkW5Ne48Ff0J
 uTzxQU/cgj+mFaqHcaDH2b5MyiDYyEqCU5Yp7e4=
X-Google-Smtp-Source: ACHHUZ7LhR/hJ85v7W7Kmd/moO6zC/ZKzSsbgqOzAA0VBsjqSCrheYSMD6gG7Ve2gNB1Yh8CQBNsig==
X-Received: by 2002:a1c:f719:0:b0:3f7:f584:5791 with SMTP id
 v25-20020a1cf719000000b003f7f5845791mr1785035wmh.35.1686239804466; 
 Thu, 08 Jun 2023 08:56:44 -0700 (PDT)
Received: from localhost.localdomain (adsl-175.37.6.3.tellas.gr. [37.6.3.175])
 by smtp.gmail.com with ESMTPSA id
 c17-20020adffb51000000b00307bc4e39e5sm1927105wrs.117.2023.06.08.08.56.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 08:56:44 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Igor Skalkin <Igor.Skalkin@opensynergy.com>,
 Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
Subject: [PATCH v2 2/3] Add virtio-sound-pci device
Date: Thu,  8 Jun 2023 18:56:18 +0300
Message-Id: <db527bc9a1fdb2199a264ffd0d2526ce709a745c.1686238728.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1686238728.git.manos.pitsidianakis@linaro.org>
References: <cover.1686238728.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
---
 hw/virtio/meson.build      |   1 +
 hw/virtio/virtio-snd-pci.c | 102 +++++++++++++++++++++++++++++++++++++
 include/hw/pci/pci.h       |   1 +
 softmmu/qdev-monitor.c     |   1 +
 4 files changed, 105 insertions(+)
 create mode 100644 hw/virtio/virtio-snd-pci.c

diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index 8cf49af618..55d9426415 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -58,6 +58,7 @@ virtio_pci_ss.add(when: 'CONFIG_VIRTIO_SERIAL', if_true: files('virtio-serial-pc
 virtio_pci_ss.add(when: 'CONFIG_VIRTIO_PMEM', if_true: files('virtio-pmem-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VIRTIO_IOMMU', if_true: files('virtio-iommu-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VIRTIO_MEM', if_true: files('virtio-mem-pci.c'))
+virtio_pci_ss.add(when: 'CONFIG_VIRTIO_SND', if_true: files('virtio-snd-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VHOST_VDPA_DEV', if_true: files('vdpa-dev-pci.c'))
 
 specific_virtio_ss.add_all(when: 'CONFIG_VIRTIO_PCI', if_true: virtio_pci_ss)
diff --git a/hw/virtio/virtio-snd-pci.c b/hw/virtio/virtio-snd-pci.c
new file mode 100644
index 0000000000..1a41b53e07
--- /dev/null
+++ b/hw/virtio/virtio-snd-pci.c
@@ -0,0 +1,102 @@
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
+    DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
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
index e6d0574a29..cf4216df81 100644
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
index b8d2c4dadd..49d68495a3 100644
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


