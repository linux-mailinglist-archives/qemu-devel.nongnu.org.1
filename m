Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E166F815085
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 21:01:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEEMn-0005wz-CL; Fri, 15 Dec 2023 15:01:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rEEMl-0005vn-3R
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 15:00:59 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rEEMh-0002Yg-L0
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 15:00:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=d8qdn8A9H7tJb1h77OHwlwFGp5J3shyL3s/TI3aisCc=; b=p6MVcfJAy9fFNpMChZu8n3VPln
 iDZi9yJkWzDhWbXG0WcWg49yUJvzj5OT7vN6mOvIMcn+G6oJs7q3oHs01E9vmSAZfnb43KzYqB/2i
 w6qRZ/7WMfsUaADg2a8HzWNg5TX27pr8D2DHlQXV7idBklktQ+Sjk3z2YuPCDBbf8j+1ug8j9D78q
 gtPwjVUxRfc/tLdH9jdj4wUxJrysSEd+pyHtgfRTIhd91mWhbsJZNUlg2eOnro3pOdSPS1Gs9kw+P
 aQAxFgQwwjM47CxyMQvC8uw/We2pIqZ+usk2ncX/UHNhPjN8ZWJ455fKx27ewUitJwY6lE0ojnCDV
 16UBq2SpYWhlkbm1zpGV65DaMDifYzYqVGtII/HjavCnudhOYibdSiei9QQKi+HxY9LpIocoS+YIY
 JFyPvRxruXSxUSfwAHXfihDqfx91WItBKJU4OrJ8etUaQsVpEyoNbwQR+7QMFSqNYhMysNveUIUkc
 gaIYtL0FtfXMg0tlYAM7ApqbXoaR95wRaTIL2T0rolXumrJDH4G1IvCvfIqKIVMMW0qEJ5twtnhvk
 VL5kSzv8i0qCT/wRJXtfRhMzQI4YKudThTqkRTQUCBwBUZflti75W8lhG9JOVuThJgLaU8yleR7Mc
 VTUQsCE2dIhwN0l0nkmidLdx0Nj/ehNnJ6p7xfPu8=;
Received: from [2a00:23c4:8bb0:f100:5e2c:460f:a6a7:b066]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rEEMG-000AEs-Rt; Fri, 15 Dec 2023 20:00:32 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Fri, 15 Dec 2023 20:00:08 +0000
Message-Id: <20231215200009.346212-12-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231215200009.346212-1-mark.cave-ayland@ilande.co.uk>
References: <20231215200009.346212-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb0:f100:5e2c:460f:a6a7:b066
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 11/12] next-cube.c: replace sysmem with get_system_memory() in
 next_cube_init()
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

Removing the intermediate variable helps simplify the code in next_cube_init().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/m68k/next-cube.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index d9a1f234ec..73deef25ca 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -974,7 +974,6 @@ static void next_cube_init(MachineState *machine)
     MemoryRegion *dmamem = g_new(MemoryRegion, 1);
     MemoryRegion *bmapm1 = g_new(MemoryRegion, 1);
     MemoryRegion *bmapm2 = g_new(MemoryRegion, 1);
-    MemoryRegion *sysmem = get_system_memory();
     const char *bios_name = machine->firmware ?: ROM_FILE;
     DeviceState *pcdev;
 
@@ -996,7 +995,8 @@ static void next_cube_init(MachineState *machine)
     sysbus_realize_and_unref(SYS_BUS_DEVICE(pcdev), &error_fatal);
 
     /* 64MB RAM starting at 0x04000000  */
-    memory_region_add_subregion(sysmem, 0x04000000, machine->ram);
+    memory_region_add_subregion(get_system_memory(), 0x04000000,
+                                machine->ram);
 
     /* Framebuffer */
     sysbus_create_simple(TYPE_NEXTFB, 0x0B000000, NULL);
@@ -1010,19 +1010,19 @@ static void next_cube_init(MachineState *machine)
     /* BMAP memory */
     memory_region_init_ram_flags_nomigrate(bmapm1, NULL, "next.bmapmem", 64,
                                            RAM_SHARED, &error_fatal);
-    memory_region_add_subregion(sysmem, 0x020c0000, bmapm1);
+    memory_region_add_subregion(get_system_memory(), 0x020c0000, bmapm1);
     /* The Rev_2.5_v66.bin firmware accesses it at 0x820c0020, too */
     memory_region_init_alias(bmapm2, NULL, "next.bmapmem2", bmapm1, 0x0, 64);
-    memory_region_add_subregion(sysmem, 0x820c0000, bmapm2);
+    memory_region_add_subregion(get_system_memory(), 0x820c0000, bmapm2);
 
     /* KBD */
     sysbus_create_simple(TYPE_NEXTKBD, 0x0200e000, NULL);
 
     /* Load ROM here */
     memory_region_init_rom(rom, NULL, "next.rom", 0x20000, &error_fatal);
-    memory_region_add_subregion(sysmem, 0x01000000, rom);
+    memory_region_add_subregion(get_system_memory(), 0x01000000, rom);
     memory_region_init_alias(rom2, NULL, "next.rom2", rom, 0x0, 0x20000);
-    memory_region_add_subregion(sysmem, 0x0, rom2);
+    memory_region_add_subregion(get_system_memory(), 0x0, rom2);
     if (load_image_targphys(bios_name, 0x01000000, 0x20000) < 8) {
         if (!qtest_enabled()) {
             error_report("Failed to load firmware '%s'.", bios_name);
@@ -1051,7 +1051,7 @@ static void next_cube_init(MachineState *machine)
     /* DMA */
     memory_region_init_io(dmamem, NULL, &next_dma_ops, machine, "next.dma",
                           0x5000);
-    memory_region_add_subregion(sysmem, 0x02000000, dmamem);
+    memory_region_add_subregion(get_system_memory(), 0x02000000, dmamem);
 }
 
 static void next_machine_class_init(ObjectClass *oc, void *data)
-- 
2.39.2


