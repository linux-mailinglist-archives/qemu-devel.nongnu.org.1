Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B6F716F6F
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 23:13:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q46dd-00048E-14; Tue, 30 May 2023 17:12:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1q46db-000485-95
 for qemu-devel@nongnu.org; Tue, 30 May 2023 17:12:15 -0400
Received: from mail-dm6nam10on2087.outbound.protection.outlook.com
 ([40.107.93.87] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1q46dZ-0003yF-4W
 for qemu-devel@nongnu.org; Tue, 30 May 2023 17:12:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nWSP2gKRaWkllh7CVTGbi/8oe34R+KXmDLzUBedGwkEaACK71gk+nqyOZZhJSxXOMe8aLS6pMaXrZPt+npdO0VZZQMmpZBNF+Xw6Hbr2OOszINg4x9o/DKpfrXvBwnCpYCJyjJGF6yVFY6zKIH3EbRxKqlzogRuxcRpdDbmN8OhHOhcRqWFK9nfp9MwGKCY7iA1HbDrEXrjY+wcrB3McTKcjMsuv6n9/wGLS0bLSyHcz+LEYcK3OOSuQ22o/X7BysvxGxfBvle6JKNqP+CJSnyOGnKf7ixEc0w6aGeyEJbo51AOaVdTg4dax5Ztm7fzKg96f4cCaipBGGxPOCWPmaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ndo2fxasgTWmtfRzqs2PM+Bya2DVemogZd3iVcw/yOk=;
 b=ZcxusBUzu/wyFardSKNgHYC+c45D+/EuwKlmg2f9DVrBnKYAXIAKljYcbN9/QZUpWjyCHRy5WQ8YQpRsKjSzILT0ZbvANC5du37Ml0dzj5pgOEv5DC0eCT2aC19HPeiteqW405K3xFeYN63rywJycKdHUE51snWELpO6FrIlc6Ajx0Tf7+UhjR9+iVpvE0zBgwVPqZNMxg5wBuoLedD81/pgKkgBE2oId7hJv5b82pTJVG2YEUtyZ3DeC16bY3A8rpFRFuytRDJnVX39OzgL7FguIIQY4Pu38rTi2Gk279AJxcrlg01AqVe0aKaRMeJgwGT4DDAamDAluH0ZhSGVEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ndo2fxasgTWmtfRzqs2PM+Bya2DVemogZd3iVcw/yOk=;
 b=kOEoDdDY8ZcrVq79EZ6PiW2/NHxIgSzoO/ZQULXS+4Sg715fJLLlZp8Ind41NFnrOt5RkVg1tWMBF0dMWsiEBA2HkU4ILKcVooldPlIsIe/T882TmxAa8VQrLmVUW/e067OPogfswz2K6h3rZDXOc9yLYIYfv8tFwI/oaBNqpZU=
Received: from BN9PR03CA0701.namprd03.prod.outlook.com (2603:10b6:408:ef::16)
 by PH0PR12MB5449.namprd12.prod.outlook.com (2603:10b6:510:e7::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 21:07:08 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ef:cafe::fa) by BN9PR03CA0701.outlook.office365.com
 (2603:10b6:408:ef::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23 via Frontend
 Transport; Tue, 30 May 2023 21:07:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.22 via Frontend Transport; Tue, 30 May 2023 21:07:08 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 30 May
 2023 16:07:07 -0500
Received: from xsjfnuv50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 30 May 2023 16:07:07 -0500
From: Vikram Garhwal <vikram.garhwal@amd.com>
To: <qemu-devel@nongnu.org>
CC: <frasse.iglesias@gmail.com>, Vikram Garhwal <vikram.garhwal@amd.com>
Subject: [QEMU][PATCH v6 0/4] Introduce Xilinx Versal CANFD
Date: Tue, 30 May 2023 14:06:58 -0700
Message-ID: <20230530210703.6707-1-vikram.garhwal@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT068:EE_|PH0PR12MB5449:EE_
X-MS-Office365-Filtering-Correlation-Id: acd90bbc-aee8-417d-fafd-08db6151d415
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RWdXasntEWCjlF//dN6p9bQWyQpGfn0fzlkF1JWcHf+EHtqbfGOSD6EQJlnYGnRyMCAZmrh/yGgA4R72nkwwckj3PuWFpUa5qDruieLy0mNKwsu6QV0mdmFyeSBdBZ1C//Tlq2jZd1s1VsBryXgp/MOMBMHzLOU7gYkDBqPiCHGPNK/Y1bfJzFTrgxfOGHf4VTxAXF+zund3i28wZ+s7M8hC4f2Bd9wfZx2qSZT8N2qPC3y95FiembsLBVLvvVn7Jmy5a43NKWN+qes1VYpO8wqVSoMBmAFU2aczQ1IpSyrmm188v0o3EWIvjLwrLmdXTqkktxHeEY9tQqEiaOpoBsiBgw5LemJa3+K7mV2MOD5Rz91+HmK5gSDWOVn9eo/19gjvp0k+HH3KbSoFs7BILZdYpzaM8nJdp5d2U8k0pUc7Ch2ItDYl0DBeSrbrL0NF5WifmzyI3ss4dF7fzLLaBleWl8O8U0c2v5Cu0m7/h+YdB1sezmfZoz3UqrcML3zQuUvO6GwkoEkX/6dqFlRQRMwRCgsaOp/V+9VnG64iU6U3BoxpcqxiRrKz+VVC87mWdMWQN5tEgw0m70mHiRlOfPzV9o/J1stFy0B0X3pv3I+ibUwyZMd4ZnzCNXDf6m6ENXPiF6751j8NGQKDfK4kFDktoYmlcAfcoUExEroKV/oE3t9lPAfPOCRBY2K6h4cpfIynQSjMMBSUDIXjgx7llcs8ldnw7xm03hgX/2oFeBOmUdBK9Cli6MrnzUFe7W8XRX6gOXf/r6WGv0iZMlkXUQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199021)(40470700004)(46966006)(36840700001)(2906002)(186003)(1076003)(36860700001)(5660300002)(54906003)(8676002)(8936002)(478600001)(2616005)(356005)(82740400003)(81166007)(47076005)(26005)(426003)(336012)(83380400001)(86362001)(82310400005)(41300700001)(316002)(6666004)(4326008)(70586007)(70206006)(44832011)(36756003)(6916009)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 21:07:08.1043 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acd90bbc-aee8-417d-fafd-08db6151d415
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5449
Received-SPF: softfail client-ip=40.107.93.87;
 envelope-from=vikram.garhwal@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
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
v5->v6:
    Add formatting related comments from Francisco.
    Add "review-by" for all remaining patches.
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


