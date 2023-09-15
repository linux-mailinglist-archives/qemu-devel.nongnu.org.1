Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF0E7A13F6
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 04:47:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgyqf-0007Od-Id; Thu, 14 Sep 2023 22:46:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1qgyqZ-0007MG-Pb; Thu, 14 Sep 2023 22:46:21 -0400
Received: from mail-dm6nam04on20623.outbound.protection.outlook.com
 ([2a01:111:f400:7e8b::623]
 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1qgyqX-0001Vn-7R; Thu, 14 Sep 2023 22:46:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZrHyFnqFnZMOLXUn+HZb+dzOUuZ9ikOU27PHMnh2MAV8b6pWYuhBi2cvRHXRsvWcMnK1qnCygyYtLW9WaaP5GjIB8Lj9dOy8wZ0ltV5yfy+l4WThkQJ/keRHJudtHRo+OavnLc5ESy0wFKbB/krO/ng0z26YEMgNSD4zKRv2rh4txDs0s136tY6HGBrckQuJ7gc1ZiaC1vV0mTzDNZG2PE+/H5FjKfsiEDHQHvJGzjOTFH+yLU6W9DEBFbqV7/3nYpjidnq7vwPBWZsCCI7zVBamV+oksfNndmI5dRzjZz4Nypb5HNIpwU9V7fBI3RdYp7eHxXXRgB+K/+/sIMLBtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QVzFIaGT2MT/s8xKxDAjSmCB7BCNbTEWJ4g0vSgjfio=;
 b=Ng4qVHTDi7jo+Op76tH2daPcHp2tgUOHTlsgMi7x4sOxL+zWOmBDoHMomeRfdwBzlLR6myxpHKmJ74NPhcpH95900c1VqBl+PCWLvz03Z2P59E/3D/iZzSZQXk+/CGHyLqW9EQGgu9RrhfMYmZdnxqoVDu+guY2wtxMwx+UBDYOTE6imsjB1/ZsxOKo21smPSkPhL4IIIGJWRVUZHSMwaF5xopNNgdA7m7wFBGt9P3VDHvbM95hDWFKvGPVhP2fDbpwOm+PfP3764B7zi9DMxBSVZ9VZ9gqny3h541Fy2WzJfKSQ60cYZ5TAYWzDVINl/uSTzQFcdX7/Zo+Xt4cPnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVzFIaGT2MT/s8xKxDAjSmCB7BCNbTEWJ4g0vSgjfio=;
 b=oB9XzG/RSjP8DEomwggmez97fOpEe4lI921jTS2FkL2XddV6HRca+Ipt38eFFhgNxoaR9dX4SUsxzHUW4UOA/GhEXgousRKZCoFg+LKkFZUcwgTChbOYaUwWLaRP2MfTLKkq/vzD5lysfZPHbO1s2HugVK/EjhL2+bNMDnA5QjluAZTfyY3oJmeHn3uzXh693jjAqKAaEmV29N3ufoI3gFselwru3/7dKIPpjhqzNWu9vCeCnFmTvjo+16PpeFZP3xd8WtfY1uq/DRiWrK6yfxno4rW6pqE1YESu3yjlC2i6vffn20BxM17thEEJmmOyxpJIAe1WHVEA80s8nulzTA==
Received: from BLAPR03CA0023.namprd03.prod.outlook.com (2603:10b6:208:32b::28)
 by SJ0PR12MB6943.namprd12.prod.outlook.com (2603:10b6:a03:44b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 15 Sep
 2023 02:46:10 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:208:32b:cafe::f) by BLAPR03CA0023.outlook.office365.com
 (2603:10b6:208:32b::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20 via Frontend
 Transport; Fri, 15 Sep 2023 02:46:09 +0000
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
 15.20.6792.20 via Frontend Transport; Fri, 15 Sep 2023 02:46:09 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 14 Sep
 2023 19:46:00 -0700
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
Subject: [PATCH v1 2/4] vfio: assign default values to node params
Date: Thu, 14 Sep 2023 19:45:57 -0700
Message-ID: <20230915024559.6565-3-ankita@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230915024559.6565-1-ankita@nvidia.com>
References: <20230915024559.6565-1-ankita@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|SJ0PR12MB6943:EE_
X-MS-Office365-Filtering-Correlation-Id: c162bee1-2648-41ef-f2e3-08dbb595eaf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IDY1D7Zkcceh+c7aCsoXJhPnfYzRcgN6k9nPcZBSLvZnevSI9PZmafx15bEjB2zBWeoDx/xBavQfVCEgW+JE8mWn5lLsJTpnr7utncr46wtDiXL1+5s/euhhRiJs0pE6r7roRY48ig5kMMnsmn9ZBzDQe81yIEOOMwQG7CGtxQcCEpccBLNnmhcGlyut3E0GKhttiHAqshl5NMC2rjzb1eZyuTlAiICgLWcfcgwIQuENyEuBxncDjOd4GMz+tbh4fOlSPrEitFE9CVFbe8aHbnTJavmnoIux+8sWMfVA14kXFprxZ5+XDB5HPb2M+PddG40APdGKmWtc9l50Ai3Q4hX5w+pkbWMyC186fjKrsQyuvk03sC9mYbyEUpLIL0nJFA3ur/fuV9gFJJXs6KIuii9Iv4Ts4Z5XOTse7SmgC2mya4WulEYoXlBzW4AOE/O6Jj93tRTU58dY5+4asRBbP8+CUfVdLNximD0/nxH3n5N2JBozE8UQ16fpTtvWuPhrDpnq+WPKj2mbSOu6pBZXuqEfqwL4ibhuQOsJPMVDYL9agkW7ZFwtS++58hAGvBAhnIWsE3lLqSqYN+/GgG0PdmHQNssnc7J0GLvr97xEKubh/5jtF0mrExrL0MNba1XmEiyEwvilEJmliKRtgktL0IxBJs3XevxSiKPWkh1qOqyf862/q3PLnycR0CeUJ0mPsSvcL9u3rClzr//uFPrzWoes4mkeX/xEw/5NIAf1RArZx0b33qinPnXpHWZK+eUa
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199024)(1800799009)(186009)(82310400011)(40470700004)(36840700001)(46966006)(70206006)(7636003)(356005)(2616005)(7696005)(6666004)(36756003)(82740400003)(86362001)(36860700001)(47076005)(40480700001)(110136005)(40460700003)(54906003)(26005)(336012)(2906002)(5660300002)(83380400001)(41300700001)(478600001)(70586007)(426003)(4326008)(8936002)(316002)(2876002)(8676002)(1076003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 02:46:09.7858 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c162bee1-2648-41ef-f2e3-08dbb595eaf4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6943
Received-SPF: softfail client-ip=2a01:111:f400:7e8b::623;
 envelope-from=ankita@nvidia.com;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
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

It may be desirable for some deployments to have QEMU automatically
pick a range and create the NUMA nodes. So the admin need not care
about passing any additional params. Another advantage is that the
feature is not dependent on newer libvirt that support the new
parameters pxm-ns and pxm-nc.

Assign default values to pxm-ns (first available node) and pxm-nc (8).
This makes the new params optional and the feature will work on older
libvirt.

Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
---
 hw/vfio/pci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index cc0c516161..0bba161172 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3053,8 +3053,10 @@ static int vfio_pci_dev_mem_probe(VFIOPCIDevice *vPciDev,
     VFIODevice *vdev = &vPciDev->vbasedev;
     MachineState *ms = MACHINE(qdev_get_machine());
     int ret = 0;
-    uint32_t dev_node_start = vPciDev->dev_node_start;
-    uint32_t dev_node_count = vPciDev->dev_nodes;
+    uint32_t dev_node_start = vPciDev->dev_node_start ?
+                              vPciDev->dev_node_start :
+                              ms->numa_state->num_nodes;
+    uint32_t dev_node_count = vPciDev->dev_nodes ? vPciDev->dev_nodes : 8;
 
     if (!vdev->sysfsdev || !vfio_pci_read_cohmem_support_sysfs(vdev)) {
         ret = -ENODEV;
-- 
2.17.1


