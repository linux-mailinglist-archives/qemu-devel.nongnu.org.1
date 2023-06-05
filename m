Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B581A72247C
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 13:25:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q68JX-0007BA-AL; Mon, 05 Jun 2023 07:23:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q68JV-0007A0-D0; Mon, 05 Jun 2023 07:23:53 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q68JT-00066z-KG; Mon, 05 Jun 2023 07:23:53 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6af713338ccso2713536a34.0; 
 Mon, 05 Jun 2023 04:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685964229; x=1688556229;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MrBfNhL+RlLKycbOMKWvyVjTAEwcluZpAacai94Li3I=;
 b=WSpNPIwgQELYx4ddGcZRNIJKpaE6b9UScVYkgw5oiwJ8m9lgKjGjVLKKog2QQUMzdx
 Ps54sAPbO9WeETyuf42/buql3WkuICs+LwoOgYizNqmScjdfGmMK3BtueOqyN+vJiPH8
 zFMOAyondGCsr+0SEodO1bqvZffcX7/f7rPmBAx0Jd6j9gPI+Apjcvilsl5fpmbm3TbR
 sXnHkCq9kyc1Tg3VtcG4EPnxM/JjweLDt30q9S9TrmdV9IbrvCH+ZLIzCQs24APSduDl
 6YLsd+86O9kesBV/KfschnHj/UjEzw9/lFzx30fa2xwa79SqpxrlU6jXzKp9jsZ8khyf
 ikgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685964229; x=1688556229;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MrBfNhL+RlLKycbOMKWvyVjTAEwcluZpAacai94Li3I=;
 b=Qr6fspPkc0vPoGh/pBORvwNgLpQoq8U7UfX26/ZbRewb+6E0Q3aIG1AP2WT8n+XYYV
 3GO43ZLyAWdvxhBIjvzbTemke5de2fdSAOL7OM8Rg2iwonXU0nbcpYj0QMKl2DEyCcVC
 9Xj9JIledRB0u7mmNd/WIFkN+FThMzfVJnPmbxb2Rdq5Q3+SckT+of6zE82QrgpRT7iO
 2I6U4nHRwptENi+16L92wjJk9OU+AOzdf4Sjlc3mpUXEVUZjzaE8Q4LHvQ4zWELHzsPf
 G1badzRHSGRbzWVrugZluOi3IqkoNtqXg807Dd1rYnVPsy3EExHt43QKIv2IwrqHC/d5
 Gqsw==
X-Gm-Message-State: AC+VfDzwTHMhGifZa6t63MNuvpPeg5ddsQKq2h9uRnHBvRsu+MhPppZX
 8E/rD2nUmShxKD53dJ80xkwI38n0hdA=
X-Google-Smtp-Source: ACHHUZ6DNpAjrXbJvlxj4SumW8FgVFPbipbITjy2epHHSNsD03ifQzg8Qw4hpdkNSqzNaTDRiRQ75w==
X-Received: by 2002:a05:6358:cb25:b0:129:cebd:d671 with SMTP id
 gr37-20020a056358cb2500b00129cebdd671mr459761rwb.11.1685964229066; 
 Mon, 05 Jun 2023 04:23:49 -0700 (PDT)
Received: from wheely.local0.net ([203.221.142.9])
 by smtp.gmail.com with ESMTPSA id
 f32-20020a17090a702300b0024e026444b6sm15953385pjk.2.2023.06.05.04.23.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 04:23:48 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH 3/4] target/ppc: Add msgsndp and DPDES SMT support
Date: Mon,  5 Jun 2023 21:23:22 +1000
Message-Id: <20230605112323.179259-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230605112323.179259-1-npiggin@gmail.com>
References: <20230605112323.179259-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=npiggin@gmail.com; helo=mail-ot1-x329.google.com
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

Doorbells in SMT need to coordinate msgsndp/msgclrp and DPDES access from
multiple threads that affect the same state.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/ppc.c             |  6 ++++++
 include/hw/ppc/ppc.h     |  1 +
 target/ppc/excp_helper.c | 30 ++++++++++++++++++++++-----
 target/ppc/gdbstub.c     |  2 +-
 target/ppc/misc_helper.c | 44 ++++++++++++++++++++++++++++++++++------
 target/ppc/translate.c   |  8 ++++++++
 6 files changed, 79 insertions(+), 12 deletions(-)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 80b4706db2..5bd4f6708f 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -1434,6 +1434,12 @@ int ppc_cpu_pir(PowerPCCPU *cpu)
     return env->spr_cb[SPR_PIR].default_value;
 }
 
+int ppc_cpu_tir(PowerPCCPU *cpu)
+{
+    CPUPPCState *env = &cpu->env;
+    return env->spr_cb[SPR_TIR].default_value;
+}
+
 PowerPCCPU *ppc_get_vcpu_by_pir(int pir)
 {
     CPUState *cs;
diff --git a/include/hw/ppc/ppc.h b/include/hw/ppc/ppc.h
index 02af03ada2..e095c002dc 100644
--- a/include/hw/ppc/ppc.h
+++ b/include/hw/ppc/ppc.h
@@ -6,6 +6,7 @@
 void ppc_set_irq(PowerPCCPU *cpu, int n_IRQ, int level);
 PowerPCCPU *ppc_get_vcpu_by_pir(int pir);
 int ppc_cpu_pir(PowerPCCPU *cpu);
+int ppc_cpu_tir(PowerPCCPU *cpu);
 
 /* PowerPC hardware exceptions management helpers */
 typedef void (*clk_setup_cb)(void *opaque, uint32_t freq);
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 4925996cf3..1e04452614 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -3154,22 +3154,42 @@ void helper_book3s_msgclrp(CPUPPCState *env, target_ulong rb)
 }
 
 /*
- * sends a message to other threads that are on the same
+ * sends a message to another thread  on the same
  * multi-threaded processor
  */
 void helper_book3s_msgsndp(CPUPPCState *env, target_ulong rb)
 {
-    int pir = env->spr_cb[SPR_PIR].default_value;
+    CPUState *cs = env_cpu(env);
+    PowerPCCPU *cpu = POWERPC_CPU(cs);
+    CPUState *ccs;
+    uint32_t nr_threads = cs->nr_threads;
+    int ttir = rb & PPC_BITMASK(57, 63);
 
     helper_hfscr_facility_check(env, HFSCR_MSGP, "msgsndp", HFSCR_IC_MSGP);
 
-    if (!dbell_type_server(rb)) {
+    if (!dbell_type_server(rb) || ttir >= nr_threads) {
+        return;
+    }
+
+    if (nr_threads == 1) {
+        ppc_set_irq(cpu, PPC_INTERRUPT_DOORBELL, 1);
         return;
     }
 
-    /* TODO: TCG supports only one thread */
+    /* WHy does iothread need to be locked for walking CPU list? */
+    qemu_mutex_lock_iothread();
+    THREAD_SIBLING_FOREACH(cs, ccs) {
+        PowerPCCPU *ccpu = POWERPC_CPU(ccs);
+        uint32_t thread_id = ppc_cpu_tir(ccpu);
+
+        if (ttir == thread_id) {
+            ppc_set_irq(ccpu, PPC_INTERRUPT_DOORBELL, 1);
+            qemu_mutex_unlock_iothread();
+            return;
+        }
+    }
 
-    book3s_msgsnd_common(pir, PPC_INTERRUPT_DOORBELL);
+    assert(0);
 }
 #endif /* TARGET_PPC64 */
 
diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
index ca39efdc35..f0304e5bb6 100644
--- a/target/ppc/gdbstub.c
+++ b/target/ppc/gdbstub.c
@@ -117,7 +117,7 @@ void ppc_maybe_bswap_register(CPUPPCState *env, uint8_t *mem_buf, int len)
  * regs and PC, MSR, CR, and so forth.  We hack round this by giving
  * the FP regs zero size when talking to a newer gdb.
  */
-
+/* XXX: read/write dpdes correctly */
 int ppc_cpu_gdb_read_register(CPUState *cs, GByteArray *buf, int n)
 {
     PowerPCCPU *cpu = POWERPC_CPU(cs);
diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index a058eb24cd..9688774139 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -184,14 +184,31 @@ void helper_store_pcr(CPUPPCState *env, target_ulong value)
  */
 target_ulong helper_load_dpdes(CPUPPCState *env)
 {
+    CPUState *cs = env_cpu(env);
+    CPUState *ccs;
+    uint32_t nr_threads = cs->nr_threads;
     target_ulong dpdes = 0;
 
     helper_hfscr_facility_check(env, HFSCR_MSGP, "load DPDES", HFSCR_IC_MSGP);
 
-    /* TODO: TCG supports only one thread */
-    if (env->pending_interrupts & PPC_INTERRUPT_DOORBELL) {
-        dpdes = 1;
+    if (nr_threads == 1) {
+        if (env->pending_interrupts & PPC_INTERRUPT_DOORBELL) {
+            dpdes = 1;
+        }
+        return dpdes;
+    }
+
+    qemu_mutex_lock_iothread();
+    THREAD_SIBLING_FOREACH(cs, ccs) {
+        PowerPCCPU *ccpu = POWERPC_CPU(ccs);
+        CPUPPCState *cenv = &ccpu->env;
+        uint32_t thread_id = ppc_cpu_tir(ccpu);
+
+        if (cenv->pending_interrupts & PPC_INTERRUPT_DOORBELL) {
+            dpdes |= (0x1 << thread_id);
+        }
     }
+    qemu_mutex_unlock_iothread();
 
     return dpdes;
 }
@@ -199,17 +216,32 @@ target_ulong helper_load_dpdes(CPUPPCState *env)
 void helper_store_dpdes(CPUPPCState *env, target_ulong val)
 {
     PowerPCCPU *cpu = env_archcpu(env);
+    CPUState *cs = env_cpu(env);
+    CPUState *ccs;
+    uint32_t nr_threads = cs->nr_threads;
 
     helper_hfscr_facility_check(env, HFSCR_MSGP, "store DPDES", HFSCR_IC_MSGP);
 
-    /* TODO: TCG supports only one thread */
-    if (val & ~0x1) {
+    if (val & ~(nr_threads - 1)) {
         qemu_log_mask(LOG_GUEST_ERROR, "Invalid DPDES register value "
                       TARGET_FMT_lx"\n", val);
+        val &= (nr_threads - 1); /* Ignore the invalid bits */
+    }
+
+    if (nr_threads == 1) {
+        /* XXX: don't need iothread lock (does ppc_set_irq takes it?) */
+        ppc_set_irq(cpu, PPC_INTERRUPT_DOORBELL, val & 0x1);
         return;
     }
 
-    ppc_set_irq(cpu, PPC_INTERRUPT_DOORBELL, val & 0x1);
+    qemu_mutex_lock_iothread();
+    THREAD_SIBLING_FOREACH(cs, ccs) {
+        PowerPCCPU *ccpu = POWERPC_CPU(ccs);
+        uint32_t thread_id = ppc_cpu_tir(ccpu);
+
+        ppc_set_irq(cpu, PPC_INTERRUPT_DOORBELL, val & (0x1 << thread_id));
+    }
+    qemu_mutex_unlock_iothread();
 }
 #endif /* defined(TARGET_PPC64) */
 
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 31821f92f5..0aa49323d3 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -820,11 +820,19 @@ void spr_write_pcr(DisasContext *ctx, int sprn, int gprn)
 /* DPDES */
 void spr_read_dpdes(DisasContext *ctx, int gprn, int sprn)
 {
+    if (!gen_serialize_core(ctx)) {
+        return;
+    }
+
     gen_helper_load_dpdes(cpu_gpr[gprn], cpu_env);
 }
 
 void spr_write_dpdes(DisasContext *ctx, int sprn, int gprn)
 {
+    if (!gen_serialize_core(ctx)) {
+        return;
+    }
+
     gen_helper_store_dpdes(cpu_env, cpu_gpr[gprn]);
 }
 #endif
-- 
2.40.1


