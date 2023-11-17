Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0B27EEC8C
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 08:19:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3t6g-0005Rq-LG; Fri, 17 Nov 2023 02:17:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3t6c-0005Q7-FI
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 02:17:34 -0500
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3t6Y-0004Jm-Gd
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 02:17:33 -0500
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-507be298d2aso2178725e87.1
 for <qemu-devel@nongnu.org>; Thu, 16 Nov 2023 23:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700205447; x=1700810247; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NH5P5ZdsVBU0A7f/AHoAHis/E7XVaC6npXWaZcl7Gsk=;
 b=YZeqypqQ+np7QYxoeTfr8yg/OYs4B64DMFZmyNuuCVRFnBabFcdiJ8fh6IyYbuphxb
 XvcnTDkxGgqWpvzRXI1CHLB34b1K1tdDPBq7khWk6+sACMtcFez3EftMBMxp6FuJG3Ox
 k8G++LFf5tNKueXa50C6TF8ZQh3LmUP0NIBNs+L51k32G8nZIuaOuI18Ou002pEwFXBy
 WrG0XTwTo/emPKq6YVbYjBEZxLnyLyiNCd2KFPcBhkAOnMpF1sKaLm+M6Ic8HD7awxlv
 2WYrlbOXgeDC+K4o05JdmOtZHxEpWWNApWku5eWB86gqJec29/nc+Pd6AkUoFqNgOHdU
 YHUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700205447; x=1700810247;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NH5P5ZdsVBU0A7f/AHoAHis/E7XVaC6npXWaZcl7Gsk=;
 b=toxypK0a7PFiZxv7sCDJlF+fALrIr6y402Xa5zp2wD83cbS8opWHXV/0c/ANnSzl1Y
 /4B2w4xW0tuqWUh1VVFS9WLg8b7/W3oQrL/+412iIuCBE9Zzq4M4kDDq5AwlUdl3LKT7
 vSOlL3B3O2oZmL2waF/VWeCSSsdqn2qmpCOsymMwV0rCJ2PkhfAZXN5iuaX9Uqi3w1Ic
 Mt6xs23KNpK0wVrnOmj1cZ7mjC2TXWnR51+3d1oyttl/cs0S4dRvBgFnHYxYy0HRxwnU
 mNlVJ4Pt0Murd4awUuqBCwaXff/DQe5YbCE9woRC5o7B5tmNodKjgkopK1RxW76ZURHX
 g/rQ==
X-Gm-Message-State: AOJu0YzedMsqLYEf0TkLgSPy2Q6pIKJe3McNTm5zRthLzCiDXWM21gLs
 fVXl+MeZEiKgGNX6AgO5EphIWEjPVMZm8EGJch0=
X-Google-Smtp-Source: AGHT+IHM2TyTPGZFJZD74exP7sZWxX7K4D8EOEUMaEakkkiaj1qUKG6TJmuh5nx/jLJshlJCGuZ45g==
X-Received: by 2002:a05:6512:11eb:b0:507:a383:fe18 with SMTP id
 p11-20020a05651211eb00b00507a383fe18mr11716101lfs.40.1700205446406; 
 Thu, 16 Nov 2023 23:17:26 -0800 (PST)
Received: from m1x-phil.lan (bd137-h02-176-184-46-187.dsl.sta.abo.bbox.fr.
 [176.184.46.187]) by smtp.gmail.com with ESMTPSA id
 t4-20020a5d4604000000b0032fbd0c7d04sm1417408wrq.55.2023.11.16.23.17.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Nov 2023 23:17:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Igor Mammedov <imammedo@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Felipe Balbi <balbi@kernel.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 Alistair Francis <alistair@alistair23.me>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, Helge Deller <deller@gmx.de>,
 Subbaraya Sundeep <sbhatta@marvell.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Gavin Shan <gshan@redhat.com>
Subject: [PATCH-for-8.2? v2 3/4] hw/arm/stm32f205: Report error when incorrect
 CPU is used
Date: Fri, 17 Nov 2023 08:17:03 +0100
Message-ID: <20231117071704.35040-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231117071704.35040-1-philmd@linaro.org>
References: <20231117071704.35040-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12f.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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
index 83753d53a3..501f63a77f 100644
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
+    static const char * const valid_cpu_types[] = {
+        ARM_CPU_TYPE_NAME("cortex-m3"),
+        NULL
+    };
+
     mc->desc = "Netduino 2 Machine (Cortex-M3)";
     mc->init = netduino2_init;
+    mc->valid_cpu_types = valid_cpu_types;
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


