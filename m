Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A39197D2722
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 01:35:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quhwe-0003tq-1X; Sun, 22 Oct 2023 19:33:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhwa-0003iO-2s
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:33:16 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhwW-0007Rr-DF
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:33:15 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-517ab9a4a13so2141713a12.1
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 16:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698017589; x=1698622389; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XbX2egfOJfjzPcR+ym3My1Z+yzRZtcU1dpfWhYJGAHs=;
 b=nj8UwBsrgb/T1oBhWAsgfCAku6IOLrQlnEGS7CQ52VApe4RKwjXLjI8nlU5X5Tr0CW
 EshsWubI4P6ASXzv9r/5OAb9mt2oKJ91SfYTqRG8MbGMGijVOhNIoAu07HEAKA5p2qkZ
 xToSL5+jfIVBhdjwDe7IGE7+COOOktInomAOM4BWBO3MrimbHnQJ86TqT4cX1lAVv6P2
 F/RMMHSfqZXfnCvU5wjFttAhWOH/O49xsG+ez+UukM8EVxv1r4nhXcGFAfsvoTujDvPP
 vVzB6yUgcGHOevsbuta2B2Z9q6M97OGfXghKsm+r4JczqBULUcwU4ryzHNxxCUrrNAG6
 I7ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698017589; x=1698622389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XbX2egfOJfjzPcR+ym3My1Z+yzRZtcU1dpfWhYJGAHs=;
 b=Ajr7RJ/1UYT7BFnpwJ3h5pb9rNz7SGPIQ5UyAIXy62aqgWA7b5ZBgTvSC1V25xn8Su
 Raus17Hv1JLwwmKUNbdfSvO0di4NbDBkCTmP/9E5v8icz1RoQMZSMaKCTwOqlFRfXF0n
 ZnZ971wr+p+z7dxPyU3l5r0bQdmZI+Z6w7RS2UinUkXCmn9A5LQbP83jVpWLeAXuk/Q9
 gxDTGruOJyqVhbTqrx+qXY2S9E+8iRzLnJ68QvceIxLO1OqNX4sZK3Ga92dqAyl8uY09
 G7ACvPkOMrwj/IMRrA5aI5fXTFKqvZp1BYP03i18LxneFwEZjE5M2zb+Tn5Sd/5Axb9R
 I9CA==
X-Gm-Message-State: AOJu0YzWd2M2LkDgipSQgs9HPDDCSBIO/sMBa31UB4P7paXCb/VE7bPq
 jaaRcdk5A6DXVPYaD6eDNdsf2OxrvuGQUWh9VEk=
X-Google-Smtp-Source: AGHT+IFtBmVRzxwDqSzgJwAlEOFybIWIGYrhfe1P+Z5mgSVyYkGI0TDN8ndaKo2lhu9xPIusg4fstw==
X-Received: by 2002:a05:6a20:7288:b0:13a:6bca:7a84 with SMTP id
 o8-20020a056a20728800b0013a6bca7a84mr10187876pzk.44.1698017589540; 
 Sun, 22 Oct 2023 16:33:09 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fe12-20020a056a002f0c00b0066a4e561beesm5182855pfb.173.2023.10.22.16.33.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 16:33:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v5 41/94] target/sparc: Move SLL, SRL, SRA to decodetree
Date: Sun, 22 Oct 2023 16:28:39 -0700
Message-Id: <20231022232932.80507-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022232932.80507-1-richard.henderson@linaro.org>
References: <20231022232932.80507-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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
index 672eb20c1e..3634b09fdc 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4244,6 +4244,83 @@ static bool trans_MULScc(DisasContext *dc, arg_r_r_ri_cc *a)
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
@@ -4592,77 +4669,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -4675,42 +4681,10 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


