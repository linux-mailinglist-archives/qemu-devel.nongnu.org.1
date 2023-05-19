Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F88470A0FC
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 22:41:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q06ud-0002dv-Mz; Fri, 19 May 2023 16:41:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1q06ub-0002dj-N3
 for qemu-devel@nongnu.org; Fri, 19 May 2023 16:41:17 -0400
Received: from mail-bn8nam04on2058.outbound.protection.outlook.com
 ([40.107.100.58] helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1q06uZ-0000uL-Ok
 for qemu-devel@nongnu.org; Fri, 19 May 2023 16:41:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k4F1geCCPm6S2AgqLl+Wmhk95CeYSMwzkOJ82uKm9XM8dVwKUjPacdiriGVrF6BCqlunnQEFCW5cledZum1ocVNvBuIz/4+WxrbI/Nbzkyv5Jj5UjyvQM3oqqjV+Y7Gzk/8gKar/dtlZC4pel/K3KxNVuKeWFV8/af8rCsz6PRR26JZDHQaXbC6c5TAoxSDFVCiJ0FmaLi9//bw1rB0nM70ni2Tu0ynXd2Ktj5CYMnCTth59JPbHl2eEt9KhDuJ+9fwxRMZ4PU/PwgaXBohqu7JQoPBNv6W8hRKtrpZ1CPONvUXJN4QHa6Y8qay6Ek4fGXK+RnpFJWCEfHDgD884jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2RvNkXvrPVH2SEn6VZOpBpj/DI8puHOUGOb4c4nbYoM=;
 b=mHCVae8wndKPlJhzVyy7gvgegR5EFU1C2hZESzyzW2+Jvx2fp5vfkPBfxfc6wkxkFUEfbqVLsYeBVnTOrn/kySks99xh4kjyJ1b1CdlQgFaq4feSy9hFLSGeS9uQwgi0VhDlueh9GgWNJCDVc96WvRcr/Ic3RHMjkhBVNmX4wGgQgVjFifwdeUsfka+cjCc6HpD39w+9InZ15B2s+ynWSZK/3wae9clEnUukZd3/nLhVLFg7dicApU6TuvtfdNJkOYNfT4y5ok5UlkBmD6Ehbcpn8zlF66sF5RSQUyToLET+JCc7TyzZ4FQtn5aQ40BpbrqDLp0NkpftRkOCImf2vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2RvNkXvrPVH2SEn6VZOpBpj/DI8puHOUGOb4c4nbYoM=;
 b=DWWnQYRUW+lFeS+fA6fe+i2rSj7AxvcdZ8YsurIhgINa7HYTaVeFIEyguB5LmaaBABN9kvkDVl2Fw8f79YeGBMRyKdgOdAPGvco22qvjzBvmkpC1ZqEJnKIf3SuJCtWAbdzy66JLjf0V7kW2M9M3QZyZaQEmw0V7m5Bb53Y554o=
Received: from BYAPR06CA0059.namprd06.prod.outlook.com (2603:10b6:a03:14b::36)
 by SA1PR12MB6971.namprd12.prod.outlook.com (2603:10b6:806:24e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.28; Fri, 19 May
 2023 20:36:10 +0000
Received: from DM6NAM11FT103.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:14b:cafe::e3) by BYAPR06CA0059.outlook.office365.com
 (2603:10b6:a03:14b::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21 via Frontend
 Transport; Fri, 19 May 2023 20:36:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT103.mail.protection.outlook.com (10.13.172.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.21 via Frontend Transport; Fri, 19 May 2023 20:36:10 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 19 May
 2023 15:35:20 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 19 May
 2023 13:35:19 -0700
Received: from xsjfnuv50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 19 May 2023 15:35:19 -0500
From: Vikram Garhwal <vikram.garhwal@amd.com>
To: <qemu-devel@nongnu.org>
CC: <frasse.iglesias@gmail.com>, Vikram Garhwal <vikram.garhwal@amd.com>
Subject: [QEMU][PATCH v5 0/4] Introduce Xilinx Versal CANFD
Date: Fri, 19 May 2023 13:35:02 -0700
Message-ID: <20230519203506.21002-1-vikram.garhwal@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT103:EE_|SA1PR12MB6971:EE_
X-MS-Office365-Filtering-Correlation-Id: 27ea6271-53b1-4473-a95a-08db58a8ae38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wsYAziD+d9sIb1DYzPxJcUeaepIQwawGhvyO3QelRYF3aBFw/dL8KDMtOmJVJDDdttthAQ8bXJGITfwZ0zWim/nGZD1lr6Wgo3tLLG9Ksq02hWWe7Ug8dW73lJZvvgaAGsfKj5qNsQTGJTmzznazDDZaQLV/i8pKx5Bx77t9SKcyBTKhasgCfhOz+kPsAqrLH7WIMoCi/JBshO9GIUAOihOQofJTCbAeYrbEMSlS2CR1iDcW2bFXtAhdOBNbR1VkLjqZO5tM2eINOlI9fK3nyrmUjxkaPykL+U13n/BfYQGegAFFWaryqWebDqNT21x43LHahAm04Ax0JcBiM0etKVJIYDcbu/mCx5JqsG5OW1y0CbCWepNplITZTrsYBy4/v8+Q7nggYgu3Q7WvHVcCSptRAHzKzpHCGVK0NxzRo7C4u0wHtIBRHj42EooE2w0Icbm1liLkdb0q2CJjuBav98bs1mlGeNS7jZ4WLbydD+y+T4UX2zaj7YyRk4fC4ljbystxjV4uPu6vuuwX+5Dt3F4FRxEW+FLe0j7GIpJNllR23bczSki61Wa3XSW9rPdI0DK78TCBYhpvUBRiqD+bJCkohvkhLcuL5+BaYP+WQoZ0kNMvia9OejhtFa9lueqI8xxB960x6cQhK8b8G8+hhXot/KdPBY/XLygKL+QSVqLpOncELLc0sqNhUQS9XOvHAgP2uCK7oJqpfEl2UFYaAuwguZbVcuTse65HfQihjwXLHBFfjeBmRF/ytduAkswtUlFE+8zDRp/IsUogbKYckA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199021)(40470700004)(46966006)(36840700001)(82310400005)(86362001)(36756003)(2906002)(40460700003)(40480700001)(36860700001)(83380400001)(426003)(336012)(47076005)(6666004)(26005)(1076003)(6916009)(356005)(4326008)(186003)(70586007)(82740400003)(54906003)(44832011)(316002)(41300700001)(2616005)(70206006)(478600001)(8676002)(81166007)(8936002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 20:36:10.2974 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27ea6271-53b1-4473-a95a-08db58a8ae38
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT103.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6971
Received-SPF: softfail client-ip=40.107.100.58;
 envelope-from=vikram.garhwal@amd.com;
 helo=NAM04-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi,
This patch implements CANFD controller for xlnx-versal-virt machine. There are
two controllers CANFD0@0xFF06_0000 and CANFD1@0xFF07_0000 are connected to the
machine.

Also, added basic qtests for data exchange between both the controllers in
various supported configs.

Changelog:
v4->v5:
    Fix Linux dtb connections for CANFD.
    Address feedback from Francisco for xlnx-versal-canfd.c file.
v3->v4:
    Address formatting related feedback from Peter.
    Correct dlc byte data storing if dlc is not a multiple of 4.
    Remove unnecessary LOG_GUEST_ERROR.
    Remove instance_finalize(canfd_finalize) function.
    Remove unused member of struct XlnxVersalCANFDState.

v2->v3:
    Corrected reg2frame().
    Added assert to prevent out of bound cases.
    Replace tx_id link list with GSList and removed sorting function.
    Replaced PTIMER_POLICY_LEGACY with proper timer policies.
    Corrected minor code format issues.

v1->v2
    Update xlnx-versal-virt.rst with CANFD examples and add this in 03/05 patch.
    Addressed comments for patch 02/05 and 03/05.
    Add reviewed-by tags for patch 01/05, 04/05 and 05/05.
    Change commit message for patch 02/05.
    Add SPDX license for Qtest.

Regards,
Vikram


Vikram Garhwal (4):
  MAINTAINERS: Include canfd tests under Xilinx CAN
  hw/net/can: Introduce Xilinx Versal CANFD controller
  xlnx-versal: Connect Xilinx VERSAL CANFD controllers
  tests/qtest: Introduce tests for Xilinx VERSAL CANFD controller

 MAINTAINERS                          |    2 +-
 docs/system/arm/xlnx-versal-virt.rst |   31 +
 hw/arm/xlnx-versal-virt.c            |   53 +
 hw/arm/xlnx-versal.c                 |   37 +
 hw/net/can/meson.build               |    1 +
 hw/net/can/trace-events              |    7 +
 hw/net/can/xlnx-versal-canfd.c       | 2107 ++++++++++++++++++++++++++
 include/hw/arm/xlnx-versal.h         |   12 +
 include/hw/net/xlnx-versal-canfd.h   |   87 ++
 tests/qtest/meson.build              |    1 +
 tests/qtest/xlnx-canfd-test.c        |  423 ++++++
 11 files changed, 2760 insertions(+), 1 deletion(-)
 create mode 100644 hw/net/can/xlnx-versal-canfd.c
 create mode 100644 include/hw/net/xlnx-versal-canfd.h
 create mode 100644 tests/qtest/xlnx-canfd-test.c

-- 
2.17.1


