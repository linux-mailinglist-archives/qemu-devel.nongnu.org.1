Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2728F7C8F16
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:31:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPik-0006Mi-AV; Fri, 13 Oct 2023 17:29:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPif-0006Ks-8E
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:29:17 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPib-0000US-4q
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:29:16 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5859a7d6556so1884793a12.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232551; x=1697837351; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vHpyM/i6DfbRJ1zqPOIHNLjOC5TfX2noQLAfAlf4cOM=;
 b=d0uvXa4WS7B7Wgd1PCzqCFCj9v5pX1ZbdSlbN7YXEUCx09ch7bj/yTDutbyCaVsnh9
 tNLd1uv4cOx3plCI45/wrsHGqdcA+L/63g4+jnRHVPCEKrBFxOB7oq0ZMsSQO1HkHaz8
 5opJ9DBGsyv8ecWyjQaZfqj33kI1Ds639RdyDL4SwpPg1NKeYdvAfbfgiEHY+Nush7St
 wEVFd76xnSGb4vuiI87uR4HcRWxicVJpfuOGZvPcmfVbdIOf+wpXOEKVkIC4Ug0HcJI2
 nZDUlM6BbNNe0lPgNQQ4s1t3anxVj07S9SToj2wITFTQAsEECUQc6zw8nk/n48qAjUQr
 pRng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232551; x=1697837351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vHpyM/i6DfbRJ1zqPOIHNLjOC5TfX2noQLAfAlf4cOM=;
 b=KghKN+bzuP7cZZrJQKivQen3Rfg6AEC0gh1xLlJ41N56y7ZCXWYk1LUSSHpFsoQY4v
 dmXfXjUHBUk0Drfvx0ILrDX3zYHeHdntnvrsKB+7X39jn0LghEafRvskuJQ0h9OJVU1V
 DhcfmVDw4axgvQNcTbqFBxeOxOn2b7T/w1CUN8lQ5vPcTNeNiYPtvt2gYhUMay4kmDXC
 SKKwpExQ+6mib8N1Hbq3K8R3K+NCnym92QFfmOSuz9nYtfAuT40JGz1JxXX2zvgPQnR7
 lVdk0Qwz2ypE0aQB9w5jsPj/DhA6iL2AC26ipUEba1DDeyU2VitOeddhuvKRQAHuJ5Cu
 n7GQ==
X-Gm-Message-State: AOJu0YyRY2dnVXByvO/X3WUzzTLqP9M8ldTiFQjaZWT18cxwPNElYzg3
 fsO/flIvfCfR2X5CXSe67pZXkws855OkezwqFXA=
X-Google-Smtp-Source: AGHT+IGiG2yyLLpMH8dBco6rrKOlbMhkNL4+z8XzzB/VWEBY4hYVPwnHQmqIxMNhx35JQWVS27r2lw==
X-Received: by 2002:a05:6a20:2583:b0:161:76a4:4f74 with SMTP id
 k3-20020a056a20258300b0016176a44f74mr32202666pzd.1.1697232550711; 
 Fri, 13 Oct 2023 14:29:10 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 b185-20020a6334c2000000b0058988954686sm70753pga.90.2023.10.13.14.29.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:29:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 24/85] target/sparc: Move basic arithmetic to decodetree
Date: Fri, 13 Oct 2023 14:27:45 -0700
Message-Id: <20231013212846.165724-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013212846.165724-1-richard.henderson@linaro.org>
References: <20231013212846.165724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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
 target/sparc/insns.decode |  18 ++++
 target/sparc/translate.c  | 183 +++++++++++++++++---------------------
 2 files changed, 98 insertions(+), 103 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 0425764973..a95f682fa7 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -28,6 +28,7 @@ CALL    01 i:s30
 
 &r_r_ri     rd rs1 rs2_or_imm imm:bool
 @n_r_ri     .. ..... ...... rs1:5 imm:1 rs2_or_imm:s13     &r_r_ri rd=0
+@r_r_ri     .. rd:5  ...... rs1:5 imm:1 rs2_or_imm:s13     &r_r_ri
 
 Tcc_r   10 0 cond:4 111010 rs1:5 0 cc:1 0000000 rs2:5
 Tcc_i   10 0 cond:4 111010 rs1:5 1 cc:1 0000 i:8
@@ -154,3 +155,20 @@ WRPR_strand_status  10 11010 110010 ..... . .............  @n_r_ri
 WRHPR_hintp         10 00011 110011 ..... . .............  @n_r_ri
 WRHPR_htba          10 00101 110011 ..... . .............  @n_r_ri
 WRHPR_hstick_cmpr   10 11111 110011 ..... . .............  @n_r_ri
+
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
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index efb3c7c570..a21c5ec329 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4079,6 +4079,86 @@ static bool trans_NOP_v7(DisasContext *dc, arg_NOP_v7 *a)
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
@@ -4427,43 +4507,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -4540,72 +4583,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


