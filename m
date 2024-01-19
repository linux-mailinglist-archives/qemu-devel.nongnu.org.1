Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABFE833077
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 22:52:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQwlx-0003vH-Ri; Fri, 19 Jan 2024 16:51:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQwlo-0003tr-Tf
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 16:51:24 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQwlf-0005Pd-LS
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 16:51:18 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40d6b4e2945so13566695e9.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 13:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705701073; x=1706305873; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kzOrVlFRj/NdOh1lLvn8pDfgdHcR2iZT2G+ZVE6nW3Q=;
 b=dT2WYQ4s2BYwr55M6u/f5F5lPUlV32xO8muJ+mNw7WC5RjAUgg+K4RcnlkdEApks4p
 Ngua2LcKY8Q/45JtrvIJgWrAyVYuLcGWsDwuecopZeS61lBX0HStdlh5/A4pP1OloI7w
 23usW+Cc6hjAVmuQ50Gk1x7bea+jndHKy/fJDYEguCjgrZExXh61dZV2Oh+KYIf6I4XS
 kAUWFjOitNJsWliy3X1h4spoVK67JbIgoalUBzyj695XoN0jGa2FAghe/MtJzUTTBDAI
 xyFAuHr7zN9BMBGDXB4NO0SFy5Wco2hK+3MTLB1G4mp0nhF2AkUlBoKsziKwQQoT46rC
 xt2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705701073; x=1706305873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kzOrVlFRj/NdOh1lLvn8pDfgdHcR2iZT2G+ZVE6nW3Q=;
 b=chenYhpSzdWNWPayfmY0+hetqSHZZumxs7LNZMTO3iTpMko2SkQelZDGMg5mmCcCgd
 pzgjoEyHGMdEIiBtB27A9RpQq5vvLQ258uODPpgKMEmfK8RXPNbXSfXXf3+gDUWe9nBm
 6Gx3fCfLL4xkvx5QFqb25VYEpmqg/TBc3DuExalSaynaXyFIFxMTboKW+4UwGSd4Wv1F
 p2mdhZzoBGQ07dbruwfXzVab6SrMczdfF7cbcI+oi2mCNMC1B7btnewL+aNPEQjqdFEh
 FrFT87z2vOscG7YGvqlbbaE5Uof3arCUSHEcssKLe3hpRrqaf89vmyxNSn0uOvP67kPb
 7Mmw==
X-Gm-Message-State: AOJu0Ywx4YAc2z9Kx+QMkysm1f2ASk6WBzF+HaXAzpfF0SWQsBo+tW17
 LJbp7MBD+RLsbYlmXYJ8VY2DPa6hfoZ06OgV74OrpCjZu8rvXMV817ZKkyIuyi1io5lbfwNRVpn
 O
X-Google-Smtp-Source: AGHT+IGYOfD72AnjX1IWPqdP6DTq9ZsZkCrjZU69yVQPuBFeasZCQnGr+lNVwTag5Dz9AIGnubMWOA==
X-Received: by 2002:a05:600c:5013:b0:40e:4bef:f24f with SMTP id
 n19-20020a05600c501300b0040e4beff24fmr159027wmr.120.1705701073278; 
 Fri, 19 Jan 2024 13:51:13 -0800 (PST)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 g15-20020a5d64ef000000b00336f43fa654sm7470330wri.22.2024.01.19.13.51.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Jan 2024 13:51:12 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 1/2] hw/arm/allwinner-a10: Unconditionally map the USB Host
 controllers
Date: Fri, 19 Jan 2024 22:51:05 +0100
Message-ID: <20240119215106.45776-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240119215106.45776-1-philmd@linaro.org>
References: <20240119215106.45776-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

This is a migration compatibility break for the cubieboard
machine started with the '-usb none' option.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net>
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


