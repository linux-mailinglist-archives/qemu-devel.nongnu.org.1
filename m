Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A77967398B8
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 09:58:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCFBK-0004th-9U; Thu, 22 Jun 2023 03:56:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qCFAf-00040k-6K
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 03:56:01 -0400
Received: from mout.kundenserver.de ([212.227.126.133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qCFAY-0002s5-8j
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 03:55:58 -0400
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue011
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MD9jV-1qKjcy0YZV-0097Op; Thu, 22
 Jun 2023 09:55:49 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 06/24] q800: move ROM memory region to Q800MachineState
Date: Thu, 22 Jun 2023 09:55:26 +0200
Message-Id: <20230622075544.210899-7-laurent@vivier.eu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622075544.210899-1-laurent@vivier.eu>
References: <20230622075544.210899-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:nFhTxUe+M2uX0htoHlTjvqFF1q20sVTZsIZ2mTtA8gyK/Iy4OrP
 VqtVVr9P/Xt3SWnXUwo2D7ghUwfgmhEFCdezTpaf7NY/sibB8T6506azDfKrxL9RQqLSDp4
 KWjDCOBCy7C2j57BEO1/wqImmTDtM1bbOeXyEHtMCGepXNnPorAZ40Kidjs3pG27CoUI2Aj
 EYo+J8jb7rj41jZw4NQqA==
UI-OutboundReport: notjunk:1;M01:P0:mwZuDtMqCZY=;F0bo6dzn0bVE5rj7EWAU7vv9vQY
 c2Uv0Odfz+23buX6ZFwkFmn8TaftWdiwQ2xIX3Gg5f/2yzEkHo9MZoNUDrG1DGUxJywPnr9KJ
 e3lAv4PSlO0YVDnAok0iIzZGbHE9oD00Z6KCmOKbsjt1ikefAzIxbPXcdYpNmjbpeA7WsuVcO
 0SGX70ymG4RjQ92rjvVQTYaPttWRHelblVQK1mD9d0iUgj+mjaDmP9zPxzczcW5djRkUelDgX
 drc7YqH+ZlouMRW9BfnuEY7Cu/8kO2otfavKqtND9wDxkOkzN8d3/1uBi9zBLt8EvCZgs4G2A
 It+x/cnbqdDahRbHZop8r6qmS+8fMpv15US/SMgFTUYb2uQx1KcnUyvm6/b/FWXJpQpRIzM6Y
 WzBBpr5YUdZORv2nD3l3OQRfyBKeBsAv9XHA23Y6vUXI01k9YNU9PfuzrTZIeVzvXVRJGX1yH
 Pn7p6h9MXCG4YpgQtGW2s1Nd7uXdDnATYH3Or/DNeAHhqF8hrqyFX1Y5RhkdhuMAFCPzqhzdX
 PyuoXZ6eU2+Px00LzgSMZAjZLV5+pphkO2GvDHxeu11TMs3NUEqZpdwDVgHU44G2Gq2Nk4ufv
 7E72YPc23Im7+wPLmlI31Gp3BNa/B3SgUT6Hy9Jscd5y7j91SJTRwXOMqvxxRI9BJz9FFNOlF
 kyNka284NoHflgQDB34IzOtFjXNuW/1Rz2/SGdT3/Q==
Received-SPF: none client-ip=212.227.126.133; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20230621085353.113233-7-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 include/hw/m68k/q800.h |  2 ++
 hw/m68k/q800.c         | 13 +++++--------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
index 4cb1a51dfe9d..d1f1ae4b8864 100644
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
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 2b651de3c13b..9f9668c2b4b3 100644
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
-- 
2.40.1


