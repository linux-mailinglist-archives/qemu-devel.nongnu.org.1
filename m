Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CE77B9C5C
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 11:55:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoL3J-0008FG-DE; Thu, 05 Oct 2023 05:53:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nks.gnu@gmail.com>)
 id 1qoL3H-0008F3-G6; Thu, 05 Oct 2023 05:53:51 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nks.gnu@gmail.com>)
 id 1qoL3F-0003RG-1l; Thu, 05 Oct 2023 05:53:51 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2c008042211so9525011fa.2; 
 Thu, 05 Oct 2023 02:53:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696499627; x=1697104427;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:dkim-signature:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XYdM1jYF/zEpUfpPfr6NpWYzcbKmGrsScXf922GXC0I=;
 b=XPoj4MAivk76QDvU4L4uEX6M3ubJUgGEBv0WGfpLnJWpPYrm0ufqE4FWj572QMiUV+
 400BMQQ+q+eAnWv0k6qudjJhZTABCs2NyxofmiQ2pS2VARvOrx9pEu8iDMpthlyd2BPo
 Kgi7N60agke2hR/oIvo5pkwrHY31ecytG/pptKVO97qIMh+vECqp+KHIMULe4u3/SorE
 ZxN+n9hUtS1oRQqa05hCSD6x20DuTg8C5uEwgb+jeHZWNRLTRFit7aDh+X7RTRA5pZSs
 OPTzoPb7yTO2rEvMJ8dNlLRYgeiHdTHmTGOAZ48Z0MuGnQHcjriZwFFZuZijiSPVnSBo
 93yg==
X-Gm-Message-State: AOJu0YyHZ9C0uWRcv76Ba6r+dz6jlh00wwutDyHcPPxP6mGTOC4i84ie
 mr4AVwPQLmZVAFWhtaQt5QmyneB4ZbSyvg==
X-Google-Smtp-Source: AGHT+IGUXQiyA/Pvu65l+eEJxcB3XJmx3Z9htruh/+L9t97SpR0Kn6522mn9tiTuFl6n9xDPwljsoQ==
X-Received: by 2002:a2e:b005:0:b0:2bc:b29e:8ff7 with SMTP id
 y5-20020a2eb005000000b002bcb29e8ff7mr4515502ljk.20.1696499626577; 
 Thu, 05 Oct 2023 02:53:46 -0700 (PDT)
Received: from flawful.org (c-f5f0e255.011-101-6d6c6d3.bbcust.telenor.se.
 [85.226.240.245]) by smtp.gmail.com with ESMTPSA id
 n16-20020a2eb790000000b002b736576a10sm231887ljo.137.2023.10.05.02.53.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Oct 2023 02:53:46 -0700 (PDT)
Received: by flawful.org (Postfix, from userid 112)
 id 75E38B825; Thu,  5 Oct 2023 11:53:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
 t=1696499625; bh=sckq77aRXO98P+R2IilWFCQxE9IIMhum/P/8l/R/AJU=;
 h=From:To:Cc:Subject:Date:From;
 b=ZZ6YUm0yVwkmoHwHVzATZGViL3uhr3wimrGKa+wNuxAP8gblIk6JsvoEgm83/SC8Q
 jjtMxvxwBvo3I59oVhIPdWd7Sd+YP5wc87lBdIE/jUStj+O45eIKwMQp8q+cJpBVRc
 5swdhTQmJRU3eED1zzaC++yCZHxeEQJ5T0yz0Sz0=
Received: from x1-carbon.lan (OpenWrt.lan [192.168.1.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by flawful.org (Postfix) with ESMTPSA id 2E6733EEC;
 Thu,  5 Oct 2023 11:53:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
 t=1696499608; bh=sckq77aRXO98P+R2IilWFCQxE9IIMhum/P/8l/R/AJU=;
 h=From:To:Cc:Subject:Date:From;
 b=kZq0DIKMZoJcms2DyNBFLjBg/buQVGHwcXquyxyPzsBdktgY2OsgJgB6ir7RnQm8w
 RXQ1fPkcSegYZLjNG4XGp0inWgCYJyB05SNmZ3mdm7WdxUWH/hI4KKc9mHscs2OkiK
 At3/hz38ubkBWxEgShCMC1QLI5Jf2T58PXfWXPiU=
From: Niklas Cassel <nks@flawful.org>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Damien Le Moal <dlemoal@kernel.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Niklas Cassel <niklas.cassel@wdc.com>
Subject: [PATCH] hw/ide/ahci: fix legacy software reset
Date: Thu,  5 Oct 2023 11:53:21 +0200
Message-ID: <20231005095322.1133817-1-nks@flawful.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=nks.gnu@gmail.com; helo=mail-lj1-x232.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
receiving an arbitrary FIS).

However, simply clearing PxCI after a non-NCQ, or NCQ command, is not
enough, we also need to clear PxCI when receiving a SRST in the Device
Control register.

This fixes an issue for FreeBSD where the device would fail to reset.
The problem was not noticed in Linux, because Linux uses a COMRESET
instead of a legacy software reset by default.

Fixes: e2a5d9b3d9c3 ("hw/ide/ahci: simplify and document PxCI handling")
Reported-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 hw/ide/ahci.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index babdd7b458..3a8b97c325 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -1254,10 +1254,26 @@ static void handle_reg_h2d_fis(AHCIState *s, int port,
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
+                 * sequence, the device will send a D2H FIS. See SATA 3.5a Gold,
+                 * section 11.4 Software reset protocol.
+                 */
+                ahci_write_fis_d2h(ad, false);
+                ahci_clear_cmd_issue(ad, slot);
                 ahci_reset_port(s, port);
             }
             break;
-- 
2.41.0


