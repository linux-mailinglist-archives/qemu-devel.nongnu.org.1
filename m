Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87061B2D6B3
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Aug 2025 10:37:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoeAd-0007Qe-0f; Wed, 20 Aug 2025 04:27:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uoeAU-00071M-RY; Wed, 20 Aug 2025 04:27:39 -0400
Received: from mail-dm6nam11on20614.outbound.protection.outlook.com
 ([2a01:111:f403:2415::614]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uoeAO-00016A-E1; Wed, 20 Aug 2025 04:27:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B8tplXsa9IYPJ3dxOd1ZLUkghlk3XChcGorof+v5EbcEIRVGmYBDYBPVMinQ25jcAL5lz8JUxMMA2ksESxuaHHJuVucp9tWN9boDuRkbJHeSyXXVbPgZghF5TZEwiNqmReLggo5A6iXS9iZgj6IUgqqRO7i/M+vu/+THAsT2lYEATPrn0PIWPjYl9/k969iJ0f413B79DQ6UXYws8SRSorqrvwwx1qudQ5mk3syA5xQRkHLei6F0OXGr1gHALQC7c1d+i/1JQEynyJxrgjAdv8NicmYYev09wBxPuXoJygyLPR6ALGgMBb/KK1Hl8eo9oNFIMpRs3KIyyMB60OjaAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=faGVf3pQ0nR5019etbtbothfCOpcWuG77uZ/hkFC9lc=;
 b=qgymegokYghK9H86sh72FRqWZUvSEQ2cP1aSyoCuYMPMwDnhiB9yv2QlqbvnTpgyYBjA31G/F/9hq3dAfrUA9VzCGZmfoDU0Ol8E8n7AJXQlGg/0K3dQMM3BMnRwfwnBfhJQNG1St/rcnZ5Oeaccxf2xE38rH5+SyV7PwkfWUXmfr1yn4N5lBJ2WkNCJxNgsxkjQtB3vTQhL1k+ZLNtOwc0XEKEhwMGztpMzfyVd5mOwsb3JhQCyjtQH/6LdpSkr+4PkgG8seYUcO7ZGJBDQpmebQrgOFzY6XJi+jftyf91MI9T6R+HGsmzJnUnqJnv0i6LGl15M8UpApxBFSI3cdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=faGVf3pQ0nR5019etbtbothfCOpcWuG77uZ/hkFC9lc=;
 b=222nP73g8EgaKZZ4XXoAfHgIP808dv5xXljJuBZ0vlHp6R4QxiRFW435kH+VRYUwyIhZKwhKGq3ZVbOKXeL82p5BNoE1FIbzSj2XcV6YUDZeeBB5iD8tKevLz/5w6+fkcwCtuyD6heVKG1qBh1qihTu41yw9iXgeBrVKv/6jocc=
Received: from BY3PR05CA0031.namprd05.prod.outlook.com (2603:10b6:a03:39b::6)
 by CH1PR12MB9670.namprd12.prod.outlook.com (2603:10b6:610:2af::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.25; Wed, 20 Aug
 2025 08:27:24 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:a03:39b:cafe::d0) by BY3PR05CA0031.outlook.office365.com
 (2603:10b6:a03:39b::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 08:27:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 08:27:24 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 03:27:23 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 03:27:23 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 20 Aug 2025 03:27:21 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v2 38/47] hw/arm/xlnx-versal: add the target field in IRQ
 descriptor
Date: Wed, 20 Aug 2025 10:25:37 +0200
Message-ID: <20250820082549.69724-39-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820082549.69724-1-luc.michel@amd.com>
References: <20250820082549.69724-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|CH1PR12MB9670:EE_
X-MS-Office365-Filtering-Correlation-Id: 12edf855-0b16-4f36-cc47-08dddfc363d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Caz/u98E7kRY+yL9vMv3lEVu0VnMtuTvFbxyMWOBCgG8U61QEhLX6jb2qC9j?=
 =?us-ascii?Q?DmKJ3SEF7E5S2OANjCUWRVs3FyB9zgQeg0ac2n8T+xiI0QUrC0diTEJ+Kl8I?=
 =?us-ascii?Q?2keOZdlKfYC3sOuUKTnByWt4nQLBVRCTCRHosdLxp3qf8jT13sMKUB6464MX?=
 =?us-ascii?Q?mY8lEhVkcNJugkzNlqkL3u9HKGllAG5cBzEhX6dYEg3uTkYgHBkqCTzhlGGb?=
 =?us-ascii?Q?n5Z0nnfbbBKkLYnT1hXr2em6XsLC/kf4VjgOLRDI2YgszwuZW9RJmongAnn+?=
 =?us-ascii?Q?Sp4n8tdpHtlpjQ2WjJZu9VIyG13Rl1yXrZyNyCOXkQQQluKLRh36UlWUrh0P?=
 =?us-ascii?Q?NCnqEC9Z2YZS48Y1BERA8S1ZAWlFIuyqjo+Ljldcsay2UaTleDnML1ydJzKV?=
 =?us-ascii?Q?OmKeq4QZy7+ixQWb6B13uUT4bpGReUwVM8bJFK9stiEzxWjIuWbTJ0JhVhbl?=
 =?us-ascii?Q?mwPwe6Qxh8pEoPwy7kCiXPbnJ6psqfEJKZJ+E4X9QvGj9qUzDY+m9HWj7IXC?=
 =?us-ascii?Q?D++lN7YCqBVzlLWTSKMOftnUFAtJGQvWruRJQyWHkTeBdMnU9CkQt27eG92H?=
 =?us-ascii?Q?SYL9va1NhG+YBI9y33YzyukE10+m7qgl30p9UGY5UAcwQOTzCRl1wieRnvNK?=
 =?us-ascii?Q?P5D6gmlGazuZNtI6/wrOnPHaT8DVl5oGaQff/ahfOnxqf5ufni8bPOHdv6TS?=
 =?us-ascii?Q?0ksjGMuOBwm2Rnud7Li7k+zbsnvVA+80J5TPqZ8kDcQDoZmui2yilzV2Iugt?=
 =?us-ascii?Q?NmUr/yIzkbkdlhuyGNDPeqBQOA1gLgTIgx2FCExEklzwmxhKxaKLdmoU6R5z?=
 =?us-ascii?Q?7EpG9TL/hul4ACbulKgJo5Xupa4mxZzTixE1sOZ25onczaJbmVFgVIAGfcMR?=
 =?us-ascii?Q?huLXd+j5PKJhgzARWS8k9rI36fXNI6aQ3QnAnp1uGQugGgZYxqxMvRHeQGwU?=
 =?us-ascii?Q?RQmmKkv4CV91NGZJdC6BjvRj6rRUtAiS3BGwx/n5swEglYOT8cPkJ6ak5wWx?=
 =?us-ascii?Q?kVlANu97sFo+wfVoYV+Vb7VqffYxnGYyei9jXaxHvBYGUkeasKAvAh6XTz5J?=
 =?us-ascii?Q?9EBL7qzERvPbaAe7leGdnoebARJYUGr3bgB4pPn899cZ4moeTmZqpXTr7uZ1?=
 =?us-ascii?Q?Fb/ufCUrVH5ib2VUKodDfME4ruE0+BmphiusgJPWnU4ssxGJ5JGeitP77TTI?=
 =?us-ascii?Q?POyvXuD+6U5kanS5HaCy33w4p8X1F8UY9vIW4ync5kSeaf38bMNMV4bppeKb?=
 =?us-ascii?Q?W2rBg/Z8+qRc25uyeNdmAm7VkaQ18MHCfIKhh9cSaa9c3/1iMOSKRxrtwFWE?=
 =?us-ascii?Q?td07fVUn62squ/FxmfjM6+8t2GVE9DWY8xiOxehawC6krZ5YBk9eveHiI8K5?=
 =?us-ascii?Q?F6xE4O4h61alaURS6QE2teKHBMWwMrUA9wIAhtVQPAiax8To0UO3yaj5iOtr?=
 =?us-ascii?Q?xdxQ3uIxLcBVJ1mo1hvtyrIruVlTLXNYDx/VfvWL2mi1opSkMOIF+ybvVdmC?=
 =?us-ascii?Q?FMbyd7JofNqg7zut0psfN0T01i6a7kB8DOjB?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 08:27:24.1651 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12edf855-0b16-4f36-cc47-08dddfc363d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9670
Received-SPF: permerror client-ip=2a01:111:f403:2415::614;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
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

Add the target field in the IRQ descriptor. This allows to target an IRQ
to another IRQ controller than the GIC(s). Other supported targets are
the PMC PPU1 CPU interrupt controller and the EAM (Error management)
device. Those two devices are currently not implemented so IRQs
targeting those will be left unconnected. This is in preparation for
versal2.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
 hw/arm/xlnx-versal.c | 41 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 9d900fe3127..551671af425 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -50,18 +50,30 @@
 #include "hw/cpu/cluster.h"
 #include "hw/arm/bsa.h"
 
 /*
  * IRQ descriptor to catch the following cases:
+ *   - An IRQ can either connect to the GICs, to the PPU1 intc, or the the EAM
  *   - Multiple devices can connect to the same IRQ. They are OR'ed together.
  */
 FIELD(VERSAL_IRQ, IRQ, 0, 16)
+FIELD(VERSAL_IRQ, TARGET, 16, 2)
 FIELD(VERSAL_IRQ, ORED, 18, 1)
 FIELD(VERSAL_IRQ, OR_IDX, 19, 4) /* input index on the IRQ OR gate */
 
+typedef enum VersalIrqTarget {
+    IRQ_TARGET_GIC,
+    IRQ_TARGET_PPU1,
+    IRQ_TARGET_EAM,
+} VersalIrqTarget;
+
+#define PPU1_IRQ(irq) ((IRQ_TARGET_PPU1 << R_VERSAL_IRQ_TARGET_SHIFT) | (irq))
+#define EAM_IRQ(irq) ((IRQ_TARGET_EAM << R_VERSAL_IRQ_TARGET_SHIFT) | (irq))
 #define OR_IRQ(irq, or_idx) \
     (R_VERSAL_IRQ_ORED_MASK | ((or_idx) << R_VERSAL_IRQ_OR_IDX_SHIFT) | (irq))
+#define PPU1_OR_IRQ(irq, or_idx) \
+    ((IRQ_TARGET_PPU1 << R_VERSAL_IRQ_TARGET_SHIFT) | OR_IRQ(irq, or_idx))
 
 typedef struct VersalSimplePeriphMap {
     uint64_t addr;
     int irq;
 } VersalSimplePeriphMap;
@@ -415,19 +427,27 @@ static qemu_irq versal_get_gic_irq(Versal *s, int irq_idx)
  * Or gates are placed under the /soc/irq-or-gates QOM container.
  */
 static qemu_irq versal_get_irq_or_gate_in(Versal *s, int irq_idx,
                                           qemu_irq target_irq)
 {
+    static const char *TARGET_STR[] = {
+        [IRQ_TARGET_GIC] = "gic",
+        [IRQ_TARGET_PPU1] = "ppu1",
+        [IRQ_TARGET_EAM] = "eam",
+    };
+
+    VersalIrqTarget target;
     Object *container = versal_get_child(s, "irq-or-gates");
     DeviceState *dev;
     g_autofree char *name;
     int idx, or_idx;
 
     idx = FIELD_EX32(irq_idx, VERSAL_IRQ, IRQ);
     or_idx = FIELD_EX32(irq_idx, VERSAL_IRQ, OR_IDX);
+    target = FIELD_EX32(irq_idx, VERSAL_IRQ, TARGET);
 
-    name = g_strdup_printf("irq[%d]", idx);
+    name = g_strdup_printf("%s-irq[%d]", TARGET_STR[target], idx);
     dev = DEVICE(object_resolve_path_at(container, name));
 
     if (dev == NULL) {
         dev = qdev_new(TYPE_OR_IRQ);
         object_property_add_child(container, name, OBJECT(dev));
@@ -439,16 +459,33 @@ static qemu_irq versal_get_irq_or_gate_in(Versal *s, int irq_idx,
     return qdev_get_gpio_in(dev, or_idx);
 }
 
 static qemu_irq versal_get_irq(Versal *s, int irq_idx)
 {
+    VersalIrqTarget target;
     qemu_irq irq;
     bool ored;
 
+    target = FIELD_EX32(irq_idx, VERSAL_IRQ, TARGET);
     ored = FIELD_EX32(irq_idx, VERSAL_IRQ, ORED);
 
-    irq = versal_get_gic_irq(s, irq_idx);
+    switch (target) {
+    case IRQ_TARGET_EAM:
+        /* EAM not implemented */
+        return NULL;
+
+    case IRQ_TARGET_PPU1:
+        /* PPU1 CPU not implemented */
+        return NULL;
+
+    case IRQ_TARGET_GIC:
+        irq = versal_get_gic_irq(s, irq_idx);
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
 
     if (ored) {
         irq = versal_get_irq_or_gate_in(s, irq_idx, irq);
     }
 
-- 
2.50.1


