Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CE67640CB
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 22:57:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOlLB-0007F1-JV; Wed, 26 Jul 2023 16:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <John.Allen@amd.com>)
 id 1qOlKx-0007Ef-HZ
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 16:42:24 -0400
Received: from mail-dm6nam10on2060b.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::60b]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <John.Allen@amd.com>)
 id 1qOlKv-00045m-Hy
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 16:42:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BffLXa8jBXmrywIjZOFOK5lq9GKk36WYjefIYWp7e5EvXZq91WrmxwTi/UY7YISqcQRzu0/AnWgpviZsix2uy+d2TuoCk3PtF8kyVB7FrpPy95qu113y7H/w5/pMJMqm5K+RkcK7fqOBElatMTScSY0I33dbQw3LT6bARRrXYedl6fv8IXYffhW55oDmLOYrm3ZEkIf+q5YJQBYmFrpR4MoP+LiZNToSwf/lK7WT3591TMyHW1sNGCtau2VLOBayIGy/UCyTaSdt5KxCoCTj2u/hpSsLTKo25EG4qPYB2pKvwDM8FVgpOSM/ZR+gu92BGYxNL1J4wfUxry00TS6r4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SiQOKLXkn+JxTqyO6y9lyNzA1rN684Ia2u/129zx2ZI=;
 b=KDLasUxZDHsTwCU0c4NfVOHRb6dA2/KBd0v1OPX9E3ycEmELtzGVrCBXvQbgz9/5baSCT9lpm3gevAiQ1zpNI5QDk1oTnm/KI2TfaSmgXeF4V9jhe0JzBBoD1MRSV2uslo0Bv24yON5jyNNxeVunBPw1cvV7va/gcBHFn+mADevE+Eqe359Q8EfURGOB2a0baqooflkFl4g4hlpM5PpMzhw95CRzYNTt0Ve55G9Z2V/fgrlZRstm8S4PCGR7FqTKQYtWxIaaXdmm+3IBFGvrHum9y7ULgl3JhUNwLDZA0M2AfP5kbjQ+JW0J7cG9OXY7jGK4ycynXo1HRpZp+76zSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SiQOKLXkn+JxTqyO6y9lyNzA1rN684Ia2u/129zx2ZI=;
 b=AWq91HplK9jT9304jO2GJRDWWOPBN3kf2o6cB+MEBuFCY3t5vAGp96QgRH/sFznomke9dVRSxrW6SMw/ZH5PQQ4VsjooWeIYOVWRv/nQqXMe/HtZCQADC/342lWOVhrUHrEnSen5zTk4WW6xxT1PNMygHgJFWYqGR0bG3nzRA0s=
Received: from BN8PR03CA0027.namprd03.prod.outlook.com (2603:10b6:408:94::40)
 by SN7PR12MB7274.namprd12.prod.outlook.com (2603:10b6:806:2ad::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 20:42:16 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:94:cafe::7) by BN8PR03CA0027.outlook.office365.com
 (2603:10b6:408:94::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Wed, 26 Jul 2023 20:42:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Wed, 26 Jul 2023 20:42:15 +0000
Received: from jallen-jump-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 26 Jul
 2023 15:42:14 -0500
From: John Allen <john.allen@amd.com>
To: <qemu-devel@nongnu.org>
CC: <yazen.ghannam@amd.com>, <michael.roth@amd.com>, <babu.moger@amd.com>,
 <william.roche@oracle.com>, <joao.m.martins@oracle.com>,
 <pbonzini@redhat.com>, <richard.henderson@linaro.org>, <eduardo@habkost.net>, 
 John Allen <john.allen@amd.com>
Subject: [PATCH v2 1/2] i386: Add support for SUCCOR feature
Date: Wed, 26 Jul 2023 20:41:56 +0000
Message-ID: <20230726204157.3604531-2-john.allen@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230726204157.3604531-1-john.allen@amd.com>
References: <20230726204157.3604531-1-john.allen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT050:EE_|SN7PR12MB7274:EE_
X-MS-Office365-Filtering-Correlation-Id: e668b8fd-7cb3-4c14-0d2c-08db8e18cc0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CS7EZtrcX7ShAFmYmO2pkmNr9ZieVLSk42SDrfptfcp51kB0tm59WejP1JxJIGEsy+j3JYbOhLxD/I4u/Jv5XQvWrmM3gRhOXN4wstb+2FhuFHKRPI1nfZ05I7x4kQDPnErS1TbNhvkkFoZdcVIdiwotNQSsfm1pOcvkT0/qgduvFuLL7dl5SVjqlsdKIvLg1VRp8A1zdGLAhvfrRS9CMlKY42wd+BqkFvytLwGvQOKnWTB+KZFQG145wJ5xD+hpdLuBH+kFosOu0DlqiFcGlh5JPf1lbyLSM9VMWvtTUhXkobFRNyNfySPHiKz1oYJU6RgcwKD/+kzhKSk536MFWHmCKb4xV8f1Cbu2zp9RKLxrWEY0VFpyYc8aDUStrkoL5D/cEit1UcMWpr1Xs2HTZgBUFhJFLjnTcQknw+p37LlYj2p3e6+CFOtS0QNmOcFeJ32WxKGmhI7FOp9SCivGonze3eqaXASrpe7hejSQ4E0BuXNv2COCnKuRTBDe+L0RJo1drMxtLyC+dihB9YBrn5K8NT/yA1JcSHRc2M60obnearCY+hHEBule+V8/lImx/waBDXgEUuJ7S5muctMqETLd/LA6iyOA/Y3ZX1lIVU0OqgfymBmxrEC1+FAl/5dhOR7UwvVgpJzbHtuHgQDMxywpLjuRWN32iancO7gnPm5Fcjgf6zfuezEP9/73jYG1X+/MwsdkCWC6SwsEg7WWvGs9QDE5oBRyPU1n9M9UyoIQDUzNEMcDP6w9p2MBJKM+6RrScmWxsl4v6UJTGEriOQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199021)(82310400008)(46966006)(40470700004)(36840700001)(47076005)(478600001)(54906003)(86362001)(70206006)(70586007)(6916009)(81166007)(4326008)(316002)(356005)(16526019)(40480700001)(186003)(1076003)(336012)(82740400003)(7696005)(6666004)(26005)(40460700003)(44832011)(5660300002)(8676002)(8936002)(41300700001)(2906002)(2616005)(426003)(36756003)(83380400001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 20:42:15.6355 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e668b8fd-7cb3-4c14-0d2c-08db8e18cc0d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7274
Received-SPF: softfail client-ip=2a01:111:f400:7e88::60b;
 envelope-from=John.Allen@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Signed-off-by: John Allen <john.allen@amd.com>
---
v2:
  - Add "succor" feature word.
  - Add case to kvm_arch_get_supported_cpuid for the SUCCOR feature.
---
 target/i386/cpu.c     | 18 +++++++++++++++++-
 target/i386/cpu.h     |  4 ++++
 target/i386/kvm/kvm.c |  2 ++
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 06009b80e8..9708785255 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -872,6 +872,22 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .tcg_features = TCG_7_1_EAX_FEATURES,
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
     [FEAT_8000_0007_EDX] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
@@ -5874,7 +5890,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         break;
     case 0x80000007:
         *eax = 0;
-        *ebx = 0;
+        *ebx = env->features[FEAT_8000_0007_EBX];
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
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index f25837f63f..4b62138459 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -417,6 +417,8 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
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


