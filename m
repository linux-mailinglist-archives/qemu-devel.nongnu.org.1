Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AFF7B824F
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 16:29:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo2rG-0000Q9-DG; Wed, 04 Oct 2023 10:28:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tong.ho@amd.com>)
 id 1qo2rB-0000Ng-K4; Wed, 04 Oct 2023 10:28:09 -0400
Received: from mail-co1nam11on20611.outbound.protection.outlook.com
 ([2a01:111:f400:7eab::611]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tong.ho@amd.com>)
 id 1qo2r2-0000JM-K1; Wed, 04 Oct 2023 10:28:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UgayAg+w03fJ0QOLIQIInIR1vUlglb/+dTn6XnXwdX0QUTMS1niU2Lfk6SEF83cb6mJLq1kNhODARERaY0nkRrFStGRH2j/cjHixmdoRwa/z+UbXePiRjQyFTn5Fb5YYBxIPX77MnrL7Q1l8eXbbq2WQL2Up/lFGLKN+XBpA83toYwSAE1IoUqVxkDsy2mqnn58CvRwtVUK/uwbOjJPRhUBf8881AadLUWmSDvR3lPDQCykdSqZf+lagqARTKXuJSmvj5gACeZExEEyYhH7z0PsQn1qHWCVHoLN5T5bU34B+NHqs9UgCOLuqm3tdmV4R5hECvQoaPJMLwyKXvqf0GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zdVXyil0s86cuUklP3SIRnzO9twBpd5wp6HImWSvSAI=;
 b=IXkrs8N6yq4fGLsulskKWiEdavgXXx4371Fi7sCliylqS78BM37UalqV9YNbmCkG04mk9PGPDu3l2+PRjE+H2xO02jNsdeuQ96RwcgL0Xg6v7f7PvGTgHbrIjT+EhhmlHoLI4l2zNQVp9pvTFnDwTyuZphzoKacIbA9WW0Ru3tNX6j+WrV/iZys/PFH3evUHVDrHVI0yKgPeFwccM7ABqwyFHP9EwAZYEnQcxsciLA8HGjwursQxx3ivMq9jMfD/X2NGjjoCwY3qvWXUpvG8J2etobQn9c6fVesY+PkW32b75XgBvovBDAPZn2Gc/adxOdfnZ7nsEHJgqduomNnSeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdVXyil0s86cuUklP3SIRnzO9twBpd5wp6HImWSvSAI=;
 b=YSP0q3dSgU6deD5HwazIRO+Omc+GamkMXsSjiF9bVISViKyMk7vW9hn58MKXB7/MpE7RUUP1ZWCFZtNDZrKcIObDwbP1v+uWp1MEruQKF7F/gSrYyR/T3OEZ1xuSkDXq2OYvJlVlzHoHUua0J5A03IncJHG3phcnUM6frhgZ5eo=
Received: from CH0PR03CA0241.namprd03.prod.outlook.com (2603:10b6:610:e5::6)
 by BL1PR12MB5189.namprd12.prod.outlook.com (2603:10b6:208:308::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Wed, 4 Oct
 2023 14:27:53 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:610:e5:cafe::8d) by CH0PR03CA0241.outlook.office365.com
 (2603:10b6:610:e5::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31 via Frontend
 Transport; Wed, 4 Oct 2023 14:27:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 14:27:53 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 09:27:53 -0500
Received: from xsjtongh40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 4 Oct 2023 09:27:52 -0500
From: Tong Ho <tong.ho@amd.com>
To: <qemu-arm@nongnu.org>
CC: <qemu-devel@nongnu.org>, <alistair@alistair23.me>,
 <edgar.iglesias@gmail.com>, <peter.maydell@linaro.org>,
 <frasse.iglesias@gmail.com>, <tong.ho@amd.com>
Subject: [PATCH v3 2/3] hw/arm: xlnx-versal-virt: Add AMD/Xilinx TRNG device
Date: Wed, 4 Oct 2023 07:27:45 -0700
Message-ID: <20231004142746.350225-3-tong.ho@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231004142746.350225-1-tong.ho@amd.com>
References: <20231004142746.350225-1-tong.ho@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|BL1PR12MB5189:EE_
X-MS-Office365-Filtering-Correlation-Id: 57ff73ca-ef61-4df9-90e3-08dbc4e618ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PwFU6zwfrgC3Bpl2I1sB7P1GgDRYY0NNxbkKIEhKiEWXs8eszizbWQIRGpMk5IbDKa/Uh4eXK0kpTpckDQxD+t5c+i22L0VXLZoBDZn/qtx4chGMntDKl+YTrBYk5QkPH9NObpuvThchaH4plvabGn/XEDkZB5trLJHHd3lSjYk3C7PkuoFmWPWUOky0hAHNmG6r13H7KCctdfLA/zDwi1kQ8GXnsS6v6lAWTARq8/ubRWHarqxycIOu3EQm75sX5aupSHz3Lgw5yBn9YdXWa8DR0aG+Vxi9FTC3LwKtOSQkkKlFlqXLwcdpI/D3gLfcfdBzm0uX396BpcexpE1QsbR/sYb9rblJgSQ+7FIpzrlBw4haXS4FtqB2XYLruP/e1rl++iRguL4uISKHq9kujHfbMz+RuKDl145ggBXU16NMPbZd7uCmpJDVJpN2/S4YcO4sBEwOLNe9SyRYAgFHlY5xmlIy4UeKkKov4wptpvivt45EYy5Zn6MpOhJiR49Ad0DEcXg3HZ9+WKe4hiKTMNa0K23vTQHyttbhy+OSqw1mMvYN115HZ0y/J+BLa2v0jMjKC2GiHrCRBcwec3g9uo79WVvilpomFPEvuVviWAxDYVsVOZio1Ni9h5GIejugUKC8yNIseYngDxb3SYkrj3gCEcOFzMiH5gmts8a9dO+Uv7TP6jotW8FxkUgJsIbiBNcfOX5eekwrcQ4gR6ACE6dWLXaAfaZGAXGpRTEPSZ75yJctV2948Jx2VxuEf5lsNmyz9gNmP24smzz32f4t8w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(346002)(136003)(39860400002)(230922051799003)(64100799003)(1800799009)(82310400011)(186009)(451199024)(36840700001)(40470700004)(46966006)(2616005)(6666004)(478600001)(426003)(83380400001)(1076003)(41300700001)(2906002)(26005)(4326008)(70586007)(316002)(6916009)(44832011)(54906003)(5660300002)(8676002)(8936002)(36756003)(70206006)(36860700001)(47076005)(86362001)(81166007)(336012)(356005)(82740400003)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 14:27:53.7760 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57ff73ca-ef61-4df9-90e3-08dbc4e618ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5189
Received-SPF: softfail client-ip=2a01:111:f400:7eab::611;
 envelope-from=tong.ho@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
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

Connect the support for Versal True Random Number Generator
(TRNG) device.

Warning: unlike the TRNG component in a real device from the
Versal device familiy, the connected TRNG model is not of
cryptographic grade and is not intended for use cases when
cryptograpically strong TRNG is needed.

Signed-off-by: Tong Ho <tong.ho@amd.com>
---
 hw/arm/Kconfig               |  1 +
 hw/arm/xlnx-versal.c         | 16 ++++++++++++++++
 include/hw/arm/xlnx-versal.h |  5 +++++
 3 files changed, 22 insertions(+)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 7e68348440..0a3ff6748d 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -482,6 +482,7 @@ config XLNX_VERSAL
     select XLNX_BBRAM
     select XLNX_EFUSE_VERSAL
     select XLNX_USB_SUBSYS
+    select XLNX_VERSAL_TRNG
 
 config NPCM7XX
     bool
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index fa556d8764..4f74a64a0d 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -373,6 +373,21 @@ static void versal_create_rtc(Versal *s, qemu_irq *pic)
                        qdev_get_gpio_in(DEVICE(&s->pmc.apb_irq_orgate), 0));
 }
 
+static void versal_create_trng(Versal *s, qemu_irq *pic)
+{
+    SysBusDevice *sbd;
+    MemoryRegion *mr;
+
+    object_initialize_child(OBJECT(s), "trng", &s->pmc.trng,
+                            TYPE_XLNX_VERSAL_TRNG);
+    sbd = SYS_BUS_DEVICE(&s->pmc.trng);
+    sysbus_realize(sbd, &error_fatal);
+
+    mr = sysbus_mmio_get_region(sbd, 0);
+    memory_region_add_subregion(&s->mr_ps, MM_PMC_TRNG, mr);
+    sysbus_connect_irq(sbd, 0, pic[VERSAL_TRNG_IRQ]);
+}
+
 static void versal_create_xrams(Versal *s, qemu_irq *pic)
 {
     int nr_xrams = ARRAY_SIZE(s->lpd.xram.ctrl);
@@ -909,6 +924,7 @@ static void versal_realize(DeviceState *dev, Error **errp)
     versal_create_sds(s, pic);
     versal_create_pmc_apb_irq_orgate(s, pic);
     versal_create_rtc(s, pic);
+    versal_create_trng(s, pic);
     versal_create_xrams(s, pic);
     versal_create_bbram(s, pic);
     versal_create_efuse(s, pic);
diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index 7b419f88c2..54f4b98d9d 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -31,6 +31,7 @@
 #include "hw/dma/xlnx_csu_dma.h"
 #include "hw/misc/xlnx-versal-crl.h"
 #include "hw/misc/xlnx-versal-pmc-iou-slcr.h"
+#include "hw/misc/xlnx-versal-trng.h"
 #include "hw/net/xlnx-versal-canfd.h"
 #include "hw/misc/xlnx-versal-cfu.h"
 #include "hw/misc/xlnx-versal-cframe-reg.h"
@@ -116,6 +117,7 @@ struct Versal {
         } iou;
 
         XlnxZynqMPRTC rtc;
+        XlnxVersalTRng trng;
         XlnxBBRam bbram;
         XlnxEFuse efuse;
         XlnxVersalEFuseCtrl efuse_ctrl;
@@ -160,6 +162,7 @@ struct Versal {
 #define VERSAL_OSPI_IRQ            124
 #define VERSAL_SD0_IRQ_0           126
 #define VERSAL_EFUSE_IRQ           139
+#define VERSAL_TRNG_IRQ            141
 #define VERSAL_RTC_ALARM_IRQ       142
 #define VERSAL_RTC_SECONDS_IRQ     143
 
@@ -329,4 +332,6 @@ struct Versal {
 #define MM_PMC_CRP_SIZE             0x10000
 #define MM_PMC_RTC                  0xf12a0000
 #define MM_PMC_RTC_SIZE             0x10000
+#define MM_PMC_TRNG                 0xf1230000
+#define MM_PMC_TRNG_SIZE            0x10000
 #endif
-- 
2.25.1


