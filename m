Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E0D7CBB90
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:46:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdmW-00008K-B1; Tue, 17 Oct 2023 02:42:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdlb-0007tK-Qn
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:41:26 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdlX-0001r7-DW
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:41:22 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1c8a1541233so32898205ad.1
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697524876; x=1698129676; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ytX3I+Rcwm2SQxKX9URwzSdF8jj+n/0iYLiv3fomhxs=;
 b=SyDEbyTTRxsi5gd1nnZMzMx1wI3vHPzmpROPpcxgRWmtvbFs2rua4A8eixyADKcgOu
 /3S6qtBT9twdcKADwVzg/SjR08rJOL0bBlUYXyQFETIU+NiceJGRPZcXhmbOIe2YTmdK
 CxlkbvplD3nWwS5huUFCX4wXvEJmQamrelxqr0pcY5h+S9U8YEkk7Ol2MiYKXuA+wdfs
 M7mKa5/SqIJeNAr39W07Zq1dz/71Yg4J4LUy81jutMmREv+5+a9EfHTbdasK0bOm4rMC
 rCO5F3WPFDo4n5FY6LWljKIOl4jpzbBRSd9naqIabEnSHjbxCMfyRhNiMd8DtglocBkK
 PjcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697524876; x=1698129676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ytX3I+Rcwm2SQxKX9URwzSdF8jj+n/0iYLiv3fomhxs=;
 b=Ul1cPANLYEi1kS4k9mem2YBMfXmUaLdPj9TL0DPrvQ5g65W+F1F54B9vuBHY6UnN+W
 khIMN0H483OHLlo/YPYO5mZOx2zjT6m44xKjg4XHN8FUOkl5hb3Iq53uszOxq+nPhkEt
 FpviWh/DUYDQztg1a7sK0RnrdsMOYJDikSCmXY16RwUZZSE/h4BZq3I5Fbf4MP/z0oUQ
 W0yG4qjuwGnxhlNqy9SwM6rXOJR5zornnFk6dyeOYJkTtvFymojOnaBMD4AB9Fey0NH/
 FO605uiiWX7gOU2iUzR3BUIt1XDmaXf4IlzwPT97TjoeuFL8JkHUPAdLbV3rZPA3BewX
 L08A==
X-Gm-Message-State: AOJu0Yxu9etFlB7kkr1xIlkH+sntuNbAn34lcXcp8ZlbTWTyAflGSzo7
 bHHwngDLtHmBqnJ4mRJMkT9fQs+8Yt3DurxmjOU=
X-Google-Smtp-Source: AGHT+IF2Opvx/oTL9Wd/6bsMIQQfCY/BtFH70H99OOqLwAXYUQuW+S3AdeS4xdVNuIS5FuX95E8NJA==
X-Received: by 2002:a17:902:bd07:b0:1c9:e774:58e1 with SMTP id
 p7-20020a170902bd0700b001c9e77458e1mr1323318pls.8.1697524876603; 
 Mon, 16 Oct 2023 23:41:16 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 x18-20020a17090300d200b001b891259eddsm685682plc.197.2023.10.16.23.41.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:41:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 08/20] target/sparc: Remove CC_OP leftovers
Date: Mon, 16 Oct 2023 23:40:57 -0700
Message-Id: <20231017064109.681935-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017064109.681935-1-richard.henderson@linaro.org>
References: <20231017064109.681935-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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
 target/sparc/translate.c    | 120 +++++++-----------------------------
 target/sparc/win_helper.c   |   7 ---
 target/sparc/meson.build    |   1 -
 10 files changed, 22 insertions(+), 187 deletions(-)
 delete mode 100644 target/sparc/cc_helper.c

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 27f7fed293..855ac8b59f 100644
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
     target_ulong cc_xcc_C;
 #endif
 
-    /* emulator internal flags handling */
-    target_ulong cc_src, cc_src2;
-    target_ulong cc_dst;
-    uint32_t cc_op;
-
     target_ulong cond; /* conditional branch result (XXX: save it in a
                           temporary register when possible) */
 
diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index 58d3c979d4..6415942e03 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -150,5 +150,3 @@ VIS_CMPHELPER(cmpne)
 #undef F_HELPER_0_1
 #undef VIS_HELPER
 #undef VIS_CMPHELPER
-DEF_HELPER_1(compute_psr, void, env)
-DEF_HELPER_FLAGS_1(compute_C_icc, TCG_CALL_NO_WG_SE, i32, env)
diff --git a/linux-user/sparc/cpu_loop.c b/linux-user/sparc/cpu_loop.c
index a2086afada..e4d66cbbac 100644
--- a/linux-user/sparc/cpu_loop.c
+++ b/linux-user/sparc/cpu_loop.c
@@ -234,11 +234,6 @@ void cpu_loop (CPUSPARCState *env)
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
index cebe03ff51..0000000000
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
-        return extract64(env->cc_icc_C, 32, 1);
-#else
-        return env->cc_icc_C;
-#endif
-    }
-    g_assert_not_reached();
-}
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 0a3882653c..3980c2d3ca 100644
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
index d8cb669592..5c0b6b2764 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -116,8 +116,6 @@ static void gen_helper_array8(TCGv r, TCGv a, TCGv b)
 
 /* global register indexes */
 static TCGv_ptr cpu_regwptr;
-static TCGv cpu_cc_src, cpu_cc_src2, cpu_cc_dst;
-static TCGv_i32 cpu_cc_op;
 static TCGv cpu_fsr, cpu_pc, cpu_npc;
 static TCGv cpu_regs[32];
 static TCGv cpu_y;
@@ -175,7 +173,6 @@ typedef struct DisasContext {
 #endif
 #endif
 
-    uint32_t cc_op;  /* current CC operation */
     sparc_def_t *def;
 #ifdef TARGET_SPARC64
     int fprs_dirty;
@@ -900,14 +897,6 @@ static void save_npc(DisasContext *dc)
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
@@ -989,17 +978,6 @@ static void gen_compare(DisasCompare *cmp, bool xcc, unsigned int cond,
     TCGv t1, t2;
 
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
     cmp->c1 = NULL;
     cmp->c2 = tcg_constant_tl(0);
 
@@ -2657,7 +2635,6 @@ TRANS(RDASR17, ASR17, do_rd_special, true, a->rd, do_rd_leon3_config)
 
 static TCGv do_rdccr(DisasContext *dc, TCGv dst)
 {
-    update_psr(dc);
     gen_helper_rdccr(dst, tcg_env);
     return dst;
 }
@@ -2800,7 +2777,6 @@ TRANS(RDSTRAND_STATUS, HYPV, do_rd_special, true, a->rd, do_rdstrand_status)
 
 static TCGv do_rdpsr(DisasContext *dc, TCGv dst)
 {
-    update_psr(dc);
     gen_helper_rdpsr(dst, tcg_env);
     return dst;
 }
@@ -3261,8 +3237,6 @@ TRANS(WRPOWERDOWN, POWERDOWN, do_wr_special, a, supervisor(dc), do_wrpowerdown)
 static void do_wrpsr(DisasContext *dc, TCGv src)
 {
     gen_helper_wrpsr(tcg_env, src);
-    tcg_gen_movi_i32(cpu_cc_op, CC_OP_FLAGS);
-    dc->cc_op = CC_OP_FLAGS;
     save_state(dc);
     gen_op_next_insn();
     tcg_gen_exit_tb(NULL, 0);
@@ -3571,9 +3545,10 @@ static bool trans_NOP_v9(DisasContext *dc, arg_NOP_v9 *a)
     return false;
 }
 
-static bool do_cc_arith(DisasContext *dc, arg_r_r_ri *a, int cc_op,
-                        void (*func)(TCGv, TCGv, TCGv),
-                        void (*funci)(TCGv, TCGv, target_long))
+static bool do_arith_int(DisasContext *dc, arg_r_r_ri *a,
+                         void (*func)(TCGv, TCGv, TCGv),
+                         void (*funci)(TCGv, TCGv, target_long),
+                         bool logic_cc)
 {
     TCGv dst, src1;
 
@@ -3582,14 +3557,10 @@ static bool do_cc_arith(DisasContext *dc, arg_r_r_ri *a, int cc_op,
         return false;
     }
 
-    if (cc_op < 0) {
-        dst = gen_dest_gpr(dc, a->rd);
-    } else if (cc_op == CC_OP_FLAGS) {
+    if (logic_cc) {
         dst = cpu_cc_N;
     } else {
-        dst = cpu_cc_dst;
-        tcg_gen_movi_i32(cpu_cc_op, cc_op);
-        dc->cc_op = cc_op;
+        dst = gen_dest_gpr(dc, a->rd);
     }
     src1 = gen_load_gpr(dc, a->rs1);
 
@@ -3603,8 +3574,7 @@ static bool do_cc_arith(DisasContext *dc, arg_r_r_ri *a, int cc_op,
         func(dst, src1, cpu_regs[a->rs2_or_imm]);
     }
 
-    /* Logic insn; to be cleaned up later. */
-    if (cc_op == CC_OP_FLAGS) {
+    if (logic_cc) {
         tcg_gen_movi_tl(cpu_cc_V, 0);
         tcg_gen_movi_tl(cpu_icc_C, 0);
 #ifdef TARGET_SPARC64
@@ -3612,9 +3582,6 @@ static bool do_cc_arith(DisasContext *dc, arg_r_r_ri *a, int cc_op,
         tcg_gen_mov_tl(cpu_xcc_Z, dst);
 #endif
         tcg_gen_mov_tl(cpu_icc_Z, dst);
-
-        tcg_gen_movi_i32(cpu_cc_op, CC_OP_FLAGS);
-        dc->cc_op = CC_OP_FLAGS;
     }
 
     gen_store_gpr(dc, a->rd, dst);
@@ -3625,25 +3592,14 @@ static bool do_arith(DisasContext *dc, arg_r_r_ri *a,
                      void (*func)(TCGv, TCGv, TCGv),
                      void (*funci)(TCGv, TCGv, target_long))
 {
-    return do_cc_arith(dc, a, -1, func, funci);
-}
-
-static bool do_flags_arith(DisasContext *dc, arg_r_r_ri *a, int cc_op,
-                           void (*func)(TCGv, TCGv, TCGv))
-{
-    if (do_arith(dc, a, func, NULL)) {
-        tcg_gen_movi_i32(cpu_cc_op, cc_op);
-        dc->cc_op = cc_op;
-        return true;
-    }
-    return false;
+    return do_arith_int(dc, a, func, funci, false);
 }
 
 static bool do_logic_cc(DisasContext *dc, arg_r_r_ri *a,
                         void (*func)(TCGv, TCGv, TCGv),
                         void (*funci)(TCGv, TCGv, target_long))
 {
-    return do_cc_arith(dc, a, CC_OP_FLAGS, func, funci);
+    return do_arith_int(dc, a, func, funci, true);
 }
 
 static bool trans_OR(DisasContext *dc, arg_r_r_ri *a)
@@ -3683,25 +3639,30 @@ TRANS(UDIVX, 64, do_arith, a, gen_op_udivx, NULL)
 TRANS(SDIVX, 64, do_arith, a, gen_op_sdivx, NULL)
 TRANS(UDIV, DIV, do_arith, a, gen_op_udiv, NULL)
 TRANS(SDIV, DIV, do_arith, a, gen_op_sdiv, NULL)
+TRANS(ADDC, ALL, do_arith, a, gen_op_addc, NULL)
+TRANS(SUBC, ALL, do_arith, a, gen_op_subc, NULL)
 /* TODO: Should have feature bit -- comes in with UltraSparc T2. */
 TRANS(POPC, 64, do_arith, a, gen_op_popc, NULL)
 
-TRANS(ADDcc, ALL, do_flags_arith, a, CC_OP_FLAGS, gen_op_addcc)
+TRANS(ADDcc, ALL, do_arith, a, gen_op_addcc, NULL)
 TRANS(ANDcc, ALL, do_logic_cc, a, tcg_gen_and_tl, tcg_gen_andi_tl)
 TRANS(ORcc, ALL, do_logic_cc, a, tcg_gen_or_tl, tcg_gen_ori_tl)
 TRANS(XORcc, ALL, do_logic_cc, a, tcg_gen_xor_tl, tcg_gen_xori_tl)
-TRANS(SUBcc, ALL, do_flags_arith, a, CC_OP_FLAGS, gen_op_subcc)
+TRANS(SUBcc, ALL, do_arith, a, gen_op_subcc, NULL)
 TRANS(ANDNcc, ALL, do_logic_cc, a, tcg_gen_andc_tl, NULL)
 TRANS(ORNcc, ALL, do_logic_cc, a, tcg_gen_orc_tl, NULL)
 TRANS(XORNcc, ALL, do_logic_cc, a, tcg_gen_eqv_tl, NULL)
 TRANS(UMULcc, MUL, do_logic_cc, a, gen_op_umul, NULL)
 TRANS(SMULcc, MUL, do_logic_cc, a, gen_op_smul, NULL)
-TRANS(UDIVcc, DIV, do_flags_arith, a, CC_OP_FLAGS, gen_op_udivcc)
-TRANS(SDIVcc, DIV, do_flags_arith, a, CC_OP_FLAGS, gen_op_sdivcc)
-TRANS(TADDcc, ALL, do_flags_arith, a, CC_OP_FLAGS, gen_op_taddcc)
-TRANS(TSUBcc, ALL, do_flags_arith, a, CC_OP_FLAGS, gen_op_tsubcc)
-TRANS(TADDccTV, ALL, do_flags_arith, a, CC_OP_FLAGS, gen_op_taddcctv)
-TRANS(TSUBccTV, ALL, do_flags_arith, a, CC_OP_FLAGS, gen_op_tsubcctv)
+TRANS(UDIVcc, DIV, do_arith, a, gen_op_udivcc, NULL)
+TRANS(SDIVcc, DIV, do_arith, a, gen_op_sdivcc, NULL)
+TRANS(TADDcc, ALL, do_arith, a, gen_op_taddcc, NULL)
+TRANS(TSUBcc, ALL, do_arith, a, gen_op_tsubcc, NULL)
+TRANS(TADDccTV, ALL, do_arith, a, gen_op_taddcctv, NULL)
+TRANS(TSUBccTV, ALL, do_arith, a, gen_op_tsubcctv, NULL)
+TRANS(ADDCcc, ALL, do_arith, a, gen_op_addccc, NULL)
+TRANS(SUBCcc, ALL, do_arith, a, gen_op_subccc, NULL)
+TRANS(MULScc, ALL, do_arith, a, gen_op_mulscc, NULL)
 
 static TCGv gen_rs2_or_imm(DisasContext *dc, bool imm, int rs2_or_imm)
 {
@@ -3716,36 +3677,6 @@ static TCGv gen_rs2_or_imm(DisasContext *dc, bool imm, int rs2_or_imm)
     }
 }
 
-static bool trans_ADDC(DisasContext *dc, arg_r_r_ri *a)
-{
-    update_psr(dc);
-    return do_arith(dc, a, gen_op_addc, NULL);
-}
-
-static bool trans_ADDCcc(DisasContext *dc, arg_r_r_ri *a)
-{
-    update_psr(dc);
-    return do_flags_arith(dc, a, CC_OP_FLAGS, gen_op_addccc);
-}
-
-static bool trans_SUBC(DisasContext *dc, arg_r_r_ri *a)
-{
-    update_psr(dc);
-    return do_arith(dc, a, gen_op_subc, NULL);
-}
-
-static bool trans_SUBCcc(DisasContext *dc, arg_r_r_ri *a)
-{
-    update_psr(dc);
-    return do_flags_arith(dc, a, CC_OP_FLAGS, gen_op_subccc);
-}
-
-static bool trans_MULScc(DisasContext *dc, arg_r_r_ri *a)
-{
-    update_psr(dc);
-    return do_flags_arith(dc, a, CC_OP_FLAGS, gen_op_mulscc);
-}
-
 static bool gen_edge(DisasContext *dc, arg_r_r_r *a,
                      int width, bool cc, bool left)
 {
@@ -3759,8 +3690,6 @@ static bool gen_edge(DisasContext *dc, arg_r_r_r *a,
 
     if (cc) {
         gen_op_subcc(cpu_cc_N, s1, s2);
-        tcg_gen_movi_i32(cpu_cc_op, CC_OP_FLAGS);
-        dc->cc_op = CC_OP_FLAGS;
     }
 
     /*
@@ -5176,7 +5105,6 @@ static void sparc_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 
     dc->pc = dc->base.pc_first;
     dc->npc = (target_ulong)dc->base.tb->cs_base;
-    dc->cc_op = CC_OP_DYNAMIC;
     dc->mem_idx = dc->base.tb->flags & TB_FLAG_MMU_MASK;
     dc->def = &env->def;
     dc->fpu_enabled = tb_fpu_enabled(dc->base.tb->flags);
@@ -5371,7 +5299,6 @@ void sparc_tcg_init(void)
 #else
         { &cpu_wim, offsetof(CPUSPARCState, wim), "wim" },
 #endif
-        { &cpu_cc_op, offsetof(CPUSPARCState, cc_op), "cc_op" },
     };
 
     static const struct { TCGv *ptr; int off; const char *name; } rtl[] = {
@@ -5394,9 +5321,6 @@ void sparc_tcg_init(void)
         { &cpu_icc_Z, offsetof(CPUSPARCState, cc_icc_Z), "icc_Z" },
         { &cpu_icc_C, offsetof(CPUSPARCState, cc_icc_C), "icc_C" },
         { &cpu_cond, offsetof(CPUSPARCState, cond), "cond" },
-        { &cpu_cc_src, offsetof(CPUSPARCState, cc_src), "cc_src" },
-        { &cpu_cc_src2, offsetof(CPUSPARCState, cc_src2), "cc_src2" },
-        { &cpu_cc_dst, offsetof(CPUSPARCState, cc_dst), "cc_dst" },
         { &cpu_fsr, offsetof(CPUSPARCState, fsr), "fsr" },
         { &cpu_pc, offsetof(CPUSPARCState, pc), "pc" },
         { &cpu_npc, offsetof(CPUSPARCState, npc), "npc" },
diff --git a/target/sparc/win_helper.c b/target/sparc/win_helper.c
index a446c1785d..64e498ce2b 100644
--- a/target/sparc/win_helper.c
+++ b/target/sparc/win_helper.c
@@ -55,8 +55,6 @@ target_ulong cpu_get_psr(CPUSPARCState *env)
 {
     target_ulong icc = 0;
 
-    helper_compute_psr(env);
-
     icc |= ((int32_t)env->cc_N < 0) << PSR_NEG_SHIFT;
     icc |= ((int32_t)env->cc_V < 0) << PSR_OVF_SHIFT;
     icc |= ((int32_t)env->cc_icc_Z == 0) << PSR_ZERO_SHIFT;
@@ -102,7 +100,6 @@ void cpu_put_psr_raw(CPUSPARCState *env, target_ulong val)
     env->psrps = (val & PSR_PS) ? 1 : 0;
     env->psret = (val & PSR_ET) ? 1 : 0;
 #endif
-    env->cc_op = CC_OP_FLAGS;
 #if !defined(TARGET_SPARC64)
     cpu_set_cwp(env, val & PSR_CWP);
 #endif
@@ -271,8 +268,6 @@ target_ulong cpu_get_ccr(CPUSPARCState *env)
 {
     target_ulong ccr = 0;
 
-    helper_compute_psr(env);
-
     ccr |= (env->cc_icc_C >> 32) & 1;
     ccr |= ((int32_t)env->cc_V < 0) << 1;
     ccr |= ((int32_t)env->cc_icc_Z == 0) << 2;
@@ -294,8 +289,6 @@ void cpu_put_ccr(CPUSPARCState *env, target_ulong val)
     env->cc_xcc_C = (val >> 4) & 1;
     env->cc_icc_Z = ~val & 0x04;
     env->cc_xcc_Z = ~val & 0x40;
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


