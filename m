Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A377ED818
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 00:24:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3PDO-0007bV-5o; Wed, 15 Nov 2023 18:22:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3PDK-0007ap-Ui
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 18:22:30 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3PD2-0003MI-Bl
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 18:22:30 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-543c3756521so306875a12.2
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 15:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700090531; x=1700695331; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z2Aez4pIK4BJ1WwRvt8loGDJ5oavAC3olsgV9rlMnB0=;
 b=MHeh91/nrgkxfcXxOepPhhIyAPcIaBmG3xCVynwggyKytPPJUaKpQH2AjUptiQdup2
 xQWg8MWFnzLwFkVUZ0Ob44G/nPW7WuWyiiPjW+wJ+qMli0c5d1iZd/rYdXXZOPnuzrZr
 bmFDBMRDUc1ouE7o3dQivK3692qpplsBmEba5qBABR0xEoLuSQqPjLXs/K5AgWldCvv6
 pximfUh77jtf4jKti0n0/YvfphsSBfc0F8uifLmeni0XrFCycou71UO0f17i8H4UGf9E
 mhHtbzUKU13/r7+CR6TsK+GPTwIiImRf0tgJTYtNyR2aJxqsUFEi7iYz3QIJ8+FWLfj/
 u0Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700090531; x=1700695331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z2Aez4pIK4BJ1WwRvt8loGDJ5oavAC3olsgV9rlMnB0=;
 b=WbfD+oOpOk5HIWrLOJKHB7QbniouL4gH0KofK1qANL6FSiGuicQnfMI2hZDRvgs54z
 VrA8IQtm1fGYV9/EFAa5jxs2frql4mabyXVJjFGnwvUu3Zx6mrsb9yEKTmP2rxkBwhGk
 LvmMr3O7UyZDzWMMQJYxtdlzLXTcJUYbr8ZvyGnsvjtcZc/BFKXbdD+AJCFjGBcF61fB
 biZKdLKHxhj5UJdwUFARBgMgfTgjPLSRO65OCCOO1sz8jTEjfyVyD/JXGnarYpeK4qax
 vTiXePgNJXzD6fjxfra41nOS2e94Dqt49eGbIisKMcC2PEw4wU/Ei7n/RSilFtKgUq8g
 cbfw==
X-Gm-Message-State: AOJu0Ywn5YZv6eJ09/p3+bRBbBJeFI1urQJmj0808oi7lXyaW19Odz4T
 Hq/097Em93FoiOm5dAgK1H2xzPodnPKHuFDq2ys=
X-Google-Smtp-Source: AGHT+IH6pcxu1kWjOcPaZaHUx3lgxyc32KFhizicDskdUy/eWopRTo6phkGY/qFdaS3eJBR3hVYqmQ==
X-Received: by 2002:a05:6402:5193:b0:543:5789:4d6c with SMTP id
 q19-20020a056402519300b0054357894d6cmr733971edd.2.1700090530804; 
 Wed, 15 Nov 2023 15:22:10 -0800 (PST)
Received: from m1x-phil.lan ([176.176.130.62])
 by smtp.gmail.com with ESMTPSA id
 v22-20020a50d096000000b0053e0f63ce33sm7104725edd.95.2023.11.15.15.22.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Nov 2023 15:22:10 -0800 (PST)
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
Subject: [PATCH-for-8.2? 2/6] hw/arm/stm32f205: Report error when incorrect
 CPU is used
Date: Thu, 16 Nov 2023 00:21:49 +0100
Message-ID: <20231115232154.4515-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231115232154.4515-1-philmd@linaro.org>
References: <20231115232154.4515-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

The 'netduino2' machine ignores the CPU type requested by the
command line. This might confuse users, since the following will
create a machine with a Cortex-M3 CPU:

  $ qemu-system-arm -M netduino2 -cpu cortex-a9

Set the MachineClass::valid_cpu_types field (introduced in commit
c9cf636d48 "machine: Add a valid_cpu_types property").
Remove the now unused MachineClass::default_cpu_type field.

We now get:

  $ qemu-system-arm -M netduino2 -cpu cortex-a9
  qemu-system-arm: Invalid CPU type: cortex-a9-arm-cpu
  The valid types are: cortex-m3-arm-cpu

Since the SoC family can only use Cortex-M3 CPUs, hard-code the
CPU type name at the SoC level, removing the QOM property
entirely.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/arm/stm32f205_soc.h | 4 ----
 hw/arm/netduino2.c             | 7 ++++++-
 hw/arm/stm32f205_soc.c         | 9 ++-------
 3 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/include/hw/arm/stm32f205_soc.h b/include/hw/arm/stm32f205_soc.h
index 5a4f776264..4f4c8bbebc 100644
--- a/include/hw/arm/stm32f205_soc.h
+++ b/include/hw/arm/stm32f205_soc.h
@@ -49,11 +49,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(STM32F205State, STM32F205_SOC)
 #define SRAM_SIZE (128 * 1024)
 
 struct STM32F205State {
-    /*< private >*/
     SysBusDevice parent_obj;
-    /*< public >*/
-
-    char *cpu_type;
 
     ARMv7MState armv7m;
 
diff --git a/hw/arm/netduino2.c b/hw/arm/netduino2.c
index 83753d53a3..94b6b379d6 100644
--- a/hw/arm/netduino2.c
+++ b/hw/arm/netduino2.c
@@ -44,7 +44,6 @@ static void netduino2_init(MachineState *machine)
     clock_set_hz(sysclk, SYSCLK_FRQ);
 
     dev = qdev_new(TYPE_STM32F205_SOC);
-    qdev_prop_set_string(dev, "cpu-type", ARM_CPU_TYPE_NAME("cortex-m3"));
     qdev_connect_clock_in(dev, "sysclk", sysclk);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
@@ -54,8 +53,14 @@ static void netduino2_init(MachineState *machine)
 
 static void netduino2_machine_init(MachineClass *mc)
 {
+    static const char *machine_valid_cpu_types[] = {
+        ARM_CPU_TYPE_NAME("cortex-m3"),
+        NULL
+    };
+
     mc->desc = "Netduino 2 Machine (Cortex-M3)";
     mc->init = netduino2_init;
+    mc->valid_cpu_types = machine_valid_cpu_types;
     mc->ignore_memory_transaction_failures = true;
 }
 
diff --git a/hw/arm/stm32f205_soc.c b/hw/arm/stm32f205_soc.c
index c6b75a381d..1a548646f6 100644
--- a/hw/arm/stm32f205_soc.c
+++ b/hw/arm/stm32f205_soc.c
@@ -127,7 +127,7 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
 
     armv7m = DEVICE(&s->armv7m);
     qdev_prop_set_uint32(armv7m, "num-irq", 96);
-    qdev_prop_set_string(armv7m, "cpu-type", s->cpu_type);
+    qdev_prop_set_string(armv7m, "cpu-type", ARM_CPU_TYPE_NAME("cortex-m3"));
     qdev_prop_set_bit(armv7m, "enable-bitband", true);
     qdev_connect_clock_in(armv7m, "cpuclk", s->sysclk);
     qdev_connect_clock_in(armv7m, "refclk", s->refclk);
@@ -201,17 +201,12 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
     }
 }
 
-static Property stm32f205_soc_properties[] = {
-    DEFINE_PROP_STRING("cpu-type", STM32F205State, cpu_type),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
 static void stm32f205_soc_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = stm32f205_soc_realize;
-    device_class_set_props(dc, stm32f205_soc_properties);
+    /* No vmstate or reset required: device has no internal state */
 }
 
 static const TypeInfo stm32f205_soc_info = {
-- 
2.41.0


