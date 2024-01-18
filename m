Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3848B831C05
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 16:08:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQTzt-0008PY-VP; Thu, 18 Jan 2024 10:08:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQTzr-0008Gf-Mg; Thu, 18 Jan 2024 10:07:59 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQTzp-00086C-Nm; Thu, 18 Jan 2024 10:07:59 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1d714e224e0so1993745ad.2; 
 Thu, 18 Jan 2024 07:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705590476; x=1706195276; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SQp5iO5TuP/qzTnCoGfV4NpOSuzwesLwzfWL0gOHg2w=;
 b=KNaRoBG3+FS/4wR9OYAm6ohCN0OL8C8imV+8rCxMuJ6MRSDmABZfZFgHM+gOLMVcjl
 DY7w7x9Bs04YZTPFz6giU3h4UOShHmuH4KywxqSFAIJhH/G8DPnbMP8uKl5sPcbo706q
 mvEm7e2y+A0r5alYNUcR4wOLMynTRwOp9SSlov/bg05OECGXTuzhtspPTgXTmcxV/iB2
 epPBYCN0Nd8ViWbUZztYAka2aQJsQvxb/ZXE1oUsUSyS1XyV3SEDmHwlSntGsOmxvyh+
 RcMsBIOmloGRPi2ke32Xjxtsbdd2Qm3n/kbbWDSeJWQx96Xggt30h4ToF//569VItoL8
 c03Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705590476; x=1706195276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SQp5iO5TuP/qzTnCoGfV4NpOSuzwesLwzfWL0gOHg2w=;
 b=G2A22HEGuGcmSQcb2zumw9H6BhP5fhD22IM3z37/h7VkFRH/zGD3tU7lbX5n4veUbs
 5f+MWhk33jAcOQ8NFQr3EM4Sn+h635kf1Yuaq6h1aT33UlvIpH6c/SCAb7llNVcBMYkl
 H6B5gWyHH42/yj+WDdQdO7uIEcEY44Ybwe9LPABVtry2lh8HF7fWHLvwjuouwyu0u/jD
 GipucY29I36OG4pI2zRGEWo2hQ2hhNxglfPJ5KWgpRzib3Rfbv0QDbbxn5nUdBaQqSts
 PjKkNkVTtxE/3MIKE8zXs4AnNOlV0tP3ol1+i+K1JJHMrNkUOSwOepNP9a3WjSi6DPlD
 ptaA==
X-Gm-Message-State: AOJu0Ywa7wOQpBH0U+7rn9U2Gvx6d+RnRNWuusS38a8QtOKIf64GhzUX
 PxP/th5oqI8uc21VkP0KvMkW/lGTMSKdKkoEDNqLQejzrl1MiCD43aWl8XXF
X-Google-Smtp-Source: AGHT+IEn0PoCPnD8+v7DO6/sdrFLFjITcRFasTt2AIRPtvJLyhdEY5Lvm54tTDxU65Vny7NVNeRMSQ==
X-Received: by 2002:a17:902:6b41:b0:1d5:78bd:af9e with SMTP id
 g1-20020a1709026b4100b001d578bdaf9emr1094854plt.116.1705590475743; 
 Thu, 18 Jan 2024 07:07:55 -0800 (PST)
Received: from wheely.local0.net (124-171-76-150.tpgi.com.au. [124.171.76.150])
 by smtp.gmail.com with ESMTPSA id
 e17-20020a170902cf5100b001d052d1aaf2sm1509401plg.101.2024.01.18.07.07.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 07:07:55 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH 13/26] target/ppc: Add SMT support to time facilities
Date: Fri, 19 Jan 2024 01:06:31 +1000
Message-ID: <20240118150644.177371-14-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240118150644.177371-1-npiggin@gmail.com>
References: <20240118150644.177371-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x630.google.com
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
per-core register. Add the necessary SMT synchronisation and value
sharing.

The TFMR can only drive the timebase state machine via thread 0 of the
core, which is almost certainly not right, but it is enough for skiboot
and certain other proprietary firmware.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/timebase_helper.c | 105 ++++++++++++++++++++++++++++++++---
 target/ppc/translate.c       |  42 +++++++++++++-
 2 files changed, 136 insertions(+), 11 deletions(-)

diff --git a/target/ppc/timebase_helper.c b/target/ppc/timebase_helper.c
index b8b9afe0b6..39d397416e 100644
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
         env->pnv_tod_tbst.tb_sync_pulse_timer--;
     } else {
         tfmr |= TFMR_TB_SYNC_OCCURED;
-        env->spr[SPR_TFMR] = tfmr;
+        write_tfmr(env, tfmr);
     }
 
     if (env->pnv_tod_tbst.tb_state_timer) {
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


