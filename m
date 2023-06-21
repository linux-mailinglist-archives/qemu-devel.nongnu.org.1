Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8B373837E
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 14:20:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBwo6-0006eE-TN; Wed, 21 Jun 2023 08:19:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBwnm-0006aZ-Gq
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 08:19:10 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBwnj-0000GC-Ih
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 08:19:10 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2b466744368so66018021fa.0
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 05:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687349946; x=1689941946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jgqAbaPN1d4W9rZooKKid+wiSp+1N29sW2yxha1lmeQ=;
 b=EMClaJq9Bv02tiOB76o4+o3foPo+UXj3ZCIUWYYqoB2F0v3Z5owuks/qGTJoZf1+/y
 zqLf3dYoVTtcUC75C4JeehVqF6gUEwy0PlI9O8B0CIzlN/bzB4/u0zdFBixcpnJL9b7n
 /pyKisKhod6kJxLinE8LWcuuOPI34v8SD46r3DKQkXeMTxxbJw6U75pYYTIGTYMNVPVe
 v8DcAJkW53MaIU+wM0OywGtQlD8ivWGoatus3ljlqB80XViwz2IM03EBmziy/Ih1/rld
 RNf95Ed3MfpdRVcRV7foXC7LekT9LtJrR155rVeEU28BRqZCna0TuH/RYwwJIRUUO0dJ
 DM3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687349946; x=1689941946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jgqAbaPN1d4W9rZooKKid+wiSp+1N29sW2yxha1lmeQ=;
 b=Tj77ahyw+B+8YaKehc0gUxp2UV+Iy4bX/Kj5FK+uU6fwxSA9mVrnVqlZg9Gy/Nobau
 50xqLRb5KelOI/cacfoZlp0Rqkkb8nxQGce9pMRCZYwp+vFc4D1pfDIBVAMnaeUMVjFu
 /9w0iEP+v5YlLvzO6neZHV6GdJbMZDKmX3vHRGoSRCfmbN/kVzYXUmjfLI7DbpUvLTtf
 xYXkaNDjWquXY7L7NxS3D9UPVDgz/lyKF9/0/cI4RJoUHeb0EwmuqOK2IYv/K9sddQ+W
 8/lg5BpnsLmEkuVUBRRosgtyfQSN/XAOzJXUlGKISrorjgcUMHbvDjRUYGx9b5i2EsS7
 JNrQ==
X-Gm-Message-State: AC+VfDxDE6qTxJqMQY9PzJC29kLuAYmUIw1uPzFE9wOKm1OKJZh9eFTu
 m0M4zpLhJIoozGGSTdGz6o4OSwhOP6rqUsT5k39Rf39v
X-Google-Smtp-Source: ACHHUZ55siBQXrNgjmF9lAgolGvvZ1XA4yeFvdleCkWXZHvIrc2o19VUMPLjn4X9DC27tLaGh6NOpg==
X-Received: by 2002:a2e:9c82:0:b0:2b4:6678:da57 with SMTP id
 x2-20020a2e9c82000000b002b46678da57mr7374896lji.6.1687349945564; 
 Wed, 21 Jun 2023 05:19:05 -0700 (PDT)
Received: from stoup.lan ([176.176.128.70]) by smtp.gmail.com with ESMTPSA id
 s6-20020a056402014600b0051bdf152295sm543176edu.76.2023.06.21.05.19.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 05:19:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 1/9] accel/tcg: Store some tlb flags in CPUTLBEntryFull
Date: Wed, 21 Jun 2023 14:18:54 +0200
Message-Id: <20230621121902.1392277-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230621121902.1392277-1-richard.henderson@linaro.org>
References: <20230621121902.1392277-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x229.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h  | 21 +++++++--
 include/exec/cpu-defs.h |  6 +++
 accel/tcg/cputlb.c      | 96 ++++++++++++++++++++++++-----------------
 3 files changed, 80 insertions(+), 43 deletions(-)

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
index 4cb77c8dec..c174d5371a 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -124,6 +124,12 @@ typedef struct CPUTLBEntryFull {
     /* @lg_page_size contains the log2 of the page size. */
     uint8_t lg_page_size;
 
+    /*
+     * Additional tlb flags for use by the slow path. If non-zero,
+     * the corresponding CPUTLBEntry comparator must have TLB_FORCE_SLOW.
+     */
+    uint8_t slow_flags[3];
+
     /*
      * Allow target-specific additions to this structure.
      * This may be used to cache items from the guest cpu
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 14ce97c33b..b40ce5ea0f 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1110,6 +1110,24 @@ static void tlb_add_large_page(CPUArchState *env, int mmu_idx,
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
@@ -1125,9 +1143,7 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
     CPUTLB *tlb = env_tlb(env);
     CPUTLBDesc *desc = &tlb->d[mmu_idx];
     MemoryRegionSection *section;
-    unsigned int index;
-    target_ulong address;
-    target_ulong write_address;
+    unsigned int index, read_flags, write_flags;
     uintptr_t addend;
     CPUTLBEntry *te, tn;
     hwaddr iotlb, xlat, sz, paddr_page;
@@ -1156,13 +1172,13 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
               " prot=%x idx=%d\n",
               vaddr, full->phys_addr, prot, mmu_idx);
 
-    address = vaddr_page;
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
@@ -1176,7 +1192,7 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
         addend = 0;
     }
 
-    write_address = address;
+    write_flags = read_flags;
     if (is_ram) {
         iotlb = memory_region_get_ram_addr(section->mr) + xlat;
         /*
@@ -1185,9 +1201,9 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
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
@@ -1198,9 +1214,9 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
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
 
@@ -1253,36 +1269,30 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
      * vaddr we add back in io_readx()/io_writex()/get_page_addr_code().
      */
     desc->fulltlb[index] = *full;
-    desc->fulltlb[index].xlat_section = iotlb - vaddr_page;
-    desc->fulltlb[index].phys_addr = paddr_page;
+    full = &desc->fulltlb[index];
+    full->xlat_section = iotlb - vaddr_page;
+    full->phys_addr = paddr_page;
 
     /* Now calculate the new entry */
     tn.addend = addend - vaddr_page;
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
+    tlb_set_compare(full, &tn, vaddr_page, read_flags,
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
+    tlb_set_compare(full, &tn, vaddr_page, read_flags,
+                    MMU_DATA_LOAD, prot & PAGE_READ);
+
+    if (prot & PAGE_WRITE_INV) {
+        write_flags |= TLB_INVALID_MASK;
+    }
+    if (wp_flags & BP_MEM_WRITE) {
+        write_flags |= TLB_WATCHPOINT;
+    }
+    tlb_set_compare(full, &tn, vaddr_page, write_flags,
+                    MMU_DATA_STORE, prot & PAGE_WRITE);
 
     copy_tlb_helper_locked(te, &tn);
     tlb_n_used_entries_inc(env, mmu_idx);
@@ -1512,7 +1522,8 @@ static int probe_access_internal(CPUArchState *env, target_ulong addr,
     CPUTLBEntry *entry = tlb_entry(env, mmu_idx, addr);
     target_ulong tlb_addr = tlb_read_idx(entry, access_type);
     target_ulong page_addr = addr & TARGET_PAGE_MASK;
-    int flags = TLB_FLAGS_MASK;
+    int flags = TLB_FLAGS_MASK & ~TLB_FORCE_SLOW;
+    CPUTLBEntryFull *full;
 
     if (!tlb_hit_page(tlb_addr, page_addr)) {
         if (!victim_tlb_hit(env, mmu_idx, index, access_type, page_addr)) {
@@ -1541,7 +1552,8 @@ static int probe_access_internal(CPUArchState *env, target_ulong addr,
     }
     flags &= tlb_addr;
 
-    *pfull = &env_tlb(env)->d[mmu_idx].fulltlb[index];
+    *pfull = full = &env_tlb(env)->d[mmu_idx].fulltlb[index];
+    flags |= full->slow_flags[access_type];
 
     /* Fold all "mmio-like" bits into TLB_MMIO.  This is not RAM.  */
     if (unlikely(flags & ~(TLB_WATCHPOINT | TLB_NOTDIRTY))) {
@@ -1764,6 +1776,8 @@ static bool mmu_lookup1(CPUArchState *env, MMULookupPageData *data,
     CPUTLBEntry *entry = tlb_entry(env, mmu_idx, addr);
     target_ulong tlb_addr = tlb_read_idx(entry, access_type);
     bool maybe_resized = false;
+    CPUTLBEntryFull *full;
+    int flags;
 
     /* If the TLB entry is for a different page, reload and try again.  */
     if (!tlb_hit(tlb_addr, addr)) {
@@ -1777,8 +1791,12 @@ static bool mmu_lookup1(CPUArchState *env, MMULookupPageData *data,
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


