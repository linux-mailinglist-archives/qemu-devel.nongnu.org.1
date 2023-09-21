Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4C27A9B33
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 20:55:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjOpB-0002DL-CT; Thu, 21 Sep 2023 14:54:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qjOpA-0002DA-2q
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 14:54:52 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qjOp8-0006OR-3Q
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 14:54:51 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-31dd10c2b8bso1302508f8f.3
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 11:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695322487; x=1695927287; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=sqjX+Qa5UKaKX85hr+XzR9jndKCAoKkj1gkGqjAhUAE=;
 b=XDKgjK30yjx5sr30rdTX+/Of2zxYBF8jbP7omFVoHSAhmRA6Uq63vk8wOXJrWe5hRP
 PXoKQ/RfS9OERfA69u96RHx/H/KCw/QPM3Z8YPTsgX6d6vt/SXVIa9ZjN/ExXfV/sECV
 9VjtjHMMbR/GPxGHKPnVDBdFB3zlsnCslxcxOjaRZdGKw6y5igezArtt5U4DsY1RkvJC
 YaJ98exSQDSMggVn8kzL6/WQHFyPegnAfp0qU+IiQjwePI81CMIEyHeZ9gxudBJKAf+W
 IWpckoX1QR08piIq5hk7fKnkketIqLwgTk5UYTxX9ThTv9mi7DXy3KEJKdaa8Yna7d0e
 Ef1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695322487; x=1695927287;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sqjX+Qa5UKaKX85hr+XzR9jndKCAoKkj1gkGqjAhUAE=;
 b=IF5eyA9sc+llfa+PYEaFe59f2fMT87jeb5Lu+3zRCIk41Z6EpBijtfLE9mgLwk5Cst
 0DpdaSYkeNJJZRuGP61cVwyY6YRTJF98oPMkXYuF1r7vGhkEKOG93v3CtIlPIwHSTmab
 XuJZfkSpyAcc9Hj8h7/+jADcO0duujRNIhOwD+/aDwiLT9l9Kx4g6NWDzp4Fj0QMYpZs
 rFp5h+k0o1f345nMpnom7ld74odqTLVgmQ+O8sfRkQd35z5chs4M0ld1+ZcN5/FA60mK
 aCvoKl3nb6bzRcsUj/Dn48Jq7ScPD6PRrJD8XsF/94px4eTjf5HPmiBZcD/L+knqF/kf
 q2CA==
X-Gm-Message-State: AOJu0Yxcqtmu3kSzAO6k67Pc6O9dzjZq1XE+Z5TnTgOtvJpkxc2qJas/
 CdWk8zOE/4PA1Wif2ezd8+hxB0wOu/2voclkXWA=
X-Google-Smtp-Source: AGHT+IHJ6urbWf8GGr12sWXvlDuaUlxQuObP8aVzJRhSOFvtgpVU0a9etyEeF5EGv2Up9ZjMJf3QZw==
X-Received: by 2002:a05:6000:1f95:b0:321:8d08:855e with SMTP id
 bw21-20020a0560001f9500b003218d08855emr2661636wrb.24.1695322487277; 
 Thu, 21 Sep 2023 11:54:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 17-20020a05600c229100b00401b242e2e6sm5472913wmf.47.2023.09.21.11.54.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 11:54:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] target/arm: Implement FEAT_HPMN0
Date: Thu, 21 Sep 2023 19:54:45 +0100
Message-Id: <20230921185445.3339214-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

FEAT_HPMN0 is a small feature which defines that it is valid for
MDCR_EL2.HPMN to be set to 0, meaning "no PMU event counters provided
to an EL1 guest" (previously this setting was reserved). QEMU's
implementation almost gets HPMN == 0 right, but we need to fix
one check in pmevcntr_is_64_bit(). That is enough for us to
advertise the feature in the 'max' CPU.

(We don't need to make the behaviour conditional on feature
presence, because the FEAT_HPMN0 behaviour is within the range
of permitted UNPREDICTABLE behaviour for a non-FEAT_HPMN0
implementation.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 target/arm/helper.c           | 2 +-
 target/arm/tcg/cpu32.c        | 4 ++++
 target/arm/tcg/cpu64.c        | 1 +
 4 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 3df936fc356..b19ea198c24 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -45,6 +45,7 @@ the following architecture extensions:
 - FEAT_HCX (Support for the HCRX_EL2 register)
 - FEAT_HPDS (Hierarchical permission disables)
 - FEAT_HPDS2 (Translation table page-based hardware attributes)
+- FEAT_HPMN0 (Setting of MDCR_EL2.HPMN to zero)
 - FEAT_I8MM (AArch64 Int8 matrix multiplication instructions)
 - FEAT_IDST (ID space trap handling)
 - FEAT_IESB (Implicit error synchronization event)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 3b22596eabf..ea3e5c6fd0f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1283,7 +1283,7 @@ static bool pmevcntr_is_64_bit(CPUARMState *env, int counter)
         bool hlp = env->cp15.mdcr_el2 & MDCR_HLP;
         int hpmn = env->cp15.mdcr_el2 & MDCR_HPMN;
 
-        if (hpmn != 0 && counter >= hpmn) {
+        if (counter >= hpmn) {
             return hlp;
         }
     }
diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index 1f918ff5375..0d5d8e307dd 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -89,6 +89,10 @@ void aa32_max_features(ARMCPU *cpu)
     t = FIELD_DP32(t, ID_DFR0, COPSDBG, 9);       /* FEAT_Debugv8p4 */
     t = FIELD_DP32(t, ID_DFR0, PERFMON, 6);       /* FEAT_PMUv3p5 */
     cpu->isar.id_dfr0 = t;
+
+    t = cpu->isar.id_dfr1;
+    t = FIELD_DP32(t, ID_DFR1, HPMN0, 1);         /* FEAT_HPMN0 */
+    cpu->isar.id_dfr1 = t;
 }
 
 /* CPU models. These are not needed for the AArch64 linux-user build. */
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 7264ab5ead1..ee369f10db6 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1104,6 +1104,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = cpu->isar.id_aa64dfr0;
     t = FIELD_DP64(t, ID_AA64DFR0, DEBUGVER, 9);  /* FEAT_Debugv8p4 */
     t = FIELD_DP64(t, ID_AA64DFR0, PMUVER, 6);    /* FEAT_PMUv3p5 */
+    t = FIELD_DP64(t, ID_AA64DFR0, HPMN0, 1);     /* FEAT_HPMN0 */
     cpu->isar.id_aa64dfr0 = t;
 
     t = cpu->isar.id_aa64smfr0;
-- 
2.34.1


