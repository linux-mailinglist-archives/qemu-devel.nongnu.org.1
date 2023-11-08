Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 589F27E606E
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 23:29:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0r1n-0000gd-SZ; Wed, 08 Nov 2023 17:28:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nks.gnu@gmail.com>)
 id 1r0r1l-0000fu-3i; Wed, 08 Nov 2023 17:28:01 -0500
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nks.gnu@gmail.com>)
 id 1r0r1Y-0006Pk-WD; Wed, 08 Nov 2023 17:28:00 -0500
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5079f9ec8d9so283504e87.0; 
 Wed, 08 Nov 2023 14:27:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699482465; x=1700087265;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:dkim-signature:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fnJEiTxap0oqRzD1UsiCOdjxOvVyh/EUEdOCdLUUynU=;
 b=XKMSDEfKpzz2FySWyTbShaRsI0U+Tox9WaHnlkhvoi1LwgnkWSGdUPAYty6pRUbkYn
 UsyMCL/Yk4Xom2D4PAMg9SMh/I4FCov/beb3jMX2Ja93z9UY57X7G4npGAoqBhkVwcwV
 h1MAkLdU0F4JeOzIDgFwjU8ERqIeBLnE+6FwFLDibwAh/rQm4mAXAS6equbo72HfEfL0
 XXdjZc2bN69u0MHhRDlxb7ouwqvINXUbkwovsrLSMJolPjFW6+Ri7GUJNeJdr65x/Bmc
 Lj9SKc+cPhz27e/mwhJThJjeAjxIEOAcx/nNOz0YH5ncdlrCXkRzRA/7nfUR5mhdXkPB
 kP+g==
X-Gm-Message-State: AOJu0Yw5K+wmNTWbborxt5FZTO6SAWHv1PhKXgniBDtF9XMbSILt4l6f
 0urrneoR/R20upqwYbidWB7nQ6Mc6LHxNYP3ZPs=
X-Google-Smtp-Source: AGHT+IGGfr1RTKCS2iyuSsJynXyVQXJZjvbn2kbCc0OWtI/b4xAtA8nM4Gd8Lzeiu2h3pcigu6n1vQ==
X-Received: by 2002:a05:6512:3da5:b0:509:489f:5b6f with SMTP id
 k37-20020a0565123da500b00509489f5b6fmr1552043lfv.11.1699482465310; 
 Wed, 08 Nov 2023 14:27:45 -0800 (PST)
Received: from flawful.org (c-bcf2e255.011-101-6d6c6d3.bbcust.telenor.se.
 [85.226.242.188]) by smtp.gmail.com with ESMTPSA id
 m7-20020ac24247000000b00507cf5f9299sm812205lfl.125.2023.11.08.14.27.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Nov 2023 14:27:45 -0800 (PST)
Received: by flawful.org (Postfix, from userid 112)
 id 1E34E3F10; Wed,  8 Nov 2023 23:27:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
 t=1699482464; bh=zg80VtaiJdVk2RH/knxWUaSb9J1air2JbyN6jgOcKnw=;
 h=From:To:Cc:Subject:Date:From;
 b=TG9H5zPjJFJsU6Y9ThLASkGlrdk9r//XMGSXep8RmNn/CPFShRtf93252OkDYwZ+Q
 Cq+ayUj4JnhQQJ25Oby684TyXPSFDoqQd+Quw/rpmaDBceqnwmB8cQ/O31OzI3Wh1N
 IV8nbWxwtQ14xFDZCWHJxKhyYKd/2slZqfM99HQU=
Received: from x1-carbon.lan (unknown [129.253.182.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by flawful.org (Postfix) with ESMTPSA id B7AE73EEF;
 Wed,  8 Nov 2023 23:27:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
 t=1699482438; bh=zg80VtaiJdVk2RH/knxWUaSb9J1air2JbyN6jgOcKnw=;
 h=From:To:Cc:Subject:Date:From;
 b=H9K+AM3IIMSjU4UmFvGUqsXDuzn6RWk7VKFYHtY9GpSfwXuN0dFG0APtCs0xqTjXt
 pckzbO3jlTAVwSAtzCLkbXOSRH/HB4x6xWrORg2ghWNYxDCtQqbfc0yp7wlil5dfxB
 PE+h3E04CC6CSSo9qzl/O1PH82Ir/5VDMXmVCfqE=
From: Niklas Cassel <nks@flawful.org>
To: John Snow <jsnow@redhat.com>,
	Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Damien Le Moal <dlemoal@kernel.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Niklas Cassel <niklas.cassel@wdc.com>
Subject: [PATCH v3] hw/ide/ahci: fix legacy software reset
Date: Wed,  8 Nov 2023 23:26:57 +0100
Message-ID: <20231108222657.117984-1-nks@flawful.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=nks.gnu@gmail.com; helo=mail-lf1-x135.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
---
Changes since v3: remove superfluous ahci_write_fis_d2h(), and add
comments describing how the (quite confusing) spec actually works.

 hw/ide/ahci.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index fcc5476e9e..56c7672eb9 100644
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
 
@@ -1243,10 +1248,30 @@ static void handle_reg_h2d_fis(AHCIState *s, int port,
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
2.41.0


