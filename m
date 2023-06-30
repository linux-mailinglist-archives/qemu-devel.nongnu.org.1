Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CAB743BD5
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 14:28:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFDDm-0008TK-DF; Fri, 30 Jun 2023 08:27:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qFDCW-0007i0-Sm
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 08:26:13 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qFDCU-0007oL-HS
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 08:26:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=yH2lGkcD6MjDRFSd7GpsAC0EDoMhVP42/0i4heE8u68=; b=NpwZXfD1qghngVlSmz4BSGLA81
 YsApToyXdzw+4A5+PRqHGEWrD7vtz40kv6ujH3H5xKmMaulthYd8NELJFYJDM+Xau2hIB5Gcph18v
 naiSnU/NWAfLuxkWQ9bZrQ99qUObMUgWwIZXGKLZW1BBNKoPPhuBMS292ZWkBST3/bek=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, richard.henderson@linaro.org, pbonzini@redhat.com,
 eduardo@habkost.net, philmd@linaro.org, marcel.apfelbaum@gmail.com,
 peter.maydell@linaro.org, wangyanan55@huawei.com
Subject: [PATCH 3/9] include/exec: Move CPUTLB and friends to tlb-common.h
Date: Fri, 30 Jun 2023 14:25:45 +0200
Message-ID: <20230630122551.21766-4-anjo@rev.ng>
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

CPUTLB is now target-agnostic and can be moved to a more suitable
header.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 include/exec/cpu-defs.h   | 145 +------------------------------------
 include/exec/tlb-common.h | 148 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 149 insertions(+), 144 deletions(-)

diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index 0a600a312b..dff6c37f6b 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -25,10 +25,7 @@
 
 #include "qemu/host-utils.h"
 #include "qemu/thread.h"
-#ifndef CONFIG_USER_ONLY
-#include "exec/hwaddr.h"
-#endif
-#include "exec/memattrs.h"
+#include "exec/tlb-common.h"
 #include "hw/core/cpu.h"
 
 #include "cpu-param.h"
@@ -54,17 +51,7 @@
 
 #include "exec/target_long.h"
 
-/*
- * Fix the number of mmu modes to 16, which is also the maximum
- * supported by the softmmu tlb api.
- */
-#define NB_MMU_MODES 16
-
 #if defined(CONFIG_SOFTMMU) && defined(CONFIG_TCG)
-#include "exec/tlb-common.h"
-
-/* use a fully associative victim tlb of 8 entries */
-#define CPU_VTLB_SIZE 8
 
 #define CPU_TLB_DYN_MIN_BITS 6
 #define CPU_TLB_DYN_DEFAULT_BITS 8
@@ -91,136 +78,6 @@
 
 #endif /* CONFIG_SOFTMMU && CONFIG_TCG */
 
-#if defined(CONFIG_SOFTMMU)
-/*
- * The full TLB entry, which is not accessed by generated TCG code,
- * so the layout is not as critical as that of CPUTLBEntry. This is
- * also why we don't want to combine the two structs.
- */
-typedef struct CPUTLBEntryFull {
-    /*
-     * @xlat_section contains:
-     *  - in the lower TARGET_PAGE_BITS, a physical section number
-     *  - with the lower TARGET_PAGE_BITS masked off, an offset which
-     *    must be added to the virtual address to obtain:
-     *     + the ram_addr_t of the target RAM (if the physical section
-     *       number is PHYS_SECTION_NOTDIRTY or PHYS_SECTION_ROM)
-     *     + the offset within the target MemoryRegion (otherwise)
-     */
-    hwaddr xlat_section;
-
-    /*
-     * @phys_addr contains the physical address in the address space
-     * given by cpu_asidx_from_attrs(cpu, @attrs).
-     */
-    hwaddr phys_addr;
-
-    /* @attrs contains the memory transaction attributes for the page. */
-    MemTxAttrs attrs;
-
-    /* @prot contains the complete protections for the page. */
-    uint8_t prot;
-
-    /* @lg_page_size contains the log2 of the page size. */
-    uint8_t lg_page_size;
-
-    /*
-     * Additional tlb flags for use by the slow path. If non-zero,
-     * the corresponding CPUTLBEntry comparator must have TLB_FORCE_SLOW.
-     */
-    uint8_t slow_flags[MMU_ACCESS_COUNT];
-
-    /*
-     * Allow target-specific additions to this structure.
-     * This may be used to cache items from the guest cpu
-     * page tables for later use by the implementation.
-     */
-    union {
-        /*
-         * Cache the attrs and shareability fields from the page table entry.
-         *
-         * For ARMMMUIdx_Stage2*, pte_attrs is the S2 descriptor bits [5:2].
-         * Otherwise, pte_attrs is the same as the MAIR_EL1 8-bit format.
-         * For shareability and guarded, as in the SH and GP fields respectively
-         * of the VMSAv8-64 PTEs.
-         */
-        struct {
-            uint8_t pte_attrs;
-            uint8_t shareability;
-            bool guarded;
-        } arm;
-    } extra;
-} CPUTLBEntryFull;
-#endif /* CONFIG_SOFTMMU */
-
-#if defined(CONFIG_SOFTMMU) && defined(CONFIG_TCG)
-/*
- * Data elements that are per MMU mode, minus the bits accessed by
- * the TCG fast path.
- */
-typedef struct CPUTLBDesc {
-    /*
-     * Describe a region covering all of the large pages allocated
-     * into the tlb.  When any page within this region is flushed,
-     * we must flush the entire tlb.  The region is matched if
-     * (addr & large_page_mask) == large_page_addr.
-     */
-    vaddr large_page_addr;
-    vaddr large_page_mask;
-    /* host time (in ns) at the beginning of the time window */
-    int64_t window_begin_ns;
-    /* maximum number of entries observed in the window */
-    size_t window_max_entries;
-    size_t n_used_entries;
-    /* The next index to use in the tlb victim table.  */
-    size_t vindex;
-    /* The tlb victim table, in two parts.  */
-    CPUTLBEntry vtable[CPU_VTLB_SIZE];
-    CPUTLBEntryFull vfulltlb[CPU_VTLB_SIZE];
-    CPUTLBEntryFull *fulltlb;
-} CPUTLBDesc;
-
-/*
- * Data elements that are shared between all MMU modes.
- */
-typedef struct CPUTLBCommon {
-    /* Serialize updates to f.table and d.vtable, and others as noted. */
-    QemuSpin lock;
-    /*
-     * Within dirty, for each bit N, modifications have been made to
-     * mmu_idx N since the last time that mmu_idx was flushed.
-     * Protected by tlb_c.lock.
-     */
-    uint16_t dirty;
-    /*
-     * Statistics.  These are not lock protected, but are read and
-     * written atomically.  This allows the monitor to print a snapshot
-     * of the stats without interfering with the cpu.
-     */
-    size_t full_flush_count;
-    size_t part_flush_count;
-    size_t elide_flush_count;
-} CPUTLBCommon;
-
-/*
- * The entire softmmu tlb, for all MMU modes.
- * The meaning of each of the MMU modes is defined in the target code.
- * Since this is placed within CPUNegativeOffsetState, the smallest
- * negative offsets are at the end of the struct.
- */
-
-typedef struct CPUTLB {
-    CPUTLBCommon c;
-    CPUTLBDesc d[NB_MMU_MODES];
-    CPUTLBDescFast f[NB_MMU_MODES];
-} CPUTLB;
-
-#else
-
-typedef struct CPUTLB { } CPUTLB;
-
-#endif /* CONFIG_SOFTMMU && CONFIG_TCG */
-
 /*
  * This structure must be placed in ArchCPU immediately
  * before CPUArchState, as a field named "neg".
diff --git a/include/exec/tlb-common.h b/include/exec/tlb-common.h
index d1203354b4..838a1f0d2a 100644
--- a/include/exec/tlb-common.h
+++ b/include/exec/tlb-common.h
@@ -19,6 +19,17 @@
 #ifndef EXEC_TLB_COMMON_H
 #define EXEC_TLB_COMMON_H 1
 
+#ifndef CONFIG_USER_ONLY
+#include "exec/hwaddr.h"
+#endif
+#include "exec/memattrs.h"
+
+/*
+ * Fix the number of mmu modes to 16, which is also the maximum
+ * supported by the softmmu tlb api.
+ */
+#define NB_MMU_MODES 16
+
 typedef enum MMUAccessType {
     MMU_DATA_LOAD  = 0,
     MMU_DATA_STORE = 1,
@@ -26,6 +37,13 @@ typedef enum MMUAccessType {
 #define MMU_ACCESS_COUNT 3
 } MMUAccessType;
 
+#if defined(CONFIG_SOFTMMU) && defined(CONFIG_TCG)
+/* use a fully associative victim tlb of 8 entries */
+#define CPU_VTLB_SIZE 8
+#endif
+
+#define CPU_TLB_ENTRY_BITS 5
+
 /* Minimalized TLB entry for use by TCG fast path. */
 typedef union CPUTLBEntry {
     struct {
@@ -58,4 +76,134 @@ typedef struct CPUTLBDescFast {
     CPUTLBEntry *table;
 } CPUTLBDescFast QEMU_ALIGNED(2 * sizeof(void *));
 
+#if defined(CONFIG_SOFTMMU)
+/*
+ * The full TLB entry, which is not accessed by generated TCG code,
+ * so the layout is not as critical as that of CPUTLBEntry. This is
+ * also why we don't want to combine the two structs.
+ */
+typedef struct CPUTLBEntryFull {
+    /*
+     * @xlat_section contains:
+     *  - in the lower TARGET_PAGE_BITS, a physical section number
+     *  - with the lower TARGET_PAGE_BITS masked off, an offset which
+     *    must be added to the virtual address to obtain:
+     *     + the ram_addr_t of the target RAM (if the physical section
+     *       number is PHYS_SECTION_NOTDIRTY or PHYS_SECTION_ROM)
+     *     + the offset within the target MemoryRegion (otherwise)
+     */
+    hwaddr xlat_section;
+
+    /*
+     * @phys_addr contains the physical address in the address space
+     * given by cpu_asidx_from_attrs(cpu, @attrs).
+     */
+    hwaddr phys_addr;
+
+    /* @attrs contains the memory transaction attributes for the page. */
+    MemTxAttrs attrs;
+
+    /* @prot contains the complete protections for the page. */
+    uint8_t prot;
+
+    /* @lg_page_size contains the log2 of the page size. */
+    uint8_t lg_page_size;
+
+    /*
+     * Additional tlb flags for use by the slow path. If non-zero,
+     * the corresponding CPUTLBEntry comparator must have TLB_FORCE_SLOW.
+     */
+    uint8_t slow_flags[MMU_ACCESS_COUNT];
+
+    /*
+     * Allow target-specific additions to this structure.
+     * This may be used to cache items from the guest cpu
+     * page tables for later use by the implementation.
+     */
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
+} CPUTLBEntryFull;
+#endif /* CONFIG_SOFTMMU */
+
+#if defined(CONFIG_SOFTMMU) && defined(CONFIG_TCG)
+/*
+ * Data elements that are per MMU mode, minus the bits accessed by
+ * the TCG fast path.
+ */
+typedef struct CPUTLBDesc {
+    /*
+     * Describe a region covering all of the large pages allocated
+     * into the tlb.  When any page within this region is flushed,
+     * we must flush the entire tlb.  The region is matched if
+     * (addr & large_page_mask) == large_page_addr.
+     */
+    vaddr large_page_addr;
+    vaddr large_page_mask;
+    /* host time (in ns) at the beginning of the time window */
+    int64_t window_begin_ns;
+    /* maximum number of entries observed in the window */
+    size_t window_max_entries;
+    size_t n_used_entries;
+    /* The next index to use in the tlb victim table.  */
+    size_t vindex;
+    /* The tlb victim table, in two parts.  */
+    CPUTLBEntry vtable[CPU_VTLB_SIZE];
+    CPUTLBEntryFull vfulltlb[CPU_VTLB_SIZE];
+    CPUTLBEntryFull *fulltlb;
+} CPUTLBDesc;
+
+/*
+ * Data elements that are shared between all MMU modes.
+ */
+typedef struct CPUTLBCommon {
+    /* Serialize updates to f.table and d.vtable, and others as noted. */
+    QemuSpin lock;
+    /*
+     * Within dirty, for each bit N, modifications have been made to
+     * mmu_idx N since the last time that mmu_idx was flushed.
+     * Protected by tlb_c.lock.
+     */
+    uint16_t dirty;
+    /*
+     * Statistics.  These are not lock protected, but are read and
+     * written atomically.  This allows the monitor to print a snapshot
+     * of the stats without interfering with the cpu.
+     */
+    size_t full_flush_count;
+    size_t part_flush_count;
+    size_t elide_flush_count;
+} CPUTLBCommon;
+
+/*
+ * The entire softmmu tlb, for all MMU modes.
+ * The meaning of each of the MMU modes is defined in the target code.
+ * Since this is placed within CPUNegativeOffsetState, the smallest
+ * negative offsets are at the end of the struct.
+ */
+
+typedef struct CPUTLB {
+    CPUTLBCommon c;
+    CPUTLBDesc d[NB_MMU_MODES];
+    CPUTLBDescFast f[NB_MMU_MODES];
+} CPUTLB;
+
+#else
+
+typedef struct CPUTLB { } CPUTLB;
+
+#endif /* CONFIG_SOFTMMU && CONFIG_TCG */
+
 #endif /* EXEC_TLB_COMMON_H */
-- 
2.41.0


