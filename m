Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD977FAF94
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 02:34:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7myG-0006GA-K7; Mon, 27 Nov 2023 20:33:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1r7myE-0006Fc-Lp; Mon, 27 Nov 2023 20:33:02 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1r7myC-0003iC-MF; Mon, 27 Nov 2023 20:33:02 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id CB43975607B;
 Tue, 28 Nov 2023 02:32:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id IX55KPrWdfDX; Tue, 28 Nov 2023 02:32:53 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 80524756078; Tue, 28 Nov 2023 02:32:53 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v3] ppc/amigaone: Allow running AmigaOS without firmware image
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, clg@kaod.org,
 philmd@linaro.org
Message-Id: <20231128013253.80524756078@zero.eik.bme.hu>
Date: Tue, 28 Nov 2023 02:32:53 +0100 (CET)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
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

The machine uses a modified U-Boot under GPL license but the sources
of it are lost with only a binary available so it cannot be included
in QEMU. Allow running without the firmware image which can be used
when calling a boot loader directly and thus simplifying booting
guests. We need a small routine that AmigaOS calls from ROM which is
added in this case to allow booting AmigaOS without external firmware
image.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
v3: Instead of -bios none do this when no -bios option given, use
constants for address and rom_add_blob_fixed() to add dummy_fw.
This makes both code and usage a bit simpler.

 hw/ppc/amigaone.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
index 992a55e632..ddfa09457a 100644
--- a/hw/ppc/amigaone.c
+++ b/hw/ppc/amigaone.c
@@ -36,10 +36,19 @@
  * -device VGA,romfile=VGABIOS-lgpl-latest.bin
  * from http://www.nongnu.org/vgabios/ instead.
  */
-#define PROM_FILENAME "u-boot-amigaone.bin"
 #define PROM_ADDR 0xfff00000
 #define PROM_SIZE (512 * KiB)
 
+/* AmigaOS calls this routine from ROM, use this if no firmware loaded */
+static const char dummy_fw[] = {
+    0x38, 0x00, 0x00, 0x08, /* li      r0,8 */
+    0x7c, 0x09, 0x03, 0xa6, /* mtctr   r0 */
+    0x54, 0x63, 0xf8, 0x7e, /* srwi    r3,r3,1 */
+    0x42, 0x00, 0xff, 0xfc, /* bdnz    0x8 */
+    0x7c, 0x63, 0x18, 0xf8, /* not     r3,r3 */
+    0x4e, 0x80, 0x00, 0x20, /* blr */
+};
+
 static void amigaone_cpu_reset(void *opaque)
 {
     PowerPCCPU *cpu = opaque;
@@ -60,8 +69,6 @@ static void amigaone_init(MachineState *machine)
     PowerPCCPU *cpu;
     CPUPPCState *env;
     MemoryRegion *rom, *pci_mem, *mr;
-    const char *fwname = machine->firmware ?: PROM_FILENAME;
-    char *filename;
     ssize_t sz;
     PCIBus *pci_bus;
     Object *via;
@@ -94,20 +101,24 @@ static void amigaone_init(MachineState *machine)
     }
 
     /* allocate and load firmware */
-    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, fwname);
-    if (filename) {
-        rom = g_new(MemoryRegion, 1);
-        memory_region_init_rom(rom, NULL, "rom", PROM_SIZE, &error_fatal);
-        memory_region_add_subregion(get_system_memory(), PROM_ADDR, rom);
+    rom = g_new(MemoryRegion, 1);
+    memory_region_init_rom(rom, NULL, "rom", PROM_SIZE, &error_fatal);
+    memory_region_add_subregion(get_system_memory(), PROM_ADDR, rom);
+    if (!machine->firmware) {
+        rom_add_blob_fixed("dummy-fw", dummy_fw, sizeof(dummy_fw),
+                           PROM_ADDR + PROM_SIZE - 0x80);
+    } else {
+        g_autofree char *filename = qemu_find_file(QEMU_FILE_TYPE_BIOS,
+                                                   machine->firmware);
+        if (!filename) {
+            error_report("Could not find firmware '%s'", machine->firmware);
+            exit(1);
+        }
         sz = load_image_targphys(filename, PROM_ADDR, PROM_SIZE);
         if (sz <= 0 || sz > PROM_SIZE) {
             error_report("Could not load firmware '%s'", filename);
             exit(1);
         }
-        g_free(filename);
-    } else if (!qtest_enabled()) {
-        error_report("Could not find firmware '%s'", fwname);
-        exit(1);
     }
 
     /* Articia S */
-- 
2.30.9


