Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8830ABA2AA5
	for <lists+qemu-devel@lfdr.de>; Fri, 26 Sep 2025 09:15:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v22b2-0006zZ-Qq; Fri, 26 Sep 2025 03:10:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22aH-0006Ya-TN; Fri, 26 Sep 2025 03:09:38 -0400
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22a0-0006ca-45; Fri, 26 Sep 2025 03:09:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sSKxuroClHa+G1Q2utld1SRIboiv7/RstPz3bIffDVgUM7ZGfw0qJT0zUyKaQ84vXcmty/xcHRV1A7L8zDfG0hRuLcEn9Un0GJnWZZxH/5OlKdXgg1ScrotT0JI+0KFAHq9PuLbiDeWzU5m39uX0HBdC44t8IRQt1Frm23sLXzf3PLouTIlhdPhNzSRX1BiSjNGy5lJ+MbdoxTXHtSWRfkmJ9s8yvTdFvWKnPinMshb/2WWgfdULexOROkY0TuYony980ThctWPTS+B7jM9WJJj5kws92wCiqD0oLoM97IXS8ySChbwwMGCkOSxO0wCRSJ8pDC9GN9FOr5Wxui/+zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/1+uMSSooA4VYwYndRLMb7OcmtUhSaq9iG3qGy5rBpU=;
 b=zBqw7AK85TuPB2lgjXaH+IIBz1z2XVSPeyED0dgN5DheE39qUdwGsAEZ8zHC/KgvsGdzw55g595ctYfhCMBVZrE6pBa9n1Gn8A2yQsVIoJF0H2/EEZjTkHRkDwyb0zhc+jmlYbee7C1PFuHnwP2L18STsYogr8xu4UjGnvGYswPd7kVmrpfZSKP7fr0lDmcBgm4DIdFSRi3olWD9IIIuCmd6U5OQbWjSLlmTXUotMbbcnIcwGTd+OrjSn0dlmB1XA74XnNsErY6hqnPFKUrQxQL+wwHK7iTGfmq509iWUT1DneCxChUzGGLddiQQQecmllRfHRJBgXYZszllnATPfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1+uMSSooA4VYwYndRLMb7OcmtUhSaq9iG3qGy5rBpU=;
 b=hXCRUmFYPQ1+/L16pybMl3sNf/DO5u8IOVRkxIHYbPZYJTo+/1u0Ta+6Ei0Ic461v76y82bFcozKc6yrFlySiaA4ki3jbYzHaQZc9CwGP7D0vw3E0CNfOy3A2T9zsK1LTQNo7ufcmX5bt1BAo8Anx4SNinGTSBXKYEEH1dCumP0=
Received: from DS7PR03CA0224.namprd03.prod.outlook.com (2603:10b6:5:3ba::19)
 by DS7PR12MB6264.namprd12.prod.outlook.com (2603:10b6:8:94::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Fri, 26 Sep
 2025 07:09:01 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:5:3ba:cafe::67) by DS7PR03CA0224.outlook.office365.com
 (2603:10b6:5:3ba::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Fri,
 26 Sep 2025 07:09:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Fri, 26 Sep 2025 07:09:01 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 26 Sep
 2025 00:08:49 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 26 Sep
 2025 00:08:48 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 26 Sep 2025 00:08:47 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v6 20/47] hw/arm/xlnx-versal: refactor CPU cluster creation
Date: Fri, 26 Sep 2025 09:07:38 +0200
Message-ID: <20250926070806.292065-21-luc.michel@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926070806.292065-1-luc.michel@amd.com>
References: <20250926070806.292065-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|DS7PR12MB6264:EE_
X-MS-Office365-Filtering-Correlation-Id: e7564203-03cb-4e54-28fa-08ddfccb9242
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QUJwWjJPdUlwTUw5WnhyR0dCc3c4NTdRcjh2cCtscDRBRHZLdnlLWmRPWktw?=
 =?utf-8?B?NnBwcW4wVFBJRjN3OFZoL1YveVlVYVN5OFB6VnJyR09Gc2dIenhhZ3c2bWFj?=
 =?utf-8?B?N0ZDL2UraDBwVEQzQVhTYVE0ekxJV3lQUGsrTkFucUNzTFNCSDBiM2RzZ3Rs?=
 =?utf-8?B?M2pWVlBydTJ6KzA2NEQya1cwWDNSa1NOcGMvQ3FWd0p2WGc5aHFxRk82bTBk?=
 =?utf-8?B?aHNvSHp0SjFxZWRBd0pxZ2JNMDZBZEQvSVY5UVN4S21JaTFMUGNYQVNOYURh?=
 =?utf-8?B?QmZLeVZtcGUrTzZnZXdOS3F6SGYwczV0UzIrSkRLYS9UV0NBRkZNQmpNaFFM?=
 =?utf-8?B?WnRyWHhrN2dmRzVEQTBIRkREellCV2FsdTl0MTM4U0hpQm1GK1NCVUlqbzIr?=
 =?utf-8?B?MlVzRmtZckRiR1NoaDJTaVc2TDZQYTZoYzViYmtFZXh5ZU5rQ0JMWGI2Lytl?=
 =?utf-8?B?TFhWWTg1YTRCa20wTW9lOUp6NEljaSs0QmxkR0NrdTJKYjFiaEd0WlNrY2Ux?=
 =?utf-8?B?OG1NWXNqR1JiQWVPRVFLN2xnbWZ2V1FGZXNtMFE4Y3ZvdDBXNnlKcGxobnVQ?=
 =?utf-8?B?ZzhIYzRLbzJVQm4vSVBTb2tpT0psKytFclRjUzY5Nm5ENGlYWGMwSGhyU29G?=
 =?utf-8?B?YmZCS2hvRDA3bkpHM2l4cFFGMFFQcXN5SWdqa2lZc1FEWTVJeXdkQi8zTGYw?=
 =?utf-8?B?QXoyWHZnbDB4QmhVTkxIdXJGQk5PeVhNQmdZUHpjVTN6OThxeGtaNTBKdHNZ?=
 =?utf-8?B?QXAxUzFaYWdLdHd0cnV2ak4vV0VCVU1jM3BJYWdKdkFMRHJlZDB5M05FQkhr?=
 =?utf-8?B?dDlZaU1kRVg2d3o3OXlFRkx1VXk1ZDFrQUdRV2tGT3JVZE4zMGhvbTRPc0dt?=
 =?utf-8?B?YW55Y1hIOHU1UlM4Sk1MZlN5eW8zd2FEZTVGMytIM2d1RE5NU3Iyc1VUZGpv?=
 =?utf-8?B?NWxwZUFBeGF4ZEd0YXQ1OHhkWGp3U0wwcFhwRjdKRUJqcGtLeTJodGZKdGdR?=
 =?utf-8?B?ZFVlN0FCdlFlbEkrak5DMGFCcmR5a3NCVVc4WHE5RTlrVHppaWl1VUdPTkNB?=
 =?utf-8?B?M0tyNkxSQWJVOVhaZDkwV01SM1lhaVlWN1NxNkoreWcxc0diRXdOSzBrM2Ev?=
 =?utf-8?B?YkgwaXlFVDY4eU5jWUNPa25mc2RCREpHaVFCNm1XNGhUZVpvMktQMWNXNW1s?=
 =?utf-8?B?L1RqYWQzdUV6Q21ha1A5djBnVW1DZmxXUWR4Zm10QW5FSUxoa0RrQ3NNanZ2?=
 =?utf-8?B?ejVnUm9RTlMwOUhJZjlEVEJDa0NVQ01lTU95emIyVnBwWGNXR2N1SU1TbVd0?=
 =?utf-8?B?OEV5V3ZObVZrM2tYakNUOXFSZU1xTTNUWkFtbFhyYWM1akVpK2drU0lHbU4y?=
 =?utf-8?B?b0ZIV0RkU3RDQmxKdTNYRGdUYnFWMitvUFh6M1lYTlBZUnpRUWpvc2hIdU5R?=
 =?utf-8?B?TVYxOHFDREJDVmN6T2JIeXUyZ0oybkJWa1Q5Wk9QNlRZUnVCQjJkcVFkL28w?=
 =?utf-8?B?akhyMXQxVWdranRKU1pVLzVFUmYxRFI3aFF2Q0xIN0FnSks2WTBJRVNENmh6?=
 =?utf-8?B?ZmhjT0duMUR3eFNSRUR6VUpNclphcGlBZUhmNXExVDVNemRCbkVHcEt5amZo?=
 =?utf-8?B?R1ZaZENEYlpGcmdyQWhjQzEyVThGVTdrTG92OFBFZ1VpM1BwQk45Ynp4Rkx2?=
 =?utf-8?B?Zy9FS3VHVmtrRkdjRTNrV1N0bnVpZ3ZrZTE1Mi9XNFFQTUZvcWw5TzRybmNz?=
 =?utf-8?B?Y1JWTmIxVEVuSWhGV3l4R2ZpNVpqblpiSVRlZEpiRFZYQ1R0eDBlaWRwVnIx?=
 =?utf-8?B?MndSeFpoRjZhTmpGWHlDTjdpV1hCaWRQNnRsRXJzdGwzbll5ZzBVMjJUb3Jx?=
 =?utf-8?B?elNhdFNhemxZMTZRQVo3V3RlblZCVFFlV0NYM1pvNk11T1J0bGltTEFVNHFL?=
 =?utf-8?B?enBVRzNMZWpHcUlVUUVOVWx1aXB1YnNROFRobjV4WkUxaE9ucUxXZ1Biem9x?=
 =?utf-8?B?Z0xGb3NOaXNOTTljWXEwRlFoRi9CS1AvVzQ0T1hxcGYvUVZYMTY2YjJJS1dK?=
 =?utf-8?Q?XQ17Ol?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 07:09:01.8094 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7564203-03cb-4e54-28fa-08ddfccb9242
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6264
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=Luc.Michel@amd.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Refactor the CPU cluster creation using the VersalMap structure. There
is no functional change. The clusters properties are now described in
the VersalMap structure. For now only the APU is converted. The RPU will
be taken care of by next commits.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 include/hw/arm/xlnx-versal.h |  12 +-
 hw/arm/xlnx-versal-virt.c    |  80 +-------
 hw/arm/xlnx-versal.c         | 352 ++++++++++++++++++++++++++---------
 3 files changed, 275 insertions(+), 169 deletions(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index af47acb288f..9d9ccfb0014 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -13,11 +13,10 @@
 #ifndef XLNX_VERSAL_H
 #define XLNX_VERSAL_H
 
 #include "hw/sysbus.h"
 #include "hw/cpu/cluster.h"
-#include "hw/intc/arm_gicv3.h"
 #include "qom/object.h"
 #include "net/can_emu.h"
 #include "target/arm/cpu.h"
 #include "hw/arm/xlnx-versal-version.h"
 
@@ -41,19 +40,10 @@ OBJECT_DECLARE_TYPE(Versal, VersalClass, XLNX_VERSAL_BASE)
 struct Versal {
     /*< private >*/
     SysBusDevice parent_obj;
 
     /*< public >*/
-    struct {
-        struct {
-            MemoryRegion mr;
-            CPUClusterState cluster;
-            ARMCPU cpu[XLNX_VERSAL_NR_ACPUS];
-            GICv3State gic;
-        } apu;
-    } fpd;
-
     MemoryRegion mr_ps;
 
     struct {
         /* 4 ranges to access DDR.  */
         MemoryRegion mr_ddr_ranges[4];
@@ -73,10 +63,11 @@ struct Versal {
     } lpd;
 
     struct {
         uint32_t clk_25mhz;
         uint32_t clk_125mhz;
+        uint32_t gic;
     } phandle;
 
     struct {
         MemoryRegion *mr_ddr;
         CanBusState **canbus;
@@ -94,10 +85,11 @@ static inline void versal_set_fdt(Versal *s, void *fdt)
 {
     g_assert(!qdev_is_realized(DEVICE(s)));
     s->cfg.fdt = fdt;
 }
 
+DeviceState *versal_get_boot_cpu(Versal *s);
 void versal_sdhci_plug_card(Versal *s, int sd_idx, BlockBackend *blk);
 void versal_efuse_attach_drive(Versal *s, BlockBackend *blk);
 void versal_bbram_attach_drive(Versal *s, BlockBackend *blk);
 void versal_ospi_create_flash(Versal *s, int flash_idx, const char *flash_mdl,
                               BlockBackend *blk);
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index b981d012558..27594f78c8f 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -36,11 +36,10 @@ struct VersalVirt {
     Versal soc;
 
     void *fdt;
     int fdt_size;
     struct {
-        uint32_t gic;
         uint32_t clk_125Mhz;
         uint32_t clk_25Mhz;
     } phandle;
     struct arm_boot_info binfo;
 
@@ -61,22 +60,18 @@ static void fdt_create(VersalVirt *s)
         error_report("create_device_tree() failed");
         exit(1);
     }
 
     /* Allocate all phandles.  */
-    s->phandle.gic = qemu_fdt_alloc_phandle(s->fdt);
     s->phandle.clk_25Mhz = qemu_fdt_alloc_phandle(s->fdt);
     s->phandle.clk_125Mhz = qemu_fdt_alloc_phandle(s->fdt);
 
     /* Create /chosen node for load_dtb.  */
     qemu_fdt_add_subnode(s->fdt, "/chosen");
     qemu_fdt_add_subnode(s->fdt, "/aliases");
 
     /* Header */
-    qemu_fdt_setprop_cell(s->fdt, "/", "interrupt-parent", s->phandle.gic);
-    qemu_fdt_setprop_cell(s->fdt, "/", "#size-cells", 0x2);
-    qemu_fdt_setprop_cell(s->fdt, "/", "#address-cells", 0x2);
     qemu_fdt_setprop_string(s->fdt, "/", "model", mc->desc);
     qemu_fdt_setprop_string(s->fdt, "/", "compatible", "xlnx-versal-virt");
 }
 
 static void fdt_add_clk_node(VersalVirt *s, const char *name,
@@ -88,71 +83,10 @@ static void fdt_add_clk_node(VersalVirt *s, const char *name,
     qemu_fdt_setprop_cell(s->fdt, name, "#clock-cells", 0x0);
     qemu_fdt_setprop_string(s->fdt, name, "compatible", "fixed-clock");
     qemu_fdt_setprop(s->fdt, name, "u-boot,dm-pre-reloc", NULL, 0);
 }
 
-static void fdt_add_cpu_nodes(VersalVirt *s, uint32_t psci_conduit)
-{
-    int i;
-
-    qemu_fdt_add_subnode(s->fdt, "/cpus");
-    qemu_fdt_setprop_cell(s->fdt, "/cpus", "#size-cells", 0x0);
-    qemu_fdt_setprop_cell(s->fdt, "/cpus", "#address-cells", 1);
-
-    for (i = XLNX_VERSAL_NR_ACPUS - 1; i >= 0; i--) {
-        char *name = g_strdup_printf("/cpus/cpu@%d", i);
-        ARMCPU *armcpu = ARM_CPU(qemu_get_cpu(i));
-
-        qemu_fdt_add_subnode(s->fdt, name);
-        qemu_fdt_setprop_cell(s->fdt, name, "reg",
-                              arm_cpu_mp_affinity(armcpu));
-        if (psci_conduit != QEMU_PSCI_CONDUIT_DISABLED) {
-            qemu_fdt_setprop_string(s->fdt, name, "enable-method", "psci");
-        }
-        qemu_fdt_setprop_string(s->fdt, name, "device_type", "cpu");
-        qemu_fdt_setprop_string(s->fdt, name, "compatible",
-                                armcpu->dtb_compatible);
-        g_free(name);
-    }
-}
-
-static void fdt_add_gic_nodes(VersalVirt *s)
-{
-    char *nodename;
-
-    nodename = g_strdup_printf("/gic@%x", MM_GIC_APU_DIST_MAIN);
-    qemu_fdt_add_subnode(s->fdt, nodename);
-    qemu_fdt_setprop_cell(s->fdt, nodename, "phandle", s->phandle.gic);
-    qemu_fdt_setprop_cells(s->fdt, nodename, "interrupts",
-                           GIC_FDT_IRQ_TYPE_PPI, VERSAL_GIC_MAINT_IRQ,
-                           GIC_FDT_IRQ_FLAGS_LEVEL_HI);
-    qemu_fdt_setprop(s->fdt, nodename, "interrupt-controller", NULL, 0);
-    qemu_fdt_setprop_sized_cells(s->fdt, nodename, "reg",
-                                 2, MM_GIC_APU_DIST_MAIN,
-                                 2, MM_GIC_APU_DIST_MAIN_SIZE,
-                                 2, MM_GIC_APU_REDIST_0,
-                                 2, MM_GIC_APU_REDIST_0_SIZE);
-    qemu_fdt_setprop_cell(s->fdt, nodename, "#interrupt-cells", 3);
-    qemu_fdt_setprop_string(s->fdt, nodename, "compatible", "arm,gic-v3");
-    g_free(nodename);
-}
-
-static void fdt_add_timer_nodes(VersalVirt *s)
-{
-    const char compat[] = "arm,armv8-timer";
-    uint32_t irqflags = GIC_FDT_IRQ_FLAGS_LEVEL_HI;
-
-    qemu_fdt_add_subnode(s->fdt, "/timer");
-    qemu_fdt_setprop_cells(s->fdt, "/timer", "interrupts",
-            GIC_FDT_IRQ_TYPE_PPI, VERSAL_TIMER_S_EL1_IRQ, irqflags,
-            GIC_FDT_IRQ_TYPE_PPI, VERSAL_TIMER_NS_EL1_IRQ, irqflags,
-            GIC_FDT_IRQ_TYPE_PPI, VERSAL_TIMER_VIRT_IRQ, irqflags,
-            GIC_FDT_IRQ_TYPE_PPI, VERSAL_TIMER_NS_EL2_IRQ, irqflags);
-    qemu_fdt_setprop(s->fdt, "/timer", "compatible",
-                     compat, sizeof(compat));
-}
-
 static void fdt_nop_memory_nodes(void *fdt, Error **errp)
 {
     Error *err = NULL;
     char **node_path;
     int n = 0;
@@ -394,20 +328,18 @@ static void versal_virt_init(MachineState *machine)
     fdt_create(s);
     versal_set_fdt(&s->soc, s->fdt);
     sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
     create_virtio_regions(s);
 
-    fdt_add_gic_nodes(s);
-    fdt_add_timer_nodes(s);
-    fdt_add_cpu_nodes(s, psci_conduit);
     fdt_add_clk_node(s, "/old-clk125", 125000000, s->phandle.clk_125Mhz);
     fdt_add_clk_node(s, "/old-clk25", 25000000, s->phandle.clk_25Mhz);
 
-    /* Make the APU cpu address space visible to virtio and other
-     * modules unaware of multiple address-spaces.  */
-    memory_region_add_subregion_overlap(get_system_memory(),
-                                        0, &s->soc.fpd.apu.mr, 0);
+    /*
+     * Map the SoC address space onto system memory. This will allow virtio and
+     * other modules unaware of multiple address-spaces to work.
+     */
+    memory_region_add_subregion(get_system_memory(), 0, &s->soc.mr_ps);
 
     /* Attach bbram backend, if given */
     bbram_attach_drive(s);
 
     /* Attach efuse backend, if given */
@@ -427,11 +359,11 @@ static void versal_virt_init(MachineState *machine)
         /* Some boot-loaders (e.g u-boot) don't like blobs at address 0 (NULL).
          * Offset things by 4K.  */
         s->binfo.loader_start = 0x1000;
         s->binfo.dtb_limit = 0x1000000;
     }
-    arm_load_kernel(&s->soc.fpd.apu.cpu[0], machine, &s->binfo);
+    arm_load_kernel(ARM_CPU(versal_get_boot_cpu(&s->soc)), machine, &s->binfo);
 
     for (i = 0; i < XLNX_VERSAL_NUM_OSPI_FLASH; i++) {
         ObjectClass *flash_klass;
         DriveInfo *dinfo = drive_get(IF_MTD, 0, i);
         BlockBackend *blk;
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 23aac709dc4..b4cad856dc2 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -41,10 +41,11 @@
 #include "hw/rtc/xlnx-zynqmp-rtc.h"
 #include "hw/misc/xlnx-versal-cfu.h"
 #include "hw/misc/xlnx-versal-cframe-reg.h"
 #include "hw/or-irq.h"
 #include "hw/misc/xlnx-versal-crl.h"
+#include "hw/intc/arm_gicv3_common.h"
 
 #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
 #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
 #define GEM_REVISION        0x40070106
 
@@ -65,11 +66,38 @@ FIELD(VERSAL_IRQ, OR_IDX, 19, 4) /* input index on the IRQ OR gate */
 typedef struct VersalSimplePeriphMap {
     uint64_t addr;
     int irq;
 } VersalSimplePeriphMap;
 
+typedef struct VersalGicMap {
+    int version;
+    uint64_t dist;
+    uint64_t redist;
+    size_t num_irq;
+} VersalGicMap;
+
+enum StartPoweredOffMode {
+    SPO_SECONDARIES,
+    SPO_ALL,
+};
+
+typedef struct VersalCpuClusterMap {
+    VersalGicMap gic;
+
+    const char *name;
+    const char *cpu_model;
+    size_t num_core;
+    size_t num_cluster;
+    uint32_t qemu_cluster_id;
+    bool dtb_expose;
+
+    enum StartPoweredOffMode start_powered_off;
+} VersalCpuClusterMap;
+
 typedef struct VersalMap {
+    VersalCpuClusterMap apu;
+
     VersalSimplePeriphMap uart[2];
     size_t num_uart;
 
     VersalSimplePeriphMap canfd[4];
     size_t num_canfd;
@@ -162,10 +190,26 @@ typedef struct VersalMap {
         int irq_num;
     } reserved;
 } VersalMap;
 
 static const VersalMap VERSAL_MAP = {
+    .apu = {
+        .name = "apu",
+        .cpu_model = ARM_CPU_TYPE_NAME("cortex-a72"),
+        .num_cluster = 1,
+        .num_core = 2,
+        .qemu_cluster_id = 0,
+        .start_powered_off = SPO_SECONDARIES,
+        .dtb_expose = true,
+        .gic = {
+            .version = 3,
+            .dist = 0xf9000000,
+            .redist = 0xf9080000,
+            .num_irq = 192,
+        },
+    },
+
     .uart[0] = { 0xff000000, 18 },
     .uart[1] = { 0xff010000, 19 },
     .num_uart = 2,
 
     .canfd[0] = { 0xff060000, 20 },
@@ -292,15 +336,16 @@ static qemu_irq versal_get_irq_or_gate_in(Versal *s, int irq_idx,
 
 static qemu_irq versal_get_irq(Versal *s, int irq_idx)
 {
     qemu_irq irq;
     bool ored;
+    DeviceState *gic;
 
     ored = FIELD_EX32(irq_idx, VERSAL_IRQ, ORED);
 
-    irq = qdev_get_gpio_in(DEVICE(&s->fpd.apu.gic),
-                           FIELD_EX32(irq_idx, VERSAL_IRQ, IRQ));
+    gic = DEVICE(versal_get_child_idx(s, "apu-gic", 0));
+    irq = qdev_get_gpio_in(gic, FIELD_EX32(irq_idx, VERSAL_IRQ, IRQ));
 
     if (ored) {
         irq = versal_get_irq_or_gate_in(s, irq_idx, irq);
     }
 
@@ -373,111 +418,243 @@ static inline DeviceState *create_or_gate(Versal *s, Object *parent,
     versal_qdev_connect_gpio_out(s, or, 0, irq_idx);
 
     return or;
 }
 
-static void versal_create_apu_cpus(Versal *s)
+static MemoryRegion *create_cpu_mr(Versal *s, DeviceState *cluster,
+                                   const VersalCpuClusterMap *map)
 {
-    int i;
+    MemoryRegion *mr, *root_alias;
+    char *name;
 
-    object_initialize_child(OBJECT(s), "apu-cluster", &s->fpd.apu.cluster,
-                            TYPE_CPU_CLUSTER);
-    qdev_prop_set_uint32(DEVICE(&s->fpd.apu.cluster), "cluster-id", 0);
+    mr = g_new(MemoryRegion, 1);
+    name = g_strdup_printf("%s-mr", map->name);
+    memory_region_init(mr, OBJECT(cluster), name, UINT64_MAX);
+    g_free(name);
 
-    for (i = 0; i < ARRAY_SIZE(s->fpd.apu.cpu); i++) {
-        Object *obj;
+    root_alias = g_new(MemoryRegion, 1);
+    name = g_strdup_printf("ps-alias-for-%s", map->name);
+    memory_region_init_alias(root_alias, OBJECT(cluster), name,
+                             &s->mr_ps, 0, UINT64_MAX);
+    g_free(name);
+    memory_region_add_subregion(mr, 0, root_alias);
 
-        object_initialize_child(OBJECT(&s->fpd.apu.cluster),
-                                "apu-cpu[*]", &s->fpd.apu.cpu[i],
-                                XLNX_VERSAL_ACPU_TYPE);
-        obj = OBJECT(&s->fpd.apu.cpu[i]);
-        if (i) {
-            /* Secondary CPUs start in powered-down state */
-            object_property_set_bool(obj, "start-powered-off", true,
-                                     &error_abort);
-        }
-
-        object_property_set_int(obj, "core-count", ARRAY_SIZE(s->fpd.apu.cpu),
-                                &error_abort);
-        object_property_set_link(obj, "memory", OBJECT(&s->fpd.apu.mr),
-                                 &error_abort);
-        qdev_realize(DEVICE(obj), NULL, &error_fatal);
-    }
-
-    qdev_realize(DEVICE(&s->fpd.apu.cluster), NULL, &error_fatal);
+    return mr;
 }
 
-static void versal_create_apu_gic(Versal *s, qemu_irq *pic)
+static DeviceState *versal_create_gic(Versal *s,
+                                      const VersalCpuClusterMap *map,
+                                      MemoryRegion *mr,
+                                      size_t num_cpu)
 {
-    static const uint64_t addrs[] = {
-        MM_GIC_APU_DIST_MAIN,
-        MM_GIC_APU_REDIST_0
-    };
-    SysBusDevice *gicbusdev;
-    DeviceState *gicdev;
+    DeviceState *dev;
+    SysBusDevice *sbd;
     QList *redist_region_count;
-    int nr_apu_cpus = ARRAY_SIZE(s->fpd.apu.cpu);
-    int i;
+    g_autofree char *node = NULL;
+    g_autofree char *name = NULL;
+    const char compatible[] = "arm,gic-v3";
 
-    object_initialize_child(OBJECT(s), "apu-gic", &s->fpd.apu.gic,
-                            gicv3_class_name());
-    gicbusdev = SYS_BUS_DEVICE(&s->fpd.apu.gic);
-    gicdev = DEVICE(&s->fpd.apu.gic);
-    qdev_prop_set_uint32(gicdev, "revision", 3);
-    qdev_prop_set_uint32(gicdev, "num-cpu", nr_apu_cpus);
-    qdev_prop_set_uint32(gicdev, "num-irq", XLNX_VERSAL_NR_IRQS + 32);
+    dev = qdev_new(gicv3_class_name());
+    name = g_strdup_printf("%s-gic[*]", map->name);
+    object_property_add_child(OBJECT(s), name, OBJECT(dev));
+    sbd = SYS_BUS_DEVICE(dev);
+    qdev_prop_set_uint32(dev, "revision", 3);
+    qdev_prop_set_uint32(dev, "num-cpu", num_cpu);
+    qdev_prop_set_uint32(dev, "num-irq", map->gic.num_irq + 32);
 
     redist_region_count = qlist_new();
-    qlist_append_int(redist_region_count, nr_apu_cpus);
-    qdev_prop_set_array(gicdev, "redist-region-count", redist_region_count);
+    qlist_append_int(redist_region_count, num_cpu);
+    qdev_prop_set_array(dev, "redist-region-count", redist_region_count);
 
-    qdev_prop_set_bit(gicdev, "has-security-extensions", true);
+    qdev_prop_set_bit(dev, "has-security-extensions", true);
+    object_property_set_link(OBJECT(dev), "sysmem", OBJECT(mr), &error_abort);
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->fpd.apu.gic), &error_fatal);
+    sysbus_realize_and_unref(sbd, &error_fatal);
 
-    for (i = 0; i < ARRAY_SIZE(addrs); i++) {
-        MemoryRegion *mr;
+    memory_region_add_subregion(mr, map->gic.dist,
+                                sysbus_mmio_get_region(sbd, 0));
+    memory_region_add_subregion(mr, map->gic.redist,
+                                sysbus_mmio_get_region(sbd, 1));
 
-        mr = sysbus_mmio_get_region(gicbusdev, i);
-        memory_region_add_subregion(&s->fpd.apu.mr, addrs[i], mr);
+    if (map->dtb_expose) {
+        node = versal_fdt_add_subnode(s, "/gic", map->gic.dist, compatible,
+                                      sizeof(compatible));
+        qemu_fdt_setprop_cell(s->cfg.fdt, node, "phandle", s->phandle.gic);
+        qemu_fdt_setprop_cell(s->cfg.fdt, node, "#interrupt-cells", 3);
+        qemu_fdt_setprop_sized_cells(s->cfg.fdt, node, "reg",
+                                     2, map->gic.dist,
+                                     2, 0x10000,
+                                     2, map->gic.redist,
+                                     2, GICV3_REDIST_SIZE * num_cpu);
+        qemu_fdt_setprop_cells(s->cfg.fdt, node, "interrupts",
+                               GIC_FDT_IRQ_TYPE_PPI, VERSAL_GIC_MAINT_IRQ,
+                               GIC_FDT_IRQ_FLAGS_LEVEL_HI);
+        qemu_fdt_setprop(s->cfg.fdt, node, "interrupt-controller", NULL, 0);
     }
 
-    for (i = 0; i < nr_apu_cpus; i++) {
-        DeviceState *cpudev = DEVICE(&s->fpd.apu.cpu[i]);
-        int ppibase = XLNX_VERSAL_NR_IRQS + i * GIC_INTERNAL + GIC_NR_SGIS;
-        qemu_irq maint_irq;
-        int ti;
-        /* Mapping from the output timer irq lines from the CPU to the
-         * GIC PPI inputs.
-         */
-        const int timer_irq[] = {
-            [GTIMER_PHYS] = VERSAL_TIMER_NS_EL1_IRQ,
-            [GTIMER_VIRT] = VERSAL_TIMER_VIRT_IRQ,
-            [GTIMER_HYP]  = VERSAL_TIMER_NS_EL2_IRQ,
-            [GTIMER_SEC]  = VERSAL_TIMER_S_EL1_IRQ,
-        };
+    return dev;
+}
 
+static void connect_gic_to_cpu(const VersalCpuClusterMap *map,
+                               DeviceState *gic, DeviceState *cpu, size_t idx,
+                               size_t num_cpu)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(gic);
+    int ppibase = map->gic.num_irq + idx * GIC_INTERNAL + GIC_NR_SGIS;
+    int ti;
+    bool has_gtimer;
+    /*
+     * Mapping from the output timer irq lines from the CPU to the
+     * GIC PPI inputs.
+     */
+    const int timer_irq[] = {
+        [GTIMER_PHYS] = VERSAL_TIMER_NS_EL1_IRQ,
+        [GTIMER_VIRT] = VERSAL_TIMER_VIRT_IRQ,
+        [GTIMER_HYP]  = VERSAL_TIMER_NS_EL2_IRQ,
+        [GTIMER_SEC]  = VERSAL_TIMER_S_EL1_IRQ,
+    };
+
+    has_gtimer = arm_feature(&ARM_CPU(cpu)->env, ARM_FEATURE_GENERIC_TIMER);
+
+    if (has_gtimer) {
         for (ti = 0; ti < ARRAY_SIZE(timer_irq); ti++) {
-            qdev_connect_gpio_out(cpudev, ti,
-                                  qdev_get_gpio_in(gicdev,
+            qdev_connect_gpio_out(cpu, ti,
+                                  qdev_get_gpio_in(gic,
                                                    ppibase + timer_irq[ti]));
         }
-        maint_irq = qdev_get_gpio_in(gicdev,
-                                        ppibase + VERSAL_GIC_MAINT_IRQ);
-        qdev_connect_gpio_out_named(cpudev, "gicv3-maintenance-interrupt",
+    }
+
+    if (map->gic.version == 3) {
+        qemu_irq maint_irq;
+
+        maint_irq = qdev_get_gpio_in(gic,
+                                     ppibase + VERSAL_GIC_MAINT_IRQ);
+        qdev_connect_gpio_out_named(cpu, "gicv3-maintenance-interrupt",
                                     0, maint_irq);
-        sysbus_connect_irq(gicbusdev, i, qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
-        sysbus_connect_irq(gicbusdev, i + nr_apu_cpus,
-                           qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
-        sysbus_connect_irq(gicbusdev, i + 2 * nr_apu_cpus,
-                           qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
-        sysbus_connect_irq(gicbusdev, i + 3 * nr_apu_cpus,
-                           qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
     }
 
-    for (i = 0; i < XLNX_VERSAL_NR_IRQS; i++) {
-        pic[i] = qdev_get_gpio_in(gicdev, i);
+    sysbus_connect_irq(sbd, idx, qdev_get_gpio_in(cpu, ARM_CPU_IRQ));
+    sysbus_connect_irq(sbd, idx + num_cpu,
+                       qdev_get_gpio_in(cpu, ARM_CPU_FIQ));
+    sysbus_connect_irq(sbd, idx + 2 * num_cpu,
+                       qdev_get_gpio_in(cpu, ARM_CPU_VIRQ));
+    sysbus_connect_irq(sbd, idx + 3 * num_cpu,
+                       qdev_get_gpio_in(cpu, ARM_CPU_VFIQ));
+}
+
+static inline void versal_create_and_connect_gic(Versal *s,
+                                                 const VersalCpuClusterMap *map,
+                                                 MemoryRegion *mr,
+                                                 DeviceState **cpus,
+                                                 size_t num_cpu)
+{
+    DeviceState *gic;
+    size_t i;
+
+    gic = versal_create_gic(s, map, mr, num_cpu);
+
+    for (i = 0; i < num_cpu; i++) {
+        connect_gic_to_cpu(map, gic, cpus[i], i, num_cpu);
+    }
+}
+
+static DeviceState *versal_create_cpu(Versal *s,
+                                      const VersalCpuClusterMap *map,
+                                      DeviceState *qemu_cluster,
+                                      MemoryRegion *cpu_mr,
+                                      size_t cluster_idx,
+                                      size_t core_idx)
+{
+    DeviceState *cpu = qdev_new(map->cpu_model);
+    ARMCPU *arm_cpu = ARM_CPU(cpu);
+    Object *obj = OBJECT(cpu);
+    bool start_off;
+    size_t idx = cluster_idx * map->num_core + core_idx;
+    g_autofree char *name;
+    g_autofree char *node = NULL;
+
+    start_off = map->start_powered_off == SPO_ALL
+        || ((map->start_powered_off == SPO_SECONDARIES)
+            && (cluster_idx || core_idx));
+
+    name = g_strdup_printf("%s[*]", map->name);
+    object_property_add_child(OBJECT(qemu_cluster), name, obj);
+    object_property_set_bool(obj, "start-powered-off", start_off,
+                             &error_abort);
+    qdev_prop_set_int32(cpu, "core-count",  map->num_core);
+    object_property_set_link(obj, "memory", OBJECT(cpu_mr), &error_abort);
+    qdev_realize_and_unref(cpu, NULL, &error_fatal);
+
+    if (!map->dtb_expose) {
+        return cpu;
+    }
+
+    node = versal_fdt_add_subnode(s, "/cpus/cpu", idx,
+                                  arm_cpu->dtb_compatible,
+                                  strlen(arm_cpu->dtb_compatible) + 1);
+    qemu_fdt_setprop_cell(s->cfg.fdt, node, "reg",
+                          arm_cpu_mp_affinity(arm_cpu) & ARM64_AFFINITY_MASK);
+    qemu_fdt_setprop_string(s->cfg.fdt, node, "device_type", "cpu");
+    qemu_fdt_setprop_string(s->cfg.fdt, node, "enable-method", "psci");
+
+    return cpu;
+}
+
+static void versal_create_cpu_cluster(Versal *s, const VersalCpuClusterMap *map)
+{
+    size_t i, j;
+    DeviceState *cluster;
+    MemoryRegion *mr;
+    char *name;
+    g_autofree DeviceState **cpus;
+    const char compatible[] = "arm,armv8-timer";
+    bool has_gtimer;
+
+    cluster = qdev_new(TYPE_CPU_CLUSTER);
+    name = g_strdup_printf("%s-cluster", map->name);
+    object_property_add_child(OBJECT(s), name, OBJECT(cluster));
+    g_free(name);
+    qdev_prop_set_uint32(cluster, "cluster-id", map->qemu_cluster_id);
+
+    mr = create_cpu_mr(s, cluster, map);
+
+    cpus = g_new(DeviceState *, map->num_cluster * map->num_core);
+
+    if (map->dtb_expose) {
+        qemu_fdt_add_subnode(s->cfg.fdt, "/cpus");
+        qemu_fdt_setprop_cell(s->cfg.fdt, "/cpus", "#size-cells", 0);
+        qemu_fdt_setprop_cell(s->cfg.fdt, "/cpus", "#address-cells", 1);
+    }
+
+    for (i = 0; i < map->num_cluster; i++) {
+        for (j = 0; j < map->num_core; j++) {
+            DeviceState *cpu = versal_create_cpu(s, map, cluster, mr, i, j);
+
+            cpus[i * map->num_core + j] = cpu;
+        }
+
+    }
+
+    qdev_realize_and_unref(cluster, NULL, &error_fatal);
+
+    versal_create_and_connect_gic(s, map, mr, cpus,
+                                  map->num_cluster * map->num_core);
+
+    has_gtimer = arm_feature(&ARM_CPU(cpus[0])->env, ARM_FEATURE_GENERIC_TIMER);
+    if (map->dtb_expose && has_gtimer) {
+        qemu_fdt_add_subnode(s->cfg.fdt, "/timer");
+        qemu_fdt_setprop_cells(s->cfg.fdt, "/timer", "interrupts",
+                               GIC_FDT_IRQ_TYPE_PPI, VERSAL_TIMER_S_EL1_IRQ,
+                               GIC_FDT_IRQ_FLAGS_LEVEL_HI,
+                               GIC_FDT_IRQ_TYPE_PPI, VERSAL_TIMER_NS_EL1_IRQ,
+                               GIC_FDT_IRQ_FLAGS_LEVEL_HI,
+                               GIC_FDT_IRQ_TYPE_PPI, VERSAL_TIMER_VIRT_IRQ,
+                               GIC_FDT_IRQ_FLAGS_LEVEL_HI,
+                               GIC_FDT_IRQ_TYPE_PPI, VERSAL_TIMER_NS_EL2_IRQ,
+                               GIC_FDT_IRQ_FLAGS_LEVEL_HI);
+        qemu_fdt_setprop(s->cfg.fdt, "/timer", "compatible",
+                         compatible, sizeof(compatible));
     }
 }
 
 static void versal_create_rpu_cpus(Versal *s)
 {
@@ -1284,27 +1461,29 @@ static uint32_t fdt_add_clk_node(Versal *s, const char *name,
 
 static void versal_realize(DeviceState *dev, Error **errp)
 {
     Versal *s = XLNX_VERSAL_BASE(dev);
     DeviceState *slcr, *ospi;
-    qemu_irq pic[XLNX_VERSAL_NR_IRQS];
     Object *container;
     const VersalMap *map = versal_get_map(s);
     size_t i;
 
     g_assert(s->cfg.fdt != NULL);
 
     s->phandle.clk_25mhz = fdt_add_clk_node(s, "/clk25", 25 * 1000 * 1000);
     s->phandle.clk_125mhz = fdt_add_clk_node(s, "/clk125", 125 * 1000 * 1000);
-
-    versal_create_apu_cpus(s);
-    versal_create_apu_gic(s, pic);
+    s->phandle.gic = qemu_fdt_alloc_phandle(s->cfg.fdt);
 
     container = object_new(TYPE_CONTAINER);
     object_property_add_child(OBJECT(s), "irq-or-gates", container);
     object_unref(container);
 
+    qemu_fdt_setprop_cell(s->cfg.fdt, "/", "interrupt-parent", s->phandle.gic);
+    qemu_fdt_setprop_cell(s->cfg.fdt, "/", "#size-cells", 0x2);
+    qemu_fdt_setprop_cell(s->cfg.fdt, "/", "#address-cells", 0x2);
+
+    versal_create_cpu_cluster(s, &map->apu);
     versal_create_rpu_cpus(s);
 
     for (i = 0; i < map->num_uart; i++) {
         versal_create_uart(s, &map->uart[i], i);
     }
@@ -1357,15 +1536,19 @@ static void versal_realize(DeviceState *dev, Error **errp)
     /* Create the On Chip Memory (OCM).  */
     memory_region_init_ram(&s->lpd.mr_ocm, OBJECT(s), "ocm",
                            MM_OCM_SIZE, &error_fatal);
 
     memory_region_add_subregion_overlap(&s->mr_ps, MM_OCM, &s->lpd.mr_ocm, 0);
-    memory_region_add_subregion_overlap(&s->fpd.apu.mr, 0, &s->mr_ps, 0);
     memory_region_add_subregion_overlap(&s->lpd.rpu.mr, 0,
                                         &s->lpd.rpu.mr_ps_alias, 0);
 }
 
+DeviceState *versal_get_boot_cpu(Versal *s)
+{
+    return DEVICE(versal_get_child_idx(s, "apu-cluster/apu", 0));
+}
+
 void versal_sdhci_plug_card(Versal *s, int sd_idx, BlockBackend *blk)
 {
     DeviceState *sdhci, *card;
 
     sdhci = DEVICE(versal_get_child_idx(s, "sdhci", sd_idx));
@@ -1465,11 +1648,10 @@ int versal_get_num_sdhci(VersalVersion version)
 static void versal_base_init(Object *obj)
 {
     Versal *s = XLNX_VERSAL_BASE(obj);
     size_t i, num_can;
 
-    memory_region_init(&s->fpd.apu.mr, obj, "mr-apu", UINT64_MAX);
     memory_region_init(&s->lpd.rpu.mr, obj, "mr-rpu", UINT64_MAX);
     memory_region_init(&s->mr_ps, obj, "mr-ps-switch", UINT64_MAX);
     memory_region_init_alias(&s->lpd.rpu.mr_ps_alias, OBJECT(s),
                              "mr-rpu-ps-alias", &s->mr_ps, 0, UINT64_MAX);
 
-- 
2.51.0


