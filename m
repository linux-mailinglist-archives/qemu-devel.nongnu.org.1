Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F262482F125
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 16:14:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPl7H-0006dG-5D; Tue, 16 Jan 2024 10:12:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPl7E-0006c8-LJ
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 10:12:36 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPl7B-0005pm-SF
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 10:12:36 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-336dcebcdb9so9497018f8f.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 07:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705417952; x=1706022752; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aEouYnD61ul1nKN/Rnd+Ze2JeHgwDcgqLT0TGxNBfQk=;
 b=W/QV9zKUje6R3NtzQFTSfj7fIwK6+ipISQhBt3f4vx+J6n6Z6dsZjB/wfFFslfq5to
 Vb0Lr9PNPYLdR9O6g5ntchFJgH5XoyjbiuhLLy8eCiPu+t3kqAaCJl/cM3iC/+jqeuJd
 qJeGtRY8Udw2CRwlCUbzklOuK7EH+WQi/L7eaGrttYVGkh9MUbigfJmVXZk78T4AWQnN
 FVkcQ+/Pm/8KTHnICJYzqP6qTx7LkVaoKc+8EF7SaCHpXYH9B0Zl2cuyX1RfR+gMkF2a
 1gKWN8pokCJ8lmEeUNWR/Lcctt2OWrcF9iyMrdqP5S061PCKvkNEof5CTQ2E9Vixhl7R
 ZkWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705417952; x=1706022752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aEouYnD61ul1nKN/Rnd+Ze2JeHgwDcgqLT0TGxNBfQk=;
 b=XvZENMMmckAuYLoPJWRytcLmqM9TUNu8JJUBmaRYlyP2II6hrhkmEp7ISGiX7RZqHF
 Ud/x3stTl8a+KswkftXks2JTerwNh9hW3Y3JOQfnokH4WGdA4Oy55+/hKqDXi+NeY7+h
 ssi6D8kruRN1MHlyoIJjbH0bUaYvszyKTxKJckNzeCWo5QOtbzufVBN6BTcN6yEG/0sz
 CpYP388cJAi+fue84xKYyzNKOMDYFaNuGvMoScamTWTfCClPEpOffsfdZUX+OD2C+H3o
 C29N6JcNxdTGj5yWkJpYYuokDpXtAFJoWNu8r3QesJ+zYtgRZp1Xvhj7yeXBjDZm7VqV
 IBZw==
X-Gm-Message-State: AOJu0Yxc9wHEvHicWvyvkIWigpMr5I7zoTcJuiKZKmKYAYdRuMA0uLUu
 e1WGyzcQs/hlmQjzHtecQx9CZ16tnvAFE0WdmgQw5fwwLqk=
X-Google-Smtp-Source: AGHT+IGKe2mah035WChyW3b28CI2xrbEAVLWWMqWOfWDsJX68Bx55caNcWngmiFtVbicwkk0C/yepw==
X-Received: by 2002:adf:fd0c:0:b0:337:68a7:11ed with SMTP id
 e12-20020adffd0c000000b0033768a711edmr1510965wrr.228.1705417952611; 
 Tue, 16 Jan 2024 07:12:32 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 m14-20020adff38e000000b003379b549a00sm10091357wro.10.2024.01.16.07.12.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 07:12:32 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/21] hw/arm: Connect STM32L4x5 SYSCFG to STM32L4x5 SoC
Date: Tue, 16 Jan 2024 15:12:15 +0000
Message-Id: <20240116151228.2430754-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240116151228.2430754-1-peter.maydell@linaro.org>
References: <20240116151228.2430754-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

From: Inès Varhol <ines.varhol@telecom-paris.fr>

The SYSCFG input GPIOs aren't connected yet. When the STM32L4x5 GPIO
device will be implemented, its output GPIOs will be connected to the
SYSCFG input GPIOs.

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20240109194438.70934-3-ines.varhol@telecom-paris.fr
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/stm32l4x5_soc.h |  2 ++
 hw/arm/stm32l4x5_soc.c         | 21 ++++++++++++++++++++-
 hw/arm/Kconfig                 |  1 +
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/include/hw/arm/stm32l4x5_soc.h b/include/hw/arm/stm32l4x5_soc.h
index f7305568dcc..baf70410b5f 100644
--- a/include/hw/arm/stm32l4x5_soc.h
+++ b/include/hw/arm/stm32l4x5_soc.h
@@ -26,6 +26,7 @@
 
 #include "exec/memory.h"
 #include "hw/arm/armv7m.h"
+#include "hw/misc/stm32l4x5_syscfg.h"
 #include "hw/misc/stm32l4x5_exti.h"
 #include "qom/object.h"
 
@@ -41,6 +42,7 @@ struct Stm32l4x5SocState {
     ARMv7MState armv7m;
 
     Stm32l4x5ExtiState exti;
+    Stm32l4x5SyscfgState syscfg;
 
     MemoryRegion sram1;
     MemoryRegion sram2;
diff --git a/hw/arm/stm32l4x5_soc.c b/hw/arm/stm32l4x5_soc.c
index 756eb694884..f470ff74ec7 100644
--- a/hw/arm/stm32l4x5_soc.c
+++ b/hw/arm/stm32l4x5_soc.c
@@ -37,6 +37,7 @@
 #define SRAM2_SIZE (32 * KiB)
 
 #define EXTI_ADDR 0x40010400
+#define SYSCFG_ADDR 0x40010000
 
 #define NUM_EXTI_IRQ 40
 /* Match exti line connections with their CPU IRQ number */
@@ -80,6 +81,7 @@ static void stm32l4x5_soc_initfn(Object *obj)
     Stm32l4x5SocState *s = STM32L4X5_SOC(obj);
 
     object_initialize_child(obj, "exti", &s->exti, TYPE_STM32L4X5_EXTI);
+    object_initialize_child(obj, "syscfg", &s->syscfg, TYPE_STM32L4X5_SYSCFG);
 
     s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
     s->refclk = qdev_init_clock_in(DEVICE(s), "refclk", NULL, NULL, 0);
@@ -155,6 +157,19 @@ static void stm32l4x5_soc_realize(DeviceState *dev_soc, Error **errp)
         return;
     }
 
+    /* System configuration controller */
+    busdev = SYS_BUS_DEVICE(&s->syscfg);
+    if (!sysbus_realize(busdev, errp)) {
+        return;
+    }
+    sysbus_mmio_map(busdev, 0, SYSCFG_ADDR);
+    /*
+     * TODO: when the GPIO device is implemented, connect it
+     * to SYCFG using `qdev_connect_gpio_out`, NUM_GPIOS and
+     * GPIO_NUM_PINS.
+     */
+
+    /* EXTI device */
     busdev = SYS_BUS_DEVICE(&s->exti);
     if (!sysbus_realize(busdev, errp)) {
         return;
@@ -164,6 +179,11 @@ static void stm32l4x5_soc_realize(DeviceState *dev_soc, Error **errp)
         sysbus_connect_irq(busdev, i, qdev_get_gpio_in(armv7m, exti_irq[i]));
     }
 
+    for (unsigned i = 0; i < 16; i++) {
+        qdev_connect_gpio_out(DEVICE(&s->syscfg), i,
+                              qdev_get_gpio_in(DEVICE(&s->exti), i));
+    }
+
     /* APB1 BUS */
     create_unimplemented_device("TIM2",      0x40000000, 0x400);
     create_unimplemented_device("TIM3",      0x40000400, 0x400);
@@ -201,7 +221,6 @@ static void stm32l4x5_soc_realize(DeviceState *dev_soc, Error **errp)
     /* RESERVED:    0x40009800, 0x6800 */
 
     /* APB2 BUS */
-    create_unimplemented_device("SYSCFG",    0x40010000, 0x30);
     create_unimplemented_device("VREFBUF",   0x40010030, 0x1D0);
     create_unimplemented_device("COMP",      0x40010200, 0x200);
     /* RESERVED:    0x40010800, 0x1400 */
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index da9c6e5064d..218b454e97f 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -459,6 +459,7 @@ config STM32L4X5_SOC
     bool
     select ARM_V7M
     select OR_IRQ
+    select STM32L4X5_SYSCFG
     select STM32L4X5_EXTI
 
 config XLNX_ZYNQMP_ARM
-- 
2.34.1


