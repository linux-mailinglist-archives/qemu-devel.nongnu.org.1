Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 313A5804FDA
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 11:10:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rASLs-00050I-A5; Tue, 05 Dec 2023 05:08:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1rASLj-0004zf-5i; Tue, 05 Dec 2023 05:08:20 -0500
Received: from mail-dm6nam10on20600.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::600]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1rASLh-0001aC-6t; Tue, 05 Dec 2023 05:08:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y/dLUxUVACR6rv1iUetkI6Bf5aTmr3F+vVntkFM99uGTVYusQkygsPsChF2nNM6jEvObK+w+tU1iBgGPmiH0egq++zR4vs4ojhlHneU0S2EAvOCzMPc242RiPKWnkZcUFVhYR1D0PNWyYsNojk1Bc58dUuIwkZMC6YLyGAdTvqbTP6p0aemZwhD8nE6X2NXiozrBx0NDhwd/mgrsI2AfR1jzOz8pdhU7kKhZ1ZAtjV5xT4IR8pJ8Y/xbyT3ukweCEMnWNW+uQmImeAOXQ2XHTXJ6VhjK+Hrows1IpKmYti7odeNoQEUEZkRJh+1hJrsvyXJCndlu7g2W1mcIT5a63w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sz1cnUiVTv94tT6QFK+z3UwvPSZIx1UHPOxAhsMZlrU=;
 b=To3b3wIUodZVkJi21JjUpjYz2+UGC8yWpmbcEuMpfhr2hidO5mHzfO3AuHAiqFi9G2570dcmob21yvzKYfcsqi36uRL4s6eCmuuxuCQD77yc2ZQl7nPg1NITUhCV3U7oJT/59ZDIRjWPSnN3+b52npFBwJujAQzpOtnleydZFogekHdo7Z3vvPwKZos7C0NXwL+QLLAcJvas7JgrI2ZC9HB2vVGfjDLHr4CQ3Gq4DfBXQHW0yRK9tn2IYrYELy1cMy3cAAV73KqidiBB/FbDlA4VC8IGixEFNxCE8AVnkuZTxqATRMPgDuhU59+I9FxnhHTAH+CmKdzO/rHdf8SaKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sz1cnUiVTv94tT6QFK+z3UwvPSZIx1UHPOxAhsMZlrU=;
 b=NvRU7p7iim8aOY9bUEXyEkftQysOaqKtqkk4pvtE8KWNGwNnkM5+OuX+ZbEijLddcsy38TTdWIWE6C+k4i+P921mNGQceddJ7IJ2hCoZfzbquKb9rr2KnqEmY+gDE2fDa+3Ic7kZIGfmrT4vnP4q3jViYvf96QJmjmVSGnInXKE=
Received: from DM6PR02CA0154.namprd02.prod.outlook.com (2603:10b6:5:332::21)
 by MN0PR12MB5761.namprd12.prod.outlook.com (2603:10b6:208:374::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 10:08:10 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:5:332:cafe::fd) by DM6PR02CA0154.outlook.office365.com
 (2603:10b6:5:332::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Tue, 5 Dec 2023 10:08:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.205) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Tue, 5 Dec 2023 10:08:09 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 5 Dec
 2023 04:08:09 -0600
Received: from xhdvaralaxm41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via
 Frontend Transport; Tue, 5 Dec 2023 04:08:07 -0600
From: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-arm@nongnu.org>, <qemu-block@nongnu.org>, Alistair Francis
 <alistair@alistair23.me>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>,
 Francisco Iglesias <frasse.iglesias@gmail.com>, <saipavanboddu@gmail.com>
Subject: [PATCH 1/1] xlnx-versal-ospi: disable reentrancy detection for
 iomem_dac
Date: Tue, 5 Dec 2023 15:38:02 +0530
Message-ID: <20231205100802.2705561-2-sai.pavan.boddu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231205100802.2705561-1-sai.pavan.boddu@amd.com>
References: <20231205100802.2705561-1-sai.pavan.boddu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|MN0PR12MB5761:EE_
X-MS-Office365-Filtering-Correlation-Id: 24ec1ddc-b360-49db-cea1-08dbf57a159a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m0d6R3jOVIIvM2FkdCw7Zr756Qh3bZ2h+Pdnlp62jpVECdBmUA0K13NCdSLc7893YM9WXRAUnbRgFq50cfhICKTLrh1BNtKDc482lKGICjHEWoShU7xu85IzPtI62LlAgUq+30II1/1kr3w94gSHTMmAKWKb4V3C7piZMgAK82GPDzLGTxHQfHSc2srBnP2yPWYhZy9DiEfl626RDmpsq8lyN7FjyuoGIEIE3JVfpGvK/Al9vFzmq2OuNdhLZP4/15zmFzJyM+jpk/F+w/vNwYY+ubLFjWGoR36AvII3h5aIHpIh28cidXi8LcMyBSPN9N7gPdSIXrVBeWYiZPHM9H35bCezJivac0A/3zNPHXGgPsmgcDYvT0IhL2CmBXODoLyrfWkkBoyUa971ajbmohS309hE02go19U5tTQu/rkcOvETmQlJQI1QjgYG23ALodiev6Opq4LnKuNHvaHK+T3b2z5H08A4iak6SL7ic2NmVyhtwZU6S3wxGwOiaKbjKI0cpZF3vqpuiLsgEI4YsN/Vy91SmJqCc92f6+Ka7MisCTHbM7Lj3zmhEmE6EuFsrr/SeeElZpjEJOnToKN1IetyD/H5rl5VI0tx4rsT6gkmyP6RVdFo9E+PO4k+SzpBgp7TKs6YdmpGYmBvy3Q2P9nSacam0ccsUgL3Ggm1C1o/F25Eu/Oiked4zLjZg8Qtri7RfRb+bGhCwNQ1uXfNFeBFzjeqz/cEqRsjRbwERkTo+XS/4+pK8nY6yrBQh/g2H4xCcwJd7XhWs3uSJdHOVAgzwJ2QWbXwXuLSb++sZs9BOQ/H2ZnPKzeUgk6E7W0F
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(136003)(376002)(39860400002)(230922051799003)(1800799012)(82310400011)(451199024)(64100799003)(186009)(46966006)(40470700004)(36840700001)(336012)(426003)(1076003)(83380400001)(26005)(82740400003)(6666004)(478600001)(2616005)(40480700001)(8676002)(4326008)(8936002)(6916009)(70586007)(70206006)(316002)(54906003)(36860700001)(81166007)(47076005)(356005)(40460700003)(5660300002)(2906002)(4744005)(86362001)(41300700001)(36756003)(103116003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 10:08:09.9245 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24ec1ddc-b360-49db-cea1-08dbf57a159a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5761
Received-SPF: softfail client-ip=2a01:111:f400:7e88::600;
 envelope-from=sai.pavan.boddu@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
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

The OSPI DMA reads flash data through the OSPI linear address space (the
iomem_dac region), because of this the reentrancy guard introduced in
commit a2e1753b ("memory: prevent dma-reentracy issues") is disabled for
the memory region.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
---
 hw/ssi/xlnx-versal-ospi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ssi/xlnx-versal-ospi.c b/hw/ssi/xlnx-versal-ospi.c
index 1a61679c2f..5123e7dde7 100644
--- a/hw/ssi/xlnx-versal-ospi.c
+++ b/hw/ssi/xlnx-versal-ospi.c
@@ -1772,6 +1772,7 @@ static void xlnx_versal_ospi_init(Object *obj)
     memory_region_init_io(&s->iomem_dac, obj, &ospi_dac_ops, s,
                           TYPE_XILINX_VERSAL_OSPI "-dac", 0x20000000);
     sysbus_init_mmio(sbd, &s->iomem_dac);
+    s->iomem_dac.disable_reentrancy_guard = true;
 
     sysbus_init_irq(sbd, &s->irq);
 
-- 
2.25.1


