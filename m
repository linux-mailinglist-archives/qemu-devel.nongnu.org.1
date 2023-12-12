Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC62A80F2D4
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 17:34:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD5gx-0007vB-Jy; Tue, 12 Dec 2023 11:33:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD5gS-0007i2-KN
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:32:39 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD5gL-0007mt-4X
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:32:36 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40c2308faedso60645465e9.1
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 08:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702398747; x=1703003547; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vFzkWMG0zGlWXgIPHI7/afHt/cki/WH0MbN3+yHSaoE=;
 b=w827WYbJT/bwT+5gA5lCtmX9vwmVYKLc9ws4IhrR5E6Fe2MoT86FYLKA/jJ9PCjRnU
 X/++TcfjnpbfHX3TOx6U0umMwbk/no1mfFB/y0259aD5CQ0ugmE+vGMfgl3Emlbq2asx
 PVhj0itcjGBrwIz9nmEe49gHivf9Q8yOzkDSUUxmbkR46a5pcyGUd+1Cl3x+m1cQ5a/a
 4uk82ADorqw5yu8CIHvEx67vUHh20tQzITSjOLRgJRdZfVklj4zb2TF00BmFmlHVxBUU
 C7TZQJY/5ElqqrxcV39PvoTTXGdpdFyJoQEsSXraj4MGuLLpHLq0B3zdfuk8P6rjKIKr
 sZ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702398747; x=1703003547;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vFzkWMG0zGlWXgIPHI7/afHt/cki/WH0MbN3+yHSaoE=;
 b=M1XBRIllnhpi68Nwr0mDUk2KEoXc70UJpkUceCf8i1LG/BppcPR/bYd+tS6V8sBYOH
 u1heRZN76xVhL7G081QBJ4FW4GVY8yMT+ciSC9R1wjzOypnOUDu2uwqvYnA1piS6nRTy
 eDcfts04WUOQjEzVz5PWDmoHr0n/OcAG5lgOcmmeWFRAjYqUvG+hxBsz+TZXuE3rHeeM
 F2mJdsnWgqTyDEcLvQldZ8tYqGhUqQuoGoGmrmteSA6zsSlH8VwBpoQlfzOPQyWtPnj4
 +yTrPy2gcN+fFC6Jhsc9gDuQy99o6Gu5omZEkja2dm2C11yhCEuMcpjEHNE7oRKju1Rb
 ZlZQ==
X-Gm-Message-State: AOJu0YwOVRAsHWuXrB5S90Z19giMZpCxIrQ1oVj/0Ht9kxFakaTcMHQQ
 n6viti/NjuHBSdgkBVc2WEDK8NV7bf8ApxZGuaI=
X-Google-Smtp-Source: AGHT+IFZd1CMjh6Gzr06q97rlXMejC01TVbKDESXkHnVYzgAhizQSnBEAprdGTA0lpX/odIAhjlgMg==
X-Received: by 2002:a05:600c:3784:b0:40b:47f0:66b5 with SMTP id
 o4-20020a05600c378400b0040b47f066b5mr3699516wmr.26.1702398746978; 
 Tue, 12 Dec 2023 08:32:26 -0800 (PST)
Received: from m1x-phil.lan ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 l39-20020a05600c1d2700b0040c2c5f5844sm17191224wms.21.2023.12.12.08.32.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Dec 2023 08:32:26 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Tyrone Ting <kfting@nuvoton.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>, Anton Johansson <anjo@rev.ng>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Hao Wu <wuhaotsh@google.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Rob Herring <robh@kernel.org>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 23/33] hw/arm/exynos4210: Let the A9MPcore create/wire the CPU
 cores
Date: Tue, 12 Dec 2023 17:29:23 +0100
Message-ID: <20231212162935.42910-24-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231212162935.42910-1-philmd@linaro.org>
References: <20231212162935.42910-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Set the properties on the a9mpcore object to let it create and
wire the CPU cores. Remove the redundant code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/arm/exynos4210.h |  4 +--
 hw/arm/exynos4210.c         | 62 +++++++++++++------------------------
 hw/arm/exynos4_boards.c     |  6 ++--
 3 files changed, 26 insertions(+), 46 deletions(-)

diff --git a/include/hw/arm/exynos4210.h b/include/hw/arm/exynos4210.h
index f95e3232c5..28a64f275c 100644
--- a/include/hw/arm/exynos4210.h
+++ b/include/hw/arm/exynos4210.h
@@ -83,10 +83,8 @@
 #define EXYNOS4210_NUM_SPLITTERS (EXYNOS4210_MAX_EXT_COMBINER_IN_IRQ + 38)
 
 struct Exynos4210State {
-    /*< private >*/
     SysBusDevice parent_obj;
-    /*< public >*/
-    ARMCPU *cpu[EXYNOS4210_NCPUS];
+
     qemu_irq irq_table[EXYNOS4210_MAX_INT_COMBINER_IN_IRQ];
 
     MemoryRegion chipid_mem;
diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index 7386a8fe57..c6da908961 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -501,12 +501,6 @@ void exynos4210_write_secondary(ARMCPU *cpu,
                        info->smp_loader_start);
 }
 
-static uint64_t exynos4210_calc_affinity(int cpu)
-{
-    /* Exynos4210 has 0x9 as cluster ID */
-    return (0x9 << ARM_AFF1_SHIFT) | cpu;
-}
-
 static DeviceState *pl330_create(uint32_t base, OrIRQState *orgate,
                                  qemu_irq irq, int nreq, int nevents, int width)
 {
@@ -549,26 +543,25 @@ static void exynos4210_realize(DeviceState *socdev, Error **errp)
     MemoryRegion *system_mem = get_system_memory();
     SysBusDevice *busdev;
     DeviceState *dev, *mpdev, *uart[4], *pl330[3];
+    CortexMPPrivState *mpcore;
     int i, n;
 
-    for (n = 0; n < EXYNOS4210_NCPUS; n++) {
-        Object *cpuobj = object_new(ARM_CPU_TYPE_NAME("cortex-a9"));
-
-        /* By default A9 CPUs have EL3 enabled.  This board does not currently
-         * support EL3 so the CPU EL3 property is disabled before realization.
-         */
-        if (object_property_find(cpuobj, "has_el3")) {
-            object_property_set_bool(cpuobj, "has_el3", false, &error_fatal);
-        }
-
-        s->cpu[n] = ARM_CPU(cpuobj);
-        object_property_set_int(cpuobj, "mp-affinity",
-                                exynos4210_calc_affinity(n), &error_abort);
-        object_property_set_int(cpuobj, "reset-cbar",
-                                EXYNOS4210_SMP_PRIVATE_BASE_ADDR,
-                                &error_abort);
-        qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
-    }
+    /* Private memory region and Internal GIC */
+    mpdev = DEVICE(&s->a9mpcore);
+    mpcore = CORTEX_MPCORE_PRIV(&s->a9mpcore);
+    /* Exynos4210 has 0x9 as cluster ID */
+    qdev_prop_set_uint32(mpdev, "cluster-id", 0x9);
+    qdev_prop_set_uint32(mpdev, "num-cores", EXYNOS4210_NCPUS);
+    /*
+     * By default A9 CPUs have EL3 enabled.  This board does not currently
+     * support EL3 so the CPU EL3 property is disabled before realization.
+     */
+    qdev_prop_set_bit(mpdev, "cpu-has-el3", false);
+    qdev_prop_set_uint64(mpdev, "cpu-reset-cbar",
+                         EXYNOS4210_SMP_PRIVATE_BASE_ADDR);
+    busdev = SYS_BUS_DEVICE(&s->a9mpcore);
+    sysbus_realize(busdev, &error_fatal);
+    sysbus_mmio_map(busdev, 0, EXYNOS4210_SMP_PRIVATE_BASE_ADDR);
 
     /* IRQ Gate */
     for (i = 0; i < EXYNOS4210_NCPUS; i++) {
@@ -578,23 +571,10 @@ static void exynos4210_realize(DeviceState *socdev, Error **errp)
                                 &error_abort);
         qdev_realize(orgate, NULL, &error_abort);
         qdev_connect_gpio_out(orgate, 0,
-                              qdev_get_gpio_in(DEVICE(s->cpu[i]), ARM_CPU_IRQ));
-    }
-
-    /* Private memory region and Internal GIC */
-    mpdev = DEVICE(&s->a9mpcore);
-    qdev_prop_set_uint32(mpdev, "num-cores", EXYNOS4210_NCPUS);
-    /*
-     * By default A9 CPUs have EL3 enabled.  This board does not currently
-     * support EL3 so the CPU EL3 property is disabled before realization.
-     */
-    qdev_prop_set_bit(mpdev, "cpu-has-el3", false);
-    busdev = SYS_BUS_DEVICE(&s->a9mpcore);
-    sysbus_realize(busdev, &error_fatal);
-    sysbus_mmio_map(busdev, 0, EXYNOS4210_SMP_PRIVATE_BASE_ADDR);
-    for (n = 0; n < EXYNOS4210_NCPUS; n++) {
-        sysbus_connect_irq(busdev, n,
-                           qdev_get_gpio_in(DEVICE(&s->cpu_irq_orgate[n]), 0));
+                              qdev_get_gpio_in(DEVICE(mpcore->cpu[i]),
+                                               ARM_CPU_IRQ));
+        sysbus_connect_irq(busdev, i,
+                           qdev_get_gpio_in(DEVICE(&s->cpu_irq_orgate[i]), 0));
     }
 
     /* Cache controller */
diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
index b0e13eb4f0..7eea66d027 100644
--- a/hw/arm/exynos4_boards.c
+++ b/hw/arm/exynos4_boards.c
@@ -136,18 +136,20 @@ static void nuri_init(MachineState *machine)
 {
     Exynos4BoardState *s = exynos4_boards_init_common(machine,
                                                       EXYNOS4_BOARD_NURI);
+    CortexMPPrivState *mp = CORTEX_MPCORE_PRIV(&s->soc.a9mpcore);
 
-    arm_load_kernel(s->soc.cpu[0], machine, &exynos4_board_binfo);
+    arm_load_kernel(mp->cpu[0], machine, &exynos4_board_binfo);
 }
 
 static void smdkc210_init(MachineState *machine)
 {
     Exynos4BoardState *s = exynos4_boards_init_common(machine,
                                                       EXYNOS4_BOARD_SMDKC210);
+    CortexMPPrivState *mp = CORTEX_MPCORE_PRIV(&s->soc.a9mpcore);
 
     lan9215_init(SMDK_LAN9118_BASE_ADDR,
             qemu_irq_invert(s->soc.irq_table[exynos4210_get_irq(37, 1)]));
-    arm_load_kernel(s->soc.cpu[0], machine, &exynos4_board_binfo);
+    arm_load_kernel(mp->cpu[0], machine, &exynos4_board_binfo);
 }
 
 static void nuri_class_init(ObjectClass *oc, void *data)
-- 
2.41.0


