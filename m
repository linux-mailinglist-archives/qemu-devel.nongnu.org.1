Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C27781DE23
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Dec 2023 05:57:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rHd1A-0007wo-Ad; Sun, 24 Dec 2023 23:56:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1rHd17-0007vH-NX; Sun, 24 Dec 2023 23:56:41 -0500
Received: from mail-bn7nam10on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2009::600]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1rHd12-0001iN-8p; Sun, 24 Dec 2023 23:56:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQbp9t7K+GE/AnTVHZL5/jAf9ODN2ukMoBEORL7YhmN764LYFOv0YCB9TvNGTxcFB0Xer4BFYYBbluQ8b8QemHwI6bVhXxKQtyCV9EyScmFqIxaZQXaczEF3WCvFh/ryTUCvDsTsk81ZD+6/p1ecRIekPbWy2uqUXutpZZqZswcNa47ElEffw8KqVFvRfSkmbggPy3L/e4jb729jIQcHbXLBv6TPa9eG5Bvn1AZITFicFJSstHf82tMjU5UwOkI4ryWUx2VYuG6S4bD2ebjRlPZ/sAzxhfxXShXrwaLDAmVCYF9uBsj5gIi0V0VbfmQ5BIBvZALkmRr4tv530swsiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hbm/jYNu0BZfNc2o4umEeC5H1hnuEpMyf2F352xUxXE=;
 b=ZMgHSQecjgLh+uJgEHoCYPxA4LZJ/2KiA7VNIuHjSp3qIII3U6XzN/qdrqH4kvOu3CgAWjVA68C+bo0DJmMgutyxZGodtn9joTv/VQSJ/nhT71gHlLqZVSvT1wRX/0mntfJOwaXzAm5bY1vghZ4Qw8tiUco/M1jgUOeU6LNUnIbwDy0GdTUARBhEx6jun1ameDfk1JnOmQKYbeQ6Za7V7NV7XqSsjVrmCiCw0JMCPFuKsGZrNTZvLAJlOJ2gIUyCEmn8YKUOq3sxfvBLdqkqPyqgmfveF3LngHSlae+ldvqxBcDPxcJqerp2/kHtGADGFiatAG1HEHQ1sEIbglR2Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hbm/jYNu0BZfNc2o4umEeC5H1hnuEpMyf2F352xUxXE=;
 b=tX1wsB6HS+VNsDNLoA4M4LRzdQje618bzrHmWkSpaibhUIrOQ2luPZC5l18Bb0a83sWnzGZvnn+D1Hqqk29RmwkQEsWGfWP1U/Fn1WYbjk30H5f+Ur6eSVDslu3KKrDWJRJUGHPPljCzA4Ygla9FMoTNYA0HRZMhK6B+Lv7pEbgAaRZe7eaG830l4O8+/zapAO4hci+fk2N96LeYIDE2HU6NF4+Knkg5mbUT6NM08s6ordHT3vr0UELtqqrU9xZavMB7Ws7Z3waeB7BQ/Ij6rFdYqNtKITB6/GnkjYSZmNyF4TneXjH5ICK7mNLQ5gNJjdZSFDCwVhwMr+LQCxz2dA==
Received: from BL6PEPF0001640F.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:16) by DM4PR12MB6328.namprd12.prod.outlook.com
 (2603:10b6:8:a0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Mon, 25 Dec
 2023 04:56:27 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2a01:111:f403:f902::1) by BL6PEPF0001640F.outlook.office365.com
 (2603:1036:903:4::a) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28 via Frontend
 Transport; Mon, 25 Dec 2023 04:56:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7135.14 via Frontend Transport; Mon, 25 Dec 2023 04:56:26 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 24 Dec
 2023 20:56:12 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Sun, 24 Dec 2023 20:56:12 -0800
Received: from sgarnayak-dt.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Sun, 24 Dec 2023 20:56:05 -0800
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
Subject: [PATCH v6 0/2] acpi: report numa nodes for device memory using GI
Date: Mon, 25 Dec 2023 10:26:01 +0530
Message-ID: <20231225045603.7654-1-ankita@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|DM4PR12MB6328:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e458e3d-ce57-4c8a-b173-08dc0505d981
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IGFSx6CeQqr9iL0OuORgKVyNe9pyExuH8p7vmTmD8HaX/3rXw7T3sHO+AgqT9G2hEqMfN+y03Lbv9Zi33GucWqMBSMeSx81YWr6qvkduGyP21pOtbx77QfeudiGr2wNf+H1Wcq+UTk0zTg4y9tra5cj2tCjRG+zVZbjrXxEsU/+recQWtHUL0Mi0bxoutQ0Z5pP89ZXtQobejD/sh5aAJAS4trL0v3TzLKX1gHZRIQMkhvD1gBeI0pgJWNqbk1h7QqXO6E2poVHSq54131SrO5RZ+NW/lKTqnfnx3gyvz/sTOHsA2uLH4W3Qv2weiQpnoh5FV9CF9HHnb5yfouB6hwEF4VsQe1GlBFUPMxCq747bvVaZnAJMTFUbCXkxfzg8KaSS3L4kvXeK8s3JMSxurJfYSdd3F9xxDZ3eF19vExcomO6YG0F1eXDUd2vU/7heDuZ0L9v+bxoUtgfVX5Eq0kFFkCR5bobRQGe4hz22mU1m3nF4cjEazsQOVslr8YM0Xo9TP88xOmvPgj27KTK8JR5zJyqi9qMbjC1cM67zRkVaT2G3CAAEh0fczzenMu4AJH4yrEvmtY75/kqZbsWnHLB3klDzLbTo8UsVKuYUt0z4ijneW1CfIyQKOGc6p3kpNR1dUFF3xw+rDfaRY/UaR5JmY2xI3lqF5wA5Q8YAWNDZE6u8JX2Sfda1+Qm2bcSyhop+ZU+sNhxAmkCVw/cGWSWc/1mY04Lu2gYSy5mA3RW4RTaytbnfdFwN8FKhuN78CzviRFD7i/6J3a+lCeo45x5lH5isoB5WbOjS2ioPX0w=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(376002)(136003)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(82310400011)(40470700004)(46966006)(36840700001)(1076003)(26005)(7696005)(2616005)(83380400001)(336012)(426003)(86362001)(8936002)(40480700001)(316002)(54906003)(70206006)(8676002)(70586007)(4326008)(6666004)(110136005)(966005)(478600001)(7636003)(82740400003)(921011)(47076005)(36860700001)(356005)(40460700003)(7416002)(2876002)(41300700001)(5660300002)(36756003)(2906002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2023 04:56:26.0023 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e458e3d-ce57-4c8a-b173-08dc0505d981
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6328
Received-SPF: softfail client-ip=2a01:111:f403:2009::600;
 envelope-from=ankita@nvidia.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.594,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=2.979, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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
only PCI device is supported. On a multi device system, each device supporting
the features needs a unique acpi-generic-initiator object with its own set of
NUMA nodes associated to it.

The admin will create a range of 8 nodes and associate that with the device
using the acpi-generic-initiator object. While a configuration of less than
8 nodes per device is allowed, such configuration will prevent utilization of
the feature to the fullest. This setting is applicable to all the Grace+Hopper
systems. The following is an example of the Qemu command line arguments to
create 8 nodes and link them to the device 'dev0':

-numa node,nodeid=2 -numa node,nodeid=3 -numa node,nodeid=4 \
-numa node,nodeid=5 -numa node,nodeid=6 -numa node,nodeid=7 \
-numa node,nodeid=8 -numa node,nodeid=9 \
-device vfio-pci-nohotplug,host=0009:01:00.0,bus=pcie.0,addr=04.0,rombar=0,id=dev0 \
-object acpi-generic-initiator,id=gi0,pci-dev=dev0,host-nodes=2-9 \

The performance benefits can be realized by providing the NUMA node distances
appropriately (through libvirt tags or Qemu params). The admin can get the
distance among nodes in hardware using `numactl -H`.

This series goes along with the vfio-pci variant driver [3] under review.

Applied over v8.2.0-rc4.

[1] ACPI Spec 6.3, Section 5.2.16.6
[2] https://www.nvidia.com/en-in/technologies/multi-instance-gpu
[3] https://lore.kernel.org/all/20231212184613.3237-1-ankita@nvidia.com/

Link for v5:
https://lore.kernel.org/all/20231203060245.31593-1-ankita@nvidia.com/

v5 -> v6
- Updated commit message for the [1/2] and the cover letter.
- Updated the acpi-generic-initiator object comment description for
  clarity on the input host-nodes.
- Rebased to v8.2.0-rc4.

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


