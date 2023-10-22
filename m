Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC157D2143
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 08:05:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quRWT-0000he-9H; Sun, 22 Oct 2023 02:01:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRWH-0000bz-1P
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:01:02 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRWF-0001c0-6Z
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:01:00 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3b2f5aed39cso1591971b6e.1
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 23:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697954458; x=1698559258; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FfOR1gXeN1HnAitPqmUHhUxlxRgSaGKHSuKSbXE/YfQ=;
 b=qsRdnE7tx3vsp18cmHxYin5UHu9p3r4sZVvOUSyZZ1YZqVz9UPeVSNlIQehid2bP1f
 y0jRVuWzpMfLb45+5I7BaHc16pfEqNOWX1fpTrnJMkQIumGxkVi7dbQlSny90+yDGdTn
 10Pn3ak479s87zghhJkNjWHd3Zv7ep7mhjrF2/5tMFJ4pnYFXg8r0r4NVsJXWF8j+CVm
 oVpIfbFYTRmOsyEIgPBuWypN6WGCru5wchhe+ajaftPr5zZSGJsp2yRFoxYwHzyVJES3
 mlo3VS623k+JcYTE2XI2fRt7/nEv08APGAVb7LSAVN+8i0DIyaYCFiMPszxY/4DO+5ls
 9Weg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697954458; x=1698559258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FfOR1gXeN1HnAitPqmUHhUxlxRgSaGKHSuKSbXE/YfQ=;
 b=UoJZPEI1+TWh5JRkmdcXHEJHzwfyR6UbhV1wVQSSz+2pR3JHMfLDGrvGzbYWjWUejL
 fOoMRiyyAC8N2IbWz0xuJCXh3mDNWpzp5W4V3USg+uQHbtWn9fdADXgeCinYdQe50ug2
 Uu+68OHJ9Ruw5Pw+B+7qAjFylvJMMYLP9YB8+pHRdXvmCLNopUuYQjXgwHcYvkxQZIkg
 SJ/qx/awjDfCqjOgbWoJG9nLqpOERiQNbLncQKzUiaxqQPZI4VrfAMxkLxCoGYyVsxVy
 hwmYMPgdZM45/jnFWaBKTKSTpdzvzES1ZHeOm1P8iR9BnVQEM1RTVtcpg+xsQHrH6fHg
 5TnA==
X-Gm-Message-State: AOJu0YxOA0Q7POFiZLeAIICns6cmhKYEAk493+ULhrxPK4lnYsej1M3S
 cii7rY5RFwSFTF82eA7oiLqCCVSalfHPfdkd5D8=
X-Google-Smtp-Source: AGHT+IHwm7xarXNb6NTL8xTAkhz80eTQ3r7L4DD28FprvMI0NHDKZMX8/8NpP2nogqGGMNJJnG5wPg==
X-Received: by 2002:a05:6808:64d:b0:3a8:80ea:f0c6 with SMTP id
 z13-20020a056808064d00b003a880eaf0c6mr5873416oih.29.1697954457805; 
 Sat, 21 Oct 2023 23:00:57 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 je17-20020a170903265100b001c728609574sm3999887plb.6.2023.10.21.23.00.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 23:00:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 30/90] target/sparc: Move ADDC to decodetree
Date: Sat, 21 Oct 2023 22:59:31 -0700
Message-Id: <20231022060031.490251-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022060031.490251-1-richard.henderson@linaro.org>
References: <20231022060031.490251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22c.google.com
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
 target/sparc/translate.c  | 162 ++++++++++++++++++++++++--------------
 2 files changed, 105 insertions(+), 58 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 3271c2997d..1cff18fa1f 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -163,6 +163,7 @@ SUB         10 ..... 0.0100 ..... . .............          @r_r_ri_cc
 ANDN        10 ..... 0.0101 ..... . .............          @r_r_ri_cc
 ORN         10 ..... 0.0110 ..... . .............          @r_r_ri_cc
 XORN        10 ..... 0.0111 ..... . .............          @r_r_ri_cc
+ADDC        10 ..... 0.1000 ..... . .............          @r_r_ri_cc
 
 Tcc_r       10 0 cond:4 111010 rs1:5 0 cc:1 0000000 rs2:5
 {
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 4bb545e9c5..c87125a328 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -434,71 +434,89 @@ static TCGv_i32 gen_sub32_carry32(void)
     return carry_32;
 }
 
-static void gen_op_addx_int(DisasContext *dc, TCGv dst, TCGv src1,
-                            TCGv src2, int update_cc)
+static void gen_op_addc_int(TCGv dst, TCGv src1, TCGv src2,
+                            TCGv_i32 carry_32, bool update_cc)
 {
-    TCGv_i32 carry_32;
-    TCGv carry;
+    tcg_gen_add_tl(dst, src1, src2);
 
-    switch (dc->cc_op) {
-    case CC_OP_DIV:
-    case CC_OP_LOGIC:
-        /* Carry is known to be zero.  Fall back to plain ADD.  */
-        if (update_cc) {
-            gen_op_add_cc(dst, src1, src2);
-        } else {
-            tcg_gen_add_tl(dst, src1, src2);
-        }
-        return;
-
-    case CC_OP_ADD:
-    case CC_OP_TADD:
-    case CC_OP_TADDTV:
-        if (TARGET_LONG_BITS == 32) {
-            /* We can re-use the host's hardware carry generation by using
-               an ADD2 opcode.  We discard the low part of the output.
-               Ideally we'd combine this operation with the add that
-               generated the carry in the first place.  */
-            carry = tcg_temp_new();
-            tcg_gen_add2_tl(carry, dst, cpu_cc_src, src1, cpu_cc_src2, src2);
-            goto add_done;
-        }
-        carry_32 = gen_add32_carry32();
-        break;
-
-    case CC_OP_SUB:
-    case CC_OP_TSUB:
-    case CC_OP_TSUBTV:
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
-#if TARGET_LONG_BITS == 64
-    carry = tcg_temp_new();
-    tcg_gen_extu_i32_i64(carry, carry_32);
+#ifdef TARGET_SPARC64
+    TCGv carry = tcg_temp_new();
+    tcg_gen_extu_i32_tl(carry, carry_32);
+    tcg_gen_add_tl(dst, dst, carry);
 #else
-    carry = carry_32;
+    tcg_gen_add_i32(dst, dst, carry_32);
 #endif
 
-    tcg_gen_add_tl(dst, src1, src2);
-    tcg_gen_add_tl(dst, dst, carry);
-
- add_done:
     if (update_cc) {
+        tcg_debug_assert(dst == cpu_cc_dst);
         tcg_gen_mov_tl(cpu_cc_src, src1);
         tcg_gen_mov_tl(cpu_cc_src2, src2);
-        tcg_gen_mov_tl(cpu_cc_dst, dst);
-        tcg_gen_movi_i32(cpu_cc_op, CC_OP_ADDX);
-        dc->cc_op = CC_OP_ADDX;
     }
 }
 
+static void gen_op_addc_int_add(TCGv dst, TCGv src1, TCGv src2, bool update_cc)
+{
+    TCGv discard;
+
+    if (TARGET_LONG_BITS == 64) {
+        gen_op_addc_int(dst, src1, src2, gen_add32_carry32(), update_cc);
+        return;
+    }
+
+    /*
+     * We can re-use the host's hardware carry generation by using
+     * an ADD2 opcode.  We discard the low part of the output.
+     * Ideally we'd combine this operation with the add that
+     * generated the carry in the first place.
+     */
+    discard = tcg_temp_new();
+    tcg_gen_add2_tl(discard, dst, cpu_cc_src, src1, cpu_cc_src2, src2);
+
+    if (update_cc) {
+        tcg_debug_assert(dst == cpu_cc_dst);
+        tcg_gen_mov_tl(cpu_cc_src, src1);
+        tcg_gen_mov_tl(cpu_cc_src2, src2);
+    }
+}
+
+static void gen_op_addc_add(TCGv dst, TCGv src1, TCGv src2)
+{
+    gen_op_addc_int_add(dst, src1, src2, false);
+}
+
+static void gen_op_addccc_add(TCGv dst, TCGv src1, TCGv src2)
+{
+    gen_op_addc_int_add(dst, src1, src2, true);
+}
+
+static void gen_op_addc_sub(TCGv dst, TCGv src1, TCGv src2)
+{
+    gen_op_addc_int(dst, src1, src2, gen_sub32_carry32(), false);
+}
+
+static void gen_op_addccc_sub(TCGv dst, TCGv src1, TCGv src2)
+{
+    gen_op_addc_int(dst, src1, src2, gen_sub32_carry32(), true);
+}
+
+static void gen_op_addc_int_generic(TCGv dst, TCGv src1, TCGv src2,
+                                    bool update_cc)
+{
+    TCGv_i32 carry_32 = tcg_temp_new_i32();
+    gen_helper_compute_C_icc(carry_32, tcg_env);
+    gen_op_addc_int(dst, src1, src2, carry_32, update_cc);
+}
+
+static void gen_op_addc_generic(TCGv dst, TCGv src1, TCGv src2)
+{
+    gen_op_addc_int_generic(dst, src1, src2, false);
+}
+
+static void gen_op_addccc_generic(TCGv dst, TCGv src1, TCGv src2)
+{
+    gen_op_addc_int_generic(dst, src1, src2, true);
+}
+
 static void gen_op_sub_cc(TCGv dst, TCGv src1, TCGv src2)
 {
     tcg_gen_mov_tl(cpu_cc_src, src1);
@@ -4226,6 +4244,38 @@ static bool trans_SUB(DisasContext *dc, arg_r_r_ri_cc *a)
     return do_arith(dc, a, -1, tcg_gen_sub_tl, tcg_gen_subi_tl);
 }
 
+static bool trans_ADDC(DisasContext *dc, arg_r_r_ri_cc *a)
+{
+    void (*func)(TCGv, TCGv, TCGv);
+
+    switch (dc->cc_op) {
+    case CC_OP_DIV:
+    case CC_OP_LOGIC:
+        /* Carry is known to be zero.  Fall back to plain ADD.  */
+        if (a->cc) {
+            return do_arith(dc, a, CC_OP_ADD, gen_op_add_cc, NULL);
+        }
+        return do_arith(dc, a, -1, tcg_gen_add_tl, tcg_gen_addi_tl);
+
+    case CC_OP_ADD:
+    case CC_OP_TADD:
+    case CC_OP_TADDTV:
+        func = a->cc ? gen_op_addccc_add : gen_op_addc_add;
+        break;
+
+    case CC_OP_SUB:
+    case CC_OP_TSUB:
+    case CC_OP_TSUBTV:
+        func = a->cc ? gen_op_addccc_sub : gen_op_addc_sub;
+        break;
+
+    default:
+        func = a->cc ? gen_op_addccc_generic : gen_op_addc_generic;
+        break;
+    }
+    return do_arith(dc, a, CC_OP_ADDX, func, NULL);
+}
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -4650,10 +4700,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     cpu_src1 = get_src1(dc, insn);
                     cpu_src2 = get_src2(dc, insn);
                     switch (xop & ~0x10) {
-                    case 0x8: /* addx, V9 addc */
-                        gen_op_addx_int(dc, cpu_dst, cpu_src1, cpu_src2,
-                                        (xop & 0x10));
-                        break;
 #ifdef TARGET_SPARC64
                     case 0x9: /* V9 mulx */
                         tcg_gen_mul_i64(cpu_dst, cpu_src1, cpu_src2);
-- 
2.34.1


