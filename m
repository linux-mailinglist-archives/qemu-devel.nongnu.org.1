Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8410697C08B
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Sep 2024 21:30:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sr0Gs-00054r-Gj; Wed, 18 Sep 2024 15:23:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3mSjrZgUKCtQJ0L8F6EE6B4.2ECG4CK-34L4BDED6DK.EH6@flex--tavip.bounces.google.com>)
 id 1sr0Gc-0004Vh-N5
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 15:23:13 -0400
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3mSjrZgUKCtQJ0L8F6EE6B4.2ECG4CK-34L4BDED6DK.EH6@flex--tavip.bounces.google.com>)
 id 1sr0GZ-0007JM-Rx
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 15:23:10 -0400
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-6ddd980af81so866567b3.2
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 12:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1726687386; x=1727292186; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=lEVtRqlZJene7dTeaWQA40okr0fqxtlzPIuT5Zal7q4=;
 b=BSHaJpsVkuWnn8mLgtpOPzEg6yxaajQKvMUCpHEw2S8SE+gsspM2cS1XZE7hJmglgV
 SjT5MiPoq/256lLYf8yOAjTBVhmJMshl/JzYd5n80/9odWyS7ZhL+mBTJmXd6vFB0e+L
 13OSNx8bcfLjq1Q/CC2By1UR7ZUfzmDaZFkKShSPERqvhCQ6i+/xtWRGLw0td+9F6fLk
 5aCBwtw2dLi1hjr7Nz5/JOYMyh87O7d/cNakOscE6Dd0FWit9+kE4ftTX+umDGNY+DTV
 YNzQmspgWEArYWNTBjmmUVUruwvnHkrDkJbGDTMDzifv+pOEUIkb3aLFEI+wVeHNpluj
 xTcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726687386; x=1727292186;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lEVtRqlZJene7dTeaWQA40okr0fqxtlzPIuT5Zal7q4=;
 b=Ii3jnPmXnC1XPu+yR9BNrYmOjZLaDwmZ9EaW03t6TiyWXdeGsWnIR29RdI5HwhAg7v
 W7wa/52heZLUDD64SYnfqFd7MNCyLUnt2OCA0O7LCdqwYqpr8LG58awy2jXRBA6PiILe
 WZ7EKbywEDmJE6CdjMjzycFGqUAvg5tFX04Ac8HqpLGYR+gAw2aeP3lLJ57VEW1BCqc9
 HaufBVpf4QbzHvDwjwsNUIDRKT0de+7veIf5ZGUO1qpSiMl5HNoBHwuy8Z430vkvw1QD
 cWlI31hQ/GAnEyv+bfttXxuBQmkhIITq3ktJEXTr+nrORrixyVeNPCHyGzjXkT7aJtsH
 on5Q==
X-Gm-Message-State: AOJu0YxDmvN12QgoAYZs6OBj5dzipFRuQANMDQJX8A1m5CD2mL+XxzWM
 IwGkIF7mJv6M5TfZZbqYVSdNv2vq8D+BrHbeSBkUdMcM43NLW7wkggIobYulaR4bg6StNkk2pyV
 KoubR0nYmCivl8CWcSRLm6oHlyDIcR4XL5bRkXEQyl5getiTqHL3j7BsDbrmA8ra1vNDyL5/2mD
 ycbaby74tPCmUK4n/DYFNih4oC/A==
X-Google-Smtp-Source: AGHT+IGfxGkXDdfCP6DbI5su4miHO/yemHL1KhNk7vT2hgJw5NXJ1I8hE7NeD92eXlVpKuAKu2ULXV8uNQ==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a81:b302:0:b0:6dd:b9bb:360a with
 SMTP id
 00721157ae682-6ddb9bb38e2mr4274627b3.1.1726687385354; Wed, 18 Sep 2024
 12:23:05 -0700 (PDT)
Date: Wed, 18 Sep 2024 12:22:33 -0700
In-Reply-To: <20240918192254.3136903-1-tavip@google.com>
Mime-Version: 1.0
References: <20240918192254.3136903-1-tavip@google.com>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Message-ID: <20240918192254.3136903-6-tavip@google.com>
Subject: [PATCH 05/25] hw/misc: add support for flexcomm
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 peter.maydell@linaro.org, marcandre.lureau@redhat.com, berrange@redhat.com, 
 eduardo@habkost.net, luc@lmichel.fr, damien.hedde@dahe.fr, 
 alistair@alistair23.me, thuth@redhat.com, philmd@linaro.org, jsnow@redhat.com, 
 crosa@redhat.com, lvivier@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1149;
 envelope-from=3mSjrZgUKCtQJ0L8F6EE6B4.2ECG4CK-34L4BDED6DK.EH6@flex--tavip.bounces.google.com;
 helo=mail-yw1-x1149.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

Add support for NXP's FLEXCOMM device model.

FLEXCOMM is a generic serial communication module which support
multiple functions: UART, SPI and I2C. These are configurable at
runtime.

An abstract FlexcomFunction class is created that will be extended for
specific functions. Each function has a dedicated overlapped
MemoryRegion that it is going to be activated when that particular
function is selected.

A generic MemoryRegion is used to map generic registers (PSELID, PID)
that is always active but has a lower priority. The function memory
region is trimed to not include the generic registers.

The FlexcommFunction object also gets access to the (non-concurrently)
shared register backstore.

The patch includes an automatically generated header which contains
the register layout and helpers.

The header can be regenerated with the svd-flexcomm target when the
build is configured with --enable-mcux-soc-svd.

Signed-off-by: Octavian Purdila <tavip@google.com>
---
 include/hw/arm/svd/flexcomm.h       | 112 ++++++++++
 include/hw/misc/flexcomm.h          |  49 +++++
 include/hw/misc/flexcomm_function.h |  47 ++++
 hw/misc/flexcomm.c                  | 319 ++++++++++++++++++++++++++++
 hw/arm/meson.build                  |   2 +
 hw/arm/svd/meson.build              |   3 +
 hw/misc/Kconfig                     |   3 +
 hw/misc/meson.build                 |   2 +
 hw/misc/trace-events                |   5 +
 9 files changed, 542 insertions(+)
 create mode 100644 include/hw/arm/svd/flexcomm.h
 create mode 100644 include/hw/misc/flexcomm.h
 create mode 100644 include/hw/misc/flexcomm_function.h
 create mode 100644 hw/misc/flexcomm.c

diff --git a/include/hw/arm/svd/flexcomm.h b/include/hw/arm/svd/flexcomm.h
new file mode 100644
index 0000000000..4639722bc7
--- /dev/null
+++ b/include/hw/arm/svd/flexcomm.h
@@ -0,0 +1,112 @@
+/*
+ * Copyright 2016-2023 NXP SPDX-License-Identifier: BSD-3-Clause
+ *
+ * Automatically generated by svd-gen-header.py from MIMXRT595S_cm33.xml
+ */
+#pragma once
+
+#include "hw/register.h"
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
index 0000000000..ea0fe77f26
--- /dev/null
+++ b/include/hw/misc/flexcomm.h
@@ -0,0 +1,49 @@
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
+#define TYPE_FLEXCOMM "flexcomm"
+OBJECT_DECLARE_SIMPLE_TYPE(FlexcommState, FLEXCOMM);
+
+struct FlexcommState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion container;
+    MemoryRegion mmio;
+    uint32_t regs[FLEXCOMM_REGS_NO];
+    uint32_t functions;
+    qemu_irq irq;
+    bool irq_state;
+};
+
+#endif /* HW_FLEXCOMM_H */
diff --git a/include/hw/misc/flexcomm_function.h b/include/hw/misc/flexcomm_function.h
new file mode 100644
index 0000000000..e498976927
--- /dev/null
+++ b/include/hw/misc/flexcomm_function.h
@@ -0,0 +1,47 @@
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
+#ifndef HW_FLEXCOMM_FUNCTION_H
+#define HW_FLEXCOMM_FUNCTION_H
+
+#include "qemu/fifo32.h"
+#include "hw/sysbus.h"
+
+#define TYPE_FLEXCOMM_FUNCTION "flexcomm-function"
+OBJECT_DECLARE_TYPE(FlexcommFunction, FlexcommFunctionClass, FLEXCOMM_FUNCTION);
+
+struct FlexcommFunction {
+    SysBusDevice parent_obj;
+
+    MemoryRegion mmio;
+    uint32_t *regs;
+};
+
+typedef void (*FlexcommFunctionSelect)(FlexcommFunction *f, bool selected);
+
+struct FlexcommFunctionClass {
+    SysBusDeviceClass parent_class;
+
+    const MemoryRegionOps *mmio_ops;
+    const char *name;
+    FlexcommFunctionSelect select;
+};
+
+static inline void flexcomm_select(FlexcommFunction *obj, bool selected)
+{
+    FlexcommFunctionClass *klass = FLEXCOMM_FUNCTION_GET_CLASS(obj);
+
+    klass->select(obj, selected);
+}
+
+void flexcomm_set_irq(FlexcommFunction *f, bool irq);
+
+#endif /* HW_FLEXCOMM_FUNCTION_H */
diff --git a/hw/misc/flexcomm.c b/hw/misc/flexcomm.c
new file mode 100644
index 0000000000..2337fb814c
--- /dev/null
+++ b/hw/misc/flexcomm.c
@@ -0,0 +1,319 @@
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
+#include "migration/vmstate.h"
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
+#define FLEXCOMM_FUNC_MMIO_SIZE \
+    ((FLEXCOMM_REGS_NO - 2) * sizeof(uint32_t))
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
+    FlexcommFunction *obj[] = {
+        FLEXCOMM_FUNCTION(&s->usart),
+        FLEXCOMM_FUNCTION(&s->spi),
+        FLEXCOMM_FUNCTION(&s->i2c),
+    };
+    int f = persel_to_function(s);
+
+    if (f >= 0 && f < ARRAY_SIZE(obj)) {
+        flexcomm_select(obj[f], selected);
+    }
+}
+
+static void flexcomm_reset_enter(Object *o, ResetType type)
+{
+    FlexcommState *s = FLEXCOMM(o);
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
+}
+
+static void flexcomm_reset_exit(Object *o, ResetType type)
+{
+    FlexcommState *s = FLEXCOMM(o);
+
+    qemu_set_irq(s->irq, s->irq_state);
+}
+
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
+        *data = s->regs[addr / 4];
+        break;
+    }
+    default:
+        return MEMTX_ERROR;
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
+            break;
+        }
+
+        flexcomm_func_select(s, true);
+        break;
+    }
+    default:
+        return MEMTX_ERROR;
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
+        .min_access_size = 4,
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
+    memory_region_init(&s->container, obj, "container", sizeof(s->regs));
+    memory_region_init_io(&s->mmio, obj, &flexcomm_ops, s,
+                          TYPE_FLEXCOMM, sizeof(s->regs));
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->container);
+    sysbus_init_irq(sbd, &s->irq);
+}
+
+static void flexcomm_func_realize_and_unref(FlexcommFunction *f, Error **errp)
+{
+    FlexcommState *s = FLEXCOMM(OBJECT(f)->parent);
+    FlexcommFunctionClass *fc = FLEXCOMM_FUNCTION_GET_CLASS(f);
+
+    f->regs = s->regs;
+    memory_region_add_subregion_overlap(&s->container, 0, &f->mmio, 0);
+    DEVICE(f)->id = g_strdup_printf("%s-%s", DEVICE(s)->id, fc->name);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(f), errp);
+    memory_region_set_enabled(&f->mmio, false);
+}
+
+static void flexcomm_realize(DeviceState *dev, Error **errp)
+{
+    FlexcommState *s = FLEXCOMM(dev);
+
+    memory_region_add_subregion_overlap(&s->container, 0, &s->mmio, -1);
+}
+
+static const VMStateDescription vmstate_flexcomm = {
+    .name = "flexcomm",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, FlexcommState, FLEXCOMM_REGS_NO),
+        VMSTATE_BOOL(irq_state, FlexcommState),
+        VMSTATE_FIFO32(rx_fifo, FlexcommState),
+        VMSTATE_FIFO32(tx_fifo, FlexcommState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void flexcomm_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    rc->phases.enter = flexcomm_reset_enter;
+    rc->phases.exit = flexcomm_reset_exit;
+    device_class_set_props(dc, flexcomm_properties);
+    dc->realize = flexcomm_realize;
+    dc->vmsd = &vmstate_flexcomm;
+}
+
+void flexcomm_set_irq(FlexcommFunction *f, bool irq)
+{
+    FlexcommState *s = FLEXCOMM(OBJECT(f)->parent);
+
+    if (s->irq_state != irq) {
+        trace_flexcomm_irq(DEVICE(s)->id, irq);
+        qemu_set_irq(s->irq, irq);
+        s->irq_state = irq;
+    }
+}
+
+static void flexcomm_function_select(FlexcommFunction *f, bool selected)
+{
+    FlexcommFunctionClass *fc = FLEXCOMM_FUNCTION_GET_CLASS(f);
+
+    memory_region_set_enabled(&f->mmio, selected);
+}
+
+static void flexcomm_function_init(Object *obj)
+{
+    FlexcommFunctionClass *fc = FLEXCOMM_FUNCTION_GET_CLASS(obj);
+    FlexcommFunction *f = FLEXCOMM_FUNCTION(obj);
+
+    memory_region_init_io(&f->mmio, obj, fc->mmio_ops, obj, fc->name,
+                          FLEXCOMM_FUNC_MMIO_SIZE);
+}
+
+static void flexcomm_function_class_init(ObjectClass *klass, void *data)
+{
+    FlexcommFunctionClass *fc = FLEXCOMM_FUNCTION_CLASS(klass);
+
+    fc->select = flexcomm_function_select;
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
+    {
+        .name          = TYPE_FLEXCOMM_FUNCTION,
+        .parent        = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(FlexcommFunction),
+        .abstract      = true,
+        .class_size    = sizeof(FlexcommFunctionClass),
+        .instance_init = flexcomm_function_init,
+        .class_init    = flexcomm_function_class_init,
+    },
+};
+
+DEFINE_TYPES(flexcomm_types);
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 4059d0be2e..fdfd083f75 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -82,3 +82,5 @@ system_ss.add(when: 'CONFIG_VEXPRESS', if_true: files('vexpress.c'))
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
index 1e08785b83..14167ae9e8 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -213,4 +213,7 @@ config IOSB
 config XLNX_VERSAL_TRNG
     bool
 
+config FLEXCOMM
+    bool
+
 source macio/Kconfig
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 2ca8717be2..749f688e84 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -157,3 +157,5 @@ system_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa_ec.c'))
 
 # HPPA devices
 system_ss.add(when: 'CONFIG_LASI', if_true: files('lasi.c'))
+
+system_ss.add(when: 'CONFIG_FLEXCOMM', if_true: files('flexcomm.c'))
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 1be0717c0c..419879fd65 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -362,3 +362,8 @@ aspeed_sli_read(uint64_t offset, unsigned int size, uint32_t data) "To 0x%" PRIx
 aspeed_sliio_write(uint64_t offset, unsigned int size, uint32_t data) "To 0x%" PRIx64 " of size %u: 0x%" PRIx32
 aspeed_sliio_read(uint64_t offset, unsigned int size, uint32_t data) "To 0x%" PRIx64 " of size %u: 0x%" PRIx32
 
+# flexcomm
+flexcomm_reset(void) ""
+flexcomm_irq(const char *id, uint8_t irq) "%s %d"
+flexcomm_reg_read(const char *devname, const char *regname, uint32_t addr, uint32_t val) "%s: %s[0x%04x] -> 0x%08x"
+flexcomm_reg_write(const char *dename, const char *regname, uint32_t addr, uint32_t val) "%s: %s[0x%04x] <- 0x%08x"
-- 
2.46.0.662.g92d0881bb0-goog


