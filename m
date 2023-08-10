Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E030B778134
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 21:17:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUB9k-0000YC-5i; Thu, 10 Aug 2023 15:17:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1qUB9J-0000Qo-C2
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 15:16:45 -0400
Received: from mail-co1nam11on20612.outbound.protection.outlook.com
 ([2a01:111:f400:7eab::612]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1qUB9H-00073r-8Z
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 15:16:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UsgAk+rHCbaYp74CuKJAE5tYvO5mjxp7Tkj60haR62frFMlIvKtrWQ9VJ/uAHMIB+lD7NK8fcCf/aNOuBAYXAtYLV8IE35Pk/R2XRJxKE+ZhsZE6zkSznpyKoxUiGUdxNnv+r+s2zMWvYvWkQNFjrGJsaZc1XpCCbX2T/wnsa1iCT/2tkYJ11UU3lFXNdKXJDfqUFISNtLcy5CZCLmOIY357szF9Adv/GpIX5sR7Kp1N9/atJFrtlm0Sv5Az98E40+bLoqWFpDjRV1L8/YfWWTaKNLqon6NDzOCl8YDKJm2KAA6rivrh8WxxTPMr2yYtu2u/+3qNuIlmfVuAwroHNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZcasW60vmhOq7+HXdSKb7ewHZ++h5DQIZBO+bvZKqdo=;
 b=RCS1JJFCZtoj7r163PMGTFx7dr9LP2lWDGAwdycR9LxnTLeEI0NaVUf+1HlgLXbjolPBZUsfzh65TK3fT6ahMCJjI1oDdjWO/u49smWWQvbsnToTUI8DgJwceRyzAgJd6f+VmKkldWqji99449q/dADZzO/QPadTh3nn6mQCM07co2SYVj9x4SBvHvZa70ZkJgMfpvB3ZZrTSmifKhdZFGnLcfopMFL3LIAUvE6LB9FG1us/DX+e3M9oYS/u1bTvsZRw6+f3cjJ+VJIVz5sULYJNSPNnKf2uq3E4BPqNkqPWHFdCeIO6dVCuTCIBRg7LqGTmzQR0YZMsd5YyFcuJkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZcasW60vmhOq7+HXdSKb7ewHZ++h5DQIZBO+bvZKqdo=;
 b=t6/UmIAflVDt3svts4gHLXX1EA07K1AiNn0xHzBqDYPCv9IoS1Cxywklan4XoXCNGU47eovOJtg6W9KTuuIQiNUWvuAaeFBtdDdcAsqEPHyrUu35ycgYENkgX6pDFG4G/cDyAhwQLk6mSujIfLul5sMR1zYimWaNbQMoqzaw3h4=
Received: from CYZPR11CA0021.namprd11.prod.outlook.com (2603:10b6:930:8d::17)
 by CH2PR12MB4230.namprd12.prod.outlook.com (2603:10b6:610:aa::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 19:16:38 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:930:8d:cafe::de) by CYZPR11CA0021.outlook.office365.com
 (2603:10b6:930:8d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30 via Frontend
 Transport; Thu, 10 Aug 2023 19:16:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Thu, 10 Aug 2023 19:16:37 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 14:16:37 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 14:16:36 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 10 Aug 2023 14:16:35 -0500
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: <qemu-devel@nongnu.org>
CC: <frasse.iglesias@gmail.com>, <alistair@alistair23.me>,
 <edgar.iglesias@gmail.com>, <peter.maydell@linaro.org>, <fkonrad@amd.com>,
 <sai.pavan.boddu@amd.com>, <tong.ho@amd.com>, <vikram.garhwal@amd.com>
Subject: [PATCH v2 4/8] hw/misc/xlnx-versal-cfu: Introduce a model of Xilinx
 Versal's CFU_SFR
Date: Thu, 10 Aug 2023 21:16:22 +0200
Message-ID: <20230810191626.81084-5-francisco.iglesias@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810191626.81084-1-francisco.iglesias@amd.com>
References: <20230810191626.81084-1-francisco.iglesias@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|CH2PR12MB4230:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e398650-80c9-4d8d-217f-08db99d651ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +5nKJg0CeW6n/+s90DWxcl6UKEAGLt+hxrik1YE7DPS4Ni5ZuScAA1asqZAjAwdHqLl0JEY8cGOyPPDKvR2qnagdG/z1KzukoYrdx/R9LqBuijXtJAFypPjtHf6mdWEIkuDl4q2rqiXCeM5//qn0JqndrxbNQqgZ76OEhwCOiGfWLLtizPXztCc7jxBMPXEsVBDlpKLtUOsQusiHEGdjRrIbd8cCMbnasgoPde5NepWGOaqwwrKqqCpnMOH2WHa0ZjhSILf7sM3Xt8cP5XIUXgDXyaca0VvGHuXF7wL9P/RRY5xGsE+3hiDrgy79FWj44deCTOWQbX4svJ+UHHiLitvhzyMk3GxWVLBzuKXQbpLdu8R5o0c0dukvG3na9RzhdeBly1Py/ZkoVo0652PPw6VTCc98NjS3dk1K69Wcg8ZYHpvmRRzS/sShzFy75lyWQ98JiqxYjpCBH2cMFqY0MFvzmGjZzdYRxf5iYyrHA3HGKNt/JFBY7U49jET1dG/nP0sR5M2FTi1Gfj8Wh60riosrJRusxlCWXLBEyRoXN9TnOJRQ0q6atNLCPeD+FBGVv0n06Y4xuS1PcPk37V802QaF+NZ66Y20prQ7H/gc9pYgvzddPvU16mNWmyEiigyIbxHeXjl7oM1QtkmeaJ3IvhGgU3EjWsXmLZn00S0XUC7Paz1a+X0dOWuciOys+N+jDGdjIg2X8SgqjwbZzg82auWGBbeswB7JcoFz93etIdf/CYvAdGNdoMuYVpub6hZikP1/IuKbwt8utw/txOL0cQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(136003)(346002)(39860400002)(186006)(82310400008)(1800799006)(451199021)(36840700001)(46966006)(40470700004)(426003)(1076003)(82740400003)(26005)(40460700003)(83380400001)(2906002)(36756003)(336012)(356005)(81166007)(40480700001)(54906003)(2616005)(36860700001)(44832011)(6666004)(5660300002)(316002)(478600001)(8936002)(8676002)(41300700001)(86362001)(6916009)(4326008)(70586007)(70206006)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 19:16:37.8509 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e398650-80c9-4d8d-217f-08db99d651ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4230
Received-SPF: softfail client-ip=2a01:111:f400:7eab::612;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
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

Introduce a model of Xilinx Versal's Configuration Frame Unit's Single
Frame Read port (CFU_SFR).

Signed-off-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
 hw/misc/xlnx-versal-cfu.c         | 87 +++++++++++++++++++++++++++++++
 include/hw/misc/xlnx-versal-cfu.h | 15 ++++++
 2 files changed, 102 insertions(+)

diff --git a/hw/misc/xlnx-versal-cfu.c b/hw/misc/xlnx-versal-cfu.c
index 255c1bf4b8..8e588ac1d8 100644
--- a/hw/misc/xlnx-versal-cfu.c
+++ b/hw/misc/xlnx-versal-cfu.c
@@ -264,6 +264,31 @@ static void cfu_stream_write(void *opaque, hwaddr addr, uint64_t value,
     }
 }
 
+static uint64_t cfu_sfr_read(void *opaque, hwaddr addr, unsigned size)
+{
+    qemu_log_mask(LOG_GUEST_ERROR, "%s: Unsupported read from addr=%"
+                  HWADDR_PRIx "\n", __func__, addr);
+    return 0;
+}
+
+static void cfu_sfr_write(void *opaque, hwaddr addr, uint64_t value,
+                      unsigned size)
+{
+    XlnxVersalCFUSFR *s = XLNX_VERSAL_CFU_SFR(opaque);
+    uint32_t wfifo[WFIFO_SZ];
+
+    if (update_wfifo(addr, value, s->wfifo, wfifo)) {
+        uint8_t row_addr = extract32(wfifo[0], 23, 5);
+        uint32_t frame_addr = extract32(wfifo[0], 0, 23);
+        XlnxCfiPacket pkt = { .reg_addr = CFRAME_SFR,
+                              .data[0] = frame_addr };
+
+        if (s->cfg.cfu) {
+            cfu_transfer_cfi_packet(s->cfg.cfu, row_addr, &pkt);
+        }
+    }
+}
+
 static uint64_t cfu_fdro_read(void *opaque, hwaddr addr, unsigned size)
 {
     XlnxVersalCFUFDRO *s = XLNX_VERSAL_CFU_FDRO(opaque);
@@ -293,6 +318,16 @@ static const MemoryRegionOps cfu_stream_ops = {
     },
 };
 
+static const MemoryRegionOps cfu_sfr_ops = {
+    .read = cfu_sfr_read,
+    .write = cfu_sfr_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
 static const MemoryRegionOps cfu_fdro_ops = {
     .read = cfu_fdro_read,
     .write = cfu_fdro_write,
@@ -334,6 +369,23 @@ static void cfu_apb_init(Object *obj)
     sysbus_init_irq(sbd, &s->irq_cfu_imr);
 }
 
+static void cfu_sfr_init(Object *obj)
+{
+    XlnxVersalCFUSFR *s = XLNX_VERSAL_CFU_SFR(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+
+    memory_region_init_io(&s->iomem_sfr, obj, &cfu_sfr_ops, s,
+                          TYPE_XLNX_VERSAL_CFU_SFR, KEYHOLE_STREAM_4K);
+    sysbus_init_mmio(sbd, &s->iomem_sfr);
+}
+
+static void cfu_sfr_reset_enter(Object *obj, ResetType type)
+{
+    XlnxVersalCFUSFR *s = XLNX_VERSAL_CFU_SFR(obj);
+
+    memset(s->wfifo, 0, WFIFO_SZ * sizeof(uint32_t));
+}
+
 static void cfu_fdro_init(Object *obj)
 {
     XlnxVersalCFUFDRO *s = XLNX_VERSAL_CFU_FDRO(obj);
@@ -401,6 +453,12 @@ static Property cfu_props[] = {
         DEFINE_PROP_END_OF_LIST(),
 };
 
+static Property cfu_sfr_props[] = {
+        DEFINE_PROP_LINK("cfu", XlnxVersalCFUSFR, cfg.cfu,
+                         TYPE_XLNX_VERSAL_CFU_APB, XlnxVersalCFUAPB *),
+        DEFINE_PROP_END_OF_LIST(),
+};
+
 static const VMStateDescription vmstate_cfu_apb = {
     .name = TYPE_XLNX_VERSAL_CFU_APB,
     .version_id = 1,
@@ -423,6 +481,16 @@ static const VMStateDescription vmstate_cfu_fdro = {
     }
 };
 
+static const VMStateDescription vmstate_cfu_sfr = {
+    .name = TYPE_XLNX_VERSAL_CFU_SFR,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(wfifo, XlnxVersalCFUSFR, 4),
+        VMSTATE_END_OF_LIST(),
+    }
+};
+
 static void cfu_apb_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -443,6 +511,16 @@ static void cfu_fdro_class_init(ObjectClass *klass, void *data)
     rc->phases.enter = cfu_fdro_reset_enter;
 }
 
+static void cfu_sfr_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    device_class_set_props(dc, cfu_sfr_props);
+    dc->vmsd = &vmstate_cfu_sfr;
+    rc->phases.enter = cfu_sfr_reset_enter;
+}
+
 static const TypeInfo cfu_apb_info = {
     .name          = TYPE_XLNX_VERSAL_CFU_APB,
     .parent        = TYPE_SYS_BUS_DEVICE,
@@ -467,10 +545,19 @@ static const TypeInfo cfu_fdro_info = {
     }
 };
 
+static const TypeInfo cfu_sfr_info = {
+    .name          = TYPE_XLNX_VERSAL_CFU_SFR,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(XlnxVersalCFUSFR),
+    .class_init    = cfu_sfr_class_init,
+    .instance_init = cfu_sfr_init,
+};
+
 static void cfu_apb_register_types(void)
 {
     type_register_static(&cfu_apb_info);
     type_register_static(&cfu_fdro_info);
+    type_register_static(&cfu_sfr_info);
 }
 
 type_init(cfu_apb_register_types)
diff --git a/include/hw/misc/xlnx-versal-cfu.h b/include/hw/misc/xlnx-versal-cfu.h
index 73e9a21af4..86fb841053 100644
--- a/include/hw/misc/xlnx-versal-cfu.h
+++ b/include/hw/misc/xlnx-versal-cfu.h
@@ -28,6 +28,9 @@ OBJECT_DECLARE_SIMPLE_TYPE(XlnxVersalCFUAPB, XLNX_VERSAL_CFU_APB)
 #define TYPE_XLNX_VERSAL_CFU_FDRO "xlnx,versal-cfu-fdro"
 OBJECT_DECLARE_SIMPLE_TYPE(XlnxVersalCFUFDRO, XLNX_VERSAL_CFU_FDRO)
 
+#define TYPE_XLNX_VERSAL_CFU_SFR "xlnx,versal-cfu-sfr"
+OBJECT_DECLARE_SIMPLE_TYPE(XlnxVersalCFUSFR, XLNX_VERSAL_CFU_SFR)
+
 REG32(CFU_ISR, 0x0)
     FIELD(CFU_ISR, USR_GTS_EVENT, 9, 1)
     FIELD(CFU_ISR, USR_GSR_EVENT, 8, 1)
@@ -222,6 +225,18 @@ struct XlnxVersalCFUFDRO {
     Fifo32 fdro_data;
 };
 
+struct XlnxVersalCFUSFR {
+    SysBusDevice parent_obj;
+    MemoryRegion iomem_sfr;
+
+    /* 128-bit wfifo. */
+    uint32_t wfifo[WFIFO_SZ];
+
+    struct {
+        XlnxVersalCFUAPB *cfu;
+    } cfg;
+};
+
 /**
  * This is a helper function for updating a CFI data write fifo, an array of 4
  * uint32_t and 128 bits of data that are allowed to be written through 4
-- 
2.34.1


