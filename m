Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDE37C8F6E
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:39:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPm1-0000Rk-Mt; Fri, 13 Oct 2023 17:32:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPlx-0008Vx-9k
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:32:41 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPlt-0001O6-Up
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:32:40 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6b77ab73c6fso385177b3a.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232756; x=1697837556; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UZ6MWwDb1p96KXrcyOGajk1wJln0yWp6ytGgWlJQ1wE=;
 b=juEpSYBt+GdQRntlaAyDA+DG+mkqFF1lUt8pO36ax3vARxVWpWBW+gUzR8sfR9uhOi
 Tw4yVvDtE50ymBbp7LiAibFSvafQZa4JwndaQikw4oaX1Ks608oGgtDirgtB+mGAfd94
 rhZ5LNFlUW5xI8acnNqerdbO1PoOJicFTGJpEWsuHwZgBEcvDjV4t/yjpgFNXrp6F8pX
 vxtDlwJTuCcxQzTlCrRKw+ZBfw2/WJERqFwTp0+o5LO9IRRUAuIx1yDYFCIqRVFqfX0K
 iwK/ckNfVntqjmdSqoCu/4YrWf/QA0LWspWNNeE/+yf1zB+8poOgiw/xglEyc6GmdpW4
 anjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232756; x=1697837556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UZ6MWwDb1p96KXrcyOGajk1wJln0yWp6ytGgWlJQ1wE=;
 b=Ly6lbpz524zjlev8K8Sci+lrrta1jXTsqfBkcCuY+hk4GTUGGcQsO6UJ3hXp6RPBwV
 L6xjaKdTC/zcfCFZKbLBduEttEATIFTGrqzFopZCy0PTP/QtaLl4Wb5HN3+KoDhCo91f
 +xO/Maxm56a1sIV1oMw3chBUK9VpkNV6EmHU16soe0W+pq9wzIODIOXunLCYMyML/3Eo
 fmkgbVkHsKQif2I8DXEFKH2c9l91vd/rTvmJLY0iFWr/NA1XynrsyWRb8jjnLRIjaW4p
 yy6RoK0+wYiYT3X8WKCWyagdLAzz+vHZXZDpD6/F4Ao6H+ZbSl+0WZ3SXWLeRxRdAVrG
 +BoA==
X-Gm-Message-State: AOJu0YxoQU1+6ML2Kh+gTukTALbPAyCG/EtqdiVqaakjXu5teHTeoYbB
 ZgLLZtrrM0AGo7toiP6blbK6Radbf2px4TQ5lqo=
X-Google-Smtp-Source: AGHT+IEpwEvT6YcYkU+ZPHF1GLTdY+WvLa2qFXRzgw1CQSI4QQQVLVmr+Myyjf4k1t4Ee3E1A+mw2g==
X-Received: by 2002:a05:6a00:3695:b0:68e:2c2a:aa1d with SMTP id
 dw21-20020a056a00369500b0068e2c2aaa1dmr1816353pfb.11.1697232756407; 
 Fri, 13 Oct 2023 14:32:36 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 j5-20020aa78d05000000b0068842ebfd10sm13977191pfe.160.2023.10.13.14.32.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:32:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 52/85] target/sparc: Move LDFSR, STFSR to decodetree
Date: Fri, 13 Oct 2023 14:28:13 -0700
Message-Id: <20231013212846.165724-53-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013212846.165724-1-richard.henderson@linaro.org>
References: <20231013212846.165724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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
index b354bb97c4..185bcadab7 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -300,10 +300,14 @@ STX         11 ..... 011110 ..... . .............          @r_r_r_asi # STXA
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
index f53b45aa38..9384815f0b 100644
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
@@ -153,12 +154,6 @@ typedef struct {
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
@@ -2547,13 +2542,13 @@ static void gen_stda_asi(DisasContext *dc, DisasASI *da, TCGv addr, int rd)
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
@@ -4702,6 +4697,61 @@ static bool trans_STDFQ(DisasContext *dc, arg_STDFQ *a)
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
@@ -4715,10 +4765,10 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5499,89 +5549,7 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


