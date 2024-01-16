Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2508782F128
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 16:14:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPl7I-0006e0-01; Tue, 16 Jan 2024 10:12:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPl7D-0006av-4e
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 10:12:35 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPl7A-0005pX-JA
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 10:12:34 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40e6f652eb8so31586775e9.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 07:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705417951; x=1706022751; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VAVTWClTEh7CJpAtB//5gPjxZvPZtR6L1YFOIhsdaEc=;
 b=ftiyL+A4+p8BUQ6sm33/rLrIawj32x3UxNCRAOB93YyqgPNcrDphRhFJuh6HPea7FM
 ayIdyP8pc71nbdj94n/v4wtbAd4HhkxtcN4DLppJRVgUAe0ebBC0fsH4pCpz3gpS/bN2
 RkPLvCTxco+m/dHseol4Y4//gw3EiRblh+Ar3Qg9Tam5YViIJ6eIu3DbyjJTr+3hKyca
 zRGWGqSffpwXwnnqP1EHO3fsu/nij+vz4k4uzLmINm6Hucg6bs0QWxiIUuWtACqaLmQc
 Kvuojsc9n8MOMZh6ZYsSaqWYhKMT4WaTd4cIYTJOTOPRIEqzEy0D/56C/v4WbCVY67Kk
 mcWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705417951; x=1706022751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VAVTWClTEh7CJpAtB//5gPjxZvPZtR6L1YFOIhsdaEc=;
 b=RqvBCJ01RW7ywdaXe3O8MJbWPl8rzTBIeI0vIt8WAvhMcArOlRhQuMWejWH9QDOzLr
 AD79Y1xIT17Xt3GlOz6Ed9jqXFmhukVZaBPl/gUmFGuf0i+Yf8ful39xSOFgUV3o3W34
 Zw327lX8T6bxkqjpHx9YfOctQeVTv/roH6gkPXWKO5/pWBx2lwd1MKWYzKJLyEAAKXXj
 qszprTAY8XlZsqq18Zs1JJw4uS4iP5+kQtkRTX5eUAYOb8Mhyp0DDuOXD6todYoStexd
 QXqLAVhx5IXBsG9OeU3RmIjTfvgvRcqdplzT3ahPJ6m6LfpeQkSs+BlvDVg+fzwVTVB5
 KfFg==
X-Gm-Message-State: AOJu0YxGa3ZehDHn9Pa4e7I83SBIiSNWTEKZUyskTSjun2Gthsn8mN9y
 jPw6MHhWdmEAdF8dvYsKh4xcNdiorX1VGaLK5MAixf+JFQc=
X-Google-Smtp-Source: AGHT+IGyog9r3wkoUxi6GhdeTbuEb4gFQlORWX6pqIGavNNst01zOUqWmHzqN8+EFEqnOK7AykXSIQ==
X-Received: by 2002:a05:600c:3799:b0:40e:6793:255 with SMTP id
 o25-20020a05600c379900b0040e67930255mr3351433wmr.138.1705417951304; 
 Tue, 16 Jan 2024 07:12:31 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 m14-20020adff38e000000b003379b549a00sm10091357wro.10.2024.01.16.07.12.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 07:12:31 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/21] hw/arm: Connect STM32L4x5 EXTI to STM32L4x5 SoC
Date: Tue, 16 Jan 2024 15:12:12 +0000
Message-Id: <20240116151228.2430754-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240116151228.2430754-1-peter.maydell@linaro.org>
References: <20240116151228.2430754-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
Message-id: 20240109160658.311932-3-ines.varhol@telecom-paris.fr
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/stm32l4x5_soc.h |  3 ++
 hw/arm/stm32l4x5_soc.c         | 52 +++++++++++++++++++++++++++++++++-
 hw/arm/Kconfig                 |  1 +
 3 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/include/hw/arm/stm32l4x5_soc.h b/include/hw/arm/stm32l4x5_soc.h
index 2fd44a36a9d..f7305568dcc 100644
--- a/include/hw/arm/stm32l4x5_soc.h
+++ b/include/hw/arm/stm32l4x5_soc.h
@@ -26,6 +26,7 @@
 
 #include "exec/memory.h"
 #include "hw/arm/armv7m.h"
+#include "hw/misc/stm32l4x5_exti.h"
 #include "qom/object.h"
 
 #define TYPE_STM32L4X5_SOC "stm32l4x5-soc"
@@ -39,6 +40,8 @@ struct Stm32l4x5SocState {
 
     ARMv7MState armv7m;
 
+    Stm32l4x5ExtiState exti;
+
     MemoryRegion sram1;
     MemoryRegion sram2;
     MemoryRegion flash;
diff --git a/hw/arm/stm32l4x5_soc.c b/hw/arm/stm32l4x5_soc.c
index 159d5315c99..756eb694884 100644
--- a/hw/arm/stm32l4x5_soc.c
+++ b/hw/arm/stm32l4x5_soc.c
@@ -36,10 +36,51 @@
 #define SRAM2_BASE_ADDRESS 0x10000000
 #define SRAM2_SIZE (32 * KiB)
 
+#define EXTI_ADDR 0x40010400
+
+#define NUM_EXTI_IRQ 40
+/* Match exti line connections with their CPU IRQ number */
+/* See Vector Table (Reference Manual p.396) */
+static const int exti_irq[NUM_EXTI_IRQ] = {
+    6,                      /* GPIO[0]                 */
+    7,                      /* GPIO[1]                 */
+    8,                      /* GPIO[2]                 */
+    9,                      /* GPIO[3]                 */
+    10,                     /* GPIO[4]                 */
+    23, 23, 23, 23, 23,     /* GPIO[5..9]              */
+    40, 40, 40, 40, 40, 40, /* GPIO[10..15]            */
+    1,                      /* PVD                     */
+    67,                     /* OTG_FS_WKUP, Direct     */
+    41,                     /* RTC_ALARM               */
+    2,                      /* RTC_TAMP_STAMP2/CSS_LSE */
+    3,                      /* RTC wakeup timer        */
+    63,                     /* COMP1                   */
+    63,                     /* COMP2                   */
+    31,                     /* I2C1 wakeup, Direct     */
+    33,                     /* I2C2 wakeup, Direct     */
+    72,                     /* I2C3 wakeup, Direct     */
+    37,                     /* USART1 wakeup, Direct   */
+    38,                     /* USART2 wakeup, Direct   */
+    39,                     /* USART3 wakeup, Direct   */
+    52,                     /* UART4 wakeup, Direct    */
+    53,                     /* UART4 wakeup, Direct    */
+    70,                     /* LPUART1 wakeup, Direct  */
+    65,                     /* LPTIM1, Direct          */
+    66,                     /* LPTIM2, Direct          */
+    76,                     /* SWPMI1 wakeup, Direct   */
+    1,                      /* PVM1 wakeup             */
+    1,                      /* PVM2 wakeup             */
+    1,                      /* PVM3 wakeup             */
+    1,                      /* PVM4 wakeup             */
+    78                      /* LCD wakeup, Direct      */
+};
+
 static void stm32l4x5_soc_initfn(Object *obj)
 {
     Stm32l4x5SocState *s = STM32L4X5_SOC(obj);
 
+    object_initialize_child(obj, "exti", &s->exti, TYPE_STM32L4X5_EXTI);
+
     s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
     s->refclk = qdev_init_clock_in(DEVICE(s), "refclk", NULL, NULL, 0);
 }
@@ -51,6 +92,7 @@ static void stm32l4x5_soc_realize(DeviceState *dev_soc, Error **errp)
     const Stm32l4x5SocClass *sc = STM32L4X5_SOC_GET_CLASS(dev_soc);
     MemoryRegion *system_memory = get_system_memory();
     DeviceState *armv7m;
+    SysBusDevice *busdev;
 
     /*
      * We use s->refclk internally and only define it with qdev_init_clock_in()
@@ -113,6 +155,15 @@ static void stm32l4x5_soc_realize(DeviceState *dev_soc, Error **errp)
         return;
     }
 
+    busdev = SYS_BUS_DEVICE(&s->exti);
+    if (!sysbus_realize(busdev, errp)) {
+        return;
+    }
+    sysbus_mmio_map(busdev, 0, EXTI_ADDR);
+    for (unsigned i = 0; i < NUM_EXTI_IRQ; i++) {
+        sysbus_connect_irq(busdev, i, qdev_get_gpio_in(armv7m, exti_irq[i]));
+    }
+
     /* APB1 BUS */
     create_unimplemented_device("TIM2",      0x40000000, 0x400);
     create_unimplemented_device("TIM3",      0x40000400, 0x400);
@@ -153,7 +204,6 @@ static void stm32l4x5_soc_realize(DeviceState *dev_soc, Error **errp)
     create_unimplemented_device("SYSCFG",    0x40010000, 0x30);
     create_unimplemented_device("VREFBUF",   0x40010030, 0x1D0);
     create_unimplemented_device("COMP",      0x40010200, 0x200);
-    create_unimplemented_device("EXTI",      0x40010400, 0x400);
     /* RESERVED:    0x40010800, 0x1400 */
     create_unimplemented_device("FIREWALL",  0x40011C00, 0x400);
     /* RESERVED:    0x40012000, 0x800 */
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 39d255425b1..da9c6e5064d 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -459,6 +459,7 @@ config STM32L4X5_SOC
     bool
     select ARM_V7M
     select OR_IRQ
+    select STM32L4X5_EXTI
 
 config XLNX_ZYNQMP_ARM
     bool
-- 
2.34.1


