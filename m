Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90842BDEC0C
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Oct 2025 15:27:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v91VR-0001ds-7h; Wed, 15 Oct 2025 09:25:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v91VN-0001bI-VG
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 09:25:25 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v91V9-0003Sw-AY
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 09:25:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=Xz2NpxhM9MIFaZrxt7g1FICYmFVQb5UYMNS01g6EvMg=; b=lo72Y50XNNdmt66
 0/HfRqiYGyngHre9iG29PszxUxnZtaTHoDWL9tCKJxSKYE5z4f7NNOyMKyWgfn55GkFL8YcN1sO4S
 iM82ulkir5LyoNZgQg0SO01jE3c54PEhuh24C4wWfxZugTNZz8fh8KiSmX+DTQQWqD9jcLhm9uoPF
 QE=;
Date: Wed, 15 Oct 2025 15:27:38 +0200
Subject: [PATCH 1/5] hw/riscv: Use generic hwaddr for firmware addressses
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-feature-single-binary-hw-v1-v1-1-8b416eda42cf@rev.ng>
References: <20251015-feature-single-binary-hw-v1-v1-0-8b416eda42cf@rev.ng>
In-Reply-To: <20251015-feature-single-binary-hw-v1-v1-0-8b416eda42cf@rev.ng>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, philmd@linaro.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, palmer@dabbelt.com
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 include/hw/riscv/boot.h    | 20 ++++++++++----------
 hw/riscv/boot.c            | 22 +++++++++++-----------
 hw/riscv/microchip_pfsoc.c |  2 +-
 hw/riscv/sifive_u.c        |  2 +-
 hw/riscv/spike.c           |  4 ++--
 hw/riscv/virt.c            |  2 +-
 6 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
index 7d59b2e6c6..d835594baa 100644
--- a/include/hw/riscv/boot.h
+++ b/include/hw/riscv/boot.h
@@ -43,21 +43,21 @@ bool riscv_is_32bit(RISCVHartArrayState *harts);
 char *riscv_plic_hart_config_string(int hart_count);
 
 void riscv_boot_info_init(RISCVBootInfo *info, RISCVHartArrayState *harts);
-target_ulong riscv_calc_kernel_start_addr(RISCVBootInfo *info,
-                                          target_ulong firmware_end_addr);
-target_ulong riscv_find_and_load_firmware(MachineState *machine,
-                                          const char *default_machine_firmware,
-                                          hwaddr *firmware_load_addr,
-                                          symbol_fn_t sym_cb);
+hwaddr riscv_calc_kernel_start_addr(RISCVBootInfo *info,
+                                    hwaddr firmware_end_addr);
+hwaddr riscv_find_and_load_firmware(MachineState *machine,
+                                    const char *default_machine_firmware,
+                                    hwaddr *firmware_load_addr,
+                                    symbol_fn_t sym_cb);
 const char *riscv_default_firmware_name(RISCVHartArrayState *harts);
 char *riscv_find_firmware(const char *firmware_filename,
                           const char *default_machine_firmware);
-target_ulong riscv_load_firmware(const char *firmware_filename,
-                                 hwaddr *firmware_load_addr,
-                                 symbol_fn_t sym_cb);
+hwaddr riscv_load_firmware(const char *firmware_filename,
+                           hwaddr *firmware_load_addr,
+                           symbol_fn_t sym_cb);
 void riscv_load_kernel(MachineState *machine,
                        RISCVBootInfo *info,
-                       target_ulong kernel_start_addr,
+                       hwaddr kernel_start_addr,
                        bool load_initrd,
                        symbol_fn_t sym_cb);
 uint64_t riscv_compute_fdt_addr(hwaddr dram_base, hwaddr dram_size,
diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 828a867be3..4eadcff26c 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -74,8 +74,8 @@ void riscv_boot_info_init(RISCVBootInfo *info, RISCVHartArrayState *harts)
     info->is_32bit = riscv_is_32bit(harts);
 }
 
-target_ulong riscv_calc_kernel_start_addr(RISCVBootInfo *info,
-                                          target_ulong firmware_end_addr) {
+hwaddr riscv_calc_kernel_start_addr(RISCVBootInfo *info,
+                                    hwaddr firmware_end_addr) {
     if (info->is_32bit) {
         return QEMU_ALIGN_UP(firmware_end_addr, 4 * MiB);
     } else {
@@ -133,13 +133,13 @@ char *riscv_find_firmware(const char *firmware_filename,
     return filename;
 }
 
-target_ulong riscv_find_and_load_firmware(MachineState *machine,
-                                          const char *default_machine_firmware,
-                                          hwaddr *firmware_load_addr,
-                                          symbol_fn_t sym_cb)
+hwaddr riscv_find_and_load_firmware(MachineState *machine,
+                                    const char *default_machine_firmware,
+                                    hwaddr *firmware_load_addr,
+                                    symbol_fn_t sym_cb)
 {
     char *firmware_filename;
-    target_ulong firmware_end_addr = *firmware_load_addr;
+    hwaddr firmware_end_addr = *firmware_load_addr;
 
     firmware_filename = riscv_find_firmware(machine->firmware,
                                             default_machine_firmware);
@@ -154,9 +154,9 @@ target_ulong riscv_find_and_load_firmware(MachineState *machine,
     return firmware_end_addr;
 }
 
-target_ulong riscv_load_firmware(const char *firmware_filename,
-                                 hwaddr *firmware_load_addr,
-                                 symbol_fn_t sym_cb)
+hwaddr riscv_load_firmware(const char *firmware_filename,
+                           hwaddr *firmware_load_addr,
+                           symbol_fn_t sym_cb)
 {
     uint64_t firmware_entry, firmware_end;
     ssize_t firmware_size;
@@ -227,7 +227,7 @@ static void riscv_load_initrd(MachineState *machine, RISCVBootInfo *info)
 
 void riscv_load_kernel(MachineState *machine,
                        RISCVBootInfo *info,
-                       target_ulong kernel_start_addr,
+                       hwaddr kernel_start_addr,
                        bool load_initrd,
                        symbol_fn_t sym_cb)
 {
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 2e74783fce..e5a0196a00 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -515,7 +515,7 @@ static void microchip_icicle_kit_machine_init(MachineState *machine)
     uint64_t mem_low_size, mem_high_size;
     hwaddr firmware_load_addr;
     const char *firmware_name;
-    target_ulong firmware_end_addr, kernel_start_addr;
+    hwaddr firmware_end_addr, kernel_start_addr;
     uint64_t kernel_entry;
     uint64_t fdt_load_addr;
     DriveInfo *dinfo = drive_get(IF_SD, 0, 0);
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index d69f942cfb..390f9b8d9a 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -515,7 +515,7 @@ static void sifive_u_machine_init(MachineState *machine)
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *flash0 = g_new(MemoryRegion, 1);
     hwaddr start_addr = memmap[SIFIVE_U_DEV_DRAM].base;
-    target_ulong firmware_end_addr, kernel_start_addr;
+    hwaddr firmware_end_addr, kernel_start_addr;
     const char *firmware_name;
     uint32_t start_addr_hi32 = 0x00000000;
     uint32_t fdt_load_addr_hi32 = 0x00000000;
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 641aae8c01..b0bab3fe00 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -197,9 +197,9 @@ static void spike_board_init(MachineState *machine)
     SpikeState *s = SPIKE_MACHINE(machine);
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
-    target_ulong firmware_end_addr = memmap[SPIKE_DRAM].base;
+    hwaddr firmware_end_addr = memmap[SPIKE_DRAM].base;
     hwaddr firmware_load_addr = memmap[SPIKE_DRAM].base;
-    target_ulong kernel_start_addr;
+    hwaddr kernel_start_addr;
     char *firmware_name;
     uint64_t fdt_load_addr;
     uint64_t kernel_entry;
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 47e573f85a..17909206c7 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1434,7 +1434,7 @@ static void virt_machine_done(Notifier *notifier, void *data)
                                      machine_done);
     MachineState *machine = MACHINE(s);
     hwaddr start_addr = s->memmap[VIRT_DRAM].base;
-    target_ulong firmware_end_addr, kernel_start_addr;
+    hwaddr firmware_end_addr, kernel_start_addr;
     const char *firmware_name = riscv_default_firmware_name(&s->soc[0]);
     uint64_t fdt_load_addr;
     uint64_t kernel_entry = 0;

-- 
2.51.0


