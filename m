Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 715C57D3BE4
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 18:11:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quxWk-0005Ta-7G; Mon, 23 Oct 2023 12:11:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1quxWN-0005Bi-3R
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 12:11:18 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1quxWJ-0001vG-T7
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 12:11:14 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SDg7n15z0z6JB9R;
 Tue, 24 Oct 2023 00:07:33 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 23 Oct 2023 17:11:08 +0100
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, Michael Tsirkin
 <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
CC: <linuxarm@huawei.com>, Fan Ni <fan.ni@samsung.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Gregory Price
 <gregory.price@memverge.com>, Davidlohr Bueso <dave@stgolabs.net>, Klaus
 Jensen <its@irrelevant.dk>, Corey Minyard <cminyard@mvista.com>
Subject: [PATCH v2 06/17] hw/cxl: Add a switch mailbox CCI function
Date: Mon, 23 Oct 2023 17:07:55 +0100
Message-ID: <20231023160806.13206-7-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231023160806.13206-1-Jonathan.Cameron@huawei.com>
References: <20231023160806.13206-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

CXL switch CCIs were added in CXL r3.0. They are a PCI function,
identified by class code that provides a CXL mailbox (identical
to that previously defined for CXL type 3 memory devices) over which
various FM-API commands may be used. Whilst the intent of this
feature is enable switch control from a BMC attached to a switch
upstream port, it is also useful to allow emulation of this feature
on the upstream port connected to a host using the CXL devices as
this greatly simplifies testing.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v2: Fixed wrong assumption that the second number in cxl_cmd
    was expected return length  - it's Effects Bitmap.
    Patch reorg effects, some commands now introduced in later patches.
---
 include/hw/cxl/cxl_component.h            |   3 +-
 include/hw/cxl/cxl_device.h               |  15 +++
 include/hw/pci-bridge/cxl_upstream_port.h |   1 +
 hw/cxl/cxl-device-utils.c                 |  27 ++++++
 hw/cxl/cxl-mailbox-utils.c                |  18 ++++
 hw/cxl/switch-mailbox-cci.c               | 111 ++++++++++++++++++++++
 hw/cxl/meson.build                        |   1 +
 7 files changed, 175 insertions(+), 1 deletion(-)

diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
index e52dd8d2b9..5227a8e833 100644
--- a/include/hw/cxl/cxl_component.h
+++ b/include/hw/cxl/cxl_component.h
@@ -26,7 +26,8 @@ enum reg_type {
     CXL2_LOGICAL_DEVICE,
     CXL2_ROOT_PORT,
     CXL2_UPSTREAM_PORT,
-    CXL2_DOWNSTREAM_PORT
+    CXL2_DOWNSTREAM_PORT,
+    CXL3_SWITCH_MAILBOX_CCI,
 };
 
 /*
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 6f8040b5ff..fa73ed03e5 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -211,8 +211,10 @@ void cxl_device_register_block_init(Object *obj, CXLDeviceState *dev,
                                     CXLCCI *cci);
 
 typedef struct CXLType3Dev CXLType3Dev;
+typedef struct CSWMBCCIDev CSWMBCCIDev;
 /* Set up default values for the register block */
 void cxl_device_register_init_t3(CXLType3Dev *ct3d);
+void cxl_device_register_init_swcci(CSWMBCCIDev *sw);
 
 /*
  * CXL 2.0 - 8.2.8.1 including errata F4
@@ -259,6 +261,8 @@ CXL_DEVICE_CAPABILITY_HEADER_REGISTER(MEMORY_DEVICE,
                                           CXL_DEVICE_CAP_REG_SIZE * 2)
 
 void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max);
+void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
+                                  DeviceState *d, size_t payload_max);
 void cxl_init_cci(CXLCCI *cci, size_t payload_max);
 int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
                             size_t len_in, uint8_t *pl_in,
@@ -397,6 +401,17 @@ struct CXLType3Class {
                           uint8_t *data);
 };
 
+struct CSWMBCCIDev {
+    PCIDevice parent_obj;
+    PCIDevice *target;
+    CXLComponentState cxl_cstate;
+    CXLDeviceState cxl_dstate;
+    CXLCCI *cci;
+};
+
+#define TYPE_CXL_SWITCH_MAILBOX_CCI "cxl-switch-mailbox-cci"
+OBJECT_DECLARE_TYPE(CSWMBCCIDev, CSWMBCCIClass, CXL_SWITCH_MAILBOX_CCI)
+
 MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
                            unsigned size, MemTxAttrs attrs);
 MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
diff --git a/include/hw/pci-bridge/cxl_upstream_port.h b/include/hw/pci-bridge/cxl_upstream_port.h
index b02aa8f659..12635139f6 100644
--- a/include/hw/pci-bridge/cxl_upstream_port.h
+++ b/include/hw/pci-bridge/cxl_upstream_port.h
@@ -11,6 +11,7 @@ typedef struct CXLUpstreamPort {
 
     /*< public >*/
     CXLComponentState cxl_cstate;
+    CXLCCI swcci;
     DOECap doe_cdat;
     uint64_t sn;
 } CXLUpstreamPort;
diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
index eb86634250..f8938678c7 100644
--- a/hw/cxl/cxl-device-utils.c
+++ b/hw/cxl/cxl-device-utils.c
@@ -67,6 +67,9 @@ static uint64_t mailbox_reg_read(void *opaque, hwaddr offset, unsigned size)
 
     if (object_dynamic_cast(OBJECT(cci->intf), TYPE_CXL_TYPE3)) {
         cxl_dstate = &CXL_TYPE3(cci->intf)->cxl_dstate;
+    } else if (object_dynamic_cast(OBJECT(cci->intf),
+                                   TYPE_CXL_SWITCH_MAILBOX_CCI)) {
+        cxl_dstate = &CXL_SWITCH_MAILBOX_CCI(cci->intf)->cxl_dstate;
     } else {
         return 0;
     }
@@ -135,6 +138,9 @@ static void mailbox_reg_write(void *opaque, hwaddr offset, uint64_t value,
 
     if (object_dynamic_cast(OBJECT(cci->intf), TYPE_CXL_TYPE3)) {
         cxl_dstate = &CXL_TYPE3(cci->intf)->cxl_dstate;
+    } else if (object_dynamic_cast(OBJECT(cci->intf),
+                                   TYPE_CXL_SWITCH_MAILBOX_CCI)) {
+        cxl_dstate = &CXL_SWITCH_MAILBOX_CCI(cci->intf)->cxl_dstate;
     } else {
         return;
     }
@@ -365,6 +371,27 @@ void cxl_device_register_init_t3(CXLType3Dev *ct3d)
                               CXL_MAILBOX_MAX_PAYLOAD_SIZE);
 }
 
+void cxl_device_register_init_swcci(CSWMBCCIDev *sw)
+{
+    CXLDeviceState *cxl_dstate = &sw->cxl_dstate;
+    uint64_t *cap_h = cxl_dstate->caps_reg_state64;
+    const int cap_count = 3;
+
+    /* CXL Device Capabilities Array Register */
+    ARRAY_FIELD_DP64(cap_h, CXL_DEV_CAP_ARRAY, CAP_ID, 0);
+    ARRAY_FIELD_DP64(cap_h, CXL_DEV_CAP_ARRAY, CAP_VERSION, 1);
+    ARRAY_FIELD_DP64(cap_h, CXL_DEV_CAP_ARRAY, CAP_COUNT, cap_count);
+
+    cxl_device_cap_init(cxl_dstate, DEVICE_STATUS, 1, 2);
+    device_reg_init_common(cxl_dstate);
+
+    cxl_device_cap_init(cxl_dstate, MAILBOX, 2, 1);
+    mailbox_reg_init_common(cxl_dstate);
+
+    cxl_device_cap_init(cxl_dstate, MEMORY_DEVICE, 0x4000, 1);
+    memdev_reg_init_common(cxl_dstate);
+}
+
 uint64_t cxl_device_get_timestamp(CXLDeviceState *cxl_dstate)
 {
     uint64_t time, delta;
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 239acc659d..28ea02fcbe 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -754,6 +754,15 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
         cmd_media_clear_poison, 72, 0 },
 };
 
+static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
+    [TIMESTAMP][GET] = { "TIMESTAMP_GET", cmd_timestamp_get, 0, 0 },
+    [TIMESTAMP][SET] = { "TIMESTAMP_SET", cmd_timestamp_set, 0,
+                         IMMEDIATE_POLICY_CHANGE },
+    [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported, 0,
+                              0 },
+    [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
+};
+
 int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
                             size_t len_in, uint8_t *pl_in, size_t *len_out,
                             uint8_t *pl_out, bool *bg_started)
@@ -795,6 +804,15 @@ void cxl_init_cci(CXLCCI *cci, size_t payload_max)
     }
 }
 
+void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
+                                  DeviceState *d, size_t payload_max)
+{
+    cci->cxl_cmd_set = cxl_cmd_set_sw;
+    cci->d = d;
+    cci->intf = intf;
+    cxl_init_cci(cci, payload_max);
+}
+
 void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max)
 {
     cci->cxl_cmd_set = cxl_cmd_set;
diff --git a/hw/cxl/switch-mailbox-cci.c b/hw/cxl/switch-mailbox-cci.c
new file mode 100644
index 0000000000..ba399c6240
--- /dev/null
+++ b/hw/cxl/switch-mailbox-cci.c
@@ -0,0 +1,111 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Emulation of a CXL Switch Mailbox CCI PCIe function.
+ *
+ * Copyright (c) 2023 Huawei Technologies.
+ *
+ * From www.computeexpresslink.org
+ * Compute Express Link (CXL) Specification revision 3.0 Version 1.0
+ */
+#include "qemu/osdep.h"
+#include "hw/pci/pci.h"
+#include "hw/pci-bridge/cxl_upstream_port.h"
+#include "qapi/error.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "hw/qdev-properties.h"
+#include "hw/cxl/cxl.h"
+
+static void cswmbcci_reset(DeviceState *dev)
+{
+    CSWMBCCIDev *cswmb = CXL_SWITCH_MAILBOX_CCI(dev);
+    cxl_device_register_init_swcci(cswmb);
+}
+
+static void cswbcci_realize(PCIDevice *pci_dev, Error **errp)
+{
+    CSWMBCCIDev *cswmb = CXL_SWITCH_MAILBOX_CCI(pci_dev);
+    CXLComponentState *cxl_cstate = &cswmb->cxl_cstate;
+    CXLDeviceState *cxl_dstate = &cswmb->cxl_dstate;
+    CXLDVSECRegisterLocator *regloc_dvsec;
+    CXLUpstreamPort *usp;
+
+    if (!cswmb->target) {
+        error_setg(errp, "Target not set");
+        return;
+    }
+    usp = CXL_USP(cswmb->target);
+
+    pcie_endpoint_cap_init(pci_dev, 0x80);
+    cxl_cstate->dvsec_offset = 0x100;
+    cxl_cstate->pdev = pci_dev;
+    cswmb->cci = &usp->swcci;
+    cxl_device_register_block_init(OBJECT(pci_dev), cxl_dstate, cswmb->cci);
+    pci_register_bar(pci_dev, 0,
+                     PCI_BASE_ADDRESS_SPACE_MEMORY |
+                         PCI_BASE_ADDRESS_MEM_TYPE_64,
+                     &cxl_dstate->device_registers);
+    regloc_dvsec = &(CXLDVSECRegisterLocator) {
+        .rsvd         = 0,
+        .reg0_base_lo = RBI_CXL_DEVICE_REG | 0,
+        .reg0_base_hi = 0,
+    };
+    cxl_component_create_dvsec(cxl_cstate, CXL3_SWITCH_MAILBOX_CCI,
+                               REG_LOC_DVSEC_LENGTH, REG_LOC_DVSEC,
+                               REG_LOC_DVSEC_REVID, (uint8_t *)regloc_dvsec);
+
+    cxl_initialize_mailbox_swcci(cswmb->cci, DEVICE(pci_dev),
+                                 DEVICE(cswmb->target),
+                                 CXL_MAILBOX_MAX_PAYLOAD_SIZE);
+}
+
+static void cswmbcci_exit(PCIDevice *pci_dev)
+{
+    /* Nothing to do here yet */
+}
+
+static Property cxl_switch_cci_props[] = {
+    DEFINE_PROP_LINK("target", CSWMBCCIDev,
+                     target, TYPE_CXL_USP, PCIDevice *),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void cswmbcci_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    PCIDeviceClass *pc = PCI_DEVICE_CLASS(oc);
+
+    pc->realize = cswbcci_realize;
+    pc->exit = cswmbcci_exit;
+    /* Serial bus, CXL Switch CCI */
+    pc->class_id = 0x0c0b;
+    /*
+     * Huawei Technologies
+     * CXL Switch Mailbox CCI - DID assigned for emulation only.
+     * No real hardware will ever use this ID.
+     */
+    pc->vendor_id = 0x19e5;
+    pc->device_id = 0xa123;
+    pc->revision = 0;
+    dc->desc = "CXL Switch Mailbox CCI";
+    dc->reset = cswmbcci_reset;
+    device_class_set_props(dc, cxl_switch_cci_props);
+}
+
+static const TypeInfo cswmbcci_info = {
+    .name = TYPE_CXL_SWITCH_MAILBOX_CCI,
+    .parent = TYPE_PCI_DEVICE,
+    .class_init = cswmbcci_class_init,
+    .instance_size = sizeof(CSWMBCCIDev),
+    .interfaces = (InterfaceInfo[]) {
+        { INTERFACE_PCIE_DEVICE },
+        { }
+    },
+};
+
+static void cxl_switch_mailbox_cci_register(void)
+{
+    type_register_static(&cswmbcci_info);
+}
+type_init(cxl_switch_mailbox_cci_register);
diff --git a/hw/cxl/meson.build b/hw/cxl/meson.build
index e261ff3881..ea0aebf6e3 100644
--- a/hw/cxl/meson.build
+++ b/hw/cxl/meson.build
@@ -6,6 +6,7 @@ system_ss.add(when: 'CONFIG_CXL',
                    'cxl-host.c',
                    'cxl-cdat.c',
                    'cxl-events.c',
+                   'switch-mailbox-cci.c',
                ),
                if_false: files(
                    'cxl-host-stubs.c',
-- 
2.39.2


