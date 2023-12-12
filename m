Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9C980F29D
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 17:31:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD5eC-0000uM-A8; Tue, 12 Dec 2023 11:30:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD5dv-0000sP-KP
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:30:00 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD5dt-0006yT-G8
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:29:59 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a1ceae92ab6so786615966b.0
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 08:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702398596; x=1703003396; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wkDSJuoxyBvjP1+SfrO4Sh4Op/iARoVIVoTcT3nNpHc=;
 b=thwcw/xNv6ukhKumJblnlxq/O7OHMzeZXgcTOeY0nsl6qYVCaBHihGCwk33V2Aq0iv
 KUtBkJslZgdinGnIdNuUMUvijxGT4o81t4e088xaRsVOX2JJduolXFAKmlc46TlMxE2b
 0dsGu9OeRoHAt/XBaUfkh7xWhX15fKLTsPhcY1gY8sg9YBo0hRhvh6vFeSMYexQi/Jve
 1by6F5ozPrnB6PCrRlo1uDOvMwz2oxM0qQRkcvBHC66XOwAVCVY4hke+5/MMJ54wF+q3
 TUQv1K4zqQg0oa2eF9vG3XQKEzHYirPPe8p3amOFG7stql3ZEYRfxmPOOwLOD1q2LBi5
 XYzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702398596; x=1703003396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wkDSJuoxyBvjP1+SfrO4Sh4Op/iARoVIVoTcT3nNpHc=;
 b=IAJwtOQJa57c4AmekVraaryJ5OkjlSpzB+hAe3kqQmXPeoLazdAh2xQnAiHIfc0fBF
 cF7IddWRmtj6JQUqU4RTEYWuu4gkiDlAld8pJOrYQXfadPmwaG4Z9P2wiuccbL/R02+9
 E6JwbrKu6Bfwoa4z+oX7Qp6SjDLs+a6DCf/XqM4a+WKeVaTQ6y+UF/Wdh9jdjy/o530+
 +fSI2IppIqu+Y7Nt2VhbKlu8/vA/hW9WZ+73YaCWTdzr3t160XFzs7pbUhYa1EhxSxR1
 MzllJIedI0V8gkjjht0kVQdh5EnuvCx903SuxvPPbSHy4Ejmvdet/LaUqNGh+eHR1+CR
 ctlg==
X-Gm-Message-State: AOJu0Yyq+2a/ZLG/HHZGrmhrU7NXqUlqW5YbgwLFsSDfSIcCzskmb5QR
 iK+giaSLIePB8w0K+IWgZhyXSzvwJhA8DhDGDR8=
X-Google-Smtp-Source: AGHT+IGsFKkYN3lv0vuskgvb8T6VOZUqpgjBDYUxlBVV6cC9UkAdsg4Jarhsh0UTbfBa0oxIEC9ZXg==
X-Received: by 2002:a17:906:8:b0:a18:8cf8:d632 with SMTP id
 8-20020a170906000800b00a188cf8d632mr2786947eja.20.1702398595847; 
 Tue, 12 Dec 2023 08:29:55 -0800 (PST)
Received: from m1x-phil.lan ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 ss22-20020a170907c01600b00a1d781068e8sm6477375ejc.8.2023.12.12.08.29.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Dec 2023 08:29:55 -0800 (PST)
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
Subject: [PATCH 02/33] hw/arm/fsl-imx6: Add a local 'gic' variable
Date: Tue, 12 Dec 2023 17:29:02 +0100
Message-ID: <20231212162935.42910-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231212162935.42910-1-philmd@linaro.org>
References: <20231212162935.42910-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
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

The A9MPCore forward the IRQs from its internal GIC.
To make the code clearer, add a 'gic' variable.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/fsl-imx6.c | 37 +++++++++++++------------------------
 1 file changed, 13 insertions(+), 24 deletions(-)

diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index 7dc42cbfe6..f6edbd7465 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -111,6 +111,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
     uint16_t i;
     Error *err = NULL;
     unsigned int smp_cpus = ms->smp.cpus;
+    DeviceState *gic = DEVICE(&s->a9mpcore);
 
     if (smp_cpus > FSL_IMX6_NUM_CPUS) {
         error_setg(errp, "%s: Only %d CPUs are supported (%d requested)",
@@ -186,8 +187,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->uart[i]), 0, serial_table[i].addr);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart[i]), 0,
-                           qdev_get_gpio_in(DEVICE(&s->a9mpcore),
-                                            serial_table[i].irq));
+                           qdev_get_gpio_in(gic, serial_table[i].irq));
     }
 
     s->gpt.ccm = IMX_CCM(&s->ccm);
@@ -198,8 +198,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
 
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpt), 0, FSL_IMX6_GPT_ADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpt), 0,
-                       qdev_get_gpio_in(DEVICE(&s->a9mpcore),
-                                        FSL_IMX6_GPT_IRQ));
+                       qdev_get_gpio_in(gic, FSL_IMX6_GPT_IRQ));
 
     /* Initialize all EPIT timers */
     for (i = 0; i < FSL_IMX6_NUM_EPITS; i++) {
@@ -219,8 +218,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->epit[i]), 0, epit_table[i].addr);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->epit[i]), 0,
-                           qdev_get_gpio_in(DEVICE(&s->a9mpcore),
-                                            epit_table[i].irq));
+                           qdev_get_gpio_in(gic, epit_table[i].irq));
     }
 
     /* Initialize all I2C */
@@ -240,8 +238,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->i2c[i]), 0, i2c_table[i].addr);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->i2c[i]), 0,
-                           qdev_get_gpio_in(DEVICE(&s->a9mpcore),
-                                            i2c_table[i].irq));
+                           qdev_get_gpio_in(gic, i2c_table[i].irq));
     }
 
     /* Initialize all GPIOs */
@@ -298,11 +295,9 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio[i]), 0, gpio_table[i].addr);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio[i]), 0,
-                           qdev_get_gpio_in(DEVICE(&s->a9mpcore),
-                                            gpio_table[i].irq_low));
+                           qdev_get_gpio_in(gic, gpio_table[i].irq_low));
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio[i]), 1,
-                           qdev_get_gpio_in(DEVICE(&s->a9mpcore),
-                                            gpio_table[i].irq_high));
+                           qdev_get_gpio_in(gic, gpio_table[i].irq_high));
     }
 
     /* Initialize all SDHC */
@@ -329,8 +324,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->esdhc[i]), 0, esdhc_table[i].addr);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->esdhc[i]), 0,
-                           qdev_get_gpio_in(DEVICE(&s->a9mpcore),
-                                            esdhc_table[i].irq));
+                           qdev_get_gpio_in(gic, esdhc_table[i].irq));
     }
 
     /* USB */
@@ -351,8 +345,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->usb[i]), 0,
                         FSL_IMX6_USBOH3_USB_ADDR + i * 0x200);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->usb[i]), 0,
-                           qdev_get_gpio_in(DEVICE(&s->a9mpcore),
-                                            FSL_IMX6_USBn_IRQ[i]));
+                           qdev_get_gpio_in(gic, FSL_IMX6_USBn_IRQ[i]));
     }
 
     /* Initialize all ECSPI */
@@ -375,8 +368,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->spi[i]), 0, spi_table[i].addr);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->spi[i]), 0,
-                           qdev_get_gpio_in(DEVICE(&s->a9mpcore),
-                                            spi_table[i].irq));
+                           qdev_get_gpio_in(gic, spi_table[i].irq));
     }
 
     object_property_set_uint(OBJECT(&s->eth), "phy-num", s->phy_num,
@@ -387,11 +379,9 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->eth), 0, FSL_IMX6_ENET_ADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->eth), 0,
-                       qdev_get_gpio_in(DEVICE(&s->a9mpcore),
-                                        FSL_IMX6_ENET_MAC_IRQ));
+                       qdev_get_gpio_in(gic, FSL_IMX6_ENET_MAC_IRQ));
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->eth), 1,
-                       qdev_get_gpio_in(DEVICE(&s->a9mpcore),
-                                        FSL_IMX6_ENET_MAC_1588_IRQ));
+                       qdev_get_gpio_in(gic, FSL_IMX6_ENET_MAC_1588_IRQ));
 
     /*
      * SNVS
@@ -418,8 +408,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt[i]), 0, FSL_IMX6_WDOGn_ADDR[i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->wdt[i]), 0,
-                           qdev_get_gpio_in(DEVICE(&s->a9mpcore),
-                                            FSL_IMX6_WDOGn_IRQ[i]));
+                           qdev_get_gpio_in(gic, FSL_IMX6_WDOGn_IRQ[i]));
     }
 
     /* ROM memory */
-- 
2.41.0


