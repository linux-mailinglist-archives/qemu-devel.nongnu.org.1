Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42673ACB893
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Jun 2025 17:43:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uM7Iw-0002uR-Di; Mon, 02 Jun 2025 11:42:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uM7Ik-0002tA-14; Mon, 02 Jun 2025 11:42:16 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uM7Ih-0003HZ-V5; Mon, 02 Jun 2025 11:42:13 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b9yfc5PGvz6DLQr;
 Mon,  2 Jun 2025 23:38:16 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 568881401DC;
 Mon,  2 Jun 2025 23:42:06 +0800 (CST)
Received: from A2303104131.china.huawei.com (10.203.177.241) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 2 Jun 2025 17:41:58 +0200
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>
Subject: [PATCH v3 2/6] =?UTF-8?q?hw/arm/virt-acpi-build:=20Re-arrange?=
 =?UTF-8?q?=C2=A0SMMUv3=20IORT=20build?=
Date: Mon, 2 Jun 2025 16:41:06 +0100
Message-ID: <20250602154110.48392-3-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20250602154110.48392-1-shameerali.kolothum.thodi@huawei.com>
References: <20250602154110.48392-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.203.177.241]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=shameerali.kolothum.thodi@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-to:  Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
From:  Shameer Kolothum via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Introduces a new struct AcpiIortSMMUv3Dev to hold all the information
required for SMMUv3 IORT node and use that for populating the node.

The current machine wide SMMUv3 is named as legacy SMMUv3 as we will
soon add support for user-creatable SMMUv3 devices. These changes will
be useful to have common code paths when we add that support.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 hw/arm/virt-acpi-build.c | 112 +++++++++++++++++++++++++++------------
 hw/arm/virt.c            |   1 +
 include/hw/arm/virt.h    |   1 +
 3 files changed, 80 insertions(+), 34 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 7e8e0f0298..bd26853ef6 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -266,6 +266,28 @@ static int iort_idmap_compare(gconstpointer a, gconstpointer b)
     return idmap_a->input_base - idmap_b->input_base;
 }
 
+struct AcpiIortSMMUv3Dev {
+    int irq;
+    hwaddr base;
+    GArray *idmaps;
+    size_t offset;
+};
+typedef struct AcpiIortSMMUv3Dev AcpiIortSMMUv3Dev;
+
+static void
+get_smmuv3_legacy_dev(VirtMachineState *vms, void *opaque)
+{
+    GArray *sdev_blob = opaque;
+    AcpiIortSMMUv3Dev sdev;
+
+    sdev.idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
+    object_child_foreach_recursive(object_get_root(),
+                                   iort_host_bridges, sdev.idmaps);
+    sdev.base = vms->memmap[VIRT_SMMU].base;
+    sdev.irq = vms->irqmap[VIRT_SMMU] + ARM_SPI_BASE;
+    g_array_append_val(sdev_blob, sdev);
+}
+
 /*
  * Input Output Remapping Table (IORT)
  * Conforms to "IO Remapping Table System Software on ARM Platforms",
@@ -274,11 +296,12 @@ static int iort_idmap_compare(gconstpointer a, gconstpointer b)
 static void
 build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 {
-    int i, nb_nodes, rc_mapping_count;
-    size_t node_size, smmu_offset = 0;
-    AcpiIortIdMapping *idmap;
+    int i, j, nb_nodes, rc_mapping_count;
+    AcpiIortSMMUv3Dev *sdev;
+    size_t node_size;
+    int num_smmus = 0;
     uint32_t id = 0;
-    GArray *smmu_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
+    GArray *smmuv3_devs = g_array_new(false, true, sizeof(AcpiIortSMMUv3Dev));
     GArray *its_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
 
     AcpiTable table = { .sig = "IORT", .rev = 3, .oem_id = vms->oem_id,
@@ -286,28 +309,41 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     /* Table 2 The IORT */
     acpi_table_begin(&table, table_data);
 
-    if (vms->iommu == VIRT_IOMMU_SMMUV3) {
-        AcpiIortIdMapping next_range = {0};
-
-        object_child_foreach_recursive(object_get_root(),
-                                       iort_host_bridges, smmu_idmaps);
-
-        /* Sort the smmu idmap by input_base */
-        g_array_sort(smmu_idmaps, iort_idmap_compare);
+    nb_nodes = 2; /* RC, ITS */
+    if (vms->legacy_smmuv3_present) {
+        get_smmuv3_legacy_dev(vms, smmuv3_devs);
+        /*
+         * There will be only one legacy SMMUv3 as it is a machine wide one.
+         * And since it covers all the PCIe RCs in the machine, may have
+         * multiple SMMUv3 idmaps. Sort it by input_base.
+         */
+        sdev = &g_array_index(smmuv3_devs, AcpiIortSMMUv3Dev, 0);
+        g_array_sort(sdev->idmaps, iort_idmap_compare);
+    }
 
+    num_smmus = smmuv3_devs->len;
+    if (num_smmus) {
+        AcpiIortIdMapping next_range = {0};
+        int smmu_map_cnt = 0;
         /*
          * Split the whole RIDs by mapping from RC to SMMU,
          * build the ID mapping from RC to ITS directly.
          */
-        for (i = 0; i < smmu_idmaps->len; i++) {
-            idmap = &g_array_index(smmu_idmaps, AcpiIortIdMapping, i);
-
-            if (next_range.input_base < idmap->input_base) {
-                next_range.id_count = idmap->input_base - next_range.input_base;
-                g_array_append_val(its_idmaps, next_range);
+        for (i = 0; i < num_smmus; i++) {
+            AcpiIortIdMapping *idmap;
+            sdev = &g_array_index(smmuv3_devs, AcpiIortSMMUv3Dev, i);
+
+            for (j = 0; j < sdev->idmaps->len; j++) {
+                idmap = &g_array_index(sdev->idmaps, AcpiIortIdMapping, j);
+
+                if (next_range.input_base < idmap->input_base) {
+                    next_range.id_count = idmap->input_base -
+                                          next_range.input_base;
+                    g_array_append_val(its_idmaps, next_range);
+                }
+                next_range.input_base = idmap->input_base + idmap->id_count;
+                smmu_map_cnt++;
             }
-
-            next_range.input_base = idmap->input_base + idmap->id_count;
         }
 
         /* Append the last RC -> ITS ID mapping */
@@ -316,10 +352,9 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
             g_array_append_val(its_idmaps, next_range);
         }
 
-        nb_nodes = 3; /* RC, ITS, SMMUv3 */
-        rc_mapping_count = smmu_idmaps->len + its_idmaps->len;
+        nb_nodes += num_smmus;
+        rc_mapping_count = smmu_map_cnt + its_idmaps->len;
     } else {
-        nb_nodes = 2; /* RC, ITS */
         rc_mapping_count = 1;
     }
     /* Number of IORT Nodes */
@@ -341,10 +376,11 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     /* GIC ITS Identifier Array */
     build_append_int_noprefix(table_data, 0 /* MADT translation_id */, 4);
 
-    if (vms->iommu == VIRT_IOMMU_SMMUV3) {
-        int irq =  vms->irqmap[VIRT_SMMU] + ARM_SPI_BASE;
+    for (i = 0; i < num_smmus; i++) {
+        sdev = &g_array_index(smmuv3_devs, AcpiIortSMMUv3Dev, i);
+        int irq = sdev->irq;
 
-        smmu_offset = table_data->len - table.table_offset;
+        sdev->offset = table_data->len - table.table_offset;
         /* Table 9 SMMUv3 Format */
         build_append_int_noprefix(table_data, 4 /* SMMUv3 */, 1); /* Type */
         node_size =  SMMU_V3_ENTRY_SIZE + ID_MAPPING_ENTRY_SIZE;
@@ -355,7 +391,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         /* Reference to ID Array */
         build_append_int_noprefix(table_data, SMMU_V3_ENTRY_SIZE, 4);
         /* Base address */
-        build_append_int_noprefix(table_data, vms->memmap[VIRT_SMMU].base, 8);
+        build_append_int_noprefix(table_data, sdev->base, 8);
         /* Flags */
         build_append_int_noprefix(table_data, 1 /* COHACC Override */, 4);
         build_append_int_noprefix(table_data, 0, 4); /* Reserved */
@@ -404,15 +440,19 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     build_append_int_noprefix(table_data, 0, 3); /* Reserved */
 
     /* Output Reference */
-    if (vms->iommu == VIRT_IOMMU_SMMUV3) {
+    if (num_smmus) {
         AcpiIortIdMapping *range;
 
         /* translated RIDs connect to SMMUv3 node: RC -> SMMUv3 -> ITS */
-        for (i = 0; i < smmu_idmaps->len; i++) {
-            range = &g_array_index(smmu_idmaps, AcpiIortIdMapping, i);
-            /* output IORT node is the smmuv3 node */
-            build_iort_id_mapping(table_data, range->input_base,
-                                  range->id_count, smmu_offset);
+        for (i = 0; i < num_smmus; i++) {
+            sdev = &g_array_index(smmuv3_devs, AcpiIortSMMUv3Dev, i);
+
+            for (j = 0; j < sdev->idmaps->len; j++) {
+                range = &g_array_index(sdev->idmaps, AcpiIortIdMapping, j);
+                /* output IORT node is the smmuv3 node */
+                build_iort_id_mapping(table_data, range->input_base,
+                                      range->id_count, sdev->offset);
+            }
         }
 
         /* bypassed RIDs connect to ITS group node directly: RC -> ITS */
@@ -428,8 +468,12 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     }
 
     acpi_table_end(linker, &table);
-    g_array_free(smmu_idmaps, true);
     g_array_free(its_idmaps, true);
+    for (i = 0; i < num_smmus; i++) {
+        sdev = &g_array_index(smmuv3_devs, AcpiIortSMMUv3Dev, i);
+        g_array_free(sdev->idmaps, true);
+    }
+    g_array_free(smmuv3_devs, true);
 }
 
 /*
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 9a6cd085a3..73bd2bd5f2 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1614,6 +1614,7 @@ static void create_pcie(VirtMachineState *vms)
             create_smmu(vms, vms->bus);
             qemu_fdt_setprop_cells(ms->fdt, nodename, "iommu-map",
                                    0x0, vms->iommu_phandle, 0x0, 0x10000);
+            vms->legacy_smmuv3_present = true;
             break;
         default:
             g_assert_not_reached();
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 9a1b0f53d2..8b1404b5f6 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -174,6 +174,7 @@ struct VirtMachineState {
     char *oem_id;
     char *oem_table_id;
     bool ns_el2_virt_timer_irq;
+    bool legacy_smmuv3_present;
 };
 
 #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM : VIRT_PCIE_ECAM)
-- 
2.34.1


