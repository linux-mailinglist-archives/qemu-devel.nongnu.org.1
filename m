Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF838251DD
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 11:26:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLhNb-0007kS-DD; Fri, 05 Jan 2024 05:24:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rLhNZ-0007k9-96
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 05:24:41 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rLhNW-0004LL-NG
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 05:24:41 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40d87df95ddso12480805e9.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 02:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1704450276; x=1705055076; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QPZTQwMMmpeM+k/XenFcBsNQhX/GrfhY4n6lvzqKbec=;
 b=Nxwtko4SMku5TNUYxcs+pRTUrefGjVMGBW+zMtEYjhEfEncEUfvTnBGK4In3OQ9e+k
 +b4v1Wl/3u2kkT1XCm+faS6mZ2c5Is5j2FJjgo+WguAIFoRDjYQ0rZezVUPuyAzkyOtD
 bPZzm5egSP9SnEbrAnYs75BhgcIiZ/QcbD5UrtfcNjFwFU2vc+wkGYkCu6BjbRpNsMfD
 A9nRaQRPKhBqP213PmTxY9Ap45/riwbH/qdHkAxk0cQxxjoCTv/W87OPYySnjUYpZd6N
 z2jykEIMfcMpBGBNwCMNwxdIuRBaUeAB5RQ5vA5fktUcULplFJW6mCXoZTHPj27qEcC5
 mgRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704450276; x=1705055076;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QPZTQwMMmpeM+k/XenFcBsNQhX/GrfhY4n6lvzqKbec=;
 b=CVc+QHHkZ9afRu5xdUOCOLcR97CPkXOR1fNRpmLnpFrsL4glcKds+TqJdG/PgrYIt0
 lfHIKoCbHEuQHIEAMUKnD9+eNQ2NEZ9iQUsVFdxR7IdwIb9ZlLWWMolYl0ovZ87Fd8Fs
 U7anPuS+eJhaXsay8uofi4wGnnLAAieOqhpVFgI3+pcmGgURfBRPt29yeSntwJ9XDmCR
 3dJ2olxKbJnbKD0PWt0OPOfr8SCrrYR69e/uaGZHc1LaYCPAuLI+b+KVshihiJEA9uK2
 YvaY1hHd23oLRQoPOgmJwCJRFQ9VlT9Bvxm/cT82jkiNsIs4x0SDR4eMR+7QZESrzmUc
 bi6g==
X-Gm-Message-State: AOJu0YwwEp1ngJlzpJ3sjdCS3qBP8KJjqwXZx2e+zaZJqQzEVApDpo9v
 98BcKYXowh4N4m1cuaqiDAZlAS7cH3YX9hDSqM2lT1AQYQ==
X-Google-Smtp-Source: AGHT+IGEzZL43NJOVKH+2aW7p92HZORm9rDDxuvE+KyiSNpMBl4OvVwP+IujTRxTD5l0dm0+JWUfyg==
X-Received: by 2002:a05:600c:3b20:b0:40d:88ef:dc07 with SMTP id
 m32-20020a05600c3b2000b0040d88efdc07mr513860wms.81.1704450276682; 
 Fri, 05 Jan 2024 02:24:36 -0800 (PST)
Received: from chigot-Dell.home ([2a01:cb15:8123:8100:323e:281a:689:2b09])
 by smtp.gmail.com with ESMTPSA id
 v8-20020a05600c444800b0040d934f48d3sm1117548wmn.32.2024.01.05.02.24.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jan 2024 02:24:36 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>
Subject: [PATCH 2/9] intc/grlib_irqmp: add ncpus property
Date: Fri,  5 Jan 2024 11:24:14 +0100
Message-Id: <20240105102421.163554-3-chigot@adacore.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240105102421.163554-1-chigot@adacore.com>
References: <20240105102421.163554-1-chigot@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=chigot@adacore.com; helo=mail-wm1-x330.google.com
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
---
 hw/intc/grlib_irqmp.c | 30 +++++++++++++++++++++---------
 hw/sparc/leon3.c      |  2 +-
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/hw/intc/grlib_irqmp.c b/hw/intc/grlib_irqmp.c
index c994d5dacc..2bacc0ff56 100644
--- a/hw/intc/grlib_irqmp.c
+++ b/hw/intc/grlib_irqmp.c
@@ -1,7 +1,7 @@
 /*
  * QEMU GRLIB IRQMP Emulator
  *
- * (Multiprocessor and extended interrupt not supported)
+ * (Extended interrupt not supported)
  *
  * Copyright (c) 2010-2024 AdaCore
  *
@@ -61,6 +61,7 @@ struct IRQMP {
 
     MemoryRegion iomem;
 
+    unsigned int ncpus;
     IRQMPState *state;
     qemu_irq irq;
 };
@@ -324,33 +325,44 @@ static void grlib_irqmp_reset(DeviceState *d)
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
index 58784c099a..7b9809b81f 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -263,11 +263,11 @@ static void leon3_generic_hw_init(MachineState *machine)
 
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


