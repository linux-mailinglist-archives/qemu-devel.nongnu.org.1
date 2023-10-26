Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCD37D7945
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:22:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo6b-0001tS-EG; Wed, 25 Oct 2023 20:20:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo6J-0001Md-MH
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:19:52 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo6B-0006pp-Gf
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:19:51 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1c77449a6daso2355165ad.0
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279582; x=1698884382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZPfCIyMItq9qsbpSlNc7YkH4PMGNqYlgO15lo4Wg0C0=;
 b=qRegKXVKkFNK5adzFtZN6p38OnfNwHLv4jHcF2oJf1EGSzyHOiiqbf08LEhGk3UZat
 4b6RGPycHJ3QHXHZZJaXivhIps2IeLl08nS7MRVBwEmYBygEp2lAVSmyiIJrtb2qygYk
 aB9JxmhrKX5EPjj47jrTepHHr8cR92x4wep0YcBzkz0YJjZHa4N0Pwk2/Lgh6emZi+VH
 ezl3D++IPI5ixgtQsuubTqSWAb8ldkogdYEhE7ch5Zmyw56bkD0S93uIhiTWIWrxWHQl
 TVL+tc6iWisgOt5TPsTS41tp4Lorjmcn8R2Vqf/7MTI/8aQyL0roKoay+MIwpPXA6Fwy
 IuRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279582; x=1698884382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZPfCIyMItq9qsbpSlNc7YkH4PMGNqYlgO15lo4Wg0C0=;
 b=ktvvdUj1NZjnCLLaAEmX7p97fSLblfBYMdXg3PkiMZyLvI/B9GQD1VXnX2g+oh3u8X
 kd2SAd+dVTkxtVGmbV+6PVyPkaTZoYJv7KQwK2HMFK3AyKh1/lNxgMf445IoHv/YgoM4
 8XKFvmmsxm8a+K2FR3rExH2DHcJtEcdt3nQYlER6UD6qQp6zGNz2BlWS2P2AJ5xi8OvK
 COxnFIcGGzXvKuCzocHUgbDEQPSWrhl5CCQYgJ7+tvPJkl3Lrxx3Zd71xPzzeLCLBZ53
 uNi/hy5BXqQjTO8rsGc7ptPf3sPrdLMR5YjhgUxftnaN42Q2b4RjwxSl8BvckRboAo6d
 fZTQ==
X-Gm-Message-State: AOJu0Yzb/MSnPy/ixgYjY+A3DHVczD/vKXUyw40Mw/pO5yJPz7T8z1GJ
 JiHXZlkIFN/gC08/+h2beGy66AME+dKCwDPUHAU=
X-Google-Smtp-Source: AGHT+IGnN8lllUNEoyheXuUMDpjUhp6cCQUFt8aJ5miOzoXLYIOl/nZtpxp2noAgLm4lIyBKorSX1A==
X-Received: by 2002:a17:903:1112:b0:1c6:117b:7086 with SMTP id
 n18-20020a170903111200b001c6117b7086mr18392260plh.5.1698279582250; 
 Wed, 25 Oct 2023 17:19:42 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jh1-20020a170903328100b001c5fc291ef9sm9754655plb.209.2023.10.25.17.19.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:19:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 41/94] target/sparc: Move SLL, SRL, SRA to decodetree
Date: Wed, 25 Oct 2023 17:14:49 -0700
Message-Id: <20231026001542.1141412-71-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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
 target/sparc/insns.decode |  14 +++
 target/sparc/translate.c  | 182 ++++++++++++++++----------------------
 2 files changed, 92 insertions(+), 104 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index b35921aabb..51cddc826d 100644
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
index 861c6e8f1e..ac8cd40aa1 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4247,6 +4247,83 @@ static bool trans_MULScc(DisasContext *dc, arg_r_r_ri_cc *a)
     return do_arith(dc, a, CC_OP_ADD, NULL, NULL, gen_op_mulscc);
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
@@ -4595,77 +4672,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -4678,42 +4684,10 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


