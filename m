Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB0478F18C
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 18:57:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbkz9-0001CV-GS; Thu, 31 Aug 2023 12:57:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1qbkys-0001Bv-Ho
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 12:57:18 -0400
Received: from mail-mw2nam12on20622.outbound.protection.outlook.com
 ([2a01:111:f400:fe5a::622]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1qbkyp-0003cF-RV
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 12:57:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8INyjp74dCFd7ekIr0kiPC++qKoinctxU3cDKAAmjQDQPfdjAWF1vgloJrNpEEcfO/lb7mHdY/1uBrVYrr8YVxOht9HZ+Zz7s4mp8HPiHWqyQw7QwOZLWHrrSqtkUT3vqlq4N9bI/HOURh5meYEgZ78Ub0wTfE+PPWKwm3EG6HLg1Pu1YAhEiDjPkTM/s8ol0MzcoZapJlnzJLeX8tAAwQve/gDTfRlHWlYoDDEXzGgXzEiwpm1YiIizGiKg8i9/EgfsP08wlgk9ZcMlL027ikUh4XpWNk2zfSuy9Yvo6AW9yf0npzrO/ZuOW/FPiArvXnuJX1Bt5WLIv6k0P7kmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dP9DJgnfmyBqIQPky8kPymTuxPZxwsqnJY/SEnS5AJY=;
 b=Qx5fInMhQd9GHypkT4L93nXBWjN03p5i5AqU2ZJnUUVCvBSy3cHv1/nQbndxtgn2bRR58In4O052/8IMW9V94NEDBFrHMmCp09deQHG6KwAV+6DkeFX22WSLzaa5M60KFZ/UaBUFkPAbROSeDKuX6n/H6gFD7Dck3cKBR6Ai78DuUXU4Fqis038IQEI0RR0rrVyhrRqnE2NTvAtEag9MDZ9iShp8BY4wrUI5q3cPDXq13S7fKwZj9TjESxdEw+f6an2CtOz3Y6UuSJd2pHWAGTR3fsFdIwizRQkMF2TUK4Y+XD4DvPY7ZGqiofPQ6N20nNZfiePnE43h3I5j7ES5EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dP9DJgnfmyBqIQPky8kPymTuxPZxwsqnJY/SEnS5AJY=;
 b=A5gm1qnj/8aFeDvFw7LoCasEti3f31JlURGm9q/6p/ThsMTnMeOmqk06Y2HGaq9/e0ENfqx9ZU6iQgvQgq8d1G72mNzwet8OXGcKQpXL8UIBPbCNkVkJHUAY4JGRTqs75rjqZbAk7hOKcGXhtNEMJ5qxDwQlyPCCnGKKmQwlieo=
Received: from CY5PR16CA0018.namprd16.prod.outlook.com (2603:10b6:930:10::19)
 by BN9PR12MB5083.namprd12.prod.outlook.com (2603:10b6:408:134::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21; Thu, 31 Aug
 2023 16:57:11 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:930:10:cafe::ee) by CY5PR16CA0018.outlook.office365.com
 (2603:10b6:930:10::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18 via Frontend
 Transport; Thu, 31 Aug 2023 16:57:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Thu, 31 Aug 2023 16:57:08 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 31 Aug
 2023 11:57:07 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 31 Aug
 2023 11:57:06 -0500
Received: from xdcsswbld02.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 31 Aug 2023 11:57:06 -0500
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: <qemu-devel@nongnu.org>
CC: <frasse.iglesias@gmail.com>, <alistair@alistair23.me>,
 <edgar.iglesias@gmail.com>, <peter.maydell@linaro.org>, <fkonrad@amd.com>,
 <sai.pavan.boddu@amd.com>, <tong.ho@amd.com>, <vikram.garhwal@amd.com>
Subject: [PATCH v5 3/8] hw/misc/xlnx-versal-cfu: Introduce a model of Xilinx
 Versal CFU_FDRO
Date: Thu, 31 Aug 2023 17:56:56 +0100
Message-ID: <20230831165701.2016397-4-francisco.iglesias@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230831165701.2016397-1-francisco.iglesias@amd.com>
References: <20230831165701.2016397-1-francisco.iglesias@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|BN9PR12MB5083:EE_
X-MS-Office365-Filtering-Correlation-Id: bb5cd913-9e8f-47aa-c9b1-08dbaa434fe5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6C0K9ptlQFjyt3ZXhNMf05oGXg7vKUr89gRSiqKOwpwfw2u5I3xSojTsgMpKvt5WaqzFNLcFqq1v7eDIYya4ot8307OtpF8ObcMGikes4JrUO4a+GvdCEEGoXsf3JHgg41hspfyqxJe/dP3ZWB+IRL7XPaSyDxKaJRIUmYxRN5t66KT0/iRnxsrsMceYaFbjkDgjoHS6UPebzf83iXPvMQq9Pl/RR7rRU+9zE1Dj2yinC7NYkEfhCAYG/pAYI3tMxq/loX30oJgOwfWqUvgjBO5+zOG6jvY37LPFVPJMQoiuElA+vYyhEfSuGToAbLF/K3Q259MgB97w1NWGO9Rh5QQx/en9tnentj8nGirhdbfYMIVScSHFv/xxYXXY4bhht+rXK2GMH5S55ul3MASS5H/s3lalv4QvuxeaTi93yyxR8Cc3AcycM8UbhhmP9pCBwhAJOXrnUmzRNSOppo6iZAi1hX8+ctlx/w5LPXN/QWCtqhAvrRRclw/4c8J2sGVBRbHp6A9sK0ODhLvOtyc9YaovmwThYYNDMAU8RBB984bw8WP6ILTa7BTR1jGdpLCRXNXUEM1ZcVr4u5Qqfou+pewZQDvHMm4rwon1Cm/24U6K1x+g0xo0Fw6jL7wUu4nREQ/MnhWtiYdsOglqdDjJgGBnBBfs2Q5RhPFjri5nye31hXZ5gTkrI+4Tp7XS3EPARgyPuZH5I0nQvFWK/AEAPpKMxeWe708Sqeg6TA5zXU8tlSaeDqENpQrEsiWsrZ8J8LGixCnMHf9BPvGoHftiMg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(376002)(346002)(39860400002)(1800799009)(82310400011)(451199024)(186009)(46966006)(40470700004)(36840700001)(82740400003)(6666004)(356005)(40460700003)(36756003)(86362001)(40480700001)(47076005)(36860700001)(81166007)(2906002)(2616005)(26005)(336012)(83380400001)(478600001)(70206006)(70586007)(8676002)(4326008)(426003)(5660300002)(8936002)(41300700001)(54906003)(44832011)(6916009)(316002)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 16:57:08.2109 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb5cd913-9e8f-47aa-c9b1-08dbaa434fe5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5083
Received-SPF: softfail client-ip=2a01:111:f400:fe5a::622;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
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

Introduce a model of Xilinx Versal's Configuration Frame Unit's data out
port (CFU_FDRO).

Signed-off-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/xlnx-versal-cfu.c         | 96 +++++++++++++++++++++++++++++++
 include/hw/misc/xlnx-versal-cfu.h | 12 ++++
 2 files changed, 108 insertions(+)

diff --git a/hw/misc/xlnx-versal-cfu.c b/hw/misc/xlnx-versal-cfu.c
index b2dc6ab211..255c1bf4b8 100644
--- a/hw/misc/xlnx-versal-cfu.c
+++ b/hw/misc/xlnx-versal-cfu.c
@@ -264,6 +264,25 @@ static void cfu_stream_write(void *opaque, hwaddr addr, uint64_t value,
     }
 }
 
+static uint64_t cfu_fdro_read(void *opaque, hwaddr addr, unsigned size)
+{
+    XlnxVersalCFUFDRO *s = XLNX_VERSAL_CFU_FDRO(opaque);
+    uint64_t ret = 0;
+
+    if (!fifo32_is_empty(&s->fdro_data)) {
+        ret = fifo32_pop(&s->fdro_data);
+    }
+
+    return ret;
+}
+
+static void cfu_fdro_write(void *opaque, hwaddr addr, uint64_t value,
+                           unsigned size)
+{
+    qemu_log_mask(LOG_GUEST_ERROR, "%s: Unsupported write from addr=%"
+                  HWADDR_PRIx "\n", __func__, addr);
+}
+
 static const MemoryRegionOps cfu_stream_ops = {
     .read = cfu_stream_read,
     .write = cfu_stream_write,
@@ -274,6 +293,16 @@ static const MemoryRegionOps cfu_stream_ops = {
     },
 };
 
+static const MemoryRegionOps cfu_fdro_ops = {
+    .read = cfu_fdro_read,
+    .write = cfu_fdro_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
 static void cfu_apb_init(Object *obj)
 {
     XlnxVersalCFUAPB *s = XLNX_VERSAL_CFU_APB(obj);
@@ -305,6 +334,39 @@ static void cfu_apb_init(Object *obj)
     sysbus_init_irq(sbd, &s->irq_cfu_imr);
 }
 
+static void cfu_fdro_init(Object *obj)
+{
+    XlnxVersalCFUFDRO *s = XLNX_VERSAL_CFU_FDRO(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+
+    memory_region_init_io(&s->iomem_fdro, obj, &cfu_fdro_ops, s,
+                          TYPE_XLNX_VERSAL_CFU_FDRO, KEYHOLE_STREAM_4K);
+    sysbus_init_mmio(sbd, &s->iomem_fdro);
+    fifo32_create(&s->fdro_data, 8 * KiB / sizeof(uint32_t));
+}
+
+static void cfu_fdro_reset_enter(Object *obj, ResetType type)
+{
+    XlnxVersalCFUFDRO *s = XLNX_VERSAL_CFU_FDRO(obj);
+
+    fifo32_reset(&s->fdro_data);
+}
+
+static void cfu_fdro_cfi_transfer_packet(XlnxCfiIf *cfi_if, XlnxCfiPacket *pkt)
+{
+    XlnxVersalCFUFDRO *s = XLNX_VERSAL_CFU_FDRO(cfi_if);
+
+    if (fifo32_num_free(&s->fdro_data) >= ARRAY_SIZE(pkt->data)) {
+        for (int i = 0; i < ARRAY_SIZE(pkt->data); i++) {
+            fifo32_push(&s->fdro_data, pkt->data[i]);
+        }
+    } else {
+        /* It is a programming error to fill the fifo. */
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "CFU_FDRO: CFI data dropped due to full read fifo\n");
+    }
+}
+
 static Property cfu_props[] = {
         DEFINE_PROP_LINK("cframe0", XlnxVersalCFUAPB, cfg.cframe[0],
                          TYPE_XLNX_CFI_IF, XlnxCfiIf *),
@@ -351,6 +413,16 @@ static const VMStateDescription vmstate_cfu_apb = {
     }
 };
 
+static const VMStateDescription vmstate_cfu_fdro = {
+    .name = TYPE_XLNX_VERSAL_CFU_FDRO,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_FIFO32(fdro_data, XlnxVersalCFUFDRO),
+        VMSTATE_END_OF_LIST(),
+    }
+};
+
 static void cfu_apb_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -360,6 +432,17 @@ static void cfu_apb_class_init(ObjectClass *klass, void *data)
     device_class_set_props(dc, cfu_props);
 }
 
+static void cfu_fdro_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+    XlnxCfiIfClass *xcic = XLNX_CFI_IF_CLASS(klass);
+
+    dc->vmsd = &vmstate_cfu_fdro;
+    xcic->cfi_transfer_packet = cfu_fdro_cfi_transfer_packet;
+    rc->phases.enter = cfu_fdro_reset_enter;
+}
+
 static const TypeInfo cfu_apb_info = {
     .name          = TYPE_XLNX_VERSAL_CFU_APB,
     .parent        = TYPE_SYS_BUS_DEVICE,
@@ -372,9 +455,22 @@ static const TypeInfo cfu_apb_info = {
     }
 };
 
+static const TypeInfo cfu_fdro_info = {
+    .name          = TYPE_XLNX_VERSAL_CFU_FDRO,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(XlnxVersalCFUFDRO),
+    .class_init    = cfu_fdro_class_init,
+    .instance_init = cfu_fdro_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_XLNX_CFI_IF },
+        { }
+    }
+};
+
 static void cfu_apb_register_types(void)
 {
     type_register_static(&cfu_apb_info);
+    type_register_static(&cfu_fdro_info);
 }
 
 type_init(cfu_apb_register_types)
diff --git a/include/hw/misc/xlnx-versal-cfu.h b/include/hw/misc/xlnx-versal-cfu.h
index 62d10caf27..73e9a21af4 100644
--- a/include/hw/misc/xlnx-versal-cfu.h
+++ b/include/hw/misc/xlnx-versal-cfu.h
@@ -20,10 +20,14 @@
 #include "hw/sysbus.h"
 #include "hw/register.h"
 #include "hw/misc/xlnx-cfi-if.h"
+#include "qemu/fifo32.h"
 
 #define TYPE_XLNX_VERSAL_CFU_APB "xlnx,versal-cfu-apb"
 OBJECT_DECLARE_SIMPLE_TYPE(XlnxVersalCFUAPB, XLNX_VERSAL_CFU_APB)
 
+#define TYPE_XLNX_VERSAL_CFU_FDRO "xlnx,versal-cfu-fdro"
+OBJECT_DECLARE_SIMPLE_TYPE(XlnxVersalCFUFDRO, XLNX_VERSAL_CFU_FDRO)
+
 REG32(CFU_ISR, 0x0)
     FIELD(CFU_ISR, USR_GTS_EVENT, 9, 1)
     FIELD(CFU_ISR, USR_GSR_EVENT, 8, 1)
@@ -210,6 +214,14 @@ struct XlnxVersalCFUAPB {
     } cfg;
 };
 
+
+struct XlnxVersalCFUFDRO {
+    SysBusDevice parent_obj;
+    MemoryRegion iomem_fdro;
+
+    Fifo32 fdro_data;
+};
+
 /**
  * This is a helper function for updating a CFI data write fifo, an array of 4
  * uint32_t and 128 bits of data that are allowed to be written through 4
-- 
2.34.1


