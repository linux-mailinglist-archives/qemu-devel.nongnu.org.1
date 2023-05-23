Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 728C770DDDB
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 15:48:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1SMp-0000vg-QW; Tue, 23 May 2023 09:47:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SMm-0000ff-Lw
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:47:56 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SMk-00018r-Aj
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:47:56 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-64d293746e0so6209131b3a.2
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684849672; x=1687441672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b4QbT7Qp39kM9Wky+d26o1epuHAtvA7Ubq3UboPhQe0=;
 b=TsWPMQIh04GxLiDDjXXSrPzB42UxoRIWG3+fjes7tpLTxP/uRS+7e/ljC23xr2d5LG
 Gvwzl9hpzGvE6hF2w8xb/z2iI9cS9wwlYQapSymdxAODHyylonAwAMdbtFgNxCgSW2GR
 nyiKhsG10M77+9TCjzdsjGLzqD5JCCmX3DbjT7N6ZL2dO1go66FX/sSw7/sGKDBHNRCz
 eZXRLCjWiiQtkbkeYzNJ3cDoqJI/cnCRzxXtJKKWCMaOVUkTsr7xWWIw77FTgPATNvwm
 EHB6zYkmxCjVw+b3FmLF9s80eawcovO90sunatSreoZ1ciov48p3Cb9IExBoyCRMMhtO
 KcmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684849672; x=1687441672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b4QbT7Qp39kM9Wky+d26o1epuHAtvA7Ubq3UboPhQe0=;
 b=Bh/YFlGB4orVJMU4j23bVmpKTc4yRkSaTaQ/FLBtblwpc/qWjC3pZP7lf8OgSVmnPs
 RcmsMOT+dMs9z937SnKxwMCOkSkSNRu87+pDUb3kjsCbOsW8cOWU3elSxSQzXwKqRWSs
 pOZ/uC/5Ry8kFP9YneMohoAHl8ilBTkNkWY96KwxP8HDQ7w2sXXmYw1oA00mqb2fZPsK
 RnDdoibexu2jhQn+PknMfW4Js7lRv/Ov+nE5F/AM0tQgEPKy47IbFstZif1t2dAX0ahI
 qE++tYnCP262256pptq4nuyizNrf9JyBEPMJLb5BtRocnL5qK4iiTZqd28oiqL9J4/6B
 dsOA==
X-Gm-Message-State: AC+VfDwIL8DG894EZQ3V0XeWzhuNH6zyE8uxnQdYfRPIz2jimSQszBw/
 G6uXQ60TqxuD1new6HVyK5S/LNde2NUhHcN0c98=
X-Google-Smtp-Source: ACHHUZ5lIyyVJVZPBnDhCBDJ+5nczi1bVC6rnj9jAkEYjsx9t+vfYoA04yiRoxLo9YpNYx0FzbYPfg==
X-Received: by 2002:a05:6a00:15c7:b0:62d:d045:392 with SMTP id
 o7-20020a056a0015c700b0062dd0450392mr20465988pfu.32.1684849672421; 
 Tue, 23 May 2023 06:47:52 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 j4-20020aa79284000000b0064d1349dc31sm5737122pfa.199.2023.05.23.06.47.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:47:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v2 20/27] accel/tcg: Remove prot argument to atomic_mmu_lookup
Date: Tue, 23 May 2023 06:47:26 -0700
Message-Id: <20230523134733.678646-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523134733.678646-1-richard.henderson@linaro.org>
References: <20230523134733.678646-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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


