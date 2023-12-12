Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA06180F2A6
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 17:31:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD5eQ-0000we-It; Tue, 12 Dec 2023 11:30:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD5e9-0000ur-Vy
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:30:15 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD5e1-000763-89
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:30:12 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a1f37fd4b53so715760866b.1
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 08:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702398602; x=1703003402; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q6IQU5ROwUn//RvfuUSFoOspGxqF5s4e8MRFf4fb5zU=;
 b=Qq9XPdd9PYGPPwPnNA9KES6D/81hx0i0lMrs0A2M4praZ8A5/sFcQha4PST+TO8JYg
 +VoROb4TMiMuuMagnGrxw6SWT7rzRljPwnBZiIH0BaPOGmq1yPJ++v7U4x9fYQZwQcS1
 dkI+SDVMIIhd54e3DCC8KP8F1TdgImnhrXdvKKcPgwNfQ1alYI/zeV0om5XYp8hg6Y1W
 +HH90oJ0q2NxmW53SY6hi1ftAXxB4wWBuzj+wz7x3X78zvFe+oSd1G/G+NpoHH+ayJa3
 mqOdfb7JYWp8c9SbTdJa7TpvUXFK+VKzpIGJhGdgM7RoUC/Y1hCVjX5YtGE2Dt5ppwCj
 L2oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702398602; x=1703003402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q6IQU5ROwUn//RvfuUSFoOspGxqF5s4e8MRFf4fb5zU=;
 b=gMowKGbyiGYHpczZ+YlJ+FMd2W9kjwHnku/mNpXvR5MEvuOhpL0hEPxDeMUvAZ98Mz
 pRYEnCWM8deWovqjMs/bZqgdWe/j5gIGgYT19UNiDAIIa76r8FWirlqObamjZ6nokdZS
 OlC2LAtPJ1LeY9gUiS0vkTzyhLSzYsUSQlHKpDOlywWJ6l11XP2F79ULF8QF0mGzSyzZ
 yRUDuNqoaX7lER5lceDvuBBWCfaImwAgYRlednEa/we5kW4QlKjOEhLxusu2g/enbbW7
 S6lwYaWpWznbV6YuaNHEB0DfTXXb9RCwDxWMix52IVX+Aa2EiuHMUtHBFynivUxCgQf4
 plYg==
X-Gm-Message-State: AOJu0YwOCmxPgldaiawe3PR3mR9iTS5+OLIFaWg+3v4wzi+HVSmcNsN/
 37vJHZoSq/XsgoqRSMqvdVEa7HlHEuzCp+MdFxE=
X-Google-Smtp-Source: AGHT+IGPms6kcaGwylnpZ0Tf8WVdt6LbbFm7Rf8FSv1VjTFbe9r66HsstVt6Q7XcCA6FptfFxEcHOA==
X-Received: by 2002:a17:906:c112:b0:9d3:f436:61e5 with SMTP id
 do18-20020a170906c11200b009d3f43661e5mr3884569ejc.29.1702398602437; 
 Tue, 12 Dec 2023 08:30:02 -0800 (PST)
Received: from m1x-phil.lan ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 rd12-20020a170907a28c00b00a097c5162b0sm6421593ejc.87.2023.12.12.08.30.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Dec 2023 08:30:02 -0800 (PST)
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
Subject: [PATCH 03/33] hw/arm/fsl-imx6ul: Add a local 'gic' variable
Date: Tue, 12 Dec 2023 17:29:03 +0100
Message-ID: <20231212162935.42910-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231212162935.42910-1-philmd@linaro.org>
References: <20231212162935.42910-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
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

The A7MPCore forward the IRQs from its internal GIC.
To make the code clearer, add a 'gic' variable.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/fsl-imx6ul.c | 38 ++++++++++++++------------------------
 1 file changed, 14 insertions(+), 24 deletions(-)

diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
index e37b69a5e1..59032263cf 100644
--- a/hw/arm/fsl-imx6ul.c
+++ b/hw/arm/fsl-imx6ul.c
@@ -156,6 +156,7 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
     FslIMX6ULState *s = FSL_IMX6UL(dev);
+    DeviceState *gic;
     int i;
     char name[NAME_SIZE];
     SysBusDevice *sbd;
@@ -177,6 +178,7 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
                             FSL_IMX6UL_MAX_IRQ + GIC_INTERNAL, &error_abort);
     sysbus_realize(SYS_BUS_DEVICE(&s->a7mpcore), &error_abort);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->a7mpcore), 0, FSL_IMX6UL_A7MPCORE_ADDR);
+    gic = DEVICE(&s->a7mpcore);
 
     sbd = SYS_BUS_DEVICE(&s->a7mpcore);
     d = DEVICE(&s->cpu);
@@ -213,8 +215,7 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
                         FSL_IMX6UL_GPTn_ADDR[i]);
 
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpt[i]), 0,
-                           qdev_get_gpio_in(DEVICE(&s->a7mpcore),
-                                            FSL_IMX6UL_GPTn_IRQ[i]));
+                           qdev_get_gpio_in(gic, FSL_IMX6UL_GPTn_IRQ[i]));
     }
 
     /*
@@ -238,8 +239,7 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
                         FSL_IMX6UL_EPITn_ADDR[i]);
 
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->epit[i]), 0,
-                           qdev_get_gpio_in(DEVICE(&s->a7mpcore),
-                                            FSL_IMX6UL_EPITn_IRQ[i]));
+                           qdev_get_gpio_in(gic, FSL_IMX6UL_EPITn_IRQ[i]));
     }
 
     /*
@@ -276,12 +276,10 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
                         FSL_IMX6UL_GPIOn_ADDR[i]);
 
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio[i]), 0,
-                           qdev_get_gpio_in(DEVICE(&s->a7mpcore),
-                                            FSL_IMX6UL_GPIOn_LOW_IRQ[i]));
+                           qdev_get_gpio_in(gic, FSL_IMX6UL_GPIOn_LOW_IRQ[i]));
 
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio[i]), 1,
-                           qdev_get_gpio_in(DEVICE(&s->a7mpcore),
-                                            FSL_IMX6UL_GPIOn_HIGH_IRQ[i]));
+                           qdev_get_gpio_in(gic, FSL_IMX6UL_GPIOn_HIGH_IRQ[i]));
     }
 
     /*
@@ -335,8 +333,7 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
                         FSL_IMX6UL_SPIn_ADDR[i]);
 
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->spi[i]), 0,
-                           qdev_get_gpio_in(DEVICE(&s->a7mpcore),
-                                            FSL_IMX6UL_SPIn_IRQ[i]));
+                           qdev_get_gpio_in(gic, FSL_IMX6UL_SPIn_IRQ[i]));
     }
 
     /*
@@ -361,8 +358,7 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->i2c[i]), 0, FSL_IMX6UL_I2Cn_ADDR[i]);
 
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->i2c[i]), 0,
-                           qdev_get_gpio_in(DEVICE(&s->a7mpcore),
-                                            FSL_IMX6UL_I2Cn_IRQ[i]));
+                           qdev_get_gpio_in(gic, FSL_IMX6UL_I2Cn_IRQ[i]));
     }
 
     /*
@@ -399,8 +395,7 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
                         FSL_IMX6UL_UARTn_ADDR[i]);
 
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart[i]), 0,
-                           qdev_get_gpio_in(DEVICE(&s->a7mpcore),
-                                            FSL_IMX6UL_UARTn_IRQ[i]));
+                           qdev_get_gpio_in(gic, FSL_IMX6UL_UARTn_IRQ[i]));
     }
 
     /*
@@ -449,12 +444,10 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
                         FSL_IMX6UL_ENETn_ADDR[i]);
 
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->eth[i]), 0,
-                           qdev_get_gpio_in(DEVICE(&s->a7mpcore),
-                                            FSL_IMX6UL_ENETn_IRQ[i]));
+                           qdev_get_gpio_in(gic, FSL_IMX6UL_ENETn_IRQ[i]));
 
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->eth[i]), 1,
-                           qdev_get_gpio_in(DEVICE(&s->a7mpcore),
-                                            FSL_IMX6UL_ENETn_TIMER_IRQ[i]));
+                           qdev_get_gpio_in(gic, FSL_IMX6UL_ENETn_TIMER_IRQ[i]));
     }
 
     /*
@@ -490,8 +483,7 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->usb[i]), 0,
                         FSL_IMX6UL_USB02_USBn_ADDR[i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->usb[i]), 0,
-                           qdev_get_gpio_in(DEVICE(&s->a7mpcore),
-                                            FSL_IMX6UL_USBn_IRQ[i]));
+                           qdev_get_gpio_in(gic, FSL_IMX6UL_USBn_IRQ[i]));
     }
 
     /*
@@ -516,8 +508,7 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
                         FSL_IMX6UL_USDHCn_ADDR[i]);
 
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->usdhc[i]), 0,
-                           qdev_get_gpio_in(DEVICE(&s->a7mpcore),
-                                            FSL_IMX6UL_USDHCn_IRQ[i]));
+                           qdev_get_gpio_in(gic, FSL_IMX6UL_USDHCn_IRQ[i]));
     }
 
     /*
@@ -549,8 +540,7 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt[i]), 0,
                         FSL_IMX6UL_WDOGn_ADDR[i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->wdt[i]), 0,
-                           qdev_get_gpio_in(DEVICE(&s->a7mpcore),
-                                            FSL_IMX6UL_WDOGn_IRQ[i]));
+                           qdev_get_gpio_in(gic, FSL_IMX6UL_WDOGn_IRQ[i]));
     }
 
     /*
-- 
2.41.0


