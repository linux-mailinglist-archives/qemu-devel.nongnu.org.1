Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 741267F2A53
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 11:26:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5Nw4-0004KL-JX; Tue, 21 Nov 2023 05:24:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r5Nw2-0004JA-E2
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 05:24:50 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r5Nvz-0007Er-93
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 05:24:50 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4084de32db5so27431685e9.0
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 02:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700562285; x=1701167085; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=O+zUt/QLfrTlh2hm/zQQFNIIEpKPbEpTMNRg+Stq7bo=;
 b=VvvXWgFS76oudZdMVi6VAcixHNXNTgaNFeMY6U2ZDpMULYs+8FgtqMWhtWLPKa+YeX
 /5kG25G9framYUARbPwp7pU+WuRElNPWlBeb6Ixt6iSvh3XJVBrCYEwS3pKb2JLQCHa6
 DyckOfWOh5jwXvVWA5Xw5Kzethj6StGW6eFPpCmBT1XPJWaHEJyd7s3w9KU9u5Qf3b52
 sbGZGr5K5ps4seKdjRCIvhZsi3IOHcKS8Jbe7mKJnzyseuJ0Ggg2L9EysJEkhVoIWnWJ
 3Fw52h7K1S//ZG+F9vF0FZpMVrakzCMiOrDuiT7vl6VhsdmcZjuT09qQOMUG4FaeOpB3
 Ixdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700562285; x=1701167085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O+zUt/QLfrTlh2hm/zQQFNIIEpKPbEpTMNRg+Stq7bo=;
 b=NdP3eUfoAFKpCh77zMuG77WmDFkSeZBYlqvadwOJrX/WFIPYNX7M2zwggDK/8hnnD7
 En2TclYM8ub6PT2+h+sFm1Rvg8adsLgs5MdUwkb/N2tBKUK1zXe+zlxR3IMk/dbDujAG
 y6a/jTuSwWP9K5kkpA6bdLS+r0dMTM9vRDf/uAO9sjXR74zaixLkvCtcMjPoj+dly3Es
 Jk9E6DwICwKiTMKFk1DMfTwQ7YDZH5uikaOANTxQMiA8POAwgezcXcjNuLMn5PBblDvU
 p0/zeLLZdCTUVf3OHT7bJCcG0c1aJ5CFSyGhg93jpMi7Aud0XVdcjoR089fLMvnZI/ka
 w/pw==
X-Gm-Message-State: AOJu0YwGed0eV0Z+nhKMtJLPG/OGfmE9IjIfTmP3qnGDntoSr0nOnbRp
 7oLJhxogi7YQc47QvZScyo6RK2aCLST1eKpBJKE=
X-Google-Smtp-Source: AGHT+IGQsuYSj+84f0d6GT2O1pPlJbJ7zfB1MGwHTZhaFPBhfCjIwfXTv5fagvuxpX3kkJbyFUaMFg==
X-Received: by 2002:a05:600c:1394:b0:409:5d7d:b26d with SMTP id
 u20-20020a05600c139400b004095d7db26dmr7014234wmf.15.1700562285768; 
 Tue, 21 Nov 2023 02:24:45 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 n25-20020a05600c181900b00405442edc69sm20450835wmp.14.2023.11.21.02.24.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 02:24:45 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 5/8] hw/arm/stm32f405: Report error when incorrect CPU is used
Date: Tue, 21 Nov 2023 10:24:38 +0000
Message-Id: <20231121102441.3872902-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121102441.3872902-1-peter.maydell@linaro.org>
References: <20231121102441.3872902-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Both 'netduinoplus2' and 'olimex-stm32-h405' machines ignore the
CPU type requested by the command line. This might confuse users,
since the following will create a machine with a Cortex-M4 CPU:

  $ qemu-system-aarch64 -M netduinoplus2 -cpu cortex-r5f

Set the MachineClass::valid_cpu_types field (introduced in commit
c9cf636d48 "machine: Add a valid_cpu_types property").
Remove the now unused MachineClass::default_cpu_type field.

We now get:

  $ qemu-system-aarch64 -M netduinoplus2 -cpu cortex-r5f
  qemu-system-aarch64: Invalid CPU type: cortex-r5f-arm-cpu
  The valid types are: cortex-m4-arm-cpu

Since the SoC family can only use Cortex-M4 CPUs, hard-code the
CPU type name at the SoC level, removing the QOM property
entirely.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Message-id: 20231117071704.35040-3-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/stm32f405_soc.h | 4 ----
 hw/arm/netduinoplus2.c         | 7 ++++++-
 hw/arm/olimex-stm32-h405.c     | 8 ++++++--
 hw/arm/stm32f405_soc.c         | 8 +-------
 4 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/include/hw/arm/stm32f405_soc.h b/include/hw/arm/stm32f405_soc.h
index c968ce3ab23..d15c03c4b5d 100644
--- a/include/hw/arm/stm32f405_soc.h
+++ b/include/hw/arm/stm32f405_soc.h
@@ -51,11 +51,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(STM32F405State, STM32F405_SOC)
 #define CCM_SIZE (64 * 1024)
 
 struct STM32F405State {
-    /*< private >*/
     SysBusDevice parent_obj;
-    /*< public >*/
-
-    char *cpu_type;
 
     ARMv7MState armv7m;
 
diff --git a/hw/arm/netduinoplus2.c b/hw/arm/netduinoplus2.c
index 515c0816054..2e589849478 100644
--- a/hw/arm/netduinoplus2.c
+++ b/hw/arm/netduinoplus2.c
@@ -44,7 +44,6 @@ static void netduinoplus2_init(MachineState *machine)
     clock_set_hz(sysclk, SYSCLK_FRQ);
 
     dev = qdev_new(TYPE_STM32F405_SOC);
-    qdev_prop_set_string(dev, "cpu-type", ARM_CPU_TYPE_NAME("cortex-m4"));
     qdev_connect_clock_in(dev, "sysclk", sysclk);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
@@ -55,8 +54,14 @@ static void netduinoplus2_init(MachineState *machine)
 
 static void netduinoplus2_machine_init(MachineClass *mc)
 {
+    static const char * const valid_cpu_types[] = {
+        ARM_CPU_TYPE_NAME("cortex-m4"),
+        NULL
+    };
+
     mc->desc = "Netduino Plus 2 Machine (Cortex-M4)";
     mc->init = netduinoplus2_init;
+    mc->valid_cpu_types = valid_cpu_types;
 }
 
 DEFINE_MACHINE("netduinoplus2", netduinoplus2_machine_init)
diff --git a/hw/arm/olimex-stm32-h405.c b/hw/arm/olimex-stm32-h405.c
index 3aa61c91b75..d793de7c97f 100644
--- a/hw/arm/olimex-stm32-h405.c
+++ b/hw/arm/olimex-stm32-h405.c
@@ -47,7 +47,6 @@ static void olimex_stm32_h405_init(MachineState *machine)
     clock_set_hz(sysclk, SYSCLK_FRQ);
 
     dev = qdev_new(TYPE_STM32F405_SOC);
-    qdev_prop_set_string(dev, "cpu-type", ARM_CPU_TYPE_NAME("cortex-m4"));
     qdev_connect_clock_in(dev, "sysclk", sysclk);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
@@ -58,9 +57,14 @@ static void olimex_stm32_h405_init(MachineState *machine)
 
 static void olimex_stm32_h405_machine_init(MachineClass *mc)
 {
+    static const char * const valid_cpu_types[] = {
+        ARM_CPU_TYPE_NAME("cortex-m4"),
+        NULL
+    };
+
     mc->desc = "Olimex STM32-H405 (Cortex-M4)";
     mc->init = olimex_stm32_h405_init;
-    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m4");
+    mc->valid_cpu_types = valid_cpu_types;
 
     /* SRAM pre-allocated as part of the SoC instantiation */
     mc->default_ram_size = 0;
diff --git a/hw/arm/stm32f405_soc.c b/hw/arm/stm32f405_soc.c
index cef23d7ee41..a65bbe298d2 100644
--- a/hw/arm/stm32f405_soc.c
+++ b/hw/arm/stm32f405_soc.c
@@ -149,7 +149,7 @@ static void stm32f405_soc_realize(DeviceState *dev_soc, Error **errp)
 
     armv7m = DEVICE(&s->armv7m);
     qdev_prop_set_uint32(armv7m, "num-irq", 96);
-    qdev_prop_set_string(armv7m, "cpu-type", s->cpu_type);
+    qdev_prop_set_string(armv7m, "cpu-type", ARM_CPU_TYPE_NAME("cortex-m4"));
     qdev_prop_set_bit(armv7m, "enable-bitband", true);
     qdev_connect_clock_in(armv7m, "cpuclk", s->sysclk);
     qdev_connect_clock_in(armv7m, "refclk", s->refclk);
@@ -287,17 +287,11 @@ static void stm32f405_soc_realize(DeviceState *dev_soc, Error **errp)
     create_unimplemented_device("RNG",         0x50060800, 0x400);
 }
 
-static Property stm32f405_soc_properties[] = {
-    DEFINE_PROP_STRING("cpu-type", STM32F405State, cpu_type),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
 static void stm32f405_soc_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = stm32f405_soc_realize;
-    device_class_set_props(dc, stm32f405_soc_properties);
     /* No vmstate or reset required: device has no internal state */
 }
 
-- 
2.34.1


