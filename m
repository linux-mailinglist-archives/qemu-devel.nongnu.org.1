Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0FC80212B
	for <lists+qemu-devel@lfdr.de>; Sun,  3 Dec 2023 07:04:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9fZS-0000bV-Jr; Sun, 03 Dec 2023 01:03:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1r9fZK-0000ZN-3Q; Sun, 03 Dec 2023 01:03:06 -0500
Received: from mail-co1nam11on2060c.outbound.protection.outlook.com
 ([2a01:111:f400:7eab::60c]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1r9fZH-0006Sk-Ja; Sun, 03 Dec 2023 01:03:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+/7kHWNo1JnvBFDnGagZkhzryzTC9MQvwu+j7W8CngZzUcWLEsGF9lJiON4DodhdzqVmIFQxQXNHGU0Rkv3tq/8RoM84UxPrIHrQmXw1eT8S2CKW8XR9ZN3MRvDkjXFJhlI5BfXrlsT2VKxRdn8CZk7C7i/RcwnHRgZkm+gF3a5a5O5bO0QfCZV2lLhpdF2PTv/vlIg3Jmabb3KdWAY25OuRZNGu2qnhoZob3x5RR1drICbgsU2tdsmg3hIo8bGT7XBPHY/5o5amVvC0KMiMzpIjB28NRRPTYUBqWvMd/KeneKKuh9Kl7bOkNiyp1E7b6OGRzQuKZxM9yCS0oXU8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4XF+RZA13GJye/VxIgi2Wa9pQjI4tdthSHGRlMfKlb8=;
 b=M7I6hGQGW+MGLWxfBxgbyfoRfWIYFXM2Pt4mfv4pHwZi99whTf8i/9hU72WjGeINQ4FIa2dqoZ9NXNOdSvDaLyU9pS7PuriBzn3WY4Nsd+GoYCiHh+m/dRw4sRPtSZS8MzwmQSbqpxi1yfwLK/Cp6HZQTPsTFskC7szXAREgt7jSe7aMqBhvDZf9RF5iFx/wk2D2FyJiMzOuFOfTbPm/VdgmKz5ytmzsoMIipzVlZyYkxsxGg0qAJieCEzDDQMNbEkN5RqZCffeuRNHlW5On45C384yOdYGy7ONsNZDWXrYjvyNqoxnwZo4ShomrM+dD/hsWMgqiNcPT7cgb/u9LzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4XF+RZA13GJye/VxIgi2Wa9pQjI4tdthSHGRlMfKlb8=;
 b=MOcAN6Ao1sTRTKYVNjK+RyU2mfiYTDyFf6i0mZkJS0ebTCp0UTyUl2xeGdEC9lDizXjxN9F3KLwEwrLcDd6GxKNYI7jDtS+LXlBaarTwT8WkxmD+ZYeoXm4Hkvy2g9e/AfJHiWV0JHk5vipqHWF+RtEYW9cCyO3Ga2fGJXNnvPhAN2ILgCSvOA/ZN8dpeEsb3HwIU/0ooY8TECfG6uzQp9u5cYv5kousqWjsRStzLkwqu0ZsDW9JVpEtG3p47xwMKEo7QaouA4KvktGgiRv/TcYBNwHQjmwRH+bvAS2vZr1WI8LB8j4/dFMMwV1OA+WbNJH9iZuqrNxwIpcGTH/lPw==
Received: from MW4PR03CA0246.namprd03.prod.outlook.com (2603:10b6:303:b4::11)
 by BL0PR12MB4866.namprd12.prod.outlook.com (2603:10b6:208:1cf::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.32; Sun, 3 Dec
 2023 06:02:55 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:303:b4:cafe::8) by MW4PR03CA0246.outlook.office365.com
 (2603:10b6:303:b4::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.29 via Frontend
 Transport; Sun, 3 Dec 2023 06:02:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.20 via Frontend Transport; Sun, 3 Dec 2023 06:02:54 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sat, 2 Dec 2023
 22:02:54 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Sat, 2 Dec 2023 22:02:53 -0800
Received: from sgarnayak-dt.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Sat, 2 Dec 2023 22:02:47 -0800
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
Subject: [PATCH v5 0/2] acpi: report numa nodes for device memory using GI
Date: Sun, 3 Dec 2023 11:32:43 +0530
Message-ID: <20231203060245.31593-1-ankita@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|BL0PR12MB4866:EE_
X-MS-Office365-Filtering-Correlation-Id: c19bfe35-37dc-48e8-4bd0-08dbf3c57db8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mBxyCksaJXDyo9mzbjDFz7IsQ38LXPyOERlbCJysVPIb4gOiYaOrLwrhlOKQJVW01emKvf1XLWJjyZlrLI7nVbUa/no+70HOSBu5iuzNSuFcmTVFVx/+ZW5Rjk//2dYsFriVHllhtPtyyHEtv+1Y2dCM1rD2LxNE57vbZpaxqG9Jhd5NcGmjd1jq1OPW1FkStoNukpMDX7rFPNRNLZZgl/gA1MkTb2fDETyzTeQISZ/BWEN/jF+7qrUhvTCenDV2VKQpyxn9dJjk+zeZ9r1vHAO+dDz3KSrLaPx6uld4mhTwCPIfrG0djttDWvkHAa8CL9d5IbbsC/1mZ5SPLKFbf6Hh+87+SocjnYFVES6Sqwkk0TePStA/VcjL53RqkTUG/8zdvbsBXzCqXvWsAA+yOVlTdoeosBxJWqEM0JVbADlKQy8l+oAv2AzPLJeetODPCA4f1tVKw4SZdKHB55mxKgnrQ0Sfah8RZEit5+Byung6dJxEpsQG7zCZxbziTwp0u1fncTjLUt6skB9tMs943wDnZojhpYtmKIYDwW9CkOccLQoCkjQQVFWRWfD/9GXHvj2KTMPMm3DVVSGqFsxKkzAA7ZYakOC21ciVZySaYWvYaiyzJCwD789bFNieCs9Q8ffsIy/lvQJmhaQHcUn74JOKQ2SVqqsN1VesOAqq6P6W72BtmWt/YRjyRN9xqVTEzxCPmKfBwDlRxq8aqDK9ysVyFSC4GRdXe7nwFAsvNrw8yv+V+EHUiedvjBGdiKQNpcHlWfkC8Csjn48+Fy461uHVYe16S105DB1M+kwx9CcqOoRlhkewTNPYrGtFOGLmsb3OsUm2H5BR0hxT8GzdUw==
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(346002)(396003)(39850400004)(230922051799003)(186009)(64100799003)(451199024)(82310400011)(1800799012)(40470700004)(36840700001)(46966006)(110136005)(70206006)(54906003)(40480700001)(316002)(70586007)(5660300002)(4326008)(8936002)(8676002)(7416002)(40460700003)(47076005)(2876002)(83380400001)(426003)(336012)(86362001)(966005)(2906002)(478600001)(6666004)(1076003)(26005)(2616005)(36756003)(921008)(7636003)(82740400003)(36860700001)(41300700001)(356005)(7696005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2023 06:02:54.5456 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c19bfe35-37dc-48e8-4bd0-08dbf3c57db8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4866
Received-SPF: softfail client-ip=2a01:111:f400:7eab::60c;
 envelope-from=ankita@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
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
only PCI device is supported.

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

Applied over v8.2.0-rc2.

[1] ACPI Spec 6.3, Section 5.2.16.6
[2] https://www.nvidia.com/en-in/technologies/multi-instance-gpu
[3] https://lore.kernel.org/all/20231114081611.30550-1-ankita@nvidia.com/

Link for v4:
https://lore.kernel.org/all/20231119130111.761-1-ankita@nvidia.com/

v4 -> v5
- Removed acpi-dev option until full support.
- The numa nodes are saved as bitmap instead of uint16List.
- Replaced asserts to exit calls.
- Addressed other miscellaneous comments.

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

 hw/acpi/acpi-generic-initiator.c         | 169 +++++++++++++++++++++++
 hw/acpi/meson.build                      |   1 +
 hw/arm/virt-acpi-build.c                 |   3 +
 include/hw/acpi/acpi-generic-initiator.h |  53 +++++++
 qapi/qom.json                            |  17 +++
 5 files changed, 243 insertions(+)
 create mode 100644 hw/acpi/acpi-generic-initiator.c
 create mode 100644 include/hw/acpi/acpi-generic-initiator.h

-- 
2.34.1


