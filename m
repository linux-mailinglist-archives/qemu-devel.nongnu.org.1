Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B0179F86D
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 04:48:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgcM4-0000lz-VW; Wed, 13 Sep 2023 22:45:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgcLs-0000iy-2d
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 22:45:08 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgcLh-0000j2-Rw
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 22:45:07 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1c3d6d88231so4054835ad.0
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 19:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694659495; x=1695264295; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jEEh4dlXcMZXTegZfFPS/y1u/lJEPdmK8D/wY9+3VvI=;
 b=F+MeHOEQzmn+CIv2RGqJgOLRcfnHkWdJkFBpbMj2/FfAHvRdLT//7seKMdO9ZfLQV9
 QsLlKzsO5jZenWkJnnYRVyPIU4JF7Dfkf8DBO32sB7v5xuouWKgZZx3LOhxt5Z1uP5RA
 J6LV+RW9rPz+4QG963OE+rE3Riyf0z+Bx6tyWlvPEHC8x5TRBeVBKX71eVYZ5CINjvOn
 saZ9eVCwbgUHW6YVDdV/1fVg7lGOvvfyTUaufuCCjm3rUFxnzmR3GNR+/lIe+BTxVSBZ
 gTklPFnXs2pBQRhvghV1Gfu3VVmNkkIQQS2gqjX4kdMV2rbbB0TvQvT8YQ2MqYZQyKXq
 O77w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694659495; x=1695264295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jEEh4dlXcMZXTegZfFPS/y1u/lJEPdmK8D/wY9+3VvI=;
 b=HSR5LezWgPT9sTJQmDoMH1Ssdr0/jsDNbUiEJ9dDNJsQQrEjBlP7m8RQE55nUZLwzI
 +GvEjXsh4DIWpp4qUUMsnayqVAsXwhIwj02ndirg9eKLR5qpDZqPgJBkzWIJdywHZaEE
 6MdNmW9ISR5kA+PjTAmz8cUho9F1d+vxg/tTZWhXOzZu1NSOp587sOi0bRd0gig+e/BC
 euoyX/UKkawKuFLxxVTXEqwwDsbQVkEXT36MoPLcAv4nFsnLXV8FmO76c8Km9gaarer7
 JrY1ur+R75yaTEWce173FDdCUokdYFM9q9T/1tOMBcmAqAA+YqgMJfbqmg83F1+TQ6sH
 heHw==
X-Gm-Message-State: AOJu0YxrMrGbHiH2MZ1R+uc9A9iqDnbit4t1fBk1VbUW0H+dVmUvcwmU
 jgUlReFNFE7aYboZdXzh7y+eZkx28L8pYiEIc6E=
X-Google-Smtp-Source: AGHT+IF4RBexaXM9yeRgP9ttBx+6Z8SGq0+a/sB3tl6rIwDv867/w82+jJt9000wfpmAQRj9RpWyhg==
X-Received: by 2002:a17:902:f690:b0:1bd:ea88:7b93 with SMTP id
 l16-20020a170902f69000b001bdea887b93mr4973230plg.54.1694659495104; 
 Wed, 13 Sep 2023 19:44:55 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 x24-20020a170902b41800b001bbdf32f011sm304336plr.269.2023.09.13.19.44.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 19:44:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng,
	ale@rev.ng,
	philmd@linaro.org
Subject: [PATCH v2 20/24] accel/tcg: Modify atomic_mmu_lookup() to use CPUState
Date: Wed, 13 Sep 2023 19:44:31 -0700
Message-Id: <20230914024435.1381329-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230914024435.1381329-1-richard.henderson@linaro.org>
References: <20230914024435.1381329-1-richard.henderson@linaro.org>
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

From: Anton Johansson <anjo@rev.ng>

The goal is to (in the future) allow for per-target compilation of
functions in atomic_template.h whilst atomic_mmu_lookup() and cputlb.c
are compiled once-per user- or system mode.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20230912153428.17816-7-anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
[rth: Use cpu->neg.tlb instead of cpu_tlb()]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/atomic_template.h | 20 ++++++++++++--------
 accel/tcg/cputlb.c          | 26 +++++++++++++-------------
 accel/tcg/user-exec.c       |  8 ++++----
 3 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/accel/tcg/atomic_template.h b/accel/tcg/atomic_template.h
index 84c08b1425..1dc2151daf 100644
--- a/accel/tcg/atomic_template.h
+++ b/accel/tcg/atomic_template.h
@@ -73,7 +73,8 @@ ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, abi_ptr addr,
                               ABI_TYPE cmpv, ABI_TYPE newv,
                               MemOpIdx oi, uintptr_t retaddr)
 {
-    DATA_TYPE *haddr = atomic_mmu_lookup(env, addr, oi, DATA_SIZE, retaddr);
+    DATA_TYPE *haddr = atomic_mmu_lookup(env_cpu(env), addr, oi,
+                                         DATA_SIZE, retaddr);
     DATA_TYPE ret;
 
 #if DATA_SIZE == 16
@@ -90,7 +91,8 @@ ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, abi_ptr addr,
 ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, abi_ptr addr, ABI_TYPE val,
                            MemOpIdx oi, uintptr_t retaddr)
 {
-    DATA_TYPE *haddr = atomic_mmu_lookup(env, addr, oi, DATA_SIZE, retaddr);
+    DATA_TYPE *haddr = atomic_mmu_lookup(env_cpu(env), addr, oi,
+                                         DATA_SIZE, retaddr);
     DATA_TYPE ret;
 
     ret = qatomic_xchg__nocheck(haddr, val);
@@ -104,7 +106,7 @@ ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, abi_ptr addr,            \
                         ABI_TYPE val, MemOpIdx oi, uintptr_t retaddr) \
 {                                                                   \
     DATA_TYPE *haddr, ret;                                          \
-    haddr = atomic_mmu_lookup(env, addr, oi, DATA_SIZE, retaddr);   \
+    haddr = atomic_mmu_lookup(env_cpu(env), addr, oi, DATA_SIZE, retaddr);   \
     ret = qatomic_##X(haddr, val);                                  \
     ATOMIC_MMU_CLEANUP;                                             \
     atomic_trace_rmw_post(env, addr, oi);                           \
@@ -135,7 +137,7 @@ ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, abi_ptr addr,            \
                         ABI_TYPE xval, MemOpIdx oi, uintptr_t retaddr) \
 {                                                                   \
     XDATA_TYPE *haddr, cmp, old, new, val = xval;                   \
-    haddr = atomic_mmu_lookup(env, addr, oi, DATA_SIZE, retaddr);   \
+    haddr = atomic_mmu_lookup(env_cpu(env), addr, oi, DATA_SIZE, retaddr);   \
     smp_mb();                                                       \
     cmp = qatomic_read__nocheck(haddr);                             \
     do {                                                            \
@@ -176,7 +178,8 @@ ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, abi_ptr addr,
                               ABI_TYPE cmpv, ABI_TYPE newv,
                               MemOpIdx oi, uintptr_t retaddr)
 {
-    DATA_TYPE *haddr = atomic_mmu_lookup(env, addr, oi, DATA_SIZE, retaddr);
+    DATA_TYPE *haddr = atomic_mmu_lookup(env_cpu(env), addr, oi,
+                                         DATA_SIZE, retaddr);
     DATA_TYPE ret;
 
 #if DATA_SIZE == 16
@@ -193,7 +196,8 @@ ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, abi_ptr addr,
 ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, abi_ptr addr, ABI_TYPE val,
                            MemOpIdx oi, uintptr_t retaddr)
 {
-    DATA_TYPE *haddr = atomic_mmu_lookup(env, addr, oi, DATA_SIZE, retaddr);
+    DATA_TYPE *haddr = atomic_mmu_lookup(env_cpu(env), addr, oi,
+                                         DATA_SIZE, retaddr);
     ABI_TYPE ret;
 
     ret = qatomic_xchg__nocheck(haddr, BSWAP(val));
@@ -207,7 +211,7 @@ ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, abi_ptr addr,            \
                         ABI_TYPE val, MemOpIdx oi, uintptr_t retaddr) \
 {                                                                   \
     DATA_TYPE *haddr, ret;                                          \
-    haddr = atomic_mmu_lookup(env, addr, oi, DATA_SIZE, retaddr);   \
+    haddr = atomic_mmu_lookup(env_cpu(env), addr, oi, DATA_SIZE, retaddr);   \
     ret = qatomic_##X(haddr, BSWAP(val));                           \
     ATOMIC_MMU_CLEANUP;                                             \
     atomic_trace_rmw_post(env, addr, oi);                           \
@@ -235,7 +239,7 @@ ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, abi_ptr addr,            \
                         ABI_TYPE xval, MemOpIdx oi, uintptr_t retaddr) \
 {                                                                   \
     XDATA_TYPE *haddr, ldo, ldn, old, new, val = xval;              \
-    haddr = atomic_mmu_lookup(env, addr, oi, DATA_SIZE, retaddr);   \
+    haddr = atomic_mmu_lookup(env_cpu(env), addr, oi, DATA_SIZE, retaddr);   \
     smp_mb();                                                       \
     ldn = qatomic_read__nocheck(haddr);                             \
     do {                                                            \
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 29c35bd201..fcd13d522e 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1936,7 +1936,7 @@ static bool mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
  * Probe for an atomic operation.  Do not allow unaligned operations,
  * or io operations to proceed.  Return the host address.
  */
-static void *atomic_mmu_lookup(CPUArchState *env, vaddr addr, MemOpIdx oi,
+static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
                                int size, uintptr_t retaddr)
 {
     uintptr_t mmu_idx = get_mmuidx(oi);
@@ -1956,7 +1956,7 @@ static void *atomic_mmu_lookup(CPUArchState *env, vaddr addr, MemOpIdx oi,
     /* Enforce guest required alignment.  */
     if (unlikely(a_bits > 0 && (addr & ((1 << a_bits) - 1)))) {
         /* ??? Maybe indicate atomic op to cpu_unaligned_access */
-        cpu_unaligned_access(env_cpu(env), addr, MMU_DATA_STORE,
+        cpu_unaligned_access(cpu, addr, MMU_DATA_STORE,
                              mmu_idx, retaddr);
     }
 
@@ -1969,18 +1969,18 @@ static void *atomic_mmu_lookup(CPUArchState *env, vaddr addr, MemOpIdx oi,
         goto stop_the_world;
     }
 
-    index = tlb_index(env_cpu(env), mmu_idx, addr);
-    tlbe = tlb_entry(env_cpu(env), mmu_idx, addr);
+    index = tlb_index(cpu, mmu_idx, addr);
+    tlbe = tlb_entry(cpu, mmu_idx, addr);
 
     /* Check TLB entry and enforce page permissions.  */
     tlb_addr = tlb_addr_write(tlbe);
     if (!tlb_hit(tlb_addr, addr)) {
-        if (!victim_tlb_hit(env_cpu(env), mmu_idx, index, MMU_DATA_STORE,
+        if (!victim_tlb_hit(cpu, mmu_idx, index, MMU_DATA_STORE,
                             addr & TARGET_PAGE_MASK)) {
-            tlb_fill(env_cpu(env), addr, size,
+            tlb_fill(cpu, addr, size,
                      MMU_DATA_STORE, mmu_idx, retaddr);
-            index = tlb_index(env_cpu(env), mmu_idx, addr);
-            tlbe = tlb_entry(env_cpu(env), mmu_idx, addr);
+            index = tlb_index(cpu, mmu_idx, addr);
+            tlbe = tlb_entry(cpu, mmu_idx, addr);
         }
         tlb_addr = tlb_addr_write(tlbe) & ~TLB_INVALID_MASK;
     }
@@ -1992,7 +1992,7 @@ static void *atomic_mmu_lookup(CPUArchState *env, vaddr addr, MemOpIdx oi,
      * but addr_read will only be -1 if PAGE_READ was unset.
      */
     if (unlikely(tlbe->addr_read == -1)) {
-        tlb_fill(env_cpu(env), addr, size, MMU_DATA_LOAD, mmu_idx, retaddr);
+        tlb_fill(cpu, addr, size, MMU_DATA_LOAD, mmu_idx, retaddr);
         /*
          * Since we don't support reads and writes to different
          * addresses, and we do have the proper page loaded for
@@ -2012,10 +2012,10 @@ static void *atomic_mmu_lookup(CPUArchState *env, vaddr addr, MemOpIdx oi,
     }
 
     hostaddr = (void *)((uintptr_t)addr + tlbe->addend);
-    full = &env_tlb(env)->d[mmu_idx].fulltlb[index];
+    full = &cpu->neg.tlb.d[mmu_idx].fulltlb[index];
 
     if (unlikely(tlb_addr & TLB_NOTDIRTY)) {
-        notdirty_write(env_cpu(env), addr, size, full, retaddr);
+        notdirty_write(cpu, addr, size, full, retaddr);
     }
 
     if (unlikely(tlb_addr & TLB_FORCE_SLOW)) {
@@ -2028,7 +2028,7 @@ static void *atomic_mmu_lookup(CPUArchState *env, vaddr addr, MemOpIdx oi,
             wp_flags |= BP_MEM_READ;
         }
         if (wp_flags) {
-            cpu_check_watchpoint(env_cpu(env), addr, size,
+            cpu_check_watchpoint(cpu, addr, size,
                                  full->attrs, wp_flags, retaddr);
         }
     }
@@ -2036,7 +2036,7 @@ static void *atomic_mmu_lookup(CPUArchState *env, vaddr addr, MemOpIdx oi,
     return hostaddr;
 
  stop_the_world:
-    cpu_loop_exit_atomic(env_cpu(env), retaddr);
+    cpu_loop_exit_atomic(cpu, retaddr);
 }
 
 /*
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index ab48cb41e4..d2daeafbab 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -1386,7 +1386,7 @@ uint64_t cpu_ldq_code_mmu(CPUArchState *env, abi_ptr addr,
 /*
  * Do not allow unaligned operations to proceed.  Return the host address.
  */
-static void *atomic_mmu_lookup(CPUArchState *env, vaddr addr, MemOpIdx oi,
+static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
                                int size, uintptr_t retaddr)
 {
     MemOp mop = get_memop(oi);
@@ -1395,15 +1395,15 @@ static void *atomic_mmu_lookup(CPUArchState *env, vaddr addr, MemOpIdx oi,
 
     /* Enforce guest required alignment.  */
     if (unlikely(addr & ((1 << a_bits) - 1))) {
-        cpu_loop_exit_sigbus(env_cpu(env), addr, MMU_DATA_STORE, retaddr);
+        cpu_loop_exit_sigbus(cpu, addr, MMU_DATA_STORE, retaddr);
     }
 
     /* Enforce qemu required alignment.  */
     if (unlikely(addr & (size - 1))) {
-        cpu_loop_exit_atomic(env_cpu(env), retaddr);
+        cpu_loop_exit_atomic(cpu, retaddr);
     }
 
-    ret = g2h(env_cpu(env), addr);
+    ret = g2h(cpu, addr);
     set_helper_retaddr(retaddr);
     return ret;
 }
-- 
2.34.1


