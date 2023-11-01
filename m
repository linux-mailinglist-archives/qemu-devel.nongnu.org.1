Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4617DDBCD
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 05:13:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qy2a7-0005x6-2g; Wed, 01 Nov 2023 00:11:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qy2a2-0005vj-KF
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 00:11:46 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qy2Zy-0007Wd-Cp
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 00:11:46 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6ce2eaf7c2bso4253604a34.0
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 21:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698811901; x=1699416701; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PR95GIj74PU0fGAeOBUIqsFpnfb+ZadloS+PJ/dvH3I=;
 b=LxVqcOGknqUHUCn58txvF4ZZwDLIp8rSGt7KVapjzQSastA7gguoxioboUoPUdLGAi
 8blI/bA5eDRr5F8aMzQI4w310WBH0NyK+GAWhbThF1lgP0N87OQOBdzZqVepT2lEkzHK
 nTOuJLtjZcY70S/AAN6ZYpqnpHzRyaPZ9lMzE9ABWhVGCL2frZspRfGG1ehOH2E42d8Z
 htOxagkSZg0HEZ0NFx7XcZWCZL4mKEXX9fU4MkvPmhcIXjhjGy7r6D/dkKZKT0Nz4BcX
 jLPxLL78JBfeGtqvhz7WJTZDHkDwjCGS3N3miOOk1AN67+WqXuc0p/eQfFyjzXbycfGO
 RkbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698811901; x=1699416701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PR95GIj74PU0fGAeOBUIqsFpnfb+ZadloS+PJ/dvH3I=;
 b=U/sgqBLZ90vokd4qYNoQuS75LcQkap7uMHIHhdLN83KhoFpobcuu4UHcFJk64+kh7e
 Blk36u6hJudekptNhkQVvsWldwksg5mHTZyx7wSvL1aBYR9EbUotpJvLKC9IJbrxlTQ3
 ng6h7MsJ95IGQJHWJp65E6A+p9F/SivPFKXnGaISGJSdCHYddXqD9jRjwFYzCRxh3PAj
 DfkH5qSSJ631JrXc2WGAFJBHt+miEvxrmvgPrjlb93HiUQjohHMM2kJsFAKIBc+JmQOB
 cvnjtPiFJ1QNuu6KDU+kyR+AYiSiAS2W3NhsePC7cMOFow777hLYRpkxJZxHaODUMomB
 amOQ==
X-Gm-Message-State: AOJu0YwZGVPqW29tY0RHOIwGab9D/7pXSQ/DwUbWoWWBU/Pj4aPPCOXP
 laNMltpYgnKDtjBOfL/bFkFs4qQb3XfirZdhqCk=
X-Google-Smtp-Source: AGHT+IFmsU2FOIEJa8qTOOBuT/iMKXro4E7c3O+4J6FBl4ZKp96n49uyM/VdlCiWkoFBQ5VL8b+i0g==
X-Received: by 2002:a05:6808:8c6:b0:3a7:330d:93da with SMTP id
 k6-20020a05680808c600b003a7330d93damr16077483oij.19.1698811901233; 
 Tue, 31 Oct 2023 21:11:41 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k8-20020aa79728000000b006875df4773fsm359576pfg.163.2023.10.31.21.11.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 21:11:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 08/21] target/sparc: Remove CC_OP leftovers
Date: Tue, 31 Oct 2023 21:11:19 -0700
Message-Id: <20231101041132.174501-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101041132.174501-1-richard.henderson@linaro.org>
References: <20231101041132.174501-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

All instructions have been converted to generate
full condition codes explicitly.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/cpu.h          |  21 -------
 target/sparc/helper.h       |   2 -
 linux-user/sparc/cpu_loop.c |   5 --
 target/sparc/cc_helper.c    |  42 -------------
 target/sparc/cpu.c          |   1 -
 target/sparc/int32_helper.c |   5 --
 target/sparc/int64_helper.c |   5 --
 target/sparc/translate.c    | 115 ++++++++----------------------------
 target/sparc/win_helper.c   |   7 ---
 target/sparc/meson.build    |   1 -
 10 files changed, 26 insertions(+), 178 deletions(-)
 delete mode 100644 target/sparc/cc_helper.c

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index a7999eaab5..3e361a5b75 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -137,22 +137,6 @@ enum {
 #define PSR_CWP   0x1f
 #endif
 
-#define CC_SRC (env->cc_src)
-#define CC_SRC2 (env->cc_src2)
-#define CC_DST (env->cc_dst)
-#define CC_OP  (env->cc_op)
-
-/* Even though lazy evaluation of CPU condition codes tends to be less
- * important on RISC systems where condition codes are only updated
- * when explicitly requested, SPARC uses it to update 32-bit and 64-bit
- * condition codes.
- */
-enum {
-    CC_OP_DYNAMIC, /* must use dynamic code to get cc_op */
-    CC_OP_FLAGS,   /* all cc are back in cc_*_[NZCV] registers */
-    CC_OP_NB,
-};
-
 /* Trap base register */
 #define TBR_BASE_MASK 0xfffff000
 
@@ -474,11 +458,6 @@ struct CPUArchState {
     target_ulong xcc_C;
 #endif
 
-    /* emulator internal flags handling */
-    target_ulong cc_src, cc_src2;
-    target_ulong cc_dst;
-    uint32_t cc_op;
-
     target_ulong cond; /* conditional branch result (XXX: save it in a
                           temporary register when possible) */
 
diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index a7b0079c3b..decd94c0d6 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -148,5 +148,3 @@ VIS_CMPHELPER(cmpne)
 #undef F_HELPER_0_1
 #undef VIS_HELPER
 #undef VIS_CMPHELPER
-DEF_HELPER_1(compute_psr, void, env)
-DEF_HELPER_FLAGS_1(compute_C_icc, TCG_CALL_NO_WG_SE, i32, env)
diff --git a/linux-user/sparc/cpu_loop.c b/linux-user/sparc/cpu_loop.c
index c1a2362041..3c1bde00dd 100644
--- a/linux-user/sparc/cpu_loop.c
+++ b/linux-user/sparc/cpu_loop.c
@@ -222,11 +222,6 @@ void cpu_loop (CPUSPARCState *env)
         cpu_exec_end(cs);
         process_queued_cpu_work(cs);
 
-        /* Compute PSR before exposing state.  */
-        if (env->cc_op != CC_OP_FLAGS) {
-            cpu_get_psr(env);
-        }
-
         switch (trapnr) {
         case TARGET_TT_SYSCALL:
             ret = do_syscall (env, env->gregs[1],
diff --git a/target/sparc/cc_helper.c b/target/sparc/cc_helper.c
deleted file mode 100644
index 05f1479aea..0000000000
--- a/target/sparc/cc_helper.c
+++ /dev/null
@@ -1,42 +0,0 @@
-/*
- * Helpers for lazy condition code handling
- *
- *  Copyright (c) 2003-2005 Fabrice Bellard
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
- */
-
-#include "qemu/osdep.h"
-#include "cpu.h"
-#include "exec/helper-proto.h"
-
-void helper_compute_psr(CPUSPARCState *env)
-{
-    if (CC_OP == CC_OP_FLAGS) {
-        return;
-    }
-    g_assert_not_reached();
-}
-
-uint32_t helper_compute_C_icc(CPUSPARCState *env)
-{
-    if (CC_OP == CC_OP_FLAGS) {
-#ifdef TARGET_SPARC64
-        return extract64(env->icc_C, 32, 1);
-#else
-        return env->icc_C;
-#endif
-    }
-    g_assert_not_reached();
-}
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index bb1a155510..befa7fc4eb 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -46,7 +46,6 @@ static void sparc_cpu_reset_hold(Object *obj)
     env->wim = 1;
 #endif
     env->regwptr = env->regbase + (env->cwp * 16);
-    CC_OP = CC_OP_FLAGS;
 #if defined(CONFIG_USER_ONLY)
 #ifdef TARGET_SPARC64
     env->cleanwin = env->nwindows - 2;
diff --git a/target/sparc/int32_helper.c b/target/sparc/int32_helper.c
index 82e8418e46..1563613582 100644
--- a/target/sparc/int32_helper.c
+++ b/target/sparc/int32_helper.c
@@ -103,11 +103,6 @@ void sparc_cpu_do_interrupt(CPUState *cs)
     CPUSPARCState *env = &cpu->env;
     int cwp, intno = cs->exception_index;
 
-    /* Compute PSR before exposing state.  */
-    if (env->cc_op != CC_OP_FLAGS) {
-        cpu_get_psr(env);
-    }
-
     if (qemu_loglevel_mask(CPU_LOG_INT)) {
         static int count;
         const char *name;
diff --git a/target/sparc/int64_helper.c b/target/sparc/int64_helper.c
index 793e57c536..1b4155f5f3 100644
--- a/target/sparc/int64_helper.c
+++ b/target/sparc/int64_helper.c
@@ -135,11 +135,6 @@ void sparc_cpu_do_interrupt(CPUState *cs)
     int intno = cs->exception_index;
     trap_state *tsptr;
 
-    /* Compute PSR before exposing state.  */
-    if (env->cc_op != CC_OP_FLAGS) {
-        cpu_get_psr(env);
-    }
-
 #ifdef DEBUG_PCALL
     if (qemu_loglevel_mask(CPU_LOG_INT)) {
         static int count;
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 7703166ebd..7c4fcf8326 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -105,8 +105,6 @@
 
 /* global register indexes */
 static TCGv_ptr cpu_regwptr;
-static TCGv cpu_cc_src, cpu_cc_src2, cpu_cc_dst;
-static TCGv_i32 cpu_cc_op;
 static TCGv cpu_fsr, cpu_pc, cpu_npc;
 static TCGv cpu_regs[32];
 static TCGv cpu_y;
@@ -172,7 +170,6 @@ typedef struct DisasContext {
 #endif
 #endif
 
-    uint32_t cc_op;  /* current CC operation */
     sparc_def_t *def;
 #ifdef TARGET_SPARC64
     int fprs_dirty;
@@ -962,14 +959,6 @@ static void save_npc(DisasContext *dc)
     }
 }
 
-static void update_psr(DisasContext *dc)
-{
-    if (dc->cc_op != CC_OP_FLAGS) {
-        dc->cc_op = CC_OP_FLAGS;
-        gen_helper_compute_psr(tcg_env);
-    }
-}
-
 static void save_state(DisasContext *dc)
 {
     tcg_gen_movi_tl(cpu_pc, dc->pc);
@@ -1048,20 +1037,9 @@ static void gen_op_next_insn(void)
 static void gen_compare(DisasCompare *cmp, bool xcc, unsigned int cond,
                         DisasContext *dc)
 {
-    TCGv t1, t2;
+    TCGv t1;
 
     cmp->is_bool = false;
-
-    switch (dc->cc_op) {
-    default:
-        gen_helper_compute_psr(tcg_env);
-        dc->cc_op = CC_OP_FLAGS;
-        break;
-
-    case CC_OP_FLAGS:
-        break;
-    }
-
     cmp->c1 = t1 = tcg_temp_new();
     cmp->c2 = tcg_constant_tl(0);
 
@@ -2739,7 +2717,6 @@ TRANS(RDASR17, ASR17, do_rd_special, true, a->rd, do_rd_leon3_config)
 
 static TCGv do_rdccr(DisasContext *dc, TCGv dst)
 {
-    update_psr(dc);
     gen_helper_rdccr(dst, tcg_env);
     return dst;
 }
@@ -2852,7 +2829,6 @@ TRANS(RDSTRAND_STATUS, HYPV, do_rd_special, true, a->rd, do_rdstrand_status)
 
 static TCGv do_rdpsr(DisasContext *dc, TCGv dst)
 {
-    update_psr(dc);
     gen_helper_rdpsr(dst, tcg_env);
     return dst;
 }
@@ -3257,8 +3233,6 @@ TRANS(WRPOWERDOWN, POWERDOWN, do_wr_special, a, supervisor(dc), do_wrpowerdown)
 static void do_wrpsr(DisasContext *dc, TCGv src)
 {
     gen_helper_wrpsr(tcg_env, src);
-    tcg_gen_movi_i32(cpu_cc_op, CC_OP_FLAGS);
-    dc->cc_op = CC_OP_FLAGS;
     dc->base.is_jmp = DISAS_EXIT;
 }
 
@@ -3522,7 +3496,7 @@ static bool trans_NOP(DisasContext *dc, arg_NOP *a)
 TRANS(NOP_v7, 32, trans_NOP, a)
 TRANS(NOP_v9, 64, trans_NOP, a)
 
-static bool do_arith_int(DisasContext *dc, arg_r_r_ri_cc *a, int cc_op,
+static bool do_arith_int(DisasContext *dc, arg_r_r_ri_cc *a,
                          void (*func)(TCGv, TCGv, TCGv),
                          void (*funci)(TCGv, TCGv, target_long),
                          bool logic_cc)
@@ -3536,8 +3510,6 @@ static bool do_arith_int(DisasContext *dc, arg_r_r_ri_cc *a, int cc_op,
 
     if (logic_cc) {
         dst = cpu_cc_N;
-    } else if (a->cc && cc_op > CC_OP_FLAGS) {
-        dst = cpu_cc_dst;
     } else {
         dst = gen_dest_gpr(dc, a->rd);
     }
@@ -3564,42 +3536,36 @@ static bool do_arith_int(DisasContext *dc, arg_r_r_ri_cc *a, int cc_op,
     }
 
     gen_store_gpr(dc, a->rd, dst);
-
-    if (a->cc) {
-        tcg_gen_movi_i32(cpu_cc_op, cc_op);
-        dc->cc_op = cc_op;
-    }
     return advance_pc(dc);
 }
 
-static bool do_arith(DisasContext *dc, arg_r_r_ri_cc *a, int cc_op,
+static bool do_arith(DisasContext *dc, arg_r_r_ri_cc *a,
                      void (*func)(TCGv, TCGv, TCGv),
                      void (*funci)(TCGv, TCGv, target_long),
                      void (*func_cc)(TCGv, TCGv, TCGv))
 {
     if (a->cc) {
-        assert(cc_op >= 0);
-        return do_arith_int(dc, a, cc_op, func_cc, NULL, false);
+        return do_arith_int(dc, a, func_cc, NULL, false);
     }
-    return do_arith_int(dc, a, cc_op, func, funci, false);
+    return do_arith_int(dc, a, func, funci, false);
 }
 
 static bool do_logic(DisasContext *dc, arg_r_r_ri_cc *a,
                      void (*func)(TCGv, TCGv, TCGv),
                      void (*funci)(TCGv, TCGv, target_long))
 {
-    return do_arith_int(dc, a, CC_OP_FLAGS, func, funci, a->cc);
+    return do_arith_int(dc, a, func, funci, a->cc);
 }
 
-TRANS(ADD, ALL, do_arith, a, CC_OP_FLAGS,
-      tcg_gen_add_tl, tcg_gen_addi_tl, gen_op_addcc)
-TRANS(SUB, ALL, do_arith, a, CC_OP_FLAGS,
-      tcg_gen_sub_tl, tcg_gen_subi_tl, gen_op_subcc)
+TRANS(ADD, ALL, do_arith, a, tcg_gen_add_tl, tcg_gen_addi_tl, gen_op_addcc)
+TRANS(SUB, ALL, do_arith, a, tcg_gen_sub_tl, tcg_gen_subi_tl, gen_op_subcc)
+TRANS(ADDC, ALL, do_arith, a, gen_op_addc, NULL, gen_op_addccc)
+TRANS(SUBC, ALL, do_arith, a, gen_op_subc, NULL, gen_op_subccc)
 
-TRANS(TADDcc, ALL, do_arith, a, CC_OP_FLAGS, NULL, NULL, gen_op_taddcc)
-TRANS(TSUBcc, ALL, do_arith, a, CC_OP_FLAGS, NULL, NULL, gen_op_tsubcc)
-TRANS(TADDccTV, ALL, do_arith, a, CC_OP_FLAGS, NULL, NULL, gen_op_taddcctv)
-TRANS(TSUBccTV, ALL, do_arith, a, CC_OP_FLAGS, NULL, NULL, gen_op_tsubcctv)
+TRANS(TADDcc, ALL, do_arith, a, NULL, NULL, gen_op_taddcc)
+TRANS(TSUBcc, ALL, do_arith, a, NULL, NULL, gen_op_tsubcc)
+TRANS(TADDccTV, ALL, do_arith, a, NULL, NULL, gen_op_taddcctv)
+TRANS(TSUBccTV, ALL, do_arith, a, NULL, NULL, gen_op_tsubcctv)
 
 TRANS(AND, ALL, do_logic, a, tcg_gen_and_tl, tcg_gen_andi_tl)
 TRANS(XOR, ALL, do_logic, a, tcg_gen_xor_tl, tcg_gen_xori_tl)
@@ -3607,17 +3573,18 @@ TRANS(ANDN, ALL, do_logic, a, tcg_gen_andc_tl, NULL)
 TRANS(ORN, ALL, do_logic, a, tcg_gen_orc_tl, NULL)
 TRANS(XORN, ALL, do_logic, a, tcg_gen_eqv_tl, NULL)
 
-TRANS(MULX, 64, do_arith, a, -1, tcg_gen_mul_tl, tcg_gen_muli_tl, NULL)
+TRANS(MULX, 64, do_arith, a, tcg_gen_mul_tl, tcg_gen_muli_tl, NULL)
 TRANS(UMUL, MUL, do_logic, a, gen_op_umul, NULL)
 TRANS(SMUL, MUL, do_logic, a, gen_op_smul, NULL)
+TRANS(MULScc, ALL, do_arith, a, NULL, NULL, gen_op_mulscc)
 
-TRANS(UDIVX, 64, do_arith, a, -1, gen_op_udivx, NULL, NULL)
-TRANS(SDIVX, 64, do_arith, a, -1, gen_op_sdivx, NULL, NULL)
-TRANS(UDIV, DIV, do_arith, a, CC_OP_FLAGS, gen_op_udiv, NULL, gen_op_udivcc)
-TRANS(SDIV, DIV, do_arith, a, CC_OP_FLAGS, gen_op_sdiv, NULL, gen_op_sdivcc)
+TRANS(UDIVX, 64, do_arith, a, gen_op_udivx, NULL, NULL)
+TRANS(SDIVX, 64, do_arith, a, gen_op_sdivx, NULL, NULL)
+TRANS(UDIV, DIV, do_arith, a, gen_op_udiv, NULL, gen_op_udivcc)
+TRANS(SDIV, DIV, do_arith, a, gen_op_sdiv, NULL, gen_op_sdivcc)
 
 /* TODO: Should have feature bit -- comes in with UltraSparc T2. */
-TRANS(POPC, 64, do_arith, a, -1, gen_op_popc, NULL, NULL)
+TRANS(POPC, 64, do_arith, a, gen_op_popc, NULL, NULL)
 
 static bool trans_OR(DisasContext *dc, arg_r_r_ri_cc *a)
 {
@@ -3636,24 +3603,6 @@ static bool trans_OR(DisasContext *dc, arg_r_r_ri_cc *a)
     return do_logic(dc, a, tcg_gen_or_tl, tcg_gen_ori_tl);
 }
 
-static bool trans_ADDC(DisasContext *dc, arg_r_r_ri_cc *a)
-{
-    update_psr(dc);
-    return do_arith(dc, a, CC_OP_FLAGS, gen_op_addc, NULL, gen_op_addccc);
-}
-
-static bool trans_SUBC(DisasContext *dc, arg_r_r_ri_cc *a)
-{
-    update_psr(dc);
-    return do_arith(dc, a, CC_OP_FLAGS, gen_op_subc, NULL, gen_op_subccc);
-}
-
-static bool trans_MULScc(DisasContext *dc, arg_r_r_ri_cc *a)
-{
-    update_psr(dc);
-    return do_arith(dc, a, CC_OP_FLAGS, NULL, NULL, gen_op_mulscc);
-}
-
 static bool gen_edge(DisasContext *dc, arg_r_r_r *a,
                      int width, bool cc, bool left)
 {
@@ -3667,8 +3616,6 @@ static bool gen_edge(DisasContext *dc, arg_r_r_r *a,
 
     if (cc) {
         gen_op_subcc(cpu_cc_N, s1, s2);
-        tcg_gen_movi_i32(cpu_cc_op, CC_OP_FLAGS);
-        dc->cc_op = CC_OP_FLAGS;
     }
 
     /*
@@ -5080,7 +5027,6 @@ static void sparc_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 
     dc->pc = dc->base.pc_first;
     dc->npc = (target_ulong)dc->base.tb->cs_base;
-    dc->cc_op = CC_OP_DYNAMIC;
     dc->mem_idx = dc->base.tb->flags & TB_FLAG_MMU_MASK;
     dc->def = &env->def;
     dc->fpu_enabled = tb_fpu_enabled(dc->base.tb->flags);
@@ -5269,13 +5215,6 @@ void sparc_tcg_init(void)
         "f48", "f50", "f52", "f54", "f56", "f58", "f60", "f62",
     };
 
-    static const struct { TCGv_i32 *ptr; int off; const char *name; } r32[] = {
-#ifdef TARGET_SPARC64
-        { &cpu_fprs, offsetof(CPUSPARCState, fprs), "fprs" },
-#endif
-        { &cpu_cc_op, offsetof(CPUSPARCState, cc_op), "cc_op" },
-    };
-
     static const struct { TCGv *ptr; int off; const char *name; } rtl[] = {
 #ifdef TARGET_SPARC64
         { &cpu_gsr, offsetof(CPUSPARCState, gsr), "gsr" },
@@ -5287,9 +5226,6 @@ void sparc_tcg_init(void)
         { &cpu_icc_Z, offsetof(CPUSPARCState, icc_Z), "icc_Z" },
         { &cpu_icc_C, offsetof(CPUSPARCState, icc_C), "icc_C" },
         { &cpu_cond, offsetof(CPUSPARCState, cond), "cond" },
-        { &cpu_cc_src, offsetof(CPUSPARCState, cc_src), "cc_src" },
-        { &cpu_cc_src2, offsetof(CPUSPARCState, cc_src2), "cc_src2" },
-        { &cpu_cc_dst, offsetof(CPUSPARCState, cc_dst), "cc_dst" },
         { &cpu_fsr, offsetof(CPUSPARCState, fsr), "fsr" },
         { &cpu_pc, offsetof(CPUSPARCState, pc), "pc" },
         { &cpu_npc, offsetof(CPUSPARCState, npc), "npc" },
@@ -5303,10 +5239,6 @@ void sparc_tcg_init(void)
                                          offsetof(CPUSPARCState, regwptr),
                                          "regwptr");
 
-    for (i = 0; i < ARRAY_SIZE(r32); ++i) {
-        *r32[i].ptr = tcg_global_mem_new_i32(tcg_env, r32[i].off, r32[i].name);
-    }
-
     for (i = 0; i < ARRAY_SIZE(rtl); ++i) {
         *rtl[i].ptr = tcg_global_mem_new(tcg_env, rtl[i].off, rtl[i].name);
     }
@@ -5329,6 +5261,11 @@ void sparc_tcg_init(void)
                                             offsetof(CPUSPARCState, fpr[i]),
                                             fregnames[i]);
     }
+
+#ifdef TARGET_SPARC64
+    cpu_fprs = tcg_global_mem_new_i32(tcg_env,
+                                      offsetof(CPUSPARCState, fprs), "fprs");
+#endif
 }
 
 void sparc_restore_state_to_opc(CPUState *cs,
diff --git a/target/sparc/win_helper.c b/target/sparc/win_helper.c
index f0ff6bf5db..16d1c70fe7 100644
--- a/target/sparc/win_helper.c
+++ b/target/sparc/win_helper.c
@@ -55,8 +55,6 @@ target_ulong cpu_get_psr(CPUSPARCState *env)
 {
     target_ulong icc = 0;
 
-    helper_compute_psr(env);
-
     icc |= ((int32_t)env->cc_N < 0) << PSR_NEG_SHIFT;
     icc |= ((int32_t)env->cc_V < 0) << PSR_OVF_SHIFT;
     icc |= ((int32_t)env->icc_Z == 0) << PSR_ZERO_SHIFT;
@@ -103,7 +101,6 @@ void cpu_put_psr_raw(CPUSPARCState *env, target_ulong val)
     env->psrps = (val & PSR_PS) ? 1 : 0;
     env->psret = (val & PSR_ET) ? 1 : 0;
 #endif
-    env->cc_op = CC_OP_FLAGS;
 #if !defined(TARGET_SPARC64)
     cpu_set_cwp(env, val & PSR_CWP);
 #endif
@@ -272,8 +269,6 @@ target_ulong cpu_get_ccr(CPUSPARCState *env)
 {
     target_ulong ccr = 0;
 
-    helper_compute_psr(env);
-
     ccr |= (env->icc_C >> 32) & 1;
     ccr |= ((int32_t)env->cc_V < 0) << 1;
     ccr |= ((int32_t)env->icc_Z == 0) << 2;
@@ -295,8 +290,6 @@ void cpu_put_ccr(CPUSPARCState *env, target_ulong val)
     env->xcc_C = (val >> 4) & 1;
     env->icc_Z = ~val & 0x04;
     env->xcc_Z = ~val & 0x40;
-
-    CC_OP = CC_OP_FLAGS;
 }
 
 target_ulong cpu_get_cwp64(CPUSPARCState *env)
diff --git a/target/sparc/meson.build b/target/sparc/meson.build
index c316773db6..46289c8669 100644
--- a/target/sparc/meson.build
+++ b/target/sparc/meson.build
@@ -3,7 +3,6 @@ gen = decodetree.process('insns.decode')
 sparc_ss = ss.source_set()
 sparc_ss.add(gen)
 sparc_ss.add(files(
-  'cc_helper.c',
   'cpu.c',
   'fop_helper.c',
   'gdbstub.c',
-- 
2.34.1


