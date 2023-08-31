Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0229978F18E
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 18:58:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbkzF-0001le-1D; Thu, 31 Aug 2023 12:57:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1qbkyq-00018y-NA
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 12:57:16 -0400
Received: from mail-dm6nam12on20612.outbound.protection.outlook.com
 ([2a01:111:f400:fe59::612]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1qbkym-0003Ym-Q9
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 12:57:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c60UDyTGM8Tm2TaE/zoP6l4ZLTBY7OYY5UTjy0cKfV22fZyWEgun75gq8T4u8RfNGUBv0yhuf722i3Mr5yGkn4DhhegBb/e5zzmsfvWYSXtVyhggBDejsc233uZ9Wbf3XgKNjLAets//y3wpnQVtyAfGUlYX8mbX0d4CGyI2tQM4mhmA2EpLdxytNA91uuKejQKCxHSnAyFFSAUWxKVmUhgk31RvvLKO+eTN7dIW6LIf8UY9lpmd+kjsmnw4ZT4hQMI2OvVRiF7f6winGCBnTQ5DxVOaTbM7OJTaUtH/863bMX7DfUOgY/+Yt3ztmJCiYndQBIP/2vmu9jpoFZdJIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e9SHItlAQjSTqN0xrYejzdl651JvBfZEfP1DZ2T+Oyg=;
 b=c5+DvgyTbjFEJz0Xsu0NzDmZA7nZotDBkfmpi1MMEw4JDQ3mchml6t7ydwZlmj5IMOJxQ+3NIE87W1HwBKzpxVQug3d9BuFYqEUFiQoWbSKrkrozz4mfhvlH8Fll5N80m1Ho7PIFlWO8E9FXyvfju5iDFJYC4FtiXM8Nmh0GkH02quefY2N3wkzhNO9gDEULxhg+Rf8mdXTMpqLpG7WTMeIJDce6jCmSQnfv1h1okcH3wKuIr5coyKAu/dB7UKCPUR1GiDQoWTwhoQ2Lh08eaLk7fM8+U0Cv2uY6Irf23NjV4VYJ7WsapNP8NLa4YrmZVTvvu/n00vixt0PMBqrEqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9SHItlAQjSTqN0xrYejzdl651JvBfZEfP1DZ2T+Oyg=;
 b=VUccIYzorcYU11Nt5XnqtYjoRKjBjWw775r1ui+O0tFo/MfjnpdcrLpyY2OhHo75fc8zGn6WevGomJYoMy2p070Puf7BcETEJH1GT9ITRoZDDI3YAngJ/3Uk79m9yBMUsjlgkfbZA3r+yV/+cIYFi3zqjb/R0udPszUCe66c1aQ=
Received: from MW3PR05CA0007.namprd05.prod.outlook.com (2603:10b6:303:2b::12)
 by DS0PR12MB8413.namprd12.prod.outlook.com (2603:10b6:8:f9::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.20; Thu, 31 Aug 2023 16:57:06 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:303:2b:cafe::60) by MW3PR05CA0007.outlook.office365.com
 (2603:10b6:303:2b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.9 via Frontend
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
 15.20.6745.17 via Frontend Transport; Thu, 31 Aug 2023 16:57:06 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 31 Aug
 2023 11:57:06 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 31 Aug
 2023 09:57:06 -0700
Received: from xdcsswbld02.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 31 Aug 2023 11:57:04 -0500
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: <qemu-devel@nongnu.org>
CC: <frasse.iglesias@gmail.com>, <alistair@alistair23.me>,
 <edgar.iglesias@gmail.com>, <peter.maydell@linaro.org>, <fkonrad@amd.com>,
 <sai.pavan.boddu@amd.com>, <tong.ho@amd.com>, <vikram.garhwal@amd.com>
Subject: [PATCH v5 2/8] hw/misc: Introduce a model of Xilinx Versal's CFU_APB
Date: Thu, 31 Aug 2023 17:56:55 +0100
Message-ID: <20230831165701.2016397-3-francisco.iglesias@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230831165701.2016397-1-francisco.iglesias@amd.com>
References: <20230831165701.2016397-1-francisco.iglesias@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|DS0PR12MB8413:EE_
X-MS-Office365-Filtering-Correlation-Id: 93f59d0b-0f9e-467d-e20b-08dbaa434ef1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fkaVaCWVjkDt3EexX8+YVSA1AxjLqpacYK+xQxt6AjrYj/bABZ9XmNiqka1Jtpa3xtg/tRU+OQCsHTCtbs58zp+hs5i1n4naDZqcHxKQhPBBqEVPg9/vJJBcKJ/xGW56iQiODZnZ9noD/kg0QH9J3OwJCV25kUT0Bh0cTvcuqPOsyNjezBWX0fwLczrNTYcsF54KG2pYuqUHKnVMzahPn14saNES1gEoE4XMtQmNM+nCoHgE71qgGfUDALE2DPNqw8LwJxCDPHCZ4RoELlANQBVI5qxx8ubB4999HOHoOL2bjMO0fNbQZNH9DqpXA4lPK+KdkmMuTB6BS61m1GF7zs+bOzvMh/cBfjq03NLAmTjI8xGryFcjwr5RD2F9J+LPzgYy/bVv6+kWy3xQPJfT3pa5lkOYKPOGahX3SgiDTPKT2arCSPi4IUJ2b/PIiUcYgaCKKVP8RQUKVXENRWUbxMW8J5qA0adX+HPhkUMU8+GbSWwjapmhyp+tT7dyaqR3dbCA7mHMd0t2CsTeWqAIY6hbdE/1ok5Kfq6Y/eubmoHlzZcyrXyKVBqwd8MR0TRdEKaO7fHerYSRzHCG7MZunp3rPf0ZCBYiKfaHgc/ENMeqcB4ebbl6khlfC50QSfEhO0BH5TrmLvGs4g09WEcFWz3sTgDWq3wfuvuNQwv2aUcoX5hUdq0NJMzMFvTsuVU2reOqjXUjrh7XP+o0zG79XWEvoFwTq+zLytKG9Bv2mvaoVa3eOOsJHuTnf2Cx8Fav48dtvWS+2RmndxpRRGygSzHgubJq3998vBkQb+EpN3o=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(346002)(136003)(396003)(1800799009)(82310400011)(451199024)(186009)(40470700004)(46966006)(36840700001)(70206006)(41300700001)(8936002)(83380400001)(47076005)(40480700001)(336012)(36860700001)(8676002)(4326008)(966005)(478600001)(6666004)(6916009)(70586007)(316002)(2616005)(426003)(1076003)(26005)(54906003)(30864003)(2906002)(82740400003)(356005)(81166007)(5660300002)(40460700003)(36756003)(86362001)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 16:57:06.5656 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93f59d0b-0f9e-467d-e20b-08dbaa434ef1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8413
Received-SPF: softfail client-ip=2a01:111:f400:fe59::612;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
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

Introduce a model of the software programming interface (CFU_APB) of
Xilinx Versal's Configuration Frame Unit.

Signed-off-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS                       |   2 +
 hw/misc/meson.build               |   1 +
 hw/misc/xlnx-versal-cfu.c         | 380 ++++++++++++++++++++++++++++++
 include/hw/misc/xlnx-versal-cfu.h | 231 ++++++++++++++++++
 4 files changed, 614 insertions(+)
 create mode 100644 hw/misc/xlnx-versal-cfu.c
 create mode 100644 include/hw/misc/xlnx-versal-cfu.h

diff --git a/MAINTAINERS b/MAINTAINERS
index e0cd365462..847b997d73 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1039,6 +1039,8 @@ M: Francisco Iglesias <francisco.iglesias@amd.com>
 S: Maintained
 F: hw/misc/xlnx-cfi-if.c
 F: include/hw/misc/xlnx-cfi-if.h
+F: hw/misc/xlnx-versal-cfu.c
+F: include/hw/misc/xlnx-versal-cfu.h
 
 STM32F100
 M: Alexandre Iooss <erdnaxe@crans.org>
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 0c562f5e3e..d95cc3fd87 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -97,6 +97,7 @@ specific_ss.add(when: 'CONFIG_XLNX_VERSAL', if_true: files('xlnx-versal-crl.c'))
 system_ss.add(when: 'CONFIG_XLNX_VERSAL', if_true: files(
   'xlnx-versal-xramc.c',
   'xlnx-versal-pmc-iou-slcr.c',
+  'xlnx-versal-cfu.c',
   'xlnx-cfi-if.c',
 ))
 system_ss.add(when: 'CONFIG_STM32F2XX_SYSCFG', if_true: files('stm32f2xx_syscfg.c'))
diff --git a/hw/misc/xlnx-versal-cfu.c b/hw/misc/xlnx-versal-cfu.c
new file mode 100644
index 0000000000..b2dc6ab211
--- /dev/null
+++ b/hw/misc/xlnx-versal-cfu.c
@@ -0,0 +1,380 @@
+/*
+ * QEMU model of the CFU Configuration Unit.
+ *
+ * Copyright (C) 2023, Advanced Micro Devices, Inc.
+ *
+ * Written by Edgar E. Iglesias <edgar.iglesias@gmail.com>,
+ *            Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
+ *            Francisco Iglesias <francisco.iglesias@amd.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/sysbus.h"
+#include "hw/register.h"
+#include "hw/irq.h"
+#include "qemu/bitops.h"
+#include "qemu/log.h"
+#include "qemu/units.h"
+#include "migration/vmstate.h"
+#include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
+#include "hw/misc/xlnx-versal-cfu.h"
+
+#ifndef XLNX_VERSAL_CFU_APB_ERR_DEBUG
+#define XLNX_VERSAL_CFU_APB_ERR_DEBUG 0
+#endif
+
+#define KEYHOLE_STREAM_4K (4 * KiB)
+#define KEYHOLE_STREAM_256K (256 * KiB)
+#define CFRAME_BROADCAST_ROW 0x1F
+
+bool update_wfifo(hwaddr addr, uint64_t value,
+                  uint32_t *wfifo, uint32_t *wfifo_ret)
+{
+    unsigned int idx = extract32(addr, 2, 2);
+
+    wfifo[idx] = value;
+
+    if (idx == 3) {
+        memcpy(wfifo_ret, wfifo, WFIFO_SZ * sizeof(uint32_t));
+        memset(wfifo, 0, WFIFO_SZ * sizeof(uint32_t));
+        return true;
+    }
+
+    return false;
+}
+
+static void cfu_imr_update_irq(XlnxVersalCFUAPB *s)
+{
+    bool pending = s->regs[R_CFU_ISR] & ~s->regs[R_CFU_IMR];
+    qemu_set_irq(s->irq_cfu_imr, pending);
+}
+
+static void cfu_isr_postw(RegisterInfo *reg, uint64_t val64)
+{
+    XlnxVersalCFUAPB *s = XLNX_VERSAL_CFU_APB(reg->opaque);
+    cfu_imr_update_irq(s);
+}
+
+static uint64_t cfu_ier_prew(RegisterInfo *reg, uint64_t val64)
+{
+    XlnxVersalCFUAPB *s = XLNX_VERSAL_CFU_APB(reg->opaque);
+    uint32_t val = val64;
+
+    s->regs[R_CFU_IMR] &= ~val;
+    cfu_imr_update_irq(s);
+    return 0;
+}
+
+static uint64_t cfu_idr_prew(RegisterInfo *reg, uint64_t val64)
+{
+    XlnxVersalCFUAPB *s = XLNX_VERSAL_CFU_APB(reg->opaque);
+    uint32_t val = val64;
+
+    s->regs[R_CFU_IMR] |= val;
+    cfu_imr_update_irq(s);
+    return 0;
+}
+
+static uint64_t cfu_itr_prew(RegisterInfo *reg, uint64_t val64)
+{
+    XlnxVersalCFUAPB *s = XLNX_VERSAL_CFU_APB(reg->opaque);
+    uint32_t val = val64;
+
+    s->regs[R_CFU_ISR] |= val;
+    cfu_imr_update_irq(s);
+    return 0;
+}
+
+static void cfu_fgcr_postw(RegisterInfo *reg, uint64_t val64)
+{
+    XlnxVersalCFUAPB *s = XLNX_VERSAL_CFU_APB(reg->opaque);
+    uint32_t val = (uint32_t)val64;
+
+    /* Do a scan. It always looks good. */
+    if (FIELD_EX32(val, CFU_FGCR, SC_HBC_TRIGGER)) {
+        ARRAY_FIELD_DP32(s->regs, CFU_STATUS, SCAN_CLEAR_PASS, 1);
+        ARRAY_FIELD_DP32(s->regs, CFU_STATUS, SCAN_CLEAR_DONE, 1);
+    }
+}
+
+static const RegisterAccessInfo cfu_apb_regs_info[] = {
+    {   .name = "CFU_ISR",  .addr = A_CFU_ISR,
+        .rsvd = 0xfffffc00,
+        .w1c = 0x3ff,
+        .post_write = cfu_isr_postw,
+    },{ .name = "CFU_IMR",  .addr = A_CFU_IMR,
+        .reset = 0x3ff,
+        .rsvd = 0xfffffc00,
+        .ro = 0x3ff,
+    },{ .name = "CFU_IER",  .addr = A_CFU_IER,
+        .rsvd = 0xfffffc00,
+        .pre_write = cfu_ier_prew,
+    },{ .name = "CFU_IDR",  .addr = A_CFU_IDR,
+        .rsvd = 0xfffffc00,
+        .pre_write = cfu_idr_prew,
+    },{ .name = "CFU_ITR",  .addr = A_CFU_ITR,
+        .rsvd = 0xfffffc00,
+        .pre_write = cfu_itr_prew,
+    },{ .name = "CFU_PROTECT",  .addr = A_CFU_PROTECT,
+        .reset = 0x1,
+    },{ .name = "CFU_FGCR",  .addr = A_CFU_FGCR,
+        .rsvd = 0xffff8000,
+        .post_write = cfu_fgcr_postw,
+    },{ .name = "CFU_CTL",  .addr = A_CFU_CTL,
+        .rsvd = 0xffff0000,
+    },{ .name = "CFU_CRAM_RW",  .addr = A_CFU_CRAM_RW,
+        .reset = 0x401f7d9,
+        .rsvd = 0xf8000000,
+    },{ .name = "CFU_MASK",  .addr = A_CFU_MASK,
+    },{ .name = "CFU_CRC_EXPECT",  .addr = A_CFU_CRC_EXPECT,
+    },{ .name = "CFU_CFRAME_LEFT_T0",  .addr = A_CFU_CFRAME_LEFT_T0,
+        .rsvd = 0xfff00000,
+    },{ .name = "CFU_CFRAME_LEFT_T1",  .addr = A_CFU_CFRAME_LEFT_T1,
+        .rsvd = 0xfff00000,
+    },{ .name = "CFU_CFRAME_LEFT_T2",  .addr = A_CFU_CFRAME_LEFT_T2,
+        .rsvd = 0xfff00000,
+    },{ .name = "CFU_ROW_RANGE",  .addr = A_CFU_ROW_RANGE,
+        .rsvd = 0xffffffc0,
+        .ro = 0x3f,
+    },{ .name = "CFU_STATUS",  .addr = A_CFU_STATUS,
+        .rsvd = 0x80000000,
+        .ro = 0x7fffffff,
+    },{ .name = "CFU_INTERNAL_STATUS",  .addr = A_CFU_INTERNAL_STATUS,
+        .rsvd = 0xff800000,
+        .ro = 0x7fffff,
+    },{ .name = "CFU_QWORD_CNT",  .addr = A_CFU_QWORD_CNT,
+        .ro = 0xffffffff,
+    },{ .name = "CFU_CRC_LIVE",  .addr = A_CFU_CRC_LIVE,
+        .ro = 0xffffffff,
+    },{ .name = "CFU_PENDING_READ_CNT",  .addr = A_CFU_PENDING_READ_CNT,
+        .rsvd = 0xfe000000,
+        .ro = 0x1ffffff,
+    },{ .name = "CFU_FDRI_CNT",  .addr = A_CFU_FDRI_CNT,
+        .ro = 0xffffffff,
+    },{ .name = "CFU_ECO1",  .addr = A_CFU_ECO1,
+    },{ .name = "CFU_ECO2",  .addr = A_CFU_ECO2,
+    }
+};
+
+static void cfu_apb_reset(DeviceState *dev)
+{
+    XlnxVersalCFUAPB *s = XLNX_VERSAL_CFU_APB(dev);
+    unsigned int i;
+
+    for (i = 0; i < ARRAY_SIZE(s->regs_info); ++i) {
+        register_reset(&s->regs_info[i]);
+    }
+    memset(s->wfifo, 0, WFIFO_SZ * sizeof(uint32_t));
+
+    s->regs[R_CFU_STATUS] |= R_CFU_STATUS_HC_COMPLETE_MASK;
+    cfu_imr_update_irq(s);
+}
+
+static const MemoryRegionOps cfu_apb_ops = {
+    .read = register_read_memory,
+    .write = register_write_memory,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void cfu_transfer_cfi_packet(XlnxVersalCFUAPB *s, uint8_t row_addr,
+                                    XlnxCfiPacket *pkt)
+{
+    if (row_addr == CFRAME_BROADCAST_ROW) {
+        for (int i = 0; i < ARRAY_SIZE(s->cfg.cframe); i++) {
+            if (s->cfg.cframe[i]) {
+                xlnx_cfi_transfer_packet(s->cfg.cframe[i], pkt);
+            }
+        }
+    } else {
+            assert(row_addr < ARRAY_SIZE(s->cfg.cframe));
+
+            if (s->cfg.cframe[row_addr]) {
+                xlnx_cfi_transfer_packet(s->cfg.cframe[row_addr], pkt);
+            }
+    }
+}
+
+static uint64_t cfu_stream_read(void *opaque, hwaddr addr, unsigned size)
+{
+    qemu_log_mask(LOG_GUEST_ERROR, "%s: Unsupported read from addr=%"
+                  HWADDR_PRIx "\n", __func__, addr);
+    return 0;
+}
+
+static void cfu_stream_write(void *opaque, hwaddr addr, uint64_t value,
+                      unsigned size)
+{
+    XlnxVersalCFUAPB *s = XLNX_VERSAL_CFU_APB(opaque);
+    uint32_t wfifo[WFIFO_SZ];
+
+    if (update_wfifo(addr, value, s->wfifo, wfifo)) {
+        uint8_t packet_type, row_addr, reg_addr;
+
+        packet_type = extract32(wfifo[0], 24, 8);
+        row_addr = extract32(wfifo[0], 16, 5);
+        reg_addr = extract32(wfifo[0], 8, 6);
+
+        /* Compressed bitstreams are not supported yet. */
+        if (ARRAY_FIELD_EX32(s->regs, CFU_CTL, DECOMPRESS) == 0) {
+            if (s->regs[R_CFU_FDRI_CNT]) {
+                XlnxCfiPacket pkt = {
+                    .reg_addr = CFRAME_FDRI,
+                    .data[0] = wfifo[0],
+                    .data[1] = wfifo[1],
+                    .data[2] = wfifo[2],
+                    .data[3] = wfifo[3]
+                };
+
+                cfu_transfer_cfi_packet(s, s->fdri_row_addr, &pkt);
+
+                s->regs[R_CFU_FDRI_CNT]--;
+
+            } else if (packet_type == PACKET_TYPE_CFU &&
+                       reg_addr == CFRAME_FDRI) {
+
+                /* Load R_CFU_FDRI_CNT, must be multiple of 25 */
+                s->regs[R_CFU_FDRI_CNT] = wfifo[1];
+
+                /* Store target row_addr */
+                s->fdri_row_addr = row_addr;
+
+                if (wfifo[1] % 25 != 0) {
+                    qemu_log_mask(LOG_GUEST_ERROR,
+                                  "CFU FDRI_CNT is not loaded with "
+                                  "a multiple of 25 value\n");
+                }
+
+            } else if (packet_type == PACKET_TYPE_CFRAME) {
+                XlnxCfiPacket pkt = {
+                    .reg_addr = reg_addr,
+                    .data[0] = wfifo[1],
+                    .data[1] = wfifo[2],
+                    .data[2] = wfifo[3],
+                };
+                cfu_transfer_cfi_packet(s, row_addr, &pkt);
+            }
+        }
+    }
+}
+
+static const MemoryRegionOps cfu_stream_ops = {
+    .read = cfu_stream_read,
+    .write = cfu_stream_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 8,
+    },
+};
+
+static void cfu_apb_init(Object *obj)
+{
+    XlnxVersalCFUAPB *s = XLNX_VERSAL_CFU_APB(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    RegisterInfoArray *reg_array;
+    unsigned int i;
+    char *name;
+
+    memory_region_init(&s->iomem, obj, TYPE_XLNX_VERSAL_CFU_APB, R_MAX * 4);
+    reg_array =
+        register_init_block32(DEVICE(obj), cfu_apb_regs_info,
+                              ARRAY_SIZE(cfu_apb_regs_info),
+                              s->regs_info, s->regs,
+                              &cfu_apb_ops,
+                              XLNX_VERSAL_CFU_APB_ERR_DEBUG,
+                              R_MAX * 4);
+    memory_region_add_subregion(&s->iomem,
+                                0x0,
+                                &reg_array->mem);
+    sysbus_init_mmio(sbd, &s->iomem);
+    for (i = 0; i < NUM_STREAM; i++) {
+        name = g_strdup_printf(TYPE_XLNX_VERSAL_CFU_APB "-stream%d", i);
+        memory_region_init_io(&s->iomem_stream[i], obj, &cfu_stream_ops, s,
+                          name, i == 0 ? KEYHOLE_STREAM_4K :
+                                         KEYHOLE_STREAM_256K);
+        sysbus_init_mmio(sbd, &s->iomem_stream[i]);
+        g_free(name);
+    }
+    sysbus_init_irq(sbd, &s->irq_cfu_imr);
+}
+
+static Property cfu_props[] = {
+        DEFINE_PROP_LINK("cframe0", XlnxVersalCFUAPB, cfg.cframe[0],
+                         TYPE_XLNX_CFI_IF, XlnxCfiIf *),
+        DEFINE_PROP_LINK("cframe1", XlnxVersalCFUAPB, cfg.cframe[1],
+                         TYPE_XLNX_CFI_IF, XlnxCfiIf *),
+        DEFINE_PROP_LINK("cframe2", XlnxVersalCFUAPB, cfg.cframe[2],
+                         TYPE_XLNX_CFI_IF, XlnxCfiIf *),
+        DEFINE_PROP_LINK("cframe3", XlnxVersalCFUAPB, cfg.cframe[3],
+                         TYPE_XLNX_CFI_IF, XlnxCfiIf *),
+        DEFINE_PROP_LINK("cframe4", XlnxVersalCFUAPB, cfg.cframe[4],
+                         TYPE_XLNX_CFI_IF, XlnxCfiIf *),
+        DEFINE_PROP_LINK("cframe5", XlnxVersalCFUAPB, cfg.cframe[5],
+                         TYPE_XLNX_CFI_IF, XlnxCfiIf *),
+        DEFINE_PROP_LINK("cframe6", XlnxVersalCFUAPB, cfg.cframe[6],
+                         TYPE_XLNX_CFI_IF, XlnxCfiIf *),
+        DEFINE_PROP_LINK("cframe7", XlnxVersalCFUAPB, cfg.cframe[7],
+                         TYPE_XLNX_CFI_IF, XlnxCfiIf *),
+        DEFINE_PROP_LINK("cframe8", XlnxVersalCFUAPB, cfg.cframe[8],
+                         TYPE_XLNX_CFI_IF, XlnxCfiIf *),
+        DEFINE_PROP_LINK("cframe9", XlnxVersalCFUAPB, cfg.cframe[9],
+                         TYPE_XLNX_CFI_IF, XlnxCfiIf *),
+        DEFINE_PROP_LINK("cframe10", XlnxVersalCFUAPB, cfg.cframe[10],
+                         TYPE_XLNX_CFI_IF, XlnxCfiIf *),
+        DEFINE_PROP_LINK("cframe11", XlnxVersalCFUAPB, cfg.cframe[11],
+                         TYPE_XLNX_CFI_IF, XlnxCfiIf *),
+        DEFINE_PROP_LINK("cframe12", XlnxVersalCFUAPB, cfg.cframe[12],
+                         TYPE_XLNX_CFI_IF, XlnxCfiIf *),
+        DEFINE_PROP_LINK("cframe13", XlnxVersalCFUAPB, cfg.cframe[13],
+                         TYPE_XLNX_CFI_IF, XlnxCfiIf *),
+        DEFINE_PROP_LINK("cframe14", XlnxVersalCFUAPB, cfg.cframe[14],
+                         TYPE_XLNX_CFI_IF, XlnxCfiIf *),
+        DEFINE_PROP_END_OF_LIST(),
+};
+
+static const VMStateDescription vmstate_cfu_apb = {
+    .name = TYPE_XLNX_VERSAL_CFU_APB,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(wfifo, XlnxVersalCFUAPB, 4),
+        VMSTATE_UINT32_ARRAY(regs, XlnxVersalCFUAPB, R_MAX),
+        VMSTATE_UINT8(fdri_row_addr, XlnxVersalCFUAPB),
+        VMSTATE_END_OF_LIST(),
+    }
+};
+
+static void cfu_apb_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->reset = cfu_apb_reset;
+    dc->vmsd = &vmstate_cfu_apb;
+    device_class_set_props(dc, cfu_props);
+}
+
+static const TypeInfo cfu_apb_info = {
+    .name          = TYPE_XLNX_VERSAL_CFU_APB,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(XlnxVersalCFUAPB),
+    .class_init    = cfu_apb_class_init,
+    .instance_init = cfu_apb_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_XLNX_CFI_IF },
+        { }
+    }
+};
+
+static void cfu_apb_register_types(void)
+{
+    type_register_static(&cfu_apb_info);
+}
+
+type_init(cfu_apb_register_types)
diff --git a/include/hw/misc/xlnx-versal-cfu.h b/include/hw/misc/xlnx-versal-cfu.h
new file mode 100644
index 0000000000..62d10caf27
--- /dev/null
+++ b/include/hw/misc/xlnx-versal-cfu.h
@@ -0,0 +1,231 @@
+/*
+ * QEMU model of the CFU Configuration Unit.
+ *
+ * Copyright (C) 2023, Advanced Micro Devices, Inc.
+ *
+ * Written by Francisco Iglesias <francisco.iglesias@amd.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * References:
+ * [1] Versal ACAP Technical Reference Manual,
+ *     https://www.xilinx.com/support/documentation/architecture-manuals/am011-versal-acap-trm.pdf
+ *
+ * [2] Versal ACAP Register Reference,
+ *     https://www.xilinx.com/htmldocs/registers/am012/am012-versal-register-reference.html
+ */
+#ifndef HW_MISC_XLNX_VERSAL_CFU_APB_H
+#define HW_MISC_XLNX_VERSAL_CFU_APB_H
+
+#include "hw/sysbus.h"
+#include "hw/register.h"
+#include "hw/misc/xlnx-cfi-if.h"
+
+#define TYPE_XLNX_VERSAL_CFU_APB "xlnx,versal-cfu-apb"
+OBJECT_DECLARE_SIMPLE_TYPE(XlnxVersalCFUAPB, XLNX_VERSAL_CFU_APB)
+
+REG32(CFU_ISR, 0x0)
+    FIELD(CFU_ISR, USR_GTS_EVENT, 9, 1)
+    FIELD(CFU_ISR, USR_GSR_EVENT, 8, 1)
+    FIELD(CFU_ISR, SLVERR, 7, 1)
+    FIELD(CFU_ISR, DECOMP_ERROR, 6, 1)
+    FIELD(CFU_ISR, BAD_CFI_PACKET, 5, 1)
+    FIELD(CFU_ISR, AXI_ALIGN_ERROR, 4, 1)
+    FIELD(CFU_ISR, CFI_ROW_ERROR, 3, 1)
+    FIELD(CFU_ISR, CRC32_ERROR, 2, 1)
+    FIELD(CFU_ISR, CRC8_ERROR, 1, 1)
+    FIELD(CFU_ISR, SEU_ENDOFCALIB, 0, 1)
+REG32(CFU_IMR, 0x4)
+    FIELD(CFU_IMR, USR_GTS_EVENT, 9, 1)
+    FIELD(CFU_IMR, USR_GSR_EVENT, 8, 1)
+    FIELD(CFU_IMR, SLVERR, 7, 1)
+    FIELD(CFU_IMR, DECOMP_ERROR, 6, 1)
+    FIELD(CFU_IMR, BAD_CFI_PACKET, 5, 1)
+    FIELD(CFU_IMR, AXI_ALIGN_ERROR, 4, 1)
+    FIELD(CFU_IMR, CFI_ROW_ERROR, 3, 1)
+    FIELD(CFU_IMR, CRC32_ERROR, 2, 1)
+    FIELD(CFU_IMR, CRC8_ERROR, 1, 1)
+    FIELD(CFU_IMR, SEU_ENDOFCALIB, 0, 1)
+REG32(CFU_IER, 0x8)
+    FIELD(CFU_IER, USR_GTS_EVENT, 9, 1)
+    FIELD(CFU_IER, USR_GSR_EVENT, 8, 1)
+    FIELD(CFU_IER, SLVERR, 7, 1)
+    FIELD(CFU_IER, DECOMP_ERROR, 6, 1)
+    FIELD(CFU_IER, BAD_CFI_PACKET, 5, 1)
+    FIELD(CFU_IER, AXI_ALIGN_ERROR, 4, 1)
+    FIELD(CFU_IER, CFI_ROW_ERROR, 3, 1)
+    FIELD(CFU_IER, CRC32_ERROR, 2, 1)
+    FIELD(CFU_IER, CRC8_ERROR, 1, 1)
+    FIELD(CFU_IER, SEU_ENDOFCALIB, 0, 1)
+REG32(CFU_IDR, 0xc)
+    FIELD(CFU_IDR, USR_GTS_EVENT, 9, 1)
+    FIELD(CFU_IDR, USR_GSR_EVENT, 8, 1)
+    FIELD(CFU_IDR, SLVERR, 7, 1)
+    FIELD(CFU_IDR, DECOMP_ERROR, 6, 1)
+    FIELD(CFU_IDR, BAD_CFI_PACKET, 5, 1)
+    FIELD(CFU_IDR, AXI_ALIGN_ERROR, 4, 1)
+    FIELD(CFU_IDR, CFI_ROW_ERROR, 3, 1)
+    FIELD(CFU_IDR, CRC32_ERROR, 2, 1)
+    FIELD(CFU_IDR, CRC8_ERROR, 1, 1)
+    FIELD(CFU_IDR, SEU_ENDOFCALIB, 0, 1)
+REG32(CFU_ITR, 0x10)
+    FIELD(CFU_ITR, USR_GTS_EVENT, 9, 1)
+    FIELD(CFU_ITR, USR_GSR_EVENT, 8, 1)
+    FIELD(CFU_ITR, SLVERR, 7, 1)
+    FIELD(CFU_ITR, DECOMP_ERROR, 6, 1)
+    FIELD(CFU_ITR, BAD_CFI_PACKET, 5, 1)
+    FIELD(CFU_ITR, AXI_ALIGN_ERROR, 4, 1)
+    FIELD(CFU_ITR, CFI_ROW_ERROR, 3, 1)
+    FIELD(CFU_ITR, CRC32_ERROR, 2, 1)
+    FIELD(CFU_ITR, CRC8_ERROR, 1, 1)
+    FIELD(CFU_ITR, SEU_ENDOFCALIB, 0, 1)
+REG32(CFU_PROTECT, 0x14)
+    FIELD(CFU_PROTECT, ACTIVE, 0, 1)
+REG32(CFU_FGCR, 0x18)
+    FIELD(CFU_FGCR, GCLK_CAL, 14, 1)
+    FIELD(CFU_FGCR, SC_HBC_TRIGGER, 13, 1)
+    FIELD(CFU_FGCR, GLOW, 12, 1)
+    FIELD(CFU_FGCR, GPWRDWN, 11, 1)
+    FIELD(CFU_FGCR, GCAP, 10, 1)
+    FIELD(CFU_FGCR, GSCWE, 9, 1)
+    FIELD(CFU_FGCR, GHIGH_B, 8, 1)
+    FIELD(CFU_FGCR, GMC_B, 7, 1)
+    FIELD(CFU_FGCR, GWE, 6, 1)
+    FIELD(CFU_FGCR, GRESTORE, 5, 1)
+    FIELD(CFU_FGCR, GTS_CFG_B, 4, 1)
+    FIELD(CFU_FGCR, GLUTMASK, 3, 1)
+    FIELD(CFU_FGCR, EN_GLOBS_B, 2, 1)
+    FIELD(CFU_FGCR, EOS, 1, 1)
+    FIELD(CFU_FGCR, INIT_COMPLETE, 0, 1)
+REG32(CFU_CTL, 0x1c)
+    FIELD(CFU_CTL, GSR_GSC, 15, 1)
+    FIELD(CFU_CTL, SLVERR_EN, 14, 1)
+    FIELD(CFU_CTL, CRC32_RESET, 13, 1)
+    FIELD(CFU_CTL, AXI_ERROR_EN, 12, 1)
+    FIELD(CFU_CTL, FLUSH_AXI, 11, 1)
+    FIELD(CFU_CTL, SSI_PER_SLR_PR, 10, 1)
+    FIELD(CFU_CTL, GCAP_CLK_EN, 9, 1)
+    FIELD(CFU_CTL, STATUS_SYNC_DISABLE, 8, 1)
+    FIELD(CFU_CTL, IGNORE_CFI_ERROR, 7, 1)
+    FIELD(CFU_CTL, CFRAME_DISABLE, 6, 1)
+    FIELD(CFU_CTL, QWORD_CNT_RESET, 5, 1)
+    FIELD(CFU_CTL, CRC8_DISABLE, 4, 1)
+    FIELD(CFU_CTL, CRC32_CHECK, 3, 1)
+    FIELD(CFU_CTL, DECOMPRESS, 2, 1)
+    FIELD(CFU_CTL, SEU_GO, 1, 1)
+    FIELD(CFU_CTL, CFI_LOCAL_RESET, 0, 1)
+REG32(CFU_CRAM_RW, 0x20)
+    FIELD(CFU_CRAM_RW, RFIFO_AFULL_DEPTH, 18, 9)
+    FIELD(CFU_CRAM_RW, RD_WAVE_CNT_LEFT, 12, 6)
+    FIELD(CFU_CRAM_RW, RD_WAVE_CNT, 6, 6)
+    FIELD(CFU_CRAM_RW, WR_WAVE_CNT, 0, 6)
+REG32(CFU_MASK, 0x28)
+REG32(CFU_CRC_EXPECT, 0x2c)
+REG32(CFU_CFRAME_LEFT_T0, 0x60)
+    FIELD(CFU_CFRAME_LEFT_T0, NUM, 0, 20)
+REG32(CFU_CFRAME_LEFT_T1, 0x64)
+    FIELD(CFU_CFRAME_LEFT_T1, NUM, 0, 20)
+REG32(CFU_CFRAME_LEFT_T2, 0x68)
+    FIELD(CFU_CFRAME_LEFT_T2, NUM, 0, 20)
+REG32(CFU_ROW_RANGE, 0x6c)
+    FIELD(CFU_ROW_RANGE, HALF_FSR, 5, 1)
+    FIELD(CFU_ROW_RANGE, NUM, 0, 5)
+REG32(CFU_STATUS, 0x100)
+    FIELD(CFU_STATUS, SEU_WRITE_ERROR, 30, 1)
+    FIELD(CFU_STATUS, FRCNT_ERROR, 29, 1)
+    FIELD(CFU_STATUS, RSVD_ERROR, 28, 1)
+    FIELD(CFU_STATUS, FDRO_ERROR, 27, 1)
+    FIELD(CFU_STATUS, FDRI_ERROR, 26, 1)
+    FIELD(CFU_STATUS, FDRI_READ_ERROR, 25, 1)
+    FIELD(CFU_STATUS, READ_FDRI_ERROR, 24, 1)
+    FIELD(CFU_STATUS, READ_SFR_ERROR, 23, 1)
+    FIELD(CFU_STATUS, READ_STREAM_ERROR, 22, 1)
+    FIELD(CFU_STATUS, UNKNOWN_STREAM_PKT, 21, 1)
+    FIELD(CFU_STATUS, USR_GTS, 20, 1)
+    FIELD(CFU_STATUS, USR_GSR, 19, 1)
+    FIELD(CFU_STATUS, AXI_BAD_WSTRB, 18, 1)
+    FIELD(CFU_STATUS, AXI_BAD_AR_SIZE, 17, 1)
+    FIELD(CFU_STATUS, AXI_BAD_AW_SIZE, 16, 1)
+    FIELD(CFU_STATUS, AXI_BAD_ARADDR, 15, 1)
+    FIELD(CFU_STATUS, AXI_BAD_AWADDR, 14, 1)
+    FIELD(CFU_STATUS, SCAN_CLEAR_PASS, 13, 1)
+    FIELD(CFU_STATUS, HC_SEC_ERROR, 12, 1)
+    FIELD(CFU_STATUS, GHIGH_B_ISHIGH, 11, 1)
+    FIELD(CFU_STATUS, GHIGH_B_ISLOW, 10, 1)
+    FIELD(CFU_STATUS, GMC_B_ISHIGH, 9, 1)
+    FIELD(CFU_STATUS, GMC_B_ISLOW, 8, 1)
+    FIELD(CFU_STATUS, GPWRDWN_B_ISHIGH, 7, 1)
+    FIELD(CFU_STATUS, CFI_SEU_CRC_ERROR, 6, 1)
+    FIELD(CFU_STATUS, CFI_SEU_ECC_ERROR, 5, 1)
+    FIELD(CFU_STATUS, CFI_SEU_HEARTBEAT, 4, 1)
+    FIELD(CFU_STATUS, SCAN_CLEAR_DONE, 3, 1)
+    FIELD(CFU_STATUS, HC_COMPLETE, 2, 1)
+    FIELD(CFU_STATUS, CFI_CFRAME_BUSY, 1, 1)
+    FIELD(CFU_STATUS, CFU_STREAM_BUSY, 0, 1)
+REG32(CFU_INTERNAL_STATUS, 0x104)
+    FIELD(CFU_INTERNAL_STATUS, SSI_EOS, 22, 1)
+    FIELD(CFU_INTERNAL_STATUS, SSI_GWE, 21, 1)
+    FIELD(CFU_INTERNAL_STATUS, RFIFO_EMPTY, 20, 1)
+    FIELD(CFU_INTERNAL_STATUS, RFIFO_FULL, 19, 1)
+    FIELD(CFU_INTERNAL_STATUS, SEL_SFR, 18, 1)
+    FIELD(CFU_INTERNAL_STATUS, STREAM_CFRAME, 17, 1)
+    FIELD(CFU_INTERNAL_STATUS, FDRI_PHASE, 16, 1)
+    FIELD(CFU_INTERNAL_STATUS, CFI_PIPE_EN, 15, 1)
+    FIELD(CFU_INTERNAL_STATUS, AWFIFO_DCNT, 10, 5)
+    FIELD(CFU_INTERNAL_STATUS, WFIFO_DCNT, 5, 5)
+    FIELD(CFU_INTERNAL_STATUS, REPAIR_BUSY, 4, 1)
+    FIELD(CFU_INTERNAL_STATUS, TRIMU_BUSY, 3, 1)
+    FIELD(CFU_INTERNAL_STATUS, TRIMB_BUSY, 2, 1)
+    FIELD(CFU_INTERNAL_STATUS, HCLEANR_BUSY, 1, 1)
+    FIELD(CFU_INTERNAL_STATUS, HCLEAN_BUSY, 0, 1)
+REG32(CFU_QWORD_CNT, 0x108)
+REG32(CFU_CRC_LIVE, 0x10c)
+REG32(CFU_PENDING_READ_CNT, 0x110)
+    FIELD(CFU_PENDING_READ_CNT, NUM, 0, 25)
+REG32(CFU_FDRI_CNT, 0x114)
+REG32(CFU_ECO1, 0x118)
+REG32(CFU_ECO2, 0x11c)
+
+#define R_MAX (R_CFU_ECO2 + 1)
+
+#define NUM_STREAM 2
+#define WFIFO_SZ 4
+
+struct XlnxVersalCFUAPB {
+    SysBusDevice parent_obj;
+    MemoryRegion iomem;
+    MemoryRegion iomem_stream[NUM_STREAM];
+    qemu_irq irq_cfu_imr;
+
+    /* 128-bit wfifo.  */
+    uint32_t wfifo[WFIFO_SZ];
+
+    uint32_t regs[R_MAX];
+    RegisterInfo regs_info[R_MAX];
+
+    uint8_t fdri_row_addr;
+
+    struct {
+        XlnxCfiIf *cframe[15];
+    } cfg;
+};
+
+/**
+ * This is a helper function for updating a CFI data write fifo, an array of 4
+ * uint32_t and 128 bits of data that are allowed to be written through 4
+ * sequential 32 bit accesses. After the last index has been written into the
+ * write fifo (wfifo), the data is copied to and returned in a secondary fifo
+ * provided to the function (wfifo_ret), and the write fifo is cleared
+ * (zeroized).
+ *
+ * @addr: the address used when calculating the wfifo array index to update
+ * @value: the value to write into the wfifo array
+ * @wfifo: the wfifo to update
+ * @wfifo_out: will return the wfifo data when all 128 bits have been written
+ *
+ * @return: true if all 128 bits have been updated.
+ */
+bool update_wfifo(hwaddr addr, uint64_t value,
+                  uint32_t *wfifo, uint32_t *wfifo_ret);
+
+#endif
-- 
2.34.1


