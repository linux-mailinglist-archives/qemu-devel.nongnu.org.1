Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDF27D1B34
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 07:48:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu4bK-0007KV-Kr; Sat, 21 Oct 2023 01:32:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4b5-0007F6-QD
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:32:29 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4b3-0008SA-TJ
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:32:27 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6b1ef786b7fso1418028b3a.3
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 22:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697866344; x=1698471144; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jlGUcpyMuqLxu8BTPX1lWRrtKe0+ojjXPoCWAq8Re84=;
 b=tl9SdBstbIXmY1/Og3Gd10m6ckp+eCwiOKAA746psiV6lqfidY8XOI6UhE/ge/TNhu
 XMsgPxBU/429o1M3FO1jTyY/cqmbCqf1x/ntRCoXmiNFSYuxpycM4Zz9O0r/DgRb/F4n
 tk7aVouWanhyDaN4+uVv4FhEhs/vVeQ6aLiCsDxm2TkHyutqVvotcgxPPG3sP9MdLfnR
 NE+nf1BUw3GmYjwIZxkzLa/xigZi+f7UUr64Ac3A81uW11BpvmPONIerQkmRxBrGdvqV
 BgxSN7uZCaXmTKfShYREvhrpObVj6UxjKz+vS7+qoeCMcQEStpJz7nZVkfFg0WEWpiva
 4WuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697866344; x=1698471144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jlGUcpyMuqLxu8BTPX1lWRrtKe0+ojjXPoCWAq8Re84=;
 b=q0M3hGJ6N2cy/710Ohdufkh9AhHTsLPT/FY5GTVzpFGMfN3rg13A0EwQ5GsJNcKQYf
 4/f26Mid1PvPjrPX7d9r9ZdZxxDs45zy+UfROlmFUP2s8LE1hc/06c4eztki7WAYSnYr
 vcXVCfDCBEUfbcqmZS/z3c5KZTu569yRWdBKVg/n169jmr2gf/duTzewBMJ2h+u770RD
 p0qL5RrlJMPCAhT2OV3MDhFAl0Q3XIX9cZhHmjaDVROD+QB3WKccJJPBqiYFNAVOk4dD
 rfbWJfsn9yPQwBF/7HXlJVGP/FMkGaetzRexbzZkGSAPEnsLYmHCSPli4k+0v9N3hNkD
 uIDg==
X-Gm-Message-State: AOJu0YxVn3tDYkxx/hbghSVET75XHHmX9LIEHOEt6dI/HkT6ilBvvwPU
 YX43UACVrZqgC5P55O7NFD8fYhpvzE36KwgJwv8=
X-Google-Smtp-Source: AGHT+IEBPfn/iTDyCjg4fa8NTnxc/tGuoTBrEc4cITIXBuhz0krXvtHm/0k9DkBHjP3tJrPPflbgpA==
X-Received: by 2002:a05:6a20:258f:b0:15f:faab:1be1 with SMTP id
 k15-20020a056a20258f00b0015ffaab1be1mr4634515pzd.20.1697866344335; 
 Fri, 20 Oct 2023 22:32:24 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 f20-20020a056a001ad400b006b2677d3684sm2434831pfv.206.2023.10.20.22.32.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 22:32:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 30/90] target/sparc: Move ADDC to decodetree
Date: Fri, 20 Oct 2023 22:30:58 -0700
Message-Id: <20231021053158.278135-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231021053158.278135-1-richard.henderson@linaro.org>
References: <20231021053158.278135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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
index abfcaeb692..959397e62f 100644
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
index ac72fb7d0d..bf41047f66 100644
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
@@ -4185,6 +4203,38 @@ static bool trans_SUB(DisasContext *dc, arg_r_r_ri_cc *a)
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
@@ -4609,10 +4659,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


