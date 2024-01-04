Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4390882435E
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 15:13:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLOS9-0006Fe-Po; Thu, 04 Jan 2024 09:12:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLOS8-0006FI-Aw
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 09:12:08 -0500
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLOS5-0000Jx-C5
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 09:12:07 -0500
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-50ea9daac4cso593216e87.3
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 06:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704377523; x=1704982323; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HH/FOzMkAK9P4wWyuKIB0SOChexA4vOozUZ0T8lYoS8=;
 b=gF4yh7tAutpOO9ZHanxhABaotb8IUvk9jiX2GKoRO021J3yqJNVqgNo4pXdM7ioS8r
 zukNhi/Tpp4/vLmPfnoVp5Mpcn+k2N1YWTGbDIJJcPEv+sYKEK28f3PYCKRfrnJP9kYh
 DL2vXnDK8GBm0e7KIQVqosXZ0MmqaF6io+2WGzpyRNHVJiRczzfSm+puaOSJoPF0KaUR
 eTgzBYWh9ozFbTgozO8rY4q5dxebHyyrz+g4Uvv1elKbXdLIxT2MR1aETQlgDIucfqIR
 G9Ou1IgTxYm+LPtL4CKdOkAPG/yDTRHlOWxFxX4UWm5YlgCIlAx31nYGJrZaOFKts/Mw
 LUww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704377523; x=1704982323;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HH/FOzMkAK9P4wWyuKIB0SOChexA4vOozUZ0T8lYoS8=;
 b=BvQGnlTujlLhf5VqjFcamaIO04HTLsBgygDydtrIVDImIXIMz3nKAWKjW88tRE/Y1x
 fanJ+/CglZ04khYbxbLiNohYq6JM1GKHAmcEv+pLw69Iiy/OOAHCAbSqgjfO2L8IMV01
 jhS2A7xq90Ljaq4Wnoggt2i9VikFHTEw+vTSwdd81Djd099l+ML6jVXj2cd+huUi2Zyo
 USwIwqO5maAD37P1ZB2GlKvOuRrfxGrBksvzyZW4B4CGrKbRqWUNZsYBUo2fn5nHSQvC
 W4zUWySzxrEvV4UsreSLDkhX7olozEVI7oYqxN+OD8kGNVXwrtiKJ5UrJSset31ieuuD
 m2cQ==
X-Gm-Message-State: AOJu0YygWoBFAVADC+YJX3Fr1n2z8ZgcRGcb3GObVYcJf7jcWqlH4nyU
 kONvj4YDDCrACLj1F0ioWCvlMf2QHF9vTSGUsV7QH9VRZHXJ9g==
X-Google-Smtp-Source: AGHT+IGmU5cevp3ctWU0Vh4aUer7qw8TinDGiplS1FtucNefleY36X6b1PTT7MlSLGB672tnx4DAcA==
X-Received: by 2002:a05:6512:31c6:b0:50e:712b:393f with SMTP id
 j6-20020a05651231c600b0050e712b393fmr411303lfe.80.1704377523160; 
 Thu, 04 Jan 2024 06:12:03 -0800 (PST)
Received: from m1x-phil.lan ([176.187.194.232])
 by smtp.gmail.com with ESMTPSA id
 p13-20020a05640210cd00b0055298b38768sm18985841edu.80.2024.01.04.06.12.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 04 Jan 2024 06:12:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Subbaraya Sundeep <sundeep.lkml@gmail.com>, qemu-arm@nongnu.org,
 Felipe Balbi <balbi@kernel.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] hw/arm: Add missing QOM parent for v7-M SoCs
Date: Thu,  4 Jan 2024 15:11:59 +0100
Message-ID: <20240104141159.53883-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12c.google.com
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

QDev objects created with qdev_new() need to manually add
their parent relationship with object_property_add_child().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/msf2-som.c          | 1 +
 hw/arm/netduino2.c         | 1 +
 hw/arm/netduinoplus2.c     | 1 +
 hw/arm/olimex-stm32-h405.c | 1 +
 hw/arm/stm32vldiscovery.c  | 1 +
 5 files changed, 5 insertions(+)

diff --git a/hw/arm/msf2-som.c b/hw/arm/msf2-som.c
index 7b3106c790..e93c83c410 100644
--- a/hw/arm/msf2-som.c
+++ b/hw/arm/msf2-som.c
@@ -66,6 +66,7 @@ static void emcraft_sf2_s2s010_init(MachineState *machine)
     memory_region_add_subregion(sysmem, DDR_BASE_ADDRESS, ddr);
 
     dev = qdev_new(TYPE_MSF2_SOC);
+    object_property_add_child(OBJECT(machine), "soc", OBJECT(dev));
     qdev_prop_set_string(dev, "part-name", "M2S010");
     qdev_prop_set_string(dev, "cpu-type", mc->default_cpu_type);
 
diff --git a/hw/arm/netduino2.c b/hw/arm/netduino2.c
index 501f63a77f..8b1a9a2437 100644
--- a/hw/arm/netduino2.c
+++ b/hw/arm/netduino2.c
@@ -44,6 +44,7 @@ static void netduino2_init(MachineState *machine)
     clock_set_hz(sysclk, SYSCLK_FRQ);
 
     dev = qdev_new(TYPE_STM32F205_SOC);
+    object_property_add_child(OBJECT(machine), "soc", OBJECT(dev));
     qdev_connect_clock_in(dev, "sysclk", sysclk);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
diff --git a/hw/arm/netduinoplus2.c b/hw/arm/netduinoplus2.c
index 2e58984947..bccd100354 100644
--- a/hw/arm/netduinoplus2.c
+++ b/hw/arm/netduinoplus2.c
@@ -44,6 +44,7 @@ static void netduinoplus2_init(MachineState *machine)
     clock_set_hz(sysclk, SYSCLK_FRQ);
 
     dev = qdev_new(TYPE_STM32F405_SOC);
+    object_property_add_child(OBJECT(machine), "soc", OBJECT(dev));
     qdev_connect_clock_in(dev, "sysclk", sysclk);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
diff --git a/hw/arm/olimex-stm32-h405.c b/hw/arm/olimex-stm32-h405.c
index d793de7c97..4ad7b043be 100644
--- a/hw/arm/olimex-stm32-h405.c
+++ b/hw/arm/olimex-stm32-h405.c
@@ -47,6 +47,7 @@ static void olimex_stm32_h405_init(MachineState *machine)
     clock_set_hz(sysclk, SYSCLK_FRQ);
 
     dev = qdev_new(TYPE_STM32F405_SOC);
+    object_property_add_child(OBJECT(machine), "soc", OBJECT(dev));
     qdev_connect_clock_in(dev, "sysclk", sysclk);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
diff --git a/hw/arm/stm32vldiscovery.c b/hw/arm/stm32vldiscovery.c
index 190db6118b..cc41935160 100644
--- a/hw/arm/stm32vldiscovery.c
+++ b/hw/arm/stm32vldiscovery.c
@@ -47,6 +47,7 @@ static void stm32vldiscovery_init(MachineState *machine)
     clock_set_hz(sysclk, SYSCLK_FRQ);
 
     dev = qdev_new(TYPE_STM32F100_SOC);
+    object_property_add_child(OBJECT(machine), "soc", OBJECT(dev));
     qdev_connect_clock_in(dev, "sysclk", sysclk);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
-- 
2.41.0


