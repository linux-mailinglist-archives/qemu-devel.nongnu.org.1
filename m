Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F99BEB727
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Oct 2025 22:10:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9qjO-00063Q-SM; Fri, 17 Oct 2025 16:07:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1v9qjM-00062i-Hi
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 16:07:16 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1v9qjK-0005PW-DF
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 16:07:16 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 6833944861;
 Fri, 17 Oct 2025 20:07:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39FD5C4CEFB;
 Fri, 17 Oct 2025 20:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1760731633;
 bh=oi9xzkvSuYKDrJGjOs3SMj0e1CTVQ5BzzhJy4MpbFTc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=a15blxtTBadUf8dSGS4rbaTy5JFMpaS5BIhrLN+OIJQa4O7AzsJphNE4TmG2VdMYr
 rOJ/eHo+6rSGtojJxLVy97eY+q8U3icKlMaCYCbyLs0xLlnTLoV1bmNg5pyWX1P+/O
 glI9KouY0NoVAZafIonj6Mm68guAL+gMMLWIKCB+W5jeSzLoXKFSvBDdzdAfLMdQN2
 T3E5XX19VMphdcojSaGBpTq5I4vZrqMoIGCiMb1/jYvwn3V4caL2WLtZ9z+zFOPAjI
 PNFNZ161YfJlMfkPba99pSC8CuFqjtOfRPAnDA1xaJvIlI/YnlPQWAvrtMeHL+lbSm
 W4EzznfEDKFGg==
From: deller@kernel.org
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Helge Deller <deller@gmx.de>,
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Subject: [PATCH 10/10] hw/hppa: Add 715 machine type including NCR710 SCSI
Date: Fri, 17 Oct 2025 22:06:53 +0200
Message-ID: <20251017200653.23337-11-deller@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017200653.23337-1-deller@kernel.org>
References: <20251017200653.23337-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add a new emulation for a 715/64 machine.
This machines has no PCI bus, and has the majority of the devices (SCSI,
network, serial ports, ...) provided by a LASI multi-function I/O chip.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/hppa/machine.c | 98 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 96 insertions(+), 2 deletions(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 7981a8bb11..9be7c46e6b 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -30,6 +30,8 @@
 #include "hw/pci-host/astro.h"
 #include "hw/pci-host/dino.h"
 #include "hw/misc/lasi.h"
+#include "hw/scsi/ncr53c710.h"
+#include "hw/scsi/lasi_ncr710.h"
 #include "hppa_hardware.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
@@ -363,8 +365,20 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
 
     /* SCSI disk setup. */
     if (drive_get_max_bus(IF_SCSI) >= 0) {
-        dev = DEVICE(pci_create_simple(pci_bus, -1, "lsi53c895a"));
-        lsi53c8xx_handle_legacy_cmdline(dev);
+        if (pci_bus) {
+            dev = DEVICE(pci_create_simple(pci_bus, -1, "lsi53c895a"));
+            lsi53c8xx_handle_legacy_cmdline(dev);
+        } else {
+            dev = lasi_ncr710_init(addr_space,
+                       translate(NULL, LASI_HPA_715 + 0x6000),
+                       qdev_get_gpio_in(lasi_dev, LASI_IRQ_SCSI_HPA));
+            if (dev) {
+                lasi_ncr710_handle_legacy_cmdline(dev);
+            } else {
+                qemu_log("HPPA Machine: Warning - "
+                         "Failed to create LASI NCR710 controller\n");
+            }
+        }
     }
 
     /* Graphics setup. */
@@ -537,6 +551,63 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
     cpu[0]->env.kernel_entry = kernel_entry;
 }
 
+/*
+ * Create HP 715/64 workstation
+ */
+static void machine_HP_715_init(MachineState *machine)
+{
+    DeviceState *dev;
+    MemoryRegion *addr_space = get_system_memory();
+    TranslateFn *translate;
+    ISABus *isa_bus;
+
+    /* Create CPUs and RAM.  */
+    translate = machine_HP_common_init_cpus(machine);
+
+    if (hppa_is_pa20(&cpu[0]->env)) {
+        error_report("The HP 715/64 workstation requires a 32-bit "
+                     "CPU. Use '-machine 715' instead.");
+        exit(1);
+    }
+
+    /* Create ISA bus, needed for PS/2 kbd/mouse port emulation */
+    isa_bus = hppa_isa_bus(translate(NULL, IDE_HPA));
+    assert(isa_bus);
+
+    /* Init Lasi chip */
+    lasi_dev = DEVICE(lasi_init());
+    memory_region_add_subregion(addr_space, translate(NULL, LASI_HPA_715),
+                                sysbus_mmio_get_region(
+                                    SYS_BUS_DEVICE(lasi_dev), 0));
+
+    /* Serial ports: Lasi use a 7.272727 MHz clock. */
+    serial_mm_init(addr_space, translate(NULL, LASI_HPA_715 + LASI_UART + 0x800), 0,
+        qdev_get_gpio_in(lasi_dev, LASI_IRQ_UART_HPA), 7272727 / 16,
+        serial_hd(0), DEVICE_BIG_ENDIAN);
+
+    /* Parallel port */
+    parallel_mm_init(addr_space, translate(NULL, LASI_HPA_715 + LASI_LPT + 0x800), 0,
+                     qdev_get_gpio_in(lasi_dev, LASI_IRQ_LPT_HPA),
+                     parallel_hds[0]);
+
+    /* PS/2 Keyboard/Mouse */
+    dev = qdev_new(TYPE_LASIPS2);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
+                       qdev_get_gpio_in(lasi_dev, LASI_IRQ_PS2KBD_HPA));
+    memory_region_add_subregion(addr_space,
+                                translate(NULL, LASI_HPA_715 + LASI_PS2),
+                                sysbus_mmio_get_region(SYS_BUS_DEVICE(dev),
+                                                       0));
+    memory_region_add_subregion(addr_space,
+                                translate(NULL, LASI_HPA_715 + LASI_PS2 + 0x100),
+                                sysbus_mmio_get_region(SYS_BUS_DEVICE(dev),
+                                                       1));
+
+    /* Add SCSI discs, NICs, graphics & load firmware */
+    machine_HP_common_init_tail(machine, NULL, translate);
+}
+
 /*
  * Create HP B160L workstation
  */
@@ -743,6 +814,25 @@ static void HP_C3700_machine_init_class_init(ObjectClass *oc, const void *data)
     mc->default_ram_size = 1024 * MiB;
 }
 
+static void HP_715_machine_init_class_init(ObjectClass *oc, const void *data)
+{
+    static const char * const valid_cpu_types[] = {
+        TYPE_HPPA_CPU,
+        NULL
+    };
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->desc = "HP 715/64 workstation";
+    mc->default_cpu_type = TYPE_HPPA_CPU;
+    mc->valid_cpu_types = valid_cpu_types;
+    mc->init = machine_HP_715_init;
+    /* can only support up to max. 8 CPUs due inventory major numbers */
+    mc->max_cpus = MIN_CONST(HPPA_MAX_CPUS, 8);
+    mc->default_ram_size = 256 * MiB;
+    mc->default_nic = NULL;
+}
+
+
 static const TypeInfo hppa_machine_types[] = {
     {
         .name           = TYPE_HPPA_COMMON_MACHINE,
@@ -762,6 +852,10 @@ static const TypeInfo hppa_machine_types[] = {
         .name = MACHINE_TYPE_NAME("C3700"),
         .parent = TYPE_HPPA_COMMON_MACHINE,
         .class_init = HP_C3700_machine_init_class_init,
+    }, {
+        .name = MACHINE_TYPE_NAME("715"),
+        .parent = TYPE_HPPA_COMMON_MACHINE,
+        .class_init = HP_715_machine_init_class_init,
     },
 };
 
-- 
2.51.0


