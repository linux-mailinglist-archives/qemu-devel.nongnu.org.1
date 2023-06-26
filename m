Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D12E73E3E7
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 17:48:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDoKv-0001Tr-Sm; Mon, 26 Jun 2023 11:41:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDoJz-0000L4-D2
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 11:40:08 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDoJs-0002sv-NN
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 11:40:07 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-313f59cd193so745774f8f.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 08:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687793999; x=1690385999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qri1HqOLSSHIT8+vbGm4od3gX3wKYAWr8GRUXx/Bq/s=;
 b=AXzZpu86YKWdPcuVrntZlCdyujc/S3A+MSFtihIjt5We3b2BhUFrw+VaMpMmrzG/Ww
 lX2n+mEkXUjYtK1LivUosl2f7PH5kRXvJtIOOoKuAa6G0v1xnuqhPX5klon3Ezay1OV5
 uT/gTYIWalzEVUhCBMEIeRaPC71vMwhWhCjFicreSaP/OwCFFUzBRUUNuHRTOvECBW1x
 hhw8x+45vRUCLzsyuhlcbRtkG/XqknxLh4jj3UgVc5qp5LW0Vt5Zsnk9FEjKhXderjl7
 QKXBuGN1jjiJesc/3m0rrvuUigiPpv2V7frwWg7i31c+McCxLpcPSDvWGAwV1nhjfezC
 FuKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687793999; x=1690385999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qri1HqOLSSHIT8+vbGm4od3gX3wKYAWr8GRUXx/Bq/s=;
 b=gr3fLeC+suvKIFgplLdXpvNRjFtFk4QEc0zF+Cp3T9VfLUihgVOhfiUr4O66TC++ly
 OY8OaxudCTJkH9YCU4VrQ0LBueGQjujtBLaMwwS0381WJ7PGKOFbNROLB7n0KSLaP+7C
 zSYsp1l+9b3dBstqrmbMcdksDFB1UIqiJvaVoJI47hWF7dFWBVZnxs6/mFGeuvlS7j8t
 1r97hzRE7MUzYcZWoR+kKm2oxvlt+Qqwr/cWfJDdC+X1fpWHKLpeGuZkE1fhpjzyJsZE
 gSYn3wgrJgkg5Jtid0ge4cU8EUwZyxXPVloAgicrptOsUA/VnuWFmtwAwOB63o6hLYSc
 l66A==
X-Gm-Message-State: AC+VfDxHQvQO8SLj8O/0qx4YP48arVVXMBgTCxtB8AOyVfa90IR1RuB7
 iMY1dB+s2kqwwK8GsLdHceVnZSELnL7CX1pI+deTg8hQ
X-Google-Smtp-Source: ACHHUZ7+qeBjXE1++lSoeW1ytGwKAY8PJ4kfP2F0Zfc3tnh2LfZNfFuoRuzvVtvaQwmxPxtpJaLRjg==
X-Received: by 2002:a5d:4684:0:b0:313:e3b9:21a4 with SMTP id
 u4-20020a5d4684000000b00313e3b921a4mr5445689wrq.48.1687793999192; 
 Mon, 26 Jun 2023 08:39:59 -0700 (PDT)
Received: from localhost.localdomain ([139.47.42.170])
 by smtp.gmail.com with ESMTPSA id
 t1-20020adfe441000000b00313f45f74a8sm2164178wrm.103.2023.06.26.08.39.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 08:39:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 20/22] accel/tcg: Store some tlb flags in CPUTLBEntryFull
Date: Mon, 26 Jun 2023 17:39:43 +0200
Message-Id: <20230626153945.76180-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230626153945.76180-1-richard.henderson@linaro.org>
References: <20230626153945.76180-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x436.google.com
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

We have run out of bits we can use within the CPUTLBEntry comparators,
as TLB_FLAGS_MASK cannot overlap alignment.

Store slow_flags[] in CPUTLBEntryFull, and merge with the flags from
the comparator.  A new TLB_FORCE_SLOW bit is set within the comparator
as an indication that the slow path must be used.

Move TLB_BSWAP to TLB_SLOW_FLAGS_MASK.  Since we are out of bits,
we cannot create a new bit without moving an old one.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h  | 21 +++++++--
 include/exec/cpu-defs.h |  6 +++
 include/hw/core/cpu.h   |  1 +
 accel/tcg/cputlb.c      | 98 ++++++++++++++++++++++++-----------------
 4 files changed, 82 insertions(+), 44 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 09bf4c0cc6..4422f4bb07 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -327,17 +327,30 @@ CPUArchState *cpu_copy(CPUArchState *env);
 #define TLB_MMIO            (1 << (TARGET_PAGE_BITS_MIN - 3))
 /* Set if TLB entry contains a watchpoint.  */
 #define TLB_WATCHPOINT      (1 << (TARGET_PAGE_BITS_MIN - 4))
-/* Set if TLB entry requires byte swap.  */
-#define TLB_BSWAP           (1 << (TARGET_PAGE_BITS_MIN - 5))
+/* Set if the slow path must be used; more flags in CPUTLBEntryFull. */
+#define TLB_FORCE_SLOW      (1 << (TARGET_PAGE_BITS_MIN - 5))
 /* Set if TLB entry writes ignored.  */
 #define TLB_DISCARD_WRITE   (1 << (TARGET_PAGE_BITS_MIN - 6))
 
-/* Use this mask to check interception with an alignment mask
+/*
+ * Use this mask to check interception with an alignment mask
  * in a TCG backend.
  */
 #define TLB_FLAGS_MASK \
     (TLB_INVALID_MASK | TLB_NOTDIRTY | TLB_MMIO \
-    | TLB_WATCHPOINT | TLB_BSWAP | TLB_DISCARD_WRITE)
+    | TLB_WATCHPOINT | TLB_FORCE_SLOW | TLB_DISCARD_WRITE)
+
+/*
+ * Flags stored in CPUTLBEntryFull.slow_flags[x].
+ * TLB_FORCE_SLOW must be set in CPUTLBEntry.addr_idx[x].
+ */
+/* Set if TLB entry requires byte swap.  */
+#define TLB_BSWAP            (1 << 0)
+
+#define TLB_SLOW_FLAGS_MASK  TLB_BSWAP
+
+/* The two sets of flags must not overlap. */
+QEMU_BUILD_BUG_ON(TLB_FLAGS_MASK & TLB_SLOW_FLAGS_MASK);
 
 /**
  * tlb_hit_page: return true if page aligned @addr is a hit against the
diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index e6a079402e..fb4c8d480f 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -124,6 +124,12 @@ typedef struct CPUTLBEntryFull {
     /* @lg_page_size contains the log2 of the page size. */
     uint8_t lg_page_size;
 
+    /*
+     * Additional tlb flags for use by the slow path. If non-zero,
+     * the corresponding CPUTLBEntry comparator must have TLB_FORCE_SLOW.
+     */
+    uint8_t slow_flags[MMU_ACCESS_COUNT];
+
     /*
      * Allow target-specific additions to this structure.
      * This may be used to cache items from the guest cpu
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 3b765beb9b..eda0230a02 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -84,6 +84,7 @@ typedef enum MMUAccessType {
     MMU_DATA_LOAD  = 0,
     MMU_DATA_STORE = 1,
     MMU_INST_FETCH = 2
+#define MMU_ACCESS_COUNT 3
 } MMUAccessType;
 
 typedef struct CPUWatchpoint CPUWatchpoint;
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 5666a8e23a..3671846744 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1107,6 +1107,24 @@ static void tlb_add_large_page(CPUArchState *env, int mmu_idx,
     env_tlb(env)->d[mmu_idx].large_page_mask = lp_mask;
 }
 
+static inline void tlb_set_compare(CPUTLBEntryFull *full, CPUTLBEntry *ent,
+                                   target_ulong address, int flags,
+                                   MMUAccessType access_type, bool enable)
+{
+    if (enable) {
+        address |= flags & TLB_FLAGS_MASK;
+        flags &= TLB_SLOW_FLAGS_MASK;
+        if (flags) {
+            address |= TLB_FORCE_SLOW;
+        }
+    } else {
+        address = -1;
+        flags = 0;
+    }
+    ent->addr_idx[access_type] = address;
+    full->slow_flags[access_type] = flags;
+}
+
 /*
  * Add a new TLB entry. At most one entry for a given virtual address
  * is permitted. Only a single TARGET_PAGE_SIZE region is mapped, the
@@ -1122,9 +1140,7 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
     CPUTLB *tlb = env_tlb(env);
     CPUTLBDesc *desc = &tlb->d[mmu_idx];
     MemoryRegionSection *section;
-    unsigned int index;
-    vaddr address;
-    vaddr write_address;
+    unsigned int index, read_flags, write_flags;
     uintptr_t addend;
     CPUTLBEntry *te, tn;
     hwaddr iotlb, xlat, sz, paddr_page;
@@ -1153,13 +1169,13 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
               " prot=%x idx=%d\n",
               addr, full->phys_addr, prot, mmu_idx);
 
-    address = addr_page;
+    read_flags = 0;
     if (full->lg_page_size < TARGET_PAGE_BITS) {
         /* Repeat the MMU check and TLB fill on every access.  */
-        address |= TLB_INVALID_MASK;
+        read_flags |= TLB_INVALID_MASK;
     }
     if (full->attrs.byte_swap) {
-        address |= TLB_BSWAP;
+        read_flags |= TLB_BSWAP;
     }
 
     is_ram = memory_region_is_ram(section->mr);
@@ -1173,7 +1189,7 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
         addend = 0;
     }
 
-    write_address = address;
+    write_flags = read_flags;
     if (is_ram) {
         iotlb = memory_region_get_ram_addr(section->mr) + xlat;
         /*
@@ -1182,9 +1198,9 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
          */
         if (prot & PAGE_WRITE) {
             if (section->readonly) {
-                write_address |= TLB_DISCARD_WRITE;
+                write_flags |= TLB_DISCARD_WRITE;
             } else if (cpu_physical_memory_is_clean(iotlb)) {
-                write_address |= TLB_NOTDIRTY;
+                write_flags |= TLB_NOTDIRTY;
             }
         }
     } else {
@@ -1195,9 +1211,9 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
          * Reads to romd devices go through the ram_ptr found above,
          * but of course reads to I/O must go through MMIO.
          */
-        write_address |= TLB_MMIO;
+        write_flags |= TLB_MMIO;
         if (!is_romd) {
-            address = write_address;
+            read_flags = write_flags;
         }
     }
 
@@ -1242,7 +1258,7 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
      * TARGET_PAGE_BITS, and either
      *  + the ram_addr_t of the page base of the target RAM (RAM)
      *  + the offset within section->mr of the page base (I/O, ROMD)
-     * We subtract the vaddr_page (which is page aligned and thus won't
+     * We subtract addr_page (which is page aligned and thus won't
      * disturb the low bits) to give an offset which can be added to the
      * (non-page-aligned) vaddr of the eventual memory access to get
      * the MemoryRegion offset for the access. Note that the vaddr we
@@ -1250,36 +1266,30 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
      * vaddr we add back in io_readx()/io_writex()/get_page_addr_code().
      */
     desc->fulltlb[index] = *full;
-    desc->fulltlb[index].xlat_section = iotlb - addr_page;
-    desc->fulltlb[index].phys_addr = paddr_page;
+    full = &desc->fulltlb[index];
+    full->xlat_section = iotlb - addr_page;
+    full->phys_addr = paddr_page;
 
     /* Now calculate the new entry */
     tn.addend = addend - addr_page;
-    if (prot & PAGE_READ) {
-        tn.addr_read = address;
-        if (wp_flags & BP_MEM_READ) {
-            tn.addr_read |= TLB_WATCHPOINT;
-        }
-    } else {
-        tn.addr_read = -1;
-    }
 
-    if (prot & PAGE_EXEC) {
-        tn.addr_code = address;
-    } else {
-        tn.addr_code = -1;
-    }
+    tlb_set_compare(full, &tn, addr_page, read_flags,
+                    MMU_INST_FETCH, prot & PAGE_EXEC);
 
-    tn.addr_write = -1;
-    if (prot & PAGE_WRITE) {
-        tn.addr_write = write_address;
-        if (prot & PAGE_WRITE_INV) {
-            tn.addr_write |= TLB_INVALID_MASK;
-        }
-        if (wp_flags & BP_MEM_WRITE) {
-            tn.addr_write |= TLB_WATCHPOINT;
-        }
+    if (wp_flags & BP_MEM_READ) {
+        read_flags |= TLB_WATCHPOINT;
     }
+    tlb_set_compare(full, &tn, addr_page, read_flags,
+                    MMU_DATA_LOAD, prot & PAGE_READ);
+
+    if (prot & PAGE_WRITE_INV) {
+        write_flags |= TLB_INVALID_MASK;
+    }
+    if (wp_flags & BP_MEM_WRITE) {
+        write_flags |= TLB_WATCHPOINT;
+    }
+    tlb_set_compare(full, &tn, addr_page, write_flags,
+                    MMU_DATA_STORE, prot & PAGE_WRITE);
 
     copy_tlb_helper_locked(te, &tn);
     tlb_n_used_entries_inc(env, mmu_idx);
@@ -1509,7 +1519,8 @@ static int probe_access_internal(CPUArchState *env, vaddr addr,
     CPUTLBEntry *entry = tlb_entry(env, mmu_idx, addr);
     uint64_t tlb_addr = tlb_read_idx(entry, access_type);
     vaddr page_addr = addr & TARGET_PAGE_MASK;
-    int flags = TLB_FLAGS_MASK;
+    int flags = TLB_FLAGS_MASK & ~TLB_FORCE_SLOW;
+    CPUTLBEntryFull *full;
 
     if (!tlb_hit_page(tlb_addr, page_addr)) {
         if (!victim_tlb_hit(env, mmu_idx, index, access_type, page_addr)) {
@@ -1538,7 +1549,8 @@ static int probe_access_internal(CPUArchState *env, vaddr addr,
     }
     flags &= tlb_addr;
 
-    *pfull = &env_tlb(env)->d[mmu_idx].fulltlb[index];
+    *pfull = full = &env_tlb(env)->d[mmu_idx].fulltlb[index];
+    flags |= full->slow_flags[access_type];
 
     /* Fold all "mmio-like" bits into TLB_MMIO.  This is not RAM.  */
     if (unlikely(flags & ~(TLB_WATCHPOINT | TLB_NOTDIRTY))) {
@@ -1761,6 +1773,8 @@ static bool mmu_lookup1(CPUArchState *env, MMULookupPageData *data,
     CPUTLBEntry *entry = tlb_entry(env, mmu_idx, addr);
     uint64_t tlb_addr = tlb_read_idx(entry, access_type);
     bool maybe_resized = false;
+    CPUTLBEntryFull *full;
+    int flags;
 
     /* If the TLB entry is for a different page, reload and try again.  */
     if (!tlb_hit(tlb_addr, addr)) {
@@ -1774,8 +1788,12 @@ static bool mmu_lookup1(CPUArchState *env, MMULookupPageData *data,
         tlb_addr = tlb_read_idx(entry, access_type) & ~TLB_INVALID_MASK;
     }
 
-    data->flags = tlb_addr & TLB_FLAGS_MASK;
-    data->full = &env_tlb(env)->d[mmu_idx].fulltlb[index];
+    full = &env_tlb(env)->d[mmu_idx].fulltlb[index];
+    flags = tlb_addr & (TLB_FLAGS_MASK & ~TLB_FORCE_SLOW);
+    flags |= full->slow_flags[access_type];
+
+    data->full = full;
+    data->flags = flags;
     /* Compute haddr speculatively; depending on flags it might be invalid. */
     data->haddr = (void *)((uintptr_t)addr + entry->addend);
 
-- 
2.34.1


