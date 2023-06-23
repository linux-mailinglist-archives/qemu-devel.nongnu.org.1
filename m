Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A65F773B7DC
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 14:44:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCfxK-0002WL-Pm; Fri, 23 Jun 2023 08:32:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCfx8-0001ik-8q
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:31:50 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCfx4-0000hC-7F
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:31:49 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-4f86fbe5e4fso663646e87.2
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 05:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687523504; x=1690115504;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=E9T6WGTnhMNzMfi/wBGsxoG9ONEdvhDohJofGPL8F+Y=;
 b=GnPJGhZyemw1xAu4p9RfLsfBS5b2D2/3NW35kEPSNy2ZwDUnbjP2pWj0EtmVBIdZz/
 TJJAl0FIWeXe1sgKvEjAHpuYMKk6GmBBwedxRaQot/RvBTUJwr5djIh5nHwCu6kBp0LW
 hJAJavFjK9TSCXssF7Sz35vRqFNJOtUHpfZr3xIHhF/tHgMYvYJk9OWHAeWxhst0ddGh
 LhgeatUg0lXxn6NSAeBjDpBeblxf6HllaWy8fFJMN+O+XJyssJomt/SbeWFT7+B863eY
 B+PIyfygu4AdgntANdNLbOovfBMn9J2hhMVJnNhCbYkikcf/O9+qKv8bpPvwt0P/0Ot1
 TiRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687523504; x=1690115504;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E9T6WGTnhMNzMfi/wBGsxoG9ONEdvhDohJofGPL8F+Y=;
 b=V1LbsbCXPCOUpsD2C/tDYvkjbuS2etH55eScz9c995PGguM9DQ/0DfJw6xQULjlgGd
 QwVNUhdQ8JyIs+7w2VGo3FubGKdc4D280JGP9Zv6/gmL8MpVqxMvm2V+J5k+8n3h1VtE
 rzPJe2E+5pJjLn1nGuQXMkoVEIcDrlu9wcvJZnKEdT5b+rXixXfoxuDbLdWSJJOT2/I8
 SsMlcSj05/QjlK048gWygUBbcIE6XhpHtujvPNKOm+D4Kx6EoZGIWSdsbV/xHoXpBnAp
 x0sYLXm4vK5y0I0YGLxH+KY4DZPG8I7/cFU1TAf1kKKZtVdK2wQTO8jeJ580oBsoa5/E
 GqKA==
X-Gm-Message-State: AC+VfDyj7svdBVzIZ5/d8ePSVwCIVDEPxVaLF4Gn9sUp5uR5QRuPmQkd
 RUYK70GjoZn5KcQ3BtUzP1wdJx0wSN3p9Kog7B4=
X-Google-Smtp-Source: ACHHUZ65W+WcKGJ/6CRPc6BRtPBJCwre7SHAewU10WnYSuvATe1hVvbZ/q/nezasrme0xdL/eeYL0g==
X-Received: by 2002:a05:6512:ba3:b0:4f9:5f97:29cc with SMTP id
 b35-20020a0565120ba300b004f95f9729ccmr5813654lfv.20.1687523504584; 
 Fri, 23 Jun 2023 05:31:44 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a1c4c07000000b003f819dfa0ddsm2232622wmf.28.2023.06.23.05.31.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 05:31:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/26] target/arm: Move s1_is_el0 into S1Translate
Date: Fri, 23 Jun 2023 13:31:24 +0100
Message-Id: <20230623123135.1788191-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230623123135.1788191-1-peter.maydell@linaro.org>
References: <20230623123135.1788191-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x131.google.com
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

Instead of passing this to get_phys_addr_lpae, stash it
in the S1Translate structure.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230620124418.805717-16-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/ptw.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 6d5e4855a33..558b4b731b8 100644
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


