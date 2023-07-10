Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D02CF74D890
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 16:08:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIrYd-0007PI-VW; Mon, 10 Jul 2023 10:08:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1qIrYb-0007OL-BU
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 10:08:05 -0400
Received: from mail-dm6nam11on2087.outbound.protection.outlook.com
 ([40.107.223.87] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1qIrYV-0006q0-NH
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 10:08:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mm5/D8L5PZZAqucnR5f21sN8AVZZhZnP/tNsnprvkVl1oZ4oQv9/BrwbcPiyCdJ10RYBxADpt1W5+HDni5898NC6fuD7IbDU92qNxUD7j2jdgZP0Y8qj9W+w/QZH4Bgn91FDFE6Wxl/K2gHruL3pI9YBTgqKSrJQtBbemlgfC0vY0khMxGrrAi2Y5X+SxJJDhk08RVaIoCP9dyr0rVO8gQBUlQbuSKniY8iDQHSr362e6nDMMOJd2XUJKn5UCLMD6Xzn/n191FeU8XrUh7qs9mQzyoqTHUFPCQX1oIHat5U+CvzIh/S3g90A6E27Zyswg1dJ5P6qeBBXmYNNYZN5lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IdkPepuThwgf0ezfrvJyHirCyHM+SV602+xWVEN/cj8=;
 b=Nw3rY2imGKtfNTnA5ewvoshTjUpX3wl36BvaStZq5Ri+7G2qTKWg637bpet1N8sFwXVGYN490x4hTpeTfUao0YMy6SeP3DDhO22WSc8Mv49+pzn/XIscdb8jl9VP9VGX7EWhxDtBLwjMQokzRw68Zpe5tCcR7iGnvmLPAL/qDtuog2nEtSaJSS+Nmc1VXzD+4+vwDxeUHTa2LYcvA6DDaWJC4I3W/atjo8UVSl9hENJw2a+sWHSQnf9346mlMNSAABNIID5gmWRTxD4M3C9qoG9w0R21bl1T+CTF8l/L0pAdsW2CanHYNMDWZP6Eqx0w5A9pH5o7XiB0920R1tihWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdkPepuThwgf0ezfrvJyHirCyHM+SV602+xWVEN/cj8=;
 b=Q2Yldhac0ZTm+LLv4MWCOV4GjJaeHm5yEHFVB7Vy/PzegPiOk+nvjJliFnKxq50mFbdc81q0mXTVXNzRBXkxg/xj+S37OEvIof0R0aSANKrprN2GAv5vvFk1JGaRV+1u4aGr2e/UWkiPSVH4t17laezK0IUIP5AbpVpLRTSgHOk=
Received: from DM6PR07CA0041.namprd07.prod.outlook.com (2603:10b6:5:74::18) by
 DM4PR12MB5071.namprd12.prod.outlook.com (2603:10b6:5:38a::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.30; Mon, 10 Jul 2023 14:02:53 +0000
Received: from DM6NAM11FT081.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::d1) by DM6PR07CA0041.outlook.office365.com
 (2603:10b6:5:74::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31 via Frontend
 Transport; Mon, 10 Jul 2023 14:02:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT081.mail.protection.outlook.com (10.13.172.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6544.38 via Frontend Transport; Mon, 10 Jul 2023 14:02:52 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 10 Jul
 2023 09:02:52 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 10 Jul
 2023 09:02:52 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Mon, 10 Jul 2023 09:02:50 -0500
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: <qemu-devel@nongnu.org>
CC: <frasse.iglesias@gmail.com>, <alistair@alistair23.me>,
 <edgar.iglesias@gmail.com>, <peter.maydell@linaro.org>, <fkonrad@amd.com>,
 <sai.pavan.boddu@amd.com>, <tong.ho@amd.com>, <vikram.garhwal@amd.com>
Subject: [PATCH v1 0/8] Xilinx Versal CFI support
Date: Mon, 10 Jul 2023 16:02:41 +0200
Message-ID: <20230710140249.56324-1-francisco.iglesias@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT081:EE_|DM4PR12MB5071:EE_
X-MS-Office365-Filtering-Correlation-Id: 6afedd2a-2960-49da-eec1-08db814e5a92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X5zqAO1UpMZbzgtREURCfdyOM9Ms/JnBaIcIy/BSJ2Fz6URTTIu4N99Rb+scz1C3yN0EBV2jRGUw1fRQHkc/iLMsdUnI5VFUZblPxJiHUPlgsp1KD2PBamC9FHXHHwSdudZj86RRC45iVqhFNZlZmngh00pstCF01drbYOkihJ+KiWxZ2FK4bnw2QuWZ9IFMQGYCwt6wATxnuozAk4LYfqqRrrS7SDClA3BrX+Wtdvyf4drFJUQ9O3bsMmBD5i+0QfWfzIezJjL6oPcRAzt2/58jNW3AHhlp9nz9ndkIIGbXoA00Dx2zuBYTpXl2o96JP3VTbzts073fnRb+s0TPmvcH9mcUah22yjnB65Lc3VdkQKUlH7GQ5xMfJj8kc/EDtykD2/9tu+futg9YwORnByiWgMCtlS8WNuWEjJRzqa7i0qzD+AU/Zo34AblWfsWCQGoKUNqq+xMAqCGfjWhqO108/lCmT5UHq+8ItOzgqvGY9YnfD2qe0Xw4P4XTa4bwHPluqr4raQyRX0zcy70ig8rEdvkHq3UstQaJgtDO0vu8gjHIW/lMi7ly3cQsrrZM8rC2GFbXRldMUK72awEf8Z4nicV57sK0WE4OqVpIghXxk1ybnvhAqhhL0PdR3o6WuHPcBKX2/wP1eckxMpQsH3fb7FyFYEjpaPeQDTUCL6wdPw20g4gb5euGfteyD/n9JFX8iGn9PsJksB9n3KwrwjIetAJdMBiPE6XOTESm9roLNZtajETspj3sO5/Z1X7o4rB6yxkAL1DEAZWEw/y+Kg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199021)(46966006)(40470700004)(36840700001)(86362001)(82310400005)(82740400003)(356005)(40460700003)(40480700001)(36756003)(6666004)(54906003)(70206006)(70586007)(81166007)(36860700001)(26005)(186003)(966005)(1076003)(2616005)(44832011)(5660300002)(2906002)(316002)(478600001)(8936002)(8676002)(47076005)(336012)(83380400001)(426003)(4326008)(6916009)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 14:02:52.9286 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6afedd2a-2960-49da-eec1-08db814e5a92
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5071
Received-SPF: softfail client-ip=40.107.223.87;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
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

This series adds support for the Configuration Frame Unit (CFU) and the
Configuration Frame controllers (CFRAME) to the Xilinx Versal machine
([1], chapter 21) for emulaing bitstream loading and readback.

The series starts by introducing the Xilinx CFI interface that is
thereafter used by the Xilinx CFU components, the Xilinx CFRAME and Xilinx
CFRAME broadcast models for transfering CFI packets between each other.
Thereafter a model of the CFU_APB, CFU_FDRO and CFU_SFR are introduced and
also models of the CFRAME controller and CFRAME broadcast controller.

The series thereafter ends with connecting the models to Xilinx Versal
machine.

Best regards,
Francisco Iglesias

References:
[1] https://docs.xilinx.com/r/en-US/am011-versal-acap-trm/PSM-Local-Registers


Francisco Iglesias (8):
  hw/misc: Introduce the Xilinx CFI interface
  hw/misc: Introduce a model of Xilinx Versal's CFU_APB
  hw/misc/xlnx-versal-cfu: Introduce a model of Xilinx Versal CFU_FDRO
  hw/misc/xlnx-versal-cfu: Introduce a model of Xilinx Versal's CFU_SFR
  hw/misc: Introduce a model of Xilinx Versal's CFRAME_REG
  hw/misc: Introduce a model of Xilinx Versal's CFRAME_BCAST_REG
  hw/arm/xlnx-versal: Connect the CFU_APB, CFU_FDRO and CFU_SFR
  hw/arm/versal: Connect the CFRAME_REG and CFRAME_BCAST_REG

 MAINTAINERS                              |  10 +
 hw/arm/xlnx-versal.c                     | 158 +++-
 hw/misc/meson.build                      |   3 +
 hw/misc/xlnx-cfi-if.c                    |  34 +
 hw/misc/xlnx-versal-cframe-reg.c         | 887 +++++++++++++++++++++++
 hw/misc/xlnx-versal-cfu.c                | 566 +++++++++++++++
 include/hw/arm/xlnx-versal.h             |  85 +++
 include/hw/misc/xlnx-cfi-if.h            |  59 ++
 include/hw/misc/xlnx-versal-cframe-reg.h | 305 ++++++++
 include/hw/misc/xlnx-versal-cfu.h        | 238 ++++++
 10 files changed, 2344 insertions(+), 1 deletion(-)
 create mode 100644 hw/misc/xlnx-cfi-if.c
 create mode 100644 hw/misc/xlnx-versal-cframe-reg.c
 create mode 100644 hw/misc/xlnx-versal-cfu.c
 create mode 100644 include/hw/misc/xlnx-cfi-if.h
 create mode 100644 include/hw/misc/xlnx-versal-cframe-reg.h
 create mode 100644 include/hw/misc/xlnx-versal-cfu.h

-- 
2.34.1


