Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA9B80212A
	for <lists+qemu-devel@lfdr.de>; Sun,  3 Dec 2023 07:04:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9fZg-0000fA-MK; Sun, 03 Dec 2023 01:03:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1r9fZc-0000dz-78; Sun, 03 Dec 2023 01:03:26 -0500
Received: from mail-mw2nam10on20601.outbound.protection.outlook.com
 ([2a01:111:f400:7e89::601]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1r9fZY-0006V7-3e; Sun, 03 Dec 2023 01:03:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hNMD1HvYJlTJ31bkwFWgc5XhHVYT0Pd0w8mJuQH4ImieB7K5N5jyLYUdl1CiL20KsA3wgthxbR5I2nqHM7GfHqcuvaCSryXxn/qYYJQMWju7u9rhKrTa9/TeWMeCGx1NILX1cU7AdYxZu1RiiQ2y1nTlFisTzOBcMMph6CYPg+7kkTS7Kcuu6i9bJTaKj2tulT3KKrS2gncj3gy8I3bq0DufGHaB3DixH3lTDOtk9fw0Gy2mifc8t4E48OTM/5KtK5bEUA3SeYmv3PjFdczMnSrXpBDW8EQ5Rw3qLqgpTL6ArqXWje6lXNUJfvkszx0GTnfLu8tJ0dAz4FQSiNfpaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+hN6PvYjdDVLUNI+vAJNlHfGo2ikIvY/PGnfd1Nismg=;
 b=bmbvNtoKHHAM3EuibcyrOxNWsxe4Qz6/kzxwWsCkLOFlK1fWQ0h3OwRJEkWboUHMsiq/HYM/piZ5rHEfVg05eNXfRX50CnUehbYPRPYcNrL8kaWxZvQlmI1RnHR2jU3dUHMkmUrlv61wLZufmcIefaYswpWesCPY1572GZ7jUdFvwZsB8lncq29KMhX2RhTynYh8FEGcHNsOcsqf84hnJSJMmdvQnG4r3yIdHIh+BsScUazM+G7Dg3nCAHOEfGR9vwlAfR3AgNwG7J+i/SObALLNt7vc8nlP/aM1mpb4qcyxo9RCr0zxut/EUxbFS8rkHxARkK96q8V83xcCIDqS1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hN6PvYjdDVLUNI+vAJNlHfGo2ikIvY/PGnfd1Nismg=;
 b=fmeg6FH91DUd2sFYNUQeGs6jEyXGkXSItdMNvDSvwL71nrjxYH0z14ReCaOWu8zsgF334ot4zfYtyWPxiM2u5zttjHIitqXdvDJqXUMVfWVh155H8OOrQOb27/2O9DE/PcsJb4modontIJ8IYXK7KqoAm+6y3Gh+VJWaoyKwmvK1Q8fEpQV6fSAfbE2QvVZyLYS86MTgphxaPUISp2TjaKmJt0eW2E97a2dULYVtVFjVmXsUnHf/tCnRlcmW5hrzvXeJZzxkVLqui6JIbprN5huNBr4Q0mEzJsiU9UzV7wTtk8gQS1Emb7KcaJWhAM8Dg74lCH9qoHovzlUiaGxVZw==
Received: from MW4P222CA0001.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::6)
 by PH7PR12MB5855.namprd12.prod.outlook.com (2603:10b6:510:1d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Sun, 3 Dec
 2023 06:03:12 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:303:114:cafe::62) by MW4P222CA0001.outlook.office365.com
 (2603:10b6:303:114::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.32 via Frontend
 Transport; Sun, 3 Dec 2023 06:03:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.20 via Frontend Transport; Sun, 3 Dec 2023 06:03:12 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sat, 2 Dec 2023
 22:03:09 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Sat, 2 Dec 2023 22:03:08 -0800
Received: from sgarnayak-dt.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Sat, 2 Dec 2023 22:03:02 -0800
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
Subject: [PATCH v5 2/2] hw/acpi: Implement the SRAT GI affinity structure
Date: Sun, 3 Dec 2023 11:32:45 +0530
Message-ID: <20231203060245.31593-3-ankita@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231203060245.31593-1-ankita@nvidia.com>
References: <20231203060245.31593-1-ankita@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|PH7PR12MB5855:EE_
X-MS-Office365-Filtering-Correlation-Id: b7a6cab0-cc57-4cc0-20f1-08dbf3c5883e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sgr1eGky7/VSJBZBABtrpL9Vsjm/Lvftag94AKgkl2IMyv0Rar+Dax8qpBNVp9FJKVzem2QRTj25oB3O6KytSU7KOkybJkvopnwQXlCUAi+wxQ/RPGVv77iKawBAwoP/L/hJ10W022T7lltsAl+TQQuIpWBO7Tb1r7yglXs/jXaMCnykfNRIXfrm1LOMoGundSzf2YJ7L+59hR3VTtOkwckji86PLR3Gzao2a490loAZ2LJq++rxykJUSw2xO+wmxzL0a5fQs0f+EHRiQRikEvRO/yNut0WU6XSbQ4+u8ShKoC6RhII3mhZHtdWzUz7l9ViUYe3CwThZH8sRNihDwxRHceU414jxKIkYyrUDLLolDt1frfFFa4Jp8bHOGe9birUvGv/NtiOSZ0GG3hTazDj4vBL9XChAbW4dLjWnkEEuIhETRKIl7bL9tZEmjhYjVXqlB/69R+ZWi8LzYpsOro1UpKqgJ/51jD/Ikwt0GIwHVWNbxN2MGmjKV9YvEu8th23NTDj1Y0l7q1Iho2D8USOqT9JL2CdkqmmVWZTlwbJfYrhGV3Uxe8wYdI/aKIARMkPh/FfwmZyVFA+AfmlERlo41jAmGjcr87k8mM/NP+ClsfJYm8FXuOgtFjjckR+tj3srLHMzc6yQzPXkvNr6WSJo2Hq3n3kYvtstIJ2L2Bu8ICsvsaZ0S7Dqy2zbvStIgQ51WPkjQ5LIdsIrbtE44W0fjdzcmW4uIIZ+JFSutSSM/PbqntEa4qNc3mJZ+MZO6PBOmFXpr5nb9fEKP4cStg==
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(376002)(136003)(346002)(230922051799003)(186009)(451199024)(82310400011)(1800799012)(64100799003)(36840700001)(40470700004)(46966006)(2616005)(26005)(40460700003)(1076003)(47076005)(41300700001)(36860700001)(426003)(336012)(70586007)(70206006)(82740400003)(316002)(54906003)(7636003)(5660300002)(36756003)(40480700001)(110136005)(7416002)(356005)(921008)(8936002)(4326008)(86362001)(8676002)(6666004)(7696005)(2906002)(478600001)(2876002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2023 06:03:12.1999 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7a6cab0-cc57-4cc0-20f1-08dbf3c5883e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5855
Received-SPF: softfail client-ip=2a01:111:f400:7e89::601;
 envelope-from=ankita@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
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
index 41b0c8cda2..4013943319 100644
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


