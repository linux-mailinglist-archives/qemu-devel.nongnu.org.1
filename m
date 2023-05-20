Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E492370A923
	for <lists+qemu-devel@lfdr.de>; Sat, 20 May 2023 18:29:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0PQR-0003tv-Om; Sat, 20 May 2023 12:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q0PQG-0003jd-SW
 for qemu-devel@nongnu.org; Sat, 20 May 2023 12:27:12 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q0PQ8-000340-P2
 for qemu-devel@nongnu.org; Sat, 20 May 2023 12:27:11 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1ae50da739dso29710025ad.1
 for <qemu-devel@nongnu.org>; Sat, 20 May 2023 09:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684600024; x=1687192024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b4QbT7Qp39kM9Wky+d26o1epuHAtvA7Ubq3UboPhQe0=;
 b=hOev8R87druHwFEKlgebrKd4480KKxlTBTo+c9cvTcJj4nL3vbUhYBaS5MhLolttI/
 1ZzDQMrST1ZegTPkHgLsr2eTsc5FrbK6v655V4nlUQ0MQVNPtNzpvH2ikLFDJJINC4G1
 HydPzwWf+GiMDYYUTEirU6XJktpJ3DUGQk/V3POJOAbqpKD6I0EWC/o1RygzyoDhuo9H
 WKn3TfCvzx2t5ab42MYUH5ZOJfPYdA2e0CMjY91rjGoGR+KlUZTRRpaYeYHuFIavxUX9
 E/fXcis/mP2S1RDOk+bBHVV5hNfjy6J7aC8a2/iKyJXpZaHG9k2oZALemRO7mkrkXo7S
 ORjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684600024; x=1687192024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b4QbT7Qp39kM9Wky+d26o1epuHAtvA7Ubq3UboPhQe0=;
 b=kfjOHSpdjK2TYzYP+2q1G/+1eZ9ciyzVoGMKGgcYBUJkFwaJYJNNzQ9WsuY/QnYuAQ
 pJqwb4jYLl0JYAShNbwuuL/vLh5CqVrYBrcBOw5HZCm5yQ7NBk1QIJ43Oat2yLbviz2Q
 bmhreRO9vIYlzho755VHq/4EiZrXskmBZY4hUBYlsvD6ALjBIF5oNifogFazuweS+of7
 P+DdGtwX3WqcdPiB+GrgO9Npa5J+EdMR1Tvd3XeCkA0+yl+oKuVVNGtOHqurSdiEeBGJ
 fG41rTGDvIleFaxOVUA/II2FQt0VWV2b7xArsvPMb6AvzUKP9rZ45MGNhR5jlOCPNsmm
 g7Zg==
X-Gm-Message-State: AC+VfDzWN3oKsvDxGnylmqpVYUOArudaTPBUfZHJFUyJyJMfKPtWTaWK
 zw+yhvpsozt1uuAgGirBSaPTGon3ZGj/W4KGysk=
X-Google-Smtp-Source: ACHHUZ5IINZ/bDd7CW4IY9XWRLnQUGFJbQP4swEHqszzauonWTitU3yvKSZc7nDzr6PWlWlbGTg+cg==
X-Received: by 2002:a17:902:c944:b0:1a6:46f2:4365 with SMTP id
 i4-20020a170902c94400b001a646f24365mr7896263pla.30.1684600023796; 
 Sat, 20 May 2023 09:27:03 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:d078:d94e:cb2b:a055])
 by smtp.gmail.com with ESMTPSA id
 d12-20020a170903230c00b001a5260a6e6csm1697104plh.206.2023.05.20.09.27.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 May 2023 09:27:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 20/27] accel/tcg: Remove prot argument to atomic_mmu_lookup
Date: Sat, 20 May 2023 09:26:27 -0700
Message-Id: <20230520162634.3991009-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230520162634.3991009-1-richard.henderson@linaro.org>
References: <20230520162634.3991009-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Now that load/store are gone, we're always passing
PAGE_READ | PAGE_WRITE for RMW atomic operations.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/atomic_template.h | 32 ++++++--------
 accel/tcg/cputlb.c          | 85 ++++++++++++++-----------------------
 accel/tcg/user-exec.c       |  8 +---
 3 files changed, 45 insertions(+), 80 deletions(-)

diff --git a/accel/tcg/atomic_template.h b/accel/tcg/atomic_template.h
index 30eee9d066..e312acd16d 100644
--- a/accel/tcg/atomic_template.h
+++ b/accel/tcg/atomic_template.h
@@ -73,8 +73,7 @@ ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, target_ulong addr,
                               ABI_TYPE cmpv, ABI_TYPE newv,
                               MemOpIdx oi, uintptr_t retaddr)
 {
-    DATA_TYPE *haddr = atomic_mmu_lookup(env, addr, oi, DATA_SIZE,
-                                         PAGE_READ | PAGE_WRITE, retaddr);
+    DATA_TYPE *haddr = atomic_mmu_lookup(env, addr, oi, DATA_SIZE, retaddr);
     DATA_TYPE ret;
 
 #if DATA_SIZE == 16
@@ -91,8 +90,7 @@ ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, target_ulong addr,
 ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, target_ulong addr, ABI_TYPE val,
                            MemOpIdx oi, uintptr_t retaddr)
 {
-    DATA_TYPE *haddr = atomic_mmu_lookup(env, addr, oi, DATA_SIZE,
-                                         PAGE_READ | PAGE_WRITE, retaddr);
+    DATA_TYPE *haddr = atomic_mmu_lookup(env, addr, oi, DATA_SIZE, retaddr);
     DATA_TYPE ret;
 
     ret = qatomic_xchg__nocheck(haddr, val);
@@ -105,9 +103,8 @@ ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, target_ulong addr, ABI_TYPE val,
 ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ulong addr,       \
                         ABI_TYPE val, MemOpIdx oi, uintptr_t retaddr) \
 {                                                                   \
-    DATA_TYPE *haddr = atomic_mmu_lookup(env, addr, oi, DATA_SIZE,  \
-                                         PAGE_READ | PAGE_WRITE, retaddr); \
-    DATA_TYPE ret;                                                  \
+    DATA_TYPE *haddr, ret;                                          \
+    haddr = atomic_mmu_lookup(env, addr, oi, DATA_SIZE, retaddr);   \
     ret = qatomic_##X(haddr, val);                                  \
     ATOMIC_MMU_CLEANUP;                                             \
     atomic_trace_rmw_post(env, addr, oi);                           \
@@ -137,9 +134,8 @@ GEN_ATOMIC_HELPER(xor_fetch)
 ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ulong addr,       \
                         ABI_TYPE xval, MemOpIdx oi, uintptr_t retaddr) \
 {                                                                   \
-    XDATA_TYPE *haddr = atomic_mmu_lookup(env, addr, oi, DATA_SIZE, \
-                                          PAGE_READ | PAGE_WRITE, retaddr); \
-    XDATA_TYPE cmp, old, new, val = xval;                           \
+    XDATA_TYPE *haddr, cmp, old, new, val = xval;                   \
+    haddr = atomic_mmu_lookup(env, addr, oi, DATA_SIZE, retaddr);   \
     smp_mb();                                                       \
     cmp = qatomic_read__nocheck(haddr);                             \
     do {                                                            \
@@ -180,8 +176,7 @@ ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, target_ulong addr,
                               ABI_TYPE cmpv, ABI_TYPE newv,
                               MemOpIdx oi, uintptr_t retaddr)
 {
-    DATA_TYPE *haddr = atomic_mmu_lookup(env, addr, oi, DATA_SIZE,
-                                         PAGE_READ | PAGE_WRITE, retaddr);
+    DATA_TYPE *haddr = atomic_mmu_lookup(env, addr, oi, DATA_SIZE, retaddr);
     DATA_TYPE ret;
 
 #if DATA_SIZE == 16
@@ -198,8 +193,7 @@ ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, target_ulong addr,
 ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, target_ulong addr, ABI_TYPE val,
                            MemOpIdx oi, uintptr_t retaddr)
 {
-    DATA_TYPE *haddr = atomic_mmu_lookup(env, addr, oi, DATA_SIZE,
-                                         PAGE_READ | PAGE_WRITE, retaddr);
+    DATA_TYPE *haddr = atomic_mmu_lookup(env, addr, oi, DATA_SIZE, retaddr);
     ABI_TYPE ret;
 
     ret = qatomic_xchg__nocheck(haddr, BSWAP(val));
@@ -212,9 +206,8 @@ ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, target_ulong addr, ABI_TYPE val,
 ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ulong addr,       \
                         ABI_TYPE val, MemOpIdx oi, uintptr_t retaddr) \
 {                                                                   \
-    DATA_TYPE *haddr = atomic_mmu_lookup(env, addr, oi, DATA_SIZE,  \
-                                         PAGE_READ | PAGE_WRITE, retaddr); \
-    DATA_TYPE ret;                                                  \
+    DATA_TYPE *haddr, ret;                                          \
+    haddr = atomic_mmu_lookup(env, addr, oi, DATA_SIZE, retaddr);   \
     ret = qatomic_##X(haddr, BSWAP(val));                           \
     ATOMIC_MMU_CLEANUP;                                             \
     atomic_trace_rmw_post(env, addr, oi);                           \
@@ -241,9 +234,8 @@ GEN_ATOMIC_HELPER(xor_fetch)
 ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ulong addr,       \
                         ABI_TYPE xval, MemOpIdx oi, uintptr_t retaddr) \
 {                                                                   \
-    XDATA_TYPE *haddr = atomic_mmu_lookup(env, addr, oi, DATA_SIZE, \
-                                          PAGE_READ | PAGE_WRITE, retaddr); \
-    XDATA_TYPE ldo, ldn, old, new, val = xval;                      \
+    XDATA_TYPE *haddr, ldo, ldn, old, new, val = xval;              \
+    haddr = atomic_mmu_lookup(env, addr, oi, DATA_SIZE, retaddr);   \
     smp_mb();                                                       \
     ldn = qatomic_read__nocheck(haddr);                             \
     do {                                                            \
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index b1e13d165c..9cb0b697d1 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1896,12 +1896,9 @@ static bool mmu_lookup(CPUArchState *env, target_ulong addr, MemOpIdx oi,
 /*
  * Probe for an atomic operation.  Do not allow unaligned operations,
  * or io operations to proceed.  Return the host address.
- *
- * @prot may be PAGE_READ, PAGE_WRITE, or PAGE_READ|PAGE_WRITE.
  */
 static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
-                               MemOpIdx oi, int size, int prot,
-                               uintptr_t retaddr)
+                               MemOpIdx oi, int size, uintptr_t retaddr)
 {
     uintptr_t mmu_idx = get_mmuidx(oi);
     MemOp mop = get_memop(oi);
@@ -1937,54 +1934,37 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
     tlbe = tlb_entry(env, mmu_idx, addr);
 
     /* Check TLB entry and enforce page permissions.  */
-    if (prot & PAGE_WRITE) {
-        tlb_addr = tlb_addr_write(tlbe);
-        if (!tlb_hit(tlb_addr, addr)) {
-            if (!victim_tlb_hit(env, mmu_idx, index, MMU_DATA_STORE,
-                                addr & TARGET_PAGE_MASK)) {
-                tlb_fill(env_cpu(env), addr, size,
-                         MMU_DATA_STORE, mmu_idx, retaddr);
-                index = tlb_index(env, mmu_idx, addr);
-                tlbe = tlb_entry(env, mmu_idx, addr);
-            }
-            tlb_addr = tlb_addr_write(tlbe) & ~TLB_INVALID_MASK;
-        }
-
-        if (prot & PAGE_READ) {
-            /*
-             * Let the guest notice RMW on a write-only page.
-             * We have just verified that the page is writable.
-             * Subpage lookups may have left TLB_INVALID_MASK set,
-             * but addr_read will only be -1 if PAGE_READ was unset.
-             */
-            if (unlikely(tlbe->addr_read == -1)) {
-                tlb_fill(env_cpu(env), addr, size,
-                         MMU_DATA_LOAD, mmu_idx, retaddr);
-                /*
-                 * Since we don't support reads and writes to different
-                 * addresses, and we do have the proper page loaded for
-                 * write, this shouldn't ever return.  But just in case,
-                 * handle via stop-the-world.
-                 */
-                goto stop_the_world;
-            }
-            /* Collect TLB_WATCHPOINT for read. */
-            tlb_addr |= tlbe->addr_read;
-        }
-    } else /* if (prot & PAGE_READ) */ {
-        tlb_addr = tlbe->addr_read;
-        if (!tlb_hit(tlb_addr, addr)) {
-            if (!victim_tlb_hit(env, mmu_idx, index, MMU_DATA_LOAD,
-                                addr & TARGET_PAGE_MASK)) {
-                tlb_fill(env_cpu(env), addr, size,
-                         MMU_DATA_LOAD, mmu_idx, retaddr);
-                index = tlb_index(env, mmu_idx, addr);
-                tlbe = tlb_entry(env, mmu_idx, addr);
-            }
-            tlb_addr = tlbe->addr_read & ~TLB_INVALID_MASK;
+    tlb_addr = tlb_addr_write(tlbe);
+    if (!tlb_hit(tlb_addr, addr)) {
+        if (!victim_tlb_hit(env, mmu_idx, index, MMU_DATA_STORE,
+                            addr & TARGET_PAGE_MASK)) {
+            tlb_fill(env_cpu(env), addr, size,
+                     MMU_DATA_STORE, mmu_idx, retaddr);
+            index = tlb_index(env, mmu_idx, addr);
+            tlbe = tlb_entry(env, mmu_idx, addr);
         }
+        tlb_addr = tlb_addr_write(tlbe) & ~TLB_INVALID_MASK;
     }
 
+    /*
+     * Let the guest notice RMW on a write-only page.
+     * We have just verified that the page is writable.
+     * Subpage lookups may have left TLB_INVALID_MASK set,
+     * but addr_read will only be -1 if PAGE_READ was unset.
+     */
+    if (unlikely(tlbe->addr_read == -1)) {
+        tlb_fill(env_cpu(env), addr, size, MMU_DATA_LOAD, mmu_idx, retaddr);
+        /*
+         * Since we don't support reads and writes to different
+         * addresses, and we do have the proper page loaded for
+         * write, this shouldn't ever return.  But just in case,
+         * handle via stop-the-world.
+         */
+        goto stop_the_world;
+    }
+    /* Collect TLB_WATCHPOINT for read. */
+    tlb_addr |= tlbe->addr_read;
+
     /* Notice an IO access or a needs-MMU-lookup access */
     if (unlikely(tlb_addr & (TLB_MMIO | TLB_DISCARD_WRITE))) {
         /* There's really nothing that can be done to
@@ -2000,11 +1980,8 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
     }
 
     if (unlikely(tlb_addr & TLB_WATCHPOINT)) {
-        QEMU_BUILD_BUG_ON(PAGE_READ != BP_MEM_READ);
-        QEMU_BUILD_BUG_ON(PAGE_WRITE != BP_MEM_WRITE);
-        /* therefore prot == watchpoint bits */
-        cpu_check_watchpoint(env_cpu(env), addr, size,
-                             full->attrs, prot, retaddr);
+        cpu_check_watchpoint(env_cpu(env), addr, size, full->attrs,
+                             BP_MEM_READ | BP_MEM_WRITE, retaddr);
     }
 
     return hostaddr;
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 19c2849c21..1e085b1210 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -1323,12 +1323,9 @@ uint64_t cpu_ldq_code_mmu(CPUArchState *env, abi_ptr addr,
 
 /*
  * Do not allow unaligned operations to proceed.  Return the host address.
- *
- * @prot may be PAGE_READ, PAGE_WRITE, or PAGE_READ|PAGE_WRITE.
  */
 static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
-                               MemOpIdx oi, int size, int prot,
-                               uintptr_t retaddr)
+                               MemOpIdx oi, int size, uintptr_t retaddr)
 {
     MemOp mop = get_memop(oi);
     int a_bits = get_alignment_bits(mop);
@@ -1336,8 +1333,7 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
 
     /* Enforce guest required alignment.  */
     if (unlikely(addr & ((1 << a_bits) - 1))) {
-        MMUAccessType t = prot == PAGE_READ ? MMU_DATA_LOAD : MMU_DATA_STORE;
-        cpu_loop_exit_sigbus(env_cpu(env), addr, t, retaddr);
+        cpu_loop_exit_sigbus(env_cpu(env), addr, MMU_DATA_STORE, retaddr);
     }
 
     /* Enforce qemu required alignment.  */
-- 
2.34.1


