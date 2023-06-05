Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3B9722480
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 13:25:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q68Jo-0007Fu-Uh; Mon, 05 Jun 2023 07:24:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q68JZ-0007Bx-Bk; Mon, 05 Jun 2023 07:24:01 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q68JX-00067E-LH; Mon, 05 Jun 2023 07:23:57 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-256a41d3e81so3977076a91.1; 
 Mon, 05 Jun 2023 04:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685964233; x=1688556233;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qtQv9mG/1sSAMYOSZ1PMqhqIDwmuO1AjyfDFNNYJ4CQ=;
 b=Kx+GQreeVYohMqWL/PKT0UTwcFEp7D0vZ3bEEfXc+2D2CvduLruFsR5BbKflnPlNE8
 ljB2A46k5v5IxwytQICtM5VArbPGYiVz65NOP949hPnwGQc+QxW3uYMRwS+2y7ecbb87
 k9DHdIQ9tyfQ77OrXqR6qS0QJcSwPrGUjAQDgeagFDe2i4Gb0aFX8xf5B0dHb+nEiy8P
 /nd9u8IMsOEymWXNgasa2wcigjB2P6D7usuh2Aj9exSlFyP2FviI6XKoDMvOFgxk4JBT
 SRaWuoz4d40vg7ZPO+RIlUZq6OHTOPpsR1sWDfg2taZRNDok1W6agyvXHKmTpO/2P4Xo
 aIAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685964233; x=1688556233;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qtQv9mG/1sSAMYOSZ1PMqhqIDwmuO1AjyfDFNNYJ4CQ=;
 b=MCBxiuRs2DYXke8Fq1Mjc8qt9tF1xdGgXwnRIiH5nxG5bxXqLMXdHdVPdp7gQwKqJ8
 ymScHcpjKOOhQDO2SB7BW0iEQrv5IF8zpbz33dZI3sZiori2EqAdD+Bu5cI/xVoQLU0W
 w6RSF+Cz8eeAu7O2E1dCgb5K2W1JoagZdqxVv9M7RIKyw4gXF3feI0FBSz0WZj1+rB5+
 oo88U1XBRvuXR2k/LOhYV4mJM6oHtQhH9CVQxBHN19sZ9/uh2EdJ93nL4VGgmYfYuAh2
 dXUPW+VY/Os1Bh3CJSFIaFnTHNorMPUwUu9SyLclNIS7cDCO2rg14WbBuqlrdRokhYjm
 GUMw==
X-Gm-Message-State: AC+VfDwQsEBcxomtSZIzeSYJwjHpG0VNsovNhA3RzQidZDEogZ8uFlzi
 tDgLqzQ/M5FAO5NQNNFDWgf06ynIoPE=
X-Google-Smtp-Source: ACHHUZ7IFMan70FtO9cY4nejhhHnZYpL62tfZFVFboYlVhLmkQdbS7T8oRIu4S0NkxqH++rPuvMfiA==
X-Received: by 2002:a17:90a:19d6:b0:259:548b:d385 with SMTP id
 22-20020a17090a19d600b00259548bd385mr2172108pjj.3.1685964233362; 
 Mon, 05 Jun 2023 04:23:53 -0700 (PDT)
Received: from wheely.local0.net ([203.221.142.9])
 by smtp.gmail.com with ESMTPSA id
 f32-20020a17090a702300b0024e026444b6sm15953385pjk.2.2023.06.05.04.23.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 04:23:52 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH 4/4] spapr: Allow up to 8 threads SMT on POWER8 and newer
Date: Mon,  5 Jun 2023 21:23:23 +1000
Message-Id: <20230605112323.179259-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230605112323.179259-1-npiggin@gmail.com>
References: <20230605112323.179259-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102a.google.com
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

PPC TCG now supports multi-threaded CPU configuration for non-hypervisor
state. This requires PIR and TIR be set, because that's how sibling thread
matching is done.

spapr's nested-HV capability does not currently coexist with SMT. This
is quite analogous to LPAR-per-core mode on real hardware which also
does not support KVM.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr.c          | 16 ++++++++++++----
 hw/ppc/spapr_caps.c     | 14 ++++++++++++++
 hw/ppc/spapr_cpu_core.c |  7 +++++--
 3 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index dcb7f1c70a..deb8b507e3 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2524,10 +2524,18 @@ static void spapr_set_vsmt_mode(SpaprMachineState *spapr, Error **errp)
     int ret;
     unsigned int smp_threads = ms->smp.threads;
 
-    if (!kvm_enabled() && (smp_threads > 1)) {
-        error_setg(errp, "TCG cannot support more than 1 thread/core "
-                   "on a pseries machine");
-        return;
+    if (!kvm_enabled()) {
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
index 3fd45a6dec..03f02b4af3 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -473,6 +473,20 @@ static void cap_nested_kvm_hv_apply(SpaprMachineState *spapr,
                 error_append_hint(errp,
                                   "Try appending -machine cap-nested-hv=off\n");
         }
+    } else {
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


