Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 394E8728383
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 17:17:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7HO4-0001fX-7Y; Thu, 08 Jun 2023 11:17:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nks.gnu@gmail.com>)
 id 1q7HNo-0001D6-ER; Thu, 08 Jun 2023 11:17:04 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nks.gnu@gmail.com>)
 id 1q7HNk-0000RN-Ro; Thu, 08 Jun 2023 11:17:03 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-4f61d79b0f2so908902e87.3; 
 Thu, 08 Jun 2023 08:16:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686237415; x=1688829415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4wsnlAkJObVDEQrtDWr3eBzH6P5Qhy1QwLNGwN1nHhc=;
 b=dNuIFWS2SK4GoaMuNdHVBZEzg2B2CeICTLNv68NbwHjrU4eza7zQvvTsJCRC6DM9Xu
 5eRpsAq76+l+/ybmAJ4DQ0EW0iK8JCvyY27jaVmeiwK+d6C5n3ZrmjQrolKhIJkPw+Di
 ACadLU2NisM8M/DyZFhua9hTHBwq5IJ1vXTBsjl0MJXtIgn1NkW2O6c4ef67Rh3OBPTq
 LPt0G5NVEUZdJQB2o+o1sz5+COmX/rxEBeqtCDjw6hLipCkaKdMLETr3wrNX2ojLNOJ4
 KfmHPh9QPck0gffDv3LAzRci3P93a57roCW0e1GP538OdxfZxHP3Lyd0CA/IdShxUQpl
 disQ==
X-Gm-Message-State: AC+VfDy2j5LJWHMXfgEeUQU51r9XUpU1MzGnN2riEYP1oxRMXlXj3JHK
 lc4daRPyIr+iWVdYwQgIqLpRABpPkpXP6E2VkIs=
X-Google-Smtp-Source: ACHHUZ7hxAUlfl/74vaC9daxciR+5Dp/D27YXP3q1ptftfeWKxuzGZwmxNxh2CupjOCsF7/1aN/nMQ==
X-Received: by 2002:ac2:43c8:0:b0:4f4:2b83:f4a3 with SMTP id
 u8-20020ac243c8000000b004f42b83f4a3mr3164896lfl.51.1686237414948; 
 Thu, 08 Jun 2023 08:16:54 -0700 (PDT)
Received: from flawful.org (c-f5f0e255.011-101-6d6c6d3.bbcust.telenor.se.
 [85.226.240.245]) by smtp.gmail.com with ESMTPSA id
 d15-20020ac2544f000000b004f62771eed4sm214000lfn.300.2023.06.08.08.16.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 08:16:54 -0700 (PDT)
Received: by flawful.org (Postfix, from userid 112)
 id C430012F3; Thu,  8 Jun 2023 17:16:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
 t=1686237413; bh=Cmjam1Ms+un7s+nyCpGIwgVVjGdS79mfE/ZWH8XfDV8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=KTKhx16JGZc6+paU+qUzQvYNybdkgxM1JJF20y4yTKYOsfB5LJsVDZsPFxmzBi5KE
 j8S2GXizFYkhi4xy8jVa0JC/DOltPIhllwvSmmV+XALShJNUSouHTHZJZbquv7ZEDk
 9YiQ7KWY5byPGHZEaQaN5Zq39ODBMMo9pXzK/G7E=
Received: from x1-carbon.wireless.wdc (unknown [129.253.182.60])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by flawful.org (Postfix) with ESMTPSA id 01F1612C6;
 Thu,  8 Jun 2023 17:16:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
 t=1686237371; bh=Cmjam1Ms+un7s+nyCpGIwgVVjGdS79mfE/ZWH8XfDV8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=t8SF7EocoNdNU3+8/uQ3/feCn4cwYITSXtGn3V28j5GPRRTs4CChwigOOy24pOlrG
 CTcoVf4Rn8kK6GkFBcHe0adtZ2coXtb8bJJs4Fltt0nIW+K6hvvQ4qIZD+SQfcHhER
 10DetK93ajud+omBOrd/CiQXNSHTvx1xbPYQ3btg=
From: Niklas Cassel <nks@flawful.org>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <niklas.cassel@wdc.com>
Subject: [PATCH 5/5] libqos/ahci: perform mandatory error recovery on error
Date: Thu,  8 Jun 2023 17:15:28 +0200
Message-Id: <20230608151528.143950-6-nks@flawful.org>
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

When the HBA encouters an error, the host has to perform error recovery,
see AHCI 1.3.1 section 6.2.2.1, in order to be able issue new commands.
If we don't do this, all the commands that we queue will get aborted.

Some tests, e.g. test_atapi_tray() call ahci_atapi_test_ready() with
ready == false, intentionally sending a command that will cause an error.

After test_atapi_tray() has called ahci_atapi_test_ready(), it directly
calls ahci_atapi_get_sense() to send a REQUEST SENSE command.

If we don't perform error recovery, the REQUEST SENSE command will get
aborted, and will not return the sense data that the test case expects.

Since the error recovery will clear PxCI, we also need to move the
ahci_port_check_nonbusy() call to before the error handling takes place.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 tests/qtest/libqos/ahci.c | 44 +++++++++++++++++++++++++++++++++------
 tests/qtest/libqos/ahci.h |  3 +--
 2 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/tests/qtest/libqos/ahci.c b/tests/qtest/libqos/ahci.c
index b216f61f14..a2c94c6e06 100644
--- a/tests/qtest/libqos/ahci.c
+++ b/tests/qtest/libqos/ahci.c
@@ -425,6 +425,31 @@ void ahci_port_check_error(AHCIQState *ahci, AHCICommand *cmd)
     reg = ahci_px_rreg(ahci, port, AHCI_PX_SERR);
     g_assert_cmphex(reg, ==, 0);
 
+    /* If expecting TF error, and TFES was set, perform error recovery
+     * (see AHCI 1.3 section 6.2.2.1) such that we can send new commands. */
+    if (cmd->errors) {
+        /* This will clear PxCI. */
+        ahci_px_clr(ahci, port, AHCI_PX_CMD, AHCI_PX_CMD_ST);
+
+        /* The port has 500ms to disengage. */
+        usleep(500000);
+        reg = ahci_px_rreg(ahci, port, AHCI_PX_CMD);
+        ASSERT_BIT_CLEAR(reg, AHCI_PX_CMD_CR);
+
+        /* Clear PxIS. */
+        reg = ahci_px_rreg(ahci, port, AHCI_PX_IS);
+        ahci_px_wreg(ahci, port, AHCI_PX_IS, reg);
+
+        /* Check if we need to perform a COMRESET.
+         * Not implemented right now, as there is no reason why our QEMU model
+         * should need a COMRESET when expecting TF error. */
+        reg = ahci_px_rreg(ahci, port, AHCI_PX_TFD);
+        ASSERT_BIT_CLEAR(reg, AHCI_PX_TFD_STS_BSY | AHCI_PX_TFD_STS_DRQ);
+
+        /* Enable issuing new commands. */
+        ahci_px_set(ahci, port, AHCI_PX_CMD, AHCI_PX_CMD_ST);
+    }
+
     /* The TFD also has two error sections. */
     reg = ahci_px_rreg(ahci, port, AHCI_PX_TFD);
     if (!cmd->errors) {
@@ -436,17 +461,24 @@ void ahci_port_check_error(AHCIQState *ahci, AHCICommand *cmd)
     ASSERT_BIT_SET(reg, AHCI_PX_TFD_ERR & (cmd->errors << 8));
 }
 
-void ahci_port_check_interrupts(AHCIQState *ahci, uint8_t port,
-                                uint32_t intr_mask)
+void ahci_port_check_interrupts(AHCIQState *ahci, AHCICommand *cmd)
 {
+    uint8_t port = cmd->port;
     uint32_t reg;
 
+    /* If we expect errors, error handling in ahci_port_check_error() will
+     * already have cleared PxIS, so in that case this function cannot verify
+     * and clear expected interrupts. */
+    if (cmd->errors) {
+        return;
+    }
+
     /* Check for expected interrupts */
     reg = ahci_px_rreg(ahci, port, AHCI_PX_IS);
-    ASSERT_BIT_SET(reg, intr_mask);
+    ASSERT_BIT_SET(reg, cmd->interrupts);
 
     /* Clear expected interrupts and assert all interrupts now cleared. */
-    ahci_px_wreg(ahci, port, AHCI_PX_IS, intr_mask);
+    ahci_px_wreg(ahci, port, AHCI_PX_IS, cmd->interrupts);
     g_assert_cmphex(ahci_px_rreg(ahci, port, AHCI_PX_IS), ==, 0);
 }
 
@@ -1248,9 +1280,9 @@ void ahci_command_verify(AHCIQState *ahci, AHCICommand *cmd)
     uint8_t slot = cmd->slot;
     uint8_t port = cmd->port;
 
-    ahci_port_check_error(ahci, cmd);
-    ahci_port_check_interrupts(ahci, port, cmd->interrupts);
     ahci_port_check_nonbusy(ahci, cmd);
+    ahci_port_check_error(ahci, cmd);
+    ahci_port_check_interrupts(ahci, cmd);
     ahci_port_check_cmd_sanity(ahci, cmd);
     if (cmd->interrupts & AHCI_PX_IS_DHRS) {
         ahci_port_check_d2h_sanity(ahci, port, slot);
diff --git a/tests/qtest/libqos/ahci.h b/tests/qtest/libqos/ahci.h
index 137858d79c..48017864bf 100644
--- a/tests/qtest/libqos/ahci.h
+++ b/tests/qtest/libqos/ahci.h
@@ -591,8 +591,7 @@ void ahci_destroy_command(AHCIQState *ahci, uint8_t port, uint8_t slot);
 
 /* AHCI sanity check routines */
 void ahci_port_check_error(AHCIQState *ahci, AHCICommand *cmd);
-void ahci_port_check_interrupts(AHCIQState *ahci, uint8_t port,
-                                uint32_t intr_mask);
+void ahci_port_check_interrupts(AHCIQState *ahci, AHCICommand *cmd);
 void ahci_port_check_nonbusy(AHCIQState *ahci, AHCICommand *cmd);
 void ahci_port_check_d2h_sanity(AHCIQState *ahci, uint8_t port, uint8_t slot);
 void ahci_port_check_pio_sanity(AHCIQState *ahci, AHCICommand *cmd);
-- 
2.40.1


