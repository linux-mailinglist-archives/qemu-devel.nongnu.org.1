Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F6F77812F
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 21:17:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUB9E-0000PX-Bi; Thu, 10 Aug 2023 15:16:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1qUB9B-0000PP-9B
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 15:16:37 -0400
Received: from mail-mw2nam12on20608.outbound.protection.outlook.com
 ([2a01:111:f400:fe5a::608]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1qUB98-00072x-Kg
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 15:16:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jmj4HfGH+rs3kfbu4Q/QORIg7+bfLl+u4S1ie2o4mvfUh6EO3uvW25TFtGe8BNK8iRfxHoRTe4n2RKPbG7niB1/HDQUcmk5K3EJd2Y0aaMGa/ZhivJY7laOC6W0cI9fPwfjcPf50EFwE7Wx5CQKs9mnXPmsrGrIGWb0oF9uSP7rybxz1kGf9k7C3YS81OfGDi5HVeS+RoB31by4rqSLx/qmNp1lIe2BN8A+QNpT9YtiKMSLC6J9rom9CkJ7wuTpxuCNSJOnQwEKRrF4+UA21O2Uv12F8jvUx2V9EOwsw9V4Kq18LwSWBOMdhz2UE+2QBBdHq5M68txQLY6Y41fCcdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Q4OYLhJ68sp1Bv88GonZf0xYO0pJ4vCA926pusTD8s=;
 b=cK/cWHJyFEE7hHdDg8sXa1wYNXOFurV5DG7tOuvdZuLgm5NxGBvkhLrvaiVxE9EzXCyT26M66elcsf8FWpYhtUtn/f+vAGgIY5F7fEtgtky7IuF1i5lqf3xUllOrRv3GivwFxGW1R6md6m1FsViggHrdBysiiRFeJEMRBmZBZe63zw7iXAhwfV95PpWS51evKJP+r/xyObcnMUQzIoMT39nEWvSjVEYIc3swa3M3/ANHpTB42xjTrSYnzGqRvsWhc7cuInt3GbFzfPqC/H7JM7YO6DbRrCb/iELtNawA3cvh/3KP9t/6alsyxryK4xTc7IKcOthKWxUxtfgfhz7bQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Q4OYLhJ68sp1Bv88GonZf0xYO0pJ4vCA926pusTD8s=;
 b=RTfJJvtpGdLXml0+RYNu2RQF24Us0mjkLZU8cv8C/U8nmTEMk10i3nmCsOfgGxmcZ35uUeW2/89carQCDALdeTDpjNr8kaaNYHzpApUGe0iWC1otvzof6wGen9nJzKCKTATCLr2n6/CB3VCoPNXSxLFh8qAUSsLGEm/Pgj8nLnI=
Received: from CY8PR10CA0007.namprd10.prod.outlook.com (2603:10b6:930:4f::14)
 by DS0PR12MB6463.namprd12.prod.outlook.com (2603:10b6:8:c5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 19:16:30 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:930:4f:cafe::aa) by CY8PR10CA0007.outlook.office365.com
 (2603:10b6:930:4f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30 via Frontend
 Transport; Thu, 10 Aug 2023 19:16:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Thu, 10 Aug 2023 19:16:29 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 14:16:29 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 14:16:29 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 10 Aug 2023 14:16:27 -0500
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: <qemu-devel@nongnu.org>
CC: <frasse.iglesias@gmail.com>, <alistair@alistair23.me>,
 <edgar.iglesias@gmail.com>, <peter.maydell@linaro.org>, <fkonrad@amd.com>,
 <sai.pavan.boddu@amd.com>, <tong.ho@amd.com>, <vikram.garhwal@amd.com>
Subject: [PATCH v2 0/8] Xilinx Versal CFI support
Date: Thu, 10 Aug 2023 21:16:18 +0200
Message-ID: <20230810191626.81084-1-francisco.iglesias@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|DS0PR12MB6463:EE_
X-MS-Office365-Filtering-Correlation-Id: 3031ecda-99cf-4f79-91f5-08db99d64d35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rtP8t5NFB19XXY4D38DyarXuzjXBs9f4aycXkUdd7ZRmIQu4dmT5QkuJ/jeodOcB104i4wmqblCIenmeqm4SMQ7Xbk7fA9h5YH96hwKo5KMf/l2Ug5kvTjOxLb6ipfpU5Ra3RGg7PMb87W7HcwYQBBDdtfUy6plbVc6Io/JXk57hExya8ckyzj7SJ53HDBSHUVZBuI9c6tLuM0Us/r+wctb8Nvjr3Qly/8Fz9mBAhq5nZBWptbyQ/JOWRLb5mmU9OMlKlAh8UyBamHyno/M+VnxZLjnW8ww6Cr7tqJCzS89OPCGgCUUuo607URIRy4/gxRVGe7arb3GPd8PeLDXZz88OlOyWI6d0feAFjBJrdJVbqsRannKb6AD4o887yZl9fvE06oXwEWm3OL9tcbH85YDSd/FgX5lFzwsCP5oA7EWG2MOxyvohUPEgw6XA9l0TQPZ5TwZ2WWrvuqhpDHSNm0R8WbqDn3tWNpFTH8x8Qg/L9tldPxDqu53vGJPW30WVukyADRILO9C/vJ5vVvYvYqFC5iBD1H5PsMCjBp0TMAit7RV9DCVm/g9jvzIMN35/PVCcuNQz+IVTdlK7RuprxZauGyEexucnyIUszJTqIWnTn1gdAcElhV/lJAVbVUvzluN7gqMwoZNavEHi9uRIsG6I9fUnl3J3zimStmYPi4PG7c1IKlJGkjNxvnI94UvOPNUWmHboqYW//AMVmFrOkc1buhd128ZEGIDXUe/j9lkKkRxDAFYiu0jqRQBSdGn7heOp42pxTkECan2iqF1PJg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(376002)(136003)(39860400002)(82310400008)(186006)(1800799006)(451199021)(40470700004)(46966006)(36840700001)(47076005)(5660300002)(316002)(6916009)(4326008)(54906003)(70586007)(70206006)(8936002)(8676002)(86362001)(41300700001)(478600001)(2906002)(44832011)(83380400001)(36860700001)(82740400003)(81166007)(6666004)(2616005)(356005)(426003)(40460700003)(40480700001)(966005)(36756003)(26005)(1076003)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 19:16:29.9370 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3031ecda-99cf-4f79-91f5-08db99d64d35
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6463
Received-SPF: softfail client-ip=2a01:111:f400:fe5a::608;
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

Hi,

This series adds support for the Configuration Frame Unit (CFU) and the
Configuration Frame controllers (CFRAME) to the Xilinx Versal machine
([1], chapter 21) for emulaing bitstream loading and readback.

The series starts by introducing the Xilinx CFI interface that is
thereafter used by the Xilinx CFU components, the Xilinx CFRAME and Xilinx
CFRAME broadcast models for transfering CFI packets between each other.
Thereafter a model of the CFU_APB, CFU_FDRO and CFU_SFR are introduced and
also models of the CFRAME controller and CFRAME broadcast controller.

The series thereafter ends with connecting the models to Xilinx Versal
machine.

Best regards,
Francisco Iglesias

References:
[1] https://docs.xilinx.com/r/en-US/am011-versal-acap-trm/PSM-Local-Registers

Changelog:
v1->v2:
 [PATCH 2]
   * Use KiB when defining KEYHOLE_STREAM_4K/KEYHOLE_STREAM_256K
   * Updated to be able to share wfifo code 

 [PATCH 3]
   * Swap to use Fifo32 instead of GArray in the CFU_FDRO model
   * Add device reset to the CFU_FDRO model

 [PATCH 4]
   * Add device reset to the CFU_SFR model

 [PATCH 5]
   * Use KiB when defining KEYHOLE_STREAM_4K
   * Add comma after CFRAME_CMD_DLPARK
   * Remove backwards compatibility comment (and the 'cfu' alias propname for
     cfg.cfu_fdro)
   * Use Fifo32 inside the XlnxCFrame structure
   * Reworked cframes_reg_pre_save / cframes_reg_post_load

 [PATCH 6]
   * Add device reset to the CFrame broadcast reg model

 [PATCH 8]
   * Switch to use g_autofree instead of explicit g_free


Francisco Iglesias (8):
  hw/misc: Introduce the Xilinx CFI interface
  hw/misc: Introduce a model of Xilinx Versal's CFU_APB
  hw/misc/xlnx-versal-cfu: Introduce a model of Xilinx Versal CFU_FDRO
  hw/misc/xlnx-versal-cfu: Introduce a model of Xilinx Versal's CFU_SFR
  hw/misc: Introduce a model of Xilinx Versal's CFRAME_REG
  hw/misc: Introduce a model of Xilinx Versal's CFRAME_BCAST_REG
  hw/arm/xlnx-versal: Connect the CFU_APB, CFU_FDRO and CFU_SFR
  hw/arm/versal: Connect the CFRAME_REG and CFRAME_BCAST_REG

 MAINTAINERS                              |  10 +
 hw/arm/xlnx-versal.c                     | 155 +++-
 hw/misc/meson.build                      |   3 +
 hw/misc/xlnx-cfi-if.c                    |  34 +
 hw/misc/xlnx-versal-cframe-reg.c         | 914 +++++++++++++++++++++++
 hw/misc/xlnx-versal-cfu.c                | 563 ++++++++++++++
 include/hw/arm/xlnx-versal.h             |  85 +++
 include/hw/misc/xlnx-cfi-if.h            |  59 ++
 include/hw/misc/xlnx-versal-cframe-reg.h | 306 ++++++++
 include/hw/misc/xlnx-versal-cfu.h        | 258 +++++++
 10 files changed, 2386 insertions(+), 1 deletion(-)
 create mode 100644 hw/misc/xlnx-cfi-if.c
 create mode 100644 hw/misc/xlnx-versal-cframe-reg.c
 create mode 100644 hw/misc/xlnx-versal-cfu.c
 create mode 100644 include/hw/misc/xlnx-cfi-if.h
 create mode 100644 include/hw/misc/xlnx-versal-cframe-reg.h
 create mode 100644 include/hw/misc/xlnx-versal-cfu.h

-- 
2.34.1


