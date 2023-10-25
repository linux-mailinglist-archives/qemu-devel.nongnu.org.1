Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B180A7D76A4
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 23:26:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvlMw-00072s-R2; Wed, 25 Oct 2023 17:24:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1qvlMu-00072a-6O
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 17:24:48 -0400
Received: from mail-dm3nam02on20631.outbound.protection.outlook.com
 ([2a01:111:f400:7e83::631]
 helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1qvlMr-0006TE-Gn
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 17:24:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BCoyKjpxFp2VPP4vE1OZBCdohHYgCBSR1yl88jcx40CmCHQ8tEGmrxwDhaoJXECZjNzmXgcwqbQQEs2GXDpKFvPexlTHehwVxzQLt5S1j/R9VAk6Bw0gqTAteA6ELSqkC2Y5Qo6xgVeuxTT25cT+Dm6vgiBuWjlgGRBK8DmsKkLklVH8basFAuCs1yRIQSq0NTDDbb3I1TeJiVR7WvvtllI8LJgzk786VWrbDVYirBEjHD4O3TDM98qAKcjmtz8MW5IR7Kx/1LJjdFXQNyiqFkOhVm164n9VTvAS9KccBQ9MmFw91FOsmj3xhnAImVUloKHw5ue76aA8+Kbc5PYIrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yPwf6e1PSaSK83DdkrGGeVN4Frej6Sqwkc5hi2vBkCY=;
 b=bnwxKL1MTVep6f075foJRn/UaKNWBxnrjzZGSc1Drc+h4JF1wSdmHRrsKQsHfFkt//ZPmFxTflLqbnsqbpQg3z1qqHyfuBEAE8dFLg8fNdkIXBoAvt1OnpMQ1jFhwOMPxl00NUlGEP54V/I/bk5fND7rp+TfFmFvhDCZjHb2qnyXPMQzPGGofAb4ZnPWhzy7EIcSnwcKDcbdDXHBiELEuww9DXLukqMvMSR5o2tUp39wnYLqLZUpvkzS7PFLXoZ6i8YVbk7no12pdZGCi5s4ZkJLeBVhT5oxnJaX2A3S9NbcgogtkTcqHPfHcRGOVFyL9iCk2eRgWBEcpxQaOY7ywQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPwf6e1PSaSK83DdkrGGeVN4Frej6Sqwkc5hi2vBkCY=;
 b=Yf5oK9jX6o3WccMFKNAulf1+xFyBO1qYQ9IJbG9p0OEructArt4HetcY1EMRlkw8ySqnNHjdyI3Mn8PQPvhHxXXCZvfcOw0iKv+CfmULqTtAUbKReUkDCXZyAampTa0aAovODhSfXQ2CXuDWS7ssQasLsBLEkjOTT8D7oQn4dAU=
Received: from DS7PR03CA0282.namprd03.prod.outlook.com (2603:10b6:5:3ad::17)
 by DM4PR12MB5197.namprd12.prod.outlook.com (2603:10b6:5:394::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 25 Oct
 2023 21:24:38 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:5:3ad:cafe::93) by DS7PR03CA0282.outlook.office365.com
 (2603:10b6:5:3ad::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.35 via Frontend
 Transport; Wed, 25 Oct 2023 21:24:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 21:24:37 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 25 Oct
 2023 16:24:31 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 25 Oct
 2023 16:24:29 -0500
Received: from xsjfnuv50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Wed, 25 Oct 2023 16:24:29 -0500
From: Vikram Garhwal <vikram.garhwal@amd.com>
To: <qemu-devel@nongnu.org>
CC: <sstabellini@kernel.org>, <vikram.garhwal@amd.com>, <jgross@suse.com>
Subject: [QEMU][PATCHv2 0/8] Xen: support grant mappings.
Date: Wed, 25 Oct 2023 14:24:13 -0700
Message-ID: <20231025212422.30371-1-vikram.garhwal@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|DM4PR12MB5197:EE_
X-MS-Office365-Filtering-Correlation-Id: 0986a5ac-71b4-49c6-f088-08dbd5a0caf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 139G455MX+hGhsjwO6ZQqgnYMvLogiaVCQ/jXfNxCAv7cyMKTIIuhQbIkaOscqX+iN/rlA9YL/mgoautHhmqrnxa3Ad0loNdYxOAofdZ/CAiwYNWgGxTCyjlVlvi2i7PmF5KSvkYQKSfipli5tXiqr2qQSfy3prn3tQRAQS7VgOpxbBSDlQF/Us3TDnTA26F7j7BzInE+i1hKVj/aJ7Fp8Jx/jYK70KD7WKb3vfLMLVMiWfN3fDmbAsp/XT9Zw1ueHAdiRlmY9hcmjbxr4RPwSijpm2woUK0UNClkzaX6llc3vJTx0n94DprxYVaqLHBWBAjKmaQ01euU+a41YF3CU0tpKZskd8Wf2CAFmFKes3VJFazfvi+ovUrRvAHXBEFo8OrO/DJxM35fcxqBovWtea9QlQO2THPD6FvzIezaV8TaPazQJ8A7bf671og1L7rGN9kCegHU4Q/haOg5eLKFlgBzuk6U6AQCvI+1DpbIj61yFM8jjH5W3vZU2VxLLp89tiU2S29HCxi7VpY2nEiUeCxh7050GTHBTBNZPlLskb17lOE0L2xj2f2q0l3rk0SskM2Hq4UjPWNKt3UoHu4/Fi7iPsW4XA4jxpsMDJPmlPcb3WMv6Fv6/1hJpddqkbux7Q1KLoDIV9s5ca4F8KdfwgyiTxJGMbY8TA8PspEiY01v/uS/yQe7gcJnaK5WY74wlDksSAzT4rYcyfIMpPmV1kao2dxUU38/r8i1SDDwCF5Bjxf6rkb/fgElKgn4iiBc4ZuYYJ1WM5tUZzK4wgKjQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(39860400002)(376002)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(82310400011)(40470700004)(46966006)(36840700001)(2906002)(83380400001)(44832011)(8676002)(4326008)(8936002)(81166007)(356005)(82740400003)(5660300002)(41300700001)(86362001)(6666004)(40480700001)(6916009)(316002)(478600001)(1076003)(336012)(426003)(26005)(2616005)(47076005)(36756003)(54906003)(70206006)(70586007)(40460700003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 21:24:37.7000 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0986a5ac-71b4-49c6-f088-08dbd5a0caf5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5197
Received-SPF: softfail client-ip=2a01:111:f400:7e83::631;
 envelope-from=vikram.garhwal@amd.com;
 helo=NAM02-DM3-obe.outbound.protection.outlook.com
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

Hi,
This patch series add support for grant mappings as a pseudo RAM region for Xen.

Enabling grant mappings patches(first 6) are written by Juergen in 2021.

QEMU Virtio device provides an emulated backends for Virtio frontned devices
in Xen.
Please set "iommu_platform=on" option when invoking QEMU. As this will set
VIRTIO_F_ACCESS_PLATFORM feature which will be used by virtio frontend in Xen
to know whether backend supports grants or not.

Changelog:
v1->v2:
    Split patch 2/7 to keep phymem.c changes in a separate.
    In patch "xen: add map and unmap callbacks for grant" add check for total
        allowed grant < XEN_MAX_VIRTIO_GRANTS.
    Fix formatting issues and re-based with master latest.

Regards,
Vikram
Juergen Gross (6):
  xen: when unplugging emulated devices skip virtio devices
  xen: add pseudo RAM region for grant mappings
  softmmu: let qemu_map_ram_ptr() use qemu_ram_ptr_length()
  xen: let xen_ram_addr_from_mapcache() return -1 in case of not found
    entry
  memory: add MemoryRegion map and unmap callbacks
  xen: add map and unmap callbacks for grant region

Vikram Garhwal (2):
  softmmu: physmem: Split ram_block_add()
  hw: arm: Add grant mapping.

 docs/system/i386/xen.rst        |   3 -
 hw/arm/xen_arm.c                |   3 +
 hw/i386/xen/xen-hvm.c           |   3 +
 hw/i386/xen/xen_platform.c      |  10 +-
 hw/xen/xen-hvm-common.c         |   4 +-
 hw/xen/xen-mapcache.c           | 214 ++++++++++++++++++++++++++++++--
 include/exec/memory.h           |  21 ++++
 include/exec/ram_addr.h         |   1 +
 include/hw/xen/xen-hvm-common.h |   2 +
 include/hw/xen/xen_pvdev.h      |   3 +
 include/sysemu/xen-mapcache.h   |   3 +
 system/physmem.c                | 181 ++++++++++++++++-----------
 12 files changed, 358 insertions(+), 90 deletions(-)

-- 
2.17.1


