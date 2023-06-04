Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF20B721746
	for <lists+qemu-devel@lfdr.de>; Sun,  4 Jun 2023 15:16:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5nZs-0004xk-K3; Sun, 04 Jun 2023 09:15:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q5nZp-0004xD-OD
 for qemu-devel@nongnu.org; Sun, 04 Jun 2023 09:15:21 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q5nZo-0003DD-0D
 for qemu-devel@nongnu.org; Sun, 04 Jun 2023 09:15:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nsrKsmdJAxjZBcLntlZIWUZO3Tx5BxstZRAzmRMyoRE=; b=iS6pQygg1Js+VFOLQbVCLve0Bw
 5p9gYBsZ1c+towuf3y2XLjKO/F+FFgSl1bEhdjVlQrvesArEcp2w2zaaiOcUeazWtpEoaTMKfJHRq
 VeW68Qxatr/hi1pOd7n6eY+l5rIZBr8sv1U0fGq/6bZIzDrlooPaF5q4eFqxXW3Am0yV65l6fK9cc
 u3OCL0AUhlzI/bKOwK4R4MC4dobmaWlQuNk+I5tctO5Tl+6tTtDDUrhXWoDC3tdCf7NImKw63AdMH
 POyuUgVkWd35Eh6TBEtgrjqgq1Igr9JFpe7BSjKSqUe/N2fxdwWKC75w+wFN0PieI53WYrVOpU8AM
 CUioKEuT5mcc/z8pGuERZDyOqRcy2otYDMRR6dE09LOppDM8VX2TbPggoQgAqa/FLf+e3YF5KjxoP
 saXsSYBf2jp385Y9HJ6qUART/APl7WKrqjHfrNr1qwpILdLkkg9zD0ABIi8yjljCvuSqMnQ/L6TjD
 WxUD7ffoW5LC5wBF08imWAklH8+bm+eMHq4KIhMk7nl/zid5b8q7XTq0U5wPD1GuuITK3ZeZYASaC
 c5TzJu6HOwQZpuyz65l4tHMJencvWtKLyilFrVLh7T89eHUqNJe4QBCmJwA4Ej1LWcrQk59/xwwBE
 GD5FxFjbhDrNym0fSoDNRtEivf+cCiAaXPHlfALeI=;
Received: from [2a00:23c4:8bac:6900:b726:cf58:4c12:f013] (helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q5nZd-0005pb-0b; Sun, 04 Jun 2023 14:15:13 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Sun,  4 Jun 2023 14:14:33 +0100
Message-Id: <20230604131450.428797-7-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230604131450.428797-1-mark.cave-ayland@ilande.co.uk>
References: <20230604131450.428797-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bac:6900:b726:cf58:4c12:f013
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 06/23] q800: move ROM memory region to Q800MachineState
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

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/m68k/q800.c         | 13 +++++--------
 include/hw/m68k/q800.h |  2 ++
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index d0ceb64b70..f99241fe16 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -372,7 +372,6 @@ static void q800_machine_init(MachineState *machine)
     int bios_size;
     ram_addr_t initrd_base;
     int32_t initrd_size;
-    MemoryRegion *rom;
     MemoryRegion *io;
     MemoryRegion *dp8393x_prom = g_new(MemoryRegion, 1);
     uint8_t *prom;
@@ -646,11 +645,10 @@ static void q800_machine_init(MachineState *machine)
         BOOTINFO1(param_ptr, BI_MAC_VROW, macfb_mode->stride);
         BOOTINFO1(param_ptr, BI_MAC_SCCBASE, SCC_BASE);
 
-        rom = g_malloc(sizeof(*rom));
-        memory_region_init_ram_ptr(rom, NULL, "m68k_fake_mac.rom",
+        memory_region_init_ram_ptr(&m->rom, NULL, "m68k_fake_mac.rom",
                                    sizeof(fake_mac_rom), fake_mac_rom);
-        memory_region_set_readonly(rom, true);
-        memory_region_add_subregion(get_system_memory(), MACROM_ADDR, rom);
+        memory_region_set_readonly(&m->rom, true);
+        memory_region_add_subregion(get_system_memory(), MACROM_ADDR, &m->rom);
 
         if (kernel_cmdline) {
             BOOTINFOSTR(param_ptr, BI_COMMAND_LINE,
@@ -692,11 +690,10 @@ static void q800_machine_init(MachineState *machine)
     } else {
         uint8_t *ptr;
         /* allocate and load BIOS */
-        rom = g_malloc(sizeof(*rom));
-        memory_region_init_rom(rom, NULL, "m68k_mac.rom", MACROM_SIZE,
+        memory_region_init_rom(&m->rom, NULL, "m68k_mac.rom", MACROM_SIZE,
                                &error_abort);
         filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
-        memory_region_add_subregion(get_system_memory(), MACROM_ADDR, rom);
+        memory_region_add_subregion(get_system_memory(), MACROM_ADDR, &m->rom);
 
         /* Load MacROM binary */
         if (filename) {
diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
index 4cb1a51dfe..d1f1ae4b88 100644
--- a/include/hw/m68k/q800.h
+++ b/include/hw/m68k/q800.h
@@ -26,6 +26,7 @@
 #include "hw/boards.h"
 #include "qom/object.h"
 #include "target/m68k/cpu-qom.h"
+#include "exec/memory.h"
 
 /*
  * The main Q800 machine
@@ -35,6 +36,7 @@ struct Q800MachineState {
     MachineState parent_obj;
 
     M68kCPU cpu;
+    MemoryRegion rom;
 };
 
 #define TYPE_Q800_MACHINE MACHINE_TYPE_NAME("q800")
-- 
2.30.2


