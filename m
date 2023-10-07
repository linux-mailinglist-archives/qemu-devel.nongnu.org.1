Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 98ECC7BC9BE
	for <lists+qemu-devel@lfdr.de>; Sat,  7 Oct 2023 22:20:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpDks-0001Vo-4o; Sat, 07 Oct 2023 16:18:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1qpDkp-0001VS-HV; Sat, 07 Oct 2023 16:18:27 -0400
Received: from mail-dm6nam12on20627.outbound.protection.outlook.com
 ([2a01:111:f400:fe59::627]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1qpDkm-0005Ki-Rq; Sat, 07 Oct 2023 16:18:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dF7XSIkvERbPRVzJrTgZurFavteNrz1MAbqsgPRKctH86rmIGh7oBlDCiGXlY5uiGLqmz0B6h4scpKsPoIv6FO0z8eUiEca87fWEdne3NH4AjsrwNtm+gqsWsxVnTku/UHI1tLcv/NHeKyA7O9/d9A7Fxw9evAjVNuP2oKVBYbPx6z7pkrC0qArOrQH5fCDgknkaWBzA1b/0qsUzXNd3tixacU/VzdxWoBnoJSlJJOnviIPQ7nXfL8TrPhT92uIOVOBNtsf+WgGvCY0cQn/WCVKVB3gv+VL4OZaV52D2azyFET35lJksABi1L9d9x8jUktsdmEu0/9jAacLkhUXHZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IpPvSlhyl0YjSWchjNsw8i+FjufS3vXF1afCUunOuhA=;
 b=bUlTsAbNRRRkd+fy9Xh4I02de4c0Q5oeNA8PPsUBXHjJBAXXBd2uOUc9CnY/xpHIfHxTXMGdNyuK5p4ULQJz97nEQYAGGM+nECxPFFqeHUOyvQ4T8YlhC/Wcn5cFyLw93LX9ugBLwFIM21KrA028Z9jGvgGShcXpekax2IMYZc/n3RTrNIP7aGY8pV/ZIzwe1CuyiR5zQrzK37aHyDNBKw3HoNCVU9nUcFj2uRRWXWi5eOjh39Mk024gB5G28XWHvZkvWgDXIIP5Tw45UEKk9oiEax8rlzCTvnpEiewkn5Z61MRDpY4OOV/kRIxLvrhaIgLSVejb/AqcQsy0MUrI9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IpPvSlhyl0YjSWchjNsw8i+FjufS3vXF1afCUunOuhA=;
 b=MrWwsIVGAcRqPY+MtMeJ+qrP/dxsA6dcY5V4DM4EncfIwf8wZW82gjXUh/G60hDlqxlTJe+Y3byYIEBYwEhty06kGj0WVSWug9XfnfFcq7MXtXlizyCxkrma7hWBGRS8tPbSu8QwoSQcpb/svYUHdsGXn0NCOE6iPlbIj+c6iicBL21kfdn2ccPKBJB2sL0+h8KQraU5PESdBPlE33Arq/Om1mUZuktHULAFoHLPg9BDI4znh/CHlWPjHQeeoW5Rlqy2xmb6M2f7c0aE9WepU7m6pM9J+rYiC3Mrxh6qDNe47hGCiZUP/RCD6Hl2EJDF+gs5BTuMYMot5niW9LxBYg==
Received: from MN2PR13CA0026.namprd13.prod.outlook.com (2603:10b6:208:160::39)
 by DM4PR12MB6302.namprd12.prod.outlook.com (2603:10b6:8:a4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.32; Sat, 7 Oct
 2023 20:18:20 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:208:160:cafe::2a) by MN2PR13CA0026.outlook.office365.com
 (2603:10b6:208:160::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.29 via Frontend
 Transport; Sat, 7 Oct 2023 20:18:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Sat, 7 Oct 2023 20:18:18 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sat, 7 Oct 2023
 13:18:03 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Sat, 7 Oct 2023 13:18:03 -0700
Received: from sgarnayak-dt.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Sat, 7 Oct 2023 13:17:56 -0700
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
Subject: [PATCH v2 2/3] hw/acpi: Implement the SRAT GI affinity structure
Date: Sun, 8 Oct 2023 01:47:39 +0530
Message-ID: <20231007201740.30335-3-ankita@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231007201740.30335-1-ankita@nvidia.com>
References: <20231007201740.30335-1-ankita@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|DM4PR12MB6302:EE_
X-MS-Office365-Filtering-Correlation-Id: 36afabd1-8f4c-4fa0-f0bd-08dbc7728bec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bRJrGErk2ngAtkqApL4TPznDN05wCL04NK4HFVCoSr6t416FgmBG0u0NrXENrqUQGh0BKaeElgFOSP/+xqFX2RzwozK4g08oXxWsYkW+WNh95TMWH+POiykClLlW+3Wt/iD7I8LC4Jk4UkZLo84jQXYXC2CQItMb4JnKwMvzLrTHPF6g2lnnwCKwGfzhN5AP2TxORdye+tlQtufwe9/3NjmXzqQUV3bRWAYb/DS//5I+qzccAYW98bJW4scqXy6pzQEGw+rUJLotIJTdci4J9mVW6Nlo3gLuYEyuW6Ggo9Jpq5CttC6v6lG5Ig3g/GggiV+lB65WnDMT6bgpgM8toEApQmLYoibl9CeBVpnrJ8iWJmcOf42Z7O28RqLYVXx2QbEh59RHvTVtJ0BXJX+OVQ8ex0jHN2uYkidVioCUZw///21eFuDLkC48X2ukntQ9ZEJaGJglWG6fhS34wGVjgYH6tZ1/LhBUymYRLFryA/mEBkfJkT0YERWmpHZQyyorNIAvHq7MJ966IliobYX8GXjRMGpo8lqZat5wQglIDjrtETIKZe9eDfan16m9MG//xE1y33gUJBKLaABvyrMdM3HXY+TtFGSyUeCtWLHgNgVqVGyjuGMawIwk4nJnhb1cfUgo71gjdsBS8GUr75v8iYLASaLl23k2HwSjNBN/1hwiwiMfCvrgMMVjAPguPhcSxNyLa0G27YrfrZ2yvV7xh9wsPJpjf6nm0tgYMzpk2NSnjLzHrDDyAMb1kE67+MeKDYGhs0sRV2xE0tHQc8AV0w==
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(136003)(376002)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(82310400011)(46966006)(40470700004)(36840700001)(7636003)(921005)(356005)(86362001)(36756003)(40480700001)(2906002)(2876002)(478600001)(82740400003)(4326008)(5660300002)(8936002)(8676002)(6666004)(41300700001)(7696005)(83380400001)(2616005)(336012)(1076003)(426003)(40460700003)(36860700001)(7416002)(70586007)(70206006)(110136005)(316002)(54906003)(47076005)(26005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2023 20:18:18.8942 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36afabd1-8f4c-4fa0-f0bd-08dbc7728bec
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6302
Received-SPF: softfail client-ip=2a01:111:f400:fe59::627;
 envelope-from=ankita@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
devices and PXM are stored using acpi-generic-initiator object. Lookup
presence of all such objects and use them to build these structures.

The structure needs a PCI device handle [2] that consists of the device BDF.
The vfio-pci-nohotplug device corresponding to the acpi-generic-initiator
object is located to determine the BDF.

[1] ACPI Spec 6.5, Section 5.2.16.6
[2] ACPI Spec 6.5, Table 5.66

Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
---
 hw/acpi/acpi-generic-initiator.c         | 78 ++++++++++++++++++++++++
 hw/arm/virt-acpi-build.c                 |  3 +
 hw/vfio/pci.c                            |  2 -
 hw/vfio/pci.h                            |  2 +
 include/hw/acpi/acpi-generic-initiator.h | 22 +++++++
 5 files changed, 105 insertions(+), 2 deletions(-)

diff --git a/hw/acpi/acpi-generic-initiator.c b/hw/acpi/acpi-generic-initiator.c
index 6406736090..1ae79639be 100644
--- a/hw/acpi/acpi-generic-initiator.c
+++ b/hw/acpi/acpi-generic-initiator.c
@@ -72,3 +72,81 @@ static void acpi_generic_initiator_class_init(ObjectClass *oc, void *data)
                               NULL, acpi_generic_initiator_set_node, NULL,
                               NULL);
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
+static void build_srat_generic_initiator_affinity(GArray *table_data, int node,
+                                                  PCIDeviceHandle *handle,
+                                                  GenericAffinityFlags flags)
+{
+    build_append_int_noprefix(table_data, 5, 1);     /* Type */
+    build_append_int_noprefix(table_data, 32, 1);    /* Length */
+    build_append_int_noprefix(table_data, 0, 1);     /* Reserved */
+    build_append_int_noprefix(table_data, 1, 1);     /* Device Handle Type */
+    build_append_int_noprefix(table_data, node, 4);  /* Proximity Domain */
+    build_append_int_noprefix(table_data, handle->segment, 2);
+    build_append_int_noprefix(table_data, handle->bdf, 2);
+    build_append_int_noprefix(table_data, handle->res0, 4);
+    build_append_int_noprefix(table_data, handle->res1, 8);
+    build_append_int_noprefix(table_data, flags, 4); /* Flags */
+    build_append_int_noprefix(table_data, 0, 4);     /* Reserved */
+}
+
+void build_srat_generic_initiator(GArray *table_data)
+{
+    GSList *gi_list, *list = acpi_generic_initiator_get_list();
+    for (gi_list = list; gi_list; gi_list = gi_list->next) {
+        AcpiGenericInitiator *gi = gi_list->data;
+        Object *o;
+        int count;
+
+        if (gi->node == MAX_NODES) {
+            continue;
+        }
+
+        o = object_resolve_path_type(gi->device, TYPE_VFIO_PCI_NOHOTPLUG, NULL);
+        if (!o) {
+            continue;
+        }
+
+        for (count = 0; count < gi->node_count; count++) {
+            PCIDeviceHandle dev_handle = {0};
+            PCIDevice *pci_dev = PCI_DEVICE(o);
+
+            dev_handle.bdf = pci_dev->devfn;
+            build_srat_generic_initiator_affinity(table_data,
+                                                  gi->node + count, &dev_handle,
+                                                  GEN_AFFINITY_ENABLED);
+        }
+    }
+    g_slist_free(list);
+}
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 6b674231c2..7337d8076b 100644
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
 
+    build_srat_generic_initiator(table_data);
+
     if (ms->nvdimms_state->is_enabled) {
         nvdimm_build_srat(table_data);
     }
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index a205c6b113..5e2a7c650a 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -43,8 +43,6 @@
 #include "migration/blocker.h"
 #include "migration/qemu-file.h"
 
-#define TYPE_VFIO_PCI_NOHOTPLUG "vfio-pci-nohotplug"
-
 /* Protected by BQL */
 static KVMRouteChange vfio_route_change;
 
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index a2771b9ff3..74ac77a260 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -118,6 +118,8 @@ typedef struct VFIOMSIXInfo {
 #define TYPE_VFIO_PCI "vfio-pci"
 OBJECT_DECLARE_SIMPLE_TYPE(VFIOPCIDevice, VFIO_PCI)
 
+#define TYPE_VFIO_PCI_NOHOTPLUG "vfio-pci-nohotplug"
+
 struct VFIOPCIDevice {
     PCIDevice pdev;
     VFIODevice vbasedev;
diff --git a/include/hw/acpi/acpi-generic-initiator.h b/include/hw/acpi/acpi-generic-initiator.h
index e67e6e23b1..e8e2670309 100644
--- a/include/hw/acpi/acpi-generic-initiator.h
+++ b/include/hw/acpi/acpi-generic-initiator.h
@@ -27,4 +27,26 @@ typedef struct AcpiGenericInitiatorClass {
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
+    uint32_t res0;
+    uint64_t res1;
+} PCIDeviceHandle;
+
+void build_srat_generic_initiator(GArray *table_data);
+
 #endif
-- 
2.17.1


