Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CE8783AC7
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 09:21:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYLgs-00073F-JZ; Tue, 22 Aug 2023 03:20:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYLgr-000733-9m
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 03:20:37 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYLgn-0004me-7B
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 03:20:37 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-4fe2d152f62so6408999e87.0
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 00:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692688831; x=1693293631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xqq0w5rrWHPhUVZYkdQHqeUnw4FGgZvSQNCoNoAaM04=;
 b=H5jvlM4/64usNewymBWaNSFKJV3Lm8hk+cR2L5PaobG6J6jfWXUbpdIOQM27wZbTMp
 HSjFCHYggutVF3jUVYlqwKKKhYh74FUG2GCjAx0PWIF2gGqDrY2+2hInOvXuWdfqZRIW
 GHSs2FBlTFLyqCebn+gCOuN9xKYen5XhFXMjsChtY9XeaV3BMwglHcaBiZc8VEAxDcC3
 Zk3pcwDcW7Io+y6wKzSat1qXMXSCEbd3UP0TCl1X+rMfs6oNHuHdFc1lo9IsZnjPHcpM
 j4BBOBvo/e/LjB6Rcl4MP+XxoShIMsYDHIJRA2VIPz8P4AsJ4HD9LW8cEQBb8l7K06nS
 IBYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692688831; x=1693293631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xqq0w5rrWHPhUVZYkdQHqeUnw4FGgZvSQNCoNoAaM04=;
 b=M1rOOSsTLE/QZlVRzCrArmb7iu/xN9BkyyqjPQ4GpMROHJUq21cPK4J4WMSgkwF50f
 AMj6bzBNjwqvso+YFFFF1gyMU7VIG53PEWTVn6d14x67khdYEXhBM/bz4Z3VHEeTy5pr
 086JPC8/K3qUcC+1cVUnw3IKlspH/iTRrdAh3L3TNdHkLLMjH46HyoRz/6MbkABxFVMd
 lDMzct1J8TuAcsqdkJoAJDqqKOYsd09l4kY9JXvv9HJSWa/8qwu10U+a69cJD7RQcuM5
 hrRmFD3noY3Par5C5AXoPubxBZVjEmyoVIzjugpWMOJGMda1ugiH4MLFDqxE8ZFGh2pF
 yyDQ==
X-Gm-Message-State: AOJu0Yyw6UrAa1PKXQux4Osj6zf1UgngjBhQUWZkFdcUhZ57+9c0Ftj9
 37CPvWhOD0ys+14OOtY4fjqOxqSWgM0oq+8/qHm2Iw==
X-Google-Smtp-Source: AGHT+IGVbeBHJSao8hI8lq8uNKNNI+mFLujqsk9nrQD10QP69LNf1y2g+gbgu5hfyK+e75iE0f1+pw==
X-Received: by 2002:ac2:4e85:0:b0:500:80af:e199 with SMTP id
 o5-20020ac24e85000000b0050080afe199mr3698894lfr.55.1692688830885; 
 Tue, 22 Aug 2023 00:20:30 -0700 (PDT)
Received: from localhost.localdomain ([37.19.214.4])
 by smtp.gmail.com with ESMTPSA id
 eo4-20020a05600c82c400b003fe1a092925sm14884342wmb.19.2023.08.22.00.20.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Aug 2023 00:20:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Song Gao <gaosong@loongson.cn>
Cc: Jiajie Chen <c@jia.je>, Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Huacai Chen <chenhuacai@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH RESEND v5 12/19] target/loongarch: Add avail_64 to check
 la64-only instructions
Date: Tue, 22 Aug 2023 09:19:52 +0200
Message-ID: <20230822071959.35620-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822071405.35386-1-philmd@linaro.org>
References: <20230822071405.35386-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12b.google.com
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

From: Song Gao <gaosong@loongson.cn>

The la32 instructions listed in Table 2 at
https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-EN.html#overview-of-basic-integer-instructions

Co-authored-by: Jiajie Chen <c@jia.je>
Signed-off-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20230822032724.1353391-9-gaosong@loongson.cn>
---
 target/loongarch/translate.h                  |  3 +
 target/loongarch/translate.c                  |  2 +
 target/loongarch/insn_trans/trans_arith.c.inc | 42 ++++++----
 .../loongarch/insn_trans/trans_atomic.c.inc   | 76 +++++++++----------
 target/loongarch/insn_trans/trans_bit.c.inc   | 28 +++----
 .../loongarch/insn_trans/trans_branch.c.inc   |  4 +-
 target/loongarch/insn_trans/trans_extra.c.inc | 24 ++++--
 target/loongarch/insn_trans/trans_fmov.c.inc  |  4 +-
 .../loongarch/insn_trans/trans_memory.c.inc   | 68 ++++++++---------
 target/loongarch/insn_trans/trans_shift.c.inc | 24 +++---
 10 files changed, 152 insertions(+), 123 deletions(-)

diff --git a/target/loongarch/translate.h b/target/loongarch/translate.h
index 3c5c746f30..1342446242 100644
--- a/target/loongarch/translate.h
+++ b/target/loongarch/translate.h
@@ -15,6 +15,8 @@
     { return avail_##AVAIL(ctx) && FUNC(ctx, a, __VA_ARGS__); }
 
 #define avail_ALL(C)   true
+#define avail_64(C)    (FIELD_EX32((C)->cpucfg1, CPUCFG1, ARCH) == \
+                        CPUCFG1_ARCH_LA64)
 
 /*
  * If an operation is being performed on less than TARGET_LONG_BITS,
@@ -37,6 +39,7 @@ typedef struct DisasContext {
     TCGv zero;
     bool la64; /* LoongArch64 mode */
     bool va32; /* 32-bit virtual address */
+    uint32_t cpucfg1;
 } DisasContext;
 
 void generate_exception(DisasContext *ctx, int excp);
diff --git a/target/loongarch/translate.c b/target/loongarch/translate.c
index de7c1c5d1f..6967e12fc3 100644
--- a/target/loongarch/translate.c
+++ b/target/loongarch/translate.c
@@ -127,6 +127,8 @@ static void loongarch_tr_init_disas_context(DisasContextBase *dcbase,
     ctx->va32 = (ctx->base.tb->flags & HW_FLAGS_VA32) != 0;
 
     ctx->zero = tcg_constant_tl(0);
+
+    ctx->cpucfg1 = env->cpucfg[1];
 }
 
 static void loongarch_tr_tb_start(DisasContextBase *dcbase, CPUState *cs)
diff --git a/target/loongarch/insn_trans/trans_arith.c.inc b/target/loongarch/insn_trans/trans_arith.c.inc
index d7f69a7553..2be057e932 100644
--- a/target/loongarch/insn_trans/trans_arith.c.inc
+++ b/target/loongarch/insn_trans/trans_arith.c.inc
@@ -199,6 +199,10 @@ static bool trans_lu32i_d(DisasContext *ctx, arg_lu32i_d *a)
     TCGv src1 = gpr_src(ctx, a->rd, EXT_NONE);
     TCGv src2 = tcg_constant_tl(a->imm);
 
+    if (!avail_64(ctx)) {
+        return false;
+    }
+
     tcg_gen_deposit_tl(dest, src1, src2, 32, 32);
     gen_set_gpr(a->rd, dest, EXT_NONE);
 
@@ -211,6 +215,10 @@ static bool trans_lu52i_d(DisasContext *ctx, arg_lu52i_d *a)
     TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
     TCGv src2 = tcg_constant_tl(a->imm);
 
+    if (!avail_64(ctx)) {
+        return false;
+    }
+
     tcg_gen_deposit_tl(dest, src1, src2, 52, 12);
     gen_set_gpr(a->rd, dest, EXT_NONE);
 
@@ -242,6 +250,10 @@ static bool trans_addu16i_d(DisasContext *ctx, arg_addu16i_d *a)
     TCGv dest = gpr_dst(ctx, a->rd, EXT_NONE);
     TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
 
+    if (!avail_64(ctx)) {
+        return false;
+    }
+
     tcg_gen_addi_tl(dest, src1, a->imm << 16);
     gen_set_gpr(a->rd, dest, EXT_NONE);
 
@@ -249,9 +261,9 @@ static bool trans_addu16i_d(DisasContext *ctx, arg_addu16i_d *a)
 }
 
 TRANS(add_w, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_SIGN, tcg_gen_add_tl)
-TRANS(add_d, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, tcg_gen_add_tl)
+TRANS(add_d, 64, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, tcg_gen_add_tl)
 TRANS(sub_w, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_SIGN, tcg_gen_sub_tl)
-TRANS(sub_d, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, tcg_gen_sub_tl)
+TRANS(sub_d, 64, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, tcg_gen_sub_tl)
 TRANS(and, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, tcg_gen_and_tl)
 TRANS(or, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, tcg_gen_or_tl)
 TRANS(xor, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, tcg_gen_xor_tl)
@@ -261,32 +273,32 @@ TRANS(orn, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, tcg_gen_orc_tl)
 TRANS(slt, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_slt)
 TRANS(sltu, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_sltu)
 TRANS(mul_w, ALL, gen_rrr, EXT_SIGN, EXT_SIGN, EXT_SIGN, tcg_gen_mul_tl)
-TRANS(mul_d, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, tcg_gen_mul_tl)
+TRANS(mul_d, 64, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, tcg_gen_mul_tl)
 TRANS(mulh_w, ALL, gen_rrr, EXT_SIGN, EXT_SIGN, EXT_NONE, gen_mulh_w)
 TRANS(mulh_wu, ALL, gen_rrr, EXT_ZERO, EXT_ZERO, EXT_NONE, gen_mulh_w)
-TRANS(mulh_d, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_mulh_d)
-TRANS(mulh_du, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_mulh_du)
-TRANS(mulw_d_w, ALL, gen_rrr, EXT_SIGN, EXT_SIGN, EXT_NONE, tcg_gen_mul_tl)
-TRANS(mulw_d_wu, ALL, gen_rrr, EXT_ZERO, EXT_ZERO, EXT_NONE, tcg_gen_mul_tl)
+TRANS(mulh_d, 64, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_mulh_d)
+TRANS(mulh_du, 64, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_mulh_du)
+TRANS(mulw_d_w, 64, gen_rrr, EXT_SIGN, EXT_SIGN, EXT_NONE, tcg_gen_mul_tl)
+TRANS(mulw_d_wu, 64, gen_rrr, EXT_ZERO, EXT_ZERO, EXT_NONE, tcg_gen_mul_tl)
 TRANS(div_w, ALL, gen_rrr, EXT_SIGN, EXT_SIGN, EXT_SIGN, gen_div_w)
 TRANS(mod_w, ALL, gen_rrr, EXT_SIGN, EXT_SIGN, EXT_SIGN, gen_rem_w)
 TRANS(div_wu, ALL, gen_rrr, EXT_ZERO, EXT_ZERO, EXT_SIGN, gen_div_du)
 TRANS(mod_wu, ALL, gen_rrr, EXT_ZERO, EXT_ZERO, EXT_SIGN, gen_rem_du)
-TRANS(div_d, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_div_d)
-TRANS(mod_d, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_rem_d)
-TRANS(div_du, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_div_du)
-TRANS(mod_du, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_rem_du)
+TRANS(div_d, 64, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_div_d)
+TRANS(mod_d, 64, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_rem_d)
+TRANS(div_du, 64, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_div_du)
+TRANS(mod_du, 64, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_rem_du)
 TRANS(slti, ALL, gen_rri_v, EXT_NONE, EXT_NONE, gen_slt)
 TRANS(sltui, ALL, gen_rri_v, EXT_NONE, EXT_NONE, gen_sltu)
 TRANS(addi_w, ALL, gen_rri_c, EXT_NONE, EXT_SIGN, tcg_gen_addi_tl)
-TRANS(addi_d, ALL, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_addi_tl)
+TRANS(addi_d, 64, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_addi_tl)
 TRANS(alsl_w, ALL, gen_rrr_sa, EXT_NONE, EXT_SIGN, gen_alsl)
-TRANS(alsl_wu, ALL, gen_rrr_sa, EXT_NONE, EXT_ZERO, gen_alsl)
-TRANS(alsl_d, ALL, gen_rrr_sa, EXT_NONE, EXT_NONE, gen_alsl)
+TRANS(alsl_wu, 64, gen_rrr_sa, EXT_NONE, EXT_ZERO, gen_alsl)
+TRANS(alsl_d, 64, gen_rrr_sa, EXT_NONE, EXT_NONE, gen_alsl)
 TRANS(pcaddi, ALL, gen_pc, gen_pcaddi)
 TRANS(pcalau12i, ALL, gen_pc, gen_pcalau12i)
 TRANS(pcaddu12i, ALL, gen_pc, gen_pcaddu12i)
-TRANS(pcaddu18i, ALL, gen_pc, gen_pcaddu18i)
+TRANS(pcaddu18i, 64, gen_pc, gen_pcaddu18i)
 TRANS(andi, ALL, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_andi_tl)
 TRANS(ori, ALL, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_ori_tl)
 TRANS(xori, ALL, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_xori_tl)
diff --git a/target/loongarch/insn_trans/trans_atomic.c.inc b/target/loongarch/insn_trans/trans_atomic.c.inc
index 0a02f0dbf3..194818d74d 100644
--- a/target/loongarch/insn_trans/trans_atomic.c.inc
+++ b/target/loongarch/insn_trans/trans_atomic.c.inc
@@ -71,41 +71,41 @@ static bool gen_am(DisasContext *ctx, arg_rrr *a,
 
 TRANS(ll_w, ALL, gen_ll, MO_TESL)
 TRANS(sc_w, ALL, gen_sc, MO_TESL)
-TRANS(ll_d, ALL, gen_ll, MO_TEUQ)
-TRANS(sc_d, ALL, gen_sc, MO_TEUQ)
-TRANS(amswap_w, ALL, gen_am, tcg_gen_atomic_xchg_tl, MO_TESL)
-TRANS(amswap_d, ALL, gen_am, tcg_gen_atomic_xchg_tl, MO_TEUQ)
-TRANS(amadd_w, ALL, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TESL)
-TRANS(amadd_d, ALL, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TEUQ)
-TRANS(amand_w, ALL, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TESL)
-TRANS(amand_d, ALL, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TEUQ)
-TRANS(amor_w, ALL, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TESL)
-TRANS(amor_d, ALL, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TEUQ)
-TRANS(amxor_w, ALL, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TESL)
-TRANS(amxor_d, ALL, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TEUQ)
-TRANS(ammax_w, ALL, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TESL)
-TRANS(ammax_d, ALL, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TEUQ)
-TRANS(ammin_w, ALL, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TESL)
-TRANS(ammin_d, ALL, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TEUQ)
-TRANS(ammax_wu, ALL, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_TESL)
-TRANS(ammax_du, ALL, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_TEUQ)
-TRANS(ammin_wu, ALL, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_TESL)
-TRANS(ammin_du, ALL, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_TEUQ)
-TRANS(amswap_db_w, ALL, gen_am, tcg_gen_atomic_xchg_tl, MO_TESL)
-TRANS(amswap_db_d, ALL, gen_am, tcg_gen_atomic_xchg_tl, MO_TEUQ)
-TRANS(amadd_db_w, ALL, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TESL)
-TRANS(amadd_db_d, ALL, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TEUQ)
-TRANS(amand_db_w, ALL, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TESL)
-TRANS(amand_db_d, ALL, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TEUQ)
-TRANS(amor_db_w, ALL, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TESL)
-TRANS(amor_db_d, ALL, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TEUQ)
-TRANS(amxor_db_w, ALL, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TESL)
-TRANS(amxor_db_d, ALL, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TEUQ)
-TRANS(ammax_db_w, ALL, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TESL)
-TRANS(ammax_db_d, ALL, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TEUQ)
-TRANS(ammin_db_w, ALL, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TESL)
-TRANS(ammin_db_d, ALL, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TEUQ)
-TRANS(ammax_db_wu, ALL, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_TESL)
-TRANS(ammax_db_du, ALL, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_TEUQ)
-TRANS(ammin_db_wu, ALL, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_TESL)
-TRANS(ammin_db_du, ALL, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_TEUQ)
+TRANS(ll_d, 64, gen_ll, MO_TEUQ)
+TRANS(sc_d, 64, gen_sc, MO_TEUQ)
+TRANS(amswap_w, 64, gen_am, tcg_gen_atomic_xchg_tl, MO_TESL)
+TRANS(amswap_d, 64, gen_am, tcg_gen_atomic_xchg_tl, MO_TEUQ)
+TRANS(amadd_w, 64, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TESL)
+TRANS(amadd_d, 64, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TEUQ)
+TRANS(amand_w, 64, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TESL)
+TRANS(amand_d, 64, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TEUQ)
+TRANS(amor_w, 64, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TESL)
+TRANS(amor_d, 64, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TEUQ)
+TRANS(amxor_w, 64, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TESL)
+TRANS(amxor_d, 64, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TEUQ)
+TRANS(ammax_w, 64, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TESL)
+TRANS(ammax_d, 64, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TEUQ)
+TRANS(ammin_w, 64, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TESL)
+TRANS(ammin_d, 64, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TEUQ)
+TRANS(ammax_wu, 64, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_TESL)
+TRANS(ammax_du, 64, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_TEUQ)
+TRANS(ammin_wu, 64, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_TESL)
+TRANS(ammin_du, 64, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_TEUQ)
+TRANS(amswap_db_w, 64, gen_am, tcg_gen_atomic_xchg_tl, MO_TESL)
+TRANS(amswap_db_d, 64, gen_am, tcg_gen_atomic_xchg_tl, MO_TEUQ)
+TRANS(amadd_db_w, 64, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TESL)
+TRANS(amadd_db_d, 64, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TEUQ)
+TRANS(amand_db_w, 64, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TESL)
+TRANS(amand_db_d, 64, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TEUQ)
+TRANS(amor_db_w, 64, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TESL)
+TRANS(amor_db_d, 64, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TEUQ)
+TRANS(amxor_db_w, 64, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TESL)
+TRANS(amxor_db_d, 64, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TEUQ)
+TRANS(ammax_db_w, 64, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TESL)
+TRANS(ammax_db_d, 64, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TEUQ)
+TRANS(ammin_db_w, 64, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TESL)
+TRANS(ammin_db_d, 64, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TEUQ)
+TRANS(ammax_db_wu, 64, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_TESL)
+TRANS(ammax_db_du, 64, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_TEUQ)
+TRANS(ammin_db_wu, 64, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_TESL)
+TRANS(ammin_db_du, 64, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_TEUQ)
diff --git a/target/loongarch/insn_trans/trans_bit.c.inc b/target/loongarch/insn_trans/trans_bit.c.inc
index d2a7ac28f7..ee5fa003ce 100644
--- a/target/loongarch/insn_trans/trans_bit.c.inc
+++ b/target/loongarch/insn_trans/trans_bit.c.inc
@@ -184,25 +184,25 @@ TRANS(clo_w, ALL, gen_rr, EXT_NONE, EXT_NONE, gen_clo_w)
 TRANS(clz_w, ALL, gen_rr, EXT_ZERO, EXT_NONE, gen_clz_w)
 TRANS(cto_w, ALL, gen_rr, EXT_NONE, EXT_NONE, gen_cto_w)
 TRANS(ctz_w, ALL, gen_rr, EXT_NONE, EXT_NONE, gen_ctz_w)
-TRANS(clo_d, ALL, gen_rr, EXT_NONE, EXT_NONE, gen_clo_d)
-TRANS(clz_d, ALL, gen_rr, EXT_NONE, EXT_NONE, gen_clz_d)
-TRANS(cto_d, ALL, gen_rr, EXT_NONE, EXT_NONE, gen_cto_d)
-TRANS(ctz_d, ALL, gen_rr, EXT_NONE, EXT_NONE, gen_ctz_d)
+TRANS(clo_d, 64, gen_rr, EXT_NONE, EXT_NONE, gen_clo_d)
+TRANS(clz_d, 64, gen_rr, EXT_NONE, EXT_NONE, gen_clz_d)
+TRANS(cto_d, 64, gen_rr, EXT_NONE, EXT_NONE, gen_cto_d)
+TRANS(ctz_d, 64, gen_rr, EXT_NONE, EXT_NONE, gen_ctz_d)
 TRANS(revb_2h, ALL, gen_rr, EXT_NONE, EXT_SIGN, gen_revb_2h)
-TRANS(revb_4h, ALL, gen_rr, EXT_NONE, EXT_NONE, gen_revb_4h)
-TRANS(revb_2w, ALL, gen_rr, EXT_NONE, EXT_NONE, gen_revb_2w)
-TRANS(revb_d, ALL, gen_rr, EXT_NONE, EXT_NONE, tcg_gen_bswap64_i64)
-TRANS(revh_2w, ALL, gen_rr, EXT_NONE, EXT_NONE, gen_revh_2w)
-TRANS(revh_d, ALL, gen_rr, EXT_NONE, EXT_NONE, gen_revh_d)
+TRANS(revb_4h, 64, gen_rr, EXT_NONE, EXT_NONE, gen_revb_4h)
+TRANS(revb_2w, 64, gen_rr, EXT_NONE, EXT_NONE, gen_revb_2w)
+TRANS(revb_d, 64, gen_rr, EXT_NONE, EXT_NONE, tcg_gen_bswap64_i64)
+TRANS(revh_2w, 64, gen_rr, EXT_NONE, EXT_NONE, gen_revh_2w)
+TRANS(revh_d, 64, gen_rr, EXT_NONE, EXT_NONE, gen_revh_d)
 TRANS(bitrev_4b, ALL, gen_rr, EXT_ZERO, EXT_SIGN, gen_helper_bitswap)
-TRANS(bitrev_8b, ALL, gen_rr, EXT_NONE, EXT_NONE, gen_helper_bitswap)
+TRANS(bitrev_8b, 64, gen_rr, EXT_NONE, EXT_NONE, gen_helper_bitswap)
 TRANS(bitrev_w, ALL, gen_rr, EXT_NONE, EXT_SIGN, gen_helper_bitrev_w)
-TRANS(bitrev_d, ALL, gen_rr, EXT_NONE, EXT_NONE, gen_helper_bitrev_d)
+TRANS(bitrev_d, 64, gen_rr, EXT_NONE, EXT_NONE, gen_helper_bitrev_d)
 TRANS(maskeqz, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_maskeqz)
 TRANS(masknez, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_masknez)
 TRANS(bytepick_w, ALL, gen_rrr_sa, EXT_NONE, EXT_NONE, gen_bytepick_w)
-TRANS(bytepick_d, ALL, gen_rrr_sa, EXT_NONE, EXT_NONE, gen_bytepick_d)
+TRANS(bytepick_d, 64, gen_rrr_sa, EXT_NONE, EXT_NONE, gen_bytepick_d)
 TRANS(bstrins_w, ALL, gen_bstrins, EXT_SIGN)
-TRANS(bstrins_d, ALL, gen_bstrins, EXT_NONE)
+TRANS(bstrins_d, 64, gen_bstrins, EXT_NONE)
 TRANS(bstrpick_w, ALL, gen_bstrpick, EXT_SIGN)
-TRANS(bstrpick_d, ALL, gen_bstrpick, EXT_NONE)
+TRANS(bstrpick_d, 64, gen_bstrpick, EXT_NONE)
diff --git a/target/loongarch/insn_trans/trans_branch.c.inc b/target/loongarch/insn_trans/trans_branch.c.inc
index 50f7eb640a..a4fd2092e5 100644
--- a/target/loongarch/insn_trans/trans_branch.c.inc
+++ b/target/loongarch/insn_trans/trans_branch.c.inc
@@ -80,5 +80,5 @@ TRANS(bltu, ALL, gen_rr_bc, TCG_COND_LTU)
 TRANS(bgeu, ALL, gen_rr_bc, TCG_COND_GEU)
 TRANS(beqz, ALL, gen_rz_bc, TCG_COND_EQ)
 TRANS(bnez, ALL, gen_rz_bc, TCG_COND_NE)
-TRANS(bceqz, ALL, gen_cz_bc, TCG_COND_EQ)
-TRANS(bcnez, ALL, gen_cz_bc, TCG_COND_NE)
+TRANS(bceqz, 64, gen_cz_bc, TCG_COND_EQ)
+TRANS(bcnez, 64, gen_cz_bc, TCG_COND_NE)
diff --git a/target/loongarch/insn_trans/trans_extra.c.inc b/target/loongarch/insn_trans/trans_extra.c.inc
index b354ca0f86..dd5d02e88c 100644
--- a/target/loongarch/insn_trans/trans_extra.c.inc
+++ b/target/loongarch/insn_trans/trans_extra.c.inc
@@ -20,6 +20,10 @@ static bool trans_asrtle_d(DisasContext *ctx, arg_asrtle_d * a)
     TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
     TCGv src2 = gpr_src(ctx, a->rk, EXT_NONE);
 
+    if (!avail_64(ctx)) {
+        return false;
+    }
+
     gen_helper_asrtle_d(cpu_env, src1, src2);
     return true;
 }
@@ -29,6 +33,10 @@ static bool trans_asrtgt_d(DisasContext *ctx, arg_asrtgt_d * a)
     TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
     TCGv src2 = gpr_src(ctx, a->rk, EXT_NONE);
 
+    if (!avail_64(ctx)) {
+        return false;
+    }
+
     gen_helper_asrtgt_d(cpu_env, src1, src2);
     return true;
 }
@@ -89,11 +97,11 @@ static bool gen_crc(DisasContext *ctx, arg_rrr *a,
     return true;
 }
 
-TRANS(crc_w_b_w, ALL, gen_crc, gen_helper_crc32, tcg_constant_tl(1))
-TRANS(crc_w_h_w, ALL, gen_crc, gen_helper_crc32, tcg_constant_tl(2))
-TRANS(crc_w_w_w, ALL, gen_crc, gen_helper_crc32, tcg_constant_tl(4))
-TRANS(crc_w_d_w, ALL, gen_crc, gen_helper_crc32, tcg_constant_tl(8))
-TRANS(crcc_w_b_w, ALL, gen_crc, gen_helper_crc32c, tcg_constant_tl(1))
-TRANS(crcc_w_h_w, ALL, gen_crc, gen_helper_crc32c, tcg_constant_tl(2))
-TRANS(crcc_w_w_w, ALL, gen_crc, gen_helper_crc32c, tcg_constant_tl(4))
-TRANS(crcc_w_d_w, ALL, gen_crc, gen_helper_crc32c, tcg_constant_tl(8))
+TRANS(crc_w_b_w, 64, gen_crc, gen_helper_crc32, tcg_constant_tl(1))
+TRANS(crc_w_h_w, 64, gen_crc, gen_helper_crc32, tcg_constant_tl(2))
+TRANS(crc_w_w_w, 64, gen_crc, gen_helper_crc32, tcg_constant_tl(4))
+TRANS(crc_w_d_w, 64, gen_crc, gen_helper_crc32, tcg_constant_tl(8))
+TRANS(crcc_w_b_w, 64, gen_crc, gen_helper_crc32c, tcg_constant_tl(1))
+TRANS(crcc_w_h_w, 64, gen_crc, gen_helper_crc32c, tcg_constant_tl(2))
+TRANS(crcc_w_w_w, 64, gen_crc, gen_helper_crc32c, tcg_constant_tl(4))
+TRANS(crcc_w_d_w, 64, gen_crc, gen_helper_crc32c, tcg_constant_tl(8))
diff --git a/target/loongarch/insn_trans/trans_fmov.c.inc b/target/loongarch/insn_trans/trans_fmov.c.inc
index aa7fea67b5..385bbb7929 100644
--- a/target/loongarch/insn_trans/trans_fmov.c.inc
+++ b/target/loongarch/insn_trans/trans_fmov.c.inc
@@ -181,8 +181,8 @@ static bool trans_movcf2gr(DisasContext *ctx, arg_movcf2gr *a)
 TRANS(fmov_s, ALL, gen_f2f, tcg_gen_mov_tl, true)
 TRANS(fmov_d, ALL, gen_f2f, tcg_gen_mov_tl, false)
 TRANS(movgr2fr_w, ALL, gen_r2f, gen_movgr2fr_w)
-TRANS(movgr2fr_d, ALL, gen_r2f, tcg_gen_mov_tl)
+TRANS(movgr2fr_d, 64, gen_r2f, tcg_gen_mov_tl)
 TRANS(movgr2frh_w, ALL, gen_r2f, gen_movgr2frh_w)
 TRANS(movfr2gr_s, ALL, gen_f2r, tcg_gen_ext32s_tl)
-TRANS(movfr2gr_d, ALL, gen_f2r, tcg_gen_mov_tl)
+TRANS(movfr2gr_d, 64, gen_f2r, tcg_gen_mov_tl)
 TRANS(movfrh2gr_s, ALL, gen_f2r, gen_movfrh2gr_s)
diff --git a/target/loongarch/insn_trans/trans_memory.c.inc b/target/loongarch/insn_trans/trans_memory.c.inc
index ad6a4b006d..d9d062235a 100644
--- a/target/loongarch/insn_trans/trans_memory.c.inc
+++ b/target/loongarch/insn_trans/trans_memory.c.inc
@@ -148,42 +148,42 @@ static bool gen_stptr(DisasContext *ctx, arg_rr_i *a, MemOp mop)
 TRANS(ld_b, ALL, gen_load, MO_SB)
 TRANS(ld_h, ALL, gen_load, MO_TESW)
 TRANS(ld_w, ALL, gen_load, MO_TESL)
-TRANS(ld_d, ALL, gen_load, MO_TEUQ)
+TRANS(ld_d, 64, gen_load, MO_TEUQ)
 TRANS(st_b, ALL, gen_store, MO_UB)
 TRANS(st_h, ALL, gen_store, MO_TEUW)
 TRANS(st_w, ALL, gen_store, MO_TEUL)
-TRANS(st_d, ALL, gen_store, MO_TEUQ)
+TRANS(st_d, 64, gen_store, MO_TEUQ)
 TRANS(ld_bu, ALL, gen_load, MO_UB)
 TRANS(ld_hu, ALL, gen_load, MO_TEUW)
-TRANS(ld_wu, ALL, gen_load, MO_TEUL)
-TRANS(ldx_b, ALL, gen_loadx, MO_SB)
-TRANS(ldx_h, ALL, gen_loadx, MO_TESW)
-TRANS(ldx_w, ALL, gen_loadx, MO_TESL)
-TRANS(ldx_d, ALL, gen_loadx, MO_TEUQ)
-TRANS(stx_b, ALL, gen_storex, MO_UB)
-TRANS(stx_h, ALL, gen_storex, MO_TEUW)
-TRANS(stx_w, ALL, gen_storex, MO_TEUL)
-TRANS(stx_d, ALL, gen_storex, MO_TEUQ)
-TRANS(ldx_bu, ALL, gen_loadx, MO_UB)
-TRANS(ldx_hu, ALL, gen_loadx, MO_TEUW)
-TRANS(ldx_wu, ALL, gen_loadx, MO_TEUL)
-TRANS(ldptr_w, ALL, gen_ldptr, MO_TESL)
-TRANS(stptr_w, ALL, gen_stptr, MO_TEUL)
-TRANS(ldptr_d, ALL, gen_ldptr, MO_TEUQ)
-TRANS(stptr_d, ALL, gen_stptr, MO_TEUQ)
-TRANS(ldgt_b, ALL, gen_load_gt, MO_SB)
-TRANS(ldgt_h, ALL, gen_load_gt, MO_TESW)
-TRANS(ldgt_w, ALL, gen_load_gt, MO_TESL)
-TRANS(ldgt_d, ALL, gen_load_gt, MO_TEUQ)
-TRANS(ldle_b, ALL, gen_load_le, MO_SB)
-TRANS(ldle_h, ALL, gen_load_le, MO_TESW)
-TRANS(ldle_w, ALL, gen_load_le, MO_TESL)
-TRANS(ldle_d, ALL, gen_load_le, MO_TEUQ)
-TRANS(stgt_b, ALL, gen_store_gt, MO_UB)
-TRANS(stgt_h, ALL, gen_store_gt, MO_TEUW)
-TRANS(stgt_w, ALL, gen_store_gt, MO_TEUL)
-TRANS(stgt_d, ALL, gen_store_gt, MO_TEUQ)
-TRANS(stle_b, ALL, gen_store_le, MO_UB)
-TRANS(stle_h, ALL, gen_store_le, MO_TEUW)
-TRANS(stle_w, ALL, gen_store_le, MO_TEUL)
-TRANS(stle_d, ALL, gen_store_le, MO_TEUQ)
+TRANS(ld_wu, 64, gen_load, MO_TEUL)
+TRANS(ldx_b, 64, gen_loadx, MO_SB)
+TRANS(ldx_h, 64, gen_loadx, MO_TESW)
+TRANS(ldx_w, 64, gen_loadx, MO_TESL)
+TRANS(ldx_d, 64, gen_loadx, MO_TEUQ)
+TRANS(stx_b, 64, gen_storex, MO_UB)
+TRANS(stx_h, 64, gen_storex, MO_TEUW)
+TRANS(stx_w, 64, gen_storex, MO_TEUL)
+TRANS(stx_d, 64, gen_storex, MO_TEUQ)
+TRANS(ldx_bu, 64, gen_loadx, MO_UB)
+TRANS(ldx_hu, 64, gen_loadx, MO_TEUW)
+TRANS(ldx_wu, 64, gen_loadx, MO_TEUL)
+TRANS(ldptr_w, 64, gen_ldptr, MO_TESL)
+TRANS(stptr_w, 64, gen_stptr, MO_TEUL)
+TRANS(ldptr_d, 64, gen_ldptr, MO_TEUQ)
+TRANS(stptr_d, 64, gen_stptr, MO_TEUQ)
+TRANS(ldgt_b, 64, gen_load_gt, MO_SB)
+TRANS(ldgt_h, 64, gen_load_gt, MO_TESW)
+TRANS(ldgt_w, 64, gen_load_gt, MO_TESL)
+TRANS(ldgt_d, 64, gen_load_gt, MO_TEUQ)
+TRANS(ldle_b, 64, gen_load_le, MO_SB)
+TRANS(ldle_h, 64, gen_load_le, MO_TESW)
+TRANS(ldle_w, 64, gen_load_le, MO_TESL)
+TRANS(ldle_d, 64, gen_load_le, MO_TEUQ)
+TRANS(stgt_b, 64, gen_store_gt, MO_UB)
+TRANS(stgt_h, 64, gen_store_gt, MO_TEUW)
+TRANS(stgt_w, 64, gen_store_gt, MO_TEUL)
+TRANS(stgt_d, 64, gen_store_gt, MO_TEUQ)
+TRANS(stle_b, 64, gen_store_le, MO_UB)
+TRANS(stle_h, 64, gen_store_le, MO_TEUW)
+TRANS(stle_w, 64, gen_store_le, MO_TEUL)
+TRANS(stle_d, 64, gen_store_le, MO_TEUQ)
diff --git a/target/loongarch/insn_trans/trans_shift.c.inc b/target/loongarch/insn_trans/trans_shift.c.inc
index 849759b94b..2f4bd6ff28 100644
--- a/target/loongarch/insn_trans/trans_shift.c.inc
+++ b/target/loongarch/insn_trans/trans_shift.c.inc
@@ -72,6 +72,10 @@ static bool trans_srai_w(DisasContext *ctx, arg_srai_w *a)
     TCGv dest = gpr_dst(ctx, a->rd, EXT_NONE);
     TCGv src1 = gpr_src(ctx, a->rj, EXT_ZERO);
 
+    if (!avail_64(ctx)) {
+        return false;
+    }
+
     tcg_gen_sextract_tl(dest, src1, a->imm, 32 - a->imm);
     gen_set_gpr(a->rd, dest, EXT_NONE);
 
@@ -81,15 +85,15 @@ static bool trans_srai_w(DisasContext *ctx, arg_srai_w *a)
 TRANS(sll_w, ALL, gen_rrr, EXT_ZERO, EXT_NONE, EXT_SIGN, gen_sll_w)
 TRANS(srl_w, ALL, gen_rrr, EXT_ZERO, EXT_NONE, EXT_SIGN, gen_srl_w)
 TRANS(sra_w, ALL, gen_rrr, EXT_SIGN, EXT_NONE, EXT_SIGN, gen_sra_w)
-TRANS(sll_d, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_sll_d)
-TRANS(srl_d, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_srl_d)
-TRANS(sra_d, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_sra_d)
-TRANS(rotr_w, ALL, gen_rrr, EXT_ZERO, EXT_NONE, EXT_SIGN, gen_rotr_w)
-TRANS(rotr_d, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_rotr_d)
+TRANS(sll_d, 64, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_sll_d)
+TRANS(srl_d, 64, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_srl_d)
+TRANS(sra_d, 64, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_sra_d)
+TRANS(rotr_w, 64, gen_rrr, EXT_ZERO, EXT_NONE, EXT_SIGN, gen_rotr_w)
+TRANS(rotr_d, 64, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_rotr_d)
 TRANS(slli_w, ALL, gen_rri_c, EXT_NONE, EXT_SIGN, tcg_gen_shli_tl)
-TRANS(slli_d, ALL, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_shli_tl)
+TRANS(slli_d, 64, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_shli_tl)
 TRANS(srli_w, ALL, gen_rri_c, EXT_ZERO, EXT_SIGN, tcg_gen_shri_tl)
-TRANS(srli_d, ALL, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_shri_tl)
-TRANS(srai_d, ALL, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_sari_tl)
-TRANS(rotri_w, ALL, gen_rri_v, EXT_NONE, EXT_NONE, gen_rotr_w)
-TRANS(rotri_d, ALL, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_rotri_tl)
+TRANS(srli_d, 64, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_shri_tl)
+TRANS(srai_d, 64, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_sari_tl)
+TRANS(rotri_w, 64, gen_rri_v, EXT_NONE, EXT_NONE, gen_rotr_w)
+TRANS(rotri_d, 64, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_rotri_tl)
-- 
2.41.0


