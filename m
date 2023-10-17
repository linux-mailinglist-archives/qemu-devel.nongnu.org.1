Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 072C57CCDFF
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 22:27:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsqdw-0007ri-2U; Tue, 17 Oct 2023 16:26:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1qspzw-00049O-Oa; Tue, 17 Oct 2023 15:45:01 -0400
Received: from mail-co1nam11on20617.outbound.protection.outlook.com
 ([2a01:111:f400:7eab::617]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1qspzu-0000we-Q4; Tue, 17 Oct 2023 15:45:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fSUucduPI4ln0uXWqADIRB5sN+iWGINwIka/qmspk53AUDtguG8/f1Os1BhXC4j0I0LCV/V2b9Lp2EhPuyB7xBYJedexADI6rpxOR3GkPT7wf19X4AtqkS1u4Kk25dn89uvSuzgJiwTfxRQHMRLdSJauxOLDmbSdVL8DDb6xDXaZ5uZR+1hQCVmtfbMILdZf6KqCTjSKb6JQsAjL0TKzgjQ6rhymnmrfpT5X+fLGQYggutPUmjTHk0DSci4ShvEiF8z8FDZ2EYrG5QaEsp+BSq4q040tGwdukj+4eiwi8sBz8LD4GawCHUKZaKSVFYMKan2OmudnoKSqQHC0KqXrAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B8wOwCMCkWcF4Sh7h+hGbl+VaPfZFfAD2B7Go4oVsEo=;
 b=ndwI4sN2Mwr/lzk0toRZ3S4J7CfBHccyLaYTJV1nIQXzUtwzC7e9cGH6BXDL/ja6R8N/DnaU0eVtPyoyUXlutcUA8PJ9se3JmzDN7jM1W4W2H+bMkjlrFYyQ6YNXbWIfcBQXSCsL5wTDNfCaF1nw7TldtCeQN2TbolT7agQ+tiqP7bGCKVPdhQ3ImQtsJi6DipqXnaXY6wFFO5zeI41MfC+yyBChrEWSX1pdf4K5efMI5m+nSMPhCg8wslloZu88vGN6WKkdzdcEbCZc30okSijqkSJuxHhM3eFgSJ60j0dxRmYquAjfDMmQAp3wPt5yG9a5G5zd4JZS+pjFJ/JITA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8wOwCMCkWcF4Sh7h+hGbl+VaPfZFfAD2B7Go4oVsEo=;
 b=NHrulppu91rBsCIvDThOW3nM8T4tjsUmJvP1O1CcZ/fZ4qgcJYL31s84hQZK1qWyihkbz7InLCkmI2RDtFkdPlOaMpgfozAuu+oxVljAw+cp1wsAE4pyVZqEzxOPl9tdp1ZcETnQfiwfD9YbG0xBmOVUEVx6k5l8mYUSb1VDF3A=
Received: from BYAPR02CA0008.namprd02.prod.outlook.com (2603:10b6:a02:ee::21)
 by CY8PR12MB7514.namprd12.prod.outlook.com (2603:10b6:930:92::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 19:44:53 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:a02:ee:cafe::56) by BYAPR02CA0008.outlook.office365.com
 (2603:10b6:a02:ee::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
 Transport; Tue, 17 Oct 2023 19:44:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.23 via Frontend Transport; Tue, 17 Oct 2023 19:44:53 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 17 Oct
 2023 14:44:52 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 17 Oct
 2023 14:44:52 -0500
Received: from luc-work-vm.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 17 Oct 2023 14:44:48 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, <qemu-arm@nongnu.org>, "Edgar E .
 Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis
 <alistair@alistair23.me>, Peter Maydell <peter.maydell@linaro.org>, "Jason
 Wang" <jasowang@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Francisco Iglesias <francisco.iglesias@amd.com>,
 Frederic Konrad <frederic.konrad@amd.com>, Sai Pavan Boddu
 <sai.pavan.boddu@amd.com>
Subject: [PATCH 09/11] hw/net/cadence_gem: use FIELD to describe PHYMNTNC
 register fields
Date: Tue, 17 Oct 2023 21:44:20 +0200
Message-ID: <20231017194422.4124691-10-luc.michel@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231017194422.4124691-1-luc.michel@amd.com>
References: <20231017194422.4124691-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|CY8PR12MB7514:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a509ef5-6b19-4293-7c2d-08dbcf4988a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p0MfGPe/Cd4+760casBLalJ+10gLrnNGImSJKjYEPnNTP9iZtvxkEbosVRNuelz60+p8F1+Ukh8LF7VDwXD2ABWTQKSoYtjQ71ZGgSsx5jrf8BT1kwXeh/JI6MjkLeTG1iSK48XZYWvLBo4ZqUYJAMxWDYTLM9E+eFjli31X15TeA0PTjKLNHaSHEWml6NXD7ywjU1CF8+CgKzc45IooZW5GtNL5NH9z/9sm9hM8lUUUT7jGnqEgW7Wi2fWghVE5gPEbUDb+ugZfV/4rzCoC2xOQsc6NXvJXbHR0yXxqbZlzdZO/7crKk1p/n7wInsz8kVF8ml+qlUzKLPr8F/4M+qLjgWAqQSfQ9nMrowJJgUnKndFZ493oWueNqzbuSR9BcGKXTH8gxn4iOyEmSvMHecen4eCJPk2VWcZygx3kzHO7G1nNeY1z/Y7VPIJTwyuOClrGr4yYN5JS9cBPC7z59K0iS0rr9MeA9g6tIKpunwKU0F2exPCGD3wYqg6EduANvYUVcDs5+j1HXZ1B0/pBvzeFz6aI75oOmmdrBWsYtDowsVFQ4DE0mxrFhnbBYgfJKYvPvdy354RN5IYY5woHBS3J/zQ8OdK9SexYi59Q+Pu31q3VAKrFUn9v1drHAFJLyG3ZqfrWBchNrvpJ7aMkoWEXk6OR8iYekVztFzKMPlsdaFk97g8tieCbOelywGpxpLLRJsd+34RIBrQ0ZWJjt/d/xd50HH4gzjslcGtXDdFhtEFnNHu7nggee6B3aabrL71KX6sD6WNFwfTQOHsJRA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(451199024)(82310400011)(186009)(64100799003)(1800799009)(46966006)(40470700004)(36840700001)(336012)(40480700001)(40460700003)(82740400003)(47076005)(81166007)(356005)(36860700001)(6666004)(83380400001)(36756003)(2906002)(54906003)(6916009)(316002)(426003)(70206006)(1076003)(2616005)(478600001)(70586007)(44832011)(26005)(86362001)(41300700001)(8936002)(8676002)(5660300002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 19:44:53.3406 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a509ef5-6b19-4293-7c2d-08dbcf4988a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7514
Received-SPF: softfail client-ip=2a01:111:f400:7eab::617;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 17 Oct 2023 16:26:01 -0400
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

Use the FIELD macro to describe the PHYMNTNC register fields.

Signed-off-by: Luc Michel <luc.michel@amd.com>
---
 hw/net/cadence_gem.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 955a8da134..4c5fe10316 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -192,10 +192,18 @@ REG32(ISR, 0x24) /* Interrupt Status reg */
 REG32(IER, 0x28) /* Interrupt Enable reg */
 REG32(IDR, 0x2c) /* Interrupt Disable reg */
 REG32(IMR, 0x30) /* Interrupt Mask reg */
 
 REG32(PHYMNTNC, 0x34) /* Phy Maintenance reg */
+    FIELD(PHYMNTNC, DATA, 0, 16)
+    FIELD(PHYMNTNC, REG_ADDR, 18, 5)
+    FIELD(PHYMNTNC, PHY_ADDR, 23, 5)
+    FIELD(PHYMNTNC, OP, 28, 2)
+    FIELD(PHYMNTNC, ST, 30, 2)
+#define MDIO_OP_READ    0x3
+#define MDIO_OP_WRITE   0x2
+
 REG32(RXPAUSE, 0x38) /* RX Pause Time reg */
 REG32(TXPAUSE, 0x3c) /* TX Pause Time reg */
 REG32(TXPARTIALSF, 0x40) /* TX Partial Store and Forward */
 REG32(RXPARTIALSF, 0x44) /* RX Partial Store and Forward */
 REG32(JUMBO_MAX_LEN, 0x48) /* Max Jumbo Frame Size */
@@ -340,17 +348,10 @@ REG32(TYPE2_COMPARE_0_WORD_1, 0x704)
 
 /*****************************************/
 
 
 
-#define GEM_PHYMNTNC_OP_R      0x20000000 /* read operation */
-#define GEM_PHYMNTNC_OP_W      0x10000000 /* write operation */
-#define GEM_PHYMNTNC_ADDR      0x0F800000 /* Address bits */
-#define GEM_PHYMNTNC_ADDR_SHFT 23
-#define GEM_PHYMNTNC_REG       0x007C0000 /* register bits */
-#define GEM_PHYMNTNC_REG_SHIFT 18
-
 /* Marvell PHY definitions */
 #define BOARD_PHY_ADDRESS    0 /* PHY address we will emulate a device at */
 
 #define PHY_REG_CONTROL      0
 #define PHY_REG_STATUS       1
@@ -1539,16 +1540,16 @@ static uint64_t gem_read(void *opaque, hwaddr offset, unsigned size)
     case R_ISR:
         DB_PRINT("lowering irqs on ISR read\n");
         /* The interrupts get updated at the end of the function. */
         break;
     case R_PHYMNTNC:
-        if (retval & GEM_PHYMNTNC_OP_R) {
+        if (FIELD_EX32(retval, PHYMNTNC, OP) == MDIO_OP_READ) {
             uint32_t phy_addr, reg_num;
 
-            phy_addr = (retval & GEM_PHYMNTNC_ADDR) >> GEM_PHYMNTNC_ADDR_SHFT;
+            phy_addr = FIELD_EX32(retval, PHYMNTNC, PHY_ADDR);
             if (phy_addr == s->phy_addr) {
-                reg_num = (retval & GEM_PHYMNTNC_REG) >> GEM_PHYMNTNC_REG_SHIFT;
+                reg_num = FIELD_EX32(retval, PHYMNTNC, REG_ADDR);
                 retval &= 0xFFFF0000;
                 retval |= gem_phy_read(s, reg_num);
             } else {
                 retval |= 0xFFFF; /* No device at this address */
             }
@@ -1662,16 +1663,16 @@ static void gem_write(void *opaque, hwaddr offset, uint64_t val,
     case R_SPADDR3HI:
     case R_SPADDR4HI:
         s->sar_active[(offset - R_SPADDR1HI) / 2] = true;
         break;
     case R_PHYMNTNC:
-        if (val & GEM_PHYMNTNC_OP_W) {
+        if (FIELD_EX32(val, PHYMNTNC, OP) == MDIO_OP_WRITE) {
             uint32_t phy_addr, reg_num;
 
-            phy_addr = (val & GEM_PHYMNTNC_ADDR) >> GEM_PHYMNTNC_ADDR_SHFT;
+            phy_addr = FIELD_EX32(val, PHYMNTNC, PHY_ADDR);
             if (phy_addr == s->phy_addr) {
-                reg_num = (val & GEM_PHYMNTNC_REG) >> GEM_PHYMNTNC_REG_SHIFT;
+                reg_num = FIELD_EX32(val, PHYMNTNC, REG_ADDR);
                 gem_phy_write(s, reg_num, val);
             }
         }
         break;
     }
-- 
2.39.2


