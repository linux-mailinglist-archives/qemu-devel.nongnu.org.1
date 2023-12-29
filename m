Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3DF81FC41
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 01:48:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJ12R-0003SJ-UT; Thu, 28 Dec 2023 19:47:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1rJ12P-0003SA-4h
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 19:47:45 -0500
Received: from mail-io1-xd36.google.com ([2607:f8b0:4864:20::d36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1rJ12M-00030S-5H
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 19:47:44 -0500
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-7ba737ee9b5so465179339f.0
 for <qemu-devel@nongnu.org>; Thu, 28 Dec 2023 16:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1703810860; x=1704415660;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9GBvTeUzoQUlng6UwMoBMsETSZDpZRfh33b6/yNi3L0=;
 b=eYA2bD9z6wIPBeu24Fl5lHnqaG+qcIDTRQV+FuObaExkEHWN+Gc2EpSBLzcBU8GbbU
 5bj1jjQkJNAJbLF44k8tn/5VQvkZhK+QvLjbR7QHJuO1wZGoD/xr+UDv17Fnhq+35x5n
 64TFBvO0ooJERbqL3eTiDz59hv0r61scu0227iOtVPDsCoo8/HnmfxpxC5igk36EmZLU
 VfDCGdKyIEfCyRApyynK8PoRhq3Tp1hrfm+uJgkI9ThPgEUIWaDs8wLedtXfx+740a3q
 kH1MfBdeWVXb/zODQm04htKQWCsBULPM22FXgJCVRMkv939WREGhPLL9B1RZUiRHIkF6
 vJiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703810860; x=1704415660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9GBvTeUzoQUlng6UwMoBMsETSZDpZRfh33b6/yNi3L0=;
 b=Vm+OSE4n6Xfih45Q4ChMyufKB13TkZhZU4z6YLqgkxolGnMkH9qaHNPBqEE/bOF+Oo
 XS9S5Ct9w9UFyxzfSPS3UAvnMkGwiEq5zwmXD1TTmtMwysKYzgBd5EVKiUY4icshQtSI
 3Z2xsxsS8loqH7OKoHTkTv7qNdJcuKVN1BICy11lTBwUbU2uKXgvcKBGQwxhaxmyu9IY
 gQs9EjW8xjwZT+OC1bfQk5C2I42zCJbl3HOrJZI8kvdcsaZqleft8quVCH8ty4PQgEmm
 B8R88EKMCy8wCqAgVV3OLj/4dsfA0RDjoIulWz4sCeWnEM50kufT7kSJUU54J97iv1J0
 hjdA==
X-Gm-Message-State: AOJu0YzEZfE1Qhz3uTveOp0XIlx+SuQGpz1Q4oc1sKmYUx8JPCjBUKZy
 k/VurspMdr0dWbhjbVSv1TqruFGqf8/2TD6sqfdJMVutwVY=
X-Google-Smtp-Source: AGHT+IGq/f3tK4ofMtMxepDnr/zCp0bEs6792hpoQXq60cUwUM3ITiNr26HK3KZ6AKQ6eoojEVtK0A==
X-Received: by 2002:a05:6e02:1805:b0:35f:d1aa:f41c with SMTP id
 a5-20020a056e02180500b0035fd1aaf41cmr19660584ilv.10.1703810860025; 
 Thu, 28 Dec 2023 16:47:40 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 z3-20020a170902ee0300b001d3561680aasm14393949plb.82.2023.12.28.16.47.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Dec 2023 16:47:39 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
To: qemu-devel@nongnu.org
Subject: [v2 5/5] target/riscv: Implement privilege mode filtering for
 cycle/instret
Date: Thu, 28 Dec 2023 16:47:31 -0800
Message-Id: <20231229004731.3841550-6-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231229004731.3841550-1-atishp@rivosinc.com>
References: <20231229004731.3841550-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d36;
 envelope-from=atishp@rivosinc.com; helo=mail-io1-xd36.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Privilege mode filtering can also be emulated for cycle/instret by
tracking host_ticks/icount during each privilege mode switch. This
patch implements that for both cycle/instret and mhpmcounters. The
first one requires Smcntrpmf while the other one requires Sscofpmf
to be enabled.

The cycle/instret are still computed using host ticks when icount
is not enabled. Otherwise, they are computed using raw icount which
is more accurate in icount mode.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 target/riscv/cpu.h        | 11 +++++
 target/riscv/cpu_helper.c |  9 +++-
 target/riscv/csr.c        | 95 ++++++++++++++++++++++++++++++---------
 target/riscv/pmu.c        | 43 ++++++++++++++++++
 target/riscv/pmu.h        |  2 +
 5 files changed, 136 insertions(+), 24 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 34617c4c4bab..40d10726155b 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -136,6 +136,15 @@ typedef struct PMUCTRState {
     target_ulong irq_overflow_left;
 } PMUCTRState;
 
+typedef struct PMUFixedCtrState {
+        /* Track cycle and icount for each privilege mode */
+        uint64_t counter[4];
+        uint64_t counter_prev[4];
+        /* Track cycle and icount for each privilege mode when V = 1*/
+        uint64_t counter_virt[2];
+        uint64_t counter_virt_prev[2];
+} PMUFixedCtrState;
+
 struct CPUArchState {
     target_ulong gpr[32];
     target_ulong gprh[32]; /* 64 top bits of the 128-bit registers */
@@ -334,6 +343,8 @@ struct CPUArchState {
     /* PMU event selector configured values for RV32 */
     target_ulong mhpmeventh_val[RV_MAX_MHPMEVENTS];
 
+    PMUFixedCtrState pmu_fixed_ctrs[2];
+
     target_ulong sscratch;
     target_ulong mscratch;
 
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index e7e23b34f455..3dddb1b433e8 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -715,8 +715,13 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv)
 {
     g_assert(newpriv <= PRV_M && newpriv != PRV_RESERVED);
 
-    if (icount_enabled() && newpriv != env->priv) {
-        riscv_itrigger_update_priv(env);
+    if (newpriv != env->priv) {
+        if (icount_enabled()) {
+            riscv_itrigger_update_priv(env);
+            riscv_pmu_icount_update_priv(env, newpriv);
+        } else {
+            riscv_pmu_cycle_update_priv(env, newpriv);
+        }
     }
     /* tlb_flush is unnecessary as mode is contained in mmu_idx */
     env->priv = newpriv;
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 618e801a7612..9926968e8e7d 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -785,32 +785,16 @@ static int write_vcsr(CPURISCVState *env, int csrno, target_ulong val)
     return RISCV_EXCP_NONE;
 }
 
+#if defined(CONFIG_USER_ONLY)
 /* User Timers and Counters */
 static target_ulong get_ticks(bool shift)
 {
-    int64_t val;
-    target_ulong result;
-
-#if !defined(CONFIG_USER_ONLY)
-    if (icount_enabled()) {
-        val = icount_get();
-    } else {
-        val = cpu_get_host_ticks();
-    }
-#else
-    val = cpu_get_host_ticks();
-#endif
-
-    if (shift) {
-        result = val >> 32;
-    } else {
-        result = val;
-    }
+    int64_t val = cpu_get_host_ticks();
+    target_ulong result = shift ? val >> 32 : val;
 
     return result;
 }
 
-#if defined(CONFIG_USER_ONLY)
 static RISCVException read_time(CPURISCVState *env, int csrno,
                                 target_ulong *val)
 {
@@ -935,6 +919,70 @@ static int write_mhpmeventh(CPURISCVState *env, int csrno, target_ulong val)
     return RISCV_EXCP_NONE;
 }
 
+static target_ulong riscv_pmu_ctr_get_fixed_counters_val(CPURISCVState *env,
+                                                         int counter_idx,
+                                                         bool upper_half)
+{
+    uint64_t curr_val = 0;
+    target_ulong result = 0;
+    uint64_t *counter_arr = icount_enabled() ? env->pmu_fixed_ctrs[1].counter :
+                            env->pmu_fixed_ctrs[0].counter;
+    uint64_t *counter_arr_virt = icount_enabled() ?
+                                 env->pmu_fixed_ctrs[1].counter_virt :
+                                 env->pmu_fixed_ctrs[0].counter_virt;
+    uint64_t cfg_val = 0;
+
+    if (counter_idx == 0) {
+        cfg_val = upper_half ? ((uint64_t)env->mcyclecfgh << 32) :
+                  env->mcyclecfg;
+    } else if (counter_idx == 2) {
+        cfg_val = upper_half ? ((uint64_t)env->minstretcfgh << 32) :
+                  env->minstretcfg;
+    } else {
+        cfg_val = upper_half ?
+                  ((uint64_t)env->mhpmeventh_val[counter_idx] << 32) :
+                  env->mhpmevent_val[counter_idx];
+    }
+
+    if (!cfg_val) {
+        if (icount_enabled()) {
+            curr_val = icount_get_raw();
+        } else {
+            curr_val = cpu_get_host_ticks();
+        }
+        goto done;
+    }
+
+    if (!(cfg_val & MCYCLECFG_BIT_MINH)) {
+        curr_val += counter_arr[PRV_M];
+    }
+
+    if (!(cfg_val & MCYCLECFG_BIT_SINH)) {
+        curr_val += counter_arr[PRV_S];
+    }
+
+    if (!(cfg_val & MCYCLECFG_BIT_UINH)) {
+        curr_val += counter_arr[PRV_U];
+    }
+
+    if (!(cfg_val & MCYCLECFG_BIT_VSINH)) {
+        curr_val += counter_arr_virt[PRV_S];
+    }
+
+    if (!(cfg_val & MCYCLECFG_BIT_VUINH)) {
+        curr_val += counter_arr_virt[PRV_U];
+    }
+
+done:
+    if (riscv_cpu_mxl(env) == MXL_RV32) {
+        result = upper_half ? curr_val >> 32 : curr_val;
+    } else {
+        result = curr_val;
+    }
+
+    return result;
+}
+
 static int write_mhpmcounter(CPURISCVState *env, int csrno, target_ulong val)
 {
     int ctr_idx = csrno - CSR_MCYCLE;
@@ -944,7 +992,8 @@ static int write_mhpmcounter(CPURISCVState *env, int csrno, target_ulong val)
     counter->mhpmcounter_val = val;
     if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
         riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
-        counter->mhpmcounter_prev = get_ticks(false);
+        counter->mhpmcounter_prev = riscv_pmu_ctr_get_fixed_counters_val(env,
+                                                                ctr_idx, false);
         if (ctr_idx > 2) {
             if (riscv_cpu_mxl(env) == MXL_RV32) {
                 mhpmctr_val = mhpmctr_val |
@@ -971,7 +1020,8 @@ static int write_mhpmcounterh(CPURISCVState *env, int csrno, target_ulong val)
     mhpmctr_val = mhpmctr_val | (mhpmctrh_val << 32);
     if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
         riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
-        counter->mhpmcounterh_prev = get_ticks(true);
+        counter->mhpmcounterh_prev = riscv_pmu_ctr_get_fixed_counters_val(env,
+                                                                 ctr_idx, true);
         if (ctr_idx > 2) {
             riscv_pmu_setup_timer(env, mhpmctr_val, ctr_idx);
         }
@@ -1012,7 +1062,8 @@ static RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
      */
     if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
         riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
-        *val = get_ticks(upper_half) - ctr_prev + ctr_val;
+        *val = riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx, upper_half) -
+                                                    ctr_prev + ctr_val;
     } else {
         *val = ctr_val;
     }
diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
index 0e7d58b8a5c2..8b6cc4c6bb4d 100644
--- a/target/riscv/pmu.c
+++ b/target/riscv/pmu.c
@@ -19,6 +19,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qemu/error-report.h"
+#include "qemu/timer.h"
 #include "cpu.h"
 #include "pmu.h"
 #include "sysemu/cpu-timers.h"
@@ -176,6 +177,48 @@ static int riscv_pmu_incr_ctr_rv64(RISCVCPU *cpu, uint32_t ctr_idx)
     return 0;
 }
 
+void riscv_pmu_icount_update_priv(CPURISCVState *env, target_ulong newpriv)
+{
+    uint64_t delta;
+    uint64_t *counter_arr;
+    uint64_t *counter_arr_prev;
+    uint64_t current_icount = icount_get_raw();
+
+    if (env->virt_enabled) {
+        counter_arr = env->pmu_fixed_ctrs[1].counter_virt;
+        counter_arr_prev = env->pmu_fixed_ctrs[1].counter_virt_prev;
+    } else {
+        counter_arr = env->pmu_fixed_ctrs[1].counter;
+        counter_arr_prev = env->pmu_fixed_ctrs[1].counter_prev;
+    }
+
+    counter_arr_prev[newpriv] = current_icount;
+    delta = current_icount - counter_arr_prev[env->priv];
+
+    counter_arr[env->priv] += delta;
+}
+
+void riscv_pmu_cycle_update_priv(CPURISCVState *env, target_ulong newpriv)
+{
+    uint64_t delta;
+    uint64_t *counter_arr;
+    uint64_t *counter_arr_prev;
+    uint64_t current_host_ticks = cpu_get_host_ticks();
+
+    if (env->virt_enabled) {
+        counter_arr = env->pmu_fixed_ctrs[0].counter_virt;
+        counter_arr_prev = env->pmu_fixed_ctrs[0].counter_virt_prev;
+    } else {
+        counter_arr = env->pmu_fixed_ctrs[0].counter;
+        counter_arr_prev = env->pmu_fixed_ctrs[0].counter_prev;
+    }
+
+    counter_arr_prev[newpriv] = current_host_ticks;
+    delta = current_host_ticks - counter_arr_prev[env->priv];
+
+    counter_arr[env->priv] += delta;
+}
+
 int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx event_idx)
 {
     uint32_t ctr_idx;
diff --git a/target/riscv/pmu.h b/target/riscv/pmu.h
index 505fc850d38e..50de6031a730 100644
--- a/target/riscv/pmu.h
+++ b/target/riscv/pmu.h
@@ -31,3 +31,5 @@ int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx event_idx);
 void riscv_pmu_generate_fdt_node(void *fdt, uint32_t cmask, char *pmu_name);
 int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value,
                           uint32_t ctr_idx);
+void riscv_pmu_icount_update_priv(CPURISCVState *env, target_ulong newpriv);
+void riscv_pmu_cycle_update_priv(CPURISCVState *env, target_ulong newpriv);
-- 
2.34.1


