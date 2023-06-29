Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 55112741E1E
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 04:18:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEhDK-0002zw-Ia; Wed, 28 Jun 2023 22:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qEhDI-0002zh-Le; Wed, 28 Jun 2023 22:16:52 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qEhDG-0003u5-5J; Wed, 28 Jun 2023 22:16:51 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6689430d803so146183b3a.0; 
 Wed, 28 Jun 2023 19:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688005008; x=1690597008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UsVkoaKhdpMxCFb5Bp7hZABpDYKHsh9t+iRQ0xTvaXo=;
 b=dcpTqPIcgi9E9Hc1R9MBQmdVquQ8wmBw6hx9DQfl26G7/xMGqkaSTrZoHT+2dNyxSd
 eMtQQoVHN3iTzyacwGc4Pc81/9rY+9QKIScSKPahWsJaTe2SQIIALS++q+UWiSRgbamB
 1xLKq9QcCNwUMFereU8p1zntxKrFuZ2lO2/3LHeGKXhadLGZ6buvsT0/c29837XrJSBK
 5VOmaX0rOhZD58uKDUwnVriGEB3KlyhSqn+swREzuKBLEzpm8DraeqTpD9v3jMUW2TP+
 OnBN857ApCY90q1prmCo8RlETdd1T5hXgDWzYi79dm0IVBuGe+46RKZxoH6L4Sb4btdv
 rDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688005008; x=1690597008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UsVkoaKhdpMxCFb5Bp7hZABpDYKHsh9t+iRQ0xTvaXo=;
 b=gmD+lpzOeNDFSntdo7lqtrzxJl2rzgxuLcgLpaZYKjR17dQpy1RsIP2Z15Wtd3aCq3
 GZSfJ+7WZlJO9AUk4EowpfSi6bgoFa9Os8Nda7gWfN6YuS8jiggJE/x5rIiMzA/Fpbkn
 dbCDyNnUAXaZE0QtfIfCeUGlFcRoGnYpV/+3T9PG3jUtShgd5tvfQyz6r1YLyli7k5lt
 djEV6RX9CA5gwpqgMg2lkuoaE5brUuNWTFpPaCJvIE1fnX2IIlDJ9imASGoELPSLWEcg
 ouCb7CJT94vJTJutFrjN+bl7oi6HXyjhdUZ3wJmgMGv0oBQ4/WxelXQN474a7j2i2v9D
 EzuA==
X-Gm-Message-State: AC+VfDzVLlxQKcWh7TmLMe4Xwpo880txgv/jI10HD2bWjzLpplebPXUS
 jdGbIWZKPcotRnDbFFpX55wwdT4epW8=
X-Google-Smtp-Source: ACHHUZ64cqL2JQfaG0Owp03x5Oo/ZhwLDNDZ3Fe83k2KuFzRshkS6Zr1GNYUkMmK3CtzVfVWA8aK4w==
X-Received: by 2002:a05:6a00:2e10:b0:666:ae6b:c476 with SMTP id
 fc16-20020a056a002e1000b00666ae6bc476mr37076320pfb.25.1688005008239; 
 Wed, 28 Jun 2023 19:16:48 -0700 (PDT)
Received: from wheely.local0.net ([125.254.1.121])
 by smtp.gmail.com with ESMTPSA id
 5-20020aa79145000000b0063b96574b8bsm7480123pfi.220.2023.06.28.19.16.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 19:16:47 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [RFC PATCH 1/3] target/ppc: Add LPAR-per-core vs per-thread mode flag
Date: Thu, 29 Jun 2023 12:16:31 +1000
Message-Id: <20230629021633.328916-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230629021633.328916-1-npiggin@gmail.com>
References: <20230629021633.328916-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x432.google.com
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
sub-processor or all threads appear as one multi-threaded processor.
In the user manuals these are known as "LPAR-per-thread" and "LPAR
per core" (or "1LPAR"), respectively.

The practical difference is in LPAR-per-thread mode, non-hypervisor SPRs
are not shared between threads and msgsndp can not be used to message
siblings. In 1LPAR mode some SPRs are shared and msgsndp is usable. LPPT
allows multiple partitions to run concurrently on the same core,
and is a requirement for KVM to run on POWER9/10.

Traditionally, SMT in PAPR environments including PowerVM and the
pseries machine with KVM acceleration beahves as in 1LPAR mode. In
OPAL systems, LPAR-per-thread is used. When adding SMT to the powernv
machine, it is preferable to emulate OPAL LPAR-per-thread, so to
account for this difference a flag is added and SPRs may become either
per-thread, per-core shared, or per-LPAR shared. Per-LPAR registers
become either per-thread or per-core shared depending on the mode.

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
index 94497aa115..beddc5db5b 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -674,6 +674,8 @@ enum {
     POWERPC_FLAG_SCV      = 0x00200000,
     /* Has >1 thread per core                                                */
     POWERPC_FLAG_SMT      = 0x00400000,
+    /* Using "LPAR per core" mode  (as opposed to per-thread)                */
+    POWERPC_FLAG_1LPAR    = 0x00800000,
 };
 
 /*
@@ -1435,6 +1437,7 @@ void store_booke_tsr(CPUPPCState *env, target_ulong val);
 void ppc_tlb_invalidate_all(CPUPPCState *env);
 void ppc_tlb_invalidate_one(CPUPPCState *env, target_ulong addr);
 void cpu_ppc_set_vhyp(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp);
+void cpu_ppc_set_1lpar(PowerPCCPU *cpu);
 int ppcmas_tlb_check(CPUPPCState *env, ppcmas_tlb_t *tlb, hwaddr *raddrp,
                      target_ulong address, uint32_t pid);
 int ppcemb_tlb_search(CPUPPCState *env, target_ulong address, uint32_t pid);
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index aeff71d063..dc3a65a575 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -6601,6 +6601,18 @@ void cpu_ppc_set_vhyp(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp)
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
+        env->flags |= POWERPC_FLAG_1LPAR;
+    }
+}
 #endif /* !defined(CONFIG_USER_ONLY) */
 
 #endif /* defined(TARGET_PPC64) */
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 372ee600b2..ef186396b4 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -256,6 +256,16 @@ static inline bool gen_serialize_core(DisasContext *ctx)
 }
 #endif
 
+static inline bool gen_serialize_core_lpar(DisasContext *ctx)
+{
+    /* 1LPAR implies SMT */
+    if (ctx->flags & POWERPC_FLAG_1LPAR) {
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
+    if (!(ctx->flags & POWERPC_FLAG_1LPAR)) {
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


