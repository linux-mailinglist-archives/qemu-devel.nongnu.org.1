Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0936960229
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Aug 2024 08:47:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sipxZ-0002hV-UV; Tue, 27 Aug 2024 02:45:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3E3bNZgUKCnIjQlYfWeeWbU.SecgUck-TUlUbdedWdk.ehW@flex--tavip.bounces.google.com>)
 id 1sipxY-0002es-Ku
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 02:45:44 -0400
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3E3bNZgUKCnIjQlYfWeeWbU.SecgUck-TUlUbdedWdk.ehW@flex--tavip.bounces.google.com>)
 id 1sipxV-00064x-Iq
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 02:45:44 -0400
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-6886cd07673so114563837b3.3
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 23:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1724741140; x=1725345940; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=f3be9fBssvmagjg2RCsw3DZxQzWbxusymZT25yOHQNQ=;
 b=1ASKGrCUqh6vrGzgV948J+/pmg6ZHpRFq8gC1IVhj5mqxyttEUyLPcFXsP4yoJwGDY
 aTbhuwcnCU4lqVzmY9/dSWqJmXRUwkmhV0R3e7u1rE7a7jtR2f1v/hBe6tRO35hI5i6F
 n8Ydc1qBdjoSjyNoorLqNGZ3lx6iN3NIFY0ghGsAttuvwQ+wbQAkxKNBKJFfmqwbfT/T
 L5otC8+w9ApUxmkrEwY5NsRBqLxsuWJb3wpEIhFh5GngEy3s+gLYigqjkpakdRKfz+jT
 wKll2xhsFEjGR0Vwtr8agWQqjHCNNVGPtXwMARZY9yJ/6Rb4r5VGdks5rcUVJAJPMKpx
 kQBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724741140; x=1725345940;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f3be9fBssvmagjg2RCsw3DZxQzWbxusymZT25yOHQNQ=;
 b=GMkOQC0WqcyN93sZlWbI4fjwA7YYylY3DCdmrhUbKJ3bEut9h+O3Kpp/T2VpV9e1zv
 jFMPCtongItgPxGUUwWFT9lmGAa2RCgu8IK8HsU/CUv+0tOggrioRpUuzfS/2awn31df
 xujFOJd0iTOA6E6n4rqbYqfcZDQ89wKscKVWQ2xzPnbG0Ait/FzTs3UTM6v1ulrvjMbK
 gXytY/jEqsx7RDtySDErm0q61JhPsLMq8k6zfLOBBfCGuszMGeKJJErXKU90nu60gdOk
 rZFro1WeF6h+PLN9plXjDpGwwqqNZLtNhwqRcmScCGHYplkksOEEjao2iOcf11C8z6/i
 TWHg==
X-Gm-Message-State: AOJu0YxvgMz/c1m7Yxt/l2OCsqldS2QnQRq3AXMPA2bx5XHOX0IGavw2
 K1N+sfrU2H+vBE076F+CMbaSa2t0tgLEujOa2fzz8WWFZ4r7sElKtFGHqKbRnEqbFOo+e7jGt3I
 JmnuEg4MgVx1trLCCDiH4udeE81YY05N0DmqI8ZTE4sm2d7DGPL6DwhaPqKJHaBisgyF6jE+NTi
 mOxytIpavPpdRtTlFowNjU4xZHJw==
X-Google-Smtp-Source: AGHT+IG/9R2pvORJ4vPAnamez4Snj/Ri8xy5jXYb9GkqIST1XNOnUbg2oDdcjVRIhMRZB3wd8JWgC87Jxg==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a05:690c:460d:b0:6ad:9825:6a2f
 with SMTP id
 00721157ae682-6c624131e77mr372357b3.1.1724741139804; Mon, 26 Aug 2024
 23:45:39 -0700 (PDT)
Date: Mon, 26 Aug 2024 23:45:09 -0700
In-Reply-To: <20240827064529.1246786-1-tavip@google.com>
Mime-Version: 1.0
References: <20240827064529.1246786-1-tavip@google.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240827064529.1246786-6-tavip@google.com>
Subject: [RFC PATCH v3 05/24] hw/misc: add basic flexcomm device model
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 peter.maydell@linaro.org, marcandre.lureau@redhat.com, berrange@redhat.com, 
 eduardo@habkost.net, luc@lmichel.fr, damien.hedde@dahe.fr, 
 alistair@alistair23.me, thuth@redhat.com, philmd@linaro.org, jsnow@redhat.com, 
 crosa@redhat.com, lvivier@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1149;
 envelope-from=3E3bNZgUKCnIjQlYfWeeWbU.SecgUck-TUlUbdedWdk.ehW@flex--tavip.bounces.google.com;
 helo=mail-yw1-x1149.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

Add support for NXP's FLEXCOMM device model. It uses the NXP RT595 SVD
file to generate the register structure.

FLEXCOMM is a generic serial communication module which support
multiple functions: UART, SPI and I2C. These are configurable at runtime.

This patch adds the infrastructure to support adding the above
mentioned hardware functions in a modular fashion in subsequent
patches as well as switching between functions.

The patch includes an automatically generated header which contains
the register layout and helpers.

The header can be regenerated with the svd-flexcomm target when the
build is configured with --enable-mcux-soc-svd.

Signed-off-by: Octavian Purdila <tavip@google.com>
---
 include/hw/arm/svd/flexcomm.h | 114 +++++++++++++
 include/hw/misc/flexcomm.h    |  70 ++++++++
 hw/misc/flexcomm.c            | 302 ++++++++++++++++++++++++++++++++++
 hw/arm/meson.build            |   2 +
 hw/arm/svd/meson.build        |   3 +
 hw/misc/Kconfig               |   5 +
 hw/misc/meson.build           |   2 +
 hw/misc/trace-events          |   6 +
 8 files changed, 504 insertions(+)
 create mode 100644 include/hw/arm/svd/flexcomm.h
 create mode 100644 include/hw/misc/flexcomm.h
 create mode 100644 hw/misc/flexcomm.c

diff --git a/include/hw/arm/svd/flexcomm.h b/include/hw/arm/svd/flexcomm.h
new file mode 100644
index 0000000000..31587b5829
--- /dev/null
+++ b/include/hw/arm/svd/flexcomm.h
@@ -0,0 +1,114 @@
+/*
+ * Copyright 2016-2023 NXP SPDX-License-Identifier: BSD-3-Clause
+ *
+ * Automatically generated by svd-gen-header.py from MIMXRT595S_cm33.xml
+ */
+#pragma once
+
+#include "hw/register.h"
+
+#include "hw/registerfields.h"
+
+/* Flexcomm */
+#define FLEXCOMM_REGS_NO (1024)
+
+/* Peripheral Select and Flexcomm module ID */
+REG32(FLEXCOMM_PSELID, 4088);
+/* Peripheral Select */
+FIELD(FLEXCOMM_PSELID, PERSEL, 0, 3);
+/* Lock the peripheral select */
+FIELD(FLEXCOMM_PSELID, LOCK, 3, 1);
+/* USART present indicator */
+FIELD(FLEXCOMM_PSELID, USARTPRESENT, 4, 1);
+/* SPI present indicator */
+FIELD(FLEXCOMM_PSELID, SPIPRESENT, 5, 1);
+/* I2C present indicator */
+FIELD(FLEXCOMM_PSELID, I2CPRESENT, 6, 1);
+/* I2S Present */
+FIELD(FLEXCOMM_PSELID, I2SPRESENT, 7, 1);
+/* Flexcomm ID */
+FIELD(FLEXCOMM_PSELID, ID, 12, 20);
+
+/* Peripheral Identification */
+REG32(FLEXCOMM_PID, 4092);
+/* Minor revision of module implementation */
+FIELD(FLEXCOMM_PID, Minor_Rev, 8, 4);
+/* Major revision of module implementation */
+FIELD(FLEXCOMM_PID, Major_Rev, 12, 4);
+/* Module identifier for the selected function */
+FIELD(FLEXCOMM_PID, ID, 16, 16);
+
+
+typedef enum {
+    /* No peripheral selected. */
+    FLEXCOMM_PSELID_PERSEL_NO_PERIPH_SELECTED = 0,
+    /* USART function selected */
+    FLEXCOMM_PSELID_PERSEL_USART = 1,
+    /* SPI function selected */
+    FLEXCOMM_PSELID_PERSEL_SPI = 2,
+    /* I2C */
+    FLEXCOMM_PSELID_PERSEL_I2C = 3,
+    /* I2S Transmit */
+    FLEXCOMM_PSELID_PERSEL_I2S_TRANSMIT = 4,
+    /* I2S Receive */
+    FLEXCOMM_PSELID_PERSEL_I2S_RECEIVE = 5,
+} FLEXCOMM_PSELID_PERSEL_Enum;
+
+typedef enum {
+    /* Peripheral select can be changed by software. */
+    FLEXCOMM_PSELID_LOCK_UNLOCKED = 0,
+    /*
+     * Peripheral select is locked and cannot be changed until this Flexcomm
+     * module or the entire device is reset.
+     */
+    FLEXCOMM_PSELID_LOCK_LOCKED = 1,
+} FLEXCOMM_PSELID_LOCK_Enum;
+
+typedef enum {
+    /* This Flexcomm module does not include the USART function. */
+    FLEXCOMM_PSELID_USARTPRESENT_NOT_PRESENT = 0,
+    /* This Flexcomm module includes the USART function. */
+    FLEXCOMM_PSELID_USARTPRESENT_PRESENT = 1,
+} FLEXCOMM_PSELID_USARTPRESENT_Enum;
+
+typedef enum {
+    /* This Flexcomm module does not include the SPI function. */
+    FLEXCOMM_PSELID_SPIPRESENT_NOT_PRESENT = 0,
+    /* This Flexcomm module includes the SPI function. */
+    FLEXCOMM_PSELID_SPIPRESENT_PRESENT = 1,
+} FLEXCOMM_PSELID_SPIPRESENT_Enum;
+
+typedef enum {
+    /* I2C Not Present */
+    FLEXCOMM_PSELID_I2CPRESENT_NOT_PRESENT = 0,
+    /* I2C Present */
+    FLEXCOMM_PSELID_I2CPRESENT_PRESENT = 1,
+} FLEXCOMM_PSELID_I2CPRESENT_Enum;
+
+typedef enum {
+    /* I2S Not Present */
+    FLEXCOMM_PSELID_I2SPRESENT_NOT_PRESENT = 0,
+    /* I2S Present */
+    FLEXCOMM_PSELID_I2SPRESENT_PRESENT = 1,
+} FLEXCOMM_PSELID_I2SPRESENT_Enum;
+
+
+#define FLEXCOMM_REGISTER_ACCESS_INFO_ARRAY(_name) \
+    struct RegisterAccessInfo _name[FLEXCOMM_REGS_NO] = { \
+        [0 ... FLEXCOMM_REGS_NO - 1] = { \
+            .name = "", \
+            .addr = -1, \
+        }, \
+        [R_FLEXCOMM_PSELID] = { \
+            .name = "PSELID", \
+            .addr = 0xFF8, \
+            .ro = 0xFFFFFFF0, \
+            .reset = 0x101000, \
+        }, \
+        [R_FLEXCOMM_PID] = { \
+            .name = "PID", \
+            .addr = 0xFFC, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+    }
diff --git a/include/hw/misc/flexcomm.h b/include/hw/misc/flexcomm.h
new file mode 100644
index 0000000000..137e483412
--- /dev/null
+++ b/include/hw/misc/flexcomm.h
@@ -0,0 +1,70 @@
+/*
+ * QEMU model for NXP's FLEXCOMM
+ *
+ * Copyright (c) 2024 Google LLC
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_FLEXCOMM_H
+#define HW_FLEXCOMM_H
+
+#include "hw/sysbus.h"
+#include "hw/arm/svd/flexcomm.h"
+#include "qemu/fifo32.h"
+
+#define TYPE_FLEXCOMM "flexcomm"
+#define FLEXCOMM(obj) OBJECT_CHECK(FlexcommState, (obj), TYPE_FLEXCOMM)
+
+#define FLEXCOMM_FUNC_USART     0
+#define FLEXCOMM_FUNC_SPI       1
+#define FLEXCOMM_FUNC_I2C       2
+#define FLEXCOMM_FUNC_I2S       3
+#define FLEXCOMM_FUNCTIONS 4
+
+#define FLEXCOMM_FULL    0xF
+#define FLEXCOMM_HSSPI   (1 << FLEXCOMM_FUNC_SPI)
+#define FLEXCOMM_PMICI2C (1 << FLEXCOMM_FUNC_I2C)
+
+#define FLEXCOMM_PERSEL_USART  1
+#define FLEXCOMM_PERSEL_SPI    2
+#define FLEXCOMM_PERSEL_I2C    3
+#define FLEXCOMM_PERSEL_I2S_TX 4
+#define FLEXCOMM_PERSEL_I2S_RX 5
+
+typedef struct {
+    SysBusDevice parent_obj;
+
+    MemoryRegion mmio;
+    uint32_t regs[FLEXCOMM_REGS_NO];
+    uint32_t functions;
+    qemu_irq irq;
+    bool irq_state;
+} FlexcommState;
+
+typedef struct {
+    /* argument to pass to functions */
+    void *arg;
+
+    /* function / submodule has been  selected / deselected. */
+    void (*select)(void *o, FlexcommState *s, int f, bool selected);
+
+    /* read register */
+    MemTxResult (*reg_read)(void *o, FlexcommState *s, int f, hwaddr addr,
+                            uint64_t *data, unsigned size);
+
+    /* write register */
+    MemTxResult (*reg_write)(void *o, FlexcommState *s, int f, hwaddr addr,
+                             uint64_t data, unsigned size);
+} FlexcommFunctionOps;
+
+
+void flexcomm_irq(FlexcommState *s, bool irq);
+bool flexcomm_register_ops(int f, void *arg, const FlexcommFunctionOps *ops,
+                          Error **errp);
+void flexcomm_unregister_ops(int f);
+
+#endif /* HW_FLEXCOMM_H */
diff --git a/hw/misc/flexcomm.c b/hw/misc/flexcomm.c
new file mode 100644
index 0000000000..2bac4f008e
--- /dev/null
+++ b/hw/misc/flexcomm.c
@@ -0,0 +1,302 @@
+/*
+ * QEMU model for NXP's FLEXCOMM
+ *
+ * Copyright (c) 2024 Google LLC
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/mmap-alloc.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "hw/irq.h"
+#include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
+#include "migration/vmstate.h"
+#include "exec/address-spaces.h"
+#include "qapi/error.h"
+#include "trace.h"
+#include "hw/misc/flexcomm.h"
+
+#define REG(s, reg) (s->regs[R_FLEXCOMM_##reg])
+#define RF_WR(s, reg, field, val) \
+    ARRAY_FIELD_DP32(s->regs, FLEXCOMM_##reg, field, val)
+#define RF_RD(s, reg, field) \
+    ARRAY_FIELD_EX32(s->regs, FLEXCOMM_##reg, field)
+
+#define modname "FLEXCOMM"
+
+static const FlexcommFunctionOps *flexcomm_fops[FLEXCOMM_FUNCTIONS];
+static void *flexcomm_farg[FLEXCOMM_FUNCTIONS];
+
+static const FLEXCOMM_REGISTER_ACCESS_INFO_ARRAY(reg_info);
+
+static inline bool has_function(FlexcommState *s, int function)
+{
+    return s->functions & (1 << function);
+}
+
+static inline int persel_to_function(FlexcommState *s)
+{
+    switch (RF_RD(s, PSELID, PERSEL)) {
+    case FLEXCOMM_PERSEL_USART:
+        return FLEXCOMM_FUNC_USART;
+    case FLEXCOMM_PERSEL_SPI:
+        return FLEXCOMM_FUNC_SPI;
+    case FLEXCOMM_PERSEL_I2C:
+        return FLEXCOMM_FUNC_I2C;
+    case FLEXCOMM_PERSEL_I2S_TX:
+    case FLEXCOMM_PERSEL_I2S_RX:
+        return FLEXCOMM_FUNC_I2S;
+    default:
+        return -1;
+    }
+}
+
+static void flexcomm_func_select(FlexcommState *s, bool selected)
+{
+    int f = persel_to_function(s);
+
+    if (f < 0 || !flexcomm_fops[f] || !flexcomm_fops[f]->select) {
+        return;
+    }
+
+    flexcomm_fops[f]->select(flexcomm_farg[f], s, f, selected);
+}
+
+static MemTxResult flexcomm_func_reg_read(FlexcommState *s, hwaddr addr,
+                                         uint64_t *data, unsigned size)
+{
+    int f = persel_to_function(s);
+
+    if (f < 0 || !flexcomm_fops[f] || !flexcomm_fops[f]->reg_read) {
+        return MEMTX_ERROR;
+    }
+
+    return flexcomm_fops[f]->reg_read(flexcomm_farg[f], s, f, addr, data, size);
+}
+
+static MemTxResult flexcomm_func_reg_write(FlexcommState *s, hwaddr addr,
+                                          uint64_t data, unsigned size)
+{
+    int f = persel_to_function(s);
+
+    if (f < 0 || !flexcomm_fops[f] || !flexcomm_fops[f]->reg_write) {
+        return MEMTX_ERROR;
+    }
+
+    return flexcomm_fops[f]->reg_write(flexcomm_farg[f], s, f, addr, data,
+                                       size);
+}
+
+static void flexcomm_reset(DeviceState *dev)
+{
+    FlexcommState *s = FLEXCOMM(dev);
+
+    trace_flexcomm_reset();
+
+    flexcomm_func_select(s, false);
+
+    for (int i = 0; i < FLEXCOMM_REGS_NO; i++) {
+        hwaddr addr = reg_info[i].addr;
+
+        if (addr != -1) {
+            struct RegisterInfo ri = {
+                .data = &s->regs[addr / 4],
+                .data_size = 4,
+                .access = &reg_info[i],
+            };
+
+            register_reset(&ri);
+        }
+    }
+
+    RF_WR(s, PSELID, USARTPRESENT, has_function(s, FLEXCOMM_FUNC_USART));
+    RF_WR(s, PSELID, SPIPRESENT, has_function(s, FLEXCOMM_FUNC_SPI));
+    RF_WR(s, PSELID, I2CPRESENT, has_function(s, FLEXCOMM_FUNC_I2C));
+    RF_WR(s, PSELID, I2SPRESENT, has_function(s, FLEXCOMM_FUNC_I2S));
+
+    s->irq_state = false;
+    qemu_set_irq(s->irq, s->irq_state);
+}
+
+static MemTxResult flexcomm_reg_read(void *opaque, hwaddr addr,
+                                    uint64_t *data, unsigned size,
+                                    MemTxAttrs attrs)
+{
+    FlexcommState *s = opaque;
+    MemTxResult ret = MEMTX_OK;
+    const struct RegisterAccessInfo *rai = &reg_info[addr / 4];
+
+    switch (addr) {
+    case A_FLEXCOMM_PSELID:
+    case A_FLEXCOMM_PID:
+    {
+        if (size != 4) {
+            ret = MEMTX_ERROR;
+        } else {
+            *data = s->regs[addr / 4];
+        }
+        break;
+    }
+    default:
+        return flexcomm_func_reg_read(s, addr, data, size);
+    }
+
+    trace_flexcomm_reg_read(DEVICE(s)->id, rai->name, addr, *data);
+    return ret;
+}
+
+static int flexcomm_check_function(FlexcommState *s)
+{
+    int f = persel_to_function(s);
+
+    if (f < 0 || !has_function(s, f)) {
+        return -1;
+    }
+
+    return f;
+}
+
+static MemTxResult flexcomm_reg_write(void *opaque, hwaddr addr,
+                                     uint64_t value, unsigned size,
+                                     MemTxAttrs attrs)
+{
+    FlexcommState *s = opaque;
+    MemTxResult ret = MEMTX_OK;
+    const struct RegisterAccessInfo *rai = &reg_info[addr / 4];
+    struct RegisterInfo ri = {
+        .data = &s->regs[addr / 4],
+        .data_size = 4,
+        .access = rai,
+    };
+
+    trace_flexcomm_reg_write(DEVICE(s)->id, rai->name, addr, value);
+
+    switch (addr) {
+    case A_FLEXCOMM_PID:
+        /* RO register, nothing do to */
+        break;
+    case A_FLEXCOMM_PSELID:
+    {
+        if (size != 4) {
+            ret = MEMTX_ERROR;
+            break;
+        }
+
+        if (RF_RD(s, PSELID, LOCK)) {
+            break;
+        }
+
+        flexcomm_func_select(s, false);
+
+        register_write(&ri, value, ~0, modname, false);
+
+        if (flexcomm_check_function(s) < 0) {
+            RF_WR(s, PSELID, PERSEL, 0);
+        }
+
+        flexcomm_func_select(s, true);
+        break;
+    }
+    default:
+        return flexcomm_func_reg_write(s, addr, value, size);
+    }
+
+    return ret;
+}
+
+
+static const MemoryRegionOps flexcomm_ops = {
+    .read_with_attrs = flexcomm_reg_read,
+    .write_with_attrs = flexcomm_reg_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+        .unaligned = false,
+    },
+};
+
+static Property flexcomm_properties[] = {
+    DEFINE_PROP_UINT32("functions", FlexcommState, functions,
+                       FLEXCOMM_FULL),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void flexcomm_init(Object *obj)
+{
+    FlexcommState *s = FLEXCOMM(obj);
+    DeviceState *dev = DEVICE(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+
+    memory_region_init_io(&s->mmio, obj, &flexcomm_ops, s,
+                          TYPE_FLEXCOMM, sizeof(s->regs));
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
+
+    sysbus_init_irq(sbd, &s->irq);
+}
+
+static void flexcomm_realize(DeviceState *dev, Error **errp)
+{
+}
+
+static void flexcomm_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->reset = flexcomm_reset;
+    device_class_set_props(dc, flexcomm_properties);
+    dc->realize = flexcomm_realize;
+}
+
+static const TypeInfo flexcomm_types[] = {
+    {
+        .name          = TYPE_FLEXCOMM,
+        .parent        = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(FlexcommState),
+        .instance_init = flexcomm_init,
+        .class_init    = flexcomm_class_init,
+    },
+};
+
+DEFINE_TYPES(flexcomm_types);
+
+void flexcomm_irq(FlexcommState *s, bool irq)
+{
+    if (s->irq_state != irq) {
+        trace_flexcomm_irq(DEVICE(s)->id, irq);
+        qemu_set_irq(s->irq, irq);
+        s->irq_state = irq;
+    }
+}
+
+bool flexcomm_register_ops(int f, void *arg, const FlexcommFunctionOps *ops,
+                          Error **errp)
+{
+    if (f < 0 || f >= FLEXCOMM_FUNCTIONS) {
+        error_setg(errp, modname ": invalid function %d", f);
+        return false;
+    }
+
+    if (flexcomm_fops[f]) {
+        error_setg(errp, modname ": function %d already registered", f);
+        return false;
+    }
+
+    flexcomm_fops[f] = ops;
+    flexcomm_farg[f] = arg;
+
+    return true;
+}
+
+/* for unit tests */
+void flexcomm_unregister_ops(int f)
+{
+    flexcomm_fops[f] = NULL;
+    flexcomm_farg[f] = NULL;
+}
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index aefde0c69a..eb604d00cf 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -78,3 +78,5 @@ system_ss.add(when: 'CONFIG_VEXPRESS', if_true: files('vexpress.c'))
 system_ss.add(when: 'CONFIG_Z2', if_true: files('z2.c'))
 
 hw_arch += {'arm': arm_ss}
+
+subdir('svd')
diff --git a/hw/arm/svd/meson.build b/hw/arm/svd/meson.build
index 7d83d2ccbc..4b0bbbbbdc 100644
--- a/hw/arm/svd/meson.build
+++ b/hw/arm/svd/meson.build
@@ -1,4 +1,7 @@
 if get_option('mcux-soc-svd')
   mcux_soc_svd = subproject('mcux-soc-svd')
   rt595 = mcux_soc_svd.get_variable('rt595')
+  run_target('svd-flexcomm', command: svd_gen_header +
+    [ '-i', rt595, '-o', '@SOURCE_ROOT@/include/hw/arm/svd/flexcomm.h',
+    '-p', 'FLEXCOMM0', '-t', 'FLEXCOMM'])
 endif
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 1e08785b83..b373e651e1 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -213,4 +213,9 @@ config IOSB
 config XLNX_VERSAL_TRNG
     bool
 
+config FLEXCOMM
+    bool
+    select I2C
+    select SSI
+
 source macio/Kconfig
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 86596a3888..8414767ae3 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -156,3 +156,5 @@ system_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa_ec.c'))
 
 # HPPA devices
 system_ss.add(when: 'CONFIG_LASI', if_true: files('lasi.c'))
+
+system_ss.add(when: 'CONFIG_FLEXCOMM', if_true: files('flexcomm.c'))
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 5d241cb40a..71ec77de29 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -351,3 +351,9 @@ djmemc_write(int reg, uint64_t value, unsigned int size) "reg=0x%x value=0x%"PRI
 # iosb.c
 iosb_read(int reg, uint64_t value, unsigned int size) "reg=0x%x value=0x%"PRIx64" size=%u"
 iosb_write(int reg, uint64_t value, unsigned int size) "reg=0x%x value=0x%"PRIx64" size=%u"
+
+# flexcomm
+flexcomm_reset(void) ""
+flexcomm_irq(const char *id, uint8_t irq) "%s %d"
+flexcomm_reg_read(const char *devname, const char *regname, uint32_t addr, uint32_t val) "%s: %s[0x%04x] -> 0x%08x"
+flexcomm_reg_write(const char *dename, const char *regname, uint32_t addr, uint32_t val) "%s: %s[0x%04x] <- 0x%08x"
-- 
2.46.0.295.g3b9ea8a38a-goog


