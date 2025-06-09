Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A2925AD2411
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Jun 2025 18:36:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOfTH-00038f-Tr; Mon, 09 Jun 2025 12:35:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uOfSr-0002zy-Ff
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 12:35:15 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uOfSo-00024b-No
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 12:35:13 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bGHZb4bMjz6M52w;
 Tue, 10 Jun 2025 00:34:47 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 33AC01400D3;
 Tue, 10 Jun 2025 00:35:09 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 9 Jun 2025 18:35:08 +0200
To: Klaus Jensen <k.jensen@samsung.com>, <cminyard@mvista.com>, Fan Ni
 <fan.ni@samsung.com>, Anisa Su <anisa.su@samsung.com>,
 <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, <mst@redhat.com>
CC: <linuxarm@huawei.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: [RFC PATCH qemu 3/5] hw/cxl/i2c_mctp_cxl: Initial device emulation
Date: Mon, 9 Jun 2025 17:33:31 +0100
Message-ID: <20250609163334.922346-4-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250609163334.922346-1-Jonathan.Cameron@huawei.com>
References: <20250609163334.922346-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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

Note, only get timestamp added for now.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/cxl/cxl_device.h               |   8 +
 include/hw/pci-bridge/cxl_upstream_port.h |   1 +
 hw/cxl/cxl-mailbox-utils.c                |  49 ++++
 hw/cxl/i2c_mctp_cxl.c                     | 289 ++++++++++++++++++++++
 hw/cxl/Kconfig                            |   4 +
 hw/cxl/meson.build                        |   4 +
 6 files changed, 355 insertions(+)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 6086d4c85b..8d87c7151e 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -360,6 +360,10 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
                             size_t len_in, uint8_t *pl_in,
                             size_t *len_out, uint8_t *pl_out,
                             bool *bg_started);
+
+void cxl_initialize_t3_mctpcci(CXLCCI *cci, DeviceState *d, DeviceState *intf,
+                               size_t payload_max);
+
 void cxl_initialize_t3_fm_owned_ld_mctpcci(CXLCCI *cci, DeviceState *d,
                                            DeviceState *intf,
                                            size_t payload_max);
@@ -367,6 +371,9 @@ void cxl_initialize_t3_fm_owned_ld_mctpcci(CXLCCI *cci, DeviceState *d,
 void cxl_initialize_t3_ld_cci(CXLCCI *cci, DeviceState *d,
                               DeviceState *intf, size_t payload_max);
 
+void cxl_initialize_usp_mctpcci(CXLCCI *cci, DeviceState *d, DeviceState *intf,
+                                size_t payload_max);
+
 #define cxl_device_cap_init(dstate, reg, cap_id, ver)                      \
     do {                                                                   \
         uint32_t *cap_hdrs = dstate->caps_reg_state32;                     \
@@ -606,6 +613,7 @@ struct CXLType3Dev {
     CXLComponentState cxl_cstate;
     CXLDeviceState cxl_dstate;
     CXLCCI cci; /* Primary PCI mailbox CCI */
+    CXLCCI oob_mctp_cci; /* Initialized only if targetted */
     /* Always initialized as no way to know if a VDM might show up */
     CXLCCI vdm_fm_owned_ld_mctp_cci;
     CXLCCI ld0_cci;
diff --git a/include/hw/pci-bridge/cxl_upstream_port.h b/include/hw/pci-bridge/cxl_upstream_port.h
index f208397ffe..7e529e0b5a 100644
--- a/include/hw/pci-bridge/cxl_upstream_port.h
+++ b/include/hw/pci-bridge/cxl_upstream_port.h
@@ -12,6 +12,7 @@ typedef struct CXLUpstreamPort {
     /*< public >*/
     CXLComponentState cxl_cstate;
     CXLCCI swcci;
+    CXLCCI mctpcci;
 
     PCIExpLinkSpeed speed;
     PCIExpLinkWidth width;
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 475547f212..4c9852642e 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -3690,6 +3690,29 @@ void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max)
     cxl_init_cci(cci, payload_max);
 }
 
+static const struct cxl_cmd cxl_cmd_set_t3_mctp[256][256] = {
+    [INFOSTAT][IS_IDENTIFY] = { "IDENTIFY", cmd_infostat_identify, 0, 0 },
+    [INFOSTAT][GET_RESPONSE_MSG_LIMIT] = { "GET_RESPONSE_MSG_LIMIT",
+                                           cmd_get_response_msg_limit, 0, 0 },
+    [INFOSTAT][SET_RESPONSE_MSG_LIMIT] = { "SET_RESPONSE_MSG_LIMIT",
+                                           cmd_set_response_msg_limit, 1, 0 },
+    [TIMESTAMP][GET] = { "TIMESTAMP_GET", cmd_timestamp_get, 0, 0 },
+    [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported, 0,
+                              0 },
+    [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
+    [TUNNEL][MANAGEMENT_COMMAND] = { "TUNNEL_MANAGEMENT_COMMAND",
+                                     cmd_tunnel_management_cmd, ~0, 0 },
+};
+
+void cxl_initialize_t3_mctpcci(CXLCCI *cci, DeviceState *d, DeviceState *intf,
+                               size_t payload_max)
+{
+    cxl_copy_cci_commands(cci, cxl_cmd_set_t3_mctp);
+    cci->d = d;
+    cci->intf = intf;
+    cxl_init_cci(cci, payload_max);
+}
+
 static const struct cxl_cmd cxl_cmd_set_t3_ld[256][256] = {
     [INFOSTAT][IS_IDENTIFY] = { "IDENTIFY", cmd_infostat_identify, 0, 0 },
     [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported, 0,
@@ -3729,3 +3752,29 @@ void cxl_initialize_t3_fm_owned_ld_mctpcci(CXLCCI *cci, DeviceState *d,
     cci->intf = intf;
     cxl_init_cci(cci, payload_max);
 }
+
+static const struct cxl_cmd cxl_cmd_set_usp_mctp[256][256] = {
+    [INFOSTAT][IS_IDENTIFY] = { "IDENTIFY", cmd_infostat_identify, 0, 0 },
+    [INFOSTAT][GET_RESPONSE_MSG_LIMIT] = { "GET_RESPONSE_MSG_LIMIT",
+                                           cmd_get_response_msg_limit, 0, 0 },
+    [INFOSTAT][SET_RESPONSE_MSG_LIMIT] = { "SET_RESPONSE_MSG_LIMIT",
+                                           cmd_set_response_msg_limit, 1, 0 },
+    [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported,
+                              0, 0 },
+    [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
+    [PHYSICAL_SWITCH][IDENTIFY_SWITCH_DEVICE] = { "IDENTIFY_SWITCH_DEVICE",
+        cmd_identify_switch_device, 0, 0 },
+    [PHYSICAL_SWITCH][GET_PHYSICAL_PORT_STATE] = { "SWITCH_PHYSICAL_PORT_STATS",
+        cmd_get_physical_port_state, ~0, 0 },
+    [TUNNEL][MANAGEMENT_COMMAND] = { "TUNNEL_MANAGEMENT_COMMAND",
+                                     cmd_tunnel_management_cmd, ~0, 0 },
+};
+
+void cxl_initialize_usp_mctpcci(CXLCCI *cci, DeviceState *d, DeviceState *intf,
+                                size_t payload_max)
+{
+    cxl_copy_cci_commands(cci, cxl_cmd_set_usp_mctp);
+    cci->d = d;
+    cci->intf = intf;
+    cxl_init_cci(cci, payload_max);
+}
diff --git a/hw/cxl/i2c_mctp_cxl.c b/hw/cxl/i2c_mctp_cxl.c
new file mode 100644
index 0000000000..1714f36e8e
--- /dev/null
+++ b/hw/cxl/i2c_mctp_cxl.c
@@ -0,0 +1,289 @@
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
+ * DSP0281 CXL Type 3 Device Component Command Interface over MCTP Binding
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
+static const Property i2c_mctp_cxl_props[] = {
+    DEFINE_PROP_LINK("target", I2C_MCTP_CXL_State,
+                     target, TYPE_PCI_DEVICE, PCIDevice *),
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
+    s->pos = sizeof(*buf);
+    if (s->cci) {
+        bool bg_started;
+        size_t len_out = 0;
+        size_t len_in;
+        int rc;
+
+        /*
+         * As it was not immediately obvious from the various specifications,
+         * clarification was sort for which binding applies for which command
+         * set. The outcome was:
+         *
+         * Any command forming part of the CXL FM-API command set
+         * e.g. Present in CXL r3.0 Table 8-132: CXL FM API Command Opcodes
+         * (and equivalent in later CXL specifications) is valid only with
+         * the CXL Fabric Manager API over MCTP binding (DSP0234).
+         *
+         * Any other CXL command currently should be sent using the
+         * CXL Type 3 Device Component Command interface over MCTP binding,
+         * even if it is being sent to a switch.
+         *
+         * If tunneling is used, the component creating the PCIe VDMs must
+         * use the appropriate binding for sending the tunnel contents
+         * onwards.
+         */
+
+        if (!(msg->message_type == MCTP_MT_CXL_TYPE3 &&
+              msg->command_set < 0x51) &&
+            !(msg->message_type == MCTP_MT_CXL_FMAPI &&
+              msg->command_set >= 0x51 && msg->command_set < 0x56)) {
+            buf->rc = CXL_MBOX_UNSUPPORTED;
+            st24_le_p(buf->pl_length, len_out);
+            s->len = s->pos;
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
+        s->pos += len_out;
+        s->len = s->pos;
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
+        cxl_initialize_t3_fm_owned_ld_mctpcci(s->cci, DEVICE(s->target), d,
+                                              MCTP_CXL_MAILBOX_BYTES);
+        return;
+    }
+
+    error_setg(errp, "Unhandled target type for CXL MCTP EP");
+}
+
+static void i2c_mctp_cxl_class_init(ObjectClass *klass, const void *data)
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
index e3abb49d27..90fd83f680 100644
--- a/hw/cxl/meson.build
+++ b/hw/cxl/meson.build
@@ -12,3 +12,7 @@ system_ss.add(when: 'CONFIG_CXL',
                if_false: files(
                    'cxl-host-stubs.c',
                ))
+system_ss.add(when: 'CONFIG_I2C_MCTP_CXL', if_true: files('i2c_mctp_cxl.c'))
+
+system_ss.add(when: 'CONFIG_ALL', if_true: files('cxl-host-stubs.c'))
+
-- 
2.48.1


