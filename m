Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC017E337B
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:06:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0COc-0007L6-TO; Mon, 06 Nov 2023 22:04:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0COL-0006fW-9Q
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:38 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CO7-0000fd-H4
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:25 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1cc37fb1310so36632955ad.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326262; x=1699931062; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sXBKF6uHHMihJPl4uhe8/3+lsxd/tpaCJO/Jxdl9png=;
 b=wGt0TXGpERLU6TaA2VbfmyLHxXMBeGG61rQuMV7EC+PhDoAepBQlF7R4huW0P522LV
 G7lqAFCYDlal0T4Kk7DEcbfujAFxh7m5/rCtrTmIfmKq8fMNwPiFredkiXgzgxjS6VMj
 eY5UJDZHwe3Ln5RT7mK8nKg6mRI1SyfbgFyvfbTFsiWQ2KXPjy6uqwD52Ttfs5BYSyYy
 6jgocqdfH2eAqOrkAp+L6InMCgQUmRV+J9INZQa5fwmE+fixj7uJcTecPqLcFB4395gl
 giKdz2bf0822RzaojXGtji44vQO9fIrSQch2OaA2XGrA7VW/BWcUc5HIxdAtrQJBmC8M
 mRsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326262; x=1699931062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sXBKF6uHHMihJPl4uhe8/3+lsxd/tpaCJO/Jxdl9png=;
 b=S8DFs14f5OgnX0s8GVlYuSbagiYzzk1br+Fo5B8qGwx6BD/K2Fj+sdhXZmUow8bhI7
 DEvGAOBmJsz1yGSxEk3/ErkzGeN8rjAbnBVbp0myX7tfeDHRvWUARng6rhD1JQoxo9pY
 xXlh8anJ6M9orSGjH/JHRWRhEIQUSsR3KsPDVtd7AxFQXrdrtkwFsF1zuyedjLv4Dq1P
 sqgsL+2QioTZWEwA+Ropw1PumO50ElqGbODAjdjJpiN0BU3sruM4dZxhRJZ2M+d90rl3
 JMBNVpGGlsxgtWdXLqB7l+vHK+r+EISbP935T673VrasA0MXQrBU5ksKKlXfgLiDlTSN
 3tEA==
X-Gm-Message-State: AOJu0YzSf5j5jxFTyfKH309cvir8a8k2AdVb6obClVLiACPl5fl7d7e+
 tCXGK4EzsW9FCm777YJrDDGztH1u1lYBYHcnq6A=
X-Google-Smtp-Source: AGHT+IEK+zu7m+mQrCo1f1fa9sp+qtGNfEeu45AVFkKgBXh7/l+g4rgUxcvZNNVpeBF3wos3Drco3A==
X-Received: by 2002:a17:902:f64e:b0:1c9:e765:e14a with SMTP id
 m14-20020a170902f64e00b001c9e765e14amr33096996plg.1.1699326262177; 
 Mon, 06 Nov 2023 19:04:22 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u9-20020a17090282c900b001c72d5e16acsm6518012plz.57.2023.11.06.19.04.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:04:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/85] target/hppa: Make HPPA_BTLB_ENTRIES variable
Date: Mon,  6 Nov 2023 19:03:00 -0800
Message-Id: <20231107030407.8979-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

Depend on hppa_is_pa20.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.h        | 19 +++++++++++--------
 hw/hppa/machine.c        |  9 +++------
 target/hppa/machine.c    |  3 ++-
 target/hppa/mem_helper.c | 40 ++++++++++++++++++++++------------------
 4 files changed, 38 insertions(+), 33 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 0ac307e0e9..48ddcffb8a 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -227,15 +227,13 @@ typedef struct CPUArchState {
     target_ureg cr_back[2];  /* back of cr17/cr18 */
     target_ureg shadow[7];   /* shadow registers */
 
-    /* ??? The number of entries isn't specified by the architecture.  */
-#ifdef TARGET_HPPA64
-#define HPPA_BTLB_FIXED         0       /* BTLBs are not supported in 64-bit machines */
-#else
-#define HPPA_BTLB_FIXED         16
-#endif
-#define HPPA_BTLB_VARIABLE      0
+    /*
+     * ??? The number of entries isn't specified by the architecture.
+     * BTLBs are not supported in 64-bit machines.
+     */
+#define PA10_BTLB_FIXED         16
+#define PA10_BTLB_VARIABLE      0
 #define HPPA_TLB_ENTRIES        256
-#define HPPA_BTLB_ENTRIES       (HPPA_BTLB_FIXED + HPPA_BTLB_VARIABLE)
 
     /* Index for round-robin tlb eviction. */
     uint32_t tlb_last;
@@ -277,6 +275,11 @@ static inline bool hppa_is_pa20(CPUHPPAState *env)
     return object_dynamic_cast(OBJECT(env_cpu(env)), TYPE_HPPA64_CPU) != NULL;
 }
 
+static inline int HPPA_BTLB_ENTRIES(CPUHPPAState *env)
+{
+    return hppa_is_pa20(env) ? 0 : PA10_BTLB_FIXED + PA10_BTLB_VARIABLE;
+}
+
 static inline int cpu_mmu_index(CPUHPPAState *env, bool ifetch)
 {
 #ifdef CONFIG_USER_ONLY
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 67d4d1b5e0..85682e6bab 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -185,6 +185,7 @@ static FWCfgState *create_fw_cfg(MachineState *ms, PCIBus *pci_bus)
     uint64_t val;
     const char qemu_version[] = QEMU_VERSION;
     MachineClass *mc = MACHINE_GET_CLASS(ms);
+    int btlb_entries = HPPA_BTLB_ENTRIES(&cpu[0]->env);
     int len;
 
     fw_cfg = fw_cfg_init_mem(FW_CFG_IO_BASE, FW_CFG_IO_BASE + 4);
@@ -196,11 +197,11 @@ static FWCfgState *create_fw_cfg(MachineState *ms, PCIBus *pci_bus)
     fw_cfg_add_file(fw_cfg, "/etc/firmware-min-version",
                     g_memdup(&val, sizeof(val)), sizeof(val));
 
-    val = cpu_to_le64(HPPA_TLB_ENTRIES - HPPA_BTLB_ENTRIES);
+    val = cpu_to_le64(HPPA_TLB_ENTRIES - btlb_entries);
     fw_cfg_add_file(fw_cfg, "/etc/cpu/tlb_entries",
                     g_memdup(&val, sizeof(val)), sizeof(val));
 
-    val = cpu_to_le64(HPPA_BTLB_ENTRIES);
+    val = cpu_to_le64(btlb_entries);
     fw_cfg_add_file(fw_cfg, "/etc/cpu/btlb_entries",
                     g_memdup(&val, sizeof(val)), sizeof(val));
 
@@ -608,10 +609,6 @@ static void hppa_machine_reset(MachineState *ms, ShutdownCause reason)
 
         cs->exception_index = -1;
         cs->halted = 0;
-
-        /* clear any existing TLB and BTLB entries */
-        memset(cpu[i]->env.tlb, 0, sizeof(cpu[i]->env.tlb));
-        cpu[i]->env.tlb_last = HPPA_BTLB_ENTRIES;
     }
 
     /* already initialized by machine_hppa_init()? */
diff --git a/target/hppa/machine.c b/target/hppa/machine.c
index 61ae942ff1..473305ffea 100644
--- a/target/hppa/machine.c
+++ b/target/hppa/machine.c
@@ -139,6 +139,7 @@ static int tlb_pre_load(void *opaque)
 static int tlb_post_load(void *opaque, int version_id)
 {
     CPUHPPAState *env = opaque;
+    uint32_t btlb_entries = HPPA_BTLB_ENTRIES(env);
     HPPATLBEntry **unused = &env->tlb_unused;
     HPPATLBEntry *partial = NULL;
 
@@ -152,7 +153,7 @@ static int tlb_post_load(void *opaque, int version_id)
 
         if (e->entry_valid) {
             interval_tree_insert(&e->itree, &env->tlb_root);
-        } else if (i < HPPA_BTLB_ENTRIES) {
+        } else if (i < btlb_entries) {
             /* btlb not in unused list */
         } else if (partial == NULL && e->itree.start < e->itree.last) {
             partial = e;
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index b1773ece61..327fb20c17 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -57,7 +57,7 @@ static void hppa_flush_tlb_ent(CPUHPPAState *env, HPPATLBEntry *ent,
                               HPPA_MMU_FLUSH_MASK, TARGET_LONG_BITS);
 
     /* Never clear BTLBs, unless forced to do so. */
-    is_btlb = ent < &env->tlb[HPPA_BTLB_ENTRIES];
+    is_btlb = ent < &env->tlb[HPPA_BTLB_ENTRIES(env)];
     if (is_btlb && !force_flush_btlb) {
         return;
     }
@@ -93,10 +93,11 @@ static HPPATLBEntry *hppa_alloc_tlb_ent(CPUHPPAState *env)
     HPPATLBEntry *ent = env->tlb_unused;
 
     if (ent == NULL) {
+        uint32_t btlb_entries = HPPA_BTLB_ENTRIES(env);
         uint32_t i = env->tlb_last;
 
-        if (i < HPPA_BTLB_ENTRIES || i >= ARRAY_SIZE(env->tlb)) {
-            i = HPPA_BTLB_ENTRIES;
+        if (i < btlb_entries || i >= ARRAY_SIZE(env->tlb)) {
+            i = btlb_entries;
         }
         env->tlb_last = i + 1;
 
@@ -385,23 +386,24 @@ void HELPER(ptlb)(CPUHPPAState *env, target_ulong addr)
 
 void hppa_ptlbe(CPUHPPAState *env)
 {
+    uint32_t btlb_entries = HPPA_BTLB_ENTRIES(env);
     uint32_t i;
 
     /* Zap the (non-btlb) tlb entries themselves. */
-    memset(&env->tlb[HPPA_BTLB_ENTRIES], 0,
-           sizeof(env->tlb) - HPPA_BTLB_ENTRIES * sizeof(env->tlb[0]));
-    env->tlb_last = HPPA_BTLB_ENTRIES;
+    memset(&env->tlb[btlb_entries], 0,
+           sizeof(env->tlb) - btlb_entries * sizeof(env->tlb[0]));
+    env->tlb_last = btlb_entries;
     env->tlb_partial = NULL;
 
     /* Put them all onto the unused list. */
-    env->tlb_unused = &env->tlb[HPPA_BTLB_ENTRIES];
-    for (i = HPPA_BTLB_ENTRIES; i < ARRAY_SIZE(env->tlb) - 1; ++i) {
+    env->tlb_unused = &env->tlb[btlb_entries];
+    for (i = btlb_entries; i < ARRAY_SIZE(env->tlb) - 1; ++i) {
         env->tlb[i].unused_next = &env->tlb[i + 1];
     }
 
     /* Re-initialize the interval tree with only the btlb entries. */
     memset(&env->tlb_root, 0, sizeof(env->tlb_root));
-    for (i = 0; i < HPPA_BTLB_ENTRIES; ++i) {
+    for (i = 0; i < btlb_entries; ++i) {
         if (env->tlb[i].entry_valid) {
             interval_tree_insert(&env->tlb[i].itree, &env->tlb_root);
         }
@@ -473,12 +475,14 @@ void HELPER(diag_btlb)(CPUHPPAState *env)
     HPPATLBEntry *btlb;
     uint64_t virt_page;
     uint32_t *vaddr;
+    uint32_t btlb_entries = HPPA_BTLB_ENTRIES(env);
 
-#ifdef TARGET_HPPA64
     /* BTLBs are not supported on 64-bit CPUs */
-    env->gr[28] = -1; /* nonexistent procedure */
-    return;
-#endif
+    if (btlb_entries == 0) {
+        env->gr[28] = -1; /* nonexistent procedure */
+        return;
+    }
+
     env->gr[28] = 0; /* PDC_OK */
 
     switch (env->gr[25]) {
@@ -492,8 +496,8 @@ void HELPER(diag_btlb)(CPUHPPAState *env)
         } else {
             vaddr[0] = cpu_to_be32(1);
             vaddr[1] = cpu_to_be32(16 * 1024);
-            vaddr[2] = cpu_to_be32(HPPA_BTLB_FIXED);
-            vaddr[3] = cpu_to_be32(HPPA_BTLB_VARIABLE);
+            vaddr[2] = cpu_to_be32(PA10_BTLB_FIXED);
+            vaddr[3] = cpu_to_be32(PA10_BTLB_VARIABLE);
         }
         break;
     case 1:
@@ -510,7 +514,7 @@ void HELPER(diag_btlb)(CPUHPPAState *env)
                     (long long) virt_page << TARGET_PAGE_BITS,
                     (long long) (virt_page + len) << TARGET_PAGE_BITS,
                     (long long) virt_page, phys_page, len, slot);
-        if (slot < HPPA_BTLB_ENTRIES) {
+        if (slot < btlb_entries) {
             btlb = &env->tlb[slot];
 
             /* Force flush of possibly existing BTLB entry. */
@@ -532,7 +536,7 @@ void HELPER(diag_btlb)(CPUHPPAState *env)
         slot = env->gr[22];
         qemu_log_mask(CPU_LOG_MMU, "PDC_BLOCK_TLB: PDC_BTLB_PURGE slot %d\n",
                                     slot);
-        if (slot < HPPA_BTLB_ENTRIES) {
+        if (slot < btlb_entries) {
             btlb = &env->tlb[slot];
             hppa_flush_tlb_ent(env, btlb, true);
         } else {
@@ -542,7 +546,7 @@ void HELPER(diag_btlb)(CPUHPPAState *env)
     case 3:
         /* Purge all BTLB entries */
         qemu_log_mask(CPU_LOG_MMU, "PDC_BLOCK_TLB: PDC_BTLB_PURGE_ALL\n");
-        for (slot = 0; slot < HPPA_BTLB_ENTRIES; slot++) {
+        for (slot = 0; slot < btlb_entries; slot++) {
             btlb = &env->tlb[slot];
             hppa_flush_tlb_ent(env, btlb, true);
         }
-- 
2.34.1


