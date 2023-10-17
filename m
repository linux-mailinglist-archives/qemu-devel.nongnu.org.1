Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E647CCE0C
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 22:28:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsqdv-0007nd-Gn; Tue, 17 Oct 2023 16:26:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1qspzh-000437-DK; Tue, 17 Oct 2023 15:44:45 -0400
Received: from mail-bn7nam10on20602.outbound.protection.outlook.com
 ([2a01:111:f400:7e8a::602]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1qspzc-0000sF-Bk; Tue, 17 Oct 2023 15:44:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T2CM1pAVozX9SoZyfkTj3PI9qhocqi40jTKBFMGgpi9C79UP7ypLW9XJ9KuR5DkdUhsC10l8zSKbTA8K2gugj5+Enel3dwq1zSSM9gbOEqfdEQ3hTFo31LCzUEw1o5lVZlrhM2KPI6RvmQG9Wlj8jGV+/nl9MnnoDQa7vOMO8PJu4y3uc8UNq5faVBeYkaUBCFRoRv3oQNuCKlObgI/0sK52wavDoDT7pvps5iSOg0vqOTZh8vHuvinjudqmu93itlaMpLjzoaQE37EHa+5WIFvyfLqE+blFHMcMpfAqQ/pwzrILPuJJErT822EN6hUeHe3VaIc5LApSSjd5F/CaYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZrLxbN/OfAMSr8G4wLa9Tsy2CGeS/W9nGuxr8fPrIM=;
 b=HGtz1v74mqlwdK5ZOn2w2qrcVgpRzrG+J1lzBsy31QkeEhLTOd2NOommFdOW4GdbTxShIi3hL3BuEJXVTOsEWBPmTRvwc18mi3JxQDEvqt5+pyR2Rt2hSron3GZZqn1qDGYa0w+NY/HqFnOQdq48nM3f1j88dT6NtQ/e4xBikM8OxQvXVfK7UNDxxQtSLkrVrXS6/PRC5zZ5I56jJnBC0BlnDL3bR1k/vehDCTu4EYWHb3/XqWgfhxNH1hYX31BsakAyZJVF2oULgI833mNF3VJKKEJO2LRF3KHIMczqMQ0f2hESHEZCtsDccW5ZSGvCMavnXj/UpQjew1nto/9SqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZrLxbN/OfAMSr8G4wLa9Tsy2CGeS/W9nGuxr8fPrIM=;
 b=YJc/cIiSwjtUjk/WtVmI7UMPGQh+aSAfC9lHmcOfG9jQh1KOHZJXE56PJKTNyQkfIx8hHgyWNYItPihgVg1S+VoJQKF5tOHjDcNsUXJ0s7AYZ+eu/zhh15dltkCsQ1ROv9mdLe6Rd9NlSBESh1IWxpQ0X5jj3zWUwCNOPUHzwz4=
Received: from DM6PR03CA0075.namprd03.prod.outlook.com (2603:10b6:5:333::8) by
 IA1PR12MB6091.namprd12.prod.outlook.com (2603:10b6:208:3ed::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 19:44:32 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:5:333:cafe::d) by DM6PR03CA0075.outlook.office365.com
 (2603:10b6:5:333::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Tue, 17 Oct 2023 19:44:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.22 via Frontend Transport; Tue, 17 Oct 2023 19:44:32 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 17 Oct
 2023 14:44:31 -0500
Received: from luc-work-vm.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 17 Oct 2023 14:44:30 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, <qemu-arm@nongnu.org>, "Edgar E .
 Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis
 <alistair@alistair23.me>, Peter Maydell <peter.maydell@linaro.org>, "Jason
 Wang" <jasowang@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Francisco Iglesias <francisco.iglesias@amd.com>,
 Frederic Konrad <frederic.konrad@amd.com>, Sai Pavan Boddu
 <sai.pavan.boddu@amd.com>
Subject: [PATCH 00/11] Various updates for the Cadence GEM model
Date: Tue, 17 Oct 2023 21:44:11 +0200
Message-ID: <20231017194422.4124691-1-luc.michel@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|IA1PR12MB6091:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b1c04cb-4930-41d8-1ce2-08dbcf497c05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JQUS5S1MGI6k7ZT8royauEmBc++w/UfmaqnVyoPieOoIQgY2N1gM8R3N/ArSYcxw9g4AZ/yrjp5HOD1DdZwXg5XjP9wGrlw0OxovFqL+R6E0g4hJvbxqcvKuqls6dXlsc62cp40aYNcYkfhh3IeMwiAh9rC/LlLIJ+eUdemwvBspeDgj4DZ23OtIir4HeW/iwkyxNqs3hpHeYxu5JK8L8j95Nbs1qWBSwXUT3yCsZ+d/l8pT/X8vZQOZ+te3wCi14B2PeojYVb1sQ0o7Y9DuqvGq1m7GWpmIXeRNFMFwui/ThP9+rGhwjaGkhPCNGRb/rxCk0/fpKHjgnWH4RLVCl80h71xi+W8i0b/NlrA3xQXhlQ2FgjlRT5YA4dCMH0Luoxpr5QliwkKyFtse9iRB7nLv2K2A0FqMuw2l0D8n9ocf4J7m1I2bpP7k7YEWAGdrJFIKPSqBOuJtolrnwWkseEbl9K7hUfC5HyfmQRo4zfYuMvAzaV22FQk4bqnEGXu8LEys7RiVnrGmAVQKQ1YDlMkDfb+yn0KPuFpCZesV5BWkIM85BShnMElyag84QCmf4mdOFqoNNQDDDKjY4Zs5bWhvEGLGXGyR5wHg7ia2XMPAzxMvtFAGv0Izg6wWaCfZTWP3X+EZ0hol4U/YndNa+XQjXMyWwyTgTuTOFbJc1MKsZ8gPBrHCZlsX2718vBeEYBcildHoOT8pzL1FKGzp7c0o66uG6PORou4YjvGnUzeLx9LX94GPBrQ6pfpgWPxWwWy60i4tiyqOjNpcnzj9kA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(136003)(396003)(376002)(230922051799003)(82310400011)(1800799009)(64100799003)(451199024)(186009)(36840700001)(40470700004)(46966006)(41300700001)(81166007)(40480700001)(356005)(86362001)(2906002)(478600001)(36756003)(54906003)(70206006)(70586007)(6916009)(36860700001)(6666004)(316002)(8936002)(8676002)(40460700003)(44832011)(26005)(1076003)(426003)(82740400003)(336012)(2616005)(83380400001)(4326008)(47076005)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 19:44:32.2547 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b1c04cb-4930-41d8-1ce2-08dbcf497c05
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6091
Received-SPF: softfail client-ip=2a01:111:f400:7e8a::602;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 17 Oct 2023 16:25:59 -0400
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

This series brings small changes to the Cadence GEM Ethernet model.
There is (almost) no behaviour change.

Patches 1 to 9 replace handcrafted defines with the use of REG32 and
FIELDS macros for register and fields declarations.

Patch 10 fixes PHY accesses so that they are done only on a write to the
PHYMNTNC register (as the real hardware does).

Patch 11 fixes a potential bug on hosts where unsigned would not be 32
bits.

Thanks,

-- 
Luc

Luc Michel (11):
  hw/net/cadence_gem: use REG32 macro for register definitions
  hw/net/cadence_gem: use FIELD for screening registers
  hw/net/cadence_gem: use FIELD to describe NWCTRL register fields
  hw/net/cadence_gem: use FIELD to describe NWCFG register fields
  hw/net/cadence_gem: use FIELD to describe DMACFG register fields
  hw/net/cadence_gem: use FIELD to describe [TX|RX]STATUS register
    fields
  hw/net/cadence_gem: use FIELD to describe IRQ register fields
  hw/net/cadence_gem: use FIELD to describe DESCONF6 register fields
  hw/net/cadence_gem: use FIELD to describe PHYMNTNC register fields
  hw/net/cadence_gem: perform PHY access on write only
  hw/net/cadence_gem: enforce 32 bits variable size for CRC

 hw/net/cadence_gem.c | 910 ++++++++++++++++++++++++-------------------
 1 file changed, 510 insertions(+), 400 deletions(-)

-- 
2.39.2


