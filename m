Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A5C7E3396
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:08:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CRX-0004Rc-Uo; Mon, 06 Nov 2023 22:07:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CRT-0004Fv-BV
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:07:51 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CRR-0001O2-1C
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:07:50 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-5bd33abbb90so2957813a12.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326467; x=1699931267; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=L8balSKIFrq7CCgbepi+cUgmlE/+RSHAIJJUFFitCVM=;
 b=eTTWXnfxSEmFiYjAnrheVKaWmCg8syPmpFTZUU+902XAlhxI8YkdorPxF7i93fgaNF
 IT0PyKVibIO0n9q1bsst6hKCaI9MBayKDSLQY9/9KoTNhreSxkysb6DFcDspQ/g3RVD3
 lTJruFQuaSytaRIs1MKDIMqnubL+cXMhbGwYW+cdcxzfcjOvOLWwDGFo2zZDsmQrhzEU
 YWJ8Y2eQRwqnvOUsSyJ8Sxgh+FAmVZZtXTnSkO/BoClA2gI8wkcYEZ7of0SCireceGff
 UED4nsxiCL/trLXY+X6bK1qXYo2k5bDOmlrF2uQnJV8GTBC+vmLZWJkjMqSqy5jxqe8B
 cNCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326467; x=1699931267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L8balSKIFrq7CCgbepi+cUgmlE/+RSHAIJJUFFitCVM=;
 b=EXmae3JT2z03R/e2I888SyZBct71VmPhFVtawcoE6oRx2yIW+LIEwhSuBx8fAsSlIc
 rvvVR4LvGoIIM2qIKtSEc+PZzjWZsW70DLHy4u/RAh4kjHdhJWJJw8zgAeiQFbD/XeNy
 MpD11gPnlMvYETjpnMfIEMeJQn7o0B3B6BaEelQEoCCsGyD3wEXhKkdboJSAaLc+t4BM
 A2RX21AKcIW6LZwBFu72pN0ZdcD3mWMY0qrqWxROYBkSuhsQfy7D/V2Y+RDP/u95Vg9K
 KsKXMapZdXgrMkVt1EfqJ7aIrLcqyhppiQ4hXZqlSJPQO+98a8hHS/ZlbIBfmIw+pOh0
 Ukmw==
X-Gm-Message-State: AOJu0YxEyhtnf/KCZiSCcjEpa7K+X2HyqnnnXvbdfCAM4cDvXv+5F3Nq
 AeCqOOrolHuOIUejZIJpTxHpaAUrCZf66/HUqpc=
X-Google-Smtp-Source: AGHT+IHZ0C83VxmvNybl1xGoNGJsatcbuzxYeJrqOy1BxVTprIlyzcq/9pakHii5+jwjXRIE+i8jHg==
X-Received: by 2002:a17:90b:4d83:b0:280:99ca:1611 with SMTP id
 oj3-20020a17090b4d8300b0028099ca1611mr16339267pjb.20.1699326467355; 
 Mon, 06 Nov 2023 19:07:47 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 13-20020a17090a004d00b0027782f611d1sm6744883pjb.36.2023.11.06.19.07.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:07:47 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 52/85] target/hppa: Implement STDBY
Date: Mon,  6 Nov 2023 19:03:34 -0800
Message-Id: <20231107030407.8979-53-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/helper.h     |   5 ++
 target/hppa/insns.decode |   1 +
 target/hppa/op_helper.c  | 178 +++++++++++++++++++++++++++++++++++++--
 target/hppa/translate.c  |  34 ++++++++
 4 files changed, 213 insertions(+), 5 deletions(-)

diff --git a/target/hppa/helper.h b/target/hppa/helper.h
index 647f043c85..9920d38ded 100644
--- a/target/hppa/helper.h
+++ b/target/hppa/helper.h
@@ -16,6 +16,11 @@ DEF_HELPER_FLAGS_3(stby_b_parallel, TCG_CALL_NO_WG, void, env, tl, tr)
 DEF_HELPER_FLAGS_3(stby_e, TCG_CALL_NO_WG, void, env, tl, tr)
 DEF_HELPER_FLAGS_3(stby_e_parallel, TCG_CALL_NO_WG, void, env, tl, tr)
 
+DEF_HELPER_FLAGS_3(stdby_b, TCG_CALL_NO_WG, void, env, tl, tr)
+DEF_HELPER_FLAGS_3(stdby_b_parallel, TCG_CALL_NO_WG, void, env, tl, tr)
+DEF_HELPER_FLAGS_3(stdby_e, TCG_CALL_NO_WG, void, env, tl, tr)
+DEF_HELPER_FLAGS_3(stdby_e_parallel, TCG_CALL_NO_WG, void, env, tl, tr)
+
 DEF_HELPER_FLAGS_1(ldc_check, TCG_CALL_NO_RWG, void, tl)
 
 DEF_HELPER_FLAGS_4(probe, TCG_CALL_NO_WG, tr, env, tl, i32, i32)
diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index ba7731b517..9d8c6a1a16 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -228,6 +228,7 @@ lda             000011 ..... ..... .. . 0 -- 0100      ......   @ldstx size=3
 sta             000011 ..... ..... .. . 1 -- 1110      ......   @stim5 size=2
 sta             000011 ..... ..... .. . 1 -- 1111      ......   @stim5 size=3
 stby            000011 b:5 r:5 sp:2 a:1 1 -- 1100 m:1   .....   disp=%im5_0
+stdby           000011 b:5 r:5 sp:2 a:1 1 -- 1101 m:1   .....   disp=%im5_0
 
 @fldstwx        ...... b:5 x:5   sp:2 scale:1 ....... m:1 ..... \
                 &ldst t=%rt64 disp=0 size=2
diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index 837e2b3117..b5b45f5120 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -56,11 +56,11 @@ void HELPER(tcond)(CPUHPPAState *env, target_ureg cond)
     }
 }
 
-static void atomic_store_3(CPUHPPAState *env, target_ulong addr,
-                           uint32_t val, uintptr_t ra)
+static void atomic_store_mask32(CPUHPPAState *env, target_ulong addr,
+                                uint32_t val, uint32_t mask, uintptr_t ra)
 {
     int mmu_idx = cpu_mmu_index(env, 0);
-    uint32_t old, new, cmp, mask, *haddr;
+    uint32_t old, new, cmp, *haddr;
     void *vaddr;
 
     vaddr = probe_access(env, addr, 3, MMU_DATA_STORE, mmu_idx, ra);
@@ -81,6 +81,35 @@ static void atomic_store_3(CPUHPPAState *env, target_ulong addr,
     }
 }
 
+static void atomic_store_mask64(CPUHPPAState *env, target_ulong addr,
+                                uint64_t val, uint64_t mask,
+                                int size, uintptr_t ra)
+{
+#ifdef CONFIG_ATOMIC64
+    int mmu_idx = cpu_mmu_index(env, 0);
+    uint64_t old, new, cmp, *haddr;
+    void *vaddr;
+
+    vaddr = probe_access(env, addr, size, MMU_DATA_STORE, mmu_idx, ra);
+    if (vaddr == NULL) {
+        cpu_loop_exit_atomic(env_cpu(env), ra);
+    }
+    haddr = (uint64_t *)((uintptr_t)vaddr & -8);
+
+    old = *haddr;
+    while (1) {
+        new = be32_to_cpu((cpu_to_be32(old) & ~mask) | (val & mask));
+        cmp = qatomic_cmpxchg__nocheck(haddr, old, new);
+        if (cmp == old) {
+            return;
+        }
+        old = cmp;
+    }
+#else
+    cpu_loop_exit_atomic(env_cpu(env), ra);
+#endif
+}
+
 static void do_stby_b(CPUHPPAState *env, target_ulong addr, target_ureg val,
                       bool parallel, uintptr_t ra)
 {
@@ -94,7 +123,7 @@ static void do_stby_b(CPUHPPAState *env, target_ulong addr, target_ureg val,
     case 1:
         /* The 3 byte store must appear atomic.  */
         if (parallel) {
-            atomic_store_3(env, addr, val, ra);
+            atomic_store_mask32(env, addr, val, 0x00ffffffu, ra);
         } else {
             cpu_stb_data_ra(env, addr, val >> 16, ra);
             cpu_stw_data_ra(env, addr + 1, val, ra);
@@ -106,6 +135,62 @@ static void do_stby_b(CPUHPPAState *env, target_ulong addr, target_ureg val,
     }
 }
 
+static void do_stdby_b(CPUHPPAState *env, target_ulong addr, uint64_t val,
+                       bool parallel, uintptr_t ra)
+{
+    switch (addr & 7) {
+    case 7:
+        cpu_stb_data_ra(env, addr, val, ra);
+        break;
+    case 6:
+        cpu_stw_data_ra(env, addr, val, ra);
+        break;
+    case 5:
+        /* The 3 byte store must appear atomic.  */
+        if (parallel) {
+            atomic_store_mask32(env, addr, val, 0x00ffffffu, ra);
+        } else {
+            cpu_stb_data_ra(env, addr, val >> 16, ra);
+            cpu_stw_data_ra(env, addr + 1, val, ra);
+        }
+        break;
+    case 4:
+        cpu_stl_data_ra(env, addr, val, ra);
+        break;
+    case 3:
+        /* The 5 byte store must appear atomic.  */
+        if (parallel) {
+            atomic_store_mask64(env, addr, val, 0x000000ffffffffffull, 5, ra);
+        } else {
+            cpu_stb_data_ra(env, addr, val >> 32, ra);
+            cpu_stl_data_ra(env, addr + 1, val, ra);
+        }
+        break;
+    case 2:
+        /* The 6 byte store must appear atomic.  */
+        if (parallel) {
+            atomic_store_mask64(env, addr, val, 0x0000ffffffffffffull, 6, ra);
+        } else {
+            cpu_stw_data_ra(env, addr, val >> 32, ra);
+            cpu_stl_data_ra(env, addr + 2, val, ra);
+        }
+        break;
+    case 1:
+        /* The 7 byte store must appear atomic.  */
+        if (parallel) {
+            atomic_store_mask64(env, addr, val, 0x00ffffffffffffffull, 7, ra);
+        } else {
+            cpu_stb_data_ra(env, addr, val >> 48, ra);
+            cpu_stw_data_ra(env, addr + 1, val >> 32, ra);
+            cpu_stl_data_ra(env, addr + 3, val, ra);
+        }
+        break;
+    default:
+        cpu_stq_data_ra(env, addr, val, ra);
+        break;
+    }
+}
+
 void HELPER(stby_b)(CPUHPPAState *env, target_ulong addr, target_ureg val)
 {
     do_stby_b(env, addr, val, false, GETPC());
@@ -117,6 +202,17 @@ void HELPER(stby_b_parallel)(CPUHPPAState *env, target_ulong addr,
     do_stby_b(env, addr, val, true, GETPC());
 }
 
+void HELPER(stdby_b)(CPUHPPAState *env, target_ulong addr, target_ureg val)
+{
+    do_stdby_b(env, addr, val, false, GETPC());
+}
+
+void HELPER(stdby_b_parallel)(CPUHPPAState *env, target_ulong addr,
+                              target_ureg val)
+{
+    do_stdby_b(env, addr, val, true, GETPC());
+}
+
 static void do_stby_e(CPUHPPAState *env, target_ulong addr, target_ureg val,
                       bool parallel, uintptr_t ra)
 {
@@ -124,7 +220,68 @@ static void do_stby_e(CPUHPPAState *env, target_ulong addr, target_ureg val,
     case 3:
         /* The 3 byte store must appear atomic.  */
         if (parallel) {
-            atomic_store_3(env, addr - 3, val, ra);
+            atomic_store_mask32(env, addr - 3, val, 0xffffff00u, ra);
+        } else {
+            cpu_stw_data_ra(env, addr - 3, val >> 16, ra);
+            cpu_stb_data_ra(env, addr - 1, val >> 8, ra);
+        }
+        break;
+    case 2:
+        cpu_stw_data_ra(env, addr - 2, val >> 16, ra);
+        break;
+    case 1:
+        cpu_stb_data_ra(env, addr - 1, val >> 24, ra);
+        break;
+    default:
+        /* Nothing is stored, but protection is checked and the
+           cacheline is marked dirty.  */
+        probe_write(env, addr, 0, cpu_mmu_index(env, 0), ra);
+        break;
+    }
+}
+
+static void do_stdby_e(CPUHPPAState *env, target_ulong addr, uint64_t val,
+                       bool parallel, uintptr_t ra)
+{
+    switch (addr & 7) {
+    case 7:
+        /* The 7 byte store must appear atomic.  */
+        if (parallel) {
+            atomic_store_mask64(env, addr - 7, val,
+                                0xffffffffffffff00ull, 7, ra);
+        } else {
+            cpu_stl_data_ra(env, addr - 7, val >> 32, ra);
+            cpu_stw_data_ra(env, addr - 3, val >> 16, ra);
+            cpu_stb_data_ra(env, addr - 1, val >> 8, ra);
+        }
+        break;
+    case 6:
+        /* The 6 byte store must appear atomic.  */
+        if (parallel) {
+            atomic_store_mask64(env, addr - 6, val,
+                                0xffffffffffff0000ull, 6, ra);
+        } else {
+            cpu_stl_data_ra(env, addr - 6, val >> 32, ra);
+            cpu_stw_data_ra(env, addr - 2, val >> 16, ra);
+        }
+        break;
+    case 5:
+        /* The 5 byte store must appear atomic.  */
+        if (parallel) {
+            atomic_store_mask64(env, addr - 5, val,
+                                0xffffffffff000000ull, 5, ra);
+        } else {
+            cpu_stl_data_ra(env, addr - 5, val >> 32, ra);
+            cpu_stb_data_ra(env, addr - 1, val >> 24, ra);
+        }
+        break;
+    case 4:
+        cpu_stl_data_ra(env, addr - 4, val >> 32, ra);
+        break;
+    case 3:
+        /* The 3 byte store must appear atomic.  */
+        if (parallel) {
+            atomic_store_mask32(env, addr - 3, val, 0xffffff00u, ra);
         } else {
             cpu_stw_data_ra(env, addr - 3, val >> 16, ra);
             cpu_stb_data_ra(env, addr - 1, val >> 8, ra);
@@ -155,6 +312,17 @@ void HELPER(stby_e_parallel)(CPUHPPAState *env, target_ulong addr,
     do_stby_e(env, addr, val, true, GETPC());
 }
 
+void HELPER(stdby_e)(CPUHPPAState *env, target_ulong addr, target_ureg val)
+{
+    do_stdby_e(env, addr, val, false, GETPC());
+}
+
+void HELPER(stdby_e_parallel)(CPUHPPAState *env, target_ulong addr,
+                              target_ureg val)
+{
+    do_stdby_e(env, addr, val, true, GETPC());
+}
+
 void HELPER(ldc_check)(target_ulong addr)
 {
     if (unlikely(addr & 0xf)) {
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 91249d89ca..485251bded 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3052,6 +3052,40 @@ static bool trans_stby(DisasContext *ctx, arg_stby *a)
     return nullify_end(ctx);
 }
 
+static bool trans_stdby(DisasContext *ctx, arg_stby *a)
+{
+    TCGv_reg ofs, val;
+    TCGv_tl addr;
+
+    if (!ctx->is_pa20) {
+        return false;
+    }
+    nullify_over(ctx);
+
+    form_gva(ctx, &addr, &ofs, a->b, 0, 0, a->disp, a->sp, a->m,
+             ctx->mmu_idx == MMU_PHYS_IDX);
+    val = load_gpr(ctx, a->r);
+    if (a->a) {
+        if (tb_cflags(ctx->base.tb) & CF_PARALLEL) {
+            gen_helper_stdby_e_parallel(tcg_env, addr, val);
+        } else {
+            gen_helper_stdby_e(tcg_env, addr, val);
+        }
+    } else {
+        if (tb_cflags(ctx->base.tb) & CF_PARALLEL) {
+            gen_helper_stdby_b_parallel(tcg_env, addr, val);
+        } else {
+            gen_helper_stdby_b(tcg_env, addr, val);
+        }
+    }
+    if (a->m) {
+        tcg_gen_andi_reg(ofs, ofs, ~7);
+        save_gpr(ctx, a->b, ofs);
+    }
+
+    return nullify_end(ctx);
+}
+
 static bool trans_lda(DisasContext *ctx, arg_ldst *a)
 {
     int hold_mmu_idx = ctx->mmu_idx;
-- 
2.34.1


