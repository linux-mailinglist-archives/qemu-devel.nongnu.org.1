Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA692786BD6
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 11:29:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ6eF-0004Yc-TO; Thu, 24 Aug 2023 05:29:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ6eC-0004CP-3L
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:29:00 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ6e7-00051z-FN
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:28:59 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fe4cdb72b9so60746105e9.0
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 02:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692869331; x=1693474131;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=m7ehu004RcOiLV/pfLKDXFZl8HCdJzWH0SUfnwSyxlE=;
 b=SMtuFkURjvCz2+Pv4kFUeaQskCmndvZzYdExMV2/CEN6E4t3R2w1fu2XbCj6lpDNWn
 hzH+LqsFyS/xOakQ5jaDRmW59RE0FAZZ9Agjjy2f9RX5yMc7hBHhUOBsYp3rdarr5dSO
 8leCcjmE0wpcpKTyDUbhGv4mYu78bB0aVJ5DHBeMr19KKBmVsV+Em4O7WDqdkeQWGnBV
 iKTkuCekk2YJ3HK1ntsRZDdk0grDqGv/pS9l1f1RHiMNbvPsG4nM0+fJ4BUlp7judL/W
 E/nVE1ujExCHE8QfD5vG9EAHBgMfjW1nr4J0EiIjziIgPvJfWYKmSbSyuAE/XlRyLlRv
 bOZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692869331; x=1693474131;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m7ehu004RcOiLV/pfLKDXFZl8HCdJzWH0SUfnwSyxlE=;
 b=WkgFFi6JR3Qn55GQdO3SqzlmjfpN/OM0Vrd4+PjjOcoKq/DGReuAcSUoZY7xh9t6eY
 Bw3CdmNnFZL9BJzQiKQqUziHFeU2Z+Sz2HugqJRsH38TS425H5IYhEKT33O0QAB2PB4Y
 EiivWEV5eUgqm3qC9cAn2NOffswQbrKjXYtoCI1TGg04ZDlM9x4q4ykiHra9xLcDFJSU
 HKfK9/mVcjT4Cdjr24iZO3ZdZR1gspF4d5TJ3pSZEXW96NkFVaTRTsIVqlS+tC3lhi4r
 N7/EaXVBzrPHkIArNGIPRN1hAR15+GvtwOdurn78S9LJZNw0oQU6egm7uvWKUAteUs9l
 zcfg==
X-Gm-Message-State: AOJu0Yz47YWtvQiChFCFTOZh82C4FCypMXx+Q6TMwKiNPnW9ov3RZEdE
 ASVbR1yiy4avMMMpTRnTK2AQgFdZBSLSSBpqlCQ=
X-Google-Smtp-Source: AGHT+IFEAMLXRup4nhWIJUAo1n5+dNndOMT2hOb6Qoe2kN+ZOz74ARFCHTuElRPsheWOlD08oa0QNQ==
X-Received: by 2002:a05:600c:3654:b0:3fb:b5dc:dab1 with SMTP id
 y20-20020a05600c365400b003fbb5dcdab1mr10401191wmq.39.1692869331371; 
 Thu, 24 Aug 2023 02:28:51 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 s12-20020adfeccc000000b00317b5c8a4f1sm21844004wro.60.2023.08.24.02.28.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 02:28:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/35] target/arm/ptw: Load stage-2 tables from realm physical
 space
Date: Thu, 24 Aug 2023 10:28:29 +0100
Message-Id: <20230824092836.2239644-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824092836.2239644-1-peter.maydell@linaro.org>
References: <20230824092836.2239644-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

In realm state, stage-2 translation tables are fetched from the realm
physical address space (R_PGRQD).

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20230809123706.1842548-2-jean-philippe@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/ptw.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 07832eb8f76..7a69968dd76 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -157,22 +157,32 @@ static ARMMMUIdx ptw_idx_for_stage_2(CPUARMState *env, ARMMMUIdx stage2idx)
 
     /*
      * We're OK to check the current state of the CPU here because
-     * (1) we always invalidate all TLBs when the SCR_EL3.NS bit changes
+     * (1) we always invalidate all TLBs when the SCR_EL3.NS or SCR_EL3.NSE bit
+     * changes.
      * (2) there's no way to do a lookup that cares about Stage 2 for a
      * different security state to the current one for AArch64, and AArch32
      * never has a secure EL2. (AArch32 ATS12NSO[UP][RW] allow EL3 to do
      * an NS stage 1+2 lookup while the NS bit is 0.)
      */
-    if (!arm_is_secure_below_el3(env) || !arm_el_is_aa64(env, 3)) {
+    if (!arm_el_is_aa64(env, 3)) {
         return ARMMMUIdx_Phys_NS;
     }
-    if (stage2idx == ARMMMUIdx_Stage2_S) {
-        s2walk_secure = !(env->cp15.vstcr_el2 & VSTCR_SW);
-    } else {
-        s2walk_secure = !(env->cp15.vtcr_el2 & VTCR_NSW);
-    }
-    return s2walk_secure ? ARMMMUIdx_Phys_S : ARMMMUIdx_Phys_NS;
 
+    switch (arm_security_space_below_el3(env)) {
+    case ARMSS_NonSecure:
+        return ARMMMUIdx_Phys_NS;
+    case ARMSS_Realm:
+        return ARMMMUIdx_Phys_Realm;
+    case ARMSS_Secure:
+        if (stage2idx == ARMMMUIdx_Stage2_S) {
+            s2walk_secure = !(env->cp15.vstcr_el2 & VSTCR_SW);
+        } else {
+            s2walk_secure = !(env->cp15.vtcr_el2 & VTCR_NSW);
+        }
+        return s2walk_secure ? ARMMMUIdx_Phys_S : ARMMMUIdx_Phys_NS;
+    default:
+        g_assert_not_reached();
+    }
 }
 
 static bool regime_translation_big_endian(CPUARMState *env, ARMMMUIdx mmu_idx)
-- 
2.34.1


