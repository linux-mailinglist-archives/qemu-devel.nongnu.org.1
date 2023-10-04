Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C62D7B778F
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 07:58:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnut7-0006VO-QJ; Wed, 04 Oct 2023 01:57:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tong.ho@amd.com>)
 id 1qnut1-0006Uc-2X; Wed, 04 Oct 2023 01:57:31 -0400
Received: from mail-dm6nam12on2062b.outbound.protection.outlook.com
 ([2a01:111:f400:fe59::62b]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tong.ho@amd.com>)
 id 1qnusw-0001br-NS; Wed, 04 Oct 2023 01:57:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KW7imu8Cj8IMx+4WAkki5LvprJvfCwTUmTTZ5n827gGd7UFSXEIaNVDCNywrnOrTInFmEEUn9RLzSRGHxy4+qfPCoNyFat0eR02W8hShbWScFdTxZGcdM/j3ziG8do2UBfdX1HTNMAM7qkSPsI3X9ek1/JjdnzO/2wsXaku4p3Qemt8j196VtE3JGLLEfs+8AXSqzKfE4leiyWpJnS6hOSc7oDNIGW/+MjonQV29SU1a9qnV84vdnaBlt24SYz2H4cFC5smhZq/92eq5E6U08X9l/V2bmtGGD6JxBz3+TOc2E8NVFfz9uHR0sMkxu18jG7unsa/D0q9tXvvSiFGl8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MyPxB2huVdf52EoKE+ayIuPibEDhY375ngG9IRdv7Zs=;
 b=jc1Sfk2kJkoZqtbry4MSO+b8wxCAZOAiDgckr8I150LuC8cp8UxsTqwx12S9MoEPdD4YIYIBp8mhXlwqb2jyeta8MxQ3Q6+n/1Yndq41FCoB6SFaQGhVrcMw7vMT/zrGvOFQAzgwnQjSaTsI4WzaOq8La02ypUh9Io+mlHhOhfYfJWa8QSEH5SDbmbteLJG62ueYzVovbc4UV8dqZuG+z78lG/8TREbR9VRknvCjr+Y+T+L3Wsy61k0ORJB3j05m6AZlvMkhkMLy/Vqo7vHdqzvI9iv23XdFeW135vCPpu1swB5mC8hCnMIf52Mx/rAGiLghbwYOZV9d7lTQOTQfGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MyPxB2huVdf52EoKE+ayIuPibEDhY375ngG9IRdv7Zs=;
 b=kcqIckGuFc3l0tb9umjhO/N/FVNBz0t2XCXy7zdu4mOG+nKN0A1vFX49Q4R454WghwKy88LrIuIkHkzYcWrL/TM4OS1oOqNNV1zHb8gI8eHUQFaDe0GyGoSx2a89aPcvxfB12vxNUug0Ht0KZSmZ/9HU2wpbVHaC1NxFMcuqWDI=
Received: from CY5PR04CA0007.namprd04.prod.outlook.com (2603:10b6:930:1e::27)
 by CH3PR12MB7738.namprd12.prod.outlook.com (2603:10b6:610:14e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Wed, 4 Oct
 2023 05:57:20 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:930:1e:cafe::73) by CY5PR04CA0007.outlook.office365.com
 (2603:10b6:930:1e::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.26 via Frontend
 Transport; Wed, 4 Oct 2023 05:57:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.147) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.15 via Frontend Transport; Wed, 4 Oct 2023 05:57:19 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 00:57:19 -0500
Received: from xsjtongh40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 4 Oct 2023 00:57:18 -0500
From: Tong Ho <tong.ho@amd.com>
To: <qemu-arm@nongnu.org>
CC: <qemu-devel@nongnu.org>, <alistair@alistair23.me>,
 <edgar.iglesias@gmail.com>, <peter.maydell@linaro.org>, <tong.ho@amd.com>
Subject: [PATCH] xlnx-zynqmp-efuse: hw/nvram: Remove deprecated device reset
Date: Tue, 3 Oct 2023 22:57:13 -0700
Message-ID: <20231004055713.324009-1-tong.ho@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|CH3PR12MB7738:EE_
X-MS-Office365-Filtering-Correlation-Id: 916c1b93-935a-4d63-5dae-08dbc49ec568
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MOEhY6UFVIy9P9WOpwwd5IECxoCELgD0JgdLnngHrNd9Ez9w8xnXNXqanp7rQhgcjLQxnbba0EE1Rnj07FnUfnvpqttDXwLOqiNL7tqddeh6zyo7HSI7XPQXoQKV5/o4wxCx04rdEFOXXkF+ctZ4SAr3EtMXWM2IuNB7sMrsCk6CbiW1J734fO1Sgt5+AwEnGI1klXxQngXOXTp3ZeQ56vUbTakF+XIn8nUV1kpvR8rxTLQU7K/GXheDdoTGG9alhMjNuF4mWhxFi96eXnKBvW1lLUPJwbCacT+uekndVdsvmMfHIS5hZfLfoxuR1ahfF1fFLfjNJUDsn6eRhgDMTNTRgYShXZbJr38Q0sFK71BXKEblX6WBftpDWFe8lLJV4X4UijI2o/RDx1hMaqE7gBXUnRzhggT+kbNNtkNNwiOEk6Rtsh8K0XcArDzLfVko6lVdt+is12v2RNkSAgubRVCrWdp10HJMXntdyPODZDz575us2+RgLChePmHtV9eut6VchDX8GsotHiG7PyrQ9AipANC+t5QtOppefu6jJikdjq1YjDp2xYO4uF9rs0LSjB59PCqu7ei3MaqQ3DoRVXz5JIXaPKlttxTReSii5cRLruuO3FLmQcLlEYtzffSFxQ2ZsAlloErQdbXvnJjZrYJeAW/nCtsmy1NZsvI7CwUZlY1b/dbFIIfOqSisH5SrIZvdNEeuggs0sOolM+XG3vF8veI8o0swQP9iADALEyRfL3uSFmPPSNwEeJSdHGB74ngbbjiHXdREoyXJOqXEbQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(396003)(136003)(346002)(230922051799003)(451199024)(1800799009)(64100799003)(82310400011)(186009)(40470700004)(36840700001)(46966006)(40460700003)(40480700001)(316002)(70586007)(70206006)(41300700001)(54906003)(6916009)(478600001)(2906002)(36756003)(86362001)(5660300002)(8936002)(8676002)(4326008)(44832011)(83380400001)(36860700001)(47076005)(81166007)(82740400003)(356005)(6666004)(426003)(336012)(1076003)(2616005)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 05:57:19.7791 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 916c1b93-935a-4d63-5dae-08dbc49ec568
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7738
Received-SPF: softfail client-ip=2a01:111:f400:fe59::62b;
 envelope-from=tong.ho@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
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
 hw/nvram/xlnx-zynqmp-efuse.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/nvram/xlnx-zynqmp-efuse.c b/hw/nvram/xlnx-zynqmp-efuse.c
index 228ba0bbfa..3db5f98ec1 100644
--- a/hw/nvram/xlnx-zynqmp-efuse.c
+++ b/hw/nvram/xlnx-zynqmp-efuse.c
@@ -2,6 +2,7 @@
  * QEMU model of the ZynqMP eFuse
  *
  * Copyright (c) 2015 Xilinx Inc.
+ * Copyright (c) 2023 Advanced Micro Devices, Inc.
  *
  * Written by Edgar E. Iglesias <edgari@xilinx.com>
  *
@@ -769,9 +770,9 @@ static void zynqmp_efuse_register_reset(RegisterInfo *reg)
     register_reset(reg);
 }
 
-static void zynqmp_efuse_reset(DeviceState *dev)
+static void zynqmp_efuse_reset_hold(Object *obj)
 {
-    XlnxZynqMPEFuse *s = XLNX_ZYNQMP_EFUSE(dev);
+    XlnxZynqMPEFuse *s = XLNX_ZYNQMP_EFUSE(obj);
     unsigned int i;
 
     for (i = 0; i < ARRAY_SIZE(s->regs_info); ++i) {
@@ -837,8 +838,9 @@ static Property zynqmp_efuse_props[] = {
 static void zynqmp_efuse_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
-    dc->reset = zynqmp_efuse_reset;
+    rc->phases.hold = zynqmp_efuse_reset_hold;
     dc->realize = zynqmp_efuse_realize;
     dc->vmsd = &vmstate_efuse;
     device_class_set_props(dc, zynqmp_efuse_props);
-- 
2.25.1


