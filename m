Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D558251D6
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 11:25:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLhNi-0007mx-RX; Fri, 05 Jan 2024 05:24:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rLhNg-0007m8-JS
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 05:24:48 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rLhNe-0004MK-A6
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 05:24:48 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40d2e56f3a6so2220295e9.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 02:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1704450284; x=1705055084; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3kjoVNEQWPmPx6yVfKaTZBwWjHQDINWXYhqFXPqbyKs=;
 b=KT1xOqSHtelGnKyZ/54NdAgwUhIVc2ABFRF7+inlhKNtJg8VTQe8ADF7uXkebHugFI
 j+cUk5SY8HrWEdWk5eS5tXUNIlVT/OjiQoUKvqeWAeu2Wp5EVBU6BlnDl18WZpoYer+2
 ibjtl+Bwv8Ykrtn9tg1fTEv9vqP2de8OYXhfcV6cZtYK6+xETqZd25gGjlw/9EwEyNaQ
 ZYTnT1SRD056/iqf9SmhXUmpFJp2GCOTZC3MPw2GdUp7zRy4QzfMtTfnHfVlVTF/3ZOx
 GnqFDQrvRj48sLVhtNloNJX2TmjT8OrVVrrFif/Lg19+KhMGUIx9EMqI4TQhdQFZyJyj
 86RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704450284; x=1705055084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3kjoVNEQWPmPx6yVfKaTZBwWjHQDINWXYhqFXPqbyKs=;
 b=iDSoC3PnzlKV6dVa0d7jQDc3YN9U347NEcDM0HAAHvlqnOPA54YMog5z3DOlNGSS6k
 5gRPkcx9QxhIX/n8hALbKmUi03mmyrOtLE581TsseC2bd/4Nyi/TFZ9dDvoqc4GQHGeU
 dCjyqNuAESAeoYtAspRfaDdzkky/48sliOy6JWGoh6cqQQ8TsKCoAm714lmLtptRr/BF
 BttJqPCRA7N/EKrR2EMLDFjBg9146hN3IyZj++cTZjrnLvHZ+n08trFN8iRz8zWr/Ew0
 ZN1WaiofBqNUwCl0hlcYCOnTCdCFn+NZGzecKXSqml8N/HHqeuzA8Yx5sicJgcoS7RVE
 28gQ==
X-Gm-Message-State: AOJu0Yy9jApsrKhytmQ9QSZADHfDtWtppew6wyEChpSrQmGAK7mz0Oxi
 sXsPEr6XRx8rjWpZ87Wyy/u0jvuSBrJ851SMOUOqJvloPA==
X-Google-Smtp-Source: AGHT+IHInj+NmU0oW11MkMdA5E7GPt3s4o5kIin0Y3oMEyyIEbrKgG8O98DORqLVLgOqo6/PGpr/Dg==
X-Received: by 2002:a05:600c:181c:b0:40d:9236:cd9e with SMTP id
 n28-20020a05600c181c00b0040d9236cd9emr1095593wmp.35.1704450284438; 
 Fri, 05 Jan 2024 02:24:44 -0800 (PST)
Received: from chigot-Dell.home ([2a01:cb15:8123:8100:323e:281a:689:2b09])
 by smtp.gmail.com with ESMTPSA id
 v8-20020a05600c444800b0040d934f48d3sm1117548wmn.32.2024.01.05.02.24.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jan 2024 02:24:43 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>
Subject: [PATCH 7/9] leon3: implement multiprocessor
Date: Fri,  5 Jan 2024 11:24:19 +0100
Message-Id: <20240105102421.163554-8-chigot@adacore.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240105102421.163554-1-chigot@adacore.com>
References: <20240105102421.163554-1-chigot@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=chigot@adacore.com; helo=mail-wm1-x32f.google.com
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
index 6019fc4c2d..38fb8d9af1 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -52,6 +52,8 @@
 #define LEON3_PROM_OFFSET    (0x00000000)
 #define LEON3_RAM_OFFSET     (0x40000000)
 
+#define MAX_CPUS  4
+
 #define LEON3_UART_OFFSET  (0x80000100)
 #define LEON3_UART_IRQ     (3)
 
@@ -65,9 +67,12 @@
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
@@ -123,18 +128,19 @@ static void write_bootloader(CPUSPARCState *env, uint8_t *base,
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
@@ -168,8 +174,8 @@ static void leon3_cache_control_int(CPUSPARCState *env)
 
 static void leon3_irq_ack(CPUSPARCState *env, int intno)
 {
-    /* No SMP support yet.  */
-    grlib_irqmp_ack(env->irq_manager, 0, intno);
+    CPUState *cpu = CPU(env_cpu(env));
+    grlib_irqmp_ack(env->irq_manager, cpu->cpu_index, intno);
 }
 
 /*
@@ -211,6 +217,20 @@ static void leon3_set_pil_in(void *opaque, int n, int level)
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
@@ -236,17 +256,21 @@ static void leon3_generic_hw_init(MachineState *machine)
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
@@ -264,14 +288,28 @@ static void leon3_generic_hw_init(MachineState *machine)
 
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
@@ -345,10 +383,13 @@ static void leon3_generic_hw_init(MachineState *machine)
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
 
@@ -387,6 +428,7 @@ static void leon3_generic_machine_init(MachineClass *mc)
     mc->init = leon3_generic_hw_init;
     mc->default_cpu_type = SPARC_CPU_TYPE_NAME("LEON3");
     mc->default_ram_id = "leon3.ram";
+    mc->max_cpus = MAX_CPUS;
 }
 
 DEFINE_MACHINE("leon3_generic", leon3_generic_machine_init)
-- 
2.25.1


