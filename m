Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB41D723E47
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 11:50:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6TIw-0007ny-EW; Tue, 06 Jun 2023 05:48:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TIj-0007dq-Ui
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:30 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TIe-0004kg-Lx
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:28 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-30d5931d17aso2603126f8f.3
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 02:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686044902; x=1688636902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=l+7SZuW91IYDY1/Al5J0Dl+eXd+OCXM7N6/TelLxj04=;
 b=Av2N+4O/ustYoUh9vuYWW4t3MSPXRWltpjOazAsjbAR6ZEl8eIrfp394rWBn1afKky
 g9Fzvz5GJFI6MNL+eUdqbWz2U8PwPmu0qdKX8nsnPddv1GJlj/nNsKOMb4Q1HRGdbI0W
 w0xGxqzE8K4R3qIO6GrLsKDcsBjQbd27p/CcKxMtHsBp0xorzzcNffUQYx9TVe/3hKda
 pF7GXqzhOCEAtvOoUkwDgC2SX+WGLSwdLYjNFWg8OjtZYdXA8r49uXz0eA2ft8ksxNj4
 vMmWb8Q3t0clU/YPcCCOKqacUfuJHPpaQboX9nWgxuF33muGtf15cfW1jh9Ey7v1cune
 CrmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686044902; x=1688636902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l+7SZuW91IYDY1/Al5J0Dl+eXd+OCXM7N6/TelLxj04=;
 b=XMwV/RWnuciZ8c9tt0bVrwQSWwHT8Wn+rq9JryrCAR4PDkXp7hS6dRWTK8rwUdEg33
 vE3n5M+1vliQ+sC53pGwI5xd6dkVAst8StnyTAYI/zVi8XI4A4N0DwHsDFK5OJ5FGcoZ
 UOVeO7qSGPQfeIiBOJ6RKWZA/b4wlR5eMLFiilpKb+JbVOW6fZpCP/CzRU20IxxXRPcT
 tQT+I6IhKhVfkzNyC6xE7BH4xVfRiMMoCc4hzVxZBKYoXyITNLtzp7NFV0kY72jo8Gk+
 b/lPvZ5n1UzfhYACJIpo4qWtnMw00vlUg7Uv+hb4fpJVkUKErHW8pQlav1UU7aTN8xnL
 iTow==
X-Gm-Message-State: AC+VfDzgKZvrrawLFNBknqVcI4JAfTDRiXltr7ogyu7tEElFNDmPHFFX
 F69HWBXE5I3TWdO1Q9op+lJDJp4gDmQipdLmwMU=
X-Google-Smtp-Source: ACHHUZ4k/KB/KuSih7CZOfCM8DedMkh+7Ou8wPD5eMS4prFO9Jp9luH3aSXSZkDTWou5yXN9zseWpg==
X-Received: by 2002:a05:6000:d1:b0:30e:46c3:a179 with SMTP id
 q17-20020a05600000d100b0030e46c3a179mr1314789wrx.30.1686044902661; 
 Tue, 06 Jun 2023 02:48:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v10-20020a5d4b0a000000b0030789698eebsm12134017wrq.89.2023.06.06.02.48.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 02:48:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/42] hw/misc: Rename axp209 to axp22x and add support AXP221
 PMU
Date: Tue,  6 Jun 2023 10:47:45 +0100
Message-Id: <20230606094814.3581397-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230606094814.3581397-1-peter.maydell@linaro.org>
References: <20230606094814.3581397-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

From: qianfan Zhao <qianfanguijin@163.com>

This patch adds minimal support for AXP-221 PMU and connect it to
bananapi M2U board.

Signed-off-by: qianfan Zhao <qianfanguijin@163.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/bananapi_m2u.c |   6 +
 hw/misc/axp209.c      | 238 -----------------------------------
 hw/misc/axp2xx.c      | 283 ++++++++++++++++++++++++++++++++++++++++++
 hw/arm/Kconfig        |   3 +-
 hw/misc/Kconfig       |   2 +-
 hw/misc/meson.build   |   2 +-
 hw/misc/trace-events  |   8 +-
 7 files changed, 297 insertions(+), 245 deletions(-)
 delete mode 100644 hw/misc/axp209.c
 create mode 100644 hw/misc/axp2xx.c

diff --git a/hw/arm/bananapi_m2u.c b/hw/arm/bananapi_m2u.c
index 1d49a006b53..9c5360a41bd 100644
--- a/hw/arm/bananapi_m2u.c
+++ b/hw/arm/bananapi_m2u.c
@@ -23,6 +23,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "hw/boards.h"
+#include "hw/i2c/i2c.h"
 #include "hw/qdev-properties.h"
 #include "hw/arm/allwinner-r40.h"
 
@@ -61,6 +62,7 @@ static void bpim2u_init(MachineState *machine)
 {
     bool bootroom_loaded = false;
     AwR40State *r40;
+    I2CBus *i2c;
 
     /* BIOS is not supported by this board */
     if (machine->firmware) {
@@ -104,6 +106,10 @@ static void bpim2u_init(MachineState *machine)
         }
     }
 
+    /* Connect AXP221 */
+    i2c = I2C_BUS(qdev_get_child_bus(DEVICE(&r40->i2c0), "i2c"));
+    i2c_slave_create_simple(i2c, "axp221_pmu", 0x34);
+
     /* SDRAM */
     memory_region_add_subregion(get_system_memory(),
                                 r40->memmap[AW_R40_DEV_SDRAM], machine->ram);
diff --git a/hw/misc/axp209.c b/hw/misc/axp209.c
deleted file mode 100644
index 2908ed99a6f..00000000000
--- a/hw/misc/axp209.c
+++ /dev/null
@@ -1,238 +0,0 @@
-/*
- * AXP-209 PMU Emulation
- *
- * Copyright (C) 2022 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
- * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
- * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
- * DEALINGS IN THE SOFTWARE.
- *
- * SPDX-License-Identifier: MIT
- */
-
-#include "qemu/osdep.h"
-#include "qemu/log.h"
-#include "trace.h"
-#include "hw/i2c/i2c.h"
-#include "migration/vmstate.h"
-
-#define TYPE_AXP209_PMU "axp209_pmu"
-
-#define AXP209(obj) \
-    OBJECT_CHECK(AXP209I2CState, (obj), TYPE_AXP209_PMU)
-
-/* registers */
-enum {
-    REG_POWER_STATUS = 0x0u,
-    REG_OPERATING_MODE,
-    REG_OTG_VBUS_STATUS,
-    REG_CHIP_VERSION,
-    REG_DATA_CACHE_0,
-    REG_DATA_CACHE_1,
-    REG_DATA_CACHE_2,
-    REG_DATA_CACHE_3,
-    REG_DATA_CACHE_4,
-    REG_DATA_CACHE_5,
-    REG_DATA_CACHE_6,
-    REG_DATA_CACHE_7,
-    REG_DATA_CACHE_8,
-    REG_DATA_CACHE_9,
-    REG_DATA_CACHE_A,
-    REG_DATA_CACHE_B,
-    REG_POWER_OUTPUT_CTRL = 0x12u,
-    REG_DC_DC2_OUT_V_CTRL = 0x23u,
-    REG_DC_DC2_DVS_CTRL = 0x25u,
-    REG_DC_DC3_OUT_V_CTRL = 0x27u,
-    REG_LDO2_4_OUT_V_CTRL,
-    REG_LDO3_OUT_V_CTRL,
-    REG_VBUS_CH_MGMT = 0x30u,
-    REG_SHUTDOWN_V_CTRL,
-    REG_SHUTDOWN_CTRL,
-    REG_CHARGE_CTRL_1,
-    REG_CHARGE_CTRL_2,
-    REG_SPARE_CHARGE_CTRL,
-    REG_PEK_KEY_CTRL,
-    REG_DC_DC_FREQ_SET,
-    REG_CHR_TEMP_TH_SET,
-    REG_CHR_HIGH_TEMP_TH_CTRL,
-    REG_IPSOUT_WARN_L1,
-    REG_IPSOUT_WARN_L2,
-    REG_DISCHR_TEMP_TH_SET,
-    REG_DISCHR_HIGH_TEMP_TH_CTRL,
-    REG_IRQ_BANK_1_CTRL = 0x40u,
-    REG_IRQ_BANK_2_CTRL,
-    REG_IRQ_BANK_3_CTRL,
-    REG_IRQ_BANK_4_CTRL,
-    REG_IRQ_BANK_5_CTRL,
-    REG_IRQ_BANK_1_STAT = 0x48u,
-    REG_IRQ_BANK_2_STAT,
-    REG_IRQ_BANK_3_STAT,
-    REG_IRQ_BANK_4_STAT,
-    REG_IRQ_BANK_5_STAT,
-    REG_ADC_ACIN_V_H = 0x56u,
-    REG_ADC_ACIN_V_L,
-    REG_ADC_ACIN_CURR_H,
-    REG_ADC_ACIN_CURR_L,
-    REG_ADC_VBUS_V_H,
-    REG_ADC_VBUS_V_L,
-    REG_ADC_VBUS_CURR_H,
-    REG_ADC_VBUS_CURR_L,
-    REG_ADC_INT_TEMP_H,
-    REG_ADC_INT_TEMP_L,
-    REG_ADC_TEMP_SENS_V_H = 0x62u,
-    REG_ADC_TEMP_SENS_V_L,
-    REG_ADC_BAT_V_H = 0x78u,
-    REG_ADC_BAT_V_L,
-    REG_ADC_BAT_DISCHR_CURR_H,
-    REG_ADC_BAT_DISCHR_CURR_L,
-    REG_ADC_BAT_CHR_CURR_H,
-    REG_ADC_BAT_CHR_CURR_L,
-    REG_ADC_IPSOUT_V_H,
-    REG_ADC_IPSOUT_V_L,
-    REG_DC_DC_MOD_SEL = 0x80u,
-    REG_ADC_EN_1,
-    REG_ADC_EN_2,
-    REG_ADC_SR_CTRL,
-    REG_ADC_IN_RANGE,
-    REG_GPIO1_ADC_IRQ_RISING_TH,
-    REG_GPIO1_ADC_IRQ_FALLING_TH,
-    REG_TIMER_CTRL = 0x8au,
-    REG_VBUS_CTRL_MON_SRP,
-    REG_OVER_TEMP_SHUTDOWN = 0x8fu,
-    REG_GPIO0_FEAT_SET,
-    REG_GPIO_OUT_HIGH_SET,
-    REG_GPIO1_FEAT_SET,
-    REG_GPIO2_FEAT_SET,
-    REG_GPIO_SIG_STATE_SET_MON,
-    REG_GPIO3_SET,
-    REG_COULOMB_CNTR_CTRL = 0xb8u,
-    REG_POWER_MEAS_RES,
-    NR_REGS
-};
-
-#define AXP209_CHIP_VERSION_ID             (0x01)
-#define AXP209_DC_DC2_OUT_V_CTRL_RESET     (0x16)
-#define AXP209_IRQ_BANK_1_CTRL_RESET       (0xd8)
-
-/* A simple I2C slave which returns values of ID or CNT register. */
-typedef struct AXP209I2CState {
-    /*< private >*/
-    I2CSlave i2c;
-    /*< public >*/
-    uint8_t regs[NR_REGS];  /* peripheral registers */
-    uint8_t ptr;            /* current register index */
-    uint8_t count;          /* counter used for tx/rx */
-} AXP209I2CState;
-
-/* Reset all counters and load ID register */
-static void axp209_reset_enter(Object *obj, ResetType type)
-{
-    AXP209I2CState *s = AXP209(obj);
-
-    memset(s->regs, 0, NR_REGS);
-    s->ptr = 0;
-    s->count = 0;
-    s->regs[REG_CHIP_VERSION] = AXP209_CHIP_VERSION_ID;
-    s->regs[REG_DC_DC2_OUT_V_CTRL] = AXP209_DC_DC2_OUT_V_CTRL_RESET;
-    s->regs[REG_IRQ_BANK_1_CTRL] = AXP209_IRQ_BANK_1_CTRL_RESET;
-}
-
-/* Handle events from master. */
-static int axp209_event(I2CSlave *i2c, enum i2c_event event)
-{
-    AXP209I2CState *s = AXP209(i2c);
-
-    s->count = 0;
-
-    return 0;
-}
-
-/* Called when master requests read */
-static uint8_t axp209_rx(I2CSlave *i2c)
-{
-    AXP209I2CState *s = AXP209(i2c);
-    uint8_t ret = 0xff;
-
-    if (s->ptr < NR_REGS) {
-        ret = s->regs[s->ptr++];
-    }
-
-    trace_axp209_rx(s->ptr - 1, ret);
-
-    return ret;
-}
-
-/*
- * Called when master sends write.
- * Update ptr with byte 0, then perform write with second byte.
- */
-static int axp209_tx(I2CSlave *i2c, uint8_t data)
-{
-    AXP209I2CState *s = AXP209(i2c);
-
-    if (s->count == 0) {
-        /* Store register address */
-        s->ptr = data;
-        s->count++;
-        trace_axp209_select(data);
-    } else {
-        trace_axp209_tx(s->ptr, data);
-        if (s->ptr == REG_DC_DC2_OUT_V_CTRL) {
-            s->regs[s->ptr++] = data;
-        }
-    }
-
-    return 0;
-}
-
-static const VMStateDescription vmstate_axp209 = {
-    .name = TYPE_AXP209_PMU,
-    .version_id = 1,
-    .fields = (VMStateField[]) {
-        VMSTATE_UINT8_ARRAY(regs, AXP209I2CState, NR_REGS),
-        VMSTATE_UINT8(count, AXP209I2CState),
-        VMSTATE_UINT8(ptr, AXP209I2CState),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
-static void axp209_class_init(ObjectClass *oc, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(oc);
-    I2CSlaveClass *isc = I2C_SLAVE_CLASS(oc);
-    ResettableClass *rc = RESETTABLE_CLASS(oc);
-
-    rc->phases.enter = axp209_reset_enter;
-    dc->vmsd = &vmstate_axp209;
-    isc->event = axp209_event;
-    isc->recv = axp209_rx;
-    isc->send = axp209_tx;
-}
-
-static const TypeInfo axp209_info = {
-    .name = TYPE_AXP209_PMU,
-    .parent = TYPE_I2C_SLAVE,
-    .instance_size = sizeof(AXP209I2CState),
-    .class_init = axp209_class_init
-};
-
-static void axp209_register_devices(void)
-{
-    type_register_static(&axp209_info);
-}
-
-type_init(axp209_register_devices);
diff --git a/hw/misc/axp2xx.c b/hw/misc/axp2xx.c
new file mode 100644
index 00000000000..41538c1cd78
--- /dev/null
+++ b/hw/misc/axp2xx.c
@@ -0,0 +1,283 @@
+/*
+ * AXP-2XX PMU Emulation, supported lists:
+ *   AXP209
+ *   AXP221
+ *
+ * Copyright (C) 2022 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
+ * Copyright (C) 2023 qianfan Zhao <qianfanguijin@163.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+ * DEALINGS IN THE SOFTWARE.
+ *
+ * SPDX-License-Identifier: MIT
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qom/object.h"
+#include "trace.h"
+#include "hw/i2c/i2c.h"
+#include "migration/vmstate.h"
+
+#define TYPE_AXP2XX     "axp2xx_pmu"
+#define TYPE_AXP209_PMU "axp209_pmu"
+#define TYPE_AXP221_PMU "axp221_pmu"
+
+OBJECT_DECLARE_TYPE(AXP2xxI2CState, AXP2xxClass, AXP2XX)
+
+#define NR_REGS                            (0xff)
+
+/* A simple I2C slave which returns values of ID or CNT register. */
+typedef struct AXP2xxI2CState {
+    /*< private >*/
+    I2CSlave i2c;
+    /*< public >*/
+    uint8_t regs[NR_REGS];  /* peripheral registers */
+    uint8_t ptr;            /* current register index */
+    uint8_t count;          /* counter used for tx/rx */
+} AXP2xxI2CState;
+
+typedef struct AXP2xxClass {
+    /*< private >*/
+    I2CSlaveClass parent_class;
+    /*< public >*/
+    void (*reset_enter)(AXP2xxI2CState *s, ResetType type);
+} AXP2xxClass;
+
+#define AXP209_CHIP_VERSION_ID             (0x01)
+#define AXP209_DC_DC2_OUT_V_CTRL_RESET     (0x16)
+
+/* Reset all counters and load ID register */
+static void axp209_reset_enter(AXP2xxI2CState *s, ResetType type)
+{
+    memset(s->regs, 0, NR_REGS);
+    s->ptr = 0;
+    s->count = 0;
+
+    s->regs[0x03] = AXP209_CHIP_VERSION_ID;
+    s->regs[0x23] = AXP209_DC_DC2_OUT_V_CTRL_RESET;
+
+    s->regs[0x30] = 0x60;
+    s->regs[0x32] = 0x46;
+    s->regs[0x34] = 0x41;
+    s->regs[0x35] = 0x22;
+    s->regs[0x36] = 0x5d;
+    s->regs[0x37] = 0x08;
+    s->regs[0x38] = 0xa5;
+    s->regs[0x39] = 0x1f;
+    s->regs[0x3a] = 0x68;
+    s->regs[0x3b] = 0x5f;
+    s->regs[0x3c] = 0xfc;
+    s->regs[0x3d] = 0x16;
+    s->regs[0x40] = 0xd8;
+    s->regs[0x42] = 0xff;
+    s->regs[0x43] = 0x3b;
+    s->regs[0x80] = 0xe0;
+    s->regs[0x82] = 0x83;
+    s->regs[0x83] = 0x80;
+    s->regs[0x84] = 0x32;
+    s->regs[0x86] = 0xff;
+    s->regs[0x90] = 0x07;
+    s->regs[0x91] = 0xa0;
+    s->regs[0x92] = 0x07;
+    s->regs[0x93] = 0x07;
+}
+
+#define AXP221_PWR_STATUS_ACIN_PRESENT          BIT(7)
+#define AXP221_PWR_STATUS_ACIN_AVAIL            BIT(6)
+#define AXP221_PWR_STATUS_VBUS_PRESENT          BIT(5)
+#define AXP221_PWR_STATUS_VBUS_USED             BIT(4)
+#define AXP221_PWR_STATUS_BAT_CHARGING          BIT(2)
+#define AXP221_PWR_STATUS_ACIN_VBUS_POWERED     BIT(1)
+
+/* Reset all counters and load ID register */
+static void axp221_reset_enter(AXP2xxI2CState *s, ResetType type)
+{
+    memset(s->regs, 0, NR_REGS);
+    s->ptr = 0;
+    s->count = 0;
+
+    /* input power status register */
+    s->regs[0x00] = AXP221_PWR_STATUS_ACIN_PRESENT
+                    | AXP221_PWR_STATUS_ACIN_AVAIL
+                    | AXP221_PWR_STATUS_ACIN_VBUS_POWERED;
+
+    s->regs[0x01] = 0x00; /* no battery is connected */
+
+    /*
+     * CHIPID register, no documented on datasheet, but it is checked in
+     * u-boot spl. I had read it from AXP221s and got 0x06 value.
+     * So leave 06h here.
+     */
+    s->regs[0x03] = 0x06;
+
+    s->regs[0x10] = 0xbf;
+    s->regs[0x13] = 0x01;
+    s->regs[0x30] = 0x60;
+    s->regs[0x31] = 0x03;
+    s->regs[0x32] = 0x43;
+    s->regs[0x33] = 0xc6;
+    s->regs[0x34] = 0x45;
+    s->regs[0x35] = 0x0e;
+    s->regs[0x36] = 0x5d;
+    s->regs[0x37] = 0x08;
+    s->regs[0x38] = 0xa5;
+    s->regs[0x39] = 0x1f;
+    s->regs[0x3c] = 0xfc;
+    s->regs[0x3d] = 0x16;
+    s->regs[0x80] = 0x80;
+    s->regs[0x82] = 0xe0;
+    s->regs[0x84] = 0x32;
+    s->regs[0x8f] = 0x01;
+
+    s->regs[0x90] = 0x07;
+    s->regs[0x91] = 0x1f;
+    s->regs[0x92] = 0x07;
+    s->regs[0x93] = 0x1f;
+
+    s->regs[0x40] = 0xd8;
+    s->regs[0x41] = 0xff;
+    s->regs[0x42] = 0x03;
+    s->regs[0x43] = 0x03;
+
+    s->regs[0xb8] = 0xc0;
+    s->regs[0xb9] = 0x64;
+    s->regs[0xe6] = 0xa0;
+}
+
+static void axp2xx_reset_enter(Object *obj, ResetType type)
+{
+    AXP2xxI2CState *s = AXP2XX(obj);
+    AXP2xxClass *sc = AXP2XX_GET_CLASS(s);
+
+    sc->reset_enter(s, type);
+}
+
+/* Handle events from master. */
+static int axp2xx_event(I2CSlave *i2c, enum i2c_event event)
+{
+    AXP2xxI2CState *s = AXP2XX(i2c);
+
+    s->count = 0;
+
+    return 0;
+}
+
+/* Called when master requests read */
+static uint8_t axp2xx_rx(I2CSlave *i2c)
+{
+    AXP2xxI2CState *s = AXP2XX(i2c);
+    uint8_t ret = 0xff;
+
+    if (s->ptr < NR_REGS) {
+        ret = s->regs[s->ptr++];
+    }
+
+    trace_axp2xx_rx(s->ptr - 1, ret);
+
+    return ret;
+}
+
+/*
+ * Called when master sends write.
+ * Update ptr with byte 0, then perform write with second byte.
+ */
+static int axp2xx_tx(I2CSlave *i2c, uint8_t data)
+{
+    AXP2xxI2CState *s = AXP2XX(i2c);
+
+    if (s->count == 0) {
+        /* Store register address */
+        s->ptr = data;
+        s->count++;
+        trace_axp2xx_select(data);
+    } else {
+        trace_axp2xx_tx(s->ptr, data);
+        s->regs[s->ptr++] = data;
+    }
+
+    return 0;
+}
+
+static const VMStateDescription vmstate_axp2xx = {
+    .name = TYPE_AXP2XX,
+    .version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT8_ARRAY(regs, AXP2xxI2CState, NR_REGS),
+        VMSTATE_UINT8(ptr, AXP2xxI2CState),
+        VMSTATE_UINT8(count, AXP2xxI2CState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void axp2xx_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    I2CSlaveClass *isc = I2C_SLAVE_CLASS(oc);
+    ResettableClass *rc = RESETTABLE_CLASS(oc);
+
+    rc->phases.enter = axp2xx_reset_enter;
+    dc->vmsd = &vmstate_axp2xx;
+    isc->event = axp2xx_event;
+    isc->recv = axp2xx_rx;
+    isc->send = axp2xx_tx;
+}
+
+static const TypeInfo axp2xx_info = {
+    .name = TYPE_AXP2XX,
+    .parent = TYPE_I2C_SLAVE,
+    .instance_size = sizeof(AXP2xxI2CState),
+    .class_size = sizeof(AXP2xxClass),
+    .class_init = axp2xx_class_init,
+    .abstract = true,
+};
+
+static void axp209_class_init(ObjectClass *oc, void *data)
+{
+    AXP2xxClass *sc = AXP2XX_CLASS(oc);
+
+    sc->reset_enter = axp209_reset_enter;
+}
+
+static const TypeInfo axp209_info = {
+    .name = TYPE_AXP209_PMU,
+    .parent = TYPE_AXP2XX,
+    .class_init = axp209_class_init
+};
+
+static void axp221_class_init(ObjectClass *oc, void *data)
+{
+    AXP2xxClass *sc = AXP2XX_CLASS(oc);
+
+    sc->reset_enter = axp221_reset_enter;
+}
+
+static const TypeInfo axp221_info = {
+    .name = TYPE_AXP221_PMU,
+    .parent = TYPE_AXP2XX,
+    .class_init = axp221_class_init,
+};
+
+static void axp2xx_register_devices(void)
+{
+    type_register_static(&axp2xx_info);
+    type_register_static(&axp209_info);
+    type_register_static(&axp221_info);
+}
+
+type_init(axp2xx_register_devices);
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 02b2d8167dc..007a81e6ede 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -383,7 +383,7 @@ config ALLWINNER_A10
     select ALLWINNER_WDT
     select ALLWINNER_EMAC
     select ALLWINNER_I2C
-    select AXP209_PMU
+    select AXP2XX_PMU
     select SERIAL
     select UNIMP
 
@@ -407,6 +407,7 @@ config ALLWINNER_R40
     bool
     default y if TCG && ARM
     select ALLWINNER_A10_PIT
+    select AXP2XX_PMU
     select SERIAL
     select ARM_TIMER
     select ARM_GIC
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 2ef5781ef87..efeb430a6ce 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -176,7 +176,7 @@ config ALLWINNER_A10_CCM
 config ALLWINNER_A10_DRAMC
     bool
 
-config AXP209_PMU
+config AXP2XX_PMU
     bool
     depends on I2C
 
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 96e35f1cdbc..1db03433336 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -45,7 +45,7 @@ softmmu_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-h3-dramc.c
 softmmu_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-h3-sysctrl.c'))
 softmmu_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-sid.c'))
 softmmu_ss.add(when: 'CONFIG_ALLWINNER_R40', if_true: files('allwinner-r40-ccu.c'))
-softmmu_ss.add(when: 'CONFIG_AXP209_PMU', if_true: files('axp209.c'))
+softmmu_ss.add(when: 'CONFIG_AXP2XX_PMU', if_true: files('axp2xx.c'))
 softmmu_ss.add(when: 'CONFIG_REALVIEW', if_true: files('arm_sysctl.c'))
 softmmu_ss.add(when: 'CONFIG_NSERIES', if_true: files('cbus.c'))
 softmmu_ss.add(when: 'CONFIG_ECCMEMCTL', if_true: files('eccmemctl.c'))
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index c47876a9026..24cdec83fe7 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -23,10 +23,10 @@ allwinner_sid_write(uint64_t offset, uint64_t data, unsigned size) "offset 0x%"
 avr_power_read(uint8_t value) "power_reduc read value:%u"
 avr_power_write(uint8_t value) "power_reduc write value:%u"
 
-# axp209.c
-axp209_rx(uint8_t reg, uint8_t data) "Read reg 0x%" PRIx8 " : 0x%" PRIx8
-axp209_select(uint8_t reg) "Accessing reg 0x%" PRIx8
-axp209_tx(uint8_t reg, uint8_t data) "Write reg 0x%" PRIx8 " : 0x%" PRIx8
+# axp2xx
+axp2xx_rx(uint8_t reg, uint8_t data) "Read reg 0x%" PRIx8 " : 0x%" PRIx8
+axp2xx_select(uint8_t reg) "Accessing reg 0x%" PRIx8
+axp2xx_tx(uint8_t reg, uint8_t data) "Write reg 0x%" PRIx8 " : 0x%" PRIx8
 
 # eccmemctl.c
 ecc_mem_writel_mer(uint32_t val) "Write memory enable 0x%08x"
-- 
2.34.1


