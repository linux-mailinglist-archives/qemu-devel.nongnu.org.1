Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 010DC7B17CF
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 11:46:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlnZS-0005tN-8e; Thu, 28 Sep 2023 05:44:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michal.Orzel@amd.com>)
 id 1qlnZQ-0005s7-G1; Thu, 28 Sep 2023 05:44:32 -0400
Received: from mail-co1nam11on20614.outbound.protection.outlook.com
 ([2a01:111:f400:7eab::614]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michal.Orzel@amd.com>)
 id 1qlnZN-0003Uy-Km; Thu, 28 Sep 2023 05:44:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MVJMoYIGs2qRNK/+rEOp8jHRD4fxsNilChh+vgwBWBA/Q4ZILnBoTrzuHAEt9XtDtomvugh+x3lnsRPWFjKuaIyR0DZ+Kmb/N6WdPEz3/1xI69iBRw0qA39+oPHxUuBTakWe2ARPNaD/X8wmNbfkB3/uLMncy7GGdJc1bp0M6PvIs9y6OwcIiqCt453UM93yUQCvmvcmEc1oQU7gUMk74rBrQX1E69xL4afBHOX/BCNU/Z4Dvw/el/vOBQzo4EbdIGAAH4wVk497hxiqyeWOsGRAY2W6K1pWJe3T2pP9FIzz481oDkAJuo7ljsXcBmVWiOG8y89Ii/X397zX/ibloA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VBhG4PYOSyVLReBeJF4sGzWwRHdIiBYIRSrtyGns0yE=;
 b=AhZn8AgqqvtrQKlLgq+2FNiWUaSjwmiwpOOHOTjyZjshZO0wul07OUKDiyfKnHkhHmG2fflT80uiew7bZ2tNV15Eczo2w7/HKkM4CqIz/D2e6ynprzXyI/vGvwLFZxnoQ63pE4/JJF1gtWnkAd9vx4zmvmKpQYm7lRJmN2qyzf7MAwdh3qYoT2Db8ACxKPR7PPD8UcFynqdSmnIXf/J5+2bP3bjJ1oC1ltlOilw7vvkbSO/rzK/X6J1nWOD8kiMtAY+Q3w0jP/t4ODVOWeOgkQ2taOYHWNDfDrNoL+QNKVG9F4z9NILnekEpTsu66/+pEwJPQH1UOe6j6XySJ7VlYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBhG4PYOSyVLReBeJF4sGzWwRHdIiBYIRSrtyGns0yE=;
 b=G4IAjUTjgAKe+bBS17DZiYRRxRMiFs+AjD39NgIDZpF7JqdwWxgH4R9LfvoG+1zii6nMBR3KhrhxV8ktg16Km0s+rnjtx+AT/QcqXKmbYAwOCMRZ/n3mFfcXIfcy77n0lAS2RBxiPhAEyiAwUGjUKvS3e3BJp9zShCYfiDdQAII=
Received: from DS7PR03CA0330.namprd03.prod.outlook.com (2603:10b6:8:2b::22) by
 SJ0PR12MB6854.namprd12.prod.outlook.com (2603:10b6:a03:47c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22; Thu, 28 Sep
 2023 09:44:24 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:8:2b:cafe::c6) by DS7PR03CA0330.outlook.office365.com
 (2603:10b6:8:2b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25 via Frontend
 Transport; Thu, 28 Sep 2023 09:44:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Thu, 28 Sep 2023 09:44:24 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 28 Sep
 2023 04:44:23 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 28 Sep
 2023 02:44:23 -0700
Received: from XIR-MICHALO-L1.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27
 via Frontend Transport; Thu, 28 Sep 2023 04:44:22 -0500
From: Michal Orzel <michal.orzel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Michal Orzel <michal.orzel@amd.com>, <peter.maydell@linaro.org>,
 <stefano.stabellini@amd.com>, <Oleksandr_Tyshchenko@epam.com>
Subject: [PATCH v2] target/arm: Fix CNTPCT_EL0 trapping from EL0 when
 HCR_EL2.E2H is 0
Date: Thu, 28 Sep 2023 11:44:04 +0200
Message-ID: <20230928094404.20802-1-michal.orzel@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|SJ0PR12MB6854:EE_
X-MS-Office365-Filtering-Correlation-Id: 2df91dcb-5dc7-44e3-8c69-08dbc0077fb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RCYny6Bc/sdAfJUgxtBSS0kL0FIB37QsCn/rRsqFgIFW3SprERQ0+hwfr/9tkGWwPJJfE0KKmMdiFbTpGikVG02C/SdooftilxuR5yf8NeHAxH2oAtr42podFIh23dwECKmYz20iKxry35yGzii+rIO7/mj8qT6sIi08kGWzB1nTdOCcAeuwgSLGRNsiEgxVDnnIL8zI7Qhle+gMoKUYKGwx4zBPj81CfL4JOAiUh7zLl1x9UwmP9S/lLIa/KxprmBIDM5Lmeo25tOBrExHB0b0YwRx3Ks1hAyMfT8jiWkdNGKTr2W2s3qfsiznqJG9Too+vyzejlKNAt1lybHkqAQrJdfDR2gBx9OdD9/na13dMGjvyZBWkF58EdU099jTGS/mP2hxXUV7DCbEvU3MacEJB9/38RFOvyT6LgJMsOKJYVG7T3IITqpxbg9sB7JcW0zotic5rrWy+ot16x3TCADgmBz/MsWjfHNFsCls6sgKyoE8SVQP+NIoIhV+3YNaK9ygAbACuAibUK/m1Ye4oDOXT0dEAH+uXweoiCDETVsXSH9g1J2JzMKWTwS1/5nzoVZI9eDVdug9hU/a2E+ANSigUG34lrphn6oZct9L8KiHXPpz5BKg/g01Fvs7g5LL824P/YF+j+FSsUC7xpHNa+gREKksj0z0TTXm3Bii/NzNtSceHdT7o8YqSV3PSfnJ9ig3YMggCTsKTxYDkawuty4ym8SYGl3mYJEBc4XFl5u6dHIi/VjUUOvPBxUnEGZuqdzyZ4Uq7xZMRv0SUM68GAw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(136003)(346002)(39860400002)(230922051799003)(82310400011)(64100799003)(186009)(1800799009)(451199024)(40470700004)(46966006)(36840700001)(40460700003)(2906002)(6666004)(1076003)(2616005)(110136005)(70206006)(54906003)(70586007)(478600001)(26005)(426003)(86362001)(83380400001)(47076005)(36860700001)(336012)(82740400003)(81166007)(356005)(4326008)(40480700001)(36756003)(5660300002)(44832011)(316002)(8676002)(41300700001)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 09:44:24.2380 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2df91dcb-5dc7-44e3-8c69-08dbc0077fb8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6854
Received-SPF: softfail client-ip=2a01:111:f400:7eab::614;
 envelope-from=Michal.Orzel@amd.com;
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

On an attempt to access CNTPCT_EL0 from EL0 using a guest running on top
of Xen, a trap from EL2 was observed which is something not reproducible
on HW (also, Xen does not trap accesses to physical counter).

This is because gt_counter_access() checks for an incorrect bit (1
instead of 0) of CNTHCTL_EL2 if HCR_EL2.E2H is 0 and access is made to
physical counter. Refer ARM ARM DDI 0487J.a, D19.12.2:
When HCR_EL2.E2H is 0:
 - EL1PCTEN, bit [0]: refers to physical counter
 - EL1PCEN, bit [1]: refers to physical timer registers

Drop entire block "if (hcr & HCR_E2H) {...} else {...}" from EL0 case
and fall through to EL1 case, given that after fixing checking for the
correct bit, the handling is the same.

Fixes: 5bc8437136fb ("target/arm: Update timer access for VHE")
Signed-off-by: Michal Orzel <michal.orzel@amd.com>
---
This is now in conformance to ARM ARM CNTPCT_EL0 pseudocode:
if PSTATE.EL == EL0 then
...
    elif EL2Enabled() && HCR_EL2.E2H == '0' && CNTHCTL_EL2.EL1PCTEN == '0' then
        AArch64.SystemAccessTrap(EL2, 0x18);

Changes in v2:
 - drop block and fall through to avoid duplication
---
 target/arm/helper.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 83620787b453..59576aa1575a 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2475,22 +2475,7 @@ static CPAccessResult gt_counter_access(CPUARMState *env, int timeridx,
         if (!extract32(env->cp15.c14_cntkctl, timeridx, 1)) {
             return CP_ACCESS_TRAP;
         }
-
-        /* If HCR_EL2.<E2H,TGE> == '10': check CNTHCTL_EL2.EL1PCTEN. */
-        if (hcr & HCR_E2H) {
-            if (timeridx == GTIMER_PHYS &&
-                !extract32(env->cp15.cnthctl_el2, 10, 1)) {
-                return CP_ACCESS_TRAP_EL2;
-            }
-        } else {
-            /* If HCR_EL2.<E2H> == 0: check CNTHCTL_EL2.EL1PCEN. */
-            if (has_el2 && timeridx == GTIMER_PHYS &&
-                !extract32(env->cp15.cnthctl_el2, 1, 1)) {
-                return CP_ACCESS_TRAP_EL2;
-            }
-        }
-        break;
-
+        /* fall through */
     case 1:
         /* Check CNTHCTL_EL2.EL1PCTEN, which changes location based on E2H. */
         if (has_el2 && timeridx == GTIMER_PHYS &&
-- 
2.25.1


