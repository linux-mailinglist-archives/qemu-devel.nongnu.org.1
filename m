Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE53729F87
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 18:02:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7cpd-0003ac-AU; Fri, 09 Jun 2023 10:11:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nks.gnu@gmail.com>)
 id 1q7cpV-0003SH-KV; Fri, 09 Jun 2023 10:11:06 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nks.gnu@gmail.com>)
 id 1q7cpQ-0000fg-N6; Fri, 09 Jun 2023 10:11:05 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2b1b2ca09b9so20050711fa.1; 
 Fri, 09 Jun 2023 07:10:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686319858; x=1688911858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mkwTC8Vty9tpt7HJGEvIurSy9HSAeKfGf7/QzOLfMEs=;
 b=dgVuAG9Al84hbDKOal3VnlbF5puz7iFOAAKZANxxEtUTeU4CJrbXPUhBY9sMietPHK
 TI8jsfWHAyew0u5u7J0b3yzhGCBEVbfR8lMFEWA7wZ1IAdYDV/i09bwXlCMzVVWNne0G
 0aok5WS3evg8KmCi3W6Nxp9BGcrAWRFZC3aV0+l17WlRMmiFcH0qoVv9xmCqfhmX17/v
 ulmRW2xHjIYuPcgvyw07lBsnoVKPUGLwOchATzAaItLebfZoLBJHyiTYJ9or30+yF53e
 /lzFi6r7hD0VdSyM9aLH9wC441lkUBewUo4HHDdL9YpeLfhcZE/vsAk/UixLlBS2zELZ
 WZTA==
X-Gm-Message-State: AC+VfDxomEXTdZW6b7r9maC1jxV3YcZV0szcZv4ejywHu3ga/UeATQ9f
 xp1QSzM6HuvpCBRB3vOMK7Pqvp0vKC/+wm7q
X-Google-Smtp-Source: ACHHUZ525L84Z6b9zWgZI8erbfXecAPm5h0OzEWwxHZ1LidZiSGGwpJwIGvHwfx2cSJzZELqxoUKgg==
X-Received: by 2002:a2e:9bc7:0:b0:2a8:a6a5:e26e with SMTP id
 w7-20020a2e9bc7000000b002a8a6a5e26emr1197903ljj.20.1686319857860; 
 Fri, 09 Jun 2023 07:10:57 -0700 (PDT)
Received: from flawful.org (c-f5f0e255.011-101-6d6c6d3.bbcust.telenor.se.
 [85.226.240.245]) by smtp.gmail.com with ESMTPSA id
 p9-20020a2ea409000000b002aa40d705a5sm411403ljn.11.2023.06.09.07.10.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jun 2023 07:10:57 -0700 (PDT)
Received: by flawful.org (Postfix, from userid 112)
 id D589319A5; Fri,  9 Jun 2023 16:10:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
 t=1686319856; bh=pUL6u6eRxrW/o4YQuJ/qElOefIt5US8w+5dHg4FA0Os=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BdmxT903T6xuWCfuZxI8S7AdXPJxHI6dFEPKEvr3CXYmspmkzaioqo0DCq6Ripn85
 fl0cRP5OsEHL5lUTWkoT/cSrg8+Xtpl7ALMNRPkQQtYcM53AwWt7XK0s2D0OqLCi0K
 rDDtvzdntthlVuL8Epeo3+V/WnZkjl6j1xGX3VIA=
Received: from x1-carbon.lan (unknown [129.253.182.58])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by flawful.org (Postfix) with ESMTPSA id 7FC5F180D;
 Fri,  9 Jun 2023 16:09:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
 t=1686319775; bh=pUL6u6eRxrW/o4YQuJ/qElOefIt5US8w+5dHg4FA0Os=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=pyZbVsJlaWoyAiBQdDZV7SEQU857JLbuXHr9PRf558cZlQAdG2DVQkrkXNSOLZtYo
 ydH2UmJZe7yeqcxVslepp3+E7dp3vVrpbnEEBDn3y3dWllOT0uCqabMOV3ztVxf6uy
 qNTjMuAKWiPRigZPlAlwg2D7sNDWlRb7BdH66o3E=
From: Niklas Cassel <nks@flawful.org>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <niklas.cassel@wdc.com>
Subject: [PATCH v3 6/8] hw/ide/ahci: PxCI should not get cleared when ERR_STAT
 is set
Date: Fri,  9 Jun 2023 16:08:42 +0200
Message-Id: <20230609140844.202795-7-nks@flawful.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230609140844.202795-1-nks@flawful.org>
References: <20230609140844.202795-1-nks@flawful.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=nks.gnu@gmail.com; helo=mail-lj1-x233.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
---
 hw/ide/ahci.c             |   7 ++-
 tests/qtest/libqos/ahci.c | 106 ++++++++++++++++++++++++++++----------
 tests/qtest/libqos/ahci.h |   8 ++-
 3 files changed, 88 insertions(+), 33 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index a31e6fa65e..12aaadc554 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -1523,7 +1523,8 @@ static void ahci_clear_cmd_issue(AHCIDevice *ad, uint8_t slot)
 {
     IDEState *ide_state = &ad->port.ifs[0];
 
-    if (!(ide_state->status & (BUSY_STAT | DRQ_STAT))) {
+    if (!(ide_state->status & ERR_STAT) &&
+        !(ide_state->status & (BUSY_STAT | DRQ_STAT))) {
         ad->port_regs.cmd_issue &= ~(1 << slot);
     }
 }
@@ -1532,6 +1533,7 @@ static void ahci_clear_cmd_issue(AHCIDevice *ad, uint8_t slot)
 static void ahci_cmd_done(const IDEDMA *dma)
 {
     AHCIDevice *ad = DO_UPCAST(AHCIDevice, dma, dma);
+    IDEState *ide_state = &ad->port.ifs[0];
 
     trace_ahci_cmd_done(ad->hba, ad->port_no);
 
@@ -1548,7 +1550,8 @@ static void ahci_cmd_done(const IDEDMA *dma)
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
2.40.1


