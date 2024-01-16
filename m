Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 632EB82EF59
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 14:03:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPj5l-0007Jj-CI; Tue, 16 Jan 2024 08:02:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rPj5e-0007IM-Mh
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 08:02:53 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rPj5c-0006gN-J6
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 08:02:50 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40e86c86a6fso1715645e9.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 05:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1705410166; x=1706014966; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rxD20uCid/0tv8hV8SWyOcdb3LbgP765Gn4srtgv1/4=;
 b=PzPCjb0c7FAvJuynsWBfUgWFTC2NceD0yPT7b2ZHXB/jSKC1CMO3oGKXJhdqSPOvwe
 4uEH5xIgMjCp7LScQ6/m2msJgDNjGKREVD9eZPjmgOqUKfEOJ3bRZPVcAzItIqctlyKU
 nm6kssPyZokr8kKhfYm88H4k7vfSCLlRyj8giqGxq6p1Lb50btRgzZENSt9UhfszzEKr
 TQuW3k1GQtlg2wId88JnLSUIAsjMGdcMIc9CX7x6Nbse30F5HG1V+/slUPwdDK4HODCT
 DlIq9RSAohaXFO04GCzvOz00ICqKSoWlUnzEcNcy97edwqUDJACSS+C1p9VuGdZ0Fcqv
 K8KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705410166; x=1706014966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rxD20uCid/0tv8hV8SWyOcdb3LbgP765Gn4srtgv1/4=;
 b=VzVTiHk6PRZFjSeS8DT9bUC5kKFScQXC2ncD2mzcxTuxCM6rvaeCPo4GnitxkoNyWB
 VDF+xNAQdkZhqcwufPiF3LpVV+8xuod+S/SEUR4pbz+CLjmsMu0IfVfealV4nP97vMKm
 G6eH4UEFex5ZYS7a8B5WRmg9m/QIJE99fsk5AszaSGsqcTmhAbrv87VAd9oLMUVvZXKV
 Me6O+8FxXaTnAtzAdJbEnDD3g66zmWIzqYrzIhVbGcyV9KoLloKVvaMy9WYx5gVU3bJh
 4j6dPKYPjR2a2ho4KpSybDHKu5/ygRryghS33Wl8mJ3qNnk0P+G2ewF1bl0vD8HN4nzB
 7Bhg==
X-Gm-Message-State: AOJu0YwASfJgw+UV09u39k02Ba5dRDxZ+uyfkJRgeTRjv6xGHKwuWIB7
 VQVjZVKSCvYqVwZH+vIxtDVFhv4RBXo2hgu/465NtoHpBA==
X-Google-Smtp-Source: AGHT+IHNy/DX4m3fAOh/NoutrnNLcIIqHOnPeMWfQ7DuJgyl14hru0duakzPzV/4XePZMgXil+JOBw==
X-Received: by 2002:a05:600c:310e:b0:40e:50f8:9ae3 with SMTP id
 g14-20020a05600c310e00b0040e50f89ae3mr2147102wmo.68.1705410166434; 
 Tue, 16 Jan 2024 05:02:46 -0800 (PST)
Received: from chigot-Dell.telnowedge.local
 (lmontsouris-659-1-24-67.w81-250.abo.wanadoo.fr. [81.250.175.67])
 by smtp.gmail.com with ESMTPSA id
 d16-20020a05600c34d000b0040e83867d62sm2495316wmq.34.2024.01.16.05.02.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 05:02:45 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>
Subject: [PATCH v2 6/8] leon3: implement multiprocessor
Date: Tue, 16 Jan 2024 14:02:11 +0100
Message-Id: <20240116130213.172358-7-chigot@adacore.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240116130213.172358-1-chigot@adacore.com>
References: <20240116130213.172358-1-chigot@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=chigot@adacore.com; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

This allows to register more than one CPU on the leon3_generic machine.

Co-developed-by: Frederic Konrad <konrad.frederic@yahoo.fr>
Signed-off-by: Clément Chigot <chigot@adacore.com>
---
 hw/sparc/leon3.c | 106 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 74 insertions(+), 32 deletions(-)

diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 7866f0a049..eacd85ee4f 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -54,6 +54,8 @@
 #define LEON3_PROM_OFFSET    (0x00000000)
 #define LEON3_RAM_OFFSET     (0x40000000)
 
+#define MAX_CPUS  4
+
 #define LEON3_UART_OFFSET  (0x80000100)
 #define LEON3_UART_IRQ     (3)
 
@@ -67,9 +69,12 @@
 #define LEON3_AHB_PNP_OFFSET (0xFFFFF000)
 
 typedef struct ResetData {
-    SPARCCPU *cpu;
-    uint32_t  entry;            /* save kernel entry in case of reset */
-    target_ulong sp;            /* initial stack pointer */
+    struct CPUResetData {
+        int id;
+        SPARCCPU *cpu;
+        target_ulong sp;  /* initial stack pointer */
+    } info[MAX_CPUS];
+    uint32_t entry;             /* save kernel entry in case of reset */
 } ResetData;
 
 static uint32_t *gen_store_u32(uint32_t *code, hwaddr addr, uint32_t val)
@@ -125,18 +130,19 @@ static void write_bootloader(CPUSPARCState *env, uint8_t *base,
     stl_p(p++, 0x01000000); /* nop */
 }
 
-static void main_cpu_reset(void *opaque)
+static void leon3_cpu_reset(void *opaque)
 {
-    ResetData *s   = (ResetData *)opaque;
-    CPUState *cpu = CPU(s->cpu);
-    CPUSPARCState  *env = &s->cpu->env;
+    struct CPUResetData *info = (struct CPUResetData *) opaque;
+    int id = info->id;
+    ResetData *s = (ResetData *)DO_UPCAST(ResetData, info[id], info);
+    CPUState *cpu = CPU(s->info[id].cpu);
+    CPUSPARCState *env = cpu_env(cpu);
 
     cpu_reset(cpu);
-
-    cpu->halted = 0;
-    env->pc     = s->entry;
-    env->npc    = s->entry + 4;
-    env->regbase[6] = s->sp;
+    cpu->halted = cpu->cpu_index != 0;
+    env->pc = s->entry;
+    env->npc = s->entry + 4;
+    env->regbase[6] = s->info[id].sp;
 }
 
 static void leon3_cache_control_int(CPUSPARCState *env)
@@ -170,8 +176,8 @@ static void leon3_cache_control_int(CPUSPARCState *env)
 
 static void leon3_irq_ack(CPUSPARCState *env, int intno)
 {
-    /* No SMP support yet, only CPU #0 available so far.  */
-    grlib_irqmp_ack(env->irq_manager, 0, intno);
+    CPUState *cpu = CPU(env_cpu(env));
+    grlib_irqmp_ack(env->irq_manager, cpu->cpu_index, intno);
 }
 
 /*
@@ -213,6 +219,20 @@ static void leon3_set_pil_in(void *opaque, int n, int level)
     }
 }
 
+static void leon3_start_cpu_async_work(CPUState *cpu, run_on_cpu_data data)
+{
+    cpu->halted = 0;
+}
+
+static void leon3_start_cpu(void *opaque, int n, int level)
+{
+    CPUState *cs = CPU(opaque);
+
+    if (level) {
+        async_run_on_cpu(cs, leon3_start_cpu_async_work, RUN_ON_CPU_NULL);
+    }
+}
+
 static void leon3_irq_manager(CPUSPARCState *env, int intno)
 {
     leon3_irq_ack(env, intno);
@@ -238,17 +258,21 @@ static void leon3_generic_hw_init(MachineState *machine)
     AHBPnp *ahb_pnp;
     APBPnp *apb_pnp;
 
-    /* Init CPU */
-    cpu = SPARC_CPU(cpu_create(machine->cpu_type));
-    env = &cpu->env;
+    reset_info = g_malloc0(sizeof(ResetData));
 
-    cpu_sparc_set_id(env, 0);
+    for (i = 0; i < machine->smp.cpus; i++) {
+        /* Init CPU */
+        cpu = SPARC_CPU(cpu_create(machine->cpu_type));
+        env = &cpu->env;
 
-    /* Reset data */
-    reset_info        = g_new0(ResetData, 1);
-    reset_info->cpu   = cpu;
-    reset_info->sp    = LEON3_RAM_OFFSET + ram_size;
-    qemu_register_reset(main_cpu_reset, reset_info);
+        cpu_sparc_set_id(env, i);
+
+        /* Reset data */
+        reset_info->info[i].id = i;
+        reset_info->info[i].cpu = cpu;
+        reset_info->info[i].sp = LEON3_RAM_OFFSET + ram_size;
+        qemu_register_reset(leon3_cpu_reset, &reset_info->info[i]);
+    }
 
     ahb_pnp = GRLIB_AHB_PNP(qdev_new(TYPE_GRLIB_AHB_PNP));
     sysbus_realize_and_unref(SYS_BUS_DEVICE(ahb_pnp), &error_fatal);
@@ -266,14 +290,28 @@ static void leon3_generic_hw_init(MachineState *machine)
 
     /* Allocate IRQ manager */
     irqmpdev = qdev_new(TYPE_GRLIB_IRQMP);
+    object_property_set_int(OBJECT(irqmpdev), "ncpus", machine->smp.cpus,
+                            &error_fatal);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(irqmpdev), &error_fatal);
-    qdev_init_gpio_in_named_with_opaque(DEVICE(cpu), leon3_set_pil_in,
-                                        env, "pil", 1);
-    qdev_connect_gpio_out_named(irqmpdev, "grlib-irq", 0,
-                                qdev_get_gpio_in_named(DEVICE(cpu), "pil", 0));
+
+    for (i = 0; i < machine->smp.cpus; i++) {
+        cpu = reset_info->info[i].cpu;
+        env = &cpu->env;
+        qdev_init_gpio_in_named_with_opaque(DEVICE(cpu), leon3_start_cpu,
+                                            cpu, "start_cpu", 1);
+        qdev_connect_gpio_out_named(irqmpdev, "grlib-start-cpu", i,
+                                    qdev_get_gpio_in_named(DEVICE(cpu),
+                                                           "start_cpu", 0));
+        qdev_init_gpio_in_named_with_opaque(DEVICE(cpu), leon3_set_pil_in,
+                                            env, "pil", 1);
+        qdev_connect_gpio_out_named(irqmpdev, "grlib-irq", i,
+                                    qdev_get_gpio_in_named(DEVICE(cpu),
+                                                           "pil", 0));
+        env->irq_manager = irqmpdev;
+        env->qemu_irq_ack = leon3_irq_manager;
+    }
+
     sysbus_mmio_map(SYS_BUS_DEVICE(irqmpdev), 0, LEON3_IRQMP_OFFSET);
-    env->irq_manager = irqmpdev;
-    env->qemu_irq_ack = leon3_irq_manager;
     grlib_apb_pnp_add_entry(apb_pnp, LEON3_IRQMP_OFFSET, 0xFFF,
                             GRLIB_VENDOR_GAISLER, GRLIB_IRQMP_DEV,
                             2, 0, GRLIB_APBIO_AREA);
@@ -347,10 +385,13 @@ static void leon3_generic_hw_init(MachineState *machine)
             uint8_t *bootloader_entry;
 
             bootloader_entry = memory_region_get_ram_ptr(prom);
-            write_bootloader(env, bootloader_entry, entry);
-            env->pc = LEON3_PROM_OFFSET;
-            env->npc = LEON3_PROM_OFFSET + 4;
+            write_bootloader(&reset_info->info[0].cpu->env, bootloader_entry,
+                             entry);
             reset_info->entry = LEON3_PROM_OFFSET;
+            for (i = 0; i < machine->smp.cpus; i++) {
+                reset_info->info[i].cpu->env.pc = LEON3_PROM_OFFSET;
+                reset_info->info[i].cpu->env.npc = LEON3_PROM_OFFSET + 4;
+            }
         }
     }
 
@@ -389,6 +430,7 @@ static void leon3_generic_machine_init(MachineClass *mc)
     mc->init = leon3_generic_hw_init;
     mc->default_cpu_type = SPARC_CPU_TYPE_NAME("LEON3");
     mc->default_ram_id = "leon3.ram";
+    mc->max_cpus = MAX_CPUS;
 }
 
 DEFINE_MACHINE("leon3_generic", leon3_generic_machine_init)
-- 
2.25.1


