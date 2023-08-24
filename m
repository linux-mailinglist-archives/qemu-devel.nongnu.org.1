Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92763787809
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 20:35:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZFAz-00072z-A6; Thu, 24 Aug 2023 14:35:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1qZFAv-00070E-8X
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 14:35:21 -0400
Received: from mail-bn8nam12on2060f.outbound.protection.outlook.com
 ([2a01:111:f400:fe5b::60f]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1qZFAs-0007FB-Gb
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 14:35:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VJZPTDMIBfIzfX02Hh2Yy743IRVBKLRkqzO1hpppAk/uF/JwRK+H4VLl9R9BYIF3IsGhThuFjSryn+z6Og7Zmf/GtzKj6nTbcT4hG9YB2ed9GXdlAr25NYNBA/GOtju+fSy7ZXbghEOpD+U15jMC7PcmCzwb6HpB3eH/QcsFBnXTg+adGOv+zhga0laH6XidEtZVOdS96axj6HgalzP52jZ6BB0gbLXVqa/VGjCXzt/Hy89yea92vbCrPEuYDeBYhkgM2CZ86Hpc8OpYtxpcshKPTAtX7/PM6L2q+JvISSr37UELVYZAejcQ4K7yjWMdQLVXY2TphcuWhJS7B94/2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQ+lddYVIVTyHUZJvwGaDUPTBiw80FboOA1+/NRIf+w=;
 b=iYqqZeKx9b8OwRAVLw9+bzGb1dEVz2xCsKFzDkHsgB2za6iJ0Ay4IlRC9si6F3E3FbnON2s2CoXYForZORVSbvDbquIY5UkQbwg9W2NqtFZI0at970w67EKYbVUgNvKzQSJzY3ovMapszFoYvyN95av7MZ2cEHR2Yl75hw6FnQYC9FnHCUPz6Xt+SFhKER4cq7n6r/o/4d5BvSgLX/zCzrVEXH7dXuKthMTM45JFm3/cLAVJSdP1yoKmTvSUpKv1lbCyXoz2idTfT9nCp62Ke48p+PN4SAzqJW82IMxiA5Z2Nd5gzmjdXiBp2CGgZniXL468LvlfJ4GZ0prAbhanJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQ+lddYVIVTyHUZJvwGaDUPTBiw80FboOA1+/NRIf+w=;
 b=Mbwk68xLEH/G6rlPykiGzGahIJ5TYfWbRNIiQtgPd4MEGG1cpUl6oQZlkMiSY54UbmedKQ0xtKhuSBM+CyNHvMFaIq/lYFG/J67fLEYZMKKaDzUTbpz6JSS4IWW06c82qt0as7u1oQXRB5+/4vwN/GyWEJPZHGgMIAi1RKjT2bw=
Received: from CY5PR13CA0052.namprd13.prod.outlook.com (2603:10b6:930:11::34)
 by BN9PR12MB5322.namprd12.prod.outlook.com (2603:10b6:408:103::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 18:35:14 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:930:11:cafe::a7) by CY5PR13CA0052.outlook.office365.com
 (2603:10b6:930:11::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Thu, 24 Aug 2023 18:35:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Thu, 24 Aug 2023 18:35:13 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 13:35:05 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 13:35:05 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 24 Aug 2023 13:35:03 -0500
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: <qemu-devel@nongnu.org>
CC: <frasse.iglesias@gmail.com>, <alistair@alistair23.me>,
 <edgar.iglesias@gmail.com>, <peter.maydell@linaro.org>, <fkonrad@amd.com>,
 <sai.pavan.boddu@amd.com>, <tong.ho@amd.com>, <vikram.garhwal@amd.com>
Subject: [PATCH v3 7/8] hw/arm/xlnx-versal: Connect the CFU_APB,
 CFU_FDRO and CFU_SFR
Date: Thu, 24 Aug 2023 20:34:47 +0200
Message-ID: <20230824183448.151738-8-francisco.iglesias@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824183448.151738-1-francisco.iglesias@amd.com>
References: <20230824183448.151738-1-francisco.iglesias@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|BN9PR12MB5322:EE_
X-MS-Office365-Filtering-Correlation-Id: 128eed48-fd42-4d99-460b-08dba4d0db13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aD7INbRi6WiJtZ9LFUESSPcYF3R77OCxz7na82e1JhWQAAS446x8Kj4ZSRZemrUxQdJeki8BKgkRxA2zvORrC/IjGpiWo2YG9mOmceBYVaekYMKUmoheRsroNbKABwvKfDUYx+vh8rBkfBF6rHQk96lbwhknJhQa41TO9oZSrw5YSRnjClQf+6z3ZD43R1VCyBQmOZE1TRmHVnecR3260DUqt0sA2adwiqf2slGM6vqsl4n1d4XOuqBbqp4sgBucupivH3RF5vwf3toigQCgRhk4i6LaU0RSBONFIw8mj25Q+z6idZIiHJ7Fe33ygQesMS9pTCldSDJhuHo+5I2CrlliZrOzDs6Yono6fDTeS8rBzvwIgmDS8kPYVX6YfnBkn3mCEOT6xLx8d8kRQe78DlU2yox/gZaI4R0DKkQloz8kc8yC4ZEqFlN66MSf4R/6Aiv3GyiKJ0JNH2u9BjfY4rdZe0ICTea1YYCPw66VNkJ9NNIK1NtvtP9FpudtiNjsZPyS1hv5hYs1Dk6AXJDu2kNiMAhd9vrVoINCQAExq54g/ZYPklCVoMiagbgwd+/P5/7QdoJDQKEyBo9/nIgrajwsBA9eb/O/5QMbTXFkgQGsPo83pUrSwdh4YC5g8QKXvhqAf5TpM3iuWNNFEwUev8LHw0mMGn/pNSSUIDXobrtDiua8yoriXftMvedwU2eLkXeE9kh9yYqU+Ki1gsYBP6/C2KtGWBCFPtqYxjpYXKupU832Yl2nlCoqDNwnrUIS/A5cvMU1fCWeQmRBFODc8g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199024)(82310400011)(186009)(1800799009)(40470700004)(36840700001)(46966006)(54906003)(70206006)(70586007)(316002)(6916009)(478600001)(26005)(36860700001)(44832011)(356005)(6666004)(40480700001)(82740400003)(81166007)(41300700001)(86362001)(2906002)(8936002)(8676002)(4326008)(1076003)(40460700003)(2616005)(5660300002)(36756003)(336012)(47076005)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 18:35:13.7277 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 128eed48-fd42-4d99-460b-08dba4d0db13
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5322
Received-SPF: softfail client-ip=2a01:111:f400:fe5b::60f;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
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

Connect the Configuration Frame Unit (CFU_APB, CFU_FDRO and CFU_SFR) to
the Versal machine.

Signed-off-by: Francisco Iglesias <francisco.iglesias@amd.com>
Acked-by: Edgar E. Iglesias <edgar@zeroasic.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/xlnx-versal.c         | 42 ++++++++++++++++++++++++++++++++++++
 include/hw/arm/xlnx-versal.h | 16 ++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 60bf5fe657..3f4b4b1560 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -570,6 +570,47 @@ static void versal_create_ospi(Versal *s, qemu_irq *pic)
     qdev_connect_gpio_out(orgate, 0, pic[VERSAL_OSPI_IRQ]);
 }
 
+static void versal_create_cfu(Versal *s, qemu_irq *pic)
+{
+    SysBusDevice *sbd;
+
+    /* CFU FDRO */
+    object_initialize_child(OBJECT(s), "cfu-fdro", &s->pmc.cfu_fdro,
+                            TYPE_XLNX_VERSAL_CFU_FDRO);
+    sbd = SYS_BUS_DEVICE(&s->pmc.cfu_fdro);
+
+    sysbus_realize(sbd, &error_fatal);
+    memory_region_add_subregion(&s->mr_ps, MM_PMC_CFU_FDRO,
+                                sysbus_mmio_get_region(sbd, 0));
+
+    /* CFU APB */
+    object_initialize_child(OBJECT(s), "cfu-apb", &s->pmc.cfu_apb,
+                            TYPE_XLNX_VERSAL_CFU_APB);
+    sbd = SYS_BUS_DEVICE(&s->pmc.cfu_apb);
+
+    sysbus_realize(sbd, &error_fatal);
+    memory_region_add_subregion(&s->mr_ps, MM_PMC_CFU_APB,
+                                sysbus_mmio_get_region(sbd, 0));
+    memory_region_add_subregion(&s->mr_ps, MM_PMC_CFU_STREAM,
+                                sysbus_mmio_get_region(sbd, 1));
+    memory_region_add_subregion(&s->mr_ps, MM_PMC_CFU_STREAM_2,
+                                sysbus_mmio_get_region(sbd, 2));
+    sysbus_connect_irq(sbd, 0, pic[VERSAL_CFU_IRQ_0]);
+
+    /* CFU SFR */
+    object_initialize_child(OBJECT(s), "cfu-sfr", &s->pmc.cfu_sfr,
+                            TYPE_XLNX_VERSAL_CFU_SFR);
+
+    sbd = SYS_BUS_DEVICE(&s->pmc.cfu_sfr);
+
+    object_property_set_link(OBJECT(&s->pmc.cfu_sfr),
+                            "cfu", OBJECT(&s->pmc.cfu_apb), &error_abort);
+
+    sysbus_realize(sbd, &error_fatal);
+    memory_region_add_subregion(&s->mr_ps, MM_PMC_CFU_SFR,
+                                sysbus_mmio_get_region(sbd, 0));
+}
+
 static void versal_create_crl(Versal *s, qemu_irq *pic)
 {
     SysBusDevice *sbd;
@@ -763,6 +804,7 @@ static void versal_realize(DeviceState *dev, Error **errp)
     versal_create_pmc_iou_slcr(s, pic);
     versal_create_ospi(s, pic);
     versal_create_crl(s, pic);
+    versal_create_cfu(s, pic);
     versal_map_ddr(s);
     versal_unimp(s);
 
diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index 39ee31185c..29b9c60301 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -32,6 +32,7 @@
 #include "hw/misc/xlnx-versal-crl.h"
 #include "hw/misc/xlnx-versal-pmc-iou-slcr.h"
 #include "hw/net/xlnx-versal-canfd.h"
+#include "hw/misc/xlnx-versal-cfu.h"
 
 #define TYPE_XLNX_VERSAL "xlnx-versal"
 OBJECT_DECLARE_SIMPLE_TYPE(Versal, XLNX_VERSAL)
@@ -117,6 +118,9 @@ struct Versal {
         XlnxEFuse efuse;
         XlnxVersalEFuseCtrl efuse_ctrl;
         XlnxVersalEFuseCache efuse_cache;
+        XlnxVersalCFUAPB cfu_apb;
+        XlnxVersalCFUFDRO cfu_fdro;
+        XlnxVersalCFUSFR cfu_sfr;
 
         OrIRQState apb_irq_orgate;
     } pmc;
@@ -147,6 +151,7 @@ struct Versal {
 #define VERSAL_GEM1_WAKE_IRQ_0     59
 #define VERSAL_ADMA_IRQ_0          60
 #define VERSAL_XRAM_IRQ_0          79
+#define VERSAL_CFU_IRQ_0           120
 #define VERSAL_PMC_APB_IRQ         121
 #define VERSAL_OSPI_IRQ            124
 #define VERSAL_SD0_IRQ_0           126
@@ -240,6 +245,17 @@ struct Versal {
 #define MM_PMC_EFUSE_CACHE          0xf1250000
 #define MM_PMC_EFUSE_CACHE_SIZE     0x00C00
 
+#define MM_PMC_CFU_APB              0xf12b0000
+#define MM_PMC_CFU_APB_SIZE         0x10000
+#define MM_PMC_CFU_STREAM           0xf12c0000
+#define MM_PMC_CFU_STREAM_SIZE      0x1000
+#define MM_PMC_CFU_SFR              0xf12c1000
+#define MM_PMC_CFU_SFR_SIZE         0x1000
+#define MM_PMC_CFU_FDRO             0xf12c2000
+#define MM_PMC_CFU_FDRO_SIZE        0x1000
+#define MM_PMC_CFU_STREAM_2         0xf1f80000
+#define MM_PMC_CFU_STREAM_2_SIZE    0x40000
+
 #define MM_PMC_CRP                  0xf1260000U
 #define MM_PMC_CRP_SIZE             0x10000
 #define MM_PMC_RTC                  0xf12a0000
-- 
2.34.1


