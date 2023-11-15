Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C41D57ED81E
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 00:24:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3PDO-0007c1-CR; Wed, 15 Nov 2023 18:22:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3PDL-0007b1-Sr
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 18:22:31 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3PCw-0003KA-26
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 18:22:31 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5435336ab0bso341988a12.1
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 15:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700090524; x=1700695324; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SjjgBM6Far3ZU6D7cHhKn6yCQMmOx1k1V2GiDQ4UpRs=;
 b=cyUzvsLVbcaS9GosKcnf2v2lEJ6g6WNDhYKZZsMhU4A3QKV3vCHbrXt58iR709uaIK
 9NGlPRb28Bv2ggUyY+ffBG2GAbZViYhyKWepsMbOyzS5BhmP069q+/HIhfEDFHUcM+ak
 yTqcInlSuB3OoqA6Mv3Oh8GGz2ib7U+nhRGa9XTY3g1AOCwvcAei3bYoL4Uakl67exsb
 ZkbK6LU6JkFeaCJs8+7irfCElBCtrxjANt35BRlggaDbG4SndIdPDefxbjuOgYi7Q2m8
 mhPqJMgZNv0FFpes5UIXDnWQMwBizCRG8AzN3VyNCSTinFwLfp7BDbwh8qGUhGvSwocR
 utXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700090524; x=1700695324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SjjgBM6Far3ZU6D7cHhKn6yCQMmOx1k1V2GiDQ4UpRs=;
 b=Xy3TdBzWtmaQZQkt9MNnYOEIXAP5WU5XqZszq36Vjvxlu3HdhkZcOTUklb9GAcAc7C
 En7kvWoMQqQpOrvy7o2rkwOFBAhj0pwaHF/M93BDlv4M4bZznHNtaUmrl/BPPFBasGZz
 MS4/BOVrsOIuhpPwaCfTqOpxaSGQ72XUIwZCryUkHmoMJCoAcfD5Tt+92CMR/M4bG0hj
 H03fc616wbyv+JB1fyQx8KE62yQZYmqZcohy6JO9PhIO40z0bLlPUJBoRdyjLCxaFWKx
 brT8yCWjvVCiped+yDvDQ2extoQVvIXL7Yx0hqVXIhG3GxqYo4/EVv3CamKtSWVZmnM/
 /2Fw==
X-Gm-Message-State: AOJu0YwFcDTRFsZOz/Y2hD9DIrRUAvkRv9QQ33CjwREE660Mx92HQOSF
 76/1zZPxyz6Ezs81NPezXFrwF6yJDZi20bUBjnM=
X-Google-Smtp-Source: AGHT+IGVQqCH25wFx2mPGXXFA671mZ6zjwxmqsNg2TD/Xsv1XY+TFPFBWHOVllzxG6CPQL0hiUhETA==
X-Received: by 2002:a17:907:c09:b0:9e7:de43:af91 with SMTP id
 ga9-20020a1709070c0900b009e7de43af91mr13824977ejc.41.1700090524467; 
 Wed, 15 Nov 2023 15:22:04 -0800 (PST)
Received: from m1x-phil.lan ([176.176.130.62])
 by smtp.gmail.com with ESMTPSA id
 dt20-20020a170906b79400b009cb2fd85371sm7580944ejb.8.2023.11.15.15.22.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Nov 2023 15:22:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 Tyrone Ting <kfting@nuvoton.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
 Hao Wu <wuhaotsh@google.com>, Felipe Balbi <balbi@kernel.org>,
 Gavin Shan <gshan@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-8.2? 1/6] hw/arm/stm32f405: Report error when incorrect
 CPU is used
Date: Thu, 16 Nov 2023 00:21:48 +0100
Message-ID: <20231115232154.4515-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231115232154.4515-1-philmd@linaro.org>
References: <20231115232154.4515-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/arm/stm32f405_soc.h | 4 ----
 hw/arm/netduinoplus2.c         | 7 ++++++-
 hw/arm/olimex-stm32-h405.c     | 8 ++++++--
 hw/arm/stm32f405_soc.c         | 8 +-------
 4 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/include/hw/arm/stm32f405_soc.h b/include/hw/arm/stm32f405_soc.h
index c968ce3ab2..d15c03c4b5 100644
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
index 515c081605..e411806dd7 100644
--- a/hw/arm/netduinoplus2.c
+++ b/hw/arm/netduinoplus2.c
@@ -44,7 +44,6 @@ static void netduinoplus2_init(MachineState *machine)
     clock_set_hz(sysclk, SYSCLK_FRQ);
 
     dev = qdev_new(TYPE_STM32F405_SOC);
-    qdev_prop_set_string(dev, "cpu-type", ARM_CPU_TYPE_NAME("cortex-m4"));
     qdev_connect_clock_in(dev, "sysclk", sysclk);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
@@ -55,7 +54,13 @@ static void netduinoplus2_init(MachineState *machine)
 
 static void netduinoplus2_machine_init(MachineClass *mc)
 {
+    static const char *machine_valid_cpu_types[] = {
+        ARM_CPU_TYPE_NAME("cortex-m4"),
+        NULL
+    };
+
     mc->desc = "Netduino Plus 2 Machine (Cortex-M4)";
+    mc->valid_cpu_types = machine_valid_cpu_types;
     mc->init = netduinoplus2_init;
 }
 
diff --git a/hw/arm/olimex-stm32-h405.c b/hw/arm/olimex-stm32-h405.c
index 3aa61c91b7..694b1dd6ed 100644
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
+    static const char *machine_valid_cpu_types[] = {
+        ARM_CPU_TYPE_NAME("cortex-m4"),
+        NULL
+    };
+
     mc->desc = "Olimex STM32-H405 (Cortex-M4)";
     mc->init = olimex_stm32_h405_init;
-    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m4");
+    mc->valid_cpu_types = machine_valid_cpu_types;
 
     /* SRAM pre-allocated as part of the SoC instantiation */
     mc->default_ram_size = 0;
diff --git a/hw/arm/stm32f405_soc.c b/hw/arm/stm32f405_soc.c
index cef23d7ee4..a65bbe298d 100644
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
2.41.0


