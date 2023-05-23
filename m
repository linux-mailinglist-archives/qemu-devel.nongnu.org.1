Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E95C970E9F5
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 02:03:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1bto-0004Kj-3w; Tue, 23 May 2023 19:58:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1btk-0004I2-Vp
 for qemu-devel@nongnu.org; Tue, 23 May 2023 19:58:37 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1btY-0001pm-0D
 for qemu-devel@nongnu.org; Tue, 23 May 2023 19:58:36 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-64d2a87b9daso112769b3a.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 16:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684886303; x=1687478303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bUiC8B941VenGp4T2O+nh8vsCtJVXe6reCgoVgugxCk=;
 b=Hu/3xqcNLofOAinlf5QDsZRG23c+EI+wgQ1l/tjkhqCR4+zIVOjkWwlEhyrmaHuqT7
 KezY99ENvFkureoalFzwjb83Ubop0w8d/kFmzGZTe5mBshEBiUPDzmtyr4pUmQoGYlb0
 9BtFmfQWQs0smLwPWNRa/rpqDvQ3hrbkXb3lEnk0B2ju0TqcfLWLM34E1eQdCCzWeVLJ
 SM5ApzovHDYxcQ0j77MBR5XhvtkZY7affmasSBUxnbmWYIujuFoxjna/wUnqpnaZdY6A
 uBg3K72vpQ6gpCwfmguUq0WMPynT4dlQYi12AwZuBBbIpRQyzt3EWeLQhicXBqQixUzj
 MBvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684886303; x=1687478303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bUiC8B941VenGp4T2O+nh8vsCtJVXe6reCgoVgugxCk=;
 b=V9yoaTws71qXZ4bSHCI8xame5OCDOCi2wIOPCUDXFIlJF68e1T/gbPrt88HpaGzzTf
 QgiHIkT3GWcaFY/mxuEW7qSmz+B7vnVZCgnMxZlaHUXsTy2NrBS4BDnJ7RO6W2c42T+r
 rshDFSAd436UWPpUgphzWSN8NBwgJ1q0O1/QkFcC2Ca2267DtgvGQuBsFJ8pXTl74XHs
 ZPa1ejTfxRNOhShC7X/CfGUjT2+jw0+hKmalXkveEQ9h6Gszjja3LJDgcrKX0MEtVyhP
 jtodKrmIgF5RD4vYRcFhVyssjJYUOKB7TBYMYrwZd9CiTeinCww8W16ZEXD/kLG9zLCN
 /mjw==
X-Gm-Message-State: AC+VfDw/smfcwnGmt23NY4IWBYJ2Sq3o4g4PUJ8Ax6vNZf/X9kbkbV8u
 EGJVKsbtcH/lzfvD0hRIQ1wZafdt1FNpAsbq7kk=
X-Google-Smtp-Source: ACHHUZ6I78vjlEoEbYE1M6QBUw+lbZ6Ppzl6750qsfp/wvVU6tlWvRduVrT6emXToJ8HjHerAiL2eA==
X-Received: by 2002:a05:6a00:148a:b0:63c:1be4:5086 with SMTP id
 v10-20020a056a00148a00b0063c1be45086mr1028975pfu.6.1684886302731; 
 Tue, 23 May 2023 16:58:22 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 p18-20020aa78612000000b0063b7c42a070sm6285041pfn.68.2023.05.23.16.58.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 16:58:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 20/28] accel/tcg: Remove prot argument to atomic_mmu_lookup
Date: Tue, 23 May 2023 16:57:56 -0700
Message-Id: <20230523235804.747803-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523235804.747803-1-richard.henderson@linaro.org>
References: <20230523235804.747803-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
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


