Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BB0AA8F0D
	for <lists+qemu-devel@lfdr.de>; Mon,  5 May 2025 11:12:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBrrc-0005M6-WD; Mon, 05 May 2025 05:11:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uBrnW-0008Kv-RN
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:07:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uBrnS-0006P3-72
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:07:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746436053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QWjhcp0cmbm4masVveL+QrvQsIN1xYgv7pOG3qZD7sA=;
 b=NpDvhhV3DzYW6zJ3FpFvFW2Fs2tf2wnowLE12C8Qpe0wWK4w8YjbOtdocJx7pPwdqmz+UI
 8jyhPXYJ90SGVRQr4UsM7FnN18sFhfAhqGBU1GeOU0VATttZ1BpysYPlEV6Y0m0NVAzAsg
 pGBy7UrtTe837brBzDNB4vMlIDn1mRU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-K17ZjNheOG-hY6sY0wZKQw-1; Mon,
 05 May 2025 05:07:31 -0400
X-MC-Unique: K17ZjNheOG-hY6sY0wZKQw-1
X-Mimecast-MFC-AGG-ID: K17ZjNheOG-hY6sY0wZKQw_1746436051
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EDE01180034E; Mon,  5 May 2025 09:07:30 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.38])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 343F830001A2; Mon,  5 May 2025 09:07:28 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Steven Lee <steven_lee@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 19/23] hw/arm/aspeed_ast27x0-ssp: Introduce AST27x0 A1 SSP SoC
Date: Mon,  5 May 2025 11:06:31 +0200
Message-ID: <20250505090635.778785-20-clg@redhat.com>
In-Reply-To: <20250505090635.778785-1-clg@redhat.com>
References: <20250505090635.778785-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Steven Lee <steven_lee@aspeedtech.com>

The AST2700 SSP (Secondary Service Processor) is a Cortex-M4 coprocessor.
This patch adds support for A1 SSP with the following updates:

- Introduce Aspeed27x0SSPSoCState structure in aspeed_soc.h
- Define memory map and IRQ map for AST27x0 A1 SSP SoC
- Implement initialization and realization functions
- Add support for UART, INTC, and SCU devices
- Map unimplemented devices for IPC and SCUIO

The IRQ mapping is similar to AST2700 CA35 SoC, featuring a two-level
interrupt controller.

Difference from AST2700:

    - AST2700
      - Support GICINT128 to GICINT136 in INTC
      - The INTCIO GIC_192_201 has 10 output pins, mapped as follows:
          Bit 0 -> GIC 192
          Bit 1 -> GIC 193
          Bit 2 -> GIC 194
          Bit 3 -> GIC 195
          Bit 4 -> GIC 196

    - AST2700-ssp
      - Support SSPINT128 to SSPINT136 in INTC
      - The INTCIO SSPINT_160_169 has 10 output pins, mapped as follows:
          Bit 0 -> SSPINT 160
          Bit 1 -> SSPINT 161
          Bit 2 -> SSPINT 162
          Bit 3 -> SSPINT 163
          Bit 4 -> SSPINT 164

Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
Change-Id: I924bf1a657f1e83f9e16d6673713f4a06ecdb496
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250502103449.3091642-6-steven_lee@aspeedtech.com
[ clg: removed local 'Error* err' in aspeed_soc_ast27x0ssp_realize() ]
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/arm/aspeed_soc.h |  14 ++
 hw/arm/aspeed_ast27x0-ssp.c | 294 ++++++++++++++++++++++++++++++++++++
 hw/arm/meson.build          |   1 +
 3 files changed, 309 insertions(+)
 create mode 100644 hw/arm/aspeed_ast27x0-ssp.c

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 5fcfd2fe2e62..32be90bc3536 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -146,6 +146,18 @@ struct Aspeed10x0SoCState {
     ARMv7MState armv7m;
 };
 
+struct Aspeed27x0SSPSoCState {
+    AspeedSoCState parent;
+    AspeedINTCState intc[2];
+    UnimplementedDeviceState ipc[2];
+    UnimplementedDeviceState scuio;
+
+    ARMv7MState armv7m;
+};
+
+#define TYPE_ASPEED27X0SSP_SOC "aspeed27x0ssp-soc"
+OBJECT_DECLARE_SIMPLE_TYPE(Aspeed27x0SSPSoCState, ASPEED27X0SSP_SOC)
+
 #define TYPE_ASPEED10X0_SOC "aspeed10x0-soc"
 OBJECT_DECLARE_SIMPLE_TYPE(Aspeed10x0SoCState, ASPEED10X0_SOC)
 
@@ -259,6 +271,8 @@ enum {
     ASPEED_DEV_SLIIO,
     ASPEED_GIC_DIST,
     ASPEED_GIC_REDIST,
+    ASPEED_DEV_IPC0,
+    ASPEED_DEV_IPC1,
 };
 
 qemu_irq aspeed_soc_get_irq(AspeedSoCState *s, int dev);
diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c
new file mode 100644
index 000000000000..80ec5996c1d1
--- /dev/null
+++ b/hw/arm/aspeed_ast27x0-ssp.c
@@ -0,0 +1,294 @@
+/*
+ * ASPEED Ast27x0 SSP SoC
+ *
+ * Copyright (C) 2025 ASPEED Technology Inc.
+ *
+ * This code is licensed under the GPL version 2 or later.  See
+ * the COPYING file in the top-level directory.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/qdev-clock.h"
+#include "hw/misc/unimp.h"
+#include "hw/arm/aspeed_soc.h"
+
+#define AST2700_SSP_RAM_SIZE (32 * MiB)
+
+static const hwaddr aspeed_soc_ast27x0ssp_memmap[] = {
+    [ASPEED_DEV_SRAM]      =  0x00000000,
+    [ASPEED_DEV_INTC]      =  0x72100000,
+    [ASPEED_DEV_SCU]       =  0x72C02000,
+    [ASPEED_DEV_SCUIO]     =  0x74C02000,
+    [ASPEED_DEV_UART0]     =  0x74C33000,
+    [ASPEED_DEV_UART1]     =  0x74C33100,
+    [ASPEED_DEV_UART2]     =  0x74C33200,
+    [ASPEED_DEV_UART3]     =  0x74C33300,
+    [ASPEED_DEV_UART4]     =  0x72C1A000,
+    [ASPEED_DEV_INTCIO]    =  0x74C18000,
+    [ASPEED_DEV_IPC0]      =  0x72C1C000,
+    [ASPEED_DEV_IPC1]      =  0x74C39000,
+    [ASPEED_DEV_UART5]     =  0x74C33400,
+    [ASPEED_DEV_UART6]     =  0x74C33500,
+    [ASPEED_DEV_UART7]     =  0x74C33600,
+    [ASPEED_DEV_UART8]     =  0x74C33700,
+    [ASPEED_DEV_UART9]     =  0x74C33800,
+    [ASPEED_DEV_UART10]    =  0x74C33900,
+    [ASPEED_DEV_UART11]    =  0x74C33A00,
+    [ASPEED_DEV_UART12]    =  0x74C33B00,
+    [ASPEED_DEV_TIMER1]    =  0x72C10000,
+};
+
+static const int aspeed_soc_ast27x0ssp_irqmap[] = {
+    [ASPEED_DEV_SCU]       = 12,
+    [ASPEED_DEV_UART0]     = 164,
+    [ASPEED_DEV_UART1]     = 164,
+    [ASPEED_DEV_UART2]     = 164,
+    [ASPEED_DEV_UART3]     = 164,
+    [ASPEED_DEV_UART4]     = 8,
+    [ASPEED_DEV_UART5]     = 164,
+    [ASPEED_DEV_UART6]     = 164,
+    [ASPEED_DEV_UART7]     = 164,
+    [ASPEED_DEV_UART8]     = 164,
+    [ASPEED_DEV_UART9]     = 164,
+    [ASPEED_DEV_UART10]    = 164,
+    [ASPEED_DEV_UART11]    = 164,
+    [ASPEED_DEV_UART12]    = 164,
+    [ASPEED_DEV_TIMER1]    = 16,
+};
+
+/* SSPINT 164 */
+static const int ast2700_ssp132_ssp164_intcmap[] = {
+    [ASPEED_DEV_UART0]     = 7,
+    [ASPEED_DEV_UART1]     = 8,
+    [ASPEED_DEV_UART2]     = 9,
+    [ASPEED_DEV_UART3]     = 10,
+    [ASPEED_DEV_UART5]     = 11,
+    [ASPEED_DEV_UART6]     = 12,
+    [ASPEED_DEV_UART7]     = 13,
+    [ASPEED_DEV_UART8]     = 14,
+    [ASPEED_DEV_UART9]     = 15,
+    [ASPEED_DEV_UART10]    = 16,
+    [ASPEED_DEV_UART11]    = 17,
+    [ASPEED_DEV_UART12]    = 18,
+};
+
+struct nvic_intc_irq_info {
+    int irq;
+    int intc_idx;
+    int orgate_idx;
+    const int *ptr;
+};
+
+static struct nvic_intc_irq_info ast2700_ssp_intcmap[] = {
+    {160, 1, 0, NULL},
+    {161, 1, 1, NULL},
+    {162, 1, 2, NULL},
+    {163, 1, 3, NULL},
+    {164, 1, 4, ast2700_ssp132_ssp164_intcmap},
+    {165, 1, 5, NULL},
+    {166, 1, 6, NULL},
+    {167, 1, 7, NULL},
+    {168, 1, 8, NULL},
+    {169, 1, 9, NULL},
+    {128, 0, 1, NULL},
+    {129, 0, 2, NULL},
+    {130, 0, 3, NULL},
+    {131, 0, 4, NULL},
+    {132, 0, 5, ast2700_ssp132_ssp164_intcmap},
+    {133, 0, 6, NULL},
+    {134, 0, 7, NULL},
+    {135, 0, 8, NULL},
+    {136, 0, 9, NULL},
+};
+
+static qemu_irq aspeed_soc_ast27x0ssp_get_irq(AspeedSoCState *s, int dev)
+{
+    Aspeed27x0SSPSoCState *a = ASPEED27X0SSP_SOC(s);
+    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
+
+    int or_idx;
+    int idx;
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(ast2700_ssp_intcmap); i++) {
+        if (sc->irqmap[dev] == ast2700_ssp_intcmap[i].irq) {
+            assert(ast2700_ssp_intcmap[i].ptr);
+            or_idx = ast2700_ssp_intcmap[i].orgate_idx;
+            idx = ast2700_ssp_intcmap[i].intc_idx;
+            return qdev_get_gpio_in(DEVICE(&a->intc[idx].orgates[or_idx]),
+                                    ast2700_ssp_intcmap[i].ptr[dev]);
+        }
+    }
+
+    return qdev_get_gpio_in(DEVICE(&a->armv7m), sc->irqmap[dev]);
+}
+
+static void aspeed_soc_ast27x0ssp_init(Object *obj)
+{
+    Aspeed27x0SSPSoCState *a = ASPEED27X0SSP_SOC(obj);
+    AspeedSoCState *s = ASPEED_SOC(obj);
+    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
+    int i;
+
+    object_initialize_child(obj, "armv7m", &a->armv7m, TYPE_ARMV7M);
+    object_initialize_child(obj, "scu", &s->scu, TYPE_ASPEED_2700_SCU);
+    s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
+    qdev_prop_set_uint32(DEVICE(&s->scu), "silicon-rev", sc->silicon_rev);
+
+    for (i = 0; i < sc->uarts_num; i++) {
+        object_initialize_child(obj, "uart[*]", &s->uart[i], TYPE_SERIAL_MM);
+    }
+
+    object_initialize_child(obj, "intc0", &a->intc[0],
+                            TYPE_ASPEED_2700SSP_INTC);
+    object_initialize_child(obj, "intc1", &a->intc[1],
+                            TYPE_ASPEED_2700SSP_INTCIO);
+
+    object_initialize_child(obj, "timerctrl", &s->timerctrl,
+                            TYPE_UNIMPLEMENTED_DEVICE);
+    object_initialize_child(obj, "ipc0", &a->ipc[0],
+                            TYPE_UNIMPLEMENTED_DEVICE);
+    object_initialize_child(obj, "ipc1", &a->ipc[1],
+                            TYPE_UNIMPLEMENTED_DEVICE);
+    object_initialize_child(obj, "scuio", &a->scuio,
+                            TYPE_UNIMPLEMENTED_DEVICE);
+}
+
+static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
+{
+    Aspeed27x0SSPSoCState *a = ASPEED27X0SSP_SOC(dev_soc);
+    AspeedSoCState *s = ASPEED_SOC(dev_soc);
+    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
+    DeviceState *armv7m;
+    g_autofree char *sram_name = NULL;
+    int i;
+
+    if (!clock_has_source(s->sysclk)) {
+        error_setg(errp, "sysclk clock must be wired up by the board code");
+        return;
+    }
+
+    /* AST27X0 SSP Core */
+    armv7m = DEVICE(&a->armv7m);
+    qdev_prop_set_uint32(armv7m, "num-irq", 256);
+    qdev_prop_set_string(armv7m, "cpu-type", aspeed_soc_cpu_type(sc));
+    qdev_connect_clock_in(armv7m, "cpuclk", s->sysclk);
+    object_property_set_link(OBJECT(&a->armv7m), "memory",
+                             OBJECT(s->memory), &error_abort);
+    sysbus_realize(SYS_BUS_DEVICE(&a->armv7m), &error_abort);
+
+    sram_name = g_strdup_printf("aspeed.dram.%d",
+                                CPU(a->armv7m.cpu)->cpu_index);
+
+    if (!memory_region_init_ram(&s->sram, OBJECT(s), sram_name, sc->sram_size,
+                                errp)) {
+        return;
+    }
+    memory_region_add_subregion(s->memory,
+                                sc->memmap[ASPEED_DEV_SRAM],
+                                &s->sram);
+
+    /* SCU */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {
+        return;
+    }
+    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->scu), 0, sc->memmap[ASPEED_DEV_SCU]);
+
+    /* INTC */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&a->intc[0]), errp)) {
+        return;
+    }
+
+    aspeed_mmio_map(s, SYS_BUS_DEVICE(&a->intc[0]), 0,
+                    sc->memmap[ASPEED_DEV_INTC]);
+
+    /* INTCIO */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&a->intc[1]), errp)) {
+        return;
+    }
+
+    aspeed_mmio_map(s, SYS_BUS_DEVICE(&a->intc[1]), 0,
+                    sc->memmap[ASPEED_DEV_INTCIO]);
+
+    /* irq source orgates -> INTC0 */
+    for (i = 0; i < ASPEED_INTC_GET_CLASS(&a->intc[0])->num_inpins; i++) {
+        qdev_connect_gpio_out(DEVICE(&a->intc[0].orgates[i]), 0,
+                              qdev_get_gpio_in(DEVICE(&a->intc[0]), i));
+    }
+    for (i = 0; i < ASPEED_INTC_GET_CLASS(&a->intc[0])->num_outpins; i++) {
+        assert(i < ARRAY_SIZE(ast2700_ssp_intcmap));
+        sysbus_connect_irq(SYS_BUS_DEVICE(&a->intc[0]), i,
+                           qdev_get_gpio_in(DEVICE(&a->armv7m),
+                                            ast2700_ssp_intcmap[i].irq));
+    }
+    /* irq source orgates -> INTCIO */
+    for (i = 0; i < ASPEED_INTC_GET_CLASS(&a->intc[1])->num_inpins; i++) {
+        qdev_connect_gpio_out(DEVICE(&a->intc[1].orgates[i]), 0,
+                              qdev_get_gpio_in(DEVICE(&a->intc[1]), i));
+    }
+    /* INTCIO -> INTC */
+    for (i = 0; i < ASPEED_INTC_GET_CLASS(&a->intc[1])->num_outpins; i++) {
+        sysbus_connect_irq(SYS_BUS_DEVICE(&a->intc[1]), i,
+                        qdev_get_gpio_in(DEVICE(&a->intc[0].orgates[0]), i));
+    }
+    /* UART */
+    if (!aspeed_soc_uart_realize(s, errp)) {
+        return;
+    }
+
+    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->timerctrl),
+                                  "aspeed.timerctrl",
+                                  sc->memmap[ASPEED_DEV_TIMER1], 0x200);
+    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&a->ipc[0]),
+                                  "aspeed.ipc0",
+                                  sc->memmap[ASPEED_DEV_IPC0], 0x1000);
+    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&a->ipc[1]),
+                                  "aspeed.ipc1",
+                                  sc->memmap[ASPEED_DEV_IPC1], 0x1000);
+    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&a->scuio),
+                                  "aspeed.scuio",
+                                  sc->memmap[ASPEED_DEV_SCUIO], 0x1000);
+}
+
+static void aspeed_soc_ast27x0ssp_class_init(ObjectClass *klass, const void *data)
+{
+    static const char * const valid_cpu_types[] = {
+        ARM_CPU_TYPE_NAME("cortex-m4"), /* TODO: cortex-m4f */
+        NULL
+    };
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    AspeedSoCClass *sc = ASPEED_SOC_CLASS(dc);
+
+    /* Reason: The Aspeed SoC can only be instantiated from a board */
+    dc->user_creatable = false;
+    dc->realize = aspeed_soc_ast27x0ssp_realize;
+
+    sc->valid_cpu_types = valid_cpu_types;
+    sc->silicon_rev = AST2700_A1_SILICON_REV;
+    sc->sram_size = AST2700_SSP_RAM_SIZE;
+    sc->spis_num = 0;
+    sc->ehcis_num = 0;
+    sc->wdts_num = 0;
+    sc->macs_num = 0;
+    sc->uarts_num = 13;
+    sc->uarts_base = ASPEED_DEV_UART0;
+    sc->irqmap = aspeed_soc_ast27x0ssp_irqmap;
+    sc->memmap = aspeed_soc_ast27x0ssp_memmap;
+    sc->num_cpus = 1;
+    sc->get_irq = aspeed_soc_ast27x0ssp_get_irq;
+}
+
+static const TypeInfo aspeed_soc_ast27x0ssp_types[] = {
+    {
+        .name           = TYPE_ASPEED27X0SSP_SOC,
+        .parent         = TYPE_ASPEED_SOC,
+        .instance_size  = sizeof(Aspeed27x0SSPSoCState),
+        .instance_init  = aspeed_soc_ast27x0ssp_init,
+        .class_init     = aspeed_soc_ast27x0ssp_class_init,
+    },
+};
+
+DEFINE_TYPES(aspeed_soc_ast27x0ssp_types)
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 09b1cfe5b572..39b74a89ed8e 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -44,6 +44,7 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed_soc_common.c',
   'aspeed_ast2400.c',
   'aspeed_ast2600.c',
+  'aspeed_ast27x0-ssp.c',
   'aspeed_ast10x0.c',
   'aspeed_eeprom.c',
   'fby35.c'))
-- 
2.49.0


