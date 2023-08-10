Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C6677813D
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 21:17:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUB9k-0000Yv-BU; Thu, 10 Aug 2023 15:17:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1qUB9P-0000Rf-L3
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 15:16:53 -0400
Received: from mail-mw2nam12on20611.outbound.protection.outlook.com
 ([2a01:111:f400:fe5a::611]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1qUB9M-00074g-T4
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 15:16:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZF0geZJ4cc31g1B0st0q6x1lTHsQYftTgkpb0ujLq5lIu9wosNfN0KKgN84P+iAMF/i3w8H2GgSnDkpBcmGub/CMZ7UZsuswYK9J+5pIPMVJ2lE35DaTaeUnOZPJrEXwheAwu6QBm69WHbdkDRp3EYLsn28zyV5lj56Qh2SkeqrTgSVPDL+PgPxY+ulbX4LdqfxpdZ/FsySwCvkxf2fPdOPdzv2tURWx++wb+Cn1dyfIv6iUPT9pcC1/xMDvXRQimBICoC7iqFIt1FnX3Qt4bTuDYUtnmsxpBFiCAL2k4uufCUUES1yYoat4RkFj8gy1zJ3nKQvpfvKCH5f/ILbuZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQ+lddYVIVTyHUZJvwGaDUPTBiw80FboOA1+/NRIf+w=;
 b=jfR2xsCu+0y7ZRGyJwqlLqQ/OTq/+mpixBGewgw76HvP3QLoTwr7BdHKU52+vtU6HCmrzrYXEbuUdilanmzZDq4ekxkmaOlzoqgZXbh7b8QQDymtYJt23pzmjM8Tci0XTBlf0UhQeM2nxG/Tv2tHdgwFoNRlDxzxcURFGbyyb2NaiGD4EP4PA6PpH8MRmuo7TB4tjFs8pAWMRFezpviN/iBqv7MejK9kqM1vsNtDmLEiGDmteQ7XJte3vdtsNbRUNjaSKYZjtJm0vevsQMq/EEKcNO7PAh1R5GNubGuy7gsPddL0IGp5sC2K+EZJ+VFXstHNLjtMLBGy+NcEKRRBUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQ+lddYVIVTyHUZJvwGaDUPTBiw80FboOA1+/NRIf+w=;
 b=UpUrqx35TvamPeCEsw2x8wMC8ufCxC7fpHWIpu+UZ2tqBHLgAco1sYm5esl4XuhUbDyAsiXF0KUKQqfvhY3f7uDCSq3oiO3H1HTCFR1n5HRVbsuZRn4bO6YDLtR+P91cBy+CtIcGX70xeoGV4Ub46D9KAaRs7BHYBnAGE+C9ZiQ=
Received: from CYZPR12CA0013.namprd12.prod.outlook.com (2603:10b6:930:8b::6)
 by IA1PR12MB6385.namprd12.prod.outlook.com (2603:10b6:208:38b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 19:16:44 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:930:8b:cafe::3c) by CYZPR12CA0013.outlook.office365.com
 (2603:10b6:930:8b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30 via Frontend
 Transport; Thu, 10 Aug 2023 19:16:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.78) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Thu, 10 Aug 2023 19:16:43 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 14:16:42 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 10 Aug 2023 14:16:41 -0500
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: <qemu-devel@nongnu.org>
CC: <frasse.iglesias@gmail.com>, <alistair@alistair23.me>,
 <edgar.iglesias@gmail.com>, <peter.maydell@linaro.org>, <fkonrad@amd.com>,
 <sai.pavan.boddu@amd.com>, <tong.ho@amd.com>, <vikram.garhwal@amd.com>
Subject: [PATCH v2 7/8] hw/arm/xlnx-versal: Connect the CFU_APB,
 CFU_FDRO and CFU_SFR
Date: Thu, 10 Aug 2023 21:16:25 +0200
Message-ID: <20230810191626.81084-8-francisco.iglesias@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810191626.81084-1-francisco.iglesias@amd.com>
References: <20230810191626.81084-1-francisco.iglesias@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|IA1PR12MB6385:EE_
X-MS-Office365-Filtering-Correlation-Id: 42bb9da0-91ca-45e8-b4bf-08db99d65557
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W/Ew9hRO4/xl2CfBDejygtG15xFPfgDci3GvzyI0TRcWTcexYq8I+REmCkIF2r3++b3LsdyMJycndct6jBaSTnDsWB2vwDLdpxDYBB4WkORqeqbkGyeOKBQxHPuZPU8ziMQbsbDeHFF6wrT95WyoR/7Lz00MSxffBZYyl9L2iyE8Y/s7GBq/pVtDLImOE2GBmEjmfXDNIOdOf6lA45l8UaPwFl69aghDdHx63SnUPlmrkeXwwvBwGOJpdLuXeIir+kstOqUWrHvQI5ESZk0HMsr+RmKJnFX+Q4igwjNM5dN9J2bmDNMFa+oOR+o9m8VfCV5HdPqEdH9qYuDBYt5BWOkcYbKnzdpd3iSHruMaBSEA7OcRkgsy7n7xyBJGFo+M1BUhlpo3qHRJaGjGirbmqjrZB+NbxkVnQla40t6I4y8KCvqGB7oN97I34UQsBrROQZTJOB1NL28xXfMnQf4HHlUoJdd/lR0hN6BxMsCnwUW9MDip08DQ+HaslyaUKN9O3V3mwrITYkCWa4HXFbHobe7dytPpdEkcqXA9N48JYFd1gVD3ckjFkF6t8mUhfr83tgURl2Lm9vJTq57T3/FRfy71zlMOUDo6xKj9F8ERqWZ2okouIzQdufIWuzgOuLm0A4Vv7TQNl2UtNk/yPepSAYcNv7dlgqFVmaC8yMKcVjWhv/7FtqDE9cjEhRIEsiOyv7ZhtLkVcN7PL5kE9yr/KzlFFZyRVepmvHmlvbKzRXCUtTrnVU5ToQOtTwkIRmHkeMVOjH8YL9tseBL79tsFMA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(346002)(136003)(39860400002)(82310400008)(1800799006)(451199021)(186006)(36840700001)(46966006)(40470700004)(8676002)(8936002)(26005)(1076003)(41300700001)(40460700003)(36860700001)(47076005)(36756003)(426003)(2906002)(2616005)(81166007)(356005)(82740400003)(86362001)(44832011)(40480700001)(336012)(5660300002)(70206006)(70586007)(6916009)(4326008)(6666004)(478600001)(54906003)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 19:16:43.5825 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42bb9da0-91ca-45e8-b4bf-08db99d65557
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6385
Received-SPF: softfail client-ip=2a01:111:f400:fe5a::611;
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


