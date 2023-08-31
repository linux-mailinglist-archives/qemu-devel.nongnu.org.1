Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D938B78F136
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 18:27:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbkUE-0004B4-GK; Thu, 31 Aug 2023 12:25:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1qbkU0-00048U-Ii
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 12:25:25 -0400
Received: from mail-mw2nam10on20611.outbound.protection.outlook.com
 ([2a01:111:f400:7e89::611]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1qbkTw-0004iS-3C
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 12:25:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xog5btunHQLJEWxie3SpC5WZHFWr6Ova6FTorbzf9eOJ5b9Pt5WE+eegnbB76SGATxGt/+kOCqSxsIuqlau2mQ9Qbiarhb/EvP63XmM5S4IjisCCSWidJYHMvgUf+BA5gS4S99oR59Z5BZLpIniBsnc08CNCPOIItErSia4mk+bErM82MmkYJKzOEf6RQZxN1te3NFU8T8vU7zhQcRghAloYrNvrdNtVuCjhZ9+mGHSmSgbeGyj86IWnmmAYXnxnIp2LtSHdtRZXXu23AoCL6huQdLri8tY831iNrIuSUBUqgPcGm0HFGJUclJlHKzUwksv7NKLLAbykPp6YZgpPAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kYVIUFfhd7F1xKgc8Iym0/HlvpD4oHxvRPRdFOekGUs=;
 b=g8NL3atNRcBuzbF/+D/1Mv5PV/XsCqo3CD6VfiF6eHrTMxZb5UQM898bqlwpw0kMi+rRw6jCWltqriePVgFvUdh0IDeeDk3porY1P2uGpdAspDonwSCCQbsi6MmV0a3bKpK5m5Oy2p0IILBjxoLjh6JUcokNCumsbiEM2Uv60bB7iPXE6Bt2dU7eSB5+lpiY8GycCOr+rfEqkiLB7GghWnfUEQh0TJEA0VArOmp0L4mIgJnuLvqYfyqQQxJAPdyFsGn5VFtcmyXXu/htggQ6sNECNbioYtYYzW5khmhcekcg6i3i1tPK7Y/4UelIfNMU+Uczf2MmsktIixj3eqHeEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYVIUFfhd7F1xKgc8Iym0/HlvpD4oHxvRPRdFOekGUs=;
 b=5Z26XKOmpRcXCcgdOri6E+n6mg8HSHvtDMSwaWktw/uBgFcuV7+cIdalxSgj7BkUJsdjeiS7hZlMdxYxIYczvkyOn1FbxwWvty19Xe89tAnKMMtK2zyf8xSIlVarrmcmij5LQULbQBWgocDAqbg6K5Y8OO/W1Fl7c3cm2ScMHug=
Received: from DS7PR03CA0347.namprd03.prod.outlook.com (2603:10b6:8:55::6) by
 CY8PR12MB7267.namprd12.prod.outlook.com (2603:10b6:930:55::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.35; Thu, 31 Aug 2023 16:25:16 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:8:55:cafe::59) by DS7PR03CA0347.outlook.office365.com
 (2603:10b6:8:55::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20 via Frontend
 Transport; Thu, 31 Aug 2023 16:25:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.20 via Frontend Transport; Thu, 31 Aug 2023 16:25:15 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 31 Aug
 2023 11:25:15 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 31 Aug 2023 11:25:13 -0500
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: <qemu-devel@nongnu.org>
CC: <frasse.iglesias@gmail.com>, <alistair@alistair23.me>,
 <edgar.iglesias@gmail.com>, <peter.maydell@linaro.org>, <fkonrad@amd.com>,
 <sai.pavan.boddu@amd.com>, <tong.ho@amd.com>, <vikram.garhwal@amd.com>
Subject: [PATCH v4 1/8] hw/misc: Introduce the Xilinx CFI interface
Date: Thu, 31 Aug 2023 18:24:58 +0200
Message-ID: <20230831162505.30399-2-francisco.iglesias@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831162505.30399-1-francisco.iglesias@amd.com>
References: <20230831162505.30399-1-francisco.iglesias@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|CY8PR12MB7267:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c729038-307f-4255-dcda-08dbaa3edbfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AgHpIZtohy2LLHysbc1K6wUsI0w9m3C8YnyTIEruL7SSrLFYmjxhF+bOQrJT3GXw9eU6rW34ZTDYFW5tpzKRkoXm/ieufa7uLH+AIMZ3v7RPxMcZt68MUS4PJB7TZejYIWuy4dZMfkhCPIPIUgytjH2PtrQEqst7fuqYKkWHWeuE3TPPj8YYnQPbIADMQNG+Q6KMng7P8Tx8/La33VOGzHF20afwQvYyUtXgjee0paRw+Iujkk5IUviHPNZwr2L3SpjMd/EO6uIGKiQAZgdn8WDpXFbrRIabxzKKilkw5WmmI75iaoGp0m523PpsivrZfXwP/3bIcHdBoa3pC3jN0xYpFv0VSr6krIX38F404rZogVHccOcPd9TccozhxyErhtqx02jT2hGS48/mFg+8ceYXEqeSAr0qvvbzwnJyFR7tudfOdXBkk1zh57uzsj9azMQEnp/utjEl93WtFJlv2IuVDOtMErjsbbPjvyaHP6j4yYOSBkGwZBNNkyllhNZ2hod4ssYrizl/tdIQgpDAj/d05qRuxsxwX8ne4UPQyusm92Vm0X3D/r/2ThXm2u36+y8XTHKgR1vpbBDopBGtnRQY83YKn/LQN7fkSaWnEpYd0oeB+0RGAFipwHKLyLgkGHV4JDY48z4Qv1CChEJFqcC0JTTdrFbU1lCroE6w6c6u+hNbxSEmtQsMUKC97i/nKhBnDSgcYPTu7x53R60KG5721GCXZAf6RMS3AJ4XhsdSxQ8NsDCSHn3iLIZGis7aVEElVv4C+AW74WeVJi/Itg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199024)(1800799009)(82310400011)(186009)(36840700001)(46966006)(40470700004)(82740400003)(6666004)(40460700003)(36756003)(86362001)(356005)(40480700001)(36860700001)(47076005)(81166007)(336012)(2906002)(478600001)(8676002)(26005)(70206006)(44832011)(2616005)(4326008)(5660300002)(8936002)(426003)(70586007)(6916009)(41300700001)(1076003)(316002)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 16:25:15.7595 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c729038-307f-4255-dcda-08dbaa3edbfc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7267
Received-SPF: softfail client-ip=2a01:111:f400:7e89::611;
 envelope-from=francisco.iglesias@amd.com;
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


