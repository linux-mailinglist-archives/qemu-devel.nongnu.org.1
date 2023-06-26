Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D22EB73D786
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 08:06:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDfFY-0005mQ-53; Mon, 26 Jun 2023 01:58:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=U+Ap=CO=kaod.org=clg@ozlabs.org>)
 id 1qDfEv-000463-0o; Mon, 26 Jun 2023 01:58:24 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=U+Ap=CO=kaod.org=clg@ozlabs.org>)
 id 1qDfEr-0007fE-Fw; Mon, 26 Jun 2023 01:58:15 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QqHFZ5H1xz4wZy;
 Mon, 26 Jun 2023 15:58:10 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QqHFX3QHsz4wb1;
 Mon, 26 Jun 2023 15:58:08 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 25/30] spapr: TCG allow up to 8-thread SMT on POWER8 and newer
 CPUs
Date: Mon, 26 Jun 2023 07:56:42 +0200
Message-ID: <20230626055647.1147743-26-clg@kaod.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626055647.1147743-1-clg@kaod.org>
References: <20230626055647.1147743-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=U+Ap=CO=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

From: Nicholas Piggin <npiggin@gmail.com>

PPC TCG supports SMT CPU configurations for non-hypervisor state, so
permit POWER8-10 pseries machines to enable SMT.

This requires PIR and TIR be set, because that's how sibling thread
matching is done by TCG.

spapr's nested-HV capability does not currently coexist with SMT, so
that combination is prohibited (interestingly somewhat analogous to
LPAR-per-core mode on real hardware which also does not support KVM).

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
[ clg: Also test smp_threads when checking for POWER8 CPU and above ]
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 hw/ppc/spapr.c          | 17 +++++++++++++----
 hw/ppc/spapr_caps.c     | 14 ++++++++++++++
 hw/ppc/spapr_cpu_core.c |  7 +++++--
 3 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 8e7d497f25fa..54dbfd7fe983 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2525,10 +2525,19 @@ static void spapr_set_vsmt_mode(SpaprMachineState *spapr, Error **errp)
     int ret;
     unsigned int smp_threads = ms->smp.threads;
 
-    if (tcg_enabled() && (smp_threads > 1)) {
-        error_setg(errp, "TCG cannot support more than 1 thread/core "
-                   "on a pseries machine");
-        return;
+    if (tcg_enabled()) {
+        if (smp_threads > 1 &&
+            !ppc_type_check_compat(ms->cpu_type, CPU_POWERPC_LOGICAL_2_07, 0,
+                                   spapr->max_compat_pvr)) {
+            error_setg(errp, "TCG only supports SMT on POWER8 or newer CPUs");
+            return;
+        }
+
+        if (smp_threads > 8) {
+            error_setg(errp, "TCG cannot support more than 8 threads/core "
+                       "on a pseries machine");
+            return;
+        }
     }
     if (!is_power_of_2(smp_threads)) {
         error_setg(errp, "Cannot support %d threads/core on a pseries "
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 3fd45a6decc2..5a0755d34fbe 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -473,6 +473,20 @@ static void cap_nested_kvm_hv_apply(SpaprMachineState *spapr,
                 error_append_hint(errp,
                                   "Try appending -machine cap-nested-hv=off\n");
         }
+    } else if (tcg_enabled()) {
+        MachineState *ms = MACHINE(spapr);
+        unsigned int smp_threads = ms->smp.threads;
+
+        /*
+         * Nested-HV vCPU env state to L2, so SMT-shared SPR updates, for
+         * example, do not necessarily update the correct SPR value on sibling
+         * threads that are in a different guest/host context.
+         */
+        if (smp_threads > 1) {
+            error_setg(errp, "TCG does not support nested-HV with SMT");
+            error_append_hint(errp, "Try appending -machine cap-nested-hv=off "
+                                    "or use threads=1 with -smp\n");
+        }
     }
 }
 
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 9b88dd549a6c..a4e3c2fadd60 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -255,7 +255,7 @@ static void spapr_cpu_core_unrealize(DeviceState *dev)
 }
 
 static bool spapr_realize_vcpu(PowerPCCPU *cpu, SpaprMachineState *spapr,
-                               SpaprCpuCore *sc, Error **errp)
+                               SpaprCpuCore *sc, int thread_index, Error **errp)
 {
     CPUPPCState *env = &cpu->env;
     CPUState *cs = CPU(cpu);
@@ -267,6 +267,9 @@ static bool spapr_realize_vcpu(PowerPCCPU *cpu, SpaprMachineState *spapr,
     cpu_ppc_set_vhyp(cpu, PPC_VIRTUAL_HYPERVISOR(spapr));
     kvmppc_set_papr(cpu);
 
+    env->spr_cb[SPR_PIR].default_value = cs->cpu_index;
+    env->spr_cb[SPR_TIR].default_value = thread_index;
+
     /* Set time-base frequency to 512 MHz. vhyp must be set first. */
     cpu_ppc_tb_init(env, SPAPR_TIMEBASE_FREQ);
 
@@ -337,7 +340,7 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < cc->nr_threads; i++) {
         sc->threads[i] = spapr_create_vcpu(sc, i, errp);
         if (!sc->threads[i] ||
-            !spapr_realize_vcpu(sc->threads[i], spapr, sc, errp)) {
+            !spapr_realize_vcpu(sc->threads[i], spapr, sc, i, errp)) {
             spapr_cpu_core_unrealize(dev);
             return;
         }
-- 
2.41.0


