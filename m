Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE29737DD6
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 10:55:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBtbj-0001x7-BZ; Wed, 21 Jun 2023 04:54:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qBtbh-0001wg-0o
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 04:54:29 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qBtbf-0003wv-Ie
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 04:54:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gTeIpHlEh1+FjdTZFv1BDfDouv7S37+TGLF5yBGy8K4=; b=JbeKW90Qp2aLFMCyM3FvvBPYtT
 grhMqisonz2HmrIxf3l6ZYvErPS6TETCDMNDYuUjTlNRxLSTffPixwQHdoI/rUOfEGSI2MXI/8lL2
 9FIWL+oWns6JZEw2w6Y81DxFfs5Wfp3ibNvkUB5vPF9xD+PnumdWf1nqhGd179lDSGD7rYwNwRPzy
 9sI16epxt9NkExnjvQt7wtQ/LHWyQBgs8JheJbHNpZSQH3/98mNhcNsRHev6KGRIFiy7qxZDKmxjK
 v/6yRvZgOOF0hBxUB7I5vGmKX1DdbiVLNkKYvITetbhNgXexPJH2B6w9qG9pj7q7iUzGbUvhRavrI
 cvuTdbQfvPYEkOXWHz0PMCCDVt1PNefn1S1sP65k4DQMGxKHqM5Kvlqt2VLSr1ixnagW54VmR+GRZ
 uMKK5uuMZPrUxh3vScq93BLiIMbMsSEzrvfnwUlenWFe0U5d1f7JLefZGnVHpOU9pepgNaJSOPnQi
 8SbAl0UOhLtxiuMcqOhaArvb9BR6LW/BNYGtcdDiIdCsg8beHbY7C+w0o61DrjVMuBWzeQqeJKx83
 fUGmf9x53CuV8oGc90EccmksG1SC1+ENurTNLbpAE+m5ylNOQLdp7/GiX0SJ192uqmbO222HfpmeA
 VEm2ATd0U3zD+E3DjeMaH+x9fKJHb6K3EYos5k/2A=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qBtbU-0001ZB-Nj; Wed, 21 Jun 2023 09:54:20 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Wed, 21 Jun 2023 09:53:35 +0100
Message-Id: <20230621085353.113233-7-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230621085353.113233-1-mark.cave-ayland@ilande.co.uk>
References: <20230621085353.113233-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 06/24] q800: move ROM memory region to Q800MachineState
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
index 2b651de3c1..9f9668c2b4 100644
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


