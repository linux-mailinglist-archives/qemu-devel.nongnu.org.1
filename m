Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4473F71731E
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 03:24:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4AYo-0004Uv-WD; Tue, 30 May 2023 21:23:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q4AYm-0004S0-Oh; Tue, 30 May 2023 21:23:32 -0400
Received: from mail-io1-xd2b.google.com ([2607:f8b0:4864:20::d2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q4AYl-0005Fk-3P; Tue, 30 May 2023 21:23:32 -0400
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-76c5db6a5cfso358985839f.2; 
 Tue, 30 May 2023 18:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685496209; x=1688088209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+zDOlRWUdwkqrj6xE/PQNHSscfk1SuhL8JkNfMoqHPQ=;
 b=AD1fNrAyNYabdEGqKTPJ4k4N9hOKKbedIddLqj1Iib1yYqMqLwptN6ERoG+YA4NkGF
 1fmdaf/GPzoeRClEiunT6SgGtWzXcgfX9/LleNy//rLCbYsZrktdeSkVJMYDOBLhQ+Nf
 M9/nur05NUAHxFyAyGzE2f/awyI+REBJYKZdR9LgLw/KlLkp4YMyDQJIS6XPEtU2aduy
 HQgX6qMJ6mchfUCzuoWqwFu/tewjaiKg3D9kC8GzLNrfBFO3U/KXSU3YBX9A/y3+lzZ9
 uGmDNMBy67yBdKOMnh1axZimG61Ko0xmz31ZbWKQ76rjGwXWVnJBLTDHRTlhzau+7L//
 jGSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685496209; x=1688088209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+zDOlRWUdwkqrj6xE/PQNHSscfk1SuhL8JkNfMoqHPQ=;
 b=MirzCkP4CMlSvpdcIWaP8i3ALLQXaRpW+lHrn3p9sFga1xdKMp4Yh1LzZfnqZ621u/
 93g0Qm9Ix1xTwzTgdoE8G2w06q1ryoyomMKT0KNxFyvKgfodZ/A00DtrYFEbw2/Wwmig
 l7R512iwrsXxXeFuIfBqtnVyJqGwt41vw/Zj2q91txksOnU+7pa+9x9+PO0VyC5OzM2q
 1WtWke2l62OO2eUp3yw4UapeY7XSlYgfRmlCtNLV5LcwbXDCZJLEbvgJazMGrzxEHS7n
 9hmFUWlysWUUpidxwEb4Z5pxfoOXMXHiFWEXhFEwGC/UQDI6mi1H+JTjyW+kl4SXBklM
 NPfA==
X-Gm-Message-State: AC+VfDweCZwkJTtCTtu+VOMs+uJoTZZItaqo6N6P2imuUKpFgx5pxZZg
 VtXB9Vu3cfo/uMPUqYxwc0+td0duiBI=
X-Google-Smtp-Source: ACHHUZ7GkcyqypQao3h351l2qDqg7xWs+YVMB075+M3ee96nltG7yP2hXb7b1lgr5umvX8yoyPio0A==
X-Received: by 2002:a92:d44d:0:b0:33a:ff76:33b8 with SMTP id
 r13-20020a92d44d000000b0033aff7633b8mr941039ilm.9.1685496208986; 
 Tue, 30 May 2023 18:23:28 -0700 (PDT)
Received: from wheely.local0.net ([203.221.142.9])
 by smtp.gmail.com with ESMTPSA id
 9-20020a170902c10900b00186a2274382sm10928840pli.76.2023.05.30.18.23.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 18:23:28 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [RFC PATCH 2/5] target/ppc: Add initial flags and helpers for SMT
 support
Date: Wed, 31 May 2023 11:23:10 +1000
Message-Id: <20230531012313.19891-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531012313.19891-1-npiggin@gmail.com>
References: <20230531012313.19891-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2b;
 envelope-from=npiggin@gmail.com; helo=mail-io1-xd2b.google.com
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


