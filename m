Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D758B31EDB
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Aug 2025 17:37:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upTVg-0007as-TN; Fri, 22 Aug 2025 11:16:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTVd-0007Zd-Cz; Fri, 22 Aug 2025 11:16:54 -0400
Received: from mail-co1nam11on2062a.outbound.protection.outlook.com
 ([2a01:111:f403:2416::62a]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTVU-00076v-HP; Fri, 22 Aug 2025 11:16:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IXkcYsFnPqU1Xf9+6b8mjE9/e4FqUANdWQ+cZmogc0Vula8YclPIjkrDOdaRquxf8O6/Y/ppXx3BIl69bW9hrVK2wyXZUpTARAdXBw5F8uy6ZkiwTJhXLWYeOMRbk9c9+Hl93PQhRyQwwWspO/boOCsZi2wbOlqs0eDyWiSS1NB6QBETDvx5EYZ2GUqpqFo7+7et/EO4Fyw6iB3FQ8Gi+VFWqI2DEcmd6xyRYbYwmoxdbM60eS/wj9e4ZtUR5gpd0+p9BYctdteCBvei8MGqp3V8yptvLPljLlJp1Yf5Zll3iMMhFa7t5p8XWHz1sQyXV/1DlmvcEaP5cfqd1zLtLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NvHmjdNHcP03NL5rHaoMSZuZQ9sjyLaXsWZOIMegQk4=;
 b=v4G7HnEhLCeSCfiKSaHJ73E/9WEwa4hG6z5BUbZStYAYyaOnNAuXAUunjcbM7BJ3OL6eO3x+hjR7fVCgHjmj/lpyHBtUmb5hzEAcpg/ePi1DOsyoF5pihBenkHvov0pvD+iHTM0h7G7pQ39Oj4y2e/CfxhgViE32aleCgUpBLG7QweyfI+I22AmTNUlqscqSC2ANI3Edgr6/deWmXGm8swlcedC0MkvY+j0JsgWUPY3W8NdCUb6xhtU6nAMnbHHVeH8MQBXaVaEbnLvHPKdFvfBL5mhEWk8TLMlnpwA3w6oXjDq/HL1QEZLCNJJVgbcvG7OD012+auBEdp6SXIC/dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NvHmjdNHcP03NL5rHaoMSZuZQ9sjyLaXsWZOIMegQk4=;
 b=FZzNbSbzJZshbTaNGX35U52mD1Zx7Gz9bbu6sxYi90XYD3gdrppaLTmvImQTKJcLnM0bnKTnkEArsViwCfxHUfhQMK354zAE3ff1MCchy40Vi7qzod4RT+MeYnf6075wNIOTlvFa9lrPfSwFboU9oWu04RXV7wajZ+Gbem2Eg18=
Received: from DSZP220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:280::11) by
 BY5PR12MB4212.namprd12.prod.outlook.com (2603:10b6:a03:202::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.14; Fri, 22 Aug 2025 15:16:33 +0000
Received: from DS2PEPF0000343D.namprd02.prod.outlook.com
 (2603:10b6:5:280:cafe::2e) by DSZP220CA0010.outlook.office365.com
 (2603:10b6:5:280::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.19 via Frontend Transport; Fri,
 22 Aug 2025 15:16:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343D.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 15:16:33 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 10:16:32 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 22 Aug 2025 10:16:30 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v4 04/47] hw/arm/xlnx-versal: canfd: refactor creation
Date: Fri, 22 Aug 2025 17:15:29 +0200
Message-ID: <20250822151614.187856-5-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822151614.187856-1-luc.michel@amd.com>
References: <20250822151614.187856-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343D:EE_|BY5PR12MB4212:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e130256-16e7-4939-64a1-08dde18ee105
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9Q0ftua6ZD/MIIomVk7eOZMsOEJmiA+YnyRTjdPzrymdW/vWOLgqYCsVKaxe?=
 =?us-ascii?Q?NgyO41CKpJgSXE2SclfFRCrJK8B2PzfJ+3PPqdbviPF+a13RcF/eXZPjwD7X?=
 =?us-ascii?Q?OsywpcdeXk4EY9z4cMevZt3GJn59D5j6SoIi1m7dCrTZMADm2fHH5kmM9bLa?=
 =?us-ascii?Q?ABQJQ1e3zipY/nZasjt+afqWvv1Jd6CaMEgVKb7n8k9fL/U1PafAYB878BFs?=
 =?us-ascii?Q?2G5fH9f+L8B/2C3FmgSp+ENpZyliH003JGEazXUwx0S++DS0IVP/XgfHwFGv?=
 =?us-ascii?Q?OxQXqzlV3dCCqwjEtI9/urjtIem2izpBhqooJMgH3RaK4GiwQdshuz3auE5q?=
 =?us-ascii?Q?A5D7hdk54KQh2HJBxPGOf6MK3yvTwjEcLL7tbZ02cpgE/Ste9fTBHBpvFiLa?=
 =?us-ascii?Q?IgOtvm1uVCKHwoxcBASr3VexxNJNH32xOHrHwH1k2RapzTc4baIHgvLkt8fS?=
 =?us-ascii?Q?YH3Rm9DL/GPs0KjybqCqiMGmRhfHH8OeB6oDFVZn0NGImyKN9Sso/z9m7S7U?=
 =?us-ascii?Q?uk1Rg5EmmMDIpA0cNPRWM3gKnEDXWh/Z/S9Ss3/QBi1iUaMaiA2zbSQhnU44?=
 =?us-ascii?Q?V7kjecPKRO2mG5RQzZlctrlTPRdoGK6VvwHdH+uOjbmcHNbcr+fCLo4m+I9d?=
 =?us-ascii?Q?Zz2LDOXuK9nu1Qxa18oVplhrm/gvJ5plHM3e4jsaRC2JXmO4QxLkMVtgzoOZ?=
 =?us-ascii?Q?958YcUUjjmmxfc6vFN0GZSCILeg09gqVMs1KMvVX9m+rXN4wFgOI/9h2JBor?=
 =?us-ascii?Q?eH2aX82VDHFyBeVoSWl7s7V/Et+R0erBlEhOVd/0250rKyS9dv+vHWPpolpP?=
 =?us-ascii?Q?4IG+bDFgH7HBas/ri7fwztn5aIIhXLsbknQD5ATfWBpO8tw0R8/6xgpm+kky?=
 =?us-ascii?Q?dHf57X3gYF9e1xYybRQeHoBIQEgDpZofNx+Isv5DHVlJBNRKIHFLJ1Xe55qz?=
 =?us-ascii?Q?45uN9kNo+HC0haucD0TDHniDSh2gFIa0pZsjzH/y1r+cXa9d31hhJEXMCdEa?=
 =?us-ascii?Q?KUirMgejWXCG1+LiIOSFSZuTua5ti7KORNt2Hd3uWvzDybfdb5H+vTFFOwVo?=
 =?us-ascii?Q?250DQMMXh/HPFYSyL7fFQHjKV+Ia17Isz8FsPgRgymz0UcaHRLFmAPzyiYCp?=
 =?us-ascii?Q?3eyrCGc+QuaGynEZfu42DubSj2C6DLViIROGFzHMi+7OXQZAsKxZDjiIFrCd?=
 =?us-ascii?Q?RanKRzNReCser92uprVHdQu8SelSvilBmLzbOHUDQNEt45fo2nXe6KykE0Dv?=
 =?us-ascii?Q?2WRRKW1+j1BrvBOH4DyeEclv5jGV8Gw2xA9VS0TTaeRUg9stIC/VLvlgFUTZ?=
 =?us-ascii?Q?MjOb7weviSyda9noRZQQKXdAQnQcJF0ZcFwFP+KvuSE7HjOJDORJp0TCL8nB?=
 =?us-ascii?Q?iNjcneY4kyhahaYURS1uyu4dQ6CqVJE6XCmGiC1W3YHVZOpi7++l+GCAGAhh?=
 =?us-ascii?Q?rQFFUgIyD5AvRCTU2MepE97eyvYhUeIxu98i0Gaxn8XS2kmdGPpEl1ObdJqg?=
 =?us-ascii?Q?m4CcWrdn1YUlTQv5acM6AO+PCcIO091juT6t?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 15:16:33.2508 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e130256-16e7-4939-64a1-08dde18ee105
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4212
Received-SPF: permerror client-ip=2a01:111:f403:2416::62a;
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

Refactor the CAN controllers creation using the VersalMap structure.

Note that the connection to the CRL is removed for now and will be
re-added by next commits.

The xlnx-versal-virt machine now dynamically creates the correct amount
of CAN bus link properties based on the number of CAN controller
advertised by the SoC.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
 include/hw/arm/xlnx-versal.h |  7 +--
 hw/arm/xlnx-versal-virt.c    | 73 ++++++++++--------------------
 hw/arm/xlnx-versal.c         | 86 +++++++++++++++++++++++++-----------
 3 files changed, 87 insertions(+), 79 deletions(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index b01ddeb1423..007c91b596e 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -29,11 +29,11 @@
 #include "hw/ssi/xlnx-versal-ospi.h"
 #include "hw/dma/xlnx_csu_dma.h"
 #include "hw/misc/xlnx-versal-crl.h"
 #include "hw/misc/xlnx-versal-pmc-iou-slcr.h"
 #include "hw/misc/xlnx-versal-trng.h"
-#include "hw/net/xlnx-versal-canfd.h"
+#include "net/can_emu.h"
 #include "hw/misc/xlnx-versal-cfu.h"
 #include "hw/misc/xlnx-versal-cframe-reg.h"
 #include "target/arm/cpu.h"
 #include "hw/arm/xlnx-versal-version.h"
 
@@ -81,12 +81,10 @@ struct Versal {
         struct {
             CadenceGEMState gem[XLNX_VERSAL_NR_GEMS];
             OrIRQState gem_irq_orgate[XLNX_VERSAL_NR_GEMS];
             XlnxZDMA adma[XLNX_VERSAL_NR_ADMAS];
             VersalUsb2 usb;
-            CanBusState *canbus[XLNX_VERSAL_NR_CANFD];
-            XlnxVersalCANFDState canfd[XLNX_VERSAL_NR_CANFD];
         } iou;
 
         /* Real-time Processing Unit.  */
         struct {
             MemoryRegion mr;
@@ -139,10 +137,11 @@ struct Versal {
         uint32_t clk_125mhz;
     } phandle;
 
     struct {
         MemoryRegion *mr_ddr;
+        CanBusState **canbus;
         void *fdt;
     } cfg;
 };
 
 struct VersalClass {
@@ -155,10 +154,12 @@ static inline void versal_set_fdt(Versal *s, void *fdt)
 {
     g_assert(!qdev_is_realized(DEVICE(s)));
     s->cfg.fdt = fdt;
 }
 
+int versal_get_num_can(VersalVersion version);
+
 /* Memory-map and IRQ definitions. Copied a subset from
  * auto-generated files.  */
 
 #define VERSAL_GIC_MAINT_IRQ        9
 #define VERSAL_TIMER_VIRT_IRQ       11
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index e1deae11317..334252564be 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -41,15 +41,15 @@ struct VersalVirt {
         uint32_t ethernet_phy[2];
         uint32_t clk_125Mhz;
         uint32_t clk_25Mhz;
         uint32_t usb;
         uint32_t dwc;
-        uint32_t canfd[2];
     } phandle;
     struct arm_boot_info binfo;
 
-    CanBusState *canbus[XLNX_VERSAL_NR_CANFD];
+    CanBusState **canbus;
+
     struct {
         bool secure;
     } cfg;
     char *ospi_model;
 };
@@ -207,42 +207,10 @@ static void fdt_add_usb_xhci_nodes(VersalVirt *s)
     qemu_fdt_setprop_cell(s->fdt, name, "phandle", s->phandle.dwc);
     qemu_fdt_setprop_string(s->fdt, name, "maximum-speed", "high-speed");
     g_free(name);
 }
 
-static void fdt_add_canfd_nodes(VersalVirt *s)
-{
-    uint64_t addrs[] = { MM_CANFD1, MM_CANFD0 };
-    uint32_t size[] = { MM_CANFD1_SIZE, MM_CANFD0_SIZE };
-    unsigned int irqs[] = { VERSAL_CANFD1_IRQ_0, VERSAL_CANFD0_IRQ_0 };
-    const char clocknames[] = "can_clk\0s_axi_aclk";
-    int i;
-
-    /* Create and connect CANFD0 and CANFD1 nodes to canbus0. */
-    for (i = 0; i < ARRAY_SIZE(addrs); i++) {
-        char *name = g_strdup_printf("/canfd@%" PRIx64, addrs[i]);
-        qemu_fdt_add_subnode(s->fdt, name);
-
-        qemu_fdt_setprop_cell(s->fdt, name, "rx-fifo-depth", 0x40);
-        qemu_fdt_setprop_cell(s->fdt, name, "tx-mailbox-count", 0x20);
-
-        qemu_fdt_setprop_cells(s->fdt, name, "clocks",
-                               s->phandle.clk_25Mhz, s->phandle.clk_25Mhz);
-        qemu_fdt_setprop(s->fdt, name, "clock-names",
-                         clocknames, sizeof(clocknames));
-        qemu_fdt_setprop_cells(s->fdt, name, "interrupts",
-                               GIC_FDT_IRQ_TYPE_SPI, irqs[i],
-                               GIC_FDT_IRQ_FLAGS_LEVEL_HI);
-        qemu_fdt_setprop_sized_cells(s->fdt, name, "reg",
-                                     2, addrs[i], 2, size[i]);
-        qemu_fdt_setprop_string(s->fdt, name, "compatible",
-                                "xlnx,canfd-2.0");
-
-        g_free(name);
-    }
-}
-
 static void fdt_add_fixed_link_nodes(VersalVirt *s, char *gemname,
                                      uint32_t phandle)
 {
     char *name = g_strdup_printf("%s/fixed-link", gemname);
 
@@ -659,22 +627,25 @@ static void versal_virt_init(MachineState *machine)
 
     object_initialize_child(OBJECT(machine), "xlnx-versal", &s->soc,
                             TYPE_XLNX_VERSAL);
     object_property_set_link(OBJECT(&s->soc), "ddr", OBJECT(machine->ram),
                              &error_abort);
-    object_property_set_link(OBJECT(&s->soc), "canbus0", OBJECT(s->canbus[0]),
-                             &error_abort);
-    object_property_set_link(OBJECT(&s->soc), "canbus1", OBJECT(s->canbus[1]),
-                             &error_abort);
+
+    for (i = 0; i < versal_get_num_can(VERSAL_VER_VERSAL); i++) {
+        g_autofree char *prop_name = g_strdup_printf("canbus%d", i);
+
+        object_property_set_link(OBJECT(&s->soc), prop_name,
+                                 OBJECT(s->canbus[i]),
+                                 &error_abort);
+    }
 
     fdt_create(s);
     versal_set_fdt(&s->soc, s->fdt);
     sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
     create_virtio_regions(s);
 
     fdt_add_gem_nodes(s);
-    fdt_add_canfd_nodes(s);
     fdt_add_gic_nodes(s);
     fdt_add_timer_nodes(s);
     fdt_add_zdma_nodes(s);
     fdt_add_usb_xhci_nodes(s);
     fdt_add_sd_nodes(s);
@@ -753,30 +724,34 @@ static void versal_virt_init(MachineState *machine)
 }
 
 static void versal_virt_machine_instance_init(Object *obj)
 {
     VersalVirt *s = XLNX_VERSAL_VIRT_MACHINE(obj);
+    size_t i, num_can;
+
+    num_can = versal_get_num_can(VERSAL_VER_VERSAL);
+    s->canbus = g_new0(CanBusState *, num_can);
 
     /*
-     * User can set canbus0 and canbus1 properties to can-bus object and connect
-     * to socketcan(optional) interface via command line.
+     * User can set canbusx properties to can-bus object and optionally connect
+     * to socketcan interface via command line.
      */
-    object_property_add_link(obj, "canbus0", TYPE_CAN_BUS,
-                             (Object **)&s->canbus[0],
-                             object_property_allow_set_link,
-                             0);
-    object_property_add_link(obj, "canbus1", TYPE_CAN_BUS,
-                             (Object **)&s->canbus[1],
-                             object_property_allow_set_link,
-                             0);
+    for (i = 0; i < num_can; i++) {
+        g_autofree char *prop_name = g_strdup_printf("canbus%zu", i);
+
+        object_property_add_link(obj, prop_name, TYPE_CAN_BUS,
+                                 (Object **) &s->canbus[i],
+                                 object_property_allow_set_link, 0);
+    }
 }
 
 static void versal_virt_machine_finalize(Object *obj)
 {
     VersalVirt *s = XLNX_VERSAL_VIRT_MACHINE(obj);
 
     g_free(s->ospi_model);
+    g_free(s->canbus);
 }
 
 static void versal_virt_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 87468cbc291..5dccf231942 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -25,10 +25,11 @@
 #include "target/arm/cpu-qom.h"
 #include "target/arm/gtimer.h"
 #include "system/device_tree.h"
 #include "hw/arm/fdt.h"
 #include "hw/char/pl011.h"
+#include "hw/net/xlnx-versal-canfd.h"
 
 #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
 #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
 #define GEM_REVISION        0x40070106
 
@@ -41,16 +42,23 @@ typedef struct VersalSimplePeriphMap {
 } VersalSimplePeriphMap;
 
 typedef struct VersalMap {
     VersalSimplePeriphMap uart[2];
     size_t num_uart;
+
+    VersalSimplePeriphMap canfd[4];
+    size_t num_canfd;
 } VersalMap;
 
 static const VersalMap VERSAL_MAP = {
     .uart[0] = { 0xff000000, 18 },
     .uart[1] = { 0xff010000, 19 },
     .num_uart = 2,
+
+    .canfd[0] = { 0xff060000, 20 },
+    .canfd[1] = { 0xff070000, 21 },
+    .num_canfd = 2,
 };
 
 static const VersalMap *VERSION_TO_MAP[] = {
     [VERSAL_VER_VERSAL] = &VERSAL_MAP,
 };
@@ -284,40 +292,46 @@ static void versal_create_uart(Versal *s,
     if (chardev_idx == 0) {
         qemu_fdt_setprop_string(s->cfg.fdt, "/chosen", "stdout-path", node);
     }
 }
 
-static void versal_create_canfds(Versal *s, qemu_irq *pic)
+static void versal_create_canfd(Versal *s, const VersalSimplePeriphMap *map,
+                                CanBusState *bus)
 {
-    int i;
-    uint32_t irqs[] = { VERSAL_CANFD0_IRQ_0, VERSAL_CANFD1_IRQ_0};
-    uint64_t addrs[] = { MM_CANFD0, MM_CANFD1 };
+    SysBusDevice *sbd;
+    MemoryRegion *mr;
+    g_autofree char *node;
+    const char compatible[] = "xlnx,canfd-2.0";
+    const char clocknames[] = "can_clk\0s_axi_aclk";
 
-    for (i = 0; i < ARRAY_SIZE(s->lpd.iou.canfd); i++) {
-        char *name = g_strdup_printf("canfd%d", i);
-        SysBusDevice *sbd;
-        MemoryRegion *mr;
+    sbd = SYS_BUS_DEVICE(qdev_new(TYPE_XILINX_CANFD));
+    object_property_add_child(OBJECT(s), "canfd[*]", OBJECT(sbd));
 
-        object_initialize_child(OBJECT(s), name, &s->lpd.iou.canfd[i],
-                                TYPE_XILINX_CANFD);
-        sbd = SYS_BUS_DEVICE(&s->lpd.iou.canfd[i]);
+    object_property_set_int(OBJECT(sbd), "ext_clk_freq",
+                            25 * 1000 * 1000 , &error_abort);
 
-        object_property_set_int(OBJECT(&s->lpd.iou.canfd[i]), "ext_clk_freq",
-                                XLNX_VERSAL_CANFD_REF_CLK , &error_abort);
+    object_property_set_link(OBJECT(sbd), "canfdbus", OBJECT(bus),
+                             &error_abort);
 
-        object_property_set_link(OBJECT(&s->lpd.iou.canfd[i]), "canfdbus",
-                                 OBJECT(s->lpd.iou.canbus[i]),
-                                 &error_abort);
+    sysbus_realize_and_unref(sbd, &error_fatal);
 
-        sysbus_realize(sbd, &error_fatal);
+    mr = sysbus_mmio_get_region(sbd, 0);
+    memory_region_add_subregion(&s->mr_ps, map->addr, mr);
 
-        mr = sysbus_mmio_get_region(sbd, 0);
-        memory_region_add_subregion(&s->mr_ps, addrs[i], mr);
+    versal_sysbus_connect_irq(s, sbd, 0, map->irq);
 
-        sysbus_connect_irq(sbd, 0, pic[irqs[i]]);
-        g_free(name);
-    }
+    node = versal_fdt_add_simple_subnode(s, "/canfd", map->addr, 0x10000,
+                                         compatible, sizeof(compatible));
+    qemu_fdt_setprop_cell(s->cfg.fdt, node, "rx-fifo-depth", 0x40);
+    qemu_fdt_setprop_cell(s->cfg.fdt, node, "tx-mailbox-count", 0x20);
+    qemu_fdt_setprop_cells(s->cfg.fdt, node, "clocks",
+                           s->phandle.clk_25mhz, s->phandle.clk_25mhz);
+    qemu_fdt_setprop(s->cfg.fdt, node, "clock-names",
+                     clocknames, sizeof(clocknames));
+    qemu_fdt_setprop_cells(s->cfg.fdt, node, "interrupts",
+                           GIC_FDT_IRQ_TYPE_SPI, map->irq,
+                           GIC_FDT_IRQ_FLAGS_LEVEL_HI);
 }
 
 static void versal_create_usbs(Versal *s, qemu_irq *pic)
 {
     DeviceState *dev;
@@ -1046,11 +1060,14 @@ static void versal_realize(DeviceState *dev, Error **errp)
 
     for (i = 0; i < map->num_uart; i++) {
         versal_create_uart(s, &map->uart[i], i);
     }
 
-    versal_create_canfds(s, pic);
+    for (i = 0; i < map->num_canfd; i++) {
+        versal_create_canfd(s, &map->canfd[i], s->cfg.canbus[i]);
+    }
+
     versal_create_usbs(s, pic);
     versal_create_gems(s, pic);
     versal_create_admas(s, pic);
     versal_create_sds(s, pic);
     versal_create_pmc_apb_irq_orgate(s, pic);
@@ -1074,28 +1091,43 @@ static void versal_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion_overlap(&s->fpd.apu.mr, 0, &s->mr_ps, 0);
     memory_region_add_subregion_overlap(&s->lpd.rpu.mr, 0,
                                         &s->lpd.rpu.mr_ps_alias, 0);
 }
 
+int versal_get_num_can(VersalVersion version)
+{
+    const VersalMap *map = VERSION_TO_MAP[version];
+
+    return map->num_canfd;
+}
+
 static void versal_base_init(Object *obj)
 {
     Versal *s = XLNX_VERSAL_BASE(obj);
+    size_t i, num_can;
 
     memory_region_init(&s->fpd.apu.mr, obj, "mr-apu", UINT64_MAX);
     memory_region_init(&s->lpd.rpu.mr, obj, "mr-rpu", UINT64_MAX);
     memory_region_init(&s->mr_ps, obj, "mr-ps-switch", UINT64_MAX);
     memory_region_init_alias(&s->lpd.rpu.mr_ps_alias, OBJECT(s),
                              "mr-rpu-ps-alias", &s->mr_ps, 0, UINT64_MAX);
+
+    num_can = versal_get_map(s)->num_canfd;
+    s->cfg.canbus = g_new0(CanBusState *, num_can);
+
+    for (i = 0; i < num_can; i++) {
+        g_autofree char *prop_name = g_strdup_printf("canbus%zu", i);
+
+        object_property_add_link(obj, prop_name, TYPE_CAN_BUS,
+                                 (Object **) &s->cfg.canbus[i],
+                                 object_property_allow_set_link, 0);
+    }
 }
 
 static const Property versal_properties[] = {
     DEFINE_PROP_LINK("ddr", Versal, cfg.mr_ddr, TYPE_MEMORY_REGION,
                      MemoryRegion *),
-    DEFINE_PROP_LINK("canbus0", Versal, lpd.iou.canbus[0],
-                      TYPE_CAN_BUS, CanBusState *),
-    DEFINE_PROP_LINK("canbus1", Versal, lpd.iou.canbus[1],
-                      TYPE_CAN_BUS, CanBusState *),
 };
 
 static void versal_base_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-- 
2.50.1


