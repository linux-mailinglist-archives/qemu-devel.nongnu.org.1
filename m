Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A13257DEA63
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:48:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMcc-0000FO-9A; Wed, 01 Nov 2023 21:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMbM-0006g6-1T
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:34:29 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMbH-0002AK-C5
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:34:26 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1cc3542e328so3159985ad.1
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698888860; x=1699493660; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3YpfUmyUa6m05sFckuJpc1CvhipgVeCi72arXwnoozE=;
 b=At/ADStd1/6lPJRUV0kNVFFNT98YvsSnr1lMZa4nTLetAMhSgXoRHdlpAsR44va8xo
 qJyD7HjQE/HRzJe7SmYOSs5cMdP6TtXKAqOkklojNtZ/b833wJ5Ike5Al21pF3IrqruD
 iKrNMU8NyHm2VxmF/11v8nyGlNlEa1GQ2bFpNXR6656x62Bd1WF8MFg8OjOn1O2v9tid
 lmBrBalzzV+dQd29NtcBGPlNiRMCWJgqky/kfauuB4zwRXzefzdpwnkMjxwzBlCMnbrA
 NGHiwHPioFM3MGo7sWL9csn8jWaCOyLEOZmSdHgWMrUIDtsmE1+zSxO1FXrj2AOGY4FD
 zfDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698888860; x=1699493660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3YpfUmyUa6m05sFckuJpc1CvhipgVeCi72arXwnoozE=;
 b=svBE8Vi2VpH0WxLZFfT8tajLgKSKwOIhBGHSXVl+fCjQpURcl4GUTxa5QJLv94i3H4
 uiOCPUPeVUIk7ftumdnoJd1pvLM94Hc3yjcBMFFR84jE8YZswlfI+TZfj/W/Rj+LQitg
 V+jJPIry8qh5smFskLr1mM2y/+xdgKhQ0epYnGT3LHhdJztO+0nN0kj1KOcdVhS1DVbv
 m74ZihNosxTxivtEL32tc772L3FpFzXLHXZaiTc9eJqlaWv7xKTpS2+k6MJPof1Bw/ZN
 uHrpsSZPog8GvMJoli0szAUqmLFneCX3RBz07b4bMipm1KosLGLT8gq+gq1hTfep83hI
 Prfg==
X-Gm-Message-State: AOJu0YzTN+SrMWW7rhGZxz7zXL/NgiTz11s7U9xb9RAAOPrEUFz3FgzM
 j62EQhq3n0cjZDZI0Alkj7JbLeFmNUSVjZ6LXxM=
X-Google-Smtp-Source: AGHT+IFwmOLKAE+DrmM/rwc6Yiz+0sKvEMMXS4Q+h7+Ki4WJI1Fw1Hgl46umP2RSnAOTa8XKIt+DyA==
X-Received: by 2002:a17:902:f093:b0:1cc:3932:4a95 with SMTP id
 p19-20020a170902f09300b001cc39324a95mr8389998pla.62.1698888860459; 
 Wed, 01 Nov 2023 18:34:20 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 t2-20020a1709027fc200b001a98f844e60sm1918125plb.263.2023.11.01.18.34.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:34:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 74/88] hw/hppa: Translate phys addresses for the cpu
Date: Wed,  1 Nov 2023 18:30:02 -0700
Message-Id: <20231102013016.369010-75-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Hack the machine to use pa2.0 physical layout when required,
using the PSW.W=0 absolute to physical mapping.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/hppa/machine.c | 117 ++++++++++++++++++++++++++++------------------
 1 file changed, 71 insertions(+), 46 deletions(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 1f09b4b490..43c7afb89d 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -87,7 +87,7 @@ static const MemoryRegionOps hppa_pci_ignore_ops = {
     },
 };
 
-static ISABus *hppa_isa_bus(void)
+static ISABus *hppa_isa_bus(hwaddr addr)
 {
     ISABus *isa_bus;
     qemu_irq *isa_irqs;
@@ -96,8 +96,7 @@ static ISABus *hppa_isa_bus(void)
     isa_region = g_new(MemoryRegion, 1);
     memory_region_init_io(isa_region, NULL, &hppa_pci_ignore_ops,
                           NULL, "isa-io", 0x800);
-    memory_region_add_subregion(get_system_memory(), IDE_HPA,
-                                isa_region);
+    memory_region_add_subregion(get_system_memory(), addr, isa_region);
 
     isa_bus = isa_bus_new(NULL, get_system_memory(), isa_region,
                           &error_abort);
@@ -163,13 +162,24 @@ static const MemoryRegionOps hppa_io_helper_ops = {
     },
 };
 
+typedef uint64_t TranslateFn(void *opaque, uint64_t addr);
 
-static uint64_t cpu_hppa_to_phys(void *opaque, uint64_t addr)
+static uint64_t linux_kernel_virt_to_phys(void *opaque, uint64_t addr)
 {
     addr &= (0x10000000 - 1);
     return addr;
 }
 
+static uint64_t translate_pa10(void *dummy, uint64_t addr)
+{
+    return (uint32_t)addr;
+}
+
+static uint64_t translate_pa20(void *dummy, uint64_t addr)
+{
+    return hppa_abs_to_phys_pa2_w0(addr);
+}
+
 static HPPACPU *cpu[HPPA_MAX_CPUS];
 static uint64_t firmware_entry;
 
@@ -179,7 +189,8 @@ static void fw_cfg_boot_set(void *opaque, const char *boot_device,
     fw_cfg_modify_i16(opaque, FW_CFG_BOOT_DEVICE, boot_device[0]);
 }
 
-static FWCfgState *create_fw_cfg(MachineState *ms, PCIBus *pci_bus)
+static FWCfgState *create_fw_cfg(MachineState *ms, PCIBus *pci_bus,
+                                 hwaddr addr)
 {
     FWCfgState *fw_cfg;
     uint64_t val;
@@ -188,7 +199,7 @@ static FWCfgState *create_fw_cfg(MachineState *ms, PCIBus *pci_bus)
     int btlb_entries = HPPA_BTLB_ENTRIES(&cpu[0]->env);
     int len;
 
-    fw_cfg = fw_cfg_init_mem(FW_CFG_IO_BASE, FW_CFG_IO_BASE + 4);
+    fw_cfg = fw_cfg_init_mem(addr, addr + 4);
     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, ms->smp.cpus);
     fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, HPPA_MAX_CPUS);
     fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, ms->ram_size);
@@ -258,32 +269,45 @@ static DinoState *dino_init(MemoryRegion *addr_space)
 /*
  * Step 1: Create CPUs and Memory
  */
-static void machine_HP_common_init_cpus(MachineState *machine)
+static TranslateFn *machine_HP_common_init_cpus(MachineState *machine)
 {
     MemoryRegion *addr_space = get_system_memory();
-    MemoryRegion *cpu_region;
-    long i;
     unsigned int smp_cpus = machine->smp.cpus;
-    char *name;
+    TranslateFn *translate;
+    MemoryRegion *cpu_region;
 
     /* Create CPUs.  */
-    for (i = 0; i < smp_cpus; i++) {
-        name = g_strdup_printf("cpu%ld-io-eir", i);
+    for (unsigned int i = 0; i < smp_cpus; i++) {
         cpu[i] = HPPA_CPU(cpu_create(machine->cpu_type));
+    }
+
+    /*
+     * For now, treat address layout as if PSW_W is clear.
+     * TODO: create a proper hppa64 board model and load elf64 firmware.
+     */
+    if (hppa_is_pa20(&cpu[0]->env)) {
+        translate = translate_pa20;
+    } else {
+        translate = translate_pa10;
+    }
+
+    for (unsigned int i = 0; i < smp_cpus; i++) {
+        g_autofree char *name = g_strdup_printf("cpu%u-io-eir", i);
 
         cpu_region = g_new(MemoryRegion, 1);
         memory_region_init_io(cpu_region, OBJECT(cpu[i]), &hppa_io_eir_ops,
                               cpu[i], name, 4);
-        memory_region_add_subregion(addr_space, CPU_HPA + i * 0x1000,
+        memory_region_add_subregion(addr_space,
+                                    translate(NULL, CPU_HPA + i * 0x1000),
                                     cpu_region);
-        g_free(name);
     }
 
     /* RTC and DebugOutputPort on CPU #0 */
     cpu_region = g_new(MemoryRegion, 1);
     memory_region_init_io(cpu_region, OBJECT(cpu[0]), &hppa_io_helper_ops,
                           cpu[0], "cpu0-io-rtc", 2 * sizeof(uint64_t));
-    memory_region_add_subregion(addr_space, CPU_HPA + 16, cpu_region);
+    memory_region_add_subregion(addr_space, translate(NULL, CPU_HPA + 16),
+                                cpu_region);
 
     /* Main memory region. */
     if (machine->ram_size > 3 * GiB) {
@@ -291,12 +315,15 @@ static void machine_HP_common_init_cpus(MachineState *machine)
         exit(EXIT_FAILURE);
     }
     memory_region_add_subregion_overlap(addr_space, 0, machine->ram, -1);
+
+    return translate;
 }
 
 /*
  * Last creation step: Add SCSI discs, NICs, graphics & load firmware
  */
-static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus)
+static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
+                                        TranslateFn *translate)
 {
     const char *kernel_filename = machine->kernel_filename;
     const char *kernel_cmdline = machine->kernel_cmdline;
@@ -324,13 +351,13 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus)
         dev = qdev_new("artist");
         s = SYS_BUS_DEVICE(dev);
         sysbus_realize_and_unref(s, &error_fatal);
-        sysbus_mmio_map(s, 0, LASI_GFX_HPA);
-        sysbus_mmio_map(s, 1, ARTIST_FB_ADDR);
+        sysbus_mmio_map(s, 0, translate(NULL, LASI_GFX_HPA));
+        sysbus_mmio_map(s, 1, translate(NULL, ARTIST_FB_ADDR));
     }
 
     /* Network setup. */
     if (enable_lasi_lan()) {
-        lasi_82596_init(addr_space, LASI_LAN_HPA,
+        lasi_82596_init(addr_space, translate(NULL, LASI_LAN_HPA),
                         qdev_get_gpio_in(lasi_dev, LASI_IRQ_LAN_HPA));
     }
 
@@ -374,7 +401,7 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus)
     qemu_register_powerdown_notifier(&hppa_system_powerdown_notifier);
 
     /* fw_cfg configuration interface */
-    create_fw_cfg(machine, pci_bus);
+    create_fw_cfg(machine, pci_bus, translate(NULL, FW_CFG_IO_BASE));
 
     /* Load firmware.  Given that this is not "real" firmware,
        but one explicitly written for the emulation, we might as
@@ -386,15 +413,10 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus)
         exit(1);
     }
 
-    size = load_elf(firmware_filename, NULL, NULL, NULL,
+    size = load_elf(firmware_filename, NULL, translate, NULL,
                     &firmware_entry, &firmware_low, &firmware_high, NULL,
                     true, EM_PARISC, 0, 0);
 
-    /* Unfortunately, load_elf sign-extends reading elf32.  */
-    firmware_entry = (uint32_t)firmware_entry;
-    firmware_low = (uint32_t)firmware_low;
-    firmware_high = (uint32_t)firmware_high;
-
     if (size < 0) {
         error_report("could not load firmware '%s'", firmware_filename);
         exit(1);
@@ -402,7 +424,8 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus)
     qemu_log_mask(CPU_LOG_PAGE, "Firmware loaded at 0x%08" PRIx64
                   "-0x%08" PRIx64 ", entry at 0x%08" PRIx64 ".\n",
                   firmware_low, firmware_high, firmware_entry);
-    if (firmware_low < FIRMWARE_START || firmware_high >= FIRMWARE_END) {
+    if (firmware_low < translate(NULL, FIRMWARE_START) ||
+        firmware_high >= translate(NULL, FIRMWARE_END)) {
         error_report("Firmware overlaps with memory or IO space");
         exit(1);
     }
@@ -411,18 +434,16 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus)
     rom_region = g_new(MemoryRegion, 1);
     memory_region_init_ram(rom_region, NULL, "firmware",
                            (FIRMWARE_END - FIRMWARE_START), &error_fatal);
-    memory_region_add_subregion(addr_space, FIRMWARE_START, rom_region);
+    memory_region_add_subregion(addr_space,
+                                translate(NULL, FIRMWARE_START), rom_region);
 
     /* Load kernel */
     if (kernel_filename) {
-        size = load_elf(kernel_filename, NULL, &cpu_hppa_to_phys,
+        size = load_elf(kernel_filename, NULL, linux_kernel_virt_to_phys,
                         NULL, &kernel_entry, &kernel_low, &kernel_high, NULL,
                         true, EM_PARISC, 0, 0);
 
-        /* Unfortunately, load_elf sign-extends reading elf32.  */
-        kernel_entry = (uint32_t) cpu_hppa_to_phys(NULL, kernel_entry);
-        kernel_low = (uint32_t)kernel_low;
-        kernel_high = (uint32_t)kernel_high;
+        kernel_entry = linux_kernel_virt_to_phys(NULL, kernel_entry);
 
         if (size < 0) {
             error_report("could not load kernel '%s'", kernel_filename);
@@ -500,41 +521,42 @@ static void machine_HP_B160L_init(MachineState *machine)
 {
     DeviceState *dev, *dino_dev;
     MemoryRegion *addr_space = get_system_memory();
+    TranslateFn *translate;
     ISABus *isa_bus;
     PCIBus *pci_bus;
 
     /* Create CPUs and RAM.  */
-    machine_HP_common_init_cpus(machine);
+    translate = machine_HP_common_init_cpus(machine);
 
     /* Init Lasi chip */
     lasi_dev = DEVICE(lasi_init());
-    memory_region_add_subregion(addr_space, LASI_HPA,
+    memory_region_add_subregion(addr_space, translate(NULL, LASI_HPA),
                                 sysbus_mmio_get_region(
                                     SYS_BUS_DEVICE(lasi_dev), 0));
 
     /* Init Dino (PCI host bus chip).  */
     dino_dev = DEVICE(dino_init(addr_space));
-    memory_region_add_subregion(addr_space, DINO_HPA,
+    memory_region_add_subregion(addr_space, translate(NULL, DINO_HPA),
                                 sysbus_mmio_get_region(
                                     SYS_BUS_DEVICE(dino_dev), 0));
     pci_bus = PCI_BUS(qdev_get_child_bus(dino_dev, "pci"));
     assert(pci_bus);
 
     /* Create ISA bus, needed for PS/2 kbd/mouse port emulation */
-    isa_bus = hppa_isa_bus();
+    isa_bus = hppa_isa_bus(translate(NULL, IDE_HPA));
     assert(isa_bus);
 
     /* Serial ports: Lasi and Dino use a 7.272727 MHz clock. */
-    serial_mm_init(addr_space, LASI_UART_HPA + 0x800, 0,
+    serial_mm_init(addr_space, translate(NULL, LASI_UART_HPA + 0x800), 0,
         qdev_get_gpio_in(lasi_dev, LASI_IRQ_UART_HPA), 7272727 / 16,
         serial_hd(0), DEVICE_BIG_ENDIAN);
 
-    serial_mm_init(addr_space, DINO_UART_HPA + 0x800, 0,
+    serial_mm_init(addr_space, translate(NULL, DINO_UART_HPA + 0x800), 0,
         qdev_get_gpio_in(dino_dev, DINO_IRQ_RS232INT), 7272727 / 16,
         serial_hd(1), DEVICE_BIG_ENDIAN);
 
     /* Parallel port */
-    parallel_mm_init(addr_space, LASI_LPT_HPA + 0x800, 0,
+    parallel_mm_init(addr_space, translate(NULL, LASI_LPT_HPA + 0x800), 0,
                      qdev_get_gpio_in(lasi_dev, LASI_IRQ_LAN_HPA),
                      parallel_hds[0]);
 
@@ -543,15 +565,17 @@ static void machine_HP_B160L_init(MachineState *machine)
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
                        qdev_get_gpio_in(lasi_dev, LASI_IRQ_PS2KBD_HPA));
-    memory_region_add_subregion(addr_space, LASI_PS2KBD_HPA,
+    memory_region_add_subregion(addr_space,
+                                translate(NULL, LASI_PS2KBD_HPA),
                                 sysbus_mmio_get_region(SYS_BUS_DEVICE(dev),
                                                        0));
-    memory_region_add_subregion(addr_space, LASI_PS2KBD_HPA + 0x100,
+    memory_region_add_subregion(addr_space,
+                                translate(NULL, LASI_PS2KBD_HPA + 0x100),
                                 sysbus_mmio_get_region(SYS_BUS_DEVICE(dev),
                                                        1));
 
     /* Add SCSI discs, NICs, graphics & load firmware */
-    machine_HP_common_init_tail(machine, pci_bus);
+    machine_HP_common_init_tail(machine, pci_bus, translate);
 }
 
 static AstroState *astro_init(void)
@@ -573,21 +597,22 @@ static void machine_HP_C3700_init(MachineState *machine)
     AstroState *astro;
     DeviceState *astro_dev;
     MemoryRegion *addr_space = get_system_memory();
+    TranslateFn *translate;
 
     /* Create CPUs and RAM.  */
-    machine_HP_common_init_cpus(machine);
+    translate = machine_HP_common_init_cpus(machine);
 
     /* Init Astro and the Elroys (PCI host bus chips).  */
     astro = astro_init();
     astro_dev = DEVICE(astro);
-    memory_region_add_subregion(addr_space, ASTRO_HPA,
+    memory_region_add_subregion(addr_space, translate(NULL, ASTRO_HPA),
                                 sysbus_mmio_get_region(
                                     SYS_BUS_DEVICE(astro_dev), 0));
     pci_bus = PCI_BUS(qdev_get_child_bus(DEVICE(astro->elroy[0]), "pci"));
     assert(pci_bus);
 
     /* Add SCSI discs, NICs, graphics & load firmware */
-    machine_HP_common_init_tail(machine, pci_bus);
+    machine_HP_common_init_tail(machine, pci_bus, translate);
 }
 
 static void hppa_machine_reset(MachineState *ms, ShutdownCause reason)
-- 
2.34.1


