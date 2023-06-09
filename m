Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF755729F70
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 17:59:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7cpM-0003K2-Lo; Fri, 09 Jun 2023 10:10:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nks.gnu@gmail.com>)
 id 1q7coo-00038q-2s; Fri, 09 Jun 2023 10:10:22 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nks.gnu@gmail.com>)
 id 1q7col-0000aL-Ev; Fri, 09 Jun 2023 10:10:21 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2b1ba50e50bso19854951fa.1; 
 Fri, 09 Jun 2023 07:10:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686319813; x=1688911813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=stzNPKEEsb93NVPera4GoUbdc/j/tKWSRzl0WF+RC+A=;
 b=bx8cRmlv4HXlRN+DmvN8vZrQbA5gSQDVwhIcffcMgdjYA9LpNRsjKO/TlmGEEJi4o9
 QsilLDKD0YtU8p/XHIVK5reiiPG8nbrd0kyDMzzLRXhdMVz++4scrnHSAUJaLMYuc+pb
 aU74RR/bAJPeFGi4HElQ0rGqAKiCgv+CFgm1PFO5IddL6GYvMCTXWFZqYYbvmxjjAyCe
 NZDyymJkF/NyYz/6YoknvxgO1lU6/QczgMLzl+L0tOoX/CXBgmHRFtLu10d9hwasIDOM
 xseQ6AwhhWzZxav1kJhJYWGzF8/PQe5BviI9prWnXFWlMWtlxQAaEmkn9pLfSr2gtP4K
 ToKw==
X-Gm-Message-State: AC+VfDxE+H2lNgV6JGzwGfX2Fjpfck1kwPXUgqH/BbpB9EH4lMaVuC5o
 Ksx6+9SrKsd3ugtsa/qlLVGJAk2rSJ46zXRU
X-Google-Smtp-Source: ACHHUZ7I6+Zf0eUm0HognUYaLA5agLVQbxST4vcdZZ68xl/3djLVsGVizE2VpapVmPZA2Mu/P86YKg==
X-Received: by 2002:a2e:87d6:0:b0:2b1:b4e9:4c3 with SMTP id
 v22-20020a2e87d6000000b002b1b4e904c3mr1322862ljj.2.1686319813495; 
 Fri, 09 Jun 2023 07:10:13 -0700 (PDT)
Received: from flawful.org (c-f5f0e255.011-101-6d6c6d3.bbcust.telenor.se.
 [85.226.240.245]) by smtp.gmail.com with ESMTPSA id
 m23-20020a2e97d7000000b002ac7b0fc473sm407006ljj.38.2023.06.09.07.10.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jun 2023 07:10:13 -0700 (PDT)
Received: by flawful.org (Postfix, from userid 112)
 id 9581C1763; Fri,  9 Jun 2023 16:10:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
 t=1686319811; bh=Q3Hm6FMI2aGPQjjUBTN4kaiW9jrcrf+oWe6LEXPzIxY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=iPFhBknqtd+FJwpeyCY9noCxUnXohTgv0H3g5a6ykV4gBPhra5ZSpAoKs4YYddUsL
 Z4M5YE91ijGwk6RqIUaSizBtoXa762aSNU7itKR48BJSz/EGO+so203Vja5GRIDolq
 DvZIftuZIv/vOrZ+7GwwiQXplQJFGWEhxD9atQ+I=
Received: from x1-carbon.lan (unknown [129.253.182.58])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by flawful.org (Postfix) with ESMTPSA id E334517AD;
 Fri,  9 Jun 2023 16:09:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
 t=1686319759; bh=Q3Hm6FMI2aGPQjjUBTN4kaiW9jrcrf+oWe6LEXPzIxY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NETuw3C2fb1f0lIBRRbAh+pToHTbQx4GpC5Pl0u4S0iDv9hgPgbS9O9HFpud9xlNP
 qYnx+zoLJqT7YDDv/g0KhWghqBMyuvZi24zDg0CGkEboxydgZH98fEA2rUwWRLfG6J
 Oj4Ti+BMk2yyCnHPmU+GV2pbdjz90cdbBYWNF9tM=
From: Niklas Cassel <nks@flawful.org>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <niklas.cassel@wdc.com>
Subject: [PATCH v3 3/8] hw/ide/ahci: write D2H FIS when processing NCQ command
Date: Fri,  9 Jun 2023 16:08:39 +0200
Message-Id: <20230609140844.202795-4-nks@flawful.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230609140844.202795-1-nks@flawful.org>
References: <20230609140844.202795-1-nks@flawful.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=nks.gnu@gmail.com; helo=mail-lj1-x231.google.com
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


