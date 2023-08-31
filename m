Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6484778F1C3
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 19:20:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qblJw-0001sC-60; Thu, 31 Aug 2023 13:19:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tong.ho@amd.com>)
 id 1qblJt-0001rg-Er; Thu, 31 Aug 2023 13:19:01 -0400
Received: from mail-dm6nam10on20618.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::618]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tong.ho@amd.com>)
 id 1qblJq-0005ua-7T; Thu, 31 Aug 2023 13:19:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iSmPxkW7+MeqKawOG3JLio3jt9lrxKXpE9ia0IPhJUUFJstbVP2e2zpzpkB9N3SkHBx2V+pZmNO4nl9/bOUqRTBPIFS1wmvyx9DWybmGa3xUtc63FgGpoTeAMS8AY6RG93WwhXHQxHy+LqfyKp1Lbipn6lnhGHebHDyb9xYVyWRmb5KSSPg7l1XCctMlGKdcd5m4UiWlQu1lyHDaWxcE5wTaMqmP5MWT27ttbVmLW/neivJQiLkS1uExj/HB1XsgqW597o3E3AnZ6+h7UAVa9Hw0gkchqSYg3+i171pRHeHUTxUW2WEftodm3o973Ga6XiVvLFYkaQ08J4I1b+4XiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O7tuUNi+bgqUFHnJ+Rl3ddXSdLMaoX10zW01xm0s1jQ=;
 b=EasgZmSOZP7ttBmNN4p9HJciY4ctWJT5So4GGeGw9WX3HGF5e6+DNlhLctFQ4xRpBvhY6a6aRyYRev7JZ+88C9PVhNIWWHN0dk9Yoqa9hy+8zLrcXFuj+gCJuDAY3cvNZCaZdv0jR8kCbKqhXRMRILKYqVbtWA0EEyqtr0I47FiFAuVxr+noecnDsZQfdylQ3hV5AvJxIqakzBKTPuSNmDYqSMMg8EHN4bEgYFicq+3fJ/3RLBSZV1t0GKi8Yo/YJaEn1sSEBR65X4ksEAa62XnWiOSxGj9f8nsjl0oXUkXoQrTGisF+LD+FzyNP97ikJf4cwHm368X+2bEW5leKoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7tuUNi+bgqUFHnJ+Rl3ddXSdLMaoX10zW01xm0s1jQ=;
 b=3nnZ3BzG7oKfeBAkydO9/fKbdMUq9uqszL+WBtUhEjvtGBWwuAQSlmbnx3KiOTN/HgGANa2QSwGiiZp9Y2B51p4ALpeG2Go9N8y5KmUuwv9CE4arlfz+LSGCtEQBdRKPXhD0C0KdBhOIUgVGtYisM8IwGZomrQakWO6+1cOP38g=
Received: from DS7PR03CA0034.namprd03.prod.outlook.com (2603:10b6:5:3b5::9) by
 DM6PR12MB4121.namprd12.prod.outlook.com (2603:10b6:5:220::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.20; Thu, 31 Aug 2023 17:18:52 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:5:3b5:cafe::9e) by DS7PR03CA0034.outlook.office365.com
 (2603:10b6:5:3b5::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21 via Frontend
 Transport; Thu, 31 Aug 2023 17:18:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.76) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Thu, 31 Aug 2023 17:18:52 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 31 Aug
 2023 12:18:51 -0500
Received: from xsjtongh40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 31 Aug 2023 12:18:51 -0500
From: Tong Ho <tong.ho@amd.com>
To: <qemu-arm@nongnu.org>
CC: <qemu-devel@nongnu.org>, <alistair@alistair23.me>,
 <edgar.iglesias@gmail.com>, <peter.maydell@linaro.org>, <tong.ho@amd.com>
Subject: [PATCH 2/3] hw/arm: xlnx-versal-virt: Add AMD/Xilinx TRNG device
Date: Thu, 31 Aug 2023 10:18:48 -0700
Message-ID: <20230831171849.3297497-3-tong.ho@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230831171849.3297497-1-tong.ho@amd.com>
References: <20230831171849.3297497-1-tong.ho@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|DM6PR12MB4121:EE_
X-MS-Office365-Filtering-Correlation-Id: b9878fbc-18ae-462b-477f-08dbaa465942
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dgs670kd+5b5x6599okR5vSXNkz4Z6LqOhQ+xfRDF57bgLYhr7tKUDaDyDM28Ru3Z6ULMNf1JDjNJlFHc87xBsjR5Bm6NvUJUtPniZVGIEjVqN6sNvqEiyKGbSOwg6f0CkYC7pSef3glDumm2RV2u67CFIoMoKZrxlBs1/c9neBc1mltab8EHgVCq+W/Mzv0SXaWrsU0UD+xA9pQKi1oiGHTkIGoWPFAnOxSqmDplFU3ukEZ5ARU/MT2jg98232ljwe28H7lFNbZCIA5cXQXd0vQ5y8GIUZR/PU+kyT9XEhT38FRO0N3WTcdTfKI1ai1gAklRQKCiwybE4pQ/ZXLPAbL7P7A84KVaVycP2vFpQf/tXzj+cizRlD5imsu2Otulr5rjgfB2jvJClCoAu9WXU0YlmUYIH5JP8N7JognfZ6z0ew3GGyDl4u0Ue4FlZQBWOOn3rlJ5wnMjoVqNJ3MCzh2vOWvb6gKtlRiqpeLevZH7xISUS7rJSYW+O9ZaroQo+hih8l/CKxhmmSfyv+zijX3Fs5/ORtfDuRUNcnag58ZnBh8ndXO5mmMibxNqlEkHjjgx2pT+L5hAGusAcBCR6fTT9yasLlMvS7gLM+049GkGK2wD6x6AcWQqejJzI4NclzAM6KdCt/28TG5Ftf2c4DBHCbBxRaOZDIAQXG00DeJF+KqEVy+EUhHue8dvpRgSlCFbPtxQJtiA6450iurPnDJtcYpPfjxVzwao2xW0WL0IAFvX3U/tsH9jSzx/tvEjHi3s8T/drgFQBnoXLmWNw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(376002)(39860400002)(346002)(1800799009)(82310400011)(451199024)(186009)(36840700001)(40470700004)(46966006)(70206006)(2906002)(36756003)(40460700003)(5660300002)(86362001)(44832011)(356005)(82740400003)(81166007)(40480700001)(4326008)(8676002)(47076005)(36860700001)(336012)(41300700001)(8936002)(83380400001)(426003)(1076003)(2616005)(316002)(26005)(54906003)(6666004)(478600001)(70586007)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 17:18:52.4068 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9878fbc-18ae-462b-477f-08dbaa465942
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4121
Received-SPF: softfail client-ip=2a01:111:f400:7e88::618;
 envelope-from=tong.ho@amd.com;
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
index 1ee2b8697f..c0704f416e 100644
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
index 60bf5fe657..4fd1924cf6 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -372,6 +372,21 @@ static void versal_create_rtc(Versal *s, qemu_irq *pic)
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
@@ -757,6 +772,7 @@ static void versal_realize(DeviceState *dev, Error **errp)
     versal_create_sds(s, pic);
     versal_create_pmc_apb_irq_orgate(s, pic);
     versal_create_rtc(s, pic);
+    versal_create_trng(s, pic);
     versal_create_xrams(s, pic);
     versal_create_bbram(s, pic);
     versal_create_efuse(s, pic);
diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index 39ee31185c..159ee26aad 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -31,6 +31,7 @@
 #include "hw/dma/xlnx_csu_dma.h"
 #include "hw/misc/xlnx-versal-crl.h"
 #include "hw/misc/xlnx-versal-pmc-iou-slcr.h"
+#include "hw/misc/xlnx-versal-trng.h"
 #include "hw/net/xlnx-versal-canfd.h"
 
 #define TYPE_XLNX_VERSAL "xlnx-versal"
@@ -113,6 +114,7 @@ struct Versal {
         } iou;
 
         XlnxZynqMPRTC rtc;
+        XlnxVersalTRng trng;
         XlnxBBRam bbram;
         XlnxEFuse efuse;
         XlnxVersalEFuseCtrl efuse_ctrl;
@@ -151,6 +153,7 @@ struct Versal {
 #define VERSAL_OSPI_IRQ            124
 #define VERSAL_SD0_IRQ_0           126
 #define VERSAL_EFUSE_IRQ           139
+#define VERSAL_TRNG_IRQ            141
 #define VERSAL_RTC_ALARM_IRQ       142
 #define VERSAL_RTC_SECONDS_IRQ     143
 
@@ -244,4 +247,6 @@ struct Versal {
 #define MM_PMC_CRP_SIZE             0x10000
 #define MM_PMC_RTC                  0xf12a0000
 #define MM_PMC_RTC_SIZE             0x10000
+#define MM_PMC_TRNG                 0xf1230000
+#define MM_PMC_TRNG_SIZE            0x10000
 #endif
-- 
2.25.1


