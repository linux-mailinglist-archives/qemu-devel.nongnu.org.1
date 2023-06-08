Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 001D1728374
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 17:16:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7HNL-0000Sj-Oi; Thu, 08 Jun 2023 11:16:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nks.gnu@gmail.com>)
 id 1q7HNG-0000HG-56; Thu, 08 Jun 2023 11:16:31 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nks.gnu@gmail.com>)
 id 1q7HNE-0000Lt-DS; Thu, 08 Jun 2023 11:16:29 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-4f62d93f38aso914422e87.0; 
 Thu, 08 Jun 2023 08:16:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686237386; x=1688829386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oyd1ZZA7m/AHJ3cyF1hjSoNsM5QHw15/nooY2h1ILic=;
 b=TRg9DtfoV2wJHE8+QuhW3sFviyrhOqSZcXiNiDlf6mi6U3ewFR7EMwLTvUl84jND0p
 3YJmjo45hVdJ7kDZQcA7HnBPceWjF40e0divB79TM+UQxIrEoBKn1cw6VJwpX7Zy4dKk
 1BFBgRml+LkUpsov2JKdU8zJu6MXPLIAE40kiNiW7P3w8QNv4tsefqiSIH3TCrW5dtFV
 Rk65oEOlvZA3/OcHNZ/nu0MEtMAKMz0bWpdfNRR2F0eNjFbKby/yVezKEWOzti4M6jdy
 sTCsnpcNufq60tOFURvfJm35OP4qmRSvWgVWrEn6zBW1/3saC4fEaWph2jhqdsm52jOw
 MdDQ==
X-Gm-Message-State: AC+VfDz+BfWndxh7Qbl3FBXPjMJtvgm17VsKtt6sIpysPLxtUPtpiHDd
 tkyQfanDCtqcuIQC8nMN7egVixhNzt93tOEqOYU=
X-Google-Smtp-Source: ACHHUZ6Ztc35WuxNxYcqGpcGm5NSMKfL5yYdFMH/atz7K47wyJ2g539MsfCXxRXwoR3ur+T7UfRObw==
X-Received: by 2002:a2e:9b94:0:b0:2a8:ce32:867 with SMTP id
 z20-20020a2e9b94000000b002a8ce320867mr3547313lji.53.1686237386042; 
 Thu, 08 Jun 2023 08:16:26 -0700 (PDT)
Received: from flawful.org (c-f5f0e255.011-101-6d6c6d3.bbcust.telenor.se.
 [85.226.240.245]) by smtp.gmail.com with ESMTPSA id
 j21-20020a2e6e15000000b002b1e6a78d3esm285408ljc.82.2023.06.08.08.16.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 08:16:25 -0700 (PDT)
Received: by flawful.org (Postfix, from userid 112)
 id 3C414155F; Thu,  8 Jun 2023 17:16:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
 t=1686237384; bh=KMCa7O4aMdqxNjdQMEzjY2v/i140Djc85D2Q1z90VOw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TYCkTQFBdCL+amv5pmbtwWRCVUdrwVlUD23OMVPiOPQAcovZvffnbzLhUpeXQ98A6
 lb/dxd9Z+4oJfLdBxdvUs2+XNhlAXohTSgtMkcBZ2x3QtSWSA1Oc3gI/R0KE8H1vK+
 wc43Qk5uDDHDE0CuraBBHDbQE9sN2ODqtS+vqxzo=
Received: from x1-carbon.wireless.wdc (unknown [129.253.182.60])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by flawful.org (Postfix) with ESMTPSA id 418D1148C;
 Thu,  8 Jun 2023 17:15:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
 t=1686237352; bh=KMCa7O4aMdqxNjdQMEzjY2v/i140Djc85D2Q1z90VOw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=oTJBWr2J4y51t89tjHADpKzMr6+ws9OhNC8PJ5XL/IzTrpjpEggvEypdlpDED1rzT
 4NJe4tF1CzgN5MKcg7JceR/pw0oVadmZ22bCuzYa6anofbtJSFWpuLDu9oeDlUcVeV
 g41JAOvd3cOuy8xSzFEklLQYxEyt4IxkqsWP9O7A=
From: Niklas Cassel <nks@flawful.org>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <niklas.cassel@wdc.com>
Subject: [PATCH 2/5] libqos/ahci: fix ahci_port_check_nonbusy()
Date: Thu,  8 Jun 2023 17:15:25 +0200
Message-Id: <20230608151528.143950-3-nks@flawful.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230608151528.143950-1-nks@flawful.org>
References: <20230608151528.143950-1-nks@flawful.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=nks.gnu@gmail.com; helo=mail-lf1-x133.google.com
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

A command that has ERR_STAT set, does not get to clear PxCI.
See AHCI 1.3.1, section 5.3.8, states RegFIS:Entry and RegFIS:ClearCI,
and 5.3.16.5 ERR:FatalTaskfile.

Some tests, e.g. test_atapi_tray() call ahci_atapi_test_ready() with
ready == false, intentionally sending a command that will cause an error.

Thus, ahci_port_check_nonbusy() cannot assume that PxCI and PxSACT will
always be cleared for the executed command.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 tests/qtest/libqos/ahci.c | 27 +++++++++++++++++++++------
 tests/qtest/libqos/ahci.h |  2 +-
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/tests/qtest/libqos/ahci.c b/tests/qtest/libqos/ahci.c
index c1d571e477..2d4981dae4 100644
--- a/tests/qtest/libqos/ahci.c
+++ b/tests/qtest/libqos/ahci.c
@@ -444,17 +444,32 @@ void ahci_port_check_interrupts(AHCIQState *ahci, uint8_t port,
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
@@ -1229,7 +1244,7 @@ void ahci_command_verify(AHCIQState *ahci, AHCICommand *cmd)
 
     ahci_port_check_error(ahci, port, cmd->interrupts, cmd->errors);
     ahci_port_check_interrupts(ahci, port, cmd->interrupts);
-    ahci_port_check_nonbusy(ahci, port, slot);
+    ahci_port_check_nonbusy(ahci, cmd);
     ahci_port_check_cmd_sanity(ahci, cmd);
     if (cmd->interrupts & AHCI_PX_IS_DHRS) {
         ahci_port_check_d2h_sanity(ahci, port, slot);
diff --git a/tests/qtest/libqos/ahci.h b/tests/qtest/libqos/ahci.h
index 88835b6228..2234f46862 100644
--- a/tests/qtest/libqos/ahci.h
+++ b/tests/qtest/libqos/ahci.h
@@ -594,7 +594,7 @@ void ahci_port_check_error(AHCIQState *ahci, uint8_t port,
                            uint32_t imask, uint8_t emask);
 void ahci_port_check_interrupts(AHCIQState *ahci, uint8_t port,
                                 uint32_t intr_mask);
-void ahci_port_check_nonbusy(AHCIQState *ahci, uint8_t port, uint8_t slot);
+void ahci_port_check_nonbusy(AHCIQState *ahci, AHCICommand *cmd);
 void ahci_port_check_d2h_sanity(AHCIQState *ahci, uint8_t port, uint8_t slot);
 void ahci_port_check_pio_sanity(AHCIQState *ahci, AHCICommand *cmd);
 void ahci_port_check_cmd_sanity(AHCIQState *ahci, AHCICommand *cmd);
-- 
2.40.1


