Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4AA9C16C0
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Nov 2024 08:06:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9J3X-0008Uy-3I; Fri, 08 Nov 2024 02:05:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1t9J3S-0008TM-G1
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 02:05:15 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1t9J3N-0006LT-Tt
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 02:05:14 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-720be27db74so1452387b3a.1
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 23:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1731049507; x=1731654307; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uKmLH8reIs8g9XbabZgseiNLeJMY72w7uqSW6boyhdw=;
 b=JTipgaDV58MqNlIXgjroD8FLzRehiQ8/IW7THdNNwWKFChqRDh+pSUNhwHE50PbXy6
 X0GtEB9RR+Hj4VB10nlOXVbpUW8LU8t+ZkEeQiCzo9Kxp7K5gP+DZ59CAT2SCBcNU/Wa
 PFGDmLxsRgO1qloEtZgSP5IZVzNiHgn9bxiTapT+lgMDnUMH84DuYDkylc8PGIqUOKi7
 toBUkqQ3QCeapPO1TzfXVohGVNL84IwVohWslZpPuukhqSoQv/Lvcfz5vmYJNZeMzRWY
 jJ8/5YhIJBFViaufiYFc33Z8Th5uaOqebc5lW6uIqBQiOxfHbL3bvqnvhzQnDZ+a4A8k
 oQVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731049507; x=1731654307;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uKmLH8reIs8g9XbabZgseiNLeJMY72w7uqSW6boyhdw=;
 b=feiJFvSeRAauNAYKUAAF0joIYi4PYOdNXIKA9SreSG7SeXWJUzgdBSweETIq4DOYXM
 Yp4YBMoOinykEMdIV68ZPkT7QrYlBSxAFqx7aKdF0gUM6gQLckznSAuZut7eIGxbo+WU
 wfA1M970Bjmd5i0SDGkp7CcHCLxWoOArAjFt8KhnSwTguPy1+NvsLL+gFT4D4kQlKjoW
 OR/pi17ukDHoX5ISMCbn6EFnlnx024h3LrCoOtbikxC0BTteBN7brqzCeK/pT5ECT62K
 Qt9MvVMZ4UTZItfRAz3EAzDU0+PvV6M/bjo1dkmKWPsPpdywMH+vyspDMb50dSVP1lod
 orXg==
X-Gm-Message-State: AOJu0YzAxtpKrP/B1uiYlIjZx1yRYZzXRAJhPbkREiUg9Np+r9qiKa8V
 yGWBxVw6vw4Ke6buCtbtmoxCyekvkGmh586M4KbIo4AB5nCej9jbvA5m36KGmhKCW06W0Aogpt9
 Ih1VzBCaBdU1IGdcdGu+Z1MC1v5lApXvZSWrOvfSl+AdVK5RpAFjQ3SApo2/OpbCdoSELJmbs2N
 eKgF5uBJQzUO613SK98S2eDAUg9Ac/OH+lMAm4
X-Google-Smtp-Source: AGHT+IH4CisFKINeLqZIxwbEk6snl+6T+gv9fvRydXDNiSzuBoNxf4Y7UMzru9C0cTQ1FdG81BuM1Q==
X-Received: by 2002:a05:6a00:1943:b0:71e:41a6:a0c6 with SMTP id
 d2e1a72fcca58-724140a4ec8mr2840735b3a.13.1731049506997; 
 Thu, 07 Nov 2024 23:05:06 -0800 (PST)
Received: from hsinchu26.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724078a9058sm2900715b3a.77.2024.11.07.23.05.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2024 23:05:06 -0800 (PST)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Jim Shu <jim.shu@sifive.com>
Subject: [PATCH v3 2/3] hw/riscv: Add a new struct RISCVBootInfo
Date: Fri,  8 Nov 2024 15:04:53 +0800
Message-Id: <20241108070454.12699-3-jim.shu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241108070454.12699-1-jim.shu@sifive.com>
References: <20241108070454.12699-1-jim.shu@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=jim.shu@sifive.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add a new struct RISCVBootInfo to sync boot information between multiple
boot functions.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
---
 hw/riscv/boot.c                    | 65 +++++++++++++++++-------------
 hw/riscv/microchip_pfsoc.c         | 12 +++---
 hw/riscv/opentitan.c               |  5 ++-
 hw/riscv/sifive_e.c                |  5 ++-
 hw/riscv/sifive_u.c                | 13 +++---
 hw/riscv/spike.c                   | 13 +++---
 hw/riscv/virt.c                    | 14 ++++---
 include/hw/riscv/boot.h            | 25 ++++++++----
 include/hw/riscv/microchip_pfsoc.h |  1 +
 include/hw/riscv/opentitan.h       |  1 +
 include/hw/riscv/sifive_e.h        |  1 +
 include/hw/riscv/sifive_u.h        |  1 +
 include/hw/riscv/spike.h           |  1 +
 include/hw/riscv/virt.h            |  1 +
 14 files changed, 96 insertions(+), 62 deletions(-)

diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 4e4e106a2b..c7478d2365 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -67,9 +67,15 @@ char *riscv_plic_hart_config_string(int hart_count)
     return g_strjoinv(",", (char **)vals);
 }
 
-target_ulong riscv_calc_kernel_start_addr(RISCVHartArrayState *harts,
+void riscv_boot_info_init(RISCVBootInfo *info, RISCVHartArrayState *harts)
+{
+    info->kernel_size = 0;
+    info->is_32bit = riscv_is_32bit(harts);
+}
+
+target_ulong riscv_calc_kernel_start_addr(RISCVBootInfo *info,
                                           target_ulong firmware_end_addr) {
-    if (riscv_is_32bit(harts)) {
+    if (info->is_32bit) {
         return QEMU_ALIGN_UP(firmware_end_addr, 4 * MiB);
     } else {
         return QEMU_ALIGN_UP(firmware_end_addr, 2 * MiB);
@@ -175,7 +181,7 @@ target_ulong riscv_load_firmware(const char *firmware_filename,
     exit(1);
 }
 
-static void riscv_load_initrd(MachineState *machine, uint64_t kernel_entry)
+static void riscv_load_initrd(MachineState *machine, RISCVBootInfo *info)
 {
     const char *filename = machine->initrd_filename;
     uint64_t mem_size = machine->ram_size;
@@ -196,7 +202,7 @@ static void riscv_load_initrd(MachineState *machine, uint64_t kernel_entry)
      * halfway into RAM, and for boards with 1GB of RAM or more we put
      * the initrd at 512MB.
      */
-    start = kernel_entry + MIN(mem_size / 2, 512 * MiB);
+    start = info->image_low_addr + MIN(mem_size / 2, 512 * MiB);
 
     size = load_ramdisk(filename, start, mem_size - start);
     if (size == -1) {
@@ -215,14 +221,14 @@ static void riscv_load_initrd(MachineState *machine, uint64_t kernel_entry)
     }
 }
 
-target_ulong riscv_load_kernel(MachineState *machine,
-                               RISCVHartArrayState *harts,
-                               target_ulong kernel_start_addr,
-                               bool load_initrd,
-                               symbol_fn_t sym_cb)
+void riscv_load_kernel(MachineState *machine,
+                       RISCVBootInfo *info,
+                       target_ulong kernel_start_addr,
+                       bool load_initrd,
+                       symbol_fn_t sym_cb)
 {
     const char *kernel_filename = machine->kernel_filename;
-    uint64_t kernel_load_base, kernel_entry;
+    ssize_t kernel_size;
     void *fdt = machine->fdt;
 
     g_assert(kernel_filename != NULL);
@@ -234,21 +240,28 @@ target_ulong riscv_load_kernel(MachineState *machine,
      * the (expected) load address load address. This allows kernels to have
      * separate SBI and ELF entry points (used by FreeBSD, for example).
      */
-    if (load_elf_ram_sym(kernel_filename, NULL, NULL, NULL,
-                         NULL, &kernel_load_base, NULL, NULL, 0,
-                         EM_RISCV, 1, 0, NULL, true, sym_cb) > 0) {
-        kernel_entry = kernel_load_base;
+    kernel_size = load_elf_ram_sym(kernel_filename, NULL, NULL, NULL, NULL,
+                                   &info->image_low_addr, &info->image_high_addr,
+                                   NULL, 0, EM_RISCV, 1, 0, NULL, true, sym_cb);
+    if (kernel_size > 0) {
+        info->kernel_size = kernel_size;
         goto out;
     }
 
-    if (load_uimage_as(kernel_filename, &kernel_entry, NULL, NULL,
-                       NULL, NULL, NULL) > 0) {
+    kernel_size = load_uimage_as(kernel_filename, &info->image_low_addr,
+                                 NULL, NULL, NULL, NULL, NULL);
+    if (kernel_size > 0) {
+        info->kernel_size = kernel_size;
+        info->image_high_addr = info->image_low_addr + kernel_size;
         goto out;
     }
 
-    if (load_image_targphys_as(kernel_filename, kernel_start_addr,
-                               current_machine->ram_size, NULL) > 0) {
-        kernel_entry = kernel_start_addr;
+    kernel_size = load_image_targphys_as(kernel_filename, kernel_start_addr,
+                                         current_machine->ram_size, NULL);
+    if (kernel_size > 0) {
+        info->kernel_size = kernel_size;
+        info->image_low_addr = kernel_start_addr;
+        info->image_high_addr = info->image_low_addr + kernel_size;
         goto out;
     }
 
@@ -257,23 +270,21 @@ target_ulong riscv_load_kernel(MachineState *machine,
 
 out:
     /*
-     * For 32 bit CPUs 'kernel_entry' can be sign-extended by
+     * For 32 bit CPUs 'image_low_addr' can be sign-extended by
      * load_elf_ram_sym().
      */
-    if (riscv_is_32bit(harts)) {
-        kernel_entry = extract64(kernel_entry, 0, 32);
+    if (info->is_32bit) {
+        info->image_low_addr = extract64(info->image_low_addr, 0, 32);
     }
 
     if (load_initrd && machine->initrd_filename) {
-        riscv_load_initrd(machine, kernel_entry);
+        riscv_load_initrd(machine, info);
     }
 
     if (fdt && machine->kernel_cmdline && *machine->kernel_cmdline) {
         qemu_fdt_setprop_string(fdt, "/chosen", "bootargs",
                                 machine->kernel_cmdline);
     }
-
-    return kernel_entry;
 }
 
 /*
@@ -293,7 +304,7 @@ out:
  * The FDT is fdt_packed() during the calculation.
  */
 uint64_t riscv_compute_fdt_addr(hwaddr dram_base, hwaddr dram_size,
-                                MachineState *ms, RISCVHartArrayState *harts)
+                                MachineState *ms, RISCVBootInfo *info)
 {
     int ret = fdt_pack(ms->fdt);
     hwaddr dram_end, temp;
@@ -321,7 +332,7 @@ uint64_t riscv_compute_fdt_addr(hwaddr dram_base, hwaddr dram_size,
      * Thus, put it at an 2MB aligned address that less than fdt size from the
      * end of dram or 3GB whichever is lesser.
      */
-    if (!riscv_is_32bit(harts)) {
+    if (!info->is_32bit) {
         temp = dram_end;
     } else {
         temp = (dram_base < 3072 * MiB) ? MIN(dram_end, 3072 * MiB) : dram_end;
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index ba8b0a2c26..ad51e12f80 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -46,7 +46,6 @@
 #include "hw/cpu/cluster.h"
 #include "target/riscv/cpu.h"
 #include "hw/misc/unimp.h"
-#include "hw/riscv/boot.h"
 #include "hw/riscv/riscv_hart.h"
 #include "hw/riscv/microchip_pfsoc.h"
 #include "hw/intc/riscv_aclint.h"
@@ -521,6 +520,7 @@ static void microchip_icicle_kit_machine_init(MachineState *machine)
     uint64_t kernel_entry;
     uint64_t fdt_load_addr;
     DriveInfo *dinfo = drive_get(IF_SD, 0, 0);
+    RISCVBootInfo boot_info;
 
     /* Sanity check on RAM size */
     if (machine->ram_size < mc->default_ram_size) {
@@ -615,17 +615,19 @@ static void microchip_icicle_kit_machine_init(MachineState *machine)
     firmware_end_addr = riscv_find_and_load_firmware(machine, firmware_name,
                                                      &firmware_load_addr, NULL);
 
+    riscv_boot_info_init(&boot_info, &s->soc.u_cpus);
     if (kernel_as_payload) {
-        kernel_start_addr = riscv_calc_kernel_start_addr(&s->soc.u_cpus,
+        kernel_start_addr = riscv_calc_kernel_start_addr(&boot_info,
                                                          firmware_end_addr);
 
-        kernel_entry = riscv_load_kernel(machine, &s->soc.u_cpus,
-                                         kernel_start_addr, true, NULL);
+        riscv_load_kernel(machine, &boot_info, kernel_start_addr,
+                          true, NULL);
+        kernel_entry = boot_info.image_low_addr;
 
         /* Compute the fdt load address in dram */
         fdt_load_addr = riscv_compute_fdt_addr(memmap[MICROCHIP_PFSOC_DRAM_LO].base,
                                                memmap[MICROCHIP_PFSOC_DRAM_LO].size,
-                                               machine, &s->soc.u_cpus);
+                                               machine, &boot_info);
         riscv_load_fdt(fdt_load_addr, machine->fdt);
 
         /* Load the reset vector */
diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
index e2830e9dc2..5382f3e82c 100644
--- a/hw/riscv/opentitan.c
+++ b/hw/riscv/opentitan.c
@@ -25,7 +25,6 @@
 #include "qemu/error-report.h"
 #include "hw/boards.h"
 #include "hw/misc/unimp.h"
-#include "hw/riscv/boot.h"
 #include "qemu/units.h"
 #include "sysemu/sysemu.h"
 
@@ -81,6 +80,7 @@ static void opentitan_machine_init(MachineState *machine)
     OpenTitanState *s = OPENTITAN_MACHINE(machine);
     const MemMapEntry *memmap = ibex_memmap;
     MemoryRegion *sys_mem = get_system_memory();
+    RISCVBootInfo boot_info;
 
     if (machine->ram_size != mc->default_ram_size) {
         char *sz = size_to_str(mc->default_ram_size);
@@ -102,8 +102,9 @@ static void opentitan_machine_init(MachineState *machine)
         riscv_load_firmware(machine->firmware, &firmware_load_addr, NULL);
     }
 
+    riscv_boot_info_init(&boot_info, &s->soc.cpus);
     if (machine->kernel_filename) {
-        riscv_load_kernel(machine, &s->soc.cpus,
+        riscv_load_kernel(machine, &boot_info,
                           memmap[IBEX_DEV_RAM].base,
                           false, NULL);
     }
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 5a1959f2a9..a91ae76bd8 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -39,7 +39,6 @@
 #include "target/riscv/cpu.h"
 #include "hw/riscv/riscv_hart.h"
 #include "hw/riscv/sifive_e.h"
-#include "hw/riscv/boot.h"
 #include "hw/char/sifive_uart.h"
 #include "hw/intc/riscv_aclint.h"
 #include "hw/intc/sifive_plic.h"
@@ -78,6 +77,7 @@ static void sifive_e_machine_init(MachineState *machine)
     SiFiveEState *s = RISCV_E_MACHINE(machine);
     MemoryRegion *sys_mem = get_system_memory();
     int i;
+    RISCVBootInfo boot_info;
 
     if (machine->ram_size != mc->default_ram_size) {
         char *sz = size_to_str(mc->default_ram_size);
@@ -113,8 +113,9 @@ static void sifive_e_machine_init(MachineState *machine)
     rom_add_blob_fixed_as("mrom.reset", reset_vec, sizeof(reset_vec),
                           memmap[SIFIVE_E_DEV_MROM].base, &address_space_memory);
 
+    riscv_boot_info_init(&boot_info, &s->soc.cpus);
     if (machine->kernel_filename) {
-        riscv_load_kernel(machine, &s->soc.cpus,
+        riscv_load_kernel(machine, &boot_info,
                           memmap[SIFIVE_E_DEV_DTIM].base,
                           false, NULL);
     }
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 05467e833a..68f92c03f1 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -50,7 +50,6 @@
 #include "target/riscv/cpu.h"
 #include "hw/riscv/riscv_hart.h"
 #include "hw/riscv/sifive_u.h"
-#include "hw/riscv/boot.h"
 #include "hw/char/sifive_uart.h"
 #include "hw/intc/riscv_aclint.h"
 #include "hw/intc/sifive_plic.h"
@@ -525,6 +524,7 @@ static void sifive_u_machine_init(MachineState *machine)
     BlockBackend *blk;
     DeviceState *flash_dev, *sd_dev, *card_dev;
     qemu_irq flash_cs, sd_cs;
+    RISCVBootInfo boot_info;
 
     /* Initialize SoC */
     object_initialize_child(OBJECT(machine), "soc", &s->soc, TYPE_RISCV_U_SOC);
@@ -590,12 +590,13 @@ static void sifive_u_machine_init(MachineState *machine)
     firmware_end_addr = riscv_find_and_load_firmware(machine, firmware_name,
                                                      &start_addr, NULL);
 
+    riscv_boot_info_init(&boot_info, &s->soc.u_cpus);
     if (machine->kernel_filename) {
-        kernel_start_addr = riscv_calc_kernel_start_addr(&s->soc.u_cpus,
+        kernel_start_addr = riscv_calc_kernel_start_addr(&boot_info,
                                                          firmware_end_addr);
-
-        kernel_entry = riscv_load_kernel(machine, &s->soc.u_cpus,
-                                         kernel_start_addr, true, NULL);
+        riscv_load_kernel(machine, &boot_info, kernel_start_addr,
+                          true, NULL);
+        kernel_entry = boot_info.image_low_addr;
     } else {
        /*
         * If dynamic firmware is used, it doesn't know where is the next mode
@@ -606,7 +607,7 @@ static void sifive_u_machine_init(MachineState *machine)
 
     fdt_load_addr = riscv_compute_fdt_addr(memmap[SIFIVE_U_DEV_DRAM].base,
                                            memmap[SIFIVE_U_DEV_DRAM].size,
-                                           machine, &s->soc.u_cpus);
+                                           machine, &boot_info);
     riscv_load_fdt(fdt_load_addr, machine->fdt);
 
     if (!riscv_is_32bit(&s->soc.u_cpus)) {
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index acd7ab1ae1..72e850e704 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -31,7 +31,6 @@
 #include "target/riscv/cpu.h"
 #include "hw/riscv/riscv_hart.h"
 #include "hw/riscv/spike.h"
-#include "hw/riscv/boot.h"
 #include "hw/riscv/numa.h"
 #include "hw/char/riscv_htif.h"
 #include "hw/intc/riscv_aclint.h"
@@ -206,6 +205,7 @@ static void spike_board_init(MachineState *machine)
     char *soc_name;
     int i, base_hartid, hart_count;
     bool htif_custom_base = false;
+    RISCVBootInfo boot_info;
 
     /* Check socket count limit */
     if (SPIKE_SOCKETS_MAX < riscv_socket_count(machine)) {
@@ -300,13 +300,14 @@ static void spike_board_init(MachineState *machine)
     create_fdt(s, memmap, riscv_is_32bit(&s->soc[0]), htif_custom_base);
 
     /* Load kernel */
+    riscv_boot_info_init(&boot_info, &s->soc[0]);
     if (machine->kernel_filename) {
-        kernel_start_addr = riscv_calc_kernel_start_addr(&s->soc[0],
+        kernel_start_addr = riscv_calc_kernel_start_addr(&boot_info,
                                                          firmware_end_addr);
 
-        kernel_entry = riscv_load_kernel(machine, &s->soc[0],
-                                         kernel_start_addr,
-                                         true, htif_symbol_callback);
+        riscv_load_kernel(machine, &boot_info, kernel_start_addr,
+                          true, htif_symbol_callback);
+        kernel_entry = boot_info.image_low_addr;
     } else {
        /*
         * If dynamic firmware is used, it doesn't know where is the next mode
@@ -317,7 +318,7 @@ static void spike_board_init(MachineState *machine)
 
     fdt_load_addr = riscv_compute_fdt_addr(memmap[SPIKE_DRAM].base,
                                            memmap[SPIKE_DRAM].size,
-                                           machine, &s->soc[0]);
+                                           machine, &boot_info);
     riscv_load_fdt(fdt_load_addr, machine->fdt);
 
     /* load the reset vector */
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 761bce3304..4df0041054 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -34,7 +34,6 @@
 #include "hw/riscv/riscv_hart.h"
 #include "hw/riscv/iommu.h"
 #include "hw/riscv/virt.h"
-#include "hw/riscv/boot.h"
 #include "hw/riscv/numa.h"
 #include "kvm/kvm_riscv.h"
 #include "hw/firmware/smbios.h"
@@ -1366,6 +1365,7 @@ static void virt_machine_done(Notifier *notifier, void *data)
     uint64_t fdt_load_addr;
     uint64_t kernel_entry = 0;
     BlockBackend *pflash_blk0;
+    RISCVBootInfo boot_info;
 
     /*
      * An user provided dtb must include everything, including
@@ -1414,17 +1414,19 @@ static void virt_machine_done(Notifier *notifier, void *data)
         }
     }
 
+    riscv_boot_info_init(&boot_info, &s->soc[0]);
+
     if (machine->kernel_filename && !kernel_entry) {
-        kernel_start_addr = riscv_calc_kernel_start_addr(&s->soc[0],
+        kernel_start_addr = riscv_calc_kernel_start_addr(&boot_info,
                                                          firmware_end_addr);
-
-        kernel_entry = riscv_load_kernel(machine, &s->soc[0],
-                                         kernel_start_addr, true, NULL);
+        riscv_load_kernel(machine, &boot_info, kernel_start_addr,
+                          true, NULL);
+        kernel_entry = boot_info.image_low_addr;
     }
 
     fdt_load_addr = riscv_compute_fdt_addr(memmap[VIRT_DRAM].base,
                                            memmap[VIRT_DRAM].size,
-                                           machine, &s->soc[0]);
+                                           machine, &boot_info);
     riscv_load_fdt(fdt_load_addr, machine->fdt);
 
     /* load the reset vector */
diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
index 34a80c5ff4..719ee1fe5f 100644
--- a/include/hw/riscv/boot.h
+++ b/include/hw/riscv/boot.h
@@ -27,11 +27,20 @@
 #define RISCV32_BIOS_BIN    "opensbi-riscv32-generic-fw_dynamic.bin"
 #define RISCV64_BIOS_BIN    "opensbi-riscv64-generic-fw_dynamic.bin"
 
+typedef struct RISCVBootInfo {
+    ssize_t kernel_size;
+    uint64_t image_low_addr;
+    uint64_t image_high_addr;
+
+    bool is_32bit;
+} RISCVBootInfo;
+
 bool riscv_is_32bit(RISCVHartArrayState *harts);
 
 char *riscv_plic_hart_config_string(int hart_count);
 
-target_ulong riscv_calc_kernel_start_addr(RISCVHartArrayState *harts,
+void riscv_boot_info_init(RISCVBootInfo *info, RISCVHartArrayState *harts);
+target_ulong riscv_calc_kernel_start_addr(RISCVBootInfo *info,
                                           target_ulong firmware_end_addr);
 target_ulong riscv_find_and_load_firmware(MachineState *machine,
                                           const char *default_machine_firmware,
@@ -43,13 +52,13 @@ char *riscv_find_firmware(const char *firmware_filename,
 target_ulong riscv_load_firmware(const char *firmware_filename,
                                  hwaddr *firmware_load_addr,
                                  symbol_fn_t sym_cb);
-target_ulong riscv_load_kernel(MachineState *machine,
-                               RISCVHartArrayState *harts,
-                               target_ulong firmware_end_addr,
-                               bool load_initrd,
-                               symbol_fn_t sym_cb);
-uint64_t riscv_compute_fdt_addr(hwaddr dram_start, uint64_t dram_size,
-                                MachineState *ms, RISCVHartArrayState *harts);
+void riscv_load_kernel(MachineState *machine,
+                       RISCVBootInfo *info,
+                       target_ulong kernel_start_addr,
+                       bool load_initrd,
+                       symbol_fn_t sym_cb);
+uint64_t riscv_compute_fdt_addr(hwaddr dram_base, hwaddr dram_size,
+                                MachineState *ms, RISCVBootInfo *info);
 void riscv_load_fdt(hwaddr fdt_addr, void *fdt);
 void riscv_setup_rom_reset_vec(MachineState *machine, RISCVHartArrayState *harts,
                                hwaddr saddr,
diff --git a/include/hw/riscv/microchip_pfsoc.h b/include/hw/riscv/microchip_pfsoc.h
index daef086da6..c74de0d450 100644
--- a/include/hw/riscv/microchip_pfsoc.h
+++ b/include/hw/riscv/microchip_pfsoc.h
@@ -32,6 +32,7 @@
 #include "hw/net/cadence_gem.h"
 #include "hw/sd/cadence_sdhci.h"
 #include "hw/riscv/riscv_hart.h"
+#include "hw/riscv/boot.h"
 
 typedef struct MicrochipPFSoCState {
     /*< private >*/
diff --git a/include/hw/riscv/opentitan.h b/include/hw/riscv/opentitan.h
index 609473d07b..562ba845dc 100644
--- a/include/hw/riscv/opentitan.h
+++ b/include/hw/riscv/opentitan.h
@@ -26,6 +26,7 @@
 #include "hw/ssi/ibex_spi_host.h"
 #include "hw/boards.h"
 #include "qom/object.h"
+#include "hw/riscv/boot.h"
 
 #define TYPE_RISCV_IBEX_SOC "riscv.lowrisc.ibex.soc"
 OBJECT_DECLARE_SIMPLE_TYPE(LowRISCIbexSoCState, RISCV_IBEX_SOC)
diff --git a/include/hw/riscv/sifive_e.h b/include/hw/riscv/sifive_e.h
index 31180a680e..eda149ecad 100644
--- a/include/hw/riscv/sifive_e.h
+++ b/include/hw/riscv/sifive_e.h
@@ -24,6 +24,7 @@
 #include "hw/gpio/sifive_gpio.h"
 #include "hw/misc/sifive_e_aon.h"
 #include "hw/boards.h"
+#include "hw/riscv/boot.h"
 
 #define TYPE_RISCV_E_SOC "riscv.sifive.e.soc"
 #define RISCV_E_SOC(obj) \
diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index 0696f85942..620353375a 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -30,6 +30,7 @@
 #include "hw/misc/sifive_u_prci.h"
 #include "hw/ssi/sifive_spi.h"
 #include "hw/timer/sifive_pwm.h"
+#include "hw/riscv/boot.h"
 
 #define TYPE_RISCV_U_SOC "riscv.sifive.u.soc"
 #define RISCV_U_SOC(obj) \
diff --git a/include/hw/riscv/spike.h b/include/hw/riscv/spike.h
index 0c2a223763..9208e77482 100644
--- a/include/hw/riscv/spike.h
+++ b/include/hw/riscv/spike.h
@@ -22,6 +22,7 @@
 #include "hw/boards.h"
 #include "hw/riscv/riscv_hart.h"
 #include "hw/sysbus.h"
+#include "hw/riscv/boot.h"
 
 #define SPIKE_CPUS_MAX 8
 #define SPIKE_SOCKETS_MAX 8
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index c0dc41ff9a..5f092b943a 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -24,6 +24,7 @@
 #include "hw/sysbus.h"
 #include "hw/block/flash.h"
 #include "hw/intc/riscv_imsic.h"
+#include "hw/riscv/boot.h"
 
 #define VIRT_CPUS_MAX_BITS             9
 #define VIRT_CPUS_MAX                  (1 << VIRT_CPUS_MAX_BITS)
-- 
2.17.1


