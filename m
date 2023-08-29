Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A67B78D098
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:29:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb83t-0003x1-9c; Tue, 29 Aug 2023 19:23:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb83q-0003ly-4n
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 19:23:50 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb83l-0001NL-3W
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 19:23:49 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1c1e3a4a06fso17052885ad.3
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 16:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693351423; x=1693956223; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tz0aWUu/vHl+1ntPEUMfK/rYoMDJR4BjrdL+Cy/mdVs=;
 b=m6n/TpIpbBGNBQuAUKMsHJ23fngCD5iKz2R34+H/gyI8U3PL6yS67MHbC4P/Yy42zf
 hfuEfuV+o8Y+ekBQLOndgbb6i4puKzsRv9gD8iAcoSF5n1fm6bXr7VN8EO6XJY84UEFW
 PBMbpty6vScIR284vl7AkzGz4NdxbK/sQTXtAkvDrTgECzBzbjBbL5UkoaiJmgvxoaRn
 mEl1E2avZwPBgwqwq8HWExlcYhDC3vZ4YRlWMKFF0mM00R9hG4mT/YO0HrTxQguQ10AN
 bGHCJvFOstoq3cRdQvmoTWS+NDT6JU9Hya7JYofzMxgheSouT2Qdv0eWz2yl24yQqUti
 NQCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693351423; x=1693956223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tz0aWUu/vHl+1ntPEUMfK/rYoMDJR4BjrdL+Cy/mdVs=;
 b=hQOXQgP2nAQJJBDKGwr0ELVr5Tb914pVLaA0v8nYzUzDUgQLWsPt2tQe9Pu7yvlUQA
 X9h/aFxNh6iIcm7v9y/qBuKNhf4U38i46OO0is/ZgdRNktShPFxhvUaHm3yq9CFig+C6
 z+sM1Pxu/NukrZqAR0qKNQ13zMe3SY8meRnnEy1HHwn9I6sM4TENWDp3ii6y2cUZDfwL
 p/L1Euz1U/y4J+VnFaiUeERKBOh+VRQJlqRWlj2iztpHXgMqvs24s1Wlj1TaKa524Xdr
 JSWYKlzEV4LhZfEoFKkEdv5z5WLfrfVdAagTukMrweCibmj0UrQZp8FtNw9PEMFDqZK+
 1u1Q==
X-Gm-Message-State: AOJu0Yy3+xc0Uo4v+Z9S7+83PTPAEV3Ehly8d5mU1tLuOmJKhFGaFVWP
 5bz7hKZlOuDKufXMNRjUMP7tdKWDyNnDR4uZXRo=
X-Google-Smtp-Source: AGHT+IHq1sgHi+ieZCXn8DM5++QiXiy25GX9ppO0+JVZ0SP/6MgAz9CzUa/uY908bbakJZIJnheQ7A==
X-Received: by 2002:a17:903:11d1:b0:1b8:78e:7c1 with SMTP id
 q17-20020a17090311d100b001b8078e07c1mr585119plh.51.1693351423715; 
 Tue, 29 Aug 2023 16:23:43 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 t9-20020a170902e84900b001b9dadf8bd2sm9829970plg.190.2023.08.29.16.23.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 16:23:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: aaron@os.amperecomputing.com, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v5 07/12] target/arm: Implement FEAT_Pauth2
Date: Tue, 29 Aug 2023 16:23:30 -0700
Message-Id: <20230829232335.965414-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230829232335.965414-1-richard.henderson@linaro.org>
References: <20230829232335.965414-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

From: Aaron Lindsay <aaron@os.amperecomputing.com>

Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230609172324.982888-6-aaron@os.amperecomputing.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/system/arm/emulation.rst |  1 +
 target/arm/tcg/cpu64.c        |  2 +-
 target/arm/tcg/pauth_helper.c | 21 +++++++++++++++++----
 3 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 4866a73ca0..54234ac090 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -63,6 +63,7 @@ the following architecture extensions:
 - FEAT_PAN2 (AT S1E1R and AT S1E1W instruction variants affected by PSTATE.PAN)
 - FEAT_PAN3 (Support for SCTLR_ELx.EPAN)
 - FEAT_PAuth (Pointer authentication)
+- FEAT_PAuth2 (Enhacements to pointer authentication)
 - FEAT_PMULL (PMULL, PMULL2 instructions)
 - FEAT_PMUv3p1 (PMU Extensions v3.1)
 - FEAT_PMUv3p4 (PMU Extensions v3.4)
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 85bf94ee40..d3be14137e 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -758,7 +758,7 @@ void aarch64_max_tcg_initfn(Object *obj)
 
     t = cpu->isar.id_aa64isar1;
     t = FIELD_DP64(t, ID_AA64ISAR1, DPB, 2);      /* FEAT_DPB2 */
-    t = FIELD_DP64(t, ID_AA64ISAR1, APA, PauthFeat_EPAC);
+    t = FIELD_DP64(t, ID_AA64ISAR1, APA, PauthFeat_2);
     t = FIELD_DP64(t, ID_AA64ISAR1, API, 1);
     t = FIELD_DP64(t, ID_AA64ISAR1, JSCVT, 1);    /* FEAT_JSCVT */
     t = FIELD_DP64(t, ID_AA64ISAR1, FCMA, 1);     /* FEAT_FCMA */
diff --git a/target/arm/tcg/pauth_helper.c b/target/arm/tcg/pauth_helper.c
index 63e1009ea7..b6aeb90548 100644
--- a/target/arm/tcg/pauth_helper.c
+++ b/target/arm/tcg/pauth_helper.c
@@ -353,7 +353,9 @@ static uint64_t pauth_addpac(CPUARMState *env, uint64_t ptr, uint64_t modifier,
      */
     test = sextract64(ptr, bot_bit, top_bit - bot_bit);
     if (test != 0 && test != -1) {
-        if (pauth_feature == PauthFeat_EPAC) {
+        if (pauth_feature >= PauthFeat_2) {
+            /* No action required */
+        } else if (pauth_feature == PauthFeat_EPAC) {
             pac = 0;
         } else {
             /*
@@ -368,6 +370,9 @@ static uint64_t pauth_addpac(CPUARMState *env, uint64_t ptr, uint64_t modifier,
      * Preserve the determination between upper and lower at bit 55,
      * and insert pointer authentication code.
      */
+    if (pauth_feature >= PauthFeat_2) {
+        pac ^= ptr;
+    }
     if (param.tbi) {
         ptr &= ~MAKE_64BIT_MASK(bot_bit, 55 - bot_bit + 1);
         pac &= MAKE_64BIT_MASK(bot_bit, 54 - bot_bit + 1);
@@ -394,18 +399,26 @@ static uint64_t pauth_original_ptr(uint64_t ptr, ARMVAParameters param)
 static uint64_t pauth_auth(CPUARMState *env, uint64_t ptr, uint64_t modifier,
                            ARMPACKey *key, bool data, int keynumber)
 {
+    ARMCPU *cpu = env_archcpu(env);
     ARMMMUIdx mmu_idx = arm_stage1_mmu_idx(env);
     ARMVAParameters param = aa64_va_parameters(env, ptr, mmu_idx, data, false);
+    ARMPauthFeature pauth_feature = cpu_isar_feature(pauth_feature, cpu);
     int bot_bit, top_bit;
-    uint64_t pac, orig_ptr, test;
+    uint64_t pac, orig_ptr, cmp_mask;
 
     orig_ptr = pauth_original_ptr(ptr, param);
     pac = pauth_computepac(env, orig_ptr, modifier, *key);
     bot_bit = 64 - param.tsz;
     top_bit = 64 - 8 * param.tbi;
 
-    test = (pac ^ ptr) & ~MAKE_64BIT_MASK(55, 1);
-    if (unlikely(extract64(test, bot_bit, top_bit - bot_bit))) {
+    cmp_mask = MAKE_64BIT_MASK(bot_bit, top_bit - bot_bit);
+    cmp_mask &= ~MAKE_64BIT_MASK(55, 1);
+
+    if (pauth_feature >= PauthFeat_2) {
+        return ptr ^ (pac & cmp_mask);
+    }
+
+    if ((pac ^ ptr) & cmp_mask) {
         int error_code = (keynumber << 1) | (keynumber ^ 1);
         if (param.tbi) {
             return deposit64(orig_ptr, 53, 2, error_code);
-- 
2.34.1


