Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A53B7CEA82
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 23:59:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtESe-0001jC-Jv; Wed, 18 Oct 2023 17:52:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtESK-00018l-5z
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:51:57 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtESI-0004QT-1w
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:51:55 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-68fb85afef4so6054511b3a.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 14:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697665912; x=1698270712; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KZ59Wqyg2YQUe4NJ15oFoXlcwSLtPJhdE2Dc4QmCfGA=;
 b=lbLJPekVhsqw9nquZCAM5lJnt5aZjDn3MSwC3xBFQsKqWGUwAupxrjhciasQqsEYPW
 CdB15csPcTYHwoYnUDMSM8iMRLNvzBfbg/xxNDxB1VAl7KyTnU2ut8iInnlhvY31n7Y5
 W3fJB2h5zZbv6A10YfxeCGbJRRrltrrRGiL0mvadRlAYmwOihTjXOn+Wpm+tGviwb11F
 YVB94eQIARzYknGlEdcRYSZ3X/oaHjDqNDsThI07sONJYSkOpDBHSv4tN5tTeqtpL7SP
 y+JWPiy4ilbWy+7EjqSQUgeOfjyQz+mVQGgjvWZUeYDOO+WPJXwyy9lAHp8ui+Z/x+4H
 1BuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697665912; x=1698270712;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KZ59Wqyg2YQUe4NJ15oFoXlcwSLtPJhdE2Dc4QmCfGA=;
 b=GOI5vgsG/eIaTO9YAR2d+0GrSWQni0uNn8RKJk5leZlssnguElnQwmQ8ahnKtmwkig
 ioFufyRsJqPdWFdWfEWIiZwYHsj0nZrRcXD3fJClsba5331UcNH/8xw7yt7coByIxwl1
 BfYBQThzcq4NrYJMH3eOCL5QagH14bBNVLAs6ODDV8aP3CWLUuODKvE1QfxwgCgZD9N0
 2x+ekbJK/5BMe4Aqm/HEA/1NaACM7kOeh3dTMA+3bPyXJ6yqOJR1HutnYmeILSiCSxRS
 zgQf5d9SmKSKSGzQHtNyLhY9WvmPIMwxp2Do47kpPDHYIFZCBcVkyIpCXFGUUT4kogSP
 GD6g==
X-Gm-Message-State: AOJu0YyH4J60dquhHZhRBFio1GNriXCb12xiMltRW/6mRu16/LZTcg1U
 /daxUrS5OetGhGbKhiyG209P+lHgI7fGBq79U1U=
X-Google-Smtp-Source: AGHT+IF2l2C0el29QLejV3GqPiqHM9QsOCkLQ3jn+eiKahehydo+rXlgd+X+N7jx2KKGtKu5NnOAHA==
X-Received: by 2002:a05:6a21:7985:b0:171:c88a:891e with SMTP id
 bh5-20020a056a21798500b00171c88a891emr397623pzc.55.1697665912230; 
 Wed, 18 Oct 2023 14:51:52 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 w17-20020a63f511000000b005b61a024ec7sm2176380pgh.74.2023.10.18.14.51.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 14:51:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 19/61] hw/hppa: Translate phys addresses for the cpu
Date: Wed, 18 Oct 2023 14:50:53 -0700
Message-Id: <20231018215135.1561375-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018215135.1561375-1-richard.henderson@linaro.org>
References: <20231018215135.1561375-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

Hack the machine to use pa2.0 physical layout when required,
using the PSW.W=0 absolute to physical mapping.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/hppa/machine.c | 87 ++++++++++++++++++++++++++++-------------------
 1 file changed, 52 insertions(+), 35 deletions(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 07f8ebeb6a..765f338544 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -81,7 +81,7 @@ static const MemoryRegionOps hppa_pci_ignore_ops = {
     },
 };
 
-static ISABus *hppa_isa_bus(void)
+static ISABus *hppa_isa_bus(hwaddr addr)
 {
     ISABus *isa_bus;
     qemu_irq *isa_irqs;
@@ -90,8 +90,7 @@ static ISABus *hppa_isa_bus(void)
     isa_region = g_new(MemoryRegion, 1);
     memory_region_init_io(isa_region, NULL, &hppa_pci_ignore_ops,
                           NULL, "isa-io", 0x800);
-    memory_region_add_subregion(get_system_memory(), IDE_HPA,
-                                isa_region);
+    memory_region_add_subregion(get_system_memory(), addr, isa_region);
 
     isa_bus = isa_bus_new(NULL, get_system_memory(), isa_region,
                           &error_abort);
@@ -103,7 +102,7 @@ static ISABus *hppa_isa_bus(void)
     return isa_bus;
 }
 
-static uint64_t cpu_hppa_to_phys(void *opaque, uint64_t addr)
+static uint64_t linux_kernel_virt_to_phys(void *opaque, uint64_t addr)
 {
     addr &= (0x10000000 - 1);
     return addr;
@@ -118,13 +117,13 @@ static void fw_cfg_boot_set(void *opaque, const char *boot_device,
     fw_cfg_modify_i16(opaque, FW_CFG_BOOT_DEVICE, boot_device[0]);
 }
 
-static FWCfgState *create_fw_cfg(MachineState *ms)
+static FWCfgState *create_fw_cfg(MachineState *ms, hwaddr addr)
 {
     FWCfgState *fw_cfg;
     uint64_t val;
     const char qemu_version[] = QEMU_VERSION;
 
-    fw_cfg = fw_cfg_init_mem(FW_CFG_IO_BASE, FW_CFG_IO_BASE + 4);
+    fw_cfg = fw_cfg_init_mem(addr, addr + 4);
     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, ms->smp.cpus);
     fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, HPPA_MAX_CPUS);
     fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, ms->ram_size);
@@ -173,6 +172,16 @@ static DinoState *dino_init(MemoryRegion *addr_space)
     return DINO_PCI_HOST_BRIDGE(dev);
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
 static void machine_hppa_init(MachineState *machine)
 {
     const char *kernel_filename = machine->kernel_filename;
@@ -188,20 +197,33 @@ static void machine_hppa_init(MachineState *machine)
     uint64_t kernel_entry = 0, kernel_low, kernel_high;
     MemoryRegion *addr_space = get_system_memory();
     MemoryRegion *rom_region;
-    MemoryRegion *cpu_region;
     long i;
     unsigned int smp_cpus = machine->smp.cpus;
     SysBusDevice *s;
+    uint64_t (*translate)(void *, uint64_t);
 
     /* Create CPUs.  */
     for (i = 0; i < smp_cpus; i++) {
-        char *name = g_strdup_printf("cpu%ld-io-eir", i);
         cpu[i] = HPPA_CPU(cpu_create(machine->cpu_type));
+    }
 
-        cpu_region = g_new(MemoryRegion, 1);
+    /*
+     * For now, treat address layout as if PSW_W is clear.
+     * TODO: create a proper hppa64 board model and load elf64 firmware.
+     */
+    if (cpu[0]->is_pa20) {
+        translate = translate_pa20;
+    } else {
+        translate = translate_pa10;
+    }
+
+    for (i = 0; i < smp_cpus; i++) {
+        char *name = g_strdup_printf("cpu%ld-io-eir", i);
+        MemoryRegion *cpu_region = g_new(MemoryRegion, 1);
         memory_region_init_io(cpu_region, OBJECT(cpu[i]), &hppa_io_eir_ops,
                               cpu[i], name, 4);
-        memory_region_add_subregion(addr_space, CPU_HPA + i * 0x1000,
+        memory_region_add_subregion(addr_space,
+                                    translate(NULL, CPU_HPA + i * 0x1000),
                                     cpu_region);
         g_free(name);
     }
@@ -216,41 +238,41 @@ static void machine_hppa_init(MachineState *machine)
 
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
 
     /* Create ISA bus. */
-    isa_bus = hppa_isa_bus();
+    isa_bus = hppa_isa_bus(translate(NULL, IDE_HPA));
     assert(isa_bus);
 
     /* Realtime clock, used by firmware for PDC_TOD call. */
     mc146818_rtc_init(isa_bus, 2000, NULL);
 
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
 
     /* fw_cfg configuration interface */
-    create_fw_cfg(machine);
+    create_fw_cfg(machine, translate(NULL, FW_CFG_IO_BASE));
 
     /* SCSI disk setup. */
     dev = DEVICE(pci_create_simple(pci_bus, -1, "lsi53c895a"));
@@ -262,13 +284,13 @@ static void machine_hppa_init(MachineState *machine)
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
 
@@ -283,10 +305,11 @@ static void machine_hppa_init(MachineState *machine)
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
                        qdev_get_gpio_in(lasi_dev, LASI_IRQ_PS2KBD_HPA));
-    memory_region_add_subregion(addr_space, LASI_PS2KBD_HPA,
+    memory_region_add_subregion(addr_space, translate(NULL, LASI_PS2KBD_HPA),
                                 sysbus_mmio_get_region(SYS_BUS_DEVICE(dev),
                                                        0));
-    memory_region_add_subregion(addr_space, LASI_PS2KBD_HPA + 0x100,
+    memory_region_add_subregion(addr_space,
+                                translate(NULL, LASI_PS2KBD_HPA + 0x100),
                                 sysbus_mmio_get_region(SYS_BUS_DEVICE(dev),
                                                        1));
 
@@ -303,15 +326,10 @@ static void machine_hppa_init(MachineState *machine)
         exit(1);
     }
 
-    size = load_elf(firmware_filename, NULL, NULL, NULL,
+    size = load_elf(firmware_filename, NULL, translate, NULL,
                     &firmware_entry, &firmware_low, &firmware_high, NULL,
                     true, EM_PARISC, 0, 0);
 
-    /* Unfortunately, load_elf sign-extends reading elf32.  */
-    firmware_entry = (target_ureg)firmware_entry;
-    firmware_low = (target_ureg)firmware_low;
-    firmware_high = (target_ureg)firmware_high;
-
     if (size < 0) {
         error_report("could not load firmware '%s'", firmware_filename);
         exit(1);
@@ -319,7 +337,8 @@ static void machine_hppa_init(MachineState *machine)
     qemu_log_mask(CPU_LOG_PAGE, "Firmware loaded at 0x%08" PRIx64
                   "-0x%08" PRIx64 ", entry at 0x%08" PRIx64 ".\n",
                   firmware_low, firmware_high, firmware_entry);
-    if (firmware_low < FIRMWARE_START || firmware_high >= FIRMWARE_END) {
+    if (firmware_low < translate(NULL, FIRMWARE_START) ||
+        firmware_high >= translate(NULL, FIRMWARE_END)) {
         error_report("Firmware overlaps with memory or IO space");
         exit(1);
     }
@@ -328,18 +347,16 @@ static void machine_hppa_init(MachineState *machine)
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
-        kernel_entry = (target_ureg) cpu_hppa_to_phys(NULL, kernel_entry);
-        kernel_low = (target_ureg)kernel_low;
-        kernel_high = (target_ureg)kernel_high;
+        kernel_entry = linux_kernel_virt_to_phys(NULL, kernel_entry);
 
         if (size < 0) {
             error_report("could not load kernel '%s'", kernel_filename);
-- 
2.34.1


