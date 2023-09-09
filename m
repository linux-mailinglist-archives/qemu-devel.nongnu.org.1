Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1699D79988A
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 15:18:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qexcH-00059M-RM; Sat, 09 Sep 2023 09:03:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qexcC-0004z5-E3; Sat, 09 Sep 2023 09:03:08 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qexc9-0002xI-PS; Sat, 09 Sep 2023 09:03:08 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 63899205AE;
 Sat,  9 Sep 2023 16:01:19 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 3587126E14;
 Sat,  9 Sep 2023 16:00:28 +0300 (MSK)
Received: (nullmailer pid 353151 invoked by uid 1000);
 Sat, 09 Sep 2023 13:00:22 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Niklas Cassel <niklas.cassel@wdc.com>,
 John Snow <jsnow@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.5 32/43] hw/ide/ahci: write D2H FIS when processing NCQ
 command
Date: Sat,  9 Sep 2023 15:59:58 +0300
Message-Id: <20230909130020.352951-32-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.5-20230909155813@cover.tls.msk.ru>
References: <qemu-stable-8.0.5-20230909155813@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Niklas Cassel <niklas.cassel@wdc.com>

The way that BUSY + PxCI is cleared for NCQ (FPDMA QUEUED) commands is
described in SATA 3.5a Gold:

11.15 FPDMA QUEUED command protocol
DFPDMAQ2: ClearInterfaceBsy
"Transmit Register Device to Host FIS with the BSY bit cleared to zero
and the DRQ bit cleared to zero and Interrupt bit cleared to zero to
mark interface ready for the next command."

PxCI is currently cleared by handle_cmd(), but we don't write the D2H
FIS to the FIS Receive Area that actually caused PxCI to be cleared.

Similar to how ahci_pio_transfer() calls ahci_write_fis_pio() with an
additional parameter to write a PIO Setup FIS without raising an IRQ,
add a parameter to ahci_write_fis_d2h() so that ahci_write_fis_d2h()
also can write the FIS to the FIS Receive Area without raising an IRQ.

Change process_ncq_command() to call ahci_write_fis_d2h() without
raising an IRQ (similar to ahci_pio_transfer()), such that the FIS
Receive Area is in sync with the PxTFD shadow register.

E.g. Linux reads status and error fields from the FIS Receive Area
directly, so it is wise to keep the FIS Receive Area and the PxTFD
shadow register in sync.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
Message-id: 20230609140844.202795-4-nks@flawful.org
Signed-off-by: John Snow <jsnow@redhat.com>
(cherry picked from commit 2967dc8209dd27b61a6ab7bad78cf7c6ec58ddb4)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 55902e1df7..1b937e5e23 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -43,7 +43,7 @@
 static void check_cmd(AHCIState *s, int port);
 static int handle_cmd(AHCIState *s, int port, uint8_t slot);
 static void ahci_reset_port(AHCIState *s, int port);
-static bool ahci_write_fis_d2h(AHCIDevice *ad);
+static bool ahci_write_fis_d2h(AHCIDevice *ad, bool d2h_fis_i);
 static void ahci_init_d2h(AHCIDevice *ad);
 static int ahci_dma_prepare_buf(const IDEDMA *dma, int32_t limit);
 static bool ahci_map_clb_address(AHCIDevice *ad);
@@ -618,7 +618,7 @@ static void ahci_init_d2h(AHCIDevice *ad)
         return;
     }
 
-    if (ahci_write_fis_d2h(ad)) {
+    if (ahci_write_fis_d2h(ad, true)) {
         ad->init_d2h_sent = true;
         /* We're emulating receiving the first Reg H2D Fis from the device;
          * Update the SIG register, but otherwise proceed as normal. */
@@ -850,7 +850,7 @@ static void ahci_write_fis_pio(AHCIDevice *ad, uint16_t len, bool pio_fis_i)
     }
 }
 
-static bool ahci_write_fis_d2h(AHCIDevice *ad)
+static bool ahci_write_fis_d2h(AHCIDevice *ad, bool d2h_fis_i)
 {
     AHCIPortRegs *pr = &ad->port_regs;
     uint8_t *d2h_fis;
@@ -864,7 +864,7 @@ static bool ahci_write_fis_d2h(AHCIDevice *ad)
     d2h_fis = &ad->res_fis[RES_FIS_RFIS];
 
     d2h_fis[0] = SATA_FIS_TYPE_REGISTER_D2H;
-    d2h_fis[1] = (1 << 6); /* interrupt bit */
+    d2h_fis[1] = d2h_fis_i ? (1 << 6) : 0; /* interrupt bit */
     d2h_fis[2] = s->status;
     d2h_fis[3] = s->error;
 
@@ -890,7 +890,10 @@ static bool ahci_write_fis_d2h(AHCIDevice *ad)
         ahci_trigger_irq(ad->hba, ad, AHCI_PORT_IRQ_BIT_TFES);
     }
 
-    ahci_trigger_irq(ad->hba, ad, AHCI_PORT_IRQ_BIT_DHRS);
+    if (d2h_fis_i) {
+        ahci_trigger_irq(ad->hba, ad, AHCI_PORT_IRQ_BIT_DHRS);
+    }
+
     return true;
 }
 
@@ -1120,6 +1123,8 @@ static void process_ncq_command(AHCIState *s, int port, const uint8_t *cmd_fis,
         return;
     }
 
+    ahci_write_fis_d2h(ad, false);
+
     ncq_tfs->used = 1;
     ncq_tfs->drive = ad;
     ncq_tfs->slot = slot;
@@ -1506,7 +1511,7 @@ static void ahci_cmd_done(const IDEDMA *dma)
     }
 
     /* update d2h status */
-    ahci_write_fis_d2h(ad);
+    ahci_write_fis_d2h(ad, true);
 
     if (ad->port_regs.cmd_issue && !ad->check_bh) {
         ad->check_bh = qemu_bh_new(ahci_check_cmd_bh, ad);
-- 
2.39.2


