Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F83816C8E
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 12:39:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFBsD-0006vC-HZ; Mon, 18 Dec 2023 06:33:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFBsA-0006hS-Sm
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 06:33:22 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFBs4-0003KZ-2M
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 06:33:22 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40c29f7b068so31786635e9.0
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 03:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702899194; x=1703503994; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Q35dnGSoWYO7P8DMUTU7ajk5KESZuoV9yrkqAnTLLr4=;
 b=nYao5VSTSJGY/sgatcbVE8k781YpT0WKZ6sxJXUx6tk9Pk+eiRm2oDaNxHoqkLxSgU
 97SlGWczHtvTu+pJz73SjK4oi1CeZf6ApHdvm4fhzKpL1zZZUylDArhOFO7XaxCPZiIH
 O3UWyUBTneIxAZz/uIDsEHZ6IDa8dnnUeFmJxsOORZNSh4X++jDVsN8Z3JIEraEOPIXI
 ObHM9AI49QsCyxQNOttx0b1rPjp5uNKa4REAI1JaMt8OY+bl0LZNRtC35n9C+O8O0hfF
 NlDzoTp6it/3eNvjrQe80ykMcjtRFWJh5pOjVQLFqVQJxMkwBvVmhLLmkXE/8w0WfHmu
 9Tbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702899194; x=1703503994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q35dnGSoWYO7P8DMUTU7ajk5KESZuoV9yrkqAnTLLr4=;
 b=DxQ7psAqX4RCjfTshp1Aw/J3Yl+UMbDzCrJ8wwV+JBC0C2eVMSe04mzUzuMaYA9eC1
 4gw2S1ibRCrJ9GUZLp3wGG3U2opAvurSe8Mvj+ntNd0AwrVxjA4QV/SDZSvHKNs3uJnP
 lnZXVpnTbbY9rLyRc+D6ttDkCYULy68I77uwmye0cxXdaetRtqdeuesqHar2N0xiJZvn
 kHQUJrbzdff8YhDApYHC88WxEel4JcoMf4/iC0v0fQE7GqW0kDMD31abJM/KWddiaACZ
 tNcDAk/J0H8clYYQSB8YzFZpIj4EBTpPNhRH4Vq8DtF826e1cLzOBpEVhmPGwTDT+4Ij
 SR+g==
X-Gm-Message-State: AOJu0YyJBcOHnTTEKfnHQhC+0+mHIAIF87DbYq5jNZ5/ySPYTuWIzpNd
 qcT65ChQ+Logl9ipVjUtTjdMXw==
X-Google-Smtp-Source: AGHT+IE0NM2TdUV/ltYSSHle0/F4FkpSU+l5aRARsDUEUNI+SVRGXaKXv01ea/Xc/ibux4ZDzY60YQ==
X-Received: by 2002:a05:600c:43c9:b0:40b:5e21:cc1b with SMTP id
 f9-20020a05600c43c900b0040b5e21cc1bmr8517830wmn.70.1702899194637; 
 Mon, 18 Dec 2023 03:33:14 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 j18-20020adff012000000b003366da509ecsm671193wro.85.2023.12.18.03.33.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 03:33:14 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 17/35] target/arm: Always use arm_pan_enabled() when checking
 if PAN is enabled
Date: Mon, 18 Dec 2023 11:32:47 +0000
Message-Id: <20231218113305.2511480-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218113305.2511480-1-peter.maydell@linaro.org>
References: <20231218113305.2511480-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

Currently the code in target/arm/helper.c mostly checks the PAN bits
in env->pstate or env->uncached_cpsr directly when it wants to know
if PAN is enabled, because in most callsites we know whether we are
in AArch64 or AArch32. We do have an arm_pan_enabled() function, but
we only use it in a few places where the code might run in either an
AArch32 or AArch64 context.

For FEAT_NV, when HCR_EL2.{NV,NV1} is {1,1} PAN is always disabled
even when the PSTATE.PAN bit is set, the "is PAN enabled" test
becomes more complicated. Make all places that check for PAN use
arm_pan_enabled(), so we have a place to put the FEAT_NV test.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 3270fb11049..4b0e46cfaae 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -263,6 +263,15 @@ void init_cpreg_list(ARMCPU *cpu)
     g_list_free(keys);
 }
 
+static bool arm_pan_enabled(CPUARMState *env)
+{
+    if (is_a64(env)) {
+        return env->pstate & PSTATE_PAN;
+    } else {
+        return env->uncached_cpsr & CPSR_PAN;
+    }
+}
+
 /*
  * Some registers are not accessible from AArch32 EL3 if SCR.NS == 0.
  */
@@ -3598,7 +3607,7 @@ static void ats_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
             g_assert(ss != ARMSS_Secure);  /* ARMv8.4-SecEL2 is 64-bit only */
             /* fall through */
         case 1:
-            if (ri->crm == 9 && (env->uncached_cpsr & CPSR_PAN)) {
+            if (ri->crm == 9 && arm_pan_enabled(env)) {
                 mmu_idx = ARMMMUIdx_Stage1_E1_PAN;
             } else {
                 mmu_idx = ARMMMUIdx_Stage1_E1;
@@ -3714,7 +3723,7 @@ static void ats_write64(CPUARMState *env, const ARMCPRegInfo *ri,
     case 0:
         switch (ri->opc1) {
         case 0: /* AT S1E1R, AT S1E1W, AT S1E1RP, AT S1E1WP */
-            if (ri->crm == 9 && (env->pstate & PSTATE_PAN)) {
+            if (ri->crm == 9 && arm_pan_enabled(env)) {
                 mmu_idx = regime_e20 ?
                           ARMMMUIdx_E20_2_PAN : ARMMMUIdx_Stage1_E1_PAN;
             } else {
@@ -12222,15 +12231,6 @@ ARMMMUIdx arm_v7m_mmu_idx_for_secstate(CPUARMState *env, bool secstate)
 }
 #endif
 
-static bool arm_pan_enabled(CPUARMState *env)
-{
-    if (is_a64(env)) {
-        return env->pstate & PSTATE_PAN;
-    } else {
-        return env->uncached_cpsr & CPSR_PAN;
-    }
-}
-
 ARMMMUIdx arm_mmu_idx_el(CPUARMState *env, int el)
 {
     ARMMMUIdx idx;
-- 
2.34.1


