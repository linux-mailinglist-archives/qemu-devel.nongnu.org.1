Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AAEEC7E33A9
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:12:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0COb-00077u-Ga; Mon, 06 Nov 2023 22:04:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0COL-0006fU-8G
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:38 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CNz-0000dX-OR
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:30 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6c10f098a27so3942385b3a.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326253; x=1699931053; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nB70z+ZvL+Oe/IRdMH3NRlu18gtAh7HSDv+Gha4r1Og=;
 b=Vt7nLetoyOZ3FqwMlcZLVvfPoYlvsi3kNMw8cDmFZi6O8cd9rrv1w75GFO/2KPf6gp
 OHaCCB5ifhE1OhfaoDcd2/WuBV6keX4pdSApzUA3p7kYuH9000xBfA3i+kCE65i4qgfL
 QZ3Y3vyBZZ2j7Y328QwUl1Q7VSX/WTwTaFar7W9mTOyTnJMt6EXv8QO/A9N5DxV5Z97l
 zKkcvSIoXXd15wZ3JGvs/gYzBjmbZ2HZzeHUw7PiOTeLcBwceMrpUBSJXgT1twZQvlp2
 QRJ/C4xRJL9GoZbFPkZAnAQAPJAKIeUjrxWYtxh5r/UZ7dtvKg/oiEwzww3HeNzXeN7m
 ZWjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326253; x=1699931053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nB70z+ZvL+Oe/IRdMH3NRlu18gtAh7HSDv+Gha4r1Og=;
 b=hnBVlxEQt2rfG244ZOdnqgpUSu+ArzEIyNYtErTXmikw5Aa/SEngjOhJYjY049Q9eZ
 4I8moyOl94ENWONfx4eyIzLrXhDiDm8yL03uw1KNSWJNPb0hXUKRWStjcC1BiMevdKzj
 7XjiZBq65F1gshJba7kDbs0IQVfdqD9AbSivUOB0mnswN8uLDFLXYna9jWtyjkcFPp03
 OjOVsCnLKRrIylAuwEhTlKjVkwD7BinH0r5wWZKlkNM6KYwhydDUy2rYt76WSEvYZsvu
 99KJMWFxwdVhopTl8odrPlPN5FHGV1ZYccrp4PW59mcRIfjb1SnpXwkvv8aY2ypS6a24
 2LcQ==
X-Gm-Message-State: AOJu0Yz8liU9kZgdWB49TOexeQPms0RCGtNSjrAyrXEaVWPnbZMRzx4d
 xB0BYjnXdPvHsdug9PkmZu3ohIfEGUrSRlBalrw=
X-Google-Smtp-Source: AGHT+IEyym4bFy3lOCyEB+C9xoj9OACdMmqKYckRRX6JZZCz+GCvWN/79Ds3meNaKsRREkX2dCWZXg==
X-Received: by 2002:a05:6a20:3d01:b0:15e:2d9f:cae0 with SMTP id
 y1-20020a056a203d0100b0015e2d9fcae0mr31132790pzi.10.1699326253299; 
 Mon, 06 Nov 2023 19:04:13 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u9-20020a17090282c900b001c72d5e16acsm6518012plz.57.2023.11.06.19.04.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:04:12 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/85] target/hppa: Populate an interval tree with valid tlb
 entries
Date: Mon,  6 Nov 2023 19:02:48 -0800
Message-Id: <20231107030407.8979-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

Complete the data structure conversion started earlier.  This reduces
the perf overhead of hppa_get_physical_address from ~5% to ~0.25%.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.h        |  24 +++++-
 target/hppa/cpu.c        |   2 +
 target/hppa/machine.c    |  51 ++++++++++++-
 target/hppa/mem_helper.c | 161 +++++++++++++++++++++++----------------
 4 files changed, 167 insertions(+), 71 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 1480d0237a..08de894393 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -176,7 +176,10 @@ typedef int64_t  target_sreg;
 #endif
 
 typedef struct HPPATLBEntry {
-    IntervalTreeNode itree;
+    union {
+        IntervalTreeNode itree;
+        struct HPPATLBEntry *unused_next;
+    };
 
     target_ureg pa;
 
@@ -234,10 +237,22 @@ typedef struct CPUArchState {
 #define HPPA_TLB_ENTRIES        256
 #define HPPA_BTLB_ENTRIES       (HPPA_BTLB_FIXED + HPPA_BTLB_VARIABLE)
 
-    /* ??? Implement a unified itlb/dtlb for the moment.  */
-    /* ??? We should use a more intelligent data structure.  */
-    HPPATLBEntry tlb[HPPA_TLB_ENTRIES];
+    /* Index for round-robin tlb eviction. */
     uint32_t tlb_last;
+
+    /*
+     * For pa1.x, the partial initialized, still invalid tlb entry
+     * which has had ITLBA performed, but not yet ITLBP.
+     */
+    HPPATLBEntry *tlb_partial;
+
+    /* Linked list of all invalid (unused) tlb entries. */
+    HPPATLBEntry *tlb_unused;
+
+    /* Root of the search tree for all valid tlb entries. */
+    IntervalTreeRoot tlb_root;
+
+    HPPATLBEntry tlb[HPPA_TLB_ENTRIES];
 } CPUHPPAState;
 
 /**
@@ -356,6 +371,7 @@ int hppa_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int hppa_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 void hppa_cpu_dump_state(CPUState *cs, FILE *f, int);
 #ifndef CONFIG_USER_ONLY
+void hppa_ptlbe(CPUHPPAState *env);
 hwaddr hppa_cpu_get_phys_page_debug(CPUState *cs, vaddr addr);
 bool hppa_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                        MMUAccessType access_type, int mmu_idx,
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 1644297bf8..5e1240c631 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -137,8 +137,10 @@ static void hppa_cpu_realizefn(DeviceState *dev, Error **errp)
 #ifndef CONFIG_USER_ONLY
     {
         HPPACPU *cpu = HPPA_CPU(cs);
+
         cpu->alarm_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
                                         hppa_cpu_alarm_timer, cpu);
+        hppa_ptlbe(&cpu->env);
     }
 #endif
 }
diff --git a/target/hppa/machine.c b/target/hppa/machine.c
index 4535195ca2..ab3e8c81fa 100644
--- a/target/hppa/machine.c
+++ b/target/hppa/machine.c
@@ -72,8 +72,6 @@ static int get_tlb(QEMUFile *f, void *opaque, size_t size,
     HPPATLBEntry *ent = opaque;
     uint32_t val;
 
-    memset(ent, 0, sizeof(*ent));
-
     ent->itree.start = qemu_get_be64(f);
     ent->pa = qemu_get_betr(f);
     val = qemu_get_be32(f);
@@ -122,6 +120,53 @@ static const VMStateInfo vmstate_tlb = {
     .put = put_tlb,
 };
 
+static int tlb_pre_load(void *opaque)
+{
+    CPUHPPAState *env = opaque;
+
+    /*
+     * Zap the entire tlb, on-the-side data structures and all.
+     * Each tlb entry will have data re-filled by put_tlb.
+     */
+    memset(env->tlb, 0, sizeof(env->tlb));
+    memset(&env->tlb_root, 0, sizeof(env->tlb_root));
+    env->tlb_unused = NULL;
+    env->tlb_partial = NULL;
+
+    return 0;
+}
+
+static int tlb_post_load(void *opaque, int version_id)
+{
+    CPUHPPAState *env = opaque;
+    HPPATLBEntry **unused = &env->tlb_unused;
+    HPPATLBEntry *partial = NULL;
+
+    /*
+     * Re-create the interval tree from the valid entries.
+     * Truely invalid entries should have start == end == 0.
+     * Otherwise it should be the in-flight tlb_partial entry.
+     */
+    for (uint32_t i = 0; i < ARRAY_SIZE(env->tlb); ++i) {
+        HPPATLBEntry *e = &env->tlb[i];
+
+        if (e->entry_valid) {
+            interval_tree_insert(&e->itree, &env->tlb_root);
+        } else if (i < HPPA_BTLB_ENTRIES) {
+            /* btlb not in unused list */
+        } else if (partial == NULL && e->itree.start < e->itree.last) {
+            partial = e;
+        } else {
+            *unused = e;
+            unused = &e->unused_next;
+        }
+    }
+    env->tlb_partial = partial;
+    *unused = NULL;
+
+    return 0;
+}
+
 static VMStateField vmstate_env_fields[] = {
     VMSTATE_UINTTR_ARRAY(gr, CPUHPPAState, 32),
     VMSTATE_UINT64_ARRAY(fr, CPUHPPAState, 32),
@@ -164,6 +209,8 @@ static const VMStateDescription vmstate_env = {
     .version_id = 1,
     .minimum_version_id = 1,
     .fields = vmstate_env_fields,
+    .pre_load = tlb_pre_load,
+    .post_load = tlb_post_load,
 };
 
 static VMStateField vmstate_cpu_fields[] = {
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 828cceb29c..b1773ece61 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -27,16 +27,13 @@
 
 static HPPATLBEntry *hppa_find_tlb(CPUHPPAState *env, vaddr addr)
 {
-    int i;
+    IntervalTreeNode *i = interval_tree_iter_first(&env->tlb_root, addr, addr);
 
-    for (i = 0; i < ARRAY_SIZE(env->tlb); ++i) {
-        HPPATLBEntry *ent = &env->tlb[i];
-        if (ent->itree.start <= addr && addr <= ent->itree.last) {
-            trace_hppa_tlb_find_entry(env, ent + i, ent->entry_valid,
-                                      ent->itree.start, ent->itree.last,
-                                      ent->pa);
-            return ent;
-        }
+    if (i) {
+        HPPATLBEntry *ent = container_of(i, HPPATLBEntry, itree);
+        trace_hppa_tlb_find_entry(env, ent, ent->entry_valid,
+                                  ent->itree.start, ent->itree.last, ent->pa);
+        return ent;
     }
     trace_hppa_tlb_find_entry_not_found(env, addr);
     return NULL;
@@ -46,6 +43,7 @@ static void hppa_flush_tlb_ent(CPUHPPAState *env, HPPATLBEntry *ent,
                                bool force_flush_btlb)
 {
     CPUState *cs = env_cpu(env);
+    bool is_btlb;
 
     if (!ent->entry_valid) {
         return;
@@ -58,50 +56,55 @@ static void hppa_flush_tlb_ent(CPUHPPAState *env, HPPATLBEntry *ent,
                               ent->itree.last - ent->itree.start + 1,
                               HPPA_MMU_FLUSH_MASK, TARGET_LONG_BITS);
 
-    /* never clear BTLBs, unless forced to do so. */
-    if (ent < &env->tlb[HPPA_BTLB_ENTRIES] && !force_flush_btlb) {
+    /* Never clear BTLBs, unless forced to do so. */
+    is_btlb = ent < &env->tlb[HPPA_BTLB_ENTRIES];
+    if (is_btlb && !force_flush_btlb) {
         return;
     }
 
+    interval_tree_remove(&ent->itree, &env->tlb_root);
     memset(ent, 0, sizeof(*ent));
-    ent->itree.start = -1;
+
+    if (!is_btlb) {
+        ent->unused_next = env->tlb_unused;
+        env->tlb_unused = ent;
+    }
 }
 
-static HPPATLBEntry *hppa_flush_tlb_range(CPUHPPAState *env,
-                                          vaddr va_b, vaddr va_e)
+static void hppa_flush_tlb_range(CPUHPPAState *env, vaddr va_b, vaddr va_e)
 {
-    HPPATLBEntry *empty = NULL;
+    IntervalTreeNode *i, *n;
 
-    /* Zap any old entries covering ADDR; notice empty entries on the way.  */
-    for (int i = HPPA_BTLB_ENTRIES; i < ARRAY_SIZE(env->tlb); ++i) {
-        HPPATLBEntry *ent = &env->tlb[i];
+    i = interval_tree_iter_first(&env->tlb_root, va_b, va_e);
+    for (; i ; i = n) {
+        HPPATLBEntry *ent = container_of(i, HPPATLBEntry, itree);
 
-        if (!ent->entry_valid) {
-            empty = ent;
-        } else if (va_e >= ent->itree.start && va_b <= ent->itree.last) {
-            hppa_flush_tlb_ent(env, ent, false);
-            empty = ent;
-        }
+        /*
+         * Find the next entry now: In the normal case the current entry
+         * will be removed, but in the BTLB case it will remain.
+         */
+        n = interval_tree_iter_next(i, va_b, va_e);
+        hppa_flush_tlb_ent(env, ent, false);
     }
-    return empty;
 }
 
 static HPPATLBEntry *hppa_alloc_tlb_ent(CPUHPPAState *env)
 {
-    HPPATLBEntry *ent;
-    uint32_t i;
+    HPPATLBEntry *ent = env->tlb_unused;
 
-    if (env->tlb_last < HPPA_BTLB_ENTRIES || env->tlb_last >= ARRAY_SIZE(env->tlb)) {
-        i = HPPA_BTLB_ENTRIES;
-        env->tlb_last = HPPA_BTLB_ENTRIES + 1;
-    } else {
-        i = env->tlb_last;
-        env->tlb_last++;
+    if (ent == NULL) {
+        uint32_t i = env->tlb_last;
+
+        if (i < HPPA_BTLB_ENTRIES || i >= ARRAY_SIZE(env->tlb)) {
+            i = HPPA_BTLB_ENTRIES;
+        }
+        env->tlb_last = i + 1;
+
+        ent = &env->tlb[i];
+        hppa_flush_tlb_ent(env, ent, false);
     }
 
-    ent = &env->tlb[i];
-
-    hppa_flush_tlb_ent(env, ent, false);
+    env->tlb_unused = ent->unused_next;
     return ent;
 }
 
@@ -127,7 +130,7 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
 
     /* Find a valid tlb entry that matches the virtual address.  */
     ent = hppa_find_tlb(env, addr);
-    if (ent == NULL || !ent->entry_valid) {
+    if (ent == NULL) {
         phys = 0;
         prot = 0;
         ret = (type == PAGE_EXEC) ? EXCP_ITLB_MISS : EXCP_DTLB_MISS;
@@ -303,23 +306,23 @@ bool hppa_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
 /* Insert (Insn/Data) TLB Address.  Note this is PA 1.1 only.  */
 void HELPER(itlba)(CPUHPPAState *env, target_ulong addr, target_ureg reg)
 {
-    HPPATLBEntry *empty;
+    HPPATLBEntry *ent;
 
-    /* Zap any old entries covering ADDR; notice empty entries on the way.  */
+    /* Zap any old entries covering ADDR. */
     addr &= TARGET_PAGE_MASK;
-    empty = hppa_flush_tlb_range(env, addr, addr + TARGET_PAGE_SIZE - 1);
+    hppa_flush_tlb_range(env, addr, addr + TARGET_PAGE_SIZE - 1);
 
-    /* If we didn't see an empty entry, evict one.  */
-    if (empty == NULL) {
-        empty = hppa_alloc_tlb_ent(env);
+    ent = env->tlb_partial;
+    if (ent == NULL) {
+        ent = hppa_alloc_tlb_ent(env);
+        env->tlb_partial = ent;
     }
 
-    /* Note that empty->entry_valid == 0 already.  */
-    empty->itree.start = addr;
-    empty->itree.last = addr + TARGET_PAGE_SIZE - 1;
-    empty->pa = extract32(reg, 5, 20) << TARGET_PAGE_BITS;
-    trace_hppa_tlb_itlba(env, empty, empty->itree.start,
-                         empty->itree.last, empty->pa);
+    /* Note that ent->entry_valid == 0 already.  */
+    ent->itree.start = addr;
+    ent->itree.last = addr + TARGET_PAGE_SIZE - 1;
+    ent->pa = extract32(reg, 5, 20) << TARGET_PAGE_BITS;
+    trace_hppa_tlb_itlba(env, ent, ent->itree.start, ent->itree.last, ent->pa);
 }
 
 static void set_access_bits(CPUHPPAState *env, HPPATLBEntry *ent, target_ureg reg)
@@ -333,6 +336,8 @@ static void set_access_bits(CPUHPPAState *env, HPPATLBEntry *ent, target_ureg re
     ent->d = extract32(reg, 28, 1);
     ent->t = extract32(reg, 29, 1);
     ent->entry_valid = 1;
+
+    interval_tree_insert(&ent->itree, &env->tlb_root);
     trace_hppa_tlb_itlbp(env, ent, ent->access_id, ent->u, ent->ar_pl2,
                          ent->ar_pl1, ent->ar_type, ent->b, ent->d, ent->t);
 }
@@ -340,14 +345,16 @@ static void set_access_bits(CPUHPPAState *env, HPPATLBEntry *ent, target_ureg re
 /* Insert (Insn/Data) TLB Protection.  Note this is PA 1.1 only.  */
 void HELPER(itlbp)(CPUHPPAState *env, target_ulong addr, target_ureg reg)
 {
-    HPPATLBEntry *ent = hppa_find_tlb(env, addr);
+    HPPATLBEntry *ent = env->tlb_partial;
 
-    if (unlikely(ent == NULL)) {
-        qemu_log_mask(LOG_GUEST_ERROR, "ITLBP not following ITLBA\n");
-        return;
+    if (ent) {
+        env->tlb_partial = NULL;
+        if (ent->itree.start <= addr && addr <= ent->itree.last) {
+            set_access_bits(env, ent, reg);
+            return;
+        }
     }
-
-    set_access_bits(env, ent, reg);
+    qemu_log_mask(LOG_GUEST_ERROR, "ITLBP not following ITLBA\n");
 }
 
 /* Purge (Insn/Data) TLB.  This is explicitly page-based, and is
@@ -356,17 +363,15 @@ static void ptlb_work(CPUState *cpu, run_on_cpu_data data)
 {
     CPUHPPAState *env = cpu_env(cpu);
     target_ulong addr = (target_ulong) data.target_ptr;
-    HPPATLBEntry *ent = hppa_find_tlb(env, addr);
 
-    if (ent && ent->entry_valid) {
-        hppa_flush_tlb_ent(env, ent, false);
-    }
+    hppa_flush_tlb_range(env, addr, addr);
 }
 
 void HELPER(ptlb)(CPUHPPAState *env, target_ulong addr)
 {
     CPUState *src = env_cpu(env);
     CPUState *cpu;
+
     trace_hppa_tlb_ptlb(env);
     run_on_cpu_data data = RUN_ON_CPU_TARGET_PTR(addr);
 
@@ -378,16 +383,40 @@ void HELPER(ptlb)(CPUHPPAState *env, target_ulong addr)
     async_safe_run_on_cpu(src, ptlb_work, data);
 }
 
+void hppa_ptlbe(CPUHPPAState *env)
+{
+    uint32_t i;
+
+    /* Zap the (non-btlb) tlb entries themselves. */
+    memset(&env->tlb[HPPA_BTLB_ENTRIES], 0,
+           sizeof(env->tlb) - HPPA_BTLB_ENTRIES * sizeof(env->tlb[0]));
+    env->tlb_last = HPPA_BTLB_ENTRIES;
+    env->tlb_partial = NULL;
+
+    /* Put them all onto the unused list. */
+    env->tlb_unused = &env->tlb[HPPA_BTLB_ENTRIES];
+    for (i = HPPA_BTLB_ENTRIES; i < ARRAY_SIZE(env->tlb) - 1; ++i) {
+        env->tlb[i].unused_next = &env->tlb[i + 1];
+    }
+
+    /* Re-initialize the interval tree with only the btlb entries. */
+    memset(&env->tlb_root, 0, sizeof(env->tlb_root));
+    for (i = 0; i < HPPA_BTLB_ENTRIES; ++i) {
+        if (env->tlb[i].entry_valid) {
+            interval_tree_insert(&env->tlb[i].itree, &env->tlb_root);
+        }
+    }
+
+    tlb_flush_by_mmuidx(env_cpu(env), HPPA_MMU_FLUSH_MASK);
+}
+
 /* Purge (Insn/Data) TLB entry.  This affects an implementation-defined
    number of pages/entries (we choose all), and is local to the cpu.  */
 void HELPER(ptlbe)(CPUHPPAState *env)
 {
     trace_hppa_tlb_ptlbe(env);
     qemu_log_mask(CPU_LOG_MMU, "FLUSH ALL TLB ENTRIES\n");
-    memset(&env->tlb[HPPA_BTLB_ENTRIES], 0,
-        sizeof(env->tlb) - HPPA_BTLB_ENTRIES * sizeof(env->tlb[0]));
-    env->tlb_last = HPPA_BTLB_ENTRIES;
-    tlb_flush_by_mmuidx(env_cpu(env), HPPA_MMU_FLUSH_MASK);
+    hppa_ptlbe(env);
 }
 
 void cpu_hppa_change_prot_id(CPUHPPAState *env)
@@ -483,9 +512,11 @@ void HELPER(diag_btlb)(CPUHPPAState *env)
                     (long long) virt_page, phys_page, len, slot);
         if (slot < HPPA_BTLB_ENTRIES) {
             btlb = &env->tlb[slot];
-            /* force flush of possibly existing BTLB entry */
+
+            /* Force flush of possibly existing BTLB entry. */
             hppa_flush_tlb_ent(env, btlb, true);
-            /* create new BTLB entry */
+
+            /* Create new BTLB entry */
             btlb->itree.start = virt_page << TARGET_PAGE_BITS;
             btlb->itree.last = btlb->itree.start + len * TARGET_PAGE_SIZE - 1;
             btlb->pa = phys_page << TARGET_PAGE_BITS;
-- 
2.34.1


