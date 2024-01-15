Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F04C82DE0A
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 17:57:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPQGG-0006Gf-0m; Mon, 15 Jan 2024 11:56:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rPQGA-0006FM-U3
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 11:56:27 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rPQG9-0001Wt-BL
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 11:56:26 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40e80046246so3684525e9.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 08:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705337783; x=1705942583; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tp5kXRZIwxQA5ZiZbQiX86tGc9m7nGG30xQAkxSTGS8=;
 b=ZOmbvnuemk7mmLA6u/WBpzJC8XVuTV/H64E/GnLppA8Pqtfd8xSlNsRuGMNk7zgAMv
 HOrBgibTOFB/dL7Gd4zwMGlupQbA9lUrsYiBICtkBuUQLIZ4nMOYyYc1hm1oECZNmRVV
 GAwFqK3pRPOYcV66glOvVDUIrTMY1+Q9Zy8KZLvMN9teNFdhKxmvZCD9j4rc0Im6HTiP
 0mabU9wxaedwEeIK0JH2crJkRv6Cq4IqGwUAsNEsOJK8Qu8qJhymo8TQJ6wRA7azJWpV
 MJbn8pcFBR+E15ErKSvehan1ji1k9qk5+GwoZaJXAQjB1JyF2tSAgVdjNI77k4OcUJpq
 dcSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705337783; x=1705942583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tp5kXRZIwxQA5ZiZbQiX86tGc9m7nGG30xQAkxSTGS8=;
 b=aRnr9q6PVJ51iAr8rqHNc59m2hk128Ev648vZPnI09KBX86rcw1ypUEcGHED5dyP2W
 TMbS8D4ittokJepQMF0VemOL6tCgrr/mv344YiF7w+0oZJu/qpCEzxdPbLfu/8z9XS3M
 b3NzNCE3M+vupQwy5Jr8BnJXdu7rnW4hu7uYJEnLCal6nFNltEX5O24pSXPRM8D5KZxS
 ixJ822XYbIrQNsnUrXmh3eMTd66vRdC9kHvvDLq3K3qeExjTd+zys+r60kzODTCEv/Yn
 MsglHcIwEkZedbFT8Jr1cwtdeCe4pPJMya3a0Ag3M4R4od4rzsbNiSXAIy5HYyEyxFsA
 pMoQ==
X-Gm-Message-State: AOJu0YxNd6d2qDVOjR3I+lzDvC1wPdK7W1d5zEAku/gw3bgY7jMSOpyj
 N2lQcp8Afi8/qlEwBW4XtykVMO+mkQrbyQI/7RNOlr40qec=
X-Google-Smtp-Source: AGHT+IG/Ffxkjt4Zmc+1LGZ23GSSXcknjgwkC3dDq1fGKm+SArl9sWnLJXaPmTr9CRhpnUkQngSe5A==
X-Received: by 2002:a05:600c:4b10:b0:40e:7114:e42d with SMTP id
 i16-20020a05600c4b1000b0040e7114e42dmr1490467wmp.17.1705337783189; 
 Mon, 15 Jan 2024 08:56:23 -0800 (PST)
Received: from m1x-phil.lan ([176.187.209.30])
 by smtp.gmail.com with ESMTPSA id
 v2-20020a5d5902000000b00337a6feab88sm4035876wrd.100.2024.01.15.08.56.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 15 Jan 2024 08:56:22 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 1/2] hw/arm/allwinner-a10: Unconditionally map the USB Host
 controllers
Date: Mon, 15 Jan 2024 17:56:14 +0100
Message-ID: <20240115165615.78323-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240115165615.78323-1-philmd@linaro.org>
References: <20240115165615.78323-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

The USB Controllers are part of the chipset, thus are
always present and mapped in memory.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/allwinner-a10.c | 49 +++++++++++++++++-------------------------
 1 file changed, 20 insertions(+), 29 deletions(-)

diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
index b0ea3f7f66..0135632996 100644
--- a/hw/arm/allwinner-a10.c
+++ b/hw/arm/allwinner-a10.c
@@ -79,15 +79,10 @@ static void aw_a10_init(Object *obj)
 
     object_initialize_child(obj, "i2c0", &s->i2c0, TYPE_AW_I2C);
 
-    if (machine_usb(current_machine)) {
-        int i;
-
-        for (i = 0; i < AW_A10_NUM_USB; i++) {
-            object_initialize_child(obj, "ehci[*]", &s->ehci[i],
-                                    TYPE_PLATFORM_EHCI);
-            object_initialize_child(obj, "ohci[*]", &s->ohci[i],
-                                    TYPE_SYSBUS_OHCI);
-        }
+    for (size_t i = 0; i < AW_A10_NUM_USB; i++) {
+        object_initialize_child(obj, "ehci[*]", &s->ehci[i],
+                                TYPE_PLATFORM_EHCI);
+        object_initialize_child(obj, "ohci[*]", &s->ohci[i], TYPE_SYSBUS_OHCI);
     }
 
     object_initialize_child(obj, "mmc0", &s->mmc0, TYPE_AW_SDHOST_SUN4I);
@@ -165,28 +160,24 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
                    qdev_get_gpio_in(dev, 1),
                    115200, serial_hd(0), DEVICE_NATIVE_ENDIAN);
 
-    if (machine_usb(current_machine)) {
-        int i;
+    for (size_t i = 0; i < AW_A10_NUM_USB; i++) {
+        g_autofree char *bus = g_strdup_printf("usb-bus.%zu", i);
 
-        for (i = 0; i < AW_A10_NUM_USB; i++) {
-            g_autofree char *bus = g_strdup_printf("usb-bus.%d", i);
+        object_property_set_bool(OBJECT(&s->ehci[i]), "companion-enable",
+                                 true, &error_fatal);
+        sysbus_realize(SYS_BUS_DEVICE(&s->ehci[i]), &error_fatal);
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->ehci[i]), 0,
+                        AW_A10_EHCI_BASE + i * 0x8000);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->ehci[i]), 0,
+                           qdev_get_gpio_in(dev, 39 + i));
 
-            object_property_set_bool(OBJECT(&s->ehci[i]), "companion-enable",
-                                     true, &error_fatal);
-            sysbus_realize(SYS_BUS_DEVICE(&s->ehci[i]), &error_fatal);
-            sysbus_mmio_map(SYS_BUS_DEVICE(&s->ehci[i]), 0,
-                            AW_A10_EHCI_BASE + i * 0x8000);
-            sysbus_connect_irq(SYS_BUS_DEVICE(&s->ehci[i]), 0,
-                               qdev_get_gpio_in(dev, 39 + i));
-
-            object_property_set_str(OBJECT(&s->ohci[i]), "masterbus", bus,
-                                    &error_fatal);
-            sysbus_realize(SYS_BUS_DEVICE(&s->ohci[i]), &error_fatal);
-            sysbus_mmio_map(SYS_BUS_DEVICE(&s->ohci[i]), 0,
-                            AW_A10_OHCI_BASE + i * 0x8000);
-            sysbus_connect_irq(SYS_BUS_DEVICE(&s->ohci[i]), 0,
-                               qdev_get_gpio_in(dev, 64 + i));
-        }
+        object_property_set_str(OBJECT(&s->ohci[i]), "masterbus", bus,
+                                &error_fatal);
+        sysbus_realize(SYS_BUS_DEVICE(&s->ohci[i]), &error_fatal);
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->ohci[i]), 0,
+                        AW_A10_OHCI_BASE + i * 0x8000);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->ohci[i]), 0,
+                           qdev_get_gpio_in(dev, 64 + i));
     }
 
     /* SD/MMC */
-- 
2.41.0


