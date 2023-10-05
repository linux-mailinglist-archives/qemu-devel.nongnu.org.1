Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B65767B9C67
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 12:06:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoLEA-0004uC-8p; Thu, 05 Oct 2023 06:05:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nks.gnu@gmail.com>)
 id 1qoLE6-0004ta-Mo; Thu, 05 Oct 2023 06:05:02 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nks.gnu@gmail.com>)
 id 1qoLDr-00074D-QS; Thu, 05 Oct 2023 06:05:02 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-50305abe5f0so1026734e87.2; 
 Thu, 05 Oct 2023 03:04:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696500284; x=1697105084;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:dkim-signature:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fzxhQFr0lyOZPYfoaCWcAHMkrVCkPctHzsLj+f/d9PM=;
 b=iDnCoceFUBcdAEl35UHmQNVs3+g7N76dueX2Px8j8d67YXnEJYU886blRKr9ZZJqlg
 Sy9qyUS+emjWltuffG8p+4W47HrHz43o3F4jkKLlhCwXioF1moEN1dwdHVG8+C2zdLiy
 3zkAs25NSorjnupnJQzj4B+91A0fyUSxSxk3X+bLahu8DRTFRR2DEXOcj+Wd3MpAwJ7N
 oIkZx8tilJVBgaQ1+nN6DAlQxoTjl9mKbbGGstJrNCa6OtHBHv1Rp5ON5ZYHRs6S5V46
 HXAlYQx7hRqCY/kTbxq4v/wcKfjuK4Tie/rcRoVieJyvF93GF0fREFzumTqisddwMWqU
 X4fg==
X-Gm-Message-State: AOJu0Yy+65zerYMj+44Z939EDFzZRvoqQgp21vwvdhdPCWhU+v+vfEK5
 I9oWxJjfqNYKELnkc9fCPHadSShn6uWquw==
X-Google-Smtp-Source: AGHT+IGSDflnGP0nomMkmeFz4iisfFN/0q6qnKVLObd81ffqPObRvNU+0Otv5inOZT6d8glsSa3aBg==
X-Received: by 2002:a05:6512:10c9:b0:504:3807:22a4 with SMTP id
 k9-20020a05651210c900b00504380722a4mr5280238lfg.23.1696500284464; 
 Thu, 05 Oct 2023 03:04:44 -0700 (PDT)
Received: from flawful.org (c-f5f0e255.011-101-6d6c6d3.bbcust.telenor.se.
 [85.226.240.245]) by smtp.gmail.com with ESMTPSA id
 q2-20020ac25102000000b00500a4679148sm235154lfb.20.2023.10.05.03.04.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Oct 2023 03:04:44 -0700 (PDT)
Received: by flawful.org (Postfix, from userid 112)
 id 4FC80B825; Thu,  5 Oct 2023 12:04:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
 t=1696500283; bh=rILs7CcOSgKih8VobjLFN3rA4GjJ2f5YTx7ZWKAgRQU=;
 h=From:To:Cc:Subject:Date:From;
 b=QVG7DufkJJHol8mlGXm7ovi2PLu1uEa4I/DS5jLwJxQPGjUnSvU6O/vuH7r9ToQ4N
 GcwKBjSSOTFVXPX8xakXJjWq6wGSNLyPQynvkiVtiRbqLGTVHB9wKMau5eZr4fseXe
 AmwO7pBEsYMVyVTRDoQKSieg19U0+4akOSIm4MhQ=
Received: from x1-carbon.lan (OpenWrt.lan [192.168.1.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by flawful.org (Postfix) with ESMTPSA id F2D213EEC;
 Thu,  5 Oct 2023 12:04:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
 t=1696500265; bh=rILs7CcOSgKih8VobjLFN3rA4GjJ2f5YTx7ZWKAgRQU=;
 h=From:To:Cc:Subject:Date:From;
 b=KbjQx1bW4zcEvW49+fGQhRPpbYKLrSvoMU/tZZatJ6ictpXKGTgcRVq5M5fOA6pnb
 k/IoMVGZffqBocb0Ssbu2xWD1um3d7j0wDeqnSRwBb0JuvkvGXN0Kctq1MyfNCbyZ4
 RbrhNtK2jOucSDkACD/KLZ9K2wpRmLM3lI6CHrc4=
From: Niklas Cassel <nks@flawful.org>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Damien Le Moal <dlemoal@kernel.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Niklas Cassel <niklas.cassel@wdc.com>
Subject: [PATCH v2] hw/ide/ahci: fix legacy software reset
Date: Thu,  5 Oct 2023 12:04:07 +0200
Message-ID: <20231005100407.1136484-1-nks@flawful.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=nks.gnu@gmail.com; helo=mail-lf1-x12f.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_NONE=0.001,
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
Changes since v1: write the D2H FIS before clearing PxCI.

 hw/ide/ahci.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index babdd7b458..7269dabbdb 100644
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
+                ahci_clear_cmd_issue(ad, slot);
+                ahci_write_fis_d2h(ad, false);
                 ahci_reset_port(s, port);
             }
             break;
-- 
2.41.0


