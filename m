Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 321777F2C2A
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 12:55:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5PJc-0003OE-OX; Tue, 21 Nov 2023 06:53:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r5PJa-0003NL-4C
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 06:53:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r5PJX-0004GG-9w
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 06:53:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700567590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0Ku6C++zJqvi5s7JjQEttBg89WdSDuViyFjlGk+UHms=;
 b=PgR9c03QRCqaCLiQEi5p01+VSKEIc8iQMvYBqFrszI8HQ0WniYGC638HjM35ifEyEJScVz
 vFaBuH7UFC/lwgRXcMZ5dl5rdghWqynaTY9Khk3HYKCf31eh0+O01B1MRk4CDSHNQM/2hU
 PRYzX06/SjsJZ0iylGmreg+NYcui6xg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-AR0zMI3xMauSFLQ_955ILw-1; Tue, 21 Nov 2023 06:53:08 -0500
X-MC-Unique: AR0zMI3xMauSFLQ_955ILw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3E70D80513E;
 Tue, 21 Nov 2023 11:53:08 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 47B2C492BFC;
 Tue, 21 Nov 2023 11:53:07 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 1/9] hw/ide/ahci: fix legacy software reset
Date: Tue, 21 Nov 2023 12:52:54 +0100
Message-ID: <20231121115302.52214-2-kwolf@redhat.com>
In-Reply-To: <20231121115302.52214-1-kwolf@redhat.com>
References: <20231121115302.52214-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
---
 hw/ide/ahci.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 7676e2d871..afdc44b8e0 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -623,9 +623,13 @@ static void ahci_init_d2h(AHCIDevice *ad)
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
@@ -663,6 +667,7 @@ static void ahci_reset_port(AHCIState *s, int port)
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
2.42.0


