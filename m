Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DDF77814B
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 21:18:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUB9l-0000iA-3b; Thu, 10 Aug 2023 15:17:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1qUB9R-0000Rm-3g
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 15:16:57 -0400
Received: from mail-dm6nam12on2062e.outbound.protection.outlook.com
 ([2a01:111:f400:fe59::62e]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1qUB9O-00074n-N4
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 15:16:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GzCVEeHRa4ZHMAX2Kct3H/BmbRlawYr6rsd3Xuu0I49wSTI+V7uIw2TxWkSfd6b6EJ3MCB0g25l8UrAJvtlYmK2uQJWrMt0Mb/9sWL/ocN4aqAdewGxUI0jKRYczrEIr6VfCfqv+vthYaldtiyJe3pFy20ZJlIOTtHFSruTvjGjz0BmImQ8nYFBJ4gybwLAdQFuBWawc/nybE4s6BPIPUa4hZYcpfMXU7I6TnYYlVTjQfKlV1sYupfkP2Pbplc14vJ7ISPYqUzcwOIBMTKEZEGKtaUoSgy8YdDtne2C4BqsFgFeBaagziUt6HQd/y2nPyKo/0OfcuQsiTz1877yeww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y4fCChbwqq2SD3J3IDsTvztjHUg9b1AXulkRtEJg8Sg=;
 b=kcqYCqdV4HcZlaZnewEtNXIAyOda+8Xz/nBhujlq4YBmwAHIN07NS1bJ3efMJRcszPCMAyPC7gngG7JM3MJUdWQifpN99Y7lm9KWNH2Km/EQBgfLuVaudrfl4E+APs0OCuusmADpaw+oia3HgADPkfnXBpsCA9jMvjoOL+RwghrU8mjBCmqIn5AXeUcHaemdFzNnPR1XtJ8jhUry0xsCAJGZlT8oIm1vX/97CklWqnJWaZkBfZwxUHPz0Wt4nk/xReWK+ufMXuQwzrde1vI13z2sFjdH1bLE5SjDbNWhj4nm1QB0hAs2p98nY3PRU5/SZSLgn6GJkkr3ZsROBlJFBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4fCChbwqq2SD3J3IDsTvztjHUg9b1AXulkRtEJg8Sg=;
 b=ECvCwY0UV4crvSK7tpN/sYveNdeEyByE8A4RKpM48f1/7STWeCblG0zuUkNAywivJOxQH6GGx5Vvu5S3eeHz8lkc3r2gr9bXRC0ugRQfGdzRBk7HEHC+gbblA6WmCGkiIy/qY0jEbawaEL/E8Pr59P/0VnwUhWPEabNBViiYCqc=
Received: from CY8PR12CA0011.namprd12.prod.outlook.com (2603:10b6:930:4e::14)
 by IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 19:16:46 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:930:4e:cafe::4f) by CY8PR12CA0011.outlook.office365.com
 (2603:10b6:930:4e::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30 via Frontend
 Transport; Thu, 10 Aug 2023 19:16:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.83) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Thu, 10 Aug 2023 19:16:45 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 14:16:44 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 10 Aug 2023 14:16:43 -0500
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: <qemu-devel@nongnu.org>
CC: <frasse.iglesias@gmail.com>, <alistair@alistair23.me>,
 <edgar.iglesias@gmail.com>, <peter.maydell@linaro.org>, <fkonrad@amd.com>,
 <sai.pavan.boddu@amd.com>, <tong.ho@amd.com>, <vikram.garhwal@amd.com>
Subject: [PATCH v2 8/8] hw/arm/versal: Connect the CFRAME_REG and
 CFRAME_BCAST_REG
Date: Thu, 10 Aug 2023 21:16:26 +0200
Message-ID: <20230810191626.81084-9-francisco.iglesias@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810191626.81084-1-francisco.iglesias@amd.com>
References: <20230810191626.81084-1-francisco.iglesias@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|IA1PR12MB9030:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f53ba71-d4ac-434f-e446-08db99d6569b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u2KzxbuKMUWACKNGol+txpkA10vRksbVW3aVOLTa62KKsh0VQ7qH7tRKRX5w0hJDskSzySkzbr5IkwKCKtTUlQ6HAW8h4U0YCpWYG85JimbmZhx6/KSKWyAs9ttVnALXo5588OtFcsWBvUIU5tXlM7ALedCuzxeo6AedrNC23KKvW5GMj1Gox4oleMVNU6KyOUoSHfDYPM2uROiqsLoIFu/2f3MnztPKuMOQeFlaY2xRqJ/R85hXfjg51vvOHCKG49FT/rLZ0Ikm7iQ++y6Ag2Tp9+lzeuYTbuSgU/c6POs6HQX/YgCKIlIXSOWOghrgZ/zQ9oMuYcs8S3HuKPz5jTw53e6bbkEAgTCEUA/eNEiDD5Tx3c3uPGNZlXoAr459Mon07R/Om6MsJoloGpRuCDc5VInmhXg7ph0rSEx+2f87A1+TeX4mdknzDeTuS9lbbZ+rpABTWEW6imXt/7mmqUkRkl2080ASli5nez6TSQcYijbDI5B+sQJHUrBBfCBbd5uMxl2a66EPtmbNbKnOQT+prPufsjnnFatVfhNsVEcv2gSSXSBxkA2lKpkNztA7f4mtrLVekgjcOLa34+2AVhOrCvCST4C49YHhrjGxUtTZtqwkugX1R/DTjgbGymjI8zMvijnpagev+GA0XCA9v7IE/oJXLz3nuhVm3fbI/kUKB4ymXEPWSyR9Aw1dYuCPOXWeF9mTSnmXGZiV/YCyJIvV6oqvCRspQHt+2oxTcoa44oKC5OvFFKfCBIwgwJ4iQkMwIdNXzErG5jTUz6W1Kg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199021)(186006)(82310400008)(1800799006)(46966006)(40470700004)(36840700001)(26005)(8936002)(1076003)(8676002)(41300700001)(40460700003)(36860700001)(47076005)(36756003)(83380400001)(426003)(2906002)(81166007)(356005)(2616005)(86362001)(82740400003)(44832011)(336012)(40480700001)(6916009)(70586007)(70206006)(478600001)(4326008)(54906003)(6666004)(5660300002)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 19:16:45.6602 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f53ba71-d4ac-434f-e446-08db99d6569b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9030
Received-SPF: softfail client-ip=2a01:111:f400:fe59::62e;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
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

Connect the Configuration Frame controller (CFRAME_REG) and the
Configuration Frame broadcast controller (CFRAME_BCAST_REG) to the
Versal machine.

Signed-off-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
 hw/arm/xlnx-versal.c         | 113 ++++++++++++++++++++++++++++++++++-
 include/hw/arm/xlnx-versal.h |  69 +++++++++++++++++++++
 2 files changed, 181 insertions(+), 1 deletion(-)

diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 3f4b4b1560..fa556d8764 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -27,7 +27,7 @@
 #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
 #define GEM_REVISION        0x40070106
 
-#define VERSAL_NUM_PMC_APB_IRQS 3
+#define VERSAL_NUM_PMC_APB_IRQS 18
 #define NUM_OSPI_IRQ_LINES 3
 
 static void versal_create_apu_cpus(Versal *s)
@@ -341,6 +341,7 @@ static void versal_create_pmc_apb_irq_orgate(Versal *s, qemu_irq *pic)
      *  - RTC
      *  - BBRAM
      *  - PMC SLCR
+     *  - CFRAME regs (input 3 - 17 to the orgate)
      */
     object_initialize_child(OBJECT(s), "pmc-apb-irq-orgate",
                             &s->pmc.apb_irq_orgate, TYPE_OR_IRQ);
@@ -573,6 +574,42 @@ static void versal_create_ospi(Versal *s, qemu_irq *pic)
 static void versal_create_cfu(Versal *s, qemu_irq *pic)
 {
     SysBusDevice *sbd;
+    DeviceState *dev;
+    int i;
+    const struct {
+        uint64_t reg_base;
+        uint64_t fdri_base;
+    } cframe_addr[] = {
+        { MM_PMC_CFRAME0_REG, MM_PMC_CFRAME0_FDRI },
+        { MM_PMC_CFRAME1_REG, MM_PMC_CFRAME1_FDRI },
+        { MM_PMC_CFRAME2_REG, MM_PMC_CFRAME2_FDRI },
+        { MM_PMC_CFRAME3_REG, MM_PMC_CFRAME3_FDRI },
+        { MM_PMC_CFRAME4_REG, MM_PMC_CFRAME4_FDRI },
+        { MM_PMC_CFRAME5_REG, MM_PMC_CFRAME5_FDRI },
+        { MM_PMC_CFRAME6_REG, MM_PMC_CFRAME6_FDRI },
+        { MM_PMC_CFRAME7_REG, MM_PMC_CFRAME7_FDRI },
+        { MM_PMC_CFRAME8_REG, MM_PMC_CFRAME8_FDRI },
+        { MM_PMC_CFRAME9_REG, MM_PMC_CFRAME9_FDRI },
+        { MM_PMC_CFRAME10_REG, MM_PMC_CFRAME10_FDRI },
+        { MM_PMC_CFRAME11_REG, MM_PMC_CFRAME11_FDRI },
+        { MM_PMC_CFRAME12_REG, MM_PMC_CFRAME12_FDRI },
+        { MM_PMC_CFRAME13_REG, MM_PMC_CFRAME13_FDRI },
+        { MM_PMC_CFRAME14_REG, MM_PMC_CFRAME14_FDRI },
+    };
+    const struct {
+        uint32_t blktype0_frames;
+        uint32_t blktype1_frames;
+        uint32_t blktype2_frames;
+        uint32_t blktype3_frames;
+        uint32_t blktype4_frames;
+        uint32_t blktype5_frames;
+        uint32_t blktype6_frames;
+    } cframe_cfg[] = {
+        [0] = { 34111, 3528, 12800, 11, 5, 1, 1 },
+        [1] = { 38498, 3841, 15361, 13, 7, 3, 1 },
+        [2] = { 38498, 3841, 15361, 13, 7, 3, 1 },
+        [3] = { 38498, 3841, 15361, 13, 7, 3, 1 },
+    };
 
     /* CFU FDRO */
     object_initialize_child(OBJECT(s), "cfu-fdro", &s->pmc.cfu_fdro,
@@ -583,10 +620,84 @@ static void versal_create_cfu(Versal *s, qemu_irq *pic)
     memory_region_add_subregion(&s->mr_ps, MM_PMC_CFU_FDRO,
                                 sysbus_mmio_get_region(sbd, 0));
 
+    /* CFRAME REG */
+    for (i = 0; i < ARRAY_SIZE(s->pmc.cframe); i++) {
+        g_autofree char *name = g_strdup_printf("cframe%d", i);
+
+        object_initialize_child(OBJECT(s), name, &s->pmc.cframe[i],
+                                TYPE_XLNX_VERSAL_CFRAME_REG);
+
+        sbd = SYS_BUS_DEVICE(&s->pmc.cframe[i]);
+        dev = DEVICE(&s->pmc.cframe[i]);
+
+        if (i < ARRAY_SIZE(cframe_cfg)) {
+            object_property_set_int(OBJECT(dev), "blktype0-frames",
+                                    cframe_cfg[i].blktype0_frames,
+                                    &error_abort);
+            object_property_set_int(OBJECT(dev), "blktype1-frames",
+                                    cframe_cfg[i].blktype1_frames,
+                                    &error_abort);
+            object_property_set_int(OBJECT(dev), "blktype2-frames",
+                                    cframe_cfg[i].blktype2_frames,
+                                    &error_abort);
+            object_property_set_int(OBJECT(dev), "blktype3-frames",
+                                    cframe_cfg[i].blktype3_frames,
+                                    &error_abort);
+            object_property_set_int(OBJECT(dev), "blktype4-frames",
+                                    cframe_cfg[i].blktype4_frames,
+                                    &error_abort);
+            object_property_set_int(OBJECT(dev), "blktype5-frames",
+                                    cframe_cfg[i].blktype5_frames,
+                                    &error_abort);
+            object_property_set_int(OBJECT(dev), "blktype6-frames",
+                                    cframe_cfg[i].blktype6_frames,
+                                    &error_abort);
+        }
+        object_property_set_link(OBJECT(dev), "cfu-fdro",
+                                 OBJECT(&s->pmc.cfu_fdro), &error_fatal);
+
+        sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
+
+        memory_region_add_subregion(&s->mr_ps, cframe_addr[i].reg_base,
+                                    sysbus_mmio_get_region(sbd, 0));
+        memory_region_add_subregion(&s->mr_ps, cframe_addr[i].fdri_base,
+                                    sysbus_mmio_get_region(sbd, 1));
+        sysbus_connect_irq(sbd, 0,
+                           qdev_get_gpio_in(DEVICE(&s->pmc.apb_irq_orgate),
+                                            3 + i));
+    }
+
+    /* CFRAME BCAST */
+    object_initialize_child(OBJECT(s), "cframe_bcast", &s->pmc.cframe_bcast,
+                            TYPE_XLNX_VERSAL_CFRAME_BCAST_REG);
+
+    sbd = SYS_BUS_DEVICE(&s->pmc.cframe_bcast);
+    dev = DEVICE(&s->pmc.cframe_bcast);
+
+    for (i = 0; i < ARRAY_SIZE(s->pmc.cframe); i++) {
+        g_autofree char *propname = g_strdup_printf("cframe%d", i);
+        object_property_set_link(OBJECT(dev), propname,
+                                 OBJECT(&s->pmc.cframe[i]), &error_fatal);
+    }
+
+    sysbus_realize(sbd, &error_fatal);
+
+    memory_region_add_subregion(&s->mr_ps, MM_PMC_CFRAME_BCAST_REG,
+                                sysbus_mmio_get_region(sbd, 0));
+    memory_region_add_subregion(&s->mr_ps, MM_PMC_CFRAME_BCAST_FDRI,
+                                sysbus_mmio_get_region(sbd, 1));
+
     /* CFU APB */
     object_initialize_child(OBJECT(s), "cfu-apb", &s->pmc.cfu_apb,
                             TYPE_XLNX_VERSAL_CFU_APB);
     sbd = SYS_BUS_DEVICE(&s->pmc.cfu_apb);
+    dev = DEVICE(&s->pmc.cfu_apb);
+
+    for (i = 0; i < ARRAY_SIZE(s->pmc.cframe); i++) {
+        g_autofree char *propname = g_strdup_printf("cframe%d", i);
+        object_property_set_link(OBJECT(dev), propname,
+                                 OBJECT(&s->pmc.cframe[i]), &error_fatal);
+    }
 
     sysbus_realize(sbd, &error_fatal);
     memory_region_add_subregion(&s->mr_ps, MM_PMC_CFU_APB,
diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index 29b9c60301..7b419f88c2 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -33,6 +33,7 @@
 #include "hw/misc/xlnx-versal-pmc-iou-slcr.h"
 #include "hw/net/xlnx-versal-canfd.h"
 #include "hw/misc/xlnx-versal-cfu.h"
+#include "hw/misc/xlnx-versal-cframe-reg.h"
 
 #define TYPE_XLNX_VERSAL "xlnx-versal"
 OBJECT_DECLARE_SIMPLE_TYPE(Versal, XLNX_VERSAL)
@@ -47,6 +48,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(Versal, XLNX_VERSAL)
 #define XLNX_VERSAL_NR_IRQS    192
 #define XLNX_VERSAL_NR_CANFD   2
 #define XLNX_VERSAL_CANFD_REF_CLK (24 * 1000 * 1000)
+#define XLNX_VERSAL_NR_CFRAME  15
 
 struct Versal {
     /*< private >*/
@@ -121,6 +123,8 @@ struct Versal {
         XlnxVersalCFUAPB cfu_apb;
         XlnxVersalCFUFDRO cfu_fdro;
         XlnxVersalCFUSFR cfu_sfr;
+        XlnxVersalCFrameReg cframe[XLNX_VERSAL_NR_CFRAME];
+        XlnxVersalCFrameBcastReg cframe_bcast;
 
         OrIRQState apb_irq_orgate;
     } pmc;
@@ -256,6 +260,71 @@ struct Versal {
 #define MM_PMC_CFU_STREAM_2         0xf1f80000
 #define MM_PMC_CFU_STREAM_2_SIZE    0x40000
 
+#define MM_PMC_CFRAME0_REG          0xf12d0000
+#define MM_PMC_CFRAME0_REG_SIZE     0x1000
+#define MM_PMC_CFRAME0_FDRI         0xf12d1000
+#define MM_PMC_CFRAME0_FDRI_SIZE    0x1000
+#define MM_PMC_CFRAME1_REG          0xf12d2000
+#define MM_PMC_CFRAME1_REG_SIZE     0x1000
+#define MM_PMC_CFRAME1_FDRI         0xf12d3000
+#define MM_PMC_CFRAME1_FDRI_SIZE    0x1000
+#define MM_PMC_CFRAME2_REG          0xf12d4000
+#define MM_PMC_CFRAME2_REG_SIZE     0x1000
+#define MM_PMC_CFRAME2_FDRI         0xf12d5000
+#define MM_PMC_CFRAME2_FDRI_SIZE    0x1000
+#define MM_PMC_CFRAME3_REG          0xf12d6000
+#define MM_PMC_CFRAME3_REG_SIZE     0x1000
+#define MM_PMC_CFRAME3_FDRI         0xf12d7000
+#define MM_PMC_CFRAME3_FDRI_SIZE    0x1000
+#define MM_PMC_CFRAME4_REG          0xf12d8000
+#define MM_PMC_CFRAME4_REG_SIZE     0x1000
+#define MM_PMC_CFRAME4_FDRI         0xf12d9000
+#define MM_PMC_CFRAME4_FDRI_SIZE    0x1000
+#define MM_PMC_CFRAME5_REG          0xf12da000
+#define MM_PMC_CFRAME5_REG_SIZE     0x1000
+#define MM_PMC_CFRAME5_FDRI         0xf12db000
+#define MM_PMC_CFRAME5_FDRI_SIZE    0x1000
+#define MM_PMC_CFRAME6_REG          0xf12dc000
+#define MM_PMC_CFRAME6_REG_SIZE     0x1000
+#define MM_PMC_CFRAME6_FDRI         0xf12dd000
+#define MM_PMC_CFRAME6_FDRI_SIZE    0x1000
+#define MM_PMC_CFRAME7_REG          0xf12de000
+#define MM_PMC_CFRAME7_REG_SIZE     0x1000
+#define MM_PMC_CFRAME7_FDRI         0xf12df000
+#define MM_PMC_CFRAME7_FDRI_SIZE    0x1000
+#define MM_PMC_CFRAME8_REG          0xf12e0000
+#define MM_PMC_CFRAME8_REG_SIZE     0x1000
+#define MM_PMC_CFRAME8_FDRI         0xf12e1000
+#define MM_PMC_CFRAME8_FDRI_SIZE    0x1000
+#define MM_PMC_CFRAME9_REG          0xf12e2000
+#define MM_PMC_CFRAME9_REG_SIZE     0x1000
+#define MM_PMC_CFRAME9_FDRI         0xf12e3000
+#define MM_PMC_CFRAME9_FDRI_SIZE    0x1000
+#define MM_PMC_CFRAME10_REG         0xf12e4000
+#define MM_PMC_CFRAME10_REG_SIZE    0x1000
+#define MM_PMC_CFRAME10_FDRI        0xf12e5000
+#define MM_PMC_CFRAME10_FDRI_SIZE   0x1000
+#define MM_PMC_CFRAME11_REG         0xf12e6000
+#define MM_PMC_CFRAME11_REG_SIZE    0x1000
+#define MM_PMC_CFRAME11_FDRI        0xf12e7000
+#define MM_PMC_CFRAME11_FDRI_SIZE   0x1000
+#define MM_PMC_CFRAME12_REG         0xf12e8000
+#define MM_PMC_CFRAME12_REG_SIZE    0x1000
+#define MM_PMC_CFRAME12_FDRI        0xf12e9000
+#define MM_PMC_CFRAME12_FDRI_SIZE   0x1000
+#define MM_PMC_CFRAME13_REG         0xf12ea000
+#define MM_PMC_CFRAME13_REG_SIZE    0x1000
+#define MM_PMC_CFRAME13_FDRI        0xf12eb000
+#define MM_PMC_CFRAME13_FDRI_SIZE   0x1000
+#define MM_PMC_CFRAME14_REG         0xf12ec000
+#define MM_PMC_CFRAME14_REG_SIZE    0x1000
+#define MM_PMC_CFRAME14_FDRI        0xf12ed000
+#define MM_PMC_CFRAME14_FDRI_SIZE   0x1000
+#define MM_PMC_CFRAME_BCAST_REG       0xf12ee000
+#define MM_PMC_CFRAME_BCAST_REG_SIZE  0x1000
+#define MM_PMC_CFRAME_BCAST_FDRI      0xf12ef000
+#define MM_PMC_CFRAME_BCAST_FDRI_SIZE 0x1000
+
 #define MM_PMC_CRP                  0xf1260000U
 #define MM_PMC_CRP_SIZE             0x10000
 #define MM_PMC_RTC                  0xf12a0000
-- 
2.34.1


