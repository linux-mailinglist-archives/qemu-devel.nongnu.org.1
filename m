Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 809B4923EB3
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jul 2024 15:19:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOdPW-0001jO-51; Tue, 02 Jul 2024 09:19:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sOdOs-0001Fr-BM
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 09:18:28 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sOdOn-0006vN-6C
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 09:18:26 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WD3NN6HXnz6J6gs;
 Tue,  2 Jul 2024 21:17:08 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 7408B140680;
 Tue,  2 Jul 2024 21:18:09 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 2 Jul 2024 14:18:08 +0100
To: <imammedo@redhat.com>, <mst@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, <qemu-devel@nongnu.org>, <ankita@nvidia.com>,
 <marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>
CC: <linuxarm@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
 <ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 <eduardo@habkost.net>, <linux-cxl@vger.kernel.org>, Michael Roth
 <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v4 07/13] hw/pci-bridge: Add acpi_uid property to TYPE_PXB_BUS
Date: Tue, 2 Jul 2024 14:14:12 +0100
Message-ID: <20240702131428.664859-8-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240702131428.664859-1-Jonathan.Cameron@huawei.com>
References: <20240702131428.664859-1-Jonathan.Cameron@huawei.com>
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

Enable ACPI table creation for PCI Expander Bridges to be independent
of PCI internals.  Note that the UID is currently the PCI bus number.
This is motivated by the forthcoming ACPI Generic Port SRAT entries
which can be made completely independent of PCI internals.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
v4: Generalize to all TYPE_PXB_BUS.  The handling for primary root
    bridges is separate and doesn't overlap with this change.
---
 hw/pci-bridge/pci_expander_bridge.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index 0411ad31ea..d71eb4b175 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -85,12 +85,23 @@ static uint16_t pxb_bus_numa_node(PCIBus *bus)
     return pxb->numa_node;
 }
 
+static void prop_pxb_uid_get(Object *obj, Visitor *v, const char *name,
+                             void *opaque, Error **errp)
+{
+    uint32_t uid = pci_bus_num(PCI_BUS(obj));
+
+    visit_type_uint32(v, name, &uid, errp);
+}
+
 static void pxb_bus_class_init(ObjectClass *class, void *data)
 {
     PCIBusClass *pbc = PCI_BUS_CLASS(class);
 
     pbc->bus_num = pxb_bus_num;
     pbc->numa_node = pxb_bus_numa_node;
+
+    object_class_property_add(class, "acpi_uid", "uint32",
+                              prop_pxb_uid_get, NULL, NULL, NULL);
 }
 
 static const TypeInfo pxb_bus_info = {
-- 
2.43.0


