Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F97A78D08D
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:27:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb83t-0003vm-8k; Tue, 29 Aug 2023 19:23:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb83p-0003fi-3t
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 19:23:49 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb83k-0001N1-9A
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 19:23:48 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-68bed286169so4261470b3a.1
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 16:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693351423; x=1693956223; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dSHDOqmpvVqWZn7zJjJYDufm+wpdwBxF2KdyWkAtGiQ=;
 b=RBXDMiCAbVEWOh24jzMgBq9SwBVpcHnOk3/ikUpgslogFgev87rbJIm9UFqTo99h+1
 xI/c5F72Riu/P1YyUly9Vzy5UkBORtDJ3bp6J8I+1yNXvA/o3NnZb4KRLeIRk/UphrbX
 hW8zThsIEkc6sc7aDqZutKsJqxklxuA6SYQ8JQf/arAmCVrJX+vqql911fc9ankbDXbK
 8zdktD6Tu9TqgbdmreLutguBDRk3MkIRvANfuXrx0ujcr36LqqgyvvqBJXgTgqLNUnyQ
 Upn2d4l51zR3aGhgD3fpPanjaCVMAC6SPsIY8O9IyCGlnYZogNQVicPLVmH1E2diqFrD
 aUxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693351423; x=1693956223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dSHDOqmpvVqWZn7zJjJYDufm+wpdwBxF2KdyWkAtGiQ=;
 b=dikAqFaou1mgclySXlrATd0xmurlIUTedLix+h0lKssUOviXfCY7NG9yL/jcSNrwJ8
 XvWHvFy4J68DR9VRC2Lntew/hzLJgyEs5IZiFKpwWQaUgYVc+zHX47X3suezLpPtGJQZ
 0m++OT5B7jjrIJlgzbeVxx3ZhRw4OmSAd8wi4CIW/OHDLYKiz1Bb2ab0C886qyDfudvz
 TxKiqtWf7ypVZc1mLa2UuxtZVGRHljH6bXadjdTfj23esjrhsmw/BeSff/K3dGoeh/dK
 6sz6HujeHBcFws7ul5Y2WVSZeDtibrrq49YHyAPM8c9xXJ+QfPWkg23sNzW+E65iwX8g
 Ejkg==
X-Gm-Message-State: AOJu0YwBbuegMJuLqfC0Hvxru5+pqab9xClPw4FOVJMXplhpP11vfn7I
 Gjd0+hZp/7ds5L2h1KfkIsVnXggCIdWcXPEbGq8=
X-Google-Smtp-Source: AGHT+IHO50E7tTBjS/eaarB7jCSxrsGpZlg4wQs/Z+sNtjmWIpeLSCNl0WBOd0g98vYXQlrmTM2mPw==
X-Received: by 2002:a05:6a20:4c84:b0:148:d5d9:aaa9 with SMTP id
 fq4-20020a056a204c8400b00148d5d9aaa9mr554519pzb.33.1693351422849; 
 Tue, 29 Aug 2023 16:23:42 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 t9-20020a170902e84900b001b9dadf8bd2sm9829970plg.190.2023.08.29.16.23.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 16:23:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: aaron@os.amperecomputing.com, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v5 06/12] target/arm: Implement FEAT_EPAC
Date: Tue, 29 Aug 2023 16:23:29 -0700
Message-Id: <20230829232335.965414-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230829232335.965414-1-richard.henderson@linaro.org>
References: <20230829232335.965414-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

From: Aaron Lindsay <aaron@os.amperecomputing.com>

Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230609172324.982888-5-aaron@os.amperecomputing.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/system/arm/emulation.rst |  1 +
 target/arm/tcg/cpu64.c        |  2 +-
 target/arm/tcg/pauth_helper.c | 16 +++++++++++-----
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 06af20d10f..4866a73ca0 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -27,6 +27,7 @@ the following architecture extensions:
 - FEAT_DotProd (Advanced SIMD dot product instructions)
 - FEAT_DoubleFault (Double Fault Extension)
 - FEAT_E0PD (Preventing EL0 access to halves of address maps)
+- FEAT_EPAC (Enhanced pointer authentication)
 - FEAT_ETS (Enhanced Translation Synchronization)
 - FEAT_EVT (Enhanced Virtualization Traps)
 - FEAT_FCMA (Floating-point complex number instructions)
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index fec6a4875d..85bf94ee40 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -758,7 +758,7 @@ void aarch64_max_tcg_initfn(Object *obj)
 
     t = cpu->isar.id_aa64isar1;
     t = FIELD_DP64(t, ID_AA64ISAR1, DPB, 2);      /* FEAT_DPB2 */
-    t = FIELD_DP64(t, ID_AA64ISAR1, APA, PauthFeat_1);
+    t = FIELD_DP64(t, ID_AA64ISAR1, APA, PauthFeat_EPAC);
     t = FIELD_DP64(t, ID_AA64ISAR1, API, 1);
     t = FIELD_DP64(t, ID_AA64ISAR1, JSCVT, 1);    /* FEAT_JSCVT */
     t = FIELD_DP64(t, ID_AA64ISAR1, FCMA, 1);     /* FEAT_FCMA */
diff --git a/target/arm/tcg/pauth_helper.c b/target/arm/tcg/pauth_helper.c
index bb03409ee5..63e1009ea7 100644
--- a/target/arm/tcg/pauth_helper.c
+++ b/target/arm/tcg/pauth_helper.c
@@ -326,8 +326,10 @@ static uint64_t pauth_computepac(CPUARMState *env, uint64_t data,
 static uint64_t pauth_addpac(CPUARMState *env, uint64_t ptr, uint64_t modifier,
                              ARMPACKey *key, bool data)
 {
+    ARMCPU *cpu = env_archcpu(env);
     ARMMMUIdx mmu_idx = arm_stage1_mmu_idx(env);
     ARMVAParameters param = aa64_va_parameters(env, ptr, mmu_idx, data, false);
+    ARMPauthFeature pauth_feature = cpu_isar_feature(pauth_feature, cpu);
     uint64_t pac, ext_ptr, ext, test;
     int bot_bit, top_bit;
 
@@ -351,11 +353,15 @@ static uint64_t pauth_addpac(CPUARMState *env, uint64_t ptr, uint64_t modifier,
      */
     test = sextract64(ptr, bot_bit, top_bit - bot_bit);
     if (test != 0 && test != -1) {
-        /*
-         * Note that our top_bit is one greater than the pseudocode's
-         * version, hence "- 2" here.
-         */
-        pac ^= MAKE_64BIT_MASK(top_bit - 2, 1);
+        if (pauth_feature == PauthFeat_EPAC) {
+            pac = 0;
+        } else {
+            /*
+             * Note that our top_bit is one greater than the pseudocode's
+             * version, hence "- 2" here.
+             */
+            pac ^= MAKE_64BIT_MASK(top_bit - 2, 1);
+        }
     }
 
     /*
-- 
2.34.1


