Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9EE7E3A58
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:53:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Jgd-0002Pa-TS; Tue, 07 Nov 2023 05:51:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0JgX-0002PA-8i
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:51:53 -0500
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0JgV-0002I7-K0
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:51:53 -0500
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2c5087d19a6so74125241fa.0
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 02:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699354309; x=1699959109; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Wv3Zimx7HgIA0oUGeUBlXRK1FPk2Q+GkiL5eeNqqui0=;
 b=vZOxVLETZbeNfnYtzzuL/kPTn+eGZPl/pX2uhtCN+uypnN3XIV/EMyZPutiR33cjOi
 UNESJ6nkrBmPjqVYvHKyIVYPO7AFLhb69hOUubpQHj1px4bCTiXvS+AT3ErKCczAgOZt
 ISdIj+OMyo8nbj/DzolgOpsnN3HKKReLtEXaar4Xy8T+4jqbx05QWUXqeiEYG33AIRA9
 T11/izNDG/UHQWQLP3401Il3chiKLGpZHS0HDfOiyNlXhsom/COHYJh38UfTuEr6XxAM
 h7mG19+l6wG3C7wMTZcbLnBIqSKFMI7LD+DaKF9mvooYLjBbIYBrOW4wImos8dvqhtGG
 FVDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699354309; x=1699959109;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Wv3Zimx7HgIA0oUGeUBlXRK1FPk2Q+GkiL5eeNqqui0=;
 b=aHhXe7WQVU7vTMd45OMOhnIl/UNE1JWfRhVjXnaRhHqM9VtramUqbWpXg1hthDVRfv
 LdPWA5ECfg46zYvPoCHrLG03hed+mcdrwh6fON6bT2msOh39r9NM192t51iS0a8inWuq
 e35ZOhJWkvBasVrupiswrhjF24z5/wHDt9yEG6qBdl7z1KmFl/k+Da1WyqFCD4WzDqfD
 oXfDvvTV42mHmkeqPlexsN1sMal/UcjkZq4Il21Rvt+/Jug8gKVMNtE2166bWk3cqvnq
 yvf+/owGwyIfv9r2WpMsvfamCeUXkchAZf0Uz5gyZagb1bwGf3odNB3Y4BLNkqrsleac
 52cw==
X-Gm-Message-State: AOJu0YzkHq4eJyL3WKCGkJf69GJodBryA4gtdBuKqWqH2ZKwIa1q6DV6
 pYn+segF0ljNEk+lBmfWvRgPvQ==
X-Google-Smtp-Source: AGHT+IG+tLBZOsNA8kifaWgm9xDx/UwJ9cgpLrjZHLYJ9J6Lm7Q8g65QiXHD7+i4UfaYlnSPgJFSNg==
X-Received: by 2002:a2e:5056:0:b0:2c5:1640:3c97 with SMTP id
 v22-20020a2e5056000000b002c516403c97mr26541068ljd.22.1699354309196; 
 Tue, 07 Nov 2023 02:51:49 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 l3-20020a05600c4f0300b003fc0505be19sm15358801wmq.37.2023.11.07.02.51.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 02:51:48 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5E0075F790;
 Tue,  7 Nov 2023 10:51:48 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PATCH] target/arm: mark the 32bit alias of PAR when LPAE enabled
Date: Tue,  7 Nov 2023 10:51:45 +0000
Message-Id: <20231107105145.2916124-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

We also mark it ARM_CP_NO_GDB so we avoid duplicate PAR's in the
system register XML we send to gdb.

Suggested-by: <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - only set ARM_CP_NO_GDB when no LPAE enabled
  - also mark as AP_CP_ALIAS
---
 target/arm/helper.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 5dc0d20a84..80a35b29bb 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3722,20 +3722,6 @@ static void ats_write64(CPUARMState *env, const ARMCPRegInfo *ri,
 }
 #endif
 
-static const ARMCPRegInfo vapa_cp_reginfo[] = {
-    { .name = "PAR", .cp = 15, .crn = 7, .crm = 4, .opc1 = 0, .opc2 = 0,
-      .access = PL1_RW, .resetvalue = 0,
-      .bank_fieldoffsets = { offsetoflow32(CPUARMState, cp15.par_s),
-                             offsetoflow32(CPUARMState, cp15.par_ns) },
-      .writefn = par_write },
-#ifndef CONFIG_USER_ONLY
-    /* This underdecoding is safe because the reginfo is NO_RAW. */
-    { .name = "ATS", .cp = 15, .crn = 7, .crm = 8, .opc1 = 0, .opc2 = CP_ANY,
-      .access = PL1_W, .accessfn = ats_access,
-      .writefn = ats_write, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC },
-#endif
-};
-
 /* Return basic MPU access permission bits.  */
 static uint32_t simple_mpu_ap_bits(uint32_t val)
 {
@@ -8904,6 +8890,24 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         define_arm_cp_regs(cpu, generic_timer_cp_reginfo);
     }
     if (arm_feature(env, ARM_FEATURE_VAPA)) {
+        ARMCPRegInfo vapa_cp_reginfo[] = {
+            { .name = "PAR", .cp = 15, .crn = 7, .crm = 4, .opc1 = 0, .opc2 = 0,
+              .access = PL1_RW, .resetvalue = 0,
+              .bank_fieldoffsets = { offsetoflow32(CPUARMState, cp15.par_s),
+                                     offsetoflow32(CPUARMState, cp15.par_ns) },
+              .writefn = par_write},
+#ifndef CONFIG_USER_ONLY
+            /* This underdecoding is safe because the reginfo is NO_RAW. */
+            { .name = "ATS", .cp = 15, .crn = 7, .crm = 8, .opc1 = 0, .opc2 = CP_ANY,
+              .access = PL1_W, .accessfn = ats_access,
+              .writefn = ats_write, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC },
+#endif
+        };
+
+        /* When LPAE exists the PAR register is an alias */
+        if (arm_feature(env, ARM_FEATURE_LPAE)) {
+            vapa_cp_reginfo[0].type = ARM_CP_ALIAS | ARM_CP_NO_GDB;
+        }
         define_arm_cp_regs(cpu, vapa_cp_reginfo);
     }
     if (arm_feature(env, ARM_FEATURE_CACHE_TEST_CLEAN)) {
-- 
2.39.2


