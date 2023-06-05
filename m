Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 150D8723459
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 03:08:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6LAQ-0004VR-GD; Mon, 05 Jun 2023 21:07:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>) id 1q6Jy2-0002zS-9A
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 19:50:31 -0400
Received: from mail-mw2nam10on20601.outbound.protection.outlook.com
 ([2a01:111:f400:7e89::601]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>) id 1q6Jy0-0008Nw-FA
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 19:50:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ane5IevuW1BmtB1oMjuQbaOqgK7GuJDM11zeMaGkWrw3tSfsWVxZzZ1hBEAw2IWYebad4jAYkZCPp3jefawWwlu0L1ZwfB9THHiNcIQSGhPMNxKspSuoKe/ZNZ3tpXTkVyxOsAl8B2JTF1jduTiaVUwcLbRDWxZrSh8+B/xq84BnE/k4JjevpP4oGoY0Bml/lsmEulDv7iUh1s77+beBCRkvnYjEqicil0WQ3/uZcykPZwmQx7FRnsqa186yI7sZkl8u5ZcJA7rymAe6LBZg4v88jQln0fn1eiEBlcxDAjfklQD/q51+fBZ0BgXZB5y4GY5p+30YHJIx6ykJdEDQfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jADDBMocO4FXs6UDQyYixbIV0wtTYpPa/eE06PvMVgk=;
 b=bmXzvnuwTstjhjP53CMe0a5pZggsjNIQMnS+dA/D9GtPR9r7OxQYGOLRbQZM/fuMFF8fG+y79twHwUwxlBBy/trcguZa86BPM9OaAn49RZ5wHA1gvFJ6AHGTMEbaIwlT0e15zD7wFlIBuSPmF7apjW+fyyM/XDKtlaZeqE+QZD+NmjhFdWbRJBwQk7vYIe3pbfAvbR93F5VYofljkjjL7CAb4R2cITXdHiZFyWzeiXgKq5v+utHFyPs+axlxMLbVxPIOtNkyURLGARfyj/0frgfHPGThu75qbHhDOdrHggo+k+A3XTuPZXHWEnf1v9O29xA2GAHAP4SPKwcccRHiGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jADDBMocO4FXs6UDQyYixbIV0wtTYpPa/eE06PvMVgk=;
 b=ei0T8Q5YIlkdXJnLFQQwbAmuOUA4PFFUNZ0g1cAcDzB0MEsMRNJWwHzaM0k7Fbc9VJzrdC6jCiDKPbZVPMlCJoWfdXBJ0UzZSd39ghcwHCP86lgshrZmBo83by850OI7fr3ugC6AFxavSAOWKm11K1jYgPoldO+/cV/3Hr4Xe+Oa9zX+W31oSnPULmBrjNVo9xVL3HX15z3gqgaE2QzRFEvRBBPZvf0BD8JLlroi/UkoCP8OsHr8rQKYfsaSZCaS/Geky9VgOImcRZ5u8b1PdpKx9rBP4cQdjWGRb7yaLSBNRfBOoNYIoiE7nH+5B4GVnrWkn1rLs20ze+N4TkJIkg==
Received: from BY5PR20CA0001.namprd20.prod.outlook.com (2603:10b6:a03:1f4::14)
 by CH3PR12MB8904.namprd12.prod.outlook.com (2603:10b6:610:167::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 23:50:22 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::da) by BY5PR20CA0001.outlook.office365.com
 (2603:10b6:a03:1f4::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Mon, 5 Jun 2023 23:50:21 +0000
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
 15.20.6477.13 via Frontend Transport; Mon, 5 Jun 2023 23:50:19 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 5 Jun 2023
 16:50:06 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 5 Jun 2023 16:50:06 -0700
Received: from ankita-dt2.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Mon, 5 Jun 2023 16:50:06 -0700
From: <ankita@nvidia.com>
To: <ankita@nvidia.com>, <jgg@nvidia.com>, <alex.williamson@redhat.com>
CC: <qemu-devel@nongnu.org>
Subject: [RFC v1 2/4] qemu: patch guest SRAT for GPU memory
Date: Mon, 5 Jun 2023 16:50:03 -0700
Message-ID: <20230605235005.20649-3-ankita@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230605235005.20649-1-ankita@nvidia.com>
References: <20230605235005.20649-1-ankita@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|CH3PR12MB8904:EE_
X-MS-Office365-Filtering-Correlation-Id: 4765840c-6a44-4913-c64d-08db661f9ee0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3XjY/Ns4VNCQO4VVa47ZO2IFxgYveXcaF5KY84pqPTbvMwpOEqbca9RjE74TqyxyidOIA71XMriRuqxUtOBDX2BsxZEx/2WZxN6PY0nZM+KEalDcX9nYUl3cJ5dzsie3Oycw5803xY8jHYFQyrJ1LSXmxgnqbAS0YNcb3sQKN9BUOAetM37nhw69Ky6P5Rkdoi8OLsIywX3VGqGIz1xalbxDjjQlXcrguEIIQaRLRueLn3phH+6vBHNgknTk69bcrujk6E9jdMzN21Y/XM+JfikJXYZls6Yd/Hft9sm1lvSfSHMMVLegBepEOMsgghsZbrGOmdgw7VcjvS5RO8LIL+CgnOU9V4gJcgkPp84HhAxAeSlkJmDjG7PJs8LhsJ0Z/0UeED2b+thHDaaLcdUJyvFc9clxIiEvlqrA1DCvc9P4tN3AISaFvz3X+/NcpS6EtKABQM08/Th3lScr1Bpz+aO2WlTG/BAi/s0gDi64EbStYOnMsQxN1wswov8PQ0C8e37Gqhfa4Bj1R7GIaolwAqFcYtmcOODunVYIFsaA3QjHDv6he4nc1FDdZHvhY8YHijRJX6NKnKYku3nFpMxo7gmPPWxSl7ettxMMq6AUw3PryXwWA5Ku7F5Als/1cz0EMJHBGjSZPu5RpjT8hpmLZKV79fxsMRnbTHmSk4gG8Uz8QvvHry2+4IOSVX19JdYatySpMJtSy7RSIfeFF0BZBz+p5HvkoWL8H3lRfhgTzD8=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199021)(46966006)(36840700001)(40470700004)(36756003)(2906002)(86362001)(2876002)(82310400005)(5660300002)(40480700001)(47076005)(7696005)(6666004)(426003)(186003)(336012)(36860700001)(1076003)(26005)(356005)(478600001)(82740400003)(7636003)(40460700003)(110136005)(70206006)(70586007)(4326008)(2616005)(316002)(8936002)(8676002)(41300700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 23:50:19.7513 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4765840c-6a44-4913-c64d-08db661f9ee0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8904
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
X-Mailman-Approved-At: Mon, 05 Jun 2023 21:07:19 -0400
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

The guest VM adds the GPU memory as (upto 8) separate memory-less NUMA
nodes. ACPI SRAT need to thus insert proximity domains and tag them as
MEM_AFFINITY_HOTPLUGGABLE. The VM kernel can then parse the SRAT and
create NUMA nodes.

Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
---
 hw/arm/virt-acpi-build.c | 54 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 4156111d49..42f76752b4 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -45,6 +45,7 @@
 #include "hw/acpi/hmat.h"
 #include "hw/pci/pcie_host.h"
 #include "hw/pci/pci.h"
+#include "hw/vfio/pci.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/pci-host/gpex.h"
 #include "hw/arm/virt.h"
@@ -514,6 +515,57 @@ build_spcr(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
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
+                                  "gpu_mem_pxm_start", &error_abort);
+            uint64_t node_count = object_property_get_uint(obj,
+                                  "gpu_mem_pxm_count", &error_abort);
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
@@ -568,6 +620,8 @@ build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
                           MEM_AFFINITY_HOTPLUGGABLE | MEM_AFFINITY_ENABLED);
     }
 
+    build_srat_devmem(table_data);
+
     acpi_table_end(linker, &table);
 }
 
-- 
2.17.1


