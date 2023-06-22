Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE269739D7B
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 11:35:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCGho-0000kI-Qs; Thu, 22 Jun 2023 05:34:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qCGhk-0000j0-DA; Thu, 22 Jun 2023 05:34:16 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qCGhi-00038c-Jq; Thu, 22 Jun 2023 05:34:16 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-54290603887so3642806a12.1; 
 Thu, 22 Jun 2023 02:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687426451; x=1690018451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DUzAvb05rmxtCAL6bjqWGB7J65IhvgQ/bEM5BESrV2Q=;
 b=qaK9ErjwzJqPC2KvjIeTKSP8EY3KjxCYTYzcBh8CFO2ngKz2WSSPOKjNNoy+dvGHCA
 6qGohGZoBZcdRwqpBWtMCwCov8RXNR7Wxh60lAw7/cY1w5y/nBbnwyZ0iyHjanGJ4nn1
 AVpb3K5wZ92zubxRq+DcU81/XRSWhbeGHBHXuRjE0HJ/yw4+HmxoleDsWuVC0nWyLTzE
 +IBB9yjZFZpOgPzf3+4Yfsl5+2TQ9slq6cQNtG0se73w7qzbVyRtjqieixC80eI+5pLM
 Qh0AErgsFVvGzvb2rVYgHkTIrzDWGSKTX48OIAUtKwNOS4HGjv3Us4/NsmfHdjTivPUz
 ftNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687426451; x=1690018451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DUzAvb05rmxtCAL6bjqWGB7J65IhvgQ/bEM5BESrV2Q=;
 b=kSyHWChbA8iUKD1gZr8OxbWiGC5DSZ5R9K+FWXoCfySuAFfi1x/XY2RFWi5JefbgtB
 TAAx8tqeme1zy/IE//5PcDGe+NThUrKNLvUEjuz+WdlwEeI4Rw2pZwoUSLzrA5YMhIGS
 xRHS4/p8lOsofqMGYUnYkIixQ0esxasT9CvTUmJGBsuOzw49VwLa+hphpQyw6333B13A
 dacRQf4cPof7CXyyEXD5j6OqlhBRx2CBKlqTykQPFRYj1kG2xHDqS7GwStlKsgLR7Ap9
 SILkwrNO6Z4PDZtmSb0dEU4YWYYajuxK9QWC8IMHe4eQDBSyVnKIs6yzVKXVePyZT0Fv
 FmMA==
X-Gm-Message-State: AC+VfDwOhAhVtjx65YssQdVRfp/C4unwdkGxIfIkTZ03HMstuQnB5N6k
 ZASNvkY86WOKTrZW8E+rJh1AiEIQrhI=
X-Google-Smtp-Source: ACHHUZ5YKyFe4kI/iUUt8av0btAd4FDK0ayVcNe1+PYi4jYDuudozQtiA2oZZfj1qrOZQ6XX7klH7g==
X-Received: by 2002:a05:6a21:585:b0:116:e7d9:8df0 with SMTP id
 lw5-20020a056a21058500b00116e7d98df0mr6256906pzb.51.1687426451391; 
 Thu, 22 Jun 2023 02:34:11 -0700 (PDT)
Received: from wheely.local0.net (193-116-203-37.tpgi.com.au. [193.116.203.37])
 by smtp.gmail.com with ESMTPSA id
 x3-20020a1709027c0300b001ac2c3e54adsm4925662pll.118.2023.06.22.02.34.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 02:34:11 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/7] target/ppc: Add initial flags and helpers for SMT
 support
Date: Thu, 22 Jun 2023 19:33:51 +1000
Message-Id: <20230622093357.255649-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622093357.255649-1-npiggin@gmail.com>
References: <20230622093357.255649-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x533.google.com
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

TGC SMT emulation needs to know whether it is running with SMT siblings,
to be able to iterate over siblings in a core, and to serialise
threads to access per-core shared SPRs. Add infrastructure to do these
things.

For now the sibling iteration and serialisation are implemented in a
simple but inefficient way. SMT shared state and sibling access is not
too common, and SMT configurations are mainly useful to test system
code, so performance is not to critical.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu.h       |  9 +++++++++
 target/ppc/cpu_init.c  |  5 +++++
 target/ppc/translate.c | 20 ++++++++++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index bfa1777289..0087ce66e2 100644
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
@@ -1270,6 +1272,13 @@ struct CPUArchState {
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
index dccc064053..aeff71d063 100644
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
index b62b624682..5d585393c5 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -236,6 +236,26 @@ struct opc_handler_t {
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


