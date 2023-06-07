Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2497D725235
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 04:51:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6jFk-00013P-U0; Tue, 06 Jun 2023 22:50:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1q6jFg-00011P-OT
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 22:50:25 -0400
Received: from mail-dm6nam04on20604.outbound.protection.outlook.com
 ([2a01:111:f400:7e8b::604]
 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1q6jFS-00029I-2D
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 22:50:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RoiWgwscZwskmNXpIEbbx7PF89o2qcUWLo7r/aL5jl3V/DmAPfiRQcH53IYDn9OmWbabPRaSoXXyBuTlhTXLAOPwBofThVYWn9yLKBRRhOOS4pCwlSVWPI2oMWCX9CA64lhOSqrHEU1mW6rLN8NqD+K/LBzJVBfPzuM7R13DA9m90IHOFqSeyyoOIQ1YTb24KJQPTHqDlg2kdktUvEViQOrO6gpXvQ2tYiVdsRhM7MtebdfyRB6XkjjDmgXrQr3VnoXhPBuLP8c1AGj8FAE1vMF4I7hvzga+aRl2K1F4osbvtXw09HKw2xfVtChJb0PapRdO2a7N9pkJovlNr6NuPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fqmkGN0oKwceSbxsT/y3Km3WBIThAu5mdpbB2zG15y4=;
 b=mLCxgJZ/B4kVXQGv3XHUeW9KQw5RzAxmoBqDc5tNApQCGE0j96qikUVw9zKoIHQkbnHcCVhX9PB+ZzocikEMFWbylBEQYAgocDDjk27D7brMY40Ar6z/TaiQoXF6sMkvDZzkqFR3vXno8pV7+m3O1M97Xh0KJUaTK5aL/Vhyqtd0ZA62qqvBfgiLnbKJfUiWQH8bO102QEmGZZ1O4CnvCIMrK9Nuoq5pfR4yHy1XkOskZkPURQA0EBNCC0SAK37fsTyxGboVmHGdWDXKe/HaCwYKk9LQcui6i5N/Ayr8AZ/jykbWhTcAuN+BqI2UDXB9yVvE3GbaP8Wns2HsqbvKrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqmkGN0oKwceSbxsT/y3Km3WBIThAu5mdpbB2zG15y4=;
 b=sRDAEKzA50U/ucr50F9PXZSBcZ70+/ZlbL1XLJGlhLnvXKPEN+YEE65AdxcowirrvEqhsPvGdcwHBWzN0bsmVlE25jZsF/eWc7ducN35VrPfQFbyXd5jTxq6qb/LadMxh0AZCXFk23ho2OGxihNeW4z0q9g/+1iQCt5FCy5Is9c=
Received: from BN0PR02CA0049.namprd02.prod.outlook.com (2603:10b6:408:e5::24)
 by MW4PR12MB7240.namprd12.prod.outlook.com (2603:10b6:303:226::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19; Wed, 7 Jun
 2023 02:50:05 +0000
Received: from BN8NAM11FT106.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::22) by BN0PR02CA0049.outlook.office365.com
 (2603:10b6:408:e5::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.34 via Frontend
 Transport; Wed, 7 Jun 2023 02:50:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT106.mail.protection.outlook.com (10.13.177.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.33 via Frontend Transport; Wed, 7 Jun 2023 02:50:04 +0000
Received: from ruby-95f9host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 6 Jun
 2023 21:50:02 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <richard.henderson@linaro.org>,
 <eduardo@habkost.net>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
 <imammedo@redhat.com>, <berrange@redhat.com>, <jusual@redhat.com>,
 <dfaggioli@suse.com>, <joao.m.martins@oracle.com>, <jon.grimm@amd.com>,
 <santosh.Shukla@amd.com>, Suravee Suthikulpanit
 <suravee.suthikulpanit@amd.com>
Subject: [PATCH v5 0/3] hw/i386/pc: Update max_cpus and default to SMBIOS
Date: Tue, 6 Jun 2023 21:49:36 -0500
Message-ID: <20230607024939.703991-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT106:EE_|MW4PR12MB7240:EE_
X-MS-Office365-Filtering-Correlation-Id: e268a5c1-2ded-4894-62d9-08db6701e566
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iPdLHxWsbCj3g5hBMzjR8nBimGGKSjxheJgJC6GXCr00iJ65bV4y6QPqXOsCWDGSY6XCeDnhc/jsqgYtbWz2a0jXqBK8mNv8DrJS5XkC+ff2lwV6QrdeeY9VRWFLh4mUKZRhDVuA2WotQlsIGpPvEdvrJ/zNNABWUqYTmFW06z3aDxZZUGi2lv2JuDTmyNH+GpzSb0qy3IqcQ4PjCEw+wQJVpCgFE5owK0jWP+tVPuOKJYRm8FwHP5dRCvyPPLERenmBH3mYXIRjioaxF6PgrADrgBE9QsnKGTm5mT/Iv8nnbRHJYB9IrB3zd0k1QBVyBpwxw0WxydcQyeCHmSEShRqfJbRmKnBPWw+/9Mdq3JnDeDRSoeUKoRgBTTj5sA5hWP5MlI2uI/igfg1mtt0l5GJRti+dMk0ahHy63jl12FT3SbHIys6IEr7ZzC7JprAbYxuQiVUVdlxfKbGW/5dwF5BGMXNAsCrc1UV77GFJU/kJ3jxOfwx/xsVIjO21W8jmQSQhzgTS0iWZYsX3qImCwc1JJbUA03jmhKqmunY+z4J7KIJZfuQV/XeA91tISlE5rHVsO/q3oVt8Ee5OuJi9Bzk7gcZUqolA7pJiSLZSEqo5LqzHJhoyzqB+KJlyI7TOv2Nq6BfFZ8sepu8XfAC7GUM7XqweVVkZ87QxZD8gPNJCEpGhkkblX4o1acVxTJ1Ke7plPQ3Nc6v3v00FKdF8/UkivWEWXEijF6DQXTTHpvMEE3q9ot0BjmOD9ifvjIa/nfvUbefjzpnTECcsneH9WBYpABm+pwPKRrjl8whjS8Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(39860400002)(346002)(396003)(451199021)(36840700001)(46966006)(40470700004)(26005)(47076005)(1076003)(40480700001)(41300700001)(7696005)(336012)(6666004)(83380400001)(426003)(36860700001)(16526019)(186003)(2616005)(40460700003)(478600001)(54906003)(70206006)(70586007)(6916009)(4326008)(82310400005)(82740400003)(81166007)(356005)(316002)(7416002)(8676002)(5660300002)(8936002)(44832011)(2906002)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 02:50:04.3284 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e268a5c1-2ded-4894-62d9-08db6701e566
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT106.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7240
Received-SPF: softfail client-ip=2a01:111:f400:7e8b::604;
 envelope-from=Suravee.Suthikulpanit@amd.com;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

In order to support large number of vcpus, a newer 64-bit SMBIOS
entry point type is needed. Therefore, upgrade the default SMBIOS version
for PC machines to SMBIOS 3.0 for newer systems. Then increase the maximum
number of vCPUs for Q35 models to 1024, which is the limit for KVM.

Changes from V4:
(https://lore.kernel.org/qemu-devel/20230605213906.644883-1-suravee.suthikulpanit@amd.com/)
 * Patch 1: Introduce a helper function pc_machine_init_smbios() and
   move the callsite from pc_machine_done() to pc_machine_init_fn().

 * Patch 2: Remove stuct PCMachineState::smbios_use_cmdline_ep_type.

 * Patch 3: Keep max_cpus for pc machine version 8.0 and older as 288.

Changes from V3:
(https://lore.kernel.org/qemu-devel/20230603032255.517970-1-suravee.suthikulpanit@amd.com/T/#t )
 * Patch 1: Refactor the code to setup SMBIOS defaults to pc_machine_done().
 * Patch 2: Minor typo fixes in comment.

Changes from V2:
(https://lore.kernel.org/qemu-devel/20230531225127.331998-1-suravee.suthikulpanit@amd.com/)
 * Add patch 1.

Changes from V1:
(https://lore.kernel.org/all/YnkDGsIi1vFvXmiP@redhat.com/T/)
 * Bump from 512 to KVM_MAX_VCPUS (per Igor's suggestion)

Thank you,
Suravee

Suravee Suthikulpanit (3):
  hw/i386/pc: Refactor logic to set SMBIOS defaults
  hw/i386/pc: Default to use SMBIOS 3.0 for newer machine models
  pc: q35: Bump max_cpus to 1024

 hw/i386/pc.c         | 28 +++++++++++++++++++++++++++-
 hw/i386/pc_piix.c    | 14 +++++---------
 hw/i386/pc_q35.c     | 16 +++++++---------
 include/hw/i386/pc.h |  1 +
 4 files changed, 40 insertions(+), 19 deletions(-)

-- 
2.34.1


