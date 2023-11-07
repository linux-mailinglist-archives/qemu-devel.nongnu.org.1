Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DEF7E48EA
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 20:02:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0RKU-0006Fb-0D; Tue, 07 Nov 2023 14:01:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1r0RKL-0006Ez-Dv; Tue, 07 Nov 2023 14:01:30 -0500
Received: from mail-bn8nam04on20617.outbound.protection.outlook.com
 ([2a01:111:f400:7e8d::617]
 helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1r0RKI-0004GA-PR; Tue, 07 Nov 2023 14:01:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eal2oYP2qsvL/RfZ8zRKdzacp1vv0xVptoaQMbqdxqNcush9Fw9ZUo19t5ik6YC9fJLsFtdZ+yOlPusHLObXg4x4Upyhv79F3VrrrTcBIaWY5QnRniT3b/wnlZOiOY7Uqn3gR+LoJSUNcDLj71qbDOay3gMIdyq2XaVWD7Fh+KhSTp5axUUmP/SkJyO8LOqLuD/lXjXaWM/cc6qXX1hmE9sfr2hAnHRNJ7DAus9lVioM8cBEb6iI5fo9PXogTMY/Jz+JeUPvjY1RdyLsCV8Rp1ZzoUtBa2fqTCHYnV00pUNUy9lbw4z1PCCimf5ZGhNn9AhOzcLrpGjo63ohPtGVOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YlpvG9U/ANRRVIq4kCko71MbL5gZbxTXBEX3dvfaFKY=;
 b=KBToijn6MsUQdc+9A8pIKDPtXiWoSp0rjuX+IMzDane/GNY0SELtEaxWVnNCEPuesqiu8aj8tVkmSofxaL4FRDpMAlt2ZOfRc3m/sd99pe1t4bH1ZYMY0ZjI1JRGenon+YP9C6vymQm/RMt8HtPErrWDDHZQCSDXC0S4Im2oioedKaHNbGM5CI2jeFu7EuGzYLPBmX97U61B+PKnUT1n+h3JU26t0ZOMZWEuwLLfXvArl/I+rzXCBAlADTopE3ylAXbkZB/eAEdCUw2KRZzJkzm8e5pHruw1g0GFwJF4PHfw0YQMPCFh5y8iYirf1AT7i7olafN2uPuLtKq4+Npfxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YlpvG9U/ANRRVIq4kCko71MbL5gZbxTXBEX3dvfaFKY=;
 b=YmAx+3G1BCvMcUXMT3p4ni3baun4iTzXGWxIK51v7ELhusP/Rmz6GBC/5hLJUekJ93jfHxsEqYTlgWZfdG0G3Ue/5BGMc4r3Vz2NDkEh1x9R2eLyXerc5LrVxX3wgePlEB24mW/X5vvtEg3TYBs9gsVrNebtW6ZRxRPgbcdXI5kX37lQl/w+0q39F5O3lLRx2UPbs57alqBkBarsTud+bADm8nE8OdrFI6QGQyOAeywitTg6SpIflzG7hbgis5Wu1upM5CfDgmkDQymHlRrkUH//UJjh90j7t4s04LQoiAit2U8xDxj+YHQqwcgaq720VSGa7mDg9DWc4TYBn415tA==
Received: from BLAPR05CA0044.namprd05.prod.outlook.com (2603:10b6:208:335::27)
 by CY8PR12MB7684.namprd12.prod.outlook.com (2603:10b6:930:87::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 19:01:18 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:208:335:cafe::24) by BLAPR05CA0044.outlook.office365.com
 (2603:10b6:208:335::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.17 via Frontend
 Transport; Tue, 7 Nov 2023 19:01:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.16 via Frontend Transport; Tue, 7 Nov 2023 19:01:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 7 Nov 2023
 11:00:49 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 7 Nov 2023
 11:00:49 -0800
Received: from sgarnayak-dt.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Tue, 7 Nov 2023 11:00:41 -0800
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
Subject: [PATCH v3 0/2] vfio/nvgpu: Add vfio pci variant module for grace
 hopper
Date: Wed, 8 Nov 2023 00:30:37 +0530
Message-ID: <20231107190039.19434-1-ankita@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|CY8PR12MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: b74c8988-3843-4a39-efbc-08dbdfc3eb82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WHtCTt1OLkyJgLPtn07ca9iSrvZQR9nujpoSUessx0OXGSPMPAvxgUlMCle0Mi6th1tISam8m1y8lQFdd/Dx2k0EZXnoHsMauu4ahHRprW/R5tYoB5P5joyH1Fa6LxoLcjKNxpObhTN94umNJQX6rTDKJO2K+mQOzJsxUR/CF1XL/SlCWlXZ7phagCk6c8cMQBEQd1TUTd8m49idMwUzllFwJ27B+1Y791shXis2/HeFM+IIip28Wi8/4XmfMUAc9758eRtlkyRk1YnY3oA66hiw+RCFYuI+YYNl0fLCo91CdzXBpp29zgJ2lyVKoU+4/fQw/0cz6ZXyL+dpKD5UGUreqJ56vCOU+grw9zXNhZo4hR78EIhcJChkjk0QE8PHBQ7tEZncX0Lik82wb6aB2gNMUvqBSZQquMLVn2+O7nBufGC7cSYmhSkbcZvNHajqhd7nfTQI8Hwjy7YLje09SWvmOUbN7+qis8TS0+ppQAVGabXzJ/KZlbnZTnU7u5AukF/av6MrTSp5dd481CPk2p5B2YznCFlBCoE4nEbq+pOJ38K+bpsNCu53SQj627/X/qjoirgVuhst0WHjjbaBe09JavjBfCFNhX0RK6tdc+UERcZdj5eMVp/mkoO0wc2xXl+QM/fMzlxVLpPb3pedPlpMpAT4cidxacakvy113wtdZC7cavPcmunMRsoLUvjLEANiZh4oDtgK7eUioPUCIOIquagoZZeSLzfqj+sFkLMtqWhuxmFagMZ9vIveah6H9eD3hbdnce37eqj+y0nfyeBv0oRfhG1fNP2bijsr7p7u/dxNDLMQn2OTF7CeQaHoiRmuXCYJTVUQflG6kvMvrw==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(39860400002)(136003)(376002)(230922051799003)(186009)(82310400011)(1800799009)(451199024)(64100799003)(36840700001)(40470700004)(46966006)(6666004)(478600001)(2616005)(7696005)(966005)(47076005)(83380400001)(336012)(426003)(1076003)(26005)(110136005)(2906002)(2876002)(41300700001)(7416002)(70206006)(5660300002)(316002)(70586007)(921008)(8936002)(4326008)(54906003)(8676002)(36860700001)(36756003)(82740400003)(7636003)(86362001)(356005)(40480700001)(40460700003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 19:01:16.3869 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b74c8988-3843-4a39-efbc-08dbdfc3eb82
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7684
Received-SPF: softfail client-ip=2a01:111:f400:7e8d::617;
 envelope-from=ankita@nvidia.com;
 helo=NAM04-BN8-obe.outbound.protection.outlook.com
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

There are upcoming devices which allow CPU to cache coherently access
their memory. It is sensible to expose such memory as NUMA nodes separate
from the sysmem node to the OS. The ACPI spec provides a scheme in SRAT
called Generic Initiator Affinity Structure [1] to allow an association
between a Proximity Domain (PXM) and a Generic Initiator (GI) (e.g.
heterogeneous processors and accelerators, GPUs, and I/O devices with
integrated compute or DMA engines).

While a single node per device may cover several use cases, it is however
insufficient for a full utilization of the NVIDIA GPUs MIG
(Mult-Instance GPUs) [2] feature. The feature allows partitioning of the
GPU device resources (including device memory) into several (upto 8)
isolated instances. Each of the partitioned memory requires a dedicated NUMA
node to operate. The partitions are not fixed and they can be created/deleted
at runtime.

Linux OS does not provide a means to dynamically create/destroy NUMA nodes
and such feature implementation is expected to be non-trivial. The nodes
that OS discovers at the boot time while parsing SRAT remains fixed. So we
utilize the GI Affinity structures that allows association between nodes
and devices. Multiple GI structures per device/BDF is possible, allowing
creation of multiple nodes in the VM by exposing unique PXM in each of these
structures.

Implement the mechanism to build the GI affinity structures as Qemu currently
does not. Introduce a new acpi-generic-initiator object that allows an
association of a set of nodes with a device. During SRAT creation, all such
objected are identified and used to add the GI Affinity Structures.

The admin will create a range of 8 nodes and associate that with the device
using the acpi-generic-initiator object. While a configuration of less than
8 nodes per device is allowed, such configuration will prevent utilization of
the feature to the fullest. This setting is applicable to all the Grace+Hopper
systems. The following is an example of the Qemu command line arguments to
create 8 nodes and link them to the device 'dev0':

-numa node,nodeid=2 \
-numa node,nodeid=3 \
-numa node,nodeid=4 \
-numa node,nodeid=5 \
-numa node,nodeid=6 \
-numa node,nodeid=7 \
-numa node,nodeid=8 \
-numa node,nodeid=9 \
-device vfio-pci-nohotplug,host=0009:01:00.0,bus=pcie.0,addr=04.0,rombar=0,id=dev0 \
-object acpi-generic-initiator,id=gi0,device=dev0,numalist=2:3:4:5:6:7:8:9 \

The performance benefits can be realized by providing the NUMA node distances
appropriately (through libvirt tags or Qemu params). The admin can get the
distance among nodes in hardware using `numactl -H`.

This series goes along with the vfio-pci variant driver [3] under review.

Applied over v8.1.2.

[1] ACPI Spec 6.5, Section 5.2.16.6
[2] https://www.nvidia.com/en-in/technologies/multi-instance-gpu
[3] https://lore.kernel.org/all/20231015163047.20391-1-ankita@nvidia.com/

Link for v2:
https://lore.kernel.org/all/20231007201740.30335-1-ankita@nvidia.com/

v2 -> v3
- changed param to accept a ':' delimited list of numa nodes, instead
of a range.
- Removed nvidia-acpi-generic-initiator object.
- Addressed miscellaneous comments in v2.

v1 -> v2
- Removed dependency on sysfs to communicate the feature with variant module.
- Use GI Affinity SRAT structure instead of Memory Affinity.
- No DSDT entries needed to communicate the PXM for the device. SRAT GI
structure is used instead.
- New objects introduced to establish link between device and nodes.

Ankit Agrawal (2):
  qom: new object to associate device to numa node
  hw/acpi: Implement the SRAT GI affinity structure

 hw/acpi/acpi-generic-initiator.c         | 159 +++++++++++++++++++++++
 hw/acpi/meson.build                      |   1 +
 hw/arm/virt-acpi-build.c                 |   3 +
 include/hw/acpi/acpi-generic-initiator.h |  50 +++++++
 qapi/qom.json                            |  16 +++
 5 files changed, 229 insertions(+)
 create mode 100644 hw/acpi/acpi-generic-initiator.c
 create mode 100644 include/hw/acpi/acpi-generic-initiator.h

-- 
2.17.1


