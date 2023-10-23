Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7177D3BE8
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 18:12:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quxX5-0006Ky-8t; Mon, 23 Oct 2023 12:11:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1quxWq-000658-OW
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 12:11:46 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1quxWo-0001x4-QM
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 12:11:44 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SDg9S5msHz6K6gN;
 Tue, 24 Oct 2023 00:09:00 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 23 Oct 2023 17:11:39 +0100
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, Michael Tsirkin
 <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
CC: <linuxarm@huawei.com>, Fan Ni <fan.ni@samsung.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Gregory Price
 <gregory.price@memverge.com>, Davidlohr Bueso <dave@stgolabs.net>, Klaus
 Jensen <its@irrelevant.dk>, Corey Minyard <cminyard@mvista.com>
Subject: [PATCH v2 07/17] hw/cxl/mbox: Add Information and Status / Identify
 command
Date: Mon, 23 Oct 2023 17:07:56 +0100
Message-ID: <20231023160806.13206-8-Jonathan.Cameron@huawei.com>
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

Add this command that is only available via out of band CCIs. It replicates
information that can be discovered inband via PCI config space.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
v2:
- The subsystem [vendor] ID is not set in the class if defaults
  are used so grab it directly from the config registers.
  I could have set this for the CXL devices, but then I'd need
  an ID to use and as the CXL type3 devices have Intel VID it would
  be odd to make them part of a Huawei subsystem even if I jumped
  through the necessary hoops to get a subsystem ID assigned.
---
 hw/cxl/cxl-mailbox-utils.c | 55 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 28ea02fcbe..6741698ee7 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -11,6 +11,7 @@
 #include "hw/cxl/cxl.h"
 #include "hw/cxl/cxl_events.h"
 #include "hw/pci/pci.h"
+#include "hw/pci-bridge/cxl_upstream_port.h"
 #include "qemu/cutils.h"
 #include "qemu/log.h"
 #include "qemu/units.h"
@@ -44,6 +45,8 @@
  */
 
 enum {
+    INFOSTAT    = 0x00,
+        #define IS_IDENTIFY   0x1
     EVENTS      = 0x01,
         #define GET_RECORDS   0x0
         #define CLEAR_RECORDS   0x1
@@ -203,6 +206,57 @@ static CXLRetCode cmd_events_set_interrupt_policy(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/* CXL r3.0 section 8.2.9.1.1: Identify (Opcode 0001h) */
+static CXLRetCode cmd_infostat_identify(const struct cxl_cmd *cmd,
+                                        uint8_t *payload_in,
+                                        size_t len_in,
+                                        uint8_t *payload_out,
+                                        size_t *len_out,
+                                        CXLCCI *cci)
+{
+    PCIDeviceClass *class = PCI_DEVICE_GET_CLASS(cci->d);
+    struct {
+        uint16_t pcie_vid;
+        uint16_t pcie_did;
+        uint16_t pcie_subsys_vid;
+        uint16_t pcie_subsys_id;
+        uint64_t sn;
+    uint8_t max_message_size;
+        uint8_t component_type;
+    } QEMU_PACKED *is_identify;
+    QEMU_BUILD_BUG_ON(sizeof(*is_identify) != 18);
+
+    is_identify = (void *)payload_out;
+    memset(is_identify, 0, sizeof(*is_identify));
+    is_identify->pcie_vid = class->vendor_id;
+    is_identify->pcie_did = class->device_id;
+    if (object_dynamic_cast(OBJECT(cci->d), TYPE_CXL_USP)) {
+        is_identify->sn = CXL_USP(cci->d)->sn;
+        /* Subsystem info not defined for a USP */
+        is_identify->pcie_subsys_vid = 0;
+        is_identify->pcie_subsys_id = 0;
+        is_identify->component_type = 0x0; /* Switch */
+    } else if (object_dynamic_cast(OBJECT(cci->d), TYPE_CXL_TYPE3)) {
+        PCIDevice *pci_dev = PCI_DEVICE(cci->d);
+
+        is_identify->sn = CXL_TYPE3(cci->d)->sn;
+        /*
+         * We can't always use class->subsystem_vendor_id as
+         * it is not set if the defaults are used.
+         */
+        is_identify->pcie_subsys_vid =
+            pci_get_word(pci_dev->config + PCI_SUBSYSTEM_VENDOR_ID);
+        is_identify->pcie_subsys_id =
+            pci_get_word(pci_dev->config + PCI_SUBSYSTEM_ID);
+        is_identify->component_type = 0x3; /* Type 3 */
+    }
+
+    /* TODO: Allow this to vary across different CCIs */
+    is_identify->max_message_size = 9; /* 512 bytes - MCTP_CXL_MAILBOX_BYTES */
+    *len_out = sizeof(*is_identify);
+    return CXL_MBOX_SUCCESS;
+}
+
 /* 8.2.9.2.1 */
 static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
                                                uint8_t *payload_in,
@@ -755,6 +809,7 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
 };
 
 static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
+    [INFOSTAT][IS_IDENTIFY] = { "IDENTIFY", cmd_infostat_identify, 0, 0 },
     [TIMESTAMP][GET] = { "TIMESTAMP_GET", cmd_timestamp_get, 0, 0 },
     [TIMESTAMP][SET] = { "TIMESTAMP_SET", cmd_timestamp_set, 0,
                          IMMEDIATE_POLICY_CHANGE },
-- 
2.39.2


