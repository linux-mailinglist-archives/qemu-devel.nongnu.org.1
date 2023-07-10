Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EC774D869
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 16:05:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIrTp-0000f6-2V; Mon, 10 Jul 2023 10:03:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1qIrTl-0000dJ-GZ
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 10:03:05 -0400
Received: from mail-mw2nam12on20614.outbound.protection.outlook.com
 ([2a01:111:f400:fe5a::614]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1qIrTg-0003FD-Tv
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 10:03:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZcBFyPh8nnaSth67DTgsaP8mHPvrRdBXEor0REYOUKYItRbQFYjNOqiBe+VMTzUZaqy+QPraKKfdZ77XBP49S9pEwDhnFz8ZwclFluL30jJ5TzlPhXkgg2ws906EIOaulPrpaL2eLUw+C0XRvcehHKWKW4NvsZFrUlyQrNlrPx12RdaFQK+ILYDCiFkovyB8uu3cVpPNmdgmhtWCzp+VWEa2MAao8hXE+F0IjZrZsCjDbYMl16ucgSmHhV9lg4pwOIaexPxTs1mi2YzCGaVb+aSzvp+1O8Vf7Yhll+Mj6ipSuhcOU7ke7xYhchU0JkLnuySi91SN2zOXleuZkMj6Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sHhIriwZbP9awjgZ8nKvDBazSnfzxX3R6ZmzbLSU8mE=;
 b=WmUChxynxGVOnZFnVHQzFPDd4e1K8ByOTs8hgkRxibuLyNoJld62X11prMbn+oYuUN/6VVoPh7Oe3HxDtRvJkN7lXM6Az7jbyc3/rfHn9TOGpRHCu8dAd+9EcCn60GHhuWPCVQtpL52RH493YQZoG2YNwBg6qyK5XJuZn+xEVKJtL8Ea5NIlZF/15ObU56mwHQC3O5oXJ96ZNLW/A3GMDr2hQ44Fs892d6Xz58KLqSkNrLhyAseIvtIFESDZ2nXsfxpAWnvPyS128/byJ/U4l8NdmCHJkJT7tczaVwf9xQ4FJZT69FZ+DF4bsLTNVxAnrk3AtCbFUYqHA8HeMB0LLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHhIriwZbP9awjgZ8nKvDBazSnfzxX3R6ZmzbLSU8mE=;
 b=O0L66BXU2AADu8O2ktcQoPSTbFpPUcEft58wFOdwNrUram7H6HUguap7eqq9Mbep+dfI8rkkTo3RDhr3fzgBssMtNwhdEkFJ3hfPi7TNt8/Im08Hd+kMgdU6nkF4e6YDJ0L98OFOFPZaGHVOFGayM/isL7rZ7qgPQx6XOja6O/g=
Received: from DM5PR07CA0058.namprd07.prod.outlook.com (2603:10b6:4:ad::23) by
 IA1PR12MB6649.namprd12.prod.outlook.com (2603:10b6:208:3a2::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.30; Mon, 10 Jul 2023 14:02:55 +0000
Received: from DM6NAM11FT098.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::24) by DM5PR07CA0058.outlook.office365.com
 (2603:10b6:4:ad::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30 via Frontend
 Transport; Mon, 10 Jul 2023 14:02:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT098.mail.protection.outlook.com (10.13.173.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.18 via Frontend Transport; Mon, 10 Jul 2023 14:02:54 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 10 Jul
 2023 09:02:54 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 10 Jul
 2023 07:02:54 -0700
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Mon, 10 Jul 2023 09:02:52 -0500
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: <qemu-devel@nongnu.org>
CC: <frasse.iglesias@gmail.com>, <alistair@alistair23.me>,
 <edgar.iglesias@gmail.com>, <peter.maydell@linaro.org>, <fkonrad@amd.com>,
 <sai.pavan.boddu@amd.com>, <tong.ho@amd.com>, <vikram.garhwal@amd.com>
Subject: [PATCH v1 1/8] hw/misc: Introduce the Xilinx CFI interface
Date: Mon, 10 Jul 2023 16:02:42 +0200
Message-ID: <20230710140249.56324-2-francisco.iglesias@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230710140249.56324-1-francisco.iglesias@amd.com>
References: <20230710140249.56324-1-francisco.iglesias@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT098:EE_|IA1PR12MB6649:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d816afd-7a0c-440d-317e-08db814e5bba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F7EWwvpigimXJSCsyLJfNp/BI2+eB7CcCqVaHcDW5sLcJrHiAYeyhLXc2S4LEDV6BSxREaBrKpLV8hFoF4vlZy1h3o4WI/krNt18FXV/t2dLbiJ/yuurPiGszXNzrw1ZpGc99hj/vfDyhM0QPqMtP2Z5EDIR/WSjXOYc8iRy3P3nLMFEfIp9qwdMKjxuS3yR+rBnJ3LozeiV5D14DGHzGGzBfmO6Xdo3k9sqxMGQJk8+QqKTv2SWsL5Hd/Tttiqkn9DZlfPQedew6oMWFL3kmKz7BJC5QNW9lhfI+iZ2BsxAn3N2ZTw2u5pxrQ+XHHr8HT7LSonj19UOM3kEkIZTpjkwxINQ0AYqRs9m0wmJc294l4wHIl3Auh0d49wODpvrd8fdWIAeY5rX+wLK77csQzwLk+QGMqGJjSFnVHoIOQqX5Eol8RQRvOAnbpHNcRdc22APqdVzdAdrj0IJXAcxqRFoL5/wcJqBDi/41zje4Nfff/dmk2Co7Hdkm3t9iomKwatOB9Y+1hPbTRhWW4p54VknRV+9fUR0jCmJchYXTCdgHr/Zf5wx4JMa6CVgyPhE2yEMAEtGNZtBnRQZ/eMQNoDNeSl/Sy7SMenudFf7aj2RsJnvH9tNOMxuFvAqh77jFEdLd6g0MYMLkcKe7/q1mxh5eIYZlkbV7gsRaiXzI9R5uXBmNiwlstflCLDxhW9xZOeaB0919RHiM2+ffymADCvQU9pWH8mSw8LBFiyrDfO2mgyBcL90OglwofSaThVouYovMO+xZLu1QySLQg6uHA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(396003)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(186003)(26005)(1076003)(2616005)(36860700001)(336012)(426003)(47076005)(41300700001)(4326008)(2906002)(316002)(44832011)(5660300002)(8936002)(8676002)(6916009)(478600001)(6666004)(70206006)(70586007)(54906003)(40480700001)(36756003)(81166007)(356005)(82310400005)(86362001)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 14:02:54.8637 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d816afd-7a0c-440d-317e-08db814e5bba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT098.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6649
Received-SPF: softfail client-ip=2a01:111:f400:fe5a::614;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
---
 MAINTAINERS                   |  6 ++++
 hw/misc/meson.build           |  1 +
 hw/misc/xlnx-cfi-if.c         | 34 ++++++++++++++++++++
 include/hw/misc/xlnx-cfi-if.h | 59 +++++++++++++++++++++++++++++++++++
 4 files changed, 100 insertions(+)
 create mode 100644 hw/misc/xlnx-cfi-if.c
 create mode 100644 include/hw/misc/xlnx-cfi-if.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 1817cfc62f..3ba115bb9b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1036,6 +1036,12 @@ S: Maintained
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
index 05877f61cc..9971b1e4db 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -96,6 +96,7 @@ specific_ss.add(when: 'CONFIG_XLNX_VERSAL', if_true: files('xlnx-versal-crl.c'))
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


