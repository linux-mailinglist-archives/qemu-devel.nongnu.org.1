Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE99739D79
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 11:35:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCGhu-0000lc-1r; Thu, 22 Jun 2023 05:34:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qCGhs-0000lD-0x; Thu, 22 Jun 2023 05:34:24 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qCGhq-0003QB-Ay; Thu, 22 Jun 2023 05:34:23 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1b52132181aso37095835ad.2; 
 Thu, 22 Jun 2023 02:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687426460; x=1690018460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pzzr5pE6kWqzcd42lVxfWrDN6uelcbJs3SVe8LRJUoc=;
 b=a6ibJTKNdIb8mRHWoFW1fh/th/hYh90MCE983YD2zyN7mMPuf/7ToZGon8O1W7Eff5
 6+Ktf2qJb117Vz9qldJtR4AtnUV79tj0EE7Zf6clSXaFV1rjjZp+6E3hemYjzMicicHO
 /QONtKQUCAnWWpswjeIQEiFDlHtOm/OBjIASxIyxaWM2U8GyJ92Uzrtfd7dWgW6/umym
 6ls/n4BA8c7NjGHs5xNjxVQY9SunfXGVXX/+VjwninUUPjicVU8p0KHqMx11KoZ8vG77
 1J0hvpudbWfYeQRK7hXbcfMFt8krSkgIeqYuNW14BCp2iuK3c5f6XCCASk7Y3gG9hc2v
 eniA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687426460; x=1690018460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pzzr5pE6kWqzcd42lVxfWrDN6uelcbJs3SVe8LRJUoc=;
 b=bMRGBs3WFR9n4g1hO96Jo6E3545MLbV4pwcKbXaRFTAjfxi3XdX022vfdZmTojewIl
 ckqCqN88nBWB3ts/ATCV8sRYf6tBm5d+xqg2cLc+7Fh+iWAyaa7Ayx4KBgb1MP1K3cuy
 EDcJnnHaq7QLX423uLNIeYIvNJWrx4jnTELj3g0NW0A2/zKZAeNr+NSNCdoEmSsJcT1f
 BQeePb/+smJh740+MRvm7ZFxtVCommzN5P5pZLmwmqCR3YCDwsiX2mZIMytriR6PSpJf
 EDQn3Mw4gIYcR/9Q8PTW427gJq/2fVtC9XSdbFuF0VPN5VSagT5ewiZnv16yALUtS4kB
 /Yfg==
X-Gm-Message-State: AC+VfDy8nMM9WfzrGMQzJaufPXs0Z+Cf+WupQwKzlHOwTU6Xu2EwZxtl
 s0udKSP3uFYRyI+oRnsGnjDoRa68hBA=
X-Google-Smtp-Source: ACHHUZ6OVeIT63zBfxw7pXUmS2N9/geH0gnd5RbUpsOTVMVD63Bp096PJVS/YA+RF+TMgSe/EVMDdQ==
X-Received: by 2002:a17:903:234b:b0:1b5:42fe:5eac with SMTP id
 c11-20020a170903234b00b001b542fe5eacmr11298166plh.10.1687426460306; 
 Thu, 22 Jun 2023 02:34:20 -0700 (PDT)
Received: from wheely.local0.net (193-116-203-37.tpgi.com.au. [193.116.203.37])
 by smtp.gmail.com with ESMTPSA id
 x3-20020a1709027c0300b001ac2c3e54adsm4925662pll.118.2023.06.22.02.34.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 02:34:20 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 3/7] target/ppc: Add msgsnd/p and DPDES SMT support
Date: Thu, 22 Jun 2023 19:33:53 +1000
Message-Id: <20230622093357.255649-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622093357.255649-1-npiggin@gmail.com>
References: <20230622093357.255649-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x634.google.com
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

Doorbells in SMT need to coordinate msgsnd/msgclr and DPDES access from
multiple threads that affect the same state.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/ppc.c             |  6 ++++++
 include/hw/ppc/ppc.h     |  1 +
 target/ppc/excp_helper.c | 30 ++++++++++++++++++++++-----
 target/ppc/misc_helper.c | 44 ++++++++++++++++++++++++++++++++++------
 target/ppc/translate.c   |  8 ++++++++
 5 files changed, 78 insertions(+), 11 deletions(-)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 1b1220c423..82e4408c5c 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -1436,6 +1436,12 @@ int ppc_cpu_pir(PowerPCCPU *cpu)
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
index 7d45035447..d40eecb4c7 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -3187,22 +3187,42 @@ void helper_book3s_msgclrp(CPUPPCState *env, target_ulong rb)
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
+    /* Does iothread need to be locked for walking CPU list? */
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
+    g_assert_not_reached();
 }
 #endif /* TARGET_PPC64 */
 
diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index a058eb24cd..1f1af21f33 100644
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
+        ppc_set_irq(cpu, PPC_INTERRUPT_DOORBELL, val & 0x1);
         return;
     }
 
-    ppc_set_irq(cpu, PPC_INTERRUPT_DOORBELL, val & 0x1);
+    /* Does iothread need to be locked for walking CPU list? */
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
index 41a8b800bd..eb278c2683 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -815,11 +815,19 @@ void spr_write_pcr(DisasContext *ctx, int sprn, int gprn)
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


