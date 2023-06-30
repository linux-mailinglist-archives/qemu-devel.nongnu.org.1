Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A97743BD4
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 14:27:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFDDe-0007rJ-6n; Fri, 30 Jun 2023 08:27:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qFDCU-0007gm-75
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 08:26:11 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qFDCR-0007nm-ST
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 08:26:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5UiQBsLcq7OOik+VH0EC9Ewy2tKMDq/XqQGTeRNa8jE=; b=ZkGMikSoGf27sX2qKaji3k58po
 FpEhXKP7mQXkGhJnbhR6Qx38/N1zrXhhxJrzCHlsZoFjLFvokAC5MkMTZKnDLQUAWBAfSGaUZmLCo
 JqlKzu5Ze+MO8iXApr4x5Ovza9PljMC33v6axCfgD6RTb5khLWny+rVt9wAFNfSCAlJQ=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, richard.henderson@linaro.org, pbonzini@redhat.com,
 eduardo@habkost.net, philmd@linaro.org, marcel.apfelbaum@gmail.com,
 peter.maydell@linaro.org, wangyanan55@huawei.com
Subject: [PATCH 1/9] target/arm: Replace TARGET_PAGE_ENTRY_EXTRA
Date: Fri, 30 Jun 2023 14:25:43 +0200
Message-ID: <20230630122551.21766-2-anjo@rev.ng>
In-Reply-To: <20230630122551.21766-1-anjo@rev.ng>
References: <20230630122551.21766-1-anjo@rev.ng>
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

From: Anton Johansson <97antjoh@gmail.com>

TARGET_PAGE_ENTRY_EXTRA is a macro that allows guests to specify additional
fields for caching with the full TLB entry.  This macro is replaced with
a union in CPUTLBEntryFull, thus making CPUTLB target-agnostic at the
cost of slightly inflated CPUTLBEntryFull for non-arm guests.

(arm is the only guest actually making use of this feature.)

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 include/exec/cpu-defs.h        | 18 +++++++++++++++---
 target/arm/cpu-param.h         | 12 ------------
 target/arm/ptw.c               |  4 ++--
 target/arm/tcg/mte_helper.c    |  2 +-
 target/arm/tcg/sve_helper.c    |  2 +-
 target/arm/tcg/tlb_helper.c    |  4 ++--
 target/arm/tcg/translate-a64.c |  2 +-
 7 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index fb4c8d480f..0a600a312b 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -135,9 +135,21 @@ typedef struct CPUTLBEntryFull {
      * This may be used to cache items from the guest cpu
      * page tables for later use by the implementation.
      */
-#ifdef TARGET_PAGE_ENTRY_EXTRA
-    TARGET_PAGE_ENTRY_EXTRA
-#endif
+    union {
+        /*
+         * Cache the attrs and shareability fields from the page table entry.
+         *
+         * For ARMMMUIdx_Stage2*, pte_attrs is the S2 descriptor bits [5:2].
+         * Otherwise, pte_attrs is the same as the MAIR_EL1 8-bit format.
+         * For shareability and guarded, as in the SH and GP fields respectively
+         * of the VMSAv8-64 PTEs.
+         */
+        struct {
+            uint8_t pte_attrs;
+            uint8_t shareability;
+            bool guarded;
+        } arm;
+    } extra;
 } CPUTLBEntryFull;
 #endif /* CONFIG_SOFTMMU */
 
diff --git a/target/arm/cpu-param.h b/target/arm/cpu-param.h
index b3b35f7aa1..f9b462a98f 100644
--- a/target/arm/cpu-param.h
+++ b/target/arm/cpu-param.h
@@ -31,18 +31,6 @@
 # define TARGET_PAGE_BITS_VARY
 # define TARGET_PAGE_BITS_MIN  10
 
-/*
- * Cache the attrs and shareability fields from the page table entry.
- *
- * For ARMMMUIdx_Stage2*, pte_attrs is the S2 descriptor bits [5:2].
- * Otherwise, pte_attrs is the same as the MAIR_EL1 8-bit format.
- * For shareability and guarded, as in the SH and GP fields respectively
- * of the VMSAv8-64 PTEs.
- */
-# define TARGET_PAGE_ENTRY_EXTRA  \
-    uint8_t pte_attrs;            \
-    uint8_t shareability;         \
-    bool guarded;
 #endif
 
 #endif
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 6015121b99..22e02579cb 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -499,7 +499,7 @@ static bool S1_ptw_translate(CPUARMState *env, S1Translate *ptw,
         }
         ptw->out_phys = full->phys_addr | (addr & ~TARGET_PAGE_MASK);
         ptw->out_rw = full->prot & PAGE_WRITE;
-        pte_attrs = full->pte_attrs;
+        pte_attrs = full->extra.arm.pte_attrs;
         ptw->out_secure = full->attrs.secure;
         ptw->out_space = full->attrs.space;
 #else
@@ -1933,7 +1933,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
 
         /* When in aarch64 mode, and BTI is enabled, remember GP in the TLB. */
         if (aarch64 && cpu_isar_feature(aa64_bti, cpu)) {
-            result->f.guarded = extract64(attrs, 50, 1); /* GP */
+            result->f.extra.arm.guarded = extract64(attrs, 50, 1); /* GP */
         }
     }
 
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index 9c64def081..be30c2bb51 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -124,7 +124,7 @@ static uint8_t *allocation_tag_mem(CPUARMState *env, int ptr_mmu_idx,
     assert(!(flags & TLB_INVALID_MASK));
 
     /* If the virtual page MemAttr != Tagged, access unchecked. */
-    if (full->pte_attrs != 0xf0) {
+    if (full->extra.arm.pte_attrs != 0xf0) {
         return NULL;
     }
 
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 0097522470..996c04d3d9 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -5373,7 +5373,7 @@ bool sve_probe_page(SVEHostPage *info, bool nofault, CPUARMState *env,
     info->tagged = (flags & PAGE_ANON) && (flags & PAGE_MTE);
 #else
     info->attrs = full->attrs;
-    info->tagged = full->pte_attrs == 0xf0;
+    info->tagged = full->extra.arm.pte_attrs == 0xf0;
 #endif
 
     /* Ensure that info->host[] is relative to addr, not addr + mem_off. */
diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
index b22b2a4c6e..59bff8b452 100644
--- a/target/arm/tcg/tlb_helper.c
+++ b/target/arm/tcg/tlb_helper.c
@@ -334,8 +334,8 @@ bool arm_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
             address &= TARGET_PAGE_MASK;
         }
 
-        res.f.pte_attrs = res.cacheattrs.attrs;
-        res.f.shareability = res.cacheattrs.shareability;
+        res.f.extra.arm.pte_attrs = res.cacheattrs.attrs;
+        res.f.extra.arm.shareability = res.cacheattrs.shareability;
 
         tlb_set_page_full(cs, mmu_idx, address, &res.f);
         return true;
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 3baab6aa60..0c5e275ac8 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -13763,7 +13763,7 @@ static bool is_guarded_page(CPUARMState *env, DisasContext *s)
                               false, &host, &full, 0);
     assert(!(flags & TLB_INVALID_MASK));
 
-    return full->guarded;
+    return full->extra.arm.guarded;
 #endif
 }
 
-- 
2.41.0


