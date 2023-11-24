Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE487F7666
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 15:36:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6XHP-0007sJ-0z; Fri, 24 Nov 2023 09:35:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Frederic.Konrad@amd.com>)
 id 1r6XHM-0007rW-Bn; Fri, 24 Nov 2023 09:35:36 -0500
Received: from mail-bn8nam11on20600.outbound.protection.outlook.com
 ([2a01:111:f400:7eae::600]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Frederic.Konrad@amd.com>)
 id 1r6XHH-0006y7-N0; Fri, 24 Nov 2023 09:35:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yxuzkpa67ud0LXXySLHfdw3G3r8JhaXCkwUWWj55n3PYJsnE9O+8MKpk/e/tNeF5Yjz14Movw6EEDzheRGoBzURpacjLvr6ceZ1m4wfpwsKHH/EzokX/jeH8i/XY8jbtmGqhPPPuqB156oAhKLLGIFAw6K8PLrQit4qL9OOMp9wSgMVgJTJHnl581FRBMe/zPNLYXXfiefDhGQHubMIkQ6ISCNcMC+g+hsgC+xLuzVWh8oPplPddCiWkAsvfsPkdINbAjVkWVgT1iCEkWATqcoKtx7CFeSFXqIOvbQGJ1v/70EwMo2Ksj+muQ1sLXxrk5WPM6kGXCq4KL5c6SydTBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5nllDb9jj2UCJ0CmFxKFDuIQKzJQPr91TWgm3T5Lqo=;
 b=aOhPXWlyGM/ORGKmuoMNl5x/VmwYfC1rbSZNTO9R8qQiPNc5J3h2H5YJupOl+ZBBs3oarARl8IMtebqZaX4/UGl9og7wvx04ofj6VRaqjw33/vCQU0R3dCChYxdwVU8h/piYaB909lguPH71ab5Cii9caUNfeL94mbTPVYLCMK9TIVA0vg9S4ZmuBQKPO7XVtFPMVTIPMjS70LkWTR65iPTzq/qLhH+ahtmqnWtUFYBxDEUkoCVewG0MHBnzgVoFEXttJ0kY1D3Lnml1zFMYR3NtRB6TH0Dz6gLbe5fQ+hCmcQJXqPoU4D074jQhnCWH/n0gvHeR2pl9g6icAn8k3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5nllDb9jj2UCJ0CmFxKFDuIQKzJQPr91TWgm3T5Lqo=;
 b=rnhkkOpbMNCqQd1C2XUE3JgggdeIx7hr+soGQeDnXBhC3arLs27c8SoZRamfwD7gJKf3kF1PQhMAwkhTsPbNjTkBNCScKr6fumIFfDRISnPsHsz8tDhtmtBIfl+zO49DY+1eZ++ZMavf+Rti8Y+dvo5lfck7MzF5rfUAWY+zPGw=
Received: from CH2PR10CA0018.namprd10.prod.outlook.com (2603:10b6:610:4c::28)
 by SA1PR12MB9002.namprd12.prod.outlook.com (2603:10b6:806:38b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Fri, 24 Nov
 2023 14:35:24 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::9d) by CH2PR10CA0018.outlook.office365.com
 (2603:10b6:610:4c::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19 via Frontend
 Transport; Fri, 24 Nov 2023 14:35:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.13 via Frontend Transport; Fri, 24 Nov 2023 14:35:23 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 24 Nov
 2023 08:35:23 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 24 Nov
 2023 08:35:22 -0600
Received: from xdcsswbld02.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Fri, 24 Nov 2023 08:35:22 -0600
From: Frederic Konrad <fkonrad@amd.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-arm@nongnu.org>, <francisco.iglesias@amd.com>,
 <peter.maydell@linaro.org>, <edgar.iglesias@gmail.com>,
 <alistair@alistair23.me>, <luc.michel@amd.com>, <fkonrad@amd.com>
Subject: [PATCH v1 0/3] ZynqMP / Versal: various fixes
Date: Fri, 24 Nov 2023 14:35:02 +0000
Message-ID: <20231124143505.1493184-1-fkonrad@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|SA1PR12MB9002:EE_
X-MS-Office365-Filtering-Correlation-Id: b1ef4d51-30bd-4ceb-d965-08dbecfa97ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ud3y6U8WieJd6Swhui2fgpOACIp0o82vVK7rL8/xX5TfH2rHfD9EvzQpzokIMQ3GXO4T/Kt+RAXqaWrG7dPJcUuagO11W7TWgFI2VsKWoTdmhZoM2/WHzj3SP/89k/icSeHRfXb5SLtWdT2jG6lzIQ7uw0YX1F+kWqt87ngAjuHebNQbSPLnjk0AVBCGmIuYRlgITwbVGijhC1jqOplFaBUoEUaC4/ZBlitBTelchje7MT25beTMkNe7zb2SJujpcmS673nicVo4yLEq/O1wnk9U2O7s/8/FhebJ75R5bS9Dawio0PxvkXWv/nGViFh/tvCHBcOKoYPDx6d2kiwasBGojNP2kczzpfRdnresWBpFzpjeCmiNZ7lEuKnY4IRLZxS2IUHGh3TWHh0z2gMQqGLE/9LkEmZSmxPItqB4Vu8kVk8AS1VeMdICxMtTUagBnZjou5SY56G+pSjVQgmU7L6rfkI+KFVGo05lsn1WGnE536P6wzw35FmL1Sn7IyJcdHA17r9l5G3ngx4xyUt5JumI+tc/HBELXpp0qskGosrCHYWAFimFUiI+n3V9try3OyhhJqNrAZXrTOMOtammTdvsyubO/lZSIjUQ6HfQKikRcNim7hKzd9uXvNWfR4XzcKyHMcVLv3exO+jZOInJZshd1GuaumuWvhe5SstUHS8Ob3xbIi9iwZMxkAfSTayu9lWiF07CCxA9sNiBvCyu/xSf8mmHPb+6BGx54shOEW0EcW8pOhnQFXrnj+q5El8CRsHzWb1GhFWJk/VvHOFo2g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(136003)(396003)(376002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(82310400011)(46966006)(40470700004)(36840700001)(336012)(426003)(83380400001)(81166007)(356005)(82740400003)(47076005)(40460700003)(36860700001)(70206006)(54906003)(70586007)(316002)(6916009)(8676002)(4326008)(8936002)(41300700001)(5660300002)(4744005)(2906002)(1076003)(36756003)(2616005)(40480700001)(26005)(6666004)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2023 14:35:23.7136 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1ef4d51-30bd-4ceb-d965-08dbecfa97ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9002
Received-SPF: softfail client-ip=2a01:111:f400:7eae::600;
 envelope-from=Frederic.Konrad@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Those are various simple fixes for ZynqMP:
  * 1: fixes a possible out of bound access in the SPI model.
  * 2: is a trivial fix for documentation url.
  * 3: is a log guest error fix for the CSU DMA.

Best Regards,
Fred

Frederic Konrad (3):
  hw/ssi/xilinx_spips: fix an out of bound access
  fix some url for amd / xilinx models
  hw/dma/xlnx_csu_dma: don't throw guest errors when stopping the SRC
    DMA

 hw/dma/xlnx_csu_dma.c                      | 14 +++++++++-----
 hw/ssi/xilinx_spips.c                      |  7 ++++++-
 include/hw/misc/xlnx-versal-cframe-reg.h   |  2 +-
 include/hw/misc/xlnx-versal-cfu.h          |  2 +-
 include/hw/misc/xlnx-versal-pmc-iou-slcr.h |  2 +-
 include/hw/ssi/xilinx_spips.h              |  3 +++
 include/hw/ssi/xlnx-versal-ospi.h          |  2 +-
 7 files changed, 22 insertions(+), 10 deletions(-)

-- 
2.25.1


