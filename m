Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FFE78D2D1
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 06:41:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbD0V-0007B3-BT; Wed, 30 Aug 2023 00:40:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1qbD0P-0007Aq-M2
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 00:40:39 -0400
Received: from mail-dm6nam10on2054.outbound.protection.outlook.com
 ([40.107.93.54] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1qbD0N-00015c-8k
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 00:40:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fAQLYm/S/4A65jSA6NwMZZ/xCQ37ekql5VCA9nOWRi1Jd2nRG9TaV19XmtlDQ9B0Y5U3zKAm0V/nw23e865OZGi2TgfKrfoARWFiif24+tR8jOjUz6JIWZQspBv2XODagnncg1Ua23oNeLye0FNzxYcSBy/+U/2nHFuqMlEW+L2zVIAm/4aMa1t1ZOu6F/0L96KXyjpwvv2MSz5beHA9UwjjPQbtSSbbsDWuEhuDSe5tPcsujjE+Ad00HhGwzXzbNePp6KNvvEYfXmV4eLGiMJCr4XVIhSs0KSMV0W5DjVjx0ndPTki+pZ7M1VH9luwgJanJ3wxY6A1RMDDBOlbmNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hr6nX117ceUap7XlQVB/Foz/HfaJ4QvMHTBCT8uUAyY=;
 b=HbK8j+hpzC3VdwqfF/y7OVrafNBNOFQIZ/eiDz4h+p0b2e6i988WvBbAlThCznS5A/c2XSXcbiCOhz5Y497X4A5qX22ljn2nPS4fzK2YwZhDp598gXXqZ42xMVzHuqkhwT7IWWJIehje2KpB5/3Yi9y3kwwu1Mx8DE8DR8HuuVewAB6Z89kJbI0Ik9kHtkv1T4hUESaG9YB3TrChDKqKyCZsOQXBetT7/edADDLpLXm/gGru3f7EoElecQUVF9gemnhAyFZd8vjlj5OO+ux0mQkOFBJmQd6IXidOrzwh1QZQM3U8d8yJEaXAX1VxSYGk4bXnRpAmA6qB0A/fY5rBkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hr6nX117ceUap7XlQVB/Foz/HfaJ4QvMHTBCT8uUAyY=;
 b=zQK3gcaISHdJbKJJdLgoxmFPRUC2dUpWB0LF3+Hcfs75cW7NNSphLrA+qonjQtN2Eb7AykSweXVCfYNRoEEzIERA7z2bFOXAarX8h0a7oKRztj6roHE4I9Qbo99VsT1xj+0BJGC+dAh5aLOYgyPMJK/fNOwl1oPAmTgi49GwFUg=
Received: from MW4PR03CA0293.namprd03.prod.outlook.com (2603:10b6:303:b5::28)
 by CH3PR12MB8710.namprd12.prod.outlook.com (2603:10b6:610:173::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Wed, 30 Aug
 2023 04:35:29 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:303:b5:cafe::9a) by MW4PR03CA0293.outlook.office365.com
 (2603:10b6:303:b5::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.36 via Frontend
 Transport; Wed, 30 Aug 2023 04:35:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Wed, 30 Aug 2023 04:35:28 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 29 Aug
 2023 23:35:27 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 29 Aug
 2023 21:35:27 -0700
Received: from xsjfnuv50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 29 Aug 2023 23:35:27 -0500
From: Vikram Garhwal <vikram.garhwal@amd.com>
To: <qemu-devel@nongnu.org>
CC: <sstabellini@kernel.org>, <vikram.garhwal@amd.com>
Subject: [QEMU][PATCH v4 0/2] Add Virtio support to Xenpvh machine for arm
Date: Tue, 29 Aug 2023 21:35:16 -0700
Message-ID: <20230830043518.21584-1-vikram.garhwal@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|CH3PR12MB8710:EE_
X-MS-Office365-Filtering-Correlation-Id: 6602da0f-c87b-4be6-7270-08dba912896c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wa4+sxFafas2Q9pyZ7pu5ae0NH4VXc7y1NR9rvwCwQztlAPH5Wm1E0h++iMw2oYdjR5seLgmkHZTrZJLRogsk1lgP+fvbhmQzwBMY8DjPdA0We2E1oZrPAYn4Rxk2n2hLMkosIYQYXx7Q8vO9Lxu1S2yY8mrxaMSAF15TsqqEU+8u4Ir2TkTjbvPlYn6QueTcABu6h+4PPitpRo7UVRU0jAVIPotmzWjwe2hIUCVvEJcTg5L3OdBqOo/Qb4r8xCUHWUjS7VKm4DlE0Dr9enhRdN8jGxQqL7IX9qKh21fTp/LJV+odEGlyuaPJNIeE0VRxz9gfozlEnPUjhDttYLRgtsQSd1+ZKkM8voTlyZpOlKLsamz9HUVvUJk18LGBP2f48X47KdSJlOzRo8rz158BYtw6qIhI91AIiBsmG1uRTOGxlAoaS9Am0PBfbUL8j0K9P9Xpi14eLfvAzcrdfjSbTxFBHCh3+0SIZgbquUkhgUes2/d5QBsv2QLGkzY0iu8byIDEceHjTbM9iR0D1O6I2wsALFi/dSFc18PWkjbLB0ELOYkt1n8z+gYWfT/BJrSR4ATILo3DcW4UpXTaEGTnkX4IfMDhv1SlLvZhUJTxILq5JpzyNXY3xIwcoZ3L+mKO5R7afstJwkWheFRlpOwHB+D8Aja9rU18IlwEXus9kewSOj28IhrBtAt3LZE1TUsnly4oviKqTURUI2IId5xxCCIOjY0jv4uawd8JxRh+TypLcJkRi1yfnyeC9qcscGasv2+E5RW4A8KdPslXekujQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(39860400002)(396003)(346002)(1800799009)(451199024)(186009)(82310400011)(40470700004)(46966006)(36840700001)(5660300002)(316002)(6916009)(36860700001)(54906003)(41300700001)(70206006)(70586007)(83380400001)(356005)(478600001)(2906002)(4744005)(8676002)(4326008)(8936002)(44832011)(81166007)(47076005)(82740400003)(86362001)(6666004)(40480700001)(426003)(2616005)(336012)(36756003)(26005)(1076003)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 04:35:28.1742 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6602da0f-c87b-4be6-7270-08dba912896c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8710
Received-SPF: softfail client-ip=40.107.93.54;
 envelope-from=vikram.garhwal@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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
We added virtio-mmio support in xenpvh machine. Now, it can support upto
10 virtio mmio.

Changelog:
    v3->v4:
        Moved the defs to xen_native.h

    v2->v3:
        Define GUEST_VIRTIO_*, GUEST_RAM* and xendevicemodel_set_irq() manually
        for old xen version. This was done to avoid build failures in gitlab-ci
    v1->v2:
        Add reference for VIRTIO_MMIO_DEV_SIZE.
        Update ram_size=0 print statement.

Oleksandr Tyshchenko (2):
  xen_arm: Create virtio-mmio devices during initialization
  xen_arm: Initialize RAM and add hi/low memory regions

 hw/arm/xen_arm.c            | 80 +++++++++++++++++++++++++++++++++++++
 include/hw/xen/xen_native.h | 24 +++++++++++
 2 files changed, 104 insertions(+)

-- 
2.17.1


