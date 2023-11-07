Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDCC7E38F4
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:22:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0J5H-0003qf-2g; Tue, 07 Nov 2023 05:13:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J5E-0003j4-OX
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:13:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J5C-0002v8-L3
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:13:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699351997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M42e+QCTFHQpfioghFl7GHYJ8ILvQFm/3mBUX2ZJf8w=;
 b=Ej36mip+f62eKeM2qoNjX9LEQxkkQc/bzb4kpngdDphfukMnlJUDtglEAkqaseY0rNZZga
 k8VEto+wyVxchsRA9VFgPodNLM0HwZwZY7Nf3L6xkwg/Nt1k442wDdrmhcNqVYaj0k3GWl
 eux+0pnQCk4npKxgo2wBNBgxLDJPQXo=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-N4OT-66PMMekjb44a0toJQ-1; Tue, 07 Nov 2023 05:13:16 -0500
X-MC-Unique: N4OT-66PMMekjb44a0toJQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-50911cc75adso5933039e87.1
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 02:13:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699351994; x=1699956794;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M42e+QCTFHQpfioghFl7GHYJ8ILvQFm/3mBUX2ZJf8w=;
 b=M+KDjMaUwW7ZJlnsRvXuIvCAzdg/u0+QC1WHWKfNXt3QjIjMDEuK5tHploUthIk8A9
 /FgpRFolLv3hcNNLh63raUO6qbgTIDiWLYOQV7Q2N6IqCVO9uc+gtZXHEAw6ZTiWL5e/
 Lc/Wu/6xv2hlUVa7ELjtC0aTDoJMn/edkQzKuC1xANkaVsVc25VMZbZ23ktIVeRi0+Yg
 OE/cpmlOau3yIQViBneWEtTMX4tPIXr7kmZNWJJMYlZUs0gYS40w4ms3uwyo6Ngs4ITJ
 bNGeHf97JFvsmE1KohB9QI+HHo1sqbYNMhQRde/H7/ZDQOPgknuVEZhc58XOnSwdWIHl
 PjxA==
X-Gm-Message-State: AOJu0YyPjvFGEdElZN0htik/AcOKHvoI60l9jgc6hpuX8xJ3LGc3VjtK
 uTjpJqZLNSYXqrWauUvUnbc22r73jTiK5hrdkdWk3ipQFGxmHQpL0ypWlMPerwfv6M8niB/r33I
 Q3Uk5H4P2SDtB015/5qD2V1+pLiRboM31RdiGCM7YEKINIRXaqT0xqQ524oDd70+AvvE7
X-Received: by 2002:a2e:8043:0:b0:2c5:70f:614a with SMTP id
 p3-20020a2e8043000000b002c5070f614amr24591829ljg.17.1699351993780; 
 Tue, 07 Nov 2023 02:13:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEwYHJi0czUxSqIiEoPAxOqubDjovxetkWvAgzwQN+WNFz5TBru84VRizIhfHEZNYDNdMCmBQ==
X-Received: by 2002:a2e:8043:0:b0:2c5:70f:614a with SMTP id
 p3-20020a2e8043000000b002c5070f614amr24591810ljg.17.1699351993311; 
 Tue, 07 Nov 2023 02:13:13 -0800 (PST)
Received: from redhat.com ([2.55.5.143]) by smtp.gmail.com with ESMTPSA id
 fo15-20020a05600c690f00b0040535648639sm14733979wmb.36.2023.11.07.02.13.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 02:13:12 -0800 (PST)
Date: Tue, 7 Nov 2023 05:13:09 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 50/63] hw/cxl: Add a switch mailbox CCI function
Message-ID: <4a58330343e6a16f6828e225fd0c054c8d1916bd.1699351720.git.mst@redhat.com>
References: <cover.1699351720.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1699351720.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

CXL switch CCIs were added in CXL r3.0. They are a PCI function,
identified by class code that provides a CXL mailbox (identical
to that previously defined for CXL type 3 memory devices) over which
various FM-API commands may be used. Whilst the intent of this
feature is enable switch control from a BMC attached to a switch
upstream port, it is also useful to allow emulation of this feature
on the upstream port connected to a host using the CXL devices as
this greatly simplifies testing.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20231023160806.13206-7-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/cxl/cxl_component.h            |   3 +-
 include/hw/cxl/cxl_device.h               |  15 +++
 include/hw/pci-bridge/cxl_upstream_port.h |   1 +
 hw/cxl/cxl-device-utils.c                 |  27 ++++++
 hw/cxl/cxl-mailbox-utils.c                |  18 ++++
 hw/cxl/switch-mailbox-cci.c               | 111 ++++++++++++++++++++++
 hw/cxl/meson.build                        |   1 +
 7 files changed, 175 insertions(+), 1 deletion(-)
 create mode 100644 hw/cxl/switch-mailbox-cci.c

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
MST


