Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 530D58BF4DD
	for <lists+qemu-devel@lfdr.de>; Wed,  8 May 2024 05:12:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4XiK-00011z-O2; Tue, 07 May 2024 23:11:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1s4XiG-00010h-Rc
 for qemu-devel@nongnu.org; Tue, 07 May 2024 23:11:24 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1s4Xi9-0006yc-Ef
 for qemu-devel@nongnu.org; Tue, 07 May 2024 23:11:24 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8BxtOpR7TpmzjAJAA--.12447S3;
 Wed, 08 May 2024 11:11:13 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxKORO7Tpm9hkVAA--.41182S4; 
 Wed, 08 May 2024 11:11:11 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v4 2/5] hw/loongarch: Rename LoongArchMachineState with
 LoongArchVirtMachineState
Date: Wed,  8 May 2024 11:11:07 +0800
Message-Id: <20240508031110.2507477-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240508031110.2507477-1-maobibo@loongson.cn>
References: <20240508031110.2507477-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxKORO7Tpm9hkVAA--.41182S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

Rename LoongArchMachineState with LoongArchVirtMachineState, and change
variable name LoongArchMachineState *lams with LoongArchVirtMachineState
*lvms.

Rename function specific for virtmachine loongarch_xxx()
with virt_xxx(). However some common functions keep unchanged such as
loongarch_acpi_setup()/loongarch_load_kernel(), since there functions
can be used for real hw boards.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/loongarch/acpi-build.c   |  89 +++++-----
 hw/loongarch/boot.c         |  10 +-
 hw/loongarch/fw_cfg.c       |   2 +-
 hw/loongarch/fw_cfg.h       |   2 +-
 hw/loongarch/virt.c         | 340 ++++++++++++++++++------------------
 include/hw/loongarch/virt.h |   7 +-
 6 files changed, 226 insertions(+), 224 deletions(-)

diff --git a/hw/loongarch/acpi-build.c b/hw/loongarch/acpi-build.c
index c7150cc0c4..5ef010d4da 100644
--- a/hw/loongarch/acpi-build.c
+++ b/hw/loongarch/acpi-build.c
@@ -105,14 +105,15 @@ build_facs(GArray *table_data)
 
 /* build MADT */
 static void
-build_madt(GArray *table_data, BIOSLinker *linker, LoongArchMachineState *lams)
+build_madt(GArray *table_data, BIOSLinker *linker,
+           LoongArchVirtMachineState *lvms)
 {
-    MachineState *ms = MACHINE(lams);
+    MachineState *ms = MACHINE(lvms);
     MachineClass *mc = MACHINE_GET_CLASS(ms);
     const CPUArchIdList *arch_ids = mc->possible_cpu_arch_ids(ms);
     int i, arch_id;
-    AcpiTable table = { .sig = "APIC", .rev = 1, .oem_id = lams->oem_id,
-                        .oem_table_id = lams->oem_table_id };
+    AcpiTable table = { .sig = "APIC", .rev = 1, .oem_id = lvms->oem_id,
+                        .oem_table_id = lvms->oem_table_id };
 
     acpi_table_begin(&table, table_data);
 
@@ -167,11 +168,11 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
     int i, arch_id, node_id;
     uint64_t mem_len, mem_base;
     int nb_numa_nodes = machine->numa_state->num_nodes;
-    LoongArchMachineState *lams = LOONGARCH_VIRT_MACHINE(machine);
-    MachineClass *mc = MACHINE_GET_CLASS(lams);
+    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(machine);
+    MachineClass *mc = MACHINE_GET_CLASS(lvms);
     const CPUArchIdList *arch_ids = mc->possible_cpu_arch_ids(machine);
-    AcpiTable table = { .sig = "SRAT", .rev = 1, .oem_id = lams->oem_id,
-                        .oem_table_id = lams->oem_table_id };
+    AcpiTable table = { .sig = "SRAT", .rev = 1, .oem_id = lvms->oem_id,
+                        .oem_table_id = lvms->oem_table_id };
 
     acpi_table_begin(&table, table_data);
     build_append_int_noprefix(table_data, 1, 4); /* Reserved */
@@ -279,13 +280,13 @@ static void
 build_la_ged_aml(Aml *dsdt, MachineState *machine)
 {
     uint32_t event;
-    LoongArchMachineState *lams = LOONGARCH_VIRT_MACHINE(machine);
+    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(machine);
 
     build_ged_aml(dsdt, "\\_SB."GED_DEVICE,
-                  HOTPLUG_HANDLER(lams->acpi_ged),
+                  HOTPLUG_HANDLER(lvms->acpi_ged),
                   VIRT_SCI_IRQ, AML_SYSTEM_MEMORY,
                   VIRT_GED_EVT_ADDR);
-    event = object_property_get_uint(OBJECT(lams->acpi_ged),
+    event = object_property_get_uint(OBJECT(lvms->acpi_ged),
                                      "ged-event", &error_abort);
     if (event & ACPI_GED_MEM_HOTPLUG_EVT) {
         build_memory_hotplug_aml(dsdt, machine->ram_slots, "\\_SB", NULL,
@@ -295,7 +296,7 @@ build_la_ged_aml(Aml *dsdt, MachineState *machine)
     acpi_dsdt_add_power_button(dsdt);
 }
 
-static void build_pci_device_aml(Aml *scope, LoongArchMachineState *lams)
+static void build_pci_device_aml(Aml *scope, LoongArchVirtMachineState *lvms)
 {
     struct GPEXConfig cfg = {
         .mmio64.base = VIRT_PCI_MEM_BASE,
@@ -305,13 +306,13 @@ static void build_pci_device_aml(Aml *scope, LoongArchMachineState *lams)
         .ecam.base   = VIRT_PCI_CFG_BASE,
         .ecam.size   = VIRT_PCI_CFG_SIZE,
         .irq         = VIRT_GSI_BASE + VIRT_DEVICE_IRQS,
-        .bus         = lams->pci_bus,
+        .bus         = lvms->pci_bus,
     };
 
     acpi_dsdt_add_gpex(scope, &cfg);
 }
 
-static void build_flash_aml(Aml *scope, LoongArchMachineState *lams)
+static void build_flash_aml(Aml *scope, LoongArchVirtMachineState *lvms)
 {
     Aml *dev, *crs;
     MemoryRegion *flash_mem;
@@ -322,11 +323,11 @@ static void build_flash_aml(Aml *scope, LoongArchMachineState *lams)
     hwaddr flash1_base;
     hwaddr flash1_size;
 
-    flash_mem = pflash_cfi01_get_memory(lams->flash[0]);
+    flash_mem = pflash_cfi01_get_memory(lvms->flash[0]);
     flash0_base = flash_mem->addr;
     flash0_size = memory_region_size(flash_mem);
 
-    flash_mem = pflash_cfi01_get_memory(lams->flash[1]);
+    flash_mem = pflash_cfi01_get_memory(lvms->flash[1]);
     flash1_base = flash_mem->addr;
     flash1_size = memory_region_size(flash_mem);
 
@@ -352,7 +353,7 @@ static void build_flash_aml(Aml *scope, LoongArchMachineState *lams)
 }
 
 #ifdef CONFIG_TPM
-static void acpi_dsdt_add_tpm(Aml *scope, LoongArchMachineState *vms)
+static void acpi_dsdt_add_tpm(Aml *scope, LoongArchVirtMachineState *vms)
 {
     PlatformBusDevice *pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
     hwaddr pbus_base = VIRT_PLATFORM_BUS_BASEADDRESS;
@@ -391,18 +392,18 @@ static void
 build_dsdt(GArray *table_data, BIOSLinker *linker, MachineState *machine)
 {
     Aml *dsdt, *scope, *pkg;
-    LoongArchMachineState *lams = LOONGARCH_VIRT_MACHINE(machine);
-    AcpiTable table = { .sig = "DSDT", .rev = 1, .oem_id = lams->oem_id,
-                        .oem_table_id = lams->oem_table_id };
+    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(machine);
+    AcpiTable table = { .sig = "DSDT", .rev = 1, .oem_id = lvms->oem_id,
+                        .oem_table_id = lvms->oem_table_id };
 
     acpi_table_begin(&table, table_data);
     dsdt = init_aml_allocator();
     build_uart_device_aml(dsdt);
-    build_pci_device_aml(dsdt, lams);
+    build_pci_device_aml(dsdt, lvms);
     build_la_ged_aml(dsdt, machine);
-    build_flash_aml(dsdt, lams);
+    build_flash_aml(dsdt, lvms);
 #ifdef CONFIG_TPM
-    acpi_dsdt_add_tpm(dsdt, lams);
+    acpi_dsdt_add_tpm(dsdt, lvms);
 #endif
     /* System State Package */
     scope = aml_scope("\\");
@@ -421,7 +422,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, MachineState *machine)
 
 static void acpi_build(AcpiBuildTables *tables, MachineState *machine)
 {
-    LoongArchMachineState *lams = LOONGARCH_VIRT_MACHINE(machine);
+    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(machine);
     GArray *table_offsets;
     AcpiFadtData fadt_data;
     unsigned facs, rsdt, dsdt;
@@ -455,14 +456,14 @@ static void acpi_build(AcpiBuildTables *tables, MachineState *machine)
     fadt_data.dsdt_tbl_offset = &dsdt;
     fadt_data.xdsdt_tbl_offset = &dsdt;
     build_fadt(tables_blob, tables->linker, &fadt_data,
-               lams->oem_id, lams->oem_table_id);
+               lvms->oem_id, lvms->oem_table_id);
 
     acpi_add_table(table_offsets, tables_blob);
-    build_madt(tables_blob, tables->linker, lams);
+    build_madt(tables_blob, tables->linker, lvms);
 
     acpi_add_table(table_offsets, tables_blob);
     build_pptt(tables_blob, tables->linker, machine,
-               lams->oem_id, lams->oem_table_id);
+               lvms->oem_id, lvms->oem_table_id);
 
     acpi_add_table(table_offsets, tables_blob);
     build_srat(tables_blob, tables->linker, machine);
@@ -470,13 +471,13 @@ static void acpi_build(AcpiBuildTables *tables, MachineState *machine)
     if (machine->numa_state->num_nodes) {
         if (machine->numa_state->have_numa_distance) {
             acpi_add_table(table_offsets, tables_blob);
-            build_slit(tables_blob, tables->linker, machine, lams->oem_id,
-                       lams->oem_table_id);
+            build_slit(tables_blob, tables->linker, machine, lvms->oem_id,
+                       lvms->oem_table_id);
         }
         if (machine->numa_state->hmat_enabled) {
             acpi_add_table(table_offsets, tables_blob);
             build_hmat(tables_blob, tables->linker, machine->numa_state,
-                       lams->oem_id, lams->oem_table_id);
+                       lvms->oem_id, lvms->oem_table_id);
         }
     }
 
@@ -486,8 +487,8 @@ static void acpi_build(AcpiBuildTables *tables, MachineState *machine)
            .base = cpu_to_le64(VIRT_PCI_CFG_BASE),
            .size = cpu_to_le64(VIRT_PCI_CFG_SIZE),
         };
-        build_mcfg(tables_blob, tables->linker, &mcfg, lams->oem_id,
-                   lams->oem_table_id);
+        build_mcfg(tables_blob, tables->linker, &mcfg, lvms->oem_id,
+                   lvms->oem_table_id);
     }
 
 #ifdef CONFIG_TPM
@@ -495,8 +496,8 @@ static void acpi_build(AcpiBuildTables *tables, MachineState *machine)
     if (tpm_get_version(tpm_find()) == TPM_VERSION_2_0) {
         acpi_add_table(table_offsets, tables_blob);
         build_tpm2(tables_blob, tables->linker,
-                   tables->tcpalog, lams->oem_id,
-                   lams->oem_table_id);
+                   tables->tcpalog, lvms->oem_id,
+                   lvms->oem_table_id);
     }
 #endif
     /* Add tables supplied by user (if any) */
@@ -510,13 +511,13 @@ static void acpi_build(AcpiBuildTables *tables, MachineState *machine)
     /* RSDT is pointed to by RSDP */
     rsdt = tables_blob->len;
     build_rsdt(tables_blob, tables->linker, table_offsets,
-               lams->oem_id, lams->oem_table_id);
+               lvms->oem_id, lvms->oem_table_id);
 
     /* RSDP is in FSEG memory, so allocate it separately */
     {
         AcpiRsdpData rsdp_data = {
             .revision = 0,
-            .oem_id = lams->oem_id,
+            .oem_id = lvms->oem_id,
             .xsdt_tbl_offset = NULL,
             .rsdt_tbl_offset = &rsdt,
         };
@@ -593,17 +594,25 @@ static const VMStateDescription vmstate_acpi_build = {
     },
 };
 
-void loongarch_acpi_setup(LoongArchMachineState *lams)
+static bool loongarch_is_acpi_enabled(LoongArchVirtMachineState *lvms)
+{
+    if (lvms->acpi == ON_OFF_AUTO_OFF) {
+        return false;
+    }
+    return true;
+}
+
+void loongarch_acpi_setup(LoongArchVirtMachineState *lvms)
 {
     AcpiBuildTables tables;
     AcpiBuildState *build_state;
 
-    if (!lams->fw_cfg) {
+    if (!lvms->fw_cfg) {
         ACPI_BUILD_DPRINTF("No fw cfg. Bailing out.\n");
         return;
     }
 
-    if (!loongarch_is_acpi_enabled(lams)) {
+    if (!loongarch_is_acpi_enabled(lvms)) {
         ACPI_BUILD_DPRINTF("ACPI disabled. Bailing out.\n");
         return;
     }
@@ -611,7 +620,7 @@ void loongarch_acpi_setup(LoongArchMachineState *lams)
     build_state = g_malloc0(sizeof *build_state);
 
     acpi_build_tables_init(&tables);
-    acpi_build(&tables, MACHINE(lams));
+    acpi_build(&tables, MACHINE(lvms));
 
     /* Now expose it all to Guest */
     build_state->table_mr = acpi_add_rom_blob(acpi_build_update,
diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
index 9b4a2d19a9..27a43a0096 100644
--- a/hw/loongarch/boot.c
+++ b/hw/loongarch/boot.c
@@ -256,10 +256,10 @@ static void fw_cfg_add_kernel_info(struct loongarch_boot_info *info,
     }
 }
 
-static void loongarch_firmware_boot(LoongArchMachineState *lams,
+static void loongarch_firmware_boot(LoongArchVirtMachineState *lvms,
                                     struct loongarch_boot_info *info)
 {
-    fw_cfg_add_kernel_info(info, lams->fw_cfg);
+    fw_cfg_add_kernel_info(info, lvms->fw_cfg);
 }
 
 static void init_boot_rom(struct loongarch_boot_info *info, void *p)
@@ -316,7 +316,7 @@ static void loongarch_direct_kernel_boot(struct loongarch_boot_info *info)
 
 void loongarch_load_kernel(MachineState *ms, struct loongarch_boot_info *info)
 {
-    LoongArchMachineState *lams = LOONGARCH_VIRT_MACHINE(ms);
+    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(ms);
     int i;
 
     /* register reset function */
@@ -328,8 +328,8 @@ void loongarch_load_kernel(MachineState *ms, struct loongarch_boot_info *info)
     info->kernel_cmdline = ms->kernel_cmdline;
     info->initrd_filename = ms->initrd_filename;
 
-    if (lams->bios_loaded) {
-        loongarch_firmware_boot(lams, info);
+    if (lvms->bios_loaded) {
+        loongarch_firmware_boot(lvms, info);
     } else {
         loongarch_direct_kernel_boot(info);
     }
diff --git a/hw/loongarch/fw_cfg.c b/hw/loongarch/fw_cfg.c
index f15a17416c..35aeb2decb 100644
--- a/hw/loongarch/fw_cfg.c
+++ b/hw/loongarch/fw_cfg.c
@@ -17,7 +17,7 @@ static void fw_cfg_boot_set(void *opaque, const char *boot_device,
     fw_cfg_modify_i16(opaque, FW_CFG_BOOT_DEVICE, boot_device[0]);
 }
 
-FWCfgState *loongarch_fw_cfg_init(ram_addr_t ram_size, MachineState *ms)
+FWCfgState *virt_fw_cfg_init(ram_addr_t ram_size, MachineState *ms)
 {
     FWCfgState *fw_cfg;
     int max_cpus = ms->smp.max_cpus;
diff --git a/hw/loongarch/fw_cfg.h b/hw/loongarch/fw_cfg.h
index 7c0de4db4a..27ee68286e 100644
--- a/hw/loongarch/fw_cfg.h
+++ b/hw/loongarch/fw_cfg.h
@@ -11,5 +11,5 @@
 #include "hw/boards.h"
 #include "hw/nvram/fw_cfg.h"
 
-FWCfgState *loongarch_fw_cfg_init(ram_addr_t ram_size, MachineState *ms);
+FWCfgState *virt_fw_cfg_init(ram_addr_t ram_size, MachineState *ms);
 #endif
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 6619cb52a9..93cdadfb8a 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -46,7 +46,7 @@
 #include "hw/block/flash.h"
 #include "qemu/error-report.h"
 
-static PFlashCFI01 *virt_flash_create1(LoongArchMachineState *lams,
+static PFlashCFI01 *virt_flash_create1(LoongArchVirtMachineState *lvms,
                                        const char *name,
                                        const char *alias_prop_name)
 {
@@ -61,16 +61,16 @@ static PFlashCFI01 *virt_flash_create1(LoongArchMachineState *lams,
     qdev_prop_set_uint16(dev, "id2", 0x00);
     qdev_prop_set_uint16(dev, "id3", 0x00);
     qdev_prop_set_string(dev, "name", name);
-    object_property_add_child(OBJECT(lams), name, OBJECT(dev));
-    object_property_add_alias(OBJECT(lams), alias_prop_name,
+    object_property_add_child(OBJECT(lvms), name, OBJECT(dev));
+    object_property_add_alias(OBJECT(lvms), alias_prop_name,
                               OBJECT(dev), "drive");
     return PFLASH_CFI01(dev);
 }
 
-static void virt_flash_create(LoongArchMachineState *lams)
+static void virt_flash_create(LoongArchVirtMachineState *lvms)
 {
-    lams->flash[0] = virt_flash_create1(lams, "virt.flash0", "pflash0");
-    lams->flash[1] = virt_flash_create1(lams, "virt.flash1", "pflash1");
+    lvms->flash[0] = virt_flash_create1(lvms, "virt.flash0", "pflash0");
+    lvms->flash[1] = virt_flash_create1(lvms, "virt.flash1", "pflash1");
 }
 
 static void virt_flash_map1(PFlashCFI01 *flash,
@@ -96,20 +96,20 @@ static void virt_flash_map1(PFlashCFI01 *flash,
                                 sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
 }
 
-static void virt_flash_map(LoongArchMachineState *lams,
+static void virt_flash_map(LoongArchVirtMachineState *lvms,
                            MemoryRegion *sysmem)
 {
-    PFlashCFI01 *flash0 = lams->flash[0];
-    PFlashCFI01 *flash1 = lams->flash[1];
+    PFlashCFI01 *flash0 = lvms->flash[0];
+    PFlashCFI01 *flash1 = lvms->flash[1];
 
     virt_flash_map1(flash0, VIRT_FLASH0_BASE, VIRT_FLASH0_SIZE, sysmem);
     virt_flash_map1(flash1, VIRT_FLASH1_BASE, VIRT_FLASH1_SIZE, sysmem);
 }
 
-static void fdt_add_cpuic_node(LoongArchMachineState *lams,
+static void fdt_add_cpuic_node(LoongArchVirtMachineState *lvms,
                                uint32_t *cpuintc_phandle)
 {
-    MachineState *ms = MACHINE(lams);
+    MachineState *ms = MACHINE(lvms);
     char *nodename;
 
     *cpuintc_phandle = qemu_fdt_alloc_phandle(ms->fdt);
@@ -123,11 +123,11 @@ static void fdt_add_cpuic_node(LoongArchMachineState *lams,
     g_free(nodename);
 }
 
-static void fdt_add_eiointc_node(LoongArchMachineState *lams,
+static void fdt_add_eiointc_node(LoongArchVirtMachineState *lvms,
                                   uint32_t *cpuintc_phandle,
                                   uint32_t *eiointc_phandle)
 {
-    MachineState *ms = MACHINE(lams);
+    MachineState *ms = MACHINE(lvms);
     char *nodename;
     hwaddr extioi_base = APIC_BASE;
     hwaddr extioi_size = EXTIOI_SIZE;
@@ -148,11 +148,11 @@ static void fdt_add_eiointc_node(LoongArchMachineState *lams,
     g_free(nodename);
 }
 
-static void fdt_add_pch_pic_node(LoongArchMachineState *lams,
+static void fdt_add_pch_pic_node(LoongArchVirtMachineState *lvms,
                                  uint32_t *eiointc_phandle,
                                  uint32_t *pch_pic_phandle)
 {
-    MachineState *ms = MACHINE(lams);
+    MachineState *ms = MACHINE(lvms);
     char *nodename;
     hwaddr pch_pic_base = VIRT_PCH_REG_BASE;
     hwaddr pch_pic_size = VIRT_PCH_REG_SIZE;
@@ -173,11 +173,11 @@ static void fdt_add_pch_pic_node(LoongArchMachineState *lams,
     g_free(nodename);
 }
 
-static void fdt_add_pch_msi_node(LoongArchMachineState *lams,
+static void fdt_add_pch_msi_node(LoongArchVirtMachineState *lvms,
                                  uint32_t *eiointc_phandle,
                                  uint32_t *pch_msi_phandle)
 {
-    MachineState *ms = MACHINE(lams);
+    MachineState *ms = MACHINE(lvms);
     char *nodename;
     hwaddr pch_msi_base = VIRT_PCH_MSI_ADDR_LOW;
     hwaddr pch_msi_size = VIRT_PCH_MSI_SIZE;
@@ -201,9 +201,9 @@ static void fdt_add_pch_msi_node(LoongArchMachineState *lams,
     g_free(nodename);
 }
 
-static void fdt_add_flash_node(LoongArchMachineState *lams)
+static void fdt_add_flash_node(LoongArchVirtMachineState *lvms)
 {
-    MachineState *ms = MACHINE(lams);
+    MachineState *ms = MACHINE(lvms);
     char *nodename;
     MemoryRegion *flash_mem;
 
@@ -213,11 +213,11 @@ static void fdt_add_flash_node(LoongArchMachineState *lams)
     hwaddr flash1_base;
     hwaddr flash1_size;
 
-    flash_mem = pflash_cfi01_get_memory(lams->flash[0]);
+    flash_mem = pflash_cfi01_get_memory(lvms->flash[0]);
     flash0_base = flash_mem->addr;
     flash0_size = memory_region_size(flash_mem);
 
-    flash_mem = pflash_cfi01_get_memory(lams->flash[1]);
+    flash_mem = pflash_cfi01_get_memory(lvms->flash[1]);
     flash1_base = flash_mem->addr;
     flash1_size = memory_region_size(flash_mem);
 
@@ -231,13 +231,13 @@ static void fdt_add_flash_node(LoongArchMachineState *lams)
     g_free(nodename);
 }
 
-static void fdt_add_rtc_node(LoongArchMachineState *lams,
+static void fdt_add_rtc_node(LoongArchVirtMachineState *lvms,
                              uint32_t *pch_pic_phandle)
 {
     char *nodename;
     hwaddr base = VIRT_RTC_REG_BASE;
     hwaddr size = VIRT_RTC_LEN;
-    MachineState *ms = MACHINE(lams);
+    MachineState *ms = MACHINE(lvms);
 
     nodename = g_strdup_printf("/rtc@%" PRIx64, base);
     qemu_fdt_add_subnode(ms->fdt, nodename);
@@ -251,13 +251,13 @@ static void fdt_add_rtc_node(LoongArchMachineState *lams,
     g_free(nodename);
 }
 
-static void fdt_add_uart_node(LoongArchMachineState *lams,
+static void fdt_add_uart_node(LoongArchVirtMachineState *lvms,
                               uint32_t *pch_pic_phandle)
 {
     char *nodename;
     hwaddr base = VIRT_UART_BASE;
     hwaddr size = VIRT_UART_SIZE;
-    MachineState *ms = MACHINE(lams);
+    MachineState *ms = MACHINE(lvms);
 
     nodename = g_strdup_printf("/serial@%" PRIx64, base);
     qemu_fdt_add_subnode(ms->fdt, nodename);
@@ -272,11 +272,11 @@ static void fdt_add_uart_node(LoongArchMachineState *lams,
     g_free(nodename);
 }
 
-static void create_fdt(LoongArchMachineState *lams)
+static void create_fdt(LoongArchVirtMachineState *lvms)
 {
-    MachineState *ms = MACHINE(lams);
+    MachineState *ms = MACHINE(lvms);
 
-    ms->fdt = create_device_tree(&lams->fdt_size);
+    ms->fdt = create_device_tree(&lvms->fdt_size);
     if (!ms->fdt) {
         error_report("create_device_tree() failed");
         exit(1);
@@ -290,10 +290,10 @@ static void create_fdt(LoongArchMachineState *lams)
     qemu_fdt_add_subnode(ms->fdt, "/chosen");
 }
 
-static void fdt_add_cpu_nodes(const LoongArchMachineState *lams)
+static void fdt_add_cpu_nodes(const LoongArchVirtMachineState *lvms)
 {
     int num;
-    const MachineState *ms = MACHINE(lams);
+    const MachineState *ms = MACHINE(lvms);
     int smp_cpus = ms->smp.cpus;
 
     qemu_fdt_add_subnode(ms->fdt, "/cpus");
@@ -347,11 +347,11 @@ static void fdt_add_cpu_nodes(const LoongArchMachineState *lams)
     }
 }
 
-static void fdt_add_fw_cfg_node(const LoongArchMachineState *lams)
+static void fdt_add_fw_cfg_node(const LoongArchVirtMachineState *lvms)
 {
     char *nodename;
     hwaddr base = VIRT_FWCFG_BASE;
-    const MachineState *ms = MACHINE(lams);
+    const MachineState *ms = MACHINE(lvms);
 
     nodename = g_strdup_printf("/fw_cfg@%" PRIx64, base);
     qemu_fdt_add_subnode(ms->fdt, nodename);
@@ -363,7 +363,7 @@ static void fdt_add_fw_cfg_node(const LoongArchMachineState *lams)
     g_free(nodename);
 }
 
-static void fdt_add_pcie_irq_map_node(const LoongArchMachineState *lams,
+static void fdt_add_pcie_irq_map_node(const LoongArchVirtMachineState *lvms,
                                       char *nodename,
                                       uint32_t *pch_pic_phandle)
 {
@@ -371,7 +371,7 @@ static void fdt_add_pcie_irq_map_node(const LoongArchMachineState *lams,
     uint32_t irq_map_stride = 0;
     uint32_t full_irq_map[GPEX_NUM_IRQS *GPEX_NUM_IRQS * 10] = {};
     uint32_t *irq_map = full_irq_map;
-    const MachineState *ms = MACHINE(lams);
+    const MachineState *ms = MACHINE(lvms);
 
     /* This code creates a standard swizzle of interrupts such that
      * each device's first interrupt is based on it's PCI_SLOT number.
@@ -416,7 +416,7 @@ static void fdt_add_pcie_irq_map_node(const LoongArchMachineState *lams,
                      0x1800, 0, 0, 0x7);
 }
 
-static void fdt_add_pcie_node(const LoongArchMachineState *lams,
+static void fdt_add_pcie_node(const LoongArchVirtMachineState *lvms,
                               uint32_t *pch_pic_phandle,
                               uint32_t *pch_msi_phandle)
 {
@@ -429,7 +429,7 @@ static void fdt_add_pcie_node(const LoongArchMachineState *lams,
     hwaddr size_pcie = VIRT_PCI_CFG_SIZE;
     hwaddr base = base_pcie;
 
-    const MachineState *ms = MACHINE(lams);
+    const MachineState *ms = MACHINE(lvms);
 
     nodename = g_strdup_printf("/pcie@%" PRIx64, base);
     qemu_fdt_add_subnode(ms->fdt, nodename);
@@ -452,7 +452,7 @@ static void fdt_add_pcie_node(const LoongArchMachineState *lams,
     qemu_fdt_setprop_cells(ms->fdt, nodename, "msi-map",
                            0, *pch_msi_phandle, 0, 0x10000);
 
-    fdt_add_pcie_irq_map_node(lams, nodename, pch_pic_phandle);
+    fdt_add_pcie_irq_map_node(lvms, nodename, pch_pic_phandle);
 
     g_free(nodename);
 }
@@ -473,15 +473,15 @@ static void fdt_add_memory_node(MachineState *ms,
     g_free(nodename);
 }
 
-static void virt_build_smbios(LoongArchMachineState *lams)
+static void virt_build_smbios(LoongArchVirtMachineState *lvms)
 {
-    MachineState *ms = MACHINE(lams);
-    MachineClass *mc = MACHINE_GET_CLASS(lams);
+    MachineState *ms = MACHINE(lvms);
+    MachineClass *mc = MACHINE_GET_CLASS(lvms);
     uint8_t *smbios_tables, *smbios_anchor;
     size_t smbios_tables_len, smbios_anchor_len;
     const char *product = "QEMU Virtual Machine";
 
-    if (!lams->fw_cfg) {
+    if (!lvms->fw_cfg) {
         return;
     }
 
@@ -493,26 +493,26 @@ static void virt_build_smbios(LoongArchMachineState *lams)
                       &smbios_anchor, &smbios_anchor_len, &error_fatal);
 
     if (smbios_anchor) {
-        fw_cfg_add_file(lams->fw_cfg, "etc/smbios/smbios-tables",
+        fw_cfg_add_file(lvms->fw_cfg, "etc/smbios/smbios-tables",
                         smbios_tables, smbios_tables_len);
-        fw_cfg_add_file(lams->fw_cfg, "etc/smbios/smbios-anchor",
+        fw_cfg_add_file(lvms->fw_cfg, "etc/smbios/smbios-anchor",
                         smbios_anchor, smbios_anchor_len);
     }
 }
 
-static void virt_machine_done(Notifier *notifier, void *data)
+static void virt_done(Notifier *notifier, void *data)
 {
-    LoongArchMachineState *lams = container_of(notifier,
-                                        LoongArchMachineState, machine_done);
-    virt_build_smbios(lams);
-    loongarch_acpi_setup(lams);
+    LoongArchVirtMachineState *lvms = container_of(notifier,
+                                      LoongArchVirtMachineState, machine_done);
+    virt_build_smbios(lvms);
+    loongarch_acpi_setup(lvms);
 }
 
 static void virt_powerdown_req(Notifier *notifier, void *opaque)
 {
-    LoongArchMachineState *s = container_of(notifier,
-                                   LoongArchMachineState, powerdown_notifier);
+    LoongArchVirtMachineState *s;
 
+    s = container_of(notifier, LoongArchVirtMachineState, powerdown_notifier);
     acpi_send_event(s->acpi_ged, ACPI_POWER_DOWN_STATUS);
 }
 
@@ -535,10 +535,11 @@ static void memmap_add_entry(uint64_t address, uint64_t length, uint32_t type)
     memmap_entries++;
 }
 
-static DeviceState *create_acpi_ged(DeviceState *pch_pic, LoongArchMachineState *lams)
+static DeviceState *create_acpi_ged(DeviceState *pch_pic,
+                                    LoongArchVirtMachineState *lvms)
 {
     DeviceState *dev;
-    MachineState *ms = MACHINE(lams);
+    MachineState *ms = MACHINE(lvms);
     uint32_t event = ACPI_GED_PWR_DOWN_EVT;
 
     if (ms->ram_slots) {
@@ -585,12 +586,12 @@ static DeviceState *create_platform_bus(DeviceState *pch_pic)
     return dev;
 }
 
-static void loongarch_devices_init(DeviceState *pch_pic,
-                                   LoongArchMachineState *lams,
+static void virt_devices_init(DeviceState *pch_pic,
+                                   LoongArchVirtMachineState *lvms,
                                    uint32_t *pch_pic_phandle,
                                    uint32_t *pch_msi_phandle)
 {
-    MachineClass *mc = MACHINE_GET_CLASS(lams);
+    MachineClass *mc = MACHINE_GET_CLASS(lvms);
     DeviceState *gpex_dev;
     SysBusDevice *d;
     PCIBus *pci_bus;
@@ -602,7 +603,7 @@ static void loongarch_devices_init(DeviceState *pch_pic,
     d = SYS_BUS_DEVICE(gpex_dev);
     sysbus_realize_and_unref(d, &error_fatal);
     pci_bus = PCI_HOST_BRIDGE(gpex_dev)->bus;
-    lams->pci_bus = pci_bus;
+    lvms->pci_bus = pci_bus;
 
     /* Map only part size_ecam bytes of ECAM space */
     ecam_alias = g_new0(MemoryRegion, 1);
@@ -635,13 +636,13 @@ static void loongarch_devices_init(DeviceState *pch_pic,
     }
 
     /* Add pcie node */
-    fdt_add_pcie_node(lams, pch_pic_phandle, pch_msi_phandle);
+    fdt_add_pcie_node(lvms, pch_pic_phandle, pch_msi_phandle);
 
     serial_mm_init(get_system_memory(), VIRT_UART_BASE, 0,
                    qdev_get_gpio_in(pch_pic,
                                     VIRT_UART_IRQ - VIRT_GSI_BASE),
                    115200, serial_hd(0), DEVICE_LITTLE_ENDIAN);
-    fdt_add_uart_node(lams, pch_pic_phandle);
+    fdt_add_uart_node(lvms, pch_pic_phandle);
 
     /* Network init */
     pci_init_nic_devices(pci_bus, mc->default_nic);
@@ -654,17 +655,17 @@ static void loongarch_devices_init(DeviceState *pch_pic,
     sysbus_create_simple("ls7a_rtc", VIRT_RTC_REG_BASE,
                          qdev_get_gpio_in(pch_pic,
                          VIRT_RTC_IRQ - VIRT_GSI_BASE));
-    fdt_add_rtc_node(lams, pch_pic_phandle);
+    fdt_add_rtc_node(lvms, pch_pic_phandle);
 
     /* acpi ged */
-    lams->acpi_ged = create_acpi_ged(pch_pic, lams);
+    lvms->acpi_ged = create_acpi_ged(pch_pic, lvms);
     /* platform bus */
-    lams->platform_bus_dev = create_platform_bus(pch_pic);
+    lvms->platform_bus_dev = create_platform_bus(pch_pic);
 }
 
-static void loongarch_irq_init(LoongArchMachineState *lams)
+static void virt_irq_init(LoongArchVirtMachineState *lvms)
 {
-    MachineState *ms = MACHINE(lams);
+    MachineState *ms = MACHINE(lvms);
     DeviceState *pch_pic, *pch_msi, *cpudev;
     DeviceState *ipi, *extioi;
     SysBusDevice *d;
@@ -702,20 +703,20 @@ static void loongarch_irq_init(LoongArchMachineState *lams)
     sysbus_realize_and_unref(SYS_BUS_DEVICE(ipi), &error_fatal);
 
     /* IPI iocsr memory region */
-    memory_region_add_subregion(&lams->system_iocsr, SMP_IPI_MAILBOX,
+    memory_region_add_subregion(&lvms->system_iocsr, SMP_IPI_MAILBOX,
                    sysbus_mmio_get_region(SYS_BUS_DEVICE(ipi), 0));
-    memory_region_add_subregion(&lams->system_iocsr, MAIL_SEND_ADDR,
+    memory_region_add_subregion(&lvms->system_iocsr, MAIL_SEND_ADDR,
                    sysbus_mmio_get_region(SYS_BUS_DEVICE(ipi), 1));
 
     /* Add cpu interrupt-controller */
-    fdt_add_cpuic_node(lams, &cpuintc_phandle);
+    fdt_add_cpuic_node(lvms, &cpuintc_phandle);
 
     for (cpu = 0; cpu < ms->smp.cpus; cpu++) {
         cpu_state = qemu_get_cpu(cpu);
         cpudev = DEVICE(cpu_state);
         lacpu = LOONGARCH_CPU(cpu_state);
         env = &(lacpu->env);
-        env->address_space_iocsr = &lams->as_iocsr;
+        env->address_space_iocsr = &lvms->as_iocsr;
 
         /* connect ipi irq to cpu irq */
         qdev_connect_gpio_out(ipi, cpu, qdev_get_gpio_in(cpudev, IRQ_IPI));
@@ -726,7 +727,7 @@ static void loongarch_irq_init(LoongArchMachineState *lams)
     extioi = qdev_new(TYPE_LOONGARCH_EXTIOI);
     qdev_prop_set_uint32(extioi, "num-cpu", ms->smp.cpus);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(extioi), &error_fatal);
-    memory_region_add_subregion(&lams->system_iocsr, APIC_BASE,
+    memory_region_add_subregion(&lvms->system_iocsr, APIC_BASE,
                    sysbus_mmio_get_region(SYS_BUS_DEVICE(extioi), 0));
 
     /*
@@ -742,7 +743,7 @@ static void loongarch_irq_init(LoongArchMachineState *lams)
     }
 
     /* Add Extend I/O Interrupt Controller node */
-    fdt_add_eiointc_node(lams, &cpuintc_phandle, &eiointc_phandle);
+    fdt_add_eiointc_node(lvms, &cpuintc_phandle, &eiointc_phandle);
 
     pch_pic = qdev_new(TYPE_LOONGARCH_PCH_PIC);
     num = VIRT_PCH_PIC_IRQ_NUM;
@@ -764,7 +765,7 @@ static void loongarch_irq_init(LoongArchMachineState *lams)
     }
 
     /* Add PCH PIC node */
-    fdt_add_pch_pic_node(lams, &eiointc_phandle, &pch_pic_phandle);
+    fdt_add_pch_pic_node(lvms, &eiointc_phandle, &pch_pic_phandle);
 
     pch_msi = qdev_new(TYPE_LOONGARCH_PCH_MSI);
     start   =  num;
@@ -781,30 +782,30 @@ static void loongarch_irq_init(LoongArchMachineState *lams)
     }
 
     /* Add PCH MSI node */
-    fdt_add_pch_msi_node(lams, &eiointc_phandle, &pch_msi_phandle);
+    fdt_add_pch_msi_node(lvms, &eiointc_phandle, &pch_msi_phandle);
 
-    loongarch_devices_init(pch_pic, lams, &pch_pic_phandle, &pch_msi_phandle);
+    virt_devices_init(pch_pic, lvms, &pch_pic_phandle, &pch_msi_phandle);
 }
 
-static void loongarch_firmware_init(LoongArchMachineState *lams)
+static void virt_firmware_init(LoongArchVirtMachineState *lvms)
 {
-    char *filename = MACHINE(lams)->firmware;
+    char *filename = MACHINE(lvms)->firmware;
     char *bios_name = NULL;
     int bios_size, i;
     BlockBackend *pflash_blk0;
     MemoryRegion *mr;
 
-    lams->bios_loaded = false;
+    lvms->bios_loaded = false;
 
     /* Map legacy -drive if=pflash to machine properties */
-    for (i = 0; i < ARRAY_SIZE(lams->flash); i++) {
-        pflash_cfi01_legacy_drive(lams->flash[i],
+    for (i = 0; i < ARRAY_SIZE(lvms->flash); i++) {
+        pflash_cfi01_legacy_drive(lvms->flash[i],
                                   drive_get(IF_PFLASH, 0, i));
     }
 
-    virt_flash_map(lams, get_system_memory());
+    virt_flash_map(lvms, get_system_memory());
 
-    pflash_blk0 = pflash_cfi01_get_blk(lams->flash[0]);
+    pflash_blk0 = pflash_cfi01_get_blk(lvms->flash[0]);
 
     if (pflash_blk0) {
         if (filename) {
@@ -812,7 +813,7 @@ static void loongarch_firmware_init(LoongArchMachineState *lams)
                          "options at once");
             exit(1);
         }
-        lams->bios_loaded = true;
+        lvms->bios_loaded = true;
         return;
     }
 
@@ -823,24 +824,24 @@ static void loongarch_firmware_init(LoongArchMachineState *lams)
             exit(1);
         }
 
-        mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(lams->flash[0]), 0);
+        mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(lvms->flash[0]), 0);
         bios_size = load_image_mr(bios_name, mr);
         if (bios_size < 0) {
             error_report("Could not load ROM image '%s'", bios_name);
             exit(1);
         }
         g_free(bios_name);
-        lams->bios_loaded = true;
+        lvms->bios_loaded = true;
     }
 }
 
 
-static void loongarch_qemu_write(void *opaque, hwaddr addr,
-                                 uint64_t val, unsigned size)
+static void virt_iocsr_misc_write(void *opaque, hwaddr addr,
+                                  uint64_t val, unsigned size)
 {
 }
 
-static uint64_t loongarch_qemu_read(void *opaque, hwaddr addr, unsigned size)
+static uint64_t virt_iocsr_misc_read(void *opaque, hwaddr addr, unsigned size)
 {
     switch (addr) {
     case VERSION_REG:
@@ -858,9 +859,9 @@ static uint64_t loongarch_qemu_read(void *opaque, hwaddr addr, unsigned size)
     return 0ULL;
 }
 
-static const MemoryRegionOps loongarch_qemu_ops = {
-    .read = loongarch_qemu_read,
-    .write = loongarch_qemu_write,
+static const MemoryRegionOps virt_iocsr_misc_ops = {
+    .read  = virt_iocsr_misc_read,
+    .write = virt_iocsr_misc_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 4,
@@ -872,7 +873,7 @@ static const MemoryRegionOps loongarch_qemu_ops = {
     },
 };
 
-static void loongarch_init(MachineState *machine)
+static void virt_init(MachineState *machine)
 {
     LoongArchCPU *lacpu;
     const char *cpu_model = machine->cpu_type;
@@ -880,7 +881,7 @@ static void loongarch_init(MachineState *machine)
     ram_addr_t ram_size = machine->ram_size;
     uint64_t highram_size = 0, phyAddr = 0;
     MemoryRegion *address_space_mem = get_system_memory();
-    LoongArchMachineState *lams = LOONGARCH_VIRT_MACHINE(machine);
+    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(machine);
     int nb_numa_nodes = machine->numa_state->num_nodes;
     NodeInfo *numa_info = machine->numa_state->nodes;
     int i;
@@ -897,16 +898,16 @@ static void loongarch_init(MachineState *machine)
         error_report("ram_size must be greater than 1G.");
         exit(1);
     }
-    create_fdt(lams);
+    create_fdt(lvms);
 
     /* Create IOCSR space */
-    memory_region_init_io(&lams->system_iocsr, OBJECT(machine), NULL,
+    memory_region_init_io(&lvms->system_iocsr, OBJECT(machine), NULL,
                           machine, "iocsr", UINT64_MAX);
-    address_space_init(&lams->as_iocsr, &lams->system_iocsr, "IOCSR");
-    memory_region_init_io(&lams->iocsr_mem, OBJECT(machine),
-                          &loongarch_qemu_ops,
+    address_space_init(&lvms->as_iocsr, &lvms->system_iocsr, "IOCSR");
+    memory_region_init_io(&lvms->iocsr_mem, OBJECT(machine),
+                          &virt_iocsr_misc_ops,
                           machine, "iocsr_misc", 0x428);
-    memory_region_add_subregion(&lams->system_iocsr, 0, &lams->iocsr_mem);
+    memory_region_add_subregion(&lvms->system_iocsr, 0, &lvms->iocsr_mem);
 
     /* Init CPUs */
     possible_cpus = mc->possible_cpu_arch_ids(machine);
@@ -917,14 +918,14 @@ static void loongarch_init(MachineState *machine)
         lacpu = LOONGARCH_CPU(cpu);
         lacpu->phy_id = machine->possible_cpus->cpus[i].arch_id;
     }
-    fdt_add_cpu_nodes(lams);
+    fdt_add_cpu_nodes(lvms);
 
     /* Node0 memory */
     memmap_add_entry(VIRT_LOWMEM_BASE, VIRT_LOWMEM_SIZE, 1);
     fdt_add_memory_node(machine, VIRT_LOWMEM_BASE, VIRT_LOWMEM_SIZE, 0);
-    memory_region_init_alias(&lams->lowmem, NULL, "loongarch.node0.lowram",
+    memory_region_init_alias(&lvms->lowmem, NULL, "loongarch.node0.lowram",
                              machine->ram, offset, VIRT_LOWMEM_SIZE);
-    memory_region_add_subregion(address_space_mem, phyAddr, &lams->lowmem);
+    memory_region_add_subregion(address_space_mem, phyAddr, &lvms->lowmem);
 
     offset += VIRT_LOWMEM_SIZE;
     if (nb_numa_nodes > 0) {
@@ -936,9 +937,9 @@ static void loongarch_init(MachineState *machine)
     phyAddr = VIRT_HIGHMEM_BASE;
     memmap_add_entry(phyAddr, highram_size, 1);
     fdt_add_memory_node(machine, phyAddr, highram_size, 0);
-    memory_region_init_alias(&lams->highmem, NULL, "loongarch.node0.highram",
+    memory_region_init_alias(&lvms->highmem, NULL, "loongarch.node0.highram",
                               machine->ram, offset, highram_size);
-    memory_region_add_subregion(address_space_mem, phyAddr, &lams->highmem);
+    memory_region_add_subregion(address_space_mem, phyAddr, &lvms->highmem);
 
     /* Node1 - Nodemax memory */
     offset += highram_size;
@@ -979,30 +980,30 @@ static void loongarch_init(MachineState *machine)
     }
 
     /* load the BIOS image. */
-    loongarch_firmware_init(lams);
+    virt_firmware_init(lvms);
 
     /* fw_cfg init */
-    lams->fw_cfg = loongarch_fw_cfg_init(ram_size, machine);
-    rom_set_fw(lams->fw_cfg);
-    if (lams->fw_cfg != NULL) {
-        fw_cfg_add_file(lams->fw_cfg, "etc/memmap",
+    lvms->fw_cfg = virt_fw_cfg_init(ram_size, machine);
+    rom_set_fw(lvms->fw_cfg);
+    if (lvms->fw_cfg != NULL) {
+        fw_cfg_add_file(lvms->fw_cfg, "etc/memmap",
                         memmap_table,
                         sizeof(struct memmap_entry) * (memmap_entries));
     }
-    fdt_add_fw_cfg_node(lams);
-    fdt_add_flash_node(lams);
+    fdt_add_fw_cfg_node(lvms);
+    fdt_add_flash_node(lvms);
 
     /* Initialize the IO interrupt subsystem */
-    loongarch_irq_init(lams);
+    virt_irq_init(lvms);
     platform_bus_add_all_fdt_nodes(machine->fdt, "/platic",
                                    VIRT_PLATFORM_BUS_BASEADDRESS,
                                    VIRT_PLATFORM_BUS_SIZE,
                                    VIRT_PLATFORM_BUS_IRQ);
-    lams->machine_done.notify = virt_machine_done;
-    qemu_add_machine_init_done_notifier(&lams->machine_done);
+    lvms->machine_done.notify = virt_done;
+    qemu_add_machine_init_done_notifier(&lvms->machine_done);
      /* connect powerdown request */
-    lams->powerdown_notifier.notify = virt_powerdown_req;
-    qemu_register_powerdown_notifier(&lams->powerdown_notifier);
+    lvms->powerdown_notifier.notify = virt_powerdown_req;
+    qemu_register_powerdown_notifier(&lvms->powerdown_notifier);
 
     /*
      * Since lowmem region starts from 0 and Linux kernel legacy start address
@@ -1011,49 +1012,41 @@ static void loongarch_init(MachineState *machine)
      * Put the FDT into the memory map as a ROM image: this will ensure
      * the FDT is copied again upon reset, even if addr points into RAM.
      */
-    qemu_fdt_dumpdtb(machine->fdt, lams->fdt_size);
-    rom_add_blob_fixed_as("fdt", machine->fdt, lams->fdt_size, FDT_BASE,
+    qemu_fdt_dumpdtb(machine->fdt, lvms->fdt_size);
+    rom_add_blob_fixed_as("fdt", machine->fdt, lvms->fdt_size, FDT_BASE,
                           &address_space_memory);
     qemu_register_reset_nosnapshotload(qemu_fdt_randomize_seeds,
-            rom_ptr_for_as(&address_space_memory, FDT_BASE, lams->fdt_size));
+            rom_ptr_for_as(&address_space_memory, FDT_BASE, lvms->fdt_size));
 
-    lams->bootinfo.ram_size = ram_size;
-    loongarch_load_kernel(machine, &lams->bootinfo);
+    lvms->bootinfo.ram_size = ram_size;
+    loongarch_load_kernel(machine, &lvms->bootinfo);
 }
 
-bool loongarch_is_acpi_enabled(LoongArchMachineState *lams)
+static void virt_get_acpi(Object *obj, Visitor *v, const char *name,
+                          void *opaque, Error **errp)
 {
-    if (lams->acpi == ON_OFF_AUTO_OFF) {
-        return false;
-    }
-    return true;
-}
-
-static void loongarch_get_acpi(Object *obj, Visitor *v, const char *name,
-                               void *opaque, Error **errp)
-{
-    LoongArchMachineState *lams = LOONGARCH_VIRT_MACHINE(obj);
-    OnOffAuto acpi = lams->acpi;
+    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(obj);
+    OnOffAuto acpi = lvms->acpi;
 
     visit_type_OnOffAuto(v, name, &acpi, errp);
 }
 
-static void loongarch_set_acpi(Object *obj, Visitor *v, const char *name,
+static void virt_set_acpi(Object *obj, Visitor *v, const char *name,
                                void *opaque, Error **errp)
 {
-    LoongArchMachineState *lams = LOONGARCH_VIRT_MACHINE(obj);
+    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(obj);
 
-    visit_type_OnOffAuto(v, name, &lams->acpi, errp);
+    visit_type_OnOffAuto(v, name, &lvms->acpi, errp);
 }
 
-static void loongarch_machine_initfn(Object *obj)
+static void virt_initfn(Object *obj)
 {
-    LoongArchMachineState *lams = LOONGARCH_VIRT_MACHINE(obj);
+    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(obj);
 
-    lams->acpi = ON_OFF_AUTO_AUTO;
-    lams->oem_id = g_strndup(ACPI_BUILD_APPNAME6, 6);
-    lams->oem_table_id = g_strndup(ACPI_BUILD_APPNAME8, 8);
-    virt_flash_create(lams);
+    lvms->acpi = ON_OFF_AUTO_AUTO;
+    lvms->oem_id = g_strndup(ACPI_BUILD_APPNAME6, 6);
+    lvms->oem_table_id = g_strndup(ACPI_BUILD_APPNAME8, 8);
+    virt_flash_create(lvms);
 }
 
 static bool memhp_type_supported(DeviceState *dev)
@@ -1069,7 +1062,7 @@ static void virt_mem_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev), NULL, errp);
 }
 
-static void virt_machine_device_pre_plug(HotplugHandler *hotplug_dev,
+static void virt_device_pre_plug(HotplugHandler *hotplug_dev,
                                             DeviceState *dev, Error **errp)
 {
     if (memhp_type_supported(dev)) {
@@ -1080,14 +1073,14 @@ static void virt_machine_device_pre_plug(HotplugHandler *hotplug_dev,
 static void virt_mem_unplug_request(HotplugHandler *hotplug_dev,
                                      DeviceState *dev, Error **errp)
 {
-    LoongArchMachineState *lams = LOONGARCH_VIRT_MACHINE(hotplug_dev);
+    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(hotplug_dev);
 
     /* the acpi ged is always exist */
-    hotplug_handler_unplug_request(HOTPLUG_HANDLER(lams->acpi_ged), dev,
+    hotplug_handler_unplug_request(HOTPLUG_HANDLER(lvms->acpi_ged), dev,
                                    errp);
 }
 
-static void virt_machine_device_unplug_request(HotplugHandler *hotplug_dev,
+static void virt_device_unplug_request(HotplugHandler *hotplug_dev,
                                           DeviceState *dev, Error **errp)
 {
     if (memhp_type_supported(dev)) {
@@ -1098,14 +1091,14 @@ static void virt_machine_device_unplug_request(HotplugHandler *hotplug_dev,
 static void virt_mem_unplug(HotplugHandler *hotplug_dev,
                              DeviceState *dev, Error **errp)
 {
-    LoongArchMachineState *lams = LOONGARCH_VIRT_MACHINE(hotplug_dev);
+    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(hotplug_dev);
 
-    hotplug_handler_unplug(HOTPLUG_HANDLER(lams->acpi_ged), dev, errp);
-    pc_dimm_unplug(PC_DIMM(dev), MACHINE(lams));
+    hotplug_handler_unplug(HOTPLUG_HANDLER(lvms->acpi_ged), dev, errp);
+    pc_dimm_unplug(PC_DIMM(dev), MACHINE(lvms));
     qdev_unrealize(dev);
 }
 
-static void virt_machine_device_unplug(HotplugHandler *hotplug_dev,
+static void virt_device_unplug(HotplugHandler *hotplug_dev,
                                           DeviceState *dev, Error **errp)
 {
     if (memhp_type_supported(dev)) {
@@ -1116,31 +1109,32 @@ static void virt_machine_device_unplug(HotplugHandler *hotplug_dev,
 static void virt_mem_plug(HotplugHandler *hotplug_dev,
                              DeviceState *dev, Error **errp)
 {
-    LoongArchMachineState *lams = LOONGARCH_VIRT_MACHINE(hotplug_dev);
+    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(hotplug_dev);
 
-    pc_dimm_plug(PC_DIMM(dev), MACHINE(lams));
-    hotplug_handler_plug(HOTPLUG_HANDLER(lams->acpi_ged),
+    pc_dimm_plug(PC_DIMM(dev), MACHINE(lvms));
+    hotplug_handler_plug(HOTPLUG_HANDLER(lvms->acpi_ged),
                          dev, &error_abort);
 }
 
-static void loongarch_machine_device_plug_cb(HotplugHandler *hotplug_dev,
+static void virt_device_plug_cb(HotplugHandler *hotplug_dev,
                                         DeviceState *dev, Error **errp)
 {
-    LoongArchMachineState *lams = LOONGARCH_VIRT_MACHINE(hotplug_dev);
-    MachineClass *mc = MACHINE_GET_CLASS(lams);
+    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(hotplug_dev);
+    MachineClass *mc = MACHINE_GET_CLASS(lvms);
+    PlatformBusDevice *pbus;
 
     if (device_is_dynamic_sysbus(mc, dev)) {
-        if (lams->platform_bus_dev) {
-            platform_bus_link_device(PLATFORM_BUS_DEVICE(lams->platform_bus_dev),
-                                     SYS_BUS_DEVICE(dev));
+        if (lvms->platform_bus_dev) {
+            pbus = PLATFORM_BUS_DEVICE(lvms->platform_bus_dev);
+            platform_bus_link_device(pbus, SYS_BUS_DEVICE(dev));
         }
     } else if (memhp_type_supported(dev)) {
         virt_mem_plug(hotplug_dev, dev, errp);
     }
 }
 
-static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *machine,
-                                                        DeviceState *dev)
+static HotplugHandler *virt_get_hotplug_handler(MachineState *machine,
+                                                DeviceState *dev)
 {
     MachineClass *mc = MACHINE_GET_CLASS(machine);
 
@@ -1180,8 +1174,8 @@ static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
     return ms->possible_cpus;
 }
 
-static CpuInstanceProperties
-virt_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
+static CpuInstanceProperties virt_cpu_index_to_props(MachineState *ms,
+                                                     unsigned cpu_index)
 {
     MachineClass *mc = MACHINE_GET_CLASS(ms);
     const CPUArchIdList *possible_cpus = mc->possible_cpu_arch_ids(ms);
@@ -1203,12 +1197,12 @@ static int64_t virt_get_default_cpu_node_id(const MachineState *ms, int idx)
     return nidx;
 }
 
-static void loongarch_class_init(ObjectClass *oc, void *data)
+static void virt_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
 
-    mc->init = loongarch_init;
+    mc->init = virt_init;
     mc->default_ram_size = 1 * GiB;
     mc->default_cpu_type = LOONGARCH_CPU_TYPE_NAME("la464");
     mc->default_ram_id = "loongarch.ram";
@@ -1224,15 +1218,15 @@ static void loongarch_class_init(ObjectClass *oc, void *data)
     mc->numa_mem_supported = true;
     mc->auto_enable_numa_with_memhp = true;
     mc->auto_enable_numa_with_memdev = true;
-    mc->get_hotplug_handler = virt_machine_get_hotplug_handler;
+    mc->get_hotplug_handler = virt_get_hotplug_handler;
     mc->default_nic = "virtio-net-pci";
-    hc->plug = loongarch_machine_device_plug_cb;
-    hc->pre_plug = virt_machine_device_pre_plug;
-    hc->unplug_request = virt_machine_device_unplug_request;
-    hc->unplug = virt_machine_device_unplug;
+    hc->plug = virt_device_plug_cb;
+    hc->pre_plug = virt_device_pre_plug;
+    hc->unplug_request = virt_device_unplug_request;
+    hc->unplug = virt_device_unplug;
 
     object_class_property_add(oc, "acpi", "OnOffAuto",
-        loongarch_get_acpi, loongarch_set_acpi,
+        virt_get_acpi, virt_set_acpi,
         NULL, NULL);
     object_class_property_set_description(oc, "acpi",
         "Enable ACPI");
@@ -1242,13 +1236,13 @@ static void loongarch_class_init(ObjectClass *oc, void *data)
 #endif
 }
 
-static const TypeInfo loongarch_machine_types[] = {
+static const TypeInfo virt_machine_types[] = {
     {
         .name           = TYPE_LOONGARCH_VIRT_MACHINE,
         .parent         = TYPE_MACHINE,
-        .instance_size  = sizeof(LoongArchMachineState),
-        .class_init     = loongarch_class_init,
-        .instance_init = loongarch_machine_initfn,
+        .instance_size  = sizeof(LoongArchVirtMachineState),
+        .class_init     = virt_class_init,
+        .instance_init  = virt_initfn,
         .interfaces = (InterfaceInfo[]) {
          { TYPE_HOTPLUG_HANDLER },
          { }
@@ -1256,4 +1250,4 @@ static const TypeInfo loongarch_machine_types[] = {
     }
 };
 
-DEFINE_TYPES(loongarch_machine_types)
+DEFINE_TYPES(virt_machine_types)
diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
index 224b51723c..564ddc3f73 100644
--- a/include/hw/loongarch/virt.h
+++ b/include/hw/loongarch/virt.h
@@ -47,7 +47,7 @@ struct memmap_entry {
     uint32_t reserved;
 };
 
-struct LoongArchMachineState {
+struct LoongArchVirtMachineState {
     /*< private >*/
     MachineState parent_obj;
 
@@ -74,7 +74,6 @@ struct LoongArchMachineState {
 };
 
 #define TYPE_LOONGARCH_VIRT_MACHINE  MACHINE_TYPE_NAME("virt")
-OBJECT_DECLARE_SIMPLE_TYPE(LoongArchMachineState, LOONGARCH_VIRT_MACHINE)
-bool loongarch_is_acpi_enabled(LoongArchMachineState *lams);
-void loongarch_acpi_setup(LoongArchMachineState *lams);
+OBJECT_DECLARE_SIMPLE_TYPE(LoongArchVirtMachineState, LOONGARCH_VIRT_MACHINE)
+void loongarch_acpi_setup(LoongArchVirtMachineState *lvms);
 #endif
-- 
2.39.3


