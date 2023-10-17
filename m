Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C85837CBB74
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:42:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdmN-00086m-Bm; Tue, 17 Oct 2023 02:42:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdlj-0007vD-R8
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:41:35 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdle-0001ti-SJ
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:41:31 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1ca3a54d2c4so21126105ad.3
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697524885; x=1698129685; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DqBVSa7X7Vl34L7v0vos+xD696qr1VhHUKnTWS4HUqY=;
 b=CZo+PXoJvCEUGjdT3X+Gn2ne+e2DqKFstD+Ettk7/vn8VsOCZswn24TmZnDnUC6HhT
 z55qdkt/qe+uNFi51NX2ePtTzxQgyHBKAgIG21lHYAY9N1rs30jdRh7WmFwASAxNbybd
 gp4eD75tQD2bXLn8bKqG3WQFabKAC958Drb4beMB7pEfp3SEypQDIBGTyKL6bOt/KHF3
 b6oZ4uLsczZIrlk1HLZQpy3ryBsYRF1COZOVxQnsG2SmLsu5IZc7ohk4zaGUKGQpJDzk
 6V0l+sw4Kv1AmWENYZwv/qMGuLA6QZ4FFUgAtt3FnGhnXyPVvr1mg9h8zHmwyOyUJy0G
 2Huw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697524885; x=1698129685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DqBVSa7X7Vl34L7v0vos+xD696qr1VhHUKnTWS4HUqY=;
 b=W9BLZZ2vcUK/6A9WoftjlDmxeIkEL2vd0uk4tMI2DbAv4GRSnBKHuwwdRtI8iSOlzj
 lGp+B9K7WFj0a9APZhLcWc5Q9mkRj57URib18dAiq4XTjFAKmlBpY5dTZD4ViAzLzbMb
 33PKZ/dnvr1luK0d0m7BLzLtiq+RTMTdxfB4/5MibxyisbbEhtVF9CNTQmRzyiIz26MU
 Ze5WeHjaab4QXxVLZXFbIKtQd0psdZYrdilqfTeMafppZY9y8/uXO93al4eFqp2HFCli
 TmALxA0/RiTogPNQFYkf0MA6hq/PtFbq6DzGT9lgS9qypYskrmhyVwUyP06DYiLvcy2x
 gUiw==
X-Gm-Message-State: AOJu0YxcptO096wlFqZl780mmnnix29NwcgNj58/7zDgmwM05XLHpM3F
 tZ0r0xbJ3FAkyimR7tXLhLIl4DB6xo6H5O33gMI=
X-Google-Smtp-Source: AGHT+IHCy66yCDucrBpRD43b1h6IO8MbInCiBhdnUoRZSICMgDTJj4Hhvp8g6rc8J5Pz8OzXvBL+5g==
X-Received: by 2002:a17:902:bd09:b0:1c6:943:baca with SMTP id
 p9-20020a170902bd0900b001c60943bacamr1501660pls.28.1697524885693; 
 Mon, 16 Oct 2023 23:41:25 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 x18-20020a17090300d200b001b891259eddsm685682plc.197.2023.10.16.23.41.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:41:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 20/20] target/sparc: Implement UDIV inline
Date: Mon, 16 Oct 2023 23:41:09 -0700
Message-Id: <20231017064109.681935-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017064109.681935-1-richard.henderson@linaro.org>
References: <20231017064109.681935-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/helper.h    |  1 -
 target/sparc/helper.c    | 29 +++++++---------------
 target/sparc/translate.c | 52 +++++++++++++++++++++++++++++++++++-----
 3 files changed, 54 insertions(+), 28 deletions(-)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index 12181d1106..624a8fdedf 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -27,7 +27,6 @@ DEF_HELPER_FLAGS_2(tick_set_limit, TCG_CALL_NO_RWG, void, ptr, i64)
 DEF_HELPER_1(debug, void, env)
 DEF_HELPER_1(save, void, env)
 DEF_HELPER_1(restore, void, env)
-DEF_HELPER_FLAGS_3(udiv, TCG_CALL_NO_WG, tl, env, tl, tl)
 DEF_HELPER_FLAGS_3(sdiv, TCG_CALL_NO_WG, tl, env, tl, tl)
 DEF_HELPER_3(udiv_cc, tl, env, tl, tl)
 DEF_HELPER_3(sdiv_cc, tl, env, tl, tl)
diff --git a/target/sparc/helper.c b/target/sparc/helper.c
index 3830d01634..1a900753d7 100644
--- a/target/sparc/helper.c
+++ b/target/sparc/helper.c
@@ -81,15 +81,14 @@ void helper_tick_set_limit(void *opaque, uint64_t limit)
 }
 #endif
 
-static target_ulong do_udiv(CPUSPARCState *env, target_ulong a,
-                            target_ulong b, int cc, uintptr_t ra)
+target_ulong helper_udiv_cc(CPUSPARCState *env, target_ulong a, target_ulong b)
 {
     target_ulong v, r;
     uint64_t x0 = (uint32_t)a | ((uint64_t)env->y << 32);
     uint32_t x1 = b;
 
     if (x1 == 0) {
-        cpu_raise_exception_ra(env, TT_DIV_ZERO, ra);
+        cpu_raise_exception_ra(env, TT_DIV_ZERO, GETPC());
     }
 
     x0 = x0 / x1;
@@ -99,29 +98,17 @@ static target_ulong do_udiv(CPUSPARCState *env, target_ulong a,
         v = r = UINT32_MAX;
     }
 
-    if (cc) {
-        env->cc_N = r;
-        env->cc_V = v;
-        env->cc_icc_Z = r;
-        env->cc_icc_C = 0;
+    env->cc_N = r;
+    env->cc_V = v;
+    env->cc_icc_Z = r;
+    env->cc_icc_C = 0;
 #ifdef TARGET_SPARC64
-        env->cc_xcc_Z = r;
-        env->cc_xcc_C = 0;
+    env->cc_xcc_Z = r;
+    env->cc_xcc_C = 0;
 #endif
-    }
     return r;
 }
 
-target_ulong helper_udiv(CPUSPARCState *env, target_ulong a, target_ulong b)
-{
-    return do_udiv(env, a, b, 0, GETPC());
-}
-
-target_ulong helper_udiv_cc(CPUSPARCState *env, target_ulong a, target_ulong b)
-{
-    return do_udiv(env, a, b, 1, GETPC());
-}
-
 static target_ulong do_sdiv(CPUSPARCState *env, target_ulong a,
                             target_ulong b, int cc, uintptr_t ra)
 {
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index b344422f8a..2c533a1998 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -576,11 +576,6 @@ static void gen_op_smul(TCGv dst, TCGv src1, TCGv src2)
     gen_op_multiply(dst, src1, src2, 1);
 }
 
-static void gen_op_udiv(TCGv dst, TCGv src1, TCGv src2)
-{
-    gen_helper_udiv(dst, tcg_env, src1, src2);
-}
-
 static void gen_op_sdiv(TCGv dst, TCGv src1, TCGv src2)
 {
     gen_helper_sdiv(dst, tcg_env, src1, src2);
@@ -3615,7 +3610,6 @@ TRANS(XORN, ALL, do_arith, a, tcg_gen_eqv_tl, NULL)
 TRANS(MULX, 64, do_arith, a, tcg_gen_mul_tl, tcg_gen_muli_tl)
 TRANS(UMUL, MUL, do_arith, a, gen_op_umul, NULL)
 TRANS(SMUL, MUL, do_arith, a, gen_op_smul, NULL)
-TRANS(UDIV, DIV, do_arith, a, gen_op_udiv, NULL)
 TRANS(SDIV, DIV, do_arith, a, gen_op_sdiv, NULL)
 TRANS(ADDC, ALL, do_arith, a, gen_op_addc, NULL)
 TRANS(SUBC, ALL, do_arith, a, gen_op_subc, NULL)
@@ -3642,6 +3636,52 @@ TRANS(ADDCcc, ALL, do_arith, a, gen_op_addccc, NULL)
 TRANS(SUBCcc, ALL, do_arith, a, gen_op_subccc, NULL)
 TRANS(MULScc, ALL, do_arith, a, gen_op_mulscc, NULL)
 
+static bool trans_UDIV(DisasContext *dc, arg_r_r_ri *a)
+{
+    TCGv_i64 t1, t2;
+    TCGv dst;
+
+    /* For simplicity, we under-decoded the rs2 form. */
+    if (!a->imm && a->rs2_or_imm & ~0x1f) {
+        return false;
+    }
+
+    if (unlikely(a->rs2_or_imm == 0)) {
+        gen_exception(dc, TT_DIV_ZERO);
+        return true;
+    }
+
+    if (a->imm) {
+        t2 = tcg_constant_i64((uint32_t)a->rs2_or_imm);
+    } else {
+        TCGLabel *lab;
+        TCGv_i32 n2;
+
+        finishing_insn(dc);
+        flush_cond(dc);
+
+        n2 = tcg_temp_new_i32();
+        tcg_gen_trunc_tl_i32(n2, cpu_regs[a->rs2_or_imm]);
+
+        lab = delay_exception(dc, TT_DIV_ZERO);
+        tcg_gen_brcondi_i32(TCG_COND_EQ, n2, 0, lab);
+
+        t2 = tcg_temp_new_i64();
+        tcg_gen_extu_tl_i64(t2, cpu_regs[a->rs2_or_imm]);
+    }
+
+    t1 = tcg_temp_new_i64();
+    tcg_gen_concat_tl_i64(t1, gen_load_gpr(dc, a->rs1), cpu_y);
+
+    tcg_gen_divu_i64(t1, t1, t2);
+    tcg_gen_umin_i64(t1, t1, tcg_constant_i64(UINT32_MAX));
+
+    dst = gen_dest_gpr(dc, a->rd);
+    tcg_gen_trunc_i64_tl(dst, t1);
+    gen_store_gpr(dc, a->rd, dst);
+    return advance_pc(dc);
+}
+
 static bool trans_UDIVX(DisasContext *dc, arg_r_r_ri *a)
 {
     TCGv dst, src1, src2;
-- 
2.34.1


