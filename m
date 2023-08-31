Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F7478F194
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 18:58:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbkzE-0001ab-58; Thu, 31 Aug 2023 12:57:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1qbkyw-0001CY-Ef
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 12:57:26 -0400
Received: from mail-dm6nam10on2062d.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::62d]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1qbkyt-0003eC-GK
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 12:57:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k23xFMeO+KWHSKASgeOf6zADu1KfhSR7mlv9+mHYougZIwr/iZF0zsYbuUq74O/sHRc4uFCQP7VXilzOgFHMf8hfO2O4+V4tHeEdU9SCJrkHIjRucCLljceClbE+IaB9ecJmAW/UyV7j+SbmUr0DStn0kw6bSycaqldSuqfRNdZ7j4bXWRlhxLUZkwSROOZYxujGMHSUurfC854p6f8I6I0dUBFVf/Y2p2GDg9Rom6ZJw8/20l1CfqBN0f2FF3EIrHr3CkKJFqV0N5iNt94vgAqMyldB35awXiXKoUNZtQ4o3ry0tYfJjg7kFzD1N7V19UanIL8V4SOaGnDZfGUUkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQ+lddYVIVTyHUZJvwGaDUPTBiw80FboOA1+/NRIf+w=;
 b=Hw0XeprpEWioFeL+Ho28IejXfKoJSAma/ukqWWYnYvlS7TEDYG9WEKCHg5UbcRTbBbjTRuHeWKqxZTEWlDKwh12Ttu56tmdw1Mbc9wbBdXsvMgHSKC7FESpZNtvgF5neCNztgw7ahY9LfYYN7/YCRRGBm/QfqALGXnvLdKWxVx7slShoS4G6AX5EXAsHyr8eDvyZ6sc+KH0AUh9JnfK+zNeRnHRqcF5O0xEPUByscymEOfLERwrR6LnbXHfJGfu3aXL2CHOSVc51/vMauO0h74zmQBuCHFBdmDk18wihh1zDZHc1FbDOmPXbazpJT5J5rA6YZ86WOZrvGhwrIoLyLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQ+lddYVIVTyHUZJvwGaDUPTBiw80FboOA1+/NRIf+w=;
 b=sIGfbxeiKhdRYecFTaBtjnIMJLfQdoiPHQF855JSPSpUJLY4Xx/E/2jQ4rOvZ1Xg40PU3E1LfK/7QRJdukzd5UduWLCbMy7iHq8PuZEwwNJrF10keipzkrPaQhVWcfQOBOE07qQucNy7Yr9HXpGyxJaDdAo41RKC27y3xsY9yQU=
Received: from CY5PR22CA0005.namprd22.prod.outlook.com (2603:10b6:930:16::28)
 by IA1PR12MB6412.namprd12.prod.outlook.com (2603:10b6:208:3af::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21; Thu, 31 Aug
 2023 16:57:15 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:930:16:cafe::8b) by CY5PR22CA0005.outlook.office365.com
 (2603:10b6:930:16::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20 via Frontend
 Transport; Thu, 31 Aug 2023 16:57:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Thu, 31 Aug 2023 16:57:14 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 31 Aug
 2023 11:57:13 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 31 Aug
 2023 11:57:12 -0500
Received: from xdcsswbld02.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 31 Aug 2023 11:57:11 -0500
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: <qemu-devel@nongnu.org>
CC: <frasse.iglesias@gmail.com>, <alistair@alistair23.me>,
 <edgar.iglesias@gmail.com>, <peter.maydell@linaro.org>, <fkonrad@amd.com>,
 <sai.pavan.boddu@amd.com>, <tong.ho@amd.com>, <vikram.garhwal@amd.com>
Subject: [PATCH v5 7/8] hw/arm/xlnx-versal: Connect the CFU_APB,
 CFU_FDRO and CFU_SFR
Date: Thu, 31 Aug 2023 17:57:00 +0100
Message-ID: <20230831165701.2016397-8-francisco.iglesias@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230831165701.2016397-1-francisco.iglesias@amd.com>
References: <20230831165701.2016397-1-francisco.iglesias@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|IA1PR12MB6412:EE_
X-MS-Office365-Filtering-Correlation-Id: 47386498-06a3-4634-93c6-08dbaa43539e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CbhDUaCfd0tgatXkYM58r30LtzmC7Cp+rOfMAmnJh6SWcOmLBSJgi/+E8HFFiK2KdfQX/BfBsuMLqYy8w45SakTd/cLMkBgsf7PGXdREBHSkEXDDERBc308WfwdMSXSMovMlehN9BRBn3Xq4M/h6ffbcyjuSUCGA3dkJc2XfYwsj7Fr98z28EP22X5wdlV7x3JDHYck2FcVFhxiTVmBXiyktGmpdzLfqmQ+M/KT5SZvAQHADmZTT1KSJMhHM+bkr6Ya4SflBgBfgNDLRMfLoGcN+8Y3ooQ4cbAPJ4sP+XKDcM8xprSNsY66gSHAK1A9eLREU9OAUshlpJevOhYahfL+FNZM5aGaDvlVcgn3w9G0rH/bvNWiOgOcWyc84BhSlGvmPyM7aQFgIhXpTPJkFxabY96YNBYlspf0l8b3gGeMJDShq9tc6a4iwxlxujh+F0Lj1u9r42YD+ajVmwVVDhw385FKkB/rQnRvovT99XXOKgoC/PefsZEXYmwWZFgdte7AD8ZllhpqeeNVX9ZDwBLXOEBC+vjr2ea9gXpAsoLTe0GzNQlCGO2PXKWwi2s6HNeVF1voVO48NxfRQKwBRCtepaAFxKE/LGuSGK29/db3Hngvb4TTe4aLAY0y4qQmsH1WIptTx1/thapkizv5TPbkgiDXmKhxdItOIJxWuT84gk19uSLDWsN/UqhS8eW8Bz/xYvvqOSTJ3lf2FF/YQXQ4bwePzdwvaYS09I2dO9R50eYD4xJPmcyRlef/ma0rcjvIOz2t/1uhk640p87MpnQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(376002)(39860400002)(136003)(82310400011)(451199024)(1800799009)(186009)(46966006)(36840700001)(40470700004)(6666004)(478600001)(2906002)(1076003)(2616005)(336012)(426003)(26005)(316002)(6916009)(41300700001)(44832011)(54906003)(70206006)(70586007)(5660300002)(4326008)(8676002)(8936002)(36756003)(40460700003)(40480700001)(47076005)(86362001)(36860700001)(81166007)(82740400003)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 16:57:14.4551 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47386498-06a3-4634-93c6-08dbaa43539e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6412
Received-SPF: softfail client-ip=2a01:111:f400:7e88::62d;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
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


