Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D781832B85
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 15:44:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQq30-0005tX-IQ; Fri, 19 Jan 2024 09:40:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rQq2o-0005pp-FY
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 09:40:31 -0500
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rQq2h-0003qe-Lm
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 09:40:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=uMQY05glCUgc2SOZtvjUFn8m9dY4dxvnJGKBXXX0x6U=; b=XooMNysNb5XXAXMg7Ll/o5+b0l
 NNyEV181Re71FV0s4VKK+vQk0p4oXkVFltsnMsH/2p2N369Z+dB+7kgG5PHjBdCUbY8NwSrCgfszA
 U0JX6d7CTxhkub+jie5jrz/z0FGR5ZWM+7sZD0du0LRMwUS70G/gnkTyvdQElml5ENdM=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng,
	richard.henderson@linaro.org,
	philmd@linaro.org
Subject: [RFC PATCH 11/34] [IGNORE] Squash of header code shuffling
Date: Fri, 19 Jan 2024 15:40:01 +0100
Message-ID: <20240119144024.14289-12-anjo@rev.ng>
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

This commit squashes header changes that are likely to change during
rebase. Code is moved from common to specific headers, or vice versa
to ensure that no target-specific code is pulled by accel/tcg via
headers.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 accel/tcg/tb-hash.h            |   4 +-
 hw/s390x/s390-virtio-hcall.h   |   2 +
 include/exec/cpu-all.h         |   1 +
 include/exec/cpu-common.h      |   2 +
 include/exec/cpu_ldst-target.h |  52 +++++
 include/exec/cpu_ldst.h        |  60 ++----
 include/exec/exec-all.h        | 347 +------------------------------
 include/exec/exec-common.h     | 367 +++++++++++++++++++++++++++++++++
 include/exec/memory-internal.h |   2 +-
 include/exec/ram_addr.h        |   3 +-
 include/qemu/plugin-memory.h   |   1 -
 accel/tcg/cpu-exec.c           |   1 +
 plugins/core.c                 |   1 +
 target/arm/cpu.c               |   1 +
 target/sparc/gdbstub.c         |   3 +
 15 files changed, 459 insertions(+), 388 deletions(-)
 create mode 100644 include/exec/cpu_ldst-target.h
 create mode 100644 include/exec/exec-common.h

diff --git a/accel/tcg/tb-hash.h b/accel/tcg/tb-hash.h
index a0c61f25cd..2569810365 100644
--- a/accel/tcg/tb-hash.h
+++ b/accel/tcg/tb-hash.h
@@ -20,8 +20,8 @@
 #ifndef EXEC_TB_HASH_H
 #define EXEC_TB_HASH_H
 
-#include "exec/cpu-defs.h"
-#include "exec/exec-all.h"
+#include "exec/exec-common.h"
+#include "exec/translation-block.h"
 #include "qemu/xxhash.h"
 #include "tb-jmp-cache.h"
 
diff --git a/hw/s390x/s390-virtio-hcall.h b/hw/s390x/s390-virtio-hcall.h
index 9800c4b351..0e48dbf71f 100644
--- a/hw/s390x/s390-virtio-hcall.h
+++ b/hw/s390x/s390-virtio-hcall.h
@@ -12,6 +12,8 @@
 #ifndef HW_S390_VIRTIO_HCALL_H
 #define HW_S390_VIRTIO_HCALL_H
 
+#include "qemu/osdep.h"
+#include "cpu.h"
 #include "standard-headers/asm-s390/virtio-ccw.h"
 
 /* The only thing that we need from the old kvm_virtio.h file */
diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 83165b1ce4..483e762f05 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -20,6 +20,7 @@
 #define CPU_ALL_H
 
 #include "exec/cpu-common.h"
+#include "exec/cpu-defs.h"
 #include "exec/memory.h"
 #include "exec/tswap.h"
 #include "qemu/thread.h"
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index c071f1a003..2eb6589764 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -3,6 +3,8 @@
 
 /* CPU interfaces that are target independent.  */
 
+#include "qemu/osdep.h"
+#include "hw/core/cpu.h"
 #ifndef CONFIG_USER_ONLY
 #include "exec/hwaddr.h"
 #endif
diff --git a/include/exec/cpu_ldst-target.h b/include/exec/cpu_ldst-target.h
new file mode 100644
index 0000000000..4fdec4a3ff
--- /dev/null
+++ b/include/exec/cpu_ldst-target.h
@@ -0,0 +1,52 @@
+#ifndef CPU_LDST_SPECIFIC_H
+#define CPU_LDST_SPECIFIC_H
+
+#include "cpu-param.h"
+
+#if TARGET_BIG_ENDIAN
+# define cpu_lduw_data        cpu_lduw_be_data
+# define cpu_ldsw_data        cpu_ldsw_be_data
+# define cpu_ldl_data         cpu_ldl_be_data
+# define cpu_ldq_data         cpu_ldq_be_data
+# define cpu_lduw_data_ra     cpu_lduw_be_data_ra
+# define cpu_ldsw_data_ra     cpu_ldsw_be_data_ra
+# define cpu_ldl_data_ra      cpu_ldl_be_data_ra
+# define cpu_ldq_data_ra      cpu_ldq_be_data_ra
+# define cpu_lduw_mmuidx_ra   cpu_lduw_be_mmuidx_ra
+# define cpu_ldsw_mmuidx_ra   cpu_ldsw_be_mmuidx_ra
+# define cpu_ldl_mmuidx_ra    cpu_ldl_be_mmuidx_ra
+# define cpu_ldq_mmuidx_ra    cpu_ldq_be_mmuidx_ra
+# define cpu_stw_data         cpu_stw_be_data
+# define cpu_stl_data         cpu_stl_be_data
+# define cpu_stq_data         cpu_stq_be_data
+# define cpu_stw_data_ra      cpu_stw_be_data_ra
+# define cpu_stl_data_ra      cpu_stl_be_data_ra
+# define cpu_stq_data_ra      cpu_stq_be_data_ra
+# define cpu_stw_mmuidx_ra    cpu_stw_be_mmuidx_ra
+# define cpu_stl_mmuidx_ra    cpu_stl_be_mmuidx_ra
+# define cpu_stq_mmuidx_ra    cpu_stq_be_mmuidx_ra
+#else
+# define cpu_lduw_data        cpu_lduw_le_data
+# define cpu_ldsw_data        cpu_ldsw_le_data
+# define cpu_ldl_data         cpu_ldl_le_data
+# define cpu_ldq_data         cpu_ldq_le_data
+# define cpu_lduw_data_ra     cpu_lduw_le_data_ra
+# define cpu_ldsw_data_ra     cpu_ldsw_le_data_ra
+# define cpu_ldl_data_ra      cpu_ldl_le_data_ra
+# define cpu_ldq_data_ra      cpu_ldq_le_data_ra
+# define cpu_lduw_mmuidx_ra   cpu_lduw_le_mmuidx_ra
+# define cpu_ldsw_mmuidx_ra   cpu_ldsw_le_mmuidx_ra
+# define cpu_ldl_mmuidx_ra    cpu_ldl_le_mmuidx_ra
+# define cpu_ldq_mmuidx_ra    cpu_ldq_le_mmuidx_ra
+# define cpu_stw_data         cpu_stw_le_data
+# define cpu_stl_data         cpu_stl_le_data
+# define cpu_stq_data         cpu_stq_le_data
+# define cpu_stw_data_ra      cpu_stw_le_data_ra
+# define cpu_stl_data_ra      cpu_stl_le_data_ra
+# define cpu_stq_data_ra      cpu_stq_le_data_ra
+# define cpu_stw_mmuidx_ra    cpu_stw_le_mmuidx_ra
+# define cpu_stl_mmuidx_ra    cpu_stl_le_mmuidx_ra
+# define cpu_stq_mmuidx_ra    cpu_stq_le_mmuidx_ra
+#endif
+
+#endif
diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index eb8f3f0595..24fe322d72 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -64,7 +64,21 @@
 
 #include "exec/memopidx.h"
 #include "qemu/int128.h"
+#if defined(CONFIG_USER_ONLY)
 #include "cpu.h"
+#include "exec/cpu-all.h"
+#include "exec/user/abitypes.h"
+#include "exec/user/guest-base.h"
+#else
+#include "qemu/typedefs.h"
+#include "exec/cpu-common.h"
+#include "exec/tlb-common.h"
+#include "tcg/tcg.h"
+#endif
+
+#ifdef NEED_CPU_H
+#include "cpu_ldst-target.h"
+#endif
 
 #if defined(CONFIG_USER_ONLY)
 /* sparc32plus has 64bit long but 32bit space address
@@ -378,52 +392,6 @@ static inline CPUTLBEntry *tlb_entry(CPUState *cpu, uintptr_t mmu_idx,
 
 #endif /* defined(CONFIG_USER_ONLY) */
 
-#if TARGET_BIG_ENDIAN
-# define cpu_lduw_data        cpu_lduw_be_data
-# define cpu_ldsw_data        cpu_ldsw_be_data
-# define cpu_ldl_data         cpu_ldl_be_data
-# define cpu_ldq_data         cpu_ldq_be_data
-# define cpu_lduw_data_ra     cpu_lduw_be_data_ra
-# define cpu_ldsw_data_ra     cpu_ldsw_be_data_ra
-# define cpu_ldl_data_ra      cpu_ldl_be_data_ra
-# define cpu_ldq_data_ra      cpu_ldq_be_data_ra
-# define cpu_lduw_mmuidx_ra   cpu_lduw_be_mmuidx_ra
-# define cpu_ldsw_mmuidx_ra   cpu_ldsw_be_mmuidx_ra
-# define cpu_ldl_mmuidx_ra    cpu_ldl_be_mmuidx_ra
-# define cpu_ldq_mmuidx_ra    cpu_ldq_be_mmuidx_ra
-# define cpu_stw_data         cpu_stw_be_data
-# define cpu_stl_data         cpu_stl_be_data
-# define cpu_stq_data         cpu_stq_be_data
-# define cpu_stw_data_ra      cpu_stw_be_data_ra
-# define cpu_stl_data_ra      cpu_stl_be_data_ra
-# define cpu_stq_data_ra      cpu_stq_be_data_ra
-# define cpu_stw_mmuidx_ra    cpu_stw_be_mmuidx_ra
-# define cpu_stl_mmuidx_ra    cpu_stl_be_mmuidx_ra
-# define cpu_stq_mmuidx_ra    cpu_stq_be_mmuidx_ra
-#else
-# define cpu_lduw_data        cpu_lduw_le_data
-# define cpu_ldsw_data        cpu_ldsw_le_data
-# define cpu_ldl_data         cpu_ldl_le_data
-# define cpu_ldq_data         cpu_ldq_le_data
-# define cpu_lduw_data_ra     cpu_lduw_le_data_ra
-# define cpu_ldsw_data_ra     cpu_ldsw_le_data_ra
-# define cpu_ldl_data_ra      cpu_ldl_le_data_ra
-# define cpu_ldq_data_ra      cpu_ldq_le_data_ra
-# define cpu_lduw_mmuidx_ra   cpu_lduw_le_mmuidx_ra
-# define cpu_ldsw_mmuidx_ra   cpu_ldsw_le_mmuidx_ra
-# define cpu_ldl_mmuidx_ra    cpu_ldl_le_mmuidx_ra
-# define cpu_ldq_mmuidx_ra    cpu_ldq_le_mmuidx_ra
-# define cpu_stw_data         cpu_stw_le_data
-# define cpu_stl_data         cpu_stl_le_data
-# define cpu_stq_data         cpu_stq_le_data
-# define cpu_stw_data_ra      cpu_stw_le_data_ra
-# define cpu_stl_data_ra      cpu_stl_le_data_ra
-# define cpu_stq_data_ra      cpu_stq_le_data_ra
-# define cpu_stw_mmuidx_ra    cpu_stw_le_mmuidx_ra
-# define cpu_stl_mmuidx_ra    cpu_stl_le_mmuidx_ra
-# define cpu_stq_mmuidx_ra    cpu_stq_le_mmuidx_ra
-#endif
-
 uint8_t cpu_ldb_code_mmu(CPUArchState *env, abi_ptr addr,
                          MemOpIdx oi, uintptr_t ra);
 uint16_t cpu_ldw_code_mmu(CPUArchState *env, abi_ptr addr,
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index ee90ef122b..8410521893 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -20,352 +20,25 @@
 #ifndef EXEC_ALL_H
 #define EXEC_ALL_H
 
+#if defined(CONFIG_USER_ONLY)
 #include "cpu.h"
+#endif
+#include "exec/exec-common.h"
 #if defined(CONFIG_USER_ONLY)
 #include "exec/cpu_ldst.h"
 #endif
 #include "exec/translation-block.h"
 #include "qemu/clang-tsa.h"
-
-/**
- * cpu_loop_exit_requested:
- * @cpu: The CPU state to be tested
- *
- * Indicate if somebody asked for a return of the CPU to the main loop
- * (e.g., via cpu_exit() or cpu_interrupt()).
- *
- * This is helpful for architectures that support interruptible
- * instructions. After writing back all state to registers/memory, this
- * call can be used to check if it makes sense to return to the main loop
- * or to continue executing the interruptible instruction.
- */
-static inline bool cpu_loop_exit_requested(CPUState *cpu)
-{
-    return (int32_t)qatomic_read(&cpu->neg.icount_decr.u32) < 0;
-}
-
-#if !defined(CONFIG_USER_ONLY) && defined(CONFIG_TCG)
-/* cputlb.c */
-/**
- * tlb_init - initialize a CPU's TLB
- * @cpu: CPU whose TLB should be initialized
- */
-void tlb_init(CPUState *cpu);
-/**
- * tlb_destroy - destroy a CPU's TLB
- * @cpu: CPU whose TLB should be destroyed
- */
-void tlb_destroy(CPUState *cpu);
-/**
- * tlb_flush_page:
- * @cpu: CPU whose TLB should be flushed
- * @addr: virtual address of page to be flushed
- *
- * Flush one page from the TLB of the specified CPU, for all
- * MMU indexes.
- */
-void tlb_flush_page(CPUState *cpu, vaddr addr);
-/**
- * tlb_flush_page_all_cpus:
- * @cpu: src CPU of the flush
- * @addr: virtual address of page to be flushed
- *
- * Flush one page from the TLB of the specified CPU, for all
- * MMU indexes.
- */
-void tlb_flush_page_all_cpus(CPUState *src, vaddr addr);
-/**
- * tlb_flush_page_all_cpus_synced:
- * @cpu: src CPU of the flush
- * @addr: virtual address of page to be flushed
- *
- * Flush one page from the TLB of the specified CPU, for all MMU
- * indexes like tlb_flush_page_all_cpus except the source vCPUs work
- * is scheduled as safe work meaning all flushes will be complete once
- * the source vCPUs safe work is complete. This will depend on when
- * the guests translation ends the TB.
- */
-void tlb_flush_page_all_cpus_synced(CPUState *src, vaddr addr);
-/**
- * tlb_flush:
- * @cpu: CPU whose TLB should be flushed
- *
- * Flush the entire TLB for the specified CPU. Most CPU architectures
- * allow the implementation to drop entries from the TLB at any time
- * so this is generally safe. If more selective flushing is required
- * use one of the other functions for efficiency.
- */
-void tlb_flush(CPUState *cpu);
-/**
- * tlb_flush_all_cpus:
- * @cpu: src CPU of the flush
- */
-void tlb_flush_all_cpus(CPUState *src_cpu);
-/**
- * tlb_flush_all_cpus_synced:
- * @cpu: src CPU of the flush
- *
- * Like tlb_flush_all_cpus except this except the source vCPUs work is
- * scheduled as safe work meaning all flushes will be complete once
- * the source vCPUs safe work is complete. This will depend on when
- * the guests translation ends the TB.
- */
-void tlb_flush_all_cpus_synced(CPUState *src_cpu);
-/**
- * tlb_flush_page_by_mmuidx:
- * @cpu: CPU whose TLB should be flushed
- * @addr: virtual address of page to be flushed
- * @idxmap: bitmap of MMU indexes to flush
- *
- * Flush one page from the TLB of the specified CPU, for the specified
- * MMU indexes.
- */
-void tlb_flush_page_by_mmuidx(CPUState *cpu, vaddr addr,
-                              uint16_t idxmap);
-/**
- * tlb_flush_page_by_mmuidx_all_cpus:
- * @cpu: Originating CPU of the flush
- * @addr: virtual address of page to be flushed
- * @idxmap: bitmap of MMU indexes to flush
- *
- * Flush one page from the TLB of all CPUs, for the specified
- * MMU indexes.
- */
-void tlb_flush_page_by_mmuidx_all_cpus(CPUState *cpu, vaddr addr,
-                                       uint16_t idxmap);
-/**
- * tlb_flush_page_by_mmuidx_all_cpus_synced:
- * @cpu: Originating CPU of the flush
- * @addr: virtual address of page to be flushed
- * @idxmap: bitmap of MMU indexes to flush
- *
- * Flush one page from the TLB of all CPUs, for the specified MMU
- * indexes like tlb_flush_page_by_mmuidx_all_cpus except the source
- * vCPUs work is scheduled as safe work meaning all flushes will be
- * complete once  the source vCPUs safe work is complete. This will
- * depend on when the guests translation ends the TB.
- */
-void tlb_flush_page_by_mmuidx_all_cpus_synced(CPUState *cpu, vaddr addr,
-                                              uint16_t idxmap);
-/**
- * tlb_flush_by_mmuidx:
- * @cpu: CPU whose TLB should be flushed
- * @wait: If true ensure synchronisation by exiting the cpu_loop
- * @idxmap: bitmap of MMU indexes to flush
- *
- * Flush all entries from the TLB of the specified CPU, for the specified
- * MMU indexes.
- */
-void tlb_flush_by_mmuidx(CPUState *cpu, uint16_t idxmap);
-/**
- * tlb_flush_by_mmuidx_all_cpus:
- * @cpu: Originating CPU of the flush
- * @idxmap: bitmap of MMU indexes to flush
- *
- * Flush all entries from all TLBs of all CPUs, for the specified
- * MMU indexes.
- */
-void tlb_flush_by_mmuidx_all_cpus(CPUState *cpu, uint16_t idxmap);
-/**
- * tlb_flush_by_mmuidx_all_cpus_synced:
- * @cpu: Originating CPU of the flush
- * @idxmap: bitmap of MMU indexes to flush
- *
- * Flush all entries from all TLBs of all CPUs, for the specified
- * MMU indexes like tlb_flush_by_mmuidx_all_cpus except except the source
- * vCPUs work is scheduled as safe work meaning all flushes will be
- * complete once  the source vCPUs safe work is complete. This will
- * depend on when the guests translation ends the TB.
- */
-void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *cpu, uint16_t idxmap);
-
-/**
- * tlb_flush_page_bits_by_mmuidx
- * @cpu: CPU whose TLB should be flushed
- * @addr: virtual address of page to be flushed
- * @idxmap: bitmap of mmu indexes to flush
- * @bits: number of significant bits in address
- *
- * Similar to tlb_flush_page_mask, but with a bitmap of indexes.
- */
-void tlb_flush_page_bits_by_mmuidx(CPUState *cpu, vaddr addr,
-                                   uint16_t idxmap, unsigned bits);
-
-/* Similarly, with broadcast and syncing. */
-void tlb_flush_page_bits_by_mmuidx_all_cpus(CPUState *cpu, vaddr addr,
-                                            uint16_t idxmap, unsigned bits);
-void tlb_flush_page_bits_by_mmuidx_all_cpus_synced
-    (CPUState *cpu, vaddr addr, uint16_t idxmap, unsigned bits);
-
-/**
- * tlb_flush_range_by_mmuidx
- * @cpu: CPU whose TLB should be flushed
- * @addr: virtual address of the start of the range to be flushed
- * @len: length of range to be flushed
- * @idxmap: bitmap of mmu indexes to flush
- * @bits: number of significant bits in address
- *
- * For each mmuidx in @idxmap, flush all pages within [@addr,@addr+@len),
- * comparing only the low @bits worth of each virtual page.
- */
-void tlb_flush_range_by_mmuidx(CPUState *cpu, vaddr addr,
-                               vaddr len, uint16_t idxmap,
-                               unsigned bits);
-
-/* Similarly, with broadcast and syncing. */
-void tlb_flush_range_by_mmuidx_all_cpus(CPUState *cpu, vaddr addr,
-                                        vaddr len, uint16_t idxmap,
-                                        unsigned bits);
-void tlb_flush_range_by_mmuidx_all_cpus_synced(CPUState *cpu,
-                                               vaddr addr,
-                                               vaddr len,
-                                               uint16_t idxmap,
-                                               unsigned bits);
-
-/**
- * tlb_set_page_full:
- * @cpu: CPU context
- * @mmu_idx: mmu index of the tlb to modify
- * @addr: virtual address of the entry to add
- * @full: the details of the tlb entry
- *
- * Add an entry to @cpu tlb index @mmu_idx.  All of the fields of
- * @full must be filled, except for xlat_section, and constitute
- * the complete description of the translated page.
- *
- * This is generally called by the target tlb_fill function after
- * having performed a successful page table walk to find the physical
- * address and attributes for the translation.
- *
- * At most one entry for a given virtual address is permitted. Only a
- * single TARGET_PAGE_SIZE region is mapped; @full->lg_page_size is only
- * used by tlb_flush_page.
- */
-void tlb_set_page_full(CPUState *cpu, int mmu_idx, vaddr addr,
-                       CPUTLBEntryFull *full);
-
-/**
- * tlb_set_page_with_attrs:
- * @cpu: CPU to add this TLB entry for
- * @addr: virtual address of page to add entry for
- * @paddr: physical address of the page
- * @attrs: memory transaction attributes
- * @prot: access permissions (PAGE_READ/PAGE_WRITE/PAGE_EXEC bits)
- * @mmu_idx: MMU index to insert TLB entry for
- * @size: size of the page in bytes
- *
- * Add an entry to this CPU's TLB (a mapping from virtual address
- * @addr to physical address @paddr) with the specified memory
- * transaction attributes. This is generally called by the target CPU
- * specific code after it has been called through the tlb_fill()
- * entry point and performed a successful page table walk to find
- * the physical address and attributes for the virtual address
- * which provoked the TLB miss.
- *
- * At most one entry for a given virtual address is permitted. Only a
- * single TARGET_PAGE_SIZE region is mapped; the supplied @size is only
- * used by tlb_flush_page.
- */
-void tlb_set_page_with_attrs(CPUState *cpu, vaddr addr,
-                             hwaddr paddr, MemTxAttrs attrs,
-                             int prot, int mmu_idx, vaddr size);
-/* tlb_set_page:
+/*
+ * All the code in this header is target independent.
  *
- * This function is equivalent to calling tlb_set_page_with_attrs()
- * with an @attrs argument of MEMTXATTRS_UNSPECIFIED. It's provided
- * as a convenience for CPUs which don't use memory transaction attributes.
+ * We only have this cpu.h include here since a lot of
+ * compilation units rely on getting cpu.h from exec-all.h.
  */
-void tlb_set_page(CPUState *cpu, vaddr addr,
-                  hwaddr paddr, int prot,
-                  int mmu_idx, vaddr size);
-#else
-static inline void tlb_init(CPUState *cpu)
-{
-}
-static inline void tlb_destroy(CPUState *cpu)
-{
-}
-static inline void tlb_flush_page(CPUState *cpu, vaddr addr)
-{
-}
-static inline void tlb_flush_page_all_cpus(CPUState *src, vaddr addr)
-{
-}
-static inline void tlb_flush_page_all_cpus_synced(CPUState *src, vaddr addr)
-{
-}
-static inline void tlb_flush(CPUState *cpu)
-{
-}
-static inline void tlb_flush_all_cpus(CPUState *src_cpu)
-{
-}
-static inline void tlb_flush_all_cpus_synced(CPUState *src_cpu)
-{
-}
-static inline void tlb_flush_page_by_mmuidx(CPUState *cpu,
-                                            vaddr addr, uint16_t idxmap)
-{
-}
-
-static inline void tlb_flush_by_mmuidx(CPUState *cpu, uint16_t idxmap)
-{
-}
-static inline void tlb_flush_page_by_mmuidx_all_cpus(CPUState *cpu,
-                                                     vaddr addr,
-                                                     uint16_t idxmap)
-{
-}
-static inline void tlb_flush_page_by_mmuidx_all_cpus_synced(CPUState *cpu,
-                                                            vaddr addr,
-                                                            uint16_t idxmap)
-{
-}
-static inline void tlb_flush_by_mmuidx_all_cpus(CPUState *cpu, uint16_t idxmap)
-{
-}
-
-static inline void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *cpu,
-                                                       uint16_t idxmap)
-{
-}
-static inline void tlb_flush_page_bits_by_mmuidx(CPUState *cpu,
-                                                 vaddr addr,
-                                                 uint16_t idxmap,
-                                                 unsigned bits)
-{
-}
-static inline void tlb_flush_page_bits_by_mmuidx_all_cpus(CPUState *cpu,
-                                                          vaddr addr,
-                                                          uint16_t idxmap,
-                                                          unsigned bits)
-{
-}
-static inline void
-tlb_flush_page_bits_by_mmuidx_all_cpus_synced(CPUState *cpu, vaddr addr,
-                                              uint16_t idxmap, unsigned bits)
-{
-}
-static inline void tlb_flush_range_by_mmuidx(CPUState *cpu, vaddr addr,
-                                             vaddr len, uint16_t idxmap,
-                                             unsigned bits)
-{
-}
-static inline void tlb_flush_range_by_mmuidx_all_cpus(CPUState *cpu,
-                                                      vaddr addr,
-                                                      vaddr len,
-                                                      uint16_t idxmap,
-                                                      unsigned bits)
-{
-}
-static inline void tlb_flush_range_by_mmuidx_all_cpus_synced(CPUState *cpu,
-                                                             vaddr addr,
-                                                             vaddr len,
-                                                             uint16_t idxmap,
-                                                             unsigned bits)
-{
-}
+#if defined(NEED_CPU_H)
+#include "cpu.h"
 #endif
+
 /**
  * probe_access:
  * @env: CPUArchState
diff --git a/include/exec/exec-common.h b/include/exec/exec-common.h
new file mode 100644
index 0000000000..82c7216c39
--- /dev/null
+++ b/include/exec/exec-common.h
@@ -0,0 +1,367 @@
+/*
+ * target-independent internal execution defines for qemu
+ *
+ *  Copyright (c) 2003 Fabrice Bellard
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef EXEC_COMMON_H
+#define EXEC_COMMON_H
+
+#include "qemu/osdep.h"
+#include "hw/core/cpu.h"
+
+/**
+ * cpu_loop_exit_requested:
+ * @cpu: The CPU state to be tested
+ *
+ * Indicate if somebody asked for a return of the CPU to the main loop
+ * (e.g., via cpu_exit() or cpu_interrupt()).
+ *
+ * This is helpful for architectures that support interruptible
+ * instructions. After writing back all state to registers/memory, this
+ * call can be used to check if it makes sense to return to the main loop
+ * or to continue executing the interruptible instruction.
+ */
+static inline bool cpu_loop_exit_requested(CPUState *cpu)
+{
+    return (int32_t)qatomic_read(&cpu->neg.icount_decr.u32) < 0;
+}
+
+#if !defined(CONFIG_USER_ONLY) && defined(CONFIG_TCG)
+/* cputlb.c */
+/**
+ * tlb_init - initialize a CPU's TLB
+ * @cpu: CPU whose TLB should be initialized
+ */
+void tlb_init(CPUState *cpu);
+/**
+ * tlb_destroy - destroy a CPU's TLB
+ * @cpu: CPU whose TLB should be destroyed
+ */
+void tlb_destroy(CPUState *cpu);
+/**
+ * tlb_flush_page:
+ * @cpu: CPU whose TLB should be flushed
+ * @addr: virtual address of page to be flushed
+ *
+ * Flush one page from the TLB of the specified CPU, for all
+ * MMU indexes.
+ */
+void tlb_flush_page(CPUState *cpu, vaddr addr);
+/**
+ * tlb_flush_page_all_cpus:
+ * @cpu: src CPU of the flush
+ * @addr: virtual address of page to be flushed
+ *
+ * Flush one page from the TLB of the specified CPU, for all
+ * MMU indexes.
+ */
+void tlb_flush_page_all_cpus(CPUState *src, vaddr addr);
+/**
+ * tlb_flush_page_all_cpus_synced:
+ * @cpu: src CPU of the flush
+ * @addr: virtual address of page to be flushed
+ *
+ * Flush one page from the TLB of the specified CPU, for all MMU
+ * indexes like tlb_flush_page_all_cpus except the source vCPUs work
+ * is scheduled as safe work meaning all flushes will be complete once
+ * the source vCPUs safe work is complete. This will depend on when
+ * the guests translation ends the TB.
+ */
+void tlb_flush_page_all_cpus_synced(CPUState *src, vaddr addr);
+/**
+ * tlb_flush:
+ * @cpu: CPU whose TLB should be flushed
+ *
+ * Flush the entire TLB for the specified CPU. Most CPU architectures
+ * allow the implementation to drop entries from the TLB at any time
+ * so this is generally safe. If more selective flushing is required
+ * use one of the other functions for efficiency.
+ */
+void tlb_flush(CPUState *cpu);
+/**
+ * tlb_flush_all_cpus:
+ * @cpu: src CPU of the flush
+ */
+void tlb_flush_all_cpus(CPUState *src_cpu);
+/**
+ * tlb_flush_all_cpus_synced:
+ * @cpu: src CPU of the flush
+ *
+ * Like tlb_flush_all_cpus except this except the source vCPUs work is
+ * scheduled as safe work meaning all flushes will be complete once
+ * the source vCPUs safe work is complete. This will depend on when
+ * the guests translation ends the TB.
+ */
+void tlb_flush_all_cpus_synced(CPUState *src_cpu);
+/**
+ * tlb_flush_page_by_mmuidx:
+ * @cpu: CPU whose TLB should be flushed
+ * @addr: virtual address of page to be flushed
+ * @idxmap: bitmap of MMU indexes to flush
+ *
+ * Flush one page from the TLB of the specified CPU, for the specified
+ * MMU indexes.
+ */
+void tlb_flush_page_by_mmuidx(CPUState *cpu, vaddr addr,
+                              uint16_t idxmap);
+/**
+ * tlb_flush_page_by_mmuidx_all_cpus:
+ * @cpu: Originating CPU of the flush
+ * @addr: virtual address of page to be flushed
+ * @idxmap: bitmap of MMU indexes to flush
+ *
+ * Flush one page from the TLB of all CPUs, for the specified
+ * MMU indexes.
+ */
+void tlb_flush_page_by_mmuidx_all_cpus(CPUState *cpu, vaddr addr,
+                                       uint16_t idxmap);
+/**
+ * tlb_flush_page_by_mmuidx_all_cpus_synced:
+ * @cpu: Originating CPU of the flush
+ * @addr: virtual address of page to be flushed
+ * @idxmap: bitmap of MMU indexes to flush
+ *
+ * Flush one page from the TLB of all CPUs, for the specified MMU
+ * indexes like tlb_flush_page_by_mmuidx_all_cpus except the source
+ * vCPUs work is scheduled as safe work meaning all flushes will be
+ * complete once  the source vCPUs safe work is complete. This will
+ * depend on when the guests translation ends the TB.
+ */
+void tlb_flush_page_by_mmuidx_all_cpus_synced(CPUState *cpu, vaddr addr,
+                                              uint16_t idxmap);
+/**
+ * tlb_flush_by_mmuidx:
+ * @cpu: CPU whose TLB should be flushed
+ * @wait: If true ensure synchronisation by exiting the cpu_loop
+ * @idxmap: bitmap of MMU indexes to flush
+ *
+ * Flush all entries from the TLB of the specified CPU, for the specified
+ * MMU indexes.
+ */
+void tlb_flush_by_mmuidx(CPUState *cpu, uint16_t idxmap);
+/**
+ * tlb_flush_by_mmuidx_all_cpus:
+ * @cpu: Originating CPU of the flush
+ * @idxmap: bitmap of MMU indexes to flush
+ *
+ * Flush all entries from all TLBs of all CPUs, for the specified
+ * MMU indexes.
+ */
+void tlb_flush_by_mmuidx_all_cpus(CPUState *cpu, uint16_t idxmap);
+/**
+ * tlb_flush_by_mmuidx_all_cpus_synced:
+ * @cpu: Originating CPU of the flush
+ * @idxmap: bitmap of MMU indexes to flush
+ *
+ * Flush all entries from all TLBs of all CPUs, for the specified
+ * MMU indexes like tlb_flush_by_mmuidx_all_cpus except except the source
+ * vCPUs work is scheduled as safe work meaning all flushes will be
+ * complete once  the source vCPUs safe work is complete. This will
+ * depend on when the guests translation ends the TB.
+ */
+void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *cpu, uint16_t idxmap);
+
+/**
+ * tlb_flush_page_bits_by_mmuidx
+ * @cpu: CPU whose TLB should be flushed
+ * @addr: virtual address of page to be flushed
+ * @idxmap: bitmap of mmu indexes to flush
+ * @bits: number of significant bits in address
+ *
+ * Similar to tlb_flush_page_mask, but with a bitmap of indexes.
+ */
+void tlb_flush_page_bits_by_mmuidx(CPUState *cpu, vaddr addr,
+                                   uint16_t idxmap, unsigned bits);
+
+/* Similarly, with broadcast and syncing. */
+void tlb_flush_page_bits_by_mmuidx_all_cpus(CPUState *cpu, vaddr addr,
+                                            uint16_t idxmap, unsigned bits);
+void tlb_flush_page_bits_by_mmuidx_all_cpus_synced
+    (CPUState *cpu, vaddr addr, uint16_t idxmap, unsigned bits);
+
+/**
+ * tlb_flush_range_by_mmuidx
+ * @cpu: CPU whose TLB should be flushed
+ * @addr: virtual address of the start of the range to be flushed
+ * @len: length of range to be flushed
+ * @idxmap: bitmap of mmu indexes to flush
+ * @bits: number of significant bits in address
+ *
+ * For each mmuidx in @idxmap, flush all pages within [@addr,@addr+@len),
+ * comparing only the low @bits worth of each virtual page.
+ */
+void tlb_flush_range_by_mmuidx(CPUState *cpu, vaddr addr,
+                               vaddr len, uint16_t idxmap,
+                               unsigned bits);
+
+/* Similarly, with broadcast and syncing. */
+void tlb_flush_range_by_mmuidx_all_cpus(CPUState *cpu, vaddr addr,
+                                        vaddr len, uint16_t idxmap,
+                                        unsigned bits);
+void tlb_flush_range_by_mmuidx_all_cpus_synced(CPUState *cpu,
+                                               vaddr addr,
+                                               vaddr len,
+                                               uint16_t idxmap,
+                                               unsigned bits);
+
+/**
+ * tlb_set_page_full:
+ * @cpu: CPU context
+ * @mmu_idx: mmu index of the tlb to modify
+ * @addr: virtual address of the entry to add
+ * @full: the details of the tlb entry
+ *
+ * Add an entry to @cpu tlb index @mmu_idx.  All of the fields of
+ * @full must be filled, except for xlat_section, and constitute
+ * the complete description of the translated page.
+ *
+ * This is generally called by the target tlb_fill function after
+ * having performed a successful page table walk to find the physical
+ * address and attributes for the translation.
+ *
+ * At most one entry for a given virtual address is permitted. Only a
+ * single TARGET_PAGE_SIZE region is mapped; @full->lg_page_size is only
+ * used by tlb_flush_page.
+ */
+void tlb_set_page_full(CPUState *cpu, int mmu_idx, vaddr addr,
+                       CPUTLBEntryFull *full);
+
+/**
+ * tlb_set_page_with_attrs:
+ * @cpu: CPU to add this TLB entry for
+ * @addr: virtual address of page to add entry for
+ * @paddr: physical address of the page
+ * @attrs: memory transaction attributes
+ * @prot: access permissions (PAGE_READ/PAGE_WRITE/PAGE_EXEC bits)
+ * @mmu_idx: MMU index to insert TLB entry for
+ * @size: size of the page in bytes
+ *
+ * Add an entry to this CPU's TLB (a mapping from virtual address
+ * @addr to physical address @paddr) with the specified memory
+ * transaction attributes. This is generally called by the target CPU
+ * specific code after it has been called through the tlb_fill()
+ * entry point and performed a successful page table walk to find
+ * the physical address and attributes for the virtual address
+ * which provoked the TLB miss.
+ *
+ * At most one entry for a given virtual address is permitted. Only a
+ * single TARGET_PAGE_SIZE region is mapped; the supplied @size is only
+ * used by tlb_flush_page.
+ */
+void tlb_set_page_with_attrs(CPUState *cpu, vaddr addr,
+                             hwaddr paddr, MemTxAttrs attrs,
+                             int prot, int mmu_idx, vaddr size);
+/**
+ * tlb_set_page:
+ *
+ * This function is equivalent to calling tlb_set_page_with_attrs()
+ * with an @attrs argument of MEMTXATTRS_UNSPECIFIED. It's provided
+ * as a convenience for CPUs which don't use memory transaction attributes.
+ */
+void tlb_set_page(CPUState *cpu, vaddr addr,
+                  hwaddr paddr, int prot,
+                  int mmu_idx, vaddr size);
+#else
+static inline void tlb_init(CPUState *cpu)
+{
+}
+static inline void tlb_destroy(CPUState *cpu)
+{
+}
+static inline void tlb_flush_page(CPUState *cpu, vaddr addr)
+{
+}
+static inline void tlb_flush_page_all_cpus(CPUState *src, vaddr addr)
+{
+}
+static inline void tlb_flush_page_all_cpus_synced(CPUState *src, vaddr addr)
+{
+}
+static inline void tlb_flush(CPUState *cpu)
+{
+}
+static inline void tlb_flush_all_cpus(CPUState *src_cpu)
+{
+}
+static inline void tlb_flush_all_cpus_synced(CPUState *src_cpu)
+{
+}
+static inline void tlb_flush_page_by_mmuidx(CPUState *cpu,
+                                            vaddr addr, uint16_t idxmap)
+{
+}
+
+static inline void tlb_flush_by_mmuidx(CPUState *cpu, uint16_t idxmap)
+{
+}
+static inline void tlb_flush_page_by_mmuidx_all_cpus(CPUState *cpu,
+                                                     vaddr addr,
+                                                     uint16_t idxmap)
+{
+}
+static inline void tlb_flush_page_by_mmuidx_all_cpus_synced(CPUState *cpu,
+                                                            vaddr addr,
+                                                            uint16_t idxmap)
+{
+}
+static inline void tlb_flush_by_mmuidx_all_cpus(CPUState *cpu, uint16_t idxmap)
+{
+}
+
+static inline void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *cpu,
+                                                       uint16_t idxmap)
+{
+}
+static inline void tlb_flush_page_bits_by_mmuidx(CPUState *cpu,
+                                                 vaddr addr,
+                                                 uint16_t idxmap,
+                                                 unsigned bits)
+{
+}
+static inline void tlb_flush_page_bits_by_mmuidx_all_cpus(CPUState *cpu,
+                                                          vaddr addr,
+                                                          uint16_t idxmap,
+                                                          unsigned bits)
+{
+}
+static inline void
+tlb_flush_page_bits_by_mmuidx_all_cpus_synced(CPUState *cpu, vaddr addr,
+                                              uint16_t idxmap, unsigned bits)
+{
+}
+static inline void tlb_flush_range_by_mmuidx(CPUState *cpu, vaddr addr,
+                                             vaddr len, uint16_t idxmap,
+                                             unsigned bits)
+{
+}
+static inline void tlb_flush_range_by_mmuidx_all_cpus(CPUState *cpu,
+                                                      vaddr addr,
+                                                      vaddr len,
+                                                      uint16_t idxmap,
+                                                      unsigned bits)
+{
+}
+static inline void tlb_flush_range_by_mmuidx_all_cpus_synced(CPUState *cpu,
+                                                             vaddr addr,
+                                                             vaddr len,
+                                                             uint16_t idxmap,
+                                                             unsigned bits)
+{
+}
+#endif
+
+#endif /* EXEC_COMMON_H */
diff --git a/include/exec/memory-internal.h b/include/exec/memory-internal.h
index 100c1237ac..ef9816d0c1 100644
--- a/include/exec/memory-internal.h
+++ b/include/exec/memory-internal.h
@@ -20,7 +20,7 @@
 #ifndef MEMORY_INTERNAL_H
 #define MEMORY_INTERNAL_H
 
-#include "cpu.h"
+#include "exec/memory.h"
 
 #ifndef CONFIG_USER_ONLY
 static inline AddressSpaceDispatch *flatview_to_dispatch(FlatView *fv)
diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 9f2e3893f5..765290a2f4 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -20,11 +20,12 @@
 #define RAM_ADDR_H
 
 #ifndef CONFIG_USER_ONLY
-#include "cpu.h"
 #include "sysemu/xen.h"
 #include "sysemu/tcg.h"
 #include "exec/ramlist.h"
 #include "exec/ramblock.h"
+#include "exec/memory.h"
+#include "qemu/bitmap.h"
 
 extern uint64_t total_dirty_pages;
 
diff --git a/include/qemu/plugin-memory.h b/include/qemu/plugin-memory.h
index 71c1123308..6065ec7aaf 100644
--- a/include/qemu/plugin-memory.h
+++ b/include/qemu/plugin-memory.h
@@ -9,7 +9,6 @@
 #ifndef PLUGIN_MEMORY_H
 #define PLUGIN_MEMORY_H
 
-#include "exec/cpu-defs.h"
 #include "exec/hwaddr.h"
 
 struct qemu_plugin_hwaddr {
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index fd0fc08f76..88de0eb000 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -34,6 +34,7 @@
 #include "hw/i386/apic.h"
 #endif
 #include "sysemu/cpus.h"
+#include "cpu.h"
 #include "exec/cpu-all.h"
 #include "sysemu/cpu-timers.h"
 #include "exec/replay-core.h"
diff --git a/plugins/core.c b/plugins/core.c
index 3c4e26c7ed..987b5300c7 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -24,6 +24,7 @@
 #include "exec/cpu-common.h"
 
 #include "exec/exec-all.h"
+#include "exec/cpu-defs.h"
 #include "exec/tb-flush.h"
 #include "tcg/tcg.h"
 #include "tcg/tcg-op.h"
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 831295d7cd..374ef523da 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -32,6 +32,7 @@
 #endif /* CONFIG_TCG */
 #include "internals.h"
 #include "exec/exec-all.h"
+#include "exec/cpu-all.h"
 #include "hw/qdev-properties.h"
 #if !defined(CONFIG_USER_ONLY)
 #include "hw/loader.h"
diff --git a/target/sparc/gdbstub.c b/target/sparc/gdbstub.c
index a1c8fdc4d5..b3eb8d035f 100644
--- a/target/sparc/gdbstub.c
+++ b/target/sparc/gdbstub.c
@@ -20,6 +20,9 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "gdbstub/helpers.h"
+#if defined(TARGET_ABI32) && defined(CONFIG_USER_ONLY)
+#include "exec/user/abitypes.h"
+#endif
 
 #ifdef TARGET_ABI32
 #define gdb_get_rega(buf, val) gdb_get_reg32(buf, val)
-- 
2.43.0


