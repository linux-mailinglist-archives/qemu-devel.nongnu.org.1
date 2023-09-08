Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2298798B3A
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 19:08:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeew0-0005N9-EI; Fri, 08 Sep 2023 13:06:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeevy-0005Fs-AE
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 13:06:18 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeevn-000177-U1
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 13:06:18 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-400a087b0bfso24194985e9.2
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 10:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694192764; x=1694797564; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=H77fDslYA9MGix1dfpbpNI3pKwapk6bXtLEuISrmSAs=;
 b=vMHj4sVkGuxge0sKIoLrPZS4IAWEDno81nDZqFRVYgk7Ydgp014kERPzgwdpOjU/Pj
 KwKLDECaqzIJ8JsNFihRb28RUuXmpQ9214Ox7817gHN0hyJ9agD2qcrbKtsG5eh0JTJa
 quIj+B+tQDRjLZXM6WMEgQrJ1MzE+DG8jWwz6uR8fWVzSNzIcKZsq3WQvdUvWXFuG2zI
 molHL7gtxKfNF9UxJWEBFFKNiXyXhPuEcCb54WnCSpTEgLh5KDBcySYxB+BV3/ELOjC8
 rI7EASC3q5RupuD5V617qSgObaufLDC2XoT4FLSvf05GCJ7yjs4rdTBCkmaGJUpHg2Bs
 fFCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694192764; x=1694797564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H77fDslYA9MGix1dfpbpNI3pKwapk6bXtLEuISrmSAs=;
 b=H79oGFi9eCHC39xusGYEl/w/+tFK5X4xJZlz/kYqf59PEHeGk2Lgsd/rYYvEh5tBhX
 /8UgJx1Wbuj4q40L5MyT6KnBqtl8gEev9B2fqLbNeAFtqUb4BBmzoRvwYhlIy72xRUgd
 RyKr8mKjvLSzFZ+N6nNCqYXFutsH5lcyagu8dpZrgUZjIGhQx576/dy9cpIGjjCEIF8e
 b2C5b6GA6d5ma9HnBDpGLkKW9pPYviwt+YfdsvWXd+KXBeno1hCLcmG8mDXqjIpNeOy2
 M8Fcv0tL/iIPUEgufxgBzGTsN1MmI1pPMvRJ80gbv3C78iecsvf9Y6K3i3NYrj2sYBGd
 V5ow==
X-Gm-Message-State: AOJu0Yy75971m1OvjtTfaXB0PEJXofF74QQAok4vrzrSyheNJ0LTD/NR
 rtZ90yqdC8i+s1WajGJX1fbr2YaH491Ev0yAt0Y=
X-Google-Smtp-Source: AGHT+IG/pQwo8KGQZ8uHTT6yTK6/WQEn1YvWcNAXLEd/J7ICyZ2sw0mzD3X5j1B/A9cXM3upHAPf2w==
X-Received: by 2002:a05:600c:285:b0:401:d258:ad26 with SMTP id
 5-20020a05600c028500b00401d258ad26mr2515239wmk.19.1694192763760; 
 Fri, 08 Sep 2023 10:06:03 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 d21-20020a1c7315000000b00400268671c6sm2427152wmb.13.2023.09.08.10.06.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 10:06:03 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/26] target/arm: Implement FEAT_Pauth2
Date: Fri,  8 Sep 2023 18:05:38 +0100
Message-Id: <20230908170557.773048-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230908170557.773048-1-peter.maydell@linaro.org>
References: <20230908170557.773048-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230829232335.965414-8-richard.henderson@linaro.org
Message-Id: <20230609172324.982888-6-aaron@os.amperecomputing.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst |  1 +
 target/arm/tcg/cpu64.c        |  2 +-
 target/arm/tcg/pauth_helper.c | 21 +++++++++++++++++----
 3 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 2e99888a6ae..b5a667527b5 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -65,6 +65,7 @@ the following architecture extensions:
 - FEAT_PAN2 (AT S1E1R and AT S1E1W instruction variants affected by PSTATE.PAN)
 - FEAT_PAN3 (Support for SCTLR_ELx.EPAN)
 - FEAT_PAuth (Pointer authentication)
+- FEAT_PAuth2 (Enhacements to pointer authentication)
 - FEAT_PMULL (PMULL, PMULL2 instructions)
 - FEAT_PMUv3p1 (PMU Extensions v3.1)
 - FEAT_PMUv3p4 (PMU Extensions v3.4)
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index b6a820aae74..be103702505 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -803,7 +803,7 @@ void aarch64_max_tcg_initfn(Object *obj)
 
     t = cpu->isar.id_aa64isar1;
     t = FIELD_DP64(t, ID_AA64ISAR1, DPB, 2);      /* FEAT_DPB2 */
-    t = FIELD_DP64(t, ID_AA64ISAR1, APA, PauthFeat_EPAC);
+    t = FIELD_DP64(t, ID_AA64ISAR1, APA, PauthFeat_2);
     t = FIELD_DP64(t, ID_AA64ISAR1, API, 1);
     t = FIELD_DP64(t, ID_AA64ISAR1, JSCVT, 1);    /* FEAT_JSCVT */
     t = FIELD_DP64(t, ID_AA64ISAR1, FCMA, 1);     /* FEAT_FCMA */
diff --git a/target/arm/tcg/pauth_helper.c b/target/arm/tcg/pauth_helper.c
index 63e1009ea74..b6aeb905480 100644
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


