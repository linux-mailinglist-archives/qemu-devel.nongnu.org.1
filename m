Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC715772763
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 16:17:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT12P-0001as-KI; Mon, 07 Aug 2023 10:16:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qT114-00008m-OB
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 10:15:27 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qT110-0005TA-HR
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 10:15:25 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3090d3e9c92so3998889f8f.2
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 07:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691417720; x=1692022520;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Km5Z3LiOVN7aMvNdfTpr688xvyTx8SIvRnXYskA55+4=;
 b=EZQvAfd1idvDCtNE1TKkywU5zhL9JK51FlrUtQkouAkbIUZIfdC+dh+XVcKuHnqIyd
 yyFQAF1iYrc7wOYEhtqNO99dvSEn2fchOdc69IRc6/7NWe+VciwnzkxWJWGBA+FQEj4v
 LjOyHX7ouC4mL4FujCa5q8blE44OYVec1Oto9JkG2X19mpv6Mr6ug4cd1euDpwbjFIXP
 KQGBE6koMFI4V31XpAzSGwLyzq2ZWNWyA2nMlJGeQrZVkd/FFfr+cm+gNoU+S3wmYPLw
 sD8dALfvoVEH8+VwXBtcUZmuJhlrsTsG/FkEMZdPtPvgZcCkLIwio2rVdSXQjt0urRws
 DPYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691417720; x=1692022520;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Km5Z3LiOVN7aMvNdfTpr688xvyTx8SIvRnXYskA55+4=;
 b=Aqp9jXfwISnlh3WEfjXe9/6w7XTIXujSyK3RoHAcbbOALhYnaOPpYtGlK8u3m9HF8A
 4Hm+mQxTqeZ+mDd+/cuX0GOjSYY+f8VswxrHDrK5CnHIX0qTdtIZT/zKtQ99G3NOn3yc
 X4PgeNBWUGEqoeAlXLck/7jIj5RHaGs3W5U59bGM79f/N0CIQ8aYKpZ6b5eWKjo+AuqR
 6nM+/MCs19hLwJwGdEf8qssXnVVmXrdWBrxLeZzXK5A73JK/HSXicFdWdvhfh0RrZuUT
 Tp9uXHIWRofCNSIIvGEAToVq6Vs+Q5gFPjXY7acG5oMapyaMQKtGbd9putMNyQDtvYnO
 pHhg==
X-Gm-Message-State: AOJu0YwjMlga1fSaZlrub+O4jwkumUJ6z2qYLAPZ0PCsYsdRl9lV08Sx
 N2ld0/M5zIXpISqpGiPD7A14qg==
X-Google-Smtp-Source: AGHT+IFz/WeDcS37ZVeJQBLxpo6d91VkdDODfUlevgNg8kZX6zkO2LYgeUM9bcEiG56CbXWdx+X87w==
X-Received: by 2002:a5d:62c6:0:b0:317:6992:855c with SMTP id
 o6-20020a5d62c6000000b003176992855cmr6517551wrv.19.1691417720374; 
 Mon, 07 Aug 2023 07:15:20 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 h20-20020a05600c261400b003fe2ebf479fsm10835617wma.36.2023.08.07.07.15.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 07:15:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 07/15] target/arm: Pass an ARMSecuritySpace to
 arm_is_el2_enabled_secstate()
Date: Mon,  7 Aug 2023 15:15:06 +0100
Message-Id: <20230807141514.19075-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807141514.19075-1-peter.maydell@linaro.org>
References: <20230807141514.19075-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

Pass an ARMSecuritySpace instead of a bool secure to
arm_is_el2_enabled_secstate(). This doesn't change behaviour.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h    | 13 ++++++++-----
 target/arm/helper.c |  2 +-
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index bcd65a63ca0..02bc8f0e8e0 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2504,17 +2504,19 @@ static inline bool arm_is_secure(CPUARMState *env)
 
 /*
  * Return true if the current security state has AArch64 EL2 or AArch32 Hyp.
- * This corresponds to the pseudocode EL2Enabled()
+ * This corresponds to the pseudocode EL2Enabled().
  */
-static inline bool arm_is_el2_enabled_secstate(CPUARMState *env, bool secure)
+static inline bool arm_is_el2_enabled_secstate(CPUARMState *env,
+                                               ARMSecuritySpace space)
 {
+    assert(space != ARMSS_Root);
     return arm_feature(env, ARM_FEATURE_EL2)
-           && (!secure || (env->cp15.scr_el3 & SCR_EEL2));
+           && (space != ARMSS_Secure || (env->cp15.scr_el3 & SCR_EEL2));
 }
 
 static inline bool arm_is_el2_enabled(CPUARMState *env)
 {
-    return arm_is_el2_enabled_secstate(env, arm_is_secure_below_el3(env));
+    return arm_is_el2_enabled_secstate(env, arm_security_space_below_el3(env));
 }
 
 #else
@@ -2538,7 +2540,8 @@ static inline bool arm_is_secure(CPUARMState *env)
     return false;
 }
 
-static inline bool arm_is_el2_enabled_secstate(CPUARMState *env, bool secure)
+static inline bool arm_is_el2_enabled_secstate(CPUARMState *env,
+                                               ARMSecuritySpace space)
 {
     return false;
 }
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 9862bc73b52..8290ca0aaad 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5778,7 +5778,7 @@ uint64_t arm_hcr_el2_eff_secstate(CPUARMState *env, ARMSecuritySpace space)
 
     assert(space != ARMSS_Root);
 
-    if (!arm_is_el2_enabled_secstate(env, arm_space_is_secure(space))) {
+    if (!arm_is_el2_enabled_secstate(env, space)) {
         /*
          * "This register has no effect if EL2 is not enabled in the
          * current Security state".  This is ARMv8.4-SecEL2 speak for
-- 
2.34.1


