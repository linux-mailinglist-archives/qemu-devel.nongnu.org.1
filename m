Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5FA832FF9
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 21:47:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQvl9-0006W6-JB; Fri, 19 Jan 2024 15:46:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1rQvl1-0006TQ-UQ
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 15:46:31 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1rQvkx-0001kn-Ss
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 15:46:31 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6d9a79a1ad4so1088438b3a.2
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 12:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705697186; x=1706301986; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VggEMRQ7OJ5+pdMKaWAUCmt82lLv964s7yWUKSDIYdI=;
 b=bV0xSIj5QHSabVFT8x8ZIE9RB34guN8ab4RfXCSZ4tNlT0/9pNsGYSnndvMV+w5FNK
 MUpZKdpSnd2pgmzZ6mMCQhokIvR8om510tvftmsBY9t84t+beJvwha/nkrPn0/oAq9vt
 LSh0CcRaerbZp/y/1nRX17cwdFOEit1p1ikRj2kpABzTUr3h0TlwGAhvgPa7o0a6buMQ
 x0t/fRm+XrqvbdmeMvqOGMplhkCavM7Pwaqr4kyDSQbCV8XZ/T37qaKjSuEiRPkaLtbb
 dmZwLoINlttFzKyvN/pvGPDefY6IahHtkKpCfNrFI4R3QHjtCtdqmFBmRanQ+/QgVXVH
 YIzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705697186; x=1706301986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VggEMRQ7OJ5+pdMKaWAUCmt82lLv964s7yWUKSDIYdI=;
 b=iuNbw9m5lrblO9Y/Zg56UA5ScVazqITRY2UnVxbH5xXzH1jdAF+yi5QAVgt4sEvtpJ
 y/JEgbBJPoc4DlcLLAH7gN4TrDi/SOOeKeKr0MtW97qkxd443/ulsXu2FvYS4JRkHWKH
 MTKfO+2pYKraBcvgSFlh942L+FG+tugImot6rXVbTtWPEYiSQODH1pAxLRLVHTMnsMDA
 hhzHAumRBtjp3Ya4FHFefdTuwJc7s0mi3i9dXTAZIsopU+SBN+fxv9O4vsOZzM+L7Ygg
 +ee+rZeAqo2tM8Noll3hATNv0m9tzd9f7H/PQj/KsVX4G4UH6PGvtO0WD3/3umgr/X73
 73yA==
X-Gm-Message-State: AOJu0YzlFH/dBBMmFRzrS+XbYXBX8eYnj7gL+U+9dOpkiQC8o4xNI25E
 unmXMby/w+lp0akLBScQSLzp21hYRlIwuBD4uATSLUa7tMYes88NqyiHgi6R
X-Google-Smtp-Source: AGHT+IEN/eJNtyHnH2raJN7D03ji1hUFuR1m3K9KcqJFXnq1w6mqeI52Yo4jBUDbAyHpTek+oBptvg==
X-Received: by 2002:a05:6a00:ad1:b0:6da:e711:7836 with SMTP id
 c17-20020a056a000ad100b006dae7117836mr569262pfl.54.1705697185671; 
 Fri, 19 Jan 2024 12:46:25 -0800 (PST)
Received: from octofox.hsd1.ca.comcast.net
 (c-73-63-239-93.hsd1.ca.comcast.net. [73.63.239.93])
 by smtp.gmail.com with ESMTPSA id
 kq9-20020a056a004b0900b006db85b12036sm5535228pfb.137.2024.01.19.12.46.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 12:46:25 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 1/2] target/xtensa: wrap MMU and MPU state into structures
Date: Fri, 19 Jan 2024 12:46:07 -0800
Message-Id: <20240119204608.779541-2-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240119204608.779541-1-jcmvbkbc@gmail.com>
References: <20240119204608.779541-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.998, HK_RANDOM_FROM=0.998,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Make separation of alternative xtensa memory management options state
explicit.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/cpu.h        | 18 +++++++++++++----
 target/xtensa/mmu_helper.c | 40 +++++++++++++++++++-------------------
 2 files changed, 34 insertions(+), 24 deletions(-)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 8a423706d8c0..497325466397 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -326,11 +326,21 @@ typedef struct xtensa_tlb {
     unsigned nrefillentries;
 } xtensa_tlb;
 
+typedef struct XtensaMMU {
+    xtensa_tlb_entry itlb[7][MAX_TLB_WAY_SIZE];
+    xtensa_tlb_entry dtlb[10][MAX_TLB_WAY_SIZE];
+    unsigned autorefill_idx;
+} XtensaMMU;
+
 typedef struct xtensa_mpu_entry {
     uint32_t vaddr;
     uint32_t attr;
 } xtensa_mpu_entry;
 
+typedef struct XtensaMPU {
+    xtensa_mpu_entry fg[MAX_MPU_FOREGROUND_SEGMENTS];
+} XtensaMPU;
+
 typedef struct XtensaGdbReg {
     int targno;
     unsigned flags;
@@ -526,10 +536,10 @@ struct CPUArchState {
     uint32_t exclusive_val;
 
 #ifndef CONFIG_USER_ONLY
-    xtensa_tlb_entry itlb[7][MAX_TLB_WAY_SIZE];
-    xtensa_tlb_entry dtlb[10][MAX_TLB_WAY_SIZE];
-    xtensa_mpu_entry mpu_fg[MAX_MPU_FOREGROUND_SEGMENTS];
-    unsigned autorefill_idx;
+    union {
+        XtensaMMU mmu;
+        XtensaMPU mpu;
+    };
     bool runstall;
     AddressSpace *address_space_er;
     MemoryRegion *system_er;
diff --git a/target/xtensa/mmu_helper.c b/target/xtensa/mmu_helper.c
index 2fda4e887cce..d9f845e7fb6f 100644
--- a/target/xtensa/mmu_helper.c
+++ b/target/xtensa/mmu_helper.c
@@ -250,8 +250,8 @@ static xtensa_tlb_entry *xtensa_tlb_get_entry(CPUXtensaState *env, bool dtlb,
 
     assert(wi < tlb->nways && ei < tlb->way_size[wi]);
     return dtlb ?
-        env->dtlb[wi] + ei :
-        env->itlb[wi] + ei;
+        env->mmu.dtlb[wi] + ei :
+        env->mmu.itlb[wi] + ei;
 }
 
 static xtensa_tlb_entry *get_tlb_entry(CPUXtensaState *env,
@@ -411,11 +411,11 @@ void reset_mmu(CPUXtensaState *env)
         env->sregs[RASID] = 0x04030201;
         env->sregs[ITLBCFG] = 0;
         env->sregs[DTLBCFG] = 0;
-        env->autorefill_idx = 0;
-        reset_tlb_mmu_all_ways(env, &env->config->itlb, env->itlb);
-        reset_tlb_mmu_all_ways(env, &env->config->dtlb, env->dtlb);
-        reset_tlb_mmu_ways56(env, &env->config->itlb, env->itlb);
-        reset_tlb_mmu_ways56(env, &env->config->dtlb, env->dtlb);
+        env->mmu.autorefill_idx = 0;
+        reset_tlb_mmu_all_ways(env, &env->config->itlb, env->mmu.itlb);
+        reset_tlb_mmu_all_ways(env, &env->config->dtlb, env->mmu.dtlb);
+        reset_tlb_mmu_ways56(env, &env->config->itlb, env->mmu.itlb);
+        reset_tlb_mmu_ways56(env, &env->config->dtlb, env->mmu.dtlb);
     } else if (xtensa_option_enabled(env->config, XTENSA_OPTION_MPU)) {
         unsigned i;
 
@@ -430,8 +430,8 @@ void reset_mmu(CPUXtensaState *env)
         }
     } else {
         env->sregs[CACHEATTR] = 0x22222222;
-        reset_tlb_region_way0(env, env->itlb);
-        reset_tlb_region_way0(env, env->dtlb);
+        reset_tlb_region_way0(env, env->mmu.itlb);
+        reset_tlb_region_way0(env, env->mmu.dtlb);
     }
 }
 
@@ -462,7 +462,7 @@ static int xtensa_tlb_lookup(const CPUXtensaState *env,
     const xtensa_tlb *tlb = dtlb ?
         &env->config->dtlb : &env->config->itlb;
     const xtensa_tlb_entry (*entry)[MAX_TLB_WAY_SIZE] = dtlb ?
-        env->dtlb : env->itlb;
+        env->mmu.dtlb : env->mmu.itlb;
 
     int nhits = 0;
     unsigned wi;
@@ -821,7 +821,7 @@ static int get_physical_addr_mmu(CPUXtensaState *env, bool update_tlb,
         split_tlb_entry_spec_way(env, vaddr, dtlb, &vpn, wi, &ei);
 
         if (update_tlb) {
-            wi = ++env->autorefill_idx & 0x3;
+            wi = ++env->mmu.autorefill_idx & 0x3;
             xtensa_tlb_set_entry(env, dtlb, wi, ei, vpn, pte);
             env->sregs[EXCVADDR] = vaddr;
             qemu_log_mask(CPU_LOG_MMU, "%s: autorefill(%08x): %08x -> %08x\n",
@@ -957,8 +957,8 @@ void HELPER(wptlb)(CPUXtensaState *env, uint32_t p, uint32_t v)
     unsigned segment = p & XTENSA_MPU_SEGMENT_MASK;
 
     if (segment < env->config->n_mpu_fg_segments) {
-        env->mpu_fg[segment].vaddr = v & -env->config->mpu_align;
-        env->mpu_fg[segment].attr = p & XTENSA_MPU_ATTR_MASK;
+        env->mpu.fg[segment].vaddr = v & -env->config->mpu_align;
+        env->mpu.fg[segment].attr = p & XTENSA_MPU_ATTR_MASK;
         env->sregs[MPUENB] = deposit32(env->sregs[MPUENB], segment, 1, v);
         tlb_flush(env_cpu(env));
     }
@@ -969,7 +969,7 @@ uint32_t HELPER(rptlb0)(CPUXtensaState *env, uint32_t s)
     unsigned segment = s & XTENSA_MPU_SEGMENT_MASK;
 
     if (segment < env->config->n_mpu_fg_segments) {
-        return env->mpu_fg[segment].vaddr |
+        return env->mpu.fg[segment].vaddr |
             extract32(env->sregs[MPUENB], segment, 1);
     } else {
         return 0;
@@ -981,7 +981,7 @@ uint32_t HELPER(rptlb1)(CPUXtensaState *env, uint32_t s)
     unsigned segment = s & XTENSA_MPU_SEGMENT_MASK;
 
     if (segment < env->config->n_mpu_fg_segments) {
-        return env->mpu_fg[segment].attr;
+        return env->mpu.fg[segment].attr;
     } else {
         return 0;
     }
@@ -993,13 +993,13 @@ uint32_t HELPER(pptlb)(CPUXtensaState *env, uint32_t v)
     unsigned segment = XTENSA_MPU_PROBE_B;
     unsigned bg_segment;
 
-    nhits = xtensa_mpu_lookup(env->mpu_fg, env->config->n_mpu_fg_segments,
+    nhits = xtensa_mpu_lookup(env->mpu.fg, env->config->n_mpu_fg_segments,
                               v, &segment);
     if (nhits > 1) {
         HELPER(exception_cause_vaddr)(env, env->pc,
                                       LOAD_STORE_TLB_MULTI_HIT_CAUSE, v);
     } else if (nhits == 1 && (env->sregs[MPUENB] & (1u << segment))) {
-        return env->mpu_fg[segment].attr | segment | XTENSA_MPU_PROBE_V;
+        return env->mpu.fg[segment].attr | segment | XTENSA_MPU_PROBE_V;
     } else {
         xtensa_mpu_lookup(env->config->mpu_bg,
                           env->config->n_mpu_bg_segments,
@@ -1017,14 +1017,14 @@ static int get_physical_addr_mpu(CPUXtensaState *env,
     unsigned segment;
     uint32_t attr;
 
-    nhits = xtensa_mpu_lookup(env->mpu_fg, env->config->n_mpu_fg_segments,
+    nhits = xtensa_mpu_lookup(env->mpu.fg, env->config->n_mpu_fg_segments,
                               vaddr, &segment);
     if (nhits > 1) {
         return is_write < 2 ?
             LOAD_STORE_TLB_MULTI_HIT_CAUSE :
             INST_TLB_MULTI_HIT_CAUSE;
     } else if (nhits == 1 && (env->sregs[MPUENB] & (1u << segment))) {
-        attr = env->mpu_fg[segment].attr;
+        attr = env->mpu.fg[segment].attr;
     } else {
         xtensa_mpu_lookup(env->config->mpu_bg,
                           env->config->n_mpu_bg_segments,
@@ -1205,7 +1205,7 @@ void dump_mmu(CPUXtensaState *env)
         dump_tlb(env, true);
     } else if (xtensa_option_enabled(env->config, XTENSA_OPTION_MPU)) {
         qemu_printf("Foreground map:\n");
-        dump_mpu(env, env->mpu_fg, env->config->n_mpu_fg_segments);
+        dump_mpu(env, env->mpu.fg, env->config->n_mpu_fg_segments);
         qemu_printf("\nBackground map:\n");
         dump_mpu(NULL, env->config->mpu_bg, env->config->n_mpu_bg_segments);
     } else {
-- 
2.39.2


