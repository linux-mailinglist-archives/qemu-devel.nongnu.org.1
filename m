Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4216274D868
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 16:05:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIrU3-0000it-T1; Mon, 10 Jul 2023 10:03:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1qIrTv-0000hy-Gr
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 10:03:15 -0400
Received: from mail-dm6nam11on2060d.outbound.protection.outlook.com
 ([2a01:111:f400:7eaa::60d]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1qIrTn-0003HC-T9
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 10:03:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h7ry7OLj0ECbAxCt8bkU50GNQ1M3GMrziUI6skBVnRlfdPEo0ernMdFPWG6Ls+oJtDucpFUtPZHN1AF8O1d31Rwuy4gu5/O8oKFzXZGLSXQekBQ0mA6oXM5NlMnQDixECbCTAgHtdfJhhdpf8QR7gYG8fiMZK9rtJ6hL/NEc0Xzq0A3pRL4C/ljVEc7L2dyHrKrL6bg6/xp6AzGuwwt3ApIDrq38sjsTeyoYZtcdqbTTq88VHGlYXTpZ5/Vg8L5vFs4luUt0+2SNB/EnP2Xw7NHh74s46/9U56j5JcnEJd8f9ixojcWBji6rB4uJAHIncbEx/NzQdiVi3aIDAIIT8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O3a8C7noLWz20Mbf1U+XtzipvH7dEVf6Nr+lgHbHHYA=;
 b=G6LOYRnei6MpfXuwY3npgT6ihnycj6xfB9rgftUELpZoB8PuTLrprIB8UyrLLq2dvMjmgXSv1aI3X0SOIqxloeQyg3jKSILb71d8o9z/yaQGkNoxUmZ3GxhgbRjls5b7a9L4hdV2nJcGKiBj1k8MnT2KVfFHSfzziGEyMrmAh6hJErutPE5HyfOTIzfuPKDjukvp+3vtshd2vEP8+YJhga+sPLb6jtBFnOBHiTfqlTVKfo3/w40b3rs8zblj4b9J7ssuHih1jRbbQTQ7g0JEJEcBsue/NZ52MoY00Tn0vF8kUO7rBUcDHrfkkBpw5XEVR1BqqMvSXXgtSxLynxOmAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3a8C7noLWz20Mbf1U+XtzipvH7dEVf6Nr+lgHbHHYA=;
 b=bqBNrZrVt/DCIMi3rcWublGjvBYRyYB8/cs+NuY242+Km6mne5XmAARv2skBjQLS0ZgvF+g1ocRi3Da/M7O4sxlN4hMRIL7qoVLp/IJ0DlX6luOTYhwGqetcU0uBewu8C4jNFFASlKT75/yky1edaCVF1aNP45fiiUmBZ2xUR0E=
Received: from SJ0PR03CA0198.namprd03.prod.outlook.com (2603:10b6:a03:2ef::23)
 by DS0PR12MB9321.namprd12.prod.outlook.com (2603:10b6:8:1b8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 14:03:04 +0000
Received: from DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:2ef:cafe::e1) by SJ0PR03CA0198.outlook.office365.com
 (2603:10b6:a03:2ef::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31 via Frontend
 Transport; Mon, 10 Jul 2023 14:03:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT034.mail.protection.outlook.com (10.13.173.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.19 via Frontend Transport; Mon, 10 Jul 2023 14:03:03 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 10 Jul
 2023 09:03:02 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Mon, 10 Jul 2023 09:03:00 -0500
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: <qemu-devel@nongnu.org>
CC: <frasse.iglesias@gmail.com>, <alistair@alistair23.me>,
 <edgar.iglesias@gmail.com>, <peter.maydell@linaro.org>, <fkonrad@amd.com>,
 <sai.pavan.boddu@amd.com>, <tong.ho@amd.com>, <vikram.garhwal@amd.com>
Subject: [PATCH v1 5/8] hw/misc: Introduce a model of Xilinx Versal's
 CFRAME_REG
Date: Mon, 10 Jul 2023 16:02:46 +0200
Message-ID: <20230710140249.56324-6-francisco.iglesias@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230710140249.56324-1-francisco.iglesias@amd.com>
References: <20230710140249.56324-1-francisco.iglesias@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT034:EE_|DS0PR12MB9321:EE_
X-MS-Office365-Filtering-Correlation-Id: 73bfedf4-133e-4800-8de9-08db814e60d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oc7hsobaZo7RAxR/qujmXbUgMzPHSq1wi6A/durek5IroqTshQiDi2vBIr6vp8e8IWHzXGPNeIYODKuM1tAYodBIRdUbK1dzK/1qcIim3doqY6d6aTL+3905K18fFrVCDSE90G1QNJNGR2CyMTxVmLqt+tmUc8FziV2az2Px+Zpf8KM9abRaMSxUKOnG+r5InXJQfw7ZwSbhtRjuu07G+Pl+5aJxu0QoDt2VNxmM2jJsICugKHvGyuWBk8Swn8i/FarAG+BofUdD9C6qWv/T7ER+FY1krntHtkb1Q+t53x8KyA0yCgU/7xdFMYDuCT5m4iHPkcB5Jx2jlYCmEbf+POTkBf9IbDAn4xlLLBneE7oqQ1PW71LfcqzfFEIesDcm1I+9Af2HEjpn08KslV7f+9G0n9YQEVS+ulyz2u/UEAe4XNV7oIf/K8b7rW1w2BZzPKoy+Pm2432ZfTzbZy7BOIMB6qxMEjdQ2m3ey20Rwb8vVYqxVhr3TzbeJUaCvgAM6fTjFEStK1/TQsOUEX2Hk44yYRW+sx1aNoI0gOOpYD7dSOd6Jkl/ijTpDF/8yl3weO/3jtOzNLtCvQ6o19oPtvGH0XlCPiApDecgZr4DssO0ixm/UrNqCk6t2fNrIvMFQD1JaAPhM2hukbVt+4ttsQ5rQsihEhL1WK1opLpYPhFlJw9hZMUE75PtyKOAGpvCXgvZnBrTeifuRt3U57H6/a1DFn2snCYQbBq+SJcGzrAFMG6KpHo20EDG1nbrjnsejp6W5imu04x9HGTldmsPd5IkDutd5oSK37AlRwl2Hro=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(39860400002)(396003)(376002)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(186003)(26005)(1076003)(2616005)(966005)(36860700001)(336012)(426003)(83380400001)(47076005)(41300700001)(4326008)(30864003)(2906002)(316002)(44832011)(5660300002)(8936002)(8676002)(6916009)(478600001)(6666004)(70206006)(70586007)(54906003)(40480700001)(36756003)(81166007)(356005)(82740400003)(82310400005)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 14:03:03.3988 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73bfedf4-133e-4800-8de9-08db814e60d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9321
Received-SPF: softfail client-ip=2a01:111:f400:7eaa::60d;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 SPF_HELO_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
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

Introduce a model of Xilinx Versal's Configuration Frame controller
(CFRAME_REG).

Signed-off-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
 MAINTAINERS                              |   2 +
 hw/misc/meson.build                      |   1 +
 hw/misc/xlnx-versal-cframe-reg.c         | 714 +++++++++++++++++++++++
 include/hw/misc/xlnx-versal-cframe-reg.h | 288 +++++++++
 4 files changed, 1005 insertions(+)
 create mode 100644 hw/misc/xlnx-versal-cframe-reg.c
 create mode 100644 include/hw/misc/xlnx-versal-cframe-reg.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 2bc7ab42ae..1fdd6927b7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1043,6 +1043,8 @@ F: hw/misc/xlnx-cfi-if.c
 F: include/hw/misc/xlnx-cfi-if.h
 F: hw/misc/xlnx-versal-cfu.c
 F: include/hw/misc/xlnx-versal-cfu.h
+F: hw/misc/xlnx-versal-cframe-reg.c
+F: include/hw/misc/xlnx-versal-cframe-reg.h
 
 STM32F100
 M: Alexandre Iooss <erdnaxe@crans.org>
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index c88051aa51..f1ef952004 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -98,6 +98,7 @@ system_ss.add(when: 'CONFIG_XLNX_VERSAL', if_true: files(
   'xlnx-versal-pmc-iou-slcr.c',
   'xlnx-versal-cfu.c',
   'xlnx-cfi-if.c',
+  'xlnx-versal-cframe-reg.c',
 ))
 system_ss.add(when: 'CONFIG_STM32F2XX_SYSCFG', if_true: files('stm32f2xx_syscfg.c'))
 system_ss.add(when: 'CONFIG_STM32F4XX_SYSCFG', if_true: files('stm32f4xx_syscfg.c'))
diff --git a/hw/misc/xlnx-versal-cframe-reg.c b/hw/misc/xlnx-versal-cframe-reg.c
new file mode 100644
index 0000000000..7e3420e14d
--- /dev/null
+++ b/hw/misc/xlnx-versal-cframe-reg.c
@@ -0,0 +1,714 @@
+/*
+ * QEMU model of the Configuration Frame Control module
+ *
+ * Copyright (C) 2023, Advanced Micro Devices, Inc.
+ *
+ * Written by Francisco Iglesias <francisco.iglesias@amd.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/sysbus.h"
+#include "hw/register.h"
+#include "hw/registerfields.h"
+#include "qemu/bitops.h"
+#include "qemu/log.h"
+#include "qapi/error.h"
+#include "hw/qdev-properties.h"
+#include "migration/vmstate.h"
+#include "hw/irq.h"
+#include "hw/misc/xlnx-versal-cframe-reg.h"
+
+#ifndef XLNX_VERSAL_CFRAME_REG_ERR_DEBUG
+#define XLNX_VERSAL_CFRAME_REG_ERR_DEBUG 0
+#endif
+
+#define KEYHOLE_STREAM_4K 0x1000
+
+#define MAX_BLOCKTYPE 6
+#define MAX_BLOCKTYPE_FRAMES 0xFFFFF
+
+enum {
+    CFRAME_CMD_WCFG = 1,
+    CFRAME_CMD_ROWON = 2,
+    CFRAME_CMD_ROWOFF = 3,
+    CFRAME_CMD_RCFG = 4,
+    CFRAME_CMD_DLPARK = 5
+};
+
+static void cfrm_imr_update_irq(XlnxVersalCFrameReg *s)
+{
+    bool pending = s->regs[R_CFRM_ISR0] & ~s->regs[R_CFRM_IMR0];
+    qemu_set_irq(s->irq_cfrm_imr, pending);
+}
+
+static void cfrm_isr_postw(RegisterInfo *reg, uint64_t val64)
+{
+    XlnxVersalCFrameReg *s = XLNX_VERSAL_CFRAME_REG(reg->opaque);
+    cfrm_imr_update_irq(s);
+}
+
+static uint64_t cfrm_ier_prew(RegisterInfo *reg, uint64_t val64)
+{
+    XlnxVersalCFrameReg *s = XLNX_VERSAL_CFRAME_REG(reg->opaque);
+
+    s->regs[R_CFRM_IMR0] &= ~s->regs[R_CFRM_IER0];
+    s->regs[R_CFRM_IER0] = 0;
+    cfrm_imr_update_irq(s);
+    return 0;
+}
+
+static uint64_t cfrm_idr_prew(RegisterInfo *reg, uint64_t val64)
+{
+    XlnxVersalCFrameReg *s = XLNX_VERSAL_CFRAME_REG(reg->opaque);
+
+    s->regs[R_CFRM_IMR0] |= s->regs[R_CFRM_IDR0];
+    s->regs[R_CFRM_IDR0] = 0;
+    cfrm_imr_update_irq(s);
+    return 0;
+}
+
+static uint64_t cfrm_itr_prew(RegisterInfo *reg, uint64_t val64)
+{
+    XlnxVersalCFrameReg *s = XLNX_VERSAL_CFRAME_REG(reg->opaque);
+
+    s->regs[R_CFRM_ISR0] |= s->regs[R_CFRM_ITR0];
+    s->regs[R_CFRM_ITR0] = 0;
+    cfrm_imr_update_irq(s);
+    return 0;
+}
+
+static void cframe_incr_far(XlnxVersalCFrameReg *s)
+{
+    uint32_t faddr = ARRAY_FIELD_EX32(s->regs, FAR0, FRAME_ADDR);
+    uint32_t blktype = ARRAY_FIELD_EX32(s->regs, FAR0, BLOCKTYPE);
+
+    assert(blktype <= MAX_BLOCKTYPE);
+
+    faddr++;
+    if (faddr > s->cfg.blktype_num_frames[blktype]) {
+        /* Restart from 0 and increment block type */
+        faddr = 0;
+        blktype++;
+
+        assert(blktype <= MAX_BLOCKTYPE);
+
+        ARRAY_FIELD_DP32(s->regs, FAR0, BLOCKTYPE, blktype);
+    }
+
+    ARRAY_FIELD_DP32(s->regs, FAR0, FRAME_ADDR, faddr);
+}
+
+static XlnxCFrame *cframes_get_frame(XlnxVersalCFrameReg *s, uint32_t addr)
+{
+    for (int i = 0; i < s->cframes->len; i++) {
+        XlnxCFrame *f = &g_array_index(s->cframes, XlnxCFrame, i);
+
+        if (f->addr == addr) {
+            return f;
+        }
+    }
+    return NULL;
+}
+
+static void cfrm_fdri_post_write(RegisterInfo *reg, uint64_t val)
+{
+    XlnxVersalCFrameReg *s = XLNX_VERSAL_CFRAME_REG(reg->opaque);
+
+    if (s->row_configured && s->rowon && s->wcfg) {
+        XlnxCFrame *new_f = &s->new_f;
+
+        new_f->data[new_f->idx++] = s->regs[R_FDRI0];
+        new_f->data[new_f->idx++] = s->regs[R_FDRI1];
+        new_f->data[new_f->idx++] = s->regs[R_FDRI2];
+        new_f->data[new_f->idx++] = s->regs[R_FDRI3];
+
+        assert(new_f->idx <= FRAME_NUM_WORDS);
+
+        if (new_f->idx == FRAME_NUM_WORDS) {
+            XlnxCFrame *cur_f;
+
+            /* Include block type and frame address */
+            new_f->addr = extract32(s->regs[R_FAR0], 0, 23);
+
+            cur_f = cframes_get_frame(s, new_f->addr);
+
+            if (cur_f) {
+                /* Overwrite current frame */
+                cur_f[0] = new_f[0];
+            } else {
+                g_array_append_val(s->cframes, new_f[0]);
+            }
+
+            cframe_incr_far(s);
+
+            /* Clear out new_f */
+            memset(new_f, 0, sizeof(*new_f));
+        }
+    }
+}
+
+static void cfrm_readout_frames(XlnxVersalCFrameReg *s, uint32_t start_addr,
+                                uint32_t end_addr)
+{
+    for (uint32_t addr = start_addr; addr < end_addr; addr++) {
+        XlnxCFrame *f = cframes_get_frame(s, addr);
+
+        for (int i = 0; i < FRAME_NUM_WORDS; i += 4) {
+            XlnxCfiPacket pkt = {};
+
+            /* If frame was found transmit the data */
+            if (f) {
+                pkt.data[0] = f->data[i];
+                pkt.data[1] = f->data[i + 1];
+                pkt.data[2] = f->data[i + 2];
+                pkt.data[3] = f->data[i + 3];
+            }
+
+            if (s->cfg.cfu_fdro) {
+                xlnx_cfi_transfer_packet(s->cfg.cfu_fdro, &pkt);
+            }
+        }
+    }
+}
+
+static void cfrm_frcnt_post_write(RegisterInfo *reg, uint64_t val)
+{
+    XlnxVersalCFrameReg *s = XLNX_VERSAL_CFRAME_REG(reg->opaque);
+
+    if (s->row_configured && s->rowon && s->rcfg) {
+        uint32_t start_addr = extract32(s->regs[R_FAR0], 0, 23);
+        uint32_t end_addr = start_addr + s->regs[R_FRCNT0] / FRAME_NUM_QWORDS;
+
+        cfrm_readout_frames(s, start_addr, end_addr);
+    }
+}
+
+static void cfrm_cmd_post_write(RegisterInfo *reg, uint64_t val)
+{
+    XlnxVersalCFrameReg *s = XLNX_VERSAL_CFRAME_REG(reg->opaque);
+
+    if (s->row_configured) {
+        uint8_t cmd = ARRAY_FIELD_EX32(s->regs, CMD0, CMD);
+
+        switch (cmd) {
+        case CFRAME_CMD_WCFG:
+            s->wcfg = true;
+            break;
+        case CFRAME_CMD_ROWON:
+            s->rowon = true;
+            break;
+        case CFRAME_CMD_ROWOFF:
+            s->rowon = false;
+            break;
+        case CFRAME_CMD_RCFG:
+            s->rcfg = true;
+            break;
+        case CFRAME_CMD_DLPARK:
+            s->wcfg = false;
+            s->rcfg = false;
+            break;
+        default:
+            break;
+        };
+    }
+}
+
+static uint64_t cfrm_last_frame_bot_post_read(RegisterInfo *reg,
+                                              uint64_t val64)
+{
+    XlnxVersalCFrameReg *s = XLNX_VERSAL_CFRAME_REG(reg->opaque);
+    uint64_t val = 0;
+
+    switch (reg->access->addr) {
+    case A_LAST_FRAME_BOT0:
+        val = FIELD_DP32(val, LAST_FRAME_BOT0, BLOCKTYPE1_LAST_FRAME_LSB,
+                         s->cfg.blktype_num_frames[1]);
+        val = FIELD_DP32(val, LAST_FRAME_BOT0, BLOCKTYPE0_LAST_FRAME,
+                         s->cfg.blktype_num_frames[0]);
+        break;
+    case A_LAST_FRAME_BOT1:
+        val = FIELD_DP32(val, LAST_FRAME_BOT1, BLOCKTYPE3_LAST_FRAME_LSB,
+                         s->cfg.blktype_num_frames[3]);
+        val = FIELD_DP32(val, LAST_FRAME_BOT1, BLOCKTYPE2_LAST_FRAME,
+                         s->cfg.blktype_num_frames[2]);
+        val = FIELD_DP32(val, LAST_FRAME_BOT1, BLOCKTYPE1_LAST_FRAME_MSB,
+                         (s->cfg.blktype_num_frames[1] >> 12));
+        break;
+    case A_LAST_FRAME_BOT2:
+        val = FIELD_DP32(val, LAST_FRAME_BOT2, BLOCKTYPE3_LAST_FRAME_MSB,
+                         (s->cfg.blktype_num_frames[3] >> 4));
+        break;
+    case A_LAST_FRAME_BOT3:
+    default:
+        break;
+    }
+
+    return val;
+}
+
+static uint64_t cfrm_last_frame_top_post_read(RegisterInfo *reg,
+                                              uint64_t val64)
+{
+    XlnxVersalCFrameReg *s = XLNX_VERSAL_CFRAME_REG(reg->opaque);
+    uint64_t val = 0;
+
+    switch (reg->access->addr) {
+    case A_LAST_FRAME_TOP0:
+        val = FIELD_DP32(val, LAST_FRAME_TOP0, BLOCKTYPE5_LAST_FRAME_LSB,
+                         s->cfg.blktype_num_frames[5]);
+        val = FIELD_DP32(val, LAST_FRAME_TOP0, BLOCKTYPE4_LAST_FRAME,
+                         s->cfg.blktype_num_frames[4]);
+        break;
+    case A_LAST_FRAME_TOP1:
+        val = FIELD_DP32(val, LAST_FRAME_TOP1, BLOCKTYPE6_LAST_FRAME,
+                         s->cfg.blktype_num_frames[6]);
+        val = FIELD_DP32(val, LAST_FRAME_TOP1, BLOCKTYPE5_LAST_FRAME_MSB,
+                         (s->cfg.blktype_num_frames[5] >> 12));
+        break;
+    case A_LAST_FRAME_TOP2:
+    case A_LAST_FRAME_BOT3:
+    default:
+        break;
+    }
+
+    return val;
+}
+
+static void cfrm_far_sfr_post_write(RegisterInfo *reg, uint64_t val)
+{
+    XlnxVersalCFrameReg *s = XLNX_VERSAL_CFRAME_REG(reg->opaque);
+
+    if (s->row_configured && s->rowon && s->rcfg) {
+        uint32_t start_addr = extract32(s->regs[R_FAR_SFR0], 0, 23);
+
+        /* Readback 1 frame */
+        cfrm_readout_frames(s, start_addr, start_addr + 1);
+    }
+}
+
+static const RegisterAccessInfo cframe_reg_regs_info[] = {
+    {   .name = "CRC0",  .addr = A_CRC0,
+        .rsvd = 0x00000000,
+    },{ .name = "CRC1",  .addr = A_CRC0,
+        .rsvd = 0xffffffff,
+    },{ .name = "CRC2",  .addr = A_CRC0,
+        .rsvd = 0xffffffff,
+    },{ .name = "CRC3",  .addr = A_CRC0,
+        .rsvd = 0xffffffff,
+    },{ .name = "FAR0",  .addr = A_FAR0,
+        .rsvd = 0xfe000000,
+    },{ .name = "FAR1",  .addr = A_FAR1,
+        .rsvd = 0xffffffff,
+    },{ .name = "FAR2",  .addr = A_FAR2,
+        .rsvd = 0xffffffff,
+    },{ .name = "FAR3",  .addr = A_FAR3,
+        .rsvd = 0xffffffff,
+    },{ .name = "FAR_SFR0",  .addr = A_FAR_SFR0,
+        .rsvd = 0xff800000,
+    },{ .name = "FAR_SFR1",  .addr = A_FAR_SFR1,
+        .rsvd = 0xffffffff,
+    },{ .name = "FAR_SFR2",  .addr = A_FAR_SFR2,
+        .rsvd = 0xffffffff,
+    },{ .name = "FAR_SFR3",  .addr = A_FAR_SFR3,
+        .rsvd = 0xffffffff,
+        .post_write = cfrm_far_sfr_post_write,
+    },{ .name = "FDRI0",  .addr = A_FDRI0,
+    },{ .name = "FDRI1",  .addr = A_FDRI1,
+    },{ .name = "FDRI2",  .addr = A_FDRI2,
+    },{ .name = "FDRI3",  .addr = A_FDRI3,
+        .post_write = cfrm_fdri_post_write,
+    },{ .name = "FRCNT0",  .addr = A_FRCNT0,
+        .rsvd = 0x00000000,
+    },{ .name = "FRCNT1",  .addr = A_FRCNT1,
+        .rsvd = 0xffffffff,
+    },{ .name = "FRCNT2",  .addr = A_FRCNT2,
+        .rsvd = 0xffffffff,
+    },{ .name = "FRCNT3",  .addr = A_FRCNT3,
+        .rsvd = 0xffffffff,
+        .post_write = cfrm_frcnt_post_write
+    },{ .name = "CMD0",  .addr = A_CMD0,
+        .rsvd = 0xffffffe0,
+    },{ .name = "CMD1",  .addr = A_CMD1,
+        .rsvd = 0xffffffff,
+    },{ .name = "CMD2",  .addr = A_CMD2,
+        .rsvd = 0xffffffff,
+    },{ .name = "CMD3",  .addr = A_CMD3,
+        .rsvd = 0xffffffff,
+        .post_write = cfrm_cmd_post_write
+    },{ .name = "CR_MASK0",  .addr = A_CR_MASK0,
+        .rsvd = 0x00000000,
+    },{ .name = "CR_MASK1",  .addr = A_CR_MASK1,
+        .rsvd = 0x00000000,
+    },{ .name = "CR_MASK2",  .addr = A_CR_MASK2,
+        .rsvd = 0x00000000,
+    },{ .name = "CR_MASK3",  .addr = A_CR_MASK3,
+        .rsvd = 0xffffffff,
+    },{ .name = "CTL0",  .addr = A_CTL0,
+        .rsvd = 0xfffffff8,
+    },{ .name = "CTL1",  .addr = A_CTL1,
+        .rsvd = 0xffffffff,
+    },{ .name = "CTL2",  .addr = A_CTL2,
+        .rsvd = 0xffffffff,
+    },{ .name = "CTL3",  .addr = A_CTL3,
+        .rsvd = 0xffffffff,
+    },{ .name = "CFRM_ISR0",  .addr = A_CFRM_ISR0,
+        .rsvd = 0xffc04000,
+        .w1c = 0x3bfff,
+    },{ .name = "CFRM_ISR1",  .addr = A_CFRM_ISR1,
+        .rsvd = 0xffffffff,
+    },{ .name = "CFRM_ISR2",  .addr = A_CFRM_ISR2,
+        .rsvd = 0xffffffff,
+    },{ .name = "CFRM_ISR3",  .addr = A_CFRM_ISR3,
+        .rsvd = 0xffffffff,
+        .post_write = cfrm_isr_postw,
+    },{ .name = "CFRM_IMR0",  .addr = A_CFRM_IMR0,
+        .rsvd = 0xffc04000,
+        .ro = 0xfffff,
+        .reset = 0x3bfff,
+    },{ .name = "CFRM_IMR1",  .addr = A_CFRM_IMR1,
+        .rsvd = 0xffffffff,
+    },{ .name = "CFRM_IMR2",  .addr = A_CFRM_IMR2,
+        .rsvd = 0xffffffff,
+    },{ .name = "CFRM_IMR3",  .addr = A_CFRM_IMR3,
+        .rsvd = 0xffffffff,
+    },{ .name = "CFRM_IER0",  .addr = A_CFRM_IER0,
+        .rsvd = 0xffc04000,
+    },{ .name = "CFRM_IER1",  .addr = A_CFRM_IER1,
+        .rsvd = 0xffffffff,
+    },{ .name = "CFRM_IER2",  .addr = A_CFRM_IER2,
+        .rsvd = 0xffffffff,
+    },{ .name = "CFRM_IER3",  .addr = A_CFRM_IER3,
+        .rsvd = 0xffffffff,
+        .pre_write = cfrm_ier_prew,
+    },{ .name = "CFRM_IDR0",  .addr = A_CFRM_IDR0,
+        .rsvd = 0xffc04000,
+    },{ .name = "CFRM_IDR1",  .addr = A_CFRM_IDR1,
+        .rsvd = 0xffffffff,
+    },{ .name = "CFRM_IDR2",  .addr = A_CFRM_IDR2,
+        .rsvd = 0xffffffff,
+    },{ .name = "CFRM_IDR3",  .addr = A_CFRM_IDR3,
+        .rsvd = 0xffffffff,
+        .pre_write = cfrm_idr_prew,
+    },{ .name = "CFRM_ITR0",  .addr = A_CFRM_ITR0,
+        .rsvd = 0xffc04000,
+    },{ .name = "CFRM_ITR1",  .addr = A_CFRM_ITR1,
+        .rsvd = 0xffffffff,
+    },{ .name = "CFRM_ITR2",  .addr = A_CFRM_ITR2,
+        .rsvd = 0xffffffff,
+    },{ .name = "CFRM_ITR3",  .addr = A_CFRM_ITR3,
+        .rsvd = 0xffffffff,
+        .pre_write = cfrm_itr_prew,
+    },{ .name = "SEU_SYNDRM00",  .addr = A_SEU_SYNDRM00,
+    },{ .name = "SEU_SYNDRM01",  .addr = A_SEU_SYNDRM01,
+    },{ .name = "SEU_SYNDRM02",  .addr = A_SEU_SYNDRM02,
+    },{ .name = "SEU_SYNDRM03",  .addr = A_SEU_SYNDRM03,
+    },{ .name = "SEU_SYNDRM10",  .addr = A_SEU_SYNDRM10,
+    },{ .name = "SEU_SYNDRM11",  .addr = A_SEU_SYNDRM11,
+    },{ .name = "SEU_SYNDRM12",  .addr = A_SEU_SYNDRM12,
+    },{ .name = "SEU_SYNDRM13",  .addr = A_SEU_SYNDRM13,
+    },{ .name = "SEU_SYNDRM20",  .addr = A_SEU_SYNDRM20,
+    },{ .name = "SEU_SYNDRM21",  .addr = A_SEU_SYNDRM21,
+    },{ .name = "SEU_SYNDRM22",  .addr = A_SEU_SYNDRM22,
+    },{ .name = "SEU_SYNDRM23",  .addr = A_SEU_SYNDRM23,
+    },{ .name = "SEU_SYNDRM30",  .addr = A_SEU_SYNDRM30,
+    },{ .name = "SEU_SYNDRM31",  .addr = A_SEU_SYNDRM31,
+    },{ .name = "SEU_SYNDRM32",  .addr = A_SEU_SYNDRM32,
+    },{ .name = "SEU_SYNDRM33",  .addr = A_SEU_SYNDRM33,
+    },{ .name = "SEU_VIRTUAL_SYNDRM0",  .addr = A_SEU_VIRTUAL_SYNDRM0,
+    },{ .name = "SEU_VIRTUAL_SYNDRM1",  .addr = A_SEU_VIRTUAL_SYNDRM1,
+    },{ .name = "SEU_VIRTUAL_SYNDRM2",  .addr = A_SEU_VIRTUAL_SYNDRM2,
+    },{ .name = "SEU_VIRTUAL_SYNDRM3",  .addr = A_SEU_VIRTUAL_SYNDRM3,
+    },{ .name = "SEU_CRC0",  .addr = A_SEU_CRC0,
+    },{ .name = "SEU_CRC1",  .addr = A_SEU_CRC1,
+    },{ .name = "SEU_CRC2",  .addr = A_SEU_CRC2,
+    },{ .name = "SEU_CRC3",  .addr = A_SEU_CRC3,
+    },{ .name = "CFRAME_FAR_BOT0",  .addr = A_CFRAME_FAR_BOT0,
+    },{ .name = "CFRAME_FAR_BOT1",  .addr = A_CFRAME_FAR_BOT1,
+    },{ .name = "CFRAME_FAR_BOT2",  .addr = A_CFRAME_FAR_BOT2,
+    },{ .name = "CFRAME_FAR_BOT3",  .addr = A_CFRAME_FAR_BOT3,
+    },{ .name = "CFRAME_FAR_TOP0",  .addr = A_CFRAME_FAR_TOP0,
+    },{ .name = "CFRAME_FAR_TOP1",  .addr = A_CFRAME_FAR_TOP1,
+    },{ .name = "CFRAME_FAR_TOP2",  .addr = A_CFRAME_FAR_TOP2,
+    },{ .name = "CFRAME_FAR_TOP3",  .addr = A_CFRAME_FAR_TOP3,
+    },{ .name = "LAST_FRAME_BOT0",  .addr = A_LAST_FRAME_BOT0,
+        .ro = 0xffffffff,
+        .post_read = cfrm_last_frame_bot_post_read,
+    },{ .name = "LAST_FRAME_BOT1",  .addr = A_LAST_FRAME_BOT1,
+        .ro = 0xffffffff,
+        .post_read = cfrm_last_frame_bot_post_read,
+    },{ .name = "LAST_FRAME_BOT2",  .addr = A_LAST_FRAME_BOT2,
+        .ro = 0xffffffff,
+        .post_read = cfrm_last_frame_bot_post_read,
+    },{ .name = "LAST_FRAME_BOT3",  .addr = A_LAST_FRAME_BOT3,
+        .ro = 0xffffffff,
+        .post_read = cfrm_last_frame_bot_post_read,
+    },{ .name = "LAST_FRAME_TOP0",  .addr = A_LAST_FRAME_TOP0,
+        .ro = 0xffffffff,
+        .post_read = cfrm_last_frame_top_post_read,
+    },{ .name = "LAST_FRAME_TOP1",  .addr = A_LAST_FRAME_TOP1,
+        .ro = 0xffffffff,
+        .post_read = cfrm_last_frame_top_post_read,
+    },{ .name = "LAST_FRAME_TOP2",  .addr = A_LAST_FRAME_TOP2,
+        .ro = 0xffffffff,
+        .post_read = cfrm_last_frame_top_post_read,
+    },{ .name = "LAST_FRAME_TOP3",  .addr = A_LAST_FRAME_TOP3,
+        .ro = 0xffffffff,
+        .post_read = cfrm_last_frame_top_post_read,
+    }
+};
+
+static void cframe_reg_cfi_transfer_packet(XlnxCfiIf *cfi_if,
+                                           XlnxCfiPacket *pkt)
+{
+    XlnxVersalCFrameReg *s = XLNX_VERSAL_CFRAME_REG(cfi_if);
+    uint64_t we = MAKE_64BIT_MASK(0, 4 * 8);
+
+    if (!s->row_configured) {
+        return;
+    }
+
+    switch (pkt->reg_addr) {
+    case CFRAME_FAR:
+        s->regs[R_FAR0] = pkt->data[0];
+        break;
+    case CFRAME_SFR:
+        s->regs[R_FAR_SFR0] = pkt->data[0];
+        register_write(&s->regs_info[R_FAR_SFR3], 0,
+                       we, object_get_typename(OBJECT(s)),
+                       XLNX_VERSAL_CFRAME_REG_ERR_DEBUG);
+        break;
+    case CFRAME_FDRI:
+    {
+        s->regs[R_FDRI0] = pkt->data[0];
+        s->regs[R_FDRI1] = pkt->data[1];
+        s->regs[R_FDRI2] = pkt->data[2];
+        register_write(&s->regs_info[R_FDRI3], pkt->data[3],
+                       we, object_get_typename(OBJECT(s)),
+                       XLNX_VERSAL_CFRAME_REG_ERR_DEBUG);
+        break;
+    }
+    case CFRAME_CMD:
+        ARRAY_FIELD_DP32(s->regs, CMD0, CMD, pkt->data[0]);
+
+        register_write(&s->regs_info[R_CMD3], 0,
+                       we, object_get_typename(OBJECT(s)),
+                       XLNX_VERSAL_CFRAME_REG_ERR_DEBUG);
+        break;
+    default:
+        break;
+    }
+}
+
+static uint64_t cframe_reg_fdri_read(void *opaque, hwaddr addr, unsigned size)
+{
+    qemu_log_mask(LOG_GUEST_ERROR, "%s: Unsupported read from addr=%"
+                  HWADDR_PRIx "\n", __func__, addr);
+    return 0;
+}
+
+static void cframe_reg_fdri_write(void *opaque, hwaddr addr, uint64_t value,
+                      unsigned size)
+{
+    XlnxVersalCFrameReg *s = XLNX_VERSAL_CFRAME_REG(opaque);
+    unsigned int idx;
+
+    /* 4 32bit words. */
+    idx = (addr >> 2) & 3;
+
+    s->wfifo[idx] = value;
+
+    /* Writing to the top word triggers the forwarding to the FDRI. */
+    if (idx == 3) {
+        uint64_t we = MAKE_64BIT_MASK(0, 4 * 8);
+
+        s->regs[R_FDRI0] = s->wfifo[0];
+        s->regs[R_FDRI1] = s->wfifo[1];
+        s->regs[R_FDRI2] = s->wfifo[2];
+        register_write(&s->regs_info[R_FDRI3], s->wfifo[3],
+                       we, object_get_typename(OBJECT(s)),
+                       XLNX_VERSAL_CFRAME_REG_ERR_DEBUG);
+
+        memset(s->wfifo, 0, 4 * sizeof(uint32_t));
+    }
+}
+
+static void cframe_reg_reset_enter(Object *obj, ResetType type)
+{
+    XlnxVersalCFrameReg *s = XLNX_VERSAL_CFRAME_REG(obj);
+    unsigned int i;
+
+    for (i = 0; i < ARRAY_SIZE(s->regs_info); ++i) {
+        register_reset(&s->regs_info[i]);
+    }
+}
+
+static void cframe_reg_reset_hold(Object *obj)
+{
+    XlnxVersalCFrameReg *s = XLNX_VERSAL_CFRAME_REG(obj);
+
+    cfrm_imr_update_irq(s);
+}
+
+static const MemoryRegionOps cframe_reg_ops = {
+    .read = register_read_memory,
+    .write = register_write_memory,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static const MemoryRegionOps cframe_reg_fdri_ops = {
+    .read = cframe_reg_fdri_read,
+    .write = cframe_reg_fdri_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void cframe_reg_realize(DeviceState *dev, Error **errp)
+{
+    XlnxVersalCFrameReg *s = XLNX_VERSAL_CFRAME_REG(dev);
+
+    for (int i = 0; i < ARRAY_SIZE(s->cfg.blktype_num_frames); i++) {
+        if (s->cfg.blktype_num_frames[i] > MAX_BLOCKTYPE_FRAMES) {
+            error_setg(errp,
+                       "blktype-frames%d > 0xFFFFF (max frame per block)",
+                       i);
+            return;
+        }
+        if (s->cfg.blktype_num_frames[i]) {
+            s->row_configured = true;
+        }
+    }
+}
+
+static void cframe_reg_init(Object *obj)
+{
+    XlnxVersalCFrameReg *s = XLNX_VERSAL_CFRAME_REG(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    RegisterInfoArray *reg_array;
+
+    memory_region_init(&s->iomem, obj, TYPE_XLNX_VERSAL_CFRAME_REG,
+                       CFRAME_REG_R_MAX * 4);
+    reg_array =
+        register_init_block32(DEVICE(obj), cframe_reg_regs_info,
+                              ARRAY_SIZE(cframe_reg_regs_info),
+                              s->regs_info, s->regs,
+                              &cframe_reg_ops,
+                              XLNX_VERSAL_CFRAME_REG_ERR_DEBUG,
+                              CFRAME_REG_R_MAX * 4);
+    memory_region_add_subregion(&s->iomem,
+                                0x0,
+                                &reg_array->mem);
+    sysbus_init_mmio(sbd, &s->iomem);
+    memory_region_init_io(&s->iomem_fdri, obj, &cframe_reg_fdri_ops, s,
+                          TYPE_XLNX_VERSAL_CFRAME_REG "-fdri",
+                          KEYHOLE_STREAM_4K);
+    sysbus_init_mmio(sbd, &s->iomem_fdri);
+    sysbus_init_irq(sbd, &s->irq_cfrm_imr);
+
+    s->cframes = g_array_new(FALSE, FALSE, sizeof(XlnxCFrame));
+}
+
+static int cframes_reg_pre_save(void *opaque)
+{
+    XlnxVersalCFrameReg *s = XLNX_VERSAL_CFRAME_REG(opaque);
+
+    if (s->cframes->len) {
+        s->cf_data = (uint32_t *) s->cframes->data;
+        s->cf_dlen = s->cframes->len * g_array_get_element_size(s->cframes) / 4;
+    }
+    return 0;
+}
+
+static int cframes_reg_post_load(void *opaque, int version_id)
+{
+    XlnxVersalCFrameReg *s = XLNX_VERSAL_CFRAME_REG(opaque);
+
+    if (s->cf_dlen) {
+        uint32_t num_frames = s->cf_dlen /
+                              (g_array_get_element_size(s->cframes) / 4);
+        g_array_append_vals(s->cframes, s->cf_data, num_frames);
+    }
+    return 0;
+}
+
+static const VMStateDescription vmstate_cframe_reg = {
+    .name = TYPE_XLNX_VERSAL_CFRAME_REG,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .pre_save = cframes_reg_pre_save,
+    .post_load = cframes_reg_post_load,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(wfifo, XlnxVersalCFrameReg, 4),
+        VMSTATE_UINT32_ARRAY(regs, XlnxVersalCFrameReg, CFRAME_REG_R_MAX),
+        VMSTATE_BOOL(rowon, XlnxVersalCFrameReg),
+        VMSTATE_BOOL(wcfg, XlnxVersalCFrameReg),
+        VMSTATE_BOOL(rcfg, XlnxVersalCFrameReg),
+        VMSTATE_VARRAY_UINT32_ALLOC(cf_data, XlnxVersalCFrameReg, cf_dlen,
+                                    0, vmstate_info_uint32, uint32_t),
+        VMSTATE_END_OF_LIST(),
+    }
+};
+
+static Property cframe_regs_props[] = {
+    /* Kept for backwards compatibility */
+    DEFINE_PROP_LINK("cfu", XlnxVersalCFrameReg, cfg.cfu_fdro,
+                     TYPE_XLNX_CFI_IF, XlnxCfiIf *),
+    DEFINE_PROP_LINK("cfu-fdro", XlnxVersalCFrameReg, cfg.cfu_fdro,
+                     TYPE_XLNX_CFI_IF, XlnxCfiIf *),
+    DEFINE_PROP_UINT32("blktype0-frames", XlnxVersalCFrameReg,
+                       cfg.blktype_num_frames[0], 0),
+    DEFINE_PROP_UINT32("blktype1-frames", XlnxVersalCFrameReg,
+                       cfg.blktype_num_frames[1], 0),
+    DEFINE_PROP_UINT32("blktype2-frames", XlnxVersalCFrameReg,
+                       cfg.blktype_num_frames[2], 0),
+    DEFINE_PROP_UINT32("blktype3-frames", XlnxVersalCFrameReg,
+                       cfg.blktype_num_frames[3], 0),
+    DEFINE_PROP_UINT32("blktype4-frames", XlnxVersalCFrameReg,
+                       cfg.blktype_num_frames[4], 0),
+    DEFINE_PROP_UINT32("blktype5-frames", XlnxVersalCFrameReg,
+                       cfg.blktype_num_frames[5], 0),
+    DEFINE_PROP_UINT32("blktype6-frames", XlnxVersalCFrameReg,
+                       cfg.blktype_num_frames[6], 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void cframe_reg_class_init(ObjectClass *klass, void *data)
+{
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    XlnxCfiIfClass *xcic = XLNX_CFI_IF_CLASS(klass);
+
+    dc->vmsd = &vmstate_cframe_reg;
+    dc->realize = cframe_reg_realize;
+    rc->phases.enter = cframe_reg_reset_enter;
+    rc->phases.hold = cframe_reg_reset_hold;
+    device_class_set_props(dc, cframe_regs_props);
+    xcic->cfi_transfer_packet = cframe_reg_cfi_transfer_packet;
+}
+
+static const TypeInfo cframe_reg_info = {
+    .name          = TYPE_XLNX_VERSAL_CFRAME_REG,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(XlnxVersalCFrameReg),
+    .class_init    = cframe_reg_class_init,
+    .instance_init = cframe_reg_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_XLNX_CFI_IF },
+        { }
+    }
+};
+
+static void cframe_reg_register_types(void)
+{
+    type_register_static(&cframe_reg_info);
+}
+
+type_init(cframe_reg_register_types)
diff --git a/include/hw/misc/xlnx-versal-cframe-reg.h b/include/hw/misc/xlnx-versal-cframe-reg.h
new file mode 100644
index 0000000000..07dd9ed3e4
--- /dev/null
+++ b/include/hw/misc/xlnx-versal-cframe-reg.h
@@ -0,0 +1,288 @@
+/*
+ * QEMU model of the Configuration Frame Control module
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
+#ifndef HW_MISC_XLNX_VERSAL_CFRAME_REG_H
+#define HW_MISC_XLNX_VERSAL_CFRAME_REG_H
+
+#include "hw/sysbus.h"
+#include "hw/register.h"
+#include "hw/misc/xlnx-cfi-if.h"
+
+#define TYPE_XLNX_VERSAL_CFRAME_REG "xlnx,cframe-reg"
+OBJECT_DECLARE_SIMPLE_TYPE(XlnxVersalCFrameReg, XLNX_VERSAL_CFRAME_REG)
+
+/*
+ * The registers in this module are 128 bits wide but it is ok to write
+ * and read them through 4 sequential 32 bit accesses (address[3:2] = 0,
+ * 1, 2, 3).
+ */
+REG32(CRC0, 0x0)
+    FIELD(CRC, CRC, 0, 32)
+REG32(CRC1, 0x4)
+REG32(CRC2, 0x8)
+REG32(CRC3, 0xc)
+REG32(FAR0, 0x10)
+    FIELD(FAR0, SEGMENT, 23, 2)
+    FIELD(FAR0, BLOCKTYPE, 20, 3)
+    FIELD(FAR0, FRAME_ADDR, 0, 20)
+REG32(FAR1, 0x14)
+REG32(FAR2, 0x18)
+REG32(FAR3, 0x1c)
+REG32(FAR_SFR0, 0x20)
+    FIELD(FAR_SFR0, BLOCKTYPE, 20, 3)
+    FIELD(FAR_SFR0, FRAME_ADDR, 0, 20)
+REG32(FAR_SFR1, 0x24)
+REG32(FAR_SFR2, 0x28)
+REG32(FAR_SFR3, 0x2c)
+REG32(FDRI0, 0x40)
+REG32(FDRI1, 0x44)
+REG32(FDRI2, 0x48)
+REG32(FDRI3, 0x4c)
+REG32(FRCNT0, 0x50)
+    FIELD(FRCNT0, FRCNT, 0, 32)
+REG32(FRCNT1, 0x54)
+REG32(FRCNT2, 0x58)
+REG32(FRCNT3, 0x5c)
+REG32(CMD0, 0x60)
+    FIELD(CMD0, CMD, 0, 5)
+REG32(CMD1, 0x64)
+REG32(CMD2, 0x68)
+REG32(CMD3, 0x6c)
+REG32(CR_MASK0, 0x70)
+REG32(CR_MASK1, 0x74)
+REG32(CR_MASK2, 0x78)
+REG32(CR_MASK3, 0x7c)
+REG32(CTL0, 0x80)
+    FIELD(CTL, PER_FRAME_CRC, 0, 1)
+REG32(CTL1, 0x84)
+REG32(CTL2, 0x88)
+REG32(CTL3, 0x8c)
+REG32(CFRM_ISR0, 0x150)
+    FIELD(CFRM_ISR0, READ_BROADCAST_ERROR, 21, 1)
+    FIELD(CFRM_ISR0, CMD_MISSING_ERROR, 20, 1)
+    FIELD(CFRM_ISR0, RW_ROWOFF_ERROR, 19, 1)
+    FIELD(CFRM_ISR0, READ_REG_ADDR_ERROR, 18, 1)
+    FIELD(CFRM_ISR0, READ_BLK_TYPE_ERROR, 17, 1)
+    FIELD(CFRM_ISR0, READ_FRAME_ADDR_ERROR, 16, 1)
+    FIELD(CFRM_ISR0, WRITE_REG_ADDR_ERROR, 15, 1)
+    FIELD(CFRM_ISR0, WRITE_BLK_TYPE_ERROR, 13, 1)
+    FIELD(CFRM_ISR0, WRITE_FRAME_ADDR_ERROR, 12, 1)
+    FIELD(CFRM_ISR0, MFW_OVERRUN_ERROR, 11, 1)
+    FIELD(CFRM_ISR0, FAR_FIFO_UNDERFLOW, 10, 1)
+    FIELD(CFRM_ISR0, FAR_FIFO_OVERFLOW, 9, 1)
+    FIELD(CFRM_ISR0, PER_FRAME_SEQ_ERROR, 8, 1)
+    FIELD(CFRM_ISR0, CRC_ERROR, 7, 1)
+    FIELD(CFRM_ISR0, WRITE_OVERRUN_ERROR, 6, 1)
+    FIELD(CFRM_ISR0, READ_OVERRUN_ERROR, 5, 1)
+    FIELD(CFRM_ISR0, CMD_INTERRUPT_ERROR, 4, 1)
+    FIELD(CFRM_ISR0, WRITE_INTERRUPT_ERROR, 3, 1)
+    FIELD(CFRM_ISR0, READ_INTERRUPT_ERROR, 2, 1)
+    FIELD(CFRM_ISR0, SEU_CRC_ERROR, 1, 1)
+    FIELD(CFRM_ISR0, SEU_ECC_ERROR, 0, 1)
+REG32(CFRM_ISR1, 0x154)
+REG32(CFRM_ISR2, 0x158)
+REG32(CFRM_ISR3, 0x15c)
+REG32(CFRM_IMR0, 0x160)
+    FIELD(CFRM_IMR0, READ_BROADCAST_ERROR, 21, 1)
+    FIELD(CFRM_IMR0, CMD_MISSING_ERROR, 20, 1)
+    FIELD(CFRM_IMR0, RW_ROWOFF_ERROR, 19, 1)
+    FIELD(CFRM_IMR0, READ_REG_ADDR_ERROR, 18, 1)
+    FIELD(CFRM_IMR0, READ_BLK_TYPE_ERROR, 17, 1)
+    FIELD(CFRM_IMR0, READ_FRAME_ADDR_ERROR, 16, 1)
+    FIELD(CFRM_IMR0, WRITE_REG_ADDR_ERROR, 15, 1)
+    FIELD(CFRM_IMR0, WRITE_BLK_TYPE_ERROR, 13, 1)
+    FIELD(CFRM_IMR0, WRITE_FRAME_ADDR_ERROR, 12, 1)
+    FIELD(CFRM_IMR0, MFW_OVERRUN_ERROR, 11, 1)
+    FIELD(CFRM_IMR0, FAR_FIFO_UNDERFLOW, 10, 1)
+    FIELD(CFRM_IMR0, FAR_FIFO_OVERFLOW, 9, 1)
+    FIELD(CFRM_IMR0, PER_FRAME_SEQ_ERROR, 8, 1)
+    FIELD(CFRM_IMR0, CRC_ERROR, 7, 1)
+    FIELD(CFRM_IMR0, WRITE_OVERRUN_ERROR, 6, 1)
+    FIELD(CFRM_IMR0, READ_OVERRUN_ERROR, 5, 1)
+    FIELD(CFRM_IMR0, CMD_INTERRUPT_ERROR, 4, 1)
+    FIELD(CFRM_IMR0, WRITE_INTERRUPT_ERROR, 3, 1)
+    FIELD(CFRM_IMR0, READ_INTERRUPT_ERROR, 2, 1)
+    FIELD(CFRM_IMR0, SEU_CRC_ERROR, 1, 1)
+    FIELD(CFRM_IMR0, SEU_ECC_ERROR, 0, 1)
+REG32(CFRM_IMR1, 0x164)
+REG32(CFRM_IMR2, 0x168)
+REG32(CFRM_IMR3, 0x16c)
+REG32(CFRM_IER0, 0x170)
+    FIELD(CFRM_IER0, READ_BROADCAST_ERROR, 21, 1)
+    FIELD(CFRM_IER0, CMD_MISSING_ERROR, 20, 1)
+    FIELD(CFRM_IER0, RW_ROWOFF_ERROR, 19, 1)
+    FIELD(CFRM_IER0, READ_REG_ADDR_ERROR, 18, 1)
+    FIELD(CFRM_IER0, READ_BLK_TYPE_ERROR, 17, 1)
+    FIELD(CFRM_IER0, READ_FRAME_ADDR_ERROR, 16, 1)
+    FIELD(CFRM_IER0, WRITE_REG_ADDR_ERROR, 15, 1)
+    FIELD(CFRM_IER0, WRITE_BLK_TYPE_ERROR, 13, 1)
+    FIELD(CFRM_IER0, WRITE_FRAME_ADDR_ERROR, 12, 1)
+    FIELD(CFRM_IER0, MFW_OVERRUN_ERROR, 11, 1)
+    FIELD(CFRM_IER0, FAR_FIFO_UNDERFLOW, 10, 1)
+    FIELD(CFRM_IER0, FAR_FIFO_OVERFLOW, 9, 1)
+    FIELD(CFRM_IER0, PER_FRAME_SEQ_ERROR, 8, 1)
+    FIELD(CFRM_IER0, CRC_ERROR, 7, 1)
+    FIELD(CFRM_IER0, WRITE_OVERRUN_ERROR, 6, 1)
+    FIELD(CFRM_IER0, READ_OVERRUN_ERROR, 5, 1)
+    FIELD(CFRM_IER0, CMD_INTERRUPT_ERROR, 4, 1)
+    FIELD(CFRM_IER0, WRITE_INTERRUPT_ERROR, 3, 1)
+    FIELD(CFRM_IER0, READ_INTERRUPT_ERROR, 2, 1)
+    FIELD(CFRM_IER0, SEU_CRC_ERROR, 1, 1)
+    FIELD(CFRM_IER0, SEU_ECC_ERROR, 0, 1)
+REG32(CFRM_IER1, 0x174)
+REG32(CFRM_IER2, 0x178)
+REG32(CFRM_IER3, 0x17c)
+REG32(CFRM_IDR0, 0x180)
+    FIELD(CFRM_IDR0, READ_BROADCAST_ERROR, 21, 1)
+    FIELD(CFRM_IDR0, CMD_MISSING_ERROR, 20, 1)
+    FIELD(CFRM_IDR0, RW_ROWOFF_ERROR, 19, 1)
+    FIELD(CFRM_IDR0, READ_REG_ADDR_ERROR, 18, 1)
+    FIELD(CFRM_IDR0, READ_BLK_TYPE_ERROR, 17, 1)
+    FIELD(CFRM_IDR0, READ_FRAME_ADDR_ERROR, 16, 1)
+    FIELD(CFRM_IDR0, WRITE_REG_ADDR_ERROR, 15, 1)
+    FIELD(CFRM_IDR0, WRITE_BLK_TYPE_ERROR, 13, 1)
+    FIELD(CFRM_IDR0, WRITE_FRAME_ADDR_ERROR, 12, 1)
+    FIELD(CFRM_IDR0, MFW_OVERRUN_ERROR, 11, 1)
+    FIELD(CFRM_IDR0, FAR_FIFO_UNDERFLOW, 10, 1)
+    FIELD(CFRM_IDR0, FAR_FIFO_OVERFLOW, 9, 1)
+    FIELD(CFRM_IDR0, PER_FRAME_SEQ_ERROR, 8, 1)
+    FIELD(CFRM_IDR0, CRC_ERROR, 7, 1)
+    FIELD(CFRM_IDR0, WRITE_OVERRUN_ERROR, 6, 1)
+    FIELD(CFRM_IDR0, READ_OVERRUN_ERROR, 5, 1)
+    FIELD(CFRM_IDR0, CMD_INTERRUPT_ERROR, 4, 1)
+    FIELD(CFRM_IDR0, WRITE_INTERRUPT_ERROR, 3, 1)
+    FIELD(CFRM_IDR0, READ_INTERRUPT_ERROR, 2, 1)
+    FIELD(CFRM_IDR0, SEU_CRC_ERROR, 1, 1)
+    FIELD(CFRM_IDR0, SEU_ECC_ERROR, 0, 1)
+REG32(CFRM_IDR1, 0x184)
+REG32(CFRM_IDR2, 0x188)
+REG32(CFRM_IDR3, 0x18c)
+REG32(CFRM_ITR0, 0x190)
+    FIELD(CFRM_ITR0, READ_BROADCAST_ERROR, 21, 1)
+    FIELD(CFRM_ITR0, CMD_MISSING_ERROR, 20, 1)
+    FIELD(CFRM_ITR0, RW_ROWOFF_ERROR, 19, 1)
+    FIELD(CFRM_ITR0, READ_REG_ADDR_ERROR, 18, 1)
+    FIELD(CFRM_ITR0, READ_BLK_TYPE_ERROR, 17, 1)
+    FIELD(CFRM_ITR0, READ_FRAME_ADDR_ERROR, 16, 1)
+    FIELD(CFRM_ITR0, WRITE_REG_ADDR_ERROR, 15, 1)
+    FIELD(CFRM_ITR0, WRITE_BLK_TYPE_ERROR, 13, 1)
+    FIELD(CFRM_ITR0, WRITE_FRAME_ADDR_ERROR, 12, 1)
+    FIELD(CFRM_ITR0, MFW_OVERRUN_ERROR, 11, 1)
+    FIELD(CFRM_ITR0, FAR_FIFO_UNDERFLOW, 10, 1)
+    FIELD(CFRM_ITR0, FAR_FIFO_OVERFLOW, 9, 1)
+    FIELD(CFRM_ITR0, PER_FRAME_SEQ_ERROR, 8, 1)
+    FIELD(CFRM_ITR0, CRC_ERROR, 7, 1)
+    FIELD(CFRM_ITR0, WRITE_OVERRUN_ERROR, 6, 1)
+    FIELD(CFRM_ITR0, READ_OVERRUN_ERROR, 5, 1)
+    FIELD(CFRM_ITR0, CMD_INTERRUPT_ERROR, 4, 1)
+    FIELD(CFRM_ITR0, WRITE_INTERRUPT_ERROR, 3, 1)
+    FIELD(CFRM_ITR0, READ_INTERRUPT_ERROR, 2, 1)
+    FIELD(CFRM_ITR0, SEU_CRC_ERROR, 1, 1)
+    FIELD(CFRM_ITR0, SEU_ECC_ERROR, 0, 1)
+REG32(CFRM_ITR1, 0x194)
+REG32(CFRM_ITR2, 0x198)
+REG32(CFRM_ITR3, 0x19c)
+REG32(SEU_SYNDRM00, 0x1a0)
+REG32(SEU_SYNDRM01, 0x1a4)
+REG32(SEU_SYNDRM02, 0x1a8)
+REG32(SEU_SYNDRM03, 0x1ac)
+REG32(SEU_SYNDRM10, 0x1b0)
+REG32(SEU_SYNDRM11, 0x1b4)
+REG32(SEU_SYNDRM12, 0x1b8)
+REG32(SEU_SYNDRM13, 0x1bc)
+REG32(SEU_SYNDRM20, 0x1c0)
+REG32(SEU_SYNDRM21, 0x1c4)
+REG32(SEU_SYNDRM22, 0x1c8)
+REG32(SEU_SYNDRM23, 0x1cc)
+REG32(SEU_SYNDRM30, 0x1d0)
+REG32(SEU_SYNDRM31, 0x1d4)
+REG32(SEU_SYNDRM32, 0x1d8)
+REG32(SEU_SYNDRM33, 0x1dc)
+REG32(SEU_VIRTUAL_SYNDRM0, 0x1e0)
+REG32(SEU_VIRTUAL_SYNDRM1, 0x1e4)
+REG32(SEU_VIRTUAL_SYNDRM2, 0x1e8)
+REG32(SEU_VIRTUAL_SYNDRM3, 0x1ec)
+REG32(SEU_CRC0, 0x1f0)
+REG32(SEU_CRC1, 0x1f4)
+REG32(SEU_CRC2, 0x1f8)
+REG32(SEU_CRC3, 0x1fc)
+REG32(CFRAME_FAR_BOT0, 0x200)
+REG32(CFRAME_FAR_BOT1, 0x204)
+REG32(CFRAME_FAR_BOT2, 0x208)
+REG32(CFRAME_FAR_BOT3, 0x20c)
+REG32(CFRAME_FAR_TOP0, 0x210)
+REG32(CFRAME_FAR_TOP1, 0x214)
+REG32(CFRAME_FAR_TOP2, 0x218)
+REG32(CFRAME_FAR_TOP3, 0x21c)
+REG32(LAST_FRAME_BOT0, 0x220)
+    FIELD(LAST_FRAME_BOT0, BLOCKTYPE1_LAST_FRAME_LSB, 20, 12)
+    FIELD(LAST_FRAME_BOT0, BLOCKTYPE0_LAST_FRAME, 0, 20)
+REG32(LAST_FRAME_BOT1, 0x224)
+    FIELD(LAST_FRAME_BOT1, BLOCKTYPE3_LAST_FRAME_LSB, 28, 4)
+    FIELD(LAST_FRAME_BOT1, BLOCKTYPE2_LAST_FRAME, 8, 20)
+    FIELD(LAST_FRAME_BOT1, BLOCKTYPE1_LAST_FRAME_MSB, 0, 8)
+REG32(LAST_FRAME_BOT2, 0x228)
+    FIELD(LAST_FRAME_BOT2, BLOCKTYPE3_LAST_FRAME_MSB, 0, 16)
+REG32(LAST_FRAME_BOT3, 0x22c)
+REG32(LAST_FRAME_TOP0, 0x230)
+    FIELD(LAST_FRAME_TOP0, BLOCKTYPE5_LAST_FRAME_LSB, 20, 12)
+    FIELD(LAST_FRAME_TOP0, BLOCKTYPE4_LAST_FRAME, 0, 20)
+REG32(LAST_FRAME_TOP1, 0x234)
+    FIELD(LAST_FRAME_TOP1, BLOCKTYPE6_LAST_FRAME, 8, 20)
+    FIELD(LAST_FRAME_TOP1, BLOCKTYPE5_LAST_FRAME_MSB, 0, 8)
+REG32(LAST_FRAME_TOP2, 0x238)
+REG32(LAST_FRAME_TOP3, 0x23c)
+
+#define CFRAME_REG_R_MAX (R_LAST_FRAME_TOP3 + 1)
+
+#define FRAME_NUM_QWORDS 25
+#define FRAME_NUM_WORDS (FRAME_NUM_QWORDS * 4) /* 25 * 128 bits */
+
+typedef struct XlnxCFrame {
+    uint32_t addr;
+    uint32_t idx;
+    uint32_t data[FRAME_NUM_WORDS];
+} XlnxCFrame;
+
+struct XlnxVersalCFrameReg {
+    SysBusDevice parent_obj;
+    MemoryRegion iomem;
+    MemoryRegion iomem_fdri;
+    qemu_irq irq_cfrm_imr;
+
+    /* 128-bit wfifo.  */
+    uint32_t wfifo[4];
+
+    uint32_t regs[CFRAME_REG_R_MAX];
+    RegisterInfo regs_info[CFRAME_REG_R_MAX];
+
+    bool rowon;
+    bool wcfg;
+    bool rcfg;
+
+    GArray *cframes;
+    XlnxCFrame new_f;
+    uint32_t *cf_data;
+    uint32_t cf_dlen;
+
+    struct {
+        XlnxCfiIf *cfu_fdro;
+        uint32_t blktype_num_frames[7];
+    } cfg;
+    bool row_configured;
+};
+
+#endif
-- 
2.34.1


