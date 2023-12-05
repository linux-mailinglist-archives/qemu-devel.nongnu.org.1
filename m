Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CC1804EAF
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 10:51:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAS4l-0006BS-Fc; Tue, 05 Dec 2023 04:50:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1rAS4W-0006AQ-4X; Tue, 05 Dec 2023 04:50:32 -0500
Received: from mail-mw2nam10on2060f.outbound.protection.outlook.com
 ([2a01:111:f400:7e89::60f]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1rAS4S-0005Ec-GZ; Tue, 05 Dec 2023 04:50:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XHJ1Dr+pMv/ToyLBAJmHfEFrjc+WXp8h8mGi1r34bZe30MEHYS2meEpqxJvRMnen8Ne1nfPClDBm15v7mJOYVWF+g21KKQz/tjRRMSbrwIPaUfvWlpGuduObOy4q/pRCsYlHyYthNrfMcfHvsEsLgXFbF7YP3i40OTEmXAW/8eSUwMI17BmL0zIRggQize/nGJItmeTB/Nrk6LcZbyKucPIZXvE+b/t1FTvwrbG8z7VwIem6BMb+tgTlKIZfxvgt70Q7j78dbigFSs7065Zj0jrTCxlpc9Emv9tGdhcH0xQx80JAB9Tbg6OZuEy8XPK/tIjQydDEvAryvgHXZm4y3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sz1cnUiVTv94tT6QFK+z3UwvPSZIx1UHPOxAhsMZlrU=;
 b=jFIe7zcIpByrj+Xq1UypTkYI0m6rKXpYBR3WaJWSxBAi2jC0B7QTryX3anejJGsLf5Hzl1a700P5/ra+j6ddilY/l75VdbY7Hw0QrSdMnSe7q26eR/+GPv/dOZf1XzjL6yrOpKgvv3UOslou5eCDCPKg+9OhfLen2FhckpvfzIMyhZuEMtDIUWVhq2VeZqvGqbr0bF6PSljhThwvaVWhZqdmeFt4MpyZzq2+gYBDnQ2yNnxBBsqcl9Fh86psVfVWIyHw0TkRs8pCQKXHuY0TfWKVIKpRqPRwhpQ2DG9WHdylvpHhvTp1bjrKC9EduvgZ6qwI3poZcDXfSp6xDhwUSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sz1cnUiVTv94tT6QFK+z3UwvPSZIx1UHPOxAhsMZlrU=;
 b=IW5UgHinRyoJDmGH9tPRmmGeU445xfhAtUs5kiJAE+4o/+sKBgKn/LbnSQBkWzei6AhM/F9Fr17YyEnDxg+Mg6uMoetMsZa0B4CylCWUbVFNmwuC1eaLmMiJdWNNYQfj8xV4ix3bIW58615yy4Kt8aOSQfub5hLir1Xk8f4Hhbc=
Received: from BLAPR03CA0110.namprd03.prod.outlook.com (2603:10b6:208:32a::25)
 by BN9PR12MB5242.namprd12.prod.outlook.com (2603:10b6:408:11f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 09:50:23 +0000
Received: from BL6PEPF0001AB51.namprd04.prod.outlook.com
 (2603:10b6:208:32a:cafe::ce) by BLAPR03CA0110.outlook.office365.com
 (2603:10b6:208:32a::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33 via Frontend
 Transport; Tue, 5 Dec 2023 09:50:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB51.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Tue, 5 Dec 2023 09:50:23 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 5 Dec
 2023 03:50:23 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 5 Dec
 2023 01:50:22 -0800
Received: from xhdvaralaxm41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via
 Frontend Transport; Tue, 5 Dec 2023 03:50:20 -0600
From: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-arm@nongnu.org>, <qemu-block@nongnu.org>, Alistair Francis
 <alistair@alistair23.me>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>,
 Francisco Iglesias <frasse.iglesias@gmail.com>, <saipavanboddu@gmail.com>
Subject: [PATCH 1/1] xlnx-versal-ospi: disable reentrancy detection for
 iomem_dac
Date: Tue, 5 Dec 2023 15:18:02 +0530
Message-ID: <20231205094802.2683581-2-sai.pavan.boddu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231205094802.2683581-1-sai.pavan.boddu@amd.com>
References: <20231205094802.2683581-1-sai.pavan.boddu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB51:EE_|BN9PR12MB5242:EE_
X-MS-Office365-Filtering-Correlation-Id: 0db4ad49-236e-4e4c-8d8e-08dbf57799d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8gmC+WE0xyM352ijwdXZuczaesv6irC4zQDuziYxP5keW9FKWLg83zbFlDPNwHsQE4JY4ND1vTAj4/iPqkzWS8OIBJIWuZ8LBe7WurquZf3mFmxdB2xp7oDCTnkz+M4lx8qj3ApNcQP0folVzPxIGoDIGQ4U2o9V3qSMkVgeKTdDQmqsqNjfrjCQLvFChS0qPxS4jYBZub2WCKYtvIVtEbVNE5TAcxxxhvcgPBUJy3qAQQkFSQeu3JVvU7ncqZ496y4fR3ON4IsZrUuCkd8sUVjvTp0PZPpUL4MQeQUHgYBg4PEK/YcEqj2OARM9xMBra3NVWjgkDsYFYSAAjVvDrB+AMogfXZDrYkfNkOFGBHg7UdNOUWqEi8D+Pd0FbhgKBsOB3j8/hhq9uzoFHh1OFajFE8i4C8CeQFCsrj5ix2QdxNGos/pPVpSzjyvsEiCypdzvEEHPGMYUDH0StZEl2tcf/GsX5qesn9h7ywJOKRJxVKcMidGN3z80Zen3wP3tliVn+BP/Y+mxNJlaEvcA6sBJLPCyEhurQjE3gal8Lf+aCf8/y++j39RhE5f48peHiTmsvyKsB7Hn7538y3zvkvmOFyV1C+MYyxIfV7JZR2HUMNO4jDR+w8Z6stNPCmAEWtFdEnm7UFbr/j9W4EBod7Bic4njUpyaNs5rscYgEOw9ZTlJ+PzrFnButpvo9027jF93NDpzPADehZom85KnewxHBXG66kM1FZH5M88Eg7kzRLBwJzlupyrdWXlehs3rQ20DFel10kkMt9kuV8AkQg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(346002)(376002)(396003)(230922051799003)(186009)(64100799003)(82310400011)(1800799012)(451199024)(36840700001)(46966006)(40470700004)(4744005)(40480700001)(36860700001)(103116003)(2906002)(316002)(6916009)(54906003)(86362001)(70206006)(8676002)(70586007)(41300700001)(36756003)(4326008)(8936002)(356005)(47076005)(5660300002)(82740400003)(81166007)(83380400001)(478600001)(40460700003)(426003)(336012)(1076003)(26005)(6666004)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 09:50:23.3214 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0db4ad49-236e-4e4c-8d8e-08dbf57799d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB51.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5242
Received-SPF: softfail client-ip=2a01:111:f400:7e89::60f;
 envelope-from=sai.pavan.boddu@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
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


