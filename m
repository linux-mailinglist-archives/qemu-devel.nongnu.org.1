Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4237838C4
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 06:26:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYIxf-0006PI-5U; Tue, 22 Aug 2023 00:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYIxd-0006N0-8G
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 00:25:45 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYIxX-0007XX-Bz
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 00:25:44 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3a8506f5b73so1707731b6e.0
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 21:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692678338; x=1693283138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tz0aWUu/vHl+1ntPEUMfK/rYoMDJR4BjrdL+Cy/mdVs=;
 b=gsTvcKb7tj6IyaLYI0joiqIh8GG+BQZN5WTHB6Mjb6N+Uboh8scCxj6UkhQenyUlMS
 cKdB4kaopQCLoWtgZLp7GityYwmhbTrvyUwd5y+cMJUi4ud//1p3bJF1HwFDDd11CT46
 sQZOzWh9t977dJTz6trxXn9tQNcK12MJ0udJ+J6d8WemrG/qGUkLYnXasg3VUKhTsFTn
 hnmFIzeBg1tgVMoyL+X/EJv7C7XlNIuOchArmlLoD4bgu3fYBsSBSI0s+UqdU0+ogG2l
 DbjbOUZc954EmqlsZbps1PgNvS6F0AXVM2g9Vr8VQ54EUzDWxS7tNqpDY+MW0KVHyiQF
 GjPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692678338; x=1693283138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tz0aWUu/vHl+1ntPEUMfK/rYoMDJR4BjrdL+Cy/mdVs=;
 b=P5XuRTv4mHmr76lNL0nlbdypGC65jTHgIlyUa35wem8zCw1b5512FDLf6SJYpaHl1m
 T/JRoCdVMIi+qTyI6kbLDnUPlF2DX+zD3x+GbIwVztNbhQ8kmhE3y6AfMg7gGzs67QlH
 lee24snDocWntUYqfYxIZU5AobgCv6jWQ//Z+Szf5go3xWa1S1+uu/hTow3JsGIy4KR5
 Kko+Nuwfbs/kZCq3Q0W1KOclx6j+HWZYvpUBcvTPowKd1K7rzUA3xBczCTgY6xDKx9pF
 8wp+O5RyJ2hJ9HD4554YsDmtEU225AzZo/K6rj9Gt21BEbQekGUhAmFE0JG3ts74gjUO
 R2KA==
X-Gm-Message-State: AOJu0YyK/s2UstjiUvOPEyKdi/vQNTiyracKwXu9y5niZf2jtl2lHw37
 5TwW76mrLkp5iJkz3PnA0YAAm948/s7n0Fv0SrY=
X-Google-Smtp-Source: AGHT+IHNZCcNDXkwO1WJIHaJrT3nMPtg5uI7XBujcJgRFT6XfmcJN0yAAOdZyWEYyqAfKRZqJu8jUA==
X-Received: by 2002:a05:6808:1b0b:b0:3a8:5904:1aa8 with SMTP id
 bx11-20020a0568081b0b00b003a859041aa8mr6570206oib.52.1692678337949; 
 Mon, 21 Aug 2023 21:25:37 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:2c08:e710:4459:46f1])
 by smtp.gmail.com with ESMTPSA id
 m14-20020aa7900e000000b0068a3f861b24sm3364908pfo.195.2023.08.21.21.25.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 21:25:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Aaron Lindsay <aaron@os.amperecomputing.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v4 7/9] target/arm: Implement FEAT_Pauth2
Date: Mon, 21 Aug 2023 21:25:28 -0700
Message-Id: <20230822042530.1026751-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230822042530.1026751-1-richard.henderson@linaro.org>
References: <20230822042530.1026751-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22d.google.com
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


