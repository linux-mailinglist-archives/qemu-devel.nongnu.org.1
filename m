Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D16E719EBD
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 15:47:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4ieV-0001Xo-BR; Thu, 01 Jun 2023 09:47:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nks.gnu@gmail.com>)
 id 1q4idT-0000bK-2J; Thu, 01 Jun 2023 09:46:46 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nks.gnu@gmail.com>)
 id 1q4idR-0008OO-1r; Thu, 01 Jun 2023 09:46:38 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2afb2874e83so12356071fa.0; 
 Thu, 01 Jun 2023 06:46:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685627195; x=1688219195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/ev5aaWOMtzj7uhrV2SRo+Ugfi/ZJw07xZsuBD2beIE=;
 b=eVXz+l6Rs3/Xs7gwK5DrU9BYu7MxTW0ga0AwKe5UcwW1pOtbPLNpBcIUHEnlctAzpn
 L/9kK6tNFdD2wz9BxglgbtzQkSEvTGsB0o12nv3Bgbpj8h7kpGVhnnsFUYZXv4/GgOuV
 Uekb1ObppRz1b6vo2kQHtOLmc5dwQqD+YizKjd1lTlDAv6Ik51xhQRnFzYH91RWUu7YQ
 S0QrVzN0UQB91W447d1MeuoBXHaswbpnXMNsACZ1fnItaCNCqL67rOKxsaOf+HJVOXlM
 8hzrTX7SHSfQvOmMMaMkOCU/oaN84vr9y91mgmrbi7/mZtXtWCIC1hwvBY2p6KZleLGl
 zegw==
X-Gm-Message-State: AC+VfDzgW1Q0Le52eMYmpnsuhr4jzWVtOYlJR8YdBSLT5oj6JQD4EyT1
 pw6CNAsUeNfPH2jwTTdVJFOe3sN2OtPm04s7
X-Google-Smtp-Source: ACHHUZ47S+I6WerkFdBKU9/WJFZdiO7yYLCEK3gqfbeMSsjF6nXSLCu8dqo1cqQ/pfPbJOwBZJRdYQ==
X-Received: by 2002:a2e:99cb:0:b0:2af:e006:b83 with SMTP id
 l11-20020a2e99cb000000b002afe0060b83mr5099367ljj.18.1685627194664; 
 Thu, 01 Jun 2023 06:46:34 -0700 (PDT)
Received: from flawful.org (c-fcf6e255.011-101-6d6c6d3.bbcust.telenor.se.
 [85.226.246.252]) by smtp.gmail.com with ESMTPSA id
 l20-20020a2e7014000000b002ab5421959fsm3799701ljc.90.2023.06.01.06.46.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 06:46:34 -0700 (PDT)
Received: by flawful.org (Postfix, from userid 112)
 id 26AD44E8; Thu,  1 Jun 2023 15:46:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
 t=1685627186; bh=+crhlsOe8XqLHrztrhhxdpb8tqjExwekFotXDvFGgAE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BLZZ/qCT+v6SZYzPE7NjpqgbV2sYKdDsCalo7m+TLS0aeeyzL/5qckd3hNr70I/Ab
 8BwMl4Pw3+OltH5LLSI8TwFTSO5CExvzgdFavASflrg3k+ehHeV21frvupWQSZkgrx
 wI32jiItpCtVOQ0/OWZgZqfmz9kyeGrWLRwFRouA=
Received: from x1-carbon.lan (unknown [129.253.182.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by flawful.org (Postfix) with ESMTPSA id D8A9B4D7;
 Thu,  1 Jun 2023 15:45:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
 t=1685627135; bh=+crhlsOe8XqLHrztrhhxdpb8tqjExwekFotXDvFGgAE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=e0YJ86U1b0fK2JsaKm2cOleAeYENO9LmdqZvXuZ6dc5HNNl1U1dGTcla7Ils1kgx4
 yaIWailYBPCsjKWPfHorGnOI/O4cnR/fWSu9N1G/0/57/Si4zJXaz4wvVDuQbzgrfl
 YE5EKsXdmEA3rgsYLWfKgTMK9YxeDYFNhx7fUoCs=
From: Niklas Cassel <nks@flawful.org>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <niklas.cassel@wdc.com>
Subject: [PATCH v2 4/8] hw/ide/ahci: simplify and document PxCI handling
Date: Thu,  1 Jun 2023 15:44:30 +0200
Message-Id: <20230601134434.519805-5-nks@flawful.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601134434.519805-1-nks@flawful.org>
References: <20230601134434.519805-1-nks@flawful.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=nks.gnu@gmail.com; helo=mail-lj1-x229.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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

The AHCI spec states that:
For NCQ, PxCI is cleared on command queued successfully.

For non-NCQ, PxCI is cleared on command completed successfully.
(A non-NCQ command that completes with error does not clear PxCI.)

The current QEMU implementation either clears PxCI in check_cmd(),
or in ahci_cmd_done().

check_cmd() will clear PxCI for a command if handle_cmd() returns 0.
handle_cmd() will return -1 if BUSY or DRQ is set.

The QEMU implementation for NCQ commands will currently not set BUSY
or DRQ, so they will always have PxCI cleared by handle_cmd().
ahci_cmd_done() will never even get called for NCQ commands.

Non-NCQ commands are executed by ide_bus_exec_cmd().
Non-NCQ commands in QEMU are implemented either in a sync or in an async
way.

For non-NCQ commands implemented in a sync way, the command handler will
return true, and when ide_bus_exec_cmd() sees that a command handler
returns true, it will call ide_cmd_done() (which will call
ahci_cmd_done()). For a command implemented in a sync way,
ahci_cmd_done() will do nothing (since busy_slot is not set). Instead,
after ide_bus_exec_cmd() has finished, check_cmd() will clear PxCI for
these commands.

For non-NCQ commands implemented in an async way (using either aiocb or
pio_aiocb), the command handler will return false, ide_bus_exec_cmd()
will not call ide_cmd_done(), instead it is expected that the async
callback function will call ide_cmd_done() once the async command is
done. handle_cmd() will set busy_slot, if and only if BUSY or DRQ is
set, and this is checked _after_ ide_bus_exec_cmd() has returned.
handle_cmd() will return -1, so check_cmd() will not clear PxCI.
When the async callback calls ide_cmd_done() (which will call
ahci_cmd_done()), it will see that busy_slot is set, and
ahci_cmd_done() will clear PxCI.

This seems racy, since busy_slot is set _after_ ide_bus_exec_cmd() has
returned. The callback might come before busy_slot gets set. And it is
quite confusing that ahci_cmd_done() will be called for all non-NCQ
commands when the command is done, but will only clear PxCI in certain
cases, even though it will always write a D2H FIS and raise an IRQ.

Even worse, in the case where ahci_cmd_done() does not clear PxCI, it
still raises an IRQ. Host software might thus read an old PxCI value,
since PxCI is cleared (by check_cmd()) after the IRQ has been raised.

Try to simplify this by always setting busy_slot for non-NCQ commands,
such that ahci_cmd_done() will always be responsible for clearing PxCI
for non-NCQ commands.

For NCQ commands, clear PxCI when we receive the D2H FIS, but before
raising the IRQ, see AHCI 1.3.1, section 5.3.8, states RegFIS:Entry and
RegFIS:ClearCI.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 hw/ide/ahci.c | 70 ++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 50 insertions(+), 20 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 4b272397fd..3deaf01add 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -41,9 +41,10 @@
 #include "trace.h"
 
 static void check_cmd(AHCIState *s, int port);
-static int handle_cmd(AHCIState *s, int port, uint8_t slot);
+static void handle_cmd(AHCIState *s, int port, uint8_t slot);
 static void ahci_reset_port(AHCIState *s, int port);
 static bool ahci_write_fis_d2h(AHCIDevice *ad, bool d2h_fis_i);
+static void ahci_clear_cmd_issue(AHCIDevice *ad, uint8_t slot);
 static void ahci_init_d2h(AHCIDevice *ad);
 static int ahci_dma_prepare_buf(const IDEDMA *dma, int32_t limit);
 static bool ahci_map_clb_address(AHCIDevice *ad);
@@ -591,9 +592,8 @@ static void check_cmd(AHCIState *s, int port)
 
     if ((pr->cmd & PORT_CMD_START) && pr->cmd_issue) {
         for (slot = 0; (slot < 32) && pr->cmd_issue; slot++) {
-            if ((pr->cmd_issue & (1U << slot)) &&
-                !handle_cmd(s, port, slot)) {
-                pr->cmd_issue &= ~(1U << slot);
+            if (pr->cmd_issue & (1U << slot)) {
+                handle_cmd(s, port, slot);
             }
         }
     }
@@ -1123,6 +1123,22 @@ static void process_ncq_command(AHCIState *s, int port, const uint8_t *cmd_fis,
         return;
     }
 
+    /*
+     * A NCQ command clears the bit in PxCI after the command has been QUEUED
+     * successfully (ERROR not set, BUSY and DRQ cleared).
+     *
+     * For NCQ commands, PxCI will always be cleared here.
+     *
+     * (Once the NCQ command is COMPLETED, the device will send a SDB FIS with
+     * the interrupt bit set, which will clear PxSACT and raise an interrupt.)
+     */
+    ahci_clear_cmd_issue(ad, slot);
+
+    /*
+     * In reality, for NCQ commands, PxCI is cleared after receiving a D2H FIS
+     * without the interrupt bit set, but since ahci_write_fis_d2h() can raise
+     * an IRQ on error, we need to call them in reverse order.
+     */
     ahci_write_fis_d2h(ad, false);
 
     ncq_tfs->used = 1;
@@ -1197,6 +1213,7 @@ static void handle_reg_h2d_fis(AHCIState *s, int port,
 {
     IDEState *ide_state = &s->dev[port].port.ifs[0];
     AHCICmdHdr *cmd = get_cmd_header(s, port, slot);
+    AHCIDevice *ad = &s->dev[port];
     uint16_t opts = le16_to_cpu(cmd->opts);
 
     if (cmd_fis[1] & 0x0F) {
@@ -1273,11 +1290,19 @@ static void handle_reg_h2d_fis(AHCIState *s, int port,
     /* Reset transferred byte counter */
     cmd->status = 0;
 
+    /*
+     * A non-NCQ command clears the bit in PxCI after the command has COMPLETED
+     * successfully (ERROR not set, BUSY and DRQ cleared).
+     *
+     * For non-NCQ commands, PxCI will always be cleared by ahci_cmd_done().
+     */
+    ad->busy_slot = slot;
+
     /* We're ready to process the command in FIS byte 2. */
     ide_bus_exec_cmd(&s->dev[port].port, cmd_fis[2]);
 }
 
-static int handle_cmd(AHCIState *s, int port, uint8_t slot)
+static void handle_cmd(AHCIState *s, int port, uint8_t slot)
 {
     IDEState *ide_state;
     uint64_t tbl_addr;
@@ -1288,12 +1313,12 @@ static int handle_cmd(AHCIState *s, int port, uint8_t slot)
     if (s->dev[port].port.ifs[0].status & (BUSY_STAT|DRQ_STAT)) {
         /* Engine currently busy, try again later */
         trace_handle_cmd_busy(s, port);
-        return -1;
+        return;
     }
 
     if (!s->dev[port].lst) {
         trace_handle_cmd_nolist(s, port);
-        return -1;
+        return;
     }
     cmd = get_cmd_header(s, port, slot);
     /* remember current slot handle for later */
@@ -1303,7 +1328,7 @@ static int handle_cmd(AHCIState *s, int port, uint8_t slot)
     ide_state = &s->dev[port].port.ifs[0];
     if (!ide_state->blk) {
         trace_handle_cmd_badport(s, port);
-        return -1;
+        return;
     }
 
     tbl_addr = le64_to_cpu(cmd->tbl_addr);
@@ -1312,7 +1337,7 @@ static int handle_cmd(AHCIState *s, int port, uint8_t slot)
                              DMA_DIRECTION_TO_DEVICE, MEMTXATTRS_UNSPECIFIED);
     if (!cmd_fis) {
         trace_handle_cmd_badfis(s, port);
-        return -1;
+        return;
     } else if (cmd_len != 0x80) {
         ahci_trigger_irq(s, &s->dev[port], AHCI_PORT_IRQ_BIT_HBFS);
         trace_handle_cmd_badmap(s, port, cmd_len);
@@ -1336,15 +1361,6 @@ static int handle_cmd(AHCIState *s, int port, uint8_t slot)
 out:
     dma_memory_unmap(s->as, cmd_fis, cmd_len, DMA_DIRECTION_TO_DEVICE,
                      cmd_len);
-
-    if (s->dev[port].port.ifs[0].status & (BUSY_STAT|DRQ_STAT)) {
-        /* async command, complete later */
-        s->dev[port].busy_slot = slot;
-        return -1;
-    }
-
-    /* done handling the command */
-    return 0;
 }
 
 /* Transfer PIO data between RAM and device */
@@ -1498,6 +1514,16 @@ static int ahci_dma_rw_buf(const IDEDMA *dma, bool is_write)
     return 1;
 }
 
+static void ahci_clear_cmd_issue(AHCIDevice *ad, uint8_t slot)
+{
+    IDEState *ide_state = &ad->port.ifs[0];
+
+    if (!(ide_state->status & (BUSY_STAT | DRQ_STAT))) {
+        ad->port_regs.cmd_issue &= ~(1 << slot);
+    }
+}
+
+/* Non-NCQ command is done - This function is never called for NCQ commands. */
 static void ahci_cmd_done(const IDEDMA *dma)
 {
     AHCIDevice *ad = DO_UPCAST(AHCIDevice, dma, dma);
@@ -1506,11 +1532,15 @@ static void ahci_cmd_done(const IDEDMA *dma)
 
     /* no longer busy */
     if (ad->busy_slot != -1) {
-        ad->port_regs.cmd_issue &= ~(1 << ad->busy_slot);
+        ahci_clear_cmd_issue(ad, ad->busy_slot);
         ad->busy_slot = -1;
     }
 
-    /* update d2h status */
+    /*
+     * In reality, for non-NCQ commands, PxCI is cleared after receiving a D2H
+     * FIS with the interrupt bit set, but since ahci_write_fis_d2h() will raise
+     * an IRQ, we need to call them in reverse order.
+     */
     ahci_write_fis_d2h(ad, true);
 
     if (ad->port_regs.cmd_issue && !ad->check_bh) {
-- 
2.40.1


