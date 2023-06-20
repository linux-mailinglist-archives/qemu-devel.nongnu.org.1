Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5C2736624
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 10:28:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBWh6-0003pS-VU; Tue, 20 Jun 2023 04:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBWgy-0003nK-O9
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 04:26:26 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBWgw-00066u-8V
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 04:26:24 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-977e0fbd742so604172366b.2
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 01:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687249580; x=1689841580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WRPMzmYk/CCPO77sVfrTSeKgekjeb0C45UKRtQqYc08=;
 b=Pbj3N6b5bFzGH2uYECBvG23yQHSfnW47WqjvWcFVGQEY46wpWhXG4rQv50VIRyK76z
 djcm4N/kf+YXn/qkKHB07pVbaiR9W3J8AVWqhvqBlPcgUrwwnn7Pb20H0e2l4FlMJL1d
 bxMny6Fc6A9vVRi96pghr3jnjjATgqd19ppTyG1E9ReXJyimenhcyI9thdY+SpJpUHjs
 jTjEw9NB+rPgCbpMjQZjjZXBv+7kgSFnTxLfrYylT0F2ZRD41a1VVlTR6SCR3sKT6H+L
 6kPQkpCPbzgZQNRvKIMiVYkcWZSazUXJcW4VfpD5/RRm4ZbL78tRZZVL+s4BuEYISfIS
 KyIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687249580; x=1689841580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WRPMzmYk/CCPO77sVfrTSeKgekjeb0C45UKRtQqYc08=;
 b=Hk4YSxFM74Lj5PReVu38MTbMpBBrJXxwqQAMiqhbCx4LYhZEAjTZbu3VkG7EI2IXNf
 R+FZ7Wtv9hv4Wnsf+mCtdqziG58sRIhmKCDhoAx8F1cBX/MFFy+d1EGinREmr69C6Eau
 82oOybeoFeKoafvUtUmJ9HtjaaiD7zrCW54MYSIpojyvpMxCQJKQB1zEu6FR/qA9FLHj
 waexFIknItDBDrU/EOfQ0cZQ+iYKl2zCtX04p31GNIq42gn9maxklFW0K5GBbzxWDhh+
 qatt1H4hsmZLV2JihyoNSS1nizeZ9ISEEWobPtAVT11yJg08rx/X7qW9mKVbFFzAvysB
 kH5g==
X-Gm-Message-State: AC+VfDzJ74Z/nP84u2uzhMNwe9rMpi8+FwX8amvTwpwJ6PCEMcpCZIbO
 pY7VWRVtsoGhyxU7AQI//WMqGNJuiGbn36pAWzVHpjXp
X-Google-Smtp-Source: ACHHUZ6RyMCLSl4eMLBJThzbaUWTxoUuPPvWMY0lkj/6r8rwsvShonMUJrZlP7kM4TvYPB+UEDIxbw==
X-Received: by 2002:a17:907:a01:b0:973:d1ce:dbe8 with SMTP id
 bb1-20020a1709070a0100b00973d1cedbe8mr9732469ejc.46.1687249580522; 
 Tue, 20 Jun 2023 01:26:20 -0700 (PDT)
Received: from stoup.lan ([176.176.183.29]) by smtp.gmail.com with ESMTPSA id
 z19-20020a170906669300b00977c7566ccbsm935901ejo.164.2023.06.20.01.26.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 01:26:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PULL 07/16] target/ppc: Check for USER_ONLY definition instead of
 SOFTMMU one
Date: Tue, 20 Jun 2023 10:26:02 +0200
Message-Id: <20230620082611.770620-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230620082611.770620-1-richard.henderson@linaro.org>
References: <20230620082611.770620-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x632.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Since we *might* have user emulation with softmmu,
replace the system emulation check by !user emulation one.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Message-Id: <20230613133347.82210-5-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/cpu_init.c    | 20 ++++++++++----------
 target/ppc/helper_regs.c |  6 ++----
 2 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 9f97222655..7bce421a7c 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -5841,7 +5841,7 @@ POWERPC_FAMILY(970)(ObjectClass *oc, void *data)
                     (1ull << MSR_PMM) |
                     (1ull << MSR_RI);
     pcc->mmu_model = POWERPC_MMU_64B;
-#if defined(CONFIG_SOFTMMU)
+#if !defined(CONFIG_USER_ONLY)
     pcc->hash64_opts = &ppc_hash64_opts_basic;
 #endif
     pcc->excp_model = POWERPC_EXCP_970;
@@ -5920,7 +5920,7 @@ POWERPC_FAMILY(POWER5P)(ObjectClass *oc, void *data)
     pcc->lpcr_mask = LPCR_RMLS | LPCR_ILE | LPCR_LPES0 | LPCR_LPES1 |
         LPCR_RMI | LPCR_HDICE;
     pcc->mmu_model = POWERPC_MMU_2_03;
-#if defined(CONFIG_SOFTMMU)
+#if !defined(CONFIG_USER_ONLY)
     pcc->hash64_opts = &ppc_hash64_opts_basic;
     pcc->lrg_decr_bits = 32;
 #endif
@@ -6037,7 +6037,7 @@ POWERPC_FAMILY(POWER7)(ObjectClass *oc, void *data)
         LPCR_LPES0 | LPCR_LPES1 | LPCR_HDICE;
     pcc->lpcr_pm = LPCR_P7_PECE0 | LPCR_P7_PECE1 | LPCR_P7_PECE2;
     pcc->mmu_model = POWERPC_MMU_2_06;
-#if defined(CONFIG_SOFTMMU)
+#if !defined(CONFIG_USER_ONLY)
     pcc->hash64_opts = &ppc_hash64_opts_POWER7;
     pcc->lrg_decr_bits = 32;
 #endif
@@ -6181,7 +6181,7 @@ POWERPC_FAMILY(POWER8)(ObjectClass *oc, void *data)
     pcc->lpcr_pm = LPCR_P8_PECE0 | LPCR_P8_PECE1 | LPCR_P8_PECE2 |
                    LPCR_P8_PECE3 | LPCR_P8_PECE4;
     pcc->mmu_model = POWERPC_MMU_2_07;
-#if defined(CONFIG_SOFTMMU)
+#if !defined(CONFIG_USER_ONLY)
     pcc->hash64_opts = &ppc_hash64_opts_POWER7;
     pcc->lrg_decr_bits = 32;
     pcc->n_host_threads = 8;
@@ -6197,7 +6197,7 @@ POWERPC_FAMILY(POWER8)(ObjectClass *oc, void *data)
     pcc->l1_icache_size = 0x8000;
 }
 
-#ifdef CONFIG_SOFTMMU
+#ifndef CONFIG_USER_ONLY
 /*
  * Radix pg sizes and AP encodings for dt node ibm,processor-radix-AP-encodings
  * Encoded as array of int_32s in the form:
@@ -6214,7 +6214,7 @@ static struct ppc_radix_page_info POWER9_radix_page_info = {
         0x4000001e  /*  1G - enc: 0x2 */
     }
 };
-#endif /* CONFIG_SOFTMMU */
+#endif /* CONFIG_USER_ONLY */
 
 static void init_proc_POWER9(CPUPPCState *env)
 {
@@ -6371,7 +6371,7 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
         LPCR_HEIC | LPCR_LPES0 | LPCR_HVICE | LPCR_HDICE;
     pcc->lpcr_pm = LPCR_PDEE | LPCR_HDEE | LPCR_EEE | LPCR_DEE | LPCR_OEE;
     pcc->mmu_model = POWERPC_MMU_3_00;
-#if defined(CONFIG_SOFTMMU)
+#if !defined(CONFIG_USER_ONLY)
     /* segment page size remain the same */
     pcc->hash64_opts = &ppc_hash64_opts_POWER7;
     pcc->radix_page_info = &POWER9_radix_page_info;
@@ -6389,7 +6389,7 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
     pcc->l1_icache_size = 0x8000;
 }
 
-#ifdef CONFIG_SOFTMMU
+#ifndef CONFIG_USER_ONLY
 /*
  * Radix pg sizes and AP encodings for dt node ibm,processor-radix-AP-encodings
  * Encoded as array of int_32s in the form:
@@ -6406,7 +6406,7 @@ static struct ppc_radix_page_info POWER10_radix_page_info = {
         0x4000001e  /*  1G - enc: 0x2 */
     }
 };
-#endif /* CONFIG_SOFTMMU */
+#endif /* !CONFIG_USER_ONLY */
 
 static void init_proc_POWER10(CPUPPCState *env)
 {
@@ -6547,7 +6547,7 @@ POWERPC_FAMILY(POWER10)(ObjectClass *oc, void *data)
 
     pcc->lpcr_pm = LPCR_PDEE | LPCR_HDEE | LPCR_EEE | LPCR_DEE | LPCR_OEE;
     pcc->mmu_model = POWERPC_MMU_3_00;
-#if defined(CONFIG_SOFTMMU)
+#if !defined(CONFIG_USER_ONLY)
     /* segment page size remain the same */
     pcc->hash64_opts = &ppc_hash64_opts_POWER7;
     pcc->radix_page_info = &POWER10_radix_page_info;
diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
index bc7e9d7eda..e27f4a75a4 100644
--- a/target/ppc/helper_regs.c
+++ b/target/ppc/helper_regs.c
@@ -310,7 +310,7 @@ int hreg_store_msr(CPUPPCState *env, target_ulong value, int alter_hv)
     return excp;
 }
 
-#ifdef CONFIG_SOFTMMU
+#ifndef CONFIG_USER_ONLY
 void store_40x_sler(CPUPPCState *env, uint32_t val)
 {
     /* XXX: TO BE FIXED */
@@ -320,9 +320,7 @@ void store_40x_sler(CPUPPCState *env, uint32_t val)
     }
     env->spr[SPR_405_SLER] = val;
 }
-#endif /* CONFIG_SOFTMMU */
 
-#ifndef CONFIG_USER_ONLY
 void check_tlb_flush(CPUPPCState *env, bool global)
 {
     CPUState *cs = env_cpu(env);
@@ -341,7 +339,7 @@ void check_tlb_flush(CPUPPCState *env, bool global)
         tlb_flush(cs);
     }
 }
-#endif
+#endif /* !CONFIG_USER_ONLY */
 
 /**
  * _spr_register
-- 
2.34.1


