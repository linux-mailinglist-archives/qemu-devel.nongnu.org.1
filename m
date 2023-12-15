Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 238D9815088
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 21:01:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEEMt-0005xu-05; Fri, 15 Dec 2023 15:01:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rEEMr-0005xU-1k
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 15:01:05 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rEEMl-0002Z7-QJ
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 15:01:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jyHbGUD3VTckOBcQ0GcMGq8yLmzlFR+M8qEZX87AFRE=; b=bM9j3PJvV5ZkRubhJWgSAQug+o
 W/fDBzmODkb0PCTTHO0TgiCXLJ9J8Fsa1NikoMjaaYvEMXduicSkEuwSIxmCs79GuTo9ko0mlSZWe
 7cjmjaYPELdYIwhR2+ZT5qXK/R0H4S6SOq2IhDfiEKhnnHw6cGMDFNDjHe0JeDbeSHFF5yPcsRX27
 LSBXbHmR+dh8eHAaqIp4odbZOzzHHIqvqtDDqTC6Kq20MNEGDSrqFDAmb4NLxJFcSQPrYgwr/Rqsg
 VdVrt3XTQAd3I9oswfrwVH/OqE1PGVBMD3PURF9VC6/JjUxuh0WO46DxiQPF+TuWdedHtGzaMdm/K
 1VP1noqVUr/7H1bHcD8esEkGN/HjAyO7A5eeRBo7J7WpY9RjZLK4+lZwqvlHh6wjTUXZxm9k5teek
 BNpl9iMLWrHGV1WTalz7aKFPLQrJwfIsJIB3+105iOrIF8Y5L0JaFBkFtK5VbhIRadal/q9a+9BTC
 uMORdkEJ2w2H/US9CaohnQgdL/mdF2TNZa07iouuXGuz7snL1IV8qGnSe8Bf2aYY8K074UqL02a2Y
 /Hi+fMbwHTiZSMahTXj5UVW3IA5BzL5XlEHQaGH0H4QfVbaoPm0CD7yoPK0u+Ht4IadD+lTDDOPxP
 Dcj4ayKk8AN1WEUQcT2UhVq1wOcHsnxUIo9azQsSE=;
Received: from [2a00:23c4:8bb0:f100:5e2c:460f:a6a7:b066]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rEEML-000AEs-0E; Fri, 15 Dec 2023 20:00:37 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Fri, 15 Dec 2023 20:00:09 +0000
Message-Id: <20231215200009.346212-13-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231215200009.346212-1-mark.cave-ayland@ilande.co.uk>
References: <20231215200009.346212-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb0:f100:5e2c:460f:a6a7:b066
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 12/12] next-cube.c: move machine MemoryRegions into NeXTState
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
---
 hw/m68k/next-cube.c | 40 +++++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 73deef25ca..4f231a1de0 100644
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
     const char *bios_name = machine->firmware ?: ROM_FILE;
     DeviceState *pcdev;
 
@@ -1008,21 +1010,24 @@ static void next_cube_init(MachineState *machine)
     sysbus_mmio_map(SYS_BUS_DEVICE(pcdev), 1, 0x02100000);
 
     /* BMAP memory */
-    memory_region_init_ram_flags_nomigrate(bmapm1, NULL, "next.bmapmem", 64,
-                                           RAM_SHARED, &error_fatal);
-    memory_region_add_subregion(get_system_memory(), 0x020c0000, bmapm1);
+    memory_region_init_ram_flags_nomigrate(&m->bmapm1, NULL, "next.bmapmem",
+                                           64, RAM_SHARED, &error_fatal);
+    memory_region_add_subregion(get_system_memory(), 0x020c0000, &m->bmapm1);
     /* The Rev_2.5_v66.bin firmware accesses it at 0x820c0020, too */
-    memory_region_init_alias(bmapm2, NULL, "next.bmapmem2", bmapm1, 0x0, 64);
-    memory_region_add_subregion(get_system_memory(), 0x820c0000, bmapm2);
+    memory_region_init_alias(&m->bmapm2, NULL, "next.bmapmem2", &m->bmapm1,
+                             0x0, 64);
+    memory_region_add_subregion(get_system_memory(), 0x820c0000,
+                                &m->bmapm2);
 
     /* KBD */
     sysbus_create_simple(TYPE_NEXTKBD, 0x0200e000, NULL);
 
     /* Load ROM here */
-    memory_region_init_rom(rom, NULL, "next.rom", 0x20000, &error_fatal);
-    memory_region_add_subregion(get_system_memory(), 0x01000000, rom);
-    memory_region_init_alias(rom2, NULL, "next.rom2", rom, 0x0, 0x20000);
-    memory_region_add_subregion(get_system_memory(), 0x0, rom2);
+    memory_region_init_rom(&m->rom, NULL, "next.rom", 0x20000, &error_fatal);
+    memory_region_add_subregion(get_system_memory(), 0x01000000, &m->rom);
+    memory_region_init_alias(&m->rom2, NULL, "next.rom2", &m->rom, 0x0,
+                             0x20000);
+    memory_region_add_subregion(get_system_memory(), 0x0, &m->rom2);
     if (load_image_targphys(bios_name, 0x01000000, 0x20000) < 8) {
         if (!qtest_enabled()) {
             error_report("Failed to load firmware '%s'.", bios_name);
@@ -1049,9 +1054,10 @@ static void next_cube_init(MachineState *machine)
     next_scsi_init(pcdev, cpu);
 
     /* DMA */
-    memory_region_init_io(dmamem, NULL, &next_dma_ops, machine, "next.dma",
-                          0x5000);
-    memory_region_add_subregion(get_system_memory(), 0x02000000, dmamem);
+    memory_region_init_io(&m->dmamem, NULL, &next_dma_ops, machine,
+                          "next.dma", 0x5000);
+    memory_region_add_subregion(get_system_memory(), 0x02000000,
+                                &m->dmamem);
 }
 
 static void next_machine_class_init(ObjectClass *oc, void *data)
-- 
2.39.2


