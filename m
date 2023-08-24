Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1B2786BE3
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 11:30:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ6ey-0000Zo-OE; Thu, 24 Aug 2023 05:29:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ6eE-0004YS-QE
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:29:02 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ6e9-000526-Mh
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:29:02 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2b9c907bc68so107676991fa.2
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 02:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692869332; x=1693474132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=R3uDnUtuXKwynZMYVZ6PjqfptEX6AZLjZgO10pyV5SQ=;
 b=ibmISsdEkWosBgWRM4zBEchMrYQCn6TlSVp1Bg3ovLJsHSclte6Vw4UdU2wuLV5kVE
 64kgCriPdQjgunF6aD4iC5WnLbLqsfRFRsLDvcj/F5I1dSGrH/ITtnM/VJoCn9D0s3fL
 SBq/UurkIuh3SA7pELZ9t4zD4zX81aiEuoGrNrjbFg4eLl5Td1x6etF3IAhsccKKXUgY
 WLQkEwWiLfkzoCw6JXwGiWIMcWfiBbPkoWQpsXbe/zg3Pf9oslnBTsGzhnqCRAqhce/F
 QnXGOxUZHUGEVwQ1fSFk3icsI2JygCa5aLeYijLTswW85q1qsAJLbHhRiE7H6ChuTfgm
 RRxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692869332; x=1693474132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R3uDnUtuXKwynZMYVZ6PjqfptEX6AZLjZgO10pyV5SQ=;
 b=evBckTxzRZlHyyhvYd4s1REzoBrbnaLjA4mQmEWqOHCN2mswEVIdlMuXy/6+hqC714
 gxeT0i0pl+pH1HDLSjuNN+lyzQukdI+xGuk5u8RdOYdNgFJj2sWE0dJ70zfvuggW5eo+
 EuTNj0YmhFJaAGR+PDvd1WATIB1k63K/dwn4LWxIu5HYEJndzn1HV56CsxylLqGweW1F
 4tfiJ5o45XqVEREv1Bpzdm0F/Un94N2T+sdNMN/yc2liAiKBIV0GiRTwfI2XfncFoX7F
 8NcxShtY8/pz+YJ235GEE/TDEvk85EBZWLQhPBAP0JImGCYfwK868fuz3G4SRV1nTck9
 5/uQ==
X-Gm-Message-State: AOJu0Yw9NJnzOesqtFSZbApdkh/Xy8OgHLEWI8Wr+nFOGmnS1iPzkSzz
 SVbDvRW4UluAe2jTt+KQWkpgdh43EQYYPR25xug=
X-Google-Smtp-Source: AGHT+IGLMss7cgWegX4MlUpJtUT+3YtOWxpSEBoSPmAhdyNL8hU3Z46vnYlcLdtcYhSiSKEWOuyhzg==
X-Received: by 2002:a2e:730a:0:b0:2b7:33a6:f2c0 with SMTP id
 o10-20020a2e730a000000b002b733a6f2c0mr11442035ljc.4.1692869331792; 
 Thu, 24 Aug 2023 02:28:51 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 s12-20020adfeccc000000b00317b5c8a4f1sm21844004wro.60.2023.08.24.02.28.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 02:28:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/35] target/arm/helper: Fix tlbmask and tlbbits for TLBI VAE2*
Date: Thu, 24 Aug 2023 10:28:30 +0100
Message-Id: <20230824092836.2239644-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824092836.2239644-1-peter.maydell@linaro.org>
References: <20230824092836.2239644-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x231.google.com
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

When HCR_EL2.E2H is enabled, TLB entries are formed using the EL2&0
translation regime, instead of the EL2 translation regime. The TLB VAE2*
instructions invalidate the regime that corresponds to the current value
of HCR_EL2.E2H.

At the moment we only invalidate the EL2 translation regime. This causes
problems with RMM, which issues TLBI VAE2IS instructions with
HCR_EL2.E2H enabled. Update vae2_tlbmask() to take HCR_EL2.E2H into
account.

Add vae2_tlbbits() as well, since the top-byte-ignore configuration is
different between the EL2&0 and EL2 regime.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20230809123706.1842548-3-jean-philippe@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 50 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 40 insertions(+), 10 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index da5db6d3ff6..808f35218a2 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4663,6 +4663,21 @@ static int vae1_tlbmask(CPUARMState *env)
     return mask;
 }
 
+static int vae2_tlbmask(CPUARMState *env)
+{
+    uint64_t hcr = arm_hcr_el2_eff(env);
+    uint16_t mask;
+
+    if (hcr & HCR_E2H) {
+        mask = ARMMMUIdxBit_E20_2 |
+               ARMMMUIdxBit_E20_2_PAN |
+               ARMMMUIdxBit_E20_0;
+    } else {
+        mask = ARMMMUIdxBit_E2;
+    }
+    return mask;
+}
+
 /* Return 56 if TBI is enabled, 64 otherwise. */
 static int tlbbits_for_regime(CPUARMState *env, ARMMMUIdx mmu_idx,
                               uint64_t addr)
@@ -4689,6 +4704,25 @@ static int vae1_tlbbits(CPUARMState *env, uint64_t addr)
     return tlbbits_for_regime(env, mmu_idx, addr);
 }
 
+static int vae2_tlbbits(CPUARMState *env, uint64_t addr)
+{
+    uint64_t hcr = arm_hcr_el2_eff(env);
+    ARMMMUIdx mmu_idx;
+
+    /*
+     * Only the regime of the mmu_idx below is significant.
+     * Regime EL2&0 has two ranges with separate TBI configuration, while EL2
+     * only has one.
+     */
+    if (hcr & HCR_E2H) {
+        mmu_idx = ARMMMUIdx_E20_2;
+    } else {
+        mmu_idx = ARMMMUIdx_E2;
+    }
+
+    return tlbbits_for_regime(env, mmu_idx, addr);
+}
+
 static void tlbi_aa64_vmalle1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                       uint64_t value)
 {
@@ -4781,10 +4815,11 @@ static void tlbi_aa64_vae2_write(CPUARMState *env, const ARMCPRegInfo *ri,
      * flush-last-level-only.
      */
     CPUState *cs = env_cpu(env);
-    int mask = e2_tlbmask(env);
+    int mask = vae2_tlbmask(env);
     uint64_t pageaddr = sextract64(value << 12, 0, 56);
+    int bits = vae2_tlbbits(env, pageaddr);
 
-    tlb_flush_page_by_mmuidx(cs, pageaddr, mask);
+    tlb_flush_page_bits_by_mmuidx(cs, pageaddr, mask, bits);
 }
 
 static void tlbi_aa64_vae3_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -4838,11 +4873,11 @@ static void tlbi_aa64_vae2is_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                    uint64_t value)
 {
     CPUState *cs = env_cpu(env);
+    int mask = vae2_tlbmask(env);
     uint64_t pageaddr = sextract64(value << 12, 0, 56);
-    int bits = tlbbits_for_regime(env, ARMMMUIdx_E2, pageaddr);
+    int bits = vae2_tlbbits(env, pageaddr);
 
-    tlb_flush_page_bits_by_mmuidx_all_cpus_synced(cs, pageaddr,
-                                                  ARMMMUIdxBit_E2, bits);
+    tlb_flush_page_bits_by_mmuidx_all_cpus_synced(cs, pageaddr, mask, bits);
 }
 
 static void tlbi_aa64_vae3is_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -5014,11 +5049,6 @@ static void tlbi_aa64_rvae1is_write(CPUARMState *env,
     do_rvae_write(env, value, vae1_tlbmask(env), true);
 }
 
-static int vae2_tlbmask(CPUARMState *env)
-{
-    return ARMMMUIdxBit_E2;
-}
-
 static void tlbi_aa64_rvae2_write(CPUARMState *env,
                                   const ARMCPRegInfo *ri,
                                   uint64_t value)
-- 
2.34.1


