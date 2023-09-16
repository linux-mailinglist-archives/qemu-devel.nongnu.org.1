Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D707A32C4
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 23:46:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhd33-0005CU-7J; Sat, 16 Sep 2023 17:41:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhd2y-0005AT-LA
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 17:41:48 -0400
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhd2t-0000Sg-BS
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 17:41:48 -0400
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-1c504386370so2017818fac.1
 for <qemu-devel@nongnu.org>; Sat, 16 Sep 2023 14:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694900502; x=1695505302; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Eqdx5KYfe7+Tgpre/r7adTy9jlck+D44aSymYCDoQAc=;
 b=RfcDki/Y13BUGq6pMNr8KJ5uN6DBfKutzo5IG7fE9s28WsBje0azxhZr35bwBoTGZv
 8jnaBQ8ErzDJZcRpC5YcADxpjtNUeG3Havvvne4o5kbJ7jWhj+Nb9FEGpqtIJ8yt0sWy
 NC16YrE1hepNpyJFHveeOBeP2ydcayhZVapoI3nlLIZQb1rmAy7muZPi7b2GhOlfBknx
 YWpmuf5bmLZX2MdxvyS3XF/1dYHvHjr3mgddDB4hUBvTrteMnw3ugqG41hfs8IGtyBm8
 b4BTcRV3ToVo4ykSSfPv8XJ4HDABOSnNbuPctdTQjfQQeZjwBwu9Y9JQZbut0KhLHHq7
 qEBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694900502; x=1695505302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Eqdx5KYfe7+Tgpre/r7adTy9jlck+D44aSymYCDoQAc=;
 b=A6FsvKynMFpRuA0anofIMlG4Qngga/y66B2m625/Qvkp3DLtafFeZJu4pB+mzhbg8R
 8vgVxx3vAPFlIEcsn0Xr+TSNngb5GC0hBhEt+5Vq+IPVUn+djQY5xM3wbJrbWmzFuxsQ
 pFkXRqGG42oNaCzjAYqokVXejzDhkUMlfDL8thONiC3Z6U2EIVCvdwk0rPomsi3fwrIJ
 J2pk9SmaHM8PHFMFw7fspX8Z1iIwAiTkUCZYkESpPic+CrGulwP51eUJFsO6SKfo2ldb
 HZ9WILWnBwUvUEJ2gIYDGbJnuk6WXRZm6jCc2VcIkm3/rSr5Dl4jmbnE3yD2eVkVqQeP
 FIRw==
X-Gm-Message-State: AOJu0YygYLaSyrVND7qiWo2d9rC0le9kInYKyVG3fVMxTZBuzUPpdq1T
 pa/VIC6ynqh/gtRKX0J0V1TpFrWT6YWfRPe6BiU=
X-Google-Smtp-Source: AGHT+IGxVeDOACbxEqDjClh/WuibLYGpmClwa/oHQjfpST76CBS/GSc0kn4Wp2mdPFGn0sW6yF3z/g==
X-Received: by 2002:a05:6871:687:b0:1ba:caf2:acc3 with SMTP id
 l7-20020a056871068700b001bacaf2acc3mr6488145oao.5.1694900501758; 
 Sat, 16 Sep 2023 14:41:41 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 n21-20020aa79055000000b0068fde95aa93sm4871708pfo.135.2023.09.16.14.41.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Sep 2023 14:41:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	anjo@rev.ng
Subject: [PATCH v3 16/39] accel/tcg: Modify tlb_*() to use CPUState
Date: Sat, 16 Sep 2023 14:41:00 -0700
Message-Id: <20230916214123.525796-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916214123.525796-1-richard.henderson@linaro.org>
References: <20230916214123.525796-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x32.google.com
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

From: Anton Johansson <anjo@rev.ng>

Changes tlb_*() functions to take CPUState instead of CPUArchState, as
they don't require the full CPUArchState. This makes it easier to
decouple target-(in)dependent code.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20230912153428.17816-4-anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
[rth: Use cpu->neg.tlb instead of cpu_tlb()]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu_ldst.h |   8 +-
 accel/tcg/cputlb.c      | 220 +++++++++++++++++++---------------------
 2 files changed, 108 insertions(+), 120 deletions(-)

diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index da10ba1433..6061e33ac9 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -361,19 +361,19 @@ static inline uint64_t tlb_addr_write(const CPUTLBEntry *entry)
 }
 
 /* Find the TLB index corresponding to the mmu_idx + address pair.  */
-static inline uintptr_t tlb_index(CPUArchState *env, uintptr_t mmu_idx,
+static inline uintptr_t tlb_index(CPUState *cpu, uintptr_t mmu_idx,
                                   vaddr addr)
 {
-    uintptr_t size_mask = env_tlb(env)->f[mmu_idx].mask >> CPU_TLB_ENTRY_BITS;
+    uintptr_t size_mask = cpu->neg.tlb.f[mmu_idx].mask >> CPU_TLB_ENTRY_BITS;
 
     return (addr >> TARGET_PAGE_BITS) & size_mask;
 }
 
 /* Find the TLB entry corresponding to the mmu_idx + address pair.  */
-static inline CPUTLBEntry *tlb_entry(CPUArchState *env, uintptr_t mmu_idx,
+static inline CPUTLBEntry *tlb_entry(CPUState *cpu, uintptr_t mmu_idx,
                                      vaddr addr)
 {
-    return &env_tlb(env)->f[mmu_idx].table[tlb_index(env, mmu_idx, addr)];
+    return &cpu->neg.tlb.f[mmu_idx].table[tlb_index(cpu, mmu_idx, addr)];
 }
 
 #endif /* defined(CONFIG_USER_ONLY) */
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index f790be5b6e..f88c394594 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -240,11 +240,11 @@ static void tlb_mmu_flush_locked(CPUTLBDesc *desc, CPUTLBDescFast *fast)
     memset(desc->vtable, -1, sizeof(desc->vtable));
 }
 
-static void tlb_flush_one_mmuidx_locked(CPUArchState *env, int mmu_idx,
+static void tlb_flush_one_mmuidx_locked(CPUState *cpu, int mmu_idx,
                                         int64_t now)
 {
-    CPUTLBDesc *desc = &env_tlb(env)->d[mmu_idx];
-    CPUTLBDescFast *fast = &env_tlb(env)->f[mmu_idx];
+    CPUTLBDesc *desc = &cpu->neg.tlb.d[mmu_idx];
+    CPUTLBDescFast *fast = &cpu->neg.tlb.f[mmu_idx];
 
     tlb_mmu_resize_locked(desc, fast, now);
     tlb_mmu_flush_locked(desc, fast);
@@ -262,41 +262,39 @@ static void tlb_mmu_init(CPUTLBDesc *desc, CPUTLBDescFast *fast, int64_t now)
     tlb_mmu_flush_locked(desc, fast);
 }
 
-static inline void tlb_n_used_entries_inc(CPUArchState *env, uintptr_t mmu_idx)
+static inline void tlb_n_used_entries_inc(CPUState *cpu, uintptr_t mmu_idx)
 {
-    env_tlb(env)->d[mmu_idx].n_used_entries++;
+    cpu->neg.tlb.d[mmu_idx].n_used_entries++;
 }
 
-static inline void tlb_n_used_entries_dec(CPUArchState *env, uintptr_t mmu_idx)
+static inline void tlb_n_used_entries_dec(CPUState *cpu, uintptr_t mmu_idx)
 {
-    env_tlb(env)->d[mmu_idx].n_used_entries--;
+    cpu->neg.tlb.d[mmu_idx].n_used_entries--;
 }
 
 void tlb_init(CPUState *cpu)
 {
-    CPUArchState *env = cpu_env(cpu);
     int64_t now = get_clock_realtime();
     int i;
 
-    qemu_spin_init(&env_tlb(env)->c.lock);
+    qemu_spin_init(&cpu->neg.tlb.c.lock);
 
     /* All tlbs are initialized flushed. */
-    env_tlb(env)->c.dirty = 0;
+    cpu->neg.tlb.c.dirty = 0;
 
     for (i = 0; i < NB_MMU_MODES; i++) {
-        tlb_mmu_init(&env_tlb(env)->d[i], &env_tlb(env)->f[i], now);
+        tlb_mmu_init(&cpu->neg.tlb.d[i], &cpu->neg.tlb.f[i], now);
     }
 }
 
 void tlb_destroy(CPUState *cpu)
 {
-    CPUArchState *env = cpu_env(cpu);
     int i;
 
-    qemu_spin_destroy(&env_tlb(env)->c.lock);
+    qemu_spin_destroy(&cpu->neg.tlb.c.lock);
     for (i = 0; i < NB_MMU_MODES; i++) {
-        CPUTLBDesc *desc = &env_tlb(env)->d[i];
-        CPUTLBDescFast *fast = &env_tlb(env)->f[i];
+        CPUTLBDesc *desc = &cpu->neg.tlb.d[i];
+        CPUTLBDescFast *fast = &cpu->neg.tlb.f[i];
 
         g_free(fast->table);
         g_free(desc->fulltlb);
@@ -328,11 +326,9 @@ void tlb_flush_counts(size_t *pfull, size_t *ppart, size_t *pelide)
     size_t full = 0, part = 0, elide = 0;
 
     CPU_FOREACH(cpu) {
-        CPUArchState *env = cpu_env(cpu);
-
-        full += qatomic_read(&env_tlb(env)->c.full_flush_count);
-        part += qatomic_read(&env_tlb(env)->c.part_flush_count);
-        elide += qatomic_read(&env_tlb(env)->c.elide_flush_count);
+        full += qatomic_read(&cpu->neg.tlb.c.full_flush_count);
+        part += qatomic_read(&cpu->neg.tlb.c.part_flush_count);
+        elide += qatomic_read(&cpu->neg.tlb.c.elide_flush_count);
     }
     *pfull = full;
     *ppart = part;
@@ -341,7 +337,6 @@ void tlb_flush_counts(size_t *pfull, size_t *ppart, size_t *pelide)
 
 static void tlb_flush_by_mmuidx_async_work(CPUState *cpu, run_on_cpu_data data)
 {
-    CPUArchState *env = cpu_env(cpu);
     uint16_t asked = data.host_int;
     uint16_t all_dirty, work, to_clean;
     int64_t now = get_clock_realtime();
@@ -350,32 +345,32 @@ static void tlb_flush_by_mmuidx_async_work(CPUState *cpu, run_on_cpu_data data)
 
     tlb_debug("mmu_idx:0x%04" PRIx16 "\n", asked);
 
-    qemu_spin_lock(&env_tlb(env)->c.lock);
+    qemu_spin_lock(&cpu->neg.tlb.c.lock);
 
-    all_dirty = env_tlb(env)->c.dirty;
+    all_dirty = cpu->neg.tlb.c.dirty;
     to_clean = asked & all_dirty;
     all_dirty &= ~to_clean;
-    env_tlb(env)->c.dirty = all_dirty;
+    cpu->neg.tlb.c.dirty = all_dirty;
 
     for (work = to_clean; work != 0; work &= work - 1) {
         int mmu_idx = ctz32(work);
-        tlb_flush_one_mmuidx_locked(env, mmu_idx, now);
+        tlb_flush_one_mmuidx_locked(cpu, mmu_idx, now);
     }
 
-    qemu_spin_unlock(&env_tlb(env)->c.lock);
+    qemu_spin_unlock(&cpu->neg.tlb.c.lock);
 
     tcg_flush_jmp_cache(cpu);
 
     if (to_clean == ALL_MMUIDX_BITS) {
-        qatomic_set(&env_tlb(env)->c.full_flush_count,
-                   env_tlb(env)->c.full_flush_count + 1);
+        qatomic_set(&cpu->neg.tlb.c.full_flush_count,
+                    cpu->neg.tlb.c.full_flush_count + 1);
     } else {
-        qatomic_set(&env_tlb(env)->c.part_flush_count,
-                   env_tlb(env)->c.part_flush_count + ctpop16(to_clean));
+        qatomic_set(&cpu->neg.tlb.c.part_flush_count,
+                    cpu->neg.tlb.c.part_flush_count + ctpop16(to_clean));
         if (to_clean != asked) {
-            qatomic_set(&env_tlb(env)->c.elide_flush_count,
-                       env_tlb(env)->c.elide_flush_count +
-                       ctpop16(asked & ~to_clean));
+            qatomic_set(&cpu->neg.tlb.c.elide_flush_count,
+                        cpu->neg.tlb.c.elide_flush_count +
+                        ctpop16(asked & ~to_clean));
         }
     }
 }
@@ -470,43 +465,43 @@ static inline bool tlb_flush_entry_locked(CPUTLBEntry *tlb_entry, vaddr page)
 }
 
 /* Called with tlb_c.lock held */
-static void tlb_flush_vtlb_page_mask_locked(CPUArchState *env, int mmu_idx,
+static void tlb_flush_vtlb_page_mask_locked(CPUState *cpu, int mmu_idx,
                                             vaddr page,
                                             vaddr mask)
 {
-    CPUTLBDesc *d = &env_tlb(env)->d[mmu_idx];
+    CPUTLBDesc *d = &cpu->neg.tlb.d[mmu_idx];
     int k;
 
-    assert_cpu_is_self(env_cpu(env));
+    assert_cpu_is_self(cpu);
     for (k = 0; k < CPU_VTLB_SIZE; k++) {
         if (tlb_flush_entry_mask_locked(&d->vtable[k], page, mask)) {
-            tlb_n_used_entries_dec(env, mmu_idx);
+            tlb_n_used_entries_dec(cpu, mmu_idx);
         }
     }
 }
 
-static inline void tlb_flush_vtlb_page_locked(CPUArchState *env, int mmu_idx,
+static inline void tlb_flush_vtlb_page_locked(CPUState *cpu, int mmu_idx,
                                               vaddr page)
 {
-    tlb_flush_vtlb_page_mask_locked(env, mmu_idx, page, -1);
+    tlb_flush_vtlb_page_mask_locked(cpu, mmu_idx, page, -1);
 }
 
-static void tlb_flush_page_locked(CPUArchState *env, int midx, vaddr page)
+static void tlb_flush_page_locked(CPUState *cpu, int midx, vaddr page)
 {
-    vaddr lp_addr = env_tlb(env)->d[midx].large_page_addr;
-    vaddr lp_mask = env_tlb(env)->d[midx].large_page_mask;
+    vaddr lp_addr = cpu->neg.tlb.d[midx].large_page_addr;
+    vaddr lp_mask = cpu->neg.tlb.d[midx].large_page_mask;
 
     /* Check if we need to flush due to large pages.  */
     if ((page & lp_mask) == lp_addr) {
         tlb_debug("forcing full flush midx %d (%016"
                   VADDR_PRIx "/%016" VADDR_PRIx ")\n",
                   midx, lp_addr, lp_mask);
-        tlb_flush_one_mmuidx_locked(env, midx, get_clock_realtime());
+        tlb_flush_one_mmuidx_locked(cpu, midx, get_clock_realtime());
     } else {
-        if (tlb_flush_entry_locked(tlb_entry(env, midx, page), page)) {
-            tlb_n_used_entries_dec(env, midx);
+        if (tlb_flush_entry_locked(tlb_entry(cpu, midx, page), page)) {
+            tlb_n_used_entries_dec(cpu, midx);
         }
-        tlb_flush_vtlb_page_locked(env, midx, page);
+        tlb_flush_vtlb_page_locked(cpu, midx, page);
     }
 }
 
@@ -523,20 +518,19 @@ static void tlb_flush_page_by_mmuidx_async_0(CPUState *cpu,
                                              vaddr addr,
                                              uint16_t idxmap)
 {
-    CPUArchState *env = cpu_env(cpu);
     int mmu_idx;
 
     assert_cpu_is_self(cpu);
 
     tlb_debug("page addr: %016" VADDR_PRIx " mmu_map:0x%x\n", addr, idxmap);
 
-    qemu_spin_lock(&env_tlb(env)->c.lock);
+    qemu_spin_lock(&cpu->neg.tlb.c.lock);
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
         if ((idxmap >> mmu_idx) & 1) {
-            tlb_flush_page_locked(env, mmu_idx, addr);
+            tlb_flush_page_locked(cpu, mmu_idx, addr);
         }
     }
-    qemu_spin_unlock(&env_tlb(env)->c.lock);
+    qemu_spin_unlock(&cpu->neg.tlb.c.lock);
 
     /*
      * Discard jump cache entries for any tb which might potentially
@@ -709,12 +703,12 @@ void tlb_flush_page_all_cpus_synced(CPUState *src, vaddr addr)
     tlb_flush_page_by_mmuidx_all_cpus_synced(src, addr, ALL_MMUIDX_BITS);
 }
 
-static void tlb_flush_range_locked(CPUArchState *env, int midx,
+static void tlb_flush_range_locked(CPUState *cpu, int midx,
                                    vaddr addr, vaddr len,
                                    unsigned bits)
 {
-    CPUTLBDesc *d = &env_tlb(env)->d[midx];
-    CPUTLBDescFast *f = &env_tlb(env)->f[midx];
+    CPUTLBDesc *d = &cpu->neg.tlb.d[midx];
+    CPUTLBDescFast *f = &cpu->neg.tlb.f[midx];
     vaddr mask = MAKE_64BIT_MASK(0, bits);
 
     /*
@@ -731,7 +725,7 @@ static void tlb_flush_range_locked(CPUArchState *env, int midx,
         tlb_debug("forcing full flush midx %d ("
                   "%016" VADDR_PRIx "/%016" VADDR_PRIx "+%016" VADDR_PRIx ")\n",
                   midx, addr, mask, len);
-        tlb_flush_one_mmuidx_locked(env, midx, get_clock_realtime());
+        tlb_flush_one_mmuidx_locked(cpu, midx, get_clock_realtime());
         return;
     }
 
@@ -744,18 +738,18 @@ static void tlb_flush_range_locked(CPUArchState *env, int midx,
         tlb_debug("forcing full flush midx %d ("
                   "%016" VADDR_PRIx "/%016" VADDR_PRIx ")\n",
                   midx, d->large_page_addr, d->large_page_mask);
-        tlb_flush_one_mmuidx_locked(env, midx, get_clock_realtime());
+        tlb_flush_one_mmuidx_locked(cpu, midx, get_clock_realtime());
         return;
     }
 
     for (vaddr i = 0; i < len; i += TARGET_PAGE_SIZE) {
         vaddr page = addr + i;
-        CPUTLBEntry *entry = tlb_entry(env, midx, page);
+        CPUTLBEntry *entry = tlb_entry(cpu, midx, page);
 
         if (tlb_flush_entry_mask_locked(entry, page, mask)) {
-            tlb_n_used_entries_dec(env, midx);
+            tlb_n_used_entries_dec(cpu, midx);
         }
-        tlb_flush_vtlb_page_mask_locked(env, midx, page, mask);
+        tlb_flush_vtlb_page_mask_locked(cpu, midx, page, mask);
     }
 }
 
@@ -769,7 +763,6 @@ typedef struct {
 static void tlb_flush_range_by_mmuidx_async_0(CPUState *cpu,
                                               TLBFlushRangeData d)
 {
-    CPUArchState *env = cpu_env(cpu);
     int mmu_idx;
 
     assert_cpu_is_self(cpu);
@@ -777,13 +770,13 @@ static void tlb_flush_range_by_mmuidx_async_0(CPUState *cpu,
     tlb_debug("range: %016" VADDR_PRIx "/%u+%016" VADDR_PRIx " mmu_map:0x%x\n",
               d.addr, d.bits, d.len, d.idxmap);
 
-    qemu_spin_lock(&env_tlb(env)->c.lock);
+    qemu_spin_lock(&cpu->neg.tlb.c.lock);
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
         if ((d.idxmap >> mmu_idx) & 1) {
-            tlb_flush_range_locked(env, mmu_idx, d.addr, d.len, d.bits);
+            tlb_flush_range_locked(cpu, mmu_idx, d.addr, d.len, d.bits);
         }
     }
-    qemu_spin_unlock(&env_tlb(env)->c.lock);
+    qemu_spin_unlock(&cpu->neg.tlb.c.lock);
 
     /*
      * If the length is larger than the jump cache size, then it will take
@@ -1028,27 +1021,24 @@ static inline void copy_tlb_helper_locked(CPUTLBEntry *d, const CPUTLBEntry *s)
  */
 void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length)
 {
-    CPUArchState *env;
-
     int mmu_idx;
 
-    env = cpu_env(cpu);
-    qemu_spin_lock(&env_tlb(env)->c.lock);
+    qemu_spin_lock(&cpu->neg.tlb.c.lock);
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
         unsigned int i;
-        unsigned int n = tlb_n_entries(&env_tlb(env)->f[mmu_idx]);
+        unsigned int n = tlb_n_entries(&cpu->neg.tlb.f[mmu_idx]);
 
         for (i = 0; i < n; i++) {
-            tlb_reset_dirty_range_locked(&env_tlb(env)->f[mmu_idx].table[i],
+            tlb_reset_dirty_range_locked(&cpu->neg.tlb.f[mmu_idx].table[i],
                                          start1, length);
         }
 
         for (i = 0; i < CPU_VTLB_SIZE; i++) {
-            tlb_reset_dirty_range_locked(&env_tlb(env)->d[mmu_idx].vtable[i],
+            tlb_reset_dirty_range_locked(&cpu->neg.tlb.d[mmu_idx].vtable[i],
                                          start1, length);
         }
     }
-    qemu_spin_unlock(&env_tlb(env)->c.lock);
+    qemu_spin_unlock(&cpu->neg.tlb.c.lock);
 }
 
 /* Called with tlb_c.lock held */
@@ -1064,32 +1054,31 @@ static inline void tlb_set_dirty1_locked(CPUTLBEntry *tlb_entry,
    so that it is no longer dirty */
 void tlb_set_dirty(CPUState *cpu, vaddr addr)
 {
-    CPUArchState *env = cpu_env(cpu);
     int mmu_idx;
 
     assert_cpu_is_self(cpu);
 
     addr &= TARGET_PAGE_MASK;
-    qemu_spin_lock(&env_tlb(env)->c.lock);
+    qemu_spin_lock(&cpu->neg.tlb.c.lock);
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
-        tlb_set_dirty1_locked(tlb_entry(env, mmu_idx, addr), addr);
+        tlb_set_dirty1_locked(tlb_entry(cpu, mmu_idx, addr), addr);
     }
 
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
         int k;
         for (k = 0; k < CPU_VTLB_SIZE; k++) {
-            tlb_set_dirty1_locked(&env_tlb(env)->d[mmu_idx].vtable[k], addr);
+            tlb_set_dirty1_locked(&cpu->neg.tlb.d[mmu_idx].vtable[k], addr);
         }
     }
-    qemu_spin_unlock(&env_tlb(env)->c.lock);
+    qemu_spin_unlock(&cpu->neg.tlb.c.lock);
 }
 
 /* Our TLB does not support large pages, so remember the area covered by
    large pages and trigger a full TLB flush if these are invalidated.  */
-static void tlb_add_large_page(CPUArchState *env, int mmu_idx,
+static void tlb_add_large_page(CPUState *cpu, int mmu_idx,
                                vaddr addr, uint64_t size)
 {
-    vaddr lp_addr = env_tlb(env)->d[mmu_idx].large_page_addr;
+    vaddr lp_addr = cpu->neg.tlb.d[mmu_idx].large_page_addr;
     vaddr lp_mask = ~(size - 1);
 
     if (lp_addr == (vaddr)-1) {
@@ -1099,13 +1088,13 @@ static void tlb_add_large_page(CPUArchState *env, int mmu_idx,
         /* Extend the existing region to include the new page.
            This is a compromise between unnecessary flushes and
            the cost of maintaining a full variable size TLB.  */
-        lp_mask &= env_tlb(env)->d[mmu_idx].large_page_mask;
+        lp_mask &= cpu->neg.tlb.d[mmu_idx].large_page_mask;
         while (((lp_addr ^ addr) & lp_mask) != 0) {
             lp_mask <<= 1;
         }
     }
-    env_tlb(env)->d[mmu_idx].large_page_addr = lp_addr & lp_mask;
-    env_tlb(env)->d[mmu_idx].large_page_mask = lp_mask;
+    cpu->neg.tlb.d[mmu_idx].large_page_addr = lp_addr & lp_mask;
+    cpu->neg.tlb.d[mmu_idx].large_page_mask = lp_mask;
 }
 
 static inline void tlb_set_compare(CPUTLBEntryFull *full, CPUTLBEntry *ent,
@@ -1137,8 +1126,7 @@ static inline void tlb_set_compare(CPUTLBEntryFull *full, CPUTLBEntry *ent,
 void tlb_set_page_full(CPUState *cpu, int mmu_idx,
                        vaddr addr, CPUTLBEntryFull *full)
 {
-    CPUArchState *env = cpu_env(cpu);
-    CPUTLB *tlb = env_tlb(env);
+    CPUTLB *tlb = &cpu->neg.tlb;
     CPUTLBDesc *desc = &tlb->d[mmu_idx];
     MemoryRegionSection *section;
     unsigned int index, read_flags, write_flags;
@@ -1155,7 +1143,7 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
         sz = TARGET_PAGE_SIZE;
     } else {
         sz = (hwaddr)1 << full->lg_page_size;
-        tlb_add_large_page(env, mmu_idx, addr, sz);
+        tlb_add_large_page(cpu, mmu_idx, addr, sz);
     }
     addr_page = addr & TARGET_PAGE_MASK;
     paddr_page = full->phys_addr & TARGET_PAGE_MASK;
@@ -1222,8 +1210,8 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
     wp_flags = cpu_watchpoint_address_matches(cpu, addr_page,
                                               TARGET_PAGE_SIZE);
 
-    index = tlb_index(env, mmu_idx, addr_page);
-    te = tlb_entry(env, mmu_idx, addr_page);
+    index = tlb_index(cpu, mmu_idx, addr_page);
+    te = tlb_entry(cpu, mmu_idx, addr_page);
 
     /*
      * Hold the TLB lock for the rest of the function. We could acquire/release
@@ -1238,7 +1226,7 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
     tlb->c.dirty |= 1 << mmu_idx;
 
     /* Make sure there's no cached translation for the new page.  */
-    tlb_flush_vtlb_page_locked(env, mmu_idx, addr_page);
+    tlb_flush_vtlb_page_locked(cpu, mmu_idx, addr_page);
 
     /*
      * Only evict the old entry to the victim tlb if it's for a
@@ -1251,7 +1239,7 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
         /* Evict the old entry into the victim tlb.  */
         copy_tlb_helper_locked(tv, te);
         desc->vfulltlb[vidx] = desc->fulltlb[index];
-        tlb_n_used_entries_dec(env, mmu_idx);
+        tlb_n_used_entries_dec(cpu, mmu_idx);
     }
 
     /* refill the tlb */
@@ -1296,7 +1284,7 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
                     MMU_DATA_STORE, prot & PAGE_WRITE);
 
     copy_tlb_helper_locked(te, &tn);
-    tlb_n_used_entries_inc(env, mmu_idx);
+    tlb_n_used_entries_inc(cpu, mmu_idx);
     qemu_spin_unlock(&tlb->c.lock);
 }
 
@@ -1390,28 +1378,28 @@ static void io_failed(CPUArchState *env, CPUTLBEntryFull *full, vaddr addr,
 
 /* Return true if ADDR is present in the victim tlb, and has been copied
    back to the main tlb.  */
-static bool victim_tlb_hit(CPUArchState *env, size_t mmu_idx, size_t index,
+static bool victim_tlb_hit(CPUState *cpu, size_t mmu_idx, size_t index,
                            MMUAccessType access_type, vaddr page)
 {
     size_t vidx;
 
-    assert_cpu_is_self(env_cpu(env));
+    assert_cpu_is_self(cpu);
     for (vidx = 0; vidx < CPU_VTLB_SIZE; ++vidx) {
-        CPUTLBEntry *vtlb = &env_tlb(env)->d[mmu_idx].vtable[vidx];
+        CPUTLBEntry *vtlb = &cpu->neg.tlb.d[mmu_idx].vtable[vidx];
         uint64_t cmp = tlb_read_idx(vtlb, access_type);
 
         if (cmp == page) {
             /* Found entry in victim tlb, swap tlb and iotlb.  */
-            CPUTLBEntry tmptlb, *tlb = &env_tlb(env)->f[mmu_idx].table[index];
+            CPUTLBEntry tmptlb, *tlb = &cpu->neg.tlb.f[mmu_idx].table[index];
 
-            qemu_spin_lock(&env_tlb(env)->c.lock);
+            qemu_spin_lock(&cpu->neg.tlb.c.lock);
             copy_tlb_helper_locked(&tmptlb, tlb);
             copy_tlb_helper_locked(tlb, vtlb);
             copy_tlb_helper_locked(vtlb, &tmptlb);
-            qemu_spin_unlock(&env_tlb(env)->c.lock);
+            qemu_spin_unlock(&cpu->neg.tlb.c.lock);
 
-            CPUTLBEntryFull *f1 = &env_tlb(env)->d[mmu_idx].fulltlb[index];
-            CPUTLBEntryFull *f2 = &env_tlb(env)->d[mmu_idx].vfulltlb[vidx];
+            CPUTLBEntryFull *f1 = &cpu->neg.tlb.d[mmu_idx].fulltlb[index];
+            CPUTLBEntryFull *f2 = &cpu->neg.tlb.d[mmu_idx].vfulltlb[vidx];
             CPUTLBEntryFull tmpf;
             tmpf = *f1; *f1 = *f2; *f2 = tmpf;
             return true;
@@ -1450,8 +1438,8 @@ static int probe_access_internal(CPUArchState *env, vaddr addr,
                                  void **phost, CPUTLBEntryFull **pfull,
                                  uintptr_t retaddr, bool check_mem_cbs)
 {
-    uintptr_t index = tlb_index(env, mmu_idx, addr);
-    CPUTLBEntry *entry = tlb_entry(env, mmu_idx, addr);
+    uintptr_t index = tlb_index(env_cpu(env), mmu_idx, addr);
+    CPUTLBEntry *entry = tlb_entry(env_cpu(env), mmu_idx, addr);
     uint64_t tlb_addr = tlb_read_idx(entry, access_type);
     vaddr page_addr = addr & TARGET_PAGE_MASK;
     int flags = TLB_FLAGS_MASK & ~TLB_FORCE_SLOW;
@@ -1459,7 +1447,8 @@ static int probe_access_internal(CPUArchState *env, vaddr addr,
     CPUTLBEntryFull *full;
 
     if (!tlb_hit_page(tlb_addr, page_addr)) {
-        if (!victim_tlb_hit(env, mmu_idx, index, access_type, page_addr)) {
+        if (!victim_tlb_hit(env_cpu(env), mmu_idx, index,
+                            access_type, page_addr)) {
             CPUState *cs = env_cpu(env);
 
             if (!cs->cc->tcg_ops->tlb_fill(cs, addr, fault_size, access_type,
@@ -1471,8 +1460,8 @@ static int probe_access_internal(CPUArchState *env, vaddr addr,
             }
 
             /* TLB resize via tlb_fill may have moved the entry.  */
-            index = tlb_index(env, mmu_idx, addr);
-            entry = tlb_entry(env, mmu_idx, addr);
+            index = tlb_index(env_cpu(env), mmu_idx, addr);
+            entry = tlb_entry(env_cpu(env), mmu_idx, addr);
 
             /*
              * With PAGE_WRITE_INV, we set TLB_INVALID_MASK immediately,
@@ -1662,9 +1651,8 @@ tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env, vaddr addr,
 bool tlb_plugin_lookup(CPUState *cpu, vaddr addr, int mmu_idx,
                        bool is_store, struct qemu_plugin_hwaddr *data)
 {
-    CPUArchState *env = cpu_env(cpu);
-    CPUTLBEntry *tlbe = tlb_entry(env, mmu_idx, addr);
-    uintptr_t index = tlb_index(env, mmu_idx, addr);
+    CPUTLBEntry *tlbe = tlb_entry(cpu, mmu_idx, addr);
+    uintptr_t index = tlb_index(cpu, mmu_idx, addr);
     MMUAccessType access_type = is_store ? MMU_DATA_STORE : MMU_DATA_LOAD;
     uint64_t tlb_addr = tlb_read_idx(tlbe, access_type);
     CPUTLBEntryFull *full;
@@ -1673,7 +1661,7 @@ bool tlb_plugin_lookup(CPUState *cpu, vaddr addr, int mmu_idx,
         return false;
     }
 
-    full = &env_tlb(env)->d[mmu_idx].fulltlb[index];
+    full = &cpu->neg.tlb.d[mmu_idx].fulltlb[index];
     data->phys_addr = full->phys_addr | (addr & ~TARGET_PAGE_MASK);
 
     /* We must have an iotlb entry for MMIO */
@@ -1727,8 +1715,8 @@ static bool mmu_lookup1(CPUArchState *env, MMULookupPageData *data,
                         int mmu_idx, MMUAccessType access_type, uintptr_t ra)
 {
     vaddr addr = data->addr;
-    uintptr_t index = tlb_index(env, mmu_idx, addr);
-    CPUTLBEntry *entry = tlb_entry(env, mmu_idx, addr);
+    uintptr_t index = tlb_index(env_cpu(env), mmu_idx, addr);
+    CPUTLBEntry *entry = tlb_entry(env_cpu(env), mmu_idx, addr);
     uint64_t tlb_addr = tlb_read_idx(entry, access_type);
     bool maybe_resized = false;
     CPUTLBEntryFull *full;
@@ -1736,12 +1724,12 @@ static bool mmu_lookup1(CPUArchState *env, MMULookupPageData *data,
 
     /* If the TLB entry is for a different page, reload and try again.  */
     if (!tlb_hit(tlb_addr, addr)) {
-        if (!victim_tlb_hit(env, mmu_idx, index, access_type,
+        if (!victim_tlb_hit(env_cpu(env), mmu_idx, index, access_type,
                             addr & TARGET_PAGE_MASK)) {
             tlb_fill(env_cpu(env), addr, data->size, access_type, mmu_idx, ra);
             maybe_resized = true;
-            index = tlb_index(env, mmu_idx, addr);
-            entry = tlb_entry(env, mmu_idx, addr);
+            index = tlb_index(env_cpu(env), mmu_idx, addr);
+            entry = tlb_entry(env_cpu(env), mmu_idx, addr);
         }
         tlb_addr = tlb_read_idx(entry, access_type) & ~TLB_INVALID_MASK;
     }
@@ -1849,7 +1837,7 @@ static bool mmu_lookup(CPUArchState *env, vaddr addr, MemOpIdx oi,
          */
         mmu_lookup1(env, &l->page[0], l->mmu_idx, type, ra);
         if (mmu_lookup1(env, &l->page[1], l->mmu_idx, type, ra)) {
-            uintptr_t index = tlb_index(env, l->mmu_idx, addr);
+            uintptr_t index = tlb_index(env_cpu(env), l->mmu_idx, addr);
             l->page[0].full = &env_tlb(env)->d[l->mmu_idx].fulltlb[index];
         }
 
@@ -1907,18 +1895,18 @@ static void *atomic_mmu_lookup(CPUArchState *env, vaddr addr, MemOpIdx oi,
         goto stop_the_world;
     }
 
-    index = tlb_index(env, mmu_idx, addr);
-    tlbe = tlb_entry(env, mmu_idx, addr);
+    index = tlb_index(env_cpu(env), mmu_idx, addr);
+    tlbe = tlb_entry(env_cpu(env), mmu_idx, addr);
 
     /* Check TLB entry and enforce page permissions.  */
     tlb_addr = tlb_addr_write(tlbe);
     if (!tlb_hit(tlb_addr, addr)) {
-        if (!victim_tlb_hit(env, mmu_idx, index, MMU_DATA_STORE,
+        if (!victim_tlb_hit(env_cpu(env), mmu_idx, index, MMU_DATA_STORE,
                             addr & TARGET_PAGE_MASK)) {
             tlb_fill(env_cpu(env), addr, size,
                      MMU_DATA_STORE, mmu_idx, retaddr);
-            index = tlb_index(env, mmu_idx, addr);
-            tlbe = tlb_entry(env, mmu_idx, addr);
+            index = tlb_index(env_cpu(env), mmu_idx, addr);
+            tlbe = tlb_entry(env_cpu(env), mmu_idx, addr);
         }
         tlb_addr = tlb_addr_write(tlbe) & ~TLB_INVALID_MASK;
     }
-- 
2.34.1


