Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E247CCC59
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 21:33:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qspns-0006vt-JT; Tue, 17 Oct 2023 15:32:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tong.ho@amd.com>)
 id 1qspnn-0006t2-KV; Tue, 17 Oct 2023 15:32:27 -0400
Received: from mail-mw2nam10on20627.outbound.protection.outlook.com
 ([2a01:111:f400:7e89::627]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tong.ho@amd.com>)
 id 1qspnl-0006nC-G4; Tue, 17 Oct 2023 15:32:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OvxEOTSml7Cua+2fUDOVB3AKencfGWlRzMUbcjfKrahfrxKd0ZboSyx7GWmhWiYGNc/b5AmG8kKHUyRPKOF3ZYoSXNl9RRTb+JmveVtwotVR+FctaZtuwI4idP83vXqB0pSqAAY9tGVCJv9LjjDmVnSHzR6At/5Yu9lM5yadD+J412K/8KwiH4JJL2Yo42k5Hht6BZQRuw+NJUb4MltoxzFFoOLSSQb0CYmo4LupNLl50jENBC4JHk+/2063XyYRbqSTWY+XYMays2R/oaLCHveVIdApnxt5DqyINUiVzYE6op0yutPb44De9W1Hqx6vhnlRu+WlhLAvoOfz8REYRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zdVXyil0s86cuUklP3SIRnzO9twBpd5wp6HImWSvSAI=;
 b=n3TOZ3Sj92wU1aT/byq8oL6HyadNAnnvI3FEAJp9pRwiQxOth/hDSD4jJhpg01+aaSMDzmSB14d+4ow0VpQEEKkbyrh8JF0jWbl2PzDX56ewXS8yVXIC6KR0Xa85fN5tZLOYXnqDptVmdFsm+kxBHOlr6Mc4DOf5ck3kSCv9rFhfWMFgT0iiuBTMXVJM/173+3L5dcv/9KWgAbIqr8w9e1Vr39y3WX2rPBErnRqzxpyn1YqHsX+1X01w/f8ohxgu3LjHaNvywl0nDg1Nm8zptY6xEED65lyP52kvpn7neISL8EMc1jGG8YBXuk73XmOByoRypW58FO89oVXDRCLtQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdVXyil0s86cuUklP3SIRnzO9twBpd5wp6HImWSvSAI=;
 b=RnyinruSIdgssE1847M+Grz7kBu2Kmcq7NIUkSoi9GPBIZt15zGhDfj79h9M9DXT3tZh4mi6Zi9d3ZsZViM6L/eXMOvyPc1CpF8h/tUcMh87j/jkzbRGGaF9Uf4LO+4C7pglDbEL9msu7g7Gl+TES17+KguAssX8D596GAfpFS4=
Received: from CY8PR11CA0045.namprd11.prod.outlook.com (2603:10b6:930:4a::28)
 by PH0PR12MB5418.namprd12.prod.outlook.com (2603:10b6:510:e5::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Tue, 17 Oct
 2023 19:32:21 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:930:4a:cafe::99) by CY8PR11CA0045.outlook.office365.com
 (2603:10b6:930:4a::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
 Transport; Tue, 17 Oct 2023 19:32:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.23 via Frontend Transport; Tue, 17 Oct 2023 19:32:20 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 17 Oct
 2023 14:32:19 -0500
Received: from xsjtongh40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 17 Oct 2023 14:32:19 -0500
From: Tong Ho <tong.ho@amd.com>
To: <qemu-arm@nongnu.org>
CC: <qemu-devel@nongnu.org>, <alistair@alistair23.me>,
 <edgar.iglesias@gmail.com>, <peter.maydell@linaro.org>,
 <richard.henderson@linaro.org>, <frasse.iglesias@gmail.com>,
 <tong.ho@amd.com>
Subject: [PATCH v4 2/3] hw/arm: xlnx-versal-virt: Add AMD/Xilinx TRNG device
Date: Tue, 17 Oct 2023 12:32:16 -0700
Message-ID: <20231017193217.1512868-3-tong.ho@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231017193217.1512868-1-tong.ho@amd.com>
References: <20231017193217.1512868-1-tong.ho@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|PH0PR12MB5418:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fd5c5b8-793b-4819-122b-08dbcf47c823
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OqrB30KTA689ouwGfaas0Iwo72b0Snlac0EfUkwcANOEU/wrbI1ek4cdkSKyT3q3wrNMHJ02cjITsRPywadkkZMtRRilri46OXkMjHsMrMC6MbhCzxk43T9Qk4kFTZAvqWDjFGlL8kjdK9Iy6moy3amtLFzZai3b3Jp6kaJbwZ9MQ3Am/XekLVvjIP/MJESieY/M8hErEI5ZnOgIHyJ3h1mFPb2g7DEi9+YZ/BPLer33IhBOsdg5k1M3ZFHMnCcNw0+naLdXlSBAcoh5bsWHZKhWLiuAeGuo46KKdl94o1K60MQPZ9bVvoJK1MtHUJ3nK/FYGMA9TVoSDfqeEwMg0xm9dCDwJ0QGZInYqEoufR0JFP7qvKBQD57I1DmDYs6Ynu4UZg5bkgLySDfx7sCg5Z4TrhwyBjNlGk5uMZU+gCq0y+pPipJwsLVfqPikph4dGPwzW+1fticcdJ1CCyt5Wd/iexhBRqLYTyt2Bajom77nlo8PJkAfgcDbY5BCoS4Ia7oQX2STQtdMz0F7mvGEmZmoY5yMNh9FMua041+7P77aBzADeagHUcWbhaoL+Qh2bNiMj+80MPFuGiCu4vvC2BQklBPrb3m7jBZhgiOxhBmrHSTh1bTNu1rTFBwsUHCatNeag1O+itaFANwdmALNAjG51AjUa5RGXnJYXdVLbEkbzwMoLhluDgtCOWYgfZXFJxsBbnb11No1w5Zb3JobUoZpAZAA9OChcza/+JXcgdmYmsD6+ljZbgghchqs4+lLFQNsH2FniykdQX1nCNXhNQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(376002)(136003)(396003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(82310400011)(36840700001)(46966006)(40470700004)(86362001)(40480700001)(82740400003)(36756003)(40460700003)(478600001)(6916009)(5660300002)(70586007)(316002)(54906003)(70206006)(81166007)(356005)(6666004)(36860700001)(47076005)(26005)(426003)(336012)(1076003)(2616005)(4326008)(8936002)(44832011)(83380400001)(8676002)(2906002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 19:32:20.9488 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fd5c5b8-793b-4819-122b-08dbcf47c823
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5418
Received-SPF: softfail client-ip=2a01:111:f400:7e89::627;
 envelope-from=tong.ho@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
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


