Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 963F57CEADF
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 00:01:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtEVc-000205-Fc; Wed, 18 Oct 2023 17:55:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEVZ-0001m7-4m
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:55:17 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEVW-00050X-S8
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:55:16 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6ccf6f4d852so1667053a34.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 14:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697666113; x=1698270913; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KAwDpLAGfIyH26tpyyPKP6Uouhfd60o6tt7/ZEef+tQ=;
 b=nhXY2lIYNkrkreEiEBU2x+fO+5WHi0tC7MBz6QQIn7xQ8AXgx1fTP+H7yv2NTbGpco
 MnO3OEju8fmIMoCxOC2e/ss02kxM9TxREzSpJcL8ugm9zFA7G8gYNSUadOKyN44aVaML
 WloaoPlaI8hw/s9SeC5mP4hfxfGpUKfAxtPHTWULowX4kWjq4R2gMJzHp9nDSbv6kG05
 GzHWw4Luh1y49P3Ftd91R5C1tyPcv0koRmyx3LfiXacWOy0GVQbhWl498VVCQ4rCvvW8
 bc2fZQFT1XJhUIpPn9+tu0+Jncg7/MkF1BcaSelixm+tBzh4qyGmyJvJ/M07lnHkp8IE
 BYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697666113; x=1698270913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KAwDpLAGfIyH26tpyyPKP6Uouhfd60o6tt7/ZEef+tQ=;
 b=VC4M5z7T2VKJQkkk1t7XhQVVHNf1k55ofVJ3GgHebTbU0zV9qex2BpgHpU2r9CcUSL
 u5Zy5Tm8X5LgoctBx0ywNYQ/z1BbP+TDDkdCbCH6aupEaVvjfIOmIWJUVercHVeOXVJ2
 okgf/0lMHWW3grDaGx8Ed0179HIwbAeMIRHunA0JzPjjNn21uN7+SQui1MdFTiEa6cWn
 we5mz1lq6ilbcGXG3Y01zNVn16TnkBTaPzYip6PatwROVBE/RdPav/YDpy4aTVNAXAc3
 +RoEmwhn+U7IoZfVMsJR8jMyB962Rl5ST+7WM/KUyO2Guj+qW+5dvp4SnEV5O40xQaxB
 AC1w==
X-Gm-Message-State: AOJu0YyrDtoZTQz00tdWm2U4GvV0hTNLeRqm/R8O7ozEd5NFd2WbBY7R
 6BtZMnbwGtZZZNiTYsGSRx64E1AZ4GOsovLRwa8=
X-Google-Smtp-Source: AGHT+IHqxzql8I+JXTnf7UdMGe84wk08SuxeHHJKILoqJKV7Ks4GOUDnd6Tsvjepvq8Ovo5S0/Xjvg==
X-Received: by 2002:a05:6830:d3:b0:6c0:7bab:3457 with SMTP id
 x19-20020a05683000d300b006c07bab3457mr622186oto.20.1697666113557; 
 Wed, 18 Oct 2023 14:55:13 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 r15-20020aa7962f000000b006889348ba6esm3796263pfg.127.2023.10.18.14.55.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 14:55:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 44/61] target/hppa: Implement STDBY
Date: Wed, 18 Oct 2023 14:51:18 -0700
Message-Id: <20231018215135.1561375-45-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018215135.1561375-1-richard.henderson@linaro.org>
References: <20231018215135.1561375-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32e.google.com
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
 target/hppa/helper.h     |   5 ++
 target/hppa/insns.decode |   1 +
 target/hppa/op_helper.c  | 178 +++++++++++++++++++++++++++++++++++++--
 target/hppa/translate.c  |  31 +++++++
 4 files changed, 210 insertions(+), 5 deletions(-)

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
index 837e2b3117..94c9ca5858 100644
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
+        cpu_stl_data_ra(env, addr, val, ra);
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
index 56c0a4fea1..4a0ae5a772 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3031,6 +3031,37 @@ static bool trans_stby(DisasContext *ctx, arg_stby *a)
     return nullify_end(ctx);
 }
 
+static bool trans_stdby(DisasContext *ctx, arg_stby *a)
+{
+    TCGv_reg ofs, val;
+    TCGv_tl addr;
+
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


