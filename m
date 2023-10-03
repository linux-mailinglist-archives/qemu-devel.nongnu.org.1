Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D797B7008
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 19:38:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnjEz-0008Pb-UJ; Tue, 03 Oct 2023 13:31:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjEk-0008G9-Us
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:31:18 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjEf-0007Sn-RP
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:31:09 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-68fb85afef4so997077b3a.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 10:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696354264; x=1696959064; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x5bXvV8/liLqXA0kcgF71U15Gwa32na7FANcfIedj14=;
 b=IwT7mZbBQrwJpI/3M0EuViODtlK5rGWE7CB+xlSf5LZ6hJN9VSLzAnfnaQURczQ5Zn
 Q16j60vyuQ1qGh7uTLfaMhDW7/iaJHNFx2aEpAd4+gVyA4B5l7vMkLVj7P2C1Wdevm9S
 ZsD0hjs9EUYKErFrl8ktLME10MkjCIHn2SInPcNy9IR8osnHrJ+myix0+Q9ERHQC6h3R
 O4WVOH0SZl3byxL5knosSnqzjfzFGxkRM1X1KfxwI34ClBaktrisIejqkUIwgScCMRI5
 YAUnlR5ITDhChOQqeG+QX4REBsgmJnxYMCB9THu7UIQzbrEbFqI+XIpCP2v+woNtCBPq
 +P9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696354264; x=1696959064;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x5bXvV8/liLqXA0kcgF71U15Gwa32na7FANcfIedj14=;
 b=FZC3c2o7vzfXyRPQtz/gHeTSbomquzSMNSwscUWeyU9n2aXN4z8ZyPHfIWBolgi0au
 IOhrpAs5BNmFufmYV1SLcmq20J6AGPcanxZE0HSNWYpzL07eN92wVhAk13oPWCSh3zHS
 G86jUNdRM/G4ydosB6YdinbX9vzvPdYSNIcc20Kgf25/JRjVWlirssftzQuhBN1qLUes
 3MqRbQ1J0b5sw/xhbD7HZ9AxO5E7RjyFg+U9wxRu/phu5udQFaTqHxQZaXd5NvtUyQV7
 Sr+vgcyIR/+WGo4G+6Zr6Yjn6mFuDuFUUuShtfIdp2Y6gFnPZiikkw1vO23iaUeYWTCO
 P0Kg==
X-Gm-Message-State: AOJu0Yy91RSZKdlSafMqni1sRavFNiun1dG0kRmYynOgxmg5w/59eFdm
 3fgBKBrntnZ5Qoq1YHv2G3fns49SXnL5ifKJ58g=
X-Google-Smtp-Source: AGHT+IF08O6UZ4HwAVfEuBA9gl4csQhUjRoVKO7RurBuvkYdEoxE4aX/TBzjclbKtGPMiqkimQ5v3Q==
X-Received: by 2002:a05:6a20:918d:b0:14c:a2e1:65fd with SMTP id
 v13-20020a056a20918d00b0014ca2e165fdmr183407pzd.9.1696354263810; 
 Tue, 03 Oct 2023 10:31:03 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 n7-20020aa78a47000000b00692c5b1a731sm1620195pfa.186.2023.10.03.10.31.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 10:31:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
Subject: [PULL 09/47] accel/tcg: Move CPUTLB definitions from cpu-defs.h
Date: Tue,  3 Oct 2023 10:30:14 -0700
Message-Id: <20231003173052.1601813-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003173052.1601813-1-richard.henderson@linaro.org>
References: <20231003173052.1601813-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

Reviewed-by: Anton Johansson <anjo@rev.ng>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-defs.h | 150 ----------------------------------------
 include/hw/core/cpu.h   | 141 +++++++++++++++++++++++++++++++++++++
 2 files changed, 141 insertions(+), 150 deletions(-)

diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index 46d2ac570f..3915438b83 100644
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
-     *  - For ram, an offset which must be added to the virtual address
-     *    to obtain the ram_addr_t of the target RAM
-     *  - For other memory regions,
-     *     + in the lower TARGET_PAGE_BITS, the physical section number
-     *     + with the TARGET_PAGE_BITS masked off, the offset within
-     *       the target MemoryRegion
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
index 648b5b3586..04baa5063c 100644
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


