Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF876787811
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 20:36:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZFAi-0006x1-RI; Thu, 24 Aug 2023 14:35:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1qZFAg-0006wk-J4
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 14:35:06 -0400
Received: from mail-mw2nam12on20617.outbound.protection.outlook.com
 ([2a01:111:f400:fe5a::617]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1qZFAb-0006xh-Bg
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 14:35:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aeynt6ZeQeyDEJz096vPCdcIDUT3zE+hAKBXr8ox81bS4uLgIGQIhrKaiBPm0enqqxv3kTi515wbm1aqKbZLat4oMkwgb+zW1OpgOw/OoqTx0bO0N0Gztdp7zeo5YBc/BfQ0LHiGE/mTtk/+VALxAx4yAdUc/J6mmNPv1CFMs9Z2GJHiIc9Y5Xl9SN8vt+XizcRhMsLKP1ywMS32lWf7JhDHs2bc/MXt6/6GyxjuqYq22tpZqOvxlETQvpNmuob7z1VHM9k634c7hjaURbqWnxC4LYdrmDfNarudsJMgyi7Q7uIWskOiJxSjSmk1KKxklFVBxJ2nyZez/cOh5zL1pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kYVIUFfhd7F1xKgc8Iym0/HlvpD4oHxvRPRdFOekGUs=;
 b=WhhCdsqJltghRJDxJaewjN2Dte02F8xRuPeoExgBu2wJpCeWWTy/ddkOWU2ME6lZxgq+/IoamEHvXDxmCgx5Ma0kMskf3e4jpKjk0jPV6VK1EshMzjT4zWxX5sktXYf7q2VTFJDi5D4lVefdgjCE68uKsq8XjJM5wUhLo+6uQCeVTzCOI7JD9zjQ4rnKwBnjqEWYYSkgr+7vRZw8kuiPn4T+fOucpVVwYPT18dd4E5BO/FXWTVvm9Wd+tqVuAieJfM+yY0e5AiSgrOAGr8DLbul3/okwEtopBtOl6DV6nE7ST4NeAwM47NUWa+YU42p2o486wbKSPrFHLyc/vs33sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYVIUFfhd7F1xKgc8Iym0/HlvpD4oHxvRPRdFOekGUs=;
 b=c4xJlK7cR4wOBwzO2E+t5rKun6egnP49CQlV5DvoK94RYRcOFxWSrnJcxpAADEUcsedUmA4iEO5Wgt0wTGeBd7VLN+pSDQVsogFJVUeOHmiIY3UFETOtIp0aia+faTprKGlKXxyqBYBj46oGJeyzI2TeaNaVRmnr2GKpQHwfJBQ=
Received: from MW4PR03CA0301.namprd03.prod.outlook.com (2603:10b6:303:dd::6)
 by CH2PR12MB4152.namprd12.prod.outlook.com (2603:10b6:610:a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Thu, 24 Aug
 2023 18:34:54 +0000
Received: from CO1PEPF000044FB.namprd21.prod.outlook.com
 (2603:10b6:303:dd:cafe::55) by MW4PR03CA0301.outlook.office365.com
 (2603:10b6:303:dd::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26 via Frontend
 Transport; Thu, 24 Aug 2023 18:34:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044FB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.2 via Frontend Transport; Thu, 24 Aug 2023 18:34:53 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 13:34:53 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 24 Aug 2023 13:34:51 -0500
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: <qemu-devel@nongnu.org>
CC: <frasse.iglesias@gmail.com>, <alistair@alistair23.me>,
 <edgar.iglesias@gmail.com>, <peter.maydell@linaro.org>, <fkonrad@amd.com>,
 <sai.pavan.boddu@amd.com>, <tong.ho@amd.com>, <vikram.garhwal@amd.com>
Subject: [PATCH v3 1/8] hw/misc: Introduce the Xilinx CFI interface
Date: Thu, 24 Aug 2023 20:34:41 +0200
Message-ID: <20230824183448.151738-2-francisco.iglesias@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824183448.151738-1-francisco.iglesias@amd.com>
References: <20230824183448.151738-1-francisco.iglesias@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FB:EE_|CH2PR12MB4152:EE_
X-MS-Office365-Filtering-Correlation-Id: 652b4d25-6bac-4336-35b3-08dba4d0cf37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wqc4ecFuHxiiWcYa451GXLLCw+4tM3spy/4F5wHo7GtqBcvSmppJvGwg3bqLIY47aolka34oTvh+vcwFZMxw+xoFdkS3oHkwbFChM6lGBdgcCysvhlAqlSEjSBhP57PdboXqVgamzDJoxps8WJKh3GT2niMg43KXnIKocPwNmdXOvL34eSsv4PWW6AfSgITqwDByho1YudLc7cudwt80Ikebt4q+iPyqSm4UKFpoFdZDrUspnTIpdsEnv0f9Su7DU9gsaKIppW7H0o/o6W55KDVYcmjK1Gd9Q2UPXNafAii83xA8MVSYun2HmLXdWITm2dgEAoXdkTzLRSdJjIHW9n8oSB6iSbselNReXnAtNtJPyKozmSN+rm6FQbx2J62Ky7KD8HcZxiq3jbBlZwfDNLbfaUnpT/2GyfbmjVQ7ehu1uKOrLOhbeYqtM+DAJdH4bLnTkPumM5Zsz3o2TB0mmRQxBGqE5SqgDUnaPk2B3HfckJpFiJ1OgoTEOhGuSRMs8xVN/E+jnyklEyY4VsOj154ZZ/E0SXW4IJUZ+t0PFgAO2lb3CyWsaxcfEDtLJoIYEcWyC9bwg0RMOlKvXFTrHRvHsWGC+RLj2Ij6H2HYuLerwLaR1l++OAZxq6gGOQzGKCjIuUPsaZr6OeeP49Lobu8cU4bfRZiJ4vGq0xM856uwu2iCFZOn/QZ2dydgiF2eTAtgQdl0xqqQK7FX6uEo80BSV3QVleyjn0OZ00XToF4MOKfBk1jROqO3wRLoBIyCUrMkkYUF9M/HznKy+j6zzQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(39860400002)(346002)(376002)(186009)(1800799009)(451199024)(82310400011)(36840700001)(40470700004)(46966006)(54906003)(6916009)(316002)(70586007)(70206006)(8676002)(8936002)(4326008)(2616005)(36756003)(41300700001)(1076003)(40460700003)(81166007)(82740400003)(356005)(478600001)(6666004)(5660300002)(40480700001)(2906002)(36860700001)(47076005)(86362001)(336012)(426003)(44832011)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 18:34:53.8305 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 652b4d25-6bac-4336-35b3-08dba4d0cf37
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4152
Received-SPF: softfail client-ip=2a01:111:f400:fe5a::617;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
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


