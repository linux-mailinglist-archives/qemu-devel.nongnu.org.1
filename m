Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89816BBD8E7
	for <lists+qemu-devel@lfdr.de>; Mon, 06 Oct 2025 11:59:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5hyf-0006O7-Vg; Mon, 06 Oct 2025 05:57:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1v5hyd-0006NF-Ky
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 05:57:55 -0400
Received: from mailgate01.uberspace.is ([95.143.172.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1v5hyb-0003qI-Aa
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 05:57:55 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate01.uberspace.is (Postfix) with ESMTPS id DC48760BB4
 for <qemu-devel@nongnu.org>; Mon,  6 Oct 2025 11:57:41 +0200 (CEST)
Received: (qmail 18837 invoked by uid 990); 6 Oct 2025 09:57:41 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Mon, 06 Oct 2025 11:57:41 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>,
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs)
Subject: [PATCH v7 15/25] target/ppc: call plugin trap callbacks
Date: Mon,  6 Oct 2025 11:57:10 +0200
Message-ID: <f9c72c655e1a1d8beaf97cac872e8c47b6650577.1759744337.git.neither@nut.email>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <cover.1759744337.git.neither@nut.email>
References: <cover.1759744337.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.962428) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -5.562428
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=uQChR51oj+aG0zkY+/JvsLAbv/s6w2MfYyQgGOhbbLc=;
 b=tUXQi6UCmsDyeKT06HmgCe5SwRDGPANaL8B41oRkePhysJTKJRsSrRV29hhGZhM9EcnmnEPh37
 PH9PiXhyPzIInUgk6IOUxgdGdBcT+xjTtFUIQMb0tFihU9jvVJhOQv4LEGwPqdOgfntjIhwvepar
 bka7PiUXv4pGtjizU4/IX9zVGgDVh38Ym5TYCZv+7T11MX4APpvZl0Wd8W+tKbi4PS/WjBZvXAhO
 KxpES34drR9P8Yzcohwp9YsBkNthJxPr0X/izPwgA+Cjkqf19XiSKOKx1hh13PmWHuUkyIOF8Q7u
 wJGYo7yq37ydHo3N6mPkBNNzC0cPpIP1hVmdFBu9KXshU2PyhdA5Yn1Bc9KnqwFLlKK5h0eRsN3h
 Rru5R6/CzeWx6LFSAyHreGGlZ1SEqkPDLasndPqzlkHbqXX07y2Dp54vex7HFa3OooT0L0Rnzs5t
 YpzOOzeeY0emjvbQqyQJVohgqY1Ul7obvm4ayH2tMWFJecT7vF0aXcXv5D3E3KzwR8Ugdw99Iq6U
 qcRTm+ZXagerSI7PTOl/BEHwpd+piUrVSo7zFy417fdIeMCU2A38Ik5Ml6W0dzLV7NixzA8uQxwp
 WTQfUEyEeAMPpwyExxQV6duOicnG4uqFwy3n4b6rLpGqb+cg6e4Ev6JHyVrOrPFEpiiAVthp/J/F
 Q=
Received-SPF: pass client-ip=95.143.172.20; envelope-from=neither@nut.email;
 helo=mailgate01.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We recently introduced API for registering callbacks for trap related
events as well as the corresponding hook functions. Due to differences
between architectures, the latter need to be called from target specific
code.

This change places hooks for Power PC targets.

Signed-off-by: Julian Ganz <neither@nut.email>
---
 target/ppc/excp_helper.c | 41 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index d8bca19fff..6d05b86505 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -27,6 +27,7 @@
 #include "internal.h"
 #include "helper_regs.h"
 #include "hw/ppc/ppc.h"
+#include "qemu/plugin.h"
 
 #include "trace.h"
 
@@ -404,11 +405,31 @@ static void powerpc_mcheck_checkstop(CPUPPCState *env)
     powerpc_checkstop(env, "machine check with MSR[ME]=0");
 }
 
+static void powerpc_do_plugin_vcpu_interrupt_cb(CPUState *cs, int excp,
+                                                uint64_t from)
+{
+    switch (excp) {
+    case POWERPC_EXCP_NONE:
+        break;
+    case POWERPC_EXCP_FIT:
+    case POWERPC_EXCP_WDT:
+    case POWERPC_EXCP_PIT:
+    case POWERPC_EXCP_SMI:
+    case POWERPC_EXCP_PERFM:
+    case POWERPC_EXCP_THERM:
+        qemu_plugin_vcpu_interrupt_cb(cs, from);
+        break;
+    default:
+        qemu_plugin_vcpu_exception_cb(cs, from);
+    }
+}
+
 static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
 {
     CPUPPCState *env = &cpu->env;
     target_ulong msr, new_msr, vector;
     int srr0 = SPR_SRR0, srr1 = SPR_SRR1;
+    uint64_t last_pc = env->nip;
 
     /* new srr1 value excluding must-be-zero bits */
     msr = env->msr & ~0x783f0000ULL;
@@ -456,6 +477,7 @@ static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
             if (!FIELD_EX64_FE(env->msr) || !FIELD_EX64(env->msr, MSR, FP)) {
                 trace_ppc_excp_fp_ignore();
                 powerpc_reset_excp_state(cpu);
+                qemu_plugin_vcpu_exception_cb(env_cpu(env), last_pc);
                 return;
             }
             env->spr[SPR_40x_ESR] = ESR_FP;
@@ -510,12 +532,14 @@ static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
     env->spr[srr0] = env->nip;
     env->spr[srr1] = msr;
     powerpc_set_excp_state(cpu, vector, new_msr);
+    powerpc_do_plugin_vcpu_interrupt_cb(env_cpu(env), excp, last_pc);
 }
 
 static void powerpc_excp_6xx(PowerPCCPU *cpu, int excp)
 {
     CPUPPCState *env = &cpu->env;
     target_ulong msr, new_msr, vector;
+    uint64_t last_pc = env->nip;
 
     /* new srr1 value excluding must-be-zero bits */
     msr = env->msr & ~0x783f0000ULL;
@@ -567,6 +591,7 @@ static void powerpc_excp_6xx(PowerPCCPU *cpu, int excp)
             if (!FIELD_EX64_FE(env->msr) || !FIELD_EX64(env->msr, MSR, FP)) {
                 trace_ppc_excp_fp_ignore();
                 powerpc_reset_excp_state(cpu);
+                qemu_plugin_vcpu_exception_cb(env_cpu(env), last_pc);
                 return;
             }
             /*
@@ -653,12 +678,14 @@ static void powerpc_excp_6xx(PowerPCCPU *cpu, int excp)
     env->spr[SPR_SRR0] = env->nip;
     env->spr[SPR_SRR1] = msr;
     powerpc_set_excp_state(cpu, vector, new_msr);
+    powerpc_do_plugin_vcpu_interrupt_cb(env_cpu(env), excp, last_pc);
 }
 
 static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
 {
     CPUPPCState *env = &cpu->env;
     target_ulong msr, new_msr, vector;
+    uint64_t last_pc = env->nip;
 
     /* new srr1 value excluding must-be-zero bits */
     msr = env->msr & ~0x783f0000ULL;
@@ -708,6 +735,7 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
             if (!FIELD_EX64_FE(env->msr) || !FIELD_EX64(env->msr, MSR, FP)) {
                 trace_ppc_excp_fp_ignore();
                 powerpc_reset_excp_state(cpu);
+                qemu_plugin_vcpu_exception_cb(env_cpu(env), last_pc);
                 return;
             }
             /*
@@ -758,6 +786,7 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
         if (lev == 1 && cpu->vhyp) {
             cpu->vhyp_class->hypercall(cpu->vhyp, cpu);
             powerpc_reset_excp_state(cpu);
+            qemu_plugin_vcpu_hostcall_cb(env_cpu(env), last_pc);
             return;
         }
 
@@ -803,12 +832,14 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
     env->spr[SPR_SRR0] = env->nip;
     env->spr[SPR_SRR1] = msr;
     powerpc_set_excp_state(cpu, vector, new_msr);
+    powerpc_do_plugin_vcpu_interrupt_cb(env_cpu(env), excp, last_pc);
 }
 
 static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
 {
     CPUPPCState *env = &cpu->env;
     target_ulong msr, new_msr, vector;
+    uint64_t last_pc = env->nip;
 
     /* new srr1 value excluding must-be-zero bits */
     msr = env->msr & ~0x783f0000ULL;
@@ -858,6 +889,7 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
             if (!FIELD_EX64_FE(env->msr) || !FIELD_EX64(env->msr, MSR, FP)) {
                 trace_ppc_excp_fp_ignore();
                 powerpc_reset_excp_state(cpu);
+                qemu_plugin_vcpu_exception_cb(env_cpu(env), last_pc);
                 return;
             }
             /*
@@ -908,6 +940,7 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
         if (lev == 1 && cpu->vhyp) {
             cpu->vhyp_class->hypercall(cpu->vhyp, cpu);
             powerpc_reset_excp_state(cpu);
+            qemu_plugin_vcpu_hostcall_cb(env_cpu(env), last_pc);
             return;
         }
 
@@ -947,6 +980,7 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
     env->spr[SPR_SRR0] = env->nip;
     env->spr[SPR_SRR1] = msr;
     powerpc_set_excp_state(cpu, vector, new_msr);
+    powerpc_do_plugin_vcpu_interrupt_cb(env_cpu(env), excp, last_pc);
 }
 
 static void powerpc_excp_ppe42(PowerPCCPU *cpu, int excp)
@@ -1073,6 +1107,7 @@ static void powerpc_excp_booke(PowerPCCPU *cpu, int excp)
     CPUPPCState *env = &cpu->env;
     target_ulong msr, new_msr, vector;
     int srr0 = SPR_SRR0, srr1 = SPR_SRR1;
+    uint64_t last_pc = env->nip;
 
     /*
      * Book E does not play games with certain bits of xSRR1 being MSR save
@@ -1144,6 +1179,7 @@ static void powerpc_excp_booke(PowerPCCPU *cpu, int excp)
             if (!FIELD_EX64_FE(env->msr) || !FIELD_EX64(env->msr, MSR, FP)) {
                 trace_ppc_excp_fp_ignore();
                 powerpc_reset_excp_state(cpu);
+                qemu_plugin_vcpu_exception_cb(env_cpu(env), last_pc);
                 return;
             }
             /*
@@ -1252,6 +1288,7 @@ static void powerpc_excp_booke(PowerPCCPU *cpu, int excp)
     env->spr[srr0] = env->nip;
     env->spr[srr1] = msr;
     powerpc_set_excp_state(cpu, vector, new_msr);
+    powerpc_do_plugin_vcpu_interrupt_cb(env_cpu(env), excp, last_pc);
 }
 
 /*
@@ -1373,6 +1410,7 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
     CPUPPCState *env = &cpu->env;
     target_ulong msr, new_msr, vector;
     int srr0 = SPR_SRR0, srr1 = SPR_SRR1, lev = -1;
+    uint64_t last_pc = env->nip;
 
     /* new srr1 value excluding must-be-zero bits */
     msr = env->msr & ~0x783f0000ULL;
@@ -1472,6 +1510,7 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
             if (!FIELD_EX64_FE(env->msr) || !FIELD_EX64(env->msr, MSR, FP)) {
                 trace_ppc_excp_fp_ignore();
                 powerpc_reset_excp_state(cpu);
+                qemu_plugin_vcpu_exception_cb(env_cpu(env), last_pc);
                 return;
             }
             /*
@@ -1516,6 +1555,7 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
         if (lev == 1 && books_vhyp_handles_hcall(cpu)) {
             cpu->vhyp_class->hypercall(cpu->vhyp, cpu);
             powerpc_reset_excp_state(cpu);
+            qemu_plugin_vcpu_hostcall_cb(env_cpu(env), last_pc);
             return;
         }
         if (env->insns_flags2 & PPC2_ISA310) {
@@ -1662,6 +1702,7 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
         ppc_excp_apply_ail(cpu, excp, msr, &new_msr, &vector);
         powerpc_set_excp_state(cpu, vector, new_msr);
     }
+    powerpc_do_plugin_vcpu_interrupt_cb(env_cpu(env), excp, last_pc);
 }
 #else
 static inline void powerpc_excp_books(PowerPCCPU *cpu, int excp)
-- 
2.49.1


