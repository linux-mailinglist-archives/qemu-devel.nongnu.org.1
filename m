Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7F27F063F
	for <lists+qemu-devel@lfdr.de>; Sun, 19 Nov 2023 14:03:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r4hQx-0005tQ-Py; Sun, 19 Nov 2023 08:01:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1r4hQo-0005s3-Jg; Sun, 19 Nov 2023 08:01:47 -0500
Received: from mail-bn8nam11on20601.outbound.protection.outlook.com
 ([2a01:111:f400:7eae::601]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1r4hQl-0006e2-Sx; Sun, 19 Nov 2023 08:01:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mhDmZyG9vKTc/KPwicIXn/GNkZdL7IDInUyinirDM36g5nLxTgN5zrOQp4YgmgLJmm4GIC+HpCm7CqufdjyilS/tWFszKspdFqBagFTDcyUnuaeg64fSFF5JPv7jwJvAoOXQY4/C6h+WNfSKtPRk0ekunUk/2YcgHPmLu1VH10Z6pZQcU+qfsjBxj877xInenvlVns8DPJHqB05D3ozIGO5nhKt0wXpkzTQT0Jqv4hOkmZ1rJs+hkfYl96t9bUUsAebiQPTzcFcCOT/DyjVk7VYal1zPmt6k6w5PeYMflxTqwsHt2tqy59iCxFd2Eay67iuXdeiQsjGjNKnjJiCGSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4furlRRbn5M0yw/66K4Y0BOlLxkmSvIDKmPncu9VTo8=;
 b=JmJ9oifDn3DjvkC7za4Mbfwxz/r8aNNsIx8PajDwhIUWprMY0UanmWxRO2NfdtMNBtyAqSOED5D5k8pwImgB/7NxaCyW9iAnNgZupmBaHd+zyxp+Qj1RFrNjb/9EZ7XpWRbfJIsboNtKKIpku3gu8US50KP8kI6US8HtjnSkVHqE3MXMCaT6BKqFoJSvNshJg0zWXeYhXwKXti5pnLhW2LwHdOSlLSYz+vXnUs8VrPqzebNuDae75rp9fKNDKtuQ08HS9eQ1VCitoNaPCqa1f3lo2YEORLAnxZrJs2H5VclrXj6WtmDsOmu3V9x/giRzArNcqDQu+XlsBWMLrcUlBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4furlRRbn5M0yw/66K4Y0BOlLxkmSvIDKmPncu9VTo8=;
 b=LS4kSqvlh9S+2VNfO26ymWq9JoUCZVIfIUrsuqwcNPECj3hfSNL2GHF8di7zBDotIhFfMmPvF3Zm7mcUCAnTAEPxGe9daNYuwbAHkTywx/8Da7nVdi4t9vmSAkqj6cD/DXws9i4Mm4XjueI+JTA5GFFgVrWKYPendy1YuA76eZYEeH5NNua8fZKVob0J541IViauaKHEV5jgkS3dq75N598vwKqv/ZXZ3RfFj6JOo5dgq+RmAt3L40E9/JgyMBZBW8nlRyDd0FXQDzP0sdRhDxNfuoohFueH5lFSXb1+HUP9EgK6+E1gV3jgo7JZ5sxzChkDIieL+lykEKxLDLyTSA==
Received: from MN2PR16CA0027.namprd16.prod.outlook.com (2603:10b6:208:134::40)
 by CY8PR12MB7633.namprd12.prod.outlook.com (2603:10b6:930:9c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Sun, 19 Nov
 2023 13:01:37 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:208:134:cafe::e5) by MN2PR16CA0027.outlook.office365.com
 (2603:10b6:208:134::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.27 via Frontend
 Transport; Sun, 19 Nov 2023 13:01:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.12 via Frontend Transport; Sun, 19 Nov 2023 13:01:36 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 19 Nov
 2023 05:01:21 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 19 Nov
 2023 05:01:20 -0800
Received: from sgarnayak-dt.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Sun, 19 Nov 2023 05:01:13 -0800
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
Subject: [PATCH v4 0/2] acpi: report numa nodes for device memory using GI
Date: Sun, 19 Nov 2023 18:31:09 +0530
Message-ID: <20231119130111.761-1-ankita@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|CY8PR12MB7633:EE_
X-MS-Office365-Filtering-Correlation-Id: 66635bc7-2431-4b56-b1d1-08dbe8ffa9e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T2RHqqHCmlZZBkfxFZDDCFeUJ9PQgM4I2ls8OEvO9YfNA94turg65L6G+xDzK8W0Em/pO2zHd608wnqU/ZJHHk+mzP5geh59FC86QGP7ZD+TjUemOSu4mqHCDvm7+pUwIJLIzUYrsEPx+IA3rMszXClAjIzFsaY9uYlVrOz5YvcUEZLC1cjqnemjbvBomgACCDkM0l94yqycbzSRixmqkfzdbvlG2k0dmSPCeTzT1kaKuwY2ktmV2FyA8MtsHAiWBypZhuz99qdnAgxqYxLH3/4zBNf/j3vIkuGtSSDzY96oypDNcz1ASy3uRB2D3IjhHuRXube/Ybi0W2lenn/AwKZDXLAhGFoq/KX1lvM/cR9hg04HlXOwQdbYLPcY9zEO0dygfmK4fyBjuFjzvUrCimRRsuSGVURWQZSPtPy2bpxI7KnB0eWsv9m9CbCrplEz75SkkrCfXObkD3RkYavWbtLb4gL0IFzVwjtjwjIqWApo1t1PVPIoMRiC8RoQC8MB+BqcYA4EUKm0a32p353jiHKFj7UnffIarv+UYfzRZUuv3lH34SfvfnQjUupY+lntuf7DgQQHzZMQDFPS+Ii8pCxnWIuOioN4oIQhFWpB1Vkpz6W28gRlaqsjmxhq/fLHRk28D9eEQFw//T/HDi0D6I38mBPuzWuBOvkTgsKpxkONEILUcVSvtQTAlYiUeadrZP1Rv9EX5K/Lckujzq7j0/2jO2IzDi4R7A2P9hJ5wFDNX3neCe1f6+F1e3iS+bkJ9YqbyB+28O1FGlgEWCTEmXD/uo8f63KvhzS30lKIQ4tvFLy8969Na+idYo2LQ1kntdaGVOLEfyDZHnNxBWkpkw==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(136003)(39860400002)(396003)(230922051799003)(1800799012)(82310400011)(451199024)(186009)(64100799003)(46966006)(40470700004)(36840700001)(40480700001)(5660300002)(2906002)(2876002)(8676002)(4326008)(8936002)(41300700001)(7416002)(70586007)(70206006)(316002)(54906003)(110136005)(40460700003)(47076005)(86362001)(478600001)(1076003)(26005)(966005)(36756003)(6666004)(36860700001)(7696005)(2616005)(336012)(426003)(356005)(7636003)(83380400001)(921008)(82740400003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2023 13:01:36.6151 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66635bc7-2431-4b56-b1d1-08dbe8ffa9e9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7633
Received-SPF: softfail client-ip=2a01:111:f400:7eae::601;
 envelope-from=ankita@nvidia.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
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
objected are identified and used to add the GI Affinity Structures. Currently,
only PCI device is supported and an error is returned for acpi device.

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
-object acpi-generic-initiator,id=gi0,pci-dev=dev0,host-nodes=2-9 \

The performance benefits can be realized by providing the NUMA node distances
appropriately (through libvirt tags or Qemu params). The admin can get the
distance among nodes in hardware using `numactl -H`.

This series goes along with the vfio-pci variant driver [3] under review.

Applied over v8.2.0.

[1] ACPI Spec 6.3, Section 5.2.16.6
[2] https://www.nvidia.com/en-in/technologies/multi-instance-gpu
[3] https://lore.kernel.org/all/20231114081611.30550-1-ankita@nvidia.com/

Link for v3:
https://lore.kernel.org/all/20231107190039.19434-1-ankita@nvidia.com/

v3 -> v4
- changed the ':' delimited way to a uint16 array to communicate the
nodes associated with the device.
- added asserts to handle invalid inputs.
- addressed other miscellaneous v3 comments.

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

 hw/acpi/acpi-generic-initiator.c         | 185 +++++++++++++++++++++++
 hw/acpi/meson.build                      |   1 +
 hw/arm/virt-acpi-build.c                 |   3 +
 include/hw/acpi/acpi-generic-initiator.h |  56 +++++++
 qapi/qom.json                            |  18 +++
 5 files changed, 263 insertions(+)
 create mode 100644 hw/acpi/acpi-generic-initiator.c
 create mode 100644 include/hw/acpi/acpi-generic-initiator.h

-- 
2.34.1


