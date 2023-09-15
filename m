Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8C57A13F9
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 04:47:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgyqX-0007LF-Kc; Thu, 14 Sep 2023 22:46:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1qgyqT-0007Kk-Vx; Thu, 14 Sep 2023 22:46:14 -0400
Received: from mail-mw2nam10on20610.outbound.protection.outlook.com
 ([2a01:111:f400:7e89::610]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1qgyqR-0001Us-7K; Thu, 14 Sep 2023 22:46:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z51ydGkEYVRrlSe2Y//XRHIq2oMaAxu0r6Eq9m5qmz/yj15u2Kio0+zaiRSDZxMGn7NhBa6Pw0eitGmYw7I6ITm89szgSY1yyV1K0J6VMmQjsgqLSkZySAeR5fb+zdN0K2B3VSaBJWKaWdtCMO0x1KfIod5vP4wgfLlsqoN8YmCyQLrLaoJLUEd2ra1mNsPbH8cBbpGUFq/QvW3V+HwayxNZPU44x+LC2NcU5VJ+ka/8F0TdYGNTj1wZ9FkT1jURRO+jZw95EvCtZ1eeeu3DNChFx5DSwlYCdri2tw+obBGAwvWcEENS4MRJQ9EPb3l/t29XhicNaSCOKJOdbELtrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PVXjSxuojgA09dgSl7142csCmbKd+a8IJ9YZCxwmDqo=;
 b=kaoRnWqAtQphkS9/X9Iuuds8brLZXuC4D+XXDiL/6S56sE9RJNpns0p4JtQzkUsRFusEsRx5WN5a6VX9qCCAQkUYzTbVY+ZaULlbEPHVMm/vDm/NCVP6VDsocIMPNmdtvZ0LQ1UhjMERo0J++wLrpr/UlbA+LcIyFrYOhDcLuHuVHR0uiAUEJ1GNx5EIARLyoeZ03YlD6oHTUr8Tajbh/vpm5jVxtCXbAvhuIUkmq/fFQR4RgaMsbRFumpsXq7ec+lGIlY9NX9ztT2V/0cxiiD9HUrMxbJM1SlYOr2KPYrjOHSQ85dA6wS9nRqo1XFa3BLyGYwhKjdG++wfJx2468w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PVXjSxuojgA09dgSl7142csCmbKd+a8IJ9YZCxwmDqo=;
 b=OAKVJianuSQJex+XvMsrcPJSVPU19ixQhknoZYUJLPk9gKgO4hooKoW+T6LX4WC+eSpKQYxzGCFSBStUyhnsquKaTknpHuZDR+w7wNVY0kclpGET1tJ+aq3djLxq3T7XyOm85fu45A4FbJAsaT+E7WzGIB7qASDFgUS40xmAHwD94fiMxqGl7v19qSTT5+5E9wVoTSLN8gGpo4j22LFSroGKcygyMTEj4htUE9Cynp4mr6R4VsVeDKkwSMOBgpx9fOEHwyrhWr6gZHaunem0UtKABVbNWJZzNVBYjeJ03mhlmwMt8O+RkZIGRMxwmH9WV0FbIGsxZPhCHXLiuaYVRA==
Received: from MW3PR05CA0003.namprd05.prod.outlook.com (2603:10b6:303:2b::8)
 by SA3PR12MB7830.namprd12.prod.outlook.com (2603:10b6:806:315::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Fri, 15 Sep
 2023 02:46:05 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:2b:cafe::a7) by MW3PR05CA0003.outlook.office365.com
 (2603:10b6:303:2b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21 via Frontend
 Transport; Fri, 15 Sep 2023 02:46:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.20 via Frontend Transport; Fri, 15 Sep 2023 02:46:05 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 14 Sep
 2023 19:46:01 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 14 Sep 2023 19:46:00 -0700
Received: from ankita-dt2.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Thu, 14 Sep 2023 19:46:00 -0700
From: <ankita@nvidia.com>
To: <ankita@nvidia.com>, <jgg@nvidia.com>, <alex.williamson@redhat.com>,
 <clg@redhat.com>, <shannon.zhaosl@gmail.com>, <peter.maydell@linaro.org>,
 <ani@anisinha.ca>
CC: <aniketa@nvidia.com>, <cjia@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <vsethi@nvidia.com>, <acurrid@nvidia.com>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: [PATCH v1 3/4] hw/arm/virt-acpi-build: patch guest SRAT for NUMA nodes
Date: Thu, 14 Sep 2023 19:45:58 -0700
Message-ID: <20230915024559.6565-4-ankita@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230915024559.6565-1-ankita@nvidia.com>
References: <20230915024559.6565-1-ankita@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|SA3PR12MB7830:EE_
X-MS-Office365-Filtering-Correlation-Id: 9236e475-72c7-43d6-79cd-08dbb595e823
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: arLCz1XQUTBh2+Ria8sspmyDZDOFBxrNT7Amn9m+dl+0y0bV9+fBENuLE+lgI5Zuy40w8vA+tPjNPeeYVwuYGxM0Ffc7QyVUqFqtepoDVjr0L+JWbktr9PJp0h6V0SitWfrxjEoPXvKSctdu0JAex5w82VxgBcI+5wWgadNqAY4JjU/sWX/Ufj/IbTYbpx0QR6TF8YSOQDShjoNZf4Y9BOKyCaWlpUtJDN+aBMQ9tp/+QiYmY4tZDXQ+enNaPoZdV075I6BiM4+pnk6V5LXFfuk+oLuM0oW/egmsrFEy6bJYLjImwuqecuVvZ44Xc/UryyBxWRi78CmYyoHOqjb+ziTIXti5DhquxuOzmbf3Morcjz2VACG9n7KnxbZ3QsEsbdmR8shu0PShqwaa5Z2I7yc0Iucrh1emahIUpV/atL4cJt+EPZpjxP/QT+luMeL9cY/g2ZAS242mrkGYdkbP5aaDNElAiYNn+TziSiQt4GTCTM86+mv0jHx7LslARSek6Dmyl8gHMVKB92tXsAhTROrMvoWuCPjdP1iB+VHc5GtPhdhLObP0qTKB7u5THt31TQpgrVMmkpDEVlljUuzP4qWn3RPeR53AQkdSiQP8m74oKXU4henTWheWndbhrQ/yt5/D+zGDEiXZFYgccU5Cmmd4XyU1iZJjTIWwDbffPG9N7okFeXDjDLVHEK9aFqY/qxr8ZFB5RIsUCkE6YKar5VDdH7huIu9ecabSpaZ8Noc=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(39860400002)(396003)(136003)(451199024)(186009)(1800799009)(82310400011)(36840700001)(40470700004)(46966006)(2906002)(5660300002)(7636003)(36756003)(8936002)(82740400003)(86362001)(40460700003)(4326008)(356005)(8676002)(316002)(54906003)(47076005)(41300700001)(36860700001)(40480700001)(2616005)(1076003)(110136005)(26005)(70586007)(7696005)(70206006)(426003)(2876002)(478600001)(336012);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 02:46:05.1357 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9236e475-72c7-43d6-79cd-08dbb595e823
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7830
Received-SPF: softfail client-ip=2a01:111:f400:7e89::610;
 envelope-from=ankita@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
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

During bootup, Linux kernel parse the ACPI SRAT to determine the PXM ids.
This allows for the creation of NUMA nodes for each unique id.

Insert a series of the unique PXM ids in the VM SRAT ACPI table. The
range of nodes can be determined from the "dev_mem_pxm_start" and
"dev_mem_pxm_count" object properties associated with the device. These
nodes as made MEM_AFFINITY_HOTPLUGGABLE. This allows the kernel to create
memory-less NUMA nodes on bootup to which a subrange (or entire range) of
device memory can be added/removed.

Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
---
 hw/arm/virt-acpi-build.c | 54 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 6b674231c2..6d1e3b6b8a 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -46,6 +46,7 @@
 #include "hw/acpi/hmat.h"
 #include "hw/pci/pcie_host.h"
 #include "hw/pci/pci.h"
+#include "hw/vfio/pci.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/pci-host/gpex.h"
 #include "hw/arm/virt.h"
@@ -515,6 +516,57 @@ build_spcr(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     acpi_table_end(linker, &table);
 }
 
+static int devmem_device_list(Object *obj, void *opaque)
+{
+    GSList **list = opaque;
+
+    if (object_dynamic_cast(obj, TYPE_VFIO_PCI)) {
+        *list = g_slist_append(*list, DEVICE(obj));
+    }
+
+    object_child_foreach(obj, devmem_device_list, opaque);
+    return 0;
+}
+
+static GSList *devmem_get_device_list(void)
+{
+    GSList *list = NULL;
+
+    object_child_foreach(qdev_get_machine(), devmem_device_list, &list);
+    return list;
+}
+
+static void build_srat_devmem(GArray *table_data)
+{
+    GSList *device_list, *list = devmem_get_device_list();
+
+    for (device_list = list; device_list; device_list = device_list->next) {
+        DeviceState *dev = device_list->data;
+        Object *obj = OBJECT(dev);
+        VFIOPCIDevice *pcidev
+            = ((VFIOPCIDevice *)object_dynamic_cast(OBJECT(obj),
+               TYPE_VFIO_PCI));
+
+        if (pcidev->pdev.has_coherent_memory) {
+            uint64_t start_node = object_property_get_uint(obj,
+                                  "dev_mem_pxm_start", &error_abort);
+            uint64_t node_count = object_property_get_uint(obj,
+                                  "dev_mem_pxm_count", &error_abort);
+            uint64_t node_index;
+
+            /*
+             * Add the node_count PXM domains starting from start_node as
+             * hot pluggable. The VM kernel parse the PXM domains and
+             * creates NUMA nodes.
+             */
+            for (node_index = 0; node_index < node_count; node_index++)
+                build_srat_memory(table_data, 0, 0, start_node + node_index,
+                    MEM_AFFINITY_ENABLED | MEM_AFFINITY_HOTPLUGGABLE);
+        }
+    }
+    g_slist_free(list);
+}
+
 /*
  * ACPI spec, Revision 5.1
  * 5.2.16 System Resource Affinity Table (SRAT)
@@ -569,6 +621,8 @@ build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
                           MEM_AFFINITY_HOTPLUGGABLE | MEM_AFFINITY_ENABLED);
     }
 
+    build_srat_devmem(table_data);
+
     acpi_table_end(linker, &table);
 }
 
-- 
2.17.1


