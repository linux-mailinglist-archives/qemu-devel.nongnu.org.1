Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CBB73B762
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 14:34:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCfxF-0001rG-ET; Fri, 23 Jun 2023 08:31:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCfx4-0001WK-4T
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:31:46 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCfx2-0000gH-0g
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:31:45 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3f9bff0a543so7419255e9.3
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 05:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687523502; x=1690115502;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Elm3K85n/1C5vgvpUJI3MqZjTZ7FhsJZsoCqFaAClpQ=;
 b=eh7gNwtVw6pZD0l7+mW73ZRCA5EJJPqbym4TacgPxQ5JSgLYq+UEt7rVx2Vipx/I/+
 KHEdhXaVSi2+rvEW8EiTkWmYq0uV5MeJVGvYGhAS8rw/eWyFwX1xvhDwpTPTbLPPLlSn
 0/4TNY+j4A5xeSMSpO7QTglutLt1TDlVvizfIbEoeM4RdLcqa07sCu+0tSlhuwMcRoHE
 UTf3LaC4lEt2/xbOKcXsKWF7xtQr2x2VAOtvJCGlPV3jJl5EcgWrhjgytLCfJvZn+0L7
 tAXf6QLX89ZmvWa6RAOCKay9rs3HrgZTEfPyNEtHrAYtvoYHiCXjM5877yhirwbYDzJE
 6cvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687523502; x=1690115502;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Elm3K85n/1C5vgvpUJI3MqZjTZ7FhsJZsoCqFaAClpQ=;
 b=IhfJAW40lQB6XOu8n5uA9tSkEpZ50wiL0CDoj/236MIUx1f2grhGQK36PdgyaFvCEF
 d3cWwJUK1lrzlNsQ3vzkhoCLUPxI0T8ULp+4knsXP8d6Si/edZdqAcJbl/uiDUOSxpXv
 gbk06wkC3loR9bZ/Rrb4k9Zb7vuDObPTVDYHWUBB+X/+Y7q0NAKXps9Qj7Lx+yD86yd8
 KcP4gzdmbgYan10s3jpELGyVw3xwML6QWHhiBMoxZ/XdddX+6axANbDvnZ7KP9Q4H7bx
 xUu2iqj17ga2z3r8bKTGBMngOee1rTnir0EDyjoR37gACY98i5UMTjX1T1DHRYhiYlgY
 uLnw==
X-Gm-Message-State: AC+VfDzk7TNmAeefVuaiAb5LthFn3CI0/BqA//2QAoaHQB0BgftjEWP3
 1YiEp4tdtQj13qibXjjc4daySyAhfzRgZf1oXgw=
X-Google-Smtp-Source: ACHHUZ4w44TzuH6V1PN+OkvCuA4cjT0MIneqOEywxjs+Ujvz0fTH7sp27eyzTpaczxq0PDHhTQJj8w==
X-Received: by 2002:a05:600c:204d:b0:3fa:7810:8cca with SMTP id
 p13-20020a05600c204d00b003fa78108ccamr2924687wmg.26.1687523502642; 
 Fri, 23 Jun 2023 05:31:42 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a1c4c07000000b003f819dfa0ddsm2232622wmf.28.2023.06.23.05.31.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 05:31:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/26] target/arm: NSTable is RES0 for the RME EL3 regime
Date: Fri, 23 Jun 2023 13:31:20 +0100
Message-Id: <20230623123135.1788191-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230623123135.1788191-1-peter.maydell@linaro.org>
References: <20230623123135.1788191-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Test in_space instead of in_secure so that we don't
switch out of Root space.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230620124418.805717-12-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/ptw.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index e1e7c9a3d22..ea0ad56f13e 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -1275,7 +1275,6 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
 {
     ARMCPU *cpu = env_archcpu(env);
     ARMMMUIdx mmu_idx = ptw->in_mmu_idx;
-    bool is_secure = ptw->in_secure;
     int32_t level;
     ARMVAParameters param;
     uint64_t ttbr;
@@ -1291,7 +1290,6 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
     uint64_t descaddrmask;
     bool aarch64 = arm_el_is_aa64(env, el);
     uint64_t descriptor, new_descriptor;
-    bool nstable;
 
     /* TODO: This code does not support shareability levels. */
     if (aarch64) {
@@ -1453,21 +1451,21 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
         descaddrmask = MAKE_64BIT_MASK(0, 40);
     }
     descaddrmask &= ~indexmask_grainsize;
-
-    /*
-     * Secure stage 1 accesses start with the page table in secure memory and
-     * can be downgraded to non-secure at any step. Non-secure accesses
-     * remain non-secure. We implement this by just ORing in the NSTable/NS
-     * bits at each step.
-     * Stage 2 never gets this kind of downgrade.
-     */
-    tableattrs = is_secure ? 0 : (1 << 4);
+    tableattrs = 0;
 
  next_level:
     descaddr |= (address >> (stride * (4 - level))) & indexmask;
     descaddr &= ~7ULL;
-    nstable = !regime_is_stage2(mmu_idx) && extract32(tableattrs, 4, 1);
-    if (nstable && ptw->in_secure) {
+
+    /*
+     * Process the NSTable bit from the previous level.  This changes
+     * the table address space and the output space from Secure to
+     * NonSecure.  With RME, the EL3 translation regime does not change
+     * from Root to NonSecure.
+     */
+    if (ptw->in_space == ARMSS_Secure
+        && !regime_is_stage2(mmu_idx)
+        && extract32(tableattrs, 4, 1)) {
         /*
          * Stage2_S -> Stage2 or Phys_S -> Phys_NS
          * Assert the relative order of the secure/non-secure indexes.
@@ -1476,7 +1474,9 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
         QEMU_BUILD_BUG_ON(ARMMMUIdx_Stage2_S + 1 != ARMMMUIdx_Stage2);
         ptw->in_ptw_idx += 1;
         ptw->in_secure = false;
+        ptw->in_space = ARMSS_NonSecure;
     }
+
     if (!S1_ptw_translate(env, ptw, descaddr, fi)) {
         goto do_fault;
     }
@@ -1579,7 +1579,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
      */
     attrs = new_descriptor & (MAKE_64BIT_MASK(2, 10) | MAKE_64BIT_MASK(50, 14));
     if (!regime_is_stage2(mmu_idx)) {
-        attrs |= nstable << 5; /* NS */
+        attrs |= !ptw->in_secure << 5; /* NS */
         if (!param.hpd) {
             attrs |= extract64(tableattrs, 0, 2) << 53;     /* XN, PXN */
             /*
-- 
2.34.1


