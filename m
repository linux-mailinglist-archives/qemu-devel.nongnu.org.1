Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 294787AA952
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 08:51:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qja09-00020U-7a; Fri, 22 Sep 2023 02:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tong.ho@amd.com>)
 id 1qjZzv-0001ze-Gc; Fri, 22 Sep 2023 02:50:43 -0400
Received: from mail-sn1nam02on2062c.outbound.protection.outlook.com
 ([2a01:111:f400:7ea9::62c]
 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tong.ho@amd.com>)
 id 1qjZzo-00046g-Nh; Fri, 22 Sep 2023 02:50:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N8KNyXKDWA5YWckaYXOBFm9qVjBqiqKvJyxRGzBuCrMD6Gric+SEi0w7/mg6bxlnVGvwAD2mbvXS2sO5FbDF71bUHLXVZcawCT3JY50s0G0J+DviFERs7L1HO4GBcV4rqLyWwiNFJEQHGsyvqw2rlMSiIKUffFUXu7Bqw8sURZIiuwcH1PZIqdrqI0+kHWNVShMW9Hqfi3t2f0fo5lSSxzfjjAa43v5EWTqsucg3eMypvW/6XzlelYVJ1qRDe+Ck2a8HRmHYbkXq+iATR1LbR4BcaMLnMBv9H1kae1mkMHG0PaRBQSoAxnuTZ0FmhN83+2Ku/GLXJYGdl4XrQmgfMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJeH2A5KXqVydfk0l7rw+MP01ExufkDrC9mmwP2Pet0=;
 b=VqklFI53SbX4qC9nv+eELZwN/akysP07XoWzwUwOTrVAbC+fQaIrvOm+3SBqYL3STJD8BhltFGuMsjAXTjM52KuzPcqZ3wbNmRzmP1Hesgve0iHb75T6Oj0j2MH50wb3u18wVicgZb0rI0/Rp8aBZPqZEmz8lRY3u04NzQua2giPVx8EHPCIPvCkB0HUACiJUqY11sYf0KymtAUSDA6lvGY3mX6sOOFrwgZxfOUDd7UEyo6X6oDajhXZQtoWwIVmihgS72JcCMIRuaG1UMhYHtLmy6P9R+ZCselL9etV2qSuT6SJDxIuKD6f+J6i1JSDCfG29gJPIzdfvq86NVi2bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJeH2A5KXqVydfk0l7rw+MP01ExufkDrC9mmwP2Pet0=;
 b=WNvG2QbImdtk0ORZvvsSJyDwyUG2SBUWJbYpB00sJcp5oA3pBxFvEhNJDVOBxO4FfAa9ED14ilwizmS/eMFnytsgOA+XjyPkg/1hLIPbIrM+EQ229/aCU57daGw1elylaOerTUE1f348x9q8myBoFuir5V4b9pvhaJFos3L3c04=
Received: from BL1PR13CA0323.namprd13.prod.outlook.com (2603:10b6:208:2c1::28)
 by PH7PR12MB7018.namprd12.prod.outlook.com (2603:10b6:510:1b8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Fri, 22 Sep
 2023 06:50:31 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:2c1:cafe::5d) by BL1PR13CA0323.outlook.office365.com
 (2603:10b6:208:2c1::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.12 via Frontend
 Transport; Fri, 22 Sep 2023 06:50:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Fri, 22 Sep 2023 06:50:31 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 22 Sep
 2023 01:50:24 -0500
Received: from xsjtongh40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 22 Sep 2023 01:50:24 -0500
From: Tong Ho <tong.ho@amd.com>
To: <qemu-arm@nongnu.org>
CC: <qemu-devel@nongnu.org>, <alistair@alistair23.me>,
 <edgar.iglesias@gmail.com>, <peter.maydell@linaro.org>,
 <richard.henderson@linaro.org>, <tong.ho@amd.com>
Subject: [PATCH v2 2/3] hw/arm: xlnx-versal-virt: Add AMD/Xilinx TRNG device
Date: Thu, 21 Sep 2023 23:50:09 -0700
Message-ID: <20230922065010.4071693-3-tong.ho@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230922065010.4071693-1-tong.ho@amd.com>
References: <20230922065010.4071693-1-tong.ho@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|PH7PR12MB7018:EE_
X-MS-Office365-Filtering-Correlation-Id: b90c16fc-851c-4f64-43f7-08dbbb3836be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rU4jYawrqn7OQFu22bw/Le1XWXW6kNLf3DN4VGVz2Mgo06uiTspMcloMW+RpCPj2X5bdZVDFaaBn1xeJzSwCZ8uqukXUMutADPITSHeI29clkoot6i9DUNu270FEWHm7g1TovwO4YKA73ZOeNLDdPJKCdjOeH5IAdbNhTwODrqbfyJheapOb97+qSbIP4JrxESHTiNJGhAbTd5fCFFJ+47xhmYZ7W/LmgvqezbKdzwg7QLnRa+9qGW7OFmLh9+P3omAy6DE8qiMk25AreEYTFIYI9QUDfthpxEbV8lHRoMO/zsWICIHuAQ6aVex46FeaN9tXir1sOQnp1Tp4Cr/MuR5YK9RqIkEce/8zqUWnW1tfeENKScLMEjZYypNhCWS52KuqR70uPOlX5TtAIjXX9oORvRfEteNAzt3kn0y4RVewsmpLxcth1CFOpjSDcQDYTLvhRylDP1oMWDDISwiZIfmTWMaor6hhBs03wNi7PHwircJoYR1n9RNxljetYmQX2AU8uITN9RLbKDcTBgtDHD3BxRm8kAailzpCTGwtQvxHhfJvgSG3nzesVhxOrr4G96Al35lMzmyLPWhXSp4bz3SBsWjKR7JlsIGBEmI66ORZNDrr0kRcxgU0GPt4YDvwH1jbBvDT3dqvH0Qfbrd7lLrP1uaIXH4o9tFdI7STGsPY/rUYkA0PiAH2UvsI3ciOt8t4cv2yHSBwa+AzkMzd/BfW1mfUhQqosORJAB/FCslSFfyzaxR6FW8vK5sNTxtyz+q/La0n/6inQC6ME338D9cGDCVEZLzlny9FVKV+7I5karTLJa/YCMNBG/mQpLKQ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(39860400002)(396003)(346002)(82310400011)(230921699003)(1800799009)(186009)(451199024)(40470700004)(46966006)(36840700001)(81166007)(83380400001)(316002)(70206006)(70586007)(6916009)(6666004)(36756003)(26005)(1076003)(336012)(356005)(2616005)(426003)(478600001)(47076005)(40460700003)(5660300002)(44832011)(2906002)(82740400003)(40480700001)(54906003)(4326008)(8676002)(8936002)(86362001)(41300700001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 06:50:31.3590 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b90c16fc-851c-4f64-43f7-08dbbb3836be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7018
Received-SPF: softfail client-ip=2a01:111:f400:7ea9::62c;
 envelope-from=tong.ho@amd.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
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
 hw/arm/xlnx-versal-virt.c    | 20 ++++++++++++++++++++
 hw/arm/xlnx-versal.c         | 16 ++++++++++++++++
 include/hw/arm/xlnx-versal.h |  5 +++++
 4 files changed, 42 insertions(+)

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
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 88c561ff63..d99255ee89 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -391,6 +391,25 @@ static void fdt_add_rtc_node(VersalVirt *s)
     g_free(name);
 }
 
+static void fdt_add_trng_node(VersalVirt *s)
+{
+    const char compat[] = TYPE_XLNX_VERSAL_TRNG;
+    const char interrupt_names[] = "trng";
+    g_autofree char *name = g_strdup_printf("/trng@%x", MM_PMC_TRNG);
+
+    qemu_fdt_add_subnode(s->fdt, name);
+
+    qemu_fdt_setprop_cells(s->fdt, name, "interrupts",
+                           GIC_FDT_IRQ_TYPE_SPI, VERSAL_TRNG_IRQ,
+                           GIC_FDT_IRQ_FLAGS_LEVEL_HI);
+    qemu_fdt_setprop(s->fdt, name, "interrupt-names",
+                     interrupt_names, sizeof(interrupt_names));
+    qemu_fdt_setprop_sized_cells(s->fdt, name, "reg",
+                                 2, MM_PMC_TRNG,
+                                 2, MM_PMC_TRNG_SIZE);
+    qemu_fdt_setprop(s->fdt, name, "compatible", compat, sizeof(compat));
+}
+
 static void fdt_add_bbram_node(VersalVirt *s)
 {
     const char compat[] = TYPE_XLNX_BBRAM;
@@ -690,6 +709,7 @@ static void versal_virt_init(MachineState *machine)
     fdt_add_usb_xhci_nodes(s);
     fdt_add_sd_nodes(s);
     fdt_add_rtc_node(s);
+    fdt_add_trng_node(s);
     fdt_add_bbram_node(s);
     fdt_add_efuse_ctrl_node(s);
     fdt_add_efuse_cache_node(s);
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


