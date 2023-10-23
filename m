Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD827D3BF0
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 18:13:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quxYn-0002xL-NJ; Mon, 23 Oct 2023 12:13:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1quxYM-0002te-0e
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 12:13:18 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1quxYJ-0002DO-Fi
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 12:13:17 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SDgFX2zlFz6K9DV;
 Tue, 24 Oct 2023 00:12:32 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 23 Oct 2023 17:13:11 +0100
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, Michael Tsirkin
 <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
CC: <linuxarm@huawei.com>, Fan Ni <fan.ni@samsung.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Gregory Price
 <gregory.price@memverge.com>, Davidlohr Bueso <dave@stgolabs.net>, Klaus
 Jensen <its@irrelevant.dk>, Corey Minyard <cminyard@mvista.com>
Subject: [PATCH v2 10/17] hw/cxl: Implement Physical Ports status retrieval
Date: Mon, 23 Oct 2023 17:07:59 +0100
Message-ID: <20231023160806.13206-11-Jonathan.Cameron@huawei.com>
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

Add this command for both the Switch CCI in switch upstream ports.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
v2:
- Fix wrong size of message.
- Fill in downstream connected device with correct device types.
  Note intially all emulated type 3 devices are considered MLDs.
---
 hw/cxl/cxl-mailbox-utils.c | 128 +++++++++++++++++++++++++++++++++++++
 1 file changed, 128 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 6ada49d37c..de63fc1a28 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -72,6 +72,7 @@ enum {
         #define CLEAR_POISON           0x2
     PHYSICAL_SWITCH = 0x51,
         #define IDENTIFY_SWITCH_DEVICE      0x0
+        #define GET_PHYSICAL_PORT_STATE     0x1
 };
 
 
@@ -320,6 +321,131 @@ static CXLRetCode cmd_identify_switch_device(const struct cxl_cmd *cmd,
 
     return CXL_MBOX_SUCCESS;
 }
+
+/* CXL r3.0 Section 7.6.7.1.2: Get Physical Port State (Opcode 5101h) */
+static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
+                                              uint8_t *payload_in,
+                                              size_t len_in,
+                                              uint8_t *payload_out,
+                                              size_t *len_out,
+                                              CXLCCI *cci)
+{
+    /* CXL r3.0 Table 7-18: Get Physical Port State Request Payload */
+    struct cxl_fmapi_get_phys_port_state_req_pl {
+        uint8_t num_ports;
+        uint8_t ports[];
+    } QEMU_PACKED *in;
+
+    /*
+     * CXL r3.0 Table 7-20: Get Physical Port State Port Information Block
+     * Format
+     */
+    struct cxl_fmapi_port_state_info_block {
+        uint8_t port_id;
+        uint8_t config_state;
+        uint8_t connected_device_cxl_version;
+        uint8_t rsv1;
+        uint8_t connected_device_type;
+        uint8_t port_cxl_version_bitmask;
+        uint8_t max_link_width;
+        uint8_t negotiated_link_width;
+        uint8_t supported_link_speeds_vector;
+        uint8_t max_link_speed;
+        uint8_t current_link_speed;
+        uint8_t ltssm_state;
+        uint8_t first_lane_num;
+        uint16_t link_state;
+        uint8_t supported_ld_count;
+    } QEMU_PACKED;
+
+    /* CXL r3.0 Table 7-19: Get Physical Port State Response Payload */
+    struct cxl_fmapi_get_phys_port_state_resp_pl {
+        uint8_t num_ports;
+        uint8_t rsv1[3];
+        struct cxl_fmapi_port_state_info_block ports[];
+    } QEMU_PACKED *out;
+    PCIBus *bus = &PCI_BRIDGE(cci->d)->sec_bus;
+    PCIEPort *usp = PCIE_PORT(cci->d);
+    size_t pl_size;
+    int i;
+
+    in = (struct cxl_fmapi_get_phys_port_state_req_pl *)payload_in;
+    out = (struct cxl_fmapi_get_phys_port_state_resp_pl *)payload_out;
+
+    /* Check if what was requested can fit */
+    if (sizeof(*out) + sizeof(*out->ports) * in->num_ports > cci->payload_max) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    /* For success there should be a match for each requested */
+    out->num_ports = in->num_ports;
+
+    for (i = 0; i < in->num_ports; i++) {
+        struct cxl_fmapi_port_state_info_block *port;
+        /* First try to match on downstream port */
+        PCIDevice *port_dev;
+        uint16_t lnkcap, lnkcap2, lnksta;
+
+        port = &out->ports[i];
+
+        port_dev = pcie_find_port_by_pn(bus, in->ports[i]);
+        if (port_dev) { /* DSP */
+            PCIDevice *ds_dev = pci_bridge_get_sec_bus(PCI_BRIDGE(port_dev))
+                ->devices[0];
+            port->config_state = 3;
+            if (ds_dev) {
+                if (object_dynamic_cast(OBJECT(ds_dev), TYPE_CXL_TYPE3)) {
+                    port->connected_device_type = 5; /* Assume MLD for now */
+                } else {
+                    port->connected_device_type = 1;
+                }
+            } else {
+                port->connected_device_type = 0;
+            }
+            port->supported_ld_count = 3;
+        } else if (usp->port == in->ports[i]) { /* USP */
+            port_dev = PCI_DEVICE(usp);
+            port->config_state = 4;
+            port->connected_device_type = 0;
+        } else {
+            return CXL_MBOX_INVALID_INPUT;
+        }
+
+        port->port_id = in->ports[i];
+        /* Information on status of this port in lnksta, lnkcap */
+        if (!port_dev->exp.exp_cap) {
+            return CXL_MBOX_INTERNAL_ERROR;
+        }
+        lnksta = port_dev->config_read(port_dev,
+                                       port_dev->exp.exp_cap + PCI_EXP_LNKSTA,
+                                       sizeof(lnksta));
+        lnkcap = port_dev->config_read(port_dev,
+                                       port_dev->exp.exp_cap + PCI_EXP_LNKCAP,
+                                       sizeof(lnkcap));
+        lnkcap2 = port_dev->config_read(port_dev,
+                                        port_dev->exp.exp_cap + PCI_EXP_LNKCAP2,
+                                        sizeof(lnkcap2));
+
+        port->max_link_width = (lnkcap & PCI_EXP_LNKCAP_MLW) >> 4;
+        port->negotiated_link_width = (lnksta & PCI_EXP_LNKSTA_NLW) >> 4;
+        /* No definition for SLS field in linux/pci_regs.h */
+        port->supported_link_speeds_vector = (lnkcap2 & 0xFE) >> 1;
+        port->max_link_speed = lnkcap & PCI_EXP_LNKCAP_SLS;
+        port->current_link_speed = lnksta & PCI_EXP_LNKSTA_CLS;
+        /* TODO: Track down if we can get the rest of the info */
+        port->ltssm_state = 0x7;
+        port->first_lane_num = 0;
+        port->link_state = 0;
+        port->port_cxl_version_bitmask = 0x2;
+        port->connected_device_cxl_version = 0x2;
+    }
+
+    pl_size = sizeof(*out) + sizeof(*out->ports) * in->num_ports;
+    *len_out = pl_size;
+
+    return CXL_MBOX_SUCCESS;
+}
+
 /* 8.2.9.2.1 */
 static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
                                                uint8_t *payload_in,
@@ -881,6 +1007,8 @@ static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
     [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
     [PHYSICAL_SWITCH][IDENTIFY_SWITCH_DEVICE] = { "IDENTIFY_SWITCH_DEVICE",
         cmd_identify_switch_device, 0, 0 },
+    [PHYSICAL_SWITCH][GET_PHYSICAL_PORT_STATE] = { "SWITCH_PHYSICAL_PORT_STATS",
+        cmd_get_physical_port_state, ~0, 0 },
 };
 
 int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
-- 
2.39.2


