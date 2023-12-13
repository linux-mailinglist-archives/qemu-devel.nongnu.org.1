Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AD381127A
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 14:05:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDOrp-0008Br-S6; Wed, 13 Dec 2023 08:01:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rDOrK-00083L-4z; Wed, 13 Dec 2023 08:01:06 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rDOrH-0006x0-VX; Wed, 13 Dec 2023 08:01:05 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CC78B3B435;
 Wed, 13 Dec 2023 16:01:00 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 6DF953C8C6;
 Wed, 13 Dec 2023 16:00:41 +0300 (MSK)
Received: (nullmailer pid 1024699 invoked by uid 1000);
 Wed, 13 Dec 2023 13:00:41 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Niklas Cassel <niklas.cassel@wdc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.8 02/24] hw/ide/ahci: fix legacy software reset
Date: Wed, 13 Dec 2023 16:00:11 +0300
Message-Id: <20231213130041.1024630-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.8-20231213160018@cover.tls.msk.ru>
References: <qemu-stable-7.2.8-20231213160018@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Niklas Cassel <niklas.cassel@wdc.com>

Legacy software contains a standard mechanism for generating a reset to a
Serial ATA device - setting the SRST (software reset) bit in the Device
Control register.

Serial ATA has a more robust mechanism called COMRESET, also referred to
as port reset. A port reset is the preferred mechanism for error
recovery and should be used in place of software reset.

Commit e2a5d9b3d9c3 ("hw/ide/ahci: simplify and document PxCI handling")
(mjt:  1e5ad6b06b1e in stable-7.2 series, v7.2.6)
improved the handling of PxCI, such that PxCI gets cleared after handling
a non-NCQ, or NCQ command (instead of incorrectly clearing PxCI after
receiving anything - even a FIS that failed to parse, which should NOT
clear PxCI, so that you can see which command slot that caused an error).

However, simply clearing PxCI after a non-NCQ, or NCQ command, is not
enough, we also need to clear PxCI when receiving a SRST in the Device
Control register.

A legacy software reset is performed by the host sending two H2D FISes,
the first H2D FIS asserts SRST, and the second H2D FIS deasserts SRST.

The first H2D FIS will not get a D2H reply, and requires the FIS to have
the C bit set to one, such that the HBA itself will clear the bit in PxCI.

The second H2D FIS will get a D2H reply once the diagnostic is completed.
The clearing of the bit in PxCI for this command should ideally be done
in ahci_init_d2h() (if it was a legacy software reset that caused the
reset (a COMRESET does not use a command slot)). However, since the reset
value for PxCI is 0, modify ahci_reset_port() to actually clear PxCI to 0,
that way we can avoid complex logic in ahci_init_d2h().

This fixes an issue for FreeBSD where the device would fail to reset.
The problem was not noticed in Linux, because Linux uses a COMRESET
instead of a legacy software reset by default.

Fixes: e2a5d9b3d9c3 ("hw/ide/ahci: simplify and document PxCI handling")
Reported-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
Message-ID: <20231108222657.117984-1-nks@flawful.org>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Tested-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit eabb921250666501ae78714b60090200b639fcfe)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: mention 1e5ad6b06b1e for stable-7.2)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index c5e79b6e6d..0167ab3680 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -622,9 +622,13 @@ static void ahci_init_d2h(AHCIDevice *ad)
         return;
     }
 
+    /*
+     * For simplicity, do not call ahci_clear_cmd_issue() for this
+     * ahci_write_fis_d2h(). (The reset value for PxCI is 0.)
+     */
     if (ahci_write_fis_d2h(ad, true)) {
         ad->init_d2h_sent = true;
-        /* We're emulating receiving the first Reg H2D Fis from the device;
+        /* We're emulating receiving the first Reg D2H FIS from the device;
          * Update the SIG register, but otherwise proceed as normal. */
         pr->sig = ((uint32_t)ide_state->hcyl << 24) |
             (ide_state->lcyl << 16) |
@@ -662,6 +666,7 @@ static void ahci_reset_port(AHCIState *s, int port)
     pr->scr_act = 0;
     pr->tfdata = 0x7F;
     pr->sig = 0xFFFFFFFF;
+    pr->cmd_issue = 0;
     d->busy_slot = -1;
     d->init_d2h_sent = false;
 
@@ -1242,10 +1247,30 @@ static void handle_reg_h2d_fis(AHCIState *s, int port,
         case STATE_RUN:
             if (cmd_fis[15] & ATA_SRST) {
                 s->dev[port].port_state = STATE_RESET;
+                /*
+                 * When setting SRST in the first H2D FIS in the reset sequence,
+                 * the device does not send a D2H FIS. Host software thus has to
+                 * set the "Clear Busy upon R_OK" bit such that PxCI (and BUSY)
+                 * gets cleared. See AHCI 1.3.1, section 10.4.1 Software Reset.
+                 */
+                if (opts & AHCI_CMD_CLR_BUSY) {
+                    ahci_clear_cmd_issue(ad, slot);
+                }
             }
             break;
         case STATE_RESET:
             if (!(cmd_fis[15] & ATA_SRST)) {
+                /*
+                 * When clearing SRST in the second H2D FIS in the reset
+                 * sequence, the device will execute diagnostics. When this is
+                 * done, the device will send a D2H FIS with the good status.
+                 * See SATA 3.5a Gold, section 11.4 Software reset protocol.
+                 *
+                 * This D2H FIS is the first D2H FIS received from the device,
+                 * and is received regardless if the reset was performed by a
+                 * COMRESET or by setting and clearing the SRST bit. Therefore,
+                 * the logic for this is found in ahci_init_d2h() and not here.
+                 */
                 ahci_reset_port(s, port);
             }
             break;
-- 
2.39.2


