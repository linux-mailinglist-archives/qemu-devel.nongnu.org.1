Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 217D9B31E23
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Aug 2025 17:19:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upTW6-0007sM-JC; Fri, 22 Aug 2025 11:17:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTVx-0007lX-Sf; Fri, 22 Aug 2025 11:17:15 -0400
Received: from mail-bn7nam10on20611.outbound.protection.outlook.com
 ([2a01:111:f403:2009::611]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTVq-0007AP-JA; Fri, 22 Aug 2025 11:17:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sjiOOZVJPCemPlAyeeEDxW783Y8ZXURlDooPz7g1dz0LkmGfph+WXEP0ty+Ip0whOHeqBK1BxmKvVPoGAuXdXiy6TQaZ+7DfdVqMqECvjYqfzhfWL07jfYwSId7BmvOIsDbpT4vW42vR+u9HXOrNYT8dnpHGYW228SWV9d/PsBwAYVcAyDRLgEBqFh7NnIqVo/TJnFj92ZZVOH8QygTC2SECKMCUsYSwVm5d1H52adWlWblclZrupb0I3WUqtTUMc2KP8p9zZqnbuNF6/XA9WSA6rVFOyqLHcgSfCUHHMZT/ZLgUjQSbCDtymVHeIHyg3eUPmX0eHI09nmciZdlUUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mnFWtjnNkzAIzhef/ZzNe9zDSbkKL3dQGSQ8PM8kpts=;
 b=jx9ztoDgpJVpjjRnlHaf5swItjINoxSQpkvn/OEt8xMcj8x7ltApO026U7UAkSXRgt4MZx6UYglZRRuMYblSCDQxOzbbkQHe4MuHE47uyFaJ6hR2Tpf76yeJtmSEUns7ovMPXIlInGusaXTE0ccT7PPMv9aPsA0J7lb8j3Y4yMmC0uQjE3KhyrXXGChNkWf5eabF2Q9rAElsnVUKBYmMW4YEOCkWXuj5cPw8g+d2HROd6IWhM+VHZVgB3vorijHUIMoYjjVrz0GbmLzvPZTJy75Bs9Mzcch8bhKQB3w6Npr4VBzv0No/kpGUafI51QRa+tLDsb0a9jV8UrhCKjP1+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnFWtjnNkzAIzhef/ZzNe9zDSbkKL3dQGSQ8PM8kpts=;
 b=gwN1ar3fZnVlKu0yQ7nZjIqdLYfVmgMYWEYCdilPdzwoVzwLEaNn/x6+lZzdpb6HPSe8CEpq+U5IQ7m/5TqvFPJqFFWNfpbWjbkhx/2hgmyYSTVwqJLJhzsQObJUgJnarHnIOmjnRdEJvktTHTkanAJyAzxFdGAXbMSp8U74Jww=
Received: from DM6PR01CA0027.prod.exchangelabs.com (2603:10b6:5:296::32) by
 DS0PR12MB6535.namprd12.prod.outlook.com (2603:10b6:8:c0::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.19; Fri, 22 Aug 2025 15:16:59 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:5:296:cafe::f9) by DM6PR01CA0027.outlook.office365.com
 (2603:10b6:5:296::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.19 via Frontend Transport; Fri,
 22 Aug 2025 15:16:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 15:16:59 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 10:16:58 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 10:16:58 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 22 Aug 2025 10:16:56 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v4 17/47] hw/arm/xlnx-versal: cfu: refactor creation
Date: Fri, 22 Aug 2025 17:15:42 +0200
Message-ID: <20250822151614.187856-18-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822151614.187856-1-luc.michel@amd.com>
References: <20250822151614.187856-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|DS0PR12MB6535:EE_
X-MS-Office365-Filtering-Correlation-Id: 88242a31-bf33-4a61-0e95-08dde18ef08c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PanX//6LhZ8XWy9zC+MxOR5SivcfgsYOmsw5xYX4DZWrzO2jNFW347Be0u3g?=
 =?us-ascii?Q?H96k9FuRMyN+347QbZYGA3A6TNYQAmf3yDXPkRysT4ER8IxeSMukRmnGQ4Om?=
 =?us-ascii?Q?sZB4uCq4LDPxB4WSueg4l3rCouuNV6McaVQjIZioxPtJlfV7f7Lvi6ceZ0wQ?=
 =?us-ascii?Q?wJ0l8t7qhBXiyqdTj9/kxs9/xFK8hkzlgS4JzJplZunDLOtOvZhVcmH/OaNE?=
 =?us-ascii?Q?D9EVtvXgYRvYV/VyHL8ZbMllDRRJeOxilcBthyHockU+coRQIl1DnAsF+ikz?=
 =?us-ascii?Q?Zxcein1rQ4lzLXgNNqAWZ8iTiLQN0gFIku9m1iQ88D8VG4vPiTm+Uh1WQpMa?=
 =?us-ascii?Q?levC0w7QcAqmciBLKZQ3DFmhH6eHYMuYOjvvZMlOk5CrJAdAHLH7G400G+7G?=
 =?us-ascii?Q?uTginFqZb25lm1mZOqMiRb1jIDxuY8mr5Xqf79cXmPNhbOHDoBs+jwvoaYuw?=
 =?us-ascii?Q?a4soSXjj9spLPy7UgcHo7NfPyOBLa0KmDxTqso5PvFlqea1HsgkMUkVzk3h+?=
 =?us-ascii?Q?2MzKgfu9z6n6+asGrqaVJwVRsSj+WJpipIElrlBsDBCj8mPb6ab+AbHeA1Zz?=
 =?us-ascii?Q?PZI/8wRFfxL/gfKbSZvyNVMOO7Lc5OKp6F8kPKjtjThcCDpYaLHranMeWc0a?=
 =?us-ascii?Q?E36IoR8xj0eohPeQwfkuTV8QS1/5GphbyQEza/8JEcCeAUXnqHJXoaucPCAR?=
 =?us-ascii?Q?hh5IR5g+5X95+rgT3G9lQ39gYmy2cE+hLRjXPra4RGD81iVtGQzu/KVquqXm?=
 =?us-ascii?Q?82be3MAeLuzo2od16frM9Jy3tvBKab32DuSSN9Nf7m5I+69ZPTtO0gg8BUJx?=
 =?us-ascii?Q?hZr5+flzjjoqx00hSu0znCYjzyn2s+RYz84X/88J2Ok54bfDvZ7WDxb90I/j?=
 =?us-ascii?Q?mz6lU4qHKY9/oV8OME+c4rOeqPze3Z/AmvYH4HHBJ9rC5I7GgGTyUBC8amIC?=
 =?us-ascii?Q?9TDXTuWwhZa780i7vJWXTC8sukNl/0diLF+UmrkpKmImZXQ2e+NVA4pFvCkw?=
 =?us-ascii?Q?MprVFjjI6RXDJZ5f9ieNGegOG4GFINaRy/3KKssFm7sGjpVj63fkc+F88Epk?=
 =?us-ascii?Q?rXknloJYvdgiQ+GtnlWWReDceUTXaoPOm1rmj9s8rAx9Gs2mFj3DVNH4Uwzx?=
 =?us-ascii?Q?KDjf5Iz5gb9MsGuGG4Kk5KrPOncVe777jNqu/wMQ5CR59hpj7jimbPFERZ/F?=
 =?us-ascii?Q?8Gj3NS6zvWmIkcLDUC8rvdZmOUDr1ezMinL+WW7D5CPiuh1szJCe7g1xPhrF?=
 =?us-ascii?Q?5xj89jGg4lAd/g7H196ut98TaJMi2gYlg/73pz1igdz4tyBcqUbuHwQP7Q2k?=
 =?us-ascii?Q?XqxNXcdh5yl0O3ZanQEwlBbRZEIJFEU1+TE92YUd31raR9mdgBoH/g+91ZDG?=
 =?us-ascii?Q?4ZTj5xlbeyyidblylexJiS9L7FMltzLN0RjuFkJcjz6VEgkGjU+Ovw8NRhoJ?=
 =?us-ascii?Q?fZeuHtdnHsk/Gukf8lcJ3UU8SviFHY7KaxL/eLucFyLaNAgQBINpWnumxyBr?=
 =?us-ascii?Q?rBcyF0uNKuW6sHoh+DLz7a5UO/4yWDCNoTaZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 15:16:59.2994 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88242a31-bf33-4a61-0e95-08dde18ef08c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6535
Received-SPF: permerror client-ip=2a01:111:f403:2009::611;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
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

Refactor the CFU device creation using the VersalMap structure. All
users of the APB IRQ OR gate have now been converted. The OR gate device
can be dropped.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
 include/hw/arm/xlnx-versal.h |  14 --
 hw/arm/xlnx-versal.c         | 258 ++++++++++++++++-------------------
 2 files changed, 115 insertions(+), 157 deletions(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index abdbed15689..5a685aea6d4 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -13,17 +13,14 @@
 #ifndef XLNX_VERSAL_H
 #define XLNX_VERSAL_H
 
 #include "hw/sysbus.h"
 #include "hw/cpu/cluster.h"
-#include "hw/or-irq.h"
 #include "hw/intc/arm_gicv3.h"
 #include "qom/object.h"
 #include "hw/misc/xlnx-versal-crl.h"
 #include "net/can_emu.h"
-#include "hw/misc/xlnx-versal-cfu.h"
-#include "hw/misc/xlnx-versal-cframe-reg.h"
 #include "target/arm/cpu.h"
 #include "hw/arm/xlnx-versal-version.h"
 
 #define TYPE_XLNX_VERSAL_BASE "xlnx-versal-base"
 OBJECT_DECLARE_TYPE(Versal, VersalClass, XLNX_VERSAL_BASE)
@@ -76,21 +73,10 @@ struct Versal {
         } rpu;
 
         XlnxVersalCRL crl;
     } lpd;
 
-    /* The Platform Management Controller subsystem.  */
-    struct {
-        XlnxVersalCFUAPB cfu_apb;
-        XlnxVersalCFUFDRO cfu_fdro;
-        XlnxVersalCFUSFR cfu_sfr;
-        XlnxVersalCFrameReg cframe[XLNX_VERSAL_NR_CFRAME];
-        XlnxVersalCFrameBcastReg cframe_bcast;
-
-        OrIRQState apb_irq_orgate;
-    } pmc;
-
     struct {
         uint32_t clk_25mhz;
         uint32_t clk_125mhz;
     } phandle;
 
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 3a29052a176..bee0b2bb39d 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -37,10 +37,13 @@
 #include "hw/ssi/xlnx-versal-ospi.h"
 #include "hw/misc/xlnx-versal-pmc-iou-slcr.h"
 #include "hw/nvram/xlnx-bbram.h"
 #include "hw/misc/xlnx-versal-trng.h"
 #include "hw/rtc/xlnx-zynqmp-rtc.h"
+#include "hw/misc/xlnx-versal-cfu.h"
+#include "hw/misc/xlnx-versal-cframe-reg.h"
+#include "hw/or-irq.h"
 
 #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
 #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
 #define GEM_REVISION        0x40070106
 
@@ -128,10 +131,28 @@ typedef struct VersalMap {
     struct VersalRtcMap {
         VersalSimplePeriphMap map;
         int alarm_irq;
         int second_irq;
     } rtc;
+
+    struct VersalCfuMap {
+        uint64_t cframe_base;
+        uint64_t cframe_stride;
+        uint64_t cfu_fdro;
+        uint64_t cframe_bcast_reg;
+        uint64_t cframe_bcast_fdri;
+        uint64_t cfu_apb;
+        uint64_t cfu_stream;
+        uint64_t cfu_stream_2;
+        uint64_t cfu_sfr;
+        int cfu_apb_irq;
+        int cframe_irq;
+        size_t num_cframe;
+        struct VersalCfuCframeCfg {
+            uint32_t blktype_frames[7];
+        } cframe_cfg[15];
+    } cfu;
 } VersalMap;
 
 static const VersalMap VERSAL_MAP = {
     .uart[0] = { 0xff000000, 18 },
     .uart[1] = { 0xff010000, 19 },
@@ -176,10 +197,26 @@ static const VersalMap VERSAL_MAP = {
     .trng = { 0xf1230000, 141 },
     .rtc = {
         { 0xf12a0000, OR_IRQ(121, 2) },
         .alarm_irq = 142, .second_irq = 143
     },
+
+    .cfu = {
+        .cframe_base = 0xf12d0000, .cframe_stride = 0x1000,
+        .cframe_bcast_reg = 0xf12ee000, .cframe_bcast_fdri = 0xf12ef000,
+        .cfu_apb = 0xf12b0000, .cfu_sfr = 0xf12c1000,
+        .cfu_stream = 0xf12c0000, .cfu_stream_2 = 0xf1f80000,
+        .cfu_fdro = 0xf12c2000,
+        .cfu_apb_irq = 120, .cframe_irq = OR_IRQ(121, 3),
+        .num_cframe = 15,
+        .cframe_cfg = {
+            { { 34111, 3528, 12800, 11, 5, 1, 1 } },
+            { { 38498, 3841, 15361, 13, 7, 3, 1 } },
+            { { 38498, 3841, 15361, 13, 7, 3, 1 } },
+            { { 38498, 3841, 15361, 13, 7, 3, 1 } },
+        },
+    },
 };
 
 static const VersalMap *VERSION_TO_MAP[] = {
     [VERSAL_VER_VERSAL] = &VERSAL_MAP,
 };
@@ -750,31 +787,10 @@ static void versal_create_sdhci(Versal *s,
     qemu_fdt_setprop_cells(s->cfg.fdt, node, "interrupts",
                            GIC_FDT_IRQ_TYPE_SPI, map->irq,
                            GIC_FDT_IRQ_FLAGS_LEVEL_HI);
 }
 
-static void versal_create_pmc_apb_irq_orgate(Versal *s, qemu_irq *pic)
-{
-    DeviceState *orgate;
-
-    /*
-     * The VERSAL_PMC_APB_IRQ is an 'or' of the interrupts from the following
-     * models:
-     *  - RTC
-     *  - BBRAM
-     *  - PMC SLCR
-     *  - CFRAME regs (input 3 - 17 to the orgate)
-     */
-    object_initialize_child(OBJECT(s), "pmc-apb-irq-orgate",
-                            &s->pmc.apb_irq_orgate, TYPE_OR_IRQ);
-    orgate = DEVICE(&s->pmc.apb_irq_orgate);
-    object_property_set_int(OBJECT(orgate),
-                            "num-lines", VERSAL_NUM_PMC_APB_IRQS, &error_fatal);
-    qdev_realize(orgate, NULL, &error_fatal);
-    qdev_connect_gpio_out(orgate, 0, pic[VERSAL_PMC_APB_IRQ]);
-}
-
 static void versal_create_rtc(Versal *s, const struct VersalRtcMap *map)
 {
     SysBusDevice *sbd;
     MemoryRegion *mr;
     g_autofree char *node;
@@ -989,158 +1005,115 @@ static DeviceState *versal_create_ospi(Versal *s,
     sysbus_connect_irq(SYS_BUS_DEVICE(dma_dst), 0, qdev_get_gpio_in(orgate, 2));
 
     return dev;
 }
 
-static void versal_create_cfu(Versal *s, qemu_irq *pic)
+static void versal_create_cfu(Versal *s, const struct VersalCfuMap *map)
 {
     SysBusDevice *sbd;
-    DeviceState *dev;
+    Object *container;
+    DeviceState *cfu_fdro, *cfu_apb, *cfu_sfr, *cframe_bcast;
+    DeviceState *cframe_irq_or;
     int i;
-    const struct {
+
+    container = object_new(TYPE_CONTAINER);
+    object_property_add_child(OBJECT(s), "cfu", container);
+    object_unref(container);
+
+    /* CFU FDRO */
+    cfu_fdro = qdev_new(TYPE_XLNX_VERSAL_CFU_FDRO);
+    object_property_add_child(container, "cfu-fdro", OBJECT(cfu_fdro));
+    sbd = SYS_BUS_DEVICE(cfu_fdro);
+
+    sysbus_realize_and_unref(sbd, &error_fatal);
+    memory_region_add_subregion(&s->mr_ps, map->cfu_fdro,
+                                sysbus_mmio_get_region(sbd, 0));
+
+    /* cframe bcast */
+    cframe_bcast = qdev_new(TYPE_XLNX_VERSAL_CFRAME_BCAST_REG);
+    object_property_add_child(container, "cframe-bcast", OBJECT(cframe_bcast));
+
+    /* CFU APB */
+    cfu_apb = qdev_new(TYPE_XLNX_VERSAL_CFU_APB);
+    object_property_add_child(container, "cfu-apb", OBJECT(cfu_apb));
+
+    /* IRQ or gate for cframes */
+    cframe_irq_or = qdev_new(TYPE_OR_IRQ);
+    object_property_add_child(container, "cframe-irq-or-gate",
+                              OBJECT(cframe_irq_or));
+    qdev_prop_set_uint16(cframe_irq_or, "num-lines", map->num_cframe);
+    qdev_realize_and_unref(cframe_irq_or, NULL, &error_abort);
+    versal_qdev_connect_gpio_out(s, cframe_irq_or, 0, map->cframe_irq);
+
+    /* cframe reg */
+    for (i = 0; i < map->num_cframe; i++) {
         uint64_t reg_base;
         uint64_t fdri_base;
-    } cframe_addr[] = {
-        { MM_PMC_CFRAME0_REG, MM_PMC_CFRAME0_FDRI },
-        { MM_PMC_CFRAME1_REG, MM_PMC_CFRAME1_FDRI },
-        { MM_PMC_CFRAME2_REG, MM_PMC_CFRAME2_FDRI },
-        { MM_PMC_CFRAME3_REG, MM_PMC_CFRAME3_FDRI },
-        { MM_PMC_CFRAME4_REG, MM_PMC_CFRAME4_FDRI },
-        { MM_PMC_CFRAME5_REG, MM_PMC_CFRAME5_FDRI },
-        { MM_PMC_CFRAME6_REG, MM_PMC_CFRAME6_FDRI },
-        { MM_PMC_CFRAME7_REG, MM_PMC_CFRAME7_FDRI },
-        { MM_PMC_CFRAME8_REG, MM_PMC_CFRAME8_FDRI },
-        { MM_PMC_CFRAME9_REG, MM_PMC_CFRAME9_FDRI },
-        { MM_PMC_CFRAME10_REG, MM_PMC_CFRAME10_FDRI },
-        { MM_PMC_CFRAME11_REG, MM_PMC_CFRAME11_FDRI },
-        { MM_PMC_CFRAME12_REG, MM_PMC_CFRAME12_FDRI },
-        { MM_PMC_CFRAME13_REG, MM_PMC_CFRAME13_FDRI },
-        { MM_PMC_CFRAME14_REG, MM_PMC_CFRAME14_FDRI },
-    };
-    const struct {
-        uint32_t blktype0_frames;
-        uint32_t blktype1_frames;
-        uint32_t blktype2_frames;
-        uint32_t blktype3_frames;
-        uint32_t blktype4_frames;
-        uint32_t blktype5_frames;
-        uint32_t blktype6_frames;
-    } cframe_cfg[] = {
-        [0] = { 34111, 3528, 12800, 11, 5, 1, 1 },
-        [1] = { 38498, 3841, 15361, 13, 7, 3, 1 },
-        [2] = { 38498, 3841, 15361, 13, 7, 3, 1 },
-        [3] = { 38498, 3841, 15361, 13, 7, 3, 1 },
-    };
+        DeviceState *dev;
+        g_autofree char *prop_name;
+        size_t j;
 
-    /* CFU FDRO */
-    object_initialize_child(OBJECT(s), "cfu-fdro", &s->pmc.cfu_fdro,
-                            TYPE_XLNX_VERSAL_CFU_FDRO);
-    sbd = SYS_BUS_DEVICE(&s->pmc.cfu_fdro);
+        dev = qdev_new(TYPE_XLNX_VERSAL_CFRAME_REG);
+        object_property_add_child(container, "cframe[*]", OBJECT(dev));
 
-    sysbus_realize(sbd, &error_fatal);
-    memory_region_add_subregion(&s->mr_ps, MM_PMC_CFU_FDRO,
-                                sysbus_mmio_get_region(sbd, 0));
+        sbd = SYS_BUS_DEVICE(dev);
 
-    /* CFRAME REG */
-    for (i = 0; i < ARRAY_SIZE(s->pmc.cframe); i++) {
-        g_autofree char *name = g_strdup_printf("cframe%d", i);
+        for (j = 0; j < ARRAY_SIZE(map->cframe_cfg[i].blktype_frames); j++) {
+            g_autofree char *blktype_prop_name;
 
-        object_initialize_child(OBJECT(s), name, &s->pmc.cframe[i],
-                                TYPE_XLNX_VERSAL_CFRAME_REG);
-
-        sbd = SYS_BUS_DEVICE(&s->pmc.cframe[i]);
-        dev = DEVICE(&s->pmc.cframe[i]);
-
-        if (i < ARRAY_SIZE(cframe_cfg)) {
-            object_property_set_int(OBJECT(dev), "blktype0-frames",
-                                    cframe_cfg[i].blktype0_frames,
-                                    &error_abort);
-            object_property_set_int(OBJECT(dev), "blktype1-frames",
-                                    cframe_cfg[i].blktype1_frames,
-                                    &error_abort);
-            object_property_set_int(OBJECT(dev), "blktype2-frames",
-                                    cframe_cfg[i].blktype2_frames,
-                                    &error_abort);
-            object_property_set_int(OBJECT(dev), "blktype3-frames",
-                                    cframe_cfg[i].blktype3_frames,
-                                    &error_abort);
-            object_property_set_int(OBJECT(dev), "blktype4-frames",
-                                    cframe_cfg[i].blktype4_frames,
-                                    &error_abort);
-            object_property_set_int(OBJECT(dev), "blktype5-frames",
-                                    cframe_cfg[i].blktype5_frames,
-                                    &error_abort);
-            object_property_set_int(OBJECT(dev), "blktype6-frames",
-                                    cframe_cfg[i].blktype6_frames,
+            blktype_prop_name = g_strdup_printf("blktype%zu-frames", j);
+            object_property_set_int(OBJECT(dev), blktype_prop_name,
+                                    map->cframe_cfg[i].blktype_frames[j],
                                     &error_abort);
         }
+
         object_property_set_link(OBJECT(dev), "cfu-fdro",
-                                 OBJECT(&s->pmc.cfu_fdro), &error_fatal);
+                                 OBJECT(cfu_fdro), &error_abort);
 
-        sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_abort);
 
-        memory_region_add_subregion(&s->mr_ps, cframe_addr[i].reg_base,
+        reg_base = map->cframe_base + i * map->cframe_stride * 2;
+        fdri_base = reg_base + map->cframe_stride;
+        memory_region_add_subregion(&s->mr_ps, reg_base,
                                     sysbus_mmio_get_region(sbd, 0));
-        memory_region_add_subregion(&s->mr_ps, cframe_addr[i].fdri_base,
+        memory_region_add_subregion(&s->mr_ps, fdri_base,
                                     sysbus_mmio_get_region(sbd, 1));
-        sysbus_connect_irq(sbd, 0,
-                           qdev_get_gpio_in(DEVICE(&s->pmc.apb_irq_orgate),
-                                            3 + i));
-    }
-
-    /* CFRAME BCAST */
-    object_initialize_child(OBJECT(s), "cframe_bcast", &s->pmc.cframe_bcast,
-                            TYPE_XLNX_VERSAL_CFRAME_BCAST_REG);
+        sysbus_connect_irq(sbd, 0, qdev_get_gpio_in(cframe_irq_or, i));
 
-    sbd = SYS_BUS_DEVICE(&s->pmc.cframe_bcast);
-    dev = DEVICE(&s->pmc.cframe_bcast);
-
-    for (i = 0; i < ARRAY_SIZE(s->pmc.cframe); i++) {
-        g_autofree char *propname = g_strdup_printf("cframe%d", i);
-        object_property_set_link(OBJECT(dev), propname,
-                                 OBJECT(&s->pmc.cframe[i]), &error_fatal);
+        prop_name = g_strdup_printf("cframe%d", i);
+        object_property_set_link(OBJECT(cframe_bcast), prop_name,
+                                 OBJECT(dev), &error_abort);
+        object_property_set_link(OBJECT(cfu_apb), prop_name,
+                                 OBJECT(dev), &error_abort);
     }
 
-    sysbus_realize(sbd, &error_fatal);
-
-    memory_region_add_subregion(&s->mr_ps, MM_PMC_CFRAME_BCAST_REG,
+    sbd = SYS_BUS_DEVICE(cframe_bcast);
+    sysbus_realize_and_unref(sbd, &error_abort);
+    memory_region_add_subregion(&s->mr_ps, map->cframe_bcast_reg,
                                 sysbus_mmio_get_region(sbd, 0));
-    memory_region_add_subregion(&s->mr_ps, MM_PMC_CFRAME_BCAST_FDRI,
+    memory_region_add_subregion(&s->mr_ps, map->cframe_bcast_fdri,
                                 sysbus_mmio_get_region(sbd, 1));
 
-    /* CFU APB */
-    object_initialize_child(OBJECT(s), "cfu-apb", &s->pmc.cfu_apb,
-                            TYPE_XLNX_VERSAL_CFU_APB);
-    sbd = SYS_BUS_DEVICE(&s->pmc.cfu_apb);
-    dev = DEVICE(&s->pmc.cfu_apb);
-
-    for (i = 0; i < ARRAY_SIZE(s->pmc.cframe); i++) {
-        g_autofree char *propname = g_strdup_printf("cframe%d", i);
-        object_property_set_link(OBJECT(dev), propname,
-                                 OBJECT(&s->pmc.cframe[i]), &error_fatal);
-    }
-
-    sysbus_realize(sbd, &error_fatal);
-    memory_region_add_subregion(&s->mr_ps, MM_PMC_CFU_APB,
+    sbd = SYS_BUS_DEVICE(cfu_apb);
+    sysbus_realize_and_unref(sbd, &error_fatal);
+    memory_region_add_subregion(&s->mr_ps, map->cfu_apb,
                                 sysbus_mmio_get_region(sbd, 0));
-    memory_region_add_subregion(&s->mr_ps, MM_PMC_CFU_STREAM,
+    memory_region_add_subregion(&s->mr_ps, map->cfu_stream,
                                 sysbus_mmio_get_region(sbd, 1));
-    memory_region_add_subregion(&s->mr_ps, MM_PMC_CFU_STREAM_2,
+    memory_region_add_subregion(&s->mr_ps, map->cfu_stream_2,
                                 sysbus_mmio_get_region(sbd, 2));
-    sysbus_connect_irq(sbd, 0, pic[VERSAL_CFU_IRQ_0]);
+    versal_sysbus_connect_irq(s, sbd, 0, map->cfu_apb_irq);
 
     /* CFU SFR */
-    object_initialize_child(OBJECT(s), "cfu-sfr", &s->pmc.cfu_sfr,
-                            TYPE_XLNX_VERSAL_CFU_SFR);
+    cfu_sfr = qdev_new(TYPE_XLNX_VERSAL_CFU_SFR);
+    object_property_add_child(container, "cfu-sfr", OBJECT(cfu_sfr));
+    sbd = SYS_BUS_DEVICE(cfu_sfr);
 
-    sbd = SYS_BUS_DEVICE(&s->pmc.cfu_sfr);
-
-    object_property_set_link(OBJECT(&s->pmc.cfu_sfr),
-                            "cfu", OBJECT(&s->pmc.cfu_apb), &error_abort);
-
-    sysbus_realize(sbd, &error_fatal);
-    memory_region_add_subregion(&s->mr_ps, MM_PMC_CFU_SFR,
+    object_property_set_link(OBJECT(cfu_sfr),
+                            "cfu", OBJECT(cfu_apb), &error_abort);
+    sysbus_realize_and_unref(sbd, &error_fatal);
+    memory_region_add_subregion(&s->mr_ps, map->cfu_sfr,
                                 sysbus_mmio_get_region(sbd, 0));
 }
 
 static void versal_create_crl(Versal *s, qemu_irq *pic)
 {
@@ -1366,14 +1339,13 @@ static void versal_realize(DeviceState *dev, Error **errp)
                                                        "ospi-mux-sel", 0));
 
     versal_create_bbram(s, &map->bbram);
     versal_create_trng(s, &map->trng);
     versal_create_rtc(s, &map->rtc);
+    versal_create_cfu(s, &map->cfu);
 
-    versal_create_pmc_apb_irq_orgate(s, pic);
     versal_create_crl(s, pic);
-    versal_create_cfu(s, pic);
     versal_map_ddr(s);
     versal_unimp(s);
 
     /* Create the On Chip Memory (OCM).  */
     memory_region_init_ram(&s->lpd.mr_ocm, OBJECT(s), "ocm",
-- 
2.50.1


