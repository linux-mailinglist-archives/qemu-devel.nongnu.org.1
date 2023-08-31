Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5E578F18D
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 18:58:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbkyz-0001Br-GO; Thu, 31 Aug 2023 12:57:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1qbkyp-00017H-EO
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 12:57:15 -0400
Received: from mail-bn7nam10on20601.outbound.protection.outlook.com
 ([2a01:111:f400:7e8a::601]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1qbkyk-0003Xb-T0
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 12:57:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iApKE9hvKzDw/85HrmJb2AOVoELkYtCf+TAn/n2ECPuzG3HDsGj4x+VgAcm6VczFBAPAx95/zF3f+ZmquBkaP015Wm/D8oPWcVDzs57VGYW99stGGF7jMGX7C6xkemlW6IVhvS7OsBiNmQbt7vh+rlFZoFZ+6ZOHF036rWBXk+l/Rb2k3hVrLQ8jGZWRnb8UKhktoI/JtDSqEtdBXfBWHrOdyXvXoKU3q5TYP5lpW06BNBHr8zWgnO8evnRX7ZSBvPYiU2fxNykTKH0384W8Ztx3oqKpDjmjj0tPNzfV9MNC+UdU5MD/fNwhLcKmUY4zQXOEQlI7c/5m74aiXf67Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kYVIUFfhd7F1xKgc8Iym0/HlvpD4oHxvRPRdFOekGUs=;
 b=ilps1ygCYxFZc2IFoZTlcG+kc9tsyJfdjgu4lT3LpIJWFB3hbokLoXs5+RU+FiztbenPLvRjrMvsNRKqXSsR0aaxcpwerdE+BCjdajgXF9uCWok3h3cG7Si9SwDrH5/CKKRs5ziz6WL2OMpG4JEySM1DWMFr2HX91gW0EJZKuNL12qcJkSd0uk/ayysK7IV+/HmaP/IGgzf1n5bfZwuyFYsi1zCyPzYAJiK/fLkRitKaTB+nm8DNvJTvwS44EGWuInLPxqcamClLoKdpj8kc0Jx12P/UPR2jSlimBgdETYgPQhGsg1bJQXTPaEvzQJyISdxFnqSG0sJMpDvSUVHUsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYVIUFfhd7F1xKgc8Iym0/HlvpD4oHxvRPRdFOekGUs=;
 b=M/oXbT1usP4wM5PnHfEopTkNisLT8OzYMp87zrZGscZw7B3shM5j0xRiJfgGfr2GG58qGQcgTx9vCngzmW2Y+wWVgDOK58q5KyurqtCkqjZJP9nu5UAPQa3T9KuOvsxzZns44Ca4gLAr1lvl+44R6xOsGzeASTL/RPfox7ZDuDI=
Received: from MW3PR05CA0011.namprd05.prod.outlook.com (2603:10b6:303:2b::16)
 by LV8PR12MB9450.namprd12.prod.outlook.com (2603:10b6:408:202::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Thu, 31 Aug
 2023 16:57:06 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:303:2b:cafe::d1) by MW3PR05CA0011.outlook.office365.com
 (2603:10b6:303:2b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.12 via Frontend
 Transport; Thu, 31 Aug 2023 16:57:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Thu, 31 Aug 2023 16:57:05 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 31 Aug
 2023 11:57:04 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 31 Aug
 2023 09:57:04 -0700
Received: from xdcsswbld02.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 31 Aug 2023 11:57:03 -0500
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: <qemu-devel@nongnu.org>
CC: <frasse.iglesias@gmail.com>, <alistair@alistair23.me>,
 <edgar.iglesias@gmail.com>, <peter.maydell@linaro.org>, <fkonrad@amd.com>,
 <sai.pavan.boddu@amd.com>, <tong.ho@amd.com>, <vikram.garhwal@amd.com>
Subject: [PATCH v5 1/8] hw/misc: Introduce the Xilinx CFI interface
Date: Thu, 31 Aug 2023 17:56:54 +0100
Message-ID: <20230831165701.2016397-2-francisco.iglesias@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230831165701.2016397-1-francisco.iglesias@amd.com>
References: <20230831165701.2016397-1-francisco.iglesias@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|LV8PR12MB9450:EE_
X-MS-Office365-Filtering-Correlation-Id: ba239db0-07b7-42d5-389a-08dbaa434e46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qqrGzMIqVcl5C/6cPhegegIxOgCsCRgLYfltjphgejyDrFai46Or37HcdjWnklBovTs5/pXfJkAI/JEPHhcErdfkYO+oGMHTCG7doDNUkcfrf2mp1tUDfmaRgttP20KAtkZjue07BovgXDlEORRnZuW8hbhIj42qZzMt5wMkhCrn/p9rCOf+gUwirieEEqj8Zfi+h4dfXA3hqnSlx4VBgHssYqCxJlVs1HBFPwwX9hwBilEtdmmCkxmi+XOPp6Yj1twkTRQumECqbCMpyN9pqIeo/dLeQ+PmbEwh4IqxC4OYEBj8t4INapDDfb4/eCu8TWNVeEzacF71xX2KsWz6eEcPh1XKRDFqHxTM25W0uuyGTNyLKyJX/LXRkHdv/emwf6dK/SDkAOCHXt5F7vLHP1uBh23//iCRabVpg3isktLl6VHQbUsoTywM8vXRvTr6DAPXzs6ddQW+LCqlfwULZpw2Wxb7Eay/tXNryJ9FgVD7XQEWXtLvc2KcAxko+X/Hx+OlVLu5Hg1foMG3FkjOhBsD8URaC+3H7Nym74wm63P5JOHjigcS2XY/6inWvjzP/ZWH/fjXK5K3ywO2RM3YMyC6Np7kjg4Xk9mn+KdIcrAbZG3boeT+iRaPaeC+0e4lqtZ1bQOmpzD+dt2kG01pwaWLZCePYgR6uhoUCzsOMa7ChQwOCduXciw1aH55kTmRiuI8tOv99dvaV21z8poR1dY9Fjtk8e3sb5TitxR5Y83DOvDX1cLxPO0kOWqTnTAGsovEIUUeaeCVkxp4IhdTQw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(1800799009)(451199024)(186009)(82310400011)(40470700004)(46966006)(36840700001)(478600001)(40480700001)(40460700003)(54906003)(70586007)(70206006)(6916009)(82740400003)(81166007)(356005)(316002)(2906002)(41300700001)(2616005)(8676002)(86362001)(8936002)(5660300002)(4326008)(44832011)(426003)(47076005)(36860700001)(6666004)(26005)(336012)(1076003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 16:57:05.4250 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba239db0-07b7-42d5-389a-08dbaa434e46
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9450
Received-SPF: softfail client-ip=2a01:111:f400:7e8a::601;
 envelope-from=francisco.iglesias@amd.com;
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


