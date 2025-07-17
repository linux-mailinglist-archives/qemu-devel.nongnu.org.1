Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A559B08A53
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Jul 2025 12:11:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucLZc-0003na-0I; Thu, 17 Jul 2025 06:10:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1ucLZ6-0003dM-I2
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 06:10:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1ucLZ3-0006SO-J1
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 06:10:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752747008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tv08obZSCQsBSzPqnkrtUjXk4cb3giOisHOp+xGiCQM=;
 b=ftOAjDjQ6onNzVHpDxBNMrXOvnhv1UOV/IEFPnFfiIWeu50rgHIIRsQFNxwtgpHjSmVqf/
 r+pu3Fid8Vrs5AdAdCmsbPxMEYgKdyJF1RmpWs3dGNN9AokAPDDChVKj2/d5Ln4VygfXm/
 3KR53FO1UJ1adptuUNTnQ5pmfu3lKCw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-H9ubZ_IUPACRP02TnPGYEg-1; Thu,
 17 Jul 2025 06:10:04 -0400
X-MC-Unique: H9ubZ_IUPACRP02TnPGYEg-1
X-Mimecast-MFC-AGG-ID: H9ubZ_IUPACRP02TnPGYEg_1752747003
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4CE701956088; Thu, 17 Jul 2025 10:10:03 +0000 (UTC)
Received: from virt-mtcollins-01.lab.eng.rdu2.redhat.com
 (virt-mtcollins-01.lab.eng.rdu2.redhat.com [10.8.1.196])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6ED3D180035E; Thu, 17 Jul 2025 10:10:00 +0000 (UTC)
From: Shaoqin Huang <shahuang@redhat.com>
To: qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Eric Auger <eauger@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Shaoqin Huang <shahuang@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Sergio Lopez <slp@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v11 3/3] hw/i386: Add the ramfb romfile compatibility
Date: Thu, 17 Jul 2025 06:09:41 -0400
Message-Id: <20250717100941.2230408-4-shahuang@redhat.com>
In-Reply-To: <20250717100941.2230408-1-shahuang@redhat.com>
References: <20250717100941.2230408-1-shahuang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=shahuang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

ramfb is a sysbus device so it can only used for machine types where it
is explicitly enabled:

  # git grep machine_class_allow_dynamic_sysbus_dev.*TYPE_RAMFB_DEVICE
  hw/arm/virt.c:    machine_class_allow_dynamic_sysbus_dev(mc,
		  TYPE_RAMFB_DEVICE);
  hw/i386/microvm.c:    machine_class_allow_dynamic_sysbus_dev(mc,
		  TYPE_RAMFB_DEVICE);
  hw/i386/pc_piix.c:    machine_class_allow_dynamic_sysbus_dev(m,
		  TYPE_RAMFB_DEVICE);
  hw/i386/pc_q35.c:    machine_class_allow_dynamic_sysbus_dev(m,
		  TYPE_RAMFB_DEVICE);
  hw/loongarch/virt.c:    machine_class_allow_dynamic_sysbus_dev(mc,
		  TYPE_RAMFB_DEVICE);
  hw/riscv/virt.c:    machine_class_allow_dynamic_sysbus_dev(mc,
		  TYPE_RAMFB_DEVICE);

So these six are the only machine types we have to worry about.

The three x86 machine types (pc, q35, microvm) will actually use the rom
(when booting with seabios).

For arm/riscv/loongarch virt we want to disable the rom.

This patch sets ramfb romfile option to false by default, except for x86
machines types (pc, q35, microvm) which need the rom file when booting
with seabios and machine types <= 10.0 (handling the case of arm virt,
for compat reasons).

At the same time, set the "use-legacy-x86-rom" property to true on those
historical versioned machine types in order to avoid the memory layout
being changed.

Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
---
 hw/core/machine.c             |  2 ++
 hw/display/ramfb-standalone.c |  2 +-
 hw/i386/microvm.c             |  3 +++
 hw/i386/pc_piix.c             | 10 ++++++++++
 hw/i386/pc_q35.c              |  3 +++
 hw/vfio/pci.c                 |  2 +-
 6 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index e869821b22..a7043e2a34 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -39,6 +39,8 @@
 
 GlobalProperty hw_compat_10_0[] = {
     { "scsi-hd", "dpofua", "off" },
+    { "ramfb", "use-legacy-x86-rom", "true"},
+    { "vfio-pci", "use-legacy-x86-rom", "true" },
 };
 const size_t hw_compat_10_0_len = G_N_ELEMENTS(hw_compat_10_0);
 
diff --git a/hw/display/ramfb-standalone.c b/hw/display/ramfb-standalone.c
index 82d8c69f89..72b2071aed 100644
--- a/hw/display/ramfb-standalone.c
+++ b/hw/display/ramfb-standalone.c
@@ -64,7 +64,7 @@ static const VMStateDescription ramfb_dev_vmstate = {
 static const Property ramfb_properties[] = {
     DEFINE_PROP_BOOL("x-migrate", RAMFBStandaloneState, migrate,  true),
     DEFINE_PROP_BOOL("use-legacy-x86-rom", RAMFBStandaloneState,
-                     use_legacy_x86_rom, true),
+                     use_legacy_x86_rom, false),
 };
 
 static void ramfb_class_initfn(ObjectClass *klass, const void *data)
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index e0daf0d4fc..d90b69a162 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -49,6 +49,7 @@
 #include "hw/acpi/generic_event_device.h"
 #include "hw/pci-host/gpex.h"
 #include "hw/usb/xhci.h"
+#include "hw/vfio/types.h"
 
 #include "elf.h"
 #include "kvm/kvm_i386.h"
@@ -633,6 +634,8 @@ GlobalProperty microvm_properties[] = {
      * so reserving io space is not going to work.  Turn it off.
      */
     { "pcie-root-port", "io-reserve", "0" },
+    { TYPE_RAMFB_DEVICE, "use-legacy-x86-rom", "true" },
+    { TYPE_VFIO_PCI, "use-legacy-x86-rom", "true" },
 };
 
 static void microvm_class_init(ObjectClass *oc, const void *data)
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index ea7572e783..6b829ad9fb 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -49,6 +49,7 @@
 #include "hw/i2c/smbus_eeprom.h"
 #include "system/memory.h"
 #include "hw/acpi/acpi.h"
+#include "hw/vfio/types.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "system/xen.h"
@@ -77,6 +78,13 @@ static const int ide_iobase2[MAX_IDE_BUS] = { 0x3f6, 0x376 };
 static const int ide_irq[MAX_IDE_BUS] = { 14, 15 };
 #endif
 
+static GlobalProperty pc_piix_compat_defaults[] = {
+    { TYPE_RAMFB_DEVICE, "use-legacy-x86-rom", "true" },
+    { TYPE_VFIO_PCI, "use-legacy-x86-rom", "true" },
+};
+static const size_t pc_piix_compat_defaults_len =
+    G_N_ELEMENTS(pc_piix_compat_defaults);
+
 /*
  * Return the global irq number corresponding to a given device irq
  * pin. We could also use the bus number to have a more precise mapping.
@@ -482,6 +490,8 @@ static void pc_i440fx_machine_options(MachineClass *m)
                                    pc_set_south_bridge);
     object_class_property_set_description(oc, "x-south-bridge",
                                      "Use a different south bridge than PIIX3");
+    compat_props_add(m->compat_props,
+                     pc_piix_compat_defaults, pc_piix_compat_defaults_len);
 }
 
 static void pc_i440fx_machine_10_1_options(MachineClass *m)
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 33211b1876..01f4f73713 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -45,6 +45,7 @@
 #include "hw/i386/pc.h"
 #include "hw/i386/amd_iommu.h"
 #include "hw/i386/intel_iommu.h"
+#include "hw/vfio/types.h"
 #include "hw/virtio/virtio-iommu.h"
 #include "hw/display/ramfb.h"
 #include "hw/ide/pci.h"
@@ -67,6 +68,8 @@
 
 static GlobalProperty pc_q35_compat_defaults[] = {
     { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "39" },
+    { TYPE_RAMFB_DEVICE, "use-legacy-x86-rom", "true" },
+    { TYPE_VFIO_PCI, "use-legacy-x86-rom", "true" },
 };
 static const size_t pc_q35_compat_defaults_len =
     G_N_ELEMENTS(pc_q35_compat_defaults);
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 6547a95ccd..b4923e4710 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3711,7 +3711,7 @@ static const TypeInfo vfio_pci_dev_info = {
 static const Property vfio_pci_dev_nohotplug_properties[] = {
     DEFINE_PROP_BOOL("ramfb", VFIOPCIDevice, enable_ramfb, false),
     DEFINE_PROP_BOOL("use-legacy-x86-rom", VFIOPCIDevice,
-                     use_legacy_x86_rom, true),
+                     use_legacy_x86_rom, false),
     DEFINE_PROP_ON_OFF_AUTO("x-ramfb-migrate", VFIOPCIDevice, ramfb_migrate,
                             ON_OFF_AUTO_AUTO),
 };
-- 
2.40.1


