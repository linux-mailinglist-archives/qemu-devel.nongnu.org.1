Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E8E79DA9F
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 23:20:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgAnD-0001nJ-MJ; Tue, 12 Sep 2023 17:19:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <John.Allen@amd.com>)
 id 1qgAnC-0001n4-Ha
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 17:19:30 -0400
Received: from mail-dm6nam11on20617.outbound.protection.outlook.com
 ([2a01:111:f400:7eaa::617]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <John.Allen@amd.com>)
 id 1qgAn7-0004pR-RH
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 17:19:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m4NXkiX1Z6TApmefM3S2xJU+AFHiYi+zO7VgS8P0iu9TedIsVFaC7wWpimdUtIpJ4j/t7Y5acCoTO/SgyYS7QTZ1Ut/8IHV1x/FnNIT9fMgC4XfKJfMuhbltSOiSYe97yqw5E8f5HVqMYO22ZrgFuN2eeD44EmjrI/ydmZco/kZuoRSzeJ+7nsTNaU2HALgt3tEOGptswem5MleDQoYqvkgldmH7LNLFlWobcrNdCCGCW13+sIT2ACudH6s7cK0woK4AcDm7OVH/ObTBC0RwZvEJYxqjJdKBnUquMMX2oDv7uuYripWbdXSOiF6I2KQf9fSye53rXgFEwy6GUFW6/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=syfvB1Uw9nYmLuJfQCrLQco9Tw0+lq98/tlDjFaIX24=;
 b=P4d6AKcAC8moLESwlqGuHePDlW4v5GdwkpNp6A7bKm1jMu8XEPphxk2vXdeoCC3pcCDoCoCzpizeM6olXlcppqt3b1QmO8Yrp+qsmlKS1Er3Yqse5iVHJR9r6wN4FOdkQ8Lvf/a6ttNW1MImcGnLk4mgSLiJNgV4pdRyaWspMZGEEv9/hLR1t2u0SvT/f7FMRFqM7ziNdmxittl9cIGRUijmNsjSc+R5J+jr9Mpouq3jr/4B26TgXZLpi76zALT8wsJ5UJVRawMpjx4EcW7gd5+g7CXBKBJhac8ABKMaGGD3OGZ1E4BzUhzOll0tdTqujQeEMOBrIdnF187wFckcGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=syfvB1Uw9nYmLuJfQCrLQco9Tw0+lq98/tlDjFaIX24=;
 b=kE8f6DOwp1nqhhajtBiAE4astzvFbLkMCnLx8t8zKFB59BIfhfnHwPzxYunG3Bs+MAkw8QqvJLtiZgV9aIL1Ns114OigVTKPw1So59QA8LToQaEJ3gDgsOH7630EPOFEL7gNiaU75GOgMKp0yOg04+FyS3Nvov//nih0VnVhyxU=
Received: from MN2PR01CA0013.prod.exchangelabs.com (2603:10b6:208:10c::26) by
 CY8PR12MB7292.namprd12.prod.outlook.com (2603:10b6:930:53::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.30; Tue, 12 Sep 2023 21:19:22 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:208:10c:cafe::cb) by MN2PR01CA0013.outlook.office365.com
 (2603:10b6:208:10c::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35 via Frontend
 Transport; Tue, 12 Sep 2023 21:19:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.17 via Frontend Transport; Tue, 12 Sep 2023 21:19:22 +0000
Received: from jallen-jump-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 12 Sep
 2023 16:19:20 -0500
From: John Allen <john.allen@amd.com>
To: <qemu-devel@nongnu.org>
CC: <yazen.ghannam@amd.com>, <michael.roth@amd.com>, <babu.moger@amd.com>,
 <william.roche@oracle.com>, <joao.m.martins@oracle.com>,
 <pbonzini@redhat.com>, <richard.henderson@linaro.org>, <eduardo@habkost.net>, 
 John Allen <john.allen@amd.com>
Subject: [PATCH v4 3/3] i386: Add support for SUCCOR feature
Date: Tue, 12 Sep 2023 21:18:24 +0000
Message-ID: <20230912211824.90952-4-john.allen@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230912211824.90952-1-john.allen@amd.com>
References: <20230912211824.90952-1-john.allen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|CY8PR12MB7292:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f24a780-c504-4c4c-94f1-08dbb3d5eee6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c8tWnolwChR9iBXzPL5Pzyhc1m8Rc1XfE/QYcbkld7O75XaIS68sTkjLIO6Zd7LaQpNqqDnNCgIBUOjvNcX7nFX129LnocYRd90UX+QWxkl6uTw3xD6Oezmip9qGEr5K3wuL1BTbw+b0sAKLTdc3SJneRyFf597+YRiu4SkplKaOAEhfXGkFp/l/Zs93cpDlUy1ySF/u77n3GXsHK3DXbmJvamofHczvLvk1v7Zaw9yT9V4Q5zIaRuir6Ais8RvEuAuykV0uQ9kYxNWUp7sWfccOuVWLQ7ykh6Zhjfa5FvkhHEDHc1vmo5ITxiZ2EeHixrMTucLovJfr7k6WnVyhMg64uNVda3eGDyVe7BZTJ+++smRK75mTQVTHfDyRuRUqPEOR2WH3B4W8H9koGx7lwf2v0+xB9Zn65SfbRHdbWDHWQJc6oLHCIkXanZIO9rVarQBjoqq25twWQwVyKP2vKjIfvh/2pwtyRDxiRwnAOy1h7a/IqEFtuObWu3ABRWnxRona7BGkuR2o3aW5vEk/RXL//1eHupPR86ct7CC2dnSLQ2uvob3kAal6PPvSOecO6CurBZIW80pXwN8tABAwpR09/eGLnGLh9CqTpGGjGhez/LQqTKrh8lofapsjlzjKvHRerwPK7hSkRsgeKn1C9VqEjLXjTjD9Al2L3Rra/JaB25zrd10i2T/y8xVRdf9EMtXn7Xb5LNZE0ek48TirxQEBduEbFv4ukx03GUhlktDtfteVSNFfGacFQjtZXed8y6fjr9OU/zx0W3N9jNafAA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(376002)(136003)(346002)(1800799009)(82310400011)(186009)(451199024)(40470700004)(46966006)(36840700001)(356005)(426003)(82740400003)(81166007)(36756003)(40480700001)(86362001)(40460700003)(478600001)(2906002)(8676002)(70586007)(7696005)(4326008)(8936002)(26005)(5660300002)(44832011)(70206006)(6916009)(41300700001)(54906003)(316002)(36860700001)(47076005)(83380400001)(2616005)(16526019)(336012)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 21:19:22.0083 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f24a780-c504-4c4c-94f1-08dbb3d5eee6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7292
Received-SPF: softfail client-ip=2a01:111:f400:7eaa::617;
 envelope-from=John.Allen@amd.com;
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
index 7e9fc0cac5..15a642a894 100644
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


