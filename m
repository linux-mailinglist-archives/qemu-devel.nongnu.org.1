Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47485728119
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 15:19:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7FWu-0003gR-Kh; Thu, 08 Jun 2023 09:18:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lis8215@gmail.com>) id 1q7D67-0002H6-MI
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:42:31 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lis8215@gmail.com>) id 1q7D65-0006T0-7K
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:42:31 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-4f642a24555so558524e87.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 03:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686220947; x=1688812947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8VYSwYNBoGdVkr6LwKT2BwpwsiRD5YPfDCGwo+rcgl4=;
 b=KpDu6h+RjA5nQNJGG0hndawR10gfBa58ppdg0OgTKRGE4LvRL0ja1NxMpkiW9BwvEB
 zivpbxIp8DJu5RaxUrTq//pSIdpvj/cyrv8ZEJBInLEoeTzO6ypk2AP0JXNlCWs+d3Hv
 awcVj3T4VXn9EGSg7JOD4Q0fTPqe/Fy28NlPA8YFqZPtKBJIDinreC4TatMvsjIrSB2l
 Z6G6U4CWMPl923lPO57u8QsaIIv7HZwZSPkjPWpgbWX44xzVBnozd2kw9+2seiTSIcj3
 Qkf2GOMQpamEW7NmnjoYptA+1zF/tJPcRNSLamKTOuYrFHXccIwNiyp1bSVzXNNkTWuf
 gcEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686220947; x=1688812947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8VYSwYNBoGdVkr6LwKT2BwpwsiRD5YPfDCGwo+rcgl4=;
 b=fT6wx2suCAANGYfxDuDbxFm7NgMPFqAkDTaeVKBLB4egqMM/KdkH16GcOFBgwqrYNQ
 CA+MgYGA3SdpqOJnA02wKk/WZb+6uJL1HgAzjNMkCAg0N/hN+gZkIdVUVQmxYTyz7cMk
 L242WqHvPYCxy+tuVG6FG63l0nX+xvrRKUd6QwinFtnRnUtfzg9RTuzXKKIsd+ETuuDD
 y6Y3xdiMiT6Huez/xvxetuIe9wEEQ5PVs0J0H4VQWTrUwbY5JmjA2017xmEpUTIEWOi7
 TJiukdL4vux27PGHxSiyK3Yrb9oGd9I2b1CAVCJ6p6oegEHuoIyV3dKiXbsFchWzjnPl
 /gLA==
X-Gm-Message-State: AC+VfDy4e1SuQdMovQtz1sa50gqzva8Lxujbt0ufhT1beBannJKd0iEJ
 9dM0aiYsZQ2s1/GjAur+BkkAZL8d8+s=
X-Google-Smtp-Source: ACHHUZ4PZV5cjdHXJv5MLVCRP4DB1R7KTqC1IdcZHLZSjwALHH+3GTMZo59SxQvVtSC0DWjFMWuIfQ==
X-Received: by 2002:ac2:4474:0:b0:4e0:a426:6ddc with SMTP id
 y20-20020ac24474000000b004e0a4266ddcmr2769583lfl.0.1686220946755; 
 Thu, 08 Jun 2023 03:42:26 -0700 (PDT)
Received: from hp-power-15.localdomain (78-62-135-63.static.zebra.lt.
 [78.62.135.63]) by smtp.gmail.com with ESMTPSA id
 w7-20020ac24427000000b004f3945751b2sm142632lfl.43.2023.06.08.03.42.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 03:42:26 -0700 (PDT)
From: Siarhei Volkau <lis8215@gmail.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Stefan Markovic <smarkovic@wavecomp.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Siarhei Volkau <lis8215@gmail.com>
Subject: [PATCH 02/33] Add support of two XBurst CPUs
Date: Thu,  8 Jun 2023 13:41:51 +0300
Message-Id: <20230608104222.1520143-3-lis8215@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230608104222.1520143-1-lis8215@gmail.com>
References: <20230608104222.1520143-1-lis8215@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=lis8215@gmail.com; helo=mail-lf1-x136.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 08 Jun 2023 09:17:53 -0400
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

XBurstR1 - is the MIPS32R1 CPU which aims to cover all Ingenic SoCs
older than JZ4770 and some newer.
XBurstR2 - is the MIPS32R2 CPU which aims to cover all Ingenic SoCs
starting from to JZ4770.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 target/mips/cpu-defs.c.inc | 46 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/target/mips/cpu-defs.c.inc b/target/mips/cpu-defs.c.inc
index d45f245a67..b67ccf171d 100644
--- a/target/mips/cpu-defs.c.inc
+++ b/target/mips/cpu-defs.c.inc
@@ -117,6 +117,26 @@ const mips_def_t mips_defs[] =
         .insn_flags = CPU_MIPS32R1,
         .mmu_type = MMU_TYPE_R4000,
     },
+    {
+        .name = "XBurstR1",
+        .CP0_PRid = 0x1ed0024f,
+        .CP0_Config0 = MIPS_CONFIG0 | (MMU_TYPE_R4000 << CP0C0_MT),
+        .CP0_Config1 = MIPS_CONFIG1 | (15 << CP0C1_MMU) |
+                       (0 << CP0C1_IS) | (3 << CP0C1_IL) | (1 << CP0C1_IA) |
+                       (0 << CP0C1_DS) | (3 << CP0C1_DL) | (1 << CP0C1_DA) |
+                       (0 << CP0C1_CA),
+        .CP0_Config2 = MIPS_CONFIG2,
+        .CP0_Config3 = MIPS_CONFIG3,
+        .CP0_LLAddr_rw_bitmask = 0,
+        .CP0_LLAddr_shift = 4,
+        .SYNCI_Step = 32,
+        .CCRes = 2,
+        .CP0_Status_rw_bitmask = 0x1278FF17,
+        .SEGBITS = 32,
+        .PABITS = 32,
+        .insn_flags = CPU_MIPS32R1 | ASE_MXU,
+        .mmu_type = MMU_TYPE_R4000,
+    },
     {
         .name = "4KEmR1",
         .CP0_PRid = 0x00018500,
@@ -323,6 +343,32 @@ const mips_def_t mips_defs[] =
         .insn_flags = CPU_MIPS32R2 | ASE_MIPS16 | ASE_DSP | ASE_DSP_R2,
         .mmu_type = MMU_TYPE_R4000,
     },
+    {
+        .name = "XBurstR2",
+        .CP0_PRid = 0x2ed1024f,
+        .CP0_Config0 = MIPS_CONFIG0 | (0x1 << CP0C0_AR) |
+                    (MMU_TYPE_R4000 << CP0C0_MT),
+        .CP0_Config1 = MIPS_CONFIG1 | (1 << CP0C1_FP) | (15 << CP0C1_MMU) |
+                       (0 << CP0C1_IS) | (3 << CP0C1_IL) | (1 << CP0C1_IA) |
+                       (0 << CP0C1_DS) | (3 << CP0C1_DL) | (1 << CP0C1_DA) |
+                       (1 << CP0C1_CA),
+        .CP0_Config2 = MIPS_CONFIG2,
+        .CP0_Config3 = MIPS_CONFIG3 | (1 << CP0C3_DSP2P) | (1 << CP0C3_DSPP) |
+                       (1 << CP0C3_VInt),
+        .CP0_LLAddr_rw_bitmask = 0,
+        .CP0_LLAddr_shift = 4,
+        .SYNCI_Step = 32,
+        .CCRes = 2,
+        .CP0_Status_rw_bitmask = 0x3778FF1F,
+        .CP1_fcr0 = (1 << FCR0_F64) | (1 << FCR0_L) | (1 << FCR0_W) |
+                    (1 << FCR0_D) | (1 << FCR0_S) | (0x93 << FCR0_PRID),
+        .CP1_fcr31 = 0,
+        .CP1_fcr31_rw_bitmask = 0xFF83FFFF,
+        .SEGBITS = 32,
+        .PABITS = 32,
+        .insn_flags = CPU_MIPS32R2 | ASE_MXU,
+        .mmu_type = MMU_TYPE_R4000,
+    },
     {
         .name = "M14K",
         .CP0_PRid = 0x00019b00,
-- 
2.40.0


