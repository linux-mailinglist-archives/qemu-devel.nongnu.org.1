Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8ADC7B6058
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 07:24:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnXt4-0005uT-2o; Tue, 03 Oct 2023 01:24:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tong.ho@amd.com>)
 id 1qnXt0-0005tg-Nk; Tue, 03 Oct 2023 01:23:58 -0400
Received: from mail-dm6nam11on20605.outbound.protection.outlook.com
 ([2a01:111:f400:7eaa::605]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tong.ho@amd.com>)
 id 1qnXsy-0006Gf-WD; Tue, 03 Oct 2023 01:23:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N3Cq6o+i9TM3W0hKkvrEthHmrZ1JMS3Sl12S8dOF7dweIAkYcW5SEwRMlvc+3J/3d+VK8mlcXPc1g9mtNAl+Yo50TdJiHKLQyiJo4n4x1GddnKsf2yKskHevyaydsRBvB2SJcUrQVaZlSM0Z11OZMi2gWqK3u+QnS2KYbwEQ/flaNz6FJ9mm2xBspg2BsMm4JHIDHZrzfGsPWOCelyS5EfDrV9c7Pp8OgaoffzMPHWweUXU61azNCuc+4DSaXG1mcHXoAksEec2wIGeTYNaSfc3JnKSADR5FM9fPfBzJr4MAkoAKIhKAC7b6vKLvodMXDfIgyTrfashxFOp8xQxcgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aft2jw9AnoRYx0/3JFfxkxDpwv8ume3ZhRMNIv/u3Ug=;
 b=Gxixe7xv6WnfIQucO6rFAimOPIl2yFZskpVRcoaoul6U/dF6+S1yXTqdIJ4JtyPmqQIqefAQvLXwD0hgs4DpW7eTYZshvUW314uX/VIIaj4rl6juNjRzlTQzcrJDPdPXWOcHWSdid+buoPUoMxHweaidKWwIVu1SJGKBPGU7HgI+2HLFLiZY7hbkUEJN7zuX3pA6jz1jtxRQH6Yv2BIg/cZIZSwuZWYWyPbLwXcKOvOje93jYjcpTs/EK9bQHJpcPWTeG0vzgCsZ4JV7aUnxKk2YSRuwf+HKYf6cXExaVLKyOazDt8Dt4G+NhGMGHQ4/CLEHQvJrjAalIhk+1WLkbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aft2jw9AnoRYx0/3JFfxkxDpwv8ume3ZhRMNIv/u3Ug=;
 b=M9S2Qrywcc56ikgYCcSqJ+JM6IZ7E5mPcdTYz1Qn2oc7vWfopr1j1NkuJo6JQEFZ7omQflEFZC1I0okf+6fUwOekzODcnTlLNGgdYEgDWvh2uiW3vBTdU1EDTSrsP9CeWKaTKxY9g03eKVIWsi1rsseUtJj5zX84EaejBdzOBzg=
Received: from CYXPR02CA0070.namprd02.prod.outlook.com (2603:10b6:930:cd::20)
 by BN9PR12MB5035.namprd12.prod.outlook.com (2603:10b6:408:134::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Tue, 3 Oct
 2023 05:23:51 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:930:cd:cafe::a8) by CYXPR02CA0070.outlook.office365.com
 (2603:10b6:930:cd::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33 via Frontend
 Transport; Tue, 3 Oct 2023 05:23:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 3 Oct 2023 05:23:51 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 3 Oct
 2023 00:23:51 -0500
Received: from xsjtongh40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 3 Oct 2023 00:23:50 -0500
From: Tong Ho <tong.ho@amd.com>
To: <qemu-arm@nongnu.org>
CC: <qemu-devel@nongnu.org>, <alistair@alistair23.me>,
 <edgar.iglesias@gmail.com>, <peter.maydell@linaro.org>, <tong.ho@amd.com>
Subject: [PATCH] xlnx-bbram: hw/nvram: Remove deprecated device reset
Date: Mon, 2 Oct 2023 22:23:45 -0700
Message-ID: <20231003052345.199725-1-tong.ho@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|BN9PR12MB5035:EE_
X-MS-Office365-Filtering-Correlation-Id: d658f5ba-22c1-43fa-d8bf-08dbc3d0ee00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: juB4YPDHXWDRMHCLmSWu3yrUsWqX8U4b9qU9tds1rsjanqPYMLH/xm2Sp4iE8DPhLOQpeNEVCaUzsiMunXsaRnTu0tCFGK8CNXYu79EjfbhPq9Q/9Zp53movD66z3k3yDFup8JKy6RAAD8fvLcVNN4LJOlX/KeebOO6hHmIan3dfhroDhPkUgkIZGHks2E6sj/tLl3tYsvGLe0Hw6EzAUIbJQsGlHe7nITGKjx36albvGZsd04ZZzwJxDzDC3tJsRN4dGidHB1KUIhj9RwscT4pDZRXFCxT1iSeGjGm/Ej4m/ds4befUtPxlR68XGLkiTrF8Gp886BpJH6pbokecOS1nMB/lcFH5IdfmAyiMTAYmhEVvlehVwZMB8U/CecGcn1QYAXLoxvc02WsJNYngSTKEFvrYSsIL1SV6kgVWdS24XYzhMP6+u8vrGoVxSOIzQ7BO39A8EjpwZkkar9OEFd8zQHgpMmUc/xyZL9n6jamKM+qECyBFQjbvAwwg0Xj2cHgUwmPQgqK7TndpB/lkxOecahctc8ucQ7SjNCIH+VjPWZRSEt0/IM4G4689wf9ncexIFjWZXLLRW9uRpIJDYH7eQeCATbV8CaO68J3rRlFO2d51mhJA3ScBbOf2XUEHSu4Pw+ITI9oZns723GiXK2gk9kJd8vPgOoTBw3WdspvfW0iFQnt1P5G3V6jOdBUYQxz1QkrG9sDw39zpeaMnDmwgGdRLTsn7dDzYg92pkJwBYT7Zl1IsJtMXH5s4d09PXNg7gKnxnmQJV70KlU5baQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(136003)(39860400002)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(82310400011)(36840700001)(46966006)(40470700004)(47076005)(83380400001)(36860700001)(478600001)(40460700003)(1076003)(26005)(426003)(336012)(66899024)(82740400003)(40480700001)(81166007)(356005)(86362001)(2906002)(8676002)(44832011)(4326008)(5660300002)(8936002)(6666004)(6916009)(316002)(36756003)(41300700001)(54906003)(70586007)(70206006)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 05:23:51.5766 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d658f5ba-22c1-43fa-d8bf-08dbc3d0ee00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5035
Received-SPF: softfail client-ip=2a01:111:f400:7eaa::605;
 envelope-from=tong.ho@amd.com;
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

This change implements the ResettableClass interface for the device.

Signed-off-by: Tong Ho <tong.ho@amd.com>
---
 hw/nvram/xlnx-bbram.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/nvram/xlnx-bbram.c b/hw/nvram/xlnx-bbram.c
index c6b484cc85..e18e7770e1 100644
--- a/hw/nvram/xlnx-bbram.c
+++ b/hw/nvram/xlnx-bbram.c
@@ -2,6 +2,7 @@
  * QEMU model of the Xilinx BBRAM Battery Backed RAM
  *
  * Copyright (c) 2014-2021 Xilinx Inc.
+ * Copyright (c) 2023 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
@@ -416,9 +417,9 @@ static RegisterAccessInfo bbram_ctrl_regs_info[] = {
     }
 };
 
-static void bbram_ctrl_reset(DeviceState *dev)
+static void bbram_ctrl_reset_hold(Object *obj)
 {
-    XlnxBBRam *s = XLNX_BBRAM(dev);
+    XlnxBBRam *s = XLNX_BBRAM(obj);
     unsigned int i;
 
     for (i = 0; i < ARRAY_SIZE(s->regs_info); ++i) {
@@ -522,8 +523,9 @@ static Property bbram_ctrl_props[] = {
 static void bbram_ctrl_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
-    dc->reset = bbram_ctrl_reset;
+    rc->phases.hold = bbram_ctrl_reset_hold;
     dc->realize = bbram_ctrl_realize;
     dc->vmsd = &vmstate_bbram_ctrl;
     device_class_set_props(dc, bbram_ctrl_props);
-- 
2.25.1


