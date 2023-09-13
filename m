Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3CB79E97D
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 15:38:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgQ2n-0001lx-8o; Wed, 13 Sep 2023 09:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qgQ2d-0001k3-Pr
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 09:36:28 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qgQ2V-000299-T6
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 09:36:27 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rm1g30SL8z6K6CF;
 Wed, 13 Sep 2023 21:35:43 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 13 Sep 2023 14:36:16 +0100
To: <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>, Fan Ni
 <fan.ni@samsung.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, <linux-cxl@vger.kernel.org>
CC: <linuxarm@huawei.com>
Subject: [PATCH V2] hw/pci-bridge/cxl-upstream: Add serial number extended
 capability support
Date: Wed, 13 Sep 2023 14:36:15 +0100
Message-ID: <20230913133615.29876-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Will be needed so there is a defined serial number for
information queries via the Switch CCI.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v2:  Thanks to Philippe for review.
 - Keep to a fixed offset for the serial number capability.
   If it's not present then there will be a hole which is fine
   under the PCIE specification.
 - As per reply to review of v1, I've not moved the Null definition
   to a header and have kept it is a valid 'default'.

hw/pci-bridge/cxl_upstream.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
index 2b9cf0cc97..a57806fb31 100644
--- a/hw/pci-bridge/cxl_upstream.c
+++ b/hw/pci-bridge/cxl_upstream.c
@@ -14,14 +14,21 @@
 #include "hw/pci/msi.h"
 #include "hw/pci/pcie.h"
 #include "hw/pci/pcie_port.h"
+/*
+ * Null value of all Fs suggested by IEEE RA guidelines for use of
+ * EU, OUI and CID
+ */
+#define UI64_NULL (~0ULL)
 
 #define CXL_UPSTREAM_PORT_MSI_NR_VECTOR 2
 
 #define CXL_UPSTREAM_PORT_MSI_OFFSET 0x70
 #define CXL_UPSTREAM_PORT_PCIE_CAP_OFFSET 0x90
 #define CXL_UPSTREAM_PORT_AER_OFFSET 0x100
-#define CXL_UPSTREAM_PORT_DVSEC_OFFSET \
+#define CXL_UPSTREAM_PORT_SN_OFFSET \
     (CXL_UPSTREAM_PORT_AER_OFFSET + PCI_ERR_SIZEOF)
+#define CXL_UPSTREAM_PORT_DVSEC_OFFSET \
+    (CXL_UPSTREAM_PORT_SN_OFFSET + PCI_EXT_CAP_DSN_SIZEOF)
 
 typedef struct CXLUpstreamPort {
     /*< private >*/
@@ -30,6 +37,7 @@ typedef struct CXLUpstreamPort {
     /*< public >*/
     CXLComponentState cxl_cstate;
     DOECap doe_cdat;
+    uint64_t sn;
 } CXLUpstreamPort;
 
 CXLComponentState *cxl_usp_to_cstate(CXLUpstreamPort *usp)
@@ -326,7 +334,9 @@ static void cxl_usp_realize(PCIDevice *d, Error **errp)
     if (rc) {
         goto err_cap;
     }
-
+    if (usp->sn != UI64_NULL) {
+        pcie_dev_ser_num_init(d, CXL_UPSTREAM_PORT_SN_OFFSET, usp->sn);
+    }
     cxl_cstate->dvsec_offset = CXL_UPSTREAM_PORT_DVSEC_OFFSET;
     cxl_cstate->pdev = d;
     build_dvsecs(cxl_cstate);
@@ -366,6 +376,7 @@ static void cxl_usp_exitfn(PCIDevice *d)
 }
 
 static Property cxl_upstream_props[] = {
+    DEFINE_PROP_UINT64("sn", CXLUpstreamPort, sn, UI64_NULL),
     DEFINE_PROP_STRING("cdat", CXLUpstreamPort, cxl_cstate.cdat.filename),
     DEFINE_PROP_END_OF_LIST()
 };
-- 
2.39.2


