Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E867F4FA0
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 19:33:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5s1e-0004sa-1z; Wed, 22 Nov 2023 13:32:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5s0p-0004N7-3H
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 13:31:49 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5s0n-0004fP-Am
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 13:31:46 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4083dbc43cfso267065e9.3
 for <qemu-devel@nongnu.org>; Wed, 22 Nov 2023 10:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700677904; x=1701282704; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xw/8eweOyz7I3htVuJ6jfziPhJMt4cQLEajxgFqYUSs=;
 b=BI5in9dwEOIqmmD9h+zoMmPY+YJWclo6Y2JXgn7PussaIZZ1kVgkCWB4xvVCP6K/AA
 izPWBzWO0OnySG1CQNaSQj+c+zCwQX1nSgfGSFg3naQvxcWOVG+rK8mhNOx/GMhdTtyI
 LQ4ziaU7BAr60sM1gs9zZHLOQbPj8awaxdDuMwaL9v9iW96AhEtzL+7FT8f5NgRWAbzI
 VW0pfRl8J8oVWrGej4MV7I5uWIMp35xb9zTIOg7gGPJ4iZzoDa5gpOJxXenwmheKGyJL
 n7Vy2XJIedTWSBzrw2YZJ7yCwT9180sCXdL8kDlgiHJ/5QmjIoLR29rp+h5sEUL9+CMg
 b0+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700677904; x=1701282704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xw/8eweOyz7I3htVuJ6jfziPhJMt4cQLEajxgFqYUSs=;
 b=Ac2QU5xo9f3EvPrAxyhxAu55j0LUldHCrmSOkEl6SUkia9CNSy6J8+IC9Xoso8jJlq
 2+7ySNdBOj1Hk20my6kWqN9Mbht/TSm7pdn3c4/NUbBR0mllYSraMuhlIuHrBHj6nv85
 BDwPLqle0zEky47FAUHoQ2uPStZVAFJc3g+juhsT5JugmSkggnstU7lyBVk3rvscBXIr
 AevP+ckQqBp+7FVcQTXLauI0CZ5+3iMQpfgYBK2NPvUFL7JSksSQsGU7GDoHiLOR1A1G
 vpcsWaJjEBw2bXrj4EpIJKnfN/CZc+9zvvcVMEEtaw22NI1vt8D85gIraFwlTpyOHXsR
 GHkA==
X-Gm-Message-State: AOJu0Yze9PMZGW9+q+yCjLsvNsDemx7IZq73HNsqbR+3bhEr4y3izq1v
 SNF+RonhoXX4k8Cmo0F+56KRgencHZVxP0gasj4=
X-Google-Smtp-Source: AGHT+IHEvpExXkkInrxw0CF5q6L6pfzIb5pjEjT/+Avi6nIuMN4o6urEqM0Ex8MQNVh19sVnhpRmvQ==
X-Received: by 2002:a05:600c:35c6:b0:405:4002:825a with SMTP id
 r6-20020a05600c35c600b004054002825amr2690978wmq.13.1700677903888; 
 Wed, 22 Nov 2023 10:31:43 -0800 (PST)
Received: from m1x-phil.lan (pas38-h02-176-184-5-64.dsl.sta.abo.bbox.fr.
 [176.184.5.64]) by smtp.gmail.com with ESMTPSA id
 hg15-20020a05600c538f00b0040849ce7116sm242754wmb.43.2023.11.22.10.31.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Nov 2023 10:31:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH-for-9.0 10/11] hw/arm/raspi: Build bcm2836.o and raspi.o
 objects once
Date: Wed, 22 Nov 2023 19:30:46 +0100
Message-ID: <20231122183048.17150-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231122183048.17150-1-philmd@linaro.org>
References: <20231122183048.17150-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Use the target_aarch64_available() method to restrict
Aarch64 specific models. They will only be added at runtime
if TARGET_AARCH64 is built in.

The Raspberry Pi models can now be built once for all targets.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/bcm2836.c   | 5 +----
 hw/arm/raspi.c     | 6 ++----
 hw/arm/meson.build | 6 ++++--
 3 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 4f5acee77e..ecf434c8ce 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -194,7 +194,6 @@ static void bcm2836_class_init(ObjectClass *oc, void *data)
     dc->realize = bcm2836_realize;
 };
 
-#ifdef TARGET_AARCH64
 static void bcm2837_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
@@ -207,7 +206,6 @@ static void bcm2837_class_init(ObjectClass *oc, void *data)
     bc->clusterid = 0x0;
     dc->realize = bcm2836_realize;
 };
-#endif
 
 static const TypeInfo bcm283x_types[] = {
     {
@@ -218,12 +216,11 @@ static const TypeInfo bcm283x_types[] = {
         .name           = TYPE_BCM2836,
         .parent         = TYPE_BCM283X,
         .class_init     = bcm2836_class_init,
-#ifdef TARGET_AARCH64
     }, {
         .name           = TYPE_BCM2837,
         .parent         = TYPE_BCM283X,
         .class_init     = bcm2837_class_init,
-#endif
+        .can_register   = target_aarch64_available,
     }, {
         .name           = TYPE_BCM283X,
         .parent         = TYPE_DEVICE,
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 01c391b90a..979937b9ac 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -349,7 +349,6 @@ static void raspi2b_machine_class_init(ObjectClass *oc, void *data)
     raspi_machine_class_common_init(mc, rmc->board_rev);
 };
 
-#ifdef TARGET_AARCH64
 static void raspi3ap_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -367,7 +366,6 @@ static void raspi3b_machine_class_init(ObjectClass *oc, void *data)
     rmc->board_rev = 0xa02082;
     raspi_machine_class_common_init(mc, rmc->board_rev);
 };
-#endif /* TARGET_AARCH64 */
 
 static const TypeInfo raspi_machine_types[] = {
     {
@@ -382,16 +380,16 @@ static const TypeInfo raspi_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("raspi2b"),
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi2b_machine_class_init,
-#ifdef TARGET_AARCH64
     }, {
         .name           = MACHINE_TYPE_NAME("raspi3ap"),
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi3ap_machine_class_init,
+        .can_register   = target_aarch64_available,
     }, {
         .name           = MACHINE_TYPE_NAME("raspi3b"),
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi3b_machine_class_init,
-#endif
+        .can_register   = target_aarch64_available,
     }, {
         .name           = TYPE_RASPI_MACHINE,
         .parent         = TYPE_MACHINE,
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 68245d3ad1..15d60685d0 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -38,7 +38,6 @@ arm_ss.add(when: 'CONFIG_STRONGARM', if_true: files('strongarm.c'))
 arm_ss.add(when: 'CONFIG_ALLWINNER_A10', if_true: files('allwinner-a10.c', 'cubieboard.c'))
 arm_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-h3.c', 'orangepi.c'))
 arm_ss.add(when: 'CONFIG_ALLWINNER_R40', if_true: files('allwinner-r40.c', 'bananapi_m2u.c'))
-arm_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2836.c', 'raspi.c'))
 arm_ss.add(when: 'CONFIG_STM32F100_SOC', if_true: files('stm32f100_soc.c'))
 arm_ss.add(when: 'CONFIG_STM32F205_SOC', if_true: files('stm32f205_soc.c'))
 arm_ss.add(when: 'CONFIG_STM32F405_SOC', if_true: files('stm32f405_soc.c'))
@@ -68,7 +67,10 @@ arm_ss.add(when: 'CONFIG_XEN', if_true: files('xen_arm.c'))
 
 system_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmu-common.c'))
 system_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4_boards.c'))
-system_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_peripherals.c'))
+system_ss.add(when: 'CONFIG_RASPI', if_true: files(
+  'bcm2835_peripherals.c',
+  'bcm2836.c',
+  'raspi.c'))
 system_ss.add(when: 'CONFIG_TOSA', if_true: files('tosa.c'))
 
 hw_arch += {'arm': arm_ss}
-- 
2.41.0


