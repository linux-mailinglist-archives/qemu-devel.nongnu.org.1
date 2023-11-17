Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D2F7EEC8D
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 08:19:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3t6h-0005Sp-GZ; Fri, 17 Nov 2023 02:17:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3t6e-0005RY-P9
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 02:17:36 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3t6c-0004Kj-86
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 02:17:35 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-32f87b1c725so1217732f8f.3
 for <qemu-devel@nongnu.org>; Thu, 16 Nov 2023 23:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700205452; x=1700810252; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jkPUT0M619zXl9UJEyr5oJWxqcVgknV+BijjQqGI0PI=;
 b=nlT6RRn1osVMNVwVIYTzC8UV4L+/I+iRb52SLisKanQB6HUTLQ+Ab8oM6mJCPAipkR
 6O6F91rqsiCTqSy9ob8yRmaCKxRn0HBs/qyo+PWUxaum7hoh6YLnnHdsxcnKfyc0+zhS
 LrNVVH7P//5Y0OXNVKCgpSno6sOAzfhVVtcGzbEC9cz4ix2yEr9Tppnb2ecYrQLgcbmt
 U28a6aVAJttO29uYhk2lxXPLH1DmgwjwUhpj2aZ0RJuxbDZEwdBeOkAocKF0BF+fiQ1t
 dXfdUsnKP2tiisq4GsoLOK36gTvXXBxet1kKavkeqRQoaE/VToW0Mssaaj/5MCsoMfv7
 lE4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700205452; x=1700810252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jkPUT0M619zXl9UJEyr5oJWxqcVgknV+BijjQqGI0PI=;
 b=wjpIwgNYa0zAtOSCECstaJtRurz5kEhEhAYq/REucx+ynv4eV0hRwLvoeqPdZzxElg
 yBAkYhU5I4miTKhEFnnpBwMfO8Sp6aTLUlPbfsyjsCOQf6Wmk4LuozG9qtqDxlhLuijw
 SsGiYQh/W82PdaRdPsNlI9F5zHIdGXkviSjMltdEMMZF6igU3PLLSBqEoeueU/9tqtyH
 EhfYnUMSaMbPxcGQg/dyQZfDfoOd8OQOlGh2SzWGEqo79XVwWqBpvSKY+OudIprb1fH6
 lXR4jy+ALi67K2itXevfTZO5NWqeVVzJNJ3krrxUe7pBMDsCDH2UO5iELirSX+/7mge4
 JpLA==
X-Gm-Message-State: AOJu0Yzaf7McA/zPZsJ6tNdhMCeADfMoNmx9toKRfJKijRb4dGLnN8tb
 u0W3K6O1yIHjNCJJ+9uK2lNNqMULnDDWVlF0W30=
X-Google-Smtp-Source: AGHT+IHFTvcbCgKP7OFB5B5FhkYKXGMpXDSZe+jYZyBLuao/KsF0vglURAPe6cpUVno6sFuauNdYvg==
X-Received: by 2002:adf:ed41:0:b0:32d:b9c5:82fc with SMTP id
 u1-20020adfed41000000b0032db9c582fcmr11874479wro.36.1700205452492; 
 Thu, 16 Nov 2023 23:17:32 -0800 (PST)
Received: from m1x-phil.lan (bd137-h02-176-184-46-187.dsl.sta.abo.bbox.fr.
 [176.184.46.187]) by smtp.gmail.com with ESMTPSA id
 q16-20020adfcd90000000b0032d9caeab0fsm1409272wrj.77.2023.11.16.23.17.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Nov 2023 23:17:32 -0800 (PST)
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
Subject: [PATCH-for-8.2? v2 4/4] hw/arm/stm32f100: Report error when incorrect
 CPU is used
Date: Fri, 17 Nov 2023 08:17:04 +0100
Message-ID: <20231117071704.35040-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231117071704.35040-1-philmd@linaro.org>
References: <20231117071704.35040-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

The 'stm32vldiscovery' machine ignores the CPU type requested by
the command line. This might confuse users, since the following
will create a machine with a Cortex-M3 CPU:

  $ qemu-system-aarch64 -M stm32vldiscovery -cpu neoverse-n1

Set the MachineClass::valid_cpu_types field (introduced in commit
c9cf636d48 "machine: Add a valid_cpu_types property").
Remove the now unused MachineClass::default_cpu_type field.

We now get:

  $ qemu-system-aarch64 -M stm32vldiscovery -cpu neoverse-n1
  qemu-system-aarch64: Invalid CPU type: neoverse-n1-arm-cpu
  The valid types are: cortex-m3-arm-cpu

Since the SoC family can only use Cortex-M3 CPUs, hard-code the
CPU type name at the SoC level, removing the QOM property
entirely.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/arm/stm32f100_soc.h | 4 ----
 hw/arm/stm32f100_soc.c         | 9 ++-------
 hw/arm/stm32vldiscovery.c      | 7 ++++++-
 3 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/include/hw/arm/stm32f100_soc.h b/include/hw/arm/stm32f100_soc.h
index 40cd415b28..a74d7b369c 100644
--- a/include/hw/arm/stm32f100_soc.h
+++ b/include/hw/arm/stm32f100_soc.h
@@ -43,12 +43,8 @@ OBJECT_DECLARE_SIMPLE_TYPE(STM32F100State, STM32F100_SOC)
 #define SRAM_SIZE (8 * 1024)
 
 struct STM32F100State {
-    /*< private >*/
     SysBusDevice parent_obj;
 
-    /*< public >*/
-    char *cpu_type;
-
     ARMv7MState armv7m;
 
     STM32F2XXUsartState usart[STM_NUM_USARTS];
diff --git a/hw/arm/stm32f100_soc.c b/hw/arm/stm32f100_soc.c
index f7b344ba9f..b90d440d7a 100644
--- a/hw/arm/stm32f100_soc.c
+++ b/hw/arm/stm32f100_soc.c
@@ -115,7 +115,7 @@ static void stm32f100_soc_realize(DeviceState *dev_soc, Error **errp)
     /* Init ARMv7m */
     armv7m = DEVICE(&s->armv7m);
     qdev_prop_set_uint32(armv7m, "num-irq", 61);
-    qdev_prop_set_string(armv7m, "cpu-type", s->cpu_type);
+    qdev_prop_set_string(armv7m, "cpu-type", ARM_CPU_TYPE_NAME("cortex-m3"));
     qdev_prop_set_bit(armv7m, "enable-bitband", true);
     qdev_connect_clock_in(armv7m, "cpuclk", s->sysclk);
     qdev_connect_clock_in(armv7m, "refclk", s->refclk);
@@ -180,17 +180,12 @@ static void stm32f100_soc_realize(DeviceState *dev_soc, Error **errp)
     create_unimplemented_device("CRC",       0x40023000, 0x400);
 }
 
-static Property stm32f100_soc_properties[] = {
-    DEFINE_PROP_STRING("cpu-type", STM32F100State, cpu_type),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
 static void stm32f100_soc_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = stm32f100_soc_realize;
-    device_class_set_props(dc, stm32f100_soc_properties);
+    /* No vmstate or reset required: device has no internal state */
 }
 
 static const TypeInfo stm32f100_soc_info = {
diff --git a/hw/arm/stm32vldiscovery.c b/hw/arm/stm32vldiscovery.c
index 67675e952f..190db6118b 100644
--- a/hw/arm/stm32vldiscovery.c
+++ b/hw/arm/stm32vldiscovery.c
@@ -47,7 +47,6 @@ static void stm32vldiscovery_init(MachineState *machine)
     clock_set_hz(sysclk, SYSCLK_FRQ);
 
     dev = qdev_new(TYPE_STM32F100_SOC);
-    qdev_prop_set_string(dev, "cpu-type", ARM_CPU_TYPE_NAME("cortex-m3"));
     qdev_connect_clock_in(dev, "sysclk", sysclk);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
@@ -58,8 +57,14 @@ static void stm32vldiscovery_init(MachineState *machine)
 
 static void stm32vldiscovery_machine_init(MachineClass *mc)
 {
+    static const char * const valid_cpu_types[] = {
+        ARM_CPU_TYPE_NAME("cortex-m3"),
+        NULL
+    };
+
     mc->desc = "ST STM32VLDISCOVERY (Cortex-M3)";
     mc->init = stm32vldiscovery_init;
+    mc->valid_cpu_types = valid_cpu_types;
 }
 
 DEFINE_MACHINE("stm32vldiscovery", stm32vldiscovery_machine_init)
-- 
2.41.0


