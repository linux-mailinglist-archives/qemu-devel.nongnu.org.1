Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 642FF7E48EB
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 20:02:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0RKZ-0006HS-62; Tue, 07 Nov 2023 14:01:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1r0RKU-0006GH-OL; Tue, 07 Nov 2023 14:01:40 -0500
Received: from mail-co1nam11on2061a.outbound.protection.outlook.com
 ([2a01:111:f400:7eab::61a]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1r0RKS-0004Gy-Lx; Tue, 07 Nov 2023 14:01:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f7Sbgbia9Eaw2h+3s+p2U4PDOLsQA9omJaovtCUEbKEx/RNQWeP1wJdM9FJXSR3UeyOZXl/S9eDCjR2MHPZNYi5Gm8pvkhj11R0vslymKOFOyZbbAM6GSiI1p/7ClJaVlKvDueVkVnsIOm+PUQpRKyQZ6MuS5h52aWF95q0gJR+EYDbV9BBCojzeh9BNPnpHgXqDrOXlHdtOpfA7ubfwR00zHiDxRm03TYpZs1QnKXq36MIj0HV47hwqFO0+y2+fzLF51j1nq657t1wTjP6un5GY9jry6+MA+vKvo/ypYmNy40qqJDePY/PqtiH0VDa1GXtCFAiLteYL1yZ/ySR4pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3pk5RZE7kQ2X6paryyFqToKkWAlsQYpT0G4bk+gZ53Y=;
 b=SfFWRn0XIEO1WjfVLb2uPCNsWPoC2Pm9ZKG/AGyL5V9+M9BnlMIMZwHObzv4Vzs9MCFhFFNABXaGTpD1k0zHG9QmCdTLr8ybUQeWAz5kOocgJ2ADe8dleM3pU7tw4Su3OD85+7/CCVREZDOmqlztYXVyaVr4tM/zuY7ln988/TQUpAk3iSJQ0hWITNuNKBegacnLU25LVCA+5pLkkqdXjrz9kKHgUDy8QE+x46mT/QATwWlVLjJn5O2m8bRgDpsNa9S3Psrboj+hmd3qQYnNq9D4UZ4vFyl6JppnGGZohd9dOtINn2Vvyy7NDimXXGNJjKH4481Wgs6yQ3ZraLGS/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3pk5RZE7kQ2X6paryyFqToKkWAlsQYpT0G4bk+gZ53Y=;
 b=YTXLwnMRquISxb/w2No+tX8KScP+f3HXgfh/e5p3sIkSCYbqOx8pBa7ZdCOYQnOBBn9XnHrGx3rWvIaK6UFUBVOhRAI2ecUeIpsYSXZzChG4YKixYudFhNbhubDv3GTFFXMD8CRuGr9+n50Ay6rb7QytcclGzmZC0JiNWVBQ3ei3z10gRev40UwuVeXWe+6H76lIRAGFOn0pOzM1NlJ0+ALB9JKvsv5YOdcRNAOIAQ57pIOjhb0e9+u7Qunqkj6kCP/EcLaXhJs7+i0MV8CTW0otrkYqGlsV+PGG0AiX4H2OAY+3QCtZnpkew8qkEfHQghNfmODQlnzRZHTWN5P0WQ==
Received: from DM6PR21CA0015.namprd21.prod.outlook.com (2603:10b6:5:174::25)
 by CH0PR12MB5059.namprd12.prod.outlook.com (2603:10b6:610:e2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 19:01:30 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:5:174:cafe::b1) by DM6PR21CA0015.outlook.office365.com
 (2603:10b6:5:174::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.16 via Frontend
 Transport; Tue, 7 Nov 2023 19:01:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.16 via Frontend Transport; Tue, 7 Nov 2023 19:01:29 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 7 Nov 2023
 11:01:06 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 7 Nov 2023
 11:01:05 -0800
Received: from sgarnayak-dt.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Tue, 7 Nov 2023 11:00:58 -0800
From: <ankita@nvidia.com>
To: <ankita@nvidia.com>, <jgg@nvidia.com>, <alex.williamson@redhat.com>,
 <clg@redhat.com>, <shannon.zhaosl@gmail.com>, <peter.maydell@linaro.org>,
 <ani@anisinha.ca>, <berrange@redhat.com>, <eduardo@habkost.net>,
 <imammedo@redhat.com>, <mst@redhat.com>, <eblake@redhat.com>,
 <armbru@redhat.com>, <david@redhat.com>, <gshan@redhat.com>,
 <Jonathan.Cameron@huawei.com>
CC: <aniketa@nvidia.com>, <cjia@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <vsethi@nvidia.com>, <acurrid@nvidia.com>,
 <dnigam@nvidia.com>, <udhoke@nvidia.com>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>
Subject: [PATCH v3 2/2] hw/acpi: Implement the SRAT GI affinity structure
Date: Wed, 8 Nov 2023 00:30:39 +0530
Message-ID: <20231107190039.19434-3-ankita@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231107190039.19434-1-ankita@nvidia.com>
References: <20231107190039.19434-1-ankita@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|CH0PR12MB5059:EE_
X-MS-Office365-Filtering-Correlation-Id: c0763858-4259-4623-94fe-08dbdfc3f36e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cZSoQJGOTXfeZbhJaG781nkyjzmnYP4AMjh8Gzxv+mBi1/DU5gOEevb4z+Es0ah2R+2hgjv8FJJMv3IMwe+IVdn6cZrQUURWkjU6arYbTSSWgvJ1IN6ad1IlynAXKLLUEFAU/V7f8jf4Cwq3vs+EqJ+oiP/6721AcdTrX5GAIs21LqlbP47npd1/G6TSXdASOmRxXO0FXut1ZPkz7DGA6U5MUUZ22mIbVwGepTldW2fHJtKgkY+OjVTJ+Ci69k6KmiSatv2PIGcotfMTuMYlftZ0lIAlky52zMH1vIuYUTtRzOedFEE1jaiaReHlPzxacvHiOTiegZ9aKrYZpNOUJ1UjdY1+6LS3UrYe1SKe8aBhJwAk4rgWjZTrK89FwNyeIeDdOsow0P8J5WMj1SinrsWduCCms4TDlfxsdakb81Zq7l2eQOJseYmzUiGAvPoXjd5/8rj2Air3OxiwvztNvyrnm18syphjM0TvweHUL0gCpaaacy34JjI2jVw/vTTWPqmn6xIPVGyYmTNYPXW0CFNnBW8X2Wh9ykODKZGuMOKHI+/1PnAnci2zReBzAVGfjjWPNrByarmd/fy3s8al1V3JBtRanFSg5EuRC9slP8OxINaYx0sNR6WG7r2duYw/vx3McXEK1FpF7kKfuO60QNBwRmq6mBg1XAV557ktBO6cqEbaeVgBQQot3qt3O3qSSVqVCJwa986nXUeS0MDG4Er3F9EcXGKHAil23FLPBmucY3SzZnwioUO8i2SeG1e/UfZcoPtC/5symLjtJCScTQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(346002)(396003)(376002)(230922051799003)(82310400011)(186009)(1800799009)(64100799003)(451199024)(36840700001)(46966006)(40470700004)(478600001)(7416002)(7696005)(6666004)(2616005)(47076005)(336012)(26005)(2906002)(1076003)(2876002)(426003)(70206006)(5660300002)(41300700001)(70586007)(110136005)(316002)(36860700001)(4326008)(8936002)(8676002)(54906003)(921008)(7636003)(36756003)(86362001)(356005)(82740400003)(40480700001)(40460700003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 19:01:29.7065 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0763858-4259-4623-94fe-08dbdfc3f36e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5059
Received-SPF: softfail client-ip=2a01:111:f400:7eab::61a;
 envelope-from=ankita@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Ankit Agrawal <ankita@nvidia.com>

ACPI spec provides a scheme to associate "Generic Initiators" [1]
(e.g. heterogeneous processors and accelerators, GPUs, and I/O devices with
integrated compute or DMA engines GPUs) with Proximity Domains. This is
achieved using Generic Initiator Affinity Structure in SRAT. During bootup,
Linux kernel parse the ACPI SRAT to determine the PXM ids and create a NUMA
node for each unique PXM ID encountered. Qemu currently do not implement
these structures while building SRAT.

Add GI structures while building VM ACPI SRAT. The association between
devices and nodes are stored using acpi-generic-initiator object. Lookup
presence of all such objects and use them to build these structures.

The structure needs a PCI device handle [2] that consists of the device BDF.
The vfio-pci device corresponding to the acpi-generic-initiator object is
located to determine the BDF.

[1] ACPI Spec 6.5, Section 5.2.16.6
[2] ACPI Spec 6.5, Table 5.66

Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
---
 hw/acpi/acpi-generic-initiator.c         | 79 ++++++++++++++++++++++++
 hw/arm/virt-acpi-build.c                 |  3 +
 include/hw/acpi/acpi-generic-initiator.h | 21 +++++++
 3 files changed, 103 insertions(+)

diff --git a/hw/acpi/acpi-generic-initiator.c b/hw/acpi/acpi-generic-initiator.c
index 0699c878e2..6d0a8fd818 100644
--- a/hw/acpi/acpi-generic-initiator.c
+++ b/hw/acpi/acpi-generic-initiator.c
@@ -78,3 +78,82 @@ static void acpi_generic_initiator_class_init(ObjectClass *oc, void *data)
     object_class_property_add_str(oc, ACPI_GENERIC_INITIATOR_NODELIST_PROP,
                                   NULL, acpi_generic_initiator_set_nodelist);
 }
+
+static int acpi_generic_initiator_list(Object *obj, void *opaque)
+{
+    GSList **list = opaque;
+
+    if (object_dynamic_cast(obj, TYPE_ACPI_GENERIC_INITIATOR)) {
+        *list = g_slist_append(*list, ACPI_GENERIC_INITIATOR(obj));
+    }
+
+    object_child_foreach(obj, acpi_generic_initiator_list, opaque);
+    return 0;
+}
+
+/*
+ * Identify Generic Initiator objects and link them into the list which is
+ * returned to the caller.
+ *
+ * Note: it is the caller's responsibility to free the list to avoid
+ * memory leak.
+ */
+static GSList *acpi_generic_initiator_get_list(void)
+{
+    GSList *list = NULL;
+
+    object_child_foreach(object_get_root(), acpi_generic_initiator_list, &list);
+    return list;
+}
+
+/*
+ * ACPI spec, Revision 6.5
+ * 5.2.16.6 Generic Initiator Affinity Structure
+ */
+static
+void build_srat_generic_pci_initiator_affinity(GArray *table_data, int node,
+                                               PCIDeviceHandle *handle)
+{
+    uint8_t index;
+
+    build_append_int_noprefix(table_data, 5, 1);     /* Type */
+    build_append_int_noprefix(table_data, 32, 1);    /* Length */
+    build_append_int_noprefix(table_data, 0, 1);     /* Reserved */
+    build_append_int_noprefix(table_data, 1, 1);     /* Device Handle Type */
+    build_append_int_noprefix(table_data, node, 4);  /* Proximity Domain */
+    build_append_int_noprefix(table_data, handle->segment, 2);
+    build_append_int_noprefix(table_data, handle->bdf, 2);
+
+    /* Reserved */
+    for (index = 0; index < 12; index++) {
+        build_append_int_noprefix(table_data, handle->res[index], 1);
+    }
+
+    build_append_int_noprefix(table_data, GEN_AFFINITY_ENABLED, 4); /* Flags */
+    build_append_int_noprefix(table_data, 0, 4);     /* Reserved */
+}
+
+void build_srat_generic_pci_initiator(GArray *table_data)
+{
+    GSList *gi_list, *list = acpi_generic_initiator_get_list();
+    for (gi_list = list; gi_list; gi_list = gi_list->next) {
+        AcpiGenericInitiator *gi = gi_list->data;
+        Object *o;
+        uint16List *l;
+
+        o = object_resolve_path_type(gi->device, TYPE_VFIO_PCI, NULL);
+        if (!o) {
+            continue;
+        }
+
+        for (l = gi->nodelist; l; l = l->next) {
+            PCIDeviceHandle dev_handle = {0};
+            PCIDevice *pci_dev = PCI_DEVICE(o);
+            dev_handle.bdf = PCI_BUILD_BDF(pci_bus_num(pci_get_bus(pci_dev)),
+                                                       pci_dev->devfn);
+            build_srat_generic_pci_initiator_affinity(table_data,
+                                                      l->value, &dev_handle);
+        }
+    }
+    g_slist_free(list);
+}
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 6b674231c2..bd53788cef 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -58,6 +58,7 @@
 #include "migration/vmstate.h"
 #include "hw/acpi/ghes.h"
 #include "hw/acpi/viot.h"
+#include "hw/acpi/acpi-generic-initiator.h"
 
 #define ARM_SPI_BASE 32
 
@@ -558,6 +559,8 @@ build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         }
     }
 
+    build_srat_generic_pci_initiator(table_data);
+
     if (ms->nvdimms_state->is_enabled) {
         nvdimm_build_srat(table_data);
     }
diff --git a/include/hw/acpi/acpi-generic-initiator.h b/include/hw/acpi/acpi-generic-initiator.h
index bb127b2541..545f46ade5 100644
--- a/include/hw/acpi/acpi-generic-initiator.h
+++ b/include/hw/acpi/acpi-generic-initiator.h
@@ -26,4 +26,25 @@ typedef struct AcpiGenericInitiatorClass {
         ObjectClass parent_class;
 } AcpiGenericInitiatorClass;
 
+/*
+ * ACPI 6.5: Table 5-68 Flags - Generic Initiator
+ */
+typedef enum {
+    GEN_AFFINITY_NOFLAGS = 0,
+    GEN_AFFINITY_ENABLED = (1 << 0),
+    GEN_AFFINITY_ARCH_TRANS = (1 << 1),
+} GenericAffinityFlags;
+
+/*
+ * ACPI 6.5: Table 5-66 Device Handle - PCI
+ * Device Handle definition
+ */
+typedef struct PCIDeviceHandle {
+    uint16_t segment;
+    uint16_t bdf;
+    uint8_t res[12];
+} PCIDeviceHandle;
+
+void build_srat_generic_pci_initiator(GArray *table_data);
+
 #endif
-- 
2.17.1


