Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C317E7D2148
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 08:05:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quRWU-0000jR-1N; Sun, 22 Oct 2023 02:01:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRWG-0000b5-At
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:01:00 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRWE-0001bu-D7
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:01:00 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6b6f4c118b7so1761082b3a.0
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 23:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697954457; x=1698559257; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nU6gypuub1y/zjRqrVVCB9wTdncPmAOVb9ayhPvvYrM=;
 b=u8y3RSv6W7qG93WW9Xi1D2vJ/I7C9GnSPrSezQl9tq1PALEPoLzI4bm03QBlJzXYWx
 txkiFXJO/TUFuUQAVlGH6sVkYbo+WgH3V1AUBfu6ZotdQ3kBHBmDbqNyoKivYL512PqF
 mL2bYkfyU7BoZWN0fJWgxUr7VVS15sLVzH21TFf/Ph0orHJ91iiIvBKV6p6SHYxS+ltS
 7WBOXIyRUcy151+Oy7FFd+hDyCkRuM9bmHbpqm8m6hKYe8BDjmGd/g/PrCND2J3LKU2c
 bxJBdjUOsaluKyjgdgmWVWpC7JHgmaUfgDDO24ZRbGB4jcGwG59aHpB09Msi4OONInGY
 3b8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697954457; x=1698559257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nU6gypuub1y/zjRqrVVCB9wTdncPmAOVb9ayhPvvYrM=;
 b=ZCSSz8zE3W+N2dqPEeeJA47PnDF7kOxze62mKLz9fe7NvFInphWfTRv5NJ23W+NJnh
 WVwev/D8ZLY8pSzF9BYuJhWW/rCe9uKIlWWTaAXhsE/lqNoFLvD/kw4tMGiU6g5xtOLE
 UaxIDyVKkONy2LgyTmEb4rrAQDiHL5G5xJY47zl3Q3+i0WSDRJjw344EwEoJK/CEMOMd
 4g/qwfJnAcNzCtynp9wKIQk26EqdOeCH4EbGjkIhcgfQrZRniLIm/tH6cc9xeZ3YdhvJ
 0Z1LcyyQT1+YiCoSeveewliDNIupxhA2Pnm+yDaslqUCOMNz4r5J8a5Yphs+ZJto+tj9
 4Y3w==
X-Gm-Message-State: AOJu0YyJHYAVm37T/TIKiU6FrOiAGc55sKxCVWST//p7M6tlWbeJtopt
 lsmzo8G+50iponpIdphUkuQTej2Cq/mIWRPpjXc=
X-Google-Smtp-Source: AGHT+IH4YPzMHdvHUmyNubSeDQWRS628oPKjXxkEmMV/tw2vU+HoH8KKF4nz3gbeWA7RSU5krn7cgA==
X-Received: by 2002:a05:6a21:7807:b0:159:e0b9:bd02 with SMTP id
 be7-20020a056a21780700b00159e0b9bd02mr4400407pzc.40.1697954457031; 
 Sat, 21 Oct 2023 23:00:57 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 je17-20020a170903265100b001c728609574sm3999887plb.6.2023.10.21.23.00.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 23:00:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 29/90] target/sparc: Move basic arithmetic to decodetree
Date: Sat, 21 Oct 2023 22:59:30 -0700
Message-Id: <20231022060031.490251-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022060031.490251-1-richard.henderson@linaro.org>
References: <20231022060031.490251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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
 target/sparc/insns.decode |  12 +++
 target/sparc/translate.c  | 178 ++++++++++++++++----------------------
 2 files changed, 87 insertions(+), 103 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index eab737fdcc..3271c2997d 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -29,6 +29,9 @@ CALL    01 i:s30
 &r_r_ri     rd rs1 rs2_or_imm imm:bool
 @n_r_ri     .. ..... ...... rs1:5 imm:1 rs2_or_imm:s13     &r_r_ri rd=0
 
+&r_r_ri_cc  rd rs1 rs2_or_imm imm:bool cc:bool
+@r_r_ri_cc  .. rd:5  . cc:1 .... rs1:5 imm:1 rs2_or_imm:s13    &r_r_ri_cc
+
 {
   [
     STBAR           10 00000 101000 01111 0 0000000000000
@@ -152,6 +155,15 @@ WRHPR_hintp         10 00011 110011 ..... . .............  @n_r_ri
 WRHPR_htba          10 00101 110011 ..... . .............  @n_r_ri
 WRHPR_hstick_cmpr   10 11111 110011 ..... . .............  @n_r_ri
 
+ADD         10 ..... 0.0000 ..... . .............          @r_r_ri_cc
+AND         10 ..... 0.0001 ..... . .............          @r_r_ri_cc
+OR          10 ..... 0.0010 ..... . .............          @r_r_ri_cc
+XOR         10 ..... 0.0011 ..... . .............          @r_r_ri_cc
+SUB         10 ..... 0.0100 ..... . .............          @r_r_ri_cc
+ANDN        10 ..... 0.0101 ..... . .............          @r_r_ri_cc
+ORN         10 ..... 0.0110 ..... . .............          @r_r_ri_cc
+XORN        10 ..... 0.0111 ..... . .............          @r_r_ri_cc
+
 Tcc_r       10 0 cond:4 111010 rs1:5 0 cc:1 0000000 rs2:5
 {
   # For v7, the entire simm13 field is present, but masked to 7 bits.
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index ea991bf1f8..4bb545e9c5 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4151,6 +4151,81 @@ static bool trans_NOP_v7(DisasContext *dc, arg_NOP_v7 *a)
     return false;
 }
 
+static bool do_arith(DisasContext *dc, arg_r_r_ri_cc *a, int cc_op,
+                     void (*func)(TCGv, TCGv, TCGv),
+                     void (*funci)(TCGv, TCGv, target_long))
+{
+    TCGv dst, src1;
+
+    /* For simplicity, we under-decoded the rs2 form. */
+    if (!a->imm && a->rs2_or_imm & ~0x1f) {
+        return false;
+    }
+
+    if (a->cc) {
+        dst = cpu_cc_dst;
+    } else {
+        dst = gen_dest_gpr(dc, a->rd);
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
+
+    if (a->cc) {
+        tcg_gen_movi_i32(cpu_cc_op, cc_op);
+        dc->cc_op = cc_op;
+    }
+    return advance_pc(dc);
+}
+
+TRANS(AND, ALL, do_arith, a, CC_OP_LOGIC, tcg_gen_and_tl, tcg_gen_andi_tl)
+TRANS(XOR, ALL, do_arith, a, CC_OP_LOGIC, tcg_gen_xor_tl, tcg_gen_xori_tl)
+TRANS(ANDN, ALL, do_arith, a, CC_OP_LOGIC, tcg_gen_andc_tl, NULL)
+TRANS(ORN, ALL, do_arith, a, CC_OP_LOGIC, tcg_gen_orc_tl, NULL)
+TRANS(XORN, ALL, do_arith, a, CC_OP_LOGIC, tcg_gen_eqv_tl, NULL)
+
+static bool trans_OR(DisasContext *dc, arg_r_r_ri_cc *a)
+{
+    /* OR with %g0 is the canonical alias for MOV. */
+    if (!a->cc && a->rs1 == 0) {
+        if (a->imm || a->rs2_or_imm == 0) {
+            gen_store_gpr(dc, a->rd, tcg_constant_tl(a->rs2_or_imm));
+        } else if (a->rs2_or_imm & ~0x1f) {
+            /* For simplicity, we under-decoded the rs2 form. */
+            return false;
+        } else {
+            gen_store_gpr(dc, a->rd, cpu_regs[a->rs2_or_imm]);
+        }
+        return advance_pc(dc);
+    }
+    return do_arith(dc, a, CC_OP_LOGIC, tcg_gen_or_tl, tcg_gen_ori_tl);
+}
+
+static bool trans_ADD(DisasContext *dc, arg_r_r_ri_cc *a)
+{
+    if (a->cc) {
+        return do_arith(dc, a, CC_OP_ADD, gen_op_add_cc, NULL);
+    }
+    return do_arith(dc, a, -1, tcg_gen_add_tl, tcg_gen_addi_tl);
+}
+
+static bool trans_SUB(DisasContext *dc, arg_r_r_ri_cc *a)
+{
+    if (a->cc) {
+        return do_arith(dc, a, CC_OP_SUB, gen_op_sub_cc, NULL);
+    }
+    return do_arith(dc, a, -1, tcg_gen_sub_tl, tcg_gen_subi_tl);
+}
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -4499,43 +4574,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -4612,72 +4650,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


