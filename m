Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0A570FFB1
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 23:12:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1vlh-0001Gq-OX; Wed, 24 May 2023 17:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vlg-0001Gh-HS
 for qemu-devel@nongnu.org; Wed, 24 May 2023 17:11:36 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vlf-0001zV-0q
 for qemu-devel@nongnu.org; Wed, 24 May 2023 17:11:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ESy5W09ulYQKyMhallGOOS2O81ly7AssHop62N/WGhM=; b=y9C2qdtXvWNIL9aAcS7PIJknkQ
 6HkPK7JuLLqDpQcXsy0qeUrY1fHJ4sXx+o2W8t1xsIKcN0bUuHsIIAL7Edl1mFn33QdqkUf8uu3uf
 GNeVelyPc/fTQEA/jIBNVhJuPdhj55PWKUqSxRbsb3dFG4D7YRKRAzr4Epd3hC52UXG/3FYtNbV2Q
 xuTaI3CxD3/zV4kKlIhPvy/FBWLvgyFbhJBr/QRIcM9CqSxU3ZukWTFkiXrWo/ALkZhRD/gn2TzOD
 QK8JTbte4OC/Oo74cLyn5I4tyuWWO9TzwF13/NLcDooCNM/q0PD3KxxQ79o0Hey/d60/GveT2dQsM
 T5XxZ//i5K8BR7zhw4oEcI4Htk9R/SycJXiCEyXpkkqIEJOOIpmMH+5pMzfWZjtcTCBpdqAeBFTBH
 hhBoBvcQvMdffLBPXtVw7VXvhnWo36V0nrdHzx8Y76mnyEGloBo/Adljwqm9M1NRdq+H5EhQ6xiF7
 GRblE+MitPOuP9apPQS3XTs37dK/TuCAqvxml/2+3x8dY8GWNn99KzZOmRPb2y0cz5CqIrLudrsXy
 laeM7nFS+Vzc7YOxRfkYQRtZgbKXAisp+vRVzU9pH3ayln1fPqEhoxhRqzLtB++8B90xwXnVToVjW
 z88oTgIYpubHhTprnkEfqz07CxUsJWM7MTaO/EA/0=;
Received: from [2a00:23c4:8bac:6900:b726:cf58:4c12:f013] (helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vlX-0005XR-HO; Wed, 24 May 2023 22:11:31 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Wed, 24 May 2023 22:10:39 +0100
Message-Id: <20230524211104.686087-6-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230524211104.686087-1-mark.cave-ayland@ilande.co.uk>
References: <20230524211104.686087-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bac:6900:b726:cf58:4c12:f013
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 05/30] q800: move ROM memory region to Q800MachineState
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
---
 hw/m68k/q800.c         | 13 +++++--------
 include/hw/m68k/q800.h |  1 +
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index ee6175ceb4..6a000ceb75 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -371,7 +371,6 @@ static void q800_machine_init(MachineState *machine)
     int bios_size;
     ram_addr_t initrd_base;
     int32_t initrd_size;
-    MemoryRegion *rom;
     MemoryRegion *io;
     MemoryRegion *dp8393x_prom = g_new(MemoryRegion, 1);
     uint8_t *prom;
@@ -643,11 +642,10 @@ static void q800_machine_init(MachineState *machine)
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
@@ -689,11 +687,10 @@ static void q800_machine_init(MachineState *machine)
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
index 5867c3ae33..2f3c720b8d 100644
--- a/include/hw/m68k/q800.h
+++ b/include/hw/m68k/q800.h
@@ -31,6 +31,7 @@ struct Q800MachineState {
     MachineState parent_obj;
 
     M68kCPU *cpu;
+    MemoryRegion rom;
 };
 
 #define TYPE_Q800_MACHINE MACHINE_TYPE_NAME("q800")
-- 
2.30.2


