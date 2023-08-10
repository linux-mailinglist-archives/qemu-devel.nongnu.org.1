Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0A0778135
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 21:17:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUB9H-0000QD-SH; Thu, 10 Aug 2023 15:16:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1qUB9D-0000Ps-Si
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 15:16:39 -0400
Received: from mail-dm6nam11on20609.outbound.protection.outlook.com
 ([2a01:111:f400:7eaa::609]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1qUB9B-00073G-0D
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 15:16:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N0hshBfBup6TB92rEyW2QJZVnprY9pKyQn6gitPNFO4z8OJ1Dg8Ka6cIfGxRipBLNaStUH97Mc7O1JxCVSWoDblon6gelxFvDdZFC07HWZHJZj6m/dbEhFyot0OGHCIjg9KI2Btmktz19Kw5SH+/QAEzQvFlzFZFIWw6GfNgW3F9yxO4sL3nKMyqNq+e3ei8AKYoE5KUPMdn78vlMsrRZk+Eha8szqhSSlDVl2ziJewPTr9/b7C7i50O5QGcqc2+EEBOV/l0pSyXKhqLRddM57PVM++amWvMD/L8B0RmgErOvAaq6NPB45aN8Ru2Fa7jdBEBX/bQUc0HY740qXZi2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kYVIUFfhd7F1xKgc8Iym0/HlvpD4oHxvRPRdFOekGUs=;
 b=LfewjTSDt+IlF/xvxbHDWJ3EqAWwz/5r8KRfWqKjUsO22lsC5+gkeCN/i3PnYCKq07XSxrWU7AxBr8E+0aEXskvaNFOuKwRwD4KFNFixmV5juVAdqHN8arvvTcm54SiIC1Lci1Dzh60LYwJE/hA76T/HOH/W9L4ky8Yzj4tLiOhS5Kmq/cvORVkDPfF3sZYCI25wya6NTer/sOswjJ9PCxfnrJNXZo+1CGpnat+UhNMbgm98dzMhPbPMF3p0EOZfGaUyJuzlXQSp/P/04CB3o0f6jP1jZu8TH8g6jR8eePutJKt+hkEBRen8o7hTWfLJAu6SAu37MkXUqQVHQNXLYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYVIUFfhd7F1xKgc8Iym0/HlvpD4oHxvRPRdFOekGUs=;
 b=xP4yNlL0BwEJO1uR4wD+eVxYWy6xl5+pBArfFLBWSa9WrCiT+slmGqmrsUg6JuRtOQO8nfRoBSOjQmIxzFgLAt69Cue+CsCFzNwi6cH52Tv/Sduwb9+nhjBZnLxjHEnt/7Kok4UDTJ4K0IPBiHddM5PEUXWlDKocXWA3RJBXDJw=
Received: from CY5PR04CA0004.namprd04.prod.outlook.com (2603:10b6:930:1e::26)
 by LV3PR12MB9440.namprd12.prod.outlook.com (2603:10b6:408:215::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 19:16:32 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:930:1e:cafe::ad) by CY5PR04CA0004.outlook.office365.com
 (2603:10b6:930:1e::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30 via Frontend
 Transport; Thu, 10 Aug 2023 19:16:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Thu, 10 Aug 2023 19:16:31 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 14:16:30 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 10 Aug 2023 14:16:29 -0500
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: <qemu-devel@nongnu.org>
CC: <frasse.iglesias@gmail.com>, <alistair@alistair23.me>,
 <edgar.iglesias@gmail.com>, <peter.maydell@linaro.org>, <fkonrad@amd.com>,
 <sai.pavan.boddu@amd.com>, <tong.ho@amd.com>, <vikram.garhwal@amd.com>
Subject: [PATCH v2 1/8] hw/misc: Introduce the Xilinx CFI interface
Date: Thu, 10 Aug 2023 21:16:19 +0200
Message-ID: <20230810191626.81084-2-francisco.iglesias@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810191626.81084-1-francisco.iglesias@amd.com>
References: <20230810191626.81084-1-francisco.iglesias@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|LV3PR12MB9440:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b144b8a-cffc-4a46-41ac-08db99d64e3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SR59fQ2N7iPe0WGu2rVp3w9CcTq6PaTHURWF3Wm2+zlP4D4Ppe0EgDTkM5OfVHSpwGtNpWEpqtIrhcziczTIi/QdufOiyiBsGYq0UrJCTwExMIZ1m/VS91jXMRiU5Tqr9tWwVkcEHjnP6p5P9sXyGZqCsCYvJ7LfhyH2/e9aRNG5V6X9fBYI6yuc5glLAyz/yx89HgpOe52x/PU10CqP+f4a7kKXYpbX6Rz2fY0cXDaT8Xhsrq0cI6t1LOnpxewHiqu73zVumeJk9wiX+GDDhSXaNrdpoSigFzMTolNVA5Walb749Udx8+8ncrhNXctFnhGAJZCG+ZT7zL3hgyBRzSDCafbiIdmcbs/5uc5xUpFJpu3OOW+2XndvuCo+c9Vo2ofqh1UmEVuN5e6bFxc08x/oYFCbH+G8e2yehB0O9F76UtZM1jOQLoxDSlTEgNU/dwQrmKIhvLUNbh7v3ypgaFq+v187Q8/iKEacuvajLwS9y0EeFvD3vqFGcPA5Pwbbk5dsvL9oVo+1YZZ0VMkA1gm/0UGwIkSHKGPZ9aVjgMRZYdJNDg0Z3z7Y/18dt2w7rdlGW46iZ4m3rH5BeBpqlnFDXzEc81gv/GZewlO9xBIZfV/WosdHvMtWXNbVAaLAKD3puY5a7MA2n6IdQAyqIFmIS+sAqsla9xrGjOW3x7SB3e2uWioUo01CdI8l1QsSdOfGHA6QWtL/tNCFex85CpM46ssAcpC10aAMx7g+yb1gfeY7zhXW0BEL7x50Ng6ij/Ksmi2TqXIVmUGg0P4ayQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(376002)(82310400008)(1800799006)(451199021)(186006)(40470700004)(36840700001)(46966006)(5660300002)(8676002)(4326008)(8936002)(44832011)(41300700001)(316002)(6916009)(70586007)(70206006)(36860700001)(478600001)(86362001)(2906002)(356005)(81166007)(6666004)(82740400003)(1076003)(36756003)(336012)(47076005)(26005)(426003)(54906003)(40460700003)(2616005)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 19:16:31.6520 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b144b8a-cffc-4a46-41ac-08db99d64e3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9440
Received-SPF: softfail client-ip=2a01:111:f400:7eaa::609;
 envelope-from=francisco.iglesias@amd.com;
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

Introduce the Xilinx Configuration Frame Interface (CFI) for transmitting
CFI data packets between the Xilinx Configuration Frame Unit models
(CFU_APB, CFU_FDRO and CFU_SFR), the Xilinx CFRAME controller (CFRAME_REG)
and the Xilinx CFRAME broadcast controller (CFRAME_BCAST_REG) models (when
emulating bitstream programming and readback).

Signed-off-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Acked-by: Edgar E. Iglesias <edgar@zeroasic.com>
---
 MAINTAINERS                   |  6 ++++
 hw/misc/meson.build           |  1 +
 hw/misc/xlnx-cfi-if.c         | 34 ++++++++++++++++++++
 include/hw/misc/xlnx-cfi-if.h | 59 +++++++++++++++++++++++++++++++++++
 4 files changed, 100 insertions(+)
 create mode 100644 hw/misc/xlnx-cfi-if.c
 create mode 100644 include/hw/misc/xlnx-cfi-if.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 6111b6b4d9..e0cd365462 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1034,6 +1034,12 @@ S: Maintained
 F: hw/ssi/xlnx-versal-ospi.c
 F: include/hw/ssi/xlnx-versal-ospi.h
 
+Xilinx Versal CFI
+M: Francisco Iglesias <francisco.iglesias@amd.com>
+S: Maintained
+F: hw/misc/xlnx-cfi-if.c
+F: include/hw/misc/xlnx-cfi-if.h
+
 STM32F100
 M: Alexandre Iooss <erdnaxe@crans.org>
 L: qemu-arm@nongnu.org
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 892f8b91c5..0c562f5e3e 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -97,6 +97,7 @@ specific_ss.add(when: 'CONFIG_XLNX_VERSAL', if_true: files('xlnx-versal-crl.c'))
 system_ss.add(when: 'CONFIG_XLNX_VERSAL', if_true: files(
   'xlnx-versal-xramc.c',
   'xlnx-versal-pmc-iou-slcr.c',
+  'xlnx-cfi-if.c',
 ))
 system_ss.add(when: 'CONFIG_STM32F2XX_SYSCFG', if_true: files('stm32f2xx_syscfg.c'))
 system_ss.add(when: 'CONFIG_STM32F4XX_SYSCFG', if_true: files('stm32f4xx_syscfg.c'))
diff --git a/hw/misc/xlnx-cfi-if.c b/hw/misc/xlnx-cfi-if.c
new file mode 100644
index 0000000000..c45f05c4aa
--- /dev/null
+++ b/hw/misc/xlnx-cfi-if.c
@@ -0,0 +1,34 @@
+/*
+ * Xilinx CFI interface
+ *
+ * Copyright (C) 2023, Advanced Micro Devices, Inc.
+ *
+ * Written by Francisco Iglesias <francisco.iglesias@amd.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+#include "hw/misc/xlnx-cfi-if.h"
+
+void xlnx_cfi_transfer_packet(XlnxCfiIf *cfi_if, XlnxCfiPacket *pkt)
+{
+    XlnxCfiIfClass *xcic = XLNX_CFI_IF_GET_CLASS(cfi_if);
+
+    if (xcic->cfi_transfer_packet) {
+        xcic->cfi_transfer_packet(cfi_if, pkt);
+    }
+}
+
+static const TypeInfo xlnx_cfi_if_info = {
+    .name          = TYPE_XLNX_CFI_IF,
+    .parent        = TYPE_INTERFACE,
+    .class_size = sizeof(XlnxCfiIfClass),
+};
+
+static void xlnx_cfi_if_register_types(void)
+{
+    type_register_static(&xlnx_cfi_if_info);
+}
+
+type_init(xlnx_cfi_if_register_types)
+
diff --git a/include/hw/misc/xlnx-cfi-if.h b/include/hw/misc/xlnx-cfi-if.h
new file mode 100644
index 0000000000..f9bd12292d
--- /dev/null
+++ b/include/hw/misc/xlnx-cfi-if.h
@@ -0,0 +1,59 @@
+/*
+ * Xilinx CFI interface
+ *
+ * Copyright (C) 2023, Advanced Micro Devices, Inc.
+ *
+ * Written by Francisco Iglesias <francisco.iglesias@amd.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef XLNX_CFI_IF_H
+#define XLNX_CFI_IF_H 1
+
+#include "qemu/help-texts.h"
+#include "hw/hw.h"
+#include "qom/object.h"
+
+#define TYPE_XLNX_CFI_IF "xlnx-cfi-if"
+typedef struct XlnxCfiIfClass XlnxCfiIfClass;
+DECLARE_CLASS_CHECKERS(XlnxCfiIfClass, XLNX_CFI_IF, TYPE_XLNX_CFI_IF)
+
+#define XLNX_CFI_IF(obj) \
+     INTERFACE_CHECK(XlnxCfiIf, (obj), TYPE_XLNX_CFI_IF)
+
+typedef enum {
+    PACKET_TYPE_CFU = 0x52,
+    PACKET_TYPE_CFRAME = 0xA1,
+} xlnx_cfi_packet_type;
+
+typedef enum {
+    CFRAME_FAR = 1,
+    CFRAME_SFR = 2,
+    CFRAME_FDRI = 4,
+    CFRAME_CMD = 6,
+} xlnx_cfi_reg_addr;
+
+typedef struct XlnxCfiPacket {
+    uint8_t reg_addr;
+    uint32_t data[4];
+} XlnxCfiPacket;
+
+typedef struct XlnxCfiIf {
+    Object Parent;
+} XlnxCfiIf;
+
+typedef struct XlnxCfiIfClass {
+    InterfaceClass parent;
+
+    void (*cfi_transfer_packet)(XlnxCfiIf *cfi_if, XlnxCfiPacket *pkt);
+} XlnxCfiIfClass;
+
+/**
+ * Transfer a XlnxCfiPacket.
+ *
+ * @cfi_if: the object implementing this interface
+ * @XlnxCfiPacket: a pointer to the XlnxCfiPacket to transfer
+ */
+void xlnx_cfi_transfer_packet(XlnxCfiIf *cfi_if, XlnxCfiPacket *pkt);
+
+#endif /* XLNX_CFI_IF_H */
-- 
2.34.1


