Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F4470FFD3
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 23:13:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1vn7-0005Nb-7t; Wed, 24 May 2023 17:13:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vn4-00056q-Rq
 for qemu-devel@nongnu.org; Wed, 24 May 2023 17:13:02 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vn3-0002IC-1p
 for qemu-devel@nongnu.org; Wed, 24 May 2023 17:13:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oTUynNDW4q72tx7pBULR2VftiLKf74kO1Fi88EOKivA=; b=RTr2BLW2BhnnZtjVralwge1zq+
 1LouL2uUdfIINYZDMUH9lAqH1EL1Z6AK1Ic0T4cucyLT3eiQLKt3C5LH1+W9znoeU4AkegRWYr87l
 44UrNOfrQocUljv2f/rfoBQc1XhyMEAI1yUmKbi3LvV4b+BPIIBhFnw+ljZ3JsQWMB12KE8b2xWii
 Oqr8TqQnmFFUTy28y/Sgfx+i9XO8q1iXkSLdI+2fV5fkFSPtQrFpad6puRkzLWMBxIW5bEE0Mnn3Q
 J8nNKlZSHF6Bxhn8lqcr1dgVtwgYH2hwnfZ5cB1W7WodAv4jwQJrGb2QC8TpRoLU68gepgc5UdbgT
 FapKkBO2/N6v9egBeLIWfszAWhne3X5Or/vsx/1gTxn0P4OL7pWbLVc9IKJrN1ZmPPDgWbk3ve+Kp
 Fr870Pet9We34uA5tJX2mZ1WyxVOt20Tcq8NXOefIOKzafF7VJVDPFyL2q9iTZIbQ6nfVipnrNdfv
 vznd4Ogv2oe37LE/OGof3yODPa0Nff57CDurMO0r2zzHiJR8u16fvDhKMUg4oboK+p5Gi9cgjkcsZ
 dCdz0RyiX26wdRO/+kxbnMLSTu/gEPAJFHRminM6NCtcaKXMxLwngrGtchWfgQM5cjtnMfM4eEM1a
 qG0bB66GHwCMA4FaqRWi5aDba8OVFv+zwCa8dEtfU=;
Received: from [2a00:23c4:8bac:6900:b726:cf58:4c12:f013] (helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vml-0005XR-Fh; Wed, 24 May 2023 22:12:47 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Wed, 24 May 2023 22:11:02 +0100
Message-Id: <20230524211104.686087-29-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230524211104.686087-1-mark.cave-ayland@ilande.co.uk>
References: <20230524211104.686087-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bac:6900:b726:cf58:4c12:f013
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 28/30] q800: add alias for MacOS toolbox ROM at 0x40000000
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

According to the Apple Quadra 800 Developer Note document, the Quadra 800 ROM
consists of 2 ROM code sections based at offsets 0x0 and 0x800000. A/UX attempts
to access the toolbox ROM at the lower offset during startup, so provide a
memory alias to allow the access to succeed.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/m68k/q800.c         | 5 +++++
 include/hw/m68k/q800.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 3acdb5dd8d..bf4acb5db7 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -869,6 +869,11 @@ static void q800_machine_init(MachineState *machine)
         filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
         memory_region_add_subregion(get_system_memory(), MACROM_ADDR, &m->rom);
 
+        memory_region_init_alias(&m->rom_alias, NULL, "m68k_mac.rom-alias",
+                                 &m->rom, 0, MACROM_SIZE);
+        memory_region_add_subregion(get_system_memory(), 0x40000000,
+                                    &m->rom_alias);
+
         /* Load MacROM binary */
         if (filename) {
             bios_size = load_image_targphys(filename, MACROM_ADDR, MACROM_SIZE);
diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
index 3039b24d30..1a0dbb5ecd 100644
--- a/include/hw/m68k/q800.h
+++ b/include/hw/m68k/q800.h
@@ -33,6 +33,7 @@ struct Q800MachineState {
     bool easc;
     M68kCPU *cpu;
     MemoryRegion rom;
+    MemoryRegion rom_alias;
     DeviceState *glue;
     DeviceState *djmemc;
     MemoryRegion ramio;
-- 
2.30.2


