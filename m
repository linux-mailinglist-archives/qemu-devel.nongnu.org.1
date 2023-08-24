Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2CA78780A
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 20:35:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZFAc-0006wH-3R; Thu, 24 Aug 2023 14:35:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1qZFAZ-0006vg-3l
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 14:34:59 -0400
Received: from mail-bn8nam11on20600.outbound.protection.outlook.com
 ([2a01:111:f400:7eae::600]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1qZFAW-0006x1-4z
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 14:34:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l9+fJYD3TDsdfmfGXzvOHY0VMp1uYuxpEsZzHTwPSNnhkg3Q4wdRyplQSW/qHhzLJ0O8wTbOs7DRIsO7V8klySsTSG7GFlNqLr9/XnZVlzlKL9YJHMhhbN8+iinvPrxHAPaW0DhNYk/z9zCix5cnuJ9e2sW6kN61VgsvLCX+wy+nRD2ztMPiThpkWMO32UgNpCZ/zj7nrJ0xgQMh/vMTCtnTCMnREHCX9Q3MLYLpppel2AMBAvwdzNOwID+5NMJKdu/y4ar61zKdjhKX9z7Kg5rb0zrDh5RInRAK8up+CafkBxzw3HVAB4kvzf4QvgUMZSYCForwNUaqJ1mf1yTtsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xu1yR3T+CwJxu4AliFx/YX464RgSg4t4Pt6LwMQIyWc=;
 b=ZZ1+mAZcea4onnC8VycBxo2cpDqEf275TjEzkLpeJOKw291pHINxoelM/INKSCFr85U08/iv+1mbxjkXj2hDCOoOnbDR1ymT6TRlG5utq23qmMhlzvEt6T56BXToOJWEfGV3lnscnJrKyg/502AGUU8SGah0R0jLsL2couHcBlMJxMh++MwislHXPUiczBTT718G1zTPq3aBjaikrqISbEFlEIBx4oXVDdVnKD0IYA921Za23KpGl5yH0Zigfw/HeXFgKB1Y9KlcYrVC6CM+2wrv8WrrJngwwWXG1caRRWQSSy2QieLuDytQUb2JB2jMlf5BnsD2TEEdTY5dbqDLIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xu1yR3T+CwJxu4AliFx/YX464RgSg4t4Pt6LwMQIyWc=;
 b=mFYCF2534rbRqIQVxG8S2ccyB1Uyn1OjsNzEjy4t+zj0HeGgA/V61h5+sPdfsu3orcN2BFzcB1tbxRzej/19N4iaOBhJKD9BwApbHJq74z+YiLYbFifMB75XIJHbzCfVQ/McDZf66ofgwco3mmQDKrDaF5kEURaZWHb6R3HOOiM=
Received: from CY5PR13CA0059.namprd13.prod.outlook.com (2603:10b6:930:11::20)
 by DM4PR12MB6133.namprd12.prod.outlook.com (2603:10b6:8:ae::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.26; Thu, 24 Aug 2023 18:34:52 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:930:11:cafe::bb) by CY5PR13CA0059.outlook.office365.com
 (2603:10b6:930:11::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Thu, 24 Aug 2023 18:34:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Thu, 24 Aug 2023 18:34:51 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 13:34:51 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 11:34:50 -0700
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 24 Aug 2023 13:34:49 -0500
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: <qemu-devel@nongnu.org>
CC: <frasse.iglesias@gmail.com>, <alistair@alistair23.me>,
 <edgar.iglesias@gmail.com>, <peter.maydell@linaro.org>, <fkonrad@amd.com>,
 <sai.pavan.boddu@amd.com>, <tong.ho@amd.com>, <vikram.garhwal@amd.com>
Subject: [PATCH v3 0/8] Xilinx Versal CFI support
Date: Thu, 24 Aug 2023 20:34:40 +0200
Message-ID: <20230824183448.151738-1-francisco.iglesias@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|DM4PR12MB6133:EE_
X-MS-Office365-Filtering-Correlation-Id: 24d48f70-5a1b-428c-d6c9-08dba4d0cdff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gjSONSLJ/VWLv+ROLOtZmKcIoum5z5h3p8q0C/4+MfwaeclD75EPureRYOEdr6pNUzA10w4nKsFtydmnlPGiNAwzQFw9fC2Og2J1obYO4D+5U7Azw4N8CvCODHScMFFFoktk22hxc0x+nye6P2ce7Rwp0b9wnLlGI3QlLQVaILgt38QBhsuZ0ZjbSPD/vO5vrNtc7X4IYsdtWLAafKkdET600G5aeFzB9hbncTnxgz+bIaPKYYBOo4EgxsAp/ASxI6wCiW7Js8hTmESeX/0QIL3cMoBhVc0Qg9okx1+WPiPJ1T95ibIulWNa26fBTQSLLt08xi4rpZRV31wy+SilR5LDSofByEC2bgxBHlb4Mkff8G4bR9hRuaPRjbFjDPXRwFBLni8VoB35oRAQoKWHKHJRtmb67BdOF3KfW4QJCVPTSYAZ6K+bvmGhRHlYqLAlrkpeMuc0vIRCZRfajBEXLF85NwY3E0MeZslFwmlEmdwxi4MLvyGq6PrfDW3u3haFlpdlPRHzdddNntc3cYsMwkS4AjfrTx63I9ZV4uH3YYcevpo5nizMtUIis4ZWb58RQkXzEjO6dvxxY+2G+jQQeWbaD3TjrE9BWcIVQkJc9YzCfG19dnFCIaqEHfyxfLmN7PSKkkhBjnQ6jCASyvcdorTJmZMUxKNdSv1VcxnChlVqXDcdQ5yNKJRpKXpmjvxMSnlWscU8uTx++PluttWjnn1Oha9d1alGv+arF2lLfkH6/BmJ5BTOaIzVjciTMGUB
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(136003)(376002)(39860400002)(186009)(1800799009)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(82740400003)(356005)(6666004)(40460700003)(81166007)(40480700001)(336012)(1076003)(36860700001)(26005)(47076005)(36756003)(83380400001)(426003)(2616005)(41300700001)(2906002)(316002)(6916009)(8676002)(70586007)(70206006)(54906003)(44832011)(5660300002)(4326008)(8936002)(86362001)(478600001)(966005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 18:34:51.8212 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24d48f70-5a1b-428c-d6c9-08dba4d0cdff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6133
Received-SPF: softfail client-ip=2a01:111:f400:7eae::600;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
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
 hw/arm/xlnx-versal.c                     | 155 ++++-
 hw/misc/meson.build                      |   3 +
 hw/misc/xlnx-cfi-if.c                    |  34 +
 hw/misc/xlnx-versal-cframe-reg.c         | 846 +++++++++++++++++++++++
 hw/misc/xlnx-versal-cfu.c                | 563 +++++++++++++++
 include/hw/arm/xlnx-versal.h             |  85 +++
 include/hw/misc/xlnx-cfi-if.h            |  59 ++
 include/hw/misc/xlnx-versal-cframe-reg.h | 303 ++++++++
 include/hw/misc/xlnx-versal-cfu.h        | 258 +++++++
 10 files changed, 2315 insertions(+), 1 deletion(-)
 create mode 100644 hw/misc/xlnx-cfi-if.c
 create mode 100644 hw/misc/xlnx-versal-cframe-reg.c
 create mode 100644 hw/misc/xlnx-versal-cfu.c
 create mode 100644 include/hw/misc/xlnx-cfi-if.h
 create mode 100644 include/hw/misc/xlnx-versal-cframe-reg.h
 create mode 100644 include/hw/misc/xlnx-versal-cfu.h

-- 
2.34.1


