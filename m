Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F89B7BC9BB
	for <lists+qemu-devel@lfdr.de>; Sat,  7 Oct 2023 22:19:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpDkl-0001UZ-Ik; Sat, 07 Oct 2023 16:18:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1qpDkh-0001Tq-Lt; Sat, 07 Oct 2023 16:18:19 -0400
Received: from mail-mw2nam10on20624.outbound.protection.outlook.com
 ([2a01:111:f400:7e89::624]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1qpDke-0005Jp-Tq; Sat, 07 Oct 2023 16:18:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L6EDvGDCHAzAKIPElbXHwJDhuqwav/B0eM0/Q8ljG8nuPXTU5u4w4Q7zpOTmLKCdzqbeMQ4o8e1jf5g73msc0aRaI5Xt01PcR/32AE7Aos57nv6xeWogQj4VEi5YaLvb5PrYu4ttv7aA4KlPmfnMnzedm5z+y9vdcF7Lo43fCl+6m2nlXjcfOg7hyY7BPpJ8yhmJZSYiYMHJVysLt/iRU/bgYY3EsYrSjWRzG2ueqnhC8jQqPGOf6hkOyvq1iNhqKhnbgNeLUEd6nLco1BvOxY/Uwczw5mb7PuzA4xq2iecdHXy61pZloDc5mv8lYSNJmHy6GAY4mkbLlav+qDjONA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4VC8FU3SRzDdPKu/Lpno6Ohrix8aAPEygkHfCM1ekTE=;
 b=UIboet/+k8DeWx03rAuUQl06enBiXaCJDf5gzcEsA+LMxNP99u6hkcaofZ8wV/sJT0rYA0TQrPrbb14mcEHUIt4QDVXhcJaMITOEzaiTrEGo90k2DBQJjLHBmg62eCYZgwYrtxe7mFsnhUEmwdFPoD9WnoWXEwoQmgttsG8Pqrj1BYFD+Bo1CyTpyE5PiCDRkKSMi8CNNyp8i9oAocN4cg6KpyqFyrNJADSu5Dp1wefbLIfsAJXb5N+ZFMiz+ukpztWLdj2Yym1j2N1BajLFZq9CHsNO6gA+/TzbjrsJZl2CjE7kGCmjqFzmtYeLZ5jb0TGp9tXEQGgdGp/VOHUphQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4VC8FU3SRzDdPKu/Lpno6Ohrix8aAPEygkHfCM1ekTE=;
 b=hmnPzjadTSo6qNFEfy6VIUSqFhOv79Cx2uAV5lG1Gy36kgjFbc67dzmFPx31qBGTHMOsNEnC8q9mVn/1vR+QajOdfMz0kJCrixAw/zi/9EXUG1emeCPBYhafYgvnh6qCFC1vnwt99l8L5RNjSapYdpyUrmWcX3ssiarKYaHnpJzKIsiV2ynEFURnkcZ6IJu2jlu4kGbOqwOWDSOHE45m+N6PIZ9xHy+0aBivn7FnRy1JVdxY8YinoqottvlejC/apoaLtiWysnzjyk6Dhk7ZA42MlI9B47KpVZTh0aeNZHtXGB+F+tXJsUSIrPzycjdyxP13x2PF8uBR5mTTy33z5w==
Received: from MN2PR16CA0056.namprd16.prod.outlook.com (2603:10b6:208:234::25)
 by CH3PR12MB7593.namprd12.prod.outlook.com (2603:10b6:610:141::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Sat, 7 Oct
 2023 20:18:09 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:234:cafe::10) by MN2PR16CA0056.outlook.office365.com
 (2603:10b6:208:234::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.35 via Frontend
 Transport; Sat, 7 Oct 2023 20:18:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Sat, 7 Oct 2023 20:18:06 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sat, 7 Oct 2023
 13:17:49 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Sat, 7 Oct 2023 13:17:48 -0700
Received: from sgarnayak-dt.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Sat, 7 Oct 2023 13:17:42 -0700
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
Subject: [PATCH v2 0/3] acpi: report numa nodes for device memory using GI
Date: Sun, 8 Oct 2023 01:47:37 +0530
Message-ID: <20231007201740.30335-1-ankita@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|CH3PR12MB7593:EE_
X-MS-Office365-Filtering-Correlation-Id: 698b15be-e3ac-4906-f5e7-08dbc77284d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eaa3l3rYBYmCPYb5F+RNBtwH86KfMSBCkb8tj9ysiT+DJ3WesTY0myaNVt2pgX1r+5lLgtt5P9C718sPG7o5ASrCBV7YFrI/95r0DY7NxjTS4ynrgsWPQTZJSygC6yt4mY8kmxP/OQ2ESKZvuVLJHyFx52CRBRv4IbJNGCv/Xl08wlR0nlCV16Mj/9OMUZW+E+Z38+XFVSO9/+sL91ae8PMaa3r1Bo3xQ45RtuBdspLsBE2hiZg+OsD8BsUY53/yF/Xrrb+y0f4opYqI12dj6ar1cVUsYL6BqKV6BozdAXEJyk+tR20mZ1DThjrycnk6EkW3COlog6RjRxD2+jDn54QuFgfg9yx7Qx4FmTOp165TKFhTamKjXuj7+Uarax+ht0W47B6p5HzSlsFxRIUn8uoLeUMqp79m8nM6pkj6S2n/Sy8G5ultl2wdlxSXNcWiJJ+pHvegqbdGziLfPsKpTfO9Lx01TbAZHFplYuVemwD4qER02/IaqMfNZOm6y6lwI7ZUrsU+oBfBrWNwByCGZp2yN6dOKp28IUPlrZ4I+U+0oWAWZ08dG/QKduU4Q8wwYcAjX6zr5L7Zjgdi4Rf34LHx0AnmZ2j/r1ZhgOGVzwiiWwZUKy/QbOUIKIxqhRa2dSVNP/mtQuhK29J+cEXy3KFvXZQeuGUguDn1y/rYzxpeMcnQic+JTB3eEGL3GWe5/KHpoGjwuktNMzjkDmlSYhKR8IHdAkamUrhEIeNcZHVq1zr4gIWjGEGJ0eHf9CMsv2MCHyw9BqE2KLJ9SoKTVYZoqX69Js47zNWAObNvzMYzsYT2z7uvw1syKmdmeHG99iIvGLF+aYArfa4V09U3Ig==
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(396003)(346002)(376002)(230922051799003)(451199024)(1800799009)(186009)(82310400011)(64100799003)(36840700001)(40470700004)(46966006)(40460700003)(1076003)(7696005)(2616005)(478600001)(966005)(6666004)(47076005)(336012)(426003)(26005)(2906002)(83380400001)(7416002)(2876002)(5660300002)(110136005)(54906003)(70206006)(4326008)(8676002)(41300700001)(70586007)(316002)(8936002)(82740400003)(356005)(7636003)(921005)(36860700001)(36756003)(86362001)(40480700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2023 20:18:06.9668 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 698b15be-e3ac-4906-f5e7-08dbc77284d0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7593
Received-SPF: softfail client-ip=2a01:111:f400:7e89::624;
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

There are upcoming devices which allow CPU to cache coherently access
their memory. It is sensible to expose such memory as NUMA nodes separate
from the sysmem node to the OS. The ACPI spec provides a scheme in SRAT
called Generic Initiator Affinity Structure [1] to allow an association
between a Proximity Domain (PXM) and a Generic Initiator (GI) (e.g.
heterogeneous processors and accelerators, GPUs, and I/O devices with
integrated compute or DMA engines).

Implement the mechanism to build the GI affinity structures as Qemu
currently does not. Introduce a new acpi-generic-initiator object
that links a node to a device BDF. During SRAT creation, all such
objected are identified and used to add the GI Affinity Structures.

A single node per BDF is insufficient for a full utilization of the NVIDIA
GPUs MIG (Mult-Instance GPUs) [2] feature. The feature allows partitioning
of the GPU device resources (including device memory) into several (upto 8)
isolated instances. Each of the partitioned memory requires a dedicated NUMA
node to operate. The partitions are not fixed and they can be created/deleted
at runtime.

Linux OS does not provide a means to dynamically create/destroy NUMA nodes
and such feature implementation is expected to be non-trivial. The nodes
that OS discovers at the boot time while parsing SRAT remains fixed. So we
utilize the GI Affinity structures that allows association between nodes
and devices. Multiple GI structures per BDF is possible, allowing creation
of multiple nodes in the VM by exposing unique PXM in each of these
structures. Implement a new nvidia-acpi-generic-initiator object to associate
a range of nodes with a device.

The admin will create a range of 8 nodes and associate that with the device
using the nvidia-acpi-generic-initiator object. While a configuration of less
than 8 nodes per device is allowed, such configuration will prevent
utilization of the feature to the fullest. This setting is applicable to
all the Grace+Hopper systems. The following is an example of the Qemu command
line arguments to create 8 nodes and link them to the device 'dev0':

-numa node,nodeid=2 \
-numa node,nodeid=3 \
-numa node,nodeid=4 \
-numa node,nodeid=5 \
-numa node,nodeid=6 \
-numa node,nodeid=7 \
-numa node,nodeid=8 \
-numa node,nodeid=9 \
-device vfio-pci-nohotplug,host=0009:01:00.0,bus=pcie.0,addr=04.0,rombar=0,id=dev0 \
-object nvidia-acpi-generic-initiator,id=gi0,device=dev0,numa-node-start=2,numa-node-count=8 \

The performance benefits can be realized by providing the NUMA node distances
appropriately (through libvirt tags or Qemu params). The admin can get the
distance among nodes in hardware using `numactl -H`.

This series goes along with the vfio-pci variant driver [3] under review.
It is expected for a vfio-pci driver to expose this feature through
sysfs. Presence of the feature is checked to enable these code changes.

Applied over v8.1.0-rc4.

Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
---

[1] ACPI Spec 6.5, Section 5.2.16.6
[2] https://www.nvidia.com/en-in/technologies/multi-instance-gpu
[3] https://lore.kernel.org/all/20230912153032.19935-1-ankita@nvidia.com/

Link for v1:
https://lore.kernel.org/all/20230915024559.6565-1-ankita@nvidia.com/

v1 -> v2
- Removed dependency on sysfs to communicate the feature with variant module.
- Use GI Affinity SRAT structure instead of Memory Affinity.
- No DSDT entries needed to communicate the PXM for the device. SRAT GI
structure is used instead.
- New objects introduced to establish link between device and nodes.

Ankit Agrawal (3):
  qom: new object to associate device to numa node
  hw/acpi: Implement the SRAT GI affinity structure
  qom: Link multiple numa nodes to device using a new object

 hw/acpi/acpi-generic-initiator.c         | 213 +++++++++++++++++++++++
 hw/acpi/meson.build                      |   1 +
 hw/arm/virt-acpi-build.c                 |   3 +
 hw/vfio/pci.c                            |   2 -
 hw/vfio/pci.h                            |   2 +
 include/hw/acpi/acpi-generic-initiator.h |  64 +++++++
 qapi/qom.json                            |  40 ++++-
 7 files changed, 321 insertions(+), 4 deletions(-)
 create mode 100644 hw/acpi/acpi-generic-initiator.c
 create mode 100644 include/hw/acpi/acpi-generic-initiator.h

-- 
2.17.1


