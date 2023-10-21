Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 983DB7D1AF3
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 07:35:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu4bN-0007NL-Ir; Sat, 21 Oct 2023 01:32:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4bC-0007Gj-Rr
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:32:34 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4b9-0008Tt-Bv
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:32:34 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6ce2cc39d12so1049997a34.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 22:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697866350; x=1698471150; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wslfR0GqF3cOjpIHepb2ompyfjkVYc9/hjo7Upyjkh4=;
 b=h9OxAz1zTmL7x4PksMcBB+QjFYLqw9HH9fEby+XAguFm1YGF8qCXzGsmvraP+RAQGx
 fcT9Yzwgf20ulolz6C80kJiJ57AwbyQvNOk9Uo0kU8iSgPTtoCsT1nqk3k81TdsCKIZR
 /eOS7o+l89cDt297YUDq3JeIU76dW5yXLJwxMAPvQBGPLQYbJ3SFqWMC+w8TTNnONQxj
 1vPg1MlewWuBywwNGSgosgIsh1QU6F5iPUhmPiz0v7Ix9Hm1kL+TrbtfPtsu8WV/aiYE
 4z+qh6FS9DqhRqOuZfM2pMiMZFo8jIenSMIjt9bv0uQVchdydX29Boidh69E/FUhFZYw
 H+KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697866350; x=1698471150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wslfR0GqF3cOjpIHepb2ompyfjkVYc9/hjo7Upyjkh4=;
 b=qzbwsbeHVz/7sEEL4Jn9PD+TBVK7CqzSNbgMCmgUpfVB7n8bPj0ExqBcJmG/3c1mof
 PWwPEQCKd7qTrGdUXFUuhh2i6WLZmdZO9UJS5AWsx8nwY/bGH5g0d3ztGpmS6PtjOAID
 h68t4RWpdZQkcHsnDFuNojnuP/YNwwkahy4/vzaczeYZ4sMQTiWbTJ0eY+0xLpFl7uWh
 qYLPddHRI4uj/8UPxH9amHCOfBW3Gopf0CTvfBPCGNU56EzWPC3pMWh7hlCB03q1+tIG
 cLL0+t5wMjrEQI4pxPn0VFkllbBWxj3plQn3/ezMas9PNEeYkrskIkuPf7uwEgjlQZl7
 26Yw==
X-Gm-Message-State: AOJu0YzL1+zxA5rgMek74q23ObZaBrME51kQiMPDv7qoI7Aye65FMrWk
 U+IHLwNAKd+kYZTrCVY0KkdNxJqv6jg2Tqxv/mQ=
X-Google-Smtp-Source: AGHT+IGFa+9eOLYRRAW/XDJbOoXi2JoalAHH33gY+9FpLU561D65ma0NGtgBLv1lzHies52cxnJk6w==
X-Received: by 2002:a05:6830:44a1:b0:6c4:d08c:6a2 with SMTP id
 r33-20020a05683044a100b006c4d08c06a2mr5489237otv.9.1697866350186; 
 Fri, 20 Oct 2023 22:32:30 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 f20-20020a056a001ad400b006b2677d3684sm2434831pfv.206.2023.10.20.22.32.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 22:32:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 37/90] target/sparc: Move SLL, SRL, SRA to decodetree
Date: Fri, 20 Oct 2023 22:31:05 -0700
Message-Id: <20231021053158.278135-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231021053158.278135-1-richard.henderson@linaro.org>
References: <20231021053158.278135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x334.google.com
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
index 39099ae14b..c2a44e0130 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -183,6 +183,20 @@ TSUBcc      10 ..... 100001 ..... . .............          @r_r_ri_cc1
 TADDccTV    10 ..... 100010 ..... . .............          @r_r_ri_cc1
 TSUBccTV    10 ..... 100011 ..... . .............          @r_r_ri_cc1
 
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
 Tcc_r       10 0 cond:4 111010 rs1:5 0 cc:1 0000000 rs2:5
 {
   # For v7, the entire simm13 field is present, but masked to 7 bits.
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index cb86afb825..a8e40b4220 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4350,6 +4350,83 @@ static bool trans_MULScc(DisasContext *dc, arg_r_r_ri_cc *a)
     return do_arith(dc, a, CC_OP_ADD, gen_op_mulscc, NULL);
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
@@ -4698,77 +4775,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -4781,42 +4787,10 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


