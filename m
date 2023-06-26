Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 063AC73D77C
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 08:03:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDfFC-0004Sk-2i; Mon, 26 Jun 2023 01:58:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=U+Ap=CO=kaod.org=clg@ozlabs.org>)
 id 1qDfEj-0003w7-IG; Mon, 26 Jun 2023 01:58:10 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=U+Ap=CO=kaod.org=clg@ozlabs.org>)
 id 1qDfEh-0007cL-Fj; Mon, 26 Jun 2023 01:58:05 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QqHFP11Lsz4wb4;
 Mon, 26 Jun 2023 15:58:01 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QqHFL6Dh4z4wb3;
 Mon, 26 Jun 2023 15:57:58 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 22/30] target/ppc: Add support for SMT CTRL register
Date: Mon, 26 Jun 2023 07:56:39 +0200
Message-ID: <20230626055647.1147743-23-clg@kaod.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626055647.1147743-1-clg@kaod.org>
References: <20230626055647.1147743-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=U+Ap=CO=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

A relatively simple case to begin with, CTRL is a SMT shared register
where reads and writes need to synchronise against state changes by
other threads in the core.

Atomic serialisation operations are used to achieve this.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 target/ppc/helper.h      |  2 ++
 target/ppc/misc_helper.c | 25 +++++++++++++++++++++++++
 target/ppc/translate.c   | 18 +++++++++++++++++-
 3 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 38efbc351c69..fda40b8a60dd 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -704,6 +704,8 @@ DEF_HELPER_3(store_dcr, void, env, tl, tl)
 
 DEF_HELPER_2(load_dump_spr, void, env, i32)
 DEF_HELPER_2(store_dump_spr, void, env, i32)
+DEF_HELPER_3(spr_write_CTRL, void, env, i32, tl)
+
 DEF_HELPER_4(fscr_facility_check, void, env, i32, i32, i32)
 DEF_HELPER_4(msr_facility_check, void, env, i32, i32, i32)
 DEF_HELPER_FLAGS_1(load_tbl, TCG_CALL_NO_RWG, tl, env)
diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index 40ddc5c08c6a..a058eb24cdc0 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -43,6 +43,31 @@ void helper_store_dump_spr(CPUPPCState *env, uint32_t sprn)
              env->spr[sprn]);
 }
 
+void helper_spr_write_CTRL(CPUPPCState *env, uint32_t sprn,
+                           target_ulong val)
+{
+    CPUState *cs = env_cpu(env);
+    CPUState *ccs;
+    uint32_t run = val & 1;
+    uint32_t ts, ts_mask;
+
+    assert(sprn == SPR_CTRL);
+
+    env->spr[sprn] &= ~1U;
+    env->spr[sprn] |= run;
+
+    ts_mask = ~(1U << (8 + env->spr[SPR_TIR]));
+    ts = run << (8 + env->spr[SPR_TIR]);
+
+    THREAD_SIBLING_FOREACH(cs, ccs) {
+        CPUPPCState *cenv = &POWERPC_CPU(ccs)->env;
+
+        cenv->spr[sprn] &= ts_mask;
+        cenv->spr[sprn] |= ts;
+    }
+}
+
+
 #ifdef TARGET_PPC64
 static void raise_hv_fu_exception(CPUPPCState *env, uint32_t bit,
                                   const char *caller, uint32_t cause,
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 7d8877b3dcfd..c321a39027a3 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -438,7 +438,7 @@ void spr_write_generic32(DisasContext *ctx, int sprn, int gprn)
 #endif
 }
 
-void spr_write_CTRL(DisasContext *ctx, int sprn, int gprn)
+static void spr_write_CTRL_ST(DisasContext *ctx, int sprn, int gprn)
 {
     /* This does not implement >1 thread */
     TCGv t0 = tcg_temp_new();
@@ -447,6 +447,22 @@ void spr_write_CTRL(DisasContext *ctx, int sprn, int gprn)
     tcg_gen_shli_tl(t1, t0, 8); /* Duplicate the bit in TS */
     tcg_gen_or_tl(t1, t1, t0);
     gen_store_spr(sprn, t1);
+}
+
+void spr_write_CTRL(DisasContext *ctx, int sprn, int gprn)
+{
+    if (!(ctx->flags & POWERPC_FLAG_SMT)) {
+        spr_write_CTRL_ST(ctx, sprn, gprn);
+        goto out;
+    }
+
+    if (!gen_serialize(ctx)) {
+        return;
+    }
+
+    gen_helper_spr_write_CTRL(cpu_env, tcg_constant_i32(sprn),
+                              cpu_gpr[gprn]);
+out:
     spr_store_dump_spr(sprn);
 
     /*
-- 
2.41.0


