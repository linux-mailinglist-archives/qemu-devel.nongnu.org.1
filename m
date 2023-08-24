Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AD1787816
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 20:36:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZFAy-00072E-KM; Thu, 24 Aug 2023 14:35:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1qZFAv-00070C-0s
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 14:35:21 -0400
Received: from mail-bn1nam02on20608.outbound.protection.outlook.com
 ([2a01:111:f400:7eb2::608]
 helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1qZFAs-0007F3-8X
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 14:35:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LWCmXntg5jzyQkaKhGQVbfZMiFV6G+I9AAiNOvk0hKi5nzSLBkRlf8FV1DYIYwv97LVv3U7TzUCO5uS4wzLvApeM7FXxXYH7j5dMfbajKCGJDiDH3hLUVglboRABp/s0fOw1DyrMVAGfwZr1Rmq8mEkTZwuQmXOcGMIDzuM2OePXdztSP18l7umRV1fuojooMp37fExMIRwK89MKnyUzYOwNKRJ3b8Gkb6b92KmYViWPQZRX+Hl4zYj1oe/9p0SfLj221WSsoNO31S+V10srU7z8lW+n4BMXZMBnTnP6B+3SbsXmbQDxw1bTcms0uKehep8hLX0eOVg0u97czPec1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=flFS5KYN+WgkgEaGTlNnGjNFWjAc9ImxSRCOjPRlyqU=;
 b=S80Xo1Yq7+7FlgidtQ/RbiacBXsaiv5COPcMaaq0+3maPp/d1PEIziuYH956Zhqde8YZ+BoUQ3hUCZRTBmk0fOQIWu1+H0uKpBWI8S00fILWder+Ue1Xy3ASBo5q6dXppYJt12I/tuqXpYLWi8TuEVdhWTTOREF7TQ//sErUxpJBWzNohZ5E79fFFWNYzglTzCdZ4xp2jLHkTfNqNjDp+fZFW6XUgVbeMhTWshiqiACLY79x4V+LmdV4qpgTHOWDwYPFJO30+YxxYo0PKhGr4oM8IPTdgZsOli7NzCleXruEdbP31Zp49oyeCtQpjldFfrQAiv3Y1Hw8scEMT/2ZeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flFS5KYN+WgkgEaGTlNnGjNFWjAc9ImxSRCOjPRlyqU=;
 b=n7PzMkAnWsY+yc6Etc24V3ZUlaW2MDF3s9zBHJ5/JlchzqaEbkT1FVVlXP/6PGnKa1yaU7hft+AAXbCcvxz81OKpboJjavQezqQkj1BVaxIftoKR1B9nKJP6i7CaJ4clyyCZJcJf5l/KrSb78xZ0oxR7fk58S7Atsssma9oydvY=
Received: from CY5PR13CA0040.namprd13.prod.outlook.com (2603:10b6:930:11::15)
 by SN7PR12MB6813.namprd12.prod.outlook.com (2603:10b6:806:267::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 18:35:13 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:930:11:cafe::9c) by CY5PR13CA0040.outlook.office365.com
 (2603:10b6:930:11::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.15 via Frontend
 Transport; Thu, 24 Aug 2023 18:35:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Thu, 24 Aug 2023 18:35:12 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 13:35:03 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 11:35:03 -0700
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 24 Aug 2023 13:35:01 -0500
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: <qemu-devel@nongnu.org>
CC: <frasse.iglesias@gmail.com>, <alistair@alistair23.me>,
 <edgar.iglesias@gmail.com>, <peter.maydell@linaro.org>, <fkonrad@amd.com>,
 <sai.pavan.boddu@amd.com>, <tong.ho@amd.com>, <vikram.garhwal@amd.com>
Subject: [PATCH v3 6/8] hw/misc: Introduce a model of Xilinx Versal's
 CFRAME_BCAST_REG
Date: Thu, 24 Aug 2023 20:34:46 +0200
Message-ID: <20230824183448.151738-7-francisco.iglesias@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824183448.151738-1-francisco.iglesias@amd.com>
References: <20230824183448.151738-1-francisco.iglesias@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|SN7PR12MB6813:EE_
X-MS-Office365-Filtering-Correlation-Id: a9968dac-69f6-4963-b05e-08dba4d0da5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QIsck8OapsieFyk9yJvyasfl1b8D/hquiFyY7NncWipe+39z4HyE/ER+96pDb+LXIKl/D5eAj0p/iNhLwostJh1nlapi62lklBiqZCEIoofncTHMjqhZHWf6XwzVgfh72ZR/bNojxQit5na6iERhd4KJV1kGu0FNZcHQqfkSrxu4MjD4H+oZTwzVRxSsq10BHCnpKXjj5XgiDH18wGaAD9cilNSdDsyMp8RTCK29m25kHdCMzGjAZ1JDZlB1w1itygJv9SMFlik7E0lI3DBbtqJqdISOaX0S/5F3TM9qExVRA4CCyHbS8abXt+a1DEpNiQbipey9qrs6nb3OTy1Mizcm1Bm91GnDwZsv3aZrLOxva//vQsMzwRbWpCZf7fQ18YjImnoUdVI7XvMs7+snRCl8EC1rhSwePpezm5bxcD633c6nQuB3UX/EJP7G2lfAYOQm9dbOoRO7GiXZIQ0/lm4ndwWEiTRxTWDAyCWunfTZe7emXrCVY97KOHlaGt3+egHlDBGEhoNa405ARmeUT0teluz8EFE4I6R2nylVLBxNuQZ4W59voHedAYq8v5pO2OJjRLMLx9pHSjLTl5wsRmVc5R8Pjh/LwTaHhIBtUKaYE3LsgjZLezP1MN466pRjjfx3aGpe6MRGGk5JIvQXYBQUq4hPi3Jm3QONrBCSdb0w4VXilxooXjhrMDn8AWKGYWlCIfnH6mpqH0vaE/nk9UGpjKiU5Q7QWkuySHz08AmyuBH/Of/vL9tGPkEiMC8+4rXFArMoC87IboCBMoZL1w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(136003)(396003)(346002)(186009)(1800799009)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(54906003)(70206006)(70586007)(316002)(6916009)(81166007)(478600001)(40480700001)(26005)(6666004)(82740400003)(41300700001)(86362001)(2906002)(356005)(4326008)(8676002)(8936002)(83380400001)(2616005)(40460700003)(5660300002)(47076005)(44832011)(1076003)(426003)(336012)(36756003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 18:35:12.5245 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9968dac-69f6-4963-b05e-08dba4d0da5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6813
Received-SPF: softfail client-ip=2a01:111:f400:7eb2::608;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM02-BN1-obe.outbound.protection.outlook.com
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
index 4c9afb184d..2ce62c1b2e 100644
--- a/hw/misc/xlnx-versal-cframe-reg.c
+++ b/hw/misc/xlnx-versal-cframe-reg.c
@@ -557,6 +557,83 @@ static const MemoryRegionOps cframe_reg_fdri_ops = {
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
@@ -651,6 +728,71 @@ static Property cframe_regs_props[] = {
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
@@ -665,6 +807,16 @@ static void cframe_reg_class_init(ObjectClass *klass, void *data)
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
@@ -677,9 +829,18 @@ static const TypeInfo cframe_reg_info = {
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


