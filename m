Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A58D37F7665
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 15:36:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6XHR-0007t7-4E; Fri, 24 Nov 2023 09:35:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Frederic.Konrad@amd.com>)
 id 1r6XHO-0007sK-6v; Fri, 24 Nov 2023 09:35:38 -0500
Received: from mail-bn7nam10on20626.outbound.protection.outlook.com
 ([2a01:111:f400:7e8a::626]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Frederic.Konrad@amd.com>)
 id 1r6XHL-0006ye-TH; Fri, 24 Nov 2023 09:35:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lpdZVZprRNob5S6MaJpsoNDDE1j6RD1aRj498i+gw4gqdzu8W3gfnBRdogUoVZd5q6Iy27TmjurJWs+LCtsBHrhI8h7ZBj39bL1KkzImzOMUh/QvzZ1g6ccafAs53HDaF12/CmaPhCZdOgnibAq1zdwM2jCrBwnkw/6bO4/g/2aGn860bWMe/0ea782ncHlvIvugb7/VkM3e3z/86Ad/K+cwPihHIpW5W3EDhD8bbrcEb8wGs2kwRArl+M+f7pcxU7Coe/Knh5MhyK1QMaFqhlz1DhsWSmrqUTkzf7YmBW1kH2bq4C78sRJXqVICQq80Mefin15Gylpswz5a1bADAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0gUDrkNNF1NhIW+YDTppB7l7BtdzkNpoSiaOr/zDyX0=;
 b=bKW8G+OZJcwG1mG0AMPfMdSN6oGHc2PGYaHi/oF7lHT+SoNTfIjwxVSMlKIMI0ruKgbFUumyKCbM2C5nutmvlAvxiw2zeAcfEDY5zES4wA3BLaLJyJVUZ599jOWMOGdeMcFdcWuf7qDxImFijgVbULitNqCpNQ5U3Q1rBGdv2CnpjsPIthIHT0afHvJGWY9DvcII1Uh7H92sTInRJfSsFo51lT0Iia21BStj+buBOKwpbDSqJt3G/YYGXHLDP81IMxqTTnD7klq/xlgZwg90rk2afC6eZpEZUYY/buGs1met9H/SUcfO5znGzTJH7pWC3Y5mBmIqdLNXZFYSnU7r6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gUDrkNNF1NhIW+YDTppB7l7BtdzkNpoSiaOr/zDyX0=;
 b=zHXjO93/ZZHph7whbTTCG+mMJWw1n7W9i44JG72tsIg/z30l4ccDyslEOw/bSIACdYjZZjGjAoROwSWdNCJDLp6FWBVRXk9tHfnsNB/ZNKouX82fwxdU/QzsWR3KqI12d/zIXJwpCgGhDrzKCNl2+Vq9e363Sv/bPFP8feNELjo=
Received: from CH2PR10CA0013.namprd10.prod.outlook.com (2603:10b6:610:4c::23)
 by BL1PR12MB5077.namprd12.prod.outlook.com (2603:10b6:208:310::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.21; Fri, 24 Nov
 2023 14:35:29 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::71) by CH2PR10CA0013.outlook.office365.com
 (2603:10b6:610:4c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20 via Frontend
 Transport; Fri, 24 Nov 2023 14:35:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.13 via Frontend Transport; Fri, 24 Nov 2023 14:35:28 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 24 Nov
 2023 08:35:28 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 24 Nov
 2023 06:35:28 -0800
Received: from xdcsswbld02.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Fri, 24 Nov 2023 08:35:27 -0600
From: Frederic Konrad <fkonrad@amd.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-arm@nongnu.org>, <francisco.iglesias@amd.com>,
 <peter.maydell@linaro.org>, <edgar.iglesias@gmail.com>,
 <alistair@alistair23.me>, <luc.michel@amd.com>, <fkonrad@amd.com>
Subject: [PATCH v1 1/3] hw/ssi/xilinx_spips: fix an out of bound access
Date: Fri, 24 Nov 2023 14:35:03 +0000
Message-ID: <20231124143505.1493184-2-fkonrad@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231124143505.1493184-1-fkonrad@amd.com>
References: <20231124143505.1493184-1-fkonrad@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|BL1PR12MB5077:EE_
X-MS-Office365-Filtering-Correlation-Id: 52c04aed-1bff-4849-5004-08dbecfa9b10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AXdTe7VfChfJguJN+Ev36N5ClOUJ4H6CGutFzHMRIMScbj7kjEEc3DTV6bNdD5W1EpqR0oiDG+34Tpcgwq7oVBRkNAluRCaEs21z30WUp8YuVrytAzCuVeVTljSQ4+uaDfCJ7pADg45gtMeyJQEcNJYkt9epTJmzXp3F44XjoJ+jJaFAOUbCC+NUvcXAZhOUm3Nqi6ZdCIzum1lIKG9EaP+WyE4z7T4P5Ji1Qel9HoCKEMWAch4CdTiO/DcZZ74N6TOnPmkZWYg1SBDOiJw3eqdowAXcsk78wcM7qqcfNNU0HBZvhlOK9gYlmA3udlXdBq8wr42wA2OWAAIFvDkzXyFH+cUfu7iOl/VxrwdY9c+VqUABs7N7XBEFa4eqdtlLWcxCQwSib+IrmKnISyXDoSoELE8bBDxQ6d7GPOdwJ3lnC2tYK9GeSI/aIctbE+QyPpOCYiad9AB0rU+Lmh9mLuhdn+OQnvLY2sG/WaDnPRZmKyypzI9dtFXB7PjMfXpOwxPTKkyKfMfsL2cYg6rXLhgXtKXGvZdUPWRiyZH0lCXPPBrVjuJf8W6qzkGyuNyXMUIOco2mxKzyg6nsBN6VhehxdfixC67JBmL/AZcBSqswNzGt9HIj8akO3+kgW8LtaoJRVS0lPAA0IATbMmkUyl76tkewR0i7zrVFwN3SAJPbRqvYCD55FybXAuozK2hoWZKYU4f9X7KbT593TfJfKUCrOOxKEEZY4e+bhpTb/qVo+K8KbTJubl6T84fdi3RRvsfKvjv3SnwWvbTTMXED6w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(39850400004)(346002)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(82310400011)(40470700004)(36840700001)(46966006)(1076003)(2906002)(5660300002)(26005)(2616005)(47076005)(40460700003)(70206006)(70586007)(6666004)(54906003)(6916009)(36756003)(40480700001)(36860700001)(83380400001)(81166007)(4326008)(316002)(8676002)(8936002)(41300700001)(478600001)(336012)(356005)(82740400003)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2023 14:35:28.9792 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52c04aed-1bff-4849-5004-08dbecfa9b10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5077
Received-SPF: softfail client-ip=2a01:111:f400:7e8a::626;
 envelope-from=Frederic.Konrad@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The spips, qspips, and zynqmp-qspips share the same realize function
(xilinx_spips_realize) and initialize their io memory region with different
mmio_ops passed through the class.  The size of the memory region is set to
the largest area (0x200 bytes for zynqmp-qspips) thus it is possible to write
out of s->regs[addr] in xilinx_spips_write for spips and qspips.

This fixes that wrong behavior.

Reviewed-by: Luc Michel <luc.michel@amd.com>
Signed-off-by: Frederic Konrad <fkonrad@amd.com>
---
 hw/ssi/xilinx_spips.c         | 7 ++++++-
 include/hw/ssi/xilinx_spips.h | 3 +++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index a3955c6c50..0bdfad7e2e 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -973,6 +973,8 @@ static void xilinx_spips_write(void *opaque, hwaddr addr,
 
     DB_PRINT_L(0, "addr=" HWADDR_FMT_plx " = %x\n", addr, (unsigned)value);
     addr >>= 2;
+    assert(addr < XLNX_SPIPS_R_MAX);
+
     switch (addr) {
     case R_CONFIG:
         mask = ~(R_CONFIG_RSVD | MAN_START_COM);
@@ -1299,7 +1301,7 @@ static void xilinx_spips_realize(DeviceState *dev, Error **errp)
     }
 
     memory_region_init_io(&s->iomem, OBJECT(s), xsc->reg_ops, s,
-                          "spi", XLNX_ZYNQMP_SPIPS_R_MAX * 4);
+                          "spi", xsc->reg_size);
     sysbus_init_mmio(sbd, &s->iomem);
 
     s->irqline = -1;
@@ -1435,6 +1437,7 @@ static void xilinx_qspips_class_init(ObjectClass *klass, void * data)
 
     dc->realize = xilinx_qspips_realize;
     xsc->reg_ops = &qspips_ops;
+    xsc->reg_size = XLNX_SPIPS_R_MAX * 4;
     xsc->rx_fifo_size = RXFF_A_Q;
     xsc->tx_fifo_size = TXFF_A_Q;
 }
@@ -1450,6 +1453,7 @@ static void xilinx_spips_class_init(ObjectClass *klass, void *data)
     dc->vmsd = &vmstate_xilinx_spips;
 
     xsc->reg_ops = &spips_ops;
+    xsc->reg_size = XLNX_SPIPS_R_MAX * 4;
     xsc->rx_fifo_size = RXFF_A;
     xsc->tx_fifo_size = TXFF_A;
 }
@@ -1464,6 +1468,7 @@ static void xlnx_zynqmp_qspips_class_init(ObjectClass *klass, void * data)
     dc->vmsd = &vmstate_xlnx_zynqmp_qspips;
     device_class_set_props(dc, xilinx_zynqmp_qspips_properties);
     xsc->reg_ops = &xlnx_zynqmp_qspips_ops;
+    xsc->reg_size = XLNX_ZYNQMP_SPIPS_R_MAX * 4;
     xsc->rx_fifo_size = RXFF_A_Q;
     xsc->tx_fifo_size = TXFF_A_Q;
 }
diff --git a/include/hw/ssi/xilinx_spips.h b/include/hw/ssi/xilinx_spips.h
index 1386d5ac8f..7a754bf67a 100644
--- a/include/hw/ssi/xilinx_spips.h
+++ b/include/hw/ssi/xilinx_spips.h
@@ -33,7 +33,9 @@
 
 typedef struct XilinxSPIPS XilinxSPIPS;
 
+/* For SPIPS, QSPIPS.  */
 #define XLNX_SPIPS_R_MAX        (0x100 / 4)
+/* For ZYNQMP_QSPIPS.  */
 #define XLNX_ZYNQMP_SPIPS_R_MAX (0x200 / 4)
 
 /* Bite off 4k chunks at a time */
@@ -125,6 +127,7 @@ struct XilinxSPIPSClass {
     SysBusDeviceClass parent_class;
 
     const MemoryRegionOps *reg_ops;
+    uint64_t reg_size;
 
     uint32_t rx_fifo_size;
     uint32_t tx_fifo_size;
-- 
2.25.1


