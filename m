Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE0880F2DA
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 17:34:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD5gQ-0007D6-Fc; Tue, 12 Dec 2023 11:32:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD5gH-0006l1-KK
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:32:27 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD5gF-0007kK-2h
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:32:25 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40c2c5a8150so54661705e9.2
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 08:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702398741; x=1703003541; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kzj0QIV76sF9kTXgAEz5Ob/+QDKCBIz99cjFrJTa8Ik=;
 b=qkk9YcAXo3o/ieDCuF6l4aWZxMmmnuHbIiGILKyxbmir3w87CIlc2z5OVO4W4EXYxh
 ie8NT+BOjvszE9VuUQ/Ddak5u+ibsAzh8A9ok+8nX04PpD4ydYKGgscGGv6fNlm1PYVu
 nFokBJNcmhbgmnlUQccgQUFHjwEX+SH3maax9uEbQdxLXe+9KGDyv0VswuX8l4V64n76
 aDD7Ff/Srw8VJeFuAbXOw4aun+xMC/PdxrVJ/XgOcw/O7Qs785m63bq6YCzurvzb7yIP
 iCjWU59dffpYV/odgBGP17+lKmhYW/J32389s14jVRfFE386eLo39/jarzyTlhCR1PNQ
 Ov8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702398741; x=1703003541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kzj0QIV76sF9kTXgAEz5Ob/+QDKCBIz99cjFrJTa8Ik=;
 b=UGssJEPqyWi+i1OxQ9wnudE3pqqbmiV+8OrGeT2IohxuXH81qKwbaIcABfoz86u/HK
 izqfnCbahbUdyjnbZ6Ss0euKCSWDVmpykB/hZPqiQvgSMO3P0bv6Ezn61pV2/npor14M
 /RYWIUf5nu9liGPxJ7rdv69vvw9LCcdMOBVB9wGQE3TW9It0fq+kZThPsgGGRwDgUORI
 UT9p5tUWn0XulB8dt47Z8Ul5BwS0uSgx/N6T6teLQKsL+kTz2Is6L+Qs7/iS91CeV//P
 hFupnPMKJKH71fOOYubAUreot3Uj6ewauDr/S22M0kS6+/F8Y3qk7wY3MidDY2jvu2AI
 JkjA==
X-Gm-Message-State: AOJu0YySxDq5AZPARlMutUTW/4uq3XCUsqShdjaZ8CMWIo4EY744sALq
 qDr2yWWZ5x2Pqox4F62e8egeabhRRNaGJ14MAr4=
X-Google-Smtp-Source: AGHT+IFvh0mZGIpHP1qTEcoTuOmgm6gU4WNQO3j50QB9RftB4/aBhWiHlumMR0/nxRxAF0gdqqmIug==
X-Received: by 2002:a05:600c:1688:b0:40b:369e:6951 with SMTP id
 k8-20020a05600c168800b0040b369e6951mr3106268wmn.28.1702398740782; 
 Tue, 12 Dec 2023 08:32:20 -0800 (PST)
Received: from m1x-phil.lan ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 t13-20020a05600c450d00b00405c7591b09sm17152033wmo.35.2023.12.12.08.32.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Dec 2023 08:32:20 -0800 (PST)
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
Subject: [PATCH 22/33] hw/arm/aspeed_ast2600: Let the A7MPcore create/wire the
 CPU cores
Date: Tue, 12 Dec 2023 17:29:22 +0100
Message-ID: <20231212162935.42910-23-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231212162935.42910-1-philmd@linaro.org>
References: <20231212162935.42910-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Set the properties on the a7mpcore object to let it create and
wire the CPU cores. Remove the redundant code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/arm/aspeed_soc.h |  1 -
 hw/arm/aspeed_ast2600.c     | 58 ++++++++++++-------------------------
 2 files changed, 18 insertions(+), 41 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 2f51d78e22..a824679b1e 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -109,7 +109,6 @@ struct Aspeed2600SoCState {
     AspeedSoCState parent;
 
     CortexMPPrivState a7mpcore;
-    ARMCPU cpu[ASPEED_CPUS_NUM]; /* XXX belong to a7mpcore */
 };
 
 #define TYPE_ASPEED2600_SOC "aspeed2600-soc"
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index 88e2a23514..1000fac675 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -156,10 +156,6 @@ static void aspeed_soc_ast2600_init(Object *obj)
         g_assert_not_reached();
     }
 
-    for (i = 0; i < sc->num_cpus; i++) {
-        object_initialize_child(obj, "cpu[*]", &a->cpu[i], sc->cpu_type);
-    }
-
     snprintf(typename, sizeof(typename), "aspeed.scu-%s", socname);
     object_initialize_child(obj, "scu", &s->scu, typename);
     qdev_prop_set_uint32(DEVICE(&s->scu), "silicon-rev",
@@ -270,11 +266,6 @@ static void aspeed_soc_ast2600_init(Object *obj)
  *
  * https://developer.arm.com/documentation/ddi0388/e/the-system-control-coprocessors/summary-of-system-control-coprocessor-registers/multiprocessor-affinity-register
  */
-static uint64_t aspeed_calc_affinity(int cpu)
-{
-    return (0xf << ARM_AFF1_SHIFT) | cpu;
-}
-
 static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
 {
     int i;
@@ -284,6 +275,8 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     Error *err = NULL;
     qemu_irq irq;
     g_autofree char *sram_name = NULL;
+    DeviceState *mpdev;
+    CortexMPPrivState *mppriv;
 
     /* Default boot region (SPI memory or ROMs) */
     memory_region_init(&s->spi_boot_container, OBJECT(s),
@@ -305,42 +298,26 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
                                   "aspeed.emmc-boot-controller",
                                   sc->memmap[ASPEED_DEV_EMMC_BC], 0x1000);
 
-    /* CPU */
-    for (i = 0; i < sc->num_cpus; i++) {
-        if (sc->num_cpus > 1) {
-            object_property_set_int(OBJECT(&a->cpu[i]), "reset-cbar",
-                                    ASPEED_A7MPCORE_ADDR, &error_abort);
-        }
-        object_property_set_int(OBJECT(&a->cpu[i]), "mp-affinity",
-                                aspeed_calc_affinity(i), &error_abort);
-
-        object_property_set_int(OBJECT(&a->cpu[i]), "cntfrq", 1125000000,
-                                &error_abort);
-        object_property_set_bool(OBJECT(&a->cpu[i]), "neon", false,
-                                &error_abort);
-        object_property_set_bool(OBJECT(&a->cpu[i]), "vfp-d32", false,
-                                &error_abort);
-        object_property_set_link(OBJECT(&a->cpu[i]), "memory",
-                                 OBJECT(s->memory), &error_abort);
-
-        if (!qdev_realize(DEVICE(&a->cpu[i]), NULL, errp)) {
-            return;
-        }
-    }
-
     /* A7MPCORE */
-    object_property_set_int(OBJECT(&a->a7mpcore), "num-cores", sc->num_cpus,
-                            &error_abort);
-    object_property_set_int(OBJECT(&a->a7mpcore), "num-irq",
-                            ROUND_UP(AST2600_MAX_IRQ + GIC_INTERNAL, 32),
-                            &error_abort);
-
+    mpdev = DEVICE(&a->a7mpcore);
+    qdev_prop_set_uint32(mpdev, "cluster-id", 0xf);
+    qdev_prop_set_uint32(mpdev, "num-cores", sc->num_cpus);
+    qdev_prop_set_string(mpdev, "cpu-type", sc->cpu_type);
+    qdev_prop_set_uint64(mpdev, "cpu-freq-hz", 1125000000);
+    qdev_prop_set_bit(mpdev, "cpu-has-neon", false);
+    qdev_prop_set_bit(mpdev, "cpu-has-vfp-d32", false);
+    qdev_prop_set_uint64(mpdev, "cpu-reset-cbar", ASPEED_A7MPCORE_ADDR);
+    object_property_set_link(OBJECT(&a->a7mpcore), "cpu-memory",
+                             OBJECT(s->memory), &error_abort);
+    qdev_prop_set_uint32(mpdev, "gic-spi-num",
+                         ROUND_UP(AST2600_MAX_IRQ + GIC_INTERNAL, 32));
     sysbus_realize(SYS_BUS_DEVICE(&a->a7mpcore), &error_abort);
     aspeed_mmio_map(s, SYS_BUS_DEVICE(&a->a7mpcore), 0, ASPEED_A7MPCORE_ADDR);
+    mppriv = CORTEX_MPCORE_PRIV(&a->a7mpcore);
 
     for (i = 0; i < sc->num_cpus; i++) {
         SysBusDevice *sbd = SYS_BUS_DEVICE(&a->a7mpcore);
-        DeviceState  *d   = DEVICE(&a->cpu[i]);
+        DeviceState  *d   = DEVICE(mppriv->cpu[i]);
 
         irq = qdev_get_gpio_in(d, ARM_CPU_IRQ);
         sysbus_connect_irq(sbd, i, irq);
@@ -353,7 +330,8 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     }
 
     /* SRAM */
-    sram_name = g_strdup_printf("aspeed.sram.%d", CPU(&a->cpu[0])->cpu_index);
+    sram_name = g_strdup_printf("aspeed.sram.%d",
+                                CPU(mppriv->cpu[0])->cpu_index);
     memory_region_init_ram(&s->sram, OBJECT(s), sram_name, sc->sram_size, &err);
     if (err) {
         error_propagate(errp, err);
-- 
2.41.0


