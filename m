Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A2778723454
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 03:07:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6LAQ-0004VU-VV; Mon, 05 Jun 2023 21:07:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>) id 1q6K2n-0003YL-Sz
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 19:55:25 -0400
Received: from mail-dm6nam11on2086.outbound.protection.outlook.com
 ([40.107.223.86] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>) id 1q6K2m-00010D-3t
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 19:55:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l82PzI39rb5nElcpP6ruW6h76Xkuk1/cR6rBTAGrQaZUAx4iP4qJ+bxKJIBJk4mHsfyLlWn9EuU4m+2OslelTH1FifEB/rb0SvP8Jaw0iknhiAqfvh61zZP2ndfPi1TBF1hWUdjVdQZxgukJhREr9O4rVxLUzrxcuis1N1UI3fRn/B/TwGPx95iHGAa14Hq4o01Sueyxp4o3aPCj99JaxtHHeiZh8esoDCpdjskBwVFVBnWxfD89besWveXX4KLWmh3RrDxeKKPk3kxc8JPV+SkzvI7KCRlZfDLV5PnpS/DbcOftV4IbLG7QSZJYGSCyi9atf45srd6sC/BQJSBsIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wV6QLcsz5S7tQ5oqXnd1lpr6M9cwBGje4tNq4COCoKs=;
 b=OYjeuJxY3hOOi/9AFY8LaZX2PhHbWfmVYSkUG/26nL/GR1Nytud7JaDAL8ggag7bON49rmn/FmIuNa2HybLcKCRb37wKUPT5CLHk/qDpc5LonSiDg596hOl2nH8NoSQYFdBLgSsJWN2Ey677vpxBz33MkdwoZli7XFW//92JzythWOy29itR+kIEvuUzZSO74/IMu807PHExwdbFy8F0XAIXX5CrFbZyP7uPupbqz5NDZ/hyltiEEIDlgpZFv8W88Myz7RnEpF6s85PP8lQrBg37jzhmES2L8ng3Vk0KE6/z8+fLykUBOhYOJVKIjH8dhNqJcs7BD9bljiA9fBaj0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wV6QLcsz5S7tQ5oqXnd1lpr6M9cwBGje4tNq4COCoKs=;
 b=SzpQdaxkAHKKy7WpPAwGtuNFBCmitcQq+tQyK2LHXHaMjPcxrabW0/iGniq/dvO7tXNb3QEo5rlQ9MI4TeuJqDO0BiaFoMH2CJLjJ0X8Aax6JB1Wr8ItaaBptZNckq/XlSQwtbwrGH+md0NxTLMyRZwHteixG1/+JclERUzR4KR3n1h3s/49iA6NHnMBNrrfZ2D+lykWv+Es5G19cdk0Ig99cO77XG4eJvuA3bicTweFcHV32LOlRmkjSjsJvrgZEa6fkKF5WwgvtKYdatGxHofc9XblpXymBaT2HBXS+yfGvC7PkzdWvmbHCjOzQ7doNpiHtGu8yQo3VVj1cLJQAg==
Received: from BYAPR02CA0055.namprd02.prod.outlook.com (2603:10b6:a03:54::32)
 by MN0PR12MB6199.namprd12.prod.outlook.com (2603:10b6:208:3c4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 23:50:18 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:a03:54:cafe::b) by BYAPR02CA0055.outlook.office365.com
 (2603:10b6:a03:54::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Mon, 5 Jun 2023 23:50:18 +0000
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
 15.20.6477.13 via Frontend Transport; Mon, 5 Jun 2023 23:50:17 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 5 Jun 2023
 16:50:06 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 5 Jun 2023 16:50:05 -0700
Received: from ankita-dt2.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Mon, 5 Jun 2023 16:50:05 -0700
From: <ankita@nvidia.com>
To: <ankita@nvidia.com>, <jgg@nvidia.com>, <alex.williamson@redhat.com>
CC: <qemu-devel@nongnu.org>
Subject: [RFC v1 0/4] Expose GPU memory as coherently CPU accessible
Date: Mon, 5 Jun 2023 16:50:01 -0700
Message-ID: <20230605235005.20649-1-ankita@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|MN0PR12MB6199:EE_
X-MS-Office365-Filtering-Correlation-Id: 880ba672-1f72-4d17-a2a5-08db661f9dd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uHXYxijIpLVBWB4VOizubLR4gTHuccuP2V69q+f2XRWDO3hDcKWW1P8nUGX9BHXyeULl6qHwYzymom0B0l1srNgZtTGm1m6eD1Pd+vvk3dOgwqCQuDUW+J+V2sVuCV5vedm7fjPviSCtAErFmteh0dW7PNXbdM34P2QZ5FvtbR6BsgE9Oeh/NG+h5/R7HfVaH3ify5IUrbhNM+t8tr4XHaiedkXgZpA3Ge1JJ6VbqUsIRcAhsyv2ykwmKA3KYnxl3FPGxDO12TAMvTcufY1PkFkDey/Ckv3cxqf8WN23Xu9qYFp0sa7Fe+Mxwx0/zyIzN4C0ksoR4vvHzgfzq9N0wvnadWNExev63Vp2AY/VNTq6MJ69DAyfXh4I99M/pIEatjy43Ksk4CnEtLT7i9hJ3VhMW+czvphWx8CUFJob1GN9ulkXXcbfu5+tfRcnjUrYkcp++8k7rl3X3bVI7kpa0hnkhLqcIMwA6ai5ZJodYXH0sqikeP0clGpog7MwSJoGzt2g6gJxwUn6SeihstrBAIRS0QZnFFqeGGdaEW18KLFm6jpu6Abpct/79HK28R2s7HyX2QYsnrYI59LbwPRJCTA94vektEKw1Q8Yrb2z0k7MC3qFhFZM/JQ6M4khtxUUbvIjCN6wiLmORHVFI/l8Lh1xCziAT028XTnG4HP7An8QSIwTfRlJeSp8fMhUnkqXhS8PL9xEASr33glDOHj9/9bS9hrXR/EJogVgzRobW9Dz9I7BE2HrCIOpgiEsiraK8jAo+E++vOaTAm9GWqGKeQ==
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199021)(36840700001)(40470700004)(46966006)(8676002)(5660300002)(8936002)(316002)(2906002)(70586007)(70206006)(4326008)(110136005)(2876002)(41300700001)(966005)(6666004)(7696005)(26005)(426003)(336012)(1076003)(36756003)(186003)(2616005)(83380400001)(36860700001)(47076005)(356005)(7636003)(478600001)(82310400005)(82740400003)(40460700003)(40480700001)(86362001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 23:50:17.9956 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 880ba672-1f72-4d17-a2a5-08db661f9dd9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6199
Received-SPF: softfail client-ip=40.107.223.86; envelope-from=ankita@nvidia.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
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

NVIDIA is building systems which allows the CPU to coherently access
GPU memory. This GPU device memory can be added and managed by the
kernel memory manager. The patch holds the required changes in QEMU
to expose this memory to the device assigned VMs.

The GPU device memory region is exposed as device BAR1 and QEMU mmaps to
it. It then adds new proximity domains to represent the memory in the
VM ACPI SRAT. This allows the device memory to be added as separate NUMA
nodes inside the VM. The proximity domains (PXM) are passed to the VM
using ACPI DSD properties to help VM kernel modules add the memory.

Current Linux cannot create NUMA nodes on the fly, hence creating enough
NUMA nodes in ACPI is needed so that they are available at the VM bootup
time. The physical platform firwmare provides 8 NUMA nodes, which QEMU
is emulating here.

A new vfio-pci variant driver is added to manage the device memory and
report as a BAR. Ongoing review of the corresponding kernel side changes
along with the new vfio-pci variant driver.
Ref: https://lore.kernel.org/lkml/20230405180134.16932-1-ankita@nvidia.com/

Applied over v8.0.2.

Ankit Agrawal (4):
  qemu: add GPU memory information as object
  qemu: patch guest SRAT for GPU memory
  qemu: patch guest DSDT for GPU memory
  qemu: adjust queried bar size to power-of-2

 hw/arm/virt-acpi-build.c    | 54 ++++++++++++++++++++++++++++
 hw/pci-host/gpex-acpi.c     | 71 ++++++++++++++++++++++++++++++++++++
 hw/vfio/common.c            |  2 +-
 hw/vfio/pci-quirks.c        | 13 +++++++
 hw/vfio/pci.c               | 72 +++++++++++++++++++++++++++++++++++++
 hw/vfio/pci.h               |  1 +
 include/hw/pci/pci_device.h |  3 ++
 7 files changed, 215 insertions(+), 1 deletion(-)

-- 
2.17.1


