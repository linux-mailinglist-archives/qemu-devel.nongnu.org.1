Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9A1816998
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 10:16:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rF9hU-0000yL-AI; Mon, 18 Dec 2023 04:14:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rF9hQ-0000wW-N1
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 04:14:08 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rF9hL-0007TN-2p
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 04:14:08 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxXOlTDYBlIf4BAA--.10651S3;
 Mon, 18 Dec 2023 17:13:55 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxXeFRDYBlVfMJAA--.47541S3; 
 Mon, 18 Dec 2023 17:13:54 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, peter.maydell@linaro.org,
 maobibo@loongson.cn
Subject: [PATCH v2 01/17] hw/loongarch: Move boot fucntions to boot.c
Date: Mon, 18 Dec 2023 17:00:43 +0800
Message-Id: <20231218090059.2678224-2-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231218090059.2678224-1-gaosong@loongson.cn>
References: <20231218090059.2678224-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxXeFRDYBlVfMJAA--.47541S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Move some boot functions to boot.c and struct
loongarch_boot_info into struct LoongArchMachineState.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/loongarch/boot.c         | 127 ++++++++++++++++++++++++++++++++++++
 hw/loongarch/meson.build    |   1 +
 hw/loongarch/virt.c         | 118 ++-------------------------------
 include/hw/loongarch/boot.h |  21 ++++++
 include/hw/loongarch/virt.h |   2 +
 5 files changed, 155 insertions(+), 114 deletions(-)
 create mode 100644 hw/loongarch/boot.c
 create mode 100644 include/hw/loongarch/boot.h

diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
new file mode 100644
index 0000000000..9f25ea5847
--- /dev/null
+++ b/hw/loongarch/boot.c
@@ -0,0 +1,127 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * LoongArch boot helper functions.
+ *
+ * Copyright (c) 2023 Loongson Technology Corporation Limited
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "target/loongarch/cpu.h"
+#include "hw/loongarch/virt.h"
+#include "hw/loader.h"
+#include "elf.h"
+#include "qemu/error-report.h"
+#include "sysemu/reset.h"
+
+static uint64_t cpu_loongarch_virt_to_phys(void *opaque, uint64_t addr)
+{
+    return addr & MAKE_64BIT_MASK(0, TARGET_PHYS_ADDR_SPACE_BITS);
+}
+
+static int64_t load_kernel_info(struct loongarch_boot_info *info)
+{
+    uint64_t kernel_entry, kernel_low, kernel_high;
+    ssize_t kernel_size;
+
+    kernel_size = load_elf(info->kernel_filename, NULL,
+                           cpu_loongarch_virt_to_phys, NULL,
+                           &kernel_entry, &kernel_low,
+                           &kernel_high, NULL, 0,
+                           EM_LOONGARCH, 1, 0);
+
+    if (kernel_size < 0) {
+        error_report("could not load kernel '%s': %s",
+                     info->kernel_filename,
+                     load_elf_strerror(kernel_size));
+        exit(1);
+    }
+    return kernel_entry;
+}
+
+static void reset_load_elf(void *opaque)
+{
+    LoongArchCPU *cpu = opaque;
+    CPULoongArchState *env = &cpu->env;
+
+    cpu_reset(CPU(cpu));
+    if (env->load_elf) {
+        cpu_set_pc(CPU(cpu), env->elf_address);
+    }
+}
+
+static void fw_cfg_add_kernel_info(struct loongarch_boot_info *info,
+                                   FWCfgState *fw_cfg)
+{
+    /*
+     * Expose the kernel, the command line, and the initrd in fw_cfg.
+     * We don't process them here at all, it's all left to the
+     * firmware.
+     */
+    load_image_to_fw_cfg(fw_cfg,
+                         FW_CFG_KERNEL_SIZE, FW_CFG_KERNEL_DATA,
+                         info->kernel_filename,
+                         false);
+
+    if (info->initrd_filename) {
+        load_image_to_fw_cfg(fw_cfg,
+                             FW_CFG_INITRD_SIZE, FW_CFG_INITRD_DATA,
+                             info->initrd_filename, false);
+    }
+
+    if (info->kernel_cmdline) {
+        fw_cfg_add_i32(fw_cfg, FW_CFG_CMDLINE_SIZE,
+                       strlen(info->kernel_cmdline) + 1);
+        fw_cfg_add_string(fw_cfg, FW_CFG_CMDLINE_DATA,
+                          info->kernel_cmdline);
+    }
+}
+
+static void loongarch_firmware_boot(LoongArchMachineState *lams,
+                                    struct loongarch_boot_info *info)
+{
+    fw_cfg_add_kernel_info(info, lams->fw_cfg);
+}
+
+static void loongarch_direct_kernel_boot(LoongArchMachineState *lams,
+                                         struct loongarch_boot_info *info)
+{
+    MachineState *machine = MACHINE(lams);
+    int64_t kernel_addr = 0;
+    LoongArchCPU *lacpu;
+    int i;
+
+    if (info->kernel_filename) {
+        kernel_addr = load_kernel_info(info);
+    } else {
+        error_report("Need kernel filename\n");
+        exit(1);
+    }
+
+    for (i = 0; i < machine->smp.cpus; i++) {
+        lacpu = LOONGARCH_CPU(qemu_get_cpu(i));
+        lacpu->env.load_elf = true;
+        lacpu->env.elf_address = kernel_addr;
+    }
+}
+
+void loongarch_load_kernel(MachineState *ms, struct loongarch_boot_info *info)
+{
+    LoongArchMachineState *lams = LOONGARCH_MACHINE(ms);
+    int i;
+
+    /* register reset function */
+    for (i = 0; i < ms->smp.cpus; i++) {
+        qemu_register_reset(reset_load_elf, LOONGARCH_CPU(qemu_get_cpu(i)));
+    }
+
+    info->kernel_filename = ms->kernel_filename;
+    info->kernel_cmdline = ms->kernel_cmdline;
+    info->initrd_filename = ms->initrd_filename;
+
+    if (lams->bios_loaded) {
+        loongarch_firmware_boot(lams, info);
+    } else {
+        loongarch_direct_kernel_boot(lams, info);
+    }
+}
diff --git a/hw/loongarch/meson.build b/hw/loongarch/meson.build
index c0421502ab..d306d82c2e 100644
--- a/hw/loongarch/meson.build
+++ b/hw/loongarch/meson.build
@@ -1,6 +1,7 @@
 loongarch_ss = ss.source_set()
 loongarch_ss.add(files(
     'fw_cfg.c',
+    'boot.c',
 ))
 loongarch_ss.add(when: 'CONFIG_LOONGARCH_VIRT', if_true: [files('virt.c'), fdt])
 loongarch_ss.add(when: 'CONFIG_ACPI', if_true: files('acpi-build.c'))
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 4b7dc67a2d..3e27d72f55 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -46,14 +46,6 @@
 #include "hw/block/flash.h"
 #include "qemu/error-report.h"
 
-
-struct loaderparams {
-    uint64_t ram_size;
-    const char *kernel_filename;
-    const char *kernel_cmdline;
-    const char *initrd_filename;
-};
-
 static void virt_flash_create(LoongArchMachineState *lams)
 {
     DeviceState *dev = qdev_new(TYPE_PFLASH_CFI01);
@@ -376,31 +368,6 @@ static void memmap_add_entry(uint64_t address, uint64_t length, uint32_t type)
     memmap_entries++;
 }
 
-static uint64_t cpu_loongarch_virt_to_phys(void *opaque, uint64_t addr)
-{
-    return addr & MAKE_64BIT_MASK(0, TARGET_PHYS_ADDR_SPACE_BITS);
-}
-
-static int64_t load_kernel_info(const struct loaderparams *loaderparams)
-{
-    uint64_t kernel_entry, kernel_low, kernel_high;
-    ssize_t kernel_size;
-
-    kernel_size = load_elf(loaderparams->kernel_filename, NULL,
-                           cpu_loongarch_virt_to_phys, NULL,
-                           &kernel_entry, &kernel_low,
-                           &kernel_high, NULL, 0,
-                           EM_LOONGARCH, 1, 0);
-
-    if (kernel_size < 0) {
-        error_report("could not load kernel '%s': %s",
-                     loaderparams->kernel_filename,
-                     load_elf_strerror(kernel_size));
-        exit(1);
-    }
-    return kernel_entry;
-}
-
 static DeviceState *create_acpi_ged(DeviceState *pch_pic, LoongArchMachineState *lams)
 {
     DeviceState *dev;
@@ -668,69 +635,6 @@ static void loongarch_firmware_init(LoongArchMachineState *lams)
         memory_region_add_subregion(get_system_memory(), VIRT_BIOS_BASE, &lams->bios);
         lams->bios_loaded = true;
     }
-
-}
-
-static void reset_load_elf(void *opaque)
-{
-    LoongArchCPU *cpu = opaque;
-    CPULoongArchState *env = &cpu->env;
-
-    cpu_reset(CPU(cpu));
-    if (env->load_elf) {
-        cpu_set_pc(CPU(cpu), env->elf_address);
-    }
-}
-
-static void fw_cfg_add_kernel_info(const struct loaderparams *loaderparams,
-                                   FWCfgState *fw_cfg)
-{
-    /*
-     * Expose the kernel, the command line, and the initrd in fw_cfg.
-     * We don't process them here at all, it's all left to the
-     * firmware.
-     */
-    load_image_to_fw_cfg(fw_cfg,
-                         FW_CFG_KERNEL_SIZE, FW_CFG_KERNEL_DATA,
-                         loaderparams->kernel_filename,
-                         false);
-
-    if (loaderparams->initrd_filename) {
-        load_image_to_fw_cfg(fw_cfg,
-                             FW_CFG_INITRD_SIZE, FW_CFG_INITRD_DATA,
-                             loaderparams->initrd_filename, false);
-    }
-
-    if (loaderparams->kernel_cmdline) {
-        fw_cfg_add_i32(fw_cfg, FW_CFG_CMDLINE_SIZE,
-                       strlen(loaderparams->kernel_cmdline) + 1);
-        fw_cfg_add_string(fw_cfg, FW_CFG_CMDLINE_DATA,
-                          loaderparams->kernel_cmdline);
-    }
-}
-
-static void loongarch_firmware_boot(LoongArchMachineState *lams,
-                                    const struct loaderparams *loaderparams)
-{
-    fw_cfg_add_kernel_info(loaderparams, lams->fw_cfg);
-}
-
-static void loongarch_direct_kernel_boot(LoongArchMachineState *lams,
-                                         const struct loaderparams *loaderparams)
-{
-    MachineState *machine = MACHINE(lams);
-    int64_t kernel_addr = 0;
-    LoongArchCPU *lacpu;
-    int i;
-
-    kernel_addr = load_kernel_info(loaderparams);
-    if (!machine->firmware) {
-        for (i = 0; i < machine->smp.cpus; i++) {
-            lacpu = LOONGARCH_CPU(qemu_get_cpu(i));
-            lacpu->env.load_elf = true;
-            lacpu->env.elf_address = kernel_addr;
-        }
-    }
 }
 
 static void loongarch_init(MachineState *machine)
@@ -750,7 +654,6 @@ static void loongarch_init(MachineState *machine)
     MachineClass *mc = MACHINE_GET_CLASS(machine);
     CPUState *cpu;
     char *ramName = NULL;
-    struct loaderparams loaderparams = { };
 
     if (!cpu_model) {
         cpu_model = LOONGARCH_CPU_TYPE_NAME("la464");
@@ -844,24 +747,8 @@ static void loongarch_init(MachineState *machine)
                         sizeof(struct memmap_entry) * (memmap_entries));
     }
     fdt_add_fw_cfg_node(lams);
-    loaderparams.ram_size = ram_size;
-    loaderparams.kernel_filename = machine->kernel_filename;
-    loaderparams.kernel_cmdline = machine->kernel_cmdline;
-    loaderparams.initrd_filename = machine->initrd_filename;
-    /* load the kernel. */
-    if (loaderparams.kernel_filename) {
-        if (lams->bios_loaded) {
-            loongarch_firmware_boot(lams, &loaderparams);
-        } else {
-            loongarch_direct_kernel_boot(lams, &loaderparams);
-        }
-    }
     fdt_add_flash_node(lams);
-    /* register reset function */
-    for (i = 0; i < machine->smp.cpus; i++) {
-        lacpu = LOONGARCH_CPU(qemu_get_cpu(i));
-        qemu_register_reset(reset_load_elf, lacpu);
-    }
+
     /* Initialize the IO interrupt subsystem */
     loongarch_irq_init(lams);
     fdt_add_irqchip_node(lams);
@@ -886,6 +773,9 @@ static void loongarch_init(MachineState *machine)
     fdt_base = 1 * MiB;
     qemu_fdt_dumpdtb(machine->fdt, lams->fdt_size);
     rom_add_blob_fixed("fdt", machine->fdt, lams->fdt_size, fdt_base);
+
+    lams->bootinfo.ram_size = ram_size;
+    loongarch_load_kernel(machine, &lams->bootinfo);
 }
 
 bool loongarch_is_acpi_enabled(LoongArchMachineState *lams)
diff --git a/include/hw/loongarch/boot.h b/include/hw/loongarch/boot.h
new file mode 100644
index 0000000000..3275c1e295
--- /dev/null
+++ b/include/hw/loongarch/boot.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Definitions for LoongArch boot.
+ *
+ * Copyright (C) 2023 Loongson Technology Corporation Limited
+ */
+
+#ifndef HW_LOONGARCH_BOOT_H
+#define HW_LOONGARCH_BOOT_H
+
+struct loongarch_boot_info {
+    uint64_t ram_size;
+    const char *kernel_filename;
+    const char *kernel_cmdline;
+    const char *initrd_filename;
+    uint64_t a0, a1, a2;
+};
+
+void loongarch_load_kernel(MachineState *ms, struct loongarch_boot_info *info);
+
+#endif /* HW_LOONGARCH_BOOT_H */
diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
index 674f4655e0..e4126dd0e7 100644
--- a/include/hw/loongarch/virt.h
+++ b/include/hw/loongarch/virt.h
@@ -13,6 +13,7 @@
 #include "qemu/queue.h"
 #include "hw/intc/loongarch_ipi.h"
 #include "hw/block/flash.h"
+#include "hw/loongarch/boot.h"
 
 #define LOONGARCH_MAX_CPUS      256
 
@@ -50,6 +51,7 @@ struct LoongArchMachineState {
     DeviceState *platform_bus_dev;
     PCIBus       *pci_bus;
     PFlashCFI01  *flash;
+    struct loongarch_boot_info bootinfo;
 };
 
 #define TYPE_LOONGARCH_MACHINE  MACHINE_TYPE_NAME("virt")
-- 
2.25.1


