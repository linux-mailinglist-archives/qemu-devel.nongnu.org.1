Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5418E74D86E
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 16:05:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIrTt-0000gC-4J; Mon, 10 Jul 2023 10:03:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1qIrTn-0000eS-U5
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 10:03:07 -0400
Received: from mail-bn7nam10on2061a.outbound.protection.outlook.com
 ([2a01:111:f400:7e8a::61a]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1qIrTl-0003Ge-DD
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 10:03:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J9ImMvUNjxW+h8bOu3rrglbjQ8gGQWEJYec/tSNcOxRiBTfwjoqgv/9rUxW0JyirNrxDH9SsKwXYEajIAEikrHZMZBuPiSZ7jGrcqFCxFCDFzw2v+BROCRK7JZnFAARNDn9mKZpg7welOYd43BGDLqFKDQrqYzwNBQLPPusiEuxi1BKptooUxBuPJXneYYlc/Kz42H+ZkAbulhY/MMXe0bvrvLRtHwFminbbu2Jk6R9qTxrDYh6k4QmLiUWTdplg9x5S6f8upu+9KQdlwIxkbvsxhJOyl0XqMTHjONZrsLOcrlVAJjW07NtRLVmCUnTMjGav7lU6/asXi/SoW4At/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zS3khLezufu3WyW7LaH6p/MZJaUzxxuw3eBtPgt95tU=;
 b=lG7kLKigP3y228J9EWcFWVf26RHHjac7tTQ3PqrML+ovurvJF5FXOeghfNUVnSxyNsQgGG/xJIdTFwmDLERgi2C7l0P5pRvhg0kpA3ZmPVvCJHuYIKwL9qjXbReiiZ8lFHvbf7rvCphwcLCZUMzme8KVfiVB7qqSTVFCbR90l/4ydHQWTsTBuzJAHzYwrG1fYDrFqg8RNeLvk8MSJN9o0sZ5lOcJdHZ7s6tlDZ0h4UvMgncfI9xs1shfAILOn76EMalNM+4Mprbh5gHqWLsS5dBB0yxxfyMN/Rr46UtFHR6zNjrpsMdW13v07ZBklMeecK/+XKyUbZYMBIi59Vdbdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zS3khLezufu3WyW7LaH6p/MZJaUzxxuw3eBtPgt95tU=;
 b=h/sCrVsBpkF5OG0Jvp2aL/Ivq53DAIuKiXj9tE+4xxe7lmoLD6+PYsFvPh9J0Zvnk6Su2nXG7Q+DIf/38B4lGLVlz6IRxkTCNiTyewOHeqhfAATpL7eJZEpV8MLy8De8pBGrNNsUpnwWQwDSkVp/EI6zURo+XbeMevOWeG0kn24=
Received: from DS7PR06CA0003.namprd06.prod.outlook.com (2603:10b6:8:2a::27) by
 PH0PR12MB7886.namprd12.prod.outlook.com (2603:10b6:510:26e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Mon, 10 Jul
 2023 14:03:00 +0000
Received: from DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::50) by DS7PR06CA0003.outlook.office365.com
 (2603:10b6:8:2a::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31 via Frontend
 Transport; Mon, 10 Jul 2023 14:02:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT025.mail.protection.outlook.com (10.13.172.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.18 via Frontend Transport; Mon, 10 Jul 2023 14:02:59 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 10 Jul
 2023 09:02:58 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 10 Jul
 2023 09:02:58 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Mon, 10 Jul 2023 09:02:56 -0500
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: <qemu-devel@nongnu.org>
CC: <frasse.iglesias@gmail.com>, <alistair@alistair23.me>,
 <edgar.iglesias@gmail.com>, <peter.maydell@linaro.org>, <fkonrad@amd.com>,
 <sai.pavan.boddu@amd.com>, <tong.ho@amd.com>, <vikram.garhwal@amd.com>
Subject: [PATCH v1 3/8] hw/misc/xlnx-versal-cfu: Introduce a model of Xilinx
 Versal CFU_FDRO
Date: Mon, 10 Jul 2023 16:02:44 +0200
Message-ID: <20230710140249.56324-4-francisco.iglesias@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230710140249.56324-1-francisco.iglesias@amd.com>
References: <20230710140249.56324-1-francisco.iglesias@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT025:EE_|PH0PR12MB7886:EE_
X-MS-Office365-Filtering-Correlation-Id: 64696420-1ded-4ffc-c9de-08db814e5e89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p6jxKGWxAiHRoVdcLd8mAxJ3UfpLapWZQxkolIFKzJe3phKFzCsvCSBNM5AW5OejCsqhFLwEa8iRtREAyi4rdAhfeLIRp88eJbU/igfQx6ShKs9HFadHVkNzkXw07fRTRY866n6uT/bB5Uu5S9orSYnDzlgQArrulxsAsl6n5FC64UxkJDPlSnAxBH7VewlXe3NtTO4VhjxqiGaSX/Z70PkU7Udl5zfSwk7GB74ORGe6DNOd8TvLpTctKY9SDC5h9UEC3Ds76XW6I0oFJdh6ZcD39AWVchMXGHRIqn2l/An23HZdINUN2ri25g3XMi3XCq4LFu5jB/7jovaErqJ8xVrbC9Zr8cp6hy++nhbcLs9NuskLB0g882aL4rTRR+cadwSWgqyc6f2IFSl3woT+J+3IYi5Z/lEijF5vIqEyOMNvMidC2rfxy1hlxdG3jT81cGl3WqtYpVxZrnfonoO6FxR5L55VUAtMhtbnxmmJtZwApZuR85R7e1dGzm5M//R9aXMqXsxxEwrvzH3r/kRc6S8NnzP9XPan2NWwCsz41Y3Vdu55siPqaxNduqv2OVz+IM7HfNkrHtpPS+RUurgji6CcPnzc8lYnS0lQdmxIOKATbdzb+ibEGpsbjkm9FF2gPHR12YvWvXgnr43asrBkkA4W7jv0Yc2Sgez6bPfxQbWLo5UVwQb0H8sAdIPX1HwmcbUZ08jHoj2RFPvhE6QiPiGNtnJQ1BrQI/ruZnWuYs7f8gBENrnbd9U8k7pnXvRjiQlxijPlEHrtICo413jFcw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(396003)(376002)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(82310400005)(478600001)(40460700003)(54906003)(6666004)(40480700001)(47076005)(426003)(336012)(1076003)(186003)(26005)(36756003)(82740400003)(83380400001)(356005)(81166007)(36860700001)(86362001)(4326008)(6916009)(70586007)(5660300002)(8676002)(2616005)(70206006)(8936002)(2906002)(316002)(41300700001)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 14:02:59.5796 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64696420-1ded-4ffc-c9de-08db814e5e89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7886
Received-SPF: softfail client-ip=2a01:111:f400:7e8a::61a;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
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

Introduce a model of Xilinx Versal's Configuration Frame Unit's data out
port (CFU_FDRO).

Signed-off-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
 hw/misc/xlnx-versal-cfu.c         | 105 ++++++++++++++++++++++++++++++
 include/hw/misc/xlnx-versal-cfu.h |  11 ++++
 2 files changed, 116 insertions(+)

diff --git a/hw/misc/xlnx-versal-cfu.c b/hw/misc/xlnx-versal-cfu.c
index cbd17d2351..528090ef1b 100644
--- a/hw/misc/xlnx-versal-cfu.c
+++ b/hw/misc/xlnx-versal-cfu.c
@@ -257,6 +257,26 @@ static void cfu_stream_write(void *opaque, hwaddr addr, uint64_t value,
     }
 }
 
+static uint64_t cfu_fdro_read(void *opaque, hwaddr addr, unsigned size)
+{
+    XlnxVersalCFUFDRO *s = XLNX_VERSAL_CFU_FDRO(opaque);
+    uint64_t ret = 0;
+
+    if (s->fdro_data->len) {
+        ret = g_array_index(s->fdro_data, uint32_t, 0);
+        g_array_remove_index(s->fdro_data, 0);
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
@@ -267,6 +287,16 @@ static const MemoryRegionOps cfu_stream_ops = {
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
@@ -298,6 +328,24 @@ static void cfu_apb_init(Object *obj)
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
+    s->fdro_data = g_array_new(FALSE, FALSE, sizeof(uint32_t));
+}
+
+static void cfu_fdro_cfi_transfer_packet(XlnxCfiIf *cfi_if, XlnxCfiPacket *pkt)
+{
+    XlnxVersalCFUFDRO *s = XLNX_VERSAL_CFU_FDRO(cfi_if);
+
+    g_array_append_vals(s->fdro_data, &pkt->data[0], 4);
+}
+
 static Property cfu_props[] = {
         DEFINE_PROP_LINK("cframe0", XlnxVersalCFUAPB, cfg.cframe[0],
                          TYPE_XLNX_CFI_IF, XlnxCfiIf *),
@@ -344,6 +392,41 @@ static const VMStateDescription vmstate_cfu_apb = {
     }
 };
 
+static int cfdro_reg_pre_save(void *opaque)
+{
+    XlnxVersalCFUFDRO *s = XLNX_VERSAL_CFU_FDRO(opaque);
+
+    if (s->fdro_data->len) {
+        s->ro_data = (uint32_t *) s->fdro_data->data;
+        s->ro_dlen = s->fdro_data->len;
+    }
+
+    return 0;
+}
+
+static int cfdro_reg_post_load(void *opaque, int version_id)
+{
+    XlnxVersalCFUFDRO *s = XLNX_VERSAL_CFU_FDRO(opaque);
+
+    if (s->ro_dlen) {
+        g_array_append_vals(s->fdro_data, s->ro_data, s->ro_dlen);
+    }
+    return 0;
+}
+
+static const VMStateDescription vmstate_cfu_fdro = {
+    .name = TYPE_XLNX_VERSAL_CFU_FDRO,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .pre_save = cfdro_reg_pre_save,
+    .post_load = cfdro_reg_post_load,
+    .fields = (VMStateField[]) {
+        VMSTATE_VARRAY_UINT32_ALLOC(ro_data, XlnxVersalCFUFDRO, ro_dlen,
+                                    0, vmstate_info_uint32, uint32_t),
+        VMSTATE_END_OF_LIST(),
+    }
+};
+
 static void cfu_apb_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -353,6 +436,15 @@ static void cfu_apb_class_init(ObjectClass *klass, void *data)
     device_class_set_props(dc, cfu_props);
 }
 
+static void cfu_fdro_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    XlnxCfiIfClass *xcic = XLNX_CFI_IF_CLASS(klass);
+
+    dc->vmsd = &vmstate_cfu_fdro;
+    xcic->cfi_transfer_packet = cfu_fdro_cfi_transfer_packet;
+}
+
 static const TypeInfo cfu_apb_info = {
     .name          = TYPE_XLNX_VERSAL_CFU_APB,
     .parent        = TYPE_SYS_BUS_DEVICE,
@@ -365,9 +457,22 @@ static const TypeInfo cfu_apb_info = {
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
index 4936d6e5f0..3603bb2862 100644
--- a/include/hw/misc/xlnx-versal-cfu.h
+++ b/include/hw/misc/xlnx-versal-cfu.h
@@ -24,6 +24,9 @@
 #define TYPE_XLNX_VERSAL_CFU_APB "xlnx,versal-cfu-apb"
 OBJECT_DECLARE_SIMPLE_TYPE(XlnxVersalCFUAPB, XLNX_VERSAL_CFU_APB)
 
+#define TYPE_XLNX_VERSAL_CFU_FDRO "xlnx,versal-cfu-fdro"
+OBJECT_DECLARE_SIMPLE_TYPE(XlnxVersalCFUFDRO, XLNX_VERSAL_CFU_FDRO)
+
 REG32(CFU_ISR, 0x0)
     FIELD(CFU_ISR, USR_GTS_EVENT, 9, 1)
     FIELD(CFU_ISR, USR_GSR_EVENT, 8, 1)
@@ -209,4 +212,12 @@ struct XlnxVersalCFUAPB {
     } cfg;
 };
 
+struct XlnxVersalCFUFDRO {
+    SysBusDevice parent_obj;
+    MemoryRegion iomem_fdro;
+
+    GArray *fdro_data;
+    uint32_t *ro_data;
+    uint32_t ro_dlen;
+};
 #endif
-- 
2.34.1


