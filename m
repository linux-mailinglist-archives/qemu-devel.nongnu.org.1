Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0BD7B6055
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 07:23:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnXr8-0004zr-KA; Tue, 03 Oct 2023 01:22:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tong.ho@amd.com>)
 id 1qnXr6-0004z7-22; Tue, 03 Oct 2023 01:22:00 -0400
Received: from mail-bn1nam02on20631.outbound.protection.outlook.com
 ([2a01:111:f400:7eb2::631]
 helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tong.ho@amd.com>)
 id 1qnXr3-0005wY-KT; Tue, 03 Oct 2023 01:21:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ej3RARIT5HCb1ldm4xdrZCr0jDkaoRnt1SLWhBs/b1S+qEyUOaVd6WEzFjH3bm2coPShjwx2BXvUE+MhRhoPIWIt4/WpEL4ELHjXPadLddimSKt5fTiObwmuhwxZGX+PjlIcMtlZ0NcEucvQqZ+Pftlird4agZOa3JPRsizHpuuwTeIR0ZrXnflSMhF18a4s72GVoNe9z81OFvJ9LdlGwIlEKk3TLI/+7BlEnZHUtgq8IFtNJmg+fGQ/i8iTOm5E7WJW4WrjewVh05FAfqShW5IcOLNBuFpJIR0qNE9F8z2+6gLb2PIXkBxVpMscqGcT0jTli40/UEc0hBPfLD7SaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pd1hU9CK4Z0LNwODqfpgDB0lZnKuFFSveznyy5jzC44=;
 b=cb6cIESg3ov45QhK+D5nQ50AhdjnhTfCERM3k3qiEzndFmx9KWv+iySMV44uMwIqiY6Mw2ZGbQHdGjMkXcZ/BLzU6FK5AzcdCzVbN86tzGhqIx0mRWMRlH7jDpN1FoCm23HVtxq8l87X17m9Olj0vO8E3QfnSMUyY+0cPRLAL243shgpkwG/2/o2hNbEZgGvWg7HvMOxBAqObq5xBSaVwuz06LZsIe/QIoY0QWjiftZlf1d+zDUkY3VZANcn1b+LnwSlAOefELm5QSnrOgd/BuwGr5RhplT1jphY2TJYcTPZJER7SwRJMXCcC0K9WD7QpZSc8rfIETJpxZoetMYQEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pd1hU9CK4Z0LNwODqfpgDB0lZnKuFFSveznyy5jzC44=;
 b=1uVgUO0eL3vooT8+GMRDy0Y31/BoJijEBQ93ZCEo+7gVeiGnVK7It/tNK1yZo0uXWcYOpUVhPxH/+gXbCK+rwIMau7V4Fn3npGfDBZObhrwT8VwZ+F3Yqnb3JWiyiKSXz8gTlYQS5r42jUyJg3mwDF8jpDHa9l3SmvtBOfUSIr0=
Received: from MW4PR03CA0065.namprd03.prod.outlook.com (2603:10b6:303:b6::10)
 by SA1PR12MB7152.namprd12.prod.outlook.com (2603:10b6:806:2b2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Tue, 3 Oct
 2023 05:21:48 +0000
Received: from CO1PEPF000044EF.namprd05.prod.outlook.com
 (2603:10b6:303:b6:cafe::58) by MW4PR03CA0065.outlook.office365.com
 (2603:10b6:303:b6::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31 via Frontend
 Transport; Tue, 3 Oct 2023 05:21:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044EF.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Tue, 3 Oct 2023 05:21:47 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 3 Oct
 2023 00:21:44 -0500
Received: from xsjtongh40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 3 Oct 2023 00:21:44 -0500
From: Tong Ho <tong.ho@amd.com>
To: <qemu-arm@nongnu.org>
CC: <qemu-devel@nongnu.org>, <alistair@alistair23.me>,
 <edgar.iglesias@gmail.com>, <peter.maydell@linaro.org>, <tong.ho@amd.com>
Subject: [PATCH] xlnx-bbram: hw/nvram: Use dot in device type name
Date: Mon, 2 Oct 2023 22:21:39 -0700
Message-ID: <20231003052139.199665-1-tong.ho@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|SA1PR12MB7152:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c489842-0fc5-4e23-c07a-08dbc3d0a3f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1YS7NOLqYMEDhx48H+2dzh4Pg3NndfeQyITjTnmRF9gXGBJIKObeRcsNAOmhlFn7oliRfZ/4VydOGui4kS6pEmcRHCNDgX9w+BciRL2n0ckt/4mBU0Bcbq0hb5f7CcEgQ4LA/fAR2UsjY/QoW4YjheTZ7t5KBUzlEC6/a20gncf40WSsaGAZKRjrDVaBah7KL0vrZHdu9e9jFaD3dLQ9sbNJ+6BtqUzn60uCvSRVf7AUap78AKbLJgjGO8PrnBJDt+cQq3G2su7gyKy+Me7ZK/zWYxzFLvJuQtwexm9U0wUv6uixcEMtvPJ2XpUJvy/C1wRLigQw/zN5pwcydBlvXTXQCiqfOZazFxyvGgezB+21zeVoIeLgKbbiK9A0KkE9xGn8m2xblpNb/1uqHBxpQsYhvaGGM0dPgV43rrHc7mR6a798pD6//FOESMgQw6R3PPUZqrVE/dAX0cM0PgeKWt1fhPLC9lIq8Sy9PB/2y+iEnkDjF2Sodp3Lw1OK3FEkEoIKSRYxvXJChGAqDW8POhIRF00kHkJbJUi9u5RmrAWGh+kTA0ewXPi9kaSrpSnES9n9WfBHKDgWn7UppsQe0EeQEau0DxuitDCyqTpA1a6VRjDHrgFx+5mNW81cNHV1TtzaluRhctVhYe7cbFbWwGcyIP9Wqztzn7GpHO+X37uiomd/RtSTvVkh/6+Uug2PdbvB3lII6O/sTwWrkJ4z8UuJUYpb9N9JgfOrU+td88mCWbEpVL0g08FdMw5pGpTi3ugXgNH2TZj+l7mK8R9qAA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(396003)(39860400002)(346002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(82310400011)(36840700001)(40470700004)(46966006)(40460700003)(40480700001)(2616005)(336012)(26005)(426003)(1076003)(83380400001)(6916009)(54906003)(5660300002)(44832011)(70586007)(41300700001)(70206006)(6666004)(8676002)(4326008)(8936002)(316002)(478600001)(36860700001)(47076005)(82740400003)(356005)(81166007)(36756003)(4744005)(2906002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 05:21:47.2991 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c489842-0fc5-4e23-c07a-08dbc3d0a3f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7152
Received-SPF: softfail client-ip=2a01:111:f400:7eb2::631;
 envelope-from=tong.ho@amd.com;
 helo=NAM02-BN1-obe.outbound.protection.outlook.com
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

This replaces the comma (,) to dot (.) in the device type name
so the name can be used with the 'driver=' command line option.

Signed-off-by: Tong Ho <tong.ho@amd.com>
---
 include/hw/nvram/xlnx-bbram.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/nvram/xlnx-bbram.h b/include/hw/nvram/xlnx-bbram.h
index 87d59ef3c0..6fc13f8cc1 100644
--- a/include/hw/nvram/xlnx-bbram.h
+++ b/include/hw/nvram/xlnx-bbram.h
@@ -34,7 +34,7 @@
 
 #define RMAX_XLNX_BBRAM ((0x4c / 4) + 1)
 
-#define TYPE_XLNX_BBRAM "xlnx,bbram-ctrl"
+#define TYPE_XLNX_BBRAM "xlnx.bbram-ctrl"
 OBJECT_DECLARE_SIMPLE_TYPE(XlnxBBRam, XLNX_BBRAM);
 
 struct XlnxBBRam {
-- 
2.25.1


