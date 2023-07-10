Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBFD74D86F
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 16:05:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIrU3-0000iL-2Y; Mon, 10 Jul 2023 10:03:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1qIrTt-0000hX-LO
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 10:03:13 -0400
Received: from mail-bn8nam11on20601.outbound.protection.outlook.com
 ([2a01:111:f400:7eae::601]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1qIrTr-0003IB-I7
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 10:03:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CT9MIUkt51e1Ag9FLp2r+ECjQrdMR4LEatQnJYTGMFkWPiefjlrEd6ScR/Fv7CRfdVvm+NXdx0gj4kjQFAZutWGxSDa/9MZo7Aj44n/LCzChJrs2u+whyXrTf0yoGgiNS5rNnWW1ImsWsOxnoxvc/fUxo/9levxQ9rjxeHLfAUxkjKAZc0agqVrEMbfwf8/AowPbzf0IU6BongZZoixWEtLPbht9+9O+CjJOYiMTtm1+PxnPlmTrEjzrx8PI7XNhO9rCDEzkclJXrtb2LKXhKt50tZDprUXKzqUBihCSNzo7sws84JQl89LLKzIp7ovkobs246QEmYnsplxKrPhIgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GaETbK5lq84DdK/cCHzssi+83dj8mWxnOyj6MFGGY+w=;
 b=WBKJNRCIWXMhnm0An/j3d03YdQyIov1Zt4Zj0dCCiSXRRfyG7qZ6ibJHHJYZTIVi6niwKjiYteItqgl1eKOQUj5aNlBFevMhEIbEHGdFLNAb/VvPeJsawQhJVW3giBkQwudVinYliXFzIUwW3AKxspPMZK3t9kWJrh7xQcZybxRKfzZ0tK3bxcNEOJiBlZhhurjDMkROnbdPpeguA4l/tR+/PyY2GeaLJ7LN9pwGlsdKRX0sURXDwvfx2gf5lWtHKgtt4DgrAec7OQ2fYanptQ4lt/4/IP2ubYcGOl01/HpQlI3WHd2YD4gbdiyLXmuOuGIe1HudzxgNDEGRg7cBVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GaETbK5lq84DdK/cCHzssi+83dj8mWxnOyj6MFGGY+w=;
 b=OS27v4XZ3UhSHuGbh9M6nhD6Op4rStauZysLjeHGpMyKgqKcpqRrwdVANMt9ar9clPXWMsTUO6jxhcYPw5d4mAkQIqmkptQ6JUPgXQwlBJs6cg7AxpVIyKXDH8dmT4X1ay6PpPNJGP6T0gIMX5ZnydfM4dmWcg2v9ra4MjALy90=
Received: from SJ0PR03CA0192.namprd03.prod.outlook.com (2603:10b6:a03:2ef::17)
 by MW3PR12MB4459.namprd12.prod.outlook.com (2603:10b6:303:56::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 14:03:02 +0000
Received: from DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:2ef:cafe::3b) by SJ0PR03CA0192.outlook.office365.com
 (2603:10b6:a03:2ef::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30 via Frontend
 Transport; Mon, 10 Jul 2023 14:03:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT034.mail.protection.outlook.com (10.13.173.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.19 via Frontend Transport; Mon, 10 Jul 2023 14:03:01 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 10 Jul
 2023 09:03:00 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 10 Jul
 2023 09:03:00 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Mon, 10 Jul 2023 09:02:58 -0500
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: <qemu-devel@nongnu.org>
CC: <frasse.iglesias@gmail.com>, <alistair@alistair23.me>,
 <edgar.iglesias@gmail.com>, <peter.maydell@linaro.org>, <fkonrad@amd.com>,
 <sai.pavan.boddu@amd.com>, <tong.ho@amd.com>, <vikram.garhwal@amd.com>
Subject: [PATCH v1 4/8] hw/misc/xlnx-versal-cfu: Introduce a model of Xilinx
 Versal's CFU_SFR
Date: Mon, 10 Jul 2023 16:02:45 +0200
Message-ID: <20230710140249.56324-5-francisco.iglesias@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230710140249.56324-1-francisco.iglesias@amd.com>
References: <20230710140249.56324-1-francisco.iglesias@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT034:EE_|MW3PR12MB4459:EE_
X-MS-Office365-Filtering-Correlation-Id: 131b073b-17b0-4188-9198-08db814e5f68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mn8hmy5Nv5g6VsY7EHTY7Wxy/6YFJL1K8ae1ZqcFDFZbMEm33uVGEMYnJTHJdWq4tDxVm773CPsjXVSZJ5ujOnbSC8SxVghhHkpnTUivzpkUCdKdSn5J36Gx5J6J6Zqc9wX70ED7BWG4jWsVpgvmciwoa2thAon2gCG1MEwGIOvJDmSqd6GxXPAC+rXf6t+LJGU7Dgi/1bRfRf0itJ4dTKnFF0YNShSTapZIkboxryID0nlK0QskOEad9NFPiUdscprP+ebtQ3weibI8Auxw3lNluMqyOfc9+NnPLm4W1dfgKLACV/7Gc67rQNxXLNSw1FRMd04lnrzZvCU3Joc5N/CzH3pDO+hyNEUrQsufnZTKzZfa+kMfHyo7x76DhwzTuM9+/5aNCpwoYwBl0kOe/W8ZQQG8LJ9XgUYsEq8f3F8qyHbySALTT19Imy1xO3tP9nxFXJkU2hIByUfzaCmzIsa4ep0zqVKJkwW6sGLej7qDOil8wxrTyAFF+szK/njeDJv84/6CaShHgVp6yo984juLvZeUw5R9KBFm2j+hhbUUQ2BIBoaZV7kj40k/0ggaoF9QmvzKP0Pu+7myb14iEHJrL6Nec9EHnBzjaSKQs4Ci0MeSIw/XAKraVvrSruXZbCscRnAQCBETjG1Vh4fseH9kTGL7zVKJt2wXT3MEDpwEd33DDdZRKz2KQQw5IzBC/rGFOYD55+p7+JchiT4n+veAbgRR1ZVZOfPSWUWZcWD8aLeAPXJ7YKi1ocG3GSNe/FX4+tpViRvXru+GogU+Xg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(376002)(39860400002)(346002)(451199021)(36840700001)(40470700004)(46966006)(81166007)(54906003)(356005)(6666004)(82740400003)(40460700003)(478600001)(8676002)(8936002)(5660300002)(36756003)(2906002)(86362001)(82310400005)(44832011)(6916009)(4326008)(316002)(40480700001)(70206006)(70586007)(41300700001)(26005)(1076003)(186003)(336012)(36860700001)(426003)(2616005)(47076005)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 14:03:01.0396 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 131b073b-17b0-4188-9198-08db814e5f68
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4459
Received-SPF: softfail client-ip=2a01:111:f400:7eae::601;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
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

Introduce a model of Xilinx Versal's Configuration Frame Unit's Single
Frame Read port (CFU_SFR).

Signed-off-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
 hw/misc/xlnx-versal-cfu.c         | 88 +++++++++++++++++++++++++++++++
 include/hw/misc/xlnx-versal-cfu.h | 15 ++++++
 2 files changed, 103 insertions(+)

diff --git a/hw/misc/xlnx-versal-cfu.c b/hw/misc/xlnx-versal-cfu.c
index 528090ef1b..60aec02a58 100644
--- a/hw/misc/xlnx-versal-cfu.c
+++ b/hw/misc/xlnx-versal-cfu.c
@@ -257,6 +257,41 @@ static void cfu_stream_write(void *opaque, hwaddr addr, uint64_t value,
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
+    unsigned int idx;
+
+    /* 4 32bit words. */
+    idx = (addr >> 2) & 3;
+
+    s->wfifo[idx] = value;
+
+    /* Writing to the top word triggers the transmit onto CFI. */
+    if (idx == 3) {
+        uint8_t row_addr = extract32(s->wfifo[0], 23, 5);
+        uint32_t frame_addr = extract32(s->wfifo[0], 0, 23);
+        XlnxCfiPacket pkt = { .reg_addr = CFRAME_SFR,
+                              .data[0] = frame_addr };
+
+        if (s->cfg.cfu) {
+            cfu_transfer_cfi_packet(s->cfg.cfu, row_addr, &pkt);
+        }
+
+        for (int i = 0; i < ARRAY_SIZE(s->wfifo); i++) {
+            s->wfifo[i] = 0;
+        }
+    }
+}
+
 static uint64_t cfu_fdro_read(void *opaque, hwaddr addr, unsigned size)
 {
     XlnxVersalCFUFDRO *s = XLNX_VERSAL_CFU_FDRO(opaque);
@@ -287,6 +322,16 @@ static const MemoryRegionOps cfu_stream_ops = {
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
@@ -328,6 +373,16 @@ static void cfu_apb_init(Object *obj)
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
 static void cfu_fdro_init(Object *obj)
 {
     XlnxVersalCFUFDRO *s = XLNX_VERSAL_CFU_FDRO(obj);
@@ -380,6 +435,12 @@ static Property cfu_props[] = {
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
@@ -427,6 +488,16 @@ static const VMStateDescription vmstate_cfu_fdro = {
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
@@ -445,6 +516,14 @@ static void cfu_fdro_class_init(ObjectClass *klass, void *data)
     xcic->cfi_transfer_packet = cfu_fdro_cfi_transfer_packet;
 }
 
+static void cfu_sfr_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_props(dc, cfu_sfr_props);
+    dc->vmsd = &vmstate_cfu_sfr;
+}
+
 static const TypeInfo cfu_apb_info = {
     .name          = TYPE_XLNX_VERSAL_CFU_APB,
     .parent        = TYPE_SYS_BUS_DEVICE,
@@ -469,10 +548,19 @@ static const TypeInfo cfu_fdro_info = {
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
index 3603bb2862..add155a8c4 100644
--- a/include/hw/misc/xlnx-versal-cfu.h
+++ b/include/hw/misc/xlnx-versal-cfu.h
@@ -27,6 +27,9 @@ OBJECT_DECLARE_SIMPLE_TYPE(XlnxVersalCFUAPB, XLNX_VERSAL_CFU_APB)
 #define TYPE_XLNX_VERSAL_CFU_FDRO "xlnx,versal-cfu-fdro"
 OBJECT_DECLARE_SIMPLE_TYPE(XlnxVersalCFUFDRO, XLNX_VERSAL_CFU_FDRO)
 
+#define TYPE_XLNX_VERSAL_CFU_SFR "xlnx,versal-cfu-sfr"
+OBJECT_DECLARE_SIMPLE_TYPE(XlnxVersalCFUSFR, XLNX_VERSAL_CFU_SFR)
+
 REG32(CFU_ISR, 0x0)
     FIELD(CFU_ISR, USR_GTS_EVENT, 9, 1)
     FIELD(CFU_ISR, USR_GSR_EVENT, 8, 1)
@@ -220,4 +223,16 @@ struct XlnxVersalCFUFDRO {
     uint32_t *ro_data;
     uint32_t ro_dlen;
 };
+
+struct XlnxVersalCFUSFR {
+    SysBusDevice parent_obj;
+    MemoryRegion iomem_sfr;
+
+    /* 128-bit wfifo. */
+    uint32_t wfifo[4];
+
+    struct {
+        XlnxVersalCFUAPB *cfu;
+    } cfg;
+};
 #endif
-- 
2.34.1


