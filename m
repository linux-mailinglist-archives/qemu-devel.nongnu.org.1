Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A011B711AA7
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 01:29:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2KLi-0005wz-CO; Thu, 25 May 2023 19:26:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2KLZ-0005r6-RT
 for qemu-devel@nongnu.org; Thu, 25 May 2023 19:26:17 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2KLV-0005lF-2P
 for qemu-devel@nongnu.org; Thu, 25 May 2023 19:26:17 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1ae6dce19f7so914395ad.3
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 16:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685057171; x=1687649171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6JfHuaMlr/R5D+hsSo7rFRMVl2Kxv9MZXkN8QLhXQd8=;
 b=HINTjw9bUT2rY8kSkU2uJaGT+Ite0+KHbsrnD58qW0uHk9LxeNrtqHyNs5SKeUxXLO
 fzh1nLHHC5JiW//dCOlB26VNT5j0K7BGrLCZlu6BUifSIZAtOgagTDipMO/ujZ2SlVNz
 iJKs/t+0QOQ3Nvmli1HaENLEwl5MCmTzP+D9fwcc5AFNtCAbp5LCcsWIp/l70RAqhkSS
 QEUmsB7SUVG/qIXw4o5zG2NpY5wG1fLoQaqxIjPbYL5zTo/G26f01K/otgXrmyeoNHBU
 J//1EGJEoBzjFTl7K+Kx28/btFdBCG+bnuCruY/rrg9eAe7H2BQ4so5MI6FHKGmCXVbK
 LTAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685057171; x=1687649171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6JfHuaMlr/R5D+hsSo7rFRMVl2Kxv9MZXkN8QLhXQd8=;
 b=NuS5vnTMbfjSYU+b3qwdu7+D2labpwRqCMtjpG9OvmSLX3TjWSzPRDuo6w6gm655Pd
 3HFSSangnd5vCLk+2bWsqSrm+cx/dLeqk1oP5bqzBsTEZQ4FcCMGpZArSPGissQ57yVr
 04KZ8AM/4dPvH3Ib+JXP24C+ap/QObea9Pc8Hc9jPzikvHny+9xOslFqRPAWS4jmGx2c
 WT5/j9bgxxFVPQDHCeIMWtHcoN1EmdSez55+Drj35KMRDGAf2Cj/vP2RPT0OGDWFgRx3
 BFecZkeAAo0NDKn6tlkTYUwbWxdz1pYzeZ8EPxxc1FyuOU0mNn4H7ZJlgJC65lyAgzSq
 NC8w==
X-Gm-Message-State: AC+VfDzCaEwo4DEbNpipZWnKcFXAZlDhWSltW31ifWPnw0XBmd46qfEY
 VBlpEhzlcEuNZEyQjt1BzByEvadyUWGXBEj+sOs=
X-Google-Smtp-Source: ACHHUZ5AHh1Be8Jyigv7m9AgGsG9jRweU6SoHHEh6C+ceBVQ0W1wzd2rK+i09cM7T/X6I0ojF+Cvdw==
X-Received: by 2002:a17:902:f64e:b0:1ae:626b:475f with SMTP id
 m14-20020a170902f64e00b001ae626b475fmr420941plg.12.1685057170961; 
 Thu, 25 May 2023 16:26:10 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:7ac5:31cc:3997:3a16])
 by smtp.gmail.com with ESMTPSA id
 s15-20020a170902ea0f00b0019e60c645b1sm1885036plg.305.2023.05.25.16.26.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 16:26:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 14/20] target/arm: Check alignment in helper_mte_check
Date: Thu, 25 May 2023 16:25:52 -0700
Message-Id: <20230525232558.1758967-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230525232558.1758967-1-richard.henderson@linaro.org>
References: <20230525232558.1758967-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Fixes a bug in that with SCTLR.A set, we should raise any
alignment fault before raising any MTE check fault.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h         |  3 ++-
 target/arm/tcg/mte_helper.c    | 18 ++++++++++++++++++
 target/arm/tcg/translate-a64.c |  2 ++
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index c869d18c38..05b5231d43 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1242,7 +1242,8 @@ FIELD(MTEDESC, MIDX,  0, 4)
 FIELD(MTEDESC, TBI,   4, 2)
 FIELD(MTEDESC, TCMA,  6, 2)
 FIELD(MTEDESC, WRITE, 8, 1)
-FIELD(MTEDESC, SIZEM1, 9, SIMD_DATA_BITS - 9)  /* size - 1 */
+FIELD(MTEDESC, ALIGN, 9, 3)
+FIELD(MTEDESC, SIZEM1, 12, SIMD_DATA_BITS - 12)  /* size - 1 */
 
 bool mte_probe(CPUARMState *env, uint32_t desc, uint64_t ptr);
 uint64_t mte_check(CPUARMState *env, uint32_t desc, uint64_t ptr, uintptr_t ra);
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index a4f3f92bc0..9c64def081 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -785,6 +785,24 @@ uint64_t mte_check(CPUARMState *env, uint32_t desc, uint64_t ptr, uintptr_t ra)
 
 uint64_t HELPER(mte_check)(CPUARMState *env, uint32_t desc, uint64_t ptr)
 {
+    /*
+     * R_XCHFJ: Alignment check not caused by memory type is priority 1,
+     * higher than any translation fault.  When MTE is disabled, tcg
+     * performs the alignment check during the code generated for the
+     * memory access.  With MTE enabled, we must check this here before
+     * raising any translation fault in allocation_tag_mem.
+     */
+    unsigned align = FIELD_EX32(desc, MTEDESC, ALIGN);
+    if (unlikely(align)) {
+        align = (1u << align) - 1;
+        if (unlikely(ptr & align)) {
+            int idx = FIELD_EX32(desc, MTEDESC, MIDX);
+            bool w = FIELD_EX32(desc, MTEDESC, WRITE);
+            MMUAccessType type = w ? MMU_DATA_STORE : MMU_DATA_LOAD;
+            arm_cpu_do_unaligned_access(env_cpu(env), ptr, type, idx, GETPC());
+        }
+    }
+
     return mte_check(env, desc, ptr, GETPC());
 }
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 214a9b1638..8301d6c8e2 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -274,6 +274,7 @@ static TCGv_i64 gen_mte_check1_mmuidx(DisasContext *s, TCGv_i64 addr,
         desc = FIELD_DP32(desc, MTEDESC, TBI, s->tbid);
         desc = FIELD_DP32(desc, MTEDESC, TCMA, s->tcma);
         desc = FIELD_DP32(desc, MTEDESC, WRITE, is_write);
+        desc = FIELD_DP32(desc, MTEDESC, ALIGN, get_alignment_bits(memop));
         desc = FIELD_DP32(desc, MTEDESC, SIZEM1, memop_size(memop) - 1);
 
         ret = tcg_temp_new_i64();
@@ -305,6 +306,7 @@ TCGv_i64 gen_mte_checkN(DisasContext *s, TCGv_i64 addr, bool is_write,
         desc = FIELD_DP32(desc, MTEDESC, TBI, s->tbid);
         desc = FIELD_DP32(desc, MTEDESC, TCMA, s->tcma);
         desc = FIELD_DP32(desc, MTEDESC, WRITE, is_write);
+        desc = FIELD_DP32(desc, MTEDESC, ALIGN, get_alignment_bits(single_mop));
         desc = FIELD_DP32(desc, MTEDESC, SIZEM1, total_size - 1);
 
         ret = tcg_temp_new_i64();
-- 
2.34.1


