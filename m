Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7834E7B7023
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 19:43:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnjF7-0008Tn-48; Tue, 03 Oct 2023 13:31:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjF1-0008ST-VM
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:31:31 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjEz-0007Vu-KY
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:31:27 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-690f7bf73ddso924234b3a.2
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 10:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696354283; x=1696959083; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RvbFDtGLZivKyhzTWEmUTibtY/MIhWAoXf/kD9e6jJo=;
 b=Ecnx/IWIK3hlca8pvBenaQhVORr+OJhlXnqzChgy++oLrW/qn8wxR2XyvSAoN7xkuw
 Eg8nCRqh9iwd2C1mq0NrNM9gcN6gAuxnZG7Nmmz0sseg2wbNtgkruPno1G596U9BFO4U
 ECmwcchvrq036BhWenNqVrZjnQJQU774pS5zl63rEZvbl2++0tMEEmjTRqY3ehy0kKbS
 67qz5ui6FMGUp2Nh/sZeSuA32iD51IY42pSXrOnR/5HCgxVjNO+odUAkemGXRZ87IwDa
 wOWGwSUEhZ3lPHtFZflW4wdzI8dRPjU4VFYtLqzo0DGKPAnvpxA8V1k8FFje7QzuQ65z
 xLLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696354283; x=1696959083;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RvbFDtGLZivKyhzTWEmUTibtY/MIhWAoXf/kD9e6jJo=;
 b=I1q+GGx58MgthZHn6GY6sPlFdZ9Ur8rkA+Brb6ZQrOCpnaYUokfD2PZ3fZb9gfYtC6
 FT59IKaaIhQl8nsPHm/i7ihi2GlcGoiSTpe0Y87vYYAVBq5KqkhuTbpGXDV3N98Qiwg4
 PdJx/Pa/LjQ0XsozQNj5m4r9GbvQ+DnPnS0caqRaya4jGyM9G+usmM+t5/G8w2nYadjf
 6fawX3O3LIKYJubnoVZr2I5DHM9uXS7egrZSf/WeeCKjCj7fCNwFlBGQcNb3CR6KyvLB
 vQLW8Ah6JZZxMALnADybuE6CANcCUXG6mr/HzNHns/FUK9CNpfhr4CU+1sGL/8SPb+Gp
 w+gQ==
X-Gm-Message-State: AOJu0YxZ8RJf45nLzSUfTuE1uvbDrmoDKmPqKJem5HGGXyB46t1Ob47+
 488imNraUk7VloAVuoQA7Izjqmh0itEhH3pcfoE=
X-Google-Smtp-Source: AGHT+IH5A3oWGWzdrsf6X0DRHqiGsrKiRyB7VAwvM+B9yu+9cZZoLu3/NupOhBmYVApUoYN/4XRTtQ==
X-Received: by 2002:a05:6a00:168a:b0:68c:4e22:8f78 with SMTP id
 k10-20020a056a00168a00b0068c4e228f78mr256349pfc.25.1696354283189; 
 Tue, 03 Oct 2023 10:31:23 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 n7-20020aa78a47000000b00692c5b1a731sm1620195pfa.186.2023.10.03.10.31.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 10:31:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 26/47] accel/tcg: Modify atomic_mmu_lookup() to use CPUState
Date: Tue,  3 Oct 2023 10:30:31 -0700
Message-Id: <20231003173052.1601813-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003173052.1601813-1-richard.henderson@linaro.org>
References: <20231003173052.1601813-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
index 0e4bc82294..3703443b5c 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1856,7 +1856,7 @@ static bool mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
  * Probe for an atomic operation.  Do not allow unaligned operations,
  * or io operations to proceed.  Return the host address.
  */
-static void *atomic_mmu_lookup(CPUArchState *env, vaddr addr, MemOpIdx oi,
+static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
                                int size, uintptr_t retaddr)
 {
     uintptr_t mmu_idx = get_mmuidx(oi);
@@ -1876,7 +1876,7 @@ static void *atomic_mmu_lookup(CPUArchState *env, vaddr addr, MemOpIdx oi,
     /* Enforce guest required alignment.  */
     if (unlikely(a_bits > 0 && (addr & ((1 << a_bits) - 1)))) {
         /* ??? Maybe indicate atomic op to cpu_unaligned_access */
-        cpu_unaligned_access(env_cpu(env), addr, MMU_DATA_STORE,
+        cpu_unaligned_access(cpu, addr, MMU_DATA_STORE,
                              mmu_idx, retaddr);
     }
 
@@ -1889,18 +1889,18 @@ static void *atomic_mmu_lookup(CPUArchState *env, vaddr addr, MemOpIdx oi,
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
@@ -1912,7 +1912,7 @@ static void *atomic_mmu_lookup(CPUArchState *env, vaddr addr, MemOpIdx oi,
      * but addr_read will only be -1 if PAGE_READ was unset.
      */
     if (unlikely(tlbe->addr_read == -1)) {
-        tlb_fill(env_cpu(env), addr, size, MMU_DATA_LOAD, mmu_idx, retaddr);
+        tlb_fill(cpu, addr, size, MMU_DATA_LOAD, mmu_idx, retaddr);
         /*
          * Since we don't support reads and writes to different
          * addresses, and we do have the proper page loaded for
@@ -1932,10 +1932,10 @@ static void *atomic_mmu_lookup(CPUArchState *env, vaddr addr, MemOpIdx oi,
     }
 
     hostaddr = (void *)((uintptr_t)addr + tlbe->addend);
-    full = &env_tlb(env)->d[mmu_idx].fulltlb[index];
+    full = &cpu->neg.tlb.d[mmu_idx].fulltlb[index];
 
     if (unlikely(tlb_addr & TLB_NOTDIRTY)) {
-        notdirty_write(env_cpu(env), addr, size, full, retaddr);
+        notdirty_write(cpu, addr, size, full, retaddr);
     }
 
     if (unlikely(tlb_addr & TLB_FORCE_SLOW)) {
@@ -1948,7 +1948,7 @@ static void *atomic_mmu_lookup(CPUArchState *env, vaddr addr, MemOpIdx oi,
             wp_flags |= BP_MEM_READ;
         }
         if (wp_flags) {
-            cpu_check_watchpoint(env_cpu(env), addr, size,
+            cpu_check_watchpoint(cpu, addr, size,
                                  full->attrs, wp_flags, retaddr);
         }
     }
@@ -1956,7 +1956,7 @@ static void *atomic_mmu_lookup(CPUArchState *env, vaddr addr, MemOpIdx oi,
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


