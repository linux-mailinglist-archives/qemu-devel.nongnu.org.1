Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C33907D76AA
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 23:26:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvlNV-000766-8C; Wed, 25 Oct 2023 17:25:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1qvlMx-00073w-HW; Wed, 25 Oct 2023 17:24:55 -0400
Received: from mail-dm3nam02on20628.outbound.protection.outlook.com
 ([2a01:111:f400:7e83::628]
 helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1qvlMu-0006Ti-9V; Wed, 25 Oct 2023 17:24:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fX0OzAFIpG0LQO6E7c4KIS16lzEJpGECwMWUl6WL86A5d3pcvK7plGZfUQKzoW8E//zurgASvwIlqn+fhnNyl9CP3WvDRyKh5sQ/5db1ZQ2SCEnQIskw4UldVKMvM7A2sLMYIjq9vwTXraLfbbDpBsBjULwJiVd0n53szjKD2PP4G7tZxanpvMNriAzf+5VsiZCLBtMHQkc0P8Kdz+Ib1dGImy4h8/0gKz6EW+J4FrIjTgip7JBxnHhOVOWOzcZo9W4AvUDj85iHrHHkMxLws3S6KN5h7yyotOwaa9jPlC0VvdDPOaTiTlIsIiSEc94NB1ujvImanXgw+u/N7+TGog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0vRH12HvDrrWbRTurt84ajWGVWm4j5M7aGxWb5eoY0=;
 b=fqOn+QDqpvNZvbevVs4CcwyqNqMWBsPxv+5A2c30w1uIZt6hh74dhYHgYRcKXaf3OqRslxJ2ipR7uoAPAqcqaDGUaErKBQaUBj3ZiNAGe6mMbQLaFkUG9PKHH4gZ9eX2RtySn/MLEn1VwrhMUqunzzN/5QbWfTQLeLCOyK2XUXascL69CQVFjFvT3YCNreL3wF+Kxy4F3er7xrPmY1rmx54jlVerF7UqCbgVzq+YNV1gQSKiCcLdBBeulvh4Y78xuWRDsCVa5W6EICFN/aATNJC0QF6ceJAmF08ZdW7cPZdM7fwlhq1aEv8B2+i/llSvtjuHwjb6UIgkpnD/4R3oYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0vRH12HvDrrWbRTurt84ajWGVWm4j5M7aGxWb5eoY0=;
 b=JucI7+ODdh4amrklPfyIMOiR2G9B/eTBD2o595ymQudLanOy4bhsovNmRlAndD2wuHW1G5nXbW9yjA24AOEmcIyznMjA2zIBxHp3qveXaVCGIigC97bLmMqD16hHtidJ2LpZMtRzrjn3hrQjgEdth1qIZAyvx9vCDua4LWT1g+I=
Received: from SN6PR04CA0093.namprd04.prod.outlook.com (2603:10b6:805:f2::34)
 by CH3PR12MB7593.namprd12.prod.outlook.com (2603:10b6:610:141::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 21:24:44 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:805:f2:cafe::3) by SN6PR04CA0093.outlook.office365.com
 (2603:10b6:805:f2::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19 via Frontend
 Transport; Wed, 25 Oct 2023 21:24:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 21:24:43 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 25 Oct
 2023 16:24:40 -0500
Received: from xsjfnuv50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Wed, 25 Oct 2023 16:24:40 -0500
From: Vikram Garhwal <vikram.garhwal@amd.com>
To: <qemu-devel@nongnu.org>
CC: <sstabellini@kernel.org>, <vikram.garhwal@amd.com>, <jgross@suse.com>,
 Peter Maydell <peter.maydell@linaro.org>, "open list:ARM TCG CPUs"
 <qemu-arm@nongnu.org>
Subject: [QEMU][PATCHv2 8/8] hw: arm: Add grant mapping.
Date: Wed, 25 Oct 2023 14:24:21 -0700
Message-ID: <20231025212422.30371-9-vikram.garhwal@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231025212422.30371-1-vikram.garhwal@amd.com>
References: <20231025212422.30371-1-vikram.garhwal@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|CH3PR12MB7593:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a47e5bb-babc-4206-b625-08dbd5a0cea5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RZSRtCUwTGmXG/i5t1WRCeQnbNIZizMwaVFaGXD2Gdi8NtE3ugLOo6e+hdiAffJsMZvvO2ezdC7uF6lvUIeJDatt64sOWCaCCjrihkEjxb+4iTOKFX0VJprRQpIBz73Y86lJnSns4mG/GjlbNwc10kSo0mGGCAl1DRCttnEo1621ZBL0yK9q5e9rVJT/9o66lJOn7znU0QNWbSjplGOyfU0xdwOlEwi6ZBAkO9JqrPdRzpPxZTmPdmjLZqALP3vaEwrH7v6hxserYuihHKp/h36HexsPLEu8TwvU8yXswc+q/kYaajHRpb708xNbo7YKDjMCHxXsHS4Z+0AaevBKaDGyucOLhwDiqydBhyNu1cf0yYADw5kbiALzPOJ9GwJnXKjN1xes9jNCKbG4UFdKefuaRIlQ+wseUTS55qJ+zp78gaOLC3iO/AJrm5J3FUFh+bIImFvqjwm/uF82EaAqzBzrrz8iTE1IZSAB1QANtQpf76IUvlfYcCzAPbK+/5xTf/AIjfPFAgQJsWGzIpqhvTNQINDJr+d53iEhWgXfjmFN9JE+OZwSGgNg56Gu7sYwrGcxOZULn5DnpwyQNP6eEk+S/M9gwBsq9WCtC2YIgcsW3vBXn/4BPjhqfEO9O0Bec55BYb7US0iIFRoQ3H8dJTLEkKTKkZHd5qOLUNNJ/KzXiEDjeVIBEdw9VuIDBAvWpTo8QpRlueGhJb6QSsWDOYH0B4CD2c/En0F/+rC0skRPv6Kb4rmtHhZk+W/RGI8/P6CCtBMSbKdE5/QoIOhrRw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(376002)(346002)(39860400002)(230922051799003)(186009)(451199024)(82310400011)(64100799003)(1800799009)(46966006)(36840700001)(40470700004)(26005)(36860700001)(82740400003)(2906002)(4744005)(41300700001)(40460700003)(44832011)(5660300002)(86362001)(36756003)(8936002)(8676002)(4326008)(6916009)(54906003)(81166007)(478600001)(1076003)(316002)(70586007)(356005)(70206006)(40480700001)(47076005)(2616005)(426003)(336012)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 21:24:43.9632 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a47e5bb-babc-4206-b625-08dbd5a0cea5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7593
Received-SPF: softfail client-ip=2a01:111:f400:7e83::628;
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

Enable grant ram mapping support for Xenpvh machine on ARM.

Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
 hw/arm/xen_arm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/arm/xen_arm.c b/hw/arm/xen_arm.c
index f83b983ec5..553c289720 100644
--- a/hw/arm/xen_arm.c
+++ b/hw/arm/xen_arm.c
@@ -125,6 +125,9 @@ static void xen_init_ram(MachineState *machine)
         DPRINTF("Initialized region xen.ram.hi: base 0x%llx size 0x%lx\n",
                 GUEST_RAM1_BASE, ram_size[1]);
     }
+
+    DPRINTF("init grant ram mapping for XEN\n");
+    ram_grants = *xen_init_grant_ram();
 }
 
 void arch_handle_ioreq(XenIOState *state, ioreq_t *req)
-- 
2.17.1


