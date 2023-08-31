Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A4D78F14C
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 18:30:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbkY9-0000rm-F6; Thu, 31 Aug 2023 12:29:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1qbkY6-0000ha-PC
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 12:29:38 -0400
Received: from mail-bn8nam11on20600.outbound.protection.outlook.com
 ([2a01:111:f400:7eae::600]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1qbkY4-0005aA-1T
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 12:29:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eN8Eej57GgyJOX5Unmu9vX3QWhEowZ3kcCxezHfr7ZXghJkzmpeIF53tLCkPUibUdChtJj8dSglz5SlpWhWO1Fa5uObK/OrVms02TnqvYmWoDNzmze67Or2D2gl41wJcuKke2QjcIGuNsa90g/1xA78cs022RLRuAsmPjfTQCgfNhM0/CjS+tG3AKin6f68EggkdafmanQlE9D0mRcUr5BuhCFcYpbIWPv6s1fWmsP/I1RQxLXAWmQ8vPibP2jqQ8vF8s6dg4TJyOJ1UBnH51Qab9DKVGHk9FSU7O3Rdio+XPCICshM/DfcJ7vp7b4zER3+qzMxVT4kR5e+T7ttWSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQ+lddYVIVTyHUZJvwGaDUPTBiw80FboOA1+/NRIf+w=;
 b=I6vmz+5r5LKlpi5l0KBwytFqvHvbWF7gg+q2QGtXaFGfZQ66Ag0g3+qA16qlWeyKj2u5U5HqKUf2TmyXopRFwZnG4GEwkn1c0Q4So++EgOze26H9Vqn9sDZ4wNjUQwhhOMm/eBdiJMtJ4fYyT4dJa1sVH355CNvRiHRQiA41uUGBPNJKsyKHnixPSL3sMF5JCJujS8+ia0wr8cNuDlu9JxTnskMbTjuas5i5RTWWnlQVyo42sFdTOCaCMU0tP2PErQZsSuTBwjahOpPmcGqS8zHaMIqaM17ID/ATBd2+is2TFTzeYtZJkOT8G+1hN8dESO47Pjir/vGUfi31S1Zp9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQ+lddYVIVTyHUZJvwGaDUPTBiw80FboOA1+/NRIf+w=;
 b=bo6BHxZ3gwx/mzt9i3tCJELUzCMsZQ6FHagVwkNF1TE8Pn/mKPo0eg/a1aV+nUUy6017G2M73t80EPGuCQyC676KLacib47y0hw6d3EkeQiDzULx15UFOc5UL6IVsKXEoeV6TbhUcXptt9JuJMBKKJGScSHdmsY41UnnOejyfmk=
Received: from MW4PR03CA0108.namprd03.prod.outlook.com (2603:10b6:303:b7::23)
 by CH2PR12MB4922.namprd12.prod.outlook.com (2603:10b6:610:65::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21; Thu, 31 Aug
 2023 16:29:32 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:303:b7:cafe::f) by MW4PR03CA0108.outlook.office365.com
 (2603:10b6:303:b7::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20 via Frontend
 Transport; Thu, 31 Aug 2023 16:29:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Thu, 31 Aug 2023 16:29:31 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 31 Aug
 2023 11:29:31 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 31 Aug
 2023 11:29:30 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 31 Aug 2023 11:29:29 -0500
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: <qemu-devel@nongnu.org>
CC: <frasse.iglesias@gmail.com>, <alistair@alistair23.me>,
 <edgar.iglesias@gmail.com>, <peter.maydell@linaro.org>, <fkonrad@amd.com>,
 <sai.pavan.boddu@amd.com>, <tong.ho@amd.com>, <vikram.garhwal@amd.com>
Subject: [PATCH v4 7/8] hw/arm/xlnx-versal: Connect the CFU_APB,
 CFU_FDRO and CFU_SFR
Date: Thu, 31 Aug 2023 18:29:18 +0200
Message-ID: <20230831162919.30472-3-francisco.iglesias@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831162919.30472-1-francisco.iglesias@amd.com>
References: <20230831162919.30472-1-francisco.iglesias@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|CH2PR12MB4922:EE_
X-MS-Office365-Filtering-Correlation-Id: ee47af32-61e1-421f-f24c-08dbaa3f74a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8vNpfCYNSPwwIaW4fqxOXVQrs+SYZ9X/XGgrYnnHBk1K8DIqB9lzOpY2ufzX4SLHEc/0qOg5ncgru7X9ijBmQFnabONbMYno1MMT8TCgCE724IwAZfO59UWRE4nl94CLsiHMnpXc81SuomwCw6Uc4aJjusVQhsAK9/hgvFX6Y1MoiqtsO76ETXoscXpVyohJGek+RLXF8SNN3L+PdD4wGzHUZStN2k/BlJ3aX079BGZHbfOHkZBMgI3uZ6tqlopICjUNYxxR7XMnPmxUJnste40u8c2vjPUQVt7wt+nKH1MHskT/zbRXkgaULkIVBFLzXYZEt0hnEJGX4Qkuv6ZgzONKBFvmCP2sssIqYHjJwQa+EpgkAOefEXw8QA5HlBVxYJ1yalUrOZpvNNcLkbkX1S0lmCEXI/oGGFXYvb9pxElmdosK4i4dB3c1f3/3gh5MBWCqgiQ+vlSNTeqRiAJnDHwTofSIrDmzpNzZRv9VXgXuP6ya8AL4tqkQ0+uDoU2rRdMQEap7jOxI/zQv1nVnesQR34o4oAdL5TT7hVetkefqnplMbzc8uksfDjSf0CGvwK/kHxRUJupgiQOokPraO/whNW80ordcZ4NYKcIyEcuYDak3PAZx+M9NQBOh6rzBJDnDtwcHKczH9EWH2TqjlnozngViIwY497W388wgeNarPSwHxSCWot7PiN1Mt2nMP4mNEbpPH89V99H6xa+9NMAI2WycYs9PNRMX13FKTE0cq+ZRWjQQ18st5gDdeYiOJOFj0cKF0YP8rZsZZ7JIeA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(82310400011)(1800799009)(451199024)(186009)(36840700001)(40470700004)(46966006)(356005)(82740400003)(6666004)(36756003)(40460700003)(81166007)(86362001)(40480700001)(47076005)(36860700001)(1076003)(2616005)(2906002)(426003)(336012)(26005)(478600001)(70586007)(70206006)(4326008)(8936002)(8676002)(54906003)(5660300002)(6916009)(44832011)(41300700001)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 16:29:31.8319 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee47af32-61e1-421f-f24c-08dbaa3f74a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4922
Received-SPF: softfail client-ip=2a01:111:f400:7eae::600;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
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

Connect the Configuration Frame Unit (CFU_APB, CFU_FDRO and CFU_SFR) to
the Versal machine.

Signed-off-by: Francisco Iglesias <francisco.iglesias@amd.com>
Acked-by: Edgar E. Iglesias <edgar@zeroasic.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/xlnx-versal.c         | 42 ++++++++++++++++++++++++++++++++++++
 include/hw/arm/xlnx-versal.h | 16 ++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 60bf5fe657..3f4b4b1560 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -570,6 +570,47 @@ static void versal_create_ospi(Versal *s, qemu_irq *pic)
     qdev_connect_gpio_out(orgate, 0, pic[VERSAL_OSPI_IRQ]);
 }
 
+static void versal_create_cfu(Versal *s, qemu_irq *pic)
+{
+    SysBusDevice *sbd;
+
+    /* CFU FDRO */
+    object_initialize_child(OBJECT(s), "cfu-fdro", &s->pmc.cfu_fdro,
+                            TYPE_XLNX_VERSAL_CFU_FDRO);
+    sbd = SYS_BUS_DEVICE(&s->pmc.cfu_fdro);
+
+    sysbus_realize(sbd, &error_fatal);
+    memory_region_add_subregion(&s->mr_ps, MM_PMC_CFU_FDRO,
+                                sysbus_mmio_get_region(sbd, 0));
+
+    /* CFU APB */
+    object_initialize_child(OBJECT(s), "cfu-apb", &s->pmc.cfu_apb,
+                            TYPE_XLNX_VERSAL_CFU_APB);
+    sbd = SYS_BUS_DEVICE(&s->pmc.cfu_apb);
+
+    sysbus_realize(sbd, &error_fatal);
+    memory_region_add_subregion(&s->mr_ps, MM_PMC_CFU_APB,
+                                sysbus_mmio_get_region(sbd, 0));
+    memory_region_add_subregion(&s->mr_ps, MM_PMC_CFU_STREAM,
+                                sysbus_mmio_get_region(sbd, 1));
+    memory_region_add_subregion(&s->mr_ps, MM_PMC_CFU_STREAM_2,
+                                sysbus_mmio_get_region(sbd, 2));
+    sysbus_connect_irq(sbd, 0, pic[VERSAL_CFU_IRQ_0]);
+
+    /* CFU SFR */
+    object_initialize_child(OBJECT(s), "cfu-sfr", &s->pmc.cfu_sfr,
+                            TYPE_XLNX_VERSAL_CFU_SFR);
+
+    sbd = SYS_BUS_DEVICE(&s->pmc.cfu_sfr);
+
+    object_property_set_link(OBJECT(&s->pmc.cfu_sfr),
+                            "cfu", OBJECT(&s->pmc.cfu_apb), &error_abort);
+
+    sysbus_realize(sbd, &error_fatal);
+    memory_region_add_subregion(&s->mr_ps, MM_PMC_CFU_SFR,
+                                sysbus_mmio_get_region(sbd, 0));
+}
+
 static void versal_create_crl(Versal *s, qemu_irq *pic)
 {
     SysBusDevice *sbd;
@@ -763,6 +804,7 @@ static void versal_realize(DeviceState *dev, Error **errp)
     versal_create_pmc_iou_slcr(s, pic);
     versal_create_ospi(s, pic);
     versal_create_crl(s, pic);
+    versal_create_cfu(s, pic);
     versal_map_ddr(s);
     versal_unimp(s);
 
diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index 39ee31185c..29b9c60301 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -32,6 +32,7 @@
 #include "hw/misc/xlnx-versal-crl.h"
 #include "hw/misc/xlnx-versal-pmc-iou-slcr.h"
 #include "hw/net/xlnx-versal-canfd.h"
+#include "hw/misc/xlnx-versal-cfu.h"
 
 #define TYPE_XLNX_VERSAL "xlnx-versal"
 OBJECT_DECLARE_SIMPLE_TYPE(Versal, XLNX_VERSAL)
@@ -117,6 +118,9 @@ struct Versal {
         XlnxEFuse efuse;
         XlnxVersalEFuseCtrl efuse_ctrl;
         XlnxVersalEFuseCache efuse_cache;
+        XlnxVersalCFUAPB cfu_apb;
+        XlnxVersalCFUFDRO cfu_fdro;
+        XlnxVersalCFUSFR cfu_sfr;
 
         OrIRQState apb_irq_orgate;
     } pmc;
@@ -147,6 +151,7 @@ struct Versal {
 #define VERSAL_GEM1_WAKE_IRQ_0     59
 #define VERSAL_ADMA_IRQ_0          60
 #define VERSAL_XRAM_IRQ_0          79
+#define VERSAL_CFU_IRQ_0           120
 #define VERSAL_PMC_APB_IRQ         121
 #define VERSAL_OSPI_IRQ            124
 #define VERSAL_SD0_IRQ_0           126
@@ -240,6 +245,17 @@ struct Versal {
 #define MM_PMC_EFUSE_CACHE          0xf1250000
 #define MM_PMC_EFUSE_CACHE_SIZE     0x00C00
 
+#define MM_PMC_CFU_APB              0xf12b0000
+#define MM_PMC_CFU_APB_SIZE         0x10000
+#define MM_PMC_CFU_STREAM           0xf12c0000
+#define MM_PMC_CFU_STREAM_SIZE      0x1000
+#define MM_PMC_CFU_SFR              0xf12c1000
+#define MM_PMC_CFU_SFR_SIZE         0x1000
+#define MM_PMC_CFU_FDRO             0xf12c2000
+#define MM_PMC_CFU_FDRO_SIZE        0x1000
+#define MM_PMC_CFU_STREAM_2         0xf1f80000
+#define MM_PMC_CFU_STREAM_2_SIZE    0x40000
+
 #define MM_PMC_CRP                  0xf1260000U
 #define MM_PMC_CRP_SIZE             0x10000
 #define MM_PMC_RTC                  0xf12a0000
-- 
2.34.1


