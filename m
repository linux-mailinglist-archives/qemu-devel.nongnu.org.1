Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A21D7BA8FA
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 20:22:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoSzG-0007uC-OS; Thu, 05 Oct 2023 14:22:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1qoSzE-0007sj-F5
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 14:22:12 -0400
Received: from mail-bn8nam12on2073.outbound.protection.outlook.com
 ([40.107.237.73] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1qoSzA-0007kc-F5
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 14:22:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IRzSU4l1BFcyFhQs2Wltr2GSsBFFDWUGg0GJi+evgVhj1oBrIk9Ern1k7dP1Mzvn9gF2RSHuJ/EJ8baNN8kRIH3ioQg3Ai90gJ1/kjdBLirvDA58UITQ6ooTX5RnIUYrACjJC91vFSv0ZiDJyLoGmOLy+JPsLwgiXm5GeGwUQQ+njjCcW67VMd1BvCmQaACVwBnVPmTIDtOBavoSXAwji5H+QcgFl9ROPnVM6jeInohAVuKEA73hMbSApzBcUifYUFhnWTHob6+MVmMt2jIvaUdYtl+ThnxZ4UlfZwXcvJvEiMXuIzYbLTBmmNoHMwOdTJymOuwTvSq1qqGQjJmzzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gzG8/xPrDQXVCqBOsY4uZEiPo7KrL44AluxOdY2Qw48=;
 b=jpIvqRBpu9jUwMM97IgwslLTJC3ED61fnb0y30Ox6A+cW+Sjp27hTBHBJOJ7d7gj2XNM/BD7H1P2Sjf1B6L1QUaRmQNci0NOiq8IHngCgOUxESQ8FhDQ8y7A21SCArJdEUfEiBpLHSur71BIp1mAr967KM2smgfpkfIQ6Wk06QX3FsRUt5Q38AAWfJktcosfRQ4e7ynmgyH0AayXSPSHdkWMKU+TwmLYglccvlfTmljar6g8N1jno7btGUNKTnYTxArLmg2I6Q59PuDAW4Z3GUnchMejnVDUsJ1GOjITj11tY52+jarZjPkztEzJS1ApMEvdLPXZHuXNx1AlMVzosw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzG8/xPrDQXVCqBOsY4uZEiPo7KrL44AluxOdY2Qw48=;
 b=EudNfZbPVCihe83Spd6pjvDFdajIIwDaIDSjFYMwdu/PI0vdWgdMJvA88KmSa29EvDFDSEc51fXPAJ9hhXOhNOJoyClicjODlGLw/iw7202s3rQbQaanydughE8+2s2GR0m2lSY8GBseyUdVEPg0G3xck5Iw93zT/h3p5kEHrn4=
Received: from BL1PR13CA0262.namprd13.prod.outlook.com (2603:10b6:208:2ba::27)
 by BL3PR12MB6451.namprd12.prod.outlook.com (2603:10b6:208:3ba::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22; Thu, 5 Oct
 2023 18:17:01 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:208:2ba:cafe::24) by BL1PR13CA0262.outlook.office365.com
 (2603:10b6:208:2ba::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.11 via Frontend
 Transport; Thu, 5 Oct 2023 18:17:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Thu, 5 Oct 2023 18:17:01 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 5 Oct
 2023 13:16:50 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 5 Oct
 2023 13:16:50 -0500
Received: from xsjfnuv50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 5 Oct 2023 13:16:49 -0500
From: Vikram Garhwal <vikram.garhwal@amd.com>
To: <qemu-devel@nongnu.org>
CC: <sstabellini@kernel.org>, Vikram Garhwal <vikram.garhwal@amd.com>
Subject: [QEMU][PATCH v1 0/7] Xen: support grant mappings.
Date: Thu, 5 Oct 2023 11:16:22 -0700
Message-ID: <20231005181629.4046-1-vikram.garhwal@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|BL3PR12MB6451:EE_
X-MS-Office365-Filtering-Correlation-Id: fb4bfe46-2fd4-4b05-6809-08dbc5cf451c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ie2vez262LjNY9qslUS4JSSxA93U5RAdN7VrLEgyMT9mz7w/ZbhYLAquVdaXQpRJh5BQ9fWTQqKf3ceeXcfB+YkMHqoNb3S2t5dhx3vXrYcoq8j0edOu4NCxLXj1kTfKigtKyU4SMkGiWYErskXnJ9eCliD/JXPQWwMicj4yrDtvNBdmcrxOxL93oJFHEbyJO0KFLobotZ7IA3yaon752y7G09xH7fzTFL+hNksUWNOQN2jash6wLl547mVL0+9FqNiP5v9TJhj+/n7QA9xWW1THX5AWi31qzK349JKSivx0M7uq5DnyOKNNgxKk/Fbq1igVGCNhoGQpcLUmBKhOEdxl0WdUu6/LFfLb0txOMZv619LhHeHnWuLB4zFR+tf2P2ayxMusueLEhh7zZpMPdKixCGsgFpPpYrvzAqfONY4cx6YAHW61VzgZ0joPJdoUc3oRbJ3x7ioIwSqovl4IDtlbiz2LIJE5QUAcpFzz+uNqBcUErlCY88KFqsdzZH+tJTm0nUMar7QzyzxI72pEiQpVZNhz/XVl5Ukf+IrneHwjzTWGygWQVwgP+o1v7i8a6pxhkEjoM99lWPqJMX88MOxMYlsIK1ftqcDOyFFkhlyE1kU2zcDd4owK8VS8ERTW2e5vMASTtg46KWNSJfehoRBULE9FjTQp7K+JnqxqankwKrTjmDQ9X2ulSJ3vA1jM4GnIZSkkSq0MZvNucO/LbsuawyyqY4zbO37Xr11HdTgRYiekaHfUkbMA9D7O0F8tOV5Yqrl23brlz0MM2QNcow==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(82310400011)(36840700001)(40470700004)(46966006)(54906003)(70206006)(1076003)(2616005)(316002)(6916009)(41300700001)(44832011)(86362001)(6666004)(5660300002)(2906002)(478600001)(70586007)(26005)(47076005)(83380400001)(426003)(4326008)(8676002)(36860700001)(8936002)(336012)(40460700003)(82740400003)(356005)(81166007)(40480700001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 18:17:01.0980 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb4bfe46-2fd4-4b05-6809-08dbc5cf451c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6451
Received-SPF: softfail client-ip=40.107.237.73;
 envelope-from=vikram.garhwal@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.493, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Vikram Garhwal (1):
  hw: arm: Add grant mapping.

 hw/arm/xen_arm.c                |   3 +
 hw/i386/xen/xen-hvm.c           |   3 +
 hw/i386/xen/xen_platform.c      |   8 +-
 hw/xen/xen-hvm-common.c         |   4 +-
 hw/xen/xen-mapcache.c           | 206 ++++++++++++++++++++++++++++++--
 include/exec/memory.h           |  21 ++++
 include/exec/ram_addr.h         |   1 +
 include/hw/xen/xen-hvm-common.h |   2 +
 include/hw/xen/xen_pvdev.h      |   3 +
 include/sysemu/xen-mapcache.h   |   3 +
 softmmu/physmem.c               | 181 +++++++++++++++++-----------
 11 files changed, 349 insertions(+), 86 deletions(-)

-- 
2.17.1


