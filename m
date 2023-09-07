Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1417F796F58
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 05:43:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qe5up-000057-Gi; Wed, 06 Sep 2023 23:42:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qe5un-0008Vw-NY
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 23:42:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qe5ul-0007Yz-5L
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 23:42:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694058161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Kd5tMpalOgxIp7itrv0DFlWsnmvAtiGth05JMj/vNA=;
 b=efgJ2b4pdBgD3v2S2C3KkF1FvClmCcKN1ShKpPtNaYW8+N2mvJlpHlEm0qmVcP5lUm7++7
 7JCJtxKnyDFBZ5TMIDyp0RO124ADrliMoIfqE8prtia4TI4l75XsxOQMCoHOH+OByPfkBi
 sOl+wINu+Dw2jRXjov6ktTmvC0WNKzE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-307-CTD1XCTfN1-yH3AsuUyVzQ-1; Wed, 06 Sep 2023 23:42:30 -0400
X-MC-Unique: CTD1XCTfN1-yH3AsuUyVzQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1E51B3C0EAA7;
 Thu,  7 Sep 2023 03:42:30 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.8.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C8FDD1182E7;
 Thu,  7 Sep 2023 03:42:29 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Niklas Cassel <niklas.cassel@wdc.com>
Subject: [PULL for-6.2 3/7] hw/ide/ahci: simplify and document PxCI handling
Date: Wed,  6 Sep 2023 23:42:24 -0400
Message-ID: <20230907034228.4054839-4-jsnow@redhat.com>
In-Reply-To: <20230907034228.4054839-1-jsnow@redhat.com>
References: <20230907034228.4054839-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Message-id: 20230609140844.202795-5-nks@flawful.org
Signed-off-by: John Snow <jsnow@redhat.com>
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
2.41.0


