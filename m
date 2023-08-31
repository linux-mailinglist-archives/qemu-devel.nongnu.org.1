Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C28678F14E
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 18:30:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbkY8-0000ic-8x; Thu, 31 Aug 2023 12:29:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1qbkY6-0000hS-Hk
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 12:29:38 -0400
Received: from mail-bn8nam04on20601.outbound.protection.outlook.com
 ([2a01:111:f400:7e8d::601]
 helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1qbkY3-0005Ze-0M
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 12:29:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lIWY4U9dDVSse21bb0mqny9+kFXygl6zWB0ASOVhrFggGkwI2exVY9kxQJArkldnPQrj7A5iiaEveUQHa6w6fjqV27G+z2Jvuw7bFIWklciZ8WUiHWhpuUvx3SLhViU+UFtMHEtrJUD4hlWmYSbN29vshUbmkr5qpBqBMjph04cQgdtGghORUnjXyKvzzo/UJSRZ4EabZk4DjNSHvd/uXW/d9UaIdcnvmEpUKTquoyRQVTvzDgwjuYcvhJ76Mup9WiF3pGGqTYGPQtRb74Wx0DkNfZzuLV9/Ikq63L0YR79lhSXOr/L5C2812YWvjWg9FnbAwYv8XcNHknnpXYH1Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PlmBUBFnHafoH3wKL40OSkcDUt6CIpWrhXuMNEfPU0U=;
 b=gaym0sSVClw0YbUT4KkwkLzEA7WVkS0DIGAQ1LAMNnfPlTJQDOARFJmiZ8HpCxOlwcEZMbEPK4xbwCyB/2ptXnEfkKUJ9/03+9gCwhgmAeNiYBCm1yXpCg/ckwYDjV1mT1Y/oql5fJPVMxoYvyOU5QLMp1i3rSEFbd3d/Qsjy2SFUr4BQyktcvt4dT5MIDTSQcX56P9mBQ5MRKEDA1r6JuKVxr0tLz6TiPzc4pNqAlaf6eea1eruPSOXTHIkSn7xQwG3WQmyNSA/K4Vu7GScw1/3jes33I8FX/86wRR4ZR0fBD8i3tJL1ZJu/GTSVM/xecnu8sXlfWHdSWyD2nrJmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PlmBUBFnHafoH3wKL40OSkcDUt6CIpWrhXuMNEfPU0U=;
 b=0Bihuk8o8LErdi0LfqyZcu2Vh2J7tqr6SOSsiTJNxZzuYlqOiuvbmW6JJf1aGmznwkkvPthppgMX+VQtCzRD+UAyvC6om72RCNk7aadczHrVYoiwQd+G3HZ29kPykhOLT6FDUNMnHcMr1jsUgt3oU5DdZ58+uO5UrZdLMxz1c64=
Received: from MW4PR04CA0298.namprd04.prod.outlook.com (2603:10b6:303:89::33)
 by DM4PR12MB5200.namprd12.prod.outlook.com (2603:10b6:5:397::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.22; Thu, 31 Aug
 2023 16:29:30 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:303:89:cafe::34) by MW4PR04CA0298.outlook.office365.com
 (2603:10b6:303:89::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21 via Frontend
 Transport; Thu, 31 Aug 2023 16:29:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.16 via Frontend Transport; Thu, 31 Aug 2023 16:29:30 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 31 Aug
 2023 11:29:29 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 31 Aug
 2023 11:29:28 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 31 Aug 2023 11:29:26 -0500
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: <qemu-devel@nongnu.org>
CC: <frasse.iglesias@gmail.com>, <alistair@alistair23.me>,
 <edgar.iglesias@gmail.com>, <peter.maydell@linaro.org>, <fkonrad@amd.com>,
 <sai.pavan.boddu@amd.com>, <tong.ho@amd.com>, <vikram.garhwal@amd.com>
Subject: [PATCH v4 6/8] hw/misc: Introduce a model of Xilinx Versal's
 CFRAME_BCAST_REG
Date: Thu, 31 Aug 2023 18:29:17 +0200
Message-ID: <20230831162919.30472-2-francisco.iglesias@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831162919.30472-1-francisco.iglesias@amd.com>
References: <20230831162919.30472-1-francisco.iglesias@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|DM4PR12MB5200:EE_
X-MS-Office365-Filtering-Correlation-Id: 722f6818-bf2f-426c-c3ee-08dbaa3f73a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l5Kra0RgOXWFrWtqtyyCJ4g8iZo1FDeEt+urG1HJC/oA9/KYupUmjLji6EUKroi2n4q2HryMp1CnAEwiIYl9D+giSg0JDUIshq5btDmB/nwji/9FQw0Krb5AMJKY4wYo1Po8ZYfi3IWVbAqofRSNORWBBZYLKy0Q+do5C8swUWteLBQahvpZvT1W4dNQ0dpZx5oKsKI62SSk71OKrSKBQAU856R0x+QtoFkcRCt0DFqEzdsSYjxpAKVtZo5FUt80L92ajC+3nbLbNkpUApNVKKZs44Z5vDJVfjyUAouKlUMXFYFwN/8znHDDTJSGRquZ4RhsN5L25aXAXkSg2bUCBivdNmJRLubqNOkZUQoHEZCXbHbusUj8m3fpUe6YzCR1a4MI71HaqzCWW8a04jsJAXYo9SwHlv9Sxe7lz1J1/UspKwzTRyQALCdcMFV2PCm7mhDIsw9kYjr5eNliKeH7adFUG5Lbjc4Opim1OvhyD/U0kpBzbKfC9WFyQ+jO0iy7cK3H6vv2fQnotzaEMfQGA0AVYmnIi2/N9zZpnDIlq7FwqXgyymDDzzcRVA0Pf4VZgDrPvz12/aLrmQsy/4tg72prHFcP+16dvR8+g06xckDPDlGj7EZmyrvSE8hZydrgMycLoI/BowNHeAsidfFiNTHC3Pa0KcQ8qb3EdGaLTZ81omvlKUgx84f9tij8w8Gm/Ig7zjqdT+nQzTt9ncClL1UhB0TJ6WA6nr4dNq3wJHQV1oUy9M7CZW1J5XHa9wy7jDvSCA9kfKtNgyaQz7Gx3A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(346002)(376002)(396003)(1800799009)(186009)(82310400011)(451199024)(46966006)(36840700001)(40470700004)(41300700001)(70586007)(70206006)(86362001)(40460700003)(2906002)(6916009)(54906003)(316002)(4326008)(8676002)(8936002)(2616005)(26005)(44832011)(1076003)(36756003)(5660300002)(426003)(336012)(40480700001)(83380400001)(81166007)(356005)(82740400003)(6666004)(36860700001)(478600001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 16:29:30.1137 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 722f6818-bf2f-426c-c3ee-08dbaa3f73a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5200
Received-SPF: softfail client-ip=2a01:111:f400:7e8d::601;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM04-BN8-obe.outbound.protection.outlook.com
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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/xlnx-versal-cframe-reg.c         | 161 +++++++++++++++++++++++
 include/hw/misc/xlnx-versal-cframe-reg.h |  17 +++
 2 files changed, 178 insertions(+)

diff --git a/hw/misc/xlnx-versal-cframe-reg.c b/hw/misc/xlnx-versal-cframe-reg.c
index 78db68f10c..8e8ec0715a 100644
--- a/hw/misc/xlnx-versal-cframe-reg.c
+++ b/hw/misc/xlnx-versal-cframe-reg.c
@@ -569,6 +569,83 @@ static const MemoryRegionOps cframe_reg_fdri_ops = {
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
@@ -663,6 +740,71 @@ static Property cframe_regs_props[] = {
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
@@ -677,6 +819,16 @@ static void cframe_reg_class_init(ObjectClass *klass, void *data)
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
@@ -689,9 +841,18 @@ static const TypeInfo cframe_reg_info = {
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
index f286d973bf..a14fbd7fe4 100644
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
@@ -283,4 +287,17 @@ struct XlnxVersalCFrameReg {
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


