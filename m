Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9127D1AFC
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 07:38:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu4eY-0003JT-4i; Sat, 21 Oct 2023 01:36:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4eO-0002kb-0E
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:35:53 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4eK-00017c-PU
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:35:51 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6bf03b98b9bso1675859b3a.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 22:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697866547; x=1698471347; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yWRJfF+GNQJEKbetIqJQA0wahH6aOWwJd5gm2Mh/bWU=;
 b=wNpq3FbiGskx38M3H6CQFKhfU20FvpR24DTOfr/eiwHsSQ0VvxywTYZrnhdLJ6/jlH
 ztyUraMmA9Z3dLeuRYXyyX/PJh8ksuxAhIwE1bwOH6JgEgbT4NW2Tm5Czl2JvdbNf9HW
 8u4qsOf03JfziHN+z0YVg3uW+y03WYIEyOGfWpF7IAwOgqYZEI9EDfF/eypxdlG5RdWi
 dkJdfGS0y6Bt2Y5tl3cuc0SyZ+jER23jDIzCInehZlbiemXdf2vfV2hROfyvdgCnXORf
 sTmQdRuRnjglGoUyS1APM75cDg25+I7adq1h3pwmM19l1Vzr6EJxRZ3gjVQc2GhdkodY
 p37A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697866547; x=1698471347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yWRJfF+GNQJEKbetIqJQA0wahH6aOWwJd5gm2Mh/bWU=;
 b=t35c5iGjSYO/eOffm2mXT4aatuWWGo/A15+NAWLev+XiKVXRL8A7/XX5vezGCuBR1u
 Z5fZKhrIv78APeDtLmcFpEsZnZZx+zah9UfN+Km0JQ2zAKcMReTFX55gPpKd0U/OzRC2
 s+58zUFy99S8KU04F7oJ5nYooKy/eJYJWJkmLG/RRP8ZEw/ermS/CLKhCW+Fwdx2vxHe
 6R8D37u64dEWWRJwhCDJYUNDVYjMdnpmfL2V4n5ITVe5RUsd44VMme5qfZD55i43as3w
 zWIemPk+075/+mUW/abgqMu06QbALqKxWPvp8Z8F3kkM5B567MVh5m2ea6mhI2FGzAeC
 NFvA==
X-Gm-Message-State: AOJu0YwXEsls3ZxMNXe4V/GNs0yzkCVnooKaFOCA1VVPMwKAR2y1CIi8
 I1BQUN0NwYEVgNI3tDb10RUdqrpLCEXvjp7ZFpY=
X-Google-Smtp-Source: AGHT+IF69H4ouapAIHLnZErpJj8bCcxyKQ6ZEsMsCQvaGLEnOl5MtW7FnWhXr6IPUJejQHzrUU5djQ==
X-Received: by 2002:a05:6a20:3d07:b0:159:c07d:66f0 with SMTP id
 y7-20020a056a203d0700b00159c07d66f0mr5620078pzi.6.1697866547199; 
 Fri, 20 Oct 2023 22:35:47 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 h1-20020a62b401000000b00690d255b5a1sm2427978pfn.217.2023.10.20.22.35.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 22:35:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 57/90] target/sparc: Move LDFSR, STFSR to decodetree
Date: Fri, 20 Oct 2023 22:31:25 -0700
Message-Id: <20231021053158.278135-58-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231021053158.278135-1-richard.henderson@linaro.org>
References: <20231021053158.278135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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
 target/sparc/insns.decode |   4 +
 target/sparc/translate.c  | 152 +++++++++++++++-----------------------
 2 files changed, 64 insertions(+), 92 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 6e8416520a..850b1a3845 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -306,10 +306,14 @@ STX         11 ..... 011110 ..... . .............          @r_r_r_asi # STXA
 STX         11 ..... 011110 ..... . .............          @r_r_i_asi # STXA
 
 LDF         11 ..... 100000 ..... . .............          @r_r_ri_na
+LDFSR       11 00000 100001 ..... . .............          @n_r_ri
+LDXFSR      11 00001 100001 ..... . .............          @n_r_ri
 LDQF        11 ..... 100010 ..... . .............          @q_r_ri_na
 LDDF        11 ..... 100011 ..... . .............          @d_r_ri_na
 
 STF         11 ..... 100100 ..... . .............          @r_r_ri_na
+STFSR       11 00000 100101 ..... . .............          @n_r_ri
+STXFSR      11 00001 100101 ..... . .............          @n_r_ri
 {
   STQF      11 ..... 100110 ..... . .............          @q_r_ri_na
   STDFQ     11 ----- 100110 ----- - -------------
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 46448fb5c5..8ac9ef2e12 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -58,6 +58,7 @@
 #define gen_helper_retry(E)             qemu_build_not_reached()
 #define gen_helper_udivx(D, E, A, B)    qemu_build_not_reached()
 #define gen_helper_sdivx(D, E, A, B)    qemu_build_not_reached()
+#define gen_helper_ldxfsr(R, E, X, Y)   qemu_build_not_reached()
 # ifdef CONFIG_USER_ONLY
 static void gen_helper_ld_asi(TCGv_i64 r, TCGv_env e, TCGv a,
                               TCGv_i32 asi, TCGv_i32 mop)
@@ -163,12 +164,6 @@ typedef struct {
 #define UA2005_HTRAP_MASK 0xff
 #define V8_TRAP_MASK 0x7f
 
-static int sign_extend(int x, int len)
-{
-    len = 32 - len;
-    return (x << len) >> len;
-}
-
 #define IS_IMM (insn & (1<<13))
 
 static void gen_update_fprs_dirty(DisasContext *dc, int rd)
@@ -2638,13 +2633,13 @@ static void gen_stda_asi(DisasContext *dc, DisasASI *da, TCGv addr, int rd)
     }
 }
 
+#ifdef TARGET_SPARC64
 static TCGv get_src1(DisasContext *dc, unsigned int insn)
 {
     unsigned int rs1 = GET_FIELD(insn, 13, 17);
     return gen_load_gpr(dc, rs1);
 }
 
-#ifdef TARGET_SPARC64
 static void gen_fmovs(DisasContext *dc, DisasCompare *cmp, int rd, int rs)
 {
     TCGv_i32 c32, zero, dst, s1, s2;
@@ -4802,6 +4797,61 @@ static bool trans_STDFQ(DisasContext *dc, arg_STDFQ *a)
     return true;
 }
 
+static bool trans_LDFSR(DisasContext *dc, arg_r_r_ri *a)
+{
+    TCGv addr;
+    TCGv_i32 tmp;
+
+    addr = gen_ldst_addr(dc, a->rs1, a->imm, a->rs2_or_imm);
+    if (addr == NULL) {
+        return false;
+    }
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+    tmp = tcg_temp_new_i32();
+    tcg_gen_qemu_ld_i32(tmp, addr, dc->mem_idx, MO_TEUL | MO_ALIGN);
+    gen_helper_ldfsr(cpu_fsr, tcg_env, cpu_fsr, tmp);
+    return advance_pc(dc);
+}
+
+static bool trans_LDXFSR(DisasContext *dc, arg_r_r_ri *a)
+{
+    TCGv addr;
+    TCGv_i64 tmp;
+
+    if (!avail_64(dc)) {
+        return false;
+    }
+    addr = gen_ldst_addr(dc, a->rs1, a->imm, a->rs2_or_imm);
+    if (addr == NULL) {
+        return false;
+    }
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+    tmp = tcg_temp_new_i64();
+    tcg_gen_qemu_ld_i64(tmp, addr, dc->mem_idx, MO_TEUQ | MO_ALIGN);
+    gen_helper_ldxfsr(cpu_fsr, tcg_env, cpu_fsr, tmp);
+    return advance_pc(dc);
+}
+
+static bool do_stfsr(DisasContext *dc, arg_r_r_ri *a, MemOp mop)
+{
+    TCGv addr = gen_ldst_addr(dc, a->rs1, a->imm, a->rs2_or_imm);
+    if (addr == NULL) {
+        return false;
+    }
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+    tcg_gen_qemu_st_tl(cpu_fsr, addr, dc->mem_idx, mop | MO_ALIGN);
+    return advance_pc(dc);
+}
+
+TRANS(STFSR, ALL, do_stfsr, a, MO_TEUL)
+TRANS(STXFSR, 64, do_stfsr, a, MO_TEUQ)
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -4815,10 +4865,10 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
     unsigned int opc, rs1, rs2, rd;
     TCGv cpu_src1 __attribute__((unused));
     TCGv cpu_src2 __attribute__((unused));
-    TCGv_i32 cpu_src1_32, cpu_src2_32, cpu_dst_32;
+    TCGv_i32 cpu_src1_32, cpu_src2_32;
     TCGv_i64 cpu_src1_64, cpu_src2_64;
+    TCGv_i32 cpu_dst_32 __attribute__((unused));
     TCGv_i64 cpu_dst_64 __attribute__((unused));
-    target_long simm;
 
     opc = GET_FIELD(insn, 0, 1);
     rd = GET_FIELD(insn, 2, 6);
@@ -5599,89 +5649,7 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
         }
         break;
     case 3:                     /* load/store instructions */
-        {
-            unsigned int xop = GET_FIELD(insn, 7, 12);
-            /* ??? gen_address_mask prevents us from using a source
-               register directly.  Always generate a temporary.  */
-            TCGv cpu_addr = tcg_temp_new();
-
-            tcg_gen_mov_tl(cpu_addr, get_src1(dc, insn));
-            if (IS_IMM) {     /* immediate */
-                simm = GET_FIELDs(insn, 19, 31);
-                if (simm != 0) {
-                    tcg_gen_addi_tl(cpu_addr, cpu_addr, simm);
-                }
-            } else {            /* register */
-                rs2 = GET_FIELD(insn, 27, 31);
-                if (rs2 != 0) {
-                    tcg_gen_add_tl(cpu_addr, cpu_addr, gen_load_gpr(dc, rs2));
-                }
-            }
-            if (xop < 4 || (xop > 7 && xop < 0x14 && xop != 0x0e) ||
-                (xop > 0x17 && xop <= 0x1d ) ||
-                (xop > 0x2c && xop <= 0x33) || xop == 0x1f || xop == 0x3d) {
-                goto illegal_insn;  /* in decodetree */
-            } else if (xop >= 0x20 && xop < 0x24) {
-                if (gen_trap_ifnofpu(dc)) {
-                    goto jmp_insn;
-                }
-                switch (xop) {
-                case 0x20:      /* ldf, load fpreg */
-                case 0x22:      /* ldqf, load quad fpreg */
-                case 0x23:      /* lddf, load double fpreg */
-                    g_assert_not_reached();  /* in decodetree */
-                case 0x21:      /* ldfsr, V9 ldxfsr */
-#ifdef TARGET_SPARC64
-                    gen_address_mask(dc, cpu_addr);
-                    if (rd == 1) {
-                        TCGv_i64 t64 = tcg_temp_new_i64();
-                        tcg_gen_qemu_ld_i64(t64, cpu_addr,
-                                            dc->mem_idx, MO_TEUQ | MO_ALIGN);
-                        gen_helper_ldxfsr(cpu_fsr, tcg_env, cpu_fsr, t64);
-                        break;
-                    }
-#endif
-                    cpu_dst_32 = tcg_temp_new_i32();
-                    tcg_gen_qemu_ld_i32(cpu_dst_32, cpu_addr,
-                                        dc->mem_idx, MO_TEUL | MO_ALIGN);
-                    gen_helper_ldfsr(cpu_fsr, tcg_env, cpu_fsr, cpu_dst_32);
-                    break;
-                default:
-                    goto illegal_insn;
-                }
-            } else if (xop > 0x23 && xop < 0x28) {
-                if (gen_trap_ifnofpu(dc)) {
-                    goto jmp_insn;
-                }
-                switch (xop) {
-                case 0x24: /* stf, store fpreg */
-                case 0x26: /* v9 stqf, v8 stdfq */
-                case 0x27: /* stdf, store double fpreg */
-                    g_assert_not_reached();
-                case 0x25: /* stfsr, V9 stxfsr */
-                    {
-#ifdef TARGET_SPARC64
-                        gen_address_mask(dc, cpu_addr);
-                        if (rd == 1) {
-                            tcg_gen_qemu_st_tl(cpu_fsr, cpu_addr,
-                                               dc->mem_idx, MO_TEUQ | MO_ALIGN);
-                            break;
-                        }
-#endif
-                        tcg_gen_qemu_st_tl(cpu_fsr, cpu_addr,
-                                           dc->mem_idx, MO_TEUL | MO_ALIGN);
-                    }
-                    break;
-                default:
-                    goto illegal_insn;
-                }
-            } else if (xop > 0x33 && xop < 0x3f) {
-                goto illegal_insn; /* in decodetree */
-            } else {
-                goto illegal_insn;
-            }
-        }
-        break;
+        goto illegal_insn; /* in decodetree */
     }
     advance_pc(dc);
  jmp_insn:
-- 
2.34.1


