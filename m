Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 906477CBB2D
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:28:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdKQ-0000ji-Ov; Tue, 17 Oct 2023 02:13:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdKM-0000eX-2V
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:13:14 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdKJ-0003w6-St
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:13:13 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1c9b1e3a809so33953895ad.2
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523190; x=1698127990; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h56o6ZbhIH4yDT9EeLuzopOeYzQ+sNlxchAEBI79PHs=;
 b=KnRuTqw3BUH/p/BF8X4F6EdJ1oUQ3vno1yBLVQn97TabVIO9GXSVsQ9bkldg7TkNV3
 Zg5QU5wn5MYL92BPKHT2Mee/eAZzNheY6o+EXgyVkXu++YknPOQOUUCPpxpI0VYWPJqu
 LQg/U1xhLVtkLdXSa9etp28vltdbffoUWpueOLVQotcx8x46oBl48CNuLp1/M8mAPPHZ
 k1AaNd2WRpNw0zf1DB/XVItlcQILghNuE0m8BkjNjMUUrEifUo23Pn+KbDOT+yCblLnT
 p+vLVk66cfPUvtNZwJFzZa3JI+SMJybjmwnxqbcG2Z5qrwhSVrf29vEUzM0lQmh6ua0O
 ITEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523190; x=1698127990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h56o6ZbhIH4yDT9EeLuzopOeYzQ+sNlxchAEBI79PHs=;
 b=MoMKsw/32TcEHV7X/gqdIKNRyngEbpBH/Kl5qz6VgT0HZJq2pwS83UXsi00q9iGMS9
 Cz/prW+kc8vJpgQCvnkgX0zbGjgjFco1EJtzjAAoSMrFwBbk9lWkdy+bBJRs7glZKXW1
 5i3mdED7z4RyH1clcOvfoHnpC0ZGhE3Fdns+R/qrEOtzSIy7Rgll0RDocOQbxkW7/DBk
 XjHGxUttXvejHEk8NJgSi+KDy8jv72i+iFPAahdrV6Hn89G78SsGGW5u8PbM64NBrdN9
 6z6YjA2PkZUXesREXMzBtBV1zrzsGLrMwomowENJezzwxenQWD+OksCW0KN/J2mmQ64Q
 4rlA==
X-Gm-Message-State: AOJu0YyIZ3IFAsNAumQRGUmTs2VJqF1yoEe4wgwHMyLo18S0kgbWwacc
 RZDIX+H1R8McaAebU4kKWbfjSQ0VTgdLp2lz2EA=
X-Google-Smtp-Source: AGHT+IHUEQS1e6UkKPaNkCYHTYWUXVhseKUEBMMTW6E70/KC1QAiCtB52SrdYxcYLrq9LJn4gbpqCg==
X-Received: by 2002:a17:902:c40e:b0:1b8:b382:f6c3 with SMTP id
 k14-20020a170902c40e00b001b8b382f6c3mr1733190plk.13.1697523190408; 
 Mon, 16 Oct 2023 23:13:10 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jf4-20020a170903268400b001ca21e05c69sm629150plb.109.2023.10.16.23.13.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:13:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 29/90] target/sparc: Move basic arithmetic to decodetree
Date: Mon, 16 Oct 2023 23:11:43 -0700
Message-Id: <20231017061244.681584-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
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

Move ADD, AND, OR, XOR, SUB, ANDN, ORN, XORN.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  20 ++++-
 target/sparc/translate.c  | 183 +++++++++++++++++---------------------
 2 files changed, 99 insertions(+), 104 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 49270705c7..4005ce3df7 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -28,6 +28,7 @@ CALL    01 i:s30
 
 &r_r_ri     rd rs1 rs2_or_imm imm:bool
 @n_r_ri     .. ..... ...... rs1:5 imm:1 rs2_or_imm:s13     &r_r_ri rd=0
+@r_r_ri     .. rd:5  ...... rs1:5 imm:1 rs2_or_imm:s13     &r_r_ri
 
 {
   [
@@ -152,4 +153,21 @@ WRHPR_hintp         10 00011 110011 ..... . .............  @n_r_ri
 WRHPR_htba          10 00101 110011 ..... . .............  @n_r_ri
 WRHPR_hstick_cmpr   10 11111 110011 ..... . .............  @n_r_ri
 
-Tcc     10 0 cond:4 111010 rs1:5 imm:1 cc:1 00000 rs2_or_imm:7
+ADD         10 ..... 000000 ..... . .............          @r_r_ri
+ADDcc       10 ..... 010000 ..... . .............          @r_r_ri
+AND         10 ..... 000001 ..... . .............          @r_r_ri
+ANDcc       10 ..... 010001 ..... . .............          @r_r_ri
+OR          10 ..... 000010 ..... . .............          @r_r_ri
+ORcc        10 ..... 010010 ..... . .............          @r_r_ri
+XOR         10 ..... 000011 ..... . .............          @r_r_ri
+XORcc       10 ..... 010011 ..... . .............          @r_r_ri
+SUB         10 ..... 000100 ..... . .............          @r_r_ri
+SUBcc       10 ..... 010100 ..... . .............          @r_r_ri
+ANDN        10 ..... 000101 ..... . .............          @r_r_ri
+ANDNcc      10 ..... 010101 ..... . .............          @r_r_ri
+ORN         10 ..... 000110 ..... . .............          @r_r_ri
+ORNcc       10 ..... 010110 ..... . .............          @r_r_ri
+XORN        10 ..... 000111 ..... . .............          @r_r_ri
+XORNcc      10 ..... 010111 ..... . .............          @r_r_ri
+
+Tcc         10 0 cond:4 111010 rs1:5 imm:1 cc:1 00000 rs2_or_imm:7
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 428fbb49bd..368bafc99a 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4113,6 +4113,86 @@ static bool trans_NOP_v7(DisasContext *dc, arg_NOP_v7 *a)
     return false;
 }
 
+static bool do_cc_arith(DisasContext *dc, arg_r_r_ri *a, int cc_op,
+                        void (*func)(TCGv, TCGv, TCGv),
+                        void (*funci)(TCGv, TCGv, target_long))
+{
+    TCGv dst, src1;
+
+    /* For simplicity, we under-decoded the rs2 form. */
+    if (!a->imm && a->rs2_or_imm & ~0x1f) {
+        return false;
+    }
+
+    if (cc_op < 0) {
+        dst = gen_dest_gpr(dc, a->rd);
+    } else {
+        dst = cpu_cc_dst;
+        tcg_gen_movi_i32(cpu_cc_op, cc_op);
+        dc->cc_op = cc_op;
+    }
+    src1 = gen_load_gpr(dc, a->rs1);
+
+    if (a->imm || a->rs2_or_imm == 0) {
+        if (funci) {
+            funci(dst, src1, a->rs2_or_imm);
+        } else {
+            func(dst, src1, tcg_constant_tl(a->rs2_or_imm));
+        }
+    } else {
+        func(dst, src1, cpu_regs[a->rs2_or_imm]);
+    }
+    gen_store_gpr(dc, a->rd, dst);
+    return advance_pc(dc);
+}
+
+static bool do_arith(DisasContext *dc, arg_r_r_ri *a,
+                     void (*func)(TCGv, TCGv, TCGv),
+                     void (*funci)(TCGv, TCGv, target_long))
+{
+    return do_cc_arith(dc, a, -1, func, funci);
+}
+
+static bool trans_OR(DisasContext *dc, arg_r_r_ri *a)
+{
+    /* For simplicity, we under-decoded the rs2 form. */
+    if (!a->imm && a->rs2_or_imm & ~0x1f) {
+        return false;
+    }
+
+    /* OR with %g0 is the canonical alias for MOV. */
+    if (a->rs1 == 0) {
+        TCGv src2;
+
+        if (a->imm || a->rs2_or_imm == 0) {
+            src2 = tcg_constant_tl(a->rs2_or_imm);
+        } else {
+            src2 = cpu_regs[a->rs2_or_imm];
+        }
+        gen_store_gpr(dc, a->rd, src2);
+        return advance_pc(dc);
+    }
+
+    return do_arith(dc, a, tcg_gen_or_tl, tcg_gen_ori_tl);
+}
+
+TRANS(ADD, ALL, do_arith, a, tcg_gen_add_tl, tcg_gen_addi_tl)
+TRANS(AND, ALL, do_arith, a, tcg_gen_and_tl, tcg_gen_andi_tl)
+TRANS(XOR, ALL, do_arith, a, tcg_gen_xor_tl, tcg_gen_xori_tl)
+TRANS(SUB, ALL, do_arith, a, tcg_gen_sub_tl, tcg_gen_subi_tl)
+TRANS(ANDN, ALL, do_arith, a, tcg_gen_andc_tl, NULL)
+TRANS(ORN, ALL, do_arith, a, tcg_gen_orc_tl, NULL)
+TRANS(XORN, ALL, do_arith, a, tcg_gen_eqv_tl, NULL)
+
+TRANS(ADDcc, ALL, do_cc_arith, a, CC_OP_ADD, gen_op_add_cc, NULL)
+TRANS(ANDcc, ALL, do_cc_arith, a, CC_OP_LOGIC, tcg_gen_and_tl, tcg_gen_andi_tl)
+TRANS(ORcc, ALL, do_cc_arith, a, CC_OP_LOGIC, tcg_gen_or_tl, tcg_gen_ori_tl)
+TRANS(XORcc, ALL, do_cc_arith, a, CC_OP_LOGIC, tcg_gen_xor_tl, tcg_gen_xori_tl)
+TRANS(SUBcc, ALL, do_cc_arith, a, CC_OP_SUB, gen_op_sub_cc, NULL)
+TRANS(ANDNcc, ALL, do_cc_arith, a, CC_OP_LOGIC, tcg_gen_andc_tl, NULL)
+TRANS(ORNcc, ALL, do_cc_arith, a, CC_OP_LOGIC, tcg_gen_orc_tl, NULL)
+TRANS(XORNcc, ALL, do_cc_arith, a, CC_OP_LOGIC, tcg_gen_eqv_tl, NULL)
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -4461,43 +4541,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     default:
                         goto illegal_insn;
                 }
-            } else if (xop == 0x2) {
-                TCGv dst = gen_dest_gpr(dc, rd);
-                rs1 = GET_FIELD(insn, 13, 17);
-                if (rs1 == 0) {
-                    /* clr/mov shortcut : or %g0, x, y -> mov x, y */
-                    if (IS_IMM) {       /* immediate */
-                        simm = GET_FIELDs(insn, 19, 31);
-                        tcg_gen_movi_tl(dst, simm);
-                        gen_store_gpr(dc, rd, dst);
-                    } else {            /* register */
-                        rs2 = GET_FIELD(insn, 27, 31);
-                        if (rs2 == 0) {
-                            tcg_gen_movi_tl(dst, 0);
-                            gen_store_gpr(dc, rd, dst);
-                        } else {
-                            cpu_src2 = gen_load_gpr(dc, rs2);
-                            gen_store_gpr(dc, rd, cpu_src2);
-                        }
-                    }
-                } else {
-                    cpu_src1 = get_src1(dc, insn);
-                    if (IS_IMM) {       /* immediate */
-                        simm = GET_FIELDs(insn, 19, 31);
-                        tcg_gen_ori_tl(dst, cpu_src1, simm);
-                        gen_store_gpr(dc, rd, dst);
-                    } else {            /* register */
-                        rs2 = GET_FIELD(insn, 27, 31);
-                        if (rs2 == 0) {
-                            /* mov shortcut:  or x, %g0, y -> mov x, y */
-                            gen_store_gpr(dc, rd, cpu_src1);
-                        } else {
-                            cpu_src2 = gen_load_gpr(dc, rs2);
-                            tcg_gen_or_tl(dst, cpu_src1, cpu_src2);
-                            gen_store_gpr(dc, rd, dst);
-                        }
-                    }
-                }
 #ifdef TARGET_SPARC64
             } else if (xop == 0x25) { /* sll, V9 sllx */
                 cpu_src1 = get_src1(dc, insn);
@@ -4574,72 +4617,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     cpu_src1 = get_src1(dc, insn);
                     cpu_src2 = get_src2(dc, insn);
                     switch (xop & ~0x10) {
-                    case 0x0: /* add */
-                        if (xop & 0x10) {
-                            gen_op_add_cc(cpu_dst, cpu_src1, cpu_src2);
-                            tcg_gen_movi_i32(cpu_cc_op, CC_OP_ADD);
-                            dc->cc_op = CC_OP_ADD;
-                        } else {
-                            tcg_gen_add_tl(cpu_dst, cpu_src1, cpu_src2);
-                        }
-                        break;
-                    case 0x1: /* and */
-                        tcg_gen_and_tl(cpu_dst, cpu_src1, cpu_src2);
-                        if (xop & 0x10) {
-                            tcg_gen_mov_tl(cpu_cc_dst, cpu_dst);
-                            tcg_gen_movi_i32(cpu_cc_op, CC_OP_LOGIC);
-                            dc->cc_op = CC_OP_LOGIC;
-                        }
-                        break;
-                    case 0x2: /* or */
-                        tcg_gen_or_tl(cpu_dst, cpu_src1, cpu_src2);
-                        if (xop & 0x10) {
-                            tcg_gen_mov_tl(cpu_cc_dst, cpu_dst);
-                            tcg_gen_movi_i32(cpu_cc_op, CC_OP_LOGIC);
-                            dc->cc_op = CC_OP_LOGIC;
-                        }
-                        break;
-                    case 0x3: /* xor */
-                        tcg_gen_xor_tl(cpu_dst, cpu_src1, cpu_src2);
-                        if (xop & 0x10) {
-                            tcg_gen_mov_tl(cpu_cc_dst, cpu_dst);
-                            tcg_gen_movi_i32(cpu_cc_op, CC_OP_LOGIC);
-                            dc->cc_op = CC_OP_LOGIC;
-                        }
-                        break;
-                    case 0x4: /* sub */
-                        if (xop & 0x10) {
-                            gen_op_sub_cc(cpu_dst, cpu_src1, cpu_src2);
-                            tcg_gen_movi_i32(cpu_cc_op, CC_OP_SUB);
-                            dc->cc_op = CC_OP_SUB;
-                        } else {
-                            tcg_gen_sub_tl(cpu_dst, cpu_src1, cpu_src2);
-                        }
-                        break;
-                    case 0x5: /* andn */
-                        tcg_gen_andc_tl(cpu_dst, cpu_src1, cpu_src2);
-                        if (xop & 0x10) {
-                            tcg_gen_mov_tl(cpu_cc_dst, cpu_dst);
-                            tcg_gen_movi_i32(cpu_cc_op, CC_OP_LOGIC);
-                            dc->cc_op = CC_OP_LOGIC;
-                        }
-                        break;
-                    case 0x6: /* orn */
-                        tcg_gen_orc_tl(cpu_dst, cpu_src1, cpu_src2);
-                        if (xop & 0x10) {
-                            tcg_gen_mov_tl(cpu_cc_dst, cpu_dst);
-                            tcg_gen_movi_i32(cpu_cc_op, CC_OP_LOGIC);
-                            dc->cc_op = CC_OP_LOGIC;
-                        }
-                        break;
-                    case 0x7: /* xorn */
-                        tcg_gen_eqv_tl(cpu_dst, cpu_src1, cpu_src2);
-                        if (xop & 0x10) {
-                            tcg_gen_mov_tl(cpu_cc_dst, cpu_dst);
-                            tcg_gen_movi_i32(cpu_cc_op, CC_OP_LOGIC);
-                            dc->cc_op = CC_OP_LOGIC;
-                        }
-                        break;
                     case 0x8: /* addx, V9 addc */
                         gen_op_addx_int(dc, cpu_dst, cpu_src1, cpu_src2,
                                         (xop & 0x10));
-- 
2.34.1


