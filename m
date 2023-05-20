Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C905C70A92E
	for <lists+qemu-devel@lfdr.de>; Sat, 20 May 2023 18:31:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0PQI-0003lC-S9; Sat, 20 May 2023 12:27:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q0PQA-0003fW-Gy
 for qemu-devel@nongnu.org; Sat, 20 May 2023 12:27:06 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q0PQ5-0003A3-0c
 for qemu-devel@nongnu.org; Sat, 20 May 2023 12:27:06 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-25372604818so1708213a91.2
 for <qemu-devel@nongnu.org>; Sat, 20 May 2023 09:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684600019; x=1687192019;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xmt+ITqZqh7I7gFJaXBYqdm/Oa0NR4029Dhdaw3mjBo=;
 b=WrCgOZf0ZCp6j36nn+TV8MLwdJxCa6t06XeLNlxv9AFquxR+mz95mTk39SCA8sarwG
 eCyGVl9K4d+qj4lDJu21piQ5UjaDOe6Zq6RD9esdfoLwaz5QXeeGsGVZC+bKqhhZuwHm
 mOOspHcn/WMG3mUdTIVzozxIw9VQYd1airni9ba6NVA7/lTH0Op7/6BR4nIHIu1sxgvE
 aEfPGFp4qJK3vJZYjGT6uMazfCi9fRLhddje0SPUc3VWcU5A95WK8h38NPftIdZn0bs/
 SJdo5HC/pWYIsMrSPiuEeHcmn/iiC4tnZxoooDfkOv1JAgO3LoEfsf+Bi/2K1nwRMfX5
 seLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684600019; x=1687192019;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xmt+ITqZqh7I7gFJaXBYqdm/Oa0NR4029Dhdaw3mjBo=;
 b=N44b4VLN1wJZqYrmsduRzGBUZVseJVPKHF/I1LwuIEBg4Rm93UKk5hrTAYcIlM0wIB
 Rbr72uHjUDzOMdqhHPKvXrkCZbJgxvAyZ/SK+gKDS9PqiZzIBP4lt6+qMiX1FKe8t9LM
 0m3j3T5agSddiM5K5CuGEPslj9zWplnEmxVwn31SQdWPWXUirSiSdxUFhKWhI5/wbSmH
 sP31zljYGmA2yi+6p6yYFvjyh18Xpp9yg02DAgntwYXcDu+asta5rMo/rrjwFhxbNWbM
 sBYzD8h2mqR35QsFEhZ4jM/OBtDf4c7cuJICnRU3Nq/Gku2JDyIIz+o6ciKZbGUs6g0S
 u0ig==
X-Gm-Message-State: AC+VfDwcoBS2ce6mMVu2XKJNz37EMGKiyCyTzX3ZyfXZTAxe8zwQSV81
 f2+UPVhA4SMWSw1v2D8ue/465uY1YLDTwa6w52g=
X-Google-Smtp-Source: ACHHUZ43/TTwB6P4ljMkvo1Xu+ef1x/RRQlAjQ7S2Q07+TuUd1udqXkg8vbq2Llhk1t424CUMOgk9Q==
X-Received: by 2002:a17:90a:d98f:b0:253:62c2:4e1b with SMTP id
 d15-20020a17090ad98f00b0025362c24e1bmr4953024pjv.48.1684600019387; 
 Sat, 20 May 2023 09:26:59 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:d078:d94e:cb2b:a055])
 by smtp.gmail.com with ESMTPSA id
 d12-20020a170903230c00b001a5260a6e6csm1697104plh.206.2023.05.20.09.26.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 May 2023 09:26:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 15/27] target/s390x: Use tcg_gen_qemu_{ld, st}_i128 for LPQ,
 STPQ
Date: Sat, 20 May 2023 09:26:22 -0700
Message-Id: <20230520162634.3991009-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230520162634.3991009-1-richard.henderson@linaro.org>
References: <20230520162634.3991009-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
Cc: qemu-s390x@nongnu.org
Cc: David Hildenbrand <david@redhat.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>
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


