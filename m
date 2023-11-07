Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5027E3898
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:14:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0J36-0003Df-6v; Tue, 07 Nov 2023 05:11:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J2N-0001Xo-Qo
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:10:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J2H-0002Pg-0I
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:10:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699351812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bn3c/hYXstIUHJ2KWYzhrqPvOR8k4oDFgUxHHIUfAFA=;
 b=Rsri9B6IyYCSajn2J6jkxoFmbuiTEPIdIIXjHzvcFygSFmAae55U8j6BOHcvTgRIYqn2v4
 cr/MHRDQ6ggCvPJ4YSRbRFn3KrzxtCGMKxSpROVS2RgNCMom2TXJdVlDejHjlYEbD7VCHt
 NWN3/6pMo4O8vLOs46f+ILVIkwzhuqc=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-rSxhJevkPOOr5Y5jGBvlhQ-1; Tue, 07 Nov 2023 05:10:11 -0500
X-MC-Unique: rSxhJevkPOOr5Y5jGBvlhQ-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-507d4583c4cso5858604e87.1
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 02:10:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699351809; x=1699956609;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Bn3c/hYXstIUHJ2KWYzhrqPvOR8k4oDFgUxHHIUfAFA=;
 b=pa2EWJkx/BleNwh7Bq04MP81BZLZ0+idHMMbflnxyekDbpoKGb0Rw3ucxeoqaoZTS2
 Fr+OOGsdwFhH26DTPny30RcRIxWXVuiw+CYtd4XzxwCO8wa4sTlAjOziFQrv4kX/eBG+
 pw8BW7ib7GNy0fA+s9M9KADpqH1hxlm/78CXuKwvXx0L9akaesAIrwtnvSPcOacoZI9r
 tPPxn4BLAaiOJ12HQ5gBK2AGuD562FQHImdh+WpREjA/HgOqOwUkxbJix0jwOyqtpw7m
 iQHQbMUAIQonZP4/yA5oL4iIWdp5Waqi8e5f7gOEc5wwKgWazmQ2YLLJUNu4CnfIMLSl
 E20A==
X-Gm-Message-State: AOJu0YwnvuAGPmQLl8mYzkmotMKKJ0fz1s4lyt5MyA49XQdEWVHjgMZs
 uPj567TvJ06HX1nr7nx+Y066IG5kwhjmL3KIuMrIECXI42gIttQ6qfygYrhB8ffdbECoq0dNluK
 Rhy/PNM2PbFuok2Cj3Xrxzd1PZO3A1yKgwVdvTePfyD3ugssLAhD4caRP0yswYhhuPrjf
X-Received: by 2002:a05:6512:230a:b0:508:11c3:c8ca with SMTP id
 o10-20020a056512230a00b0050811c3c8camr29365996lfu.7.1699351809514; 
 Tue, 07 Nov 2023 02:10:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG2PF6rXNhuXAN6HCD9WEIadiSp1b4BH+dCKyzFvyju0fjmqeN9OQYfNgnj8b9244WviioNmw==
X-Received: by 2002:a05:6512:230a:b0:508:11c3:c8ca with SMTP id
 o10-20020a056512230a00b0050811c3c8camr29365969lfu.7.1699351809213; 
 Tue, 07 Nov 2023 02:10:09 -0800 (PST)
Received: from redhat.com ([2.55.5.143]) by smtp.gmail.com with ESMTPSA id
 i11-20020a0560001acb00b0032dde679398sm1923841wry.8.2023.11.07.02.10.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 02:10:08 -0800 (PST)
Date: Tue, 7 Nov 2023 05:10:03 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Igor Skalkin <Igor.Skalkin@opensynergy.com>,
 Anton Yakovlev <Anton.Yakovlev@opensynergy.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 09/63] Add virtio-sound-pci device
Message-ID: <2426908590c1d8d9ffb741c5552ad45d9d3ba9f8.1699351720.git.mst@redhat.com>
References: <cover.1699351720.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1699351720.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

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
Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
Signed-off-by: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <b223598d59f56ead6a6d8d9bb6801e17489ddaa4.1698062525.git.manos.pitsidianakis@linaro.org>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/audio/virtio-snd-pci.c | 93 +++++++++++++++++++++++++++++++++++++++
 system/qdev-monitor.c     |  1 +
 MAINTAINERS               |  1 +
 hw/audio/meson.build      |  1 +
 4 files changed, 96 insertions(+)
 create mode 100644 hw/audio/virtio-snd-pci.c

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
index 3c0aabec4b..a13db763e5 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -112,6 +112,7 @@ static const QDevAlias qdev_alias_table[] = {
     { "virtio-serial-ccw", "virtio-serial", QEMU_ARCH_VIRTIO_CCW },
     { "virtio-serial-pci", "virtio-serial", QEMU_ARCH_VIRTIO_PCI},
     { "virtio-sound-device", "virtio-sound", QEMU_ARCH_VIRTIO_MMIO },
+    { "virtio-sound-pci", "virtio-sound", QEMU_ARCH_VIRTIO_PCI },
     { "virtio-tablet-device", "virtio-tablet", QEMU_ARCH_VIRTIO_MMIO },
     { "virtio-tablet-ccw", "virtio-tablet", QEMU_ARCH_VIRTIO_CCW },
     { "virtio-tablet-pci", "virtio-tablet", QEMU_ARCH_VIRTIO_PCI },
diff --git a/MAINTAINERS b/MAINTAINERS
index d3ee463d21..c09bb8cf41 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2315,6 +2315,7 @@ M: Gerd Hoffmann <kraxel@redhat.com>
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
-- 
MST


