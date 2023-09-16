Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F647A32AA
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 23:43:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhd3c-0005Xz-I4; Sat, 16 Sep 2023 17:42:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhd2y-0005AO-D7
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 17:41:48 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhd2v-0000Sx-Li
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 17:41:48 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-57128297bd7so2090752eaf.0
 for <qemu-devel@nongnu.org>; Sat, 16 Sep 2023 14:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694900504; x=1695505304; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RvbFDtGLZivKyhzTWEmUTibtY/MIhWAoXf/kD9e6jJo=;
 b=ZFX6tegQ31+UtytKhaPOcxZdSjmUEzF4hMaR0xrUg5wV/AnUa4g+P4Gq5EXpaVvTjq
 IjEaDIFAhXPhIJuRf6ypW8hAy88LPJgSi4qw2RapJIOUvl//0+HDpDaAT860k29fVnBu
 f69MDUYkecJO9KMXIDmO+NvTRqjGV2O118vtkvCaCEtW2SnMoKyrbavBTvXYF98r33dv
 kbTM7vxaSPbs2AQHuPpZYwsIykIbN/sDA63OOzFcN4gT+cBRx2/0yZHXoxWexoVUY0ic
 CwNVd7oNEVpipX/hjdmlA1v9Sf4H0RXRpXQZNh+/JYNf317hUbVK+ZgViIuzdmmfKIHm
 HgPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694900504; x=1695505304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RvbFDtGLZivKyhzTWEmUTibtY/MIhWAoXf/kD9e6jJo=;
 b=X9PwXYodP0NXBNukQzjrBBnXEWDooBn8yvVBAy+Zvr8AJcg4yy+ewoTJMBa3a+R1bL
 n3uq1evI7ysXrJjeCBLfMK5I4NoVtiKh7Y/LOaFnNn/bomNzsH+RU40k++XWUJMTMFz8
 Cy6Zq98bh5Xj6wvkBdW87SXxFJtd9VYKQRXitSoJRMWfQBIKPYjFRNrCAMEXlFlOyVdH
 ZJIwUaDUbTn1I/g8hwnvfif7N5A0QFUlTGlrhfoVlg3vjRkMNji/EMS74Qu8jSivH81U
 ntJVwwiw/b84Hxraxh6eRMU7m9tSwFA1vX7URjCwffansP+balnjoWpjEQPGcZ0Fd30f
 AuXw==
X-Gm-Message-State: AOJu0YwOeUTTUw8tjhQIySi3rrxcOHE+ViPeU0aZuvRL/PVL+fX3IRg9
 3/yDHfCaHwH+h1uDW/yGuiF+bs7hr1fH08vKuDw=
X-Google-Smtp-Source: AGHT+IEBJYp/rh5CbIbN+Y+ou80rmO1KP0beQwDb+O+dEJsljzcELbuFpdx4ZOKhyJb94GKvcXULuA==
X-Received: by 2002:a05:6870:9728:b0:1d6:3b6d:f824 with SMTP id
 n40-20020a056870972800b001d63b6df824mr7072837oaq.36.1694900504294; 
 Sat, 16 Sep 2023 14:41:44 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 n21-20020aa79055000000b0068fde95aa93sm4871708pfo.135.2023.09.16.14.41.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Sep 2023 14:41:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	anjo@rev.ng
Subject: [PATCH v3 19/39] accel/tcg: Modify atomic_mmu_lookup() to use CPUState
Date: Sat, 16 Sep 2023 14:41:03 -0700
Message-Id: <20230916214123.525796-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916214123.525796-1-richard.henderson@linaro.org>
References: <20230916214123.525796-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2e.google.com
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


