Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1E982ACF6
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 12:09:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNssm-0001je-Vu; Thu, 11 Jan 2024 06:05:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNssD-0001O5-I7
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:25 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNssA-0004T1-Vp
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:21 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3368abe1093so4130651f8f.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 03:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704971116; x=1705575916; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LwWUwjczvpD7+ZI2C4YQSC3wj+TJRP3iZxPLtk74qzM=;
 b=cCHT2MY7W/xubnO9TL6BFAHPQgP3d4TQqL5/LBKaOqUcPagUCVvTefBDzELSfQkcRm
 HVyTD8lm7/9Kqhx/zcyKpii/VjCS5Hdp1NstxyM4Fsnpa/6z++b/fzfvNQsXr1oktig8
 OchVVT6U+dO0ACVdH3uzUAfpbwNR3Ah4mF4qwXQJ+Rqq3TzrmTbV0R5b9DmGQF6zK/I1
 yaKe9wabhmJnZnlh/Ii4wOzIgwH4Bghen/Ds4Kgk67KEPd0lSy0JGmuWE6OMAqybddv2
 wsA1iJor2Gw6zluvxBtBnXHrrAVfeUXXWk9BwZOfe12X6loKVURiP+NK1Srl54sytSwP
 6c/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704971116; x=1705575916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LwWUwjczvpD7+ZI2C4YQSC3wj+TJRP3iZxPLtk74qzM=;
 b=uksNk8Obsz/h2XqFQ2AMcrlRfSZP0/WBhuN7YR38idx9v2kcITaOwRRHFXStXa6Da3
 3GIyNJeefre7Qd7lZsbb6egJq9KCh/ZfyOLUMbG/cdPLbjfncgn17gWkuTdZDCx3ZL5Q
 rxa8NVAyYoEneMQ35iTeqy4v806/umbCwkGR6AOqZrZhh8U+OVv3ZvmfqeaH7vzn8kde
 cZoqGf+em6+Me8OasMsYjxW3S9chudhRKOz1rIU/hOuApLeEi4NbnO0sA3XvasfLAnBt
 ju8T5ISyvVxndjR+WX3B2L5fIluhloqYuRuJFzF6tmpSbnvLiH7n7ns/06uEW0/qSZiJ
 b9XA==
X-Gm-Message-State: AOJu0YzVEyRGfVXbyVLkbh2QvMhAKTAc5ZAzGx03RtoayTMsALMjyVPm
 XliXI1Es09He5QGBWvtXezQbwzqjBH5+Ps46x5PPydeyn0g=
X-Google-Smtp-Source: AGHT+IFAic/FXrM4cE189FTlZNAIUWtMLxvJ/+hN+q/KtbithMLjwSSp+wH0Kr6Hy/QaplimjasoqA==
X-Received: by 2002:adf:eb0d:0:b0:337:7c78:a4d5 with SMTP id
 s13-20020adfeb0d000000b003377c78a4d5mr461125wrn.73.1704971116636; 
 Thu, 11 Jan 2024 03:05:16 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v30-20020adf8b5e000000b0033690139ea5sm951323wra.44.2024.01.11.03.05.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 03:05:16 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/41] target/arm: Always use arm_pan_enabled() when checking
 if PAN is enabled
Date: Thu, 11 Jan 2024 11:04:47 +0000
Message-Id: <20240111110505.1563291-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240111110505.1563291-1-peter.maydell@linaro.org>
References: <20240111110505.1563291-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
---
 target/arm/helper.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index c8296a9c191..1db2effb1c0 100644
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
@@ -3614,7 +3623,7 @@ static void ats_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
             g_assert(ss != ARMSS_Secure);  /* ARMv8.4-SecEL2 is 64-bit only */
             /* fall through */
         case 1:
-            if (ri->crm == 9 && (env->uncached_cpsr & CPSR_PAN)) {
+            if (ri->crm == 9 && arm_pan_enabled(env)) {
                 mmu_idx = ARMMMUIdx_Stage1_E1_PAN;
             } else {
                 mmu_idx = ARMMMUIdx_Stage1_E1;
@@ -3730,7 +3739,7 @@ static void ats_write64(CPUARMState *env, const ARMCPRegInfo *ri,
     case 0:
         switch (ri->opc1) {
         case 0: /* AT S1E1R, AT S1E1W, AT S1E1RP, AT S1E1WP */
-            if (ri->crm == 9 && (env->pstate & PSTATE_PAN)) {
+            if (ri->crm == 9 && arm_pan_enabled(env)) {
                 mmu_idx = regime_e20 ?
                           ARMMMUIdx_E20_2_PAN : ARMMMUIdx_Stage1_E1_PAN;
             } else {
@@ -12145,15 +12154,6 @@ ARMMMUIdx arm_v7m_mmu_idx_for_secstate(CPUARMState *env, bool secstate)
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


