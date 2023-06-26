Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E9A73D785
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 08:05:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDfFY-0005my-7P; Mon, 26 Jun 2023 01:58:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=U+Ap=CO=kaod.org=clg@ozlabs.org>)
 id 1qDfEh-0003mA-B1; Mon, 26 Jun 2023 01:58:05 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=U+Ap=CO=kaod.org=clg@ozlabs.org>)
 id 1qDfEe-0007bq-Vi; Mon, 26 Jun 2023 01:58:02 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QqHFL2DJjz4wb5;
 Mon, 26 Jun 2023 15:57:58 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QqHFJ0Pzkz4wb3;
 Mon, 26 Jun 2023 15:57:55 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 21/30] target/ppc: Add initial flags and helpers for SMT support
Date: Mon, 26 Jun 2023 07:56:38 +0200
Message-ID: <20230626055647.1147743-22-clg@kaod.org>
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

TGC SMT emulation needs to know whether it is running with SMT siblings,
to be able to iterate over siblings in a core, and to serialise
threads to access per-core shared SPRs. Add infrastructure to do these
things.

For now the sibling iteration and serialisation are implemented in a
simple but inefficient way. SMT shared state and sibling access is not
too common, and SMT configurations are mainly useful to test system
code, so performance is not to critical.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
[ clg: fix build breakage with clang ]
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 target/ppc/cpu.h       |  9 +++++++++
 target/ppc/cpu_init.c  |  5 +++++
 target/ppc/translate.c | 22 ++++++++++++++++++++++
 3 files changed, 36 insertions(+)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 054edf3c8014..4138a2580109 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -672,6 +672,8 @@ enum {
     POWERPC_FLAG_TM       = 0x00100000,
     /* Has SCV (ISA 3.00)                                                    */
     POWERPC_FLAG_SCV      = 0x00200000,
+    /* Has >1 thread per core                                                */
+    POWERPC_FLAG_SMT      = 0x00400000,
 };
 
 /*
@@ -1268,6 +1270,13 @@ struct CPUArchState {
     uint64_t pmu_base_time;
 };
 
+#define _CORE_ID(cs)                                            \
+    (POWERPC_CPU(cs)->env.spr_cb[SPR_PIR].default_value & ~(cs->nr_threads - 1))
+
+#define THREAD_SIBLING_FOREACH(cs, cs_sibling)                  \
+    CPU_FOREACH(cs_sibling)                                     \
+        if (_CORE_ID(cs) == _CORE_ID(cs_sibling))
+
 #define SET_FIT_PERIOD(a_, b_, c_, d_)          \
 do {                                            \
     env->fit_period[0] = (a_);                  \
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index dccc06405381..aeff71d063d2 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -6755,6 +6755,7 @@ static void ppc_cpu_realize(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
     PowerPCCPU *cpu = POWERPC_CPU(dev);
+    CPUPPCState *env = &cpu->env;
     PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
     Error *local_err = NULL;
 
@@ -6786,6 +6787,10 @@ static void ppc_cpu_realize(DeviceState *dev, Error **errp)
 
     pcc->parent_realize(dev, errp);
 
+    if (env_cpu(env)->nr_threads > 1) {
+        env->flags |= POWERPC_FLAG_SMT;
+    }
+
     return;
 
 unrealize:
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 8f74a864e48e..7d8877b3dcfd 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -234,6 +234,28 @@ struct opc_handler_t {
     void (*handler)(DisasContext *ctx);
 };
 
+static inline bool gen_serialize(DisasContext *ctx)
+{
+    if (tb_cflags(ctx->base.tb) & CF_PARALLEL) {
+        /* Restart with exclusive lock.  */
+        gen_helper_exit_atomic(cpu_env);
+        ctx->base.is_jmp = DISAS_NORETURN;
+        return false;
+    }
+    return true;
+}
+
+#if defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY)
+static inline bool gen_serialize_core(DisasContext *ctx)
+{
+    if (ctx->flags & POWERPC_FLAG_SMT) {
+        return gen_serialize(ctx);
+    }
+
+    return true;
+}
+#endif
+
 /* SPR load/store helpers */
 static inline void gen_load_spr(TCGv t, int reg)
 {
-- 
2.41.0


