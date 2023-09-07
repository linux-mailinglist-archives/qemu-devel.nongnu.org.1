Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D868B7971D2
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 13:36:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeDI5-0006CI-GK; Thu, 07 Sep 2023 07:35:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qeDI3-0006Bz-C0
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 07:35:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qeDI0-0001uo-3T
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 07:35:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694086509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=b9ij7LsW+STaPO1h0sQsEpYrPpbU2qcXYJGH7zuHdl0=;
 b=afJJ+DQh4Hep9fCnMw1oVNkgy1xcA5QV+SgU+/QgEJuxZeTU7P+TtyYxm4GqZDBt/1u7Xr
 TwBRQkE8Ed15BtkGC5oqCx+XVhoZjScgi8IlQnOqMC+R+hC5pJKYShoEWrfG5VkbgxOqsw
 s/Hk6PmbKQl/RzvIETbX138fLiYuR4A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-611-QXNTnTNbPUqxW9F1i93K9A-1; Thu, 07 Sep 2023 07:35:06 -0400
X-MC-Unique: QXNTnTNbPUqxW9F1i93K9A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 849EE817077;
 Thu,  7 Sep 2023 11:35:05 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.196])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 45B6D2026D76;
 Thu,  7 Sep 2023 11:35:02 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-trivial@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH] trivial: Simplify the spots that use TARGET_BIG_ENDIAN as a
 numeric value
Date: Thu,  7 Sep 2023 13:35:00 +0200
Message-Id: <20230907113500.185276-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

TARGET_BIG_ENDIAN is *always* defined, either as 0 for little endian
targets or as 1 for big endian targets. So we can use this as a value
directly in places that need such a 0 or 1 for some reason, instead
of taking a detour through an additional local variable or something
similar.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/arm/cpu.h     | 12 ++----------
 cpu.c                |  6 +-----
 hw/microblaze/boot.c |  9 ++-------
 hw/mips/jazz.c       | 10 ++--------
 hw/mips/malta.c      | 21 ++++-----------------
 hw/mips/mipssim.c    |  9 +--------
 hw/nios2/boot.c      |  9 ++-------
 hw/xtensa/sim.c      |  7 +------
 hw/xtensa/xtfpga.c   | 10 +++-------
 9 files changed, 18 insertions(+), 75 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 278cc135c2..d50cd91858 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3208,11 +3208,7 @@ static inline bool bswap_code(bool sctlr_b)
      * The invalid combination SCTLR.B=1/CPSR.E=1/TARGET_BIG_ENDIAN=0
      * would also end up as a mixed-endian mode with BE code, LE data.
      */
-    return
-#if TARGET_BIG_ENDIAN
-        1 ^
-#endif
-        sctlr_b;
+    return TARGET_BIG_ENDIAN ^ sctlr_b;
 #else
     /* All code access in ARM is little endian, and there are no loaders
      * doing swaps that need to be reversed
@@ -3224,11 +3220,7 @@ static inline bool bswap_code(bool sctlr_b)
 #ifdef CONFIG_USER_ONLY
 static inline bool arm_cpu_bswap_data(CPUARMState *env)
 {
-    return
-#if TARGET_BIG_ENDIAN
-       1 ^
-#endif
-       arm_cpu_data_is_big_endian(env);
+    return TARGET_BIG_ENDIAN ^ arm_cpu_data_is_big_endian(env);
 }
 #endif
 
diff --git a/cpu.c b/cpu.c
index 1c948d1161..0769b0b153 100644
--- a/cpu.c
+++ b/cpu.c
@@ -420,11 +420,7 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
 
 bool target_words_bigendian(void)
 {
-#if TARGET_BIG_ENDIAN
-    return true;
-#else
-    return false;
-#endif
+    return TARGET_BIG_ENDIAN;
 }
 
 const char *target_name(void)
diff --git a/hw/microblaze/boot.c b/hw/microblaze/boot.c
index 25ad54754e..ed61e483ee 100644
--- a/hw/microblaze/boot.c
+++ b/hw/microblaze/boot.c
@@ -140,22 +140,17 @@ void microblaze_load_kernel(MicroBlazeCPU *cpu, hwaddr ddr_base,
         int kernel_size;
         uint64_t entry, high;
         uint32_t base32;
-        int big_endian = 0;
-
-#if TARGET_BIG_ENDIAN
-        big_endian = 1;
-#endif
 
         /* Boots a kernel elf binary.  */
         kernel_size = load_elf(kernel_filename, NULL, NULL, NULL,
                                &entry, NULL, &high, NULL,
-                               big_endian, EM_MICROBLAZE, 0, 0);
+                               TARGET_BIG_ENDIAN, EM_MICROBLAZE, 0, 0);
         base32 = entry;
         if (base32 == 0xc0000000) {
             kernel_size = load_elf(kernel_filename, NULL,
                                    translate_kernel_address, NULL,
                                    &entry, NULL, NULL, NULL,
-                                   big_endian, EM_MICROBLAZE, 0, 0);
+                                   TARGET_BIG_ENDIAN, EM_MICROBLAZE, 0, 0);
         }
         /* Always boot into physical ram.  */
         boot_info.bootstrap_pc = (uint32_t)entry;
diff --git a/hw/mips/jazz.c b/hw/mips/jazz.c
index ca4426a92c..0081dcf921 100644
--- a/hw/mips/jazz.c
+++ b/hw/mips/jazz.c
@@ -125,7 +125,7 @@ static void mips_jazz_init(MachineState *machine,
 {
     MemoryRegion *address_space = get_system_memory();
     char *filename;
-    int bios_size, n, big_endian;
+    int bios_size, n;
     Clock *cpuclk;
     MIPSCPU *cpu;
     MIPSCPUClass *mcc;
@@ -157,12 +157,6 @@ static void mips_jazz_init(MachineState *machine,
         [JAZZ_PICA61] = {33333333, 4},
     };
 
-#if TARGET_BIG_ENDIAN
-    big_endian = 1;
-#else
-    big_endian = 0;
-#endif
-
     if (machine->ram_size > 256 * MiB) {
         error_report("RAM size more than 256Mb is not supported");
         exit(EXIT_FAILURE);
@@ -301,7 +295,7 @@ static void mips_jazz_init(MachineState *machine,
             dev = qdev_new("dp8393x");
             qdev_set_nic_properties(dev, nd);
             qdev_prop_set_uint8(dev, "it_shift", 2);
-            qdev_prop_set_bit(dev, "big_endian", big_endian > 0);
+            qdev_prop_set_bit(dev, "big_endian", TARGET_BIG_ENDIAN);
             object_property_set_link(OBJECT(dev), "dma_mr",
                                      OBJECT(rc4030_dma_mr), &error_abort);
             sysbus = SYS_BUS_DEVICE(dev);
diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index 16e9c4773f..dac27fad9d 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -870,7 +870,6 @@ static uint64_t load_kernel(void)
     uint64_t kernel_entry, kernel_high, initrd_size;
     long kernel_size;
     ram_addr_t initrd_offset;
-    int big_endian;
     uint32_t *prom_buf;
     long prom_size;
     int prom_index = 0;
@@ -878,16 +877,10 @@ static uint64_t load_kernel(void)
     char rng_seed_hex[sizeof(rng_seed) * 2 + 1];
     size_t rng_seed_prom_offset;
 
-#if TARGET_BIG_ENDIAN
-    big_endian = 1;
-#else
-    big_endian = 0;
-#endif
-
     kernel_size = load_elf(loaderparams.kernel_filename, NULL,
                            cpu_mips_kseg0_to_phys, NULL,
                            &kernel_entry, NULL,
-                           &kernel_high, NULL, big_endian, EM_MIPS,
+                           &kernel_high, NULL, TARGET_BIG_ENDIAN, EM_MIPS,
                            1, 0);
     if (kernel_size < 0) {
         error_report("could not load kernel '%s': %s",
@@ -1107,7 +1100,6 @@ void mips_malta_init(MachineState *machine)
     I2CBus *smbus;
     DriveInfo *dinfo;
     int fl_idx = 0;
-    int be;
     MaltaState *s;
     PCIDevice *piix4;
     DeviceState *dev;
@@ -1144,12 +1136,6 @@ void mips_malta_init(MachineState *machine)
                                     ram_low_postio);
     }
 
-#if TARGET_BIG_ENDIAN
-    be = 1;
-#else
-    be = 0;
-#endif
-
     /* FPGA */
 
     /* The CBUS UART is attached to the MIPS CPU INT2 pin, ie interrupt 4 */
@@ -1161,7 +1147,8 @@ void mips_malta_init(MachineState *machine)
                                FLASH_SIZE,
                                dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
                                65536,
-                               4, 0x0000, 0x0000, 0x0000, 0x0000, be);
+                               4, 0x0000, 0x0000, 0x0000, 0x0000,
+                               TARGET_BIG_ENDIAN);
     bios = pflash_cfi01_get_memory(fl);
     fl_idx++;
     if (kernel_filename) {
@@ -1245,7 +1232,7 @@ void mips_malta_init(MachineState *machine)
 
     /* Northbridge */
     dev = qdev_new("gt64120");
-    qdev_prop_set_bit(dev, "cpu-little-endian", !be);
+    qdev_prop_set_bit(dev, "cpu-little-endian", !TARGET_BIG_ENDIAN);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     pci_bus = PCI_BUS(qdev_get_child_bus(dev, "pci"));
     pci_bus_map_irqs(pci_bus, malta_pci_slot_get_pirq);
diff --git a/hw/mips/mipssim.c b/hw/mips/mipssim.c
index 39f64448f2..2f951f7fc6 100644
--- a/hw/mips/mipssim.c
+++ b/hw/mips/mipssim.c
@@ -62,18 +62,11 @@ static uint64_t load_kernel(void)
     uint64_t entry, kernel_high, initrd_size;
     long kernel_size;
     ram_addr_t initrd_offset;
-    int big_endian;
-
-#if TARGET_BIG_ENDIAN
-    big_endian = 1;
-#else
-    big_endian = 0;
-#endif
 
     kernel_size = load_elf(loaderparams.kernel_filename, NULL,
                            cpu_mips_kseg0_to_phys, NULL,
                            &entry, NULL,
-                           &kernel_high, NULL, big_endian,
+                           &kernel_high, NULL, TARGET_BIG_ENDIAN,
                            EM_MIPS, 1, 0);
     if (kernel_size < 0) {
         error_report("could not load kernel '%s': %s",
diff --git a/hw/nios2/boot.c b/hw/nios2/boot.c
index b30a7b1efb..cd75803fc2 100644
--- a/hw/nios2/boot.c
+++ b/hw/nios2/boot.c
@@ -148,16 +148,11 @@ void nios2_load_kernel(Nios2CPU *cpu, hwaddr ddr_base,
     if (kernel_filename) {
         int kernel_size, fdt_size;
         uint64_t entry, high;
-        int big_endian = 0;
-
-#if TARGET_BIG_ENDIAN
-        big_endian = 1;
-#endif
 
         /* Boots a kernel elf binary. */
         kernel_size = load_elf(kernel_filename, NULL, NULL, NULL,
                                &entry, NULL, &high, NULL,
-                               big_endian, EM_ALTERA_NIOS2, 0, 0);
+                               TARGET_BIG_ENDIAN, EM_ALTERA_NIOS2, 0, 0);
         if ((uint32_t)entry == 0xc0000000) {
             /*
              * The Nios II processor reference guide documents that the
@@ -168,7 +163,7 @@ void nios2_load_kernel(Nios2CPU *cpu, hwaddr ddr_base,
             kernel_size = load_elf(kernel_filename, NULL,
                                    translate_kernel_address, NULL,
                                    &entry, NULL, NULL, NULL,
-                                   big_endian, EM_ALTERA_NIOS2, 0, 0);
+                                   TARGET_BIG_ENDIAN, EM_ALTERA_NIOS2, 0, 0);
             boot_info.bootstrap_pc = ddr_base + 0xc0000000 +
                 (entry & 0x07ffffff);
         } else {
diff --git a/hw/xtensa/sim.c b/hw/xtensa/sim.c
index 946c71cb5b..2160e61964 100644
--- a/hw/xtensa/sim.c
+++ b/hw/xtensa/sim.c
@@ -96,16 +96,11 @@ XtensaCPU *xtensa_sim_common_init(MachineState *machine)
 void xtensa_sim_load_kernel(XtensaCPU *cpu, MachineState *machine)
 {
     const char *kernel_filename = machine->kernel_filename;
-#if TARGET_BIG_ENDIAN
-    int big_endian = true;
-#else
-    int big_endian = false;
-#endif
 
     if (kernel_filename) {
         uint64_t elf_entry;
         int success = load_elf(kernel_filename, NULL, translate_phys_addr, cpu,
-                               &elf_entry, NULL, NULL, NULL, big_endian,
+                               &elf_entry, NULL, NULL, NULL, TARGET_BIG_ENDIAN,
                                EM_XTENSA, 0, 0);
 
         if (success > 0) {
diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index 2a5556a35f..fbad1c83a3 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -219,11 +219,6 @@ static const MemoryRegionOps xtfpga_io_ops = {
 
 static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
 {
-#if TARGET_BIG_ENDIAN
-    int be = 1;
-#else
-    int be = 0;
-#endif
     MemoryRegion *system_memory = get_system_memory();
     XtensaCPU *cpu = NULL;
     CPUXtensaState *env = NULL;
@@ -316,7 +311,7 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
 
     dinfo = drive_get(IF_PFLASH, 0, 0);
     if (dinfo) {
-        flash = xtfpga_flash_init(system_io, board, dinfo, be);
+        flash = xtfpga_flash_init(system_io, board, dinfo, TARGET_BIG_ENDIAN);
     }
 
     /* Use presence of kernel file name as 'boot from SRAM' switch. */
@@ -412,7 +407,8 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
 
         uint64_t elf_entry;
         int success = load_elf(kernel_filename, NULL, translate_phys_addr, cpu,
-                &elf_entry, NULL, NULL, NULL, be, EM_XTENSA, 0, 0);
+                               &elf_entry, NULL, NULL, NULL, TARGET_BIG_ENDIAN,
+                               EM_XTENSA, 0, 0);
         if (success > 0) {
             entry_point = elf_entry;
         } else {
-- 
2.39.3


