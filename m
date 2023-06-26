Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8F073E3BD
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 17:43:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDoKe-000159-AP; Mon, 26 Jun 2023 11:40:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDoJr-0000Ij-4q
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 11:39:59 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDoJk-0002nd-Jl
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 11:39:58 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3113dabc549so5071421f8f.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 08:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687793987; x=1690385987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZzRZxXHRRLN5qy74ZXj69wS/+DuBucVdtdp4csoOd4Y=;
 b=CXLjl7LH2V+zMIwH6VetWa2eOEPPoQe9F10UvSUjZLJ4S1gogDf2IOGMiPzopOwn1G
 zwq78qjM07kig14gOh/V+86Y8JYS0OWWoVFgNDNxIgwBEHYXjSOaSYqFliHYuxi+LFGz
 wgTfTQ4GgfbJdmmhxUqnAz6JiCApbPk2CUFZAcVV8anvMoCv4B8ItLdlVj3Dg+2yku6U
 LomTyse6Xcj+YTmplSJrwxOVYMiWWk0sHQqphpvwaJYHP7hVZPIs5Zz10gPyXcNOqTeY
 ezwAGeCGYOZKkc+TXLa4RYfqxYDFXXpWDsxxuNj7rOcCKfOelc5wO8Gjpyr0zB/f9ak0
 cFQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687793987; x=1690385987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZzRZxXHRRLN5qy74ZXj69wS/+DuBucVdtdp4csoOd4Y=;
 b=HMGy/8HQGnuRpXK6laJLyfEs8cs8MTnPKVpmEWO7lcHFWKUsuwgIv7VPzbWts9KIzx
 Iev29qXMpxMFjuW96WCd0sqaVwFy/vOVv7+O3TZtg96/KaIBvxINrpSdXlxX0LmDt8qX
 heb6EpQ3GcL7ciUZxBETltaMCTIc4uqwHjf3X4pnJMLgfwcoZiaIQDhJGHXNkhC2tU5G
 WetFbYn/lopqmZmZyfkS8hXDB6mcgjAjM/ZSSwdN3ltaXRLEecGZpLGY4Q6ll9YbLBbH
 /nDEX3KWffmSNd3Xom1v784HwICX6VOZ72G36jWq7NPCa5SiQJzwvQS9f5Hs0wFGFBC7
 gf2A==
X-Gm-Message-State: AC+VfDxLazkBRUSYXxKDlEbXKW+xeGt4PIZ3oXdNT0eoodLrOfB8FbLo
 YiDwAgZ7MUcOdSMXKalVEipWi8/OPDSbgBiooMUVVZKE
X-Google-Smtp-Source: ACHHUZ6ndn7v2RhOSEO/qAnn4UnwO3Dtas/g0gGR6c46mvHTe7FhX8YpboPUYnQuh91kd18CJtwZdA==
X-Received: by 2002:adf:e8c1:0:b0:30a:ea8a:7a6d with SMTP id
 k1-20020adfe8c1000000b0030aea8a7a6dmr29979853wrn.16.1687793987230; 
 Mon, 26 Jun 2023 08:39:47 -0700 (PDT)
Received: from localhost.localdomain ([139.47.42.170])
 by smtp.gmail.com with ESMTPSA id
 t1-20020adfe441000000b00313f45f74a8sm2164178wrm.103.2023.06.26.08.39.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 08:39:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
Subject: [PULL 01/22] accel: Replace target_ulong in tlb_*()
Date: Mon, 26 Jun 2023 17:39:24 +0200
Message-Id: <20230626153945.76180-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230626153945.76180-1-richard.henderson@linaro.org>
References: <20230626153945.76180-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42b.google.com
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

From: Anton Johansson <anjo@rev.ng>

Replaces target_ulong with vaddr for guest virtual addresses in tlb_*()
functions and auxilliary structs.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230621135633.1649-2-anjo@rev.ng>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-defs.h      |   4 +-
 include/exec/exec-all.h      |  79 ++++++++--------
 include/qemu/plugin-memory.h |   2 +-
 accel/stubs/tcg-stub.c       |   2 +-
 accel/tcg/cputlb.c           | 177 +++++++++++++++++------------------
 accel/tcg/tb-maint.c         |   2 +-
 6 files changed, 131 insertions(+), 135 deletions(-)

diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index 4cb77c8dec..e6a079402e 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -147,8 +147,8 @@ typedef struct CPUTLBDesc {
      * we must flush the entire tlb.  The region is matched if
      * (addr & large_page_mask) == large_page_addr.
      */
-    target_ulong large_page_addr;
-    target_ulong large_page_mask;
+    vaddr large_page_addr;
+    vaddr large_page_mask;
     /* host time (in ns) at the beginning of the time window */
     int64_t window_begin_ns;
     /* maximum number of entries observed in the window */
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 698943d58f..f5508e242b 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -94,7 +94,7 @@ void tlb_destroy(CPUState *cpu);
  * Flush one page from the TLB of the specified CPU, for all
  * MMU indexes.
  */
-void tlb_flush_page(CPUState *cpu, target_ulong addr);
+void tlb_flush_page(CPUState *cpu, vaddr addr);
 /**
  * tlb_flush_page_all_cpus:
  * @cpu: src CPU of the flush
@@ -103,7 +103,7 @@ void tlb_flush_page(CPUState *cpu, target_ulong addr);
  * Flush one page from the TLB of the specified CPU, for all
  * MMU indexes.
  */
-void tlb_flush_page_all_cpus(CPUState *src, target_ulong addr);
+void tlb_flush_page_all_cpus(CPUState *src, vaddr addr);
 /**
  * tlb_flush_page_all_cpus_synced:
  * @cpu: src CPU of the flush
@@ -115,7 +115,7 @@ void tlb_flush_page_all_cpus(CPUState *src, target_ulong addr);
  * the source vCPUs safe work is complete. This will depend on when
  * the guests translation ends the TB.
  */
-void tlb_flush_page_all_cpus_synced(CPUState *src, target_ulong addr);
+void tlb_flush_page_all_cpus_synced(CPUState *src, vaddr addr);
 /**
  * tlb_flush:
  * @cpu: CPU whose TLB should be flushed
@@ -150,7 +150,7 @@ void tlb_flush_all_cpus_synced(CPUState *src_cpu);
  * Flush one page from the TLB of the specified CPU, for the specified
  * MMU indexes.
  */
-void tlb_flush_page_by_mmuidx(CPUState *cpu, target_ulong addr,
+void tlb_flush_page_by_mmuidx(CPUState *cpu, vaddr addr,
                               uint16_t idxmap);
 /**
  * tlb_flush_page_by_mmuidx_all_cpus:
@@ -161,7 +161,7 @@ void tlb_flush_page_by_mmuidx(CPUState *cpu, target_ulong addr,
  * Flush one page from the TLB of all CPUs, for the specified
  * MMU indexes.
  */
-void tlb_flush_page_by_mmuidx_all_cpus(CPUState *cpu, target_ulong addr,
+void tlb_flush_page_by_mmuidx_all_cpus(CPUState *cpu, vaddr addr,
                                        uint16_t idxmap);
 /**
  * tlb_flush_page_by_mmuidx_all_cpus_synced:
@@ -175,7 +175,7 @@ void tlb_flush_page_by_mmuidx_all_cpus(CPUState *cpu, target_ulong addr,
  * complete once  the source vCPUs safe work is complete. This will
  * depend on when the guests translation ends the TB.
  */
-void tlb_flush_page_by_mmuidx_all_cpus_synced(CPUState *cpu, target_ulong addr,
+void tlb_flush_page_by_mmuidx_all_cpus_synced(CPUState *cpu, vaddr addr,
                                               uint16_t idxmap);
 /**
  * tlb_flush_by_mmuidx:
@@ -218,14 +218,14 @@ void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *cpu, uint16_t idxmap);
  *
  * Similar to tlb_flush_page_mask, but with a bitmap of indexes.
  */
-void tlb_flush_page_bits_by_mmuidx(CPUState *cpu, target_ulong addr,
+void tlb_flush_page_bits_by_mmuidx(CPUState *cpu, vaddr addr,
                                    uint16_t idxmap, unsigned bits);
 
 /* Similarly, with broadcast and syncing. */
-void tlb_flush_page_bits_by_mmuidx_all_cpus(CPUState *cpu, target_ulong addr,
+void tlb_flush_page_bits_by_mmuidx_all_cpus(CPUState *cpu, vaddr addr,
                                             uint16_t idxmap, unsigned bits);
 void tlb_flush_page_bits_by_mmuidx_all_cpus_synced
-    (CPUState *cpu, target_ulong addr, uint16_t idxmap, unsigned bits);
+    (CPUState *cpu, vaddr addr, uint16_t idxmap, unsigned bits);
 
 /**
  * tlb_flush_range_by_mmuidx
@@ -238,17 +238,17 @@ void tlb_flush_page_bits_by_mmuidx_all_cpus_synced
  * For each mmuidx in @idxmap, flush all pages within [@addr,@addr+@len),
  * comparing only the low @bits worth of each virtual page.
  */
-void tlb_flush_range_by_mmuidx(CPUState *cpu, target_ulong addr,
-                               target_ulong len, uint16_t idxmap,
+void tlb_flush_range_by_mmuidx(CPUState *cpu, vaddr addr,
+                               vaddr len, uint16_t idxmap,
                                unsigned bits);
 
 /* Similarly, with broadcast and syncing. */
-void tlb_flush_range_by_mmuidx_all_cpus(CPUState *cpu, target_ulong addr,
-                                        target_ulong len, uint16_t idxmap,
+void tlb_flush_range_by_mmuidx_all_cpus(CPUState *cpu, vaddr addr,
+                                        vaddr len, uint16_t idxmap,
                                         unsigned bits);
 void tlb_flush_range_by_mmuidx_all_cpus_synced(CPUState *cpu,
-                                               target_ulong addr,
-                                               target_ulong len,
+                                               vaddr addr,
+                                               vaddr len,
                                                uint16_t idxmap,
                                                unsigned bits);
 
@@ -256,7 +256,7 @@ void tlb_flush_range_by_mmuidx_all_cpus_synced(CPUState *cpu,
  * tlb_set_page_full:
  * @cpu: CPU context
  * @mmu_idx: mmu index of the tlb to modify
- * @vaddr: virtual address of the entry to add
+ * @addr: virtual address of the entry to add
  * @full: the details of the tlb entry
  *
  * Add an entry to @cpu tlb index @mmu_idx.  All of the fields of
@@ -271,13 +271,13 @@ void tlb_flush_range_by_mmuidx_all_cpus_synced(CPUState *cpu,
  * single TARGET_PAGE_SIZE region is mapped; @full->lg_page_size is only
  * used by tlb_flush_page.
  */
-void tlb_set_page_full(CPUState *cpu, int mmu_idx, target_ulong vaddr,
+void tlb_set_page_full(CPUState *cpu, int mmu_idx, vaddr addr,
                        CPUTLBEntryFull *full);
 
 /**
  * tlb_set_page_with_attrs:
  * @cpu: CPU to add this TLB entry for
- * @vaddr: virtual address of page to add entry for
+ * @addr: virtual address of page to add entry for
  * @paddr: physical address of the page
  * @attrs: memory transaction attributes
  * @prot: access permissions (PAGE_READ/PAGE_WRITE/PAGE_EXEC bits)
@@ -285,7 +285,7 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx, target_ulong vaddr,
  * @size: size of the page in bytes
  *
  * Add an entry to this CPU's TLB (a mapping from virtual address
- * @vaddr to physical address @paddr) with the specified memory
+ * @addr to physical address @paddr) with the specified memory
  * transaction attributes. This is generally called by the target CPU
  * specific code after it has been called through the tlb_fill()
  * entry point and performed a successful page table walk to find
@@ -296,18 +296,18 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx, target_ulong vaddr,
  * single TARGET_PAGE_SIZE region is mapped; the supplied @size is only
  * used by tlb_flush_page.
  */
-void tlb_set_page_with_attrs(CPUState *cpu, target_ulong vaddr,
+void tlb_set_page_with_attrs(CPUState *cpu, vaddr addr,
                              hwaddr paddr, MemTxAttrs attrs,
-                             int prot, int mmu_idx, target_ulong size);
+                             int prot, int mmu_idx, vaddr size);
 /* tlb_set_page:
  *
  * This function is equivalent to calling tlb_set_page_with_attrs()
  * with an @attrs argument of MEMTXATTRS_UNSPECIFIED. It's provided
  * as a convenience for CPUs which don't use memory transaction attributes.
  */
-void tlb_set_page(CPUState *cpu, target_ulong vaddr,
+void tlb_set_page(CPUState *cpu, vaddr addr,
                   hwaddr paddr, int prot,
-                  int mmu_idx, target_ulong size);
+                  int mmu_idx, vaddr size);
 #else
 static inline void tlb_init(CPUState *cpu)
 {
@@ -315,14 +315,13 @@ static inline void tlb_init(CPUState *cpu)
 static inline void tlb_destroy(CPUState *cpu)
 {
 }
-static inline void tlb_flush_page(CPUState *cpu, target_ulong addr)
+static inline void tlb_flush_page(CPUState *cpu, vaddr addr)
 {
 }
-static inline void tlb_flush_page_all_cpus(CPUState *src, target_ulong addr)
+static inline void tlb_flush_page_all_cpus(CPUState *src, vaddr addr)
 {
 }
-static inline void tlb_flush_page_all_cpus_synced(CPUState *src,
-                                                  target_ulong addr)
+static inline void tlb_flush_page_all_cpus_synced(CPUState *src, vaddr addr)
 {
 }
 static inline void tlb_flush(CPUState *cpu)
@@ -335,7 +334,7 @@ static inline void tlb_flush_all_cpus_synced(CPUState *src_cpu)
 {
 }
 static inline void tlb_flush_page_by_mmuidx(CPUState *cpu,
-                                            target_ulong addr, uint16_t idxmap)
+                                            vaddr addr, uint16_t idxmap)
 {
 }
 
@@ -343,12 +342,12 @@ static inline void tlb_flush_by_mmuidx(CPUState *cpu, uint16_t idxmap)
 {
 }
 static inline void tlb_flush_page_by_mmuidx_all_cpus(CPUState *cpu,
-                                                     target_ulong addr,
+                                                     vaddr addr,
                                                      uint16_t idxmap)
 {
 }
 static inline void tlb_flush_page_by_mmuidx_all_cpus_synced(CPUState *cpu,
-                                                            target_ulong addr,
+                                                            vaddr addr,
                                                             uint16_t idxmap)
 {
 }
@@ -361,37 +360,37 @@ static inline void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *cpu,
 {
 }
 static inline void tlb_flush_page_bits_by_mmuidx(CPUState *cpu,
-                                                 target_ulong addr,
+                                                 vaddr addr,
                                                  uint16_t idxmap,
                                                  unsigned bits)
 {
 }
 static inline void tlb_flush_page_bits_by_mmuidx_all_cpus(CPUState *cpu,
-                                                          target_ulong addr,
+                                                          vaddr addr,
                                                           uint16_t idxmap,
                                                           unsigned bits)
 {
 }
 static inline void
-tlb_flush_page_bits_by_mmuidx_all_cpus_synced(CPUState *cpu, target_ulong addr,
+tlb_flush_page_bits_by_mmuidx_all_cpus_synced(CPUState *cpu, vaddr addr,
                                               uint16_t idxmap, unsigned bits)
 {
 }
-static inline void tlb_flush_range_by_mmuidx(CPUState *cpu, target_ulong addr,
-                                             target_ulong len, uint16_t idxmap,
+static inline void tlb_flush_range_by_mmuidx(CPUState *cpu, vaddr addr,
+                                             vaddr len, uint16_t idxmap,
                                              unsigned bits)
 {
 }
 static inline void tlb_flush_range_by_mmuidx_all_cpus(CPUState *cpu,
-                                                      target_ulong addr,
-                                                      target_ulong len,
+                                                      vaddr addr,
+                                                      vaddr len,
                                                       uint16_t idxmap,
                                                       unsigned bits)
 {
 }
 static inline void tlb_flush_range_by_mmuidx_all_cpus_synced(CPUState *cpu,
-                                                             target_ulong addr,
-                                                             target_long len,
+                                                             vaddr addr,
+                                                             vaddr len,
                                                              uint16_t idxmap,
                                                              unsigned bits)
 {
@@ -663,7 +662,7 @@ static inline void mmap_lock(void) {}
 static inline void mmap_unlock(void) {}
 
 void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length);
-void tlb_set_dirty(CPUState *cpu, target_ulong vaddr);
+void tlb_set_dirty(CPUState *cpu, vaddr addr);
 
 MemoryRegionSection *
 address_space_translate_for_iotlb(CPUState *cpu, int asidx, hwaddr addr,
diff --git a/include/qemu/plugin-memory.h b/include/qemu/plugin-memory.h
index 6fd539022a..43165f2452 100644
--- a/include/qemu/plugin-memory.h
+++ b/include/qemu/plugin-memory.h
@@ -37,7 +37,7 @@ struct qemu_plugin_hwaddr {
  * It would only fail if not called from an instrumented memory access
  * which would be an abuse of the API.
  */
-bool tlb_plugin_lookup(CPUState *cpu, target_ulong addr, int mmu_idx,
+bool tlb_plugin_lookup(CPUState *cpu, vaddr addr, int mmu_idx,
                        bool is_store, struct qemu_plugin_hwaddr *data);
 
 #endif /* PLUGIN_MEMORY_H */
diff --git a/accel/stubs/tcg-stub.c b/accel/stubs/tcg-stub.c
index 813695b402..0998e601ad 100644
--- a/accel/stubs/tcg-stub.c
+++ b/accel/stubs/tcg-stub.c
@@ -18,7 +18,7 @@ void tb_flush(CPUState *cpu)
 {
 }
 
-void tlb_set_dirty(CPUState *cpu, target_ulong vaddr)
+void tlb_set_dirty(CPUState *cpu, vaddr vaddr)
 {
 }
 
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 14ce97c33b..5caeccb52d 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -427,7 +427,7 @@ void tlb_flush_all_cpus_synced(CPUState *src_cpu)
 }
 
 static bool tlb_hit_page_mask_anyprot(CPUTLBEntry *tlb_entry,
-                                      target_ulong page, target_ulong mask)
+                                      vaddr page, vaddr mask)
 {
     page &= mask;
     mask &= TARGET_PAGE_MASK | TLB_INVALID_MASK;
@@ -437,8 +437,7 @@ static bool tlb_hit_page_mask_anyprot(CPUTLBEntry *tlb_entry,
             page == (tlb_entry->addr_code & mask));
 }
 
-static inline bool tlb_hit_page_anyprot(CPUTLBEntry *tlb_entry,
-                                        target_ulong page)
+static inline bool tlb_hit_page_anyprot(CPUTLBEntry *tlb_entry, vaddr page)
 {
     return tlb_hit_page_mask_anyprot(tlb_entry, page, -1);
 }
@@ -454,8 +453,8 @@ static inline bool tlb_entry_is_empty(const CPUTLBEntry *te)
 
 /* Called with tlb_c.lock held */
 static bool tlb_flush_entry_mask_locked(CPUTLBEntry *tlb_entry,
-                                        target_ulong page,
-                                        target_ulong mask)
+                                        vaddr page,
+                                        vaddr mask)
 {
     if (tlb_hit_page_mask_anyprot(tlb_entry, page, mask)) {
         memset(tlb_entry, -1, sizeof(*tlb_entry));
@@ -464,16 +463,15 @@ static bool tlb_flush_entry_mask_locked(CPUTLBEntry *tlb_entry,
     return false;
 }
 
-static inline bool tlb_flush_entry_locked(CPUTLBEntry *tlb_entry,
-                                          target_ulong page)
+static inline bool tlb_flush_entry_locked(CPUTLBEntry *tlb_entry, vaddr page)
 {
     return tlb_flush_entry_mask_locked(tlb_entry, page, -1);
 }
 
 /* Called with tlb_c.lock held */
 static void tlb_flush_vtlb_page_mask_locked(CPUArchState *env, int mmu_idx,
-                                            target_ulong page,
-                                            target_ulong mask)
+                                            vaddr page,
+                                            vaddr mask)
 {
     CPUTLBDesc *d = &env_tlb(env)->d[mmu_idx];
     int k;
@@ -487,21 +485,20 @@ static void tlb_flush_vtlb_page_mask_locked(CPUArchState *env, int mmu_idx,
 }
 
 static inline void tlb_flush_vtlb_page_locked(CPUArchState *env, int mmu_idx,
-                                              target_ulong page)
+                                              vaddr page)
 {
     tlb_flush_vtlb_page_mask_locked(env, mmu_idx, page, -1);
 }
 
-static void tlb_flush_page_locked(CPUArchState *env, int midx,
-                                  target_ulong page)
+static void tlb_flush_page_locked(CPUArchState *env, int midx, vaddr page)
 {
-    target_ulong lp_addr = env_tlb(env)->d[midx].large_page_addr;
-    target_ulong lp_mask = env_tlb(env)->d[midx].large_page_mask;
+    vaddr lp_addr = env_tlb(env)->d[midx].large_page_addr;
+    vaddr lp_mask = env_tlb(env)->d[midx].large_page_mask;
 
     /* Check if we need to flush due to large pages.  */
     if ((page & lp_mask) == lp_addr) {
-        tlb_debug("forcing full flush midx %d ("
-                  TARGET_FMT_lx "/" TARGET_FMT_lx ")\n",
+        tlb_debug("forcing full flush midx %d (%"
+                  VADDR_PRIx "/%" VADDR_PRIx ")\n",
                   midx, lp_addr, lp_mask);
         tlb_flush_one_mmuidx_locked(env, midx, get_clock_realtime());
     } else {
@@ -522,7 +519,7 @@ static void tlb_flush_page_locked(CPUArchState *env, int midx,
  * at @addr from the tlbs indicated by @idxmap from @cpu.
  */
 static void tlb_flush_page_by_mmuidx_async_0(CPUState *cpu,
-                                             target_ulong addr,
+                                             vaddr addr,
                                              uint16_t idxmap)
 {
     CPUArchState *env = cpu->env_ptr;
@@ -530,7 +527,7 @@ static void tlb_flush_page_by_mmuidx_async_0(CPUState *cpu,
 
     assert_cpu_is_self(cpu);
 
-    tlb_debug("page addr:" TARGET_FMT_lx " mmu_map:0x%x\n", addr, idxmap);
+    tlb_debug("page addr: %" VADDR_PRIx " mmu_map:0x%x\n", addr, idxmap);
 
     qemu_spin_lock(&env_tlb(env)->c.lock);
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
@@ -561,15 +558,15 @@ static void tlb_flush_page_by_mmuidx_async_0(CPUState *cpu,
 static void tlb_flush_page_by_mmuidx_async_1(CPUState *cpu,
                                              run_on_cpu_data data)
 {
-    target_ulong addr_and_idxmap = (target_ulong) data.target_ptr;
-    target_ulong addr = addr_and_idxmap & TARGET_PAGE_MASK;
+    vaddr addr_and_idxmap = data.target_ptr;
+    vaddr addr = addr_and_idxmap & TARGET_PAGE_MASK;
     uint16_t idxmap = addr_and_idxmap & ~TARGET_PAGE_MASK;
 
     tlb_flush_page_by_mmuidx_async_0(cpu, addr, idxmap);
 }
 
 typedef struct {
-    target_ulong addr;
+    vaddr addr;
     uint16_t idxmap;
 } TLBFlushPageByMMUIdxData;
 
@@ -592,9 +589,9 @@ static void tlb_flush_page_by_mmuidx_async_2(CPUState *cpu,
     g_free(d);
 }
 
-void tlb_flush_page_by_mmuidx(CPUState *cpu, target_ulong addr, uint16_t idxmap)
+void tlb_flush_page_by_mmuidx(CPUState *cpu, vaddr addr, uint16_t idxmap)
 {
-    tlb_debug("addr: "TARGET_FMT_lx" mmu_idx:%" PRIx16 "\n", addr, idxmap);
+    tlb_debug("addr: %" VADDR_PRIx " mmu_idx:%" PRIx16 "\n", addr, idxmap);
 
     /* This should already be page aligned */
     addr &= TARGET_PAGE_MASK;
@@ -620,15 +617,15 @@ void tlb_flush_page_by_mmuidx(CPUState *cpu, target_ulong addr, uint16_t idxmap)
     }
 }
 
-void tlb_flush_page(CPUState *cpu, target_ulong addr)
+void tlb_flush_page(CPUState *cpu, vaddr addr)
 {
     tlb_flush_page_by_mmuidx(cpu, addr, ALL_MMUIDX_BITS);
 }
 
-void tlb_flush_page_by_mmuidx_all_cpus(CPUState *src_cpu, target_ulong addr,
+void tlb_flush_page_by_mmuidx_all_cpus(CPUState *src_cpu, vaddr addr,
                                        uint16_t idxmap)
 {
-    tlb_debug("addr: "TARGET_FMT_lx" mmu_idx:%"PRIx16"\n", addr, idxmap);
+    tlb_debug("addr: %" VADDR_PRIx " mmu_idx:%"PRIx16"\n", addr, idxmap);
 
     /* This should already be page aligned */
     addr &= TARGET_PAGE_MASK;
@@ -660,16 +657,16 @@ void tlb_flush_page_by_mmuidx_all_cpus(CPUState *src_cpu, target_ulong addr,
     tlb_flush_page_by_mmuidx_async_0(src_cpu, addr, idxmap);
 }
 
-void tlb_flush_page_all_cpus(CPUState *src, target_ulong addr)
+void tlb_flush_page_all_cpus(CPUState *src, vaddr addr)
 {
     tlb_flush_page_by_mmuidx_all_cpus(src, addr, ALL_MMUIDX_BITS);
 }
 
 void tlb_flush_page_by_mmuidx_all_cpus_synced(CPUState *src_cpu,
-                                              target_ulong addr,
+                                              vaddr addr,
                                               uint16_t idxmap)
 {
-    tlb_debug("addr: "TARGET_FMT_lx" mmu_idx:%"PRIx16"\n", addr, idxmap);
+    tlb_debug("addr: %" VADDR_PRIx " mmu_idx:%"PRIx16"\n", addr, idxmap);
 
     /* This should already be page aligned */
     addr &= TARGET_PAGE_MASK;
@@ -706,18 +703,18 @@ void tlb_flush_page_by_mmuidx_all_cpus_synced(CPUState *src_cpu,
     }
 }
 
-void tlb_flush_page_all_cpus_synced(CPUState *src, target_ulong addr)
+void tlb_flush_page_all_cpus_synced(CPUState *src, vaddr addr)
 {
     tlb_flush_page_by_mmuidx_all_cpus_synced(src, addr, ALL_MMUIDX_BITS);
 }
 
 static void tlb_flush_range_locked(CPUArchState *env, int midx,
-                                   target_ulong addr, target_ulong len,
+                                   vaddr addr, vaddr len,
                                    unsigned bits)
 {
     CPUTLBDesc *d = &env_tlb(env)->d[midx];
     CPUTLBDescFast *f = &env_tlb(env)->f[midx];
-    target_ulong mask = MAKE_64BIT_MASK(0, bits);
+    vaddr mask = MAKE_64BIT_MASK(0, bits);
 
     /*
      * If @bits is smaller than the tlb size, there may be multiple entries
@@ -731,7 +728,7 @@ static void tlb_flush_range_locked(CPUArchState *env, int midx,
      */
     if (mask < f->mask || len > f->mask) {
         tlb_debug("forcing full flush midx %d ("
-                  TARGET_FMT_lx "/" TARGET_FMT_lx "+" TARGET_FMT_lx ")\n",
+                  "%" VADDR_PRIx "/%" VADDR_PRIx "+%" VADDR_PRIx ")\n",
                   midx, addr, mask, len);
         tlb_flush_one_mmuidx_locked(env, midx, get_clock_realtime());
         return;
@@ -744,14 +741,14 @@ static void tlb_flush_range_locked(CPUArchState *env, int midx,
      */
     if (((addr + len - 1) & d->large_page_mask) == d->large_page_addr) {
         tlb_debug("forcing full flush midx %d ("
-                  TARGET_FMT_lx "/" TARGET_FMT_lx ")\n",
+                  "%" VADDR_PRIx "/%" VADDR_PRIx ")\n",
                   midx, d->large_page_addr, d->large_page_mask);
         tlb_flush_one_mmuidx_locked(env, midx, get_clock_realtime());
         return;
     }
 
-    for (target_ulong i = 0; i < len; i += TARGET_PAGE_SIZE) {
-        target_ulong page = addr + i;
+    for (vaddr i = 0; i < len; i += TARGET_PAGE_SIZE) {
+        vaddr page = addr + i;
         CPUTLBEntry *entry = tlb_entry(env, midx, page);
 
         if (tlb_flush_entry_mask_locked(entry, page, mask)) {
@@ -762,8 +759,8 @@ static void tlb_flush_range_locked(CPUArchState *env, int midx,
 }
 
 typedef struct {
-    target_ulong addr;
-    target_ulong len;
+    vaddr addr;
+    vaddr len;
     uint16_t idxmap;
     uint16_t bits;
 } TLBFlushRangeData;
@@ -776,7 +773,7 @@ static void tlb_flush_range_by_mmuidx_async_0(CPUState *cpu,
 
     assert_cpu_is_self(cpu);
 
-    tlb_debug("range:" TARGET_FMT_lx "/%u+" TARGET_FMT_lx " mmu_map:0x%x\n",
+    tlb_debug("range: %" VADDR_PRIx "/%u+%" VADDR_PRIx " mmu_map:0x%x\n",
               d.addr, d.bits, d.len, d.idxmap);
 
     qemu_spin_lock(&env_tlb(env)->c.lock);
@@ -801,7 +798,7 @@ static void tlb_flush_range_by_mmuidx_async_0(CPUState *cpu,
      * overlap the flushed pages, which includes the previous.
      */
     d.addr -= TARGET_PAGE_SIZE;
-    for (target_ulong i = 0, n = d.len / TARGET_PAGE_SIZE + 1; i < n; i++) {
+    for (vaddr i = 0, n = d.len / TARGET_PAGE_SIZE + 1; i < n; i++) {
         tb_jmp_cache_clear_page(cpu, d.addr);
         d.addr += TARGET_PAGE_SIZE;
     }
@@ -815,8 +812,8 @@ static void tlb_flush_range_by_mmuidx_async_1(CPUState *cpu,
     g_free(d);
 }
 
-void tlb_flush_range_by_mmuidx(CPUState *cpu, target_ulong addr,
-                               target_ulong len, uint16_t idxmap,
+void tlb_flush_range_by_mmuidx(CPUState *cpu, vaddr addr,
+                               vaddr len, uint16_t idxmap,
                                unsigned bits)
 {
     TLBFlushRangeData d;
@@ -851,14 +848,14 @@ void tlb_flush_range_by_mmuidx(CPUState *cpu, target_ulong addr,
     }
 }
 
-void tlb_flush_page_bits_by_mmuidx(CPUState *cpu, target_ulong addr,
+void tlb_flush_page_bits_by_mmuidx(CPUState *cpu, vaddr addr,
                                    uint16_t idxmap, unsigned bits)
 {
     tlb_flush_range_by_mmuidx(cpu, addr, TARGET_PAGE_SIZE, idxmap, bits);
 }
 
 void tlb_flush_range_by_mmuidx_all_cpus(CPUState *src_cpu,
-                                        target_ulong addr, target_ulong len,
+                                        vaddr addr, vaddr len,
                                         uint16_t idxmap, unsigned bits)
 {
     TLBFlushRangeData d;
@@ -898,16 +895,16 @@ void tlb_flush_range_by_mmuidx_all_cpus(CPUState *src_cpu,
 }
 
 void tlb_flush_page_bits_by_mmuidx_all_cpus(CPUState *src_cpu,
-                                            target_ulong addr,
-                                            uint16_t idxmap, unsigned bits)
+                                            vaddr addr, uint16_t idxmap,
+                                            unsigned bits)
 {
     tlb_flush_range_by_mmuidx_all_cpus(src_cpu, addr, TARGET_PAGE_SIZE,
                                        idxmap, bits);
 }
 
 void tlb_flush_range_by_mmuidx_all_cpus_synced(CPUState *src_cpu,
-                                               target_ulong addr,
-                                               target_ulong len,
+                                               vaddr addr,
+                                               vaddr len,
                                                uint16_t idxmap,
                                                unsigned bits)
 {
@@ -949,7 +946,7 @@ void tlb_flush_range_by_mmuidx_all_cpus_synced(CPUState *src_cpu,
 }
 
 void tlb_flush_page_bits_by_mmuidx_all_cpus_synced(CPUState *src_cpu,
-                                                   target_ulong addr,
+                                                   vaddr addr,
                                                    uint16_t idxmap,
                                                    unsigned bits)
 {
@@ -1055,32 +1052,32 @@ void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length)
 
 /* Called with tlb_c.lock held */
 static inline void tlb_set_dirty1_locked(CPUTLBEntry *tlb_entry,
-                                         target_ulong vaddr)
+                                         vaddr addr)
 {
-    if (tlb_entry->addr_write == (vaddr | TLB_NOTDIRTY)) {
-        tlb_entry->addr_write = vaddr;
+    if (tlb_entry->addr_write == (addr | TLB_NOTDIRTY)) {
+        tlb_entry->addr_write = addr;
     }
 }
 
 /* update the TLB corresponding to virtual page vaddr
    so that it is no longer dirty */
-void tlb_set_dirty(CPUState *cpu, target_ulong vaddr)
+void tlb_set_dirty(CPUState *cpu, vaddr addr)
 {
     CPUArchState *env = cpu->env_ptr;
     int mmu_idx;
 
     assert_cpu_is_self(cpu);
 
-    vaddr &= TARGET_PAGE_MASK;
+    addr &= TARGET_PAGE_MASK;
     qemu_spin_lock(&env_tlb(env)->c.lock);
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
-        tlb_set_dirty1_locked(tlb_entry(env, mmu_idx, vaddr), vaddr);
+        tlb_set_dirty1_locked(tlb_entry(env, mmu_idx, addr), addr);
     }
 
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
         int k;
         for (k = 0; k < CPU_VTLB_SIZE; k++) {
-            tlb_set_dirty1_locked(&env_tlb(env)->d[mmu_idx].vtable[k], vaddr);
+            tlb_set_dirty1_locked(&env_tlb(env)->d[mmu_idx].vtable[k], addr);
         }
     }
     qemu_spin_unlock(&env_tlb(env)->c.lock);
@@ -1089,20 +1086,20 @@ void tlb_set_dirty(CPUState *cpu, target_ulong vaddr)
 /* Our TLB does not support large pages, so remember the area covered by
    large pages and trigger a full TLB flush if these are invalidated.  */
 static void tlb_add_large_page(CPUArchState *env, int mmu_idx,
-                               target_ulong vaddr, target_ulong size)
+                               vaddr addr, uint64_t size)
 {
-    target_ulong lp_addr = env_tlb(env)->d[mmu_idx].large_page_addr;
-    target_ulong lp_mask = ~(size - 1);
+    vaddr lp_addr = env_tlb(env)->d[mmu_idx].large_page_addr;
+    vaddr lp_mask = ~(size - 1);
 
-    if (lp_addr == (target_ulong)-1) {
+    if (lp_addr == (vaddr)-1) {
         /* No previous large page.  */
-        lp_addr = vaddr;
+        lp_addr = addr;
     } else {
         /* Extend the existing region to include the new page.
            This is a compromise between unnecessary flushes and
            the cost of maintaining a full variable size TLB.  */
         lp_mask &= env_tlb(env)->d[mmu_idx].large_page_mask;
-        while (((lp_addr ^ vaddr) & lp_mask) != 0) {
+        while (((lp_addr ^ addr) & lp_mask) != 0) {
             lp_mask <<= 1;
         }
     }
@@ -1119,19 +1116,19 @@ static void tlb_add_large_page(CPUArchState *env, int mmu_idx,
  * critical section.
  */
 void tlb_set_page_full(CPUState *cpu, int mmu_idx,
-                       target_ulong vaddr, CPUTLBEntryFull *full)
+                       vaddr addr, CPUTLBEntryFull *full)
 {
     CPUArchState *env = cpu->env_ptr;
     CPUTLB *tlb = env_tlb(env);
     CPUTLBDesc *desc = &tlb->d[mmu_idx];
     MemoryRegionSection *section;
     unsigned int index;
-    target_ulong address;
-    target_ulong write_address;
+    vaddr address;
+    vaddr write_address;
     uintptr_t addend;
     CPUTLBEntry *te, tn;
     hwaddr iotlb, xlat, sz, paddr_page;
-    target_ulong vaddr_page;
+    vaddr addr_page;
     int asidx, wp_flags, prot;
     bool is_ram, is_romd;
 
@@ -1141,9 +1138,9 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
         sz = TARGET_PAGE_SIZE;
     } else {
         sz = (hwaddr)1 << full->lg_page_size;
-        tlb_add_large_page(env, mmu_idx, vaddr, sz);
+        tlb_add_large_page(env, mmu_idx, addr, sz);
     }
-    vaddr_page = vaddr & TARGET_PAGE_MASK;
+    addr_page = addr & TARGET_PAGE_MASK;
     paddr_page = full->phys_addr & TARGET_PAGE_MASK;
 
     prot = full->prot;
@@ -1152,11 +1149,11 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
                                                 &xlat, &sz, full->attrs, &prot);
     assert(sz >= TARGET_PAGE_SIZE);
 
-    tlb_debug("vaddr=" TARGET_FMT_lx " paddr=0x" HWADDR_FMT_plx
+    tlb_debug("vaddr=%" VADDR_PRIx " paddr=0x" HWADDR_FMT_plx
               " prot=%x idx=%d\n",
-              vaddr, full->phys_addr, prot, mmu_idx);
+              addr, full->phys_addr, prot, mmu_idx);
 
-    address = vaddr_page;
+    address = addr_page;
     if (full->lg_page_size < TARGET_PAGE_BITS) {
         /* Repeat the MMU check and TLB fill on every access.  */
         address |= TLB_INVALID_MASK;
@@ -1204,11 +1201,11 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
         }
     }
 
-    wp_flags = cpu_watchpoint_address_matches(cpu, vaddr_page,
+    wp_flags = cpu_watchpoint_address_matches(cpu, addr_page,
                                               TARGET_PAGE_SIZE);
 
-    index = tlb_index(env, mmu_idx, vaddr_page);
-    te = tlb_entry(env, mmu_idx, vaddr_page);
+    index = tlb_index(env, mmu_idx, addr_page);
+    te = tlb_entry(env, mmu_idx, addr_page);
 
     /*
      * Hold the TLB lock for the rest of the function. We could acquire/release
@@ -1223,13 +1220,13 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
     tlb->c.dirty |= 1 << mmu_idx;
 
     /* Make sure there's no cached translation for the new page.  */
-    tlb_flush_vtlb_page_locked(env, mmu_idx, vaddr_page);
+    tlb_flush_vtlb_page_locked(env, mmu_idx, addr_page);
 
     /*
      * Only evict the old entry to the victim tlb if it's for a
      * different page; otherwise just overwrite the stale data.
      */
-    if (!tlb_hit_page_anyprot(te, vaddr_page) && !tlb_entry_is_empty(te)) {
+    if (!tlb_hit_page_anyprot(te, addr_page) && !tlb_entry_is_empty(te)) {
         unsigned vidx = desc->vindex++ % CPU_VTLB_SIZE;
         CPUTLBEntry *tv = &desc->vtable[vidx];
 
@@ -1253,11 +1250,11 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
      * vaddr we add back in io_readx()/io_writex()/get_page_addr_code().
      */
     desc->fulltlb[index] = *full;
-    desc->fulltlb[index].xlat_section = iotlb - vaddr_page;
+    desc->fulltlb[index].xlat_section = iotlb - addr_page;
     desc->fulltlb[index].phys_addr = paddr_page;
 
     /* Now calculate the new entry */
-    tn.addend = addend - vaddr_page;
+    tn.addend = addend - addr_page;
     if (prot & PAGE_READ) {
         tn.addr_read = address;
         if (wp_flags & BP_MEM_READ) {
@@ -1289,9 +1286,9 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
     qemu_spin_unlock(&tlb->c.lock);
 }
 
-void tlb_set_page_with_attrs(CPUState *cpu, target_ulong vaddr,
+void tlb_set_page_with_attrs(CPUState *cpu, vaddr addr,
                              hwaddr paddr, MemTxAttrs attrs, int prot,
-                             int mmu_idx, target_ulong size)
+                             int mmu_idx, uint64_t size)
 {
     CPUTLBEntryFull full = {
         .phys_addr = paddr,
@@ -1301,14 +1298,14 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ulong vaddr,
     };
 
     assert(is_power_of_2(size));
-    tlb_set_page_full(cpu, mmu_idx, vaddr, &full);
+    tlb_set_page_full(cpu, mmu_idx, addr, &full);
 }
 
-void tlb_set_page(CPUState *cpu, target_ulong vaddr,
+void tlb_set_page(CPUState *cpu, vaddr addr,
                   hwaddr paddr, int prot,
-                  int mmu_idx, target_ulong size)
+                  int mmu_idx, uint64_t size)
 {
-    tlb_set_page_with_attrs(cpu, vaddr, paddr, MEMTXATTRS_UNSPECIFIED,
+    tlb_set_page_with_attrs(cpu, addr, paddr, MEMTXATTRS_UNSPECIFIED,
                             prot, mmu_idx, size);
 }
 
@@ -1317,7 +1314,7 @@ void tlb_set_page(CPUState *cpu, target_ulong vaddr,
  * caller's prior references to the TLB table (e.g. CPUTLBEntry pointers) must
  * be discarded and looked up again (e.g. via tlb_entry()).
  */
-static void tlb_fill(CPUState *cpu, target_ulong addr, int size,
+static void tlb_fill(CPUState *cpu, vaddr addr, int size,
                      MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
 {
     bool ok;
@@ -1357,7 +1354,7 @@ static inline void cpu_transaction_failed(CPUState *cpu, hwaddr physaddr,
 }
 
 static uint64_t io_readx(CPUArchState *env, CPUTLBEntryFull *full,
-                         int mmu_idx, target_ulong addr, uintptr_t retaddr,
+                         int mmu_idx, vaddr addr, uintptr_t retaddr,
                          MMUAccessType access_type, MemOp op)
 {
     CPUState *cpu = env_cpu(env);
@@ -1407,7 +1404,7 @@ static void save_iotlb_data(CPUState *cs, MemoryRegionSection *section,
 }
 
 static void io_writex(CPUArchState *env, CPUTLBEntryFull *full,
-                      int mmu_idx, uint64_t val, target_ulong addr,
+                      int mmu_idx, uint64_t val, vaddr addr,
                       uintptr_t retaddr, MemOp op)
 {
     CPUState *cpu = env_cpu(env);
@@ -1449,7 +1446,7 @@ static void io_writex(CPUArchState *env, CPUTLBEntryFull *full,
 /* Return true if ADDR is present in the victim tlb, and has been copied
    back to the main tlb.  */
 static bool victim_tlb_hit(CPUArchState *env, size_t mmu_idx, size_t index,
-                           MMUAccessType access_type, target_ulong page)
+                           MMUAccessType access_type, vaddr page)
 {
     size_t vidx;
 
@@ -1691,13 +1688,13 @@ tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env, target_ulong addr,
  * from the same thread (which a mem callback will be) this is safe.
  */
 
-bool tlb_plugin_lookup(CPUState *cpu, target_ulong addr, int mmu_idx,
+bool tlb_plugin_lookup(CPUState *cpu, vaddr addr, int mmu_idx,
                        bool is_store, struct qemu_plugin_hwaddr *data)
 {
     CPUArchState *env = cpu->env_ptr;
     CPUTLBEntry *tlbe = tlb_entry(env, mmu_idx, addr);
     uintptr_t index = tlb_index(env, mmu_idx, addr);
-    target_ulong tlb_addr = is_store ? tlb_addr_write(tlbe) : tlbe->addr_read;
+    vaddr tlb_addr = is_store ? tlb_addr_write(tlbe) : tlbe->addr_read;
 
     if (likely(tlb_hit(tlb_addr, addr))) {
         /* We must have an iotlb entry for MMIO */
diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index 892eecda2d..3541419845 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -98,7 +98,7 @@ static void tb_remove_all(void)
 /* Call with mmap_lock held. */
 static void tb_record(TranslationBlock *tb, PageDesc *p1, PageDesc *p2)
 {
-    target_ulong addr;
+    vaddr addr;
     int flags;
 
     assert_memory_lock();
-- 
2.34.1


