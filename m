Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0039B82EF57
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 14:03:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPj5b-0007HO-D5; Tue, 16 Jan 2024 08:02:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rPj5Y-0007FQ-Cs
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 08:02:44 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rPj5W-0006fJ-J3
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 08:02:44 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40e85acaca2so4042875e9.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 05:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1705410160; x=1706014960; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MDOC//9rYljv8JbNJSrklqxInCkoTiR/AirLn143wHQ=;
 b=Xq5y2Q2tCDmGY+uH1WkSTDeBZUs1tUpxWuY3J4f3d9xf8wSKeD/i7kkbCWcfbq+X4A
 Z7UUXBTIgEmuux3DNzb+aqiRO7lAPMu8qRm+HFynMdmR05XK1sZiG4FDxw17IKWlGe9M
 EszgxWFzoLTMu2uXcYbU6ynb5RRiVqqLqdF1N+CGYiIU5FHzm22a8XbAaL5dtt8T77e1
 O70rSvpxbOn9fiGKoJ6VCBIDa2rHM/aRlk+3SDpbGglv1UooE5dHnxR5v3xD3eyUkZKg
 vYOGbIgghZ1YU8IGEy905ctVjqhZ6sdvX3FoVWqh7K2JqfQLKxWOS/qz2BNa74UOajt3
 oaOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705410160; x=1706014960;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MDOC//9rYljv8JbNJSrklqxInCkoTiR/AirLn143wHQ=;
 b=fTGKY0wZc0H7nyLEfinNFO2VQYK0px8WggFBqe2XGSEvmhVOF5Roo0FJzK48q5+yV+
 HuRngnIxC9WofpR+GSKe33DvqAZPuCO7Gkl/7nUeFv8NkgypjSy3O4sFEG+phwC9Dmeq
 eYRLz6pwnxm5NvmXso/eip1Azxa11eMrjkZHzMpkAOfM8qZXPZPFXZbivHw4NlChi/HI
 J1rFlw/nuK7B474rSleF3uhiroEpKBV9tM0o5vwuQTtFhLRHxNiTlVJ7O1tFoZSMzavO
 nQPJikuzdG3IPY+mVwW/rdGWLSKqtj8Adrqgd9+lfBjx3Q485ydp9c0dqHSLmjBjnzkX
 M3uA==
X-Gm-Message-State: AOJu0YxHYG1inxvc9hNfpP4JMBS3gmtQtu3P+tdE+PV3MDK99L5bm3gK
 HEMT/WboQ/VarmPofvnWnRIN6/6yRmfScO9YkoShBPQpZw==
X-Google-Smtp-Source: AGHT+IEE01QlQfGI0133ekbhI9uILARFGyuyjcA5Ts05TPtTHYcmLDHfAUdK+uIFygJdVsA7FiWQjw==
X-Received: by 2002:a05:600c:6a0b:b0:40e:43ba:610e with SMTP id
 jj11-20020a05600c6a0b00b0040e43ba610emr3808540wmb.66.1705410160545; 
 Tue, 16 Jan 2024 05:02:40 -0800 (PST)
Received: from chigot-Dell.telnowedge.local
 (lmontsouris-659-1-24-67.w81-250.abo.wanadoo.fr. [81.250.175.67])
 by smtp.gmail.com with ESMTPSA id
 d16-20020a05600c34d000b0040e83867d62sm2495316wmq.34.2024.01.16.05.02.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 05:02:40 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/8] intc/grlib_irqmp: add ncpus property
Date: Tue, 16 Jan 2024 14:02:07 +0100
Message-Id: <20240116130213.172358-3-chigot@adacore.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240116130213.172358-1-chigot@adacore.com>
References: <20240116130213.172358-1-chigot@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=chigot@adacore.com; helo=mail-wm1-x331.google.com
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

This adds a "ncpus" property to the "grlib-irqmp" device to be used later,
this required a little refactoring of how we initialize the device (ie: use
realize instead of init).

Co-developed-by: Frederic Konrad <konrad.frederic@yahoo.fr>
Signed-off-by: Clément Chigot <chigot@adacore.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/intc/grlib_irqmp.c | 30 +++++++++++++++++++++---------
 hw/sparc/leon3.c      |  2 +-
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/hw/intc/grlib_irqmp.c b/hw/intc/grlib_irqmp.c
index 11eef62457..744cd64c58 100644
--- a/hw/intc/grlib_irqmp.c
+++ b/hw/intc/grlib_irqmp.c
@@ -1,7 +1,7 @@
 /*
  * QEMU GRLIB IRQMP Emulator
  *
- * (Multiprocessor and extended interrupt not supported)
+ * (Extended interrupt not supported)
  *
  * SPDX-License-Identifier: MIT
  *
@@ -63,6 +63,7 @@ struct IRQMP {
 
     MemoryRegion iomem;
 
+    unsigned int ncpus;
     IRQMPState *state;
     qemu_irq irq;
 };
@@ -326,33 +327,44 @@ static void grlib_irqmp_reset(DeviceState *d)
     irqmp->state->parent = irqmp;
 }
 
-static void grlib_irqmp_init(Object *obj)
+static void grlib_irqmp_realize(DeviceState *dev, Error **errp)
 {
-    IRQMP *irqmp = GRLIB_IRQMP(obj);
-    SysBusDevice *dev = SYS_BUS_DEVICE(obj);
+    IRQMP *irqmp = GRLIB_IRQMP(dev);
 
-    qdev_init_gpio_in(DEVICE(obj), grlib_irqmp_set_irq, MAX_PILS);
-    qdev_init_gpio_out_named(DEVICE(obj), &irqmp->irq, "grlib-irq", 1);
-    memory_region_init_io(&irqmp->iomem, obj, &grlib_irqmp_ops, irqmp,
+    if ((!irqmp->ncpus) || (irqmp->ncpus > IRQMP_MAX_CPU)) {
+        error_setg(errp, "Invalid ncpus properties: "
+                   "%u, must be 0 < ncpus =< %u.", irqmp->ncpus,
+                   IRQMP_MAX_CPU);
+    }
+
+    qdev_init_gpio_in(dev, grlib_irqmp_set_irq, MAX_PILS);
+    qdev_init_gpio_out_named(dev, &irqmp->irq, "grlib-irq", 1);
+    memory_region_init_io(&irqmp->iomem, OBJECT(dev), &grlib_irqmp_ops, irqmp,
                           "irqmp", IRQMP_REG_SIZE);
 
     irqmp->state = g_malloc0(sizeof *irqmp->state);
 
-    sysbus_init_mmio(dev, &irqmp->iomem);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &irqmp->iomem);
 }
 
+static Property grlib_irqmp_properties[] = {
+    DEFINE_PROP_UINT32("ncpus", IRQMP, ncpus, 1),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void grlib_irqmp_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
+    dc->realize = grlib_irqmp_realize;
     dc->reset = grlib_irqmp_reset;
+    device_class_set_props(dc, grlib_irqmp_properties);
 }
 
 static const TypeInfo grlib_irqmp_info = {
     .name          = TYPE_GRLIB_IRQMP,
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(IRQMP),
-    .instance_init = grlib_irqmp_init,
     .class_init    = grlib_irqmp_class_init,
 };
 
diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index b7d81c76f3..b72761b959 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -265,11 +265,11 @@ static void leon3_generic_hw_init(MachineState *machine)
 
     /* Allocate IRQ manager */
     irqmpdev = qdev_new(TYPE_GRLIB_IRQMP);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(irqmpdev), &error_fatal);
     qdev_init_gpio_in_named_with_opaque(DEVICE(cpu), leon3_set_pil_in,
                                         env, "pil", 1);
     qdev_connect_gpio_out_named(irqmpdev, "grlib-irq", 0,
                                 qdev_get_gpio_in_named(DEVICE(cpu), "pil", 0));
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(irqmpdev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(irqmpdev), 0, LEON3_IRQMP_OFFSET);
     env->irq_manager = irqmpdev;
     env->qemu_irq_ack = leon3_irq_manager;
-- 
2.25.1


