Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1FC736C2C
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 14:45:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBaiw-0001f7-UK; Tue, 20 Jun 2023 08:44:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBais-0001bQ-PY
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 08:44:38 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBaiq-000232-Q2
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 08:44:38 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-51a20138617so6475192a12.2
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 05:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687265075; x=1689857075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pwtewtSNTpSONPyBLmZuBuFoTg9ObSjoVeJpdVVh5D0=;
 b=n5qRUEQt+lDjoQuxmllGGhV4vV7TqCOOarRYwKPjptmc5GQM8EO7j+4C6qCJR7LoVL
 ZmUmSx8/80jQwFRBGQq/j8FsV7RVPyss//WlbqB+Qf24kUuMe0Zvn80oFcMKGFRKo2tD
 sdlDyh5o93NlGvbOcHoP64OVBkHIIm7Blt7fV11k1qkuFKfts957G1Q4fB0Ahtp7N8wx
 bLqGFUyajWHrC5QDA3JDv+87dgiWbadxl3HYn+nzliMZkNfamIPVC/uRQCof1f93PBR5
 8ffSJ0wHQ3lu4qna2My50USCL7jKv3kfElw7cF/QTg4R+s9GomqLdbc8We+CE9Ha84jx
 DIDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687265075; x=1689857075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pwtewtSNTpSONPyBLmZuBuFoTg9ObSjoVeJpdVVh5D0=;
 b=RXORoTmA54wy/jJ0oHcGb1V4IhcXa3foWJBZK70G88HO/qyZOV22JahE4Gqqkg4RXx
 KT4Mq8SjA0gERqjLF1Pog97oqVadVEmGvNyB0gg6xX0PJrpdZdOvBax0rGm24ukcllXG
 gsQ1Mee0cOEQKEfEtdxgx1sIK/mA5t9PLxPs8Mml1qGKSNQ+og1hVnMjD/m6gbQS4RiI
 pZZla1JREEGCMqxKoUZVsIX7/BETU9W4YtyjDRodU4KmVKTm/37DCZyp7tXMJmjRHTgX
 oqm9v+z1vdzXfcThTheb8Pg+6gBOcP0zfaMp+MMmn3xPMM5TbePIfQQnaORlMtSsvEiK
 zRFg==
X-Gm-Message-State: AC+VfDz9M06K+rE22Q4QBhGuMHYlS6oX/5EKv4YkBFn/cRiwuUBJTkT/
 ErdjB7Ahy/2IUurnSB54Gu+ccAF1OzC/tcRmevZhKGcW
X-Google-Smtp-Source: ACHHUZ4Vj4688j5kTYfQqsKLPDY+Gcy5+lU/LZefZIxavI2RnHAjmcW0uW2JPbMr1L0ARHR1AF8MwQ==
X-Received: by 2002:aa7:d855:0:b0:51a:594d:c1f4 with SMTP id
 f21-20020aa7d855000000b0051a594dc1f4mr4551017eds.24.1687265075279; 
 Tue, 20 Jun 2023 05:44:35 -0700 (PDT)
Received: from stoup.lan ([176.176.183.29]) by smtp.gmail.com with ESMTPSA id
 w9-20020aa7dcc9000000b0051a313a66e8sm1142541edu.45.2023.06.20.05.44.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 05:44:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v5 15/20] target/arm: Move s1_is_el0 into S1Translate
Date: Tue, 20 Jun 2023 14:44:13 +0200
Message-Id: <20230620124418.805717-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230620124418.805717-1-richard.henderson@linaro.org>
References: <20230620124418.805717-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x52d.google.com
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

Instead of passing this to get_phys_addr_lpae, stash it
in the S1Translate structure.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 6d5e4855a3..558b4b731b 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -24,6 +24,12 @@ typedef struct S1Translate {
     ARMSecuritySpace in_space;
     bool in_secure;
     bool in_debug;
+    /*
+     * If this is stage 2 of a stage 1+2 page table walk, then this must
+     * be true if stage 1 is an EL0 access; otherwise this is ignored.
+     * Stage 2 is indicated by in_mmu_idx set to ARMMMUIdx_Stage2{,_S}.
+     */
+    bool in_s1_is_el0;
     bool out_secure;
     bool out_rw;
     bool out_be;
@@ -34,8 +40,7 @@ typedef struct S1Translate {
 } S1Translate;
 
 static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
-                               uint64_t address,
-                               MMUAccessType access_type, bool s1_is_el0,
+                               uint64_t address, MMUAccessType access_type,
                                GetPhysAddrResult *result, ARMMMUFaultInfo *fi);
 
 static bool get_phys_addr_with_struct(CPUARMState *env, S1Translate *ptw,
@@ -1289,17 +1294,12 @@ static int check_s2_mmu_setup(ARMCPU *cpu, bool is_aa64, uint64_t tcr,
  * @ptw: Current and next stage parameters for the walk.
  * @address: virtual address to get physical address for
  * @access_type: MMU_DATA_LOAD, MMU_DATA_STORE or MMU_INST_FETCH
- * @s1_is_el0: if @ptw->in_mmu_idx is ARMMMUIdx_Stage2
- *             (so this is a stage 2 page table walk),
- *             must be true if this is stage 2 of a stage 1+2
- *             walk for an EL0 access. If @mmu_idx is anything else,
- *             @s1_is_el0 is ignored.
  * @result: set on translation success,
  * @fi: set to fault info if the translation fails
  */
 static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
                                uint64_t address,
-                               MMUAccessType access_type, bool s1_is_el0,
+                               MMUAccessType access_type,
                                GetPhysAddrResult *result, ARMMMUFaultInfo *fi)
 {
     ARMCPU *cpu = env_archcpu(env);
@@ -1635,7 +1635,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
             result->f.prot = get_S2prot_noexecute(ap);
         } else {
             xn = extract64(attrs, 53, 2);
-            result->f.prot = get_S2prot(env, ap, xn, s1_is_el0);
+            result->f.prot = get_S2prot(env, ap, xn, ptw->in_s1_is_el0);
         }
     } else {
         int nse, ns = extract32(attrs, 5, 1);
@@ -2858,7 +2858,6 @@ static bool get_phys_addr_twostage(CPUARMState *env, S1Translate *ptw,
     bool ret, ipa_secure;
     ARMCacheAttrs cacheattrs1;
     ARMSecuritySpace ipa_space;
-    bool is_el0;
     uint64_t hcr;
 
     ret = get_phys_addr_with_struct(env, ptw, address, access_type, result, fi);
@@ -2872,7 +2871,7 @@ static bool get_phys_addr_twostage(CPUARMState *env, S1Translate *ptw,
     ipa_secure = result->f.attrs.secure;
     ipa_space = result->f.attrs.space;
 
-    is_el0 = ptw->in_mmu_idx == ARMMMUIdx_Stage1_E0;
+    ptw->in_s1_is_el0 = ptw->in_mmu_idx == ARMMMUIdx_Stage1_E0;
     ptw->in_mmu_idx = ipa_secure ? ARMMMUIdx_Stage2_S : ARMMMUIdx_Stage2;
     ptw->in_secure = ipa_secure;
     ptw->in_space = ipa_space;
@@ -2891,8 +2890,7 @@ static bool get_phys_addr_twostage(CPUARMState *env, S1Translate *ptw,
         ret = get_phys_addr_pmsav8(env, ipa, access_type,
                                    ptw->in_mmu_idx, is_secure, result, fi);
     } else {
-        ret = get_phys_addr_lpae(env, ptw, ipa, access_type,
-                                 is_el0, result, fi);
+        ret = get_phys_addr_lpae(env, ptw, ipa, access_type, result, fi);
     }
     fi->s2addr = ipa;
 
@@ -3078,8 +3076,7 @@ static bool get_phys_addr_with_struct(CPUARMState *env, S1Translate *ptw,
     }
 
     if (regime_using_lpae_format(env, mmu_idx)) {
-        return get_phys_addr_lpae(env, ptw, address, access_type, false,
-                                  result, fi);
+        return get_phys_addr_lpae(env, ptw, address, access_type, result, fi);
     } else if (arm_feature(env, ARM_FEATURE_V7) ||
                regime_sctlr(env, mmu_idx) & SCTLR_XP) {
         return get_phys_addr_v6(env, ptw, address, access_type, result, fi);
-- 
2.34.1


