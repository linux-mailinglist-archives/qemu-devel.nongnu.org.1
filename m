Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97757B072DD
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Jul 2025 12:13:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubyt3-0005Tg-S2; Wed, 16 Jul 2025 05:57:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubysO-0002JX-Co; Wed, 16 Jul 2025 05:56:39 -0400
Received: from mail-mw2nam10on20630.outbound.protection.outlook.com
 ([2a01:111:f403:2412::630]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubysL-0006ni-EL; Wed, 16 Jul 2025 05:56:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZWZ7F3TG9m4X+6PcqjF0tQ4xsmsSQ6zl59iPyof0kDM6JWLBYsfMJuQIVuVofro3PthJ6TMKLUvdMQA7sqmoITVjztnRv5VPH7z1fU+y7YnYDAGSluwH8mh+1MdHaGZW54toC9XVgZdrUNMfwmeLhdJVFcQXRrVdDLnnLMZsYm7C1juIBsTGqpfwHAbGPotf5csj9kO4GloAXKN+pcIEeslhwFsuxVEE737Qd4o5+y2Z2DaWPLy0ljRJ5ASV9Q17q3mDZE9yVTN7olJxl6NEq8Zv+7MDNn05wX0LQ6RSPeDjXJ6AxSV+TqScVcfIcrYsXnrJjB/LaPvqg4FuaLmkog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJ3Z3S8uVpf9+TtoWk5J0oOpQkg6RCfxV2/Hg4FOk5A=;
 b=ZnYLNxes1chVANLdh9ah5JMH6TOU3tao+cwBJcBdfV3g+JuCY9LBkVqAcRT538kT7frzFhgtk1NNbRPv/E+yI9w7WblxY8GInQ3+F1RNBXH8rLOjC9g+XnjHXkkm+QUdti4Wt4iOk2bfpEI4L2ZSYmappuknzLxT1TL+F1g5UEX3Huxat4pL0RNa+/VJ8IKuyiiVrkAO9uLIwTjymhPlxavoTl26FqZIUGNr5H/UUOxSoqQraQ+38fWK9VAH2/Dpmnee3Z78E8YLWegxg7ORC/tddvpaW+jyCSIuckxKQRcfFUymuKgEnlvBmIZ5VCf0EJced+SLDPVydDYlO5mitw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJ3Z3S8uVpf9+TtoWk5J0oOpQkg6RCfxV2/Hg4FOk5A=;
 b=SdtY03OCdpeEOlHCsBkwh/eLlFXk9xN1bbJD/trW5nyUD6QTzNwAQWwv956qGPId9jDXBE6q/HQwKklbtBB7W9edjKCrREC5UxcKePmpzFB8T2FbNY+c7DeokSztDlzguZumFXAbBfW68kGqb3QZeEYbN6hUol0CDlsxOXEamlo=
Received: from BYAPR05CA0005.namprd05.prod.outlook.com (2603:10b6:a03:c0::18)
 by IA1PR12MB6113.namprd12.prod.outlook.com (2603:10b6:208:3eb::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 09:56:23 +0000
Received: from SJ5PEPF00000208.namprd05.prod.outlook.com
 (2603:10b6:a03:c0:cafe::4b) by BYAPR05CA0005.outlook.office365.com
 (2603:10b6:a03:c0::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.12 via Frontend Transport; Wed,
 16 Jul 2025 09:56:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF00000208.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Wed, 16 Jul 2025 09:56:22 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 04:56:22 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 04:56:21 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 16 Jul 2025 04:56:19 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH 41/48] hw/arm/xlnx-versal: add versal2 SoC
Date: Wed, 16 Jul 2025 11:54:23 +0200
Message-ID: <20250716095432.81923-42-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250716095432.81923-1-luc.michel@amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000208:EE_|IA1PR12MB6113:EE_
X-MS-Office365-Filtering-Correlation-Id: 8025d57e-5fba-4038-5736-08ddc44f055c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MybOxuh46CQxVDBT/x442n+qg8O2ZaiX9rbG0nGPvIlihSxjWn4gwv6FwsIQ?=
 =?us-ascii?Q?7KyKg285ZDci9gRG3AhyRhCkMyt0CI2v1IbaCjeBXc7ChaRuAJgZci94KlWh?=
 =?us-ascii?Q?bWDF3ANFRdMIZnPUa64RoP2ZJoRouW8l1dqmmujWkUXVwjVIVo0iRoC0smHP?=
 =?us-ascii?Q?+bFnECn67QORes/6yw4UDekVjPVKC+goq6ykaCCrs1zXUjnygxPWGaZhYmjx?=
 =?us-ascii?Q?8NQ28uGVmgrD2j5bT1LDKt8tGPetJpWzIsNKP2KsXwyAPMhlKfdV46mRU9t2?=
 =?us-ascii?Q?tuLketl1CkOcGa8SuIzKJ/uJcsPVvHT9WPdUXIMu8inBqYlhTSi1xUsAXN11?=
 =?us-ascii?Q?rrByen9Dn9gV0D0wIL5IzIMclXm5J6D5lwqKqjWNcvr16RUMusyDaBsTk0hF?=
 =?us-ascii?Q?z3jRePYR3FHVsBB5bgs6q9NzD7vVWxeC7gT7NHId0cVNvcGfnB/Pk4ps3D30?=
 =?us-ascii?Q?QS2vieGcjs5wVJlKIvv6sHhXbHRhKGqMvseP5bIYVNZNkZ/18qAw6CB48YEv?=
 =?us-ascii?Q?QI3E0Lr8JTkGNwX6Ot3IDqs1N8T045oy1A4/pK1Ehn9mUi6KT44RAimkn3Wq?=
 =?us-ascii?Q?0uXLB0iggRy1nylE0vxljzKZi4lzwhCqVGYXV42CcMCo3UTYWQLH9Bnq+rfm?=
 =?us-ascii?Q?DOshFnFbLVzYJp6wKbskAknUydgtii4J7Y7Jr60vcs6A124IhYTlDSwSFPB8?=
 =?us-ascii?Q?PLcI9bpRjPR08H8iQ0uvD+emIRczTc+xAvj+eCpKWBK/hYvIX9kVbUUJn2St?=
 =?us-ascii?Q?uDUfbbY5bdQIKn3MdnZYFJXX0HEvejrQCkeVoXpb/vViqatH4aAhD4Kf9iBI?=
 =?us-ascii?Q?nbuOscZifLkzremjeU1rQq6dsbBPuTwad88R4pJ7FTGasLcl3Yp+Hx39dw6O?=
 =?us-ascii?Q?HVfeX9+rSWrY7cX9nBFS54K2QY9CX+jGm/oLY1xWQUwn97b+g+Ky4M1SDmeS?=
 =?us-ascii?Q?EMPSDlOFNvvy18OvIdOi+Q36tu6uCp4vvghG2EPka0y/A4DjXz9U5UmuJD5o?=
 =?us-ascii?Q?79VWQANC1BBDSN+Zu8JMa3ujNJ3sYVBDK0eYbvR7KgfygAp8raDGLcHhp898?=
 =?us-ascii?Q?IGrtgDKKbOD4vCMxuSCKVStdy2mCtdC/opBln55ovOZd/R/wEN1hZ4cUej3w?=
 =?us-ascii?Q?trQ+NugL63pCVsSf3NnrBGE/AahOuBa+nyIZ19dTzboj2ylblV5eYYJYpytF?=
 =?us-ascii?Q?EjgzMdoN6N/DLXn2KCrFg26Et8HHjzMUUkjjOoZMsyK187+Mfn1l3feHcDyV?=
 =?us-ascii?Q?LBJSR8rluBHTSgkyZT3VZZgJHM3Nw0LFgqes502H4pD/juhHGClmnPVhV5K3?=
 =?us-ascii?Q?9VNnfZjOVv2qpqUs7e4r3KuW6KovGSvo78FlFaAhXQTqf6KiZPsrkyN/5LJh?=
 =?us-ascii?Q?xY1679x2dRvC6gWImTCfpX/Sam3tJmr3vyatNQvDfNfWM+oZB/PvBqBK7Q52?=
 =?us-ascii?Q?W/E6KRZdG6dUDb6AqsNQnygglDDl4I+CqtZk7GWY8TrKEU8I0r6nJ9+8gHam?=
 =?us-ascii?Q?UOPUaZJeM9HdgV2FkY/wwIEGJwHtWScSA7X5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 09:56:22.6540 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8025d57e-5fba-4038-5736-08ddc44f055c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6113
Received-SPF: permerror client-ip=2a01:111:f403:2412::630;
 envelope-from=Luc.Michel@amd.com;
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

Add the Versal Gen 2 (versal2) version of the Versal SoC family.
This version embeds up to 8 Cortex-A78AE cores (split into 4 clusters)
and 10 Cortex-R52 cores (split into 5 clusters). The similarities
between versal and versal2 in term of architecture allow to reuse the
VersalMap structure to almost fully describe the implemented parts of
versal2.

The versal2 eFuse device differs quite a lot from the versal one and is
left as future work.

Signed-off-by: Luc Michel <luc.michel@amd.com>
---
 include/hw/arm/xlnx-versal.h |  17 ++-
 hw/arm/xlnx-versal.c         | 212 ++++++++++++++++++++++++++++++++---
 2 files changed, 214 insertions(+), 15 deletions(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index bdfab2a5426..1d216b5dbf1 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -1,7 +1,7 @@
 /*
- * Model of the Xilinx Versal
+ * AMD/Xilinx Versal family SoC model.
  *
  * Copyright (c) 2018 Xilinx Inc.
  * Copyright (c) 2025 Advanced Micro Devices, Inc.
  * Written by Edgar E. Iglesias
  *
@@ -20,10 +20,11 @@
 
 #define TYPE_XLNX_VERSAL_BASE "xlnx-versal-base"
 OBJECT_DECLARE_TYPE(Versal, VersalClass, XLNX_VERSAL_BASE)
 
 #define TYPE_XLNX_VERSAL "xlnx-versal"
+#define TYPE_XLNX_VERSAL2 "xlnx-versal2"
 
 struct Versal {
     /*< private >*/
     SysBusDevice parent_obj;
 
@@ -69,6 +70,20 @@ hwaddr versal_get_reserved_mmio_addr(Versal *s);
 
 int versal_get_num_cpu(VersalVersion version);
 int versal_get_num_can(VersalVersion version);
 int versal_get_num_sdhci(VersalVersion version);
 
+static inline const char *versal_get_class(VersalVersion version)
+{
+    switch (version) {
+    case VERSAL_VER_VERSAL:
+        return TYPE_XLNX_VERSAL;
+
+    case VERSAL_VER_VERSAL2:
+        return TYPE_XLNX_VERSAL2;
+
+    default:
+        g_assert_not_reached();
+    }
+}
+
 #endif
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 551671af425..52a68e356b0 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -1,7 +1,7 @@
 /*
- * Xilinx Versal SoC model.
+ * AMD/Xilinx Versal family SoC model.
  *
  * Copyright (c) 2018 Xilinx Inc.
  * Copyright (c) 2025 Advanced Micro Devices, Inc.
  * Written by Edgar E. Iglesias
  *
@@ -353,12 +353,133 @@ static const VersalMap VERSAL_MAP = {
     .crl = { 0xff5e0000, 10 },
 
     .reserved = { 0xa0000000, 111, 8 },
 };
 
+static const VersalMap VERSAL2_MAP = {
+    .ocm = {
+        .addr = 0xbbe00000,
+        .size = 2 * MiB,
+    },
+
+    .ddr = {
+        .chan[0] = { .addr = 0x0, .size = 2046 * MiB },
+        .chan[1] = { .addr = 0x800000000ull, .size = 32 * GiB },
+        .chan[2] = { .addr = 0xc00000000ull, .size = 256 * GiB },
+        .chan[3] = { .addr = 0x10000000000ull, .size = 734 * GiB },
+        .num_chan = 4,
+    },
+
+    .apu = {
+        .name = "apu",
+        .cpu_model = ARM_CPU_TYPE_NAME("cortex-a78ae"),
+        .num_cluster = 4,
+        .num_core = 2,
+        .qemu_cluster_id = 0,
+        .mp_affinity = {
+            .base = 0x0, /* TODO: the MT bit should be set */
+            .core_mask = 0xff,
+            .core_shift = 8,
+            .cluster_mask = 0xff,
+            .cluster_shift = 16,
+        },
+        .start_powered_off = SPO_SECONDARIES,
+        .dtb_expose = true,
+        .gic = {
+            .version = 3,
+            .dist = 0xe2000000,
+            .redist = 0xe2060000,
+            .num_irq = 544,
+            .has_its = true,
+            .its = 0xe2040000,
+        },
+    },
+
+    .rpu = {
+        .name = "rpu",
+        .cpu_model = ARM_CPU_TYPE_NAME("cortex-r52"),
+        .num_cluster = 5,
+        .num_core = 2,
+        .qemu_cluster_id = 1,
+        .mp_affinity = {
+            .base = 0x0,
+            .core_mask = 0xff,
+            .core_shift = 0,
+            .cluster_mask = 0xff,
+            .cluster_shift = 8,
+        },
+        .start_powered_off = SPO_ALL,
+        .dtb_expose = false,
+        .per_cluster_gic = true,
+        .gic = {
+            .version = 3,
+            .dist = 0x0,
+            .redist = 0x100000,
+            .num_irq = 288,
+        },
+    },
+
+    .uart[0] = { 0xf1920000, 25 },
+    .uart[1] = { 0xf1930000, 26 },
+    .num_uart = 2,
+
+    .canfd[0] = { 0xf19e0000, 27 },
+    .canfd[1] = { 0xf19f0000, 28 },
+    .canfd[2] = { 0xf1a00000, 95 },
+    .canfd[3] = { 0xf1a10000, 96 },
+    .num_canfd = 4,
+
+    .gem[0] = { { 0xf1a60000, 39 }, 2, "rgmii-id", 1000 },
+    .gem[1] = { { 0xf1a70000, 41 }, 2, "rgmii-id", 1000 },
+    .gem[2] = { { 0xed920000, 164 }, 4, "usxgmii", 10000 }, /* MMI 10Gb GEM */
+    .num_gem = 3,
+
+    .zdma[0] = { "adma", { 0xebd00000, 72 }, 8, 0x10000, 1 },
+    .zdma[1] = { "sdma", { 0xebd80000, 112 }, 8, 0x10000, 1 },
+    .num_zdma = 2,
+
+    .usb[0] = { .xhci = 0xf1b00000, .ctrl = 0xf1ee0000, .irq = 29 },
+    .usb[1] = { .xhci = 0xf1c00000, .ctrl = 0xf1ef0000, .irq = 34 },
+    .num_usb = 2,
+
+    .efuse = { .ctrl = 0xf1240000, .cache = 0xf1250000, .irq = 230 },
+
+    .ospi = {
+        .ctrl = 0xf1010000,
+        .dac = 0xc0000000, .dac_sz = 0x20000000,
+        .dma_src = 0xf1011000, .dma_dst = 0xf1011800,
+        .irq = 216,
+    },
+
+    .sdhci[0] = { 0xf1040000, 218 },
+    .sdhci[1] = { 0xf1050000, 220 }, /* eMMC */
+    .num_sdhci = 2,
+
+    .pmc_iou_slcr = { 0xf1060000, 222 },
+    .bbram = { 0xf11f0000, PPU1_OR_IRQ(18, 0) },
+    .crl = { 0xeb5e0000 },
+    .trng = { 0xf1230000, 233 },
+    .rtc = {
+        { 0xf12a0000, PPU1_OR_IRQ(18, 1) },
+        .alarm_irq = 200, .second_irq = 201
+    },
+
+    .cfu = {
+        .cframe_base = 0xf12d0000, .cframe_stride = 0x1000,
+        .cframe_bcast_reg = 0xf12ee000, .cframe_bcast_fdri = 0xf12ef000,
+        .cfu_apb = 0xf12b0000, .cfu_sfr = 0xf12c1000,
+        .cfu_stream = 0xf12c0000, .cfu_stream_2 = 0xf1f80000,
+        .cfu_fdro = 0xf12c2000,
+        .cfu_apb_irq = 235, .cframe_irq = EAM_IRQ(7),
+    },
+
+    .reserved = { 0xf5e00000, 270, 8 },
+};
+
 static const VersalMap *VERSION_TO_MAP[] = {
     [VERSAL_VER_VERSAL] = &VERSAL_MAP,
+    [VERSAL_VER_VERSAL2] = &VERSAL2_MAP,
 };
 
 static inline VersalVersion versal_get_version(Versal *s)
 {
     return XLNX_VERSAL_BASE_GET_CLASS(s)->version;
@@ -1291,10 +1412,15 @@ static void versal_create_efuse(Versal *s,
 {
     DeviceState *bits;
     DeviceState *ctrl;
     DeviceState *cache;
 
+    if (versal_get_version(s) != VERSAL_VER_VERSAL) {
+        /* TODO for versal2 */
+        return;
+    }
+
     ctrl = qdev_new(TYPE_XLNX_VERSAL_EFUSE_CTRL);
     cache = qdev_new(TYPE_XLNX_VERSAL_EFUSE_CACHE);
     bits = qdev_new(TYPE_XLNX_EFUSE);
 
     qdev_prop_set_uint32(bits, "efuse-nr", 3);
@@ -1542,34 +1668,47 @@ static inline void crl_connect_dev_by_name(Versal *s, Object *crl,
 }
 
 static inline void versal_create_crl(Versal *s)
 {
     const VersalMap *map;
+    VersalVersion ver;
     const char *crl_class;
     DeviceState *dev;
+    size_t num_gem;
     Object *obj;
 
     map = versal_get_map(s);
+    ver = versal_get_version(s);
 
-    crl_class = TYPE_XLNX_VERSAL_CRL;
+    crl_class = xlnx_versal_crl_class_name(ver);
     dev = qdev_new(crl_class);
     obj = OBJECT(dev);
     object_property_add_child(OBJECT(s), "crl", obj);
 
+    /*
+     * The 3rd GEM controller on versal2 is in the MMI subsystem.
+     * Its reset line is not connected to the CRL. Consider only the first two
+     * ones.
+     */
+    num_gem = ver == VERSAL_VER_VERSAL2 ? 2 : map->num_gem;
+
     crl_connect_dev_by_name(s, obj, "rpu-cluster/rpu",
                             map->rpu.num_cluster * map->rpu.num_core);
     crl_connect_dev_by_name(s, obj, map->zdma[0].name, map->zdma[0].num_chan);
     crl_connect_dev_by_name(s, obj, "uart", map->num_uart);
-    crl_connect_dev_by_name(s, obj, "gem", map->num_gem);
+    crl_connect_dev_by_name(s, obj, "gem", num_gem);
     crl_connect_dev_by_name(s, obj, "usb", map->num_usb);
 
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_abort);
 
     memory_region_add_subregion(&s->mr_ps, map->crl.addr,
                                 sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
 
-    versal_sysbus_connect_irq(s, SYS_BUS_DEVICE(dev), 0, map->crl.irq);
+    if (ver == VERSAL_VER_VERSAL) {
+        /* CRL IRQ line has been removed in versal2 */
+        versal_sysbus_connect_irq(s, SYS_BUS_DEVICE(dev), 0, map->crl.irq);
+    }
 }
 
 /*
  * This takes the board allocated linear DDR memory and creates aliases
  * for each split DDR range/aperture on the Versal address map.
@@ -1657,21 +1796,16 @@ static void versal_unimp_irq_parity_imr(void *opaque, int n, int level)
     qemu_log_mask(LOG_UNIMP,
                   "PMC SLCR parity interrupt behaviour "
                   "is not yet implemented\n");
 }
 
-static void versal_unimp(Versal *s)
+static void versal_unimp_common(Versal *s)
 {
     DeviceState *slcr;
     qemu_irq gpio_in;
 
-    versal_unimp_area(s, "psm", &s->mr_ps, 0xffc80000, 0x70000);
-    versal_unimp_area(s, "crf", &s->mr_ps, 0xfd1a0000, 0x140000);
-    versal_unimp_area(s, "apu", &s->mr_ps, 0xfd5c0000, 0x100);
     versal_unimp_area(s, "crp", &s->mr_ps, 0xf1260000, 0x10000);
-    versal_unimp_area(s, "iou-scntr", &s->mr_ps, 0xff130000, 0x10000);
-    versal_unimp_area(s, "iou-scntr-seucre", &s->mr_ps, 0xff140000, 0x10000);
 
     qdev_init_gpio_in_named(DEVICE(s), versal_unimp_sd_emmc_sel,
                             "sd-emmc-sel-dummy", 2);
     qdev_init_gpio_in_named(DEVICE(s), versal_unimp_qspi_ospi_mux_sel,
                             "qspi-ospi-mux-sel-dummy", 1);
@@ -1690,10 +1824,29 @@ static void versal_unimp(Versal *s)
 
     gpio_in = qdev_get_gpio_in_named(DEVICE(s), "irq-parity-imr-dummy", 0);
     qdev_connect_gpio_out_named(slcr, SYSBUS_DEVICE_GPIO_IRQ, 0, gpio_in);
 }
 
+static void versal_unimp(Versal *s)
+{
+    versal_unimp_area(s, "psm", &s->mr_ps, 0xffc80000, 0x70000);
+    versal_unimp_area(s, "crf", &s->mr_ps, 0xfd1a0000, 0x140000);
+    versal_unimp_area(s, "apu", &s->mr_ps, 0xfd5c0000, 0x100);
+    versal_unimp_area(s, "iou-scntr", &s->mr_ps, 0xff130000, 0x10000);
+    versal_unimp_area(s, "iou-scntr-secure", &s->mr_ps, 0xff140000, 0x10000);
+
+    versal_unimp_common(s);
+}
+
+static void versal2_unimp(Versal *s)
+{
+    versal_unimp_area(s, "fpd-systmr-ctrl", &s->mr_ps, 0xec920000, 0x1000);
+    versal_unimp_area(s, "crf", &s->mr_ps, 0xec200000, 0x100000);
+
+    versal_unimp_common(s);
+}
+
 static uint32_t fdt_add_clk_node(Versal *s, const char *name,
                                  unsigned int freq_hz)
 {
     uint32_t phandle;
 
@@ -1707,13 +1860,12 @@ static uint32_t fdt_add_clk_node(Versal *s, const char *name,
     qemu_fdt_setprop(s->cfg.fdt, name, "u-boot,dm-pre-reloc", NULL, 0);
 
     return phandle;
 }
 
-static void versal_realize(DeviceState *dev, Error **errp)
+static void versal_realize_common(Versal *s)
 {
-    Versal *s = XLNX_VERSAL_BASE(dev);
     DeviceState *slcr, *ospi;
     MemoryRegion *ocm;
     Object *container;
     const VersalMap *map = versal_get_map(s);
     size_t i;
@@ -1782,18 +1934,33 @@ static void versal_realize(DeviceState *dev, Error **errp)
     versal_create_rtc(s, &map->rtc);
     versal_create_cfu(s, &map->cfu);
     versal_create_crl(s);
 
     versal_map_ddr(s, &map->ddr);
-    versal_unimp(s);
 
     /* Create the On Chip Memory (OCM).  */
     ocm = g_new(MemoryRegion, 1);
     memory_region_init_ram(ocm, OBJECT(s), "ocm", map->ocm.size, &error_fatal);
     memory_region_add_subregion_overlap(&s->mr_ps, map->ocm.addr, ocm, 0);
 }
 
+static void versal_realize(DeviceState *dev, Error **errp)
+{
+    Versal *s = XLNX_VERSAL_BASE(dev);
+
+    versal_realize_common(s);
+    versal_unimp(s);
+}
+
+static void versal2_realize(DeviceState *dev, Error **errp)
+{
+    Versal *s = XLNX_VERSAL_BASE(dev);
+
+    versal_realize_common(s);
+    versal2_unimp(s);
+}
+
 void versal_sdhci_plug_card(Versal *s, int sd_idx, BlockBackend *blk)
 {
     DeviceState *sdhci, *card;
 
     sdhci = DEVICE(versal_get_child_idx(s, "sdhci", sd_idx));
@@ -1925,20 +2092,30 @@ static const Property versal_properties[] = {
 
 static void versal_base_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->realize = versal_realize;
     device_class_set_props(dc, versal_properties);
     /* No VMSD since we haven't got any top-level SoC state to save.  */
 }
 
 static void versal_class_init(ObjectClass *klass, const void *data)
 {
     VersalClass *vc = XLNX_VERSAL_BASE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
 
     vc->version = VERSAL_VER_VERSAL;
+    dc->realize = versal_realize;
+}
+
+static void versal2_class_init(ObjectClass *klass, const void *data)
+{
+    VersalClass *vc = XLNX_VERSAL_BASE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    vc->version = VERSAL_VER_VERSAL2;
+    dc->realize = versal2_realize;
 }
 
 static const TypeInfo versal_base_info = {
     .name = TYPE_XLNX_VERSAL_BASE,
     .parent = TYPE_SYS_BUS_DEVICE,
@@ -1953,12 +2130,19 @@ static const TypeInfo versal_info = {
     .name = TYPE_XLNX_VERSAL,
     .parent = TYPE_XLNX_VERSAL_BASE,
     .class_init = versal_class_init,
 };
 
+static const TypeInfo versal2_info = {
+    .name = TYPE_XLNX_VERSAL2,
+    .parent = TYPE_XLNX_VERSAL_BASE,
+    .class_init = versal2_class_init,
+};
+
 static void versal_register_types(void)
 {
     type_register_static(&versal_base_info);
     type_register_static(&versal_info);
+    type_register_static(&versal2_info);
 }
 
 type_init(versal_register_types);
-- 
2.50.0


