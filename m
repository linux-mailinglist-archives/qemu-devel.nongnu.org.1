Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5197E7483C4
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 14:07:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH1Ha-0004a7-NO; Wed, 05 Jul 2023 08:06:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qH1HY-0004ZP-5Z; Wed, 05 Jul 2023 08:06:52 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qH1HW-0003SD-7K; Wed, 05 Jul 2023 08:06:51 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-666ecf9a081so4977742b3a.2; 
 Wed, 05 Jul 2023 05:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688558805; x=1691150805;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+V5Wb1UvgAvMuIUAuz+YnbQq/PuCuzQgXqqfNnT5OAU=;
 b=XD4xPJcMm6gE20E4YNO7EVwOl+b4DfQyLU5VKpEi9vGgIcxYt63fq4SF0FYCXL7aKb
 8PWsHNaPrfWL8/yhk1Nw95Q592gnAjqOi+b0utu/nLj8eLC1W0uu1+tnP6RdXBVsxHY0
 9Uk1O8EbGaQWqrdKsIut3VNOHr9gQM7gJhLEjaXQ4CB9eiPPphsfUzDZM/fiHWKanUWS
 Y4aaEVvDHDy/1ftOlyDkrmSts3GKIvYf2WB4hbvSJxUqGomuQjTma4/H/vz8n0gzVUzH
 1DSxibcM2O3A902b69ruBBjXR7E49/rpLpjYyomQSaW/qFLrxX0/ojc7ex3KThlmnxYG
 UF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688558805; x=1691150805;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+V5Wb1UvgAvMuIUAuz+YnbQq/PuCuzQgXqqfNnT5OAU=;
 b=Np+f6xY+DjoIciWxHqwbLeonPnhJE5amOK1CryzvZs7ncO7QeifzKeK1Xr/KXCHGvO
 C+Aa/e4hJQ81fZEbl1Czo7KDuvvI+LVsl0B9ZsE7tQZbtuafgpaTx+DszTxRmsvdJAiR
 dCfn2SmbRdmavDeZ0S9y/JZU6xec/3k+7YUtmH3+8ADKISZceS1qBXOTC4n5xbXc+H7Y
 2FK5RrlWDJhdsCobwWos8re53R9dYmfc+Hb/k8/UzMV9bUCx9hr37C7LtMXDLojformY
 6YMhX572wpxEl8pGqhd6dEdPXHlc4UjAwjWaYdTG15Vetay37sCLSy/P0RE+UnU3XX6h
 FlIg==
X-Gm-Message-State: ABy/qLb4LCBlD4Sbc+/5VAsjm5hCMtOFZXhPsQDqhyDg0i+iMOnrGbzA
 okKtli7dIec9SwXxgP/oINk=
X-Google-Smtp-Source: APBJJlGd4zScKooUZf0OEAjx14kIA4z+lZ08NmUoSCiATM2hVhszjBcoEH3Np/yxy+q7NFUuoc6CbA==
X-Received: by 2002:a05:6a00:24c9:b0:682:37be:c9fe with SMTP id
 d9-20020a056a0024c900b0068237bec9femr22204203pfv.10.1688558805258; 
 Wed, 05 Jul 2023 05:06:45 -0700 (PDT)
Received: from wheely.local0.net ([61.68.2.145])
 by smtp.gmail.com with ESMTPSA id
 x16-20020a056a00271000b0067459e92801sm15764843pfv.64.2023.07.05.05.06.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jul 2023 05:06:45 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>
Subject: [PATCH v2 1/4] target/ppc: Add LPAR-per-core vs per-thread mode flag
Date: Wed,  5 Jul 2023 22:06:28 +1000
Message-Id: <20230705120631.27670-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230705120631.27670-1-npiggin@gmail.com>
References: <20230705120631.27670-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x431.google.com
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

The Power ISA has the concept of sub-processors:

  Hardware is allowed to sub-divide a multi-threaded processor into
  "sub-processors" that appear to privileged programs as multi-threaded
  processors with fewer threads.

POWER9 and POWER10 have two modes, either every thread is a
sub-processor or all threads appear as one multi-threaded processor. In
the user manuals these are known as "LPAR per thread" / "Thread LPAR",
and "LPAR per core" / "1 LPAR", respectively.

The practical difference is: in thread LPAR mode, non-hypervisor SPRs
are not shared between threads and msgsndp can not be used to message
siblings. In 1 LPAR mode, some SPRs are shared and msgsndp is usable.
Thrad LPAR allows multiple partitions to run concurrently on the same
core, and is a requirement for KVM to run on POWER9/10 (which does not
gang-schedule an LPAR on all threads of a core like POWER8 KVM).

Traditionally, SMT in PAPR environments including PowerVM and the
pseries QEMU machine with KVM acceleration behaves as in 1 LPAR mode.
In OPAL systems, Thread LPAR is used. When adding SMT to the powernv
machine, it is therefore preferable to emulate Thread LPAR.

To account for this difference between pseries and powernv, an LPAR mode
flag is added such that SPRs can be implemented as per-LPAR shared, and
that becomes either per-thread or per-core depending on the flag.

Reviewed-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Tested-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr_cpu_core.c  |  2 ++
 target/ppc/cpu.h         |  3 +++
 target/ppc/cpu_init.c    | 12 ++++++++++++
 target/ppc/excp_helper.c |  4 ++++
 target/ppc/misc_helper.c |  8 ++++++++
 target/ppc/translate.c   | 11 ++++++-----
 6 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index a4e3c2fadd..b482d9754a 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -270,6 +270,8 @@ static bool spapr_realize_vcpu(PowerPCCPU *cpu, SpaprMachineState *spapr,
     env->spr_cb[SPR_PIR].default_value = cs->cpu_index;
     env->spr_cb[SPR_TIR].default_value = thread_index;
 
+    cpu_ppc_set_1lpar(cpu);
+
     /* Set time-base frequency to 512 MHz. vhyp must be set first. */
     cpu_ppc_tb_init(env, SPAPR_TIMEBASE_FREQ);
 
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index af12c93ebc..951f73d89d 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -674,6 +674,8 @@ enum {
     POWERPC_FLAG_SCV      = 0x00200000,
     /* Has >1 thread per core                                                */
     POWERPC_FLAG_SMT      = 0x00400000,
+    /* Using "LPAR per core" mode  (as opposed to per-thread)                */
+    POWERPC_FLAG_SMT_1LPAR= 0x00800000,
 };
 
 /*
@@ -1437,6 +1439,7 @@ void store_booke_tsr(CPUPPCState *env, target_ulong val);
 void ppc_tlb_invalidate_all(CPUPPCState *env);
 void ppc_tlb_invalidate_one(CPUPPCState *env, target_ulong addr);
 void cpu_ppc_set_vhyp(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp);
+void cpu_ppc_set_1lpar(PowerPCCPU *cpu);
 int ppcmas_tlb_check(CPUPPCState *env, ppcmas_tlb_t *tlb, hwaddr *raddrp,
                      target_ulong address, uint32_t pid);
 int ppcemb_tlb_search(CPUPPCState *env, target_ulong address, uint32_t pid);
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 5f4969664e..905a59aea9 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -6629,6 +6629,18 @@ void cpu_ppc_set_vhyp(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp)
     env->msr_mask &= ~MSR_HVB;
 }
 
+void cpu_ppc_set_1lpar(PowerPCCPU *cpu)
+{
+    CPUPPCState *env = &cpu->env;
+
+    /*
+     * pseries SMT means "LPAR per core" mode, e.g., msgsndp is usable
+     * between threads.
+     */
+    if (env->flags & POWERPC_FLAG_SMT) {
+        env->flags |= POWERPC_FLAG_SMT_1LPAR;
+    }
+}
 #endif /* !defined(CONFIG_USER_ONLY) */
 
 #endif /* defined(TARGET_PPC64) */
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 354392668e..7683ea0fc9 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -3130,6 +3130,10 @@ void helper_book3s_msgsndp(CPUPPCState *env, target_ulong rb)
 
     helper_hfscr_facility_check(env, HFSCR_MSGP, "msgsndp", HFSCR_IC_MSGP);
 
+    if (!(env->flags & POWERPC_FLAG_SMT_1LPAR)) {
+        nr_threads = 1; /* msgsndp behaves as 1-thread in LPAR-per-thread mode*/
+    }
+
     if (!dbell_type_server(rb) || ttir >= nr_threads) {
         return;
     }
diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index 1f1af21f33..26e546cc9c 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -191,6 +191,10 @@ target_ulong helper_load_dpdes(CPUPPCState *env)
 
     helper_hfscr_facility_check(env, HFSCR_MSGP, "load DPDES", HFSCR_IC_MSGP);
 
+    if (!(env->flags & POWERPC_FLAG_SMT_1LPAR)) {
+        nr_threads = 1; /* DPDES behaves as 1-thread in LPAR-per-thread mode */
+    }
+
     if (nr_threads == 1) {
         if (env->pending_interrupts & PPC_INTERRUPT_DOORBELL) {
             dpdes = 1;
@@ -222,6 +226,10 @@ void helper_store_dpdes(CPUPPCState *env, target_ulong val)
 
     helper_hfscr_facility_check(env, HFSCR_MSGP, "store DPDES", HFSCR_IC_MSGP);
 
+    if (!(env->flags & POWERPC_FLAG_SMT_1LPAR)) {
+        nr_threads = 1; /* DPDES behaves as 1-thread in LPAR-per-thread mode */
+    }
+
     if (val & ~(nr_threads - 1)) {
         qemu_log_mask(LOG_GUEST_ERROR, "Invalid DPDES register value "
                       TARGET_FMT_lx"\n", val);
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index db0ba49bdc..4556297ab5 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -246,9 +246,9 @@ static inline bool gen_serialize(DisasContext *ctx)
 }
 
 #if defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY)
-static inline bool gen_serialize_core(DisasContext *ctx)
+static inline bool gen_serialize_core_lpar(DisasContext *ctx)
 {
-    if (ctx->flags & POWERPC_FLAG_SMT) {
+    if (ctx->flags & POWERPC_FLAG_SMT_1LPAR) {
         return gen_serialize(ctx);
     }
 
@@ -451,7 +451,8 @@ static void spr_write_CTRL_ST(DisasContext *ctx, int sprn, int gprn)
 
 void spr_write_CTRL(DisasContext *ctx, int sprn, int gprn)
 {
-    if (!(ctx->flags & POWERPC_FLAG_SMT)) {
+    if (!(ctx->flags & POWERPC_FLAG_SMT_1LPAR)) {
+        /* CTRL behaves as 1-thread in LPAR-per-thread mode */
         spr_write_CTRL_ST(ctx, sprn, gprn);
         goto out;
     }
@@ -815,7 +816,7 @@ void spr_write_pcr(DisasContext *ctx, int sprn, int gprn)
 /* DPDES */
 void spr_read_dpdes(DisasContext *ctx, int gprn, int sprn)
 {
-    if (!gen_serialize_core(ctx)) {
+    if (!gen_serialize_core_lpar(ctx)) {
         return;
     }
 
@@ -824,7 +825,7 @@ void spr_read_dpdes(DisasContext *ctx, int gprn, int sprn)
 
 void spr_write_dpdes(DisasContext *ctx, int sprn, int gprn)
 {
-    if (!gen_serialize_core(ctx)) {
+    if (!gen_serialize_core_lpar(ctx)) {
         return;
     }
 
-- 
2.40.1


