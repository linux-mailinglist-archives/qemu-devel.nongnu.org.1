Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9229F78F133
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 18:26:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbkUD-00049B-2Q; Thu, 31 Aug 2023 12:25:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1qbkTy-00047q-JS
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 12:25:23 -0400
Received: from mail-dm6nam11on2060d.outbound.protection.outlook.com
 ([2a01:111:f400:7eaa::60d]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1qbkTv-0004iJ-5a
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 12:25:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MPHuOQT/hhL6OpOoCynpoq4CiPM+q5szCr8aAAPVFYAReF3GxHLaG9RlLGIYG+MXAyDmG2N4Jkr050Uo4eAGpgCQQhU6b1fC7ESBl1evQsbdc3aq7rVX1v2JZAlYABHvu11ew23LEYkpVOw0BA0vUbiqaISEgzmfDWqhOYGC6s0U8lUGeQfRc/YO753rLs6ZfBHPxAfBZHT+DzV67yu7DJtjj28Jws02Ppz2OETu4RM9ZFiHDMf3gqLyCeXyBpn8GpacPgDwrUkTP4zbxWMEaRxCXXrxZr6dYn6TPdXFuvbe56a7V+8RsCDjyd7FHNG26m7T6UKmCSy99qJ2IPaFWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8wuEwcBK2GsoVFi1nU2a/qlKQKrqLhSZLBu/zAoH5sY=;
 b=GKxfdUbYaCDTmFBRqUv3arHyBnZMb92CnzyAunbT9Ou2UOewoUbczY/SuFLPcWTKkuBdptPzBzYwl6jfyAh61JR/mpPpOVwFIjMIsTVN4TMZY7uzmnqA7uPEeZ5mgxJ8Dub9+OpbhqrFflflljKzIaqujalb+6HyoCNM84NdDH2RQCRuLZ2AZ9G1X7I9y2QhKhPQ11tITyofGmszbrLG+3IOEdkg7qqr2au2k9nqil8Yvi0uUK8mFsejtPD4WJJVQBqiymuNS/N0IK1EPLfcvAX4l2g5anL6AWe+VCvULCssZPJ0jE9P2APhGW+XnkyC3WxtS6y6hSsV/99VwHQk3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8wuEwcBK2GsoVFi1nU2a/qlKQKrqLhSZLBu/zAoH5sY=;
 b=vGjxIsULVdcc1AsNzIYNe/Ynr7xpaVWro7lR+WMYOX8aAKC6hP78/3QP896HYZdG+hbXA7SmgSluhLEGBWRfzFenBuYdZ4c6klwgMl2/tMKK4u/AVylBH2KRO9SmQYX3oidII1uT9wY4/wHYzS2e0Qjv/AwhdtBiyAU3CesU054=
Received: from MW2PR16CA0030.namprd16.prod.outlook.com (2603:10b6:907::43) by
 LV2PR12MB5726.namprd12.prod.outlook.com (2603:10b6:408:17e::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.20; Thu, 31 Aug 2023 16:25:14 +0000
Received: from CO1PEPF000044F1.namprd05.prod.outlook.com
 (2603:10b6:907:0:cafe::72) by MW2PR16CA0030.outlook.office365.com
 (2603:10b6:907::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.22 via Frontend
 Transport; Thu, 31 Aug 2023 16:25:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F1.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.16 via Frontend Transport; Thu, 31 Aug 2023 16:25:13 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 31 Aug
 2023 11:25:12 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 31 Aug 2023 11:25:11 -0500
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: <qemu-devel@nongnu.org>
CC: <frasse.iglesias@gmail.com>, <alistair@alistair23.me>,
 <edgar.iglesias@gmail.com>, <peter.maydell@linaro.org>, <fkonrad@amd.com>,
 <sai.pavan.boddu@amd.com>, <tong.ho@amd.com>, <vikram.garhwal@amd.com>
Subject: [PATCH v4 0/8] Xilinx Versal CFI support
Date: Thu, 31 Aug 2023 18:24:57 +0200
Message-ID: <20230831162505.30399-1-francisco.iglesias@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F1:EE_|LV2PR12MB5726:EE_
X-MS-Office365-Filtering-Correlation-Id: 33ac4fae-c7d9-4098-f2f4-08dbaa3edadb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B8Ol31+5xtNmCvlknUUz3aFs+/BgxUZm8nqtbnd63kKRLug9viPscAJCUs4LbBN4fg3ohsacbyyJahQt2C16Yc111sjPtdkgmJ/7YoabFDGwH6OH7wLdRLRqfX8Ka0kXP+Hgl6wD3CmcdJKFXvRhGoCHJ1p2ZBK8pENmUB2coNl85sKpDUusIj9XEpQdZeafZVuE2ziPadTmQ++Ha7IKG7ZQqGpx1epZrF86HlqYsp0tlP5OchM0Gpfq6dl10d3j1G81OC1+EUX9Qycy0wUFhgrk/2jPy9gA81SEBbSex56/yd9Ht7ldQ29YRcGuyrf3Wm+j9m2t/5AQqmdfntIHbLZN7vhfPp0O8YRtIqObuc6d2M0pvcLe1GnTjdoYed347B85nrxFhCPsbdBwEV1wxMBWx3TPpxnAq1iyb7A/clUaA1+xDH755DF7ny2BOwXA5SqFPqu1JSYH/dxriXlhAWF+rfyqpDzIEIUiB+SeKRCD5TA2gF/uNs+IppgUK1Yk3rsRJj0juLgDHwLxPA3LtOQ1dndFkQ/3yTSWNVh/ViV0YGwDTpP/xhkve5OXFHDexYfdLxDVy0uEM1hXtxTn45MXVRR7nhX1EzL8OKTprvCnvEHGnERhibjlJbCl9HoEDQAy2qQi3JOvQhc3xQJwPiTObCeNn45PlCqoxOOkUxKGCqOWg/iA/NPMlkw0o2UK1EMqiKfvDxURrmxF8l1zAvUZQNSLJEPdN19Z8HmcBbgWljWV7AMT90V/ynX8DE6ANWWoKrfg/ePRZYMzJnIhGQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(1800799009)(451199024)(186009)(82310400011)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(82740400003)(966005)(2906002)(316002)(54906003)(70206006)(6916009)(478600001)(356005)(81166007)(70586007)(86362001)(8936002)(8676002)(5660300002)(41300700001)(4326008)(83380400001)(44832011)(36860700001)(47076005)(2616005)(336012)(6666004)(1076003)(426003)(26005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 16:25:13.8036 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33ac4fae-c7d9-4098-f2f4-08dbaa3edadb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5726
Received-SPF: softfail client-ip=2a01:111:f400:7eaa::60d;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
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


