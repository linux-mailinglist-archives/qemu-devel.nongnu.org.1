Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9917D798A
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:33:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo9v-0003FK-67; Wed, 25 Oct 2023 20:23:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo9P-0000yP-UN
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:23:04 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo9L-0008CB-RW
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:23:03 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-27d4372322aso230999a91.3
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279778; x=1698884578; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RIi7xoRuzKbSVlpBvebwS7XPDovioXkEjFSzNKBTcCg=;
 b=C5+IGhuZeTEXf845J3zcdiH0fBhg1G63HVH9OYH/+fBGXZpx+3iwJci9eozz46mIHm
 K5LJQS58fgu5ZhFrW+AKdDqnQpsbRAgeDcsDiOullNrDn4F2CXLeoUcPY9q0+nuZHlBw
 sFytSHzktjeaL7gwPnq6n2ulSqt0sx4i2gg9k13YHPpiCGOOr3C68msB0r2P7uK1coQO
 J6pbjjhp4MB3p6EtNZDsH/AKR2eCrTOyhZUQgNBSpXyrCaIWjp6egDeDyjRgwT+fYM34
 HDnkN+WN4wQQ0E2zKlU5pcILFENH6E44g9a0gCMxH2FcAxxq58JP+FGU4cG6oWQKhop9
 DmTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279778; x=1698884578;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RIi7xoRuzKbSVlpBvebwS7XPDovioXkEjFSzNKBTcCg=;
 b=E1EEuOn5hjFwu/LQAUaxRmlVTb6k30YTB5Jew//w6QzC6w3lMMHzNXzJHsRyW4oJWo
 psVdOIh5yjPBjd5LCjiP6KqYRMjYprhvqv/zxHTnhiGRpBARDWEQfYzynMS25S6CR6TO
 A5B7NVtZIKaFj0JnjCvfKBBbIc68XHAa5UoWf33marfZPqH+IWOXOzOu8SXOe5Yi7KWK
 2m8PWwvU6fyh7q6eNAkdVWV7ab9YnDUEp2cNjMsyMuu+ChytXSEhD65bJd716h0uC1eH
 bvUhkWCtEvRW1yoC3OP7MUvOETpDCLGQqIwjXNyIV4iZVPTPvkSYiDt2g8+Uhq7Hr5YD
 xluA==
X-Gm-Message-State: AOJu0YyOhh1hqJ9i3xg8LWnWH8W5tDfcTEJYk9C6sCLJr1QUa+o9Paqg
 QQNZsq06FiDhc58cKAMeO2+4Bl/QLV/iyPkvCng=
X-Google-Smtp-Source: AGHT+IFGadz1pHzMxpfnwhGGK7pv3rPp1f+oZAXZUjA8NbvnFqN30uRL9pvwWAhYTtpVH6NEqDWs2g==
X-Received: by 2002:a17:90b:354e:b0:27d:37bb:12c0 with SMTP id
 lt14-20020a17090b354e00b0027d37bb12c0mr13885687pjb.36.1698279778327; 
 Wed, 25 Oct 2023 17:22:58 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 9-20020a17090a0cc900b0027463889e72sm499870pjt.55.2023.10.25.17.22.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:22:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 61/94] target/sparc: Move LDFSR, STFSR to decodetree
Date: Wed, 25 Oct 2023 17:15:09 -0700
Message-Id: <20231026001542.1141412-91-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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
 target/sparc/insns.decode |   4 +
 target/sparc/translate.c  | 152 +++++++++++++++-----------------------
 2 files changed, 64 insertions(+), 92 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 45eb6a967f..5df3b1add4 100644
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
index ebffcd7393..4c0e7cde4a 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -45,6 +45,7 @@
 # define gen_helper_clear_softint(E, S)         qemu_build_not_reached()
 # define gen_helper_done(E)                     qemu_build_not_reached()
 # define gen_helper_flushw(E)                   qemu_build_not_reached()
+# define gen_helper_ldxfsr(D, E, A, B)          qemu_build_not_reached()
 # define gen_helper_rdccr(D, E)                 qemu_build_not_reached()
 # define gen_helper_rdcwp(D, E)                 qemu_build_not_reached()
 # define gen_helper_restored(E)                 qemu_build_not_reached()
@@ -164,12 +165,6 @@ typedef struct {
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
@@ -2655,13 +2650,13 @@ static void gen_stda_asi(DisasContext *dc, DisasASI *da, TCGv addr, int rd)
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
@@ -4680,6 +4675,61 @@ static bool trans_STDFQ(DisasContext *dc, arg_STDFQ *a)
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
@@ -4693,10 +4743,10 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5477,89 +5527,7 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


