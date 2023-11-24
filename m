Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CABD7F7669
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 15:37:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6XHb-0007uN-Hu; Fri, 24 Nov 2023 09:35:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Frederic.Konrad@amd.com>)
 id 1r6XHS-0007u0-Ua; Fri, 24 Nov 2023 09:35:42 -0500
Received: from mail-dm6nam11on20629.outbound.protection.outlook.com
 ([2a01:111:f400:7eaa::629]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Frederic.Konrad@amd.com>)
 id 1r6XHQ-00070o-QS; Fri, 24 Nov 2023 09:35:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IdHI22sxaPYV2vw3lg9LJffEgxHzm7qm2cK0ulM59CcXoZxgvzIv7hrGAXxOtJm1qMQ10f9Sv7DQ7asRltXPYNaJWo3XIatgeGuPLJQwEEJSma6jHXrV85tyaoWycle9kBu6Ri+gIHIzxbTiODMCEAp1yebaitDHje9Jm9/WlbM8ryc6Hz6kwto/ngg/OVGvR0GWmqWe87h6JRG1CrTDyF0FA0lY9PUc/Ru4fnuwSYh4NUIgI0Q+7VCwm2och4dqwRJ5RvcBvHBe1/B0uewEH1mQeh+rj04z3/UjmHXe/mhCnfJYzb5GUxX4IhHmUiJyeLo9UrsDE1llrYTgmApRKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YGJ0ngFxcPwqdEA54FWd9cpmIgU9Oyv8OYZ4rpULu0k=;
 b=OMQQhvihYMj8U0H5Oj01vtp/umUKpGS93B0ZLT1J2JnvWoehLkom/eE8BK7tNxWhMI05tvhRl0Zru2uJn6PwJgQUtPIyj/pZHdIjkJJl+t9kQFB8iCq0EcSdaEVRZs5MBECrturErmL/26VgQFgLNLo56OXoo3Qu5hh9mF6nDLrLW5HUH7tMxoq4ZIoQvxO3Cq/R3J7kg6GvOeyHX+qb0Q+pZHP2oS9vTwts1/PVYrJm7g7ECqqohP3/t7qaeQHk0rERgV2IoxUvVg5x4J3ZKom4Le4ldZZE4uw6b1FlYYxXJTm5t8+u4glnoniqGgA+BSBoep84ANY9jR40Ezuilg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YGJ0ngFxcPwqdEA54FWd9cpmIgU9Oyv8OYZ4rpULu0k=;
 b=tbIChjPQ8BbzQmwyKWfYeWG+0lHfCk9tXPUC6+6ooDRl/WvTvGEyym40qLfXGnfkHJDtIFRMXjI45gsCHQcODLxSSaQLd9RIChjnIPnipMe6jz+rIlrTymBO73agZKUZcVFwVp7mT9GkBJh0ls7CTptgATDawf5m2EbkRpSJvJ8=
Received: from BN1PR12CA0010.namprd12.prod.outlook.com (2603:10b6:408:e1::15)
 by SA1PR12MB8600.namprd12.prod.outlook.com (2603:10b6:806:257::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.22; Fri, 24 Nov
 2023 14:35:35 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:408:e1:cafe::7a) by BN1PR12CA0010.outlook.office365.com
 (2603:10b6:408:e1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19 via Frontend
 Transport; Fri, 24 Nov 2023 14:35:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Fri, 24 Nov 2023 14:35:34 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 24 Nov
 2023 08:35:33 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 24 Nov
 2023 06:35:33 -0800
Received: from xdcsswbld02.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Fri, 24 Nov 2023 08:35:32 -0600
From: Frederic Konrad <fkonrad@amd.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-arm@nongnu.org>, <francisco.iglesias@amd.com>,
 <peter.maydell@linaro.org>, <edgar.iglesias@gmail.com>,
 <alistair@alistair23.me>, <luc.michel@amd.com>, <fkonrad@amd.com>
Subject: [PATCH v1 2/3] fix some url for amd / xilinx models
Date: Fri, 24 Nov 2023 14:35:04 +0000
Message-ID: <20231124143505.1493184-3-fkonrad@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231124143505.1493184-1-fkonrad@amd.com>
References: <20231124143505.1493184-1-fkonrad@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|SA1PR12MB8600:EE_
X-MS-Office365-Filtering-Correlation-Id: e957f861-2451-463b-09e6-08dbecfa9e80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rwQXuTpgOP3Ytmc42zo7LjyuWEg1kpMw8+Ev1zZhUcNfy75OU9Vea+nG53Muj161ZR0KOl+QkfZhxQkaFW3o6Em+26Dhzm2CxCq4IkdV9iK2u2s6/tfvG0FdzQ60Jo0bEdtmNUK4tI0OpkuWHvnAS8Hvw/sDh/XA9vULGX893vGlouosZ5ze0Emd7H+8krcviFzoSh4YBV2HZ0QYarQzthswZ3IM8PvgeThzGDybd0gNnKADgzeSSO3twdAu7+ChZvvUaMCsPbNtgbz+YOvDBJDv4NJ+bRSDQaCwBYZ5F1KRlUV4UjplmlxSdQTUk2sjjq40lF9IjPOkArhl6IulKfulY9jOc++Mh3IomJlwTB4X8kB2/W7ue3c3H68Ch1MRVM6JgIQm+A9blHNNvJJalhiYDA0wTMJHQzMf85jvbJy7b0CEjLGHagg2uWvucSoS5lYZIcFnaZX3DRuhzhqtXAhB2duZbiZOZ1bOmZDg61a/IaTnERF3V1LL8twb5YjMnyNEm3w7CAIa3UnL2FRW2LqNGq5y0XKrBOmYx68hZvf7jn+IOzK3E7Cr2hlC7+S6+ZwTFeDqTO1rnLiAJNf04DXBpfTKBXgz78e63v8pEr5zbv0+wNp23mSoKOE9d2Q2sSXUzc3jtiPeJDc1xyYlfdb+IpNvfq5S3FA51qGAEdQANdTr7bslvvO8ca8WYhJFUxuWjPIXSxmloVxklwKvifyIWyhA13o+qYn36rJO+RlbzyNoDnOvAbmdkCRkVfoeL9I9jIFZ5krrZ7XJ20nUbKwzUI+rrGKGTtuUHK+9XyZ+66THWf6ixymkk+6COkaDjoz+pDF67skhwMt9xDZjmg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(136003)(376002)(346002)(230922051799003)(451199024)(186009)(82310400011)(64100799003)(1800799012)(40470700004)(36840700001)(46966006)(40460700003)(316002)(6916009)(54906003)(83380400001)(47076005)(36860700001)(4326008)(8676002)(8936002)(5660300002)(478600001)(82740400003)(966005)(36756003)(40480700001)(41300700001)(2616005)(356005)(81166007)(6666004)(1076003)(70586007)(70206006)(426003)(336012)(2906002)(26005)(170073001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2023 14:35:34.7758 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e957f861-2451-463b-09e6-08dbecfa9e80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8600
Received-SPF: softfail client-ip=2a01:111:f400:7eaa::629;
 envelope-from=Frederic.Konrad@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
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

It seems that the url changed a bit, and it triggers an error.  Fix the URLs so
the documentation can be reached again.

Signed-off-by: Frederic Konrad <fkonrad@amd.com>
---
 hw/dma/xlnx_csu_dma.c                      | 2 +-
 include/hw/misc/xlnx-versal-cframe-reg.h   | 2 +-
 include/hw/misc/xlnx-versal-cfu.h          | 2 +-
 include/hw/misc/xlnx-versal-pmc-iou-slcr.h | 2 +-
 include/hw/ssi/xlnx-versal-ospi.h          | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/dma/xlnx_csu_dma.c b/hw/dma/xlnx_csu_dma.c
index e89089821a..531013f35a 100644
--- a/hw/dma/xlnx_csu_dma.c
+++ b/hw/dma/xlnx_csu_dma.c
@@ -33,7 +33,7 @@
 
 /*
  * Ref: UG1087 (v1.7) February 8, 2019
- * https://www.xilinx.com/html_docs/registers/ug1087/ug1087-zynq-ultrascale-registers.html
+ * https://www.xilinx.com/html_docs/registers/ug1087/ug1087-zynq-ultrascale-registers
  * CSUDMA Module section
  */
 REG32(ADDR, 0x0)
diff --git a/include/hw/misc/xlnx-versal-cframe-reg.h b/include/hw/misc/xlnx-versal-cframe-reg.h
index a14fbd7fe4..0091505246 100644
--- a/include/hw/misc/xlnx-versal-cframe-reg.h
+++ b/include/hw/misc/xlnx-versal-cframe-reg.h
@@ -12,7 +12,7 @@
  *     https://www.xilinx.com/support/documentation/architecture-manuals/am011-versal-acap-trm.pdf
  *
  * [2] Versal ACAP Register Reference,
- *     https://www.xilinx.com/htmldocs/registers/am012/am012-versal-register-reference.html
+ *     https://docs.xilinx.com/r/en-US/am012-versal-register-reference/CFRAME_REG-Module
  */
 #ifndef HW_MISC_XLNX_VERSAL_CFRAME_REG_H
 #define HW_MISC_XLNX_VERSAL_CFRAME_REG_H
diff --git a/include/hw/misc/xlnx-versal-cfu.h b/include/hw/misc/xlnx-versal-cfu.h
index 86fb841053..be62bab8c8 100644
--- a/include/hw/misc/xlnx-versal-cfu.h
+++ b/include/hw/misc/xlnx-versal-cfu.h
@@ -12,7 +12,7 @@
  *     https://www.xilinx.com/support/documentation/architecture-manuals/am011-versal-acap-trm.pdf
  *
  * [2] Versal ACAP Register Reference,
- *     https://www.xilinx.com/htmldocs/registers/am012/am012-versal-register-reference.html
+ *     https://docs.xilinx.com/r/en-US/am012-versal-register-reference/CFU_CSR-Module
  */
 #ifndef HW_MISC_XLNX_VERSAL_CFU_APB_H
 #define HW_MISC_XLNX_VERSAL_CFU_APB_H
diff --git a/include/hw/misc/xlnx-versal-pmc-iou-slcr.h b/include/hw/misc/xlnx-versal-pmc-iou-slcr.h
index f7d24c93c4..0c4a4fd66d 100644
--- a/include/hw/misc/xlnx-versal-pmc-iou-slcr.h
+++ b/include/hw/misc/xlnx-versal-pmc-iou-slcr.h
@@ -34,7 +34,7 @@
  *     https://www.xilinx.com/support/documentation/architecture-manuals/am011-versal-acap-trm.pdf
  *
  * [2] Versal ACAP Register Reference,
- *     https://www.xilinx.com/html_docs/registers/am012/am012-versal-register-reference.html#mod___pmc_iop_slcr.html
+ *     https://docs.xilinx.com/r/en-US/am012-versal-register-reference/PMC_IOP_SLCR-Module
  *
  * QEMU interface:
  * + sysbus MMIO region 0: MemoryRegion for the device's registers
diff --git a/include/hw/ssi/xlnx-versal-ospi.h b/include/hw/ssi/xlnx-versal-ospi.h
index 5d131d351d..4ac975aa2f 100644
--- a/include/hw/ssi/xlnx-versal-ospi.h
+++ b/include/hw/ssi/xlnx-versal-ospi.h
@@ -34,7 +34,7 @@
  *     https://www.xilinx.com/support/documentation/architecture-manuals/am011-versal-acap-trm.pdf
  *
  * [2] Versal ACAP Register Reference,
- *     https://www.xilinx.com/html_docs/registers/am012/am012-versal-register-reference.html#mod___ospi.html
+ *     https://docs.xilinx.com/r/en-US/am012-versal-register-reference/OSPI-Module
  *
  *
  * QEMU interface:
-- 
2.25.1


