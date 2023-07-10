Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B804C74D859
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 16:04:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIrUJ-0000l8-6a; Mon, 10 Jul 2023 10:03:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1qIrUF-0000kr-8e
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 10:03:35 -0400
Received: from mail-bn7nam10on2062c.outbound.protection.outlook.com
 ([2a01:111:f400:7e8a::62c]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1qIrUB-0003Lh-4h
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 10:03:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cjCI+AOq8yAQh7ErUQ7Ajav3V7rVqMBsvADxAxpjMItjS2ur60Kxm0UdpXQEV0hxKG6nrjGFVnHVKHyeSQZpTp3dsI7xyZQ3aiwuWnIOQEds5WAX+7uQd4DFtlQB6RRZtPhd5/GGgzb3GlOlV6Os75FJp5Mpa7aqtV9G8bzJhFOEaF+vobqSBLv4J706X5RtuMBq5Mt7bDsNEi4deQ5F4JZpANagxOOKFStoJtcWQkB1OBvNulzH/wJGTg6+MRQK2sVZQObJRAIJthF6LYiWAErwCwpQI5zED05VAevmZSTRc4lb9uTrSdWF1FFN04v5DHR9TJD5WXXmNsD10eZMZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=59W9NRMuQ8I7YWzkPy1iaHKAnFRMUvmQvYTJ6k9qBxQ=;
 b=RHw6Vw4Zmcgwhl4V17PfcHnjjHy4t4giNztkVRxg3qff/xQ/gcLjlE9RA+KdR7DLXOVoy6BIz13Vx5aesAGebXZT00Qc2DGxk2vpopkBhxCwS1n+Ch6pZiV7VUTLkSG/Hnjkne7trnBs9H+4Ys6RdAUpmDpbzhwELmNE9HAuCRK+aCsBfgAPj0/4nWnWIHBlIrgUF0yTkdhsfsD/fr9oEBvCm0GuOKrvLuuhpMsRARroQgYaC8FqqRRTdoCXn/bGwoTmAr5sWrC0FXg8gd4qS90Vrb7sZKz//mIG0cE2p4mfMnxaOaoopJ0ftsnWxtPAOvf7xMAZceVrzfIwd0WIwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=59W9NRMuQ8I7YWzkPy1iaHKAnFRMUvmQvYTJ6k9qBxQ=;
 b=I7iFGvmGcpMxlPChiCME78PO70Ywo/Z7LuJYnDLYTsvNGNuokd+KkBQnBTxYSPK1k/JLk8PEY8Y3rvnY1wNIZm4R+6Q9+MQfO5nBOHiVBdorQjZwjzZp7CJCIUiVD2xRz0odnxdz3K2W88EomHJIjAw8+kF7HC7VmYuaeohUGgY=
Received: from BYAPR01CA0017.prod.exchangelabs.com (2603:10b6:a02:80::30) by
 MN0PR12MB6294.namprd12.prod.outlook.com (2603:10b6:208:3c1::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.30; Mon, 10 Jul 2023 14:03:26 +0000
Received: from DM6NAM11FT115.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a02:80:cafe::fe) by BYAPR01CA0017.outlook.office365.com
 (2603:10b6:a02:80::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30 via Frontend
 Transport; Mon, 10 Jul 2023 14:03:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT115.mail.protection.outlook.com (10.13.173.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.19 via Frontend Transport; Mon, 10 Jul 2023 14:03:25 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 10 Jul
 2023 09:03:20 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 10 Jul
 2023 09:03:07 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Mon, 10 Jul 2023 09:03:05 -0500
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: <qemu-devel@nongnu.org>
CC: <frasse.iglesias@gmail.com>, <alistair@alistair23.me>,
 <edgar.iglesias@gmail.com>, <peter.maydell@linaro.org>, <fkonrad@amd.com>,
 <sai.pavan.boddu@amd.com>, <tong.ho@amd.com>, <vikram.garhwal@amd.com>
Subject: [PATCH v1 7/8] hw/arm/xlnx-versal: Connect the CFU_APB,
 CFU_FDRO and CFU_SFR
Date: Mon, 10 Jul 2023 16:02:48 +0200
Message-ID: <20230710140249.56324-8-francisco.iglesias@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230710140249.56324-1-francisco.iglesias@amd.com>
References: <20230710140249.56324-1-francisco.iglesias@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT115:EE_|MN0PR12MB6294:EE_
X-MS-Office365-Filtering-Correlation-Id: 627bd8bc-a45f-42b4-0238-08db814e6dd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SUXeZcTdurJ2H+vZH/b21anWq8yH+eBT5Z6OdpXPwqdOXE1x/HduSXPmKOfvfVQct3p75v9obpg+qtrhQDJdvWWU63C9Dv0JgfC0csWnC4tMlcN53QbYLDgKmy1kcxx6nF20RjWT59GIBtOSShH0efJcDmJOzwjDijoPlO/X+mwwlg1RQX2v1R9dIngPwUfPX3f46ChoSbItLqpl9uw4L7fR1s8WrcrrdFQrZzT+bO9YZapzJN94R+5ZknxuPq2boig/kQldUEItz7dcAOQM3qqIcT6aqjqaB6C2CLDUi81HWBTj9KusYcHs9d+WFne6m0Y5zh0JItdQc4G3vCIutTc3Z0O6or0bQVTN+Y3b5F+E6M5fjfBZEVgSPsVDa+DnqIYePo/5abuPX6bj4YMBvAp91+sKVgnA42zzAhVPI+2C2TShQeaiNFbkVhGAv+m0ufKg2DDAFLLKIU+0yet/Nmnc4DbcYPkXldS6LbAIQ7pjqkNsQLNegrnIhr7NGVggjELEjKDWQrEAB36+odCfToKkipLd35cr+S336ZkiXPQaEejH8rbTqlcsfN+QLjMbIKh/YdfSxkN6RC1KHHMTjAfGgqPfVolZFoS6D9MrEyxOq7zCxD2xuo//05iY4c9NaNhmdrvuKjxByL4apUCcz5CpI/A61hwOqGeLIakD6Ov5A7hWa5K94twyteU7A/qsk2qxaY9iuMswM3f5rz6cJHj4nmeGamP+dBiW+77kmjeTLZA0+tnjCqCxXyERWGu7UwzMLuEMNh0fiJDjlWUDRg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(39860400002)(376002)(136003)(451199021)(40470700004)(46966006)(36840700001)(86362001)(82310400005)(82740400003)(40460700003)(40480700001)(36756003)(6666004)(54906003)(70206006)(70586007)(356005)(81166007)(36860700001)(26005)(186003)(1076003)(2616005)(44832011)(5660300002)(2906002)(316002)(478600001)(8936002)(8676002)(47076005)(336012)(426003)(4326008)(6916009)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 14:03:25.2449 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 627bd8bc-a45f-42b4-0238-08db814e6dd6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT115.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6294
Received-SPF: softfail client-ip=2a01:111:f400:7e8a::62c;
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

Connect the Configuration Frame Unit (CFU_APB, CFU_FDRO and CFU_SFR) to
the Versal machine.

Signed-off-by: Francisco Iglesias <francisco.iglesias@amd.com>
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


