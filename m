Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04AD37F6C6E
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 07:42:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6PtL-0003XO-Rf; Fri, 24 Nov 2023 01:42:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r6Pss-0002yK-3H; Fri, 24 Nov 2023 01:41:50 -0500
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r6Psq-0006I3-6H; Fri, 24 Nov 2023 01:41:49 -0500
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-1eb6c559ab4so981281fac.0; 
 Thu, 23 Nov 2023 22:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700808106; x=1701412906; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/YjF11udA/3aBuPx0YbpetB55ddjbtjBqWNhoZ4uvqU=;
 b=GrTfcB/OONzHCYtzscJbsrEo6A9GAYvQd1zRV/WVTR7wxFi++VCRPbgdcErL1K2mnw
 YMpmwk52/IKKPOXwaVYmyTIwb6FzF+kd/xdOY4HzKQm8mcNP55xccn0xPG/eeiKku1U7
 lmtvq+RoxyKHgElO3AMvdaY2tteTUiIw6vWZxcSSLrlgmhGomV05K+0ZcFEveWAoU60s
 aakt+0HXTu4HVXU3tliYlOqPyUuQTFhSpeB26NssLbPQKZkMM2E054MoeejUXoc1BlsS
 r2oY/es8lo3FgKlJmbTZaDGLp5+YxOajvqf0yR9YAru6X1egb11ImbYQWCg3SrY39p/J
 fFJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700808106; x=1701412906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/YjF11udA/3aBuPx0YbpetB55ddjbtjBqWNhoZ4uvqU=;
 b=uOBkLWVqK1TEj9Ftdr9hJcTVIvtnBWfM9NMserCqWjN00PURABCCq1y2Q3TlNvCIKl
 Sr2A9VTpreT4X5MpWvLHXPmGT1m+rhbUL+qd8L18PZJrgLzuHJwEvFWiFaJXxjFbRxa5
 1yZJBvl0V4kX1d4B6MqlTs06pp2KYOhx3DNvCslR5M4gfOtLM0E2FMG7o90iII+jH5Cx
 APFSl20t51E9NC/KKsyv+RYbTU/7Ui0yK9l7JGLzDcxbZuzJcW4p9q4+P6wK8XK8v2C3
 BN16rQ/Z+uTVB6qq2X8XxCPEewaLcEgDoJvIenuK21YZxHRwM28DMfP0vofluDgMgV/y
 xWdw==
X-Gm-Message-State: AOJu0YxbLBkj+jXTG51W0qpCUHRa60SRdhSTQVegRrgHWfBrHG8X0iOB
 jQ+PL17RwZNbIN+EquTvg2W8AJcBWtGAgA==
X-Google-Smtp-Source: AGHT+IGPAJMFDtpJJRpuPNmAR6Uak5Asj8a5xFfjhUTKcrN7ulmchxIyFvINkUDpbMQVapJh6epa+g==
X-Received: by 2002:a05:6870:7812:b0:1ea:85b6:99e4 with SMTP id
 hb18-20020a056870781200b001ea85b699e4mr2327440oab.13.1700808106397; 
 Thu, 23 Nov 2023 22:41:46 -0800 (PST)
Received: from wheely.local0.net ([1.145.239.154])
 by smtp.gmail.com with ESMTPSA id
 y9-20020a62f249000000b006cb8a8a4bbfsm2152013pfl.186.2023.11.23.22.41.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Nov 2023 22:41:45 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 7/7] target/ppc: Add SMT support to time facilities
Date: Fri, 24 Nov 2023 16:40:01 +1000
Message-ID: <20231124064001.198572-8-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231124064001.198572-1-npiggin@gmail.com>
References: <20231124064001.198572-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=npiggin@gmail.com; helo=mail-oa1-x2c.google.com
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

The TB, VTB, PURR, HDEC SPRs are per-LPAR registers, and the TFMR is a
per-core register. Add the necessary SMT helpers.

The TFMR can only drive the timebase state machine via thread 0 of the
core, which is almost certainly not right, but it is enough for skiboot
and other proprietary firmware.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/timebase_helper.c | 105 ++++++++++++++++++++++++++++++++---
 target/ppc/translate.c       |  42 +++++++++++++-
 2 files changed, 136 insertions(+), 11 deletions(-)

diff --git a/target/ppc/timebase_helper.c b/target/ppc/timebase_helper.c
index 9c77736e77..c3fc194b1e 100644
--- a/target/ppc/timebase_helper.c
+++ b/target/ppc/timebase_helper.c
@@ -60,19 +60,55 @@ target_ulong helper_load_purr(CPUPPCState *env)
 
 void helper_store_purr(CPUPPCState *env, target_ulong val)
 {
-    cpu_ppc_store_purr(env, val);
+    CPUState *cs = env_cpu(env);
+    CPUState *ccs;
+    uint32_t nr_threads = cs->nr_threads;
+
+    if (nr_threads == 1 || !(env->flags & POWERPC_FLAG_SMT_1LPAR)) {
+        cpu_ppc_store_purr(env, val);
+        return;
+    }
+
+    THREAD_SIBLING_FOREACH(cs, ccs) {
+        CPUPPCState *cenv = &POWERPC_CPU(ccs)->env;
+        cpu_ppc_store_purr(cenv, val);
+    }
 }
 #endif
 
 #if !defined(CONFIG_USER_ONLY)
 void helper_store_tbl(CPUPPCState *env, target_ulong val)
 {
-    cpu_ppc_store_tbl(env, val);
+    CPUState *cs = env_cpu(env);
+    CPUState *ccs;
+    uint32_t nr_threads = cs->nr_threads;
+
+    if (nr_threads == 1 || !(env->flags & POWERPC_FLAG_SMT_1LPAR)) {
+        cpu_ppc_store_tbl(env, val);
+        return;
+    }
+
+    THREAD_SIBLING_FOREACH(cs, ccs) {
+        CPUPPCState *cenv = &POWERPC_CPU(ccs)->env;
+        cpu_ppc_store_tbl(cenv, val);
+    }
 }
 
 void helper_store_tbu(CPUPPCState *env, target_ulong val)
 {
-    cpu_ppc_store_tbu(env, val);
+    CPUState *cs = env_cpu(env);
+    CPUState *ccs;
+    uint32_t nr_threads = cs->nr_threads;
+
+    if (nr_threads == 1 || !(env->flags & POWERPC_FLAG_SMT_1LPAR)) {
+        cpu_ppc_store_tbu(env, val);
+        return;
+    }
+
+    THREAD_SIBLING_FOREACH(cs, ccs) {
+        CPUPPCState *cenv = &POWERPC_CPU(ccs)->env;
+        cpu_ppc_store_tbu(cenv, val);
+    }
 }
 
 void helper_store_atbl(CPUPPCState *env, target_ulong val)
@@ -102,17 +138,53 @@ target_ulong helper_load_hdecr(CPUPPCState *env)
 
 void helper_store_hdecr(CPUPPCState *env, target_ulong val)
 {
-    cpu_ppc_store_hdecr(env, val);
+    CPUState *cs = env_cpu(env);
+    CPUState *ccs;
+    uint32_t nr_threads = cs->nr_threads;
+
+    if (nr_threads == 1 || !(env->flags & POWERPC_FLAG_SMT_1LPAR)) {
+        cpu_ppc_store_hdecr(env, val);
+        return;
+    }
+
+    THREAD_SIBLING_FOREACH(cs, ccs) {
+        CPUPPCState *cenv = &POWERPC_CPU(ccs)->env;
+        cpu_ppc_store_hdecr(cenv, val);
+    }
 }
 
 void helper_store_vtb(CPUPPCState *env, target_ulong val)
 {
-    cpu_ppc_store_vtb(env, val);
+    CPUState *cs = env_cpu(env);
+    CPUState *ccs;
+    uint32_t nr_threads = cs->nr_threads;
+
+    if (nr_threads == 1 || !(env->flags & POWERPC_FLAG_SMT_1LPAR)) {
+        cpu_ppc_store_vtb(env, val);
+        return;
+    }
+
+    THREAD_SIBLING_FOREACH(cs, ccs) {
+        CPUPPCState *cenv = &POWERPC_CPU(ccs)->env;
+        cpu_ppc_store_vtb(cenv, val);
+    }
 }
 
 void helper_store_tbu40(CPUPPCState *env, target_ulong val)
 {
-    cpu_ppc_store_tbu40(env, val);
+    CPUState *cs = env_cpu(env);
+    CPUState *ccs;
+    uint32_t nr_threads = cs->nr_threads;
+
+    if (nr_threads == 1 || !(env->flags & POWERPC_FLAG_SMT_1LPAR)) {
+        cpu_ppc_store_tbu40(env, val);
+        return;
+    }
+
+    THREAD_SIBLING_FOREACH(cs, ccs) {
+        CPUPPCState *cenv = &POWERPC_CPU(ccs)->env;
+        cpu_ppc_store_tbu40(cenv, val);
+    }
 }
 
 target_ulong helper_load_40x_pit(CPUPPCState *env)
@@ -211,6 +283,21 @@ static uint64_t tfmr_new_tb_state(uint64_t tfmr, unsigned int tbst)
     return tfmr;
 }
 
+static void write_tfmr(CPUPPCState *env, target_ulong val)
+{
+    CPUState *cs = env_cpu(env);
+
+    if (cs->nr_threads == 1) {
+        env->spr[SPR_TFMR] = val;
+    } else {
+        CPUState *ccs;
+        THREAD_SIBLING_FOREACH(cs, ccs) {
+            CPUPPCState *cenv = &POWERPC_CPU(ccs)->env;
+            cenv->spr[SPR_TFMR] = val;
+        }
+    }
+}
+
 static void tb_state_machine_step(CPUPPCState *env)
 {
     uint64_t tfmr = env->spr[SPR_TFMR];
@@ -224,7 +311,7 @@ static void tb_state_machine_step(CPUPPCState *env)
         env->tb_sync_pulse_timer--;
     } else {
         tfmr |= TFMR_TB_SYNC_OCCURED;
-        env->spr[SPR_TFMR] = tfmr;
+        write_tfmr(env, tfmr);
     }
 
     if (env->tb_state_timer) {
@@ -262,7 +349,7 @@ static void tb_state_machine_step(CPUPPCState *env)
         }
     }
 
-    env->spr[SPR_TFMR] = tfmr;
+    write_tfmr(env, tfmr);
 }
 
 target_ulong helper_load_tfmr(CPUPPCState *env)
@@ -357,7 +444,7 @@ void helper_store_tfmr(CPUPPCState *env, target_ulong val)
     }
 
 out:
-    env->spr[SPR_TFMR] = tfmr;
+    write_tfmr(env, tfmr);
 }
 #endif
 
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 329da4d518..bd103b1026 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -247,13 +247,24 @@ static inline bool gen_serialize(DisasContext *ctx)
     return true;
 }
 
-#if defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY)
+#if !defined(CONFIG_USER_ONLY)
+#if defined(TARGET_PPC64)
+static inline bool gen_serialize_core(DisasContext *ctx)
+{
+    if (ctx->flags & POWERPC_FLAG_SMT) {
+        return gen_serialize(ctx);
+    }
+    return true;
+}
+#endif
+
 static inline bool gen_serialize_core_lpar(DisasContext *ctx)
 {
+#if defined(TARGET_PPC64)
     if (ctx->flags & POWERPC_FLAG_SMT_1LPAR) {
         return gen_serialize(ctx);
     }
-
+#endif
     return true;
 }
 #endif
@@ -667,12 +678,20 @@ void spr_read_atbu(DisasContext *ctx, int gprn, int sprn)
 #if !defined(CONFIG_USER_ONLY)
 void spr_write_tbl(DisasContext *ctx, int sprn, int gprn)
 {
+    if (!gen_serialize_core_lpar(ctx)) {
+        return;
+    }
+
     translator_io_start(&ctx->base);
     gen_helper_store_tbl(tcg_env, cpu_gpr[gprn]);
 }
 
 void spr_write_tbu(DisasContext *ctx, int sprn, int gprn)
 {
+    if (!gen_serialize_core_lpar(ctx)) {
+        return;
+    }
+
     translator_io_start(&ctx->base);
     gen_helper_store_tbu(tcg_env, cpu_gpr[gprn]);
 }
@@ -696,6 +715,9 @@ void spr_read_purr(DisasContext *ctx, int gprn, int sprn)
 
 void spr_write_purr(DisasContext *ctx, int sprn, int gprn)
 {
+    if (!gen_serialize_core_lpar(ctx)) {
+        return;
+    }
     translator_io_start(&ctx->base);
     gen_helper_store_purr(tcg_env, cpu_gpr[gprn]);
 }
@@ -709,6 +731,9 @@ void spr_read_hdecr(DisasContext *ctx, int gprn, int sprn)
 
 void spr_write_hdecr(DisasContext *ctx, int sprn, int gprn)
 {
+    if (!gen_serialize_core_lpar(ctx)) {
+        return;
+    }
     translator_io_start(&ctx->base);
     gen_helper_store_hdecr(tcg_env, cpu_gpr[gprn]);
 }
@@ -721,12 +746,18 @@ void spr_read_vtb(DisasContext *ctx, int gprn, int sprn)
 
 void spr_write_vtb(DisasContext *ctx, int sprn, int gprn)
 {
+    if (!gen_serialize_core_lpar(ctx)) {
+        return;
+    }
     translator_io_start(&ctx->base);
     gen_helper_store_vtb(tcg_env, cpu_gpr[gprn]);
 }
 
 void spr_write_tbu40(DisasContext *ctx, int sprn, int gprn)
 {
+    if (!gen_serialize_core_lpar(ctx)) {
+        return;
+    }
     translator_io_start(&ctx->base);
     gen_helper_store_tbu40(tcg_env, cpu_gpr[gprn]);
 }
@@ -1220,11 +1251,18 @@ void spr_write_hmer(DisasContext *ctx, int sprn, int gprn)
 
 void spr_read_tfmr(DisasContext *ctx, int gprn, int sprn)
 {
+    /* Reading TFMR can cause it to be updated, so serialize threads here too */
+    if (!gen_serialize_core(ctx)) {
+        return;
+    }
     gen_helper_load_tfmr(cpu_gpr[gprn], tcg_env);
 }
 
 void spr_write_tfmr(DisasContext *ctx, int sprn, int gprn)
 {
+    if (!gen_serialize_core(ctx)) {
+        return;
+    }
     gen_helper_store_tfmr(tcg_env, cpu_gpr[gprn]);
 }
 
-- 
2.42.0


