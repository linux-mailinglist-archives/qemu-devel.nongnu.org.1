Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 376C47459FE
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 12:18:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGGcw-0000jN-Fq; Mon, 03 Jul 2023 06:17:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qGGcU-0000KG-4q; Mon, 03 Jul 2023 06:17:25 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qGGcS-0000vR-1U; Mon, 03 Jul 2023 06:17:21 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6b71cdb47e1so3527125a34.2; 
 Mon, 03 Jul 2023 03:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688379438; x=1690971438;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2qF/Z9+zgr+HRi5gA8P3eTX+di+A7NJtnLcplKmqPHM=;
 b=Y+3VxzgBEnwDPn193SKgyMkAz+G0gLGz3JFLCp9EWvAjZ1u98h51qF0zl3ZUu8hAl1
 IlrWzYZEZJmBo09y8E6wht/AUSquvDZuvdVHZOPnKsA2VWOMRHcwS0XNfLe3zZT1YmOF
 fnEnGi4w3q6P52WUPLEHFThGf5pxrLIvU8HiPKmr0aOZiRnyUZ1uISfkWRPDBzeMOktu
 SyxXTWzGbb1FU14JfBLv109hGguUOPP5iRsSEWB+ei971y+WKsD3ZqTTRDauKC+3UTBq
 9TXac+VwXWdHWd/hJd9aIIJ4NrM3TZEm7+4VGfHCqDZ+ESWy4ljZC1C91xi7yB2ogzZy
 igVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688379438; x=1690971438;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2qF/Z9+zgr+HRi5gA8P3eTX+di+A7NJtnLcplKmqPHM=;
 b=eCxb1WO4Ezpje3MkPACqNSs7YWzl9PY89KGsGjm8JqLf4HEIBeBRMM6ECmnoeiZHqY
 TfNwpYEEyYcXEwCNx/qMuV/pFb79R/ipA3+wUUBA4Nh944ox0GjPwCkSmCycvgRLWutr
 oLh8lfigg/KAf0xpyL7qhpfeFlFVz/Ip3QpRMeV40BqGCUTi7GBjnsZdDVi2WFTtv+Or
 L7ET0M6hdu9fvG9lDrutDkkX9giF7+4pf4wl844F8f+JrMEnBUtg75TiIDx6dqoDA+va
 zV3BzRRYUbMwIU7e3gFV9t3bJI0lp01XVD0D0qV/Xqc4fezlEkrTVTHsXxu/8njwct5o
 XigQ==
X-Gm-Message-State: ABy/qLbHo6KJ31T0+KqokXx1KHEpqul+I88+TViqk3KSGv3FuEoDPWTD
 DvianHlTDKXL5pXFsdoAdg2Iejtqdhe7iQ==
X-Google-Smtp-Source: APBJJlFPGrx28Clm+D1IcqgxbKzBonhfyN/mO24Co5uQ6gs9tVrXC0iC9s0IFt1YBiIT1DLSO1nidw==
X-Received: by 2002:a05:6358:e822:b0:134:e631:fd2b with SMTP id
 gi34-20020a056358e82200b00134e631fd2bmr6242746rwb.0.1688379438244; 
 Mon, 03 Jul 2023 03:17:18 -0700 (PDT)
Received: from wheely.local0.net ([118.210.96.60])
 by smtp.gmail.com with ESMTPSA id
 o2-20020aa79782000000b006826c9e4397sm3887727pfp.48.2023.07.03.03.17.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 03:17:18 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>
Subject: [PATCH 1/4] target/ppc: Add LPAR-per-core vs per-thread mode flag
Date: Mon,  3 Jul 2023 20:16:57 +1000
Message-Id: <20230703101700.24064-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230703101700.24064-1-npiggin@gmail.com>
References: <20230703101700.24064-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=npiggin@gmail.com; helo=mail-ot1-x32c.google.com
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
Tested-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr_cpu_core.c |  2 ++
 target/ppc/cpu.h        |  3 +++
 target/ppc/cpu_init.c   | 12 ++++++++++++
 target/ppc/translate.c  | 16 +++++++++++++---
 4 files changed, 30 insertions(+), 3 deletions(-)

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
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index db0ba49bdc..10598cde40 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -256,6 +256,16 @@ static inline bool gen_serialize_core(DisasContext *ctx)
 }
 #endif
 
+static inline bool gen_serialize_core_lpar(DisasContext *ctx)
+{
+    /* 1LPAR implies SMT */
+    if (ctx->flags & POWERPC_FLAG_SMT_1LPAR) {
+        return gen_serialize(ctx);
+    }
+
+    return true;
+}
+
 /* SPR load/store helpers */
 static inline void gen_load_spr(TCGv t, int reg)
 {
@@ -451,7 +461,7 @@ static void spr_write_CTRL_ST(DisasContext *ctx, int sprn, int gprn)
 
 void spr_write_CTRL(DisasContext *ctx, int sprn, int gprn)
 {
-    if (!(ctx->flags & POWERPC_FLAG_SMT)) {
+    if (!(ctx->flags & POWERPC_FLAG_SMT_1LPAR)) {
         spr_write_CTRL_ST(ctx, sprn, gprn);
         goto out;
     }
@@ -815,7 +825,7 @@ void spr_write_pcr(DisasContext *ctx, int sprn, int gprn)
 /* DPDES */
 void spr_read_dpdes(DisasContext *ctx, int gprn, int sprn)
 {
-    if (!gen_serialize_core(ctx)) {
+    if (!gen_serialize_core_lpar(ctx)) {
         return;
     }
 
@@ -824,7 +834,7 @@ void spr_read_dpdes(DisasContext *ctx, int gprn, int sprn)
 
 void spr_write_dpdes(DisasContext *ctx, int sprn, int gprn)
 {
-    if (!gen_serialize_core(ctx)) {
+    if (!gen_serialize_core_lpar(ctx)) {
         return;
     }
 
-- 
2.40.1


