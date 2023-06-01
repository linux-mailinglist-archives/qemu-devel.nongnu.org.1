Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F021719EBC
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 15:47:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4idf-0000CH-0Y; Thu, 01 Jun 2023 09:46:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nks.gnu@gmail.com>)
 id 1q4icp-0008W0-VQ; Thu, 01 Jun 2023 09:46:00 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nks.gnu@gmail.com>)
 id 1q4ico-0008Fy-6S; Thu, 01 Jun 2023 09:45:59 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-4f4e71a09a7so1191129e87.1; 
 Thu, 01 Jun 2023 06:45:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685627156; x=1688219156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=stzNPKEEsb93NVPera4GoUbdc/j/tKWSRzl0WF+RC+A=;
 b=i7Wo51JZYFabcx0SsYO77405OI/bQ0OjiFSXsmKujfsqtmNJxAUw6hqcqvW3V8ghM5
 45z8chTK8a5ghzPXFLaK5o/ZgmkEEmpea8P1OUjCK2047m7K3LvD1YQUoMb38Q54xEP4
 qce1N+fMYOWS2UOoXRKMcjEi3gwwWlzFg8kNzu3jWAaVBb/Zt1mqO2lkHmIP2dnO7sbH
 40WbEA+Dx1uDZF+G3NuIwV1ObrCLXwWKJ/OAmD7MEwBIFoFAKrfTCX2BMcZ4w7lLUhsJ
 FHEaf9PacpDOo6tqZdWGD4b7azJZc4UF72xNI30J4aLlXOW3MeThGBQ9FP+3lviQdv3T
 Ej/w==
X-Gm-Message-State: AC+VfDxxCCN5wTjlkD6k/O1PNCk/DdlcCWxhVl4zB5wITVUitggcRkXU
 Yswf4UnFACv3OPxPi6hPq4UcusxnDgAgQrb0
X-Google-Smtp-Source: ACHHUZ6x/DoFfqzZgRyN0Bg9Wz6BmWELEci+CgUlzS6sYUPVr8GgNaJEAtBxciQmGu/ylcpJLCsDZw==
X-Received: by 2002:ac2:4c35:0:b0:4f4:b38c:1f87 with SMTP id
 u21-20020ac24c35000000b004f4b38c1f87mr610556lfq.12.1685627155767; 
 Thu, 01 Jun 2023 06:45:55 -0700 (PDT)
Received: from flawful.org (c-fcf6e255.011-101-6d6c6d3.bbcust.telenor.se.
 [85.226.246.252]) by smtp.gmail.com with ESMTPSA id
 q24-20020a19a418000000b004f388c5f25dsm1089869lfc.257.2023.06.01.06.45.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 06:45:55 -0700 (PDT)
Received: by flawful.org (Postfix, from userid 112)
 id AA09550A; Thu,  1 Jun 2023 15:45:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
 t=1685627154; bh=Q3Hm6FMI2aGPQjjUBTN4kaiW9jrcrf+oWe6LEXPzIxY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=omiLWQKK3Kmdm283EFQTYENys7gXUQZaSMIdJ/ZMTvWBSkNJnAPp2oO3d5/VPC00s
 rHUNh1tnZb4bynnHp9bwQQqenXI8bZdb/XwgNc1U5NZ0z/UvOAQVJCxuHSCO5AJCe3
 6C6zl6vyDuG5raNidMU2aOSXSdAjnd7cYCg2FEFA=
Received: from x1-carbon.lan (unknown [129.253.182.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by flawful.org (Postfix) with ESMTPSA id 3743A18B;
 Thu,  1 Jun 2023 15:45:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
 t=1685627128; bh=Q3Hm6FMI2aGPQjjUBTN4kaiW9jrcrf+oWe6LEXPzIxY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=UblLAnNZLBn4xhY9IkVZwuPUHNuCUhZP5mWL4ifl9IKCn1lwtvkCrNbNQbSGNs5/W
 Z8N+S7Pw+cfcWzjicTK4DFg4NsKt3Nb+feLQvNTlY67Jv4czkiyoGnOZ28zaBmXFkC
 3OxsqeHF5qvY3K6zUn9CN+x7ovq/5GWXPnLjhNfg=
From: Niklas Cassel <nks@flawful.org>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <niklas.cassel@wdc.com>
Subject: [PATCH v2 3/8] hw/ide/ahci: write D2H FIS on when processing NCQ
 command
Date: Thu,  1 Jun 2023 15:44:29 +0200
Message-Id: <20230601134434.519805-4-nks@flawful.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601134434.519805-1-nks@flawful.org>
References: <20230601134434.519805-1-nks@flawful.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=nks.gnu@gmail.com; helo=mail-lf1-x131.google.com
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
---
 hw/ide/ahci.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 48d550f633..4b272397fd 100644
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
         ad->check_bh = qemu_bh_new_guarded(ahci_check_cmd_bh, ad,
-- 
2.40.1


