Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C9564723E35
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 11:49:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6TIl-0007dO-2z; Tue, 06 Jun 2023 05:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TIe-0007aR-Nn
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:26 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TIa-0004jA-OC
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:24 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3f623adec61so60420135e9.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 02:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686044899; x=1688636899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dbW4GR4QIqhQcHZ3xyUai+qfPEZHoIr9LwZlkCY8DQc=;
 b=oIJPNJ3TT+IZetNU4dCQ49I/yswnuQ3iQn0Mh0+066khYA6qCaL5L3XcBkT+FapMlO
 znbHkMRqfPjxJZQRJbMLPUex10lL4+UXXCHNjZDMMyx+x+RDt7OwYMs7M5SXhaE5furH
 U76oaZjj6YT5lUC50E4idWPI7ChXNvaWaMd0NF7DbS5cunfLHVqxN368RUdj/upmbUU/
 M4EMwGkXQTVp9l2HXjzrZjB5bibFphNE/Ac+ancUDSTSXnsz3CRRa31ExnRHyQjOQYeX
 yaBfV6ruLa7tTiYd66m+714UJ8zI6e6Btqgb9NNU7u0l/BShIF32NOY1FntQazAzGopc
 31ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686044899; x=1688636899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dbW4GR4QIqhQcHZ3xyUai+qfPEZHoIr9LwZlkCY8DQc=;
 b=Tu2KhiQGgPau3eX8eBLGkSAuhoxsDhME6mwIodkuvzWCXPPs41QwxSitvAfWtLUnfL
 8OvIeLJxPChJxyUYAJgZzjWAeLg4criqFbSSa1pzlNbJ8ib1swExpLxBFGntohfy1ROo
 HuXGCwrDC0Co9ctsS3IEokbqm1y6DeRE3hDDdA6Q/YThKyEXybaCfm9SeXEaU9nGP6Bu
 4zSgjDn1tbNNIdp3V4mciAVtiXOwcPy8bBoKF6K8SU8kHC0EHJnqzRLtrZrfSbWOjY3Z
 T4ZOe4u9RkzFfdJt8NL7L/vWRxKymiC9VIGcl92Irqts36PYoGa1eIEecboXGvvsAyw9
 7dOg==
X-Gm-Message-State: AC+VfDwCxl6mcdfGI0Gl+FWkuoBYI6IF+x02l/deCvoX9r/US/6sew9N
 D1IFkGU3pA0lzWqsao+bODbkqRKwieYsaIzLo40=
X-Google-Smtp-Source: ACHHUZ7GOLj3iBYfKtJu8/Frsy8NTOXIQuET89/n3mNcQixD/fMwXYiFuakc9tF0/ZQCyJ4lkw5ZYQ==
X-Received: by 2002:a5d:514a:0:b0:30a:3498:a360 with SMTP id
 u10-20020a5d514a000000b0030a3498a360mr1284428wrt.24.1686044899335; 
 Tue, 06 Jun 2023 02:48:19 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v10-20020a5d4b0a000000b0030789698eebsm12134017wrq.89.2023.06.06.02.48.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 02:48:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/42] xlnx-versal: Connect Xilinx VERSAL CANFD controllers
Date: Tue,  6 Jun 2023 10:47:38 +0100
Message-Id: <20230606094814.3581397-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230606094814.3581397-1-peter.maydell@linaro.org>
References: <20230606094814.3581397-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

From: Vikram Garhwal <vikram.garhwal@amd.com>

Connect CANFD0 and CANFD1 on the Versal-virt machine and update xlnx-versal-virt
document with CANFD command line examples.

Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/xlnx-versal-virt.rst | 31 ++++++++++++++++
 include/hw/arm/xlnx-versal.h         | 12 +++++++
 hw/arm/xlnx-versal-virt.c            | 53 ++++++++++++++++++++++++++++
 hw/arm/xlnx-versal.c                 | 37 +++++++++++++++++++
 4 files changed, 133 insertions(+)

diff --git a/docs/system/arm/xlnx-versal-virt.rst b/docs/system/arm/xlnx-versal-virt.rst
index 92ad10d2da4..d2d1b266926 100644
--- a/docs/system/arm/xlnx-versal-virt.rst
+++ b/docs/system/arm/xlnx-versal-virt.rst
@@ -34,6 +34,7 @@ Implemented devices:
 - DDR memory
 - BBRAM (36 bytes of Battery-backed RAM)
 - eFUSE (3072 bytes of one-time field-programmable bit array)
+- 2 CANFDs
 
 QEMU does not yet model any other devices, including the PL and the AI Engine.
 
@@ -224,3 +225,33 @@ To use a different index value, N, from default of 1, add:
 
   Better yet, do not use actual product data when running guest image
   on this Xilinx Versal Virt board.
+
+Using CANFDs for Versal Virt
+""""""""""""""""""""""""""""
+Versal CANFD controller is developed based on SocketCAN and QEMU CAN bus
+implementation. Bus connection and socketCAN connection for each CAN module
+can be set through command lines.
+
+To connect both CANFD0 and CANFD1 on the same bus:
+
+.. code-block:: bash
+
+    -object can-bus,id=canbus -machine canbus0=canbus -machine canbus1=canbus
+
+To connect CANFD0 and CANFD1 to separate buses:
+
+.. code-block:: bash
+
+    -object can-bus,id=canbus0 -object can-bus,id=canbus1 \
+    -machine canbus0=canbus0 -machine canbus1=canbus1
+
+The SocketCAN interface can connect to a Physical or a Virtual CAN interfaces on
+the host machine. Please check this document to learn about CAN interface on
+Linux: docs/system/devices/can.rst
+
+To connect CANFD0 and CANFD1 to host machine's CAN interface can0:
+
+.. code-block:: bash
+
+    -object can-bus,id=canbus -machine canbus0=canbus -machine canbus1=canbus
+    -object can-host-socketcan,id=canhost0,if=can0,canbus=canbus
diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index b6786e9832d..39ee31185c3 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -31,6 +31,7 @@
 #include "hw/dma/xlnx_csu_dma.h"
 #include "hw/misc/xlnx-versal-crl.h"
 #include "hw/misc/xlnx-versal-pmc-iou-slcr.h"
+#include "hw/net/xlnx-versal-canfd.h"
 
 #define TYPE_XLNX_VERSAL "xlnx-versal"
 OBJECT_DECLARE_SIMPLE_TYPE(Versal, XLNX_VERSAL)
@@ -43,6 +44,8 @@ OBJECT_DECLARE_SIMPLE_TYPE(Versal, XLNX_VERSAL)
 #define XLNX_VERSAL_NR_SDS     2
 #define XLNX_VERSAL_NR_XRAM    4
 #define XLNX_VERSAL_NR_IRQS    192
+#define XLNX_VERSAL_NR_CANFD   2
+#define XLNX_VERSAL_CANFD_REF_CLK (24 * 1000 * 1000)
 
 struct Versal {
     /*< private >*/
@@ -73,6 +76,8 @@ struct Versal {
             CadenceGEMState gem[XLNX_VERSAL_NR_GEMS];
             XlnxZDMA adma[XLNX_VERSAL_NR_ADMAS];
             VersalUsb2 usb;
+            CanBusState *canbus[XLNX_VERSAL_NR_CANFD];
+            XlnxVersalCANFDState canfd[XLNX_VERSAL_NR_CANFD];
         } iou;
 
         /* Real-time Processing Unit.  */
@@ -133,6 +138,8 @@ struct Versal {
 #define VERSAL_CRL_IRQ             10
 #define VERSAL_UART0_IRQ_0         18
 #define VERSAL_UART1_IRQ_0         19
+#define VERSAL_CANFD0_IRQ_0        20
+#define VERSAL_CANFD1_IRQ_0        21
 #define VERSAL_USB0_IRQ_0          22
 #define VERSAL_GEM0_IRQ_0          56
 #define VERSAL_GEM0_WAKE_IRQ_0     57
@@ -163,6 +170,11 @@ struct Versal {
 #define MM_UART1                    0xff010000U
 #define MM_UART1_SIZE               0x10000
 
+#define MM_CANFD0                   0xff060000U
+#define MM_CANFD0_SIZE              0x10000
+#define MM_CANFD1                   0xff070000U
+#define MM_CANFD1_SIZE              0x10000
+
 #define MM_GEM0                     0xff0c0000U
 #define MM_GEM0_SIZE                0x10000
 #define MM_GEM1                     0xff0d0000U
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 668a9d65a43..1ee2b8697fe 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -40,9 +40,11 @@ struct VersalVirt {
         uint32_t clk_25Mhz;
         uint32_t usb;
         uint32_t dwc;
+        uint32_t canfd[2];
     } phandle;
     struct arm_boot_info binfo;
 
+    CanBusState *canbus[XLNX_VERSAL_NR_CANFD];
     struct {
         bool secure;
     } cfg;
@@ -235,6 +237,38 @@ static void fdt_add_uart_nodes(VersalVirt *s)
     }
 }
 
+static void fdt_add_canfd_nodes(VersalVirt *s)
+{
+    uint64_t addrs[] = { MM_CANFD1, MM_CANFD0 };
+    uint32_t size[] = { MM_CANFD1_SIZE, MM_CANFD0_SIZE };
+    unsigned int irqs[] = { VERSAL_CANFD1_IRQ_0, VERSAL_CANFD0_IRQ_0 };
+    const char clocknames[] = "can_clk\0s_axi_aclk";
+    int i;
+
+    /* Create and connect CANFD0 and CANFD1 nodes to canbus0. */
+    for (i = 0; i < ARRAY_SIZE(addrs); i++) {
+        char *name = g_strdup_printf("/canfd@%" PRIx64, addrs[i]);
+        qemu_fdt_add_subnode(s->fdt, name);
+
+        qemu_fdt_setprop_cell(s->fdt, name, "rx-fifo-depth", 0x40);
+        qemu_fdt_setprop_cell(s->fdt, name, "tx-mailbox-count", 0x20);
+
+        qemu_fdt_setprop_cells(s->fdt, name, "clocks",
+                               s->phandle.clk_25Mhz, s->phandle.clk_25Mhz);
+        qemu_fdt_setprop(s->fdt, name, "clock-names",
+                         clocknames, sizeof(clocknames));
+        qemu_fdt_setprop_cells(s->fdt, name, "interrupts",
+                               GIC_FDT_IRQ_TYPE_SPI, irqs[i],
+                               GIC_FDT_IRQ_FLAGS_LEVEL_HI);
+        qemu_fdt_setprop_sized_cells(s->fdt, name, "reg",
+                                     2, addrs[i], 2, size[i]);
+        qemu_fdt_setprop_string(s->fdt, name, "compatible",
+                                "xlnx,canfd-2.0");
+
+        g_free(name);
+    }
+}
+
 static void fdt_add_fixed_link_nodes(VersalVirt *s, char *gemname,
                                      uint32_t phandle)
 {
@@ -639,12 +673,17 @@ static void versal_virt_init(MachineState *machine)
                             TYPE_XLNX_VERSAL);
     object_property_set_link(OBJECT(&s->soc), "ddr", OBJECT(machine->ram),
                              &error_abort);
+    object_property_set_link(OBJECT(&s->soc), "canbus0", OBJECT(s->canbus[0]),
+                             &error_abort);
+    object_property_set_link(OBJECT(&s->soc), "canbus1", OBJECT(s->canbus[1]),
+                             &error_abort);
     sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
 
     fdt_create(s);
     create_virtio_regions(s);
     fdt_add_gem_nodes(s);
     fdt_add_uart_nodes(s);
+    fdt_add_canfd_nodes(s);
     fdt_add_gic_nodes(s);
     fdt_add_timer_nodes(s);
     fdt_add_zdma_nodes(s);
@@ -712,6 +751,20 @@ static void versal_virt_init(MachineState *machine)
 
 static void versal_virt_machine_instance_init(Object *obj)
 {
+    VersalVirt *s = XLNX_VERSAL_VIRT_MACHINE(obj);
+
+    /*
+     * User can set canbus0 and canbus1 properties to can-bus object and connect
+     * to socketcan(optional) interface via command line.
+     */
+    object_property_add_link(obj, "canbus0", TYPE_CAN_BUS,
+                             (Object **)&s->canbus[0],
+                             object_property_allow_set_link,
+                             0);
+    object_property_add_link(obj, "canbus1", TYPE_CAN_BUS,
+                             (Object **)&s->canbus[1],
+                             object_property_allow_set_link,
+                             0);
 }
 
 static void versal_virt_machine_class_init(ObjectClass *oc, void *data)
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 69b1b99e937..1594dd6c5c5 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -184,6 +184,38 @@ static void versal_create_uarts(Versal *s, qemu_irq *pic)
     }
 }
 
+static void versal_create_canfds(Versal *s, qemu_irq *pic)
+{
+    int i;
+    uint32_t irqs[] = { VERSAL_CANFD0_IRQ_0, VERSAL_CANFD1_IRQ_0};
+    uint64_t addrs[] = { MM_CANFD0, MM_CANFD1 };
+
+    for (i = 0; i < ARRAY_SIZE(s->lpd.iou.canfd); i++) {
+        char *name = g_strdup_printf("canfd%d", i);
+        SysBusDevice *sbd;
+        MemoryRegion *mr;
+
+        object_initialize_child(OBJECT(s), name, &s->lpd.iou.canfd[i],
+                                TYPE_XILINX_CANFD);
+        sbd = SYS_BUS_DEVICE(&s->lpd.iou.canfd[i]);
+
+        object_property_set_int(OBJECT(&s->lpd.iou.canfd[i]), "ext_clk_freq",
+                                XLNX_VERSAL_CANFD_REF_CLK , &error_abort);
+
+        object_property_set_link(OBJECT(&s->lpd.iou.canfd[i]), "canfdbus",
+                                 OBJECT(s->lpd.iou.canbus[i]),
+                                 &error_abort);
+
+        sysbus_realize(sbd, &error_fatal);
+
+        mr = sysbus_mmio_get_region(sbd, 0);
+        memory_region_add_subregion(&s->mr_ps, addrs[i], mr);
+
+        sysbus_connect_irq(sbd, 0, pic[irqs[i]]);
+        g_free(name);
+    }
+}
+
 static void versal_create_usbs(Versal *s, qemu_irq *pic)
 {
     DeviceState *dev;
@@ -718,6 +750,7 @@ static void versal_realize(DeviceState *dev, Error **errp)
     versal_create_apu_gic(s, pic);
     versal_create_rpu_cpus(s);
     versal_create_uarts(s, pic);
+    versal_create_canfds(s, pic);
     versal_create_usbs(s, pic);
     versal_create_gems(s, pic);
     versal_create_admas(s, pic);
@@ -757,6 +790,10 @@ static void versal_init(Object *obj)
 static Property versal_properties[] = {
     DEFINE_PROP_LINK("ddr", Versal, cfg.mr_ddr, TYPE_MEMORY_REGION,
                      MemoryRegion *),
+    DEFINE_PROP_LINK("canbus0", Versal, lpd.iou.canbus[0],
+                      TYPE_CAN_BUS, CanBusState *),
+    DEFINE_PROP_LINK("canbus1", Versal, lpd.iou.canbus[1],
+                      TYPE_CAN_BUS, CanBusState *),
     DEFINE_PROP_END_OF_LIST()
 };
 
-- 
2.34.1


