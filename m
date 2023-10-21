Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC817D1AEF
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 07:34:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu4bM-0007Mf-Lr; Sat, 21 Oct 2023 01:32:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4bA-0007Fk-Tt
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:32:32 -0400
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4b9-0008Tf-2R
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:32:32 -0400
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-1ea45b07c59so1144190fac.0
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 22:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697866349; x=1698471149; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2UcYIxKtjHYsj8AaxTVb8axIcBlRLqYqK/EKXSopODs=;
 b=FhlcyKttLB196DfwXQdJ9ii2YYsV9LXLhmVht4oNrIL8hxQX4MiCX3JR7f292Ku6Hu
 gE/X3qWzAG+fEo2GqTgDKS+bvV42KXMALT2DZmEG03l8T5v07C1ddbUjwhsHRbY/V+Q6
 gbvPC29r8kGFcQh3tZNWu514tnUH+x+QKwwa8ENtJocqBl2YhD7XHw082RYivNblxPj9
 WG+2FT+DHEMQl61nVTrIIIl5LX1xw6o8ZiLeyZ9xtONabVS5cbpyfmWCGOtRbveUL5xU
 4OYx2Gu89jVzYqMtyHUZ9NRZ6xIICftXmYRjqPTcUr7aqKuxq55Zlske5bkk68s4g9+L
 dzPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697866349; x=1698471149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2UcYIxKtjHYsj8AaxTVb8axIcBlRLqYqK/EKXSopODs=;
 b=DZb2XsqjobjRXj2JwXFbvgd+oJ8q2mDF8KUNM6aWrdd9lPj71JZZrt4nSXlF0tj1GR
 1W83OwdPrfcp5MW+YWipzhHHCPjInTvvN5woY9W1eLVM8XHCvIGLLOFJ/LVl8+GEArUf
 FqnIPP7kCOl364gxwpJEwPDHOT1ojqURYriWTyKawHQ4suftmlvA4iDTt/0i11TX+WpI
 TdGz2g7V3h01Q7vJWaU5EK7SsvfnFzJv5imEhRbF/BOYbZkuKx9eWMHzp7B3PDx7HDUM
 0SgF6nNw0rNHUEzzJEX7F1cpx+WzS3O4vDon4Yd5qeG4SFeUD5BjEjPpPAcCWgrkZknN
 1/Bg==
X-Gm-Message-State: AOJu0YxP/6iIzigNnznbAAGy2PzTA3jR9JzliH2/eSG2J0xVR5q9l4j9
 mERM67sZH3TbtClEp7Fkt9mxrvZyrb5nYz1FlnQ=
X-Google-Smtp-Source: AGHT+IEwWVAlhPCEaI7N+F5ajUj+63TvV3BrSLhT2OkzUC5pySZWIs9gRetlJiHo+gUPItvNP8byLg==
X-Received: by 2002:a05:6871:a693:b0:1e9:9f9b:eb80 with SMTP id
 wh19-20020a056871a69300b001e99f9beb80mr4197030oab.46.1697866349293; 
 Fri, 20 Oct 2023 22:32:29 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 f20-20020a056a001ad400b006b2677d3684sm2434831pfv.206.2023.10.20.22.32.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 22:32:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 36/90] target/sparc: Move TADD, TSUB, MULS to decodetree
Date: Fri, 20 Oct 2023 22:31:04 -0700
Message-Id: <20231021053158.278135-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231021053158.278135-1-richard.henderson@linaro.org>
References: <20231021053158.278135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x36.google.com
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
 target/sparc/insns.decode |  7 ++++++
 target/sparc/helper.c     |  4 ----
 target/sparc/translate.c  | 48 ++++++++++++++++++---------------------
 3 files changed, 29 insertions(+), 30 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 74bf3760e9..39099ae14b 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -32,6 +32,7 @@ CALL    01 i:s30
 &r_r_ri_cc  rd rs1 rs2_or_imm imm:bool cc:bool
 @r_r_ri_cc  .. rd:5  . cc:1 .... rs1:5 imm:1 rs2_or_imm:s13    &r_r_ri_cc
 @r_r_ri_cc0 .. rd:5  ...... rs1:5 imm:1 rs2_or_imm:s13         &r_r_ri_cc cc=0
+@r_r_ri_cc1 .. rd:5  ...... rs1:5 imm:1 rs2_or_imm:s13         &r_r_ri_cc cc=1
 
 {
   [
@@ -170,12 +171,18 @@ SUBC        10 ..... 0.1100 ..... . .............          @r_r_ri_cc
 MULX        10 ..... 001001 ..... . .............          @r_r_ri_cc0
 UMUL        10 ..... 0.1010 ..... . .............          @r_r_ri_cc
 SMUL        10 ..... 0.1011 ..... . .............          @r_r_ri_cc
+MULScc      10 ..... 100100 ..... . .............          @r_r_ri_cc1
 
 UDIVX       10 ..... 001101 ..... . .............          @r_r_ri_cc0
 SDIVX       10 ..... 101101 ..... . .............          @r_r_ri_cc0
 UDIV        10 ..... 0.1110 ..... . .............          @r_r_ri_cc
 SDIV        10 ..... 0.1111 ..... . .............          @r_r_ri_cc
 
+TADDcc      10 ..... 100000 ..... . .............          @r_r_ri_cc1
+TSUBcc      10 ..... 100001 ..... . .............          @r_r_ri_cc1
+TADDccTV    10 ..... 100010 ..... . .............          @r_r_ri_cc1
+TSUBccTV    10 ..... 100011 ..... . .............          @r_r_ri_cc1
+
 Tcc_r       10 0 cond:4 111010 rs1:5 0 cc:1 0000000 rs2:5
 {
   # For v7, the entire simm13 field is present, but masked to 7 bits.
diff --git a/target/sparc/helper.c b/target/sparc/helper.c
index e25fdaeedd..2bcdc81d54 100644
--- a/target/sparc/helper.c
+++ b/target/sparc/helper.c
@@ -198,10 +198,8 @@ target_ulong helper_taddcctv(CPUSPARCState *env, target_ulong src1,
     }
 
     /* Only modify the CC after any exceptions have been generated.  */
-    env->cc_op = CC_OP_TADDTV;
     env->cc_src = src1;
     env->cc_src2 = src2;
-    env->cc_dst = dst;
     return dst;
 
  tag_overflow:
@@ -226,10 +224,8 @@ target_ulong helper_tsubcctv(CPUSPARCState *env, target_ulong src1,
     }
 
     /* Only modify the CC after any exceptions have been generated.  */
-    env->cc_op = CC_OP_TSUBTV;
     env->cc_src = src1;
     env->cc_src2 = src2;
-    env->cc_dst = dst;
     return dst;
 
  tag_overflow:
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index e8d904d565..cb86afb825 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -717,6 +717,16 @@ static void gen_op_sdivcc(TCGv dst, TCGv src1, TCGv src2)
     gen_helper_sdiv_cc(dst, tcg_env, src1, src2);
 }
 
+static void gen_op_taddcctv(TCGv dst, TCGv src1, TCGv src2)
+{
+    gen_helper_taddcctv(dst, tcg_env, src1, src2);
+}
+
+static void gen_op_tsubcctv(TCGv dst, TCGv src1, TCGv src2)
+{
+    gen_helper_tsubcctv(dst, tcg_env, src1, src2);
+}
+
 // 1
 static void gen_op_eval_ba(TCGv dst)
 {
@@ -4232,6 +4242,11 @@ TRANS(UDIV, DIV, do_arith, a, CC_OP_DIV,
 TRANS(SDIV, DIV, do_arith, a, CC_OP_DIV,
       a->cc ? gen_op_sdivcc : gen_op_sdiv, NULL)
 
+TRANS(TADDcc, ALL, do_arith, a, CC_OP_TADD, gen_op_add_cc, NULL)
+TRANS(TSUBcc, ALL, do_arith, a, CC_OP_TSUB, gen_op_sub_cc, NULL)
+TRANS(TADDccTV, ALL, do_arith, a, CC_OP_TADDTV, gen_op_taddcctv, NULL)
+TRANS(TSUBccTV, ALL, do_arith, a, CC_OP_TSUBTV, gen_op_tsubcctv, NULL)
+
 static bool trans_OR(DisasContext *dc, arg_r_r_ri_cc *a)
 {
     /* OR with %g0 is the canonical alias for MOV. */
@@ -4329,6 +4344,12 @@ static bool trans_SUBC(DisasContext *dc, arg_r_r_ri_cc *a)
     return do_arith(dc, a, CC_OP_SUBX, func, NULL);
 }
 
+static bool trans_MULScc(DisasContext *dc, arg_r_r_ri_cc *a)
+{
+    update_psr(dc);
+    return do_arith(dc, a, CC_OP_ADD, gen_op_mulscc, NULL);
+}
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -4756,36 +4777,11 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     cpu_src2 = get_src2(dc, insn);
                     switch (xop) {
                     case 0x20: /* taddcc */
-                        gen_op_add_cc(cpu_dst, cpu_src1, cpu_src2);
-                        gen_store_gpr(dc, rd, cpu_dst);
-                        tcg_gen_movi_i32(cpu_cc_op, CC_OP_TADD);
-                        dc->cc_op = CC_OP_TADD;
-                        break;
                     case 0x21: /* tsubcc */
-                        gen_op_sub_cc(cpu_dst, cpu_src1, cpu_src2);
-                        gen_store_gpr(dc, rd, cpu_dst);
-                        tcg_gen_movi_i32(cpu_cc_op, CC_OP_TSUB);
-                        dc->cc_op = CC_OP_TSUB;
-                        break;
                     case 0x22: /* taddcctv */
-                        gen_helper_taddcctv(cpu_dst, tcg_env,
-                                            cpu_src1, cpu_src2);
-                        gen_store_gpr(dc, rd, cpu_dst);
-                        dc->cc_op = CC_OP_TADDTV;
-                        break;
                     case 0x23: /* tsubcctv */
-                        gen_helper_tsubcctv(cpu_dst, tcg_env,
-                                            cpu_src1, cpu_src2);
-                        gen_store_gpr(dc, rd, cpu_dst);
-                        dc->cc_op = CC_OP_TSUBTV;
-                        break;
                     case 0x24: /* mulscc */
-                        update_psr(dc);
-                        gen_op_mulscc(cpu_dst, cpu_src1, cpu_src2);
-                        gen_store_gpr(dc, rd, cpu_dst);
-                        tcg_gen_movi_i32(cpu_cc_op, CC_OP_ADD);
-                        dc->cc_op = CC_OP_ADD;
-                        break;
+                        goto illegal_insn;  /* in decodetree */
 #ifndef TARGET_SPARC64
                     case 0x25:  /* sll */
                         if (IS_IMM) { /* immediate */
-- 
2.34.1


