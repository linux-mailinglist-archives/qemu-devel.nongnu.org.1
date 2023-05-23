Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A53B670EA08
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 02:07:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1bu7-0004Nk-HT; Tue, 23 May 2023 19:58:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1bth-0004H6-1g
 for qemu-devel@nongnu.org; Tue, 23 May 2023 19:58:33 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1btU-0001lx-CS
 for qemu-devel@nongnu.org; Tue, 23 May 2023 19:58:32 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-64d4e45971bso103368b3a.2
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 16:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684886298; x=1687478298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jLExgig/sSvVFxDtwQ48pSfnJZWfkAOeqOv3WT/bVOU=;
 b=TEkpFkDkkS7h/xnsz+yHgeAlguY9+7RqVtgGql73cI224Y4rk8q1Q8J5PgEm0nkFAj
 nENN/UjUsjm9Vfc09uUTqLV0S07E1cV2b3LfBCjW8FUO/PuxV+AzCXzMoJj2xrnxNQh5
 sECn9W4NotWGu4Y1KfWj80j5hCEvFLMWlvFZbLTRfq7vJnr86hBbuVteiZU2NLpxhliW
 BiWMI1n73lFPmq9oaX3CLUuLYZSdf0c5BQSOrXWSpH04ftS3EGxUS/xBSefzLA7Q56Wj
 qF+ndR3OnPVvfI9dEGRVkD4xrmm+mZEz9oz9gXtYN9CnkVCP7ozetylyMdvPINRZVOo9
 csBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684886298; x=1687478298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jLExgig/sSvVFxDtwQ48pSfnJZWfkAOeqOv3WT/bVOU=;
 b=CTLiFbY/mWYEhc8GXII6eN/qN0HTEWR6Q92Ub81ihnrvsPOu+oDHWOg4IH2t4I9h0W
 jucqaT6ROxthOj02r+uncUG+6NA5uYMw5GQCT8PruND3WQ5luDowcUh5Qa9lC/0q3Rus
 cQLMPgRZuvOluQtGG1CqNXKikhrD7oVI34kObzRQ9llXDZ1cmsAZnmu9mn9Rp+QInrto
 ZZ08tGaP0KxkL+pwyOCVlj4NG+1buq7CcViO6KhWZpkf/jmmlnfYcZ6lvrhtOQPO+HJ/
 A/35uYL8JM0P78sYsBmWofYnfDak4vlgrvfcG2B0in/o/Ye6RdjXPwrR92ecv2L5gq42
 bTAQ==
X-Gm-Message-State: AC+VfDwRAzwZErmf3gpEG+yqdRLbAOvPnytW01p0BYXy2kFC+2G58xwr
 Bj/xEpwFC1tqbmVwOfPo6ADg6WlcjFPbcWEiAvU=
X-Google-Smtp-Source: ACHHUZ6fgE7Ra4zcxErjGVSyUiEeAEnhx5blR0ATS7i1cL9fVlLivmvwBOK7wAWRr3+XKsXVbTq5Cw==
X-Received: by 2002:a05:6a00:a1a:b0:64a:f8c9:a421 with SMTP id
 p26-20020a056a000a1a00b0064af8c9a421mr1021711pfh.32.1684886298549; 
 Tue, 23 May 2023 16:58:18 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 p18-20020aa78612000000b0063b7c42a070sm6285041pfn.68.2023.05.23.16.58.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 16:58:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Hildenbrand <david@redhat.com>
Subject: [PULL 15/28] target/s390x: Use tcg_gen_qemu_{ld, st}_i128 for LPQ,
 STPQ
Date: Tue, 23 May 2023 16:57:51 -0700
Message-Id: <20230523235804.747803-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523235804.747803-1-richard.henderson@linaro.org>
References: <20230523235804.747803-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/cpu.h               |  3 --
 target/s390x/helper.h            |  4 ---
 target/s390x/tcg/mem_helper.c    | 61 --------------------------------
 target/s390x/tcg/translate.c     | 30 +++++-----------
 target/s390x/tcg/insn-data.h.inc |  2 +-
 5 files changed, 9 insertions(+), 91 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index c47e7adcb1..f130c29f83 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -76,9 +76,6 @@ struct CPUArchState {
 
     float_status fpu_status; /* passed to softfloat lib */
 
-    /* The low part of a 128-bit return, or remainder of a divide.  */
-    uint64_t retxl;
-
     PSW psw;
 
     S390CrashReason crash_reason;
diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 341bc51ec2..7529e725f2 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -108,10 +108,6 @@ DEF_HELPER_FLAGS_2(sfas, TCG_CALL_NO_WG, void, env, i64)
 DEF_HELPER_FLAGS_2(srnm, TCG_CALL_NO_WG, void, env, i64)
 DEF_HELPER_FLAGS_1(popcnt, TCG_CALL_NO_RWG_SE, i64, i64)
 DEF_HELPER_2(stfle, i32, env, i64)
-DEF_HELPER_FLAGS_2(lpq, TCG_CALL_NO_WG, i64, env, i64)
-DEF_HELPER_FLAGS_2(lpq_parallel, TCG_CALL_NO_WG, i64, env, i64)
-DEF_HELPER_FLAGS_4(stpq, TCG_CALL_NO_WG, void, env, i64, i64, i64)
-DEF_HELPER_FLAGS_4(stpq_parallel, TCG_CALL_NO_WG, void, env, i64, i64, i64)
 DEF_HELPER_4(mvcos, i32, env, i64, i64, i64)
 DEF_HELPER_4(cu12, i32, env, i32, i32, i32)
 DEF_HELPER_4(cu14, i32, env, i32, i32, i32)
diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
index 8b58b8d88d..0e0d66b3b6 100644
--- a/target/s390x/tcg/mem_helper.c
+++ b/target/s390x/tcg/mem_helper.c
@@ -2398,67 +2398,6 @@ uint64_t HELPER(lra)(CPUS390XState *env, uint64_t addr)
 }
 #endif
 
-/* load pair from quadword */
-uint64_t HELPER(lpq)(CPUS390XState *env, uint64_t addr)
-{
-    uintptr_t ra = GETPC();
-    uint64_t hi, lo;
-
-    check_alignment(env, addr, 16, ra);
-    hi = cpu_ldq_data_ra(env, addr + 0, ra);
-    lo = cpu_ldq_data_ra(env, addr + 8, ra);
-
-    env->retxl = lo;
-    return hi;
-}
-
-uint64_t HELPER(lpq_parallel)(CPUS390XState *env, uint64_t addr)
-{
-    uintptr_t ra = GETPC();
-    uint64_t hi, lo;
-    int mem_idx;
-    MemOpIdx oi;
-    Int128 v;
-
-    assert(HAVE_ATOMIC128);
-
-    mem_idx = cpu_mmu_index(env, false);
-    oi = make_memop_idx(MO_TEUQ | MO_ALIGN_16, mem_idx);
-    v = cpu_atomic_ldo_be_mmu(env, addr, oi, ra);
-    hi = int128_gethi(v);
-    lo = int128_getlo(v);
-
-    env->retxl = lo;
-    return hi;
-}
-
-/* store pair to quadword */
-void HELPER(stpq)(CPUS390XState *env, uint64_t addr,
-                  uint64_t low, uint64_t high)
-{
-    uintptr_t ra = GETPC();
-
-    check_alignment(env, addr, 16, ra);
-    cpu_stq_data_ra(env, addr + 0, high, ra);
-    cpu_stq_data_ra(env, addr + 8, low, ra);
-}
-
-void HELPER(stpq_parallel)(CPUS390XState *env, uint64_t addr,
-                           uint64_t low, uint64_t high)
-{
-    uintptr_t ra = GETPC();
-    int mem_idx;
-    MemOpIdx oi;
-    Int128 v;
-
-    assert(HAVE_ATOMIC128);
-
-    mem_idx = cpu_mmu_index(env, false);
-    oi = make_memop_idx(MO_TEUQ | MO_ALIGN_16, mem_idx);
-    v = int128_make128(low, high);
-    cpu_atomic_sto_be_mmu(env, addr, v, oi, ra);
-}
-
 /* Execute instruction.  This instruction executes an insn modified with
    the contents of r1.  It does not change the executed instruction in memory;
    it does not change the program counter.
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index d6670e6a87..3eb3708d55 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -335,11 +335,6 @@ static void store_freg32_i64(int reg, TCGv_i64 v)
     tcg_gen_st32_i64(v, cpu_env, freg32_offset(reg));
 }
 
-static void return_low128(TCGv_i64 dest)
-{
-    tcg_gen_ld_i64(dest, cpu_env, offsetof(CPUS390XState, retxl));
-}
-
 static void update_psw_addr(DisasContext *s)
 {
     /* psw.addr */
@@ -3130,15 +3125,9 @@ static DisasJumpType op_lpd(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_lpq(DisasContext *s, DisasOps *o)
 {
-    if (!(tb_cflags(s->base.tb) & CF_PARALLEL)) {
-        gen_helper_lpq(o->out, cpu_env, o->in2);
-    } else if (HAVE_ATOMIC128) {
-        gen_helper_lpq_parallel(o->out, cpu_env, o->in2);
-    } else {
-        gen_helper_exit_atomic(cpu_env);
-        return DISAS_NORETURN;
-    }
-    return_low128(o->out2);
+    o->out_128 = tcg_temp_new_i128();
+    tcg_gen_qemu_ld_i128(o->out_128, o->in2, get_mem_index(s),
+                         MO_TE | MO_128 | MO_ALIGN);
     return DISAS_NEXT;
 }
 
@@ -4533,14 +4522,11 @@ static DisasJumpType op_stmh(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_stpq(DisasContext *s, DisasOps *o)
 {
-    if (!(tb_cflags(s->base.tb) & CF_PARALLEL)) {
-        gen_helper_stpq(cpu_env, o->in2, o->out2, o->out);
-    } else if (HAVE_ATOMIC128) {
-        gen_helper_stpq_parallel(cpu_env, o->in2, o->out2, o->out);
-    } else {
-        gen_helper_exit_atomic(cpu_env);
-        return DISAS_NORETURN;
-    }
+    TCGv_i128 t16 = tcg_temp_new_i128();
+
+    tcg_gen_concat_i64_i128(t16, o->out2, o->out);
+    tcg_gen_qemu_st_i128(t16, o->in2, get_mem_index(s),
+                         MO_TE | MO_128 | MO_ALIGN);
     return DISAS_NEXT;
 }
 
diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
index 1f1ac742a9..bcc70d99ba 100644
--- a/target/s390x/tcg/insn-data.h.inc
+++ b/target/s390x/tcg/insn-data.h.inc
@@ -570,7 +570,7 @@
     D(0xc804, LPD,     SSF,   ILA, 0, 0, new_P, r3_P32, lpd, 0, MO_TEUL)
     D(0xc805, LPDG,    SSF,   ILA, 0, 0, new_P, r3_P64, lpd, 0, MO_TEUQ)
 /* LOAD PAIR FROM QUADWORD */
-    C(0xe38f, LPQ,     RXY_a, Z,   0, a2, r1_P, 0, lpq, 0)
+    C(0xe38f, LPQ,     RXY_a, Z,   0, a2, 0, r1_D64, lpq, 0)
 /* LOAD POSITIVE */
     C(0x1000, LPR,     RR_a,  Z,   0, r2_32s, new, r1_32, abs, abs32)
     C(0xb900, LPGR,    RRE,   Z,   0, r2, r1, 0, abs, abs64)
-- 
2.34.1


