Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF10A7CBB7E
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:43:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdli-0007rc-Ee; Tue, 17 Oct 2023 02:41:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdlW-0007qw-29
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:41:18 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdlS-0001qD-Ru
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:41:16 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1ca72f8ff3aso11751105ad.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697524873; x=1698129673; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yfEgZHzJR6F/R4oI34yVNGiG2eavTL8cA83U55eNzd0=;
 b=NLuiPWnqlfPveViZTOyn9DDzAh3o5fHxzQIanZBn9YgsjOXim8/wEwPZbqsCLhzyZe
 KO2Hiu6dUKh8HbcfS3n9AAprJOXEnC7o83VRIfgIPqIXoZInhA/7yf0qbtOnurrqs8H4
 O0e//d7jN2l705SjmoBhcB5ekkJzhPuWYztBb7zlOG7qFCye/57zTBCi5uIiHRO8FNNb
 NrkvL6VTCXrS4BlDaDGcG6O7jCCDD5QQ/M9gZwnl6t2+gmTg/FBmU3yel8M9Hxp+d1h4
 IzKvE7B0Ku7c3nsC01elXZNXVRkRHOm3mjopPxGAjB1tQJX6pB5TwEHKpgfbPmM/jIo6
 EH2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697524873; x=1698129673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yfEgZHzJR6F/R4oI34yVNGiG2eavTL8cA83U55eNzd0=;
 b=PRHGIM9YdRGzD1nymSOIpRZ86I/zIp3cxlBLwL2j70cx5XIT0cGxzXte8DaVD+X8y7
 /wPY8J8dZMLi23AKGs6QqB6HW6hV47eYLzb6NxeSN/Aej0xPPygLvrxzCGPBbLu5+0EM
 Qmph8uxN880WOF6gDj2R6dIRBxRB8XpHlCxXJz88JxdiGNZPdJFmKvcdg/CV9b9sKnGr
 BPDVMz0sVuU+dTt6xwp3FNLJTosBQYkaZlDZz28Yr47fZvehqZRo3fcF+TZ94DcOHV5r
 fHZKsdJPt56pQ1/gSDAtMMtrIpFQTqGjiTZobbJhU8FpLiADjvc8LLPZ+J71+DP/TM7Q
 rXFg==
X-Gm-Message-State: AOJu0YyszXGhbGMb0uzaoaFxiCu6I/ABaY++q2ioo1OADpp7VKTz0csU
 XtrF0Sup9F1bEpVQocZgWLa9NtUdp0ZUQ11GvKY=
X-Google-Smtp-Source: AGHT+IHybzxTDBXuCJ5j8mqm0k+A+otPyP1NEVhCnoHLWlOwLiA7Q1O8RrJljDaZ6BINfy8Lr6QTlA==
X-Received: by 2002:a17:903:2309:b0:1c9:e508:ad43 with SMTP id
 d9-20020a170903230900b001c9e508ad43mr1587210plh.8.1697524873510; 
 Mon, 16 Oct 2023 23:41:13 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 x18-20020a17090300d200b001b891259eddsm685682plc.197.2023.10.16.23.41.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:41:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 04/20] target/sparc: Remove CC_OP_LOGIC
Date: Mon, 16 Oct 2023 23:40:53 -0700
Message-Id: <20231017064109.681935-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017064109.681935-1-richard.henderson@linaro.org>
References: <20231017064109.681935-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/cpu.h       |  1 -
 target/sparc/cc_helper.c | 19 --------
 target/sparc/translate.c | 97 +++++++++++++++++-----------------------
 3 files changed, 40 insertions(+), 77 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index df49d8423a..48e549f7cb 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -158,7 +158,6 @@ enum {
     CC_OP_SUBX,    /* modify all flags, CC_DST = res, CC_SRC = src1 */
     CC_OP_TSUB,    /* modify all flags, CC_DST = res, CC_SRC = src1 */
     CC_OP_TSUBTV,  /* modify all flags except V, CC_DST = res, CC_SRC = src1 */
-    CC_OP_LOGIC,   /* modify N and Z, C = V = 0, CC_DST = res */
     CC_OP_NB,
 };
 
diff --git a/target/sparc/cc_helper.c b/target/sparc/cc_helper.c
index a6d1a4b9ae..a88399d74a 100644
--- a/target/sparc/cc_helper.c
+++ b/target/sparc/cc_helper.c
@@ -354,23 +354,6 @@ static uint32_t compute_all_tsubtv(CPUSPARCState *env)
     return ret;
 }
 
-static uint32_t compute_all_logic(CPUSPARCState *env)
-{
-    return get_NZ_icc(CC_DST);
-}
-
-static uint32_t compute_C_logic(CPUSPARCState *env)
-{
-    return 0;
-}
-
-#ifdef TARGET_SPARC64
-static uint32_t compute_all_logic_xcc(CPUSPARCState *env)
-{
-    return get_NZ_xcc(CC_DST);
-}
-#endif
-
 typedef struct CCTable {
     uint32_t (*compute_all)(CPUSPARCState *env); /* return all the flags */
     uint32_t (*compute_c)(CPUSPARCState *env);  /* return the C flag */
@@ -386,7 +369,6 @@ static const CCTable icc_table[CC_OP_NB] = {
     [CC_OP_SUBX] = { compute_all_subx, compute_C_subx },
     [CC_OP_TSUB] = { compute_all_tsub, compute_C_sub },
     [CC_OP_TSUBTV] = { compute_all_tsubtv, compute_C_sub },
-    [CC_OP_LOGIC] = { compute_all_logic, compute_C_logic },
 };
 
 #ifdef TARGET_SPARC64
@@ -400,7 +382,6 @@ static const CCTable xcc_table[CC_OP_NB] = {
     [CC_OP_SUBX] = { compute_all_subx_xcc, compute_C_subx_xcc },
     [CC_OP_TSUB] = { compute_all_sub_xcc, compute_C_sub_xcc },
     [CC_OP_TSUBTV] = { compute_all_sub_xcc, compute_C_sub_xcc },
-    [CC_OP_LOGIC] = { compute_all_logic_xcc, compute_C_logic },
 };
 #endif
 
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 2ca20ba110..989275b17d 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -437,15 +437,6 @@ static void gen_op_addx_int(DisasContext *dc, TCGv dst, TCGv src1,
     TCGv carry;
 
     switch (dc->cc_op) {
-    case CC_OP_LOGIC:
-        /* Carry is known to be zero.  Fall back to plain ADD.  */
-        if (update_cc) {
-            gen_op_add_cc(dst, src1, src2);
-        } else {
-            tcg_gen_add_tl(dst, src1, src2);
-        }
-        return;
-
     case CC_OP_ADD:
     case CC_OP_TADD:
     case CC_OP_TADDTV:
@@ -509,15 +500,6 @@ static void gen_op_subx_int(DisasContext *dc, TCGv dst, TCGv src1,
     TCGv carry;
 
     switch (dc->cc_op) {
-    case CC_OP_LOGIC:
-        /* Carry is known to be zero.  Fall back to plain SUB.  */
-        if (update_cc) {
-            gen_op_sub_cc(dst, src1, src2);
-        } else {
-            tcg_gen_sub_tl(dst, src1, src2);
-        }
-        return;
-
     case CC_OP_ADD:
     case CC_OP_TADD:
     case CC_OP_TADDTV:
@@ -1069,48 +1051,25 @@ static void gen_compare(DisasCompare *cmp, bool xcc, unsigned int cond,
         -1, /* no overflow */
     };
 
-    static int logic_cond[16] = {
-        TCG_COND_NEVER,
-        TCG_COND_EQ,     /* eq:  Z */
-        TCG_COND_LE,     /* le:  Z | (N ^ V) -> Z | N */
-        TCG_COND_LT,     /* lt:  N ^ V -> N */
-        TCG_COND_EQ,     /* leu: C | Z -> Z */
-        TCG_COND_NEVER,  /* ltu: C -> 0 */
-        TCG_COND_LT,     /* neg: N */
-        TCG_COND_NEVER,  /* vs:  V -> 0 */
-        TCG_COND_ALWAYS,
-        TCG_COND_NE,     /* ne:  !Z */
-        TCG_COND_GT,     /* gt:  !(Z | (N ^ V)) -> !(Z | N) */
-        TCG_COND_GE,     /* ge:  !(N ^ V) -> !N */
-        TCG_COND_NE,     /* gtu: !(C | Z) -> !Z */
-        TCG_COND_ALWAYS, /* geu: !C -> 1 */
-        TCG_COND_GE,     /* pos: !N */
-        TCG_COND_ALWAYS, /* vc:  !V -> 1 */
-    };
-
     TCGv t1, t2;
 
     cmp->is_bool = false;
 
     switch (dc->cc_op) {
-    case CC_OP_LOGIC:
-        cmp->cond = logic_cond[cond];
-    do_compare_dst_0:
-        cmp->c2 = tcg_constant_tl(0);
-        if (TARGET_LONG_BITS == 32 || xcc) {
-            cmp->c1 = cpu_cc_dst;
-        } else {
-            cmp->c1 = t1 = tcg_temp_new();
-            tcg_gen_ext32s_tl(t1, cpu_cc_dst);
-        }
-        return;
 
     case CC_OP_SUB:
         switch (cond) {
         case 6:  /* neg */
         case 14: /* pos */
             cmp->cond = (cond == 6 ? TCG_COND_LT : TCG_COND_GE);
-            goto do_compare_dst_0;
+            cmp->c2 = tcg_constant_tl(0);
+            if (TARGET_LONG_BITS == 32 || xcc) {
+                cmp->c1 = cpu_cc_dst;
+            } else {
+                cmp->c1 = t1 = tcg_temp_new();
+                tcg_gen_ext32s_tl(t1, cpu_cc_dst);
+            }
+            return;
 
         case 7: /* overflow */
         case 15: /* !overflow */
@@ -3726,6 +3685,8 @@ static bool do_cc_arith(DisasContext *dc, arg_r_r_ri *a, int cc_op,
 
     if (cc_op < 0) {
         dst = gen_dest_gpr(dc, a->rd);
+    } else if (cc_op == CC_OP_FLAGS) {
+        dst = cpu_cc_N;
     } else {
         dst = cpu_cc_dst;
         tcg_gen_movi_i32(cpu_cc_op, cc_op);
@@ -3742,6 +3703,21 @@ static bool do_cc_arith(DisasContext *dc, arg_r_r_ri *a, int cc_op,
     } else {
         func(dst, src1, cpu_regs[a->rs2_or_imm]);
     }
+
+    /* Logic insn; to be cleaned up later. */
+    if (cc_op == CC_OP_FLAGS) {
+        tcg_gen_movi_tl(cpu_cc_V, 0);
+        tcg_gen_movi_tl(cpu_icc_C, 0);
+#ifdef TARGET_SPARC64
+        tcg_gen_movi_tl(cpu_xcc_C, 0);
+        tcg_gen_mov_tl(cpu_xcc_Z, dst);
+#endif
+        tcg_gen_mov_tl(cpu_icc_Z, dst);
+
+        tcg_gen_movi_i32(cpu_cc_op, CC_OP_FLAGS);
+        dc->cc_op = CC_OP_FLAGS;
+    }
+
     gen_store_gpr(dc, a->rd, dst);
     return advance_pc(dc);
 }
@@ -3764,6 +3740,13 @@ static bool do_flags_arith(DisasContext *dc, arg_r_r_ri *a, int cc_op,
     return false;
 }
 
+static bool do_logic_cc(DisasContext *dc, arg_r_r_ri *a,
+                        void (*func)(TCGv, TCGv, TCGv),
+                        void (*funci)(TCGv, TCGv, target_long))
+{
+    return do_cc_arith(dc, a, CC_OP_FLAGS, func, funci);
+}
+
 static bool trans_OR(DisasContext *dc, arg_r_r_ri *a)
 {
     /* For simplicity, we under-decoded the rs2 form. */
@@ -3805,15 +3788,15 @@ TRANS(SDIV, DIV, do_arith, a, gen_op_sdiv, NULL)
 TRANS(POPC, 64, do_arith, a, gen_op_popc, NULL)
 
 TRANS(ADDcc, ALL, do_cc_arith, a, CC_OP_ADD, gen_op_add_cc, NULL)
-TRANS(ANDcc, ALL, do_cc_arith, a, CC_OP_LOGIC, tcg_gen_and_tl, tcg_gen_andi_tl)
-TRANS(ORcc, ALL, do_cc_arith, a, CC_OP_LOGIC, tcg_gen_or_tl, tcg_gen_ori_tl)
-TRANS(XORcc, ALL, do_cc_arith, a, CC_OP_LOGIC, tcg_gen_xor_tl, tcg_gen_xori_tl)
+TRANS(ANDcc, ALL, do_logic_cc, a, tcg_gen_and_tl, tcg_gen_andi_tl)
+TRANS(ORcc, ALL, do_logic_cc, a, tcg_gen_or_tl, tcg_gen_ori_tl)
+TRANS(XORcc, ALL, do_logic_cc, a, tcg_gen_xor_tl, tcg_gen_xori_tl)
 TRANS(SUBcc, ALL, do_cc_arith, a, CC_OP_SUB, gen_op_sub_cc, NULL)
-TRANS(ANDNcc, ALL, do_cc_arith, a, CC_OP_LOGIC, tcg_gen_andc_tl, NULL)
-TRANS(ORNcc, ALL, do_cc_arith, a, CC_OP_LOGIC, tcg_gen_orc_tl, NULL)
-TRANS(XORNcc, ALL, do_cc_arith, a, CC_OP_LOGIC, tcg_gen_eqv_tl, NULL)
-TRANS(UMULcc, MUL, do_cc_arith, a, CC_OP_LOGIC, gen_op_umul, NULL)
-TRANS(SMULcc, MUL, do_cc_arith, a, CC_OP_LOGIC, gen_op_smul, NULL)
+TRANS(ANDNcc, ALL, do_logic_cc, a, tcg_gen_andc_tl, NULL)
+TRANS(ORNcc, ALL, do_logic_cc, a, tcg_gen_orc_tl, NULL)
+TRANS(XORNcc, ALL, do_logic_cc, a, tcg_gen_eqv_tl, NULL)
+TRANS(UMULcc, MUL, do_logic_cc, a, gen_op_umul, NULL)
+TRANS(SMULcc, MUL, do_logic_cc, a, gen_op_smul, NULL)
 TRANS(UDIVcc, DIV, do_flags_arith, a, CC_OP_FLAGS, gen_op_udivcc)
 TRANS(SDIVcc, DIV, do_flags_arith, a, CC_OP_FLAGS, gen_op_sdivcc)
 TRANS(TADDcc, ALL, do_cc_arith, a, CC_OP_TADD, gen_op_add_cc, NULL)
-- 
2.34.1


