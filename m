Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FBD74B035
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 13:47:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHjho-0003EU-By; Fri, 07 Jul 2023 07:32:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjhf-00032R-BF; Fri, 07 Jul 2023 07:32:49 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjhc-0006n7-3j; Fri, 07 Jul 2023 07:32:45 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6b5d5e6b086so1085441a34.1; 
 Fri, 07 Jul 2023 04:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688729562; x=1691321562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R3bY1q5kf6/rVmn8/fEVz8+/dHlEPFJNirZ9iDq1UYA=;
 b=S4YIVfglXv1ZSiBnE5CXSpAZxbV7a7em/vI7KbCaKwnOdvyqm8GUV662z3GUgU0mcM
 eUF3SJ4DWETLRL1xfMDkGmhas6+0+ONDpnzhYUxhvruql9MdhPQtfT3jm6kFH4QJFLnk
 tbjcA7BqOEhr7Ot6D9KHiDovrwWDBWvE4ismC0yGpTycsiPu2axSXz1d1TmBFTVWPHbE
 Wuo5Xj9JOWMZvJ9qDWgmetqZq6ZBjPs3K32YCxLJewWFl6ay2Yu8cD4VW5WphxClapJz
 rUpQv5rR1PUf/Am7316Gf+6QwEnQBjCRJ4W1THtSzrpEBLWyU/MNU8CSrh2BRXJ8Rz9w
 pPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688729562; x=1691321562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R3bY1q5kf6/rVmn8/fEVz8+/dHlEPFJNirZ9iDq1UYA=;
 b=fQfqyMbzmVz46fHOeQ0JRtDGcj0F+fZVN+BeRLwXClZmluBqLezfDgUd8cdFItazz0
 qnoCcmTd1p4dMwdyCN7V+3xaLUy1Y5QqeUKM1VlFAVeRktv4L0jyLPdtDJnemb0Bvz8r
 6+MgFGzXgmcV3O8kzvADwhKndwpEEXFt+2NdhAyiZSs/3drVKF2UGh9GOoCMbv2QDB0Y
 IE+Snni3wcKOdva+om9hrjBqt56CsEX7KzZJbkjTfKonPpWqPb0jXojrZCUxPCqo3M7y
 3PVAiuB9OqU6WjyYnR44CypkpluEFNOuAUNyD6knTB6+bfQQbyoTLPk2Ez22F57Nh//x
 /hsw==
X-Gm-Message-State: ABy/qLZKbLi2K7RY9Vh3Agn04HAcM9ibxol04X7T0SX+JQkj1EkvjPe1
 bDOqzHZS9sYPY+ytYz5ha2G1gdq99rk=
X-Google-Smtp-Source: APBJJlElP8nyxOViLYoPIfHnS5zOAt+PkWNXfjtTTfF4c1oZcU2ntozcv/roF1JJkEJ4ZWybukkbAw==
X-Received: by 2002:a05:6830:631c:b0:6b8:78a1:be14 with SMTP id
 cg28-20020a056830631c00b006b878a1be14mr5006286otb.2.1688729562526; 
 Fri, 07 Jul 2023 04:32:42 -0700 (PDT)
Received: from grind.. ([2804:14c:f435:9162::1002])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a9d6c51000000b006b74b37f5e5sm1574859otq.20.2023.07.07.04.32.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 04:32:42 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, Nicholas Piggin <npiggin@gmail.com>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 31/60] target/ppc: Add LPAR-per-core vs per-thread mode flag
Date: Fri,  7 Jul 2023 08:30:39 -0300
Message-ID: <20230707113108.7145-32-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707113108.7145-1-danielhb413@gmail.com>
References: <20230707113108.7145-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x32c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Nicholas Piggin <npiggin@gmail.com>

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
Message-ID: <20230705120631.27670-2-npiggin@gmail.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
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
index af12c93ebc..b269b0d090 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -674,6 +674,8 @@ enum {
     POWERPC_FLAG_SCV      = 0x00200000,
     /* Has >1 thread per core                                                */
     POWERPC_FLAG_SMT      = 0x00400000,
+    /* Using "LPAR per core" mode  (as opposed to per-thread)                */
+    POWERPC_FLAG_SMT_1LPAR = 0x00800000,
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
2.41.0


