Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 312709AF542
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Oct 2024 00:20:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t46Ah-0006ew-V8; Thu, 24 Oct 2024 18:19:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1t46Ac-0006eM-90
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 18:19:06 -0400
Received: from mail-dm3nam02on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2405::600]
 helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1t46AZ-0002TG-UO
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 18:19:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tr1Um7USf7e0kuv2xkD9aMfh4WUjn4zzJ7A05PZfd9nXvIPnqYIpsnqRXzk+21qs+6OkQAgDAq4bCL+wwYIi7TuS/BR9pQx/7MkrOKpNhlynxGAhQxch4rg+ZKpVvjJrG+UGPjozga6SrFjYi55YstoGBhFTOX7Ua/MxNl6TwgxA0D2U1z/cDMims2RFW/KwkrvoU+noESY70fujMQeWQbAr8bWr35wPo15AdpIFfswcJqE15se7qAuq/EWPXW7NkwVb54VCIENcWNZyYuZkb2o98LOWKWCSLqKQRfPoanzMnUqn7GLlaXjmujVKI4jlPWanPSMLBnsnp7FtvHGW2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lC/nWSHfr2KubAxQ1G96BsinYFLfMdavq+HNjo7NNy0=;
 b=SVyPtsw0tAvgFU7sJvESGuqLsKsbGLP7iE7yGqu5i69Eh5O1Ohcs66JdlqzwVcveoa+RyIt61oM8gVqGiKanR7x2QpCDuSr/MQNDTOtTgyBP1ob2dyro/unOySSRYKaLRKhnMElavgIoEoXAejZeW3FdNBUz2UVcEKVg6Qt160Y5NU9XLnckFd092AMvX2W94sm+sF8lcrbanRMhC1nzpnQJ075HFBRjFKQBYH17ShwRH58qOQIQTYe8hTHtC7f7i7Hs7aNxEKelwYnmHu4c0PRUbUrrKIbq8JRsc7w/kFFgE2b+xxtKxq/BdDMDNgzfws6ziO5LpuKCJAuhvsa8Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lC/nWSHfr2KubAxQ1G96BsinYFLfMdavq+HNjo7NNy0=;
 b=LxxK5firww6THxNnwl+up7wP386Yy2teJs4lmdlrnSm6Q024V+6DcK5YOS9cX90F9b2me6TzGyNw1qPVDRboLWejBwAC6CJI9bhnluTILosvs4q1ZOUk/EqICTb6wjgy4ySzoTLH7l43snloHHCHfDPxOTCQGpxxuvX/HioxHtg=
Received: from SJ0PR03CA0342.namprd03.prod.outlook.com (2603:10b6:a03:39c::17)
 by CH3PR12MB9145.namprd12.prod.outlook.com (2603:10b6:610:19b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Thu, 24 Oct
 2024 22:18:56 +0000
Received: from SJ1PEPF00002322.namprd03.prod.outlook.com
 (2603:10b6:a03:39c:cafe::a3) by SJ0PR03CA0342.outlook.office365.com
 (2603:10b6:a03:39c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18 via Frontend
 Transport; Thu, 24 Oct 2024 22:18:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002322.mail.protection.outlook.com (10.167.242.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Thu, 24 Oct 2024 22:18:56 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Oct
 2024 17:18:51 -0500
From: Babu Moger <babu.moger@amd.com>
To: <pbonzini@redhat.com>
CC: <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>
Subject: [PATCH v3 3/7] target/i386: Add PerfMonV2 feature bit
Date: Thu, 24 Oct 2024 17:18:21 -0500
Message-ID: <a96f00ee2637674c63c61e9fc4dee343ea818053.1729807947.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1729807947.git.babu.moger@amd.com>
References: <cover.1729807947.git.babu.moger@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002322:EE_|CH3PR12MB9145:EE_
X-MS-Office365-Filtering-Correlation-Id: b532df2d-f0f4-450a-4224-08dcf479d9f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UiRHepItkd1moQg8MqryX3vTQGuOnepRiRlijYks4yl8090xV8WYmVXUo3BI?=
 =?us-ascii?Q?ImpzK65Gg5Dtdc93QgqnfrkgBKiS/obV69mYzdZRmD2EecFpGpC4yOSz1/21?=
 =?us-ascii?Q?xaGAi3qiv9rAcADELc+l1RL6U8X2xkGVk5Nm7hTa4rcJU4PM1z0FmWRTXGAR?=
 =?us-ascii?Q?rIqPzziFl8Dg6ySBhOGx/ffgyL0bgJZlm+rY1UrWN3qIHiFxN4kIJu+jwNkE?=
 =?us-ascii?Q?fitWBdk8v58GRDAstrbpCJU12hcyA9c7/zy6z+KNiSMRsYKOvEvPYdb8rzDv?=
 =?us-ascii?Q?V8pLVmknurhB5gD8S+UIIukbRpfqgfg9O4sTkUKGHv/MTDuUJDrGScMoBQL3?=
 =?us-ascii?Q?Vz1GAMaZOyIpWkefyGKJyVIl60BRZBXC9WFM5LABywmGtGzWrQuimHWbeym8?=
 =?us-ascii?Q?6eKpxqUNakxLClWqk6WdwEBPMNCY4J8fkTVsZJhIT0Ij9VBrqyBRIK4m8RqA?=
 =?us-ascii?Q?gRHCfnTf9aEZn/PB2XhsiVSBIaPQ3st6Pl04m9DpZG3070+5ZeruO/+d91K7?=
 =?us-ascii?Q?v3FVxaDRYmLGqfyNjONaQB9eyoe+BQtN/XvpOMJVmnaQhEuJCpOnh4qoKqB0?=
 =?us-ascii?Q?QWnz1c77x5fiqKuu5Uu36HXgCiY1+sDglMTun6GXNYvPg4I0q3LGYJKCRf2S?=
 =?us-ascii?Q?9sDwSF+g08ieErRm3YHTTfNGSza4IQUU8TfSlnPAQWCF6idlqXt8Xp9PJFen?=
 =?us-ascii?Q?HEPb3i4JWIFmv8EB09qE8Yi6hmli5+Xw9uetEGBcRcUHHpVbCudBhpX5WaJM?=
 =?us-ascii?Q?Wo5bweM8EnhTAsHUoPda2usG8KOhIjJnfZHs15meGEupUWdZURizrygPLT3y?=
 =?us-ascii?Q?vejWUhK/w7A4+8KMa2trbB1Myc9S9AL1uLBFv+kseNPfgq21ydStNeW+Rykp?=
 =?us-ascii?Q?rD1MAYtQb+BP0bZxcC0JwvKSZGsdDBhENm5hDcSQbwicz7I/xWAjN/sZW9ko?=
 =?us-ascii?Q?Id/hCW5fW5Tu0Jdq8cniXJod9hUXzzMYuSM9F1XSP4FZJ6r8cNq9djTtn8Rq?=
 =?us-ascii?Q?5q5ixX5Z+qvALqIMa5Mq9B0lBZykty5A5OeAfPoEHi1WTwb2zppfpThrKuvM?=
 =?us-ascii?Q?UqmFwtWYtDfdQSojMGGYVAXuo/4KLHpJ7RHNtMy9OQcFbmilJGPygijmLrbU?=
 =?us-ascii?Q?ayeUds4rM4RESHV9DvRJdMrUYh3b2+urpDOlfqYxEWLZmc7Q69QGQKlPQXIv?=
 =?us-ascii?Q?o5j3HWUcuDm1YX1JBMDIVyzQw2vteLEKmd0FGWoUyxdDTk6QQLAvRKfNJrUZ?=
 =?us-ascii?Q?3BKk66LK1o8hiv1HupYGDLOtAscIiqeI+Hmnp0Fx7eBpyaV551NI7kNHYsvo?=
 =?us-ascii?Q?G3UjFEMtfHzoqr5m1rSTDknInatBYOCOZY0e47AWMRb06l5YVj+/8ObC9yjs?=
 =?us-ascii?Q?2YzYwx3j+/0mnCSvEHULYOABjm+D5kfSQhV1pd/qXjR35FoKaA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 22:18:56.3245 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b532df2d-f0f4-450a-4224-08dcf479d9f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002322.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9145
Received-SPF: permerror client-ip=2a01:111:f403:2405::600;
 envelope-from=Babu.Moger@amd.com;
 helo=NAM02-DM3-obe.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
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

From: Sandipan Das <sandipan.das@amd.com>

CPUID leaf 0x80000022, i.e. ExtPerfMonAndDbg, advertises new performance
monitoring features for AMD processors. Bit 0 of EAX indicates support
for Performance Monitoring Version 2 (PerfMonV2) features. If found to
be set during PMU initialization, the EBX bits can be used to determine
the number of available counters for different PMUs. It also denotes the
availability of global control and status registers.

Add the required CPUID feature word and feature bit to allow guests to
make use of the PerfMonV2 features.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
v3: No changes

v2: Used OR instead of overwrite for eax and ebx.
    Added Zhao's Reviewed-by.
---
 target/i386/cpu.c | 26 ++++++++++++++++++++++++++
 target/i386/cpu.h |  4 ++++
 2 files changed, 30 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index e88859056a..d697c8ea6e 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1227,6 +1227,22 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .tcg_features = 0,
         .unmigratable_flags = 0,
     },
+    [FEAT_8000_0022_EAX] = {
+        .type = CPUID_FEATURE_WORD,
+        .feat_names = {
+            "perfmon-v2", NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+        },
+        .cpuid = { .eax = 0x80000022, .reg = R_EAX, },
+        .tcg_features = 0,
+        .unmigratable_flags = 0,
+    },
     [FEAT_XSAVE] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
@@ -7040,6 +7056,16 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *edx = 0;
         }
         break;
+    case 0x80000022:
+        *eax = *ebx = *ecx = *edx = 0;
+        /* AMD Extended Performance Monitoring and Debug */
+        if (kvm_enabled() && cpu->enable_pmu &&
+            (env->features[FEAT_8000_0022_EAX] & CPUID_8000_0022_EAX_PERFMON_V2)) {
+            *eax |= CPUID_8000_0022_EAX_PERFMON_V2;
+            *ebx |= kvm_arch_get_supported_cpuid(cs->kvm_state, index, count,
+                                                 R_EBX) & 0xf;
+        }
+        break;
     case 0xC0000000:
         *eax = env->cpuid_xlevel2;
         *ebx = 0;
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 9eb45faa65..e0dea1ba54 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -634,6 +634,7 @@ typedef enum FeatureWord {
     FEAT_8000_0007_EDX, /* CPUID[8000_0007].EDX */
     FEAT_8000_0008_EBX, /* CPUID[8000_0008].EBX */
     FEAT_8000_0021_EAX, /* CPUID[8000_0021].EAX */
+    FEAT_8000_0022_EAX, /* CPUID[8000_0022].EAX */
     FEAT_C000_0001_EDX, /* CPUID[C000_0001].EDX */
     FEAT_KVM,           /* CPUID[4000_0001].EAX (KVM_CPUID_FEATURES) */
     FEAT_KVM_HINTS,     /* CPUID[4000_0001].EDX */
@@ -1022,6 +1023,9 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 /* Automatic IBRS */
 #define CPUID_8000_0021_EAX_AUTO_IBRS   (1U << 8)
 
+/* Performance Monitoring Version 2 */
+#define CPUID_8000_0022_EAX_PERFMON_V2  (1U << 0)
+
 #define CPUID_XSAVE_XSAVEOPT   (1U << 0)
 #define CPUID_XSAVE_XSAVEC     (1U << 1)
 #define CPUID_XSAVE_XGETBV1    (1U << 2)
-- 
2.34.1


