Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24574B52A0D
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Sep 2025 09:33:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwbhF-0007pE-Ph; Thu, 11 Sep 2025 03:26:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uwbgT-0007gW-Dz; Thu, 11 Sep 2025 03:25:35 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uwbgQ-0000j4-Qh; Thu, 11 Sep 2025 03:25:33 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 11 Sep
 2025 15:24:54 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 11 Sep 2025 15:24:54 +0800
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "Michael S. Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, "open list:ARM TCG CPUs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <nabihestefan@google.com>, <wuhaotsh@google.com>, <titusr@google.com>
Subject: [PATCH v2 05/14] hw/pci-host/aspeed: Add AST2600 PCIe Root Port and
 make address configurable
Date: Thu, 11 Sep 2025 15:24:29 +0800
Message-ID: <20250911072452.314553-6-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250911072452.314553-1-jamin_lin@aspeedtech.com>
References: <20250911072452.314553-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Introduce an ASPEED PCIe Root Port and wire it under the RC. The root port
is modeled as TYPE_ASPEED_PCIE_ROOT_PORT (subclass of TYPE_PCIE_ROOT_PORT).

Key changes:
- Add TYPE_ASPEED_PCIE_ROOT_PORT (PCIESlot-based) with vendor/device IDs
  and AER capability offset.
- Extend AspeedPCIERcState to embed a root_port instance and a
  configurable rp_addr.
- Add "rp-addr" property to the RC to place the root port at a specific
  devfn on the root bus.
- Set the root port's "chassis" property to ensure a unique chassis per RC.
- Extend AspeedPCIECfgClass with rc_rp_addr defaulting to PCI_DEVFN(8,0).

Rationale:
- AST2600 places the root port at 80:08.0 (bus 0x80, dev 8, fn 0).
- AST2700 must place the root port at 00:00.0, and it supports three RCs.
  Each root port must therefore be uniquely identifiable; uses the
  PCIe "chassis" ID for that.
- Providing a configurable "rp-addr" lets platforms select the correct
  devfn per SoC family, while the "chassis" property ensures uniqueness
  across multiple RC instances on AST2700.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 include/hw/pci-host/aspeed_pcie.h | 11 +++++++
 hw/pci-host/aspeed_pcie.c         | 48 +++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/include/hw/pci-host/aspeed_pcie.h b/include/hw/pci-host/aspeed_pcie.h
index e7c231e847..4026d5b4c5 100644
--- a/include/hw/pci-host/aspeed_pcie.h
+++ b/include/hw/pci-host/aspeed_pcie.h
@@ -22,6 +22,7 @@
 #include "hw/sysbus.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pcie_host.h"
+#include "hw/pci/pcie_port.h"
 #include "qom/object.h"
 
 typedef struct AspeedPCIECfgTxDesc {
@@ -42,6 +43,13 @@ typedef struct AspeedPCIERegMap {
     AspeedPCIERcRegs rc;
 } AspeedPCIERegMap;
 
+#define TYPE_ASPEED_PCIE_ROOT_PORT "aspeed.pcie-root-port"
+OBJECT_DECLARE_SIMPLE_TYPE(AspeedPCIERootPortState, ASPEED_PCIE_ROOT_PORT)
+
+typedef struct AspeedPCIERootPortState {
+    PCIESlot parent_obj;
+} AspeedPCIERootPortState;
+
 #define TYPE_ASPEED_PCIE_ROOT_DEVICE "aspeed.pcie-root-device"
 OBJECT_DECLARE_SIMPLE_TYPE(AspeedPCIERootDeviceState, ASPEED_PCIE_ROOT_DEVICE);
 
@@ -60,12 +68,14 @@ struct AspeedPCIERcState {
     MemoryRegion mmio;
     MemoryRegion io;
 
+    uint32_t rp_addr;
     uint32_t bus_nr;
     char name[16];
     bool has_rd;
     qemu_irq irq;
 
     AspeedPCIERootDeviceState root_device;
+    AspeedPCIERootPortState root_port;
 };
 
 /* Bridge between AHB bus and PCIe RC. */
@@ -88,6 +98,7 @@ struct AspeedPCIECfgClass {
     const AspeedPCIERegMap *reg_map;
     const MemoryRegionOps *reg_ops;
 
+    uint32_t rc_rp_addr;
     uint64_t rc_bus_nr;
     uint64_t nr_regs;
     bool rc_has_rd;
diff --git a/hw/pci-host/aspeed_pcie.c b/hw/pci-host/aspeed_pcie.c
index fa8854fe7a..3f04f0d379 100644
--- a/hw/pci-host/aspeed_pcie.c
+++ b/hw/pci-host/aspeed_pcie.c
@@ -23,6 +23,7 @@
 #include "hw/registerfields.h"
 #include "hw/irq.h"
 #include "hw/pci/pci_host.h"
+#include "hw/pci/pcie_port.h"
 #include "hw/pci-host/aspeed_pcie.h"
 #include "hw/pci/msi.h"
 #include "trace.h"
@@ -65,6 +66,32 @@ static const TypeInfo aspeed_pcie_root_device_info = {
     },
 };
 
+/*
+ * PCIe Root Port
+ */
+
+static void aspeed_pcie_root_port_class_init(ObjectClass *klass,
+                                             const void *data)
+{
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIERootPortClass *rpc = PCIE_ROOT_PORT_CLASS(klass);
+
+    dc->desc = "ASPEED PCIe Root Port";
+    k->vendor_id = PCI_VENDOR_ID_ASPEED;
+    k->device_id = 0x1150;
+    dc->user_creatable = true;
+
+    rpc->aer_offset = 0x100;
+}
+
+static const TypeInfo aspeed_pcie_root_port_info = {
+    .name = TYPE_ASPEED_PCIE_ROOT_PORT,
+    .parent = TYPE_PCIE_ROOT_PORT,
+    .instance_size = sizeof(AspeedPCIERootPortState),
+    .class_init = aspeed_pcie_root_port_class_init,
+};
+
 /*
  * PCIe Root Complex (RC)
  */
@@ -144,6 +171,11 @@ static void aspeed_pcie_rc_realize(DeviceState *dev, Error **errp)
         qdev_prop_set_bit(DEVICE(&rc->root_device), "multifunction", false);
         qdev_realize(DEVICE(&rc->root_device), BUS(pci->bus), &error_fatal);
     }
+
+    /* setup root port */
+    qdev_prop_set_int32(DEVICE(&rc->root_port), "addr", rc->rp_addr);
+    qdev_prop_set_uint16(DEVICE(&rc->root_port), "chassis", cfg->id);
+    qdev_realize(DEVICE(&rc->root_port), BUS(pci->bus), &error_fatal);
 }
 
 static const char *aspeed_pcie_rc_root_bus_path(PCIHostState *host_bridge,
@@ -158,9 +190,19 @@ static const char *aspeed_pcie_rc_root_bus_path(PCIHostState *host_bridge,
     return rc->name;
 }
 
+static void aspeed_pcie_rc_instance_init(Object *obj)
+{
+    AspeedPCIERcState *rc = ASPEED_PCIE_RC(obj);
+    AspeedPCIERootPortState *root_port = &rc->root_port;
+
+    object_initialize_child(obj, "root_port", root_port,
+                            TYPE_ASPEED_PCIE_ROOT_PORT);
+}
+
 static const Property aspeed_pcie_rc_props[] = {
     DEFINE_PROP_UINT32("bus-nr", AspeedPCIERcState, bus_nr, 0),
     DEFINE_PROP_BOOL("has-rd", AspeedPCIERcState, has_rd, 0),
+    DEFINE_PROP_UINT32("rp-addr", AspeedPCIERcState, rp_addr, 0),
 };
 
 static void aspeed_pcie_rc_class_init(ObjectClass *klass, const void *data)
@@ -183,6 +225,7 @@ static const TypeInfo aspeed_pcie_rc_info = {
     .name = TYPE_ASPEED_PCIE_RC,
     .parent = TYPE_PCIE_HOST_BRIDGE,
     .instance_size = sizeof(AspeedPCIERcState),
+    .instance_init = aspeed_pcie_rc_instance_init,
     .class_init = aspeed_pcie_rc_class_init,
 };
 
@@ -456,6 +499,9 @@ static void aspeed_pcie_cfg_realize(DeviceState *dev, Error **errp)
     object_property_set_bool(OBJECT(&s->rc), "has-rd",
                             apc->rc_has_rd,
                             &error_abort);
+    object_property_set_int(OBJECT(&s->rc), "rp-addr",
+                            apc->rc_rp_addr,
+                            &error_abort);
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->rc), errp)) {
         return;
     }
@@ -489,6 +535,7 @@ static void aspeed_pcie_cfg_class_init(ObjectClass *klass, const void *data)
     apc->nr_regs = 0x100 >> 2;
     apc->rc_bus_nr = 0x80;
     apc->rc_has_rd = true;
+    apc->rc_rp_addr = PCI_DEVFN(8, 0);
 }
 
 static const TypeInfo aspeed_pcie_cfg_info = {
@@ -627,6 +674,7 @@ static void aspeed_pcie_register_types(void)
 {
     type_register_static(&aspeed_pcie_rc_info);
     type_register_static(&aspeed_pcie_root_device_info);
+    type_register_static(&aspeed_pcie_root_port_info);
     type_register_static(&aspeed_pcie_cfg_info);
     type_register_static(&aspeed_pcie_phy_info);
 }
-- 
2.43.0


