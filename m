Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 422E280F2AB
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 17:31:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD5en-0001Rm-Mi; Tue, 12 Dec 2023 11:30:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD5eB-0000vl-SE
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:30:16 -0500
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD5e9-0007Cs-Ow
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:30:15 -0500
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2c9e9c2989dso79323771fa.0
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 08:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702398611; x=1703003411; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ntmhn8CuDxjNGoVZ5yGIEeRznutb1/fx3IdQEKhFga0=;
 b=WzMZ6DQyDgC3e/937XNwSe9dXEys4VG+R2ENy/tbyGl/bDx49hEy9eyjDWyVgZmmlH
 4s4B6xtrROXPxXQda7IMZTxFd1xBtWjGvLJErYV8FDpa3hFxKJvn/1m3fp+MXRb1ftAk
 G1xUok4fPFH2zVHoZBHW0HgAhrr8nKabNsbx+B8KjgwDxPilpq7DowSlirUzN50pccBW
 EnhsNb3+TmZq5Dv8t3txsnL2LF4NH7a0zUeWA3nAZmIevLg97hWS/b3lBsoZeB6MAAGh
 eRGCCPyPk8QjEZU3CEuC+Ohx7RXCNh+Rmiu4GI13JGZz0TpT665SaKazjfmJusbCj6J7
 0gIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702398611; x=1703003411;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ntmhn8CuDxjNGoVZ5yGIEeRznutb1/fx3IdQEKhFga0=;
 b=TbH/QTZrVJlUStQSaZ3gihfqxW8X9se6jQ5W4OL7HLhmqT9wxCTVnHVzOwHaUr4lGg
 esGNG69tsepzrUsegTzcWixD1jKPPW9GJ72R29JTPPPMmQYnxe90yaN7F2U3itcQPAgu
 R+W7ngORzQyhan7iLYpZuKG8SSpPZWKQp59BHzIzqDZWLEg2OI6GUWbXiFwGen7es7cB
 nvQsHTcWDJ1oim/rw7hPz84dFBuFA0yRbbkf5+XRQd95KY0oxP+4I8RCbyUPd1bx2Y+K
 PdeDBoT1CLtRNL/Cpb74DQYhcAmk4O10D479UAuqrek8Q+YGNU6M4tHvcYgDObr0FCkM
 +fYw==
X-Gm-Message-State: AOJu0YzKM74SRQpD2lsqf6ptYEKYGxUqZ2jIe77mFtSb+r310fqqKyvC
 BArYXvgMeKZxOVtaFhsPIJAokeEmHNpcxSplfm0=
X-Google-Smtp-Source: AGHT+IHmcKLv23YcK+tsyfDylj0DqqIiRyVrHKUDnOrMisblwcfnWQWZ8TIDJqz1FNLpYJRB+MzSrA==
X-Received: by 2002:a05:651c:b0c:b0:2cb:2f4a:4ee1 with SMTP id
 b12-20020a05651c0b0c00b002cb2f4a4ee1mr2683827ljr.11.1702398610911; 
 Tue, 12 Dec 2023 08:30:10 -0800 (PST)
Received: from m1x-phil.lan ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 c27-20020a50d65b000000b0054c9bbd07e7sm5049547edj.54.2023.12.12.08.30.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Dec 2023 08:30:10 -0800 (PST)
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
Subject: [PATCH 04/33] hw/arm/fsl-imx7: Add a local 'gic' variable
Date: Tue, 12 Dec 2023 17:29:04 +0100
Message-ID: <20231212162935.42910-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231212162935.42910-1-philmd@linaro.org>
References: <20231212162935.42910-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x234.google.com
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
 hw/arm/fsl-imx7.c | 38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
index 474cfdc87c..a283dcb45f 100644
--- a/hw/arm/fsl-imx7.c
+++ b/hw/arm/fsl-imx7.c
@@ -163,6 +163,7 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
     FslIMX7State *s = FSL_IMX7(dev);
+    DeviceState *gic;
     Object *o;
     int i;
     qemu_irq irq;
@@ -209,6 +210,7 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
 
     sysbus_realize(SYS_BUS_DEVICE(&s->a7mpcore), &error_abort);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->a7mpcore), 0, FSL_IMX7_A7MPCORE_ADDR);
+    gic = DEVICE(&s->a7mpcore);
 
     for (i = 0; i < smp_cpus; i++) {
         SysBusDevice *sbd = SYS_BUS_DEVICE(&s->a7mpcore);
@@ -252,8 +254,7 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
         sysbus_realize(SYS_BUS_DEVICE(&s->gpt[i]), &error_abort);
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpt[i]), 0, FSL_IMX7_GPTn_ADDR[i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpt[i]), 0,
-                           qdev_get_gpio_in(DEVICE(&s->a7mpcore),
-                                            FSL_IMX7_GPTn_IRQ[i]));
+                           qdev_get_gpio_in(gic, FSL_IMX7_GPTn_IRQ[i]));
     }
 
     /*
@@ -295,12 +296,10 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
                         FSL_IMX7_GPIOn_ADDR[i]);
 
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio[i]), 0,
-                           qdev_get_gpio_in(DEVICE(&s->a7mpcore),
-                                            FSL_IMX7_GPIOn_LOW_IRQ[i]));
+                           qdev_get_gpio_in(gic, FSL_IMX7_GPIOn_LOW_IRQ[i]));
 
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio[i]), 1,
-                           qdev_get_gpio_in(DEVICE(&s->a7mpcore),
-                                            FSL_IMX7_GPIOn_HIGH_IRQ[i]));
+                           qdev_get_gpio_in(gic, FSL_IMX7_GPIOn_HIGH_IRQ[i]));
     }
 
     /*
@@ -352,8 +351,7 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->spi[i]), 0,
                         FSL_IMX7_SPIn_ADDR[i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->spi[i]), 0,
-                           qdev_get_gpio_in(DEVICE(&s->a7mpcore),
-                                            FSL_IMX7_SPIn_IRQ[i]));
+                           qdev_get_gpio_in(gic, FSL_IMX7_SPIn_IRQ[i]));
     }
 
     /*
@@ -378,8 +376,7 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->i2c[i]), 0, FSL_IMX7_I2Cn_ADDR[i]);
 
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->i2c[i]), 0,
-                           qdev_get_gpio_in(DEVICE(&s->a7mpcore),
-                                            FSL_IMX7_I2Cn_IRQ[i]));
+                           qdev_get_gpio_in(gic, FSL_IMX7_I2Cn_IRQ[i]));
     }
 
     /*
@@ -413,7 +410,7 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->uart[i]), 0, FSL_IMX7_UARTn_ADDR[i]);
 
-        irq = qdev_get_gpio_in(DEVICE(&s->a7mpcore), FSL_IMX7_UARTn_IRQ[i]);
+        irq = qdev_get_gpio_in(gic, FSL_IMX7_UARTn_IRQ[i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart[i]), 0, irq);
     }
 
@@ -451,9 +448,9 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->eth[i]), 0, FSL_IMX7_ENETn_ADDR[i]);
 
-        irq = qdev_get_gpio_in(DEVICE(&s->a7mpcore), FSL_IMX7_ENET_IRQ(i, 0));
+        irq = qdev_get_gpio_in(gic, FSL_IMX7_ENET_IRQ(i, 0));
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->eth[i]), 0, irq);
-        irq = qdev_get_gpio_in(DEVICE(&s->a7mpcore), FSL_IMX7_ENET_IRQ(i, 3));
+        irq = qdev_get_gpio_in(gic, FSL_IMX7_ENET_IRQ(i, 3));
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->eth[i]), 1, irq);
     }
 
@@ -480,7 +477,7 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->usdhc[i]), 0,
                         FSL_IMX7_USDHCn_ADDR[i]);
 
-        irq = qdev_get_gpio_in(DEVICE(&s->a7mpcore), FSL_IMX7_USDHCn_IRQ[i]);
+        irq = qdev_get_gpio_in(gic, FSL_IMX7_USDHCn_IRQ[i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->usdhc[i]), 0, irq);
     }
 
@@ -519,8 +516,7 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt[i]), 0, FSL_IMX7_WDOGn_ADDR[i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->wdt[i]), 0,
-                           qdev_get_gpio_in(DEVICE(&s->a7mpcore),
-                                            FSL_IMX7_WDOGn_IRQ[i]));
+                           qdev_get_gpio_in(gic, FSL_IMX7_WDOGn_IRQ[i]));
     }
 
     /*
@@ -596,13 +592,13 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
     sysbus_realize(SYS_BUS_DEVICE(&s->pcie), &error_abort);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->pcie), 0, FSL_IMX7_PCIE_REG_ADDR);
 
-    irq = qdev_get_gpio_in(DEVICE(&s->a7mpcore), FSL_IMX7_PCI_INTA_IRQ);
+    irq = qdev_get_gpio_in(gic, FSL_IMX7_PCI_INTA_IRQ);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->pcie), 0, irq);
-    irq = qdev_get_gpio_in(DEVICE(&s->a7mpcore), FSL_IMX7_PCI_INTB_IRQ);
+    irq = qdev_get_gpio_in(gic, FSL_IMX7_PCI_INTB_IRQ);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->pcie), 1, irq);
-    irq = qdev_get_gpio_in(DEVICE(&s->a7mpcore), FSL_IMX7_PCI_INTC_IRQ);
+    irq = qdev_get_gpio_in(gic, FSL_IMX7_PCI_INTC_IRQ);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->pcie), 2, irq);
-    irq = qdev_get_gpio_in(DEVICE(&s->a7mpcore), FSL_IMX7_PCI_INTD_IRQ);
+    irq = qdev_get_gpio_in(gic, FSL_IMX7_PCI_INTD_IRQ);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->pcie), 3, irq);
 
     /*
@@ -631,7 +627,7 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->usb[i]), 0,
                         FSL_IMX7_USBn_ADDR[i]);
 
-        irq = qdev_get_gpio_in(DEVICE(&s->a7mpcore), FSL_IMX7_USBn_IRQ[i]);
+        irq = qdev_get_gpio_in(gic, FSL_IMX7_USBn_IRQ[i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->usb[i]), 0, irq);
 
         snprintf(name, NAME_SIZE, "usbmisc%d", i);
-- 
2.41.0


