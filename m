Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC006778136
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 21:17:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUB9k-0000Z6-Ed; Thu, 10 Aug 2023 15:17:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1qUB9P-0000Rh-Vj
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 15:16:53 -0400
Received: from mail-bn8nam11on20601.outbound.protection.outlook.com
 ([2a01:111:f400:7eae::601]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1qUB9M-00074Z-J0
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 15:16:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OehK2dJNc1q+gSOPKVOcDkFEikXqPLgIuscn3WMMI4cjYgQzCKRqtXk+4wFwxiS/VSDrfmy+6ci6YL9Jc79lJgISAdX2e186RKKlI2IsUBB04lwNx5Y6194YK7mbX/el8+yncjguiz4p6MIDVYJwtCILE4msVvYRxq1CL0T9AhNMfKmf89nIlEqm4BW4SyGoQc3q7+L1sHDPvkeHtSM3ofyfhhznvP5xNXKn0+D+cQux4sB8uHGdTztHmELU+TWuCQffbQteZ9YpbUKxyb/uHGI/UpBR/lOgl5cO4iypm23sVs2q6oyVpayfiVi2pdNm0NLaBROfZPf2MPt+hmLDTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8d6Q3tkfp9kgKmi0cdTNcY4OJiNS4MBOoSKHBbd/Rxs=;
 b=GefW84tTk+k76pArDY1y2NAUt+W3IJ1/KyP2rSv5iEVMUlpYqC9x1agOafEWusB9Md2BrMp5bdHhISrGeR7AzWbzmBwKjsjdpYYuci6NZhnYKRGNEC3y9/+AniL343UtWVRzIGQ4H0XODhXU3aSeaiAoVUVZNOH1KrQUCCbOSggnuiYtJX83GnoKBUsnvFAjeI3vYk7+ekqkoAQyZqy7n6+CLuR3481xSu0jq5tfdtsTo7PPNuWocQPgd81XrxBFxq75I21IlwyYF9hiSFs3IW49QVlsZBIpZpqTVA3f7dS0aDQYAjmrvXSkgtfJ8dGSXLaDjAKFKCCIVyu4P+p5ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8d6Q3tkfp9kgKmi0cdTNcY4OJiNS4MBOoSKHBbd/Rxs=;
 b=qXAjYfYYcPb7JWjUvJPPN+qdUuOy4Xd4yl3cDy9ujOZiwfOZ2G5GuGXsp/EM4vF0MdO+3sqLTpoE46Sh1GIi/KCoUYtYKYF4nlkPWKH/wbV/p8G0/2l8SbwyEe7jYP9pJDrhTOBM/QUMZ9Uxoj9PuVjrJcVd9X9hMRvtOmFD7zM=
Received: from CY5PR19CA0106.namprd19.prod.outlook.com (2603:10b6:930:83::29)
 by PH7PR12MB5927.namprd12.prod.outlook.com (2603:10b6:510:1da::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 19:16:41 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:930:83:cafe::1) by CY5PR19CA0106.outlook.office365.com
 (2603:10b6:930:83::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30 via Frontend
 Transport; Thu, 10 Aug 2023 19:16:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.77) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.20 via Frontend Transport; Thu, 10 Aug 2023 19:16:41 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 14:16:40 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 10 Aug 2023 14:16:39 -0500
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: <qemu-devel@nongnu.org>
CC: <frasse.iglesias@gmail.com>, <alistair@alistair23.me>,
 <edgar.iglesias@gmail.com>, <peter.maydell@linaro.org>, <fkonrad@amd.com>,
 <sai.pavan.boddu@amd.com>, <tong.ho@amd.com>, <vikram.garhwal@amd.com>
Subject: [PATCH v2 6/8] hw/misc: Introduce a model of Xilinx Versal's
 CFRAME_BCAST_REG
Date: Thu, 10 Aug 2023 21:16:24 +0200
Message-ID: <20230810191626.81084-7-francisco.iglesias@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810191626.81084-1-francisco.iglesias@amd.com>
References: <20230810191626.81084-1-francisco.iglesias@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|PH7PR12MB5927:EE_
X-MS-Office365-Filtering-Correlation-Id: ad574b3c-162a-48c2-5947-08db99d65435
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wUJ+vpeAOYw3auUr6Ad8rmhq962qMrL8/5hRAY5+inYwavoJLssTHV2M4qyLAw++ZROOIy7Nv5cUMHASG7gqk9+ZcooKj2bP4JrfAySykS5FM9Jdu1J0E/kcPn6cBgwtNKr2l91hafbxIRyfqdAOtZLe3LceM6lKnYPDkGnLmeFaUZG7ISnLm2S0PYnueDzFDnBZL1oGCidR3oRZXHrd4FBZd6LNgazejedj7hboGgRJp2AbogKzFus5rO3PBMHOk741W9aUPXexBUe2igj4y6efXO/IlK0+9EhAEEmN7gMD8mQNXIN9743SVmUiHxbugcYIXyucqvA0ETyexDfAFNC/9G4hMc28XbZwB8eAX1+HQ3AscY25i8jonEkPaHND9hIvgFhJwcCnYaAFpGVaHUhRyTiIu1+SgnPSIvDO1QFbFsZgLGgmHBCtz/QUiSU7UpPfypynlN5csoL6UyMZJx1h0o6hJzjoGYpjzu6sGGZ8znPIRWRkQDfRCMVvikVR+LIWf2eDLIjMsy2bLDokt2lglogtC60ClbEZokbhKZh3S/DqLo8+gk/LlHnA9QCk9MwoE+MYvwg+CDdjK1bRTL8G1cVN8BaXJWeym4pDxMExoycelIn7VJyak97aPP1eX3dAKfbIqJimncYh21akiQAbKvbw1Oqk7o/RYkw/IOwpJrNE4E5+aJrwRAn1sIGKX/rrUoMfB/NRs4KOvKHFciI3wl/FRkkokFwVhJy93qQ1maa9i+HMKkVqIx8dCmJhg/tV26OYzzg4DE13CPnUQg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199021)(186006)(1800799006)(82310400008)(36840700001)(40470700004)(46966006)(40460700003)(356005)(426003)(2906002)(81166007)(336012)(2616005)(478600001)(86362001)(6666004)(54906003)(44832011)(316002)(5660300002)(1076003)(36860700001)(26005)(40480700001)(82740400003)(36756003)(8936002)(8676002)(41300700001)(47076005)(70206006)(70586007)(83380400001)(6916009)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 19:16:41.6796 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad574b3c-162a-48c2-5947-08db99d65435
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5927
Received-SPF: softfail client-ip=2a01:111:f400:7eae::601;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
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

Introduce a model of Xilinx Versal's Configuration Frame broadcast
controller (CFRAME_BCAST_REG).

Signed-off-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
 hw/misc/xlnx-versal-cframe-reg.c         | 161 +++++++++++++++++++++++
 include/hw/misc/xlnx-versal-cframe-reg.h |  17 +++
 2 files changed, 178 insertions(+)

diff --git a/hw/misc/xlnx-versal-cframe-reg.c b/hw/misc/xlnx-versal-cframe-reg.c
index 401bd7a4a9..686425756b 100644
--- a/hw/misc/xlnx-versal-cframe-reg.c
+++ b/hw/misc/xlnx-versal-cframe-reg.c
@@ -582,6 +582,83 @@ static const MemoryRegionOps cframe_reg_fdri_ops = {
     },
 };
 
+static uint64_t cframes_bcast_reg_read(void *opaque, hwaddr addr, unsigned size)
+{
+    qemu_log_mask(LOG_GUEST_ERROR, "%s: Unsupported read from addr=%"
+                  HWADDR_PRIx "\n", __func__, addr);
+    return 0;
+}
+
+static void cframes_bcast_write(XlnxVersalCFrameBcastReg *s, uint8_t reg_addr,
+                                uint32_t *wfifo)
+{
+    XlnxCfiPacket pkt = {
+        .reg_addr = reg_addr,
+        .data[0] = wfifo[0],
+        .data[1] = wfifo[1],
+        .data[2] = wfifo[2],
+        .data[3] = wfifo[3]
+    };
+
+    for (int i = 0; i < ARRAY_SIZE(s->cfg.cframe); i++) {
+        if (s->cfg.cframe[i]) {
+            xlnx_cfi_transfer_packet(s->cfg.cframe[i], &pkt);
+        }
+    }
+}
+
+static void cframes_bcast_reg_write(void *opaque, hwaddr addr, uint64_t value,
+                      unsigned size)
+{
+    XlnxVersalCFrameBcastReg *s = XLNX_VERSAL_CFRAME_BCAST_REG(opaque);
+    uint32_t wfifo[WFIFO_SZ];
+
+    if (update_wfifo(addr, value, s->wfifo, wfifo)) {
+        uint8_t reg_addr = extract32(addr, 4, 6);
+
+        cframes_bcast_write(s, reg_addr, wfifo);
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
+    uint32_t wfifo[WFIFO_SZ];
+
+    if (update_wfifo(addr, value, s->wfifo, wfifo)) {
+        cframes_bcast_write(s, CFRAME_FDRI, wfifo);
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
@@ -719,6 +796,71 @@ static Property cframe_regs_props[] = {
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
+static void cframe_bcast_reg_reset_enter(Object *obj, ResetType type)
+{
+    XlnxVersalCFrameBcastReg *s = XLNX_VERSAL_CFRAME_BCAST_REG(obj);
+
+    memset(s->wfifo, 0, WFIFO_SZ * sizeof(uint32_t));
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
@@ -733,6 +875,16 @@ static void cframe_reg_class_init(ObjectClass *klass, void *data)
     xcic->cfi_transfer_packet = cframe_reg_cfi_transfer_packet;
 }
 
+static void cframe_bcast_reg_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    dc->vmsd = &vmstate_cframe_bcast_reg;
+    device_class_set_props(dc, cframe_bcast_regs_props);
+    rc->phases.enter = cframe_bcast_reg_reset_enter;
+}
+
 static const TypeInfo cframe_reg_info = {
     .name          = TYPE_XLNX_VERSAL_CFRAME_REG,
     .parent        = TYPE_SYS_BUS_DEVICE,
@@ -745,9 +897,18 @@ static const TypeInfo cframe_reg_info = {
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
index 14a147781a..031a1f736b 100644
--- a/include/hw/misc/xlnx-versal-cframe-reg.h
+++ b/include/hw/misc/xlnx-versal-cframe-reg.h
@@ -26,6 +26,10 @@
 #define TYPE_XLNX_VERSAL_CFRAME_REG "xlnx,cframe-reg"
 OBJECT_DECLARE_SIMPLE_TYPE(XlnxVersalCFrameReg, XLNX_VERSAL_CFRAME_REG)
 
+#define TYPE_XLNX_VERSAL_CFRAME_BCAST_REG "xlnx.cframe-bcast-reg"
+OBJECT_DECLARE_SIMPLE_TYPE(XlnxVersalCFrameBcastReg,
+                           XLNX_VERSAL_CFRAME_BCAST_REG)
+
 /*
  * The registers in this module are 128 bits wide but it is ok to write
  * and read them through 4 sequential 32 bit accesses (address[3:2] = 0,
@@ -286,4 +290,17 @@ struct XlnxVersalCFrameReg {
     bool row_configured;
 };
 
+struct XlnxVersalCFrameBcastReg {
+    SysBusDevice parent_obj;
+    MemoryRegion iomem_reg;
+    MemoryRegion iomem_fdri;
+
+    /* 128-bit wfifo. */
+    uint32_t wfifo[WFIFO_SZ];
+
+    struct {
+        XlnxCfiIf *cframe[15];
+    } cfg;
+};
+
 #endif
-- 
2.34.1


