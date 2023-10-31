Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C65217DD645
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 19:47:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxtlQ-0005Lt-FF; Tue, 31 Oct 2023 14:46:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tong.ho@amd.com>)
 id 1qxtl7-0005Fz-S9; Tue, 31 Oct 2023 14:46:38 -0400
Received: from mail-mw2nam04on20621.outbound.protection.outlook.com
 ([2a01:111:f400:7e8c::621]
 helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tong.ho@amd.com>)
 id 1qxtl5-0003lj-A8; Tue, 31 Oct 2023 14:46:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gpswE2u/f7nFYmBu92mCyxM0BGZiSklEHyDDFMvqwrJ8jw5MQQrRaeqa/pLbuigf+tneBgE2l/a/SMz9NpVl/u1CJyIMSf1fwufXyQoTCRhtHEb360MiZULJvNXjzE/iy1VTDj6oTnoMMeXxi8zx8ZI6FDQjOTjvSL8d06rEvk3nU867R9Hd/C8hhVAPMmvpG/2R8bJNBB3qVoY3zVuhV5B3tRyuECentS3FO4D2bKdwYJ0igfNz7FaWnO8Yz6/UNpJhX8yBK71PfDiEa6UVUpUSrgEJBrXfjKW2DZ8tyKKgdMqy8XwxuqI3Th7yDssv/XXZ23uzU7tKgRUWWvTu0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cAr02EfUi3LX/xsAOsil341EpjuT96nH8CQzJSq4yZY=;
 b=gYchObbk54N/UUc7fM4IRVckDr1dyHzkyETKf3UYXZO4RTp/z/pmSP1Y9Pd570GwXlvEPgvoq8oyuQleguE7+mCAWmaH5Fp96Q+2F7KLTpgFjAt/nSIHdCnihGg4iEgiHCPehm5xjEBkj5sySDNw+9GAkkYDHHFdQ9Zdnc6IlEciycZG+Mg2STL/Hb7I1CeQch0Yp+bsltWmU8adZxCGlHJoKw9yF+d8sq+C2jiCWPoclDOCvvR4tjH7qmQKWsWX674uabSg5vgNPBEJ3SriCsPpjKHloEuxrYEtLzFIr2Swh93KmciOXompMItWngFVeREoMZsgOlQjOoWtwy72lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cAr02EfUi3LX/xsAOsil341EpjuT96nH8CQzJSq4yZY=;
 b=fVOeymp7FMOYE9QmTijVrCJfSslii3J5oOfhOaJ2FMkeeS6BWIoXYCLdimT5/WZk5CuwZoEslOL7hmi3W4e/BceuykYkY/duT3ToFH/2LBz7JHKov3ji+h9zZjQB1+9eDD1BzVg9Qapwjj02Vm9pZ3rDWBvn8vUq1hRNE/yhFD8=
Received: from MW4PR02CA0002.namprd02.prod.outlook.com (2603:10b6:303:16d::10)
 by CH0PR12MB5171.namprd12.prod.outlook.com (2603:10b6:610:ba::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Tue, 31 Oct
 2023 18:46:29 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:303:16d:cafe::c) by MW4PR02CA0002.outlook.office365.com
 (2603:10b6:303:16d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29 via Frontend
 Transport; Tue, 31 Oct 2023 18:46:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Tue, 31 Oct 2023 18:46:23 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 31 Oct
 2023 13:46:19 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 31 Oct
 2023 11:46:19 -0700
Received: from xsjtongh40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Tue, 31 Oct 2023 13:46:18 -0500
From: Tong Ho <tong.ho@amd.com>
To: <qemu-arm@nongnu.org>
CC: <qemu-devel@nongnu.org>, <alistair@alistair23.me>,
 <edgar.iglesias@gmail.com>, <peter.maydell@linaro.org>,
 <richard.henderson@linaro.org>, <frasse.iglesias@gmail.com>,
 <tong.ho@amd.com>
Subject: [PATCH v5 2/3] hw/arm: xlnx-versal-virt: Add AMD/Xilinx TRNG device
Date: Tue, 31 Oct 2023 11:46:10 -0700
Message-ID: <20231031184611.3029156-3-tong.ho@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231031184611.3029156-1-tong.ho@amd.com>
References: <20231031184611.3029156-1-tong.ho@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|CH0PR12MB5171:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bfedc09-768b-4896-17a8-08dbda41b0ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ThnQtIl9NB6WlzirLRQWUohKD4WS+WqgRAPvB8kintykfNNSTgFI712ghQULCS2d2dh8zb/3psADfT7NUaa260u1LVmM34KD8aydAvlTN8exsNRJlNz04efZlJ6HBHLxlHkmL9BTeiLKs8jv25Nbsi/3DFj2Xly5MK3vOSuqZ6AKnIkYN2rmK1EYjLsRw/q1glgaMxITy8JsjQSkpdaebIlESODcFYqaEMFIYpqNWtLwhF660DqizyonZe7hMymUfWpfvFAEtHXM6HQUEh+feTBzPhrOztrJ2ZjgvcSkxeEH2GFBZwfHoa4ipLOVn2TrhnRHPwMyI7uzU6GGEHbpQf6AAB19w9vgv0Nvb4OMXSaY7q10RdTjUu0re6IeuI5PUK/FILGFKING1OzGeZot13+XS1oZbdhJrdRGkMgSZTpvyX8YOS+VnF18lZNeo7b73Vy1Jl+T2p/58rL/f/I8lSS2i2ZmhtPeukTzFPqUV0sCJ0heCCDWnX9FNSRGQDI7wdF6CLmQit8bBun5vh+ug8g3HtlocyYqButYpcwu0jO1RZbG9ZjUnUOA5rjFaLDsTtUxRw6bopfg6gBTrfJPdG7tD2DyB0kptF3uqbXmRYWPLhfPRJHTmrvZh0VL4INcb+G9/wNcYr3d18UJRm8QeZeO9mHzm6z8hluxNh/W3cNB7VxpZrnDHrOv+DmZRGKum86aGuXXn/yWrOYl4cvb0UhOiLicjjH+uuzWk+UHCNI4vPVBizoONyQuV761EkKLYKJBDYnl6HeiERBcjdvS2FZqHXhwaLfjKPGTPn1t4KFxfj+ToBC1HCq3EF2njKNV
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(230273577357003)(230173577357003)(1800799009)(186009)(64100799003)(82310400011)(451199024)(40470700004)(46966006)(36840700001)(1076003)(26005)(40460700003)(86362001)(82740400003)(36756003)(40480700001)(356005)(81166007)(2616005)(4326008)(5660300002)(83380400001)(2906002)(478600001)(6666004)(36860700001)(47076005)(8676002)(54906003)(316002)(426003)(336012)(8936002)(6916009)(44832011)(70586007)(41300700001)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 18:46:23.3398 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bfedc09-768b-4896-17a8-08dbda41b0ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5171
Received-SPF: softfail client-ip=2a01:111:f400:7e8c::621;
 envelope-from=tong.ho@amd.com;
 helo=NAM04-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
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

Connect the support for Versal True Random Number Generator
(TRNG) device.

Warning: unlike the TRNG component in a real device from the
Versal device familiy, the connected TRNG model is not of
cryptographic grade and is not intended for use cases when
cryptograpically strong TRNG is needed.

Signed-off-by: Tong Ho <tong.ho@amd.com>
Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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
index b710d71fb0..b24fa64557 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -30,6 +30,7 @@
 #include "hw/dma/xlnx_csu_dma.h"
 #include "hw/misc/xlnx-versal-crl.h"
 #include "hw/misc/xlnx-versal-pmc-iou-slcr.h"
+#include "hw/misc/xlnx-versal-trng.h"
 #include "hw/net/xlnx-versal-canfd.h"
 #include "hw/misc/xlnx-versal-cfu.h"
 #include "hw/misc/xlnx-versal-cframe-reg.h"
@@ -115,6 +116,7 @@ struct Versal {
         } iou;
 
         XlnxZynqMPRTC rtc;
+        XlnxVersalTRng trng;
         XlnxBBRam bbram;
         XlnxEFuse efuse;
         XlnxVersalEFuseCtrl efuse_ctrl;
@@ -159,6 +161,7 @@ struct Versal {
 #define VERSAL_OSPI_IRQ            124
 #define VERSAL_SD0_IRQ_0           126
 #define VERSAL_EFUSE_IRQ           139
+#define VERSAL_TRNG_IRQ            141
 #define VERSAL_RTC_ALARM_IRQ       142
 #define VERSAL_RTC_SECONDS_IRQ     143
 
@@ -328,4 +331,6 @@ struct Versal {
 #define MM_PMC_CRP_SIZE             0x10000
 #define MM_PMC_RTC                  0xf12a0000
 #define MM_PMC_RTC_SIZE             0x10000
+#define MM_PMC_TRNG                 0xf1230000
+#define MM_PMC_TRNG_SIZE            0x10000
 #endif
-- 
2.25.1


