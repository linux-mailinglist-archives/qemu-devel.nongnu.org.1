Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E8CADC013
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Jun 2025 06:10:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRNdu-0003yD-AD; Tue, 17 Jun 2025 00:09:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyuquan1236@phytium.com.cn>)
 id 1uRNdf-0003rY-Qn
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 00:09:39 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wangyuquan1236@phytium.com.cn>) id 1uRNdd-0003bK-73
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 00:09:35 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwD3_7v76VBoiufrAg--.11358S2;
 Tue, 17 Jun 2025 12:07:23 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwAHmiPr6VBo5wZWAA--.5570S5;
 Tue, 17 Jun 2025 12:07:19 +0800 (CST)
From: wangyuquan <wangyuquan1236@phytium.com.cn>
To: jonathan.cameron@huawei.com, fan.ni@samsung.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
 Yuquan Wang <wangyuquan1236@phytium.com.cn>
Subject: [RFC PATCH v3 2/2] pci-host/cxl: Support creation of a new CXL Host
 Bridge
Date: Tue, 17 Jun 2025 12:06:49 +0800
Message-Id: <20250617040649.81303-3-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250617040649.81303-1-wangyuquan1236@phytium.com.cn>
References: <20250617040649.81303-1-wangyuquan1236@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwAHmiPr6VBo5wZWAA--.5570S5
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQADAWhPIu4E8QAbsG
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
 1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvAXoW3tFWUAF4UKF43Xr13Gw4UJwb_yoW8JFWDCo
 Wava4UZr48Gr4fAFy0kwnakr47CrWxKr4fXF4FkFWqk3W7Gws8t348tan3Aay3GF1ftr45
 WrWfC34akan7Jr18n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
 J3UbIjqfuFe4nvWSU8nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UU
 UUUUUUU==
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=wangyuquan1236@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Yuquan Wang <wangyuquan1236@phytium.com.cn>

Define a new CXL host bridge type (TYPE_CXL_HOST). This is an
independent CXL host bridge which combined GPEX features (ECAM, MMIO
windows and irq) and CXL Host Bridge Component Registers (CHBCR).

The root bus path of CXL_HOST is "0001:00", that would not affect the
original PCIe host topology on some platforms. In the previous, the
pxb-cxl-host with any CXL root ports and CXL endpoint devices would
share the resources (like BDF, MMIO space) of the original pcie
domain, but it would cause some platforms like sbsa-ref are unable to
support the original number of PCIe devices. The new type provides a
solution to resolve the problem.

Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
---
 hw/cxl/cxl-host-stubs.c               |   3 +
 hw/cxl/cxl-host.c                     |  64 ++++++++---
 hw/pci-host/Kconfig                   |   4 +
 hw/pci-host/cxl.c                     | 152 ++++++++++++++++++++++++++
 hw/pci-host/meson.build               |   1 +
 include/hw/cxl/cxl.h                  |   7 +-
 include/hw/cxl/cxl_host.h             |   3 +
 include/hw/pci-host/cxl_host_bridge.h |  23 ++++
 8 files changed, 240 insertions(+), 17 deletions(-)
 create mode 100644 hw/pci-host/cxl.c
 create mode 100644 include/hw/pci-host/cxl_host_bridge.h

diff --git a/hw/cxl/cxl-host-stubs.c b/hw/cxl/cxl-host-stubs.c
index cae4afcdde..2131331af1 100644
--- a/hw/cxl/cxl-host-stubs.c
+++ b/hw/cxl/cxl-host-stubs.c
@@ -11,5 +11,8 @@
 void cxl_fmws_link_targets(CXLState *stat, Error **errp) {};
 void cxl_machine_init(Object *obj, CXLState *state) {};
 void cxl_hook_up_pxb_registers(PCIBus *bus, CXLState *state, Error **errp) {};
+void cxl_fixed_memory_window_config(CXLState *cxl_state,
+                                    CXLFixedMemoryWindowOptions *object,
+                                    Error **errp) {};
 
 const MemoryRegionOps cfmws_ops;
diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index e010163174..fe7545abc1 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -16,15 +16,17 @@
 #include "qapi/qapi-visit-machine.h"
 #include "hw/cxl/cxl.h"
 #include "hw/cxl/cxl_host.h"
+#include "hw/irq.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pci_host.h"
 #include "hw/pci/pcie_port.h"
 #include "hw/pci-bridge/pci_expander_bridge.h"
+#include "hw/pci-host/cxl_host_bridge.h"
 
-static void cxl_fixed_memory_window_config(CXLState *cxl_state,
-                                           CXLFixedMemoryWindowOptions *object,
-                                           Error **errp)
+void cxl_fixed_memory_window_config(CXLState *cxl_state,
+                                    CXLFixedMemoryWindowOptions *object,
+                                    Error **errp)
 {
     ERRP_GUARD();
     g_autofree CXLFixedWindow *fw = g_malloc0(sizeof(*fw));
@@ -83,14 +85,16 @@ void cxl_fmws_link_targets(CXLState *cxl_state, Error **errp)
                 bool ambig;
 
                 o = object_resolve_path_type(fw->targets[i],
-                                             TYPE_PXB_CXL_DEV,
-                                             &ambig);
-                if (!o) {
+                                             TYPE_DEVICE, &ambig);
+
+                if (object_dynamic_cast(o, TYPE_PXB_CXL_DEV) ||
+                    object_dynamic_cast(o, TYPE_CXL_HOST)) {
+                    fw->target_hbs[i] = o;
+                } else {
                     error_setg(errp, "Could not resolve CXLFM target %s",
                                fw->targets[i]);
                     return;
                 }
-                fw->target_hbs[i] = PXB_CXL_DEV(o);
             }
         }
     }
@@ -153,6 +157,7 @@ static bool cxl_hdm_find_target(uint32_t *cache_mem, hwaddr addr,
 static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr)
 {
     CXLComponentState *hb_cstate, *usp_cstate;
+    CXLHostBridge *cxlhost;
     PCIHostState *hb;
     CXLUpstreamPort *usp;
     int rb_index;
@@ -160,23 +165,50 @@ static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr)
     uint8_t target;
     bool target_found;
     PCIDevice *rp, *d;
+    Object *o;
 
     /* Address is relative to memory region. Convert to HPA */
     addr += fw->base;
 
     rb_index = (addr / cxl_decode_ig(fw->enc_int_gran)) % fw->num_targets;
-    hb = PCI_HOST_BRIDGE(fw->target_hbs[rb_index]->cxl_host_bridge);
-    if (!hb || !hb->bus || !pci_bus_is_cxl(hb->bus)) {
-        return NULL;
-    }
-
-    if (cxl_get_hb_passthrough(hb)) {
-        rp = pcie_find_port_first(hb->bus);
-        if (!rp) {
+    o = fw->target_hbs[rb_index];
+    if (object_dynamic_cast(o, TYPE_PXB_CXL_DEV)) {
+        hb = PCI_HOST_BRIDGE(PXB_CXL_DEV(o)->cxl_host_bridge);
+        if (!hb || !hb->bus || !pci_bus_is_cxl(hb->bus)) {
             return NULL;
         }
+
+        if (cxl_get_hb_passthrough(hb)) {
+            rp = pcie_find_port_first(hb->bus);
+            if (!rp) {
+                return NULL;
+            }
+        } else {
+            hb_cstate = cxl_get_hb_cstate(hb);
+            if (!hb_cstate) {
+                return NULL;
+            }
+
+            cache_mem = hb_cstate->crb.cache_mem_registers;
+
+            target_found = cxl_hdm_find_target(cache_mem, addr, &target);
+            if (!target_found) {
+                return NULL;
+            }
+
+            rp = pcie_find_port_by_pn(hb->bus, target);
+            if (!rp) {
+                return NULL;
+            }
+        }
     } else {
-        hb_cstate = cxl_get_hb_cstate(hb);
+        hb = PCI_HOST_BRIDGE(o);
+        if (!hb || !hb->bus || !pci_bus_is_cxl(hb->bus)) {
+            return NULL;
+        }
+
+        cxlhost = CXL_HOST(hb);
+        hb_cstate = &cxlhost->cxl_cstate;
         if (!hb_cstate) {
             return NULL;
         }
diff --git a/hw/pci-host/Kconfig b/hw/pci-host/Kconfig
index 35c0415242..05c772bcf4 100644
--- a/hw/pci-host/Kconfig
+++ b/hw/pci-host/Kconfig
@@ -74,6 +74,10 @@ config PCI_POWERNV
     select MSI_NONBROKEN
     select PCIE_PORT
 
+config CXL_HOST_BRIDGE
+    bool
+    select PCI_EXPRESS
+
 config REMOTE_PCIHOST
     bool
 
diff --git a/hw/pci-host/cxl.c b/hw/pci-host/cxl.c
new file mode 100644
index 0000000000..74c8c83314
--- /dev/null
+++ b/hw/pci-host/cxl.c
@@ -0,0 +1,152 @@
+/*
+ * QEMU CXL Host Bridge Emulation
+ *
+ * Copyright (C) 2025, Phytium Technology Co, Ltd. All rights reserved.
+ *
+ * Based on gpex.c
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/pci/pci_bus.h"
+#include "hw/pci-host/cxl_host_bridge.h"
+
+static void cxl_host_set_irq(void *opaque, int irq_num, int level)
+{
+    CXLHostBridge *host = opaque;
+
+    qemu_set_irq(host->irq[irq_num], level);
+}
+
+int cxl_host_set_irq_num(CXLHostBridge *host, int index, int gsi)
+{
+    if (index >= PCI_NUM_PINS) {
+        return -EINVAL;
+    }
+
+    host->irq_num[index] = gsi;
+    return 0;
+}
+
+static PCIINTxRoute cxl_host_route_intx_pin_to_irq(void *opaque, int pin)
+{
+    PCIINTxRoute route;
+    CXLHostBridge *host = opaque;
+    int gsi = host->irq_num[pin];
+
+    route.irq = gsi;
+    if (gsi < 0) {
+        route.mode = PCI_INTX_DISABLED;
+    } else {
+        route.mode = PCI_INTX_ENABLED;
+    }
+
+    return route;
+}
+
+static const char *cxl_host_root_bus_path(PCIHostState *host_bridge,
+                                          PCIBus *rootbus)
+{
+    return "0001:00";
+}
+
+void cxl_host_hook_up_registers(CXLState *cxl_state, CXLHostBridge *host)
+{
+    CXLComponentState *cxl_cstate = &host->cxl_cstate;
+    struct MemoryRegion *mr = &cxl_cstate->crb.component_registers;
+
+    memory_region_add_subregion(&cxl_state->host_mr, 0, mr);
+}
+
+static void cxl_host_reset(CXLHostBridge *host)
+{
+    CXLComponentState *cxl_cstate = &host->cxl_cstate;
+    uint32_t *reg_state = cxl_cstate->crb.cache_mem_registers;
+    uint32_t *write_msk = cxl_cstate->crb.cache_mem_regs_write_mask;
+
+    cxl_component_register_init_common(reg_state, write_msk, CXL2_RC);
+
+    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, TARGET_COUNT,
+                     8);
+}
+
+static void cxl_host_realize(DeviceState *dev, Error **errp)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    CXLHostBridge *host = CXL_HOST(dev);
+    CXLComponentState *cxl_cstate = &host->cxl_cstate;
+    struct MemoryRegion *mr = &cxl_cstate->crb.component_registers;
+    PCIHostState *pci = PCI_HOST_BRIDGE(dev);
+    PCIExpressHost *pex = PCIE_HOST_BRIDGE(dev);
+    PCIBus *cxlbus;
+    int i;
+
+    cxl_host_reset(host);
+    cxl_component_register_block_init(OBJECT(dev), cxl_cstate, TYPE_CXL_HOST);
+    sysbus_init_mmio(sbd, mr);
+
+    pcie_host_mmcfg_init(pex, PCIE_MMCFG_SIZE_MAX);
+    sysbus_init_mmio(sbd, &pex->mmio);
+
+    memory_region_init(&host->io_mmio, OBJECT(host), "cxl_host_mmio",
+                        UINT64_MAX);
+
+    memory_region_init_io(&host->io_mmio_window, OBJECT(host),
+                              &unassigned_io_ops, OBJECT(host),
+                              "cxl_host_mmio_window", UINT64_MAX);
+
+    memory_region_add_subregion(&host->io_mmio_window, 0, &host->io_mmio);
+    sysbus_init_mmio(sbd, &host->io_mmio_window);
+
+    /* ioport window init, 64K is the legacy size in x86 */
+    memory_region_init(&host->io_ioport, OBJECT(host), "cxl_host_ioport",
+                        64 * 1024);
+
+    memory_region_init_io(&host->io_ioport_window, OBJECT(host),
+                              &unassigned_io_ops, OBJECT(host),
+                              "cxl_host_ioport_window", 64 * 1024);
+
+    memory_region_add_subregion(&host->io_ioport_window, 0, &host->io_ioport);
+    sysbus_init_mmio(sbd, &host->io_ioport_window);
+
+    /* PCIe host bridge use 4 legacy IRQ lines */
+    for (i = 0; i < PCI_NUM_PINS; i++) {
+        sysbus_init_irq(sbd, &host->irq[i]);
+        host->irq_num[i] = -1;
+    }
+
+    pci->bus = pci_register_root_bus(dev, "cxlhost.0", cxl_host_set_irq,
+                                 pci_swizzle_map_irq_fn, host, &host->io_mmio,
+                                 &host->io_ioport, 0, 4, TYPE_CXL_BUS);
+    cxlbus = pci->bus;
+    cxlbus->flags |= PCI_BUS_CXL;
+
+    pci_bus_set_route_irq_fn(pci->bus, cxl_host_route_intx_pin_to_irq);
+}
+
+static void cxl_host_class_init(ObjectClass *class, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(class);
+    PCIHostBridgeClass *hc = PCI_HOST_BRIDGE_CLASS(class);
+
+    hc->root_bus_path = cxl_host_root_bus_path;
+    dc->realize = cxl_host_realize;
+    dc->desc = "CXL Host Bridge";
+    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
+    dc->fw_name = "cxl";
+}
+
+static const TypeInfo cxl_host_info = {
+    .name          = TYPE_CXL_HOST,
+    .parent        = TYPE_PCIE_HOST_BRIDGE,
+    .instance_size = sizeof(CXLHostBridge),
+    .class_init    = cxl_host_class_init,
+};
+
+static void cxl_host_register(void)
+{
+    type_register_static(&cxl_host_info);
+}
+
+type_init(cxl_host_register)
diff --git a/hw/pci-host/meson.build b/hw/pci-host/meson.build
index 937a0f72ac..030672373d 100644
--- a/hw/pci-host/meson.build
+++ b/hw/pci-host/meson.build
@@ -4,6 +4,7 @@ pci_ss.add(when: 'CONFIG_PCI_BONITO', if_true: files('bonito.c'))
 pci_ss.add(when: 'CONFIG_GT64120', if_true: files('gt64120.c'))
 pci_ss.add(when: 'CONFIG_PCI_EXPRESS_DESIGNWARE', if_true: files('designware.c'))
 pci_ss.add(when: 'CONFIG_PCI_EXPRESS_GENERIC_BRIDGE', if_true: files('gpex.c'))
+pci_ss.add(when: 'CONFIG_CXL_HOST_BRIDGE', if_true: files('cxl.c'))
 pci_ss.add(when: ['CONFIG_PCI_EXPRESS_GENERIC_BRIDGE', 'CONFIG_ACPI'], if_true: files('gpex-acpi.c'))
 pci_ss.add(when: 'CONFIG_PCI_EXPRESS_Q35', if_true: files('q35.c'))
 pci_ss.add(when: 'CONFIG_PCI_EXPRESS_XILINX', if_true: files('xilinx-pcie.c'))
diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
index 75e47b6864..346a7b58ad 100644
--- a/include/hw/cxl/cxl.h
+++ b/include/hw/cxl/cxl.h
@@ -26,10 +26,12 @@
 
 typedef struct PXBCXLDev PXBCXLDev;
 
+typedef struct CXLHostBridge CXLHostBridge;
+
 typedef struct CXLFixedWindow {
     uint64_t size;
     char **targets;
-    PXBCXLDev *target_hbs[16];
+    Object *target_hbs[16];
     uint8_t num_targets;
     uint8_t enc_int_ways;
     uint8_t enc_int_gran;
@@ -56,6 +58,9 @@ struct CXLHost {
 #define TYPE_PXB_CXL_HOST "pxb-cxl-host"
 OBJECT_DECLARE_SIMPLE_TYPE(CXLHost, PXB_CXL_HOST)
 
+#define TYPE_CXL_HOST "cxl-host"
+OBJECT_DECLARE_SIMPLE_TYPE(CXLHostBridge, CXL_HOST)
+
 #define TYPE_CXL_USP "cxl-upstream"
 
 typedef struct CXLUpstreamPort CXLUpstreamPort;
diff --git a/include/hw/cxl/cxl_host.h b/include/hw/cxl/cxl_host.h
index c9bc9c7c50..6aeb0507de 100644
--- a/include/hw/cxl/cxl_host.h
+++ b/include/hw/cxl/cxl_host.h
@@ -16,6 +16,9 @@
 void cxl_machine_init(Object *obj, CXLState *state);
 void cxl_fmws_link_targets(CXLState *stat, Error **errp);
 void cxl_hook_up_pxb_registers(PCIBus *bus, CXLState *state, Error **errp);
+void cxl_fixed_memory_window_config(CXLState *cxl_state,
+                                    CXLFixedMemoryWindowOptions *object,
+                                    Error **errp);
 
 extern const MemoryRegionOps cfmws_ops;
 
diff --git a/include/hw/pci-host/cxl_host_bridge.h b/include/hw/pci-host/cxl_host_bridge.h
new file mode 100644
index 0000000000..833e460f01
--- /dev/null
+++ b/include/hw/pci-host/cxl_host_bridge.h
@@ -0,0 +1,23 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "hw/cxl/cxl.h"
+#include "hw/irq.h"
+#include "hw/pci/pcie_host.h"
+
+typedef struct CXLHostBridge {
+    PCIExpressHost parent_obj;
+
+    CXLComponentState cxl_cstate;
+
+    MemoryRegion io_ioport;
+    MemoryRegion io_mmio;
+    MemoryRegion io_ioport_window;
+    MemoryRegion io_mmio_window;
+    qemu_irq irq[PCI_NUM_PINS];
+    int irq_num[PCI_NUM_PINS];
+} CXLHostBridge;
+
+int cxl_host_set_irq_num(CXLHostBridge *host, int index, int gsi);
+void cxl_host_hook_up_registers(CXLState *cxl_state, CXLHostBridge *host);
-- 
2.34.1


