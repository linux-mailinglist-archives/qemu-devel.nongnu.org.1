Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC63B984DA7
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Sep 2024 00:22:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stDsY-0000bI-OQ; Tue, 24 Sep 2024 18:19:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1stDsU-0000PE-Ef
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 18:19:26 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1stDsS-0001iR-DL
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 18:19:26 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-71798a15ce5so236507b3a.0
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2024 15:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727216362; x=1727821162; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R5jHY/cvRvWBnggTvUa1x3wfsBE/MV3qbf/f2sAmW9c=;
 b=DGWcnxD2txfbKzEFRd/nlkncKtQ9OZ3YoOIgReXOHZlVGOQDJDUFhsExulAezYNmQq
 H5unD6R7UryhyPFwo8JGfRVdmHpKm19e5a2lKaqtfQH8TGkKNrU6Hq4vUc86BNtOeHI8
 SpCCgjw3V24GX5420vSpicFbe2prOVEN12pOAawdgPcxFEeO1kvkCVGKWHroMtzOMSWl
 jdgcToE2RLLIFWRxC+knTynMs0koUcVB4dMvRAvknJqmV4IgpaE2y4csyC5DGjwdcKc4
 uLeVLIghCgRm/VaSj4wObjDXYv3poP9v2CV1oOyR0GmfoPHIfChjYhvIMRVR1Muvau3o
 kqfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727216362; x=1727821162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R5jHY/cvRvWBnggTvUa1x3wfsBE/MV3qbf/f2sAmW9c=;
 b=T25rhczNhdCChlmZg6OGtyOyNE0nDCCJ/LXXar13sGHYQyvS/YNuK0GuaTUQbhjTW0
 R2fw1fDFu7u8sDu51oQHuNmWFZwGkdGW2BoTXnOd+F1BIl7uY980WiKvgq8S1ZUiB++W
 ofBkGXvYP8GYrTgWv2GHEXE+DskBPGH2QSOzifKOIHei2Z/pdSUmYy2k8mnLVDPnrgeU
 3mHYsClvpUGaqqH6Hq08Etu2yViDnJnqXlzj11hKRf7Rf+vmhp8tni7d+GGDF12ACIkd
 X10L4wYOIXa3Cuodsr7AJX95zXzz68EU0iOA5w8Q4MrhPrCmHUGkkMa5aHJuUw047j27
 W8sg==
X-Gm-Message-State: AOJu0YzcpvXYbxwnm4Wr0gDfDJcwEw+nhzMbIxH+iwrHsy4G1+F9HtOo
 svUYIlGaiq21EaYC0wJ1zbDI82/3lgdCew/Ft6Z0sR/aKgDZPxuktoPOXg==
X-Google-Smtp-Source: AGHT+IHIzhsC8RvGMfzMgQmCr9l/HsfhPyQPKHCYlm8Uepk/KV9zj2OxZPjfMZ27dNq916gjvMgDNA==
X-Received: by 2002:a05:6a00:ad2:b0:707:fa61:1c6a with SMTP id
 d2e1a72fcca58-71b0b2bd2e0mr982094b3a.10.1727216361641; 
 Tue, 24 Sep 2024 15:19:21 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71afc8342easm1665310b3a.11.2024.09.24.15.19.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2024 15:19:21 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Samuel Holland <samuel.holland@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 26/47] hw/riscv: Respect firmware ELF entry point
Date: Wed, 25 Sep 2024 08:17:27 +1000
Message-ID: <20240924221751.2688389-27-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240924221751.2688389-1-alistair.francis@wdc.com>
References: <20240924221751.2688389-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Samuel Holland <samuel.holland@sifive.com>

When riscv_load_firmware() loads an ELF, the ELF segment addresses are
used, not the passed-in firmware_load_addr. The machine models assume
the firmware entry point is what they provided for firmware_load_addr,
and use that address to generate the boot ROM, so if the ELF is linked
at any other address, the boot ROM will jump to empty memory.

Pass back the ELF entry point to use when generating the boot ROM, so
the boot ROM can jump to firmware loaded anywhere in RAM. For example,
on the virt machine, this allows using an OpenSBI fw_dynamic.elf built
with FW_TEXT_START values other than 0x80000000.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240817002651.3209701-1-samuel.holland@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/boot.h    |  4 ++--
 hw/riscv/boot.c            | 11 ++++++-----
 hw/riscv/microchip_pfsoc.c |  2 +-
 hw/riscv/opentitan.c       |  3 ++-
 hw/riscv/shakti_c.c        | 13 ++++++-------
 hw/riscv/sifive_u.c        |  4 ++--
 hw/riscv/spike.c           |  5 +++--
 hw/riscv/virt.c            |  4 ++--
 8 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
index a2e4ae9cb0..18bfe9f7bf 100644
--- a/include/hw/riscv/boot.h
+++ b/include/hw/riscv/boot.h
@@ -35,13 +35,13 @@ target_ulong riscv_calc_kernel_start_addr(RISCVHartArrayState *harts,
                                           target_ulong firmware_end_addr);
 target_ulong riscv_find_and_load_firmware(MachineState *machine,
                                           const char *default_machine_firmware,
-                                          hwaddr firmware_load_addr,
+                                          hwaddr *firmware_load_addr,
                                           symbol_fn_t sym_cb);
 const char *riscv_default_firmware_name(RISCVHartArrayState *harts);
 char *riscv_find_firmware(const char *firmware_filename,
                           const char *default_machine_firmware);
 target_ulong riscv_load_firmware(const char *firmware_filename,
-                                 hwaddr firmware_load_addr,
+                                 hwaddr *firmware_load_addr,
                                  symbol_fn_t sym_cb);
 target_ulong riscv_load_kernel(MachineState *machine,
                                RISCVHartArrayState *harts,
diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 47281ca853..9115ecd91f 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -128,11 +128,11 @@ char *riscv_find_firmware(const char *firmware_filename,
 
 target_ulong riscv_find_and_load_firmware(MachineState *machine,
                                           const char *default_machine_firmware,
-                                          hwaddr firmware_load_addr,
+                                          hwaddr *firmware_load_addr,
                                           symbol_fn_t sym_cb)
 {
     char *firmware_filename;
-    target_ulong firmware_end_addr = firmware_load_addr;
+    target_ulong firmware_end_addr = *firmware_load_addr;
 
     firmware_filename = riscv_find_firmware(machine->firmware,
                                             default_machine_firmware);
@@ -148,7 +148,7 @@ target_ulong riscv_find_and_load_firmware(MachineState *machine,
 }
 
 target_ulong riscv_load_firmware(const char *firmware_filename,
-                                 hwaddr firmware_load_addr,
+                                 hwaddr *firmware_load_addr,
                                  symbol_fn_t sym_cb)
 {
     uint64_t firmware_entry, firmware_end;
@@ -159,15 +159,16 @@ target_ulong riscv_load_firmware(const char *firmware_filename,
     if (load_elf_ram_sym(firmware_filename, NULL, NULL, NULL,
                          &firmware_entry, NULL, &firmware_end, NULL,
                          0, EM_RISCV, 1, 0, NULL, true, sym_cb) > 0) {
+        *firmware_load_addr = firmware_entry;
         return firmware_end;
     }
 
     firmware_size = load_image_targphys_as(firmware_filename,
-                                           firmware_load_addr,
+                                           *firmware_load_addr,
                                            current_machine->ram_size, NULL);
 
     if (firmware_size > 0) {
-        return firmware_load_addr + firmware_size;
+        return *firmware_load_addr + firmware_size;
     }
 
     error_report("could not load firmware '%s'", firmware_filename);
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 7725dfbde5..f9a3b43d2e 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -613,7 +613,7 @@ static void microchip_icicle_kit_machine_init(MachineState *machine)
 
     /* Load the firmware */
     firmware_end_addr = riscv_find_and_load_firmware(machine, firmware_name,
-                                                     firmware_load_addr, NULL);
+                                                     &firmware_load_addr, NULL);
 
     if (kernel_as_payload) {
         kernel_start_addr = riscv_calc_kernel_start_addr(&s->soc.u_cpus,
diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
index 436503f1ba..e2830e9dc2 100644
--- a/hw/riscv/opentitan.c
+++ b/hw/riscv/opentitan.c
@@ -98,7 +98,8 @@ static void opentitan_machine_init(MachineState *machine)
         memmap[IBEX_DEV_RAM].base, machine->ram);
 
     if (machine->firmware) {
-        riscv_load_firmware(machine->firmware, memmap[IBEX_DEV_RAM].base, NULL);
+        hwaddr firmware_load_addr = memmap[IBEX_DEV_RAM].base;
+        riscv_load_firmware(machine->firmware, &firmware_load_addr, NULL);
     }
 
     if (machine->kernel_filename) {
diff --git a/hw/riscv/shakti_c.c b/hw/riscv/shakti_c.c
index 3888034c2b..2dccc1eff2 100644
--- a/hw/riscv/shakti_c.c
+++ b/hw/riscv/shakti_c.c
@@ -45,6 +45,7 @@ static void shakti_c_machine_state_init(MachineState *mstate)
 {
     ShaktiCMachineState *sms = RISCV_SHAKTI_MACHINE(mstate);
     MemoryRegion *system_memory = get_system_memory();
+    hwaddr firmware_load_addr = shakti_c_memmap[SHAKTI_C_RAM].base;
 
     /* Initialize SoC */
     object_initialize_child(OBJECT(mstate), "soc", &sms->soc,
@@ -56,16 +57,14 @@ static void shakti_c_machine_state_init(MachineState *mstate)
                                 shakti_c_memmap[SHAKTI_C_RAM].base,
                                 mstate->ram);
 
+    if (mstate->firmware) {
+        riscv_load_firmware(mstate->firmware, &firmware_load_addr, NULL);
+    }
+
     /* ROM reset vector */
-    riscv_setup_rom_reset_vec(mstate, &sms->soc.cpus,
-                              shakti_c_memmap[SHAKTI_C_RAM].base,
+    riscv_setup_rom_reset_vec(mstate, &sms->soc.cpus, firmware_load_addr,
                               shakti_c_memmap[SHAKTI_C_ROM].base,
                               shakti_c_memmap[SHAKTI_C_ROM].size, 0, 0);
-    if (mstate->firmware) {
-        riscv_load_firmware(mstate->firmware,
-                            shakti_c_memmap[SHAKTI_C_RAM].base,
-                            NULL);
-    }
 }
 
 static void shakti_c_machine_instance_init(Object *obj)
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index af5f923f54..35a689309d 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -515,7 +515,7 @@ static void sifive_u_machine_init(MachineState *machine)
     SiFiveUState *s = RISCV_U_MACHINE(machine);
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *flash0 = g_new(MemoryRegion, 1);
-    target_ulong start_addr = memmap[SIFIVE_U_DEV_DRAM].base;
+    hwaddr start_addr = memmap[SIFIVE_U_DEV_DRAM].base;
     target_ulong firmware_end_addr, kernel_start_addr;
     const char *firmware_name;
     uint32_t start_addr_hi32 = 0x00000000;
@@ -589,7 +589,7 @@ static void sifive_u_machine_init(MachineState *machine)
 
     firmware_name = riscv_default_firmware_name(&s->soc.u_cpus);
     firmware_end_addr = riscv_find_and_load_firmware(machine, firmware_name,
-                                                     start_addr, NULL);
+                                                     &start_addr, NULL);
 
     if (machine->kernel_filename) {
         kernel_start_addr = riscv_calc_kernel_start_addr(&s->soc.u_cpus,
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 64074395bc..fceb91d946 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -198,6 +198,7 @@ static void spike_board_init(MachineState *machine)
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
     target_ulong firmware_end_addr = memmap[SPIKE_DRAM].base;
+    hwaddr firmware_load_addr = memmap[SPIKE_DRAM].base;
     target_ulong kernel_start_addr;
     char *firmware_name;
     uint32_t fdt_load_addr;
@@ -290,7 +291,7 @@ static void spike_board_init(MachineState *machine)
     /* Load firmware */
     if (firmware_name) {
         firmware_end_addr = riscv_load_firmware(firmware_name,
-                                                memmap[SPIKE_DRAM].base,
+                                                &firmware_load_addr,
                                                 htif_symbol_callback);
         g_free(firmware_name);
     }
@@ -320,7 +321,7 @@ static void spike_board_init(MachineState *machine)
     riscv_load_fdt(fdt_load_addr, machine->fdt);
 
     /* load the reset vector */
-    riscv_setup_rom_reset_vec(machine, &s->soc[0], memmap[SPIKE_DRAM].base,
+    riscv_setup_rom_reset_vec(machine, &s->soc[0], firmware_load_addr,
                               memmap[SPIKE_MROM].base,
                               memmap[SPIKE_MROM].size, kernel_entry,
                               fdt_load_addr);
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 63d553ac98..1d32b4b0f3 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1360,7 +1360,7 @@ static void virt_machine_done(Notifier *notifier, void *data)
                                      machine_done);
     const MemMapEntry *memmap = virt_memmap;
     MachineState *machine = MACHINE(s);
-    target_ulong start_addr = memmap[VIRT_DRAM].base;
+    hwaddr start_addr = memmap[VIRT_DRAM].base;
     target_ulong firmware_end_addr, kernel_start_addr;
     const char *firmware_name = riscv_default_firmware_name(&s->soc[0]);
     uint64_t fdt_load_addr;
@@ -1392,7 +1392,7 @@ static void virt_machine_done(Notifier *notifier, void *data)
     }
 
     firmware_end_addr = riscv_find_and_load_firmware(machine, firmware_name,
-                                                     start_addr, NULL);
+                                                     &start_addr, NULL);
 
     pflash_blk0 = pflash_cfi01_get_blk(s->flash[0]);
     if (pflash_blk0) {
-- 
2.46.1


