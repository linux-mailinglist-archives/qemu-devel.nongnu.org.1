Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D187D3BEC
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 18:12:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quxXU-0007ja-Cc; Mon, 23 Oct 2023 12:12:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1quxXK-0007Tf-Ga
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 12:12:14 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1quxXI-00025L-Nz
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 12:12:14 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SDg8y29cNz6JBBn;
 Tue, 24 Oct 2023 00:08:34 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 23 Oct 2023 17:12:10 +0100
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, Michael Tsirkin
 <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
CC: <linuxarm@huawei.com>, Fan Ni <fan.ni@samsung.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Gregory Price
 <gregory.price@memverge.com>, Davidlohr Bueso <dave@stgolabs.net>, Klaus
 Jensen <its@irrelevant.dk>, Corey Minyard <cminyard@mvista.com>
Subject: [PATCH v2 08/17] hw/cxl/mbox: Add Physical Switch Identify command.
Date: Mon, 23 Oct 2023 17:07:57 +0100
Message-ID: <20231023160806.13206-9-Jonathan.Cameron@huawei.com>
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

Enable it for the switch CCI.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/cxl/cxl.h           |  6 ++++
 hw/cxl/cxl-mailbox-utils.c     | 65 ++++++++++++++++++++++++++++++++++
 hw/pci-bridge/cxl_downstream.c |  4 +--
 3 files changed, 72 insertions(+), 3 deletions(-)

diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
index 4944725849..75e47b6864 100644
--- a/include/hw/cxl/cxl.h
+++ b/include/hw/cxl/cxl.h
@@ -61,4 +61,10 @@ OBJECT_DECLARE_SIMPLE_TYPE(CXLHost, PXB_CXL_HOST)
 typedef struct CXLUpstreamPort CXLUpstreamPort;
 DECLARE_INSTANCE_CHECKER(CXLUpstreamPort, CXL_USP, TYPE_CXL_USP)
 CXLComponentState *cxl_usp_to_cstate(CXLUpstreamPort *usp);
+
+#define TYPE_CXL_DSP "cxl-downstream"
+
+typedef struct CXLDownstreamPort CXLDownstreamPort;
+DECLARE_INSTANCE_CHECKER(CXLDownstreamPort, CXL_DSP, TYPE_CXL_DSP)
+
 #endif
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 6741698ee7..6ada49d37c 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -70,6 +70,8 @@ enum {
         #define GET_POISON_LIST        0x0
         #define INJECT_POISON          0x1
         #define CLEAR_POISON           0x2
+    PHYSICAL_SWITCH = 0x51,
+        #define IDENTIFY_SWITCH_DEVICE      0x0
 };
 
 
@@ -257,6 +259,67 @@ static CXLRetCode cmd_infostat_identify(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+static void cxl_set_dsp_active_bm(PCIBus *b, PCIDevice *d,
+                                  void *private)
+{
+    uint8_t *bm = private;
+    if (object_dynamic_cast(OBJECT(d), TYPE_CXL_DSP)) {
+        uint8_t port = PCIE_PORT(d)->port;
+        bm[port / 8] |= 1 << (port % 8);
+    }
+}
+
+/* CXL r3 8.2.9.1.1 */
+static CXLRetCode cmd_identify_switch_device(const struct cxl_cmd *cmd,
+                                             uint8_t *payload_in,
+                                             size_t len_in,
+                                             uint8_t *payload_out,
+                                             size_t *len_out,
+                                             CXLCCI *cci)
+{
+    PCIEPort *usp = PCIE_PORT(cci->d);
+    PCIBus *bus = &PCI_BRIDGE(cci->d)->sec_bus;
+    int num_phys_ports = pcie_count_ds_ports(bus);
+
+    struct cxl_fmapi_ident_switch_dev_resp_pl {
+        uint8_t ingress_port_id;
+        uint8_t rsvd;
+        uint8_t num_physical_ports;
+        uint8_t num_vcss;
+        uint8_t active_port_bitmask[0x20];
+        uint8_t active_vcs_bitmask[0x20];
+        uint16_t total_vppbs;
+        uint16_t bound_vppbs;
+        uint8_t num_hdm_decoders_per_usp;
+    } QEMU_PACKED *out;
+    QEMU_BUILD_BUG_ON(sizeof(*out) != 0x49);
+
+    out = (struct cxl_fmapi_ident_switch_dev_resp_pl *)payload_out;
+    *out = (struct cxl_fmapi_ident_switch_dev_resp_pl) {
+        .num_physical_ports = num_phys_ports + 1, /* 1 USP */
+        .num_vcss = 1, /* Not yet support multiple VCS - potentialy tricky */
+        .active_vcs_bitmask[0] = 0x1,
+        .total_vppbs = num_phys_ports + 1,
+        .bound_vppbs = num_phys_ports + 1,
+        .num_hdm_decoders_per_usp = 4,
+    };
+
+    /* Depends on the CCI type */
+    if (object_dynamic_cast(OBJECT(cci->intf), TYPE_PCIE_PORT)) {
+        out->ingress_port_id = PCIE_PORT(cci->intf)->port;
+    } else {
+        /* MCTP? */
+        out->ingress_port_id = 0;
+    }
+
+    pci_for_each_device_under_bus(bus, cxl_set_dsp_active_bm,
+                                  out->active_port_bitmask);
+    out->active_port_bitmask[usp->port / 8] |= (1 << usp->port % 8);
+
+    *len_out = sizeof(*out);
+
+    return CXL_MBOX_SUCCESS;
+}
 /* 8.2.9.2.1 */
 static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
                                                uint8_t *payload_in,
@@ -816,6 +879,8 @@ static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
     [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported, 0,
                               0 },
     [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
+    [PHYSICAL_SWITCH][IDENTIFY_SWITCH_DEVICE] = { "IDENTIFY_SWITCH_DEVICE",
+        cmd_identify_switch_device, 0, 0 },
 };
 
 int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
index 8c0f759add..8d99e1e96d 100644
--- a/hw/pci-bridge/cxl_downstream.c
+++ b/hw/pci-bridge/cxl_downstream.c
@@ -13,6 +13,7 @@
 #include "hw/pci/msi.h"
 #include "hw/pci/pcie.h"
 #include "hw/pci/pcie_port.h"
+#include "hw/cxl/cxl.h"
 #include "qapi/error.h"
 
 typedef struct CXLDownstreamPort {
@@ -23,9 +24,6 @@ typedef struct CXLDownstreamPort {
     CXLComponentState cxl_cstate;
 } CXLDownstreamPort;
 
-#define TYPE_CXL_DSP "cxl-downstream"
-DECLARE_INSTANCE_CHECKER(CXLDownstreamPort, CXL_DSP, TYPE_CXL_DSP)
-
 #define CXL_DOWNSTREAM_PORT_MSI_OFFSET 0x70
 #define CXL_DOWNSTREAM_PORT_MSI_NR_VECTOR 1
 #define CXL_DOWNSTREAM_PORT_EXP_OFFSET 0x90
-- 
2.39.2


