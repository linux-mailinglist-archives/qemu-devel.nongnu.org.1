Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A35FC819FA9
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 14:18:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFwSU-00082l-N9; Wed, 20 Dec 2023 08:17:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rFwS1-0007rR-Bz
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 08:17:32 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rFwRz-0002PT-Ll
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 08:17:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zKHhExBrhQhDtz+bMd3ZGiF02kmYBxElgg/wkqmyApA=; b=USrABwp0KMXlUI6d/sCrAJ2fS9
 01jvbACnnPk9hNILXYpSC5d+2HdNUWdiy8asH3wkk4Ra7Wi0Yxgk/8OOyv+mpBO3MjU6dFjYiKdHR
 oDgnclWM/rozxClfKKE5YljsFt+nYIoZUnSJzuCCR0aY2bsqkW2SMUruD2FOSOskrctSoBS5HTvny
 1qFPt/hPm8FsSYjlWNNocfhW9F6JFdhuA63587As1v6GBLr82GEcJjq4+H+c7n2aSqrbR7N8ceBEC
 fl3nfVsh6BvxvRwKdoDc5EHr3VAV0iqTiSNAJssPE3BJ2wuSeUiUPvAbocYB8VcOinqU7xv1P8hPv
 gGVJ7fdDouv5lW9eC6YKy6iSa+owDmGB9nav1PMqY6a2bIJ7KBuH3BS/++o/lPvySqg68n9VIUQxT
 8zR6KHdJz0qLCp3mL5kci+UJnk4+MsymbEUwh4Q3k1e13rRfCjwGtfTqiu7Lh9Xis7ccOQ1myH+oX
 3FFzLMqNCOHZ04TyNGKsTozaLmHpCoJ7lYV/SCtRRnceWOOANDlVxaBTuXWWiQiBNFM1RW51+0Oyg
 G3TFcHAb/ZdYeKPmuCgSrJXo2MoZ+9wW5om7SQzSNsqqZR/YySvpy47Y+dEupTXBjUCu1ESQSSFr5
 vCuLooga/OSVaVk6xRJYhtgnOuKPpsjR5fErU/vLg=;
Received: from host86-147-134-9.range86-147.btcentralplus.com ([86.147.134.9]
 helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rFwRX-0001qt-4G; Wed, 20 Dec 2023 13:17:03 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Wed, 20 Dec 2023 13:16:41 +0000
Message-Id: <20231220131641.592826-12-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231220131641.592826-1-mark.cave-ayland@ilande.co.uk>
References: <20231220131641.592826-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.147.134.9
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 11/11] next-cube.c: move machine MemoryRegions into
 NeXTState
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

These static memory regions are contained within the machine and do not need to
be dynamically allocated.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index d9a1f234ec..292f13defb 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -74,6 +74,12 @@ typedef struct NextRtc {
 struct NeXTState {
     MachineState parent;
 
+    MemoryRegion rom;
+    MemoryRegion rom2;
+    MemoryRegion dmamem;
+    MemoryRegion bmapm1;
+    MemoryRegion bmapm2;
+
     next_dma dma[10];
 };
 
@@ -967,13 +973,9 @@ static const TypeInfo next_pc_info = {
 
 static void next_cube_init(MachineState *machine)
 {
+    NeXTState *m = NEXT_MACHINE(machine);
     M68kCPU *cpu;
     CPUM68KState *env;
-    MemoryRegion *rom = g_new(MemoryRegion, 1);
-    MemoryRegion *rom2 = g_new(MemoryRegion, 1);
-    MemoryRegion *dmamem = g_new(MemoryRegion, 1);
-    MemoryRegion *bmapm1 = g_new(MemoryRegion, 1);
-    MemoryRegion *bmapm2 = g_new(MemoryRegion, 1);
     MemoryRegion *sysmem = get_system_memory();
     const char *bios_name = machine->firmware ?: ROM_FILE;
     DeviceState *pcdev;
@@ -1008,21 +1010,23 @@ static void next_cube_init(MachineState *machine)
     sysbus_mmio_map(SYS_BUS_DEVICE(pcdev), 1, 0x02100000);
 
     /* BMAP memory */
-    memory_region_init_ram_flags_nomigrate(bmapm1, NULL, "next.bmapmem", 64,
-                                           RAM_SHARED, &error_fatal);
-    memory_region_add_subregion(sysmem, 0x020c0000, bmapm1);
+    memory_region_init_ram_flags_nomigrate(&m->bmapm1, NULL, "next.bmapmem",
+                                           64, RAM_SHARED, &error_fatal);
+    memory_region_add_subregion(sysmem, 0x020c0000, &m->bmapm1);
     /* The Rev_2.5_v66.bin firmware accesses it at 0x820c0020, too */
-    memory_region_init_alias(bmapm2, NULL, "next.bmapmem2", bmapm1, 0x0, 64);
-    memory_region_add_subregion(sysmem, 0x820c0000, bmapm2);
+    memory_region_init_alias(&m->bmapm2, NULL, "next.bmapmem2", &m->bmapm1,
+                             0x0, 64);
+    memory_region_add_subregion(sysmem, 0x820c0000, &m->bmapm2);
 
     /* KBD */
     sysbus_create_simple(TYPE_NEXTKBD, 0x0200e000, NULL);
 
     /* Load ROM here */
-    memory_region_init_rom(rom, NULL, "next.rom", 0x20000, &error_fatal);
-    memory_region_add_subregion(sysmem, 0x01000000, rom);
-    memory_region_init_alias(rom2, NULL, "next.rom2", rom, 0x0, 0x20000);
-    memory_region_add_subregion(sysmem, 0x0, rom2);
+    memory_region_init_rom(&m->rom, NULL, "next.rom", 0x20000, &error_fatal);
+    memory_region_add_subregion(sysmem, 0x01000000, &m->rom);
+    memory_region_init_alias(&m->rom2, NULL, "next.rom2", &m->rom, 0x0,
+                             0x20000);
+    memory_region_add_subregion(sysmem, 0x0, &m->rom2);
     if (load_image_targphys(bios_name, 0x01000000, 0x20000) < 8) {
         if (!qtest_enabled()) {
             error_report("Failed to load firmware '%s'.", bios_name);
@@ -1049,9 +1053,9 @@ static void next_cube_init(MachineState *machine)
     next_scsi_init(pcdev, cpu);
 
     /* DMA */
-    memory_region_init_io(dmamem, NULL, &next_dma_ops, machine, "next.dma",
-                          0x5000);
-    memory_region_add_subregion(sysmem, 0x02000000, dmamem);
+    memory_region_init_io(&m->dmamem, NULL, &next_dma_ops, machine,
+                          "next.dma", 0x5000);
+    memory_region_add_subregion(sysmem, 0x02000000, &m->dmamem);
 }
 
 static void next_machine_class_init(ObjectClass *oc, void *data)
-- 
2.39.2


