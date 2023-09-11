Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0668C79A560
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 10:05:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfbtJ-0001zw-Sh; Mon, 11 Sep 2023 04:03:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qfbtG-0001wY-Ea; Mon, 11 Sep 2023 04:03:26 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qfbtD-0002IW-Ic; Mon, 11 Sep 2023 04:03:26 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6AD9B20AFC;
 Mon, 11 Sep 2023 11:02:31 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id BF66527251;
 Mon, 11 Sep 2023 11:02:29 +0300 (MSK)
Received: (nullmailer pid 3680164 invoked by uid 1000);
 Mon, 11 Sep 2023 08:02:27 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Niklas Cassel <niklas.cassel@wdc.com>,
 John Snow <jsnow@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.6 43/51] hw/ide/ahci: PxCI should not get cleared when
 ERR_STAT is set
Date: Mon, 11 Sep 2023 11:02:06 +0300
Message-Id: <20230911080225.3680068-15-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.6-20230911105418@cover.tls.msk.ru>
References: <qemu-stable-7.2.6-20230911105418@cover.tls.msk.ru>
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

For NCQ, PxCI is cleared on command queued successfully.
For non-NCQ, PxCI is cleared on command completed successfully.
Successfully means ERR_STAT, BUSY and DRQ are all cleared.

A command that has ERR_STAT set, does not get to clear PxCI.
See AHCI 1.3.1, section 5.3.8, states RegFIS:Entry and RegFIS:ClearCI,
and 5.3.16.5 ERR:FatalTaskfile.

In the case of non-NCQ commands, not clearing PxCI is needed in order
for host software to be able to see which command slot that failed.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
Message-id: 20230609140844.202795-7-nks@flawful.org
Signed-off-by: John Snow <jsnow@redhat.com>
(cherry picked from commit 1a16ce64fda11bdf50f0c4ab5d9fdde72c1383a2)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 945101d6bb..518094e215 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -1522,7 +1522,8 @@ static void ahci_clear_cmd_issue(AHCIDevice *ad, uint8_t slot)
 {
     IDEState *ide_state = &ad->port.ifs[0];
 
-    if (!(ide_state->status & (BUSY_STAT | DRQ_STAT))) {
+    if (!(ide_state->status & ERR_STAT) &&
+        !(ide_state->status & (BUSY_STAT | DRQ_STAT))) {
         ad->port_regs.cmd_issue &= ~(1 << slot);
     }
 }
@@ -1531,6 +1532,7 @@ static void ahci_clear_cmd_issue(AHCIDevice *ad, uint8_t slot)
 static void ahci_cmd_done(const IDEDMA *dma)
 {
     AHCIDevice *ad = DO_UPCAST(AHCIDevice, dma, dma);
+    IDEState *ide_state = &ad->port.ifs[0];
 
     trace_ahci_cmd_done(ad->hba, ad->port_no);
 
@@ -1547,7 +1549,8 @@ static void ahci_cmd_done(const IDEDMA *dma)
      */
     ahci_write_fis_d2h(ad, true);
 
-    if (ad->port_regs.cmd_issue && !ad->check_bh) {
+    if (!(ide_state->status & ERR_STAT) &&
+        ad->port_regs.cmd_issue && !ad->check_bh) {
         ad->check_bh = qemu_bh_new_guarded(ahci_check_cmd_bh, ad,
                                            &ad->mem_reentrancy_guard);
         qemu_bh_schedule(ad->check_bh);
diff --git a/tests/qtest/libqos/ahci.c b/tests/qtest/libqos/ahci.c
index f53f12aa99..a2c94c6e06 100644
--- a/tests/qtest/libqos/ahci.c
+++ b/tests/qtest/libqos/ahci.c
@@ -404,57 +404,110 @@ void ahci_port_clear(AHCIQState *ahci, uint8_t port)
 /**
  * Check a port for errors.
  */
-void ahci_port_check_error(AHCIQState *ahci, uint8_t port,
-                           uint32_t imask, uint8_t emask)
+void ahci_port_check_error(AHCIQState *ahci, AHCICommand *cmd)
 {
+    uint8_t port = cmd->port;
     uint32_t reg;
 
-    /* The upper 9 bits of the IS register all indicate errors. */
-    reg = ahci_px_rreg(ahci, port, AHCI_PX_IS);
-    reg &= ~imask;
-    reg >>= 23;
-    g_assert_cmphex(reg, ==, 0);
+    /* If expecting TF error, ensure that TFES is set. */
+    if (cmd->errors) {
+        reg = ahci_px_rreg(ahci, port, AHCI_PX_IS);
+        ASSERT_BIT_SET(reg, AHCI_PX_IS_TFES);
+    } else {
+        /* The upper 9 bits of the IS register all indicate errors. */
+        reg = ahci_px_rreg(ahci, port, AHCI_PX_IS);
+        reg &= ~cmd->interrupts;
+        reg >>= 23;
+        g_assert_cmphex(reg, ==, 0);
+    }
 
-    /* The Sata Error Register should be empty. */
+    /* The Sata Error Register should be empty, even when expecting TF error. */
     reg = ahci_px_rreg(ahci, port, AHCI_PX_SERR);
     g_assert_cmphex(reg, ==, 0);
 
+    /* If expecting TF error, and TFES was set, perform error recovery
+     * (see AHCI 1.3 section 6.2.2.1) such that we can send new commands. */
+    if (cmd->errors) {
+        /* This will clear PxCI. */
+        ahci_px_clr(ahci, port, AHCI_PX_CMD, AHCI_PX_CMD_ST);
+
+        /* The port has 500ms to disengage. */
+        usleep(500000);
+        reg = ahci_px_rreg(ahci, port, AHCI_PX_CMD);
+        ASSERT_BIT_CLEAR(reg, AHCI_PX_CMD_CR);
+
+        /* Clear PxIS. */
+        reg = ahci_px_rreg(ahci, port, AHCI_PX_IS);
+        ahci_px_wreg(ahci, port, AHCI_PX_IS, reg);
+
+        /* Check if we need to perform a COMRESET.
+         * Not implemented right now, as there is no reason why our QEMU model
+         * should need a COMRESET when expecting TF error. */
+        reg = ahci_px_rreg(ahci, port, AHCI_PX_TFD);
+        ASSERT_BIT_CLEAR(reg, AHCI_PX_TFD_STS_BSY | AHCI_PX_TFD_STS_DRQ);
+
+        /* Enable issuing new commands. */
+        ahci_px_set(ahci, port, AHCI_PX_CMD, AHCI_PX_CMD_ST);
+    }
+
     /* The TFD also has two error sections. */
     reg = ahci_px_rreg(ahci, port, AHCI_PX_TFD);
-    if (!emask) {
+    if (!cmd->errors) {
         ASSERT_BIT_CLEAR(reg, AHCI_PX_TFD_STS_ERR);
     } else {
         ASSERT_BIT_SET(reg, AHCI_PX_TFD_STS_ERR);
     }
-    ASSERT_BIT_CLEAR(reg, AHCI_PX_TFD_ERR & (~emask << 8));
-    ASSERT_BIT_SET(reg, AHCI_PX_TFD_ERR & (emask << 8));
+    ASSERT_BIT_CLEAR(reg, AHCI_PX_TFD_ERR & (~cmd->errors << 8));
+    ASSERT_BIT_SET(reg, AHCI_PX_TFD_ERR & (cmd->errors << 8));
 }
 
-void ahci_port_check_interrupts(AHCIQState *ahci, uint8_t port,
-                                uint32_t intr_mask)
+void ahci_port_check_interrupts(AHCIQState *ahci, AHCICommand *cmd)
 {
+    uint8_t port = cmd->port;
     uint32_t reg;
 
+    /* If we expect errors, error handling in ahci_port_check_error() will
+     * already have cleared PxIS, so in that case this function cannot verify
+     * and clear expected interrupts. */
+    if (cmd->errors) {
+        return;
+    }
+
     /* Check for expected interrupts */
     reg = ahci_px_rreg(ahci, port, AHCI_PX_IS);
-    ASSERT_BIT_SET(reg, intr_mask);
+    ASSERT_BIT_SET(reg, cmd->interrupts);
 
     /* Clear expected interrupts and assert all interrupts now cleared. */
-    ahci_px_wreg(ahci, port, AHCI_PX_IS, intr_mask);
+    ahci_px_wreg(ahci, port, AHCI_PX_IS, cmd->interrupts);
     g_assert_cmphex(ahci_px_rreg(ahci, port, AHCI_PX_IS), ==, 0);
 }
 
-void ahci_port_check_nonbusy(AHCIQState *ahci, uint8_t port, uint8_t slot)
+void ahci_port_check_nonbusy(AHCIQState *ahci, AHCICommand *cmd)
 {
+    uint8_t slot = cmd->slot;
+    uint8_t port = cmd->port;
     uint32_t reg;
 
-    /* Assert that the command slot is no longer busy (NCQ) */
+    /* For NCQ command with error PxSACT bit should still be set.
+     * For NCQ command without error, PxSACT bit should be cleared.
+     * For non-NCQ command, PxSACT bit should always be cleared. */
     reg = ahci_px_rreg(ahci, port, AHCI_PX_SACT);
-    ASSERT_BIT_CLEAR(reg, (1 << slot));
+    if (cmd->props->ncq && cmd->errors) {
+        ASSERT_BIT_SET(reg, (1 << slot));
+    } else {
+        ASSERT_BIT_CLEAR(reg, (1 << slot));
+    }
 
-    /* Non-NCQ */
+    /* For non-NCQ command with error, PxCI bit should still be set.
+     * For non-NCQ command without error, PxCI bit should be cleared.
+     * For NCQ command without error, PxCI bit should be cleared.
+     * For NCQ command with error, PxCI bit may or may not be cleared. */
     reg = ahci_px_rreg(ahci, port, AHCI_PX_CI);
-    ASSERT_BIT_CLEAR(reg, (1 << slot));
+    if (!cmd->props->ncq && cmd->errors) {
+        ASSERT_BIT_SET(reg, (1 << slot));
+    } else if (!cmd->errors) {
+        ASSERT_BIT_CLEAR(reg, (1 << slot));
+    }
 
     /* And assert that we are generally not busy. */
     reg = ahci_px_rreg(ahci, port, AHCI_PX_TFD);
@@ -1207,9 +1260,10 @@ void ahci_command_wait(AHCIQState *ahci, AHCICommand *cmd)
 
 #define RSET(REG, MASK) (BITSET(ahci_px_rreg(ahci, cmd->port, (REG)), (MASK)))
 
-    while (RSET(AHCI_PX_TFD, AHCI_PX_TFD_STS_BSY) ||
-           RSET(AHCI_PX_CI, 1 << cmd->slot) ||
-           (cmd->props->ncq && RSET(AHCI_PX_SACT, 1 << cmd->slot))) {
+    while (!RSET(AHCI_PX_TFD, AHCI_PX_TFD_STS_ERR) &&
+           (RSET(AHCI_PX_TFD, AHCI_PX_TFD_STS_BSY) ||
+            RSET(AHCI_PX_CI, 1 << cmd->slot) ||
+            (cmd->props->ncq && RSET(AHCI_PX_SACT, 1 << cmd->slot)))) {
         usleep(50);
     }
 
@@ -1226,9 +1280,9 @@ void ahci_command_verify(AHCIQState *ahci, AHCICommand *cmd)
     uint8_t slot = cmd->slot;
     uint8_t port = cmd->port;
 
-    ahci_port_check_error(ahci, port, cmd->interrupts, cmd->errors);
-    ahci_port_check_interrupts(ahci, port, cmd->interrupts);
-    ahci_port_check_nonbusy(ahci, port, slot);
+    ahci_port_check_nonbusy(ahci, cmd);
+    ahci_port_check_error(ahci, cmd);
+    ahci_port_check_interrupts(ahci, cmd);
     ahci_port_check_cmd_sanity(ahci, cmd);
     if (cmd->interrupts & AHCI_PX_IS_DHRS) {
         ahci_port_check_d2h_sanity(ahci, port, slot);
diff --git a/tests/qtest/libqos/ahci.h b/tests/qtest/libqos/ahci.h
index 88835b6228..48017864bf 100644
--- a/tests/qtest/libqos/ahci.h
+++ b/tests/qtest/libqos/ahci.h
@@ -590,11 +590,9 @@ void ahci_set_command_header(AHCIQState *ahci, uint8_t port,
 void ahci_destroy_command(AHCIQState *ahci, uint8_t port, uint8_t slot);
 
 /* AHCI sanity check routines */
-void ahci_port_check_error(AHCIQState *ahci, uint8_t port,
-                           uint32_t imask, uint8_t emask);
-void ahci_port_check_interrupts(AHCIQState *ahci, uint8_t port,
-                                uint32_t intr_mask);
-void ahci_port_check_nonbusy(AHCIQState *ahci, uint8_t port, uint8_t slot);
+void ahci_port_check_error(AHCIQState *ahci, AHCICommand *cmd);
+void ahci_port_check_interrupts(AHCIQState *ahci, AHCICommand *cmd);
+void ahci_port_check_nonbusy(AHCIQState *ahci, AHCICommand *cmd);
 void ahci_port_check_d2h_sanity(AHCIQState *ahci, uint8_t port, uint8_t slot);
 void ahci_port_check_pio_sanity(AHCIQState *ahci, AHCICommand *cmd);
 void ahci_port_check_cmd_sanity(AHCIQState *ahci, AHCICommand *cmd);
-- 
2.39.2


