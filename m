Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF090BD1819
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Oct 2025 07:49:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8BM7-0007zi-Cu; Mon, 13 Oct 2025 01:44:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v8BM4-0007z2-HR; Mon, 13 Oct 2025 01:44:20 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v8BM2-0002DU-8p; Mon, 13 Oct 2025 01:44:19 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 13 Oct
 2025 13:43:38 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 13 Oct 2025 13:43:38 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>
Subject: [PATCH v3 09/16] hw/arm/aspeed: Introduce AspeedCoprocessor class and
 base implementation
Date: Mon, 13 Oct 2025 13:43:21 +0800
Message-ID: <20251013054334.955331-10-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251013054334.955331-1-jamin_lin@aspeedtech.com>
References: <20251013054334.955331-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_FAIL=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Add a new AspeedCoprocessor class that defines the foundational structure for
ASPEED coprocessor models. This class encapsulates a base DeviceState with
links to system memory, clock, and peripheral components such as SCU, SCUIO,
Timer Controller, and UARTs.

Introduce the corresponding implementation file
aspeed_coprocessor_common.c, which provides the aspeed_coprocessor_realize()
method, property registration, and QOM type registration. The class is marked
as abstract and intended to serve as a common base for specific coprocessor
variants (e.g. SSP/TSP subsystems).

This establishes a reusable and extensible framework for modeling ASPEED
coprocessor devices.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 include/hw/arm/aspeed_coprocessor.h | 44 ++++++++++++++++++++++++++
 hw/arm/aspeed_coprocessor_common.c  | 49 +++++++++++++++++++++++++++++
 hw/arm/meson.build                  |  3 +-
 3 files changed, 95 insertions(+), 1 deletion(-)
 create mode 100644 include/hw/arm/aspeed_coprocessor.h
 create mode 100644 hw/arm/aspeed_coprocessor_common.c

diff --git a/include/hw/arm/aspeed_coprocessor.h b/include/hw/arm/aspeed_coprocessor.h
new file mode 100644
index 0000000000..793c7b1f8b
--- /dev/null
+++ b/include/hw/arm/aspeed_coprocessor.h
@@ -0,0 +1,44 @@
+/*
+ * ASPEED Coprocessor
+ *
+ * Copyright (C) 2025 ASPEED Technology Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef ASPEED_COPROCESSOR_H
+#define ASPEED_COPROCESSOR_H
+
+#include "qom/object.h"
+#include "hw/arm/aspeed_soc.h"
+
+struct AspeedCoprocessorState {
+    DeviceState parent;
+
+    MemoryRegion *memory;
+    MemoryRegion sram;
+    Clock *sysclk;
+
+    AspeedSCUState scu;
+    AspeedSCUState scuio;
+    AspeedTimerCtrlState timerctrl;
+    SerialMM uart[ASPEED_UARTS_NUM];
+};
+
+#define TYPE_ASPEED_COPROCESSOR "aspeed-coprocessor"
+OBJECT_DECLARE_TYPE(AspeedCoprocessorState, AspeedCoprocessorClass,
+                    ASPEED_COPROCESSOR)
+
+struct AspeedCoprocessorClass {
+    DeviceClass parent_class;
+
+    /** valid_cpu_types: NULL terminated array of a single CPU type. */
+    const char * const *valid_cpu_types;
+    uint32_t silicon_rev;
+    const hwaddr *memmap;
+    const int *irqmap;
+    int uarts_base;
+    int uarts_num;
+};
+
+#endif /* ASPEED_COPROCESSOR_H */
diff --git a/hw/arm/aspeed_coprocessor_common.c b/hw/arm/aspeed_coprocessor_common.c
new file mode 100644
index 0000000000..8a94b44f07
--- /dev/null
+++ b/hw/arm/aspeed_coprocessor_common.c
@@ -0,0 +1,49 @@
+/*
+ * ASPEED Coprocessor
+ *
+ * Copyright (C) 2025 ASPEED Technology Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "system/memory.h"
+#include "hw/qdev-properties.h"
+#include "hw/arm/aspeed_coprocessor.h"
+
+static void aspeed_coprocessor_realize(DeviceState *dev, Error **errp)
+{
+    AspeedCoprocessorState *s = ASPEED_COPROCESSOR(dev);
+
+    if (!s->memory) {
+        error_setg(errp, "'memory' link is not set");
+        return;
+    }
+}
+
+static const Property aspeed_coprocessor_properties[] = {
+    DEFINE_PROP_LINK("memory", AspeedCoprocessorState, memory,
+                     TYPE_MEMORY_REGION, MemoryRegion *),
+};
+
+static void aspeed_coprocessor_class_init(ObjectClass *oc, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->realize = aspeed_coprocessor_realize;
+    device_class_set_props(dc, aspeed_coprocessor_properties);
+}
+
+static const TypeInfo aspeed_coprocessor_types[] = {
+    {
+        .name           = TYPE_ASPEED_COPROCESSOR,
+        .parent         = TYPE_DEVICE,
+        .instance_size  = sizeof(AspeedCoprocessorState),
+        .class_size     = sizeof(AspeedCoprocessorClass),
+        .class_init     = aspeed_coprocessor_class_init,
+        .abstract       = true,
+    },
+};
+
+DEFINE_TYPES(aspeed_coprocessor_types)
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index dc68391305..56bdb88b11 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -52,7 +52,8 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'fby35.c'))
 arm_common_ss.add(when: ['CONFIG_ASPEED_SOC', 'TARGET_AARCH64'], if_true: files(
   'aspeed_ast27x0.c',
-  'aspeed_ast27x0-fc.c',))
+  'aspeed_ast27x0-fc.c',
+  'aspeed_coprocessor_common.c'))
 arm_common_ss.add(when: 'CONFIG_MPS2', if_true: files('mps2.c'))
 arm_common_ss.add(when: 'CONFIG_MPS2', if_true: files('mps2-tz.c'))
 arm_common_ss.add(when: 'CONFIG_MSF2', if_true: files('msf2-soc.c'))
-- 
2.43.0


