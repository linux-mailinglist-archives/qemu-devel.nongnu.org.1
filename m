Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D0BD28416FD
	for <lists+qemu-devel@lfdr.de>; Tue, 30 Jan 2024 00:38:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUb66-0005cd-Rv; Mon, 29 Jan 2024 18:31:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUb5h-0005RM-LU
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:31:05 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUb5e-00050y-JM
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:31:00 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1d51ba18e1bso31328505ad.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 15:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706571057; x=1707175857; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lgGnmjgbm65ABwN9XCrwoifbds3p9aO0+EYuonhmffg=;
 b=uku3NPlSWeKEC8FomPlFBNrHecgO5mjHWY2nSjsU1Lvse3XhlPdPq0LI9RUxVG7/4c
 yhZ2pP3zvDrk+OjI70t2wZWeeuV3tJ2vTZTcCxL5kfKtXd7F7mdjSn7CwoFb3vKq6PYM
 XCJGqXVXjyymyTgd7+HkzZqWYMVAYcU58lSUDNVCTb/wQLHQ0CKgs1B/B7ywGL8/0zey
 W5cFu3j0P6OLkcLsVmfVSy1jJEchUPVbnVaarj4Vh/UrRIAYbVPE4kgdgXEEp2UbYVZC
 M3MYDKh6BF7QFVJJPLEWWzUxzqXjVO8jR8iYmHu8GlAIPrpJEcnEulXopcGA4NBbbNWl
 uYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706571057; x=1707175857;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lgGnmjgbm65ABwN9XCrwoifbds3p9aO0+EYuonhmffg=;
 b=DirFnAEGIHu1OfvfBWpvc8K9YpKuJ6L8+nkViPnwjLT9dyFuJa1NN5uAzwB1+FgqMC
 xYGgpS98sjWIoOYCmGJrIAPanGolbtek+wihjXwkAZSSxBuK+TlrJs773oJq01VWzsZi
 q4UgCvnR94VPYdi9ABYNHvCDhroDJ2mNNrJ+lPmFeqtD426ANPSYg+7kAbhZC//jhads
 hboxQlpWwPXqP9uOt+FIV3DoIw5ePDev8xC5MHSBcfZsL05T0N9yEOIuUb+Gr6Q+t7mw
 1OqdjLCl449q0TJ+60CRCAQBeZboETQ2Que/B5U5cyWunVQlwaiO2atTl2fk3+xXIbt/
 i/nA==
X-Gm-Message-State: AOJu0YwQdAw0AjYpnHHA0wPn3x1XNermG/d1XOv4/txj7xudi0UVZrvk
 qVxXm280AtNszK/dsXMVS+lzs77PImxUW7vhVpvAITY9eLq1QhlFr9gn5u4UjilTbUeDKEiZ9O6
 7nZg=
X-Google-Smtp-Source: AGHT+IFsv+4o4EQvixLjxFxIuR9Arqu2C7qd/ohgjPO02aKUnfBrXHVlroh1PbfDNjzPrBKoHzk1/Q==
X-Received: by 2002:a17:902:6849:b0:1d8:f106:cb92 with SMTP id
 f9-20020a170902684900b001d8f106cb92mr1944300pln.10.1706571057142; 
 Mon, 29 Jan 2024 15:30:57 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 l6-20020a170902eb0600b001d8dbb867b1sm2710591plb.179.2024.01.29.15.30.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 15:30:56 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	anjo@rev.ng
Subject: [PATCH 04/33] target/arm: Split out arm_env_mmu_index
Date: Tue, 30 Jan 2024 09:30:14 +1000
Message-Id: <20240129233043.34558-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129233043.34558-1-richard.henderson@linaro.org>
References: <20240129233043.34558-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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
 target/arm/internals.h      |  5 +++++
 target/arm/helper.c         |  2 +-
 target/arm/tcg/helper-a64.c |  4 ++--
 target/arm/tcg/mte_helper.c | 18 +++++++++---------
 target/arm/tcg/sve_helper.c |  8 ++++----
 target/arm/tcg/tlb_helper.c |  2 +-
 6 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 71d6c70bf3..fc337fe40e 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -40,6 +40,11 @@
 #define BANK_HYP    6
 #define BANK_MON    7
 
+static inline int arm_env_mmu_index(CPUARMState *env)
+{
+    return EX_TBFLAG_ANY(env->hflags, MMUIDX);
+}
+
 static inline bool excp_is_internal(int excp)
 {
     /* Return true if this exception number represents a QEMU-internal
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 945d8571a6..b0488caf40 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7841,7 +7841,7 @@ static void dccvap_writefn(CPUARMState *env, const ARMCPRegInfo *opaque,
     uint64_t vaddr_in = (uint64_t) value;
     uint64_t vaddr = vaddr_in & ~(dline_size - 1);
     void *haddr;
-    int mem_idx = cpu_mmu_index(env, false);
+    int mem_idx = arm_env_mmu_index(env);
 
     /* This won't be crossing page boundaries */
     haddr = probe_read(env, vaddr, dline_size, mem_idx, GETPC());
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 198b975f20..ebaa7f00df 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -856,7 +856,7 @@ void HELPER(exception_return)(CPUARMState *env, uint64_t new_pc)
         tbii = EX_TBFLAG_A64(env->hflags, TBII);
         if ((tbii >> extract64(new_pc, 55, 1)) & 1) {
             /* TBI is enabled. */
-            int core_mmu_idx = cpu_mmu_index(env, false);
+            int core_mmu_idx = arm_env_mmu_index(env);
             if (regime_has_2_ranges(core_to_aa64_mmu_idx(core_mmu_idx))) {
                 new_pc = sextract64(new_pc, 0, 56);
             } else {
@@ -925,7 +925,7 @@ void HELPER(dc_zva)(CPUARMState *env, uint64_t vaddr_in)
      */
     int blocklen = 4 << env_archcpu(env)->dcz_blocksize;
     uint64_t vaddr = vaddr_in & ~(blocklen - 1);
-    int mmu_idx = cpu_mmu_index(env, false);
+    int mmu_idx = arm_env_mmu_index(env);
     void *mem;
 
     /*
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index ffb8ea1c34..d971b81370 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -291,7 +291,7 @@ static int load_tag1(uint64_t ptr, uint8_t *mem)
 
 uint64_t HELPER(ldg)(CPUARMState *env, uint64_t ptr, uint64_t xt)
 {
-    int mmu_idx = cpu_mmu_index(env, false);
+    int mmu_idx = arm_env_mmu_index(env);
     uint8_t *mem;
     int rtag = 0;
 
@@ -311,7 +311,7 @@ static void check_tag_aligned(CPUARMState *env, uint64_t ptr, uintptr_t ra)
 {
     if (unlikely(!QEMU_IS_ALIGNED(ptr, TAG_GRANULE))) {
         arm_cpu_do_unaligned_access(env_cpu(env), ptr, MMU_DATA_STORE,
-                                    cpu_mmu_index(env, false), ra);
+                                    arm_env_mmu_index(env), ra);
         g_assert_not_reached();
     }
 }
@@ -344,7 +344,7 @@ typedef void stg_store1(uint64_t, uint8_t *, int);
 static inline void do_stg(CPUARMState *env, uint64_t ptr, uint64_t xt,
                           uintptr_t ra, stg_store1 store1)
 {
-    int mmu_idx = cpu_mmu_index(env, false);
+    int mmu_idx = arm_env_mmu_index(env);
     uint8_t *mem;
 
     check_tag_aligned(env, ptr, ra);
@@ -371,7 +371,7 @@ void HELPER(stg_parallel)(CPUARMState *env, uint64_t ptr, uint64_t xt)
 
 void HELPER(stg_stub)(CPUARMState *env, uint64_t ptr)
 {
-    int mmu_idx = cpu_mmu_index(env, false);
+    int mmu_idx = arm_env_mmu_index(env);
     uintptr_t ra = GETPC();
 
     check_tag_aligned(env, ptr, ra);
@@ -381,7 +381,7 @@ void HELPER(stg_stub)(CPUARMState *env, uint64_t ptr)
 static inline void do_st2g(CPUARMState *env, uint64_t ptr, uint64_t xt,
                            uintptr_t ra, stg_store1 store1)
 {
-    int mmu_idx = cpu_mmu_index(env, false);
+    int mmu_idx = arm_env_mmu_index(env);
     int tag = allocation_tag_from_addr(xt);
     uint8_t *mem1, *mem2;
 
@@ -429,7 +429,7 @@ void HELPER(st2g_parallel)(CPUARMState *env, uint64_t ptr, uint64_t xt)
 
 void HELPER(st2g_stub)(CPUARMState *env, uint64_t ptr)
 {
-    int mmu_idx = cpu_mmu_index(env, false);
+    int mmu_idx = arm_env_mmu_index(env);
     uintptr_t ra = GETPC();
     int in_page = -(ptr | TARGET_PAGE_MASK);
 
@@ -445,7 +445,7 @@ void HELPER(st2g_stub)(CPUARMState *env, uint64_t ptr)
 
 uint64_t HELPER(ldgm)(CPUARMState *env, uint64_t ptr)
 {
-    int mmu_idx = cpu_mmu_index(env, false);
+    int mmu_idx = arm_env_mmu_index(env);
     uintptr_t ra = GETPC();
     int gm_bs = env_archcpu(env)->gm_blocksize;
     int gm_bs_bytes = 4 << gm_bs;
@@ -505,7 +505,7 @@ uint64_t HELPER(ldgm)(CPUARMState *env, uint64_t ptr)
 
 void HELPER(stgm)(CPUARMState *env, uint64_t ptr, uint64_t val)
 {
-    int mmu_idx = cpu_mmu_index(env, false);
+    int mmu_idx = arm_env_mmu_index(env);
     uintptr_t ra = GETPC();
     int gm_bs = env_archcpu(env)->gm_blocksize;
     int gm_bs_bytes = 4 << gm_bs;
@@ -555,7 +555,7 @@ void HELPER(stgm)(CPUARMState *env, uint64_t ptr, uint64_t val)
 void HELPER(stzgm_tags)(CPUARMState *env, uint64_t ptr, uint64_t val)
 {
     uintptr_t ra = GETPC();
-    int mmu_idx = cpu_mmu_index(env, false);
+    int mmu_idx = arm_env_mmu_index(env);
     int log2_dcz_bytes, log2_tag_bytes;
     intptr_t dcz_bytes, tag_bytes;
     uint8_t *mem;
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index f006d152cc..bce4295d28 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -5481,7 +5481,7 @@ bool sve_cont_ldst_pages(SVEContLdSt *info, SVEContFault fault,
                          CPUARMState *env, target_ulong addr,
                          MMUAccessType access_type, uintptr_t retaddr)
 {
-    int mmu_idx = cpu_mmu_index(env, false);
+    int mmu_idx = arm_env_mmu_index(env);
     int mem_off = info->mem_off_first[0];
     bool nofault = fault == FAULT_NO;
     bool have_work = true;
@@ -6529,7 +6529,7 @@ void sve_ld1_z(CPUARMState *env, void *vd, uint64_t *vg, void *vm,
                sve_ldst1_host_fn *host_fn,
                sve_ldst1_tlb_fn *tlb_fn)
 {
-    const int mmu_idx = cpu_mmu_index(env, false);
+    const int mmu_idx = arm_env_mmu_index(env);
     const intptr_t reg_max = simd_oprsz(desc);
     const int scale = simd_data(desc);
     ARMVectorReg scratch;
@@ -6715,7 +6715,7 @@ void sve_ldff1_z(CPUARMState *env, void *vd, uint64_t *vg, void *vm,
                  sve_ldst1_host_fn *host_fn,
                  sve_ldst1_tlb_fn *tlb_fn)
 {
-    const int mmu_idx = cpu_mmu_index(env, false);
+    const int mmu_idx = arm_env_mmu_index(env);
     const intptr_t reg_max = simd_oprsz(desc);
     const int scale = simd_data(desc);
     const int esize = 1 << esz;
@@ -6920,7 +6920,7 @@ void sve_st1_z(CPUARMState *env, void *vd, uint64_t *vg, void *vm,
                sve_ldst1_host_fn *host_fn,
                sve_ldst1_tlb_fn *tlb_fn)
 {
-    const int mmu_idx = cpu_mmu_index(env, false);
+    const int mmu_idx = arm_env_mmu_index(env);
     const intptr_t reg_max = simd_oprsz(desc);
     const int scale = simd_data(desc);
     void *host[ARM_MAX_VQ * 4];
diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
index 5477c7fb7d..885bf4ec14 100644
--- a/target/arm/tcg/tlb_helper.c
+++ b/target/arm/tcg/tlb_helper.c
@@ -281,7 +281,7 @@ void helper_exception_pc_alignment(CPUARMState *env, target_ulong pc)
 {
     ARMMMUFaultInfo fi = { .type = ARMFault_Alignment };
     int target_el = exception_target_el(env);
-    int mmu_idx = cpu_mmu_index(env, true);
+    int mmu_idx = arm_env_mmu_index(env);
     uint32_t fsc;
 
     env->exception.vaddress = pc;
-- 
2.34.1


