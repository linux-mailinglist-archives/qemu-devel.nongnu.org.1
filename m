Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D56A910B1D
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jun 2024 18:06:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKKIa-0005l4-1Q; Thu, 20 Jun 2024 12:06:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sKKIW-0005dX-Fw
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 12:06:04 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sKKIU-0007u4-1n
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 12:06:04 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W4lhH6Y2pz6K6S4;
 Fri, 21 Jun 2024 00:05:35 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 9C19B140C72;
 Fri, 21 Jun 2024 00:05:59 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Jun 2024 17:05:59 +0100
To: <imammedo@redhat.com>, <mst@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, <qemu-devel@nongnu.org>, <ankita@nvidia.com>,
 <marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>
CC: <linuxarm@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
 <ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 <eduardo@habkost.net>, <linux-cxl@vger.kernel.org>, Michael Roth
 <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v3 05/11] hw/pci: Add a bus property to pci_props and use for
 acpi/gi
Date: Thu, 20 Jun 2024 17:03:13 +0100
Message-ID: <20240620160324.109058-6-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240620160324.109058-1-Jonathan.Cameron@huawei.com>
References: <20240620160324.109058-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Using a property allows us to hide the internal details of the PCI device
from the code to build a SRAT Generic Initiator Affinity Structure with
PCI Device Handle.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
V3: New patch
---
 hw/acpi/acpi_generic_initiator.c | 11 ++++++-----
 hw/pci/pci.c                     | 14 ++++++++++++++
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/hw/acpi/acpi_generic_initiator.c b/hw/acpi/acpi_generic_initiator.c
index 73bafaaaea..34284359f0 100644
--- a/hw/acpi/acpi_generic_initiator.c
+++ b/hw/acpi/acpi_generic_initiator.c
@@ -9,6 +9,7 @@
 #include "hw/boards.h"
 #include "hw/pci/pci_device.h"
 #include "qemu/error-report.h"
+#include "qapi/error.h"
 
 typedef struct AcpiGenericInitiatorClass {
     ObjectClass parent_class;
@@ -79,7 +80,7 @@ static int build_acpi_generic_initiator(Object *obj, void *opaque)
     MachineState *ms = MACHINE(qdev_get_machine());
     AcpiGenericInitiator *gi;
     GArray *table_data = opaque;
-    PCIDevice *pci_dev;
+    uint8_t bus, devfn;
     Object *o;
 
     if (!object_dynamic_cast(obj, TYPE_ACPI_GENERIC_INITIATOR)) {
@@ -100,10 +101,10 @@ static int build_acpi_generic_initiator(Object *obj, void *opaque)
         exit(1);
     }
 
-    pci_dev = PCI_DEVICE(o);
-    build_srat_pci_generic_initiator(table_data, gi->node, 0,
-                                     pci_bus_num(pci_get_bus(pci_dev)),
-                                     pci_dev->devfn);
+    bus = object_property_get_uint(o, "bus", &error_fatal);
+    devfn = object_property_get_uint(o, "addr", &error_fatal);
+
+    build_srat_pci_generic_initiator(table_data, gi->node, 0, bus, devfn);
 
     return 0;
 }
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 324c1302d2..b4b499b172 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -67,6 +67,19 @@ static char *pcibus_get_fw_dev_path(DeviceState *dev);
 static void pcibus_reset_hold(Object *obj, ResetType type);
 static bool pcie_has_upstream_port(PCIDevice *dev);
 
+static void prop_pci_bus_get(Object *obj, Visitor *v, const char *name,
+                             void *opaque, Error **errp)
+{
+    uint8_t bus = pci_dev_bus_num(PCI_DEVICE(obj));
+
+    visit_type_uint8(v, name, &bus, errp);
+}
+
+static const PropertyInfo prop_pci_bus = {
+    .name = "bus",
+    .get = prop_pci_bus_get,
+};
+
 static Property pci_props[] = {
     DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
     DEFINE_PROP_STRING("romfile", PCIDevice, romfile),
@@ -85,6 +98,7 @@ static Property pci_props[] = {
                     QEMU_PCIE_ERR_UNC_MASK_BITNR, true),
     DEFINE_PROP_BIT("x-pcie-ari-nextfn-1", PCIDevice, cap_present,
                     QEMU_PCIE_ARI_NEXTFN_1_BITNR, false),
+    { .name = "bus", .info = &prop_pci_bus },
     DEFINE_PROP_END_OF_LIST()
 };
 
-- 
2.43.0


