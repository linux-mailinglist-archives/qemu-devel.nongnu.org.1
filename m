Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DF37D1AE7
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 07:34:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu4bL-0007Ku-8H; Sat, 21 Oct 2023 01:32:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4b9-0007FQ-9f
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:32:32 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4b7-0008St-Fd
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:32:30 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-517ab9a4a13so1187187a12.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 22:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697866347; x=1698471147; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7iOpxPC6VqGVqOgY76rdiLh5ZrmtpZH6A2OROv484R0=;
 b=dSDGBwLsTX/KBnAQRNIr2RVdetARgh8W7O8le4rCb9+HL5yxeiF1flBWJetqMvhLEr
 ql1o69SCRAIM+qVF3iMbeEvyWTgahRvkDtd4aR/Grfuwbcgr64Zq3KdyCtMzaA36QN2j
 /kBhRO/Az+7ytwOzhbOWGyZSoaJIhXOqMzWFmUJPt9nhXpV/2+FQ47FdQ1Vn3GHa1D9f
 ODaE0SOKWHgIM6b8TiH5dqZftLmNTonqaYvEf/+FvXhqSdbrbsZde2LcLPHqJW/A7MiX
 0U8BjMQ7sqYoyretHMekJEh3dmYqnQq1SEbwA0k0KnRB1vpXJV+KUXf/Tl2B/WolECDT
 F6KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697866347; x=1698471147;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7iOpxPC6VqGVqOgY76rdiLh5ZrmtpZH6A2OROv484R0=;
 b=u29SLjMMwBZJzwv7N06890qj7ttrvXmzoaMBK+lndCGQyC88c5YHKvY0BNIXxJgbcO
 n/hiywiOTxrZ2X7h4cQZuW8UzGf9CsgAWDWdIqcF8un2MngWyyvmp6aY8/41LBhVxFCj
 I53eH6sTWaLrK+RzqBxnXYGVv6a2x30Wno4zIA4QkXmxge9TGJNv4gw+ldFWElZfOXUd
 trTXJnzNhz+2SjEwnvh7pX8i+1r8Da3E+uCuxJuaFYJ1dz58TcrpL5w0apSEvsVcNuKe
 iSLYkQAfeEFdZuvh1OakMTNKFJCEscTKmkylD15d3McqiDtWnaPB3sC9QnrBr6Vnuh6c
 LGLA==
X-Gm-Message-State: AOJu0Yx89z/6ZuQVZCTLOOzeBLqbb7L+Lrf7jPmyYWQaWwQiEq0tmGuB
 ytUHBzb/PbXBoAmXf5yb0peX7GfmY1mOIygmCss=
X-Google-Smtp-Source: AGHT+IE+WDqNswclPMPP73VpHctkKtIPppu1O48r32Uh4S+7fsdKIkJ493VxN3AIzkO/Sb4zj+/xzQ==
X-Received: by 2002:a05:6a20:3d83:b0:174:2d20:5404 with SMTP id
 s3-20020a056a203d8300b001742d205404mr4889449pzi.37.1697866347019; 
 Fri, 20 Oct 2023 22:32:27 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 f20-20020a056a001ad400b006b2677d3684sm2434831pfv.206.2023.10.20.22.32.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 22:32:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 33/90] target/sparc: Move SUBC to decodetree
Date: Fri, 20 Oct 2023 22:31:01 -0700
Message-Id: <20231021053158.278135-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231021053158.278135-1-richard.henderson@linaro.org>
References: <20231021053158.278135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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
 target/sparc/insns.decode |   1 +
 target/sparc/translate.c  | 147 +++++++++++++++++++++++++-------------
 2 files changed, 98 insertions(+), 50 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index f214baf465..ca54a090a3 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -165,6 +165,7 @@ ANDN        10 ..... 0.0101 ..... . .............          @r_r_ri_cc
 ORN         10 ..... 0.0110 ..... . .............          @r_r_ri_cc
 XORN        10 ..... 0.0111 ..... . .............          @r_r_ri_cc
 ADDC        10 ..... 0.1000 ..... . .............          @r_r_ri_cc
+SUBC        10 ..... 0.1100 ..... . .............          @r_r_ri_cc
 
 MULX        10 ..... 001001 ..... . .............          @r_r_ri_cc0
 UMUL        10 ..... 0.1010 ..... . .............          @r_r_ri_cc
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 4744e8caca..2c9f5ec317 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -525,51 +525,11 @@ static void gen_op_sub_cc(TCGv dst, TCGv src1, TCGv src2)
     tcg_gen_mov_tl(dst, cpu_cc_dst);
 }
 
-static void gen_op_subx_int(DisasContext *dc, TCGv dst, TCGv src1,
-                            TCGv src2, int update_cc)
+static void gen_op_subc_int(TCGv dst, TCGv src1, TCGv src2,
+                            TCGv_i32 carry_32, bool update_cc)
 {
-    TCGv_i32 carry_32;
     TCGv carry;
 
-    switch (dc->cc_op) {
-    case CC_OP_DIV:
-    case CC_OP_LOGIC:
-        /* Carry is known to be zero.  Fall back to plain SUB.  */
-        if (update_cc) {
-            gen_op_sub_cc(dst, src1, src2);
-        } else {
-            tcg_gen_sub_tl(dst, src1, src2);
-        }
-        return;
-
-    case CC_OP_ADD:
-    case CC_OP_TADD:
-    case CC_OP_TADDTV:
-        carry_32 = gen_add32_carry32();
-        break;
-
-    case CC_OP_SUB:
-    case CC_OP_TSUB:
-    case CC_OP_TSUBTV:
-        if (TARGET_LONG_BITS == 32) {
-            /* We can re-use the host's hardware carry generation by using
-               a SUB2 opcode.  We discard the low part of the output.
-               Ideally we'd combine this operation with the add that
-               generated the carry in the first place.  */
-            carry = tcg_temp_new();
-            tcg_gen_sub2_tl(carry, dst, cpu_cc_src, src1, cpu_cc_src2, src2);
-            goto sub_done;
-        }
-        carry_32 = gen_sub32_carry32();
-        break;
-
-    default:
-        /* We need external help to produce the carry.  */
-        carry_32 = tcg_temp_new_i32();
-        gen_helper_compute_C_icc(carry_32, tcg_env);
-        break;
-    }
-
 #if TARGET_LONG_BITS == 64
     carry = tcg_temp_new();
     tcg_gen_extu_i32_i64(carry, carry_32);
@@ -580,16 +540,75 @@ static void gen_op_subx_int(DisasContext *dc, TCGv dst, TCGv src1,
     tcg_gen_sub_tl(dst, src1, src2);
     tcg_gen_sub_tl(dst, dst, carry);
 
- sub_done:
     if (update_cc) {
+        tcg_debug_assert(dst == cpu_cc_dst);
         tcg_gen_mov_tl(cpu_cc_src, src1);
         tcg_gen_mov_tl(cpu_cc_src2, src2);
-        tcg_gen_mov_tl(cpu_cc_dst, dst);
-        tcg_gen_movi_i32(cpu_cc_op, CC_OP_SUBX);
-        dc->cc_op = CC_OP_SUBX;
     }
 }
 
+static void gen_op_subc_add(TCGv dst, TCGv src1, TCGv src2)
+{
+    gen_op_subc_int(dst, src1, src2, gen_add32_carry32(), false);
+}
+
+static void gen_op_subccc_add(TCGv dst, TCGv src1, TCGv src2)
+{
+    gen_op_subc_int(dst, src1, src2, gen_sub32_carry32(), true);
+}
+
+static void gen_op_subc_int_sub(TCGv dst, TCGv src1, TCGv src2, bool update_cc)
+{
+    TCGv discard;
+
+    if (TARGET_LONG_BITS == 64) {
+        gen_op_subc_int(dst, src1, src2, gen_sub32_carry32(), update_cc);
+        return;
+    }
+
+    /*
+     * We can re-use the host's hardware carry generation by using
+     * a SUB2 opcode.  We discard the low part of the output.
+     */
+    discard = tcg_temp_new();
+    tcg_gen_sub2_tl(discard, dst, cpu_cc_src, src1, cpu_cc_src2, src2);
+
+    if (update_cc) {
+        tcg_debug_assert(dst == cpu_cc_dst);
+        tcg_gen_mov_tl(cpu_cc_src, src1);
+        tcg_gen_mov_tl(cpu_cc_src2, src2);
+    }
+}
+
+static void gen_op_subc_sub(TCGv dst, TCGv src1, TCGv src2)
+{
+    gen_op_subc_int_sub(dst, src1, src2, false);
+}
+
+static void gen_op_subccc_sub(TCGv dst, TCGv src1, TCGv src2)
+{
+    gen_op_subc_int_sub(dst, src1, src2, true);
+}
+
+static void gen_op_subc_int_generic(TCGv dst, TCGv src1, TCGv src2,
+                                    bool update_cc)
+{
+    TCGv_i32 carry_32 = tcg_temp_new_i32();
+
+    gen_helper_compute_C_icc(carry_32, tcg_env);
+    gen_op_subc_int(dst, src1, src2, carry_32, update_cc);
+}
+
+static void gen_op_subc_generic(TCGv dst, TCGv src1, TCGv src2)
+{
+    gen_op_subc_int_generic(dst, src1, src2, false);
+}
+
+static void gen_op_subccc_generic(TCGv dst, TCGv src1, TCGv src2)
+{
+    gen_op_subc_int_generic(dst, src1, src2, true);
+}
+
 static void gen_op_mulscc(TCGv dst, TCGv src1, TCGv src2)
 {
     TCGv r_temp, zero, t0;
@@ -4239,6 +4258,38 @@ static bool trans_ADDC(DisasContext *dc, arg_r_r_ri_cc *a)
     return do_arith(dc, a, CC_OP_ADDX, func, NULL);
 }
 
+static bool trans_SUBC(DisasContext *dc, arg_r_r_ri_cc *a)
+{
+    void (*func)(TCGv, TCGv, TCGv);
+
+    switch (dc->cc_op) {
+    case CC_OP_DIV:
+    case CC_OP_LOGIC:
+        /* Carry is known to be zero.  Fall back to plain SUB.  */
+        if (a->cc) {
+            return do_arith(dc, a, CC_OP_SUB, gen_op_sub_cc, NULL);
+        }
+        return do_arith(dc, a, -1, tcg_gen_sub_tl, tcg_gen_subi_tl);
+
+    case CC_OP_ADD:
+    case CC_OP_TADD:
+    case CC_OP_TADDTV:
+        func = a->cc ? gen_op_subccc_add : gen_op_subc_add;
+        break;
+
+    case CC_OP_SUB:
+    case CC_OP_TSUB:
+    case CC_OP_TSUBTV:
+        func = a->cc ? gen_op_subccc_sub : gen_op_subc_sub;
+        break;
+
+    default:
+        func = a->cc ? gen_op_subccc_generic : gen_op_subc_generic;
+        break;
+    }
+    return do_arith(dc, a, CC_OP_SUBX, func, NULL);
+}
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -4663,10 +4714,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     cpu_src1 = get_src1(dc, insn);
                     cpu_src2 = get_src2(dc, insn);
                     switch (xop & ~0x10) {
-                    case 0xc: /* subx, V9 subc */
-                        gen_op_subx_int(dc, cpu_dst, cpu_src1, cpu_src2,
-                                        (xop & 0x10));
-                        break;
 #ifdef TARGET_SPARC64
                     case 0xd: /* V9 udivx */
                         gen_helper_udivx(cpu_dst, tcg_env, cpu_src1, cpu_src2);
-- 
2.34.1


