Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0933A73D9B5
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 10:29:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDhbG-00019A-7X; Mon, 26 Jun 2023 04:29:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qDhbB-00015U-Nu
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 04:29:25 -0400
Received: from mail-mw2nam10on2086.outbound.protection.outlook.com
 ([40.107.94.86] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qDhb4-0004EG-1F
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 04:29:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CXhqZ+untx3htWpPgkuVtKC8lXNUIMU80LJPQE4E/oefLBPEPoEum8Vfv3JecUaSO6AaLL2NapgkNa+SVPPD6YfkC9k/phioJJvXfICRTJCQHTi8JOXb3XawKI8A4r/QOtKqjWlt4Sd4KyoKglppCCFkMiSSDmru1xY9EjtnAtN0TczMKj4/aCdY6SbKf+5Yw1fTVhKS6zhU3r+Z6aMtO7YmAdnFJvNi1FWV8FKv8WDtiBRX8A4+oN3Oa+CRdTnExS07YWs4GjeOZeOlRj5kQ1UrKS9kzbtLvX35V1cTq/99xiKXYmmzXVfXVfwRNGbPCobf2TncUFCUGeZvdq7v9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yIUaeOP0kqVYd6QAjksV1vaN0rsfWOmQCAoa3numy38=;
 b=gUH/CGXBq8T9p+dHtRadrdC+0DHeRRtrrQmwfQ8QS+is9DpHEqv6RkSJHogCtjlE3uLEX2VBz8jOp/jE60i9HFGmEBR32Jry4OzyNKcXzvjFvIOS7B1NE8/xdnBsbhsNmkwGstoMCHd821YVb1HOkRrun1ruCtkoujTRgzSY6I494Cv9D0rvq/WhKR+poPfhNInO/FeQ4yh49MwBSTvcrJ6Ni5eVcVN9Osye5osUfSXbzY/EDWg/gTjspuKFfm/K7B6zNn+v+HNZXWDA267ziwhmtnyWAVU1GgArj2ahVtpuTHlNDtkQJ6r0++HNb08doYONFDL9qNxh55XMFHm3wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yIUaeOP0kqVYd6QAjksV1vaN0rsfWOmQCAoa3numy38=;
 b=Ly4ZM2DbaqGgp/60SadH1UyBZfdJ0t3HkleJGjTnj+DAK0qL+uv9qxS2aOUMB/CLg0yDTQntg3EgEfcDwflKtPZ+V+8mDwzSIMqVaoEBPNASvCS548keky8A3VFp1wWJKEqsHDdgWWtFUoSx8ihsdImYRqNUm26VKGCAk8gRDSOPpDDHxgiYKqHjNOoPxoXaC8vRaoG9OYhcA6D8447sGU2gbxxHyQh1OZhPfoalttaYhDXprDAHutJnYHwTobCvkAbcCE0W9KAoMCBM5YwuShAxCQySKd3MTMW/XTLDa+vWLj0SXaw8j4D1Z/TtbjlomAWvs+czpk9U4HQv65mavA==
Received: from BN9P222CA0009.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::14)
 by SA3PR12MB8762.namprd12.prod.outlook.com (2603:10b6:806:31f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Mon, 26 Jun
 2023 08:24:11 +0000
Received: from BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10c:cafe::88) by BN9P222CA0009.outlook.office365.com
 (2603:10b6:408:10c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.33 via Frontend
 Transport; Mon, 26 Jun 2023 08:24:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT065.mail.protection.outlook.com (10.13.177.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.47 via Frontend Transport; Mon, 26 Jun 2023 08:24:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 26 Jun 2023
 01:23:58 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 26 Jun
 2023 01:23:57 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Mon, 26 Jun
 2023 01:23:54 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Juan Quintela
 <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>, Yishai Hadas
 <yishaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb
 <maorg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>, Kirti Wankhede
 <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>, Joao Martins
 <joao.m.martins@oracle.com>
Subject: [PATCH 0/3] vfio/migration: Make VFIO migration non-experimental
Date: Mon, 26 Jun 2023 11:23:50 +0300
Message-ID: <20230626082353.18535-1-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT065:EE_|SA3PR12MB8762:EE_
X-MS-Office365-Filtering-Correlation-Id: 73172ca4-faf2-4b5e-3b3d-08db761eb82d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: euBEIvt8uYbPa2wVaXwrbc/rg2JhHubN2IOgFlZnF7UJiCKDmaJ0lEhgqdqRov1uhwj+fpdCxV79NwtJPI8s6R69G8rfNbNOgPyCur49JvuOwq3iAOcYIyWqhtoNZGRfcq+LmcXP+FW0J2JYx6KT32yDM0Hay00JtgeUg/LZEMONJ/jn3U6xL+MF+jgE/pYMatxyymTLJtYNScQxnNOGfsFFzGkBXwQ+r2z551LkeA588AQx2M3ReKudimtuXIeHUkEaZpWKNCmgSwxdvClifzbv9mF5iGjmQARwrAnmCkoxIbcDEq/KDgANRTr7XJGIgFplNbKgPqfORUGLuq9EdNzgVkKoNSBAH+0ZILgxbSuw0COS4KK75XP7LnRvBgLiNLNVjwV0tGubcfTNPV5XdJjiCx6vzhDDSsX1taDloyG2OqWU+KD1y13cc/5RkctUhK+464zINIeoP0FMamIK7bg4BzqPpQbqMmRCJk4cxBVDgg7cfBqQb/GUatTyLWJpfk/WhZmOsQcIspLKnkOfxVK5VY2phAId2enp+3EF1ZJ/+T14Kqu3JbV7WBHpCBPmyG59rNet8VCnXi9sQEh8H7ylpJfivNH9CgzJEVCVQkeNiZNWg9KqAsl4yCl7I7hgoljDDVbqe5gNxmG97PSdc9JARwshRn81PvTjkETnpUcvG9bokEvU4cPdevar8hiWiCdGKFCEiJ0TvNV7EBXHsHg4PGJxcV+CThbCP38opoX8Ka3VKbVJ8GPny4xC7e6xLD5yh3o4nWaWtMZkjiellDuVDHCdSiETp1/ih59kdIs7rdTfDWFW/NZYfYgzFU8F
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(82310400005)(36860700001)(47076005)(966005)(478600001)(426003)(54906003)(2616005)(6666004)(7696005)(336012)(83380400001)(1076003)(26005)(186003)(2906002)(5660300002)(356005)(36756003)(70206006)(40460700003)(70586007)(82740400003)(40480700001)(7636003)(8936002)(8676002)(316002)(86362001)(6916009)(4326008)(41300700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 08:24:11.2091 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73172ca4-faf2-4b5e-3b3d-08db761eb82d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8762
Received-SPF: softfail client-ip=40.107.94.86; envelope-from=avihaih@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hello,

The major parts of VFIO migration are supported today in QEMU. This
includes basic VFIO migration, device dirty page tracking and precopy
support. Thus, at this point in time, it seems appropriate to make VFIO
migration non-experimental.

This short series (which is based on the precopy series [1]) does that
and also adds a few improvements:
- Patch #1 moves the transition from STOP_COPY to STOP state to
  vfio_save_cleanup(). Testing with a ConnectX-7 VFIO device showed
  that this can reduce downtime by 6% with loaded devices.
- Patch #2 resets bytes_transferred counter properly.
- Patch #3 cleans up the VFIO migration realize flow and makes VFIO
  migration non-experimental.

Note that Zhenzhong's series [2] fixes additional bugs and further
cleans the VFIO migration realize flow.

Thanks.

[1]
https://lore.kernel.org/qemu-devel/20230621111201.29729-1-avihaih@nvidia.com/

[2]
https://lore.kernel.org/qemu-devel/20230621080204.420723-1-zhenzhong.duan@intel.com/

Avihai Horon (3):
  vfio/migration: Move from STOP_COPY to STOP in vfio_save_cleanup()
  vfio/migration: Reset bytes_transferred properly
  vfio/migration: Make VFIO migration non-experimental

 include/hw/vfio/vfio-common.h |  3 +-
 migration/migration.h         |  1 +
 hw/vfio/migration.c           | 54 ++++++++++++++++++++++-------------
 hw/vfio/pci.c                 |  4 +--
 migration/migration.c         |  1 +
 migration/savevm.c            |  1 +
 migration/target.c            | 17 +++++++++--
 7 files changed, 56 insertions(+), 25 deletions(-)

-- 
2.26.3


