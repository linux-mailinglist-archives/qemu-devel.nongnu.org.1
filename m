Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD06716D46
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 21:16:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q44ow-0008Cj-AM; Tue, 30 May 2023 15:15:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44oE-0007Da-4p
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:15:06 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44o1-0004j0-CH
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:15:05 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-64d2a87b9daso3612876b3a.0
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 12:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685474092; x=1688066092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j3NB0kKMraRNz/f7J34nBSLxO8imEq998u/Uy8JSg1Y=;
 b=i+FS+wwSqZ94ZWrWpLwSqLy3cUP5VnKQtCENyBC0vuovK9FebwwII6glQvJ1/Ui8Fh
 Et4ugxMWS7yychhGaT0cq9cjh1V6o7F5Kolh8ld63bQRGB/7zxMTESItgSgsS8WF33qu
 lJT25vHfHm6UVK/QoK9z+mJS7stXFjQWNVwbip5fjTW2xK552Mi0a9COGlFVRQbFe+35
 R6gO1OZW/Tm26dQ6hq2fAt1gSXbUZTao43HV3YjUOeNcW4paKdp0oor5ITidZEc/evzB
 Z3lroz7ecuEzP1kYC9p/SWB2K+POwCav67CJhnYLG4rRDNhodbIIqBlIGRJLFGmNvMX5
 a3WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685474092; x=1688066092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j3NB0kKMraRNz/f7J34nBSLxO8imEq998u/Uy8JSg1Y=;
 b=EcFWP1W8nE7KqAJ0/P2jiyk9bxInT0n+C6EiQDUJb7SdVVE6VnRhCNKwHO5GAlOoDy
 iTTOU3W8SU8bWAL60cLJlyCQJqRlbhpvoWZQ8AuBUZXRTlEAa7MPsj7HW+CRtmSg5Yas
 2Vy7otFetDqvze0AOkpnumjhfAPY6D+LGp0t7G0sVgswbpylX7TXG92JOuDoD0vrlkO/
 oscKhTK++NKGlPwLaNTrmxjIbC3gye6OWXvBXwJrT256qdzaYJhB2U2WTGtNFtuXFoZR
 yZP2nihbuG2sw3JSECxv/HSbN9MKRPZFBat0r4y1D1m4mYjUlyuvyadWfktibA6WxlCF
 S8lw==
X-Gm-Message-State: AC+VfDxF4gHQCK2vOK9gxBLRvqapOTv44T4v8EReYq4tSYMR28/YjT0t
 wYvdi6EQiXgOGm2rYK1yi/5a8PVXsNF9Mj3+tgo=
X-Google-Smtp-Source: ACHHUZ67KHHcZxaexBUr6tzqnPa4fZhwhiDV/sZd+Yku0UIr0XlKj603n9MYIEggh06TsZKTxQ6naQ==
X-Received: by 2002:a05:6a00:2444:b0:64a:7723:fe04 with SMTP id
 d4-20020a056a00244400b0064a7723fe04mr4088630pfj.4.1685474091991; 
 Tue, 30 May 2023 12:14:51 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:35a2:c45d:7485:f488])
 by smtp.gmail.com with ESMTPSA id
 10-20020a63104a000000b0051806da5cd6sm8926757pgq.60.2023.05.30.12.14.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 12:14:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 15/20] target/arm: Add SCTLR.nAA to TBFLAG_A64
Date: Tue, 30 May 2023 12:14:33 -0700
Message-Id: <20230530191438.411344-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530191438.411344-1-richard.henderson@linaro.org>
References: <20230530191438.411344-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h               | 3 ++-
 target/arm/tcg/translate.h     | 2 ++
 target/arm/tcg/hflags.c        | 6 ++++++
 target/arm/tcg/translate-a64.c | 1 +
 4 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c1db26b299..36c608f0e6 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1248,7 +1248,7 @@ void pmu_init(ARMCPU *cpu);
 #define SCTLR_D       (1U << 5) /* up to v5; RAO in v6 */
 #define SCTLR_CP15BEN (1U << 5) /* v7 onward */
 #define SCTLR_L       (1U << 6) /* up to v5; RAO in v6 and v7; RAZ in v8 */
-#define SCTLR_nAA     (1U << 6) /* when v8.4-LSE is implemented */
+#define SCTLR_nAA     (1U << 6) /* when FEAT_LSE2 is implemented */
 #define SCTLR_B       (1U << 7) /* up to v6; RAZ in v7 */
 #define SCTLR_ITD     (1U << 7) /* v8 onward */
 #define SCTLR_S       (1U << 8) /* up to v6; RAZ in v7 */
@@ -3044,6 +3044,7 @@ FIELD(TBFLAG_A64, SVL, 24, 4)
 /* Indicates that SME Streaming mode is active, and SMCR_ELx.FA64 is not. */
 FIELD(TBFLAG_A64, SME_TRAP_NONSTREAMING, 28, 1)
 FIELD(TBFLAG_A64, FGT_ERET, 29, 1)
+FIELD(TBFLAG_A64, NAA, 30, 1)
 
 /*
  * Helpers for using the above.
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 626cf07970..38086a23f4 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -137,6 +137,8 @@ typedef struct DisasContext {
     bool fgt_eret;
     /* True if fine-grained trap on SVC is enabled */
     bool fgt_svc;
+    /* True if FEAT_LSE2 SCTLR_ELx.nAA is set */
+    bool naa;
     /*
      * >= 0, a copy of PSTATE.BTYPE, which will be 0 without v8.5-BTI.
      *  < 0, set by the current instruction.
diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index b2ccd77cff..616c5fa723 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -248,6 +248,12 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
         }
     }
 
+    if (cpu_isar_feature(aa64_lse2, env_archcpu(env))) {
+        if (sctlr & SCTLR_nAA) {
+            DP_TBFLAG_A64(flags, NAA, 1);
+        }
+    }
+
     /* Compute the condition for using AccType_UNPRIV for LDTR et al. */
     if (!(env->pstate & PSTATE_UAO)) {
         switch (mmu_idx) {
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 8301d6c8e2..bbcdf31728 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -14163,6 +14163,7 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->pstate_sm = EX_TBFLAG_A64(tb_flags, PSTATE_SM);
     dc->pstate_za = EX_TBFLAG_A64(tb_flags, PSTATE_ZA);
     dc->sme_trap_nonstreaming = EX_TBFLAG_A64(tb_flags, SME_TRAP_NONSTREAMING);
+    dc->naa = EX_TBFLAG_A64(tb_flags, NAA);
     dc->vec_len = 0;
     dc->vec_stride = 0;
     dc->cp_regs = arm_cpu->cp_regs;
-- 
2.34.1


