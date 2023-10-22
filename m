Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E90787D26FF
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 01:32:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quhtY-0007HA-QZ; Sun, 22 Oct 2023 19:30:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhtW-0007FB-KW
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:30:06 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhtU-0006vq-J8
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:30:06 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6bd73395bceso1934131b3a.0
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 16:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698017403; x=1698622203; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rkAqtrZ7b6nSMFGQGrcOgVLoMwovDweF7VCAkmVboSw=;
 b=ruu9PY6asNKuD4SfqxQMLG9CEtmtN2e8mKjbm3j2EvZkncBtt/bNUj3PRsiahblpKr
 9W2hfwM+FwqYux0sqmMQHWhHTrYX/DMq4qq1dem/gWE9AG0HtfC84Rx4M9/VU4CcqAso
 lQZx0YY1wjS6mSTYBI2qLPuneaZCak65R0IUt6SR9V9U5JqeBbNR11492N6157+b1OyS
 Uht2B6wd8JhLueD1ZSjG9dG3IA+HNLNEU4jCONPs3pKTXmavyZTA8bW9Xhk50czU/45a
 uLjn5Pkuj2viHcSwwRrMrkn1s4CJhSBCE9WwTDK6VtP4TX1eF9MG7yoYSqcnhkyT6+HH
 U3rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698017403; x=1698622203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rkAqtrZ7b6nSMFGQGrcOgVLoMwovDweF7VCAkmVboSw=;
 b=Oh6beWE9oTu5Oou7BGUNAPz6znhw52DCnWf60Edt+N4VE8FJiwIeh7i4GzLjXlOOu1
 ZnyQuz9xz3FS5vkjt8q5excShzA2l8g11uG4Zrb55LmDcQt3eoX1Otix48AZqMIhTZxe
 tt8jQ7v1mw24YoHY3y99Nv1z+4KUDhw4nCalYyuCcGhNsKRk6jyO4EMYZJZGnD4/Sk9k
 ibG0jTI7D97hls/OsCibw3XGDOorXQi7zH9K+HXMVXTW4DowJZJe+LOkhJPZK8KO6S7L
 +tA8WFxIr4pJveyxjdFGCcrtUPRN7WwUWtFbCDe7KTjwrpa2gZsJv8UIDmFVY+EJPl2L
 Q8HA==
X-Gm-Message-State: AOJu0YzvMqpbuciRniYt1RdqBWQRJ9Jp56weG2yVsZbrRV4n+3YoKbMX
 ABS23ftsvLd1X44etT9PddzQT+wEpbnQ6q+JuMQ=
X-Google-Smtp-Source: AGHT+IFOp20v2ErG+VxffaJKKicpEz+wLra2gboXR7yLQRVYoywgZV6Nq0I/A+AG52mg4ZIv0o0P5Q==
X-Received: by 2002:a05:6a20:7d8c:b0:17e:4f56:ebe3 with SMTP id
 v12-20020a056a207d8c00b0017e4f56ebe3mr550393pzj.10.1698017403286; 
 Sun, 22 Oct 2023 16:30:03 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k26-20020a63ba1a000000b005b25a04cf8bsm4023772pgf.12.2023.10.22.16.30.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 16:30:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v5 34/94] target/sparc: Move ADDC to decodetree
Date: Sun, 22 Oct 2023 16:28:32 -0700
Message-Id: <20231022232932.80507-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022232932.80507-1-richard.henderson@linaro.org>
References: <20231022232932.80507-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |   1 +
 target/sparc/translate.c  | 154 ++++++++++++++++++++++++--------------
 2 files changed, 97 insertions(+), 58 deletions(-)

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
index c587e6519e..d27876084e 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -447,71 +447,89 @@ static TCGv_i32 gen_sub32_carry32(void)
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
@@ -4095,6 +4113,30 @@ TRANS(ADD, ALL, do_arith, a, CC_OP_ADD,
 TRANS(SUB, ALL, do_arith, a, CC_OP_SUB,
       tcg_gen_sub_tl, tcg_gen_subi_tl, gen_op_sub_cc)
 
+static bool trans_ADDC(DisasContext *dc, arg_r_r_ri_cc *a)
+{
+    switch (dc->cc_op) {
+    case CC_OP_DIV:
+    case CC_OP_LOGIC:
+        /* Carry is known to be zero.  Fall back to plain ADD.  */
+        return do_arith(dc, a, CC_OP_ADD,
+                        tcg_gen_add_tl, tcg_gen_addi_tl, gen_op_add_cc);
+    case CC_OP_ADD:
+    case CC_OP_TADD:
+    case CC_OP_TADDTV:
+        return do_arith(dc, a, CC_OP_ADDX,
+                        gen_op_addc_add, NULL, gen_op_addccc_add);
+    case CC_OP_SUB:
+    case CC_OP_TSUB:
+    case CC_OP_TSUBTV:
+        return do_arith(dc, a, CC_OP_ADDX,
+                        gen_op_addc_sub, NULL, gen_op_addccc_sub);
+    default:
+        return do_arith(dc, a, CC_OP_ADDX,
+                        gen_op_addc_generic, NULL, gen_op_addccc_generic);
+    }
+}
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -4519,10 +4561,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


