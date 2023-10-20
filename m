Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AB77D179E
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 22:56:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtwLr-0007p5-VF; Fri, 20 Oct 2023 16:44:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLW-0007jS-MJ
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:43:54 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLT-0008AW-Dy
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:43:49 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6b5af4662b7so1157591b3a.3
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 13:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697834626; x=1698439426; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UGijUKxOjssioK5c9G9sCxgwEWxi/0wrwl9TMa9PkY0=;
 b=i2DlNLCQ5pbZ4c3vp3z81bYED6D+1uMs5Sfa0XqFMUfKPv0M0mdar+4/VQUCZESS8c
 rgJGIae5p6zvfsc/bNr2nqgTVk9TBy5BUNbJWJ/5Qn2NKrV5rK2Qz2sJv7YGE8sGKJDt
 IjFWhuCkmkJp4gvEHFPxeGXxMLJvhZfd8tRrOo8kZeAKcXe6GplRABkCi8vqJdrH/i+1
 BVl537irErTfSuKnNwTUPANgCmaEDPl1R76nqe6afp9ky4jlLTcSdrjmAGzoUgHvcpgg
 i+bAYo7QvR6W1VNLHHImk5S4QB7D+rhhQLXjWW3fsHMdyjagblIBoLJzGZyVnOa3vesJ
 3gOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697834626; x=1698439426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UGijUKxOjssioK5c9G9sCxgwEWxi/0wrwl9TMa9PkY0=;
 b=mEAlchh29DDhVOZMCq7VEzBqK807NgS+aPq0SyB1+xcGqjfcsyKhQFcDm4d2oqOfLj
 kDP04cqKFyj3AWBCpRrE+zf61fEFoSu1i3dq/Pxd9EwECx3afjV+hs723zs9tbyAtFke
 UMUUBk/heWg92CueknePF4demjG5ZJyym9lhRedlyt1j9fF8iGgPvwP0JLkDWVMpxPsv
 eM72c7hkG2W8GMSZOSUDxg53Eu7KjhgyxMFCqJAvNT3okkanT1lvAov+a2syPkm+mw6U
 B6uwCy8L7d+Rry0G8OEHdQQpfSQlV7PNk4L2dpQO9c/FtEiDeYanHS7iypVZzt+TMgSq
 VhFg==
X-Gm-Message-State: AOJu0YzJ5HQxzdItWTEqZll2Txh/t7zRRd3TI+l2hw5zVrDngdijEOGh
 YstsiFpSD2H4cmZtVYna9rZSCVhxiIQVj31diuo=
X-Google-Smtp-Source: AGHT+IGCkGCjsnpc91uQqcneYTjwC/wonMzBp04nYbQyMsTNgwiNRGFUlqvO74jrd9WcEpMCdvnH/w==
X-Received: by 2002:a05:6a21:4983:b0:172:83b8:67f7 with SMTP id
 ax3-20020a056a21498300b0017283b867f7mr2752274pzc.44.1697834626130; 
 Fri, 20 Oct 2023 13:43:46 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k15-20020aa7998f000000b00688965c5227sm1944975pfh.120.2023.10.20.13.43.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 13:43:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 14/65] target/hppa: Make HPPA_BTLB_ENTRIES variable
Date: Fri, 20 Oct 2023 13:42:40 -0700
Message-Id: <20231020204331.139847-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020204331.139847-1-richard.henderson@linaro.org>
References: <20231020204331.139847-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

Depend on hppa_is_pa20.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.h        | 19 +++++++++++--------
 hw/hppa/machine.c        |  9 +++------
 target/hppa/cpu.c        |  3 +++
 target/hppa/mem_helper.c | 40 ++++++++++++++++++++++------------------
 4 files changed, 39 insertions(+), 32 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 6995eb69ef..60fdd9e295 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -210,15 +210,13 @@ typedef struct CPUArchState {
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
 
     /* ??? Implement a unified itlb/dtlb for the moment.  */
     /* ??? We should use a more intelligent data structure.  */
@@ -248,6 +246,11 @@ static inline bool hppa_is_pa20(CPUHPPAState *env)
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
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 192aae268d..e1293857f5 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -139,6 +139,9 @@ static void hppa_cpu_realizefn(DeviceState *dev, Error **errp)
         HPPACPU *cpu = HPPA_CPU(cs);
         cpu->alarm_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
                                         hppa_cpu_alarm_timer, cpu);
+
+        memset(cpu->env.tlb, 0, sizeof(cpu->env.tlb));
+        cpu->env.tlb_last = HPPA_BTLB_ENTRIES(&cpu->env);
     }
 #endif
 }
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 350485f619..48cb5b0d76 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -57,7 +57,7 @@ static void hppa_flush_tlb_ent(CPUHPPAState *env, hppa_tlb_entry *ent,
                                 HPPA_MMU_FLUSH_MASK, TARGET_LONG_BITS);
 
     /* never clear BTLBs, unless forced to do so. */
-    if (ent < &env->tlb[HPPA_BTLB_ENTRIES] && !force_flush_btlb) {
+    if (ent < &env->tlb[HPPA_BTLB_ENTRIES(env)] && !force_flush_btlb) {
         return;
     }
 
@@ -68,11 +68,11 @@ static void hppa_flush_tlb_ent(CPUHPPAState *env, hppa_tlb_entry *ent,
 static hppa_tlb_entry *hppa_alloc_tlb_ent(CPUHPPAState *env)
 {
     hppa_tlb_entry *ent;
-    uint32_t i;
+    uint32_t i, btlb_entries = HPPA_BTLB_ENTRIES(env);
 
-    if (env->tlb_last < HPPA_BTLB_ENTRIES || env->tlb_last >= ARRAY_SIZE(env->tlb)) {
-        i = HPPA_BTLB_ENTRIES;
-        env->tlb_last = HPPA_BTLB_ENTRIES + 1;
+    if (env->tlb_last < btlb_entries || env->tlb_last >= ARRAY_SIZE(env->tlb)) {
+        i = btlb_entries;
+        env->tlb_last = btlb_entries + 1;
     } else {
         i = env->tlb_last;
         env->tlb_last++;
@@ -279,7 +279,7 @@ void HELPER(itlba)(CPUHPPAState *env, target_ulong addr, target_ureg reg)
     int i;
 
     /* Zap any old entries covering ADDR; notice empty entries on the way.  */
-    for (i = HPPA_BTLB_ENTRIES; i < ARRAY_SIZE(env->tlb); ++i) {
+    for (i = HPPA_BTLB_ENTRIES(env); i < ARRAY_SIZE(env->tlb); ++i) {
         hppa_tlb_entry *ent = &env->tlb[i];
         if (ent->va_b <= addr && addr <= ent->va_e) {
             if (ent->entry_valid) {
@@ -363,11 +363,13 @@ void HELPER(ptlb)(CPUHPPAState *env, target_ulong addr)
    number of pages/entries (we choose all), and is local to the cpu.  */
 void HELPER(ptlbe)(CPUHPPAState *env)
 {
+    uint32_t btlb_entries = HPPA_BTLB_ENTRIES(env);
+
     trace_hppa_tlb_ptlbe(env);
     qemu_log_mask(CPU_LOG_MMU, "FLUSH ALL TLB ENTRIES\n");
-    memset(&env->tlb[HPPA_BTLB_ENTRIES], 0,
-        sizeof(env->tlb) - HPPA_BTLB_ENTRIES * sizeof(env->tlb[0]));
-    env->tlb_last = HPPA_BTLB_ENTRIES;
+    memset(&env->tlb[btlb_entries], 0,
+           sizeof(env->tlb) - btlb_entries * sizeof(env->tlb[0]));
+    env->tlb_last = btlb_entries;
     tlb_flush_by_mmuidx(env_cpu(env), HPPA_MMU_FLUSH_MASK);
 }
 
@@ -427,12 +429,14 @@ void HELPER(diag_btlb)(CPUHPPAState *env)
     hppa_tlb_entry *btlb;
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
@@ -446,8 +450,8 @@ void HELPER(diag_btlb)(CPUHPPAState *env)
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
@@ -464,7 +468,7 @@ void HELPER(diag_btlb)(CPUHPPAState *env)
                     (long long) virt_page << TARGET_PAGE_BITS,
                     (long long) (virt_page + len) << TARGET_PAGE_BITS,
                     (long long) virt_page, phys_page, len, slot);
-        if (slot < HPPA_BTLB_ENTRIES) {
+        if (slot < btlb_entries) {
             btlb = &env->tlb[slot];
             /* force flush of possibly existing BTLB entry */
             hppa_flush_tlb_ent(env, btlb, true);
@@ -484,7 +488,7 @@ void HELPER(diag_btlb)(CPUHPPAState *env)
         slot = env->gr[22];
         qemu_log_mask(CPU_LOG_MMU, "PDC_BLOCK_TLB: PDC_BTLB_PURGE slot %d\n",
                                     slot);
-        if (slot < HPPA_BTLB_ENTRIES) {
+        if (slot < btlb_entries) {
             btlb = &env->tlb[slot];
             hppa_flush_tlb_ent(env, btlb, true);
         } else {
@@ -494,7 +498,7 @@ void HELPER(diag_btlb)(CPUHPPAState *env)
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


