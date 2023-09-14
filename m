Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE96879F86E
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 04:48:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgcLV-0000b0-90; Wed, 13 Sep 2023 22:44:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgcLT-0000aM-PZ
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 22:44:43 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgcLQ-0000es-Cv
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 22:44:43 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1c1ff5b741cso4099625ad.2
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 19:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694659479; x=1695264279; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cpfReO7qH4WP0lrA4FSR5wIwEaBAvx0PCBgP2wYkK8o=;
 b=JcYAjwc7+hrEW9uXnCiEmtGCvY+6PD9nCaVcQKWzg8VgwxdBXNPUX3+W1+QYw1mVg7
 5dpuAOhWhpIZa3r7zF9gQlGfEtXjPgIC95SfrRsISUfdhxO8WqrDFi99NDHxRR5a8G9i
 jobXq8CcpiuEAfpaOq1fr9m7niNpAVXuLKGw0Zmyvb1QB8TZv5wQVvr0Lt9NfVfI9Gg2
 CiIQ+XeilObP2veoKd4632xXdohEjvDStVY+CJtg9EFhfH7ykIO4CYdz0HjDR/ZEfOrD
 fNu6u1wmW0235GIEoYYzTl4gfcapL4O3NIgT03uDUGUTpxyWhP0cCPW+oE3J8Yf+qtvw
 /kjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694659479; x=1695264279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cpfReO7qH4WP0lrA4FSR5wIwEaBAvx0PCBgP2wYkK8o=;
 b=tjb1OGJrgFKPIyo5s5kWlDGTFmMg/BRweQgkC8TJe0HZmjTp/O92pvUB2J5pDRy+0b
 2FYJnAYeGcDpka+3SolpdRZP/tsdzlbkKS24MrKoxmoIZvrM3rR2yogbYr+T5bbLnFPC
 SymZpQeVV4FHeQoVTXPLylLphk5u8EejM0BamrIB+Js0+nupLPC7LVurC9ZnIVKdzcTv
 0zMsfNwJWHOQe4X99t6bXJuvoNQgynA2bvou7yCTmHUMonQAoSpotzI6H6lsSu7MA2gw
 +D3I/5vk8ei56KhkjBx76h2+Le6V4bfPhrX7dN6vaSP0M0xLTpqE19PkPHP58pS61LDq
 BKDA==
X-Gm-Message-State: AOJu0YxIfbgOyk4siDqnncQNvmfzpG9iNhj/ZGEqhfyydqW9Zu1uT7NC
 Zt+XvBMfiUhWnKAh5j8JitDM9ihOpiekaZO16sY=
X-Google-Smtp-Source: AGHT+IGVXKCiJOOgP5c9MWKSs5J617zwScF+M7UfyZv8sfRT2pdZmBU409bL+TdEMeywnQT3PogMFg==
X-Received: by 2002:a17:902:d48e:b0:1bb:9b48:ea94 with SMTP id
 c14-20020a170902d48e00b001bb9b48ea94mr4608336plg.32.1694659478796; 
 Wed, 13 Sep 2023 19:44:38 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 x24-20020a170902b41800b001bbdf32f011sm304336plr.269.2023.09.13.19.44.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 19:44:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng,
	ale@rev.ng,
	philmd@linaro.org
Subject: [PATCH v2 02/24] accel/tcg: Move CPUTLB definitions from cpu-defs.h
Date: Wed, 13 Sep 2023 19:44:13 -0700
Message-Id: <20230914024435.1381329-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230914024435.1381329-1-richard.henderson@linaro.org>
References: <20230914024435.1381329-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

Accept that we will consume space in CPUState for CONFIG_USER_ONLY,
since we cannot test CONFIG_SOFTMMU within hw/core/cpu.h.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-defs.h | 150 ----------------------------------------
 include/hw/core/cpu.h   | 141 +++++++++++++++++++++++++++++++++++++
 2 files changed, 141 insertions(+), 150 deletions(-)

diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index 0a600a312b..3915438b83 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -54,18 +54,7 @@
 
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
-
 #define CPU_TLB_DYN_MIN_BITS 6
 #define CPU_TLB_DYN_DEFAULT_BITS 8
 
@@ -91,143 +80,4 @@
 
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
-/*
- * This structure must be placed in ArchCPU immediately
- * before CPUArchState, as a field named "neg".
- */
-typedef struct CPUNegativeOffsetState {
-    CPUTLB tlb;
-    IcountDecr icount_decr;
-} CPUNegativeOffsetState;
-
 #endif
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 92a4234439..861664a5df 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -25,6 +25,7 @@
 #include "exec/cpu-common.h"
 #include "exec/hwaddr.h"
 #include "exec/memattrs.h"
+#include "exec/tlb-common.h"
 #include "qapi/qapi-types-run-state.h"
 #include "qemu/bitmap.h"
 #include "qemu/rcu_queue.h"
@@ -192,6 +193,137 @@ struct CPUClass {
     bool gdb_stop_before_watchpoint;
 };
 
+/*
+ * Fix the number of mmu modes to 16, which is also the maximum
+ * supported by the softmmu tlb api.
+ */
+#define NB_MMU_MODES 16
+
+/* Use a fully associative victim tlb of 8 entries. */
+#define CPU_VTLB_SIZE 8
+
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
+
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
+typedef struct CPUTLB {
+#ifdef CONFIG_TCG
+    CPUTLBCommon c;
+    CPUTLBDesc d[NB_MMU_MODES];
+    CPUTLBDescFast f[NB_MMU_MODES];
+#endif
+} CPUTLB;
+
 /*
  * Low 16 bits: number of cycles left, used only in icount mode.
  * High 16 bits: Set to -1 to force TCG to stop executing linked TBs
@@ -212,6 +344,15 @@ typedef union IcountDecr {
     } u16;
 } IcountDecr;
 
+/*
+ * This structure must be placed in ArchCPU immediately
+ * before CPUArchState, as a field named "neg".
+ */
+typedef struct CPUNegativeOffsetState {
+    CPUTLB tlb;
+    IcountDecr icount_decr;
+} CPUNegativeOffsetState;
+
 typedef struct CPUBreakpoint {
     vaddr pc;
     int flags; /* BP_* */
-- 
2.34.1


