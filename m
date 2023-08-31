Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B8778F134
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 18:26:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbkUF-0004Bi-Bc; Thu, 31 Aug 2023 12:25:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1qbkU7-00049h-HQ
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 12:25:32 -0400
Received: from mail-bn8nam11on20601.outbound.protection.outlook.com
 ([2a01:111:f400:7eae::601]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1qbkU3-0004mP-Q3
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 12:25:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0BJQOj68FHJVVQS+1rMX7cOTcupWC3AGGIIqHspbog+Rlz6uiedfRr9hBRWLUPiCJKNey//FjmXE2Bd7KrWCylydi6vkNVbWrMU+BptpvllMWQUcOt5nlJlY5vpfzzdffYRCcjGFator5bWQVzLraSMSE4A4HvyzpeFxTPFf7/WILV/WheGLx5j/+rGZ32k8H2+qY1s76LwFOsEyAQsZABt0SGtqDw4E8pHjSnfHe4xZZlvu17QoSbWOR4jTeNsPtqVyl6qvCBuk8vWJ74+MUR6epTampYGQk+zgjxBzJszWxXg0KGAhLq8v3jUsrC5Z9yeqLc66TyR16uhwT8Hbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dP9DJgnfmyBqIQPky8kPymTuxPZxwsqnJY/SEnS5AJY=;
 b=kX/Q3Poz0ZE3Fn42XqU7Qtagkr8gDTd2v/aBR+Ys4wnakVdZLle3rud4iBHP8hIDF603qvhjkFEdM8ewCe+E8EL3ISxGkjSFQA178hbKZbYKIiey6/gJNuzP9QiNZJN0bWgoAXWFeY9djb0bI5JB2ZP+anu49hjy27Fk9dy5iIZwCe/CGtQlEYrF07GSyh9b7TMWoweP8VNSoCAbrTKi2qzXUKCc9ZXgHM0YfZH4Y0/ShtfquqHMNb+Bx8ZFgdp7ARECtdpH234RyJCrcXmNm+TZI2GudePja1RcKc0tguvwpk6YLA9qWk9lELaBSDnRZhUyH624LzTih5R40pQksQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dP9DJgnfmyBqIQPky8kPymTuxPZxwsqnJY/SEnS5AJY=;
 b=G5p2StD1Y4MynOftIccmtNAczrO6OlPCoKrDwU8w6YeCKZpeIdOFS+1dW6mBBdI4TCZdEzIOOixgAdqy84u0+W/V9xJZGECGKMOnj41SyzfSY3levAOyriAs7QgHJH0xRoEWAZzjyz8YsN/P6ADerBhEADEGcsWKwROCcaCf4YE=
Received: from MW4PR04CA0367.namprd04.prod.outlook.com (2603:10b6:303:81::12)
 by CH3PR12MB9249.namprd12.prod.outlook.com (2603:10b6:610:1bc::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Thu, 31 Aug
 2023 16:25:22 +0000
Received: from CO1PEPF000044F4.namprd05.prod.outlook.com
 (2603:10b6:303:81:cafe::a7) by MW4PR04CA0367.outlook.office365.com
 (2603:10b6:303:81::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.22 via Frontend
 Transport; Thu, 31 Aug 2023 16:25:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F4.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Thu, 31 Aug 2023 16:25:22 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 31 Aug
 2023 11:25:20 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 31 Aug
 2023 09:25:19 -0700
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 31 Aug 2023 11:25:18 -0500
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: <qemu-devel@nongnu.org>
CC: <frasse.iglesias@gmail.com>, <alistair@alistair23.me>,
 <edgar.iglesias@gmail.com>, <peter.maydell@linaro.org>, <fkonrad@amd.com>,
 <sai.pavan.boddu@amd.com>, <tong.ho@amd.com>, <vikram.garhwal@amd.com>
Subject: [PATCH v4 3/8] hw/misc/xlnx-versal-cfu: Introduce a model of Xilinx
 Versal CFU_FDRO
Date: Thu, 31 Aug 2023 18:25:00 +0200
Message-ID: <20230831162505.30399-4-francisco.iglesias@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831162505.30399-1-francisco.iglesias@amd.com>
References: <20230831162505.30399-1-francisco.iglesias@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F4:EE_|CH3PR12MB9249:EE_
X-MS-Office365-Filtering-Correlation-Id: ffcd1c00-f7ba-4573-cbd8-08dbaa3edfc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OXrBw07chFY4ZoZNjzuGY8+vEYvS+lgXEYerE3e/yHA5KO4EGQUTqchz/xN5rqJxiteWBck444g4TX8GOny3U26V9y/+n1Hl5xJlaqvUm6iWHGMKetlkYwSiCnjbzDx+Myw8+xuj+by0iL35/mqUvbeamOZCTd+zsUgK4EkWTCZ24frrlyDeWSjPWKR5FqfY3SvxOa29p7IKY0Ms2OODHlLrGE0EUBrjnxSCfz7rkjI8LDjZwbTqoYb/jmnxijGZjHC2bHgNo9VTbPOzEmBzGqkcOaQ7+w1a5KKF4xhaE8dj1yFmuhwGvabqa0RHFnxq0Jd5BUGomXy4fgAhSBQMSVxDPFIj5NBLof1x1nDaPYHIk6JBrpovEsubhNv+dvUxbx/JdrgoepbjYx1hxDnqB7VFFJnW7JuEOs9tHH43nOu50k4rhYduEdThETk/ShGZU0HOsuMJJfHi32u/mYrRN6gCimkLF0c/kYAPGF53gNlQK1EXgRAE0FT3SseAA6AacwDOljdj85lIydVkFkWkVLjI4RgOmcen6C2KuZr8WYQT5FDxI4GTkjgj7gL1+j4HhXmhvkEzpnFS5fWY0NshXPAdNTF8T+Blm142dDjiZTh47538pRA/D8HVO/MMc5je+Q1lRaj8MUfelJRraiIy9Cu6TM5gmibEoVUyS3pwT0uVb4asI2vo1OwNH+XHc2MKdyIlQyPirZoudqTCdU9XsuW74RUar/TxO3gfY0qn6VPUBsNXQiblaYpMGuYj9UjdgYsrBJRLWTY771aqUgGi1Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(39860400002)(376002)(396003)(186009)(82310400011)(1800799009)(451199024)(40470700004)(36840700001)(46966006)(41300700001)(40460700003)(356005)(6666004)(82740400003)(478600001)(2616005)(86362001)(47076005)(81166007)(83380400001)(36860700001)(426003)(336012)(1076003)(26005)(40480700001)(70206006)(36756003)(70586007)(316002)(54906003)(2906002)(6916009)(5660300002)(8676002)(8936002)(4326008)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 16:25:22.0470 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffcd1c00-f7ba-4573-cbd8-08dbaa3edfc5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9249
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


