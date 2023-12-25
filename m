Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 476AC81DE25
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Dec 2023 05:58:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rHd1B-0007x6-O8; Sun, 24 Dec 2023 23:56:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1rHd19-0007wT-Kr; Sun, 24 Dec 2023 23:56:43 -0500
Received: from mail-co1nam11on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2416::601]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1rHd12-0001k2-Gv; Sun, 24 Dec 2023 23:56:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LCxt2zCPwoHl61rVho88ZIZvRg+YJhZvY2w49N/zYXibdnITo8RSfGCJhusR14dTK33X0GRwU+sfWQjqovv4k0GZs3V98dxOP0YpE9QD7oqsIGxIdJOXoyrEP0oCBSKeeWcy0mk6Imcaed83j8IyMql0KWj4mKby2kg6Lf9WzAJJwNYybVyLDYwtxR6y/10T3udkoPzEE71GKmNA8W5ifgr5ibHAt/NYdXG5K+qZGd9O0tvIxRj3ZYiBK0YpA4Kw9SDG3K7iHwz4efwBKWE30ojz1QYay5gx3TdJsuOPmu7tAmbYkCUKkLdDkDNcw2UnItZzbC0kG3oRZdaFr6tGsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ppHRw6F1lKoe0jGXdQeGMr+pvtqCEpp0ReueG1+t/zc=;
 b=TOAke8U99S1Hn8Cx7gk8Zg8ZGeNiOQadau2CdQNtG3qf3GNsUdInVFHrC++RrpB005HaX60XXJrrGxxzmljZrxW5urHbu9DWZtE0aXct8PqtywSMEb5yA/GV0meeB9UGq8e1rZuwzKgJcqUtbBmFepFuDfrCCywbycK9i7qiv4RZ+R+2iycjHuNZ0tfRfpnr3fi6CBhQrl6y8MYJcFwnkcI1E3wecMt0WriRMdxBIyovfVmG3hu45mHCTf6ZUJI+FEMB9JwJwYkDpxj68xpXEW3n93rkXln1SLopz3c7g+VZgt+uFwskPI2onW2yvM5qUgtZCL058KJ1VZynwQAtqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ppHRw6F1lKoe0jGXdQeGMr+pvtqCEpp0ReueG1+t/zc=;
 b=SWu/ZZH5feYpiBFdI9QPSK0PDA9XEp7qbM2kLxvAOUkrUWbHODt4jXdvhNlAGJaDUhtnx2H3dt5YhzHx7K3oZHqdimY7Oa7XtXLK070fjGDfzvBVmY5WmY7wgUr3vy676O/0KF/fgiyRU0EcGlVwX6BE6ACyDHJ5sxz0FFXxUZPrkSao3EQJIJ/sU+f11v9pVrxSjKte8qG4nHAXZzCvfh2lCSIwjG20BlZ+IMLutRS9fJOGCapasnrT/wpvjjOfr/9UqdyMzhz9mV4b9/I5oXDJEW6GtZ1BWEBr/cBxwDrOwMhytd9GcteHiZORIOrBOwTcX3QMprAzb5XIgc2kEg==
Received: from BL1PR13CA0208.namprd13.prod.outlook.com (2603:10b6:208:2be::33)
 by DS7PR12MB5863.namprd12.prod.outlook.com (2603:10b6:8:7a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Mon, 25 Dec
 2023 04:56:30 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:2be:cafe::f5) by BL1PR13CA0208.outlook.office365.com
 (2603:10b6:208:2be::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.16 via Frontend
 Transport; Mon, 25 Dec 2023 04:56:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7135.14 via Frontend Transport; Mon, 25 Dec 2023 04:56:30 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 24 Dec
 2023 20:56:27 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Sun, 24 Dec 2023 20:56:27 -0800
Received: from sgarnayak-dt.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Sun, 24 Dec 2023 20:56:20 -0800
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
Subject: [PATCH v6 2/2] hw/acpi: Implement the SRAT GI affinity structure
Date: Mon, 25 Dec 2023 10:26:03 +0530
Message-ID: <20231225045603.7654-3-ankita@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231225045603.7654-1-ankita@nvidia.com>
References: <20231225045603.7654-1-ankita@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|DS7PR12MB5863:EE_
X-MS-Office365-Filtering-Correlation-Id: d9d8bdbe-cf18-458d-c59a-08dc0505dbf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1c4TakaMzy9SJAINo3H13VYfMrCReYMtuTxzNcNttv1yPLZGEug5krBGHZJ0w589Moh8R9DNk7IiZUIAybCOKcIaW++LsGH6YEcfqqcqKACfsFYpeRbiX6SYlbdzEILCNtaFJsqjNbsobC2zYxFByoBHPBMPW9BjhbTSBwjkrqcm8SbvbzB16Ao6uutttqHFch9xbPzWI53+s6LPZJ9VX2fJbUY436ee2Dd/IlstGW/w5Sfi3CCEiyQ8JJbIdo88hHJkbyT6d1SpIQlHTkHOMotMW2U74W9vZj/T2SVPk8Ww8sFviohg0GoA2tXSJV4ihGHnWrQ+SwEhng2GOqRTAiFgAfNj+QjIaEc8vlF43V6qBN16ulKDAveTHyXT7F71Z2Lhkc7dR8mrTwpx/UJlFDrV5XbPJkcQ7qYg2I6d/voqzZm91oHemuGRlVzSO6HasKTVJxW0Gyf2ZLnUSXdJEZmJkvuLQZ6v/ahXNsc3X8kqdj8F6BzX9oQd5KLs+byexZZgHQ/TxMrI4JHNOO0h3sy085Gi2JfVoRXmqJUshKhjwp1SzIwtp81kRVLr4BCx/Tzm82eXpgSNlqw/dXItqZ3e8yy9bonBXMDQPE3jvJj/KRJhyxjmTF2jbT80gsbAaa/kgkrYhKlG98EfTN+dus9zEZTxybkVJJ7lUu6IAsVU8bYh/AD77iteizOs1z4Sj18thsDB8IzbnSIgucRIWc8SB13oEZRQPW1lHOuzvyuLRNFNx/zkzkyBq0mT14PGjC+UxrvDKmjK4dGpgJ7j/g==
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(136003)(396003)(346002)(230922051799003)(1800799012)(64100799003)(451199024)(82310400011)(186009)(40470700004)(46966006)(36840700001)(7636003)(82740400003)(356005)(36756003)(40460700003)(921011)(86362001)(40480700001)(1076003)(26005)(2616005)(7696005)(8676002)(8936002)(316002)(6666004)(478600001)(426003)(54906003)(336012)(110136005)(36860700001)(47076005)(70206006)(70586007)(41300700001)(2876002)(2906002)(4326008)(7416002)(5660300002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2023 04:56:30.1054 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9d8bdbe-cf18-458d-c59a-08dc0505dbf3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5863
Received-SPF: softfail client-ip=2a01:111:f403:2416::601;
 envelope-from=ankita@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.594,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

[1] ACPI Spec 6.3, Section 5.2.16.6
[2] ACPI Spec 6.3, Table 5.80

Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
---
 hw/acpi/acpi-generic-initiator.c         | 99 ++++++++++++++++++++++++
 hw/arm/virt-acpi-build.c                 |  3 +
 include/hw/acpi/acpi-generic-initiator.h | 26 +++++++
 3 files changed, 128 insertions(+)

diff --git a/hw/acpi/acpi-generic-initiator.c b/hw/acpi/acpi-generic-initiator.c
index e05e28e962..fa5235f2bb 100644
--- a/hw/acpi/acpi-generic-initiator.c
+++ b/hw/acpi/acpi-generic-initiator.c
@@ -68,3 +68,102 @@ static void acpi_generic_initiator_class_init(ObjectClass *oc, void *data)
     object_class_property_add(oc, "host-nodes", "int", NULL,
         acpi_generic_initiator_set_host_nodes, NULL, NULL);
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
+    object_child_foreach(object_get_root(),
+                         acpi_generic_initiator_list, &list);
+    return list;
+}
+
+/*
+ * ACPI 6.3:
+ * Table 5-78 Generic Initiator Affinity Structure
+ */
+static void
+build_srat_generic_pci_initiator_affinity(GArray *table_data, int node,
+                                          PCIDeviceHandle *handle)
+{
+    uint8_t index;
+
+    build_append_int_noprefix(table_data, 5, 1);  /* Type */
+    build_append_int_noprefix(table_data, 32, 1); /* Length */
+    build_append_int_noprefix(table_data, 0, 1);  /* Reserved */
+    build_append_int_noprefix(table_data, 1, 1);  /* Device Handle Type: PCI */
+    build_append_int_noprefix(table_data, node, 4);  /* Proximity Domain */
+
+    /* Device Handle - PCI */
+    build_append_int_noprefix(table_data, handle->segment, 2);
+    build_append_int_noprefix(table_data, handle->bdf, 2);
+    for (index = 0; index < 12; index++) {
+        build_append_int_noprefix(table_data, 0, 1);
+    }
+
+    build_append_int_noprefix(table_data, GEN_AFFINITY_ENABLED, 4); /* Flags */
+    build_append_int_noprefix(table_data, 0, 4);     /* Reserved */
+}
+
+void build_srat_generic_pci_initiator(GArray *table_data)
+{
+    GSList *gi_list, *list = acpi_generic_initiator_get_list();
+    AcpiGenericInitiator *gi;
+
+    for (gi_list = list; gi_list; gi_list = gi_list->next) {
+        Object *o;
+        uint16_t node;
+        PCIDevice *pci_dev;
+        bool node_specified = false;
+
+        gi = gi_list->data;
+
+        o = object_resolve_path_type(gi->pci_dev, TYPE_PCI_DEVICE, NULL);
+        if (!o) {
+            error_printf("Specified device must be a PCI device.\n");
+            exit(1);
+        }
+        pci_dev = PCI_DEVICE(o);
+
+        for (node = 0; (node = find_next_bit(gi->host_nodes,
+                             MAX_NODES, node)) != MAX_NODES; node++)
+        {
+            PCIDeviceHandle dev_handle;
+            dev_handle.segment = 0;
+            dev_handle.bdf = PCI_BUILD_BDF(pci_bus_num(pci_get_bus(pci_dev)),
+                                                       pci_dev->devfn);
+            build_srat_generic_pci_initiator_affinity(table_data,
+                                                      node, &dev_handle);
+            node_specified = true;
+        }
+
+        if (!node_specified) {
+            error_report("Generic Initiator device 0:%x:%x.%x has no associated"
+                         " NUMA node.", pci_bus_num(pci_get_bus(pci_dev)),
+                         PCI_SLOT(pci_dev->devfn), PCI_FUNC(pci_dev->devfn));
+            error_printf("Specify NUMA node with -host-nodes option.\n");
+            exit(1);
+        }
+    }
+
+    g_slist_free(list);
+}
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 8bc35a483c..00d77327e0 100644
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
index 9643b81951..76efd5d3f0 100644
--- a/include/hw/acpi/acpi-generic-initiator.h
+++ b/include/hw/acpi/acpi-generic-initiator.h
@@ -24,4 +24,30 @@ typedef struct AcpiGenericInitiatorClass {
         ObjectClass parent_class;
 } AcpiGenericInitiatorClass;
 
+/*
+ * ACPI 6.3:
+ * Table 5-81 Flags – Generic Initiator Affinity Structure
+ */
+typedef enum {
+    GEN_AFFINITY_ENABLED = (1 << 0), /*
+                                      * If clear, the OSPM ignores the contents
+                                      * of the Generic Initiator/Port Affinity
+                                      * Structure. This allows system firmware
+                                      * to populate the SRAT with a static
+                                      * number of structures, but only enable
+                                      * them as necessary.
+                                      */
+} GenericAffinityFlags;
+
+/*
+ * ACPI 6.3:
+ * Table 5-80 Device Handle - PCI
+ */
+typedef struct PCIDeviceHandle {
+    uint16_t segment;
+    uint16_t bdf;
+} PCIDeviceHandle;
+
+void build_srat_generic_pci_initiator(GArray *table_data);
+
 #endif
-- 
2.34.1


