Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA5072247B
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 13:25:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q68JS-00077i-I7; Mon, 05 Jun 2023 07:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q68JO-00076I-4e; Mon, 05 Jun 2023 07:23:46 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q68JL-00066C-DE; Mon, 05 Jun 2023 07:23:44 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-256e1d87998so3973032a91.3; 
 Mon, 05 Jun 2023 04:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685964221; x=1688556221;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+zDOlRWUdwkqrj6xE/PQNHSscfk1SuhL8JkNfMoqHPQ=;
 b=dDS90VQbe5z1sDPlE3P1VypZVuMaIXbJ71oKxd15e10+BiTHkAF4es4bDyfH0pncT/
 M/xF6VcfWqhBV6BmT0KYxQrDJj+XGnL7SnnDpayWhWy5wwXQNHBRnD8y/X6NnYdYBHAe
 tF1rMxlBKA5yPqLvNKsXHMkoF6Pwcg8MuI1/3fL/3ZCqVusHX/AfocF1xWZxvHZinCUm
 /tGcxTch2aXNDfq15G9kmMwFfCw5WBSf27gOJIzKkGA7EXwDjukyHy7twgub/N8R46Qx
 EKw6UUuubvMLGtduu+qnrda4cIvFqDtCcoLmbvxOr8EKNujftfgoEwfOkUr0aDQL2Txs
 PEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685964221; x=1688556221;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+zDOlRWUdwkqrj6xE/PQNHSscfk1SuhL8JkNfMoqHPQ=;
 b=RLXpcQ5UDvR8x7S236NiTvmfW186NFFczm3PcrNAos+8Qcl4VrfaHDIRn4Vkv8xp9r
 /DrupX3JQOiGGNN/4YqD+byvNLJm/+YcmmKhP0dRl2LLLUIu8QjKUjhGenhTZlXd8Mbu
 u/i6eoI5QRnMgJ3yxjPHUvHnfexRWioKn8c3d/3jdG8JFPuTGclT4LI4j7EWce4Hs0pp
 g/vLLHMwSi9PY542JrQlroc9eBmkDKgv2i52VIpkMrosZUYEylAHhGAI8aJcAUggC+eS
 XDGZ8DfMsSrnLa/Ikie4wNBmUOIAtxQpN2OuEtlzjlopN20AcVjttZTPqfjZBNShUZGe
 JE3A==
X-Gm-Message-State: AC+VfDwx4WK+QsGcL4OZCxcci9daeESeotGxasmVkmEKa0pFqN/pQHsE
 ArrvgtMp50ZWuhKw+LPRyDNBhKSoric=
X-Google-Smtp-Source: ACHHUZ6nyUllZqAE/zWlV9LbDxp4/kLr5mvQy6hTzqxC8hsXQ+W4ON6Vxlb1P7MkZC5fdSFNPchhhg==
X-Received: by 2002:a17:90a:11:b0:255:d878:704a with SMTP id
 17-20020a17090a001100b00255d878704amr7315091pja.4.1685964221397; 
 Mon, 05 Jun 2023 04:23:41 -0700 (PDT)
Received: from wheely.local0.net ([203.221.142.9])
 by smtp.gmail.com with ESMTPSA id
 f32-20020a17090a702300b0024e026444b6sm15953385pjk.2.2023.06.05.04.23.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 04:23:40 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH 1/4] target/ppc: Add initial flags and helpers for SMT support
Date: Mon,  5 Jun 2023 21:23:20 +1000
Message-Id: <20230605112323.179259-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230605112323.179259-1-npiggin@gmail.com>
References: <20230605112323.179259-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1034.google.com
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

SMT TCG emulation needs to be able to iterate over siblings in a core,
and needs to serialise core access to shared SPRs and state.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu.h       |  9 +++++++++
 target/ppc/cpu_init.c  |  5 +++++
 target/ppc/translate.c | 20 ++++++++++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 1f23b81e90..b594408a8d 100644
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
@@ -1266,6 +1268,13 @@ struct CPUArchState {
     uint64_t pmu_base_time;
 };
 
+#define _CORE_ID(cs)                                            \
+    (POWERPC_CPU(cs)->env.spr_cb[SPR_PIR].default_value & ~(cs->nr_threads - 1))
+
+#define THREAD_SIBLING_FOREACH(cs, cs_sibling)			\
+    CPU_FOREACH(cs_sibling)                                     \
+        if (_CORE_ID(cs) == _CORE_ID(cs_sibling))
+
 #define SET_FIT_PERIOD(a_, b_, c_, d_)          \
 do {                                            \
     env->fit_period[0] = (a_);                  \
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index aa364f36f6..5035f6dada 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -6754,6 +6754,7 @@ static void ppc_cpu_realize(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
     PowerPCCPU *cpu = POWERPC_CPU(dev);
+    CPUPPCState *env = &cpu->env;
     PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
     Error *local_err = NULL;
 
@@ -6785,6 +6786,10 @@ static void ppc_cpu_realize(DeviceState *dev, Error **errp)
 
     pcc->parent_realize(dev, errp);
 
+    if (env_cpu(env)->nr_threads > 1) {
+        env->flags |= POWERPC_FLAG_SMT;
+    }
+
     return;
 
 unrealize:
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index b6bab4c234..72270c2163 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -227,6 +227,26 @@ struct opc_handler_t {
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
+static inline bool gen_serialize_core(DisasContext *ctx)
+{
+    if (ctx->flags & POWERPC_FLAG_SMT) {
+        return gen_serialize(ctx);
+    }
+
+    return true;
+}
+
 /* SPR load/store helpers */
 static inline void gen_load_spr(TCGv t, int reg)
 {
-- 
2.40.1


