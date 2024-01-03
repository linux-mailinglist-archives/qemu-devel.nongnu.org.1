Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 986D78230D7
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 16:55:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL3Z8-0004ML-7s; Wed, 03 Jan 2024 10:53:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sam@rfc1149.net>)
 id 1rL3Z5-0004Kh-Ul; Wed, 03 Jan 2024 10:53:55 -0500
Received: from zoidberg.rfc1149.net ([195.154.227.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sam@rfc1149.net>)
 id 1rL3Z2-00052L-Ko; Wed, 03 Jan 2024 10:53:55 -0500
Received: from buffy.. (buffy [192.168.147.6])
 by zoidberg.rfc1149.net (Postfix) with ESMTP id 42FAE80028;
 Wed,  3 Jan 2024 16:53:44 +0100 (CET)
Authentication-Results: zoidberg.rfc1149.net;
 dmarc=fail (p=none dis=none) header.from=rfc1149.net
Authentication-Results: zoidberg.rfc1149.net;
 spf=fail smtp.mailfrom=rfc1149.net
From: Samuel Tardieu <sam@rfc1149.net>
To: qemu-devel@nongnu.org
Cc: Arnaud Minier <arnaud.minier@telecom-paris.fr>, qemu-arm@nongnu.org,
 Anton Kochkov <anton.kochkov@proton.me>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 Alexandre Iooss <erdnaxe@crans.org>, Samuel Tardieu <sam@rfc1149.net>
Subject: [PATCH v2 3/3] hw/arm/socs: configure priority bits for existing SOCs
Date: Wed,  3 Jan 2024 16:53:37 +0100
Message-ID: <20240103155337.2026946-4-sam@rfc1149.net>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240103155337.2026946-1-sam@rfc1149.net>
References: <20240103155337.2026946-1-sam@rfc1149.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.154.227.159; envelope-from=sam@rfc1149.net;
 helo=zoidberg.rfc1149.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Update the number of priority bits for a number of existing
SoCs according to their technical documentation:

- STM32F100/F205/F405/L4x5: 4 bits
- Stellaris (Sandstorm/Fury): 3 bits

Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
---
 hw/arm/stellaris.c     | 2 ++
 hw/arm/stm32f100_soc.c | 1 +
 hw/arm/stm32f205_soc.c | 1 +
 hw/arm/stm32f405_soc.c | 1 +
 hw/arm/stm32l4x5_soc.c | 1 +
 5 files changed, 6 insertions(+)

diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index dd90f686bf..38981967f3 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -47,6 +47,7 @@
 #define BP_GAMEPAD   0x04
 
 #define NUM_IRQ_LINES 64
+#define NUM_PRIO_BITS 3
 
 typedef const struct {
     const char *name;
@@ -1067,6 +1068,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
 
     nvic = qdev_new(TYPE_ARMV7M);
     qdev_prop_set_uint32(nvic, "num-irq", NUM_IRQ_LINES);
+    qdev_prop_set_uint8(nvic, "num-prio-bits", NUM_PRIO_BITS);
     qdev_prop_set_string(nvic, "cpu-type", ms->cpu_type);
     qdev_prop_set_bit(nvic, "enable-bitband", true);
     qdev_connect_clock_in(nvic, "cpuclk",
diff --git a/hw/arm/stm32f100_soc.c b/hw/arm/stm32f100_soc.c
index b90d440d7a..808b783515 100644
--- a/hw/arm/stm32f100_soc.c
+++ b/hw/arm/stm32f100_soc.c
@@ -115,6 +115,7 @@ static void stm32f100_soc_realize(DeviceState *dev_soc, Error **errp)
     /* Init ARMv7m */
     armv7m = DEVICE(&s->armv7m);
     qdev_prop_set_uint32(armv7m, "num-irq", 61);
+    qdev_prop_set_uint8(armv7m, "num-prio-bits", 4);
     qdev_prop_set_string(armv7m, "cpu-type", ARM_CPU_TYPE_NAME("cortex-m3"));
     qdev_prop_set_bit(armv7m, "enable-bitband", true);
     qdev_connect_clock_in(armv7m, "cpuclk", s->sysclk);
diff --git a/hw/arm/stm32f205_soc.c b/hw/arm/stm32f205_soc.c
index 1a548646f6..a451e21f59 100644
--- a/hw/arm/stm32f205_soc.c
+++ b/hw/arm/stm32f205_soc.c
@@ -127,6 +127,7 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
 
     armv7m = DEVICE(&s->armv7m);
     qdev_prop_set_uint32(armv7m, "num-irq", 96);
+    qdev_prop_set_uint8(armv7m, "num-prio-bits", 4);
     qdev_prop_set_string(armv7m, "cpu-type", ARM_CPU_TYPE_NAME("cortex-m3"));
     qdev_prop_set_bit(armv7m, "enable-bitband", true);
     qdev_connect_clock_in(armv7m, "cpuclk", s->sysclk);
diff --git a/hw/arm/stm32f405_soc.c b/hw/arm/stm32f405_soc.c
index a65bbe298d..2ad5b79a06 100644
--- a/hw/arm/stm32f405_soc.c
+++ b/hw/arm/stm32f405_soc.c
@@ -149,6 +149,7 @@ static void stm32f405_soc_realize(DeviceState *dev_soc, Error **errp)
 
     armv7m = DEVICE(&s->armv7m);
     qdev_prop_set_uint32(armv7m, "num-irq", 96);
+    qdev_prop_set_uint8(armv7m, "num-prio-bits", 4);
     qdev_prop_set_string(armv7m, "cpu-type", ARM_CPU_TYPE_NAME("cortex-m4"));
     qdev_prop_set_bit(armv7m, "enable-bitband", true);
     qdev_connect_clock_in(armv7m, "cpuclk", s->sysclk);
diff --git a/hw/arm/stm32l4x5_soc.c b/hw/arm/stm32l4x5_soc.c
index 7513db0d6a..cc70c83d20 100644
--- a/hw/arm/stm32l4x5_soc.c
+++ b/hw/arm/stm32l4x5_soc.c
@@ -105,6 +105,7 @@ static void stm32l4x5_soc_realize(DeviceState *dev_soc, Error **errp)
     object_initialize_child(OBJECT(dev_soc), "armv7m", &s->armv7m, TYPE_ARMV7M);
     armv7m = DEVICE(&s->armv7m);
     qdev_prop_set_uint32(armv7m, "num-irq", 96);
+    qdev_prop_set_uint32(armv7m, "num-prio-bits", 4);
     qdev_prop_set_string(armv7m, "cpu-type", ARM_CPU_TYPE_NAME("cortex-m4"));
     qdev_prop_set_bit(armv7m, "enable-bitband", true);
     qdev_connect_clock_in(armv7m, "cpuclk", s->sysclk);
-- 
2.42.0


