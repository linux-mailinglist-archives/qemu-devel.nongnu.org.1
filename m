Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2C0B072D2
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Jul 2025 12:12:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubysZ-0002eu-Qw; Wed, 16 Jul 2025 05:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubyrE-00016m-Aj; Wed, 16 Jul 2025 05:55:24 -0400
Received: from mail-co1nam11on2061e.outbound.protection.outlook.com
 ([2a01:111:f403:2416::61e]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubyrC-0006X4-05; Wed, 16 Jul 2025 05:55:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CyU3vDjrR6nhd34aIKxYjnGmVEEoBD2Yry2CHdZpJ4HSoocNYyiIak1ZOdTsX567Ugxvj0jq3u8shGyu6MZx3vixlTOvhOaQNrd2kflyxhaHHG8C6tStSHoUA/8cuO3S8RKw2mqQm86oaYLdxWpCDQ20iUZMopGqRKNjXX0IYfA3tNkIQjaWPzx+7ZJb6sqCqmUTxcMU+4mBnGg6PmvYXbY+X4s1/37Yb4YYdAwY4pC6YcVdbO4kmYlleeeM3EU0foi82fGCcuc+Y7bw8QyYcZe/sLjvaabF95cQgtLyvpKh0cfPnkls0OfPuj2EnEaHjavocxl2AbX8qj0LZqiviw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sOfktpFRkl4mU8gjjksUEPqtSXlW9A3BspmZi/i4bnw=;
 b=V/+gLZ9tUnDFyD7PHOcAUC4/QKUTn608x+3qVOmEGij+nQxsX3y6F7f/xMxYC1DUKzVFfIvSK8daf5VfOOWLK/uFBKbIEP2iyguiNQ8br3uS1FDwkihVsA6qH9vBvFJ40Fn9z4l6prDC9bmWcpwoflm/CVhnML+z7dDk7HCrh2F0k8q4mfA6NphZQyg/MrYja96rK4LXY331eNMoEjFCWgTLVNgiUgyDn74Q8df4dpAjmXic2B3Rr8xlkhfF0o/estxIW/ZQG0htw7lg0TV9Ky8rX/esHDwsamMEzd9bK4cBYhV4ZdtTWuonqK2wxOwS/UOz8q8aAhhu/ENPOVm4ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sOfktpFRkl4mU8gjjksUEPqtSXlW9A3BspmZi/i4bnw=;
 b=BR/XAMuKylCl5SYQK5wfVNhJ5WGFizDFyFE//Hi8qZMeGZGpcHo4VfB9NGQepfNfKNLvT6FWr8oRmgb7DA0J2ZXGApWzdzxD10X8UzCDWZLcyO6NASMmuYK0mln+E33b0VjzWJIB886x+QtvO2YVHTl24n2RdJJX2YTZaRMEf4g=
Received: from DM5PR08CA0056.namprd08.prod.outlook.com (2603:10b6:4:60::45) by
 SN7PR12MB6742.namprd12.prod.outlook.com (2603:10b6:806:26e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 09:55:13 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:4:60:cafe::95) by DM5PR08CA0056.outlook.office365.com
 (2603:10b6:4:60::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.17 via Frontend Transport; Wed,
 16 Jul 2025 09:55:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Wed, 16 Jul 2025 09:55:12 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 04:55:03 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 16 Jul 2025 04:55:01 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH 03/48] hw/arm/xlnx-versal: prepare for FDT creation
Date: Wed, 16 Jul 2025 11:53:45 +0200
Message-ID: <20250716095432.81923-4-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250716095432.81923-1-luc.michel@amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|SN7PR12MB6742:EE_
X-MS-Office365-Filtering-Correlation-Id: d1ebfe2c-234c-4864-5450-08ddc44edb92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VsE6ls/BeOtqgKpLXwvhE81ZksDS/pcyKgnEVuPNrnEKBYGwwP9b9iaLcwpR?=
 =?us-ascii?Q?wRNXOMiOjpzdF5ykY5zkY/z4v+Oal3/EEN03jDpwAlriooGb65xpZMgErd0H?=
 =?us-ascii?Q?lPWzvAOxLXc5FbiaPRoJKgSli39ReB70qIAroDBjlyFKPoqYS5YCFOF2MZUP?=
 =?us-ascii?Q?0/aiWc913m6HiNvW1V67EwfhNVyXlVDI3TChuGjGiA7xNl3SigVW4fTSbGCU?=
 =?us-ascii?Q?vsB38RgkAcMlsGt2FmXWzyW1VfEsDedfc6/nc16PBlBnqS3OSYUgU0Zv4a0A?=
 =?us-ascii?Q?xVg6ciiRDfLFHNkDAE9pOsmr4KTwZHplXq3lvwYggIX2vczShE4eKrfDJpR5?=
 =?us-ascii?Q?ZtusCRVNMNnbbX6vFJlIGK7RCEZiwUhb/O8qicaFeIKdw5xQlYi7gKCV552B?=
 =?us-ascii?Q?75WyOfMCNxE+N3xgOelIkLr1ONWYCBzCQD9rqh0+cWRN93uukQzmXXSLULfA?=
 =?us-ascii?Q?84JqrLLTqOU6GgdzaxPR7gx9/mvsdzWWZG1HnO0VL5W6SCgsmiegc/xKaUFP?=
 =?us-ascii?Q?Po7qIMoCURQtYKkZ+R8raQqNAXfOs2oqTDyvhFMbI8ypP9MMSCboj57mXvvS?=
 =?us-ascii?Q?h9cICHupGszEMPSMNQa/clMvpBH3128Cbj/qbXfdcq9zu0+bcZZG69GpeiLH?=
 =?us-ascii?Q?0MjyNh/x/kOLwQg60gr/sDYoA/1HwPn4bLMf955Ks42uDpJh82ktzbi/b8wk?=
 =?us-ascii?Q?xhKffIKxW3qv1HRUJwPPbrj9xSsfz8HF9+i4LWcXuUPTIXkNr7lXtT+8NiyE?=
 =?us-ascii?Q?qhILsdQVRbUqYjDDxtrsKGnXAGB4k6qnIWvhV29VR7aQ7SwvUFTqBFZ40R6L?=
 =?us-ascii?Q?kJXK1fI/VFfoTZiJ/tw2tpVpltHTQI0NLVEd5ViDE7yCR/mF51KIas2DLhk4?=
 =?us-ascii?Q?pbjf+8KHiL/1TadVcH5cJu6wKjnsed5CT/GgQ5kPw0ICxgK90b/DPmcVcdOn?=
 =?us-ascii?Q?5SUeXkB2deriC6HYE4W2GBX4W4rcuxK4RPvECSlUYi+dRE/P5OEX652xdfBf?=
 =?us-ascii?Q?JGDWxbXaoTrXwk2CDTCRYw6bPsnRHZQwl1RdVUfPQt+VjQW5sOWS2hqGUM+f?=
 =?us-ascii?Q?Dz2Jl6Yj5wZuJ+OkrEQRPujsP+21AxBTzpiKXPdmJb0ccm9w07azGpBf+LKE?=
 =?us-ascii?Q?nxiUhTd/cPMcoSCuSe1Mvh0ujmjxeNoPAPv8aZt+mxLbzmukiB77qBWQJ7Ip?=
 =?us-ascii?Q?UDMvyjvCFi/mS7chWxwlzeVR4hrhx5JDM9XMK+QZWUKFJDI+FUFcN0EGthIZ?=
 =?us-ascii?Q?4oa27X7urE+kPx64m9BGSCBCK+8CSzt/8mwLJ4RwkzuTmGtVWCvXplDXJafr?=
 =?us-ascii?Q?HCvYb+cvRqimIODQDgtIbLuGDCq2eob1V+6CB+uq8dA3RHigc+Ixh5QDnbJQ?=
 =?us-ascii?Q?edcU0BzHe56rxRppA8yd/EJ8hrPtMKR9cBo+pQNevsVcG5en2M9cT4v+iS8e?=
 =?us-ascii?Q?0/9DI/EAcn1qZA8YjC/Na8AkRC3iW9PBeSmSpsbpWgpkIbTrVF+YnnpRYFaP?=
 =?us-ascii?Q?LvAcGqzHnq/yrEt2Lg/j8zYtgynPNrjAS2/l?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 09:55:12.5951 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1ebfe2c-234c-4864-5450-08ddc44edb92
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6742
Received-SPF: permerror client-ip=2a01:111:f403:2416::61e;
 envelope-from=Luc.Michel@amd.com;
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

The following commits will move FDT creation logic from the
xlnx-versal-virt machine to the xlnx-versal SoC itself. Prepare this by
passing the FDT handle to the SoC before it is realized. If no FDT is
passed, a dummy one is created internally as a stub to the fdt function
calls.

For now the SoC only creates the two clock nodes. The ones from the
xlnx-versal virt machine are renamed with a `old-' prefix and will be
removed once they are not referenced anymore.

Signed-off-by: Luc Michel <luc.michel@amd.com>
---
 include/hw/arm/xlnx-versal.h | 12 ++++++++++++
 hw/arm/xlnx-versal-virt.c    | 11 +++++++----
 hw/arm/xlnx-versal.c         | 30 ++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index 1f92e314d6c..f2a62b43552 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -134,21 +134,33 @@ struct Versal {
         XlnxVersalCFrameBcastReg cframe_bcast;
 
         OrIRQState apb_irq_orgate;
     } pmc;
 
+    struct {
+        uint32_t clk_25mhz;
+        uint32_t clk_125mhz;
+    } phandle;
+
     struct {
         MemoryRegion *mr_ddr;
+        void *fdt;
     } cfg;
 };
 
 struct VersalClass {
     SysBusDeviceClass parent;
 
     VersalVersion version;
 };
 
+static inline void versal_set_fdt(Versal *s, void *fdt)
+{
+    g_assert(!qdev_is_realized(DEVICE(s)));
+    s->cfg.fdt = fdt;
+}
+
 /* Memory-map and IRQ definitions. Copied a subset from
  * auto-generated files.  */
 
 #define VERSAL_GIC_MAINT_IRQ        9
 #define VERSAL_TIMER_VIRT_IRQ       11
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index adadbb72902..c30dcca424c 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -1,9 +1,10 @@
 /*
  * Xilinx Versal Virtual board.
  *
  * Copyright (c) 2018 Xilinx Inc.
+ * Copyright (c) 2025, Advanced Micro Devices, Inc.
  * Written by Edgar E. Iglesias
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 or
  * (at your option) any later version.
@@ -695,14 +696,13 @@ static void versal_virt_init(MachineState *machine)
                              &error_abort);
     object_property_set_link(OBJECT(&s->soc), "canbus0", OBJECT(s->canbus[0]),
                              &error_abort);
     object_property_set_link(OBJECT(&s->soc), "canbus1", OBJECT(s->canbus[1]),
                              &error_abort);
-    sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
 
     fdt_create(s);
-    create_virtio_regions(s);
+    versal_set_fdt(&s->soc, s->fdt);
     fdt_add_gem_nodes(s);
     fdt_add_uart_nodes(s);
     fdt_add_canfd_nodes(s);
     fdt_add_gic_nodes(s);
     fdt_add_timer_nodes(s);
@@ -712,12 +712,15 @@ static void versal_virt_init(MachineState *machine)
     fdt_add_rtc_node(s);
     fdt_add_bbram_node(s);
     fdt_add_efuse_ctrl_node(s);
     fdt_add_efuse_cache_node(s);
     fdt_add_cpu_nodes(s, psci_conduit);
-    fdt_add_clk_node(s, "/clk125", 125000000, s->phandle.clk_125Mhz);
-    fdt_add_clk_node(s, "/clk25", 25000000, s->phandle.clk_25Mhz);
+    fdt_add_clk_node(s, "/old-clk125", 125000000, s->phandle.clk_125Mhz);
+    fdt_add_clk_node(s, "/old-clk25", 25000000, s->phandle.clk_25Mhz);
+
+    sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
+    create_virtio_regions(s);
 
     /* Make the APU cpu address space visible to virtio and other
      * modules unaware of multiple address-spaces.  */
     memory_region_add_subregion_overlap(get_system_memory(),
                                         0, &s->soc.fpd.apu.mr, 0);
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 4da656318f6..7bb55751e5c 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -22,10 +22,12 @@
 #include "hw/misc/unimp.h"
 #include "hw/arm/xlnx-versal.h"
 #include "qemu/log.h"
 #include "target/arm/cpu-qom.h"
 #include "target/arm/gtimer.h"
+#include "system/device_tree.h"
+#include "hw/arm/fdt.h"
 
 #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
 #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
 #define GEM_REVISION        0x40070106
 
@@ -917,14 +919,42 @@ static void versal_unimp(Versal *s)
     qdev_connect_gpio_out_named(DEVICE(&s->pmc.iou.slcr),
                                 SYSBUS_DEVICE_GPIO_IRQ, 0,
                                 gpio_in);
 }
 
+static uint32_t fdt_add_clk_node(Versal *s, const char *name,
+                                 unsigned int freq_hz)
+{
+    uint32_t phandle;
+
+    phandle = qemu_fdt_alloc_phandle(s->cfg.fdt);
+
+    qemu_fdt_add_subnode(s->cfg.fdt, name);
+    qemu_fdt_setprop_cell(s->cfg.fdt, name, "phandle", phandle);
+    qemu_fdt_setprop_cell(s->cfg.fdt, name, "clock-frequency", freq_hz);
+    qemu_fdt_setprop_cell(s->cfg.fdt, name, "#clock-cells", 0x0);
+    qemu_fdt_setprop_string(s->cfg.fdt, name, "compatible", "fixed-clock");
+    qemu_fdt_setprop(s->cfg.fdt, name, "u-boot,dm-pre-reloc", NULL, 0);
+
+    return phandle;
+}
+
 static void versal_realize(DeviceState *dev, Error **errp)
 {
     Versal *s = XLNX_VERSAL_BASE(dev);
     qemu_irq pic[XLNX_VERSAL_NR_IRQS];
+    const VersalMap *map = versal_get_map(s);
+    size_t i;
+
+    if (s->cfg.fdt == NULL) {
+        int fdt_size;
+
+        s->cfg.fdt = create_device_tree(&fdt_size);
+    }
+
+    s->phandle.clk_25mhz = fdt_add_clk_node(s, "/clk25", 25 * 1000 * 1000);
+    s->phandle.clk_125mhz = fdt_add_clk_node(s, "/clk125", 125 * 1000 * 1000);
 
     versal_create_apu_cpus(s);
     versal_create_apu_gic(s, pic);
     versal_create_rpu_cpus(s);
     versal_create_uarts(s, pic);
-- 
2.50.0


