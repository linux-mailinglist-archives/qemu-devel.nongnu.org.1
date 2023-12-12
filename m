Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A31B280F2BC
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 17:32:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD5el-0001Il-UI; Tue, 12 Dec 2023 11:30:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD5eP-00017N-JR
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:30:30 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD5eO-0007Ln-02
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:30:29 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a1f37fd4b53so715830366b.1
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 08:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702398625; x=1703003425; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SnL91noqzEJ/OmxDVsmRBFeCwxiwF12rVXOPGYxs90k=;
 b=H/ra4LosmvZvn0PwFLwhfm8t+otQO/aNdC90ZfdqobFNR17wEfmMv3Ax7wBJtg8sbQ
 ONsLhXtVeAEb0tKrH/FBEUIU8q1/V+MM3e9HpI9wRGSCluWT3hM8Srx+QS/lz/yL0s8g
 epdIJ8cN9xiIwGpbFBUhxXb3Ttu1J3lSftPO7rL9T78mZjR1v+o6Yf+BIZX31UrGEg0V
 +gBn7V9mbfwixLPXSZ4GeHfBJChMSqV7kY8CiAgnwiBtpIpX9PLihD2YurLVhdFoAXWA
 dxCQWrz6NjVTG+rQXRdxaclL2YYGsJwGxD9zsStnqNhGPErxOnPIzbjSW+PngnDE0xp3
 aLOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702398625; x=1703003425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SnL91noqzEJ/OmxDVsmRBFeCwxiwF12rVXOPGYxs90k=;
 b=VASJpdB6sgcFolpB9yef3ma2R9hbXRyWMiApaLi8O6cN3hOqy8jP/qVrachZveam0R
 Rwj4h4Hamrlx8sWYKunLI2t2bo6yXmwSX39fwtABmFZ9PnPVJYNjZnMZaiOC7sqDUO/v
 j3tYA/AltNk74vQYzPHXT1quKdUWEq+6fuy8w0kRluQ60Dy8qZO2crlLUPTPEXqHARdx
 kxq8qC8iNV0dNbMKhflcHOaza6lX2oeVqY06Gtjj1YKpdVxs/vENPTdPkHbZ0GZqIts6
 V9BKpr8ofMj+uiSncB0oYgvvf4wQQ8QlNo45jesgOxw3/W5nAR/y0RJ7vfkz/8e+WNdC
 OPDw==
X-Gm-Message-State: AOJu0YyTIT3D3PjXQlZXIr4aIkhBuYV9fmYHtdtZ3KX77jXMdDRmQQ9g
 g2+cm8XLiFB9LFcObO2a26F3Dm86PiZ8loxnoXM=
X-Google-Smtp-Source: AGHT+IHQSSAkWJvD36OnpNHlgnVYT2/cx6Tc6mY+U7cxpo8QxzPJuYkHa87vpl7b8J0ljfokve6hig==
X-Received: by 2002:a17:907:7f87:b0:a17:8181:4f3 with SMTP id
 qk7-20020a1709077f8700b00a17818104f3mr3873447ejc.49.1702398625485; 
 Tue, 12 Dec 2023 08:30:25 -0800 (PST)
Received: from m1x-phil.lan ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 ll5-20020a170907190500b00a1c99f67834sm6480179ejc.70.2023.12.12.08.30.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Dec 2023 08:30:25 -0800 (PST)
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
Subject: [PATCH 06/33] hw/cpu/arm: Rename 'busdev' -> 'gicsbd' in
 a15mp_priv_realize()
Date: Tue, 12 Dec 2023 17:29:06 +0100
Message-ID: <20231212162935.42910-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231212162935.42910-1-philmd@linaro.org>
References: <20231212162935.42910-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

'busdev' is the internal GIC as SysBus device.
Since we already have a 'gicdev' variable for the GIC as QDev,
rename 'busdev' as 'gicsbd' to make it clear we access the IRQ
lines from the GIC.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/cpu/a15mpcore.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/cpu/a15mpcore.c b/hw/cpu/a15mpcore.c
index bfd8aa5644..a40f142128 100644
--- a/hw/cpu/a15mpcore.c
+++ b/hw/cpu/a15mpcore.c
@@ -51,7 +51,7 @@ static void a15mp_priv_realize(DeviceState *dev, Error **errp)
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     A15MPPrivState *s = A15MPCORE_PRIV(dev);
     DeviceState *gicdev;
-    SysBusDevice *busdev;
+    SysBusDevice *gicsbd;
     int i;
     bool has_el3;
     bool has_el2 = false;
@@ -78,10 +78,10 @@ static void a15mp_priv_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->gic), errp)) {
         return;
     }
-    busdev = SYS_BUS_DEVICE(&s->gic);
+    gicsbd = SYS_BUS_DEVICE(&s->gic);
 
     /* Pass through outbound IRQ lines from the GIC */
-    sysbus_pass_irq(sbd, busdev);
+    sysbus_pass_irq(sbd, gicsbd);
 
     /* Pass through inbound GPIO lines to the GIC */
     qdev_init_gpio_in(dev, a15mp_priv_set_irq, s->num_irq - 32);
@@ -126,17 +126,17 @@ static void a15mp_priv_realize(DeviceState *dev, Error **errp)
      *  0x6000-0x7fff -- GIC virtual CPU interface
      */
     memory_region_add_subregion(&s->container, 0x1000,
-                                sysbus_mmio_get_region(busdev, 0));
+                                sysbus_mmio_get_region(gicsbd, 0));
     memory_region_add_subregion(&s->container, 0x2000,
-                                sysbus_mmio_get_region(busdev, 1));
+                                sysbus_mmio_get_region(gicsbd, 1));
     if (has_el2) {
         memory_region_add_subregion(&s->container, 0x4000,
-                                    sysbus_mmio_get_region(busdev, 2));
+                                    sysbus_mmio_get_region(gicsbd, 2));
         memory_region_add_subregion(&s->container, 0x6000,
-                                    sysbus_mmio_get_region(busdev, 3));
+                                    sysbus_mmio_get_region(gicsbd, 3));
         for (i = 0; i < s->num_cpu; i++) {
             hwaddr base = 0x5000 + i * 0x200;
-            MemoryRegion *mr = sysbus_mmio_get_region(busdev,
+            MemoryRegion *mr = sysbus_mmio_get_region(gicsbd,
                                                       4 + s->num_cpu + i);
             memory_region_add_subregion(&s->container, base, mr);
         }
-- 
2.41.0


