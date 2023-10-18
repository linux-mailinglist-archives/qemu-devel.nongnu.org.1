Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B197CEA63
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 23:58:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtESX-000196-Pz; Wed, 18 Oct 2023 17:52:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtESF-00016t-54
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:51:51 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtESC-0004Oq-Lp
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:51:50 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-57be3d8e738so4124982eaf.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 14:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697665907; x=1698270707; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4w9TuqB+Wh/IgMQszmtMNOuKxNZ/aMG7k6ZFrv3n6zg=;
 b=f1fPYWVYztKEg0hCwjFVvX5Yspy4GcWq+q+jPstbdfPN0Povgw1etSBhXj6F3xm9W0
 /zMysTA2j8BRh9WMsxIX/U95/48nBRUY6zgC5FCuK3Fys8wUlj4zN/+6RIwid9etY3+z
 yVfm53FiDRnaOF+Eia1Y2n0VIe9r3YEZhqH7eGqACGyPinJVPC6MvcV0VCCgvFaYMhEf
 Xkuhuv2WPz9SJ+ELUtFDCDD7/CRGApyK7TWEJsNpf/1SglCphG7UUV7Z9MHKwjYW7art
 rGRE7TYhmFEGKFXajHWnHuonsKFovBcQfCYxJ6rXpTmKP0R/KIXqwMF2U5aNdQF4N4gO
 6DGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697665907; x=1698270707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4w9TuqB+Wh/IgMQszmtMNOuKxNZ/aMG7k6ZFrv3n6zg=;
 b=bZ+545h6MMvk+5/adbfPGJ8jBPVsJuYSP1rxKcZmCuOnKc45OxTde6Xb9gr2J0aiaM
 ySm2TFILTxZjKcrgUkK9I/AiTuje7fS7F+XTDN/oqns2FI4VdHRxoatoKLg9grOIKJ/3
 LQRKmyJ6kOJS3k06ZOdCaCkqgRy3xkQBTxPs0K/ZsH5ErWju4rlYBfwLMxw+W/HBDFwg
 VeJEr3pwhsSYcCtzFCtHyx1taETzGWu3vxxL71bnbfiooRtePUYKB40tTHZqNRgVnle4
 5Ren2zEW7q5rHsQcF5TmIvRJ0TDSjEpaDZano0ukOf5UGb/UNhmaxaZbaP4Sk9zC1Szb
 Kw/g==
X-Gm-Message-State: AOJu0YyCTGQwggZvYtmBoOqUL67CIx9kFbyXkmuFGZsjybeBMIVFQAuy
 7lWj4DM3rNyvpGVF9EC8jdko22obAHx7QjpFg5o=
X-Google-Smtp-Source: AGHT+IG6etGpjL+sjmEnIMrCxBC4n0MaKCbL5hTWGjxuhouHDEXC1TYejWAe1HvSV7PxPH2edZBmwg==
X-Received: by 2002:a05:6358:c683:b0:141:8c:75ad with SMTP id
 fe3-20020a056358c68300b00141008c75admr262733rwb.28.1697665907467; 
 Wed, 18 Oct 2023 14:51:47 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 w17-20020a63f511000000b005b61a024ec7sm2176380pgh.74.2023.10.18.14.51.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 14:51:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 13/61] target/hppa: Make HPPA_BTLB_ENTRIES variable
Date: Wed, 18 Oct 2023 14:50:47 -0700
Message-Id: <20231018215135.1561375-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018215135.1561375-1-richard.henderson@linaro.org>
References: <20231018215135.1561375-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2e.google.com
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

Depend on !HPPACPU.is_pa20.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.h        | 16 ++++++++--------
 hw/hppa/machine.c        |  6 +-----
 target/hppa/cpu.c        |  3 +++
 target/hppa/mem_helper.c | 41 ++++++++++++++++++++++------------------
 4 files changed, 35 insertions(+), 31 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 743fc90e14..22690e351d 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -210,15 +210,15 @@ typedef struct CPUArchState {
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
+#define HPPA_BTLB_ENTRIES(E)    (env_archcpu(E)->is_pa20 ? 0 \
+                                 : PA10_BTLB_FIXED + PA10_BTLB_VARIABLE)
 #define HPPA_TLB_ENTRIES        256
-#define HPPA_BTLB_ENTRIES       (HPPA_BTLB_FIXED + HPPA_BTLB_VARIABLE)
 
     /* ??? Implement a unified itlb/dtlb for the moment.  */
     /* ??? We should use a more intelligent data structure.  */
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index cf28cb9586..07f8ebeb6a 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -133,7 +133,7 @@ static FWCfgState *create_fw_cfg(MachineState *ms)
     fw_cfg_add_file(fw_cfg, "/etc/firmware-min-version",
                     g_memdup(&val, sizeof(val)), sizeof(val));
 
-    val = cpu_to_le64(HPPA_TLB_ENTRIES - HPPA_BTLB_ENTRIES);
+    val = cpu_to_le64(HPPA_TLB_ENTRIES - HPPA_BTLB_ENTRIES(&cpu[0]->env));
     fw_cfg_add_file(fw_cfg, "/etc/cpu/tlb_entries",
                     g_memdup(&val, sizeof(val)), sizeof(val));
 
@@ -429,10 +429,6 @@ static void hppa_machine_reset(MachineState *ms, ShutdownCause reason)
 
         cs->exception_index = -1;
         cs->halted = 0;
-
-        /* clear any existing TLB and BTLB entries */
-        memset(cpu[i]->env.tlb, 0, sizeof(cpu[i]->env.tlb));
-        cpu[i]->env.tlb_last = HPPA_BTLB_ENTRIES;
     }
 
     /* already initialized by machine_hppa_init()? */
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index ed5b6afd10..41abdb04d0 100644
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
index 350485f619..b2a75f6408 100644
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
 
@@ -427,13 +429,16 @@ void HELPER(diag_btlb)(CPUHPPAState *env)
     hppa_tlb_entry *btlb;
     uint64_t virt_page;
     uint32_t *vaddr;
+    uint32_t btlb_entries;
 
-#ifdef TARGET_HPPA64
     /* BTLBs are not supported on 64-bit CPUs */
-    env->gr[28] = -1; /* nonexistent procedure */
-    return;
-#endif
+    if (env_archcpu(env)->is_pa20) {
+        env->gr[28] = -1; /* nonexistent procedure */
+        return;
+    }
+
     env->gr[28] = 0; /* PDC_OK */
+    btlb_entries = HPPA_BTLB_ENTRIES(env);
 
     switch (env->gr[25]) {
     case 0:
@@ -446,8 +451,8 @@ void HELPER(diag_btlb)(CPUHPPAState *env)
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
@@ -464,7 +469,7 @@ void HELPER(diag_btlb)(CPUHPPAState *env)
                     (long long) virt_page << TARGET_PAGE_BITS,
                     (long long) (virt_page + len) << TARGET_PAGE_BITS,
                     (long long) virt_page, phys_page, len, slot);
-        if (slot < HPPA_BTLB_ENTRIES) {
+        if (slot < btlb_entries) {
             btlb = &env->tlb[slot];
             /* force flush of possibly existing BTLB entry */
             hppa_flush_tlb_ent(env, btlb, true);
@@ -484,7 +489,7 @@ void HELPER(diag_btlb)(CPUHPPAState *env)
         slot = env->gr[22];
         qemu_log_mask(CPU_LOG_MMU, "PDC_BLOCK_TLB: PDC_BTLB_PURGE slot %d\n",
                                     slot);
-        if (slot < HPPA_BTLB_ENTRIES) {
+        if (slot < btlb_entries) {
             btlb = &env->tlb[slot];
             hppa_flush_tlb_ent(env, btlb, true);
         } else {
@@ -494,7 +499,7 @@ void HELPER(diag_btlb)(CPUHPPAState *env)
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


