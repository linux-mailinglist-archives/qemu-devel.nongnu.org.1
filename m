Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 515CE728381
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 17:17:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7HNN-0000XB-Ls; Thu, 08 Jun 2023 11:16:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nks.gnu@gmail.com>)
 id 1q7HNH-0000HZ-B6; Thu, 08 Jun 2023 11:16:31 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nks.gnu@gmail.com>)
 id 1q7HNE-0000M0-Uu; Thu, 08 Jun 2023 11:16:31 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-4f655293a38so463078e87.0; 
 Thu, 08 Jun 2023 08:16:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686237386; x=1688829386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=He8QmAL+E++VH1Chy1HIq2VBq+sk2uzk9Ae+qKD9BC0=;
 b=JKi8dle/oC0NiFauWdVVb3SxR/8SiACVNSqkGBG2URt/If6l42R/HRyYnRY6nMQPSl
 Ke+R6SMlhOqbnu+UA4aCQ5qxg6Kp6pvR8wDwlRuWkvg+myTdxikno332mbuec/VP3tZS
 3+fxrLEDAA5sPI1Hscyak1Yi8tIdJWLFhxaGZFDKUD6R6J3fDHU87WbWTWIPV+XjLMYK
 BOjGFlSkDdYRJTI2VaoIviNSvI35pBAIjUEVU6YU3eLX5TeOqKAq84mTK+zYTWLY9iyu
 NiumQiL3bn0MBYifd0yeORoNFjD3oPu3vXQ5Uk0skWEgPPRNCiRCSHZ4J8i4Wzo0PBOy
 wflA==
X-Gm-Message-State: AC+VfDyMWTfYf8pSJk4mGCCPaIUDiETHjtLPKB2hkM777uwL8PVS4pXp
 CsIrdF5XcXd7wpZeO4CGgBylPgPF9wEaPGbDjd0=
X-Google-Smtp-Source: ACHHUZ76jnA3JRAkUjMRqvDndmC4MAtHNlN1gu2jR6azvlIQ4+S5W881+V4XsIMhCoj94aydXUxOAg==
X-Received: by 2002:ac2:43d6:0:b0:4e9:59cd:416c with SMTP id
 u22-20020ac243d6000000b004e959cd416cmr3332465lfl.0.1686237386569; 
 Thu, 08 Jun 2023 08:16:26 -0700 (PDT)
Received: from flawful.org (c-f5f0e255.011-101-6d6c6d3.bbcust.telenor.se.
 [85.226.240.245]) by smtp.gmail.com with ESMTPSA id
 d19-20020ac244d3000000b004f37b88eacfsm217043lfm.187.2023.06.08.08.16.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 08:16:26 -0700 (PDT)
Received: by flawful.org (Postfix, from userid 112)
 id 40BED148C; Thu,  8 Jun 2023 17:16:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
 t=1686237385; bh=a5SkxRTfz+p1TvOllAPLUVa9px3KY3l+AXj78TtaLFE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ixSXKW96olrnQ6/8QmhFMT5kkcFvGrFD2bFDxOMBiMoF90GcYESAcnaOceGznCDe3
 6Pt6oTyr+N+6hLsLYEWl3x58Gz7v6TrxwSCrArSanCZzckz5E8JihPMvSWqdKaJUn/
 WSOv0YkiXtyH2RtVpcEEvpRNVxxOFYUDaIESXEQQ=
Received: from x1-carbon.wireless.wdc (unknown [129.253.182.60])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by flawful.org (Postfix) with ESMTPSA id EAFF212FF;
 Thu,  8 Jun 2023 17:15:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
 t=1686237358; bh=a5SkxRTfz+p1TvOllAPLUVa9px3KY3l+AXj78TtaLFE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XyeTqJpRgCECiEMYrDfi+nGAOEO6RM1Gto3vr1gUH+DsODFDzB7a2Yu/FznEKFx+W
 8/A8YIxUMh4YdXiHCgaNSK15BrVw5IozXeSO8gA1HUCcLOvRNwuQr4of5S85s7CjP+
 +Lyy8zxxX9FMe/zNBU1spp8tMc0bxbURwfhFFwJo=
From: Niklas Cassel <nks@flawful.org>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <niklas.cassel@wdc.com>
Subject: [PATCH 3/5] libqos/ahci: simplify ahci_port_check_error()
Date: Thu,  8 Jun 2023 17:15:26 +0200
Message-Id: <20230608151528.143950-4-nks@flawful.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230608151528.143950-1-nks@flawful.org>
References: <20230608151528.143950-1-nks@flawful.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=nks.gnu@gmail.com; helo=mail-lf1-x131.google.com
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

Modify ahci_port_check_error() to simply take a struct AHCICommand.
This way, the conditionals are in line which the existing code,
e.g. ahci_port_check_nonbusy(), which checks for cmd->errors.

This makes the code easier to reason with, we don't want to use
cmd->errors in some functions and emask in some functions.

No functional changes intended.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 tests/qtest/libqos/ahci.c | 14 +++++++-------
 tests/qtest/libqos/ahci.h |  3 +--
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/tests/qtest/libqos/ahci.c b/tests/qtest/libqos/ahci.c
index 2d4981dae4..644ed7e79f 100644
--- a/tests/qtest/libqos/ahci.c
+++ b/tests/qtest/libqos/ahci.c
@@ -404,14 +404,14 @@ void ahci_port_clear(AHCIQState *ahci, uint8_t port)
 /**
  * Check a port for errors.
  */
-void ahci_port_check_error(AHCIQState *ahci, uint8_t port,
-                           uint32_t imask, uint8_t emask)
+void ahci_port_check_error(AHCIQState *ahci, AHCICommand *cmd)
 {
+    uint8_t port = cmd->port;
     uint32_t reg;
 
     /* The upper 9 bits of the IS register all indicate errors. */
     reg = ahci_px_rreg(ahci, port, AHCI_PX_IS);
-    reg &= ~imask;
+    reg &= ~cmd->interrupts;
     reg >>= 23;
     g_assert_cmphex(reg, ==, 0);
 
@@ -421,13 +421,13 @@ void ahci_port_check_error(AHCIQState *ahci, uint8_t port,
 
     /* The TFD also has two error sections. */
     reg = ahci_px_rreg(ahci, port, AHCI_PX_TFD);
-    if (!emask) {
+    if (!cmd->errors) {
         ASSERT_BIT_CLEAR(reg, AHCI_PX_TFD_STS_ERR);
     } else {
         ASSERT_BIT_SET(reg, AHCI_PX_TFD_STS_ERR);
     }
-    ASSERT_BIT_CLEAR(reg, AHCI_PX_TFD_ERR & (~emask << 8));
-    ASSERT_BIT_SET(reg, AHCI_PX_TFD_ERR & (emask << 8));
+    ASSERT_BIT_CLEAR(reg, AHCI_PX_TFD_ERR & (~cmd->errors << 8));
+    ASSERT_BIT_SET(reg, AHCI_PX_TFD_ERR & (cmd->errors << 8));
 }
 
 void ahci_port_check_interrupts(AHCIQState *ahci, uint8_t port,
@@ -1242,7 +1242,7 @@ void ahci_command_verify(AHCIQState *ahci, AHCICommand *cmd)
     uint8_t slot = cmd->slot;
     uint8_t port = cmd->port;
 
-    ahci_port_check_error(ahci, port, cmd->interrupts, cmd->errors);
+    ahci_port_check_error(ahci, cmd);
     ahci_port_check_interrupts(ahci, port, cmd->interrupts);
     ahci_port_check_nonbusy(ahci, cmd);
     ahci_port_check_cmd_sanity(ahci, cmd);
diff --git a/tests/qtest/libqos/ahci.h b/tests/qtest/libqos/ahci.h
index 2234f46862..137858d79c 100644
--- a/tests/qtest/libqos/ahci.h
+++ b/tests/qtest/libqos/ahci.h
@@ -590,8 +590,7 @@ void ahci_set_command_header(AHCIQState *ahci, uint8_t port,
 void ahci_destroy_command(AHCIQState *ahci, uint8_t port, uint8_t slot);
 
 /* AHCI sanity check routines */
-void ahci_port_check_error(AHCIQState *ahci, uint8_t port,
-                           uint32_t imask, uint8_t emask);
+void ahci_port_check_error(AHCIQState *ahci, AHCICommand *cmd);
 void ahci_port_check_interrupts(AHCIQState *ahci, uint8_t port,
                                 uint32_t intr_mask);
 void ahci_port_check_nonbusy(AHCIQState *ahci, AHCICommand *cmd);
-- 
2.40.1


