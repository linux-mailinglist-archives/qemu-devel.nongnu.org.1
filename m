Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F409882ACE8
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 12:08:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNssU-0001Rg-4A; Thu, 11 Jan 2024 06:05:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNss5-0001KF-GL
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:13 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNss3-0004NU-BN
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:13 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-33674f60184so4942742f8f.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 03:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704971109; x=1705575909; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xdmkDsShtK90/D77OytZy2H9fVO4LlCAzfF++RrV4Lw=;
 b=wwPMqyIyy5DtPCMcuazwHP/tCqc0wmR3f34LtZKCB/hcfreFRN6gP5I2jVvRaqUeT7
 Vs2B5YehvGFkhKY6hbr+13eGxoK9Q63+9tKnt5rRhIPzGuIt8+ChaUhnfX0w/iIURj+r
 WtwGGWc++eGIJybG8FrATC/mlMREbYo7OLaPQ9dKGjmkeMMoifu+GPAeYLnV34+mGyI9
 FEbJjiVcO+Vtpf6xiJKQIsihfRwhEPA4WZ91wn9EbCss8+KkdTbrnW04MYRanHwC+wmS
 ROM4PwTRxmEoBmcv/agGl8iXfNKGx1vwB/JjnD72/oHkm8APBBX9qscuyz5WX7GaLDQp
 B2TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704971109; x=1705575909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xdmkDsShtK90/D77OytZy2H9fVO4LlCAzfF++RrV4Lw=;
 b=aYTc9hcjTSCtXOEG8JACokgVZv/I6RyDRT9fJGyvDHjE9Iw/jButQphCRCkY4PVMeS
 6Sz4zVnyQ8vdscvqk72jTkofyRIUPVcx9CZLqsJ03KqkI3vH77Tb2ko1dKcgU/cPu3dD
 zeC17rS7PQFCR5iHOoOhhFYwixdtDsgRlzvyLmTO/6edG+Vcxe6oaJHs7FisIjSamzER
 EiTY7Q4exDZjLnyR248TUmmeyiI1ST22kXUqfnud9CKhzqs3L5RLUL9QqWGCCCqro6fR
 plIC4QIo5DupbaZ6Grvof06IinomTwzuTNpLphjpOdPWp0u1hXcDPq2KmeJUyJyvY5lR
 wdaA==
X-Gm-Message-State: AOJu0Yz9+WPZ6Q2PZjnwMsmgKX9t4z6r+M71I8m/jcNTfBGgiOaKAcJM
 R8yyNGx5Zrvlb0aJFVAMPoo/a6HVcE2J686A8ImMrX/fobI=
X-Google-Smtp-Source: AGHT+IFMZQ7WJj1FPZLsB13YobS1pNGynQBZJyXhH9dELj0hQKxGqNHzkSuV1TwPO6gMWNEtenQ3uA==
X-Received: by 2002:a5d:4d82:0:b0:337:2ff5:f523 with SMTP id
 b2-20020a5d4d82000000b003372ff5f523mr362559wru.0.1704971109782; 
 Thu, 11 Jan 2024 03:05:09 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v30-20020adf8b5e000000b0033690139ea5sm951323wra.44.2024.01.11.03.05.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 03:05:09 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/41] hw/arm/socs: configure priority bits for existing SOCs
Date: Thu, 11 Jan 2024 11:04:30 +0000
Message-Id: <20240111110505.1563291-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240111110505.1563291-1-peter.maydell@linaro.org>
References: <20240111110505.1563291-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

From: Samuel Tardieu <sam@rfc1149.net>

Update the number of priority bits for a number of existing
SoCs according to their technical documentation:

- STM32F100/F205/F405/L4x5: 4 bits
- Stellaris (Sandstorm/Fury): 3 bits

Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20240106181503.1746200-4-sam@rfc1149.net
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/stellaris.c     | 2 ++
 hw/arm/stm32f100_soc.c | 1 +
 hw/arm/stm32f205_soc.c | 1 +
 hw/arm/stm32f405_soc.c | 1 +
 hw/arm/stm32l4x5_soc.c | 1 +
 5 files changed, 6 insertions(+)

diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 729a8bf5695..d18b1144af5 100644
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
index b90d440d7aa..808b783515d 100644
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
index 1a548646f6e..a451e21f59c 100644
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
index a65bbe298d2..2ad5b79a069 100644
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
index 70609a6dac4..159d5315c99 100644
--- a/hw/arm/stm32l4x5_soc.c
+++ b/hw/arm/stm32l4x5_soc.c
@@ -102,6 +102,7 @@ static void stm32l4x5_soc_realize(DeviceState *dev_soc, Error **errp)
     object_initialize_child(OBJECT(dev_soc), "armv7m", &s->armv7m, TYPE_ARMV7M);
     armv7m = DEVICE(&s->armv7m);
     qdev_prop_set_uint32(armv7m, "num-irq", 96);
+    qdev_prop_set_uint32(armv7m, "num-prio-bits", 4);
     qdev_prop_set_string(armv7m, "cpu-type", ARM_CPU_TYPE_NAME("cortex-m4"));
     qdev_prop_set_bit(armv7m, "enable-bitband", true);
     qdev_connect_clock_in(armv7m, "cpuclk", s->sysclk);
-- 
2.34.1


