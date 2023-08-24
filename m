Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BB378780C
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 20:36:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZFAw-000704-0J; Thu, 24 Aug 2023 14:35:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1qZFAm-0006yN-Vf
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 14:35:14 -0400
Received: from mail-dm6nam11on20622.outbound.protection.outlook.com
 ([2a01:111:f400:7eaa::622]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1qZFAk-0007CG-C0
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 14:35:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YOmCxkJKyDQSv2DsV2DHS27n4tTpPoTHMlgRf5TwGjUouY28vqfqmC8jPNAOqI2PXDlv6V2fN6U+ToUteA03XuOtOY9zFfCVR5gsAj3rxeju5Rk3Wf4yjM0yLoACSaLyX0eOxSAwIXmIRO+7XAmHy7GV6VnoJQWgMzdcmyFVwciwKm/m0rtgbePSkfVVGdVlNSvdQT5KFf8U6bVNgSTDqgfh50Q4JqDXZIA94U9LQqru2anH78ZzQp16qlIDoBQw8cgbwEKGvdC0mPGEZpCRnr0JYM7ccL5rVmD8+O1nV8S4fS+yyNkdR0EhWyErI0g2Ovoe2Axj6aX/lYOLPztsSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L3K6zjYWsy6eN46xdaD2mGatwHnrAxG/IEIeslaDOLA=;
 b=AshsuYmBQvxYU5XwlbR/jmxpXJVzealh7olxdDaIxyLFIIpzmiYR04PDN4Bj+JdGp3rp1ewuf9VA4hxlgqYg5cG90TM4fEKChlVWNEd8NjUEeRRIjk+fumeTr+r21k19GsKoH0GhCMPkfzBysgj4neTi7WIp4kVdFgDWV2BnH25MpnmlGWkpWSO8GKwwcNWxVLlbp2MwmzruFoNRrY4Weh6Bnw65HQNIJMx4iod+AXiVNSeTOgd1awVXL3lbYP6wZdc5+GJE3EOdIXMmBf/hf/6+Rx10y+AH3pYFmeRJuCqU53DwjmKjgIoCUrM7/FGhaJSJWM4olANG65N1APfhow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L3K6zjYWsy6eN46xdaD2mGatwHnrAxG/IEIeslaDOLA=;
 b=NgkMGwCjvuV62U6AijqZ1fpWCwSQZ5pTRghV3CMS3laPrfp9rhT1dWkEUMP4Dl/hJ4ZUC9o+19jeHqXW5TcFu5/IDG191RKKcko73lvV9LwnHYEL/N9olvCgnTkGK1apb3GugsbI6/ooEpgPqb+q9yUOai4hX+NYNUQKODu2NI0=
Received: from DM6PR18CA0006.namprd18.prod.outlook.com (2603:10b6:5:15b::19)
 by CH3PR12MB9284.namprd12.prod.outlook.com (2603:10b6:610:1c7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 18:35:03 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:5:15b:cafe::d4) by DM6PR18CA0006.outlook.office365.com
 (2603:10b6:5:15b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27 via Frontend
 Transport; Thu, 24 Aug 2023 18:35:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.2 via Frontend Transport; Thu, 24 Aug 2023 18:35:02 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 13:34:59 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 24 Aug 2023 13:34:57 -0500
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: <qemu-devel@nongnu.org>
CC: <frasse.iglesias@gmail.com>, <alistair@alistair23.me>,
 <edgar.iglesias@gmail.com>, <peter.maydell@linaro.org>, <fkonrad@amd.com>,
 <sai.pavan.boddu@amd.com>, <tong.ho@amd.com>, <vikram.garhwal@amd.com>
Subject: [PATCH v3 4/8] hw/misc/xlnx-versal-cfu: Introduce a model of Xilinx
 Versal's CFU_SFR
Date: Thu, 24 Aug 2023 20:34:44 +0200
Message-ID: <20230824183448.151738-5-francisco.iglesias@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824183448.151738-1-francisco.iglesias@amd.com>
References: <20230824183448.151738-1-francisco.iglesias@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|CH3PR12MB9284:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d1545dc-870e-424d-2f8a-08dba4d0d480
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dbf2gP3+SeJf1JnHRunbvRlFD1k3cAtBglgDdTuQVmRwhEN/WyN3SCtdQDGglS66YVZxxX4cQe8CqPV40GL3SbGSM7iEtN/4N1MkmyPJjBZSKEY4wJGaECsTtw4MWv3x7IweyaZN3Snu0KRMtafAMBDjsjSk2NmKj/wzSq/kJwtfkMu238a8/qFpB+dezcvzy60diRMQywOY3bBCFr6nnpCizD4FI4pV2WDnjaLWVYXMvuHxPu50XEv41UDbvtW70sb4XKsOCtLSnwZKWcUUbXAgFGSaQ5/+HcLXXz21XiIvpXlhxCWLjZgPRwn1ZSbAuacGt6mPK3oXkUafk0vNPcG96zJ0TPkxOR1U5Do+ilmNQsc+8fuxZ5h5C6JQp5JYssf2E4PlNHesJNmB45jlCNPLJNJIY5qQl6qw27UZGrde9iI8cliySk4kHQomQJHq8jnXdedQv/JK1ezwSaSgbgcl+LTeBQi5m/aQterxKpE7VOB739VAWWc2/61mAg9mUl0jy1MIaMCQz0Amr3OG4TWEHU/Niy3xLX5Ja1b9Mdznds+EXe5vrHZtFsxuoMYpnIWU3YOh2JtqCE74hf8vgp+57re3QyQHyeH6Y+Mj9anIjr2jNUVUgreiq3zaYpI6OevzzpTstNXiEM6goz2rducj1s2HVdKv7oJETxO1vw+lJ/WSYjvWzewlPbvirVjAwR88VQEnoJOZ0TVwXTJEUXWiy06HkYK3fneHDcpZJbYIQD561VokipBWqXPxf7GsyJRLrs3fOmtjDGRoYxCalw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199024)(186009)(82310400011)(1800799009)(46966006)(40470700004)(36840700001)(54906003)(70206006)(70586007)(316002)(81166007)(40480700001)(6916009)(478600001)(26005)(36860700001)(44832011)(6666004)(356005)(82740400003)(41300700001)(86362001)(2906002)(8936002)(8676002)(4326008)(40460700003)(1076003)(2616005)(5660300002)(83380400001)(36756003)(336012)(426003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 18:35:02.6661 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d1545dc-870e-424d-2f8a-08dba4d0d480
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9284
Received-SPF: softfail client-ip=2a01:111:f400:7eaa::622;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
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


