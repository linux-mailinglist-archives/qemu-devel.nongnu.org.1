Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B5F78F195
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 18:58:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbkzE-0001cA-95; Thu, 31 Aug 2023 12:57:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1qbkyt-0001CQ-TI
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 12:57:21 -0400
Received: from mail-dm6nam10on2062e.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::62e]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1qbkyr-0003cy-0k
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 12:57:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MFNqZAv2WJVDPUUqhNPu0xBGRojD8cynKBjC2GnGa7840FjPA1/QS9WMvfLjGfPyoDuwn7eGkpDXVutkoRuz+h6cS6pqLDqOYqFtwaHcgIYkyy+S4HFiLS7VxPKMgBLbA88B4RL5TzpHu5lMn6l6OI6t5o64onzqlKjspZbcBM+ZyHGgXv3h/EHNXfHGRd7L6t8jVdHwfWa8Xc6PyFUHv5TOj2A+K3GUTdl21NQNhNL/hmLkpe/ELMQFw+lhFprnLe/v8shBk++oZXvasBB4VJEw4C9VGaW9kasl/G4XSWiG+/5BwPPOxAi614jD8kQJzgxgNkSB8qE1VX9l0Iqa+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L3K6zjYWsy6eN46xdaD2mGatwHnrAxG/IEIeslaDOLA=;
 b=H0qZyPYB9S8N61iYCd7fAeM8QUX/9paZjGzLQB1s6aofVriT2j4T6yiqLWxOGJwzS3nTxEoGcCa4DMnhy8eKNPxlSlDLg/oDziExMNu3F3YYPPqhOkoBuFKcQvQfx8+T37IU+CByLUpSpORxT0UQYu0e4wZlY2wzCQIrVrl2NpADwo9xMi2WR+0sKxM6yvMMmuU+AxJbjtFJ+hRudw9leu7qOsn+WMGV4BZaCJLo8YM+0VERXVCzhlQ1pllSxKgtfb3CtufGFtnq9NLUZLL11dWxFTwB4RjCyVsZL/PAee41iYUfGdX0nYOBKStwO/S4dB43luBKxsz6msWDFImosA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L3K6zjYWsy6eN46xdaD2mGatwHnrAxG/IEIeslaDOLA=;
 b=V69FcZOPD/CVy/s4oajwfj2MPQE/Nn/43T51BjWDBobiWjCYYCn1QPKAMZ4/B4w7oJGsN5PV/fI1ezLo8qbPxwDH1Wi8k5ovOc+ZrwEyC0ahQEZ9pqUctY7gYvPbmUt5AXI4QN+BOdQMLnwgh2Bg3qowzY9eZp5Fckgyb96sikc=
Received: from CY5PR16CA0030.namprd16.prod.outlook.com (2603:10b6:930:10::15)
 by DM4PR12MB6328.namprd12.prod.outlook.com (2603:10b6:8:a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.22; Thu, 31 Aug
 2023 16:57:12 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:930:10:cafe::ac) by CY5PR16CA0030.outlook.office365.com
 (2603:10b6:930:10::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20 via Frontend
 Transport; Thu, 31 Aug 2023 16:57:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Thu, 31 Aug 2023 16:57:12 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 31 Aug
 2023 11:57:09 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 31 Aug
 2023 09:57:08 -0700
Received: from xdcsswbld02.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 31 Aug 2023 11:57:07 -0500
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: <qemu-devel@nongnu.org>
CC: <frasse.iglesias@gmail.com>, <alistair@alistair23.me>,
 <edgar.iglesias@gmail.com>, <peter.maydell@linaro.org>, <fkonrad@amd.com>,
 <sai.pavan.boddu@amd.com>, <tong.ho@amd.com>, <vikram.garhwal@amd.com>
Subject: [PATCH v5 4/8] hw/misc/xlnx-versal-cfu: Introduce a model of Xilinx
 Versal's CFU_SFR
Date: Thu, 31 Aug 2023 17:56:57 +0100
Message-ID: <20230831165701.2016397-5-francisco.iglesias@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230831165701.2016397-1-francisco.iglesias@amd.com>
References: <20230831165701.2016397-1-francisco.iglesias@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|DM4PR12MB6328:EE_
X-MS-Office365-Filtering-Correlation-Id: 9465cef8-baf7-4a6e-3708-08dbaa43525b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wl/Intyi0/ySgu4oa10tvtTYAZ7rr969cCXqbJ1I07bgjZnR/gPbuily2gRoxsULVtUas/QGdCcWVURLC4FrOd2uCL5DgeMGugQs3f8N4Lmk8THCbG0xWgQusbrsAXAtRBV1xMkx802KBoWvcJfXj4ekuR401adnhXj9aCz9LEl4+uUW2UfCBzidaOtEOKlM3TyGHAebJLP/q5jH0Yg4g37mPVgRZFKro5Y3FfyL26Ubj3pMXukLgQ9V1dSOaghU4oq4QDTqtv7BuOf4EVJf4E6N84jUBM1SJuXBGyEqZCKIYsqQSwKycQbljTMLG7nLxBql46jyeRczM0keJb2zGj/NmHWqMG2cz9E6+PrySBY0I9T5VMzP4WsAXxPgATXLIUEzKPYh6hJ8f367AChlwv6cGTKCI/5IKBIqF3pDjG+eQZK6Oq3JqSyBcf79N4HVZ2Hm0jHz8twIRhMkG8WSZXcH/3CFMsv58gm7R0VwZ0EK9GLj3AFlm50WqnEyHkEg4VaJcYzIUIiN+aW8feIxu4+MOUWMff+ViG/NnjBoz124Zo06UXftBbPHcv1Qnxa7kZbuwCThT5qmqu5w7gUNL3JoTLOZttMdEIcdOciv1s/Ay1/EBTKf2FXaKWPPH9R+ttWEhYJ2StJwFFCPc6dM5BpC11qlGYAHsja0UMK37evB96UiNBvAxEAuwjy9p5D89/15gdFr7bbcD3e1xMsLgy+Oq/OmD2yTwZa5uZImHNtjzisMG0/dNxYcFB9vF7YPpxc+/Bd/7T2Dmm6bFVIQWQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(136003)(396003)(39860400002)(82310400011)(186009)(1800799009)(451199024)(36840700001)(40470700004)(46966006)(40480700001)(82740400003)(36756003)(41300700001)(336012)(426003)(1076003)(40460700003)(26005)(356005)(83380400001)(70586007)(70206006)(54906003)(81166007)(316002)(6916009)(478600001)(6666004)(2906002)(86362001)(5660300002)(44832011)(8936002)(2616005)(8676002)(36860700001)(47076005)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 16:57:12.3359 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9465cef8-baf7-4a6e-3708-08dbaa43525b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6328
Received-SPF: softfail client-ip=2a01:111:f400:7e88::62e;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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


