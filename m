Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 070DE7737D4
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 06:21:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTEDU-000789-3Q; Tue, 08 Aug 2023 00:21:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qTEDS-00077g-4Z; Tue, 08 Aug 2023 00:21:06 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qTEDQ-0007ml-DC; Tue, 08 Aug 2023 00:21:05 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-687ca37628eso798907b3a.1; 
 Mon, 07 Aug 2023 21:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691468463; x=1692073263;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4E2HOZjazPZHARfPvsKQ/WSbla5XrPKfruoE7y4VFWg=;
 b=Vhy9EVvi/2EeLXYpJAysbLLbrrqruoJkLs31XrB+ubay8RxDLkofDi8enQKWnchyZR
 aRN7qGJ9fOaEjJm1a7dl+tfweXMqpQXlCO77KoT75gp/pwxwB82VipexZ+x5/36CTAB9
 rPrFyyYiLHvdt4G1uijXROIW8Qsnj3ELRL8J9xLB+7Kj31dZksdzPilXC6UT5cndJBkI
 1V1Xg8vrzddTgNa/sEwLw7jdhbI3L9m3abYMRfMjhT/SZd91XI95orn+Yi/68F0CLJ1M
 DvwnMG3JyUGEL0Vv3DJ2HYhFQg7qkHZE80jjMNXWofW0oR4t2tFtai/BA4lYeTT/540E
 xaXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691468463; x=1692073263;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4E2HOZjazPZHARfPvsKQ/WSbla5XrPKfruoE7y4VFWg=;
 b=L/OMtaDQb7jjXLVRkVHSQ+Rp1xpCHhZGQHlvsNeP2WP1yEfvbHWTl8aaADbRjza01w
 YBKDaLgAFzrSLHJ1gT7gha2t95AYt18FxQFRV66z6pRsxwCF80DRfhop04Q9YJSoBIDb
 SREeg+1634WkAulfqPjrVRbGTWvjWf5WMsu0lWGf9oomOpluR6Mzkw7YATpsg69RIw4e
 tqGZE3dnkdUB+j5QDIIlrjNVZtDJoCf6PrC1zcJu7srX/z29Xg94T3KTplCpfLae+lqj
 qky0ux2vn+0zk3rWz70KnYqwcoag6PwzQakm+t1GDJxj4m1/DSfuInhzinCNCHNWCOkE
 eFbA==
X-Gm-Message-State: AOJu0YwREy5o5hlnAltvRiZQo6ptGtW8ipE9EOo/tIVq8LT58i2ce3SS
 htr8af8MNmsh/HEnmq7Ad+c=
X-Google-Smtp-Source: AGHT+IHdw1TjEAx++ylXkfWcODFEWRN8r73/dqPFCE4T/hdLTeDdZ4G+tAM7siWGLFzvo4CPkUL8oQ==
X-Received: by 2002:a05:6a20:7495:b0:130:f6bc:9146 with SMTP id
 p21-20020a056a20749500b00130f6bc9146mr13925261pzd.14.1691468462867; 
 Mon, 07 Aug 2023 21:21:02 -0700 (PDT)
Received: from wheely.local0.net (61-68-137-140.tpgi.com.au. [61.68.137.140])
 by smtp.gmail.com with ESMTPSA id
 fk10-20020a056a003a8a00b0068718f6a035sm6979207pfb.33.2023.08.07.21.20.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 21:21:02 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2 11/19] hw/ppc: Reset timebase facilities on machine reset
Date: Tue,  8 Aug 2023 14:19:53 +1000
Message-Id: <20230808042001.411094-12-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808042001.411094-1-npiggin@gmail.com>
References: <20230808042001.411094-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Lower interrupts, delete timers, and set time facility registers
back to initial state on machine reset.

This is not so important for record-replay since timebase and
decrementer are migrated, but it gives a cleaner reset state.

Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/mac_oldworld.c   |  1 +
 hw/ppc/pegasos2.c       |  1 +
 hw/ppc/pnv_core.c       |  2 ++
 hw/ppc/ppc.c            | 46 +++++++++++++++++++++++------------------
 hw/ppc/prep.c           |  1 +
 hw/ppc/spapr_cpu_core.c |  2 ++
 include/hw/ppc/ppc.h    |  3 ++-
 7 files changed, 35 insertions(+), 21 deletions(-)

diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 510ff0eaaf..9acc7adfc9 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -81,6 +81,7 @@ static void ppc_heathrow_reset(void *opaque)
 {
     PowerPCCPU *cpu = opaque;
 
+    cpu_ppc_tb_reset(&cpu->env);
     cpu_reset(CPU(cpu));
 }
 
diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index 075367d94d..bd397cf2b5 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -99,6 +99,7 @@ static void pegasos2_cpu_reset(void *opaque)
         cpu->env.gpr[1] = 2 * VOF_STACK_SIZE - 0x20;
         cpu->env.nip = 0x100;
     }
+    cpu_ppc_tb_reset(&cpu->env);
 }
 
 static void pegasos2_pci_irq(void *opaque, int n, int level)
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 9b39d527de..8c7afe037f 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -61,6 +61,8 @@ static void pnv_core_cpu_reset(PnvCore *pc, PowerPCCPU *cpu)
     hreg_compute_hflags(env);
     ppc_maybe_interrupt(env);
 
+    cpu_ppc_tb_reset(env);
+
     pcc->intc_reset(pc->chip, cpu);
 }
 
diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index d9a1cfbf91..f391acc39e 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -944,23 +944,6 @@ void cpu_ppc_store_purr(CPUPPCState *env, uint64_t value)
                      &tb_env->purr_offset, value);
 }
 
-static void cpu_ppc_set_tb_clk (void *opaque, uint32_t freq)
-{
-    CPUPPCState *env = opaque;
-    PowerPCCPU *cpu = env_archcpu(env);
-    ppc_tb_t *tb_env = env->tb_env;
-
-    tb_env->tb_freq = freq;
-    tb_env->decr_freq = freq;
-    /* There is a bug in Linux 2.4 kernels:
-     * if a decrementer exception is pending when it enables msr_ee at startup,
-     * it's not ready to handle it...
-     */
-    _cpu_ppc_store_decr(cpu, 0xFFFFFFFF, 0xFFFFFFFF, 32);
-    _cpu_ppc_store_hdecr(cpu, 0xFFFFFFFF, 0xFFFFFFFF, 32);
-    cpu_ppc_store_purr(env, 0x0000000000000000ULL);
-}
-
 static void timebase_save(PPCTimebase *tb)
 {
     uint64_t ticks = cpu_get_host_ticks();
@@ -1062,7 +1045,7 @@ const VMStateDescription vmstate_ppc_timebase = {
 };
 
 /* Set up (once) timebase frequency (in Hz) */
-clk_setup_cb cpu_ppc_tb_init (CPUPPCState *env, uint32_t freq)
+void cpu_ppc_tb_init(CPUPPCState *env, uint32_t freq)
 {
     PowerPCCPU *cpu = env_archcpu(env);
     ppc_tb_t *tb_env;
@@ -1083,9 +1066,32 @@ clk_setup_cb cpu_ppc_tb_init (CPUPPCState *env, uint32_t freq)
     } else {
         tb_env->hdecr_timer = NULL;
     }
-    cpu_ppc_set_tb_clk(env, freq);
 
-    return &cpu_ppc_set_tb_clk;
+    tb_env->tb_freq = freq;
+    tb_env->decr_freq = freq;
+}
+
+void cpu_ppc_tb_reset(CPUPPCState *env)
+{
+    PowerPCCPU *cpu = env_archcpu(env);
+    ppc_tb_t *tb_env = env->tb_env;
+
+    timer_del(tb_env->decr_timer);
+    ppc_set_irq(cpu, PPC_INTERRUPT_DECR, 0);
+    tb_env->decr_next = 0;
+    if (tb_env->hdecr_timer != NULL) {
+        timer_del(tb_env->hdecr_timer);
+        ppc_set_irq(cpu, PPC_INTERRUPT_HDECR, 0);
+        tb_env->hdecr_next = 0;
+    }
+
+    /* There is a bug in Linux 2.4 kernels:
+     * if a decrementer exception is pending when it enables msr_ee at startup,
+     * it's not ready to handle it...
+     */
+    cpu_ppc_store_decr(env, -1);
+    cpu_ppc_store_hdecr(env, -1);
+    cpu_ppc_store_purr(env, 0x0000000000000000ULL);
 }
 
 void cpu_ppc_tb_free(CPUPPCState *env)
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index d9231c7317..f6fd35fcb9 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -67,6 +67,7 @@ static void ppc_prep_reset(void *opaque)
     PowerPCCPU *cpu = opaque;
 
     cpu_reset(CPU(cpu));
+    cpu_ppc_tb_reset(&cpu->env);
 }
 
 
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index b482d9754a..91fae56573 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -74,6 +74,8 @@ static void spapr_reset_vcpu(PowerPCCPU *cpu)
 
     kvm_check_mmu(cpu, &error_fatal);
 
+    cpu_ppc_tb_reset(env);
+
     spapr_irq_cpu_intc_reset(spapr, cpu);
 }
 
diff --git a/include/hw/ppc/ppc.h b/include/hw/ppc/ppc.h
index e095c002dc..17a8dfc107 100644
--- a/include/hw/ppc/ppc.h
+++ b/include/hw/ppc/ppc.h
@@ -54,7 +54,8 @@ struct ppc_tb_t {
                                                */
 
 uint64_t cpu_ppc_get_tb(ppc_tb_t *tb_env, uint64_t vmclk, int64_t tb_offset);
-clk_setup_cb cpu_ppc_tb_init (CPUPPCState *env, uint32_t freq);
+void cpu_ppc_tb_init(CPUPPCState *env, uint32_t freq);
+void cpu_ppc_tb_reset(CPUPPCState *env);
 void cpu_ppc_tb_free(CPUPPCState *env);
 void cpu_ppc_hdecr_init(CPUPPCState *env);
 void cpu_ppc_hdecr_exit(CPUPPCState *env);
-- 
2.40.1


