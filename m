Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 589A272ABD1
	for <lists+qemu-devel@lfdr.de>; Sat, 10 Jun 2023 15:40:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7yi5-0005CJ-RZ; Sat, 10 Jun 2023 09:32:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q7yi4-0005BK-G4; Sat, 10 Jun 2023 09:32:52 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q7yi2-0007jN-TE; Sat, 10 Jun 2023 09:32:52 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-39c77cf32deso1164280b6e.0; 
 Sat, 10 Jun 2023 06:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686403969; x=1688995969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+To2/YJ6TCkaBB4yMFK0NMzrQ35wgpmINRBjFlxrk0M=;
 b=AXs/MSArX0Z3XqgXlulhjDnEE6B9SaJWBqKde18TvdvA6g1IP/gynahoEF3taBUwPy
 O2kss7NH7yDswWOHeVtxkin5xo3Zb/WDMQXCh5Hq6Ub5Is/hQtst3Px7Q/tbIk3BlVlG
 bJfbN3RUfCaZO2c42QG+76ME9oOMNQqOoWtv1cADv+SazBeDq9IvedVMQIekUtyll0sk
 2px6bUVlpOVAaeI+i986ahMeEzU6ucnxr7VhTcpdeoDk+7hyGk4LVuABmlMdMt8TxR6y
 NV1JEtRT4BHQ4rs/6m0Ag3qg0JrkG2NbuGGHf87KZx/33SEABg+MbbMRCalW64RKf002
 21NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686403969; x=1688995969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+To2/YJ6TCkaBB4yMFK0NMzrQ35wgpmINRBjFlxrk0M=;
 b=dxUVHVrEhiHyTLEBna8WNcMUXkt06z+WrGMYSyNqxMEKEELX/1/NJEAnBujEAj10UA
 7tpATK9IVxqHH+hXxm96L6mY3PoCvvXf74RxbFn3phQKaMle5SZdY3B1rzfIMwzsdGq7
 6Oqw4gNN9dl6JtIaC2U/OzomEsppr4ejZcKdVoaz/yHHbFmz5D38Zku74rIoIHidswDU
 1NckCOBXeK0kW6Mg77j2kLKXxakQNukPDVje5VIGY6UPf3Y6+n21bHEAoPrp866Na1Qb
 p3ylr7RhevriwEcUHwg/jOD2zuAcQtF6KI25V0Qzzx7WYrkhPeH97Z5gE2XwG4KN6/rN
 wK4A==
X-Gm-Message-State: AC+VfDzIJBk5asxs69nEHAzkthjTqZKok85Z1jsiHhGad+xqpBSC8k87
 3pwljB4VeyVwFGw/WFVVOPUHn3WE/64=
X-Google-Smtp-Source: ACHHUZ5HyvTOdbAaxslG8tKjEkOGN5RfMVwWoxEqOs8YTEXyCPnq9ZIDosrkuRyGVWS57Z35J/Ibmw==
X-Received: by 2002:a05:6808:220c:b0:39a:98bc:10e8 with SMTP id
 bd12-20020a056808220c00b0039a98bc10e8mr752420oib.28.1686403969383; 
 Sat, 10 Jun 2023 06:32:49 -0700 (PDT)
Received: from grind.. ([177.170.117.52]) by smtp.gmail.com with ESMTPSA id
 y3-20020a544d83000000b00395f2c84b81sm2428420oix.54.2023.06.10.06.32.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Jun 2023 06:32:49 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 28/29] target/ppc: Implement gathering irq statistics
Date: Sat, 10 Jun 2023 10:31:31 -0300
Message-Id: <20230610133132.290703-29-danielhb413@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230610133132.290703-1-danielhb413@gmail.com>
References: <20230610133132.290703-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=danielhb413@gmail.com; helo=mail-oi1-x230.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Count exceptions which can be queried with info irq monitor command.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230606220200.7EBCC74635C@zero.eik.bme.hu>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 target/ppc/cpu.h         |  1 +
 target/ppc/cpu_init.c    | 18 ++++++++++++++++++
 target/ppc/excp_helper.c |  1 +
 3 files changed, 20 insertions(+)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 20508bac5e..0ee2adc105 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1195,6 +1195,7 @@ struct CPUArchState {
     int error_code;
     uint32_t pending_interrupts;
 #if !defined(CONFIG_USER_ONLY)
+    uint64_t excp_stats[POWERPC_EXCP_NB];
     /*
      * This is the IRQ controller, which is implementation dependent and only
      * relevant when emulating a complete machine. Note that this isn't used
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index d4ef074afb..9f97222655 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -48,6 +48,7 @@
 
 #ifndef CONFIG_USER_ONLY
 #include "hw/boards.h"
+#include "hw/intc/intc.h"
 #endif
 
 /* #define PPC_DEBUG_SPR */
@@ -7123,6 +7124,16 @@ static bool ppc_cpu_is_big_endian(CPUState *cs)
     return !FIELD_EX64(env->msr, MSR, LE);
 }
 
+static bool ppc_get_irq_stats(InterruptStatsProvider *obj,
+                              uint64_t **irq_counts, unsigned int *nb_irqs)
+{
+    CPUPPCState *env = &POWERPC_CPU(obj)->env;
+
+    *irq_counts = env->excp_stats;
+    *nb_irqs = ARRAY_SIZE(env->excp_stats);
+    return true;
+}
+
 #ifdef CONFIG_TCG
 static void ppc_cpu_exec_enter(CPUState *cs)
 {
@@ -7286,6 +7297,7 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
     cc->gdb_write_register = ppc_cpu_gdb_write_register;
 #ifndef CONFIG_USER_ONLY
     cc->sysemu_ops = &ppc_sysemu_ops;
+    INTERRUPT_STATS_PROVIDER_CLASS(oc)->get_statistics = ppc_get_irq_stats;
 #endif
 
     cc->gdb_num_core_regs = 71;
@@ -7323,6 +7335,12 @@ static const TypeInfo ppc_cpu_type_info = {
     .abstract = true,
     .class_size = sizeof(PowerPCCPUClass),
     .class_init = ppc_cpu_class_init,
+#ifndef CONFIG_USER_ONLY
+    .interfaces = (InterfaceInfo[]) {
+          { TYPE_INTERRUPT_STATS_PROVIDER },
+          { }
+    },
+#endif
 };
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 8b95410c36..12d8a7257b 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -1655,6 +1655,7 @@ static void powerpc_excp(PowerPCCPU *cpu, int excp)
     qemu_log_mask(CPU_LOG_INT, "Raise exception at " TARGET_FMT_lx
                   " => %s (%d) error=%02x\n", env->nip, powerpc_excp_name(excp),
                   excp, env->error_code);
+    env->excp_stats[excp]++;
 
     switch (env->excp_model) {
     case POWERPC_EXCP_40x:
-- 
2.40.1


