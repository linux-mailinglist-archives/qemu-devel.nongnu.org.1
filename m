Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6FE92FA32
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jul 2024 14:25:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSFL0-0004vy-WA; Fri, 12 Jul 2024 08:25:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sSFKy-0004nH-5v
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 08:25:20 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sSFKw-0002mR-9B
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 08:25:19 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WL9jT4kNsz6K9GW;
 Fri, 12 Jul 2024 20:23:09 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 8382C1400CF;
 Fri, 12 Jul 2024 20:25:16 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 12 Jul 2024 13:25:16 +0100
To: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 <qemu-devel@nongnu.org>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>,
 <marcel.apfelbaum@gmail.com>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
 <ying.huang@intel.com>, Michael Roth <michael.roth@amd.com>,
 <fan.ni@samsung.com>
Subject: [RFC qemu 2/6] hw/pci-bridge/cxl_upstream: Provide x-speed and
 x-width properties.
Date: Fri, 12 Jul 2024 13:24:10 +0100
Message-ID: <20240712122414.1448284-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240712122414.1448284-1-Jonathan.Cameron@huawei.com>
References: <20240712122414.1448284-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Copied from gen_pcie_root_port.c
Drop the previous code that ensured a valid value in s->width, s->speed
as now a default is provided so this will always be set.

Note this changes the default settings but it is unlikely to have a negative
effect on software as will only affect ports with now downstream device.
All other ports will use the settings from that device.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/pci-bridge/cxl_downstream.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
index 742da07a01..c0b4fac735 100644
--- a/hw/pci-bridge/cxl_downstream.c
+++ b/hw/pci-bridge/cxl_downstream.c
@@ -13,6 +13,8 @@
 #include "hw/pci/msi.h"
 #include "hw/pci/pcie.h"
 #include "hw/pci/pcie_port.h"
+#include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "hw/cxl/cxl.h"
 #include "qapi/error.h"
 
@@ -210,24 +212,20 @@ static void cxl_dsp_exitfn(PCIDevice *d)
     pci_bridge_exitfn(d);
 }
 
-static void cxl_dsp_instance_post_init(Object *obj)
-{
-    PCIESlot *s = PCIE_SLOT(obj);
-
-    if (!s->speed) {
-        s->speed = QEMU_PCI_EXP_LNK_2_5GT;
-    }
-
-    if (!s->width) {
-        s->width = QEMU_PCI_EXP_LNK_X1;
-    }
-}
+static Property cxl_dsp_props[] = {
+    DEFINE_PROP_PCIE_LINK_SPEED("x-speed", PCIESlot,
+                                speed, PCIE_LINK_SPEED_64),
+    DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,
+                                width, PCIE_LINK_WIDTH_16),
+    DEFINE_PROP_END_OF_LIST()
+};
 
 static void cxl_dsp_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(oc);
 
+    device_class_set_props(dc, cxl_dsp_props);
     k->config_write = cxl_dsp_config_write;
     k->realize = cxl_dsp_realize;
     k->exit = cxl_dsp_exitfn;
@@ -243,7 +241,6 @@ static const TypeInfo cxl_dsp_info = {
     .name = TYPE_CXL_DSP,
     .instance_size = sizeof(CXLDownstreamPort),
     .parent = TYPE_PCIE_SLOT,
-    .instance_post_init = cxl_dsp_instance_post_init,
     .class_init = cxl_dsp_class_init,
     .interfaces = (InterfaceInfo[]) {
         { INTERFACE_PCIE_DEVICE },
-- 
2.43.0


