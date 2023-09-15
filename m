Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0F97A13F7
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 04:47:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgyqg-0007Ot-IY; Thu, 14 Sep 2023 22:46:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1qgyqZ-0007MH-Px; Thu, 14 Sep 2023 22:46:21 -0400
Received: from mail-bn7nam10on20608.outbound.protection.outlook.com
 ([2a01:111:f400:7e8a::608]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1qgyqX-0001W6-1U; Thu, 14 Sep 2023 22:46:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jBSYbynCCb5/BgyettXuRf9mNBsT9Bq0CHqX8VTwFQKEvHw3BxVqpPUO5bLwDgpBrZq4k/+sZyRVO8YCswMokmbyKS4Sls9ahoimW4ubvobfbMEGGJbh7PFOIU8MH/+F5S1ZFw+WjQWrEpYPKKhkcqU9MehxduI79P/9QqYZJw+kHS4SNdtyv24lsH0Ck/czef7CUVxzT/NJYIKrWGRUTuMEKR0ntJPdwNJSUARgkkvyUAZFKIMxR4f/t68MHF2JWTCTE42F7KII3fZrSTi2WndN7KxzfIS5NsOKmD2TW26fDohiMeQIJ/xq+aY4MB0crVfKF8dPAV83Pbd1vGLfsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NTUmTnIUmHO4yCTxzTlZ1vqntUu0P0NkSfWyDbf1qLo=;
 b=QF6nkPYzjrzfwWtY+7qIlVJ0YAthMig0kjPdFO9AacvrAUJB/N8TXBz/W8P5Lu4B3LJ3JmvoGYVE+H96DsEzO8J0tTfvwcqRPbqPf5lP8IFOU8pkos779aIYBwdcBBFcBb9uMNR5vvl5GIeKHmfmvu73yriw2x0lm/Edh0z9QMcQHNYchmD8hrTAGGPswCSieDl47hA5V6V3yY3bmxVcf3ilGQUMuMu2XEgmRdOLwi26Os69NGcSl51D2E1FKHjGFzlP4N/uh2JJRnanRZYmIFpEeLSpfYtQblyiUXUoPD6HLkwYwTLOZHhRn3R9/F2YSiKCiYIURBhop75l0gSdCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NTUmTnIUmHO4yCTxzTlZ1vqntUu0P0NkSfWyDbf1qLo=;
 b=Cx6lR1eIqJ1kRrhh2QkJQTeYPpC1MD0TATScW0oXU+afC0OaAptJO5Iy5HeiUfCpxKpb6RVO6lvTyqexwKYU8l8hHOXogNWGXvpPlNglSjT0oero2b6iPr2GXTa9ckudLAqk9WLCRZnd7mIlBwY1/HMYbphLW6aX2Y0BpjRt79xdMRUuAhmqPSGvNyIC+TSMoN1++l+zMdBXBvJ/QMmznEdD4s8Wz3gr6UWj03yBwkDNgyaUzbNi5aBiJWxoKKT2iKxirXgqG6lXBURMsZLYimkSmNhmpleZoyOMfTX9U2AyXdNaQ/56bIK8oePw909OMWUqY4idozJiNe9HHpNm+A==
Received: from BLAPR03CA0025.namprd03.prod.outlook.com (2603:10b6:208:32b::30)
 by PH8PR12MB6793.namprd12.prod.outlook.com (2603:10b6:510:1c4::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 15 Sep
 2023 02:46:12 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:208:32b:cafe::3b) by BLAPR03CA0025.outlook.office365.com
 (2603:10b6:208:32b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21 via Frontend
 Transport; Fri, 15 Sep 2023 02:46:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.20 via Frontend Transport; Fri, 15 Sep 2023 02:46:11 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 14 Sep
 2023 19:46:01 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 14 Sep 2023 19:46:01 -0700
Received: from ankita-dt2.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Thu, 14 Sep 2023 19:46:01 -0700
From: <ankita@nvidia.com>
To: <ankita@nvidia.com>, <jgg@nvidia.com>, <alex.williamson@redhat.com>,
 <clg@redhat.com>, <shannon.zhaosl@gmail.com>, <peter.maydell@linaro.org>,
 <ani@anisinha.ca>
CC: <aniketa@nvidia.com>, <cjia@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <vsethi@nvidia.com>, <acurrid@nvidia.com>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: [PATCH v1 4/4] acpi/gpex: patch guest DSDT for dev mem information
Date: Thu, 14 Sep 2023 19:45:59 -0700
Message-ID: <20230915024559.6565-5-ankita@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230915024559.6565-1-ankita@nvidia.com>
References: <20230915024559.6565-1-ankita@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|PH8PR12MB6793:EE_
X-MS-Office365-Filtering-Correlation-Id: b5b2ac45-3420-486b-32a1-08dbb595ec39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IJtR2mEBFNYf4dFXQzL35SOH9aLrZxxK5TwAmRb/TS5fG2McCF5FuKblikQab5qQZ6IJBYXM3FEDA68pnxtiqq8OD47KjYeZFwSH8zdjB6+cmA5AaxXrgjWg2R/UlIydyYf8W9j6bzBl6BhATNy6kl0f39yDrplkddXJ0X0MVVaf1myPD4fELWHLxN5stNs1pBQYYKl/+0m82knpgtPQbJcz/d/YlJqAJfqhf2DhnZVMUQEI5yRvDkvkrU+4Y+7PVFSx8vqVQWARU3ZnmzQKO9F++a+mc/hXqxbJ6XkT7yJ2qfKA4hYLKcX6xyKEeYqWcY2AuuwnjLLnLEL4zOgkLELowhkuskh4MjoAEnF5idW4b+5X3NqbvUNXBDrk5tRrSzHwPudlhFfDg8ZtQaAkSI9IRJm1NaZ2G9iRafpgHT3HIjTKkgZlQrA0l/9FBjYC0wwHVqFPX/sekWyeykD05rqRNh32G60mxiWuXEcxHbiPpfYB4A61n97nqNi7SpMjPzOU2tKylkCbYF7Qc3RxdY0nzKy9qRdwoHTyS084WA1bA4aCRn2OKuC2UHZwPE9D4EIEL0IBgyay3lpFZOuT+ZedeK/yfKwUe+6pM8xw1xAfHv4uL1xaYTNmTfEQtZaAMcvYeAbmAcTkF/2eU1KQBh0YP42VvlTOxZl7g/ZyC/sjseORvpfeUSoggHMo0WPtsb6eluKHR+UR2JEGL8ObDF7/ZyD71B1r3AVFs56nAFbmaBUT1bxFREkiDnqg91Vp
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199024)(82310400011)(1800799009)(186009)(46966006)(40470700004)(36840700001)(36756003)(86362001)(40480700001)(2616005)(40460700003)(478600001)(356005)(82740400003)(7636003)(36860700001)(2876002)(316002)(1076003)(2906002)(336012)(426003)(26005)(47076005)(5660300002)(41300700001)(7696005)(8676002)(70206006)(4326008)(110136005)(70586007)(54906003)(8936002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 02:46:11.9108 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5b2ac45-3420-486b-32a1-08dbb595ec39
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6793
Received-SPF: softfail client-ip=2a01:111:f400:7e8a::608;
 envelope-from=ankita@nvidia.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
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

To add the memory in the guest as NUMA nodes, it needs the PXM node index
and the total count of nodes associated with the memory. The range of
proximity domains are communicated to the VM as part of the guest ACPI
using the nvidia,gpu-mem-pxm-start and nvidia,gpu-mem-pxm-count DSD
properties. These value respectively represent the staring proximity
domain id and the count. Kernel modules can then fetch this information
and determine the numa node id using pxm_to_node().

Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
---
 hw/pci-host/gpex-acpi.c | 69 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
index 7c7316bc96..0548feace1 100644
--- a/hw/pci-host/gpex-acpi.c
+++ b/hw/pci-host/gpex-acpi.c
@@ -49,6 +49,72 @@ static void acpi_dsdt_add_pci_route_table(Aml *dev, uint32_t irq)
     }
 }
 
+static void acpi_dsdt_add_cohmem_device(Aml *dev, int32_t devfn,
+                                        uint64_t dev_mem_pxm_start,
+                                        uint64_t dev_mem_pxm_count)
+{
+    Aml *memdev = aml_device("CMD%X", PCI_SLOT(devfn));
+    Aml *pkg = aml_package(2);
+    Aml *pkg1 = aml_package(2);
+    Aml *pkg2 = aml_package(2);
+    Aml *dev_pkg = aml_package(2);
+    Aml *UUID;
+
+    aml_append(memdev, aml_name_decl("_ADR", aml_int(PCI_SLOT(devfn) << 16)));
+
+    aml_append(pkg1, aml_string("dev-mem-pxm-start"));
+    aml_append(pkg1, aml_int(dev_mem_pxm_start));
+
+    aml_append(pkg2, aml_string("dev-mem-pxm-count"));
+    aml_append(pkg2, aml_int(dev_mem_pxm_count));
+
+    aml_append(pkg, pkg1);
+    aml_append(pkg, pkg2);
+
+    UUID = aml_touuid("DAFFD814-6EBA-4D8C-8A91-BC9BBF4AA301");
+    aml_append(dev_pkg, UUID);
+    aml_append(dev_pkg, pkg);
+
+    aml_append(memdev, aml_name_decl("_DSD", dev_pkg));
+    aml_append(dev, memdev);
+}
+
+static void find_mem_device(PCIBus *bus, PCIDevice *pdev,
+                            void *opaque)
+{
+    Aml *dev = (Aml *)opaque;
+
+    if (bus == NULL) {
+        return;
+    }
+
+    if (pdev->has_coherent_memory) {
+        Object *po = OBJECT(pdev);
+
+        if (po == NULL) {
+            return;
+        }
+
+        uint64_t pxm_start
+           = object_property_get_uint(po, "dev_mem_pxm_start", NULL);
+        uint64_t pxm_count
+           = object_property_get_uint(po, "dev_mem_pxm_count", NULL);
+
+        acpi_dsdt_add_cohmem_device(dev, pdev->devfn, pxm_start, pxm_count);
+    }
+}
+
+static void acpi_dsdt_find_and_add_cohmem_device(PCIBus *bus, Aml *dev)
+{
+    if (bus == NULL) {
+        return;
+    }
+
+    pci_for_each_device_reverse(bus, pci_bus_num(bus),
+                                find_mem_device, dev);
+
+}
+
 static void acpi_dsdt_add_pci_osc(Aml *dev)
 {
     Aml *method, *UUID, *ifctx, *ifctx1, *elsectx, *buf;
@@ -207,7 +273,10 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
 
     acpi_dsdt_add_pci_route_table(dev, cfg->irq);
 
+    acpi_dsdt_find_and_add_cohmem_device(cfg->bus, dev);
+
     method = aml_method("_CBA", 0, AML_NOTSERIALIZED);
+
     aml_append(method, aml_return(aml_int(cfg->ecam.base)));
     aml_append(dev, method);
 
-- 
2.17.1


