Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEAF7CBAF3
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:21:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdKc-0000rE-7p; Tue, 17 Oct 2023 02:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdKT-0000mi-NQ
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:13:21 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdKQ-0003y1-B1
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:13:21 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1c87a85332bso45340555ad.2
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523196; x=1698127996; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UCOIS4gOpVGHgOirABjKO6Yw+e6lmcWihb6phG5srXA=;
 b=PVWfjuws0CSz8FmGQmOtNmQ/uPlb53I8Y2D2jJ79EYnLSlUPOHqyK4gmoZWos9bq+i
 5ErTiIo1MSbwOuM+8/ctsoWNvGwhjIzgc6YpnPXYKtnfTnzDTtS1V3cJAlzK21l95dct
 7PWtMd3bFacBkRcBno4hiidXV+g2QWDwrD6ck0y/MFyAe2YGei4OUM9g++OpQdeKcFwj
 vNZpiu78bV9dk2u9TMZ/EWKiiC5j1RuD+V9Z+qHEwoGjmozP6aWhAgPZSyVzmcRQ/qGb
 NQKhSLfry3JkwA3VBYJ2J53tQRPMt0tSn/2XRntfed9N47CAy2c96MkMHC3YWEMowZcX
 FUdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523196; x=1698127996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UCOIS4gOpVGHgOirABjKO6Yw+e6lmcWihb6phG5srXA=;
 b=wgyYxRC6AogV+L7cRCBTpWGPyppQbvr1vQKZUovHB7+4KOD+1n6xl02htNl1HOvLdT
 oDKcG7HrPudFnEWawWMqOemY39NojlOGPCsXNgsY3OWgLT5fhqDLqjoWZxvfFwXuqiMp
 SFre6ddFLWyOyiacnjoSOesITPCBGUukDHzfG+aVa+K00THLr6izVzV4TfcozmXi9ALt
 JLaMXPCpApo8BH+ehM4X2ENIseX0sicLrMcAnrSSQnsLlM3/HW06+zcIuXoFp+HGdupj
 EQkdCrwqfrb7kTfAl5bzoX+OgnqPPPX0mTsKAXVvJEUJQoIhiLjXTVEe/cDVVc79VXUO
 Ycqg==
X-Gm-Message-State: AOJu0YwYg7SnvrHTMJ9AssyYx6Z22hfmaqaMYoRJwuwxYqiCvUTVBm5y
 Hu5irmGjnZAGYHJLIgFZ0vy2NficjuwcjNVuSm0=
X-Google-Smtp-Source: AGHT+IGsEuIarHiApv+Z0EzXGIa/ZWTzTXI3AYLhHF4mCfso/cazoLnJrLPNIY/VDmf56y/UTpCCKQ==
X-Received: by 2002:a17:903:2348:b0:1ca:8e79:538f with SMTP id
 c8-20020a170903234800b001ca8e79538fmr1561753plh.25.1697523196696; 
 Mon, 16 Oct 2023 23:13:16 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jf4-20020a170903268400b001ca21e05c69sm629150plb.109.2023.10.16.23.13.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:13:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 37/90] target/sparc: Move SLL, SRL, SRA to decodetree
Date: Mon, 16 Oct 2023 23:11:51 -0700
Message-Id: <20231017061244.681584-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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
 target/sparc/insns.decode |  14 +++
 target/sparc/translate.c  | 182 ++++++++++++++++----------------------
 2 files changed, 92 insertions(+), 104 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 18e2372928..fe0eacd779 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -190,4 +190,18 @@ TADDccTV    10 ..... 100010 ..... . .............          @r_r_ri
 TSUBccTV    10 ..... 100011 ..... . .............          @r_r_ri
 MULScc      10 ..... 100100 ..... . .............          @r_r_ri
 
+&shiftr     rd rs1 rs2 x:bool
+@shiftr     .. rd:5  ...... rs1:5 . x:1 ....... rs2:5      &shiftr
+
+SLL_r       10 ..... 100101 ..... 0 .   0000000 .....      @shiftr
+SRL_r       10 ..... 100110 ..... 0 .   0000000 .....      @shiftr
+SRA_r       10 ..... 100111 ..... 0 .   0000000 .....      @shiftr
+
+&shifti     rd rs1 i x:bool
+@shifti     .. rd:5  ...... rs1:5 . x:1 ...... i:6         &shifti
+
+SLL_i       10 ..... 100101 ..... 1 .   000000 ......      @shifti
+SRL_i       10 ..... 100110 ..... 1 .   000000 ......      @shifti
+SRA_i       10 ..... 100111 ..... 1 .   000000 ......      @shifti
+
 Tcc         10 0 cond:4 111010 rs1:5 imm:1 cc:1 00000 rs2_or_imm:7
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 4adf2cc3ae..deea3015b1 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4330,6 +4330,83 @@ static bool trans_MULScc(DisasContext *dc, arg_r_r_ri *a)
     return do_cc_arith(dc, a, CC_OP_ADD, gen_op_mulscc, NULL);
 }
 
+static bool do_shift_r(DisasContext *dc, arg_shiftr *a, bool l, bool u)
+{
+    TCGv dst, src1, src2;
+
+    /* Reject 64-bit shifts for sparc32. */
+    if (avail_32(dc) && a->x) {
+        return false;
+    }
+
+    src2 = tcg_temp_new();
+    tcg_gen_andi_tl(src2, gen_load_gpr(dc, a->rs2), a->x ? 63 : 31);
+    src1 = gen_load_gpr(dc, a->rs1);
+    dst = gen_dest_gpr(dc, a->rd);
+
+    if (l) {
+        tcg_gen_shl_tl(dst, src1, src2);
+        if (!a->x) {
+            tcg_gen_ext32u_tl(dst, dst);
+        }
+    } else if (u) {
+        if (!a->x) {
+            tcg_gen_ext32u_tl(dst, src1);
+            src1 = dst;
+        }
+        tcg_gen_shr_tl(dst, src1, src2);
+    } else {
+        if (!a->x) {
+            tcg_gen_ext32s_tl(dst, src1);
+            src1 = dst;
+        }
+        tcg_gen_sar_tl(dst, src1, src2);
+    }
+    gen_store_gpr(dc, a->rd, dst);
+    return advance_pc(dc);
+}
+
+TRANS(SLL_r, ALL, do_shift_r, a, true, true)
+TRANS(SRL_r, ALL, do_shift_r, a, false, true)
+TRANS(SRA_r, ALL, do_shift_r, a, false, false)
+
+static bool do_shift_i(DisasContext *dc, arg_shifti *a, bool l, bool u)
+{
+    TCGv dst, src1;
+
+    /* Reject 64-bit shifts for sparc32. */
+    if (avail_32(dc) && (a->x || a->i >= 32)) {
+        return false;
+    }
+
+    src1 = gen_load_gpr(dc, a->rs1);
+    dst = gen_dest_gpr(dc, a->rd);
+
+    if (avail_32(dc) || a->x) {
+        if (l) {
+            tcg_gen_shli_tl(dst, src1, a->i);
+        } else if (u) {
+            tcg_gen_shri_tl(dst, src1, a->i);
+        } else {
+            tcg_gen_sari_tl(dst, src1, a->i);
+        }
+    } else {
+        if (l) {
+            tcg_gen_deposit_z_tl(dst, src1, a->i, 32 - a->i);
+        } else if (u) {
+            tcg_gen_extract_tl(dst, src1, a->i, 32 - a->i);
+        } else {
+            tcg_gen_sextract_tl(dst, src1, a->i, 32 - a->i);
+        }
+    }
+    gen_store_gpr(dc, a->rd, dst);
+    return advance_pc(dc);
+}
+
+TRANS(SLL_i, ALL, do_shift_i, a, true, true)
+TRANS(SRL_i, ALL, do_shift_i, a, false, true)
+TRANS(SRA_i, ALL, do_shift_i, a, false, false)
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -4678,77 +4755,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     default:
                         goto illegal_insn;
                 }
-#ifdef TARGET_SPARC64
-            } else if (xop == 0x25) { /* sll, V9 sllx */
-                cpu_src1 = get_src1(dc, insn);
-                if (IS_IMM) {   /* immediate */
-                    simm = GET_FIELDs(insn, 20, 31);
-                    if (insn & (1 << 12)) {
-                        tcg_gen_shli_i64(cpu_dst, cpu_src1, simm & 0x3f);
-                    } else {
-                        tcg_gen_shli_i64(cpu_dst, cpu_src1, simm & 0x1f);
-                    }
-                } else {                /* register */
-                    rs2 = GET_FIELD(insn, 27, 31);
-                    cpu_src2 = gen_load_gpr(dc, rs2);
-                    cpu_tmp0 = tcg_temp_new();
-                    if (insn & (1 << 12)) {
-                        tcg_gen_andi_i64(cpu_tmp0, cpu_src2, 0x3f);
-                    } else {
-                        tcg_gen_andi_i64(cpu_tmp0, cpu_src2, 0x1f);
-                    }
-                    tcg_gen_shl_i64(cpu_dst, cpu_src1, cpu_tmp0);
-                }
-                gen_store_gpr(dc, rd, cpu_dst);
-            } else if (xop == 0x26) { /* srl, V9 srlx */
-                cpu_src1 = get_src1(dc, insn);
-                if (IS_IMM) {   /* immediate */
-                    simm = GET_FIELDs(insn, 20, 31);
-                    if (insn & (1 << 12)) {
-                        tcg_gen_shri_i64(cpu_dst, cpu_src1, simm & 0x3f);
-                    } else {
-                        tcg_gen_andi_i64(cpu_dst, cpu_src1, 0xffffffffULL);
-                        tcg_gen_shri_i64(cpu_dst, cpu_dst, simm & 0x1f);
-                    }
-                } else {                /* register */
-                    rs2 = GET_FIELD(insn, 27, 31);
-                    cpu_src2 = gen_load_gpr(dc, rs2);
-                    cpu_tmp0 = tcg_temp_new();
-                    if (insn & (1 << 12)) {
-                        tcg_gen_andi_i64(cpu_tmp0, cpu_src2, 0x3f);
-                        tcg_gen_shr_i64(cpu_dst, cpu_src1, cpu_tmp0);
-                    } else {
-                        tcg_gen_andi_i64(cpu_tmp0, cpu_src2, 0x1f);
-                        tcg_gen_andi_i64(cpu_dst, cpu_src1, 0xffffffffULL);
-                        tcg_gen_shr_i64(cpu_dst, cpu_dst, cpu_tmp0);
-                    }
-                }
-                gen_store_gpr(dc, rd, cpu_dst);
-            } else if (xop == 0x27) { /* sra, V9 srax */
-                cpu_src1 = get_src1(dc, insn);
-                if (IS_IMM) {   /* immediate */
-                    simm = GET_FIELDs(insn, 20, 31);
-                    if (insn & (1 << 12)) {
-                        tcg_gen_sari_i64(cpu_dst, cpu_src1, simm & 0x3f);
-                    } else {
-                        tcg_gen_ext32s_i64(cpu_dst, cpu_src1);
-                        tcg_gen_sari_i64(cpu_dst, cpu_dst, simm & 0x1f);
-                    }
-                } else {                /* register */
-                    rs2 = GET_FIELD(insn, 27, 31);
-                    cpu_src2 = gen_load_gpr(dc, rs2);
-                    cpu_tmp0 = tcg_temp_new();
-                    if (insn & (1 << 12)) {
-                        tcg_gen_andi_i64(cpu_tmp0, cpu_src2, 0x3f);
-                        tcg_gen_sar_i64(cpu_dst, cpu_src1, cpu_tmp0);
-                    } else {
-                        tcg_gen_andi_i64(cpu_tmp0, cpu_src2, 0x1f);
-                        tcg_gen_ext32s_i64(cpu_dst, cpu_src1);
-                        tcg_gen_sar_i64(cpu_dst, cpu_dst, cpu_tmp0);
-                    }
-                }
-                gen_store_gpr(dc, rd, cpu_dst);
-#endif
             } else if (xop < 0x36) {
                 if (xop < 0x20) {
                     goto illegal_insn;
@@ -4761,42 +4767,10 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     case 0x22: /* taddcctv */
                     case 0x23: /* tsubcctv */
                     case 0x24: /* mulscc */
-                        goto illegal_insn;  /* in decodetree */
-#ifndef TARGET_SPARC64
                     case 0x25:  /* sll */
-                        if (IS_IMM) { /* immediate */
-                            simm = GET_FIELDs(insn, 20, 31);
-                            tcg_gen_shli_tl(cpu_dst, cpu_src1, simm & 0x1f);
-                        } else { /* register */
-                            cpu_tmp0 = tcg_temp_new();
-                            tcg_gen_andi_tl(cpu_tmp0, cpu_src2, 0x1f);
-                            tcg_gen_shl_tl(cpu_dst, cpu_src1, cpu_tmp0);
-                        }
-                        gen_store_gpr(dc, rd, cpu_dst);
-                        break;
                     case 0x26:  /* srl */
-                        if (IS_IMM) { /* immediate */
-                            simm = GET_FIELDs(insn, 20, 31);
-                            tcg_gen_shri_tl(cpu_dst, cpu_src1, simm & 0x1f);
-                        } else { /* register */
-                            cpu_tmp0 = tcg_temp_new();
-                            tcg_gen_andi_tl(cpu_tmp0, cpu_src2, 0x1f);
-                            tcg_gen_shr_tl(cpu_dst, cpu_src1, cpu_tmp0);
-                        }
-                        gen_store_gpr(dc, rd, cpu_dst);
-                        break;
                     case 0x27:  /* sra */
-                        if (IS_IMM) { /* immediate */
-                            simm = GET_FIELDs(insn, 20, 31);
-                            tcg_gen_sari_tl(cpu_dst, cpu_src1, simm & 0x1f);
-                        } else { /* register */
-                            cpu_tmp0 = tcg_temp_new();
-                            tcg_gen_andi_tl(cpu_tmp0, cpu_src2, 0x1f);
-                            tcg_gen_sar_tl(cpu_dst, cpu_src1, cpu_tmp0);
-                        }
-                        gen_store_gpr(dc, rd, cpu_dst);
-                        break;
-#endif
+                        goto illegal_insn;  /* in decodetree */
                     case 0x30:
                         goto illegal_insn;  /* WRASR in decodetree */
                     case 0x32:
-- 
2.34.1


