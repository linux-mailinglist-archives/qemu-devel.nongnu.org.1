Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 373AF7CBAEC
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:21:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdNs-0003V2-8H; Tue, 17 Oct 2023 02:16:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdNj-00038H-Rz
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:16:43 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdNa-0004jA-5a
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:16:43 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6c7b3adbeb6so3795482a34.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523393; x=1698128193; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dMSUFS9qh79LcgmLspNPYV12WqEJpxUzeh5RmFSfxBg=;
 b=KyijiEJZrzdL/XZKc58a4Uj0STimf6pC6yT3oGE5PR7/PaawNyOjorv0nHMQkD/ZrV
 Ecj+AGme2Oc6UJfYmXl9/LzXC9qCBmaOCbaUuoNRBX180MtJM1SxSXqkQZIqQSujwhdV
 52I9U7mvSZB2e2NY2B6D2xStbCtipwALUinl/Rh+rOeFycaPbKMYtaKopgxiIab9VdfU
 AOpGAv2oYErx1Zff0QK/zmIKFrWTjceLVm3d2srHdycTZPgU889i1RVMCnTG1+dQfvtE
 PFFjdFi/EOCxc6z2iAkNaL5mCfqDgX4GYh1DeMEXawALHRtOY8tLkArT4va3+lgovQuL
 21MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523393; x=1698128193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dMSUFS9qh79LcgmLspNPYV12WqEJpxUzeh5RmFSfxBg=;
 b=oRyJFnbL9OC5BkIpPeTqyRpOhLP55f1QI1qupwSBdDVj5+vitMCJ62UACzr80o4zto
 qoLxbI7/Z8hu4QN+WyOQ1p3c+uiBQ08EP7aPUdYbvaV4CJcDU1FQt2DLS1PL8lsKyqbC
 DlE0Ox5KHU64/W/jOW3lASEEHAO0bIcCQgm0nfNuv3AQgaKXnFVXcCcpECcqamri39Xg
 +sFTaaqOKKWA2dV+im4v/wwQWUp7XyHRUdgO9yU0TgD840kVEG1GyKfocMWrghRuZFSH
 nZ3bhROQQ1n0zup4/8llrH4RR16ETAGY62BhqfgHvesweAvqdLLQ8b+9RIldevn3FRSy
 1prg==
X-Gm-Message-State: AOJu0YwJS20A5YPr6y0gR58cJcAUu/C4fInoM6Wx+31ZJ8PRuyrmNoxT
 BnwjDftmN28TI8Kh4nCLQMamkgLeU6qxLmp3aII=
X-Google-Smtp-Source: AGHT+IH9NZ+OO2Yj+MIQEwebdT8NTR4ubd1qOBWfgc3eTMLTjxZuKjsVTP9qTvEq7IneThMDpJavpQ==
X-Received: by 2002:a05:6830:25d4:b0:6bd:b879:c313 with SMTP id
 d20-20020a05683025d400b006bdb879c313mr1561270otu.10.1697523392929; 
 Mon, 16 Oct 2023 23:16:32 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 m10-20020a056a00080a00b00690ca4356f1sm579280pfk.198.2023.10.16.23.16.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:16:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 57/90] target/sparc: Move LDFSR, STFSR to decodetree
Date: Mon, 16 Oct 2023 23:12:11 -0700
Message-Id: <20231017061244.681584-58-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32b.google.com
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
index fa9c8d3d8b..42eb807e21 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -299,10 +299,14 @@ STX         11 ..... 011110 ..... . .............          @r_r_r_asi # STXA
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
index 6fdcfebe55..b23f77a199 100644
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
@@ -2596,13 +2591,13 @@ static void gen_stda_asi(DisasContext *dc, DisasASI *da, TCGv addr, int rd)
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
@@ -4768,6 +4763,61 @@ static bool trans_STDFQ(DisasContext *dc, arg_STDFQ *a)
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
@@ -4781,10 +4831,10 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5565,89 +5615,7 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


