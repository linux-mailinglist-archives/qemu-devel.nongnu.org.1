Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B6878F18B
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 18:57:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbkys-00018z-AA; Thu, 31 Aug 2023 12:57:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1qbkym-00014z-Vw
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 12:57:13 -0400
Received: from mail-bn8nam12on20618.outbound.protection.outlook.com
 ([2a01:111:f400:fe5b::618]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1qbkyj-0003XO-EB
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 12:57:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nbeLCHpWkTB6ItQProQdM8Pk+TOQt/9qlGXeShr59JU4h02YQknZD9vwmRej7V47bGGs2KcRCr+W2keV43LqKFR7Jbyk0j1vTu53zo/nqYhCAwHqQuevZUBgwrQKYvafPBzCmkN9IlJevRirNZPEQOzhQ0VBfeuU650dfHl+b+e5pr13i9l/CSg6OaZlTc5a/JIiKEQOjWVbDw/hXk4AAEF7KHv5/zGXXyuhsv/3vyBc7zJ3RTViYOQTdwi3c7rQprOzxdg+quVhoUdPCsGWKGIbHz1+vus6gyAhzS/dBGwuBHfg9Tv66nBWoasHKQdRX3cjB08gYKdnLvXkkGpQmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4HoZkw9FH4pOTN5W7a3YTj506kZyl71hkS7Gpq2ciZA=;
 b=IFLmtRzu972KzGtp2l2alH18yvNAPFYcwWzTbwMBQhBoY4KzyhNR9sSm8TJAHEbqhg7sAkj7d5WMhGtYSdGQW+twOwe4rh/+XkyCoVyhsiUN8h5hglkW5v1SdWaNI1Fa4xcgwl7y7MZD2cM4x4u8Eht3xadawWebFdRbQQ2NXwklnWIiyH2Qvej3PRKdKkrL9tB+y2nerFrcPAj0332Oskglg9mVTbqPTXg+bP/Kfj6Pd69IgQLg0RX3ZmJvqgV28AdRwHSV53GiAR48urJc5NBzXJcxAAGisdG5TwanybJZxYVJx20BS108rH7PrFMt4bLGqU/qkjUOAR6BNV3atw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4HoZkw9FH4pOTN5W7a3YTj506kZyl71hkS7Gpq2ciZA=;
 b=yTmhP+3zqAnpb3GjDHY8d4rFZ3fjsQR/22fSxvstZEedoyM1+hfYPg4dBlN6/EAWQwK0hKDwQR74vi5aqxbYm836Swa9vJMflUIX1DcvbgJdZXG6gssiuTH0pyhpKuFNEe7R/HdKUt2IOc6VdR0hUx2bJ3gvhp2959h+FefHGnw=
Received: from CY5PR22CA0067.namprd22.prod.outlook.com (2603:10b6:930:80::12)
 by SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Thu, 31 Aug
 2023 16:57:04 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:930:80:cafe::be) by CY5PR22CA0067.outlook.office365.com
 (2603:10b6:930:80::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.22 via Frontend
 Transport; Thu, 31 Aug 2023 16:57:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.16 via Frontend Transport; Thu, 31 Aug 2023 16:57:04 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 31 Aug
 2023 11:57:03 -0500
Received: from xdcsswbld02.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 31 Aug 2023 11:57:01 -0500
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: <qemu-devel@nongnu.org>
CC: <frasse.iglesias@gmail.com>, <alistair@alistair23.me>,
 <edgar.iglesias@gmail.com>, <peter.maydell@linaro.org>, <fkonrad@amd.com>,
 <sai.pavan.boddu@amd.com>, <tong.ho@amd.com>, <vikram.garhwal@amd.com>
Subject: [PATCH v5 0/8] Xilinx Versal CFI support
Date: Thu, 31 Aug 2023 17:56:53 +0100
Message-ID: <20230831165701.2016397-1-francisco.iglesias@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|SJ1PR12MB6363:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d2ccf98-3514-47c8-da81-08dbaa434d76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mm2ehrgJlU8SR5RcaJB0jP0GYHGWUC6nMUXVkx2F5QMvUHZ7Tzr83zUQ3B3CkU9xQXBgo0npqrIiwhbViKZnWc7zO+xI2b5zmLats8f5bUIvW9BggTUZz7ZFkfTZqCiH4X+bqc4iRrIYUNU6RTRuPUmDjiqbinypecT0ub+dZbo5aPyHYQS3eVcmX//kGJ6I++HXw+pKFL/2cRi8XWmPNW96Mo/7jCD9aJVlNYavleBtilZyd12kjAcRLbMW4aQnPEB3KT4K2AEoujmmR5Q3kfmqoTAcyEOfQPCqV2sagljiY7PIdmsJMMedRWuSWQ7VAFCJlzg2tvhkqvN+bmpdMiBuKPpPNuv2lPV9bEOPFROxrE/xXT8Tn+MVwKxyndY0/O1LklbsjPK75VgEW+zTaFRQkboz0gqqefg2Qs95jKZqrOooUP5cN59WIXL+OqHgzNsZwOP1yCKmi4On66S6c2kcYoBa9hRp3DwJx1NWyeZh53g3X116aE/+24keCE/wtHKnXh83dd/+2Qfu0PcXDlw7RKPW5JKSOzhRP8+WMO0wBV/0S61mvxsDoVaIcMI9dtO3t/q3RLpRNBeIRPKVDs7xE6SEw4CHLGppBHPzoDcT/euLIVyW199h1k9UwIC4wqK9xiYeEmNoOk/sD4YpIOpRVgDOZZiIXWta8cocMxJyVFK7cA6lNhrdglgnB1XBB67ZxPUs50jagrxBdGItLUZ05KR8FXBogDRF9wij4UXtQbBv16yWZqLICILVcTJsXBGDDHH0yNnk6GtmBhVqUJ2fZU9frHDwO89UHDxmtij42fQ6Q6ezbg3QsEqF8Z98
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(346002)(136003)(396003)(1800799009)(82310400011)(451199024)(186009)(40470700004)(46966006)(36840700001)(70206006)(41300700001)(8936002)(83380400001)(47076005)(40480700001)(336012)(36860700001)(8676002)(4326008)(966005)(478600001)(6666004)(6916009)(70586007)(316002)(2616005)(426003)(1076003)(26005)(54906003)(2906002)(82740400003)(356005)(81166007)(5660300002)(40460700003)(36756003)(86362001)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 16:57:04.0503 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d2ccf98-3514-47c8-da81-08dbaa434d76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6363
Received-SPF: softfail client-ip=2a01:111:f400:fe5b::618;
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
v4->v5:
   * Identical to v4 (resend of v4 due to an smtp problem)
v3->v4:
 [PATCH 5]
   * Swap to pop out the fifo32 data instead of using memcpy
   * Use g_tree_nnodes instead of g_tree_height
   * Take reference before g_tree_destroy (for keeping the GTree around)
   * Remove stray whitespace (in cframe_reg_init before g_free)

v2->v3:
 [PATCH 5]
   * Swap to store the CFrames in a GTree instead of GArray
   * Rename new_f to new_f_data and also add it to the vmstate 
   * Removed unnecessary 'switch' braces in cframe_reg_cfi_transfer_packet
   * Correct the reset of new_f_data and the cframes GTree


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
 hw/misc/xlnx-versal-cframe-reg.c         | 858 +++++++++++++++++++++++
 hw/misc/xlnx-versal-cfu.c                | 563 +++++++++++++++
 include/hw/arm/xlnx-versal.h             |  85 +++
 include/hw/misc/xlnx-cfi-if.h            |  59 ++
 include/hw/misc/xlnx-versal-cframe-reg.h | 303 ++++++++
 include/hw/misc/xlnx-versal-cfu.h        | 258 +++++++
 10 files changed, 2327 insertions(+), 1 deletion(-)
 create mode 100644 hw/misc/xlnx-cfi-if.c
 create mode 100644 hw/misc/xlnx-versal-cframe-reg.c
 create mode 100644 hw/misc/xlnx-versal-cfu.c
 create mode 100644 include/hw/misc/xlnx-cfi-if.h
 create mode 100644 include/hw/misc/xlnx-versal-cframe-reg.h
 create mode 100644 include/hw/misc/xlnx-versal-cfu.h

-- 
2.34.1


