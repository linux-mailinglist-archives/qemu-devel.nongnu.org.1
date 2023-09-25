Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A03187ADCDD
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 18:14:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkoEC-0007F0-43; Mon, 25 Sep 2023 12:14:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qkoEA-0007Eo-Ef
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 12:14:30 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qkoE8-0000H9-8i
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 12:14:30 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RvSbH2QLMz6K7Yb;
 Tue, 26 Sep 2023 00:13:15 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 25 Sep 2023 17:14:25 +0100
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, Michael Tsirkin
 <mst@redhat.com>
CC: <linuxarm@huawei.com>, Fan Ni <fan.ni@samsung.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Davidlohr
 Bueso <dave@stgolabs.net>, Gregory Price <gregory.price@memverge.com>, Klaus
 Jensen <its@irrelevant.dk>, Corey Minyard <cminyard@mvista.com>, Klaus Jensen
 <k.jensen@samsung.com>
Subject: [PATCH 06/19] hw/cxl/i2c_mctp_cxl: Initial device emulation
Date: Mon, 25 Sep 2023 17:11:11 +0100
Message-ID: <20230925161124.18940-7-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230925161124.18940-1-Jonathan.Cameron@huawei.com>
References: <20230925161124.18940-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
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

The CCI and Fabric Manager APIs are used to configure CXL switches and
devices. DMTF has defined an MCTP binding specification to carry these
messages. The end goal of this work is to hook this up to emulated CXL
switches and devices to  allow control of the configuration.

Since this relies on i2c target mode, this can currently only be used with
an SoC that includes the Aspeed I2C controller.

Note, no commands supported at this point.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
Updated to use the v6 MCTP patch set.
Can be tested in similar fashion to NVME-mi (or using the
out of tree patches to add the aspeed-i2c controller to other
i386/pc and arm/virt.
---
 include/hw/cxl/cxl_device.h               |   5 +
 include/hw/pci-bridge/cxl_upstream_port.h |   1 +
 hw/cxl/cxl-mailbox-utils.c                |  24 ++
 hw/cxl/i2c_mctp_cxl.c                     | 290 ++++++++++++++++++++++
 hw/cxl/Kconfig                            |   4 +
 hw/cxl/meson.build                        |   1 +
 6 files changed, 325 insertions(+)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 0e3f6c3c0b..ba74908da5 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -274,6 +274,10 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
                             size_t len_in, uint8_t *pl_in,
                             size_t *len_out, uint8_t *pl_out,
                             bool *bg_started);
+void cxl_initialize_t3_mctpcci(CXLCCI *cci, DeviceState *d, DeviceState *intf,
+                               size_t payload_max);
+void cxl_initialize_usp_mctpcci(CXLCCI *cci, DeviceState *d, DeviceState *intf,
+                                size_t payload_max);
 
 #define cxl_device_cap_init(dstate, reg, cap_id, ver)                      \
     do {                                                                   \
@@ -375,6 +379,7 @@ struct CXLType3Dev {
     CXLComponentState cxl_cstate;
     CXLDeviceState cxl_dstate;
     CXLCCI cci; /* Primary PCI mailbox CCI */
+    CXLCCI oob_mctp_cci; /* Initialized only if targetted */
 
     /* DOE */
     DOECap doe_cdat;
diff --git a/include/hw/pci-bridge/cxl_upstream_port.h b/include/hw/pci-bridge/cxl_upstream_port.h
index b02aa8f659..15db8c8582 100644
--- a/include/hw/pci-bridge/cxl_upstream_port.h
+++ b/include/hw/pci-bridge/cxl_upstream_port.h
@@ -11,6 +11,7 @@ typedef struct CXLUpstreamPort {
 
     /*< public >*/
     CXLComponentState cxl_cstate;
+    CXLCCI mctpcci;
     DOECap doe_cdat;
     uint64_t sn;
 } CXLUpstreamPort;
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 239acc659d..27b6828d4f 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -804,3 +804,27 @@ void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max)
     cci->intf = d;
     cxl_init_cci(cci, payload_max);
 }
+
+static const struct cxl_cmd cxl_cmd_set_t3_mctp[256][256] = {
+};
+
+void cxl_initialize_t3_mctpcci(CXLCCI *cci, DeviceState *d, DeviceState *intf,
+                               size_t payload_max)
+{
+    cci->cxl_cmd_set = cxl_cmd_set_t3_mctp;
+    cci->d = d;
+    cci->intf = intf;
+    cxl_init_cci(cci, payload_max);
+}
+
+static const struct cxl_cmd cxl_cmd_set_usp_mctp[256][256] = {
+};
+
+void cxl_initialize_usp_mctpcci(CXLCCI *cci, DeviceState *d, DeviceState *intf,
+                                size_t payload_max)
+{
+    cci->cxl_cmd_set = cxl_cmd_set_usp_mctp;
+    cci->d = d;
+    cci->intf = intf;
+    cxl_init_cci(cci, payload_max);
+}
diff --git a/hw/cxl/i2c_mctp_cxl.c b/hw/cxl/i2c_mctp_cxl.c
new file mode 100644
index 0000000000..a55448c8fe
--- /dev/null
+++ b/hw/cxl/i2c_mctp_cxl.c
@@ -0,0 +1,290 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Emulation of a CXL Switch Fabric Management interface over MCTP over I2C.
+ *
+ * Copyright (c) 2023 Huawei Technologies.
+ *
+ * Reference list:
+ * From www.dmtf.org
+ * DSP0236 Management Component Transport Protocol (MCTP) Base Specification
+ *    1.3.0
+ * DPS0234 CXL Fabric Manager API over MCTP Binding Specification 1.0.0
+ * DSP0281 CXL Type 3 Deivce Component Command Interface over MCTP Binding
+ *    Specification (note some commands apply to switches as well)
+ * From www.computeexpresslink.org
+ * Compute Express Link (CXL) Specification revision 3.0 Version 1.0
+ */
+
+#include "qemu/osdep.h"
+#include "hw/i2c/i2c.h"
+#include "hw/i2c/mctp.h"
+#include "net/mctp.h"
+#include "hw/irq.h"
+#include "migration/vmstate.h"
+#include "qapi/error.h"
+#include "hw/cxl/cxl.h"
+#include "hw/pci-bridge/cxl_upstream_port.h"
+#include "hw/pci/pcie.h"
+#include "hw/pci/pcie_port.h"
+#include "hw/qdev-properties.h"
+#include "hw/registerfields.h"
+
+#define TYPE_I2C_MCTP_CXL "i2c_mctp_cxl"
+
+/* DMTF DSP0234 CXL Fabric Manager API over MCTP Binding Specification */
+#define MCTP_MT_CXL_FMAPI 0x7
+/*
+ * DMTF DSP0281 CXL Type 3 Deivce Component Command Interface over MCTP
+ * Binding Specification
+ */
+#define MCTP_MT_CXL_TYPE3 0x8
+
+/* FMAPI binding specification defined */
+#define MCTP_CXL_MAX_MSG_LEN 1088
+
+/* Implementation choice - may make this configurable */
+#define MCTP_CXL_MAILBOX_BYTES 512
+
+typedef struct CXLMCTPMessage {
+    /*
+     * DSP0236 (MCTP Base) Integrity Check + Message Type
+     * DSP0234/DSP0281 (CXL bindings) state no Integrity Check
+     * so just the message type.
+     */
+    uint8_t message_type;
+    /* Remaing fields from CXL r3.0 Table 7-14 CCI Message Format */
+    uint8_t category;
+    uint8_t tag;
+    uint8_t rsvd;
+    /*
+     * CXL r3.0 - Table 8-36 Generic Component Command Opcodes:
+     * Command opcode is split into two sub fields
+     */
+    uint8_t command;
+    uint8_t command_set;
+    uint8_t pl_length[3];
+    uint16_t rc;
+    uint16_t vendor_status;
+    uint8_t payload[];
+} QEMU_PACKED CXLMCTPMessage;
+
+enum cxl_dev_type {
+    cxl_type3,
+    cxl_switch,
+};
+
+struct I2C_MCTP_CXL_State {
+    MCTPI2CEndpoint mctp;
+    PCIDevice *target;
+    CXLCCI *cci;
+    enum cxl_dev_type type;
+    size_t len;
+    int64_t pos;
+    uint8_t buffer[MCTP_CXL_MAX_MSG_LEN];
+    uint8_t scratch[MCTP_CXL_MAX_MSG_LEN];
+};
+
+OBJECT_DECLARE_SIMPLE_TYPE(I2C_MCTP_CXL_State, I2C_MCTP_CXL)
+
+static Property i2c_mctp_cxl_props[] = {
+    DEFINE_PROP_LINK("target", I2C_MCTP_CXL_State,
+                     target, TYPE_PCI_DEVICE, PCIDevice *),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static size_t i2c_mctp_cxl_get_buf(MCTPI2CEndpoint *mctp,
+                                   const uint8_t **buf,
+                                   size_t maxlen,
+                                   uint8_t *mctp_flags)
+{
+    I2C_MCTP_CXL_State *s = I2C_MCTP_CXL(mctp);
+    size_t len;
+
+    len = MIN(maxlen, s->len - s->pos);
+
+    if (len == 0) {
+        return 0;
+    }
+
+    if (s->pos == 0) {
+        *mctp_flags = FIELD_DP8(*mctp_flags, MCTP_H_FLAGS, SOM, 1);
+    }
+
+    *buf = s->scratch + s->pos;
+    s->pos += len;
+
+    if (s->pos == s->len) {
+        *mctp_flags = FIELD_DP8(*mctp_flags, MCTP_H_FLAGS, EOM, 1);
+
+        s->pos = s->len = 0;
+    }
+
+    return len;
+}
+
+static int i2c_mctp_cxl_put_buf(MCTPI2CEndpoint *mctp,
+                                uint8_t *buf, size_t len)
+{
+    I2C_MCTP_CXL_State *s = I2C_MCTP_CXL(mctp);
+
+    if (s->len + len > MCTP_CXL_MAX_MSG_LEN) {
+        return -1;
+    }
+
+    memcpy(s->buffer + s->len, buf, len);
+    s->len += len;
+
+    return 0;
+}
+
+static size_t i2c_mctp_cxl_get_types(MCTPI2CEndpoint *mctp,
+                                     const uint8_t **data)
+{
+    static const uint8_t buf[] = {
+        0x0, /* Success */
+        2, /* Message types in list - supported in addition to control */
+        MCTP_MT_CXL_FMAPI,
+        MCTP_MT_CXL_TYPE3,
+    };
+    *data = buf;
+
+    return sizeof(buf);
+}
+
+static void i2c_mctp_cxl_reset_message(MCTPI2CEndpoint *mctp)
+{
+    I2C_MCTP_CXL_State *s = I2C_MCTP_CXL(mctp);
+
+    s->len = 0;
+}
+
+static void i2c_mctp_cxl_handle_message(MCTPI2CEndpoint *mctp)
+{
+    I2C_MCTP_CXL_State *s = I2C_MCTP_CXL(mctp);
+    CXLMCTPMessage *msg = (CXLMCTPMessage *)s->buffer;
+    CXLMCTPMessage *buf = (CXLMCTPMessage *)s->scratch;
+
+    *buf = (CXLMCTPMessage) {
+        .message_type = msg->message_type,
+        .category = 1,
+        .tag = msg->tag,
+        .command = msg->command,
+        .command_set = msg->command_set,
+    };
+    s->pos = sizeof(buf);
+
+    if (s->cci) {
+        bool bg_started;
+        size_t len_out = 0;
+        size_t len_in;
+        int rc;
+
+        /*
+         * Check the message types - there are two because in theory
+         * the opcodes for different device types could overlap in future.
+         * In practice that hasn't happened yet, but best to keep to the
+         * specifications.
+         *
+         * The binding specifications are not closely coupled to the
+         * CXL specification which makes interpretation tricky.
+         *
+         * Assumption that no non type3 commands sets will be defined below
+         * the FM-API (there is a lot more room above).
+         *
+         * For both bindings, command sets < 0x40 are valid.
+         * For Type3 they start at 0x40 - we allow up to start of FMAPI
+         * For FMAPI they start at 0x51 - we allow up to 0x56.
+         */
+
+        if (!((msg->message_type == MCTP_MT_CXL_TYPE3 ||
+               msg->message_type == MCTP_MT_CXL_FMAPI) &&
+              msg->command_set < 0x40) &&
+            !(msg->message_type == MCTP_MT_CXL_TYPE3 &&
+              msg->command_set > 0x40 && msg->command_set < 0x51) &&
+            !(msg->message_type == MCTP_MT_CXL_FMAPI &&
+              msg->command_set >= 0x51 && msg->command_set < 0x56)) {
+            buf->rc = CXL_MBOX_UNSUPPORTED;
+            st24_le_p(buf->pl_length, len_out);
+            s->pos = 0;
+            i2c_mctp_schedule_send(mctp);
+            return;
+        }
+
+        len_in = msg->pl_length[2] << 16 | msg->pl_length[1] << 8 |
+            msg->pl_length[0];
+
+        rc = cxl_process_cci_message(s->cci, msg->command_set, msg->command,
+                                     len_in, msg->payload,
+                                     &len_out,
+                                     s->scratch + sizeof(CXLMCTPMessage),
+                                     &bg_started);
+        buf->rc = rc;
+        s->len += len_out;
+        st24_le_p(buf->pl_length, len_out);
+        s->pos = 0;
+        i2c_mctp_schedule_send(mctp);
+    } else {
+        g_assert_not_reached(); /* The cci must be hooked up */
+    }
+}
+
+static void i2c_mctp_cxl_realize(DeviceState *d, Error **errp)
+{
+    I2C_MCTP_CXL_State *s = I2C_MCTP_CXL(d);
+
+    /* Check this is a type we support */
+    if (object_dynamic_cast(OBJECT(s->target), TYPE_CXL_USP)) {
+        CXLUpstreamPort *usp = CXL_USP(s->target);
+
+        s->type = cxl_switch;
+        s->cci = &usp->mctpcci;
+
+        cxl_initialize_usp_mctpcci(s->cci, DEVICE(s->target), d,
+                                   MCTP_CXL_MAILBOX_BYTES);
+
+        return;
+    }
+
+    if (object_dynamic_cast(OBJECT(s->target), TYPE_CXL_TYPE3)) {
+        CXLType3Dev *ct3d = CXL_TYPE3(s->target);
+
+        s->type = cxl_type3;
+        s->cci = &ct3d->oob_mctp_cci;
+
+        cxl_initialize_t3_mctpcci(s->cci, DEVICE(s->target), d,
+                                  MCTP_CXL_MAILBOX_BYTES);
+        return;
+    }
+
+    error_setg(errp, "Unhandled target type for CXL MCTP EP");
+}
+
+static void i2c_mctp_cxl_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    MCTPI2CEndpointClass *mc = MCTP_I2C_ENDPOINT_CLASS(klass);
+
+    dc->realize = i2c_mctp_cxl_realize;
+    mc->get_types = i2c_mctp_cxl_get_types;
+    mc->get_buf = i2c_mctp_cxl_get_buf;
+    mc->put_buf = i2c_mctp_cxl_put_buf;
+
+    mc->handle = i2c_mctp_cxl_handle_message;
+    mc->reset = i2c_mctp_cxl_reset_message;
+    device_class_set_props(dc, i2c_mctp_cxl_props);
+}
+
+static const TypeInfo i2c_mctp_cxl_info = {
+    .name = TYPE_I2C_MCTP_CXL,
+    .parent = TYPE_MCTP_I2C_ENDPOINT,
+    .instance_size = sizeof(I2C_MCTP_CXL_State),
+    .class_init = i2c_mctp_cxl_class_init,
+};
+
+static void i2c_mctp_cxl_register_types(void)
+{
+    type_register_static(&i2c_mctp_cxl_info);
+}
+
+type_init(i2c_mctp_cxl_register_types)
diff --git a/hw/cxl/Kconfig b/hw/cxl/Kconfig
index 8e67519b16..bc259fdf67 100644
--- a/hw/cxl/Kconfig
+++ b/hw/cxl/Kconfig
@@ -1,3 +1,7 @@
 config CXL
     bool
     default y if PCI_EXPRESS
+
+config I2C_MCTP_CXL
+    bool
+    default y if CXL && I2C_MCTP
diff --git a/hw/cxl/meson.build b/hw/cxl/meson.build
index e261ff3881..0152a2b190 100644
--- a/hw/cxl/meson.build
+++ b/hw/cxl/meson.build
@@ -10,5 +10,6 @@ system_ss.add(when: 'CONFIG_CXL',
                if_false: files(
                    'cxl-host-stubs.c',
                ))
+system_ss.add(when: 'CONFIG_I2C_MCTP_CXL', if_true: files('i2c_mctp_cxl.c'))
 
 system_ss.add(when: 'CONFIG_ALL', if_true: files('cxl-host-stubs.c'))
-- 
2.39.2


