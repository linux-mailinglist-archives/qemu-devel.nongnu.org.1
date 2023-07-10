Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0B074D85B
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 16:04:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIrUJ-0000l9-8G; Mon, 10 Jul 2023 10:03:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1qIrUD-0000kV-9O
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 10:03:34 -0400
Received: from mail-dm6nam11on20623.outbound.protection.outlook.com
 ([2a01:111:f400:7eaa::623]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1qIrU9-0003Kr-4p
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 10:03:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZOQUGYayPLRTZIO0zpZBfZZbE6AFHQR0RQ3XKnDUe/gfZZ0OF1j0qVskwjusI9MKI1GrSqeMrLpQdKBVmL9y9Jgy57KNJW8jQQPNm1ROXgIegzF05FfWYur6ZeJOu+cMOtopn32E7uAnYRagyDPKABRjSrje7G5qpSQgnd1UTqcUJ/UpLq+0s8uzszzhGCJ/66BoiP5SyPHpoRUKVYOYa+tItaXNE65gCQvue1fAdb4tpTBnYFZb+fCY8WoNyj1+WXq7l7/O7X0FDip+gPpijBJLJ2jVanb8I37sbdrYeyJETIXb3gV8Lv93Kf5XjuHuwmi0aluv44i4+0Rs6/RdbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O9CFdxnrXTbM8Y95X+RRpp+Wab/FuuA8p52ekwg+uJ0=;
 b=ofJrzL+Ew80BlqP1yBGp9ljBxAWGP06ru2yZej+MyXmvMZuqEoQEnKPBIr8ItERJ3e/FvspeOJGBLzGB7NOUpYcDA5sm5z0fA1WEzQmaeeJ4HpluphiFkC/Cakxu9WXYBqPtKsG0hEhufIvc5QhDJwfR+hGQS+nST4npC21Lj+6JsZxmWZNSqpwJKFy805uhkEuUY5gSjZnAkbrKrFKIM/w2x/A9y1SnTz6AYWESA/6W4JS6qiaD330Yhesl49BSYRnucqVcyrui6JOoNxi7RWW5XZIGVRp2FLNa1JsPkoOTG9KwxtDgd+crG07Jlflhhfkma/8UGrtCjtRyV/GL1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9CFdxnrXTbM8Y95X+RRpp+Wab/FuuA8p52ekwg+uJ0=;
 b=uEF6aNP1s5gS/dSpcFSOz7qu5RyEb/ykH1VSmLq75IKeuP+aaPV8O5iLIBdg3Mpobc+ERJ1UoYcEqsgdQxhcU+AWf3f/8tNe0Tgz6exhUaj/QGsY5x65WCuLwfuLx/e8Ylduf+a/5pUi2vOyA6zYwgTyDB5RMCKw4TDTqB02PbE=
Received: from BYAPR01CA0007.prod.exchangelabs.com (2603:10b6:a02:80::20) by
 MW4PR12MB6777.namprd12.prod.outlook.com (2603:10b6:303:1e9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 14:03:20 +0000
Received: from DM6NAM11FT115.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a02:80:cafe::10) by BYAPR01CA0007.outlook.office365.com
 (2603:10b6:a02:80::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30 via Frontend
 Transport; Mon, 10 Jul 2023 14:03:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT115.mail.protection.outlook.com (10.13.173.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.19 via Frontend Transport; Mon, 10 Jul 2023 14:03:05 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 10 Jul
 2023 09:03:05 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 10 Jul
 2023 07:03:04 -0700
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Mon, 10 Jul 2023 09:03:03 -0500
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: <qemu-devel@nongnu.org>
CC: <frasse.iglesias@gmail.com>, <alistair@alistair23.me>,
 <edgar.iglesias@gmail.com>, <peter.maydell@linaro.org>, <fkonrad@amd.com>,
 <sai.pavan.boddu@amd.com>, <tong.ho@amd.com>, <vikram.garhwal@amd.com>
Subject: [PATCH v1 6/8] hw/misc: Introduce a model of Xilinx Versal's
 CFRAME_BCAST_REG
Date: Mon, 10 Jul 2023 16:02:47 +0200
Message-ID: <20230710140249.56324-7-francisco.iglesias@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230710140249.56324-1-francisco.iglesias@amd.com>
References: <20230710140249.56324-1-francisco.iglesias@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT115:EE_|MW4PR12MB6777:EE_
X-MS-Office365-Filtering-Correlation-Id: 98a52b0f-3193-4df5-2219-08db814e6a9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7ICF452GmmJeS2nXUPVeIGMBljRfTSFs9mYyfjqgDUhS70yYKHQJGt14F6LQhSReH/CE7+oE/Mzako9FwApZ/Qodk9w5GopsV26sEaAgrxkTQ7YQRfaUoOT5n5XBmIDCYvWdr9AoDEoqc8KKVU0eXJvZj1XaZPQDBBGoMif2Kn5hi/0u7deVidpNGsEFipiKXEOhIY9Z3prfQ1jdv/u3QWStrvUnyM/aLSeSFzizS+ipWDxwxRyE9OmavBguH1u2bsSv3EvcFkvjbVes/4ljBI9pBHuDRU/XiyvXGqQwJrgipzEj6E+3dLBs5QEymEyqrByAzjhnxnf27AgIpV1hzYdqY8GhCz0UxUR29X5pH07A468XM4gnDx/r2KYv0dwAx6jrybMZTxRp0BOePh4l+Gjji5IfiJdFUD89YgQO81puhx72qcvwXsMyFCRDE6PfAk0SkWy7/uzLE7MYcbE9iknGYG1Q/DSNzESO5KigSeNceyCg3ye+PMrAhoqEmDBRZlk4hzngisqMbUWQUtiXqY9o1dlGxc9vqVWzGLZeqKMG1MDdtTiosRbse87IMQZTAbyemojA+W7GK4qiwhKVZvMmdMtlTlpLidxZqSiDxEz8ECjX1xEJodpVvbDCqac5xAk3/VPdzwTFGYZAMJQFdxetBSBkpNfJkM8XOKpypWeGQA+wSjFYZjBHNc635rVw9iCbkT8SiH9SuwKRe+8U5oZrMSMK5y+Zjp/7/Fje9/SLhyxtzU/uND6z4ZLpuPonIAQ2TsSvtf7sZx0WzY7dgw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199021)(46966006)(36840700001)(40470700004)(70586007)(70206006)(2616005)(2906002)(4326008)(6916009)(36756003)(336012)(426003)(44832011)(83380400001)(82310400005)(316002)(86362001)(26005)(186003)(36860700001)(47076005)(5660300002)(478600001)(6666004)(1076003)(54906003)(40460700003)(41300700001)(40480700001)(8936002)(356005)(8676002)(81166007)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 14:03:05.8087 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98a52b0f-3193-4df5-2219-08db814e6a9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT115.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6777
Received-SPF: softfail client-ip=2a01:111:f400:7eaa::623;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
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

Introduce a model of Xilinx Versal's Configuration Frame broadcast
controller (CFRAME_BCAST_REG).

Signed-off-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
 hw/misc/xlnx-versal-cframe-reg.c         | 173 +++++++++++++++++++++++
 include/hw/misc/xlnx-versal-cframe-reg.h |  17 +++
 2 files changed, 190 insertions(+)

diff --git a/hw/misc/xlnx-versal-cframe-reg.c b/hw/misc/xlnx-versal-cframe-reg.c
index 7e3420e14d..4f90eaa240 100644
--- a/hw/misc/xlnx-versal-cframe-reg.c
+++ b/hw/misc/xlnx-versal-cframe-reg.c
@@ -571,6 +571,104 @@ static const MemoryRegionOps cframe_reg_fdri_ops = {
     },
 };
 
+static uint64_t cframes_bcast_reg_read(void *opaque, hwaddr addr, unsigned size)
+{
+    qemu_log_mask(LOG_GUEST_ERROR, "%s: Unsupported read from addr=%"
+                  HWADDR_PRIx "\n", __func__, addr);
+    return 0;
+}
+
+static void cframes_bcast_reg_write(void *opaque, hwaddr addr, uint64_t value,
+                      unsigned size)
+{
+    XlnxVersalCFrameBcastReg *s = XLNX_VERSAL_CFRAME_BCAST_REG(opaque);
+    unsigned int idx;
+
+    /* 4 32bit words. */
+    idx = (addr >> 2) & 3;
+
+    s->wfifo[idx] = value;
+
+    /* Writing to the top word triggers the transmit onto CFI. */
+    if (idx == 3) {
+        uint32_t reg_addr = extract32(addr, 4, 6);
+        XlnxCfiPacket pkt = {
+            .reg_addr = reg_addr,
+            .data[0] = s->wfifo[0],
+            .data[1] = s->wfifo[1],
+            .data[2] = s->wfifo[2],
+            .data[3] = s->wfifo[3]
+        };
+
+        for (int i = 0; i < ARRAY_SIZE(s->cfg.cframe); i++) {
+            if (s->cfg.cframe[i]) {
+                xlnx_cfi_transfer_packet(s->cfg.cframe[i], &pkt);
+            }
+        }
+
+        memset(s->wfifo, 0, 4 * sizeof(uint32_t));
+    }
+}
+
+static uint64_t cframes_bcast_fdri_read(void *opaque, hwaddr addr,
+                                        unsigned size)
+{
+    qemu_log_mask(LOG_GUEST_ERROR, "%s: Unsupported read from addr=%"
+                  HWADDR_PRIx "\n", __func__, addr);
+    return 0;
+}
+
+static void cframes_bcast_fdri_write(void *opaque, hwaddr addr, uint64_t value,
+                      unsigned size)
+{
+    XlnxVersalCFrameBcastReg *s = XLNX_VERSAL_CFRAME_BCAST_REG(opaque);
+    unsigned int idx;
+
+    /* 4 32bit words. */
+    idx = (addr >> 2) & 3;
+
+    s->wfifo[idx] = value;
+
+    /* Writing to the top word triggers the transmit onto CFI. */
+    if (idx == 3) {
+        XlnxCfiPacket pkt = {
+            .reg_addr = CFRAME_FDRI,
+            .data[0] = s->wfifo[0],
+            .data[1] = s->wfifo[1],
+            .data[2] = s->wfifo[2],
+            .data[3] = s->wfifo[3]
+        };
+
+        for (int i = 0; i < ARRAY_SIZE(s->cfg.cframe); i++) {
+            if (s->cfg.cframe[i]) {
+                xlnx_cfi_transfer_packet(s->cfg.cframe[i], &pkt);
+            }
+        }
+
+        memset(s->wfifo, 0, 4 * sizeof(uint32_t));
+    }
+}
+
+static const MemoryRegionOps cframes_bcast_reg_reg_ops = {
+    .read = cframes_bcast_reg_read,
+    .write = cframes_bcast_reg_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static const MemoryRegionOps cframes_bcast_reg_fdri_ops = {
+    .read = cframes_bcast_fdri_read,
+    .write = cframes_bcast_fdri_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
 static void cframe_reg_realize(DeviceState *dev, Error **errp)
 {
     XlnxVersalCFrameReg *s = XLNX_VERSAL_CFRAME_REG(dev);
@@ -680,6 +778,64 @@ static Property cframe_regs_props[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static void cframe_bcast_reg_init(Object *obj)
+{
+    XlnxVersalCFrameBcastReg *s = XLNX_VERSAL_CFRAME_BCAST_REG(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+
+    memory_region_init_io(&s->iomem_reg, obj, &cframes_bcast_reg_reg_ops, s,
+                          TYPE_XLNX_VERSAL_CFRAME_BCAST_REG, KEYHOLE_STREAM_4K);
+    memory_region_init_io(&s->iomem_fdri, obj, &cframes_bcast_reg_fdri_ops, s,
+                          TYPE_XLNX_VERSAL_CFRAME_BCAST_REG "-fdri",
+                          KEYHOLE_STREAM_4K);
+    sysbus_init_mmio(sbd, &s->iomem_reg);
+    sysbus_init_mmio(sbd, &s->iomem_fdri);
+}
+
+static const VMStateDescription vmstate_cframe_bcast_reg = {
+    .name = TYPE_XLNX_VERSAL_CFRAME_BCAST_REG,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(wfifo, XlnxVersalCFrameBcastReg, 4),
+        VMSTATE_END_OF_LIST(),
+    }
+};
+
+static Property cframe_bcast_regs_props[] = {
+    DEFINE_PROP_LINK("cframe0", XlnxVersalCFrameBcastReg, cfg.cframe[0],
+                     TYPE_XLNX_CFI_IF, XlnxCfiIf *),
+    DEFINE_PROP_LINK("cframe1", XlnxVersalCFrameBcastReg, cfg.cframe[1],
+                     TYPE_XLNX_CFI_IF, XlnxCfiIf *),
+    DEFINE_PROP_LINK("cframe2", XlnxVersalCFrameBcastReg, cfg.cframe[2],
+                     TYPE_XLNX_CFI_IF, XlnxCfiIf *),
+    DEFINE_PROP_LINK("cframe3", XlnxVersalCFrameBcastReg, cfg.cframe[3],
+                     TYPE_XLNX_CFI_IF, XlnxCfiIf *),
+    DEFINE_PROP_LINK("cframe4", XlnxVersalCFrameBcastReg, cfg.cframe[4],
+                     TYPE_XLNX_CFI_IF, XlnxCfiIf *),
+    DEFINE_PROP_LINK("cframe5", XlnxVersalCFrameBcastReg, cfg.cframe[5],
+                     TYPE_XLNX_CFI_IF, XlnxCfiIf *),
+    DEFINE_PROP_LINK("cframe6", XlnxVersalCFrameBcastReg, cfg.cframe[6],
+                     TYPE_XLNX_CFI_IF, XlnxCfiIf *),
+    DEFINE_PROP_LINK("cframe7", XlnxVersalCFrameBcastReg, cfg.cframe[7],
+                     TYPE_XLNX_CFI_IF, XlnxCfiIf *),
+    DEFINE_PROP_LINK("cframe8", XlnxVersalCFrameBcastReg, cfg.cframe[8],
+                     TYPE_XLNX_CFI_IF, XlnxCfiIf *),
+    DEFINE_PROP_LINK("cframe9", XlnxVersalCFrameBcastReg, cfg.cframe[9],
+                     TYPE_XLNX_CFI_IF, XlnxCfiIf *),
+    DEFINE_PROP_LINK("cframe10", XlnxVersalCFrameBcastReg, cfg.cframe[10],
+                     TYPE_XLNX_CFI_IF, XlnxCfiIf *),
+    DEFINE_PROP_LINK("cframe11", XlnxVersalCFrameBcastReg, cfg.cframe[11],
+                     TYPE_XLNX_CFI_IF, XlnxCfiIf *),
+    DEFINE_PROP_LINK("cframe12", XlnxVersalCFrameBcastReg, cfg.cframe[12],
+                     TYPE_XLNX_CFI_IF, XlnxCfiIf *),
+    DEFINE_PROP_LINK("cframe13", XlnxVersalCFrameBcastReg, cfg.cframe[13],
+                     TYPE_XLNX_CFI_IF, XlnxCfiIf *),
+    DEFINE_PROP_LINK("cframe14", XlnxVersalCFrameBcastReg, cfg.cframe[14],
+                     TYPE_XLNX_CFI_IF, XlnxCfiIf *),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void cframe_reg_class_init(ObjectClass *klass, void *data)
 {
     ResettableClass *rc = RESETTABLE_CLASS(klass);
@@ -694,6 +850,14 @@ static void cframe_reg_class_init(ObjectClass *klass, void *data)
     xcic->cfi_transfer_packet = cframe_reg_cfi_transfer_packet;
 }
 
+static void cframe_bcast_reg_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->vmsd = &vmstate_cframe_bcast_reg;
+    device_class_set_props(dc, cframe_bcast_regs_props);
+}
+
 static const TypeInfo cframe_reg_info = {
     .name          = TYPE_XLNX_VERSAL_CFRAME_REG,
     .parent        = TYPE_SYS_BUS_DEVICE,
@@ -706,9 +870,18 @@ static const TypeInfo cframe_reg_info = {
     }
 };
 
+static const TypeInfo cframe_bcast_reg_info = {
+    .name          = TYPE_XLNX_VERSAL_CFRAME_BCAST_REG,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(XlnxVersalCFrameBcastReg),
+    .class_init    = cframe_bcast_reg_class_init,
+    .instance_init = cframe_bcast_reg_init,
+};
+
 static void cframe_reg_register_types(void)
 {
     type_register_static(&cframe_reg_info);
+    type_register_static(&cframe_bcast_reg_info);
 }
 
 type_init(cframe_reg_register_types)
diff --git a/include/hw/misc/xlnx-versal-cframe-reg.h b/include/hw/misc/xlnx-versal-cframe-reg.h
index 07dd9ed3e4..c98d5d84f9 100644
--- a/include/hw/misc/xlnx-versal-cframe-reg.h
+++ b/include/hw/misc/xlnx-versal-cframe-reg.h
@@ -24,6 +24,10 @@
 #define TYPE_XLNX_VERSAL_CFRAME_REG "xlnx,cframe-reg"
 OBJECT_DECLARE_SIMPLE_TYPE(XlnxVersalCFrameReg, XLNX_VERSAL_CFRAME_REG)
 
+#define TYPE_XLNX_VERSAL_CFRAME_BCAST_REG "xlnx.cframe-bcast-reg"
+OBJECT_DECLARE_SIMPLE_TYPE(XlnxVersalCFrameBcastReg,
+                           XLNX_VERSAL_CFRAME_BCAST_REG)
+
 /*
  * The registers in this module are 128 bits wide but it is ok to write
  * and read them through 4 sequential 32 bit accesses (address[3:2] = 0,
@@ -285,4 +289,17 @@ struct XlnxVersalCFrameReg {
     bool row_configured;
 };
 
+struct XlnxVersalCFrameBcastReg {
+    SysBusDevice parent_obj;
+    MemoryRegion iomem_reg;
+    MemoryRegion iomem_fdri;
+
+    /* 128-bit wfifo. */
+    uint32_t wfifo[4];
+
+    struct {
+        XlnxCfiIf *cframe[15];
+    } cfg;
+};
+
 #endif
-- 
2.34.1


