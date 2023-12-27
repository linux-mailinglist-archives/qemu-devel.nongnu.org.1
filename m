Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E57281F218
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Dec 2023 22:03:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIb2r-0006bq-8R; Wed, 27 Dec 2023 16:02:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rIb2o-0006bR-IQ
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 16:02:26 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rIb2m-00067L-Ss
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 16:02:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cAvKlNBYzl1WaMXRJXiwT4A4rGQ91vp570UQf4hWf94=; b=Ew7ZwRNIE7ScHC8Sfjeb8ZMmkO
 nND0RJ2t4B0vQyKDMyvuwU+1Hg1KL/c03fbM955jaHOg5/CQAp2kDxny3lH/NEIM5KKfdnJK0QQ/R
 ViHaGJ9jattqKfwaNcilBe4ySt3GX1Fa8CkzCUTVBa08k9MphCLOz1o2AuISPGk12faoxpmX69dYN
 wBzPfE2acyee1OC+dWBLvd5CDIouf0dKuiUqNs54TK+MHLZQywNi98ro3RVOYGUdtjav5mMehEAJV
 z1dmNkjE+VfsuWizmsXBjF9/iNUzwi/0Jkuo3Zpl58WMSILij6SN0ZcLEPCJ14ZrZMIobyQ/yEokL
 NoSeKmqUd0SfMOxq95S2JyrpJAR7IntfdZxI19ErpKNwnZqHHl3nvKFurSu0ZLpZB8aBLHR+MDDO6
 5ZhKf6pZSS9DkhHPf+R+xbcbxiBppH34tKQImhlMoTpcfa2quYQNy+/Lu5Roli522QQaJbopUHv0H
 014YAShjk/Ukb1sPW1o91tl5dGCNzOOMCFbA+vSYQFaROcMibJc8ZHjuO2XsNFows7CB5XxI0v3do
 cmPN7JvwGIWNKYrnTXkfFd1OEhWbLPOyLVBv6tSCTbCY0sXu430bKkQkle8QVtPOONlkiH/OG2eFC
 e/fwPAvFA0ACjBcIx+RjUQMlZwzx5TD1WajX5aRNg=;
Received: from [2a00:23c4:8bb0:f100:68ed:6797:e32e:ab13]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rIb2F-0000nu-8W; Wed, 27 Dec 2023 21:01:55 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Wed, 27 Dec 2023 21:02:12 +0000
Message-Id: <20231227210212.245106-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb0:f100:68ed:6797:e32e:ab13
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH] q800: move dp8393x_prom memory region to Q800MachineState
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

There is no need to dynamically allocate the memory region from the heap.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/m68k/q800.c         | 7 +++----
 include/hw/m68k/q800.h | 1 +
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 83d1571d02..b80a3b6d5f 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -253,7 +253,6 @@ static void q800_machine_init(MachineState *machine)
     int bios_size;
     ram_addr_t initrd_base;
     int32_t initrd_size;
-    MemoryRegion *dp8393x_prom = g_new(MemoryRegion, 1);
     uint8_t *prom;
     int i, checksum;
     MacFbMode *macfb_mode;
@@ -406,13 +405,13 @@ static void q800_machine_init(MachineState *machine)
     sysbus_connect_irq(sysbus, 0,
                        qdev_get_gpio_in(DEVICE(&m->glue), GLUE_IRQ_IN_SONIC));
 
-    memory_region_init_rom(dp8393x_prom, NULL, "dp8393x-q800.prom",
+    memory_region_init_rom(&m->dp8393x_prom, NULL, "dp8393x-q800.prom",
                            SONIC_PROM_SIZE, &error_fatal);
     memory_region_add_subregion(get_system_memory(), SONIC_PROM_BASE,
-                                dp8393x_prom);
+                                &m->dp8393x_prom);
 
     /* Add MAC address with valid checksum to PROM */
-    prom = memory_region_get_ram_ptr(dp8393x_prom);
+    prom = memory_region_get_ram_ptr(&m->dp8393x_prom);
     checksum = 0;
     for (i = 0; i < 6; i++) {
         prom[i] = revbit8(nd_table[0].macaddr.a[i]);
diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
index a9661f65f6..34365c9860 100644
--- a/include/hw/m68k/q800.h
+++ b/include/hw/m68k/q800.h
@@ -55,6 +55,7 @@ struct Q800MachineState {
     MOS6522Q800VIA1State via1;
     MOS6522Q800VIA2State via2;
     dp8393xState dp8393x;
+    MemoryRegion dp8393x_prom;
     ESCCState escc;
     OrIRQState escc_orgate;
     SysBusESPState esp;
-- 
2.39.2


