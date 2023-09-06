Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DA97944CE
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 22:54:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdzXL-0007jf-Ar; Wed, 06 Sep 2023 16:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <John.Allen@amd.com>)
 id 1qdzXJ-0007jL-8h
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 16:54:05 -0400
Received: from mail-sn1nam02on20628.outbound.protection.outlook.com
 ([2a01:111:f400:7ea9::628]
 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <John.Allen@amd.com>)
 id 1qdzXG-0004kN-Ia
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 16:54:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eTHc8K4l42kdNSkLEZ5vZnGc0FMwpSK+jWO1foasD13WCx3tWdqSfOoRCVyPyqL/qbb8mBUdod342UdcaBjfcLJkHxQRja6gnS4u1+0076/D85Gzk1L0nfotwhsiCAX4EIw5aui4M8VErX7l9zmdCf/TfjrndB/FhKGoaU4DxVHPKdhuS0xL7p0T6a6bgeaPWInGzxTfb6tx++7DH00nEBuxVkClKxWStFv2ZCGYs50qbU3u744huO5Rm34rs0Yw0Tbmg0XYaPCjVbCYoujcH7fDE/UrCFB0SpL+tBdMWVxGyPD67h6PDiX6DTHvIKzx3iR3Y4lmqm5K4CKrtv56cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8nASAOlzIjTBfvMybJyt8QaMQaXmaWoUENYyjwWT83Q=;
 b=KXLhTXdjo1I73kZBJwGD3ITnkBfr7E9lu2yY68ZTLJgnSPn0cZU2XmuIoKGRe+RUn/3tUZRZOWUbNZzsMOzAdQBuDEYa/JSQ4Ep6DqPW0sinMNltS+yvcNIB6HljDXdeeUK2lwSkZHuejgnxVfNUcMb9JrwX9qIa0/pSJSrP01LHTiGdU5fWxkVfvuyyig8qJVsX18ywpxDzZcoy+wsPVBpA2/u+UGN6KqXJHLGvl8IKOiSSwN+iuj1ZhzwG2OWNph6eU1tl3oDE7AURmyEwp+pkkdpK2kbBETOJtj9SQboWcJLSllkJrvw4LqRNbzG49CSgw2YHoKIXrcqLZ3gP1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8nASAOlzIjTBfvMybJyt8QaMQaXmaWoUENYyjwWT83Q=;
 b=IwqRIGf8Bnla2bJmA5gQbBGFul1qVVIwRSl4XO+a16eykamHxpK2s39KA21VvlD+E+QW/vLww2uf6zF0jOqY504yGEEHROp2LgbaIQNDr91e/HYPh8wBHBHAKy0ndDEtP5EcOZtiP7DD4eCXEWZ+gPbW5jGPWvVjdXUOehEsfV4=
Received: from CY5PR15CA0088.namprd15.prod.outlook.com (2603:10b6:930:18::29)
 by CH3PR12MB7691.namprd12.prod.outlook.com (2603:10b6:610:151::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 20:53:58 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:930:18:cafe::e7) by CY5PR15CA0088.outlook.office365.com
 (2603:10b6:930:18::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34 via Frontend
 Transport; Wed, 6 Sep 2023 20:53:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.205) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Wed, 6 Sep 2023 20:53:57 +0000
Received: from jallen-jump-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 6 Sep
 2023 15:53:56 -0500
From: John Allen <john.allen@amd.com>
To: <qemu-devel@nongnu.org>
CC: <yazen.ghannam@amd.com>, <michael.roth@amd.com>, <babu.moger@amd.com>,
 <william.roche@oracle.com>, <joao.m.martins@oracle.com>,
 <pbonzini@redhat.com>, <richard.henderson@linaro.org>, <eduardo@habkost.net>, 
 John Allen <john.allen@amd.com>
Subject: [PATCH v3 3/3] i386: Add support for SUCCOR feature
Date: Wed, 6 Sep 2023 20:53:08 +0000
Message-ID: <20230906205308.50334-4-john.allen@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230906205308.50334-1-john.allen@amd.com>
References: <20230906205308.50334-1-john.allen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|CH3PR12MB7691:EE_
X-MS-Office365-Filtering-Correlation-Id: fcce570f-9ffc-45bc-d77a-08dbaf1b63e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Ez03Bg4LifWlarijK/z5+XzMKJk3LAqsIFKOV77qQwTSFAbb3kAA8dWJjTLZxpU9X/iZO/nO4CLA00Ik2fyKG5ubzh/QflrzAkPxPQG0uPegd+44vq25V08C5qQjMwRS4sQdROdgj/qMm1W4g95aEgwziPE1E9itVdzrqIsc+KO9ezu+yw/28gY/JM5yeaW1mUN59o9AAxifwSRd9MhQgWPHguPwL59o1frMqMnS49PZkH5s5/a7rBzt1HeRkBfLSgtliLdezipAj4RFM92ewHVXS8DqpnBmdTXy3Nwp+DZTED8UEUY29GD2d1NxnSVdPRwOysebvOrUGs60ZLu0dB+lEXCEmuiV4ZEXc1zrOZGh1fs2D2FQSCSd8tAYET3o6geDTY9bfd5btbetYYTXm6vigCnUEJM4wf+jvrNp7WhTy51EkiGqI68Hfxpf1Zey/xNmPOZy5mTU11/vqLI6zkUzSfaaRCo/mkG7y/u+TWcPVeO7vpeT0/6r7I3VtF6ZK/2bRot9rcJIo02zrV8XBgKpf/cRVUhtxi5KRlbWpt8dd4bY3dB8r9Q3/47ySmjfKJU/Q4Uo1rmBhvV0rQXzIr8wTPwKGHmVUDBvqcJhkfB8mtKsRHqStKtJu1leataR1tz94aSSO90xdcgtxfFTO8eX4XZDmorQ+wSxh8eXLjeh4KXHqsIWm582cXnP4/IC1qGaUIC0ew7FwgO/tXALfBYrTRgYQxjeoKT2OlhoQ+ioiApw5BECTccqozaFrLDsh2qUl2vZj+LBuhNNQfJ0g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(82310400011)(451199024)(1800799009)(186009)(46966006)(40470700004)(36840700001)(356005)(7696005)(6666004)(478600001)(83380400001)(1076003)(2616005)(426003)(26005)(336012)(16526019)(2906002)(316002)(6916009)(54906003)(44832011)(70206006)(41300700001)(70586007)(5660300002)(8936002)(4326008)(8676002)(40460700003)(82740400003)(40480700001)(36860700001)(47076005)(36756003)(86362001)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 20:53:57.6686 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcce570f-9ffc-45bc-d77a-08dbaf1b63e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7691
Received-SPF: softfail client-ip=2a01:111:f400:7ea9::628;
 envelope-from=John.Allen@amd.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
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

Add cpuid bit definition for the SUCCOR feature. This cpuid bit is required to
be exposed to guests to allow them to handle machine check exceptions on AMD
hosts.

Reported-by: William Roche <william.roche@oracle.com>
Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: John Allen <john.allen@amd.com>
----
v2:
  - Add "succor" feature word.
  - Add case to kvm_arch_get_supported_cpuid for the SUCCOR feature.
---
 target/i386/cpu.c     | 18 +++++++++++++++++-
 target/i386/cpu.h     |  4 ++++
 target/i386/kvm/kvm.c |  2 ++
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 00f913b638..d90d3a9489 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1029,6 +1029,22 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .tcg_features = TCG_APM_FEATURES,
         .unmigratable_flags = CPUID_APM_INVTSC,
     },
+    [FEAT_8000_0007_EBX] = {
+        .type = CPUID_FEATURE_WORD,
+        .feat_names = {
+            NULL, "succor", NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+        },
+        .cpuid = { .eax = 0x80000007, .reg = R_EBX, },
+        .tcg_features = 0,
+        .unmigratable_flags = 0,
+    },
     [FEAT_8000_0008_EBX] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
@@ -6554,7 +6570,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         break;
     case 0x80000007:
         *eax = 0;
-        *ebx = 0;
+        *ebx = env->features[FEAT_8000_0007_EBX];
         *ecx = 0;
         *edx = env->features[FEAT_8000_0007_EDX];
         break;
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index a6000e93bd..f5afc5e4fd 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -598,6 +598,7 @@ typedef enum FeatureWord {
     FEAT_7_1_EAX,       /* CPUID[EAX=7,ECX=1].EAX */
     FEAT_8000_0001_EDX, /* CPUID[8000_0001].EDX */
     FEAT_8000_0001_ECX, /* CPUID[8000_0001].ECX */
+    FEAT_8000_0007_EBX, /* CPUID[8000_0007].EBX */
     FEAT_8000_0007_EDX, /* CPUID[8000_0007].EDX */
     FEAT_8000_0008_EBX, /* CPUID[8000_0008].EBX */
     FEAT_8000_0021_EAX, /* CPUID[8000_0021].EAX */
@@ -942,6 +943,9 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
 /* Packets which contain IP payload have LIP values */
 #define CPUID_14_0_ECX_LIP              (1U << 31)
 
+/* RAS Features */
+#define CPUID_8000_0007_EBX_SUCCOR      (1U << 1)
+
 /* CLZERO instruction */
 #define CPUID_8000_0008_EBX_CLZERO      (1U << 0)
 /* Always save/restore FP error pointers */
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 4d42d3ed4c..0255863421 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -477,6 +477,8 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
          */
         cpuid_1_edx = kvm_arch_get_supported_cpuid(s, 1, 0, R_EDX);
         ret |= cpuid_1_edx & CPUID_EXT2_AMD_ALIASES;
+    } else if (function == 0x80000007 && reg == R_EBX) {
+        ret |= CPUID_8000_0007_EBX_SUCCOR;
     } else if (function == KVM_CPUID_FEATURES && reg == R_EAX) {
         /* kvm_pv_unhalt is reported by GET_SUPPORTED_CPUID, but it can't
          * be enabled without the in-kernel irqchip
-- 
2.39.3


