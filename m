Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E19B17B778C
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 07:55:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnupc-0005a9-TZ; Wed, 04 Oct 2023 01:54:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tong.ho@amd.com>)
 id 1qnupa-0005Za-1b; Wed, 04 Oct 2023 01:53:58 -0400
Received: from mail-mw2nam12on20609.outbound.protection.outlook.com
 ([2a01:111:f400:fe5a::609]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tong.ho@amd.com>)
 id 1qnupW-00013I-BJ; Wed, 04 Oct 2023 01:53:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KzcYmfff4xkXJCdlfXsp8o25zNLtz744X05EbmmeQXp8rUEYwiF5cX6JBy4Wnie+bYfwg40MlQXBxbbgpHuMnHTGUy8VzgcNzZXJlXD7Gz4NcGdCGiNs2iFrw55jJ9ExgdPvNQehBQ1SGQ5jr1ExeUf+sf5P89gOoQ8FRUUAWYNhXvivE1I0auFp88FxNwaqQF8PAjeHz4dVb5sxXoRG0Q24jEOGwHx+ADreevyBUxPxvqTD7fGcBKvLyT2MzQEmdjmzEt6I7BNNELERkIS24moCXudjLL/jDWcY384rQvB7TgIePv2DfclIwjeJHjtuswKzcMki3ZuRloU+uAr19g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=snE/k5gBALNrl806iI/O8AjoY+aEJW2VAzexsSQ7nyY=;
 b=cGqYF5R9ycBpyIfTBjQ077rEmqf8yxbObPG4FC6tX4I3kMipDYsNgLrr8Tx6FWntW7olLVRGROk8OJ+I2Cfv/kAxLdcRGwjVpO3Wxyq+a6Z8VvikY/GXERWtIWVmbsT1ihKrCEFYORD0j9T1+8Y90F9b1CX1k1XeXjmyRXWUdr7bfAektrwFO0mHpzPcqaOHGuk+hPYp0zQzqSBzqYoJvt8jJntV9+4z5uQBFnpNwE43MPOuxtXVWeylM4DXGNxq1XPwMDTsowMy1pUXBgerKu40a7YcJdVUBIlsKlYPxld0Y0T/rGTFsSTgLLNdIZbwVEfvVEnnPAi16KT6tnYsLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=snE/k5gBALNrl806iI/O8AjoY+aEJW2VAzexsSQ7nyY=;
 b=VnjI842d/uempi9XYambAtsw44JcoaXIK/xMCB6u9ie4048ShRV+1ONtK7ACNTMLrXgpPML5srkoPSdxzRBKniV92XyKzcgoGG8Zi989iX35a6lq+LnkFEjmC68VFowCgQDXWphGR+GzYvZkktgpLgtNBPG/HY25LCtN5otyiL0=
Received: from CYZPR10CA0022.namprd10.prod.outlook.com (2603:10b6:930:8a::26)
 by IA0PR12MB7601.namprd12.prod.outlook.com (2603:10b6:208:43b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Wed, 4 Oct
 2023 05:53:46 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:930:8a:cafe::e5) by CYZPR10CA0022.outlook.office365.com
 (2603:10b6:930:8a::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.36 via Frontend
 Transport; Wed, 4 Oct 2023 05:53:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.147) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.15 via Frontend Transport; Wed, 4 Oct 2023 05:53:46 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 00:53:45 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 00:53:45 -0500
Received: from xsjtongh40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 4 Oct 2023 00:53:44 -0500
From: Tong Ho <tong.ho@amd.com>
To: <qemu-arm@nongnu.org>
CC: <qemu-devel@nongnu.org>, <alistair@alistair23.me>,
 <edgar.iglesias@gmail.com>, <peter.maydell@linaro.org>, <tong.ho@amd.com>
Subject: [PATCH] xlnx-versal-efuse: hw/nvram: Remove deprecated device reset
Date: Tue, 3 Oct 2023 22:53:39 -0700
Message-ID: <20231004055339.323833-1-tong.ho@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|IA0PR12MB7601:EE_
X-MS-Office365-Filtering-Correlation-Id: ce5fce71-c688-4dda-5ddb-08dbc49e461f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dsksiUM8e3u0WHwINjAPK7mOzB/Co3C+6pOtFEAzjbtd782ZPBrwky3dMYVHQ6XhEhrjeFtKyf0bQvIfVLqxP0jPSOoLx0U73ZDqLpF92PZxDmWCjAgEDIca68u722WQQlgzUtBIuTHudHhP9BccsoadAKYmH5jn+bHGq90QV8qtYgyLTxRIrfVJhc1Vm2JUUMwRYd5i0uC6oxHxpXKrzT8A2T4YLGjQuK0QlPT1ZgbSVWOp69fWkWUI/TQl7faJ1JIfRiE0Z3XK1pi9f4rm6Tt3G6JalpSb+0kVGQ6O8FL7arVSLNxtjDus2YFTfa1iKfnLzpnY+2odACVya9V1CorneRUhjSAXITKvVT9w6vPQg9dnNJuiVKXT9uzd/Y0x9b0y9ifzGKmkvs4pyU7GWjGwcDt3AoTDABzuxDykgHhwD6rTnD9RzawuSOdMySCdrXmldzvZbFYOnqMfk1LH+8ivMta8CxQ74QTVy70XEAzmR1IRq2LOUF9lrrIr8JMMQOpadKFqlmR73JoghCoNQrXvYeaTOD7NevpzfDyp888f9ewwtrF2tcpFAD6eDwukJYnFIMyBxx3ZbvioGYLLXHxeXsX/LflK2O+GJrJ0RQP6+EfNbos80LaU1vrfB44HxMfOQTP28cGZNwDfSwL0zhemsbXzm2yw0tFZ0a4ImfewrsXiVug2tMCHKtbXbD87n7BFTPiX4c2qFyqaZClbi8pyp3vlhbc+G1KTPK33CWfJOET+1kUUiKaxa5BD1wiTKI04fednAsqUc12gmDOl7g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(376002)(346002)(39860400002)(230922051799003)(186009)(451199024)(82310400011)(1800799009)(64100799003)(46966006)(36840700001)(40470700004)(6916009)(2906002)(70586007)(36756003)(70206006)(47076005)(316002)(54906003)(86362001)(41300700001)(8676002)(5660300002)(8936002)(6666004)(4326008)(36860700001)(44832011)(83380400001)(426003)(336012)(40460700003)(478600001)(26005)(1076003)(2616005)(66899024)(81166007)(82740400003)(356005)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 05:53:46.2301 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce5fce71-c688-4dda-5ddb-08dbc49e461f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7601
Received-SPF: softfail client-ip=2a01:111:f400:fe5a::609;
 envelope-from=tong.ho@amd.com;
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

This change implements the ResettableClass interface for the device.

Signed-off-by: Tong Ho <tong.ho@amd.com>
---
 hw/nvram/xlnx-versal-efuse-ctrl.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/nvram/xlnx-versal-efuse-ctrl.c b/hw/nvram/xlnx-versal-efuse-ctrl.c
index b35ba65ab5..beb5661c35 100644
--- a/hw/nvram/xlnx-versal-efuse-ctrl.c
+++ b/hw/nvram/xlnx-versal-efuse-ctrl.c
@@ -2,6 +2,7 @@
  * QEMU model of the Versal eFuse controller
  *
  * Copyright (c) 2020 Xilinx Inc.
+ * Copyright (c) 2023 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
@@ -657,9 +658,9 @@ static void efuse_ctrl_register_reset(RegisterInfo *reg)
     register_reset(reg);
 }
 
-static void efuse_ctrl_reset(DeviceState *dev)
+static void efuse_ctrl_reset_hold(Object *obj)
 {
-    XlnxVersalEFuseCtrl *s = XLNX_VERSAL_EFUSE_CTRL(dev);
+    XlnxVersalEFuseCtrl *s = XLNX_VERSAL_EFUSE_CTRL(obj);
     unsigned int i;
 
     for (i = 0; i < ARRAY_SIZE(s->regs_info); ++i) {
@@ -749,8 +750,9 @@ static Property efuse_ctrl_props[] = {
 static void efuse_ctrl_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
-    dc->reset = efuse_ctrl_reset;
+    rc->phases.hold = efuse_ctrl_reset_hold;
     dc->realize = efuse_ctrl_realize;
     dc->vmsd = &vmstate_efuse_ctrl;
     device_class_set_props(dc, efuse_ctrl_props);
-- 
2.25.1


