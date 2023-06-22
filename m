Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E07739D76
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 11:35:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCGi3-0000pC-K1; Thu, 22 Jun 2023 05:34:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qCGi1-0000oS-Ag; Thu, 22 Jun 2023 05:34:33 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qCGhz-0003RZ-N5; Thu, 22 Jun 2023 05:34:33 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-666e5f0d60bso3453959b3a.3; 
 Thu, 22 Jun 2023 02:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687426469; x=1690018469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iztxxuocG32dEPagObJRElL6SocUWZT7jIaplMj9hX4=;
 b=mTLsdN43dBOoMWkCneDStYkzKFyjKI1OlMRBhM9laXni6AP5Zcgn1hclCXR6bIFbAh
 h5KiDp5gG9Bl/3qkDoDtFMdjqMh3j1nlLzXeE165kUcvABXm5s9VqglZEeleoaw0OlXj
 Pjsf8Yp3oU+P5F5gWLyiRyJgE0s5rnHTQ5AquciF4e2PzfKT1f34DzMlquLihuT9O+fm
 NoxrhDFYJ/ZvOJFb3deQmlx5PeURx8GVfHBplIlotuDoA25Ru7AgqtQS0XXp7QMiPUup
 +GRY85jn939jDkNT80ad+lXrLjKs8SI1n8PuLOeocgkHi5kt4aSyeYbyz3cCeQ6JHGWC
 EA2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687426469; x=1690018469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iztxxuocG32dEPagObJRElL6SocUWZT7jIaplMj9hX4=;
 b=Gs8KDGYH4jW8Kyk3fu15d7JIF9F+XjU9m1Yfl+jo2B3kWnY127Ozq9A/ZYa/RLFGJD
 vZKeAdKNEPW2lDdbnaW701DAGXQwevWn+EyPsfTM6/eQkecZVjsz0Zw5MUpxkE97AyrA
 OUckwsMIgjyBT9nVBPAtcNN9RLsCy/BPO7gyay0q1YOFB5Em94qVromk5JiNj6tAMBcK
 KXCrCDyTOawSvi9+GMSHJjAdw/wyPUwJSWsy6RJSX36+e0lvlZmWqGDNmDKUOnt7hVSU
 UxWaQR9oi70yhjWYUHR2WffsrnU6EFVEDoSJwNUoNTyVGo7LvbC3PIvpb//O0BG4YpZ8
 649Q==
X-Gm-Message-State: AC+VfDwI4NsIWkFxy+PK5kakKVCoSffIneLtXLCBzLoqPHEb56fVTSNK
 MPd9pNWLBvqUnRKEAQHmo0ZY+jP9D7o=
X-Google-Smtp-Source: ACHHUZ6/zoG3SgjxJdwpZWMXg9v+ae144eSXD+Bj8TLRI0MHcJJMc1wC73t0aemi7JQ6NvpDBzBr0g==
X-Received: by 2002:a05:6a20:4299:b0:121:d74e:8b46 with SMTP id
 o25-20020a056a20429900b00121d74e8b46mr8843969pzj.55.1687426469406; 
 Thu, 22 Jun 2023 02:34:29 -0700 (PDT)
Received: from wheely.local0.net (193-116-203-37.tpgi.com.au. [193.116.203.37])
 by smtp.gmail.com with ESMTPSA id
 x3-20020a1709027c0300b001ac2c3e54adsm4925662pll.118.2023.06.22.02.34.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 02:34:29 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 5/7] spapr: TCG allow up to 8-thread SMT on POWER8 and
 newer CPUs
Date: Thu, 22 Jun 2023 19:33:55 +1000
Message-Id: <20230622093357.255649-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622093357.255649-1-npiggin@gmail.com>
References: <20230622093357.255649-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

PPC TCG supports SMT CPU configurations for non-hypervisor state, so
permit POWER8-10 pseries machines to enable SMT.

This requires PIR and TIR be set, because that's how sibling thread
matching is done by TCG.

spapr's nested-HV capability does not currently coexist with SMT, so
that combination is prohibited (interestingly somewhat analogous to
LPAR-per-core mode on real hardware which also does not support KVM).

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr.c          | 16 ++++++++++++----
 hw/ppc/spapr_caps.c     | 14 ++++++++++++++
 hw/ppc/spapr_cpu_core.c |  7 +++++--
 3 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 8e7d497f25..677b5eef9d 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2525,10 +2525,18 @@ static void spapr_set_vsmt_mode(SpaprMachineState *spapr, Error **errp)
     int ret;
     unsigned int smp_threads = ms->smp.threads;
 
-    if (tcg_enabled() && (smp_threads > 1)) {
-        error_setg(errp, "TCG cannot support more than 1 thread/core "
-                   "on a pseries machine");
-        return;
+    if (tcg_enabled()) {
+        if (!ppc_type_check_compat(ms->cpu_type, CPU_POWERPC_LOGICAL_2_07, 0,
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
index 3fd45a6dec..5a0755d34f 100644
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
index 9b88dd549a..a4e3c2fadd 100644
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
2.40.1


