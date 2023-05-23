Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6BC70E9F6
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 02:03:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1btm-0004Jb-Da; Tue, 23 May 2023 19:58:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1bth-0004H7-53
 for qemu-devel@nongnu.org; Tue, 23 May 2023 19:58:33 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1btU-0001oW-Cd
 for qemu-devel@nongnu.org; Tue, 23 May 2023 19:58:32 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-64a9335a8e7so99315b3a.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 16:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684886298; x=1687478298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qDyUFs0sCPOBnTeZd0UtyIPfkyRMGJGfSbxncKQ9k00=;
 b=zwm5gfOgRLXGIanGIPtENvhuq6GsicA6raVjz1fDehlaWoCl3IbS2wdwnF0btXOzCb
 pZCBwcF+0WDPjnV0/dKMFPe+YrZkOJZTV8WttlG975IEYDqGAs9rObvWIQv6is4/vTyI
 uhyhtgX/kbfqWBmED17TkZk/tIdnGCJEFoYPY5Aqxt03Ka5ErtTrsHbsorH2LedDfo4T
 vA410wojyZbUyQishAyAIfLodwl8ze51lWFq6dVmLzMPX5XgBS51e5ojYPmhM6lKkVu3
 X5YfA7rogudTN82JxaEFwyxSS2WzH/TA6fNOifEkqLHqxy8TitoMt5aCeMx9dH2Om+O3
 F7cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684886298; x=1687478298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qDyUFs0sCPOBnTeZd0UtyIPfkyRMGJGfSbxncKQ9k00=;
 b=BGOkA01atvUEaa6KZZGl3sRhUnt3TQ1GcZg4tU/l86lPti+/PbqRRoQs94kqRMtahx
 8O6v6ZkYCUS5/TK98rtc7hWbgu299YrBBAtwMhS53lnmXLXV0tFnvbDJojO8Jjy+Z+fq
 lQ+Hf3Ky3SwbLEW91501dcOORwoS+8Yw3QWxEBoOzx7rZBs//oMTKW4RT9YShtjInxg6
 uR1XES0/aQlCQUFy/ns7uq5Un+2DWwVcPu/HNiLu8V1xljlTpGbztOGDla0e3m8YSow8
 wUyEQ75FBgB13E5sllUlR9Cjg8kszUj7Pxs6c8nrmQZE2gwcfJBJvgh4baa7dpSHdkyj
 HxfA==
X-Gm-Message-State: AC+VfDzx9QASl/Qmjl5q4HMTBIAi4dr8S7k88SimwgaH+Ao6MD4Bixhx
 vf1jtPUSjLjSwKk4HAfqd0lPCPmKZnj+q5A1QeU=
X-Google-Smtp-Source: ACHHUZ728fTqW99pivFhjBxujafGa8W7N6HS9qicWQ2wa3z0CCg9QDqxYKN1wF9k+jpCVv/Efn7SDw==
X-Received: by 2002:a05:6a20:7f91:b0:ff:ca91:68ee with SMTP id
 d17-20020a056a207f9100b000ffca9168eemr16795724pzj.9.1684886297841; 
 Tue, 23 May 2023 16:58:17 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 p18-20020aa78612000000b0063b7c42a070sm6285041pfn.68.2023.05.23.16.58.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 16:58:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 14/28] target/ppc: Use tcg_gen_qemu_{ld, st}_i128 for LQARX, LQ,
 STQ
Date: Tue, 23 May 2023 16:57:50 -0700
Message-Id: <20230523235804.747803-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523235804.747803-1-richard.henderson@linaro.org>
References: <20230523235804.747803-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

No need to roll our own, as this is now provided by tcg.
This was the last use of retxl, so remove that too.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/cpu.h                           |  1 -
 target/ppc/helper.h                        |  9 ----
 target/ppc/mem_helper.c                    | 48 --------------------
 target/ppc/translate.c                     | 34 ++-------------
 target/ppc/translate/fixedpoint-impl.c.inc | 51 +++-------------------
 5 files changed, 11 insertions(+), 132 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 1c02596d9f..0f9f2e1a0c 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1124,7 +1124,6 @@ struct CPUArchState {
                            /* used to speed-up TLB assist handlers */
 
     target_ulong nip;      /* next instruction pointer */
-    uint64_t retxh;        /* high part of 128-bit helper return */
 
     /* when a memory exception occurs, the access type is stored here */
     int access_type;
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 0beaca5c7a..38efbc351c 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -810,12 +810,3 @@ DEF_HELPER_4(DSCLIQ, void, env, fprp, fprp, i32)
 
 DEF_HELPER_1(tbegin, void, env)
 DEF_HELPER_FLAGS_1(fixup_thrm, TCG_CALL_NO_RWG, void, env)
-
-#ifdef TARGET_PPC64
-DEF_HELPER_FLAGS_3(lq_le_parallel, TCG_CALL_NO_WG, i64, env, tl, i32)
-DEF_HELPER_FLAGS_3(lq_be_parallel, TCG_CALL_NO_WG, i64, env, tl, i32)
-DEF_HELPER_FLAGS_5(stq_le_parallel, TCG_CALL_NO_WG,
-                   void, env, tl, i64, i64, i32)
-DEF_HELPER_FLAGS_5(stq_be_parallel, TCG_CALL_NO_WG,
-                   void, env, tl, i64, i64, i32)
-#endif
diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index 1578887a8f..46eae65819 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -367,54 +367,6 @@ target_ulong helper_lscbx(CPUPPCState *env, target_ulong addr, uint32_t reg,
     return i;
 }
 
-#ifdef TARGET_PPC64
-uint64_t helper_lq_le_parallel(CPUPPCState *env, target_ulong addr,
-                               uint32_t opidx)
-{
-    Int128 ret;
-
-    /* We will have raised EXCP_ATOMIC from the translator.  */
-    assert(HAVE_ATOMIC128);
-    ret = cpu_atomic_ldo_le_mmu(env, addr, opidx, GETPC());
-    env->retxh = int128_gethi(ret);
-    return int128_getlo(ret);
-}
-
-uint64_t helper_lq_be_parallel(CPUPPCState *env, target_ulong addr,
-                               uint32_t opidx)
-{
-    Int128 ret;
-
-    /* We will have raised EXCP_ATOMIC from the translator.  */
-    assert(HAVE_ATOMIC128);
-    ret = cpu_atomic_ldo_be_mmu(env, addr, opidx, GETPC());
-    env->retxh = int128_gethi(ret);
-    return int128_getlo(ret);
-}
-
-void helper_stq_le_parallel(CPUPPCState *env, target_ulong addr,
-                            uint64_t lo, uint64_t hi, uint32_t opidx)
-{
-    Int128 val;
-
-    /* We will have raised EXCP_ATOMIC from the translator.  */
-    assert(HAVE_ATOMIC128);
-    val = int128_make128(lo, hi);
-    cpu_atomic_sto_le_mmu(env, addr, val, opidx, GETPC());
-}
-
-void helper_stq_be_parallel(CPUPPCState *env, target_ulong addr,
-                            uint64_t lo, uint64_t hi, uint32_t opidx)
-{
-    Int128 val;
-
-    /* We will have raised EXCP_ATOMIC from the translator.  */
-    assert(HAVE_ATOMIC128);
-    val = int128_make128(lo, hi);
-    cpu_atomic_sto_be_mmu(env, addr, val, opidx, GETPC());
-}
-#endif
-
 /*****************************************************************************/
 /* Altivec extension helpers */
 #if HOST_BIG_ENDIAN
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index f603f1a939..1720570b9b 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -3757,6 +3757,7 @@ static void gen_lqarx(DisasContext *ctx)
 {
     int rd = rD(ctx->opcode);
     TCGv EA, hi, lo;
+    TCGv_i128 t16;
 
     if (unlikely((rd & 1) || (rd == rA(ctx->opcode)) ||
                  (rd == rB(ctx->opcode)))) {
@@ -3772,36 +3773,9 @@ static void gen_lqarx(DisasContext *ctx)
     lo = cpu_gpr[rd + 1];
     hi = cpu_gpr[rd];
 
-    if (tb_cflags(ctx->base.tb) & CF_PARALLEL) {
-        if (HAVE_ATOMIC128) {
-            TCGv_i32 oi = tcg_temp_new_i32();
-            if (ctx->le_mode) {
-                tcg_gen_movi_i32(oi, make_memop_idx(MO_LE | MO_128 | MO_ALIGN,
-                                                    ctx->mem_idx));
-                gen_helper_lq_le_parallel(lo, cpu_env, EA, oi);
-            } else {
-                tcg_gen_movi_i32(oi, make_memop_idx(MO_BE | MO_128 | MO_ALIGN,
-                                                    ctx->mem_idx));
-                gen_helper_lq_be_parallel(lo, cpu_env, EA, oi);
-            }
-            tcg_gen_ld_i64(hi, cpu_env, offsetof(CPUPPCState, retxh));
-        } else {
-            /* Restart with exclusive lock.  */
-            gen_helper_exit_atomic(cpu_env);
-            ctx->base.is_jmp = DISAS_NORETURN;
-            return;
-        }
-    } else if (ctx->le_mode) {
-        tcg_gen_qemu_ld_i64(lo, EA, ctx->mem_idx, MO_LEUQ | MO_ALIGN_16);
-        tcg_gen_mov_tl(cpu_reserve, EA);
-        gen_addr_add(ctx, EA, EA, 8);
-        tcg_gen_qemu_ld_i64(hi, EA, ctx->mem_idx, MO_LEUQ);
-    } else {
-        tcg_gen_qemu_ld_i64(hi, EA, ctx->mem_idx, MO_BEUQ | MO_ALIGN_16);
-        tcg_gen_mov_tl(cpu_reserve, EA);
-        gen_addr_add(ctx, EA, EA, 8);
-        tcg_gen_qemu_ld_i64(lo, EA, ctx->mem_idx, MO_BEUQ);
-    }
+    t16 = tcg_temp_new_i128();
+    tcg_gen_qemu_ld_i128(t16, EA, ctx->mem_idx, DEF_MEMOP(MO_128 | MO_ALIGN));
+    tcg_gen_extr_i128_i64(lo, hi, t16);
 
     tcg_gen_st_tl(hi, cpu_env, offsetof(CPUPPCState, reserve_val));
     tcg_gen_st_tl(lo, cpu_env, offsetof(CPUPPCState, reserve_val2));
diff --git a/target/ppc/translate/fixedpoint-impl.c.inc b/target/ppc/translate/fixedpoint-impl.c.inc
index 02d86b77a8..f47f1a50e8 100644
--- a/target/ppc/translate/fixedpoint-impl.c.inc
+++ b/target/ppc/translate/fixedpoint-impl.c.inc
@@ -72,7 +72,7 @@ static bool do_ldst_quad(DisasContext *ctx, arg_D *a, bool store, bool prefixed)
 #if defined(TARGET_PPC64)
     TCGv ea;
     TCGv_i64 low_addr_gpr, high_addr_gpr;
-    MemOp mop;
+    TCGv_i128 t16;
 
     REQUIRE_INSNS_FLAGS(ctx, 64BX);
 
@@ -101,51 +101,14 @@ static bool do_ldst_quad(DisasContext *ctx, arg_D *a, bool store, bool prefixed)
         low_addr_gpr = cpu_gpr[a->rt + 1];
         high_addr_gpr = cpu_gpr[a->rt];
     }
+    t16 = tcg_temp_new_i128();
 
-    if (tb_cflags(ctx->base.tb) & CF_PARALLEL) {
-        if (HAVE_ATOMIC128) {
-            mop = DEF_MEMOP(MO_128);
-            TCGv_i32 oi = tcg_constant_i32(make_memop_idx(mop, ctx->mem_idx));
-            if (store) {
-                if (ctx->le_mode) {
-                    gen_helper_stq_le_parallel(cpu_env, ea, low_addr_gpr,
-                                               high_addr_gpr, oi);
-                } else {
-                    gen_helper_stq_be_parallel(cpu_env, ea, high_addr_gpr,
-                                               low_addr_gpr, oi);
-
-                }
-            } else {
-                if (ctx->le_mode) {
-                    gen_helper_lq_le_parallel(low_addr_gpr, cpu_env, ea, oi);
-                    tcg_gen_ld_i64(high_addr_gpr, cpu_env,
-                                   offsetof(CPUPPCState, retxh));
-                } else {
-                    gen_helper_lq_be_parallel(high_addr_gpr, cpu_env, ea, oi);
-                    tcg_gen_ld_i64(low_addr_gpr, cpu_env,
-                                   offsetof(CPUPPCState, retxh));
-                }
-            }
-        } else {
-            /* Restart with exclusive lock.  */
-            gen_helper_exit_atomic(cpu_env);
-            ctx->base.is_jmp = DISAS_NORETURN;
-        }
+    if (store) {
+        tcg_gen_concat_i64_i128(t16, low_addr_gpr, high_addr_gpr);
+        tcg_gen_qemu_st_i128(t16, ea, ctx->mem_idx, DEF_MEMOP(MO_128));
     } else {
-        mop = DEF_MEMOP(MO_UQ);
-        if (store) {
-            tcg_gen_qemu_st_i64(low_addr_gpr, ea, ctx->mem_idx, mop);
-        } else {
-            tcg_gen_qemu_ld_i64(low_addr_gpr, ea, ctx->mem_idx, mop);
-        }
-
-        gen_addr_add(ctx, ea, ea, 8);
-
-        if (store) {
-            tcg_gen_qemu_st_i64(high_addr_gpr, ea, ctx->mem_idx, mop);
-        } else {
-            tcg_gen_qemu_ld_i64(high_addr_gpr, ea, ctx->mem_idx, mop);
-        }
+        tcg_gen_qemu_ld_i128(t16, ea, ctx->mem_idx, DEF_MEMOP(MO_128));
+        tcg_gen_extr_i128_i64(low_addr_gpr, high_addr_gpr, t16);
     }
 #else
     qemu_build_not_reached();
-- 
2.34.1


