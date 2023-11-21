Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5EA7F2A54
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 11:26:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5Nw4-0004Ki-Rj; Tue, 21 Nov 2023 05:24:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r5Nw2-0004Iy-BE
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 05:24:50 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r5Nvz-0007Ez-Ih
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 05:24:50 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40839807e82so16619315e9.0
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 02:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700562286; x=1701167086; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oiUnhyvPvuaZLFK9pIShm6X1qmnlGPN+kB6sEamcCNk=;
 b=rcfTl/iaDNjpihlRNQ4ocO9Ahzsd3fZnvfeNnCA5l/YiTzQdN5yLKqeeHl/A1PGdpK
 8DCG4IuEVcPcWhVWXCGS25NywOUwKgFgVkOWIUQMaHEtGjMGMXrOrVi8ea4rHKp0VbyF
 c4Kkv2pWumZcKq4J9saAEyuHgedTV5cnRz20IOP8acWXl4jI9R7BBQQl+ci8d53wtP/Y
 7N1kd/5AXdNCHYP9LMrgbIIGYfhcILuI3KsBNrU1idEJTg7h4H6jnOK9hbFIXU57PFG3
 fQWMf0nQUmCy7BvdjbmHvqUx+XY9+wTMdozk+IY4oQyelW6YoGtALEsiQdaCZFDjf6mM
 i9UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700562286; x=1701167086;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oiUnhyvPvuaZLFK9pIShm6X1qmnlGPN+kB6sEamcCNk=;
 b=o8hAnITgdImSGXUFsetMFXb/vbof3LoNLK6RTXCmOT6+v/738rn3MaqZLM5MFZpwUp
 ORMH+a8kHTJ57+njm9Vgf+lBvyKdkEv6E5k8fKkUKGnx3wGfQb2P1wlWfTweYYQgWJwZ
 HZhC7GxTWqJJYiEYkOBJxRlCh7EosoRfhtTZ0fpaQWqUxuQsrpIGkJVdH3lv/TqtxKYy
 XspguM+Ya5dsSG4p8itGNtAVplupQP3LzRmpTHrmb0Yp0wo/dwJTDhNWXPYGwiBalPko
 6mG69b8ti2XKzdkwSBQsBIvzMAvI5tPmGjyVkAYxbV4cGY5pJbQjNUtpXjyYCO/7bYwH
 A2Fg==
X-Gm-Message-State: AOJu0YwVtER4rWMgG0YX0QjFJqyIoRcXBjGvwsyAXV8/qM4gaZlbTVpH
 2GvvR1mzHY3eNipoQaK4hjz/9SA4TDb43BBy2RU=
X-Google-Smtp-Source: AGHT+IG5OGgcAvB+6DAJwv2fawesGqN+7unFSCk+AMwp5lwyKRZJErnGX5a20HK/6hVxXmFRLmXWgA==
X-Received: by 2002:a05:600c:5489:b0:405:784a:d53e with SMTP id
 iv9-20020a05600c548900b00405784ad53emr1722310wmb.20.1700562286267; 
 Tue, 21 Nov 2023 02:24:46 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 n25-20020a05600c181900b00405442edc69sm20450835wmp.14.2023.11.21.02.24.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 02:24:45 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 6/8] hw/arm/stm32f205: Report error when incorrect CPU is used
Date: Tue, 21 Nov 2023 10:24:39 +0000
Message-Id: <20231121102441.3872902-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121102441.3872902-1-peter.maydell@linaro.org>
References: <20231121102441.3872902-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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
Reviewed-by: Gavin Shan <gshan@redhat.com>
Message-id: 20231117071704.35040-4-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/stm32f205_soc.h | 4 ----
 hw/arm/netduino2.c             | 7 ++++++-
 hw/arm/stm32f205_soc.c         | 9 ++-------
 3 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/include/hw/arm/stm32f205_soc.h b/include/hw/arm/stm32f205_soc.h
index 5a4f7762642..4f4c8bbebc1 100644
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
index 83753d53a3f..501f63a77f9 100644
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
index c6b75a381d9..1a548646f6e 100644
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
2.34.1


