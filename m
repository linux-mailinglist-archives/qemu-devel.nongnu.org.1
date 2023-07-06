Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B5B74A489
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 21:47:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHUvF-0000um-Ks; Thu, 06 Jul 2023 15:45:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <John.Allen@amd.com>)
 id 1qHUqS-0000TO-QQ
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 15:40:52 -0400
Received: from mail-dm6nam04on2060a.outbound.protection.outlook.com
 ([2a01:111:f400:7e8b::60a]
 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <John.Allen@amd.com>)
 id 1qHUqO-00038a-T0
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 15:40:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gsH1iUuhqDLpbnamRteJ35m62AoZs0/xN9hLPNFQz8RPNl4BmFfh3QbPeWS9kvhr6LkvZypStEx6LYiMwueKnMCT4vIgayQ66HsohSpEEMIAgx/QlJIWFYc3nmgaCRICyHNO27//ce3R+0CnmENxgmR5xqiiEx4h74zM0otlGztIOnk6YsgsMI0RkTYLpKp8Q48paVfcEAb8ZhPrgj+CF5J22rmn5Fk9z2KBl+tC6HaDoxrKWQu9bXxqdXeQeWSt2EjRbCxxl9Qb+FRoCnYJrRb/omJqPqcALQ1wxF6M1ahbjpZIPt/EyM47QbFU+3/oTd1D0BJsiIsGjBrKJepuKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1F1VSUGF7Wx/nkaKEjRweLxocdxSie6q3PnknM7OTSk=;
 b=ngqYMENgqdBBDd+3FFfz5OlfYxYRrc6VzxN9GNGE9TmRYmomxhYSQQiJES2XG4OR8s63YeWzxLKTOYugjJqSbECSCFi2vSituU7VSqCJkcpc8p/aradolC8KYpg7dOzv8/o4U91Z20xvO8HccxIq7LkaBcikT23jVt9TN6t9Fml0F7Rg24b1kiR27vxsiOOdhI6eWgUcmMeY1as35KZqAurZrmSd0NDklEjgbVoG9zbzr/4cewAXGt4nLsMSMjgkXMYkJORpDz8hpmwk3HNbkZZvfCwvpfKUFHORvYHSntp7rLpRu2MwuFlIT4ShJvwX3kbifvTInY7DUIDrfI0PSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1F1VSUGF7Wx/nkaKEjRweLxocdxSie6q3PnknM7OTSk=;
 b=w5EFwbBW+heI0EvcGsv238zxf9964oNY5gDGIGY1oeDrW2bzZE5LKUSecpiSREi/YIsNd6dLS4LT8M5lCjuMDfeQT0JY71jJzWdB093RwcoQ24CqrwEEUrBsSA/Rm944y0rQ4njb9Sf89RNPtiUTwfyap2G+ry6Xd+6WvxN1QSk=
Received: from BN9PR03CA0550.namprd03.prod.outlook.com (2603:10b6:408:138::15)
 by DM6PR12MB4154.namprd12.prod.outlook.com (2603:10b6:5:21d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 19:40:42 +0000
Received: from BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::41) by BN9PR03CA0550.outlook.office365.com
 (2603:10b6:408:138::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24 via Frontend
 Transport; Thu, 6 Jul 2023 19:40:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT057.mail.protection.outlook.com (10.13.177.49) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Thu, 6 Jul 2023 19:40:41 +0000
Received: from jallen-jump-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 6 Jul
 2023 14:40:41 -0500
From: John Allen <john.allen@amd.com>
To: <qemu-devel@nongnu.org>
CC: <yazen.ghannam@amd.com>, <michael.roth@amd.com>, <babu.moger@amd.com>,
 <william.roche@oracle.com>, <joao.m.martins@oracle.com>, John Allen
 <john.allen@amd.com>
Subject: [PATCH 1/2] i386: Add support for SUCCOR feature
Date: Thu, 6 Jul 2023 19:40:21 +0000
Message-ID: <20230706194022.2485195-2-john.allen@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230706194022.2485195-1-john.allen@amd.com>
References: <20230706194022.2485195-1-john.allen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT057:EE_|DM6PR12MB4154:EE_
X-MS-Office365-Filtering-Correlation-Id: 4abe875e-d471-48f5-eb99-08db7e58e217
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XfhXqbI82EkC6XKAHdY+Zz55OGPHeW7FenRG4PzTICCcgC1jot15plMRUDZfsJ3BrmPJSsJvqyEyQcUgpEWapMOpXfXIHDXkklS7H1HNBiMzN8hFMsaa8rI+19PM4nAQgwLOSC8i3WhmUKKnFpDEJQH/Lii+RhM7lh0ucZDH7LrtYi1nYHxy1BrQ0Nevd70IKcl9t+YR/RoA0OrtD06WGYnj1uTtJVQmDz5wlMeQ6Kd+XI3wNkonDpsYysZdBe8wh8N8tPqWY2WME+nOTSZje54ZdMafMYTLVO+duSB4TwSpsvIwz2DVMwUMEDcxS0drSU3SbS+EenEKffuKM0tqg9SwPbJKNH9G8ljPUdPdGeb2oDjn1MgOa9NTyDeSi1xdsJ7THhoHnTCLw2HxiTibOxOc0b6m3/ObNy9nCJKL301vl6TEnNNOQ0/boD4/7lfoxOPVzTijw/Ma5vCOZfJmDPCkaIIxH6/CNELasiP5S+8+8sofp7XaH4m64PMfP6jtbDzxeBwkhbhykfbg9g83sczlz9H8iMxZSW++4as5VIEc2xcONE/PhPd1jOesN71n9zIbqH4i460ZexNJcfQssLT/ZCw3vKyT2FrbEiSVJ+r6ZrBG8Fwdve8fbEhV12oQ/Zw3UjhJ248Qw6Rgk5DQQlQbQneUlMv3s8IJXWtf1UN3vS0ntQOHKz4oiq6AtFtiIcA47JKsZlRmOk3osJm/65iQTKksfRA11TgVOZeqRzea27NeXyExt59iTv4U4lgfL5s0CE+TdwbhzkeASvsy4g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(396003)(451199021)(40470700004)(36840700001)(46966006)(8936002)(2906002)(8676002)(2616005)(40480700001)(16526019)(5660300002)(44832011)(1076003)(26005)(186003)(336012)(70206006)(70586007)(40460700003)(41300700001)(81166007)(356005)(82740400003)(6916009)(6666004)(4326008)(426003)(47076005)(83380400001)(316002)(36756003)(7696005)(36860700001)(478600001)(54906003)(82310400005)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 19:40:41.8028 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4abe875e-d471-48f5-eb99-08db7e58e217
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4154
Received-SPF: softfail client-ip=2a01:111:f400:7e8b::60a;
 envelope-from=John.Allen@amd.com;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 06 Jul 2023 15:45:36 -0400
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

Add cpuid bit definition for the SUCCOR feature. This cpuid bit is required to
be exposed to guests to allow them to handle machine check exceptions on AMD
hosts.

Reported-by: William Roche <william.roche@oracle.com>
Signed-off-by: John Allen <john.allen@amd.com>
---
 target/i386/cpu.c | 2 +-
 target/i386/cpu.h | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 06009b80e8..09fae9337a 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5874,7 +5874,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         break;
     case 0x80000007:
         *eax = 0;
-        *ebx = 0;
+        *ebx = env->features[FEAT_8000_0007_EBX] | CPUID_8000_0007_EBX_SUCCOR;
         *ecx = 0;
         *edx = env->features[FEAT_8000_0007_EDX];
         break;
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 3edaad7688..fccb9b5a97 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -555,6 +555,7 @@ typedef enum FeatureWord {
     FEAT_7_1_EAX,       /* CPUID[EAX=7,ECX=1].EAX */
     FEAT_8000_0001_EDX, /* CPUID[8000_0001].EDX */
     FEAT_8000_0001_ECX, /* CPUID[8000_0001].ECX */
+    FEAT_8000_0007_EBX, /* CPUID[8000_0007].EBX */
     FEAT_8000_0007_EDX, /* CPUID[8000_0007].EDX */
     FEAT_8000_0008_EBX, /* CPUID[8000_0008].EBX */
     FEAT_C000_0001_EDX, /* CPUID[C000_0001].EDX */
@@ -856,6 +857,9 @@ typedef uint64_t FeatureWordArray[FEATURE_WORDS];
 /* Packets which contain IP payload have LIP values */
 #define CPUID_14_0_ECX_LIP              (1U << 31)
 
+/* RAS Features */
+#define CPUID_8000_0007_EBX_SUCCOR      (1U << 1)
+
 /* CLZERO instruction */
 #define CPUID_8000_0008_EBX_CLZERO      (1U << 0)
 /* Always save/restore FP error pointers */
-- 
2.39.3


