Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 062FE723458
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 03:08:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6LAQ-0004VQ-D6; Mon, 05 Jun 2023 21:07:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>) id 1q6K2i-0003Xj-5Q
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 19:55:20 -0400
Received: from mail-bn7nam10on2077.outbound.protection.outlook.com
 ([40.107.92.77] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>) id 1q6K2g-0000ut-9f
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 19:55:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NWEUcSABdZRFX6rRqbSnJpXWRahcgfRF7SSmWquS+rAvM1Q9BVCBLujYFrqM0RSSIZhpG8rHZbLAWReG2On8SKNwWpxN/tcwFI3PbWuUrB+tmte7xQEaIKao6MSwIvpE0ORplqJTgWJd16ojaulkcsvuuRN+GY55aWxQIyeb1QLeUItOZWz6Hb0BwUf5yMKHKls35i6dlmD2FjCi5MynlvXtSTxL5IQ06xiWBgRUSQPp4/GgczzNzD66DiK1ZS7HtTkSAkA7eFkSoniECYb44GnipkCmwocXui5Qbhq7arzo8Yg+Oih7KmPiGn2DAXiH7oamhOY7aadIoUa7qjmi/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rcEzxi52YV+/AgvzHnqHfsxybubDhUcPYqE5QllXpiw=;
 b=Ny+kUX7O/FmXelEvOYkn4rMGm8Rv56G6nVsiUQPLXkWGjTyEU/l3cHEWo5+H4lbmI5cRPj/2xt7Lv0OGEamcAnuCot1YYZuADEvRUC9kiawzncau99mSqrykis2JA/pka56536Z/V+E0JnpxTnEXZPAVlozK4zLEBrethmhohIRSO4R5qXjV5/f8J3DsrV32YLSekHOLuQ69Sss8bdDX77mkG1mcldiZip5Da/o+zkjnFX3p9Rhvsh4CQT+MEppGc9V1Fk5oIBJUG8Q11D+UCrRXiJAT4Sk4RE8yXTmOGzkSyU9CF2aKX2gkAko/ZoGSNQrucJv9QshbrFGlXYwvoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rcEzxi52YV+/AgvzHnqHfsxybubDhUcPYqE5QllXpiw=;
 b=WgnjOnkLCsHKnRxMnN43jEbcbq3TbuvvLkjMpVBieyk188SI2jT4bYxtWt7uym2VdSVaU8j0Y7gGh7gsfSoE+JCs6dWaoZIm+Bop39qr8lwhCRpAFnRm5lW03LrocEoldKurxxBCisa99vZgfyrsg1R6n0TQRzG8vV2MdPgg7FPpEoceQwPiUvNcGCQ4oJc6Qn17Xei+ZViL1MjgbaD3DUkT1zT19zZx+BOeQBlYi7z/Erou+T+wZtbsrFJUDknCx/XWXskLgIAwHu6yHJ95LeQzuDORiCtR6WXdI6jVyC8Wxfh66OpRUCr0peofECB0Ps32OZM35Dpk0P2hJ+ArZA==
Received: from MW4PR03CA0135.namprd03.prod.outlook.com (2603:10b6:303:8c::20)
 by SA1PR12MB9004.namprd12.prod.outlook.com (2603:10b6:806:388::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 23:50:14 +0000
Received: from CO1NAM11FT093.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::c3) by MW4PR03CA0135.outlook.office365.com
 (2603:10b6:303:8c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Mon, 5 Jun 2023 23:50:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT093.mail.protection.outlook.com (10.13.175.59) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.33 via Frontend Transport; Mon, 5 Jun 2023 23:50:14 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
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
Subject: [RFC v1 3/4] qemu: patch guest DSDT for GPU memory
Date: Mon, 5 Jun 2023 16:50:04 -0700
Message-ID: <20230605235005.20649-4-ankita@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230605235005.20649-1-ankita@nvidia.com>
References: <20230605235005.20649-1-ankita@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT093:EE_|SA1PR12MB9004:EE_
X-MS-Office365-Filtering-Correlation-Id: db6095fb-1e8e-439a-3929-08db661f9b8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0OMwtu6B+ghN3h03qt4HWRaFArfen5qRWdqsvC+2tJ+p1ypXthkyV23IpT6ajodzjnZAdblAcvCsTttUrjHyEsC0Nc66CRoijvpPm8RuWyV/kellE8AG56v+CbnIQFpg+OIYC0IV4tdrKBuiy0sdKzkVPlMFe3OjjMWMrjV5CW42PyROmLsimHHxxwM+ELRa6rLivbZgLHu27HD4GQBNny2ERsYxWFwLbqEJqFHCO8oeOOXYTj6cLVLzTsvXb1oyRENUVvSPXEPjDrC8CNhdrr0zkSWgiMUGmR2jNUzaNKQF8vrbrHJnM77K4bBRNc1M+fLW0a34gzSxJdYVyC+9emOgTF18A5jZurmS2NbJjEcINJgrsIFpuh2JsR0dDDejB3fAut5+QSR5WdQ1JCDU+xhmJoms7AUkONCgqH4h9X+gEIjMxlAOTSks2Q1rbvtFOuxRu39nDEE1vMp5czUbV0efbS5spf6NZ7QBOc5gEM/KWxdfp7TLAk6EYkrMRlncZ6JKti18BtAheSsqAuyb7qKokDr6ZDCnwNjlWHdUOUzyyQ7977JmDrPwY/q68vy85F+VkN7O3Rqi3JA0tu1SNhFjFeEbNO7k/OXynvPlguuMRwupSnlKpVbbbCJ7JDleXloUXDsFT71HVpMFmeqGYcE37MRQYqR7WVbIw/owYyhJOqMIEO18AczwbFCwFAebQOypJuueyIB/qOaiEh5g/yVnrBcBRxvLS6bk2nba0ARhIQkX5lNsT27xqX9PjmkJ
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(396003)(451199021)(46966006)(40470700004)(36840700001)(40460700003)(336012)(426003)(2906002)(47076005)(2876002)(2616005)(36756003)(82310400005)(86362001)(356005)(82740400003)(7636003)(36860700001)(40480700001)(7696005)(41300700001)(316002)(5660300002)(8676002)(8936002)(110136005)(478600001)(70206006)(70586007)(4326008)(26005)(1076003)(186003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 23:50:14.1797 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db6095fb-1e8e-439a-3929-08db661f9b8c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT093.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9004
Received-SPF: softfail client-ip=40.107.92.77; envelope-from=ankita@nvidia.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

To add the memory in the guest as NUMA nodes, it needs the PXM node index
and the total count of nodes associated with the memory. The range of
proximity domains are communicated to the VM as part of the guest ACPI
using the nvidia,gpu-mem-pxm-start and nvidia,gpu-mem-pxm-count DSD
properties. These value respectively represent the staring proximity
domain id and the count. Kernel modules can then fetch this information
and determine the numa node ID using pxm_to_node().

Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
---
 hw/pci-host/gpex-acpi.c | 71 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
index 7c7316bc96..36873889c1 100644
--- a/hw/pci-host/gpex-acpi.c
+++ b/hw/pci-host/gpex-acpi.c
@@ -49,6 +49,74 @@ static void acpi_dsdt_add_pci_route_table(Aml *dev, uint32_t irq)
     }
 }
 
+static void acpi_dsdt_add_gpu(Aml *dev, int32_t devfn,
+                             uint64_t gpu_mem_pxm_start,
+                             uint64_t gpu_mem_pxm_count)
+{
+    Aml *dev_gpu = aml_device("GPU%X", PCI_SLOT(devfn));
+    Aml *pkg = aml_package(2);
+    Aml *pkg1 = aml_package(2);
+    Aml *pkg2 = aml_package(2);
+    Aml *dev_pkg = aml_package(2);
+    Aml *UUID;
+
+    aml_append(dev_gpu, aml_name_decl("_ADR", aml_int(PCI_SLOT(devfn) << 16)));
+
+    aml_append(pkg1, aml_string("nvidia,gpu-mem-pxm-start"));
+    aml_append(pkg1, aml_int(gpu_mem_pxm_start));
+
+    aml_append(pkg2, aml_string("nvidia,gpu-mem-pxm-count"));
+    aml_append(pkg2, aml_int(gpu_mem_pxm_count));
+
+    aml_append(pkg, pkg1);
+    aml_append(pkg, pkg2);
+
+    UUID = aml_touuid("DAFFD814-6EBA-4D8C-8A91-BC9BBF4AA301");
+    aml_append(dev_pkg, UUID);
+    aml_append(dev_pkg, pkg);
+
+    aml_append(dev_gpu, aml_name_decl("_DSD", dev_pkg));
+    aml_append(dev, dev_gpu);
+}
+
+static void find_hbm_device(PCIBus *bus, PCIDevice *pdev,
+                            void *opaque)
+{
+    Aml *dev = (Aml *)opaque;
+    uint32_t vendor_id = pci_default_read_config(pdev, PCI_VENDOR_ID, 2);
+
+    if (bus == NULL) {
+        return;
+    }
+
+    if (vendor_id == PCI_VENDOR_ID_NVIDIA &&
+        pdev->has_coherent_memory) {
+        Object *po = OBJECT(pdev);
+
+        if (po == NULL) {
+            return;
+        }
+
+        uint64_t pxm_start
+           = object_property_get_uint(po, "gpu_mem_pxm_start", NULL);
+        uint64_t pxm_count
+           = object_property_get_uint(po, "gpu_mem_pxm_count", NULL);
+
+        acpi_dsdt_add_gpu(dev, pdev->devfn, pxm_start, pxm_count);
+    }
+}
+
+static void acpi_dsdt_find_and_add_gpu(PCIBus *bus, Aml *dev)
+{
+    if (bus == NULL) {
+        return;
+    }
+
+    pci_for_each_device_reverse(bus, pci_bus_num(bus),
+                                find_hbm_device, dev);
+
+}
+
 static void acpi_dsdt_add_pci_osc(Aml *dev)
 {
     Aml *method, *UUID, *ifctx, *ifctx1, *elsectx, *buf;
@@ -207,7 +275,10 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
 
     acpi_dsdt_add_pci_route_table(dev, cfg->irq);
 
+    acpi_dsdt_find_and_add_gpu(cfg->bus, dev);
+
     method = aml_method("_CBA", 0, AML_NOTSERIALIZED);
+
     aml_append(method, aml_return(aml_int(cfg->ecam.base)));
     aml_append(dev, method);
 
-- 
2.17.1


