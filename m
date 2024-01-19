Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 359CA832B7D
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 15:43:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQq33-0005vN-3Q; Fri, 19 Jan 2024 09:40:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rQq2t-0005qQ-98
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 09:40:35 -0500
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rQq2q-0003u6-Lp
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 09:40:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=OSL2GHUkDheOlsFtGxY+LT4CIeg4LkaX7rfcHlxNROE=; b=JoZcvFDL4p5l0ahQQ5aRsQqT37
 cp4yUEEiaMeGy/5bpX5P1urEM380w4LN9H17fuZ9jPXyU6MWTxzdJUlmcFnGx5ZWHZdpgyKHXvnOn
 1lPi/LOSULuipkBFPR3EbNKlmcaaCo2P2znVOANiNjQe3+6FEhrLLdexclazGK3Os5mQ=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng,
	richard.henderson@linaro.org,
	philmd@linaro.org
Subject: [RFC PATCH 19/34] accel/tcg: [CPUTLB] Use TCGContext.addr_type
 instead of TARGET_LONG_BITS
Date: Fri, 19 Jan 2024 15:40:09 +0100
Message-ID: <20240119144024.14289-20-anjo@rev.ng>
In-Reply-To: <20240119144024.14289-1-anjo@rev.ng>
References: <20240119144024.14289-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

[NOTE: We could also use target_long_bits(), which is introduced later]

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 include/exec/cpu_ldst.h | 31 ++++++++++++++++---------------
 accel/tcg/cputlb.c      | 34 ++++++++++++++++++++--------------
 2 files changed, 36 insertions(+), 29 deletions(-)

diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index 24fe322d72..553e0119f9 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -340,7 +340,7 @@ static inline void clear_helper_retaddr(void)
 
 #else
 
-#include "tcg/oversized-guest.h"
+#include "tcg-target-reg-bits.h"
 
 static inline uint64_t tlb_read_idx(const CPUTLBEntry *entry,
                                     MMUAccessType access_type)
@@ -353,20 +353,21 @@ static inline uint64_t tlb_read_idx(const CPUTLBEntry *entry,
     QEMU_BUILD_BUG_ON(offsetof(CPUTLBEntry, addr_code) !=
                       MMU_INST_FETCH * sizeof(uint64_t));
 
-#if TARGET_LONG_BITS == 32
-    /* Use qatomic_read, in case of addr_write; only care about low bits. */
-    const uint32_t *ptr = (uint32_t *)&entry->addr_idx[access_type];
-    ptr += HOST_BIG_ENDIAN;
-    return qatomic_read(ptr);
-#else
-    const uint64_t *ptr = &entry->addr_idx[access_type];
-# if TCG_OVERSIZED_GUEST
-    return *ptr;
-# else
-    /* ofs might correspond to .addr_write, so use qatomic_read */
-    return qatomic_read(ptr);
-# endif
-#endif
+    if (tcg_ctx->addr_type == TCG_TYPE_I32) {
+        /* Use qatomic_read, in case of addr_write; only care about low bits. */
+        const uint32_t *ptr = (uint32_t *)&entry->addr_idx[access_type];
+        ptr += HOST_BIG_ENDIAN;
+        return qatomic_read(ptr);
+    } else {
+        const uint64_t *ptr = &entry->addr_idx[access_type];
+        if (TCG_TARGET_REG_BITS == 32) {
+            /* Oversized guest */
+            return *ptr;
+        } else {
+            /* ofs might correspond to .addr_write, so use qatomic_read */
+            return qatomic_read(ptr);
+        }
+    }
 }
 
 static inline uint64_t tlb_addr_write(const CPUTLBEntry *entry)
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 449c86301e..967d5da6d4 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -41,7 +41,7 @@
 #include "qemu/plugin-memory.h"
 #endif
 #include "tcg/tcg-ldst.h"
-#include "tcg/oversized-guest.h"
+#include "tcg-target-reg-bits.h"
 
 /* DEBUG defines, enable DEBUG_TLB_LOG to log to the CPU_LOG_MMU target */
 /* #define DEBUG_TLB */
@@ -815,12 +815,13 @@ void tlb_flush_range_by_mmuidx(CPUState *cpu, vaddr addr,
                                unsigned bits)
 {
     TLBFlushRangeData d;
+    const unsigned long_bits = (tcg_ctx->addr_type == TCG_TYPE_I32) ? 32 : 64;
 
     /*
      * If all bits are significant, and len is small,
      * this devolves to tlb_flush_page.
      */
-    if (bits >= TARGET_LONG_BITS && len <= TARGET_PAGE_SIZE) {
+    if (bits >= long_bits && len <= TARGET_PAGE_SIZE) {
         tlb_flush_page_by_mmuidx(cpu, addr, idxmap);
         return;
     }
@@ -858,12 +859,13 @@ void tlb_flush_range_by_mmuidx_all_cpus(CPUState *src_cpu,
 {
     TLBFlushRangeData d;
     CPUState *dst_cpu;
+    const unsigned long_bits = (tcg_ctx->addr_type == TCG_TYPE_I32) ? 32 : 64;
 
     /*
      * If all bits are significant, and len is small,
      * this devolves to tlb_flush_page.
      */
-    if (bits >= TARGET_LONG_BITS && len <= TARGET_PAGE_SIZE) {
+    if (bits >= long_bits && len <= TARGET_PAGE_SIZE) {
         tlb_flush_page_by_mmuidx_all_cpus(src_cpu, addr, idxmap);
         return;
     }
@@ -908,12 +910,13 @@ void tlb_flush_range_by_mmuidx_all_cpus_synced(CPUState *src_cpu,
 {
     TLBFlushRangeData d, *p;
     CPUState *dst_cpu;
+    const unsigned long_bits = (tcg_ctx->addr_type == TCG_TYPE_I32) ? 32 : 64;
 
     /*
      * If all bits are significant, and len is small,
      * this devolves to tlb_flush_page.
      */
-    if (bits >= TARGET_LONG_BITS && len <= TARGET_PAGE_SIZE) {
+    if (bits >= long_bits && len <= TARGET_PAGE_SIZE) {
         tlb_flush_page_by_mmuidx_all_cpus_synced(src_cpu, addr, idxmap);
         return;
     }
@@ -995,16 +998,19 @@ static void tlb_reset_dirty_range_locked(CPUTLBEntry *tlb_entry,
         addr &= TARGET_PAGE_MASK;
         addr += tlb_entry->addend;
         if ((addr - start) < length) {
-#if TARGET_LONG_BITS == 32
-            uint32_t *ptr_write = (uint32_t *)&tlb_entry->addr_write;
-            ptr_write += HOST_BIG_ENDIAN;
-            qatomic_set(ptr_write, *ptr_write | TLB_NOTDIRTY);
-#elif TCG_OVERSIZED_GUEST
-            tlb_entry->addr_write |= TLB_NOTDIRTY;
-#else
-            qatomic_set(&tlb_entry->addr_write,
-                        tlb_entry->addr_write | TLB_NOTDIRTY);
-#endif
+            if (tcg_ctx->addr_type == TCG_TYPE_I32) {
+                /* 32-bit */
+                uint32_t *ptr_write = (uint32_t *)&tlb_entry->addr_write;
+                ptr_write += HOST_BIG_ENDIAN;
+                qatomic_set(ptr_write, *ptr_write | TLB_NOTDIRTY);
+            } else if (TCG_TARGET_REG_BITS == 32) {
+                /* Oversized guest */
+                tlb_entry->addr_write |= TLB_NOTDIRTY;
+            } else {
+                /* 64-bit */
+                qatomic_set(&tlb_entry->addr_write,
+                            tlb_entry->addr_write | TLB_NOTDIRTY);
+            }
         }
     }
 }
-- 
2.43.0


