Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6183792F95B
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jul 2024 13:11:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSEBO-0001FO-77; Fri, 12 Jul 2024 07:11:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sSEBL-00014Z-6e
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 07:11:19 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sSEBF-0005nl-Ph
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 07:11:18 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WL85C0qbqz6JB4X;
 Fri, 12 Jul 2024 19:10:07 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 122B014058E;
 Fri, 12 Jul 2024 19:11:11 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 12 Jul 2024 12:11:10 +0100
To: <imammedo@redhat.com>, <mst@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, <qemu-devel@nongnu.org>, <ankita@nvidia.com>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>,
 <marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
 <ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 <eduardo@habkost.net>, Michael Roth <michael.roth@amd.com>, Ani Sinha
 <anisinha@redhat.com>
Subject: [PATCH v5 05/13] hw/pci: Add a busnr property to pci_props and use
 for acpi/gi
Date: Fri, 12 Jul 2024 12:08:09 +0100
Message-ID: <20240712110837.1439736-6-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240712110837.1439736-1-Jonathan.Cameron@huawei.com>
References: <20240712110837.1439736-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
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

Using a property allows us to hide the internal details of the PCI device
from the code to build a SRAT Generic Initiator Affinity Structure with
PCI Device Handle.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
V5: Add assert() to catch if devfn is out of permissible range of
    0 to 255.
---
 hw/acpi/acpi_generic_initiator.c | 14 +++++++++-----
 hw/pci/pci.c                     | 14 ++++++++++++++
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/hw/acpi/acpi_generic_initiator.c b/hw/acpi/acpi_generic_initiator.c
index 73bafaaaea..365feb527f 100644
--- a/hw/acpi/acpi_generic_initiator.c
+++ b/hw/acpi/acpi_generic_initiator.c
@@ -9,6 +9,7 @@
 #include "hw/boards.h"
 #include "hw/pci/pci_device.h"
 #include "qemu/error-report.h"
+#include "qapi/error.h"
 
 typedef struct AcpiGenericInitiatorClass {
     ObjectClass parent_class;
@@ -79,7 +80,8 @@ static int build_acpi_generic_initiator(Object *obj, void *opaque)
     MachineState *ms = MACHINE(qdev_get_machine());
     AcpiGenericInitiator *gi;
     GArray *table_data = opaque;
-    PCIDevice *pci_dev;
+    int32_t devfn;
+    uint8_t bus;
     Object *o;
 
     if (!object_dynamic_cast(obj, TYPE_ACPI_GENERIC_INITIATOR)) {
@@ -100,10 +102,12 @@ static int build_acpi_generic_initiator(Object *obj, void *opaque)
         exit(1);
     }
 
-    pci_dev = PCI_DEVICE(o);
-    build_srat_pci_generic_initiator(table_data, gi->node, 0,
-                                     pci_bus_num(pci_get_bus(pci_dev)),
-                                     pci_dev->devfn);
+    bus = object_property_get_uint(o, "busnr", &error_fatal);
+    devfn = object_property_get_int(o, "addr", &error_fatal);
+    /* devfn is constrained in PCI to be 8 bit but storage is an int32_t */
+    assert(devfn >= 0 && devfn < PCI_DEVFN_MAX);
+
+    build_srat_pci_generic_initiator(table_data, gi->node, 0, bus, devfn);
 
     return 0;
 }
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 4c7be52951..e3d1a83e31 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -67,6 +67,19 @@ static char *pcibus_get_fw_dev_path(DeviceState *dev);
 static void pcibus_reset_hold(Object *obj, ResetType type);
 static bool pcie_has_upstream_port(PCIDevice *dev);
 
+static void prop_pci_busnr_get(Object *obj, Visitor *v, const char *name,
+                             void *opaque, Error **errp)
+{
+    uint8_t busnr = pci_dev_bus_num(PCI_DEVICE(obj));
+
+    visit_type_uint8(v, name, &busnr, errp);
+}
+
+static const PropertyInfo prop_pci_busnr = {
+    .name = "busnr",
+    .get = prop_pci_busnr_get,
+};
+
 static Property pci_props[] = {
     DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
     DEFINE_PROP_STRING("romfile", PCIDevice, romfile),
@@ -85,6 +98,7 @@ static Property pci_props[] = {
                     QEMU_PCIE_ERR_UNC_MASK_BITNR, true),
     DEFINE_PROP_BIT("x-pcie-ari-nextfn-1", PCIDevice, cap_present,
                     QEMU_PCIE_ARI_NEXTFN_1_BITNR, false),
+    { .name = "busnr", .info = &prop_pci_busnr },
     DEFINE_PROP_END_OF_LIST()
 };
 
-- 
2.43.0


