Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D48E07C9631
	for <lists+qemu-devel@lfdr.de>; Sat, 14 Oct 2023 21:59:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrkli-00040M-CG; Sat, 14 Oct 2023 15:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qrklc-0003wQ-Bc
 for qemu-devel@nongnu.org; Sat, 14 Oct 2023 15:57:44 -0400
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qrkla-0004eN-AH
 for qemu-devel@nongnu.org; Sat, 14 Oct 2023 15:57:44 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 238ADB80B6F;
 Sat, 14 Oct 2023 19:57:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9901BC433C8;
 Sat, 14 Oct 2023 19:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1697313460;
 bh=TQHUR8r1qpIqcvXzPYWoz5iPRy3IbEhmANhWmoQVc2c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Mv1MAm6co2rgA3Th3Ap0WY4yYpj6eVkMeWbIF2MpLyK38vAWKaf0tjpMYRMH/LA0c
 IKJqhqoK+CwOudSgvyi3zT0VR+APvh8Dyj53XIc9kERGwYVvVYy3/8Y7cnQq7A3lDa
 QXmL+sckO+u9dPZDQ/yhptIfkK+xZXMXa3vwEqOYI4r6qBzPR2NYsZnhu3ZN9JD2sr
 C2vcHvPQELtcVis4ligIqk5aOYs0csTo+k2Qa6fxp1DmSToMnlImJUXZ5DQDTplB2b
 SqV6voNxwECCbzaw83oxrdkX4a7B3UUTKJc5fe0eQ+Kz5Od0cNcD77zhuIBGkMwNmx
 rwCYJwlyhrD5Q==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH 12/12] hw/hppa: Add new HP C3700 machine
Date: Sat, 14 Oct 2023 21:57:19 +0200
Message-ID: <20231014195719.151397-13-deller@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231014195719.151397-1-deller@kernel.org>
References: <20231014195719.151397-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4601:e00::1;
 envelope-from=deller@kernel.org; helo=ams.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

From: Helge Deller <deller@gmx.de>

Add code to create an emulated C3700 machine.
It includes the following components:
- HP Powerbar SP2 Diva BMC card (serial port only)
- PCI 4x serial card (for serial ports #1-#4)
- USB OHCI controller with USB keyboard and USB mouse

Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/hppa/machine.c | 100 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 71087a3f2f..365aa1d508 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -22,8 +22,10 @@
 #include "hw/input/lasips2.h"
 #include "hw/net/lasi_82596.h"
 #include "hw/nmi.h"
+#include "hw/usb.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_device.h"
+#include "hw/pci-host/astro.h"
 #include "hw/pci-host/dino.h"
 #include "hw/misc/lasi.h"
 #include "hppa_hardware.h"
@@ -301,6 +303,7 @@ static void machine_HP_common_init_tail(MachineState *machine)
     const char *initrd_filename = machine->initrd_filename;
     MachineClass *mc = MACHINE_GET_CLASS(machine);
     DeviceState *dev;
+    PCIDevice *pci_dev;
     char *firmware_filename;
     uint64_t firmware_low, firmware_high;
     long size;
@@ -337,6 +340,36 @@ static void machine_HP_common_init_tail(MachineState *machine)
         }
     }
 
+    /* BMC board: HP Powerbar SP2 Diva (with console only) */
+    pci_dev = pci_new(-1, "pci-serial");
+    if (!lasi_dev) {
+        /* bind default keyboard/serial to Diva card */
+        qdev_prop_set_chr(DEVICE(pci_dev), "chardev", serial_hd(0));
+    }
+    qdev_prop_set_uint8(DEVICE(pci_dev), "prog_if", 0);
+    pci_realize_and_unref(pci_dev, pci_bus, &error_fatal);
+    pci_config_set_vendor_id(pci_dev->config, PCI_VENDOR_ID_HP);
+    pci_config_set_device_id(pci_dev->config, 0x1048);
+    pci_set_word(&pci_dev->config[PCI_SUBSYSTEM_VENDOR_ID], PCI_VENDOR_ID_HP);
+    pci_set_word(&pci_dev->config[PCI_SUBSYSTEM_ID], 0x1227); /* Powerbar */
+
+    /* create a second serial PCI card when running Astro */
+    if (!lasi_dev) {
+        pci_dev = pci_new(-1, "pci-serial-4x");
+        qdev_prop_set_chr(DEVICE(pci_dev), "chardev1", serial_hd(1));
+        qdev_prop_set_chr(DEVICE(pci_dev), "chardev2", serial_hd(2));
+        qdev_prop_set_chr(DEVICE(pci_dev), "chardev3", serial_hd(3));
+        qdev_prop_set_chr(DEVICE(pci_dev), "chardev4", serial_hd(4));
+        pci_realize_and_unref(pci_dev, pci_bus, &error_fatal);
+    }
+
+    /* create USB OHCI controller for USB keyboard & mouse on Astro machines */
+    if (!lasi_dev && machine->enable_graphics) {
+        pci_create_simple(pci_bus, -1, "pci-ohci");
+        usb_create_simple(usb_bus_find(-1), "usb-kbd");
+        usb_create_simple(usb_bus_find(-1), "usb-mouse");
+    }
+
     /* register power switch emulation */
     qemu_register_powerdown_notifier(&hppa_system_powerdown_notifier);
 
@@ -520,6 +553,41 @@ static void machine_HP_B160L_init(MachineState *machine)
     machine_HP_common_init_tail(machine);
 }
 
+static AstroState *astro_init(void)
+{
+    DeviceState *dev;
+
+    dev = qdev_new(TYPE_ASTRO_CHIP);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+
+    return ASTRO_CHIP(dev);
+}
+
+/*
+ * Create HP C3700 workstation
+ */
+static void machine_HP_C3700_init(MachineState *machine)
+{
+    AstroState *astro;
+    DeviceState *astro_dev;
+    MemoryRegion *addr_space = get_system_memory();
+
+    /* Create CPUs and RAM.  */
+    machine_HP_common_init_cpus(machine);
+
+    /* Init Astro and the Elroys (PCI host bus chips).  */
+    astro = astro_init();
+    astro_dev = DEVICE(astro);
+    memory_region_add_subregion(addr_space, ASTRO_HPA,
+                                sysbus_mmio_get_region(
+                                    SYS_BUS_DEVICE(astro_dev), 0));
+    pci_bus = PCI_BUS(qdev_get_child_bus(DEVICE(astro->elroy[0]), "pci"));
+    assert(pci_bus);
+
+    /* Add SCSI discs, NICs, graphics & load firmware */
+    machine_HP_common_init_tail(machine);
+}
+
 static void hppa_machine_reset(MachineState *ms, ShutdownCause reason)
 {
     unsigned int smp_cpus = ms->smp.cpus;
@@ -599,9 +667,41 @@ static const TypeInfo HP_B160L_machine_init_typeinfo = {
     },
 };
 
+static void HP_C3700_machine_init_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    NMIClass *nc = NMI_CLASS(oc);
+
+    mc->desc = "HP C3700 workstation";
+    mc->default_cpu_type = TYPE_HPPA_CPU;
+    mc->init = machine_HP_C3700_init;
+    mc->reset = hppa_machine_reset;
+    mc->block_default_type = IF_SCSI;
+    mc->max_cpus = HPPA_MAX_CPUS;
+    mc->default_cpus = 1;
+    mc->is_default = false;
+    mc->default_ram_size = 1024 * MiB;
+    mc->default_boot_order = "cd";
+    mc->default_ram_id = "ram";
+    mc->default_nic = "tulip";
+
+    nc->nmi_monitor_handler = hppa_nmi;
+}
+
+static const TypeInfo HP_C3700_machine_init_typeinfo = {
+    .name = MACHINE_TYPE_NAME("C3700"),
+    .parent = TYPE_MACHINE,
+    .class_init = HP_C3700_machine_init_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_NMI },
+        { }
+    },
+};
+
 static void hppa_machine_init_register_types(void)
 {
     type_register_static(&HP_B160L_machine_init_typeinfo);
+    type_register_static(&HP_C3700_machine_init_typeinfo);
 }
 
 type_init(hppa_machine_init_register_types)
-- 
2.41.0


