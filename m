Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A07775F5F
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 14:39:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTiRK-0002cP-Hb; Wed, 09 Aug 2023 08:37:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1qTiRH-0002Z8-2L
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 08:37:23 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1qTiRC-0002oc-QX
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 08:37:22 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-31765aee31bso5074583f8f.1
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 05:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691584637; x=1692189437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SnCb5YYZ+ttuOO1YKRt+XJ7wY6WpMTwJacpneD/an1A=;
 b=chcUIqNccXiVOYGWUqRtlIUxp1bxd6Mkqj3I3bVDaLSKFGUGH3pa5Bey9A5W62raQH
 0wONZKFxZcD77Y67cO+qJ95obpcXF4ktrvBS9zdaZEvIxXe1vSvUqQmgYWDTG+tr1slB
 ybNaj1lqzax/ZdmFv8THI6saMRXvNdpCLIN3Ysxb69USkPcdWOIK+udv5tvk93gU2Ma+
 pllLKrNKA59qGn7wzRm6dGcaGZt2+YOhKrZPIuyZA2GldIPAPulFZ7AQrAiM7EOcL5TA
 4GzSWN5ZNC+s9Wc1n63aZ7KR2E7eI8ra0ulaUh3noQkr99uAXudP4kLnRUQOla1ZO2YS
 D7bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691584637; x=1692189437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SnCb5YYZ+ttuOO1YKRt+XJ7wY6WpMTwJacpneD/an1A=;
 b=Fg479h8+sePV0tPbZA1Bc6qik5AeJ0j+VojD8AMJGE6xlHSoqKs6qhOsAKyk643gU6
 a8Op8HpXdh4tiw9Ru/exuDM9F/z8gKfpEOS/rOViklb6C0CPtNrFHXY1FBTwJwV6pqLl
 LiKo7YEpaNRMGjh9VXaOXKPWe9k/yq9LNaNIwgBPl0hDs4g2DhZLFpH2zDHVWNc4g2Ro
 9nDymrgkxMt9T0y/r7/WjPKF696+MUwTdJi8rh34Uo8lmIpa3+PXmYHYz2AB6wXoKrI/
 /vgCffD0a7AC5pIPAy7SkiaDPfwm6rmEg0/WvxiZFY8pkUTabyEu2n9aS5UGqrM2NPnw
 7W1g==
X-Gm-Message-State: AOJu0Yy0Pfb8LjAGarVodNorg74UvIXE8yeWs0uS/YkcS+kvEP+5fzpX
 UcdAxldEVSahklXEfVLwwGcHLg==
X-Google-Smtp-Source: AGHT+IGFhJQis2N+lwM/6tZ3oWtyPK2YpS+Mqafvcaafyva1M9tEtrawnKQcHVYxBUHaS1gze20k/g==
X-Received: by 2002:a5d:5612:0:b0:313:e8bf:a77 with SMTP id
 l18-20020a5d5612000000b00313e8bf0a77mr1862453wrv.5.1691584637345; 
 Wed, 09 Aug 2023 05:37:17 -0700 (PDT)
Received: from localhost.localdomain ([2.219.138.198])
 by smtp.gmail.com with ESMTPSA id
 k6-20020a5d5246000000b00317f70240afsm5617888wrc.27.2023.08.09.05.37.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Aug 2023 05:37:17 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: peter.maydell@linaro.org
Cc: richard.henderson@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v3 5/6] target/arm/helper: Check SCR_EL3.{NSE,
 NS} encoding for AT instructions
Date: Wed,  9 Aug 2023 13:37:05 +0100
Message-ID: <20230809123706.1842548-6-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809123706.1842548-1-jean-philippe@linaro.org>
References: <20230809123706.1842548-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=jean-philippe@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The AT instruction is UNDEFINED if the {NSE,NS} configuration is
invalid. Add a function to check this on all AT instructions that apply
to an EL lower than 3.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 target/arm/helper.c | 38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index fbb03c364b..dbfe9f2f5e 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3616,6 +3616,22 @@ static void ats1h_write(CPUARMState *env, const ARMCPRegInfo *ri,
 #endif /* CONFIG_TCG */
 }
 
+static CPAccessResult at_e012_access(CPUARMState *env, const ARMCPRegInfo *ri,
+                                     bool isread)
+{
+    /*
+     * R_NYXTL: instruction is UNDEFINED if it applies to an Exception level
+     * lower than EL3 and the combination SCR_EL3.{NSE,NS} is reserved. This can
+     * only happen when executing at EL3 because that combination also causes an
+     * illegal exception return. We don't need to check FEAT_RME either, because
+     * scr_write() ensures that the NSE bit is not set otherwise.
+     */
+    if ((env->cp15.scr_el3 & (SCR_NSE | SCR_NS)) == SCR_NSE) {
+        return CP_ACCESS_TRAP;
+    }
+    return CP_ACCESS_OK;
+}
+
 static CPAccessResult at_s1e2_access(CPUARMState *env, const ARMCPRegInfo *ri,
                                      bool isread)
 {
@@ -3623,7 +3639,7 @@ static CPAccessResult at_s1e2_access(CPUARMState *env, const ARMCPRegInfo *ri,
         !(env->cp15.scr_el3 & (SCR_NS | SCR_EEL2))) {
         return CP_ACCESS_TRAP;
     }
-    return CP_ACCESS_OK;
+    return at_e012_access(env, ri, isread);
 }
 
 static void ats_write64(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -5505,38 +5521,38 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
       .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 8, .opc2 = 0,
       .access = PL1_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
       .fgt = FGT_ATS1E1R,
-      .writefn = ats_write64 },
+      .accessfn = at_e012_access, .writefn = ats_write64 },
     { .name = "AT_S1E1W", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 8, .opc2 = 1,
       .access = PL1_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
       .fgt = FGT_ATS1E1W,
-      .writefn = ats_write64 },
+      .accessfn = at_e012_access, .writefn = ats_write64 },
     { .name = "AT_S1E0R", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 8, .opc2 = 2,
       .access = PL1_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
       .fgt = FGT_ATS1E0R,
-      .writefn = ats_write64 },
+      .accessfn = at_e012_access, .writefn = ats_write64 },
     { .name = "AT_S1E0W", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 8, .opc2 = 3,
       .access = PL1_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
       .fgt = FGT_ATS1E0W,
-      .writefn = ats_write64 },
+      .accessfn = at_e012_access, .writefn = ats_write64 },
     { .name = "AT_S12E1R", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 7, .crm = 8, .opc2 = 4,
       .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
-      .writefn = ats_write64 },
+      .accessfn = at_e012_access, .writefn = ats_write64 },
     { .name = "AT_S12E1W", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 7, .crm = 8, .opc2 = 5,
       .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
-      .writefn = ats_write64 },
+      .accessfn = at_e012_access, .writefn = ats_write64 },
     { .name = "AT_S12E0R", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 7, .crm = 8, .opc2 = 6,
       .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
-      .writefn = ats_write64 },
+      .accessfn = at_e012_access, .writefn = ats_write64 },
     { .name = "AT_S12E0W", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 7, .crm = 8, .opc2 = 7,
       .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
-      .writefn = ats_write64 },
+      .accessfn = at_e012_access, .writefn = ats_write64 },
     /* AT S1E2* are elsewhere as they UNDEF from EL3 if EL2 is not present */
     { .name = "AT_S1E3R", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 6, .crn = 7, .crm = 8, .opc2 = 0,
@@ -8078,12 +8094,12 @@ static const ARMCPRegInfo ats1e1_reginfo[] = {
       .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 9, .opc2 = 0,
       .access = PL1_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
       .fgt = FGT_ATS1E1RP,
-      .writefn = ats_write64 },
+      .accessfn = at_e012_access, .writefn = ats_write64 },
     { .name = "AT_S1E1WP", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 9, .opc2 = 1,
       .access = PL1_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
       .fgt = FGT_ATS1E1WP,
-      .writefn = ats_write64 },
+      .accessfn = at_e012_access, .writefn = ats_write64 },
 };
 
 static const ARMCPRegInfo ats1cp_reginfo[] = {
-- 
2.41.0


