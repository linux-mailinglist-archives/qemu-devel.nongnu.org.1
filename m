Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E30A4A128
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Feb 2025 19:08:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1to4mb-0006ML-5S; Fri, 28 Feb 2025 13:08:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1to4mM-0005wF-TO
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 13:08:06 -0500
Received: from mail-mw2nam10on20631.outbound.protection.outlook.com
 ([2a01:111:f403:2412::631]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1to4mK-0002W7-Rc
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 13:08:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XhB85ZaLUXzEtJJrpL+opuLFeNIi3d7SdkYAujjA/1gPssdHtnA7SiXhNV1Q5Q4Lz+TW4jWVHc4igLKheuVFaU976tEmwCKrVxs7asGBmVbqz+b2WbtxStBBkw25ceIB7n+lpQIIHoHHwUJ5zfPjuzb14V15txon35CoxVud7dYYqcihD0OiwSKultM31hX/qX7PZqy2FF5h1frc34FNMeBiv3pwnBcfc9YYa1IZZjTNQG72W2bDYqoI7PX+4JSA8+LKhecacAQCCLPmBRurbqDdYs0RBtvKN9dQRlYOmh4v3AVDir+hMqbrLll9OwPkITKQkouAkyZ4LmdEwFCMBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aVeULQ+Eb8fvVEv9FUxZ/7bE5TjiFYthpnLAE5e7kvU=;
 b=tawIzD+qkmXt+hykkhUOYKFTVHnM9pxzGKma5my+YONBVmHIJq5kBjZVOiuaziLSp3HftxIHry7mGvFgHvYM8o69oGG0nxgYeC9Yn9btZjQrbdxqmBiOE44tt7iC6Kwhqujp5yRblXharTKOnBF9I2ELL05f86hyl3ZxPTUxfZcXXcCCMNR+qADR4S6uIbA5MhJdoYpuWrSLtLk2BIF9RtcHf2y2R0mtSTf3meFXfUDR0wKBWufvSwnFvmfe3UMySz/uicIgfgfL5hXGAGpFAp38MTdqya8HKsL7LfhqZyxgUsBJRq6dU1dvbJ8sPgjuLlM+PLN/r3XoLB5tiADxVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVeULQ+Eb8fvVEv9FUxZ/7bE5TjiFYthpnLAE5e7kvU=;
 b=LCgrz6ME1G3zmoVy8zvH9Z4ESgxxCg2wQkWciIsoabcYlGuuW4C/Xzqy8ddicuWWIdBUD6/K42RzbGHgokicvKsrCc8c+Y3mbf84iloRE1KT+uKgEY/FyNmG2I4ZRVbxD5xGUNaIe7bLeQEoGS2GrI2y5pg1Do6ylqblZmdil30=
Received: from SJ0PR13CA0123.namprd13.prod.outlook.com (2603:10b6:a03:2c6::8)
 by CYYPR12MB8872.namprd12.prod.outlook.com (2603:10b6:930:c8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Fri, 28 Feb
 2025 18:08:00 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::a6) by SJ0PR13CA0123.outlook.office365.com
 (2603:10b6:a03:2c6::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.10 via Frontend Transport; Fri,
 28 Feb 2025 18:08:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 18:07:59 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 12:07:58 -0600
From: Babu Moger <babu.moger@amd.com>
To: <pbonzini@redhat.com>
CC: <zhao1.liu@intel.com>, <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>,
 <davydov-max@yandex-team.ru>
Subject: [PATCH v6 6/6] target/i386: Add support for EPYC-Turin model
Date: Fri, 28 Feb 2025 12:07:06 -0600
Message-ID: <51b0e6fdd7caafd365f3a0f38a177920c7a167c5.1740766026.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1740766026.git.babu.moger@amd.com>
References: <cover.1740766026.git.babu.moger@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|CYYPR12MB8872:EE_
X-MS-Office365-Filtering-Correlation-Id: b7855d33-e65d-4f50-4397-08dd5822d603
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?O4a8zIBuWfV2zBesqvZizN+zPFc1uVvNoNV97uZHygLs4VX1rs/62ImGLZwh?=
 =?us-ascii?Q?8gYRwBHuh4aqJPVQQVwOqV9P1MQJiEzPuwQKs/H9tp/IT146O/tiRIlsTiGO?=
 =?us-ascii?Q?bGIqz8mGfAYQr0iZOOOdIP/RQnEjekKCzsyN1yh43L9zOwQ/fLKl07slwFFD?=
 =?us-ascii?Q?ZsIQeJuwAhUcGUbm2hTufGL4MlwlM9jml91Q1ElUeEAQVAb/AwkHvud7kJ98?=
 =?us-ascii?Q?dN6+Mo5LHQcxyI3Douv9498n17QhmyinxS4406o+VMWZB726G88D3MuIAHPc?=
 =?us-ascii?Q?+pWqJArBTecFbrmhTiwYCpMVR8vOYOmspL3OZOpK5CvOESVMj7TJtw8LRNuG?=
 =?us-ascii?Q?AMR69+p49sk979ffZ1RHFajDsPz4BshTziMH11O00sKrnLcclgMCMVz1Mlen?=
 =?us-ascii?Q?BpH3fUHBd6WaFbrw6kf/wlRB0xcIgdJqlA8RSeIaiFKI+U31xKUynM86Vjn6?=
 =?us-ascii?Q?t5SoLlVDT3ML3jCxx3E54ITr15LkOFFLXCvPxX3SIZYHnuajd+oZtvGSzpZS?=
 =?us-ascii?Q?n4UfX726pQVbbAoUOp0NtLelgJ/LMmiF5bbO6imaLR5w5/fseFToExS5wpwJ?=
 =?us-ascii?Q?B1X9wtzVRXppERhI00pjRWXJ8C1vWe9zI/2/DWXWbw8aPUocmSUaZFyo4cO7?=
 =?us-ascii?Q?7Hc+WCTuaHIbAZFxO6WXYdNRULOe2U7ck3pYCFTWPxCZFr2PXMiCCxaMpUno?=
 =?us-ascii?Q?YtRDKl3lUmM/fRpK48LgILmlpetuPOBYPDvTCc/w9plXNWkzo3q0L2QwMLZt?=
 =?us-ascii?Q?RP7n6jtqGYM6ZpNR8LAQaOJN5HafLeOWe4/9wXNFKgm+XKz0sHvNfAKP7EIa?=
 =?us-ascii?Q?CBseFWfA3up4yljQfGRLrFNq3z4KqPpyew7riV9/VyL/dAwWiPSXjydO4NBu?=
 =?us-ascii?Q?wma+n8l+jGv/bNSIUOKuPIoqy+ZqXUs1ODWmZ7thkv/x3je4UkzfYh9zPZNB?=
 =?us-ascii?Q?lX4W/ei3QTxxv/Zv/sNSWLXF9N2noZ1HDvdlaUytdvT67vKaXGuMuJ+vAcUv?=
 =?us-ascii?Q?X/r7a2/n81wc7CM90WVF5RUTarvnUXvuYxa5mzSjXTVzNas938ySJEOiHW+k?=
 =?us-ascii?Q?3gIuiexs8KCkd7wsWWwL9HeheKaFhFiaShn+0HOI+j386/LkIntGC/2olOD5?=
 =?us-ascii?Q?ZwCE1DZNRIgeLwHdnSV15mlgHcEcBtK9+BhRPnrki0XftPOQ0TFgdIYRrV5U?=
 =?us-ascii?Q?6ZJJ1rh8KEox8/T1snF+SkqwEzn0QuCTacupDt4IauXvdEE7p9EN4LOxg2Pd?=
 =?us-ascii?Q?mQNMjNf1L4KNyJnwveIzw302fKc9GM598q6pWx+AFcG1kp9HAmYk+QX3UgpL?=
 =?us-ascii?Q?zmDwjhKLTPFJqem8Q44I+20MC12u7sfblryhj7op2+UIOQXlGEc+SODH5mCT?=
 =?us-ascii?Q?BBCD4n4+WagMkNcdFiENaaRvG7IYoerz03FlF5G2yBNXCfU0q3lecLk8a8Ol?=
 =?us-ascii?Q?xLfxvDwzdNovFLSS41N3DP13oYriliWBob8vy36Yzlp9hyzhyJMgAGJvDDFP?=
 =?us-ascii?Q?PmgOnvgVy1CELRk5ySOuYY6zoTzMtJphzAR+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 18:07:59.7586 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7855d33-e65d-4f50-4397-08dd5822d603
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8872
Received-SPF: permerror client-ip=2a01:111:f403:2412::631;
 envelope-from=Babu.Moger@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

Add the support for AMD EPYC zen 5 processors (EPYC-Turin).

Add the following new feature bits on top of the feature bits from
the previous generation EPYC models.

movdiri             : Move Doubleword as Direct Store Instruction
movdir64b           : Move 64 Bytes as Direct Store Instruction
avx512-vp2intersect : AVX512 Vector Pair Intersection to a Pair
                      of Mask Register
avx-vnni            : AVX VNNI Instruction
sbpb                : Selective Branch Predictor Barrier
ibpb-brtype         : IBPB includes branch type prediction flushing
srso-user-kernel-no : Not vulnerable to SRSO at the user-kernel boundary

Link: https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/programmer-references/57238.zip
Link: https://www.amd.com/content/dam/amd/en/documents/corporate/cr/speculative-return-stack-overflow-whitepaper.pdf
Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 138 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 138 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b9109b7e79..081a7f0c0f 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2665,6 +2665,61 @@ static const CPUCaches epyc_genoa_v2_cache_info = {
         .share_level = CPU_TOPOLOGY_LEVEL_DIE,
     },
 };
+
+static const CPUCaches epyc_turin_cache_info = {
+    .l1d_cache = &(CPUCacheInfo) {
+        .type = DATA_CACHE,
+        .level = 1,
+        .size = 48 * KiB,
+        .line_size = 64,
+        .associativity = 12,
+        .partitions = 1,
+        .sets = 64,
+        .lines_per_tag = 1,
+        .self_init = true,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+    },
+    .l1i_cache = &(CPUCacheInfo) {
+        .type = INSTRUCTION_CACHE,
+        .level = 1,
+        .size = 32 * KiB,
+        .line_size = 64,
+        .associativity = 8,
+        .partitions = 1,
+        .sets = 64,
+        .lines_per_tag = 1,
+        .self_init = true,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+    },
+    .l2_cache = &(CPUCacheInfo) {
+        .type = UNIFIED_CACHE,
+        .level = 2,
+        .size = 1 * MiB,
+        .line_size = 64,
+        .associativity = 16,
+        .partitions = 1,
+        .sets = 1024,
+        .lines_per_tag = 1,
+        .self_init = true,
+        .inclusive = true,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+    },
+    .l3_cache = &(CPUCacheInfo) {
+        .type = UNIFIED_CACHE,
+        .level = 3,
+        .size = 32 * MiB,
+        .line_size = 64,
+        .associativity = 16,
+        .partitions = 1,
+        .sets = 32768,
+        .lines_per_tag = 1,
+        .self_init = true,
+        .no_invd_sharing = true,
+        .complex_indexing = false,
+        .share_level = CPU_TOPOLOGY_LEVEL_DIE,
+    },
+};
+
 /* The following VMX features are not supported by KVM and are left out in the
  * CPU definitions:
  *
@@ -5792,6 +5847,89 @@ static const X86CPUDefinition builtin_x86_defs[] = {
             { /* end of list */ }
         }
     },
+    {
+        .name = "EPYC-Turin",
+        .level = 0xd,
+        .vendor = CPUID_VENDOR_AMD,
+        .family = 26,
+        .model = 0,
+        .stepping = 0,
+        .features[FEAT_1_ECX] =
+            CPUID_EXT_RDRAND | CPUID_EXT_F16C | CPUID_EXT_AVX |
+            CPUID_EXT_XSAVE | CPUID_EXT_AES |  CPUID_EXT_POPCNT |
+            CPUID_EXT_MOVBE | CPUID_EXT_SSE42 | CPUID_EXT_SSE41 |
+            CPUID_EXT_PCID | CPUID_EXT_CX16 | CPUID_EXT_FMA |
+            CPUID_EXT_SSSE3 | CPUID_EXT_MONITOR | CPUID_EXT_PCLMULQDQ |
+            CPUID_EXT_SSE3,
+        .features[FEAT_1_EDX] =
+            CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX | CPUID_CLFLUSH |
+            CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPUID_MCA | CPUID_PGE |
+            CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_CX8 | CPUID_MCE |
+            CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE | CPUID_DE |
+            CPUID_VME | CPUID_FP87,
+        .features[FEAT_6_EAX] =
+            CPUID_6_EAX_ARAT,
+        .features[FEAT_7_0_EBX] =
+            CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 | CPUID_7_0_EBX_AVX2 |
+            CPUID_7_0_EBX_SMEP | CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS |
+            CPUID_7_0_EBX_INVPCID | CPUID_7_0_EBX_AVX512F |
+            CPUID_7_0_EBX_AVX512DQ | CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_ADX |
+            CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_AVX512IFMA |
+            CPUID_7_0_EBX_CLFLUSHOPT | CPUID_7_0_EBX_CLWB |
+            CPUID_7_0_EBX_AVX512CD | CPUID_7_0_EBX_SHA_NI |
+            CPUID_7_0_EBX_AVX512BW | CPUID_7_0_EBX_AVX512VL,
+        .features[FEAT_7_0_ECX] =
+            CPUID_7_0_ECX_AVX512_VBMI | CPUID_7_0_ECX_UMIP | CPUID_7_0_ECX_PKU |
+            CPUID_7_0_ECX_AVX512_VBMI2 | CPUID_7_0_ECX_GFNI |
+            CPUID_7_0_ECX_VAES | CPUID_7_0_ECX_VPCLMULQDQ |
+            CPUID_7_0_ECX_AVX512VNNI | CPUID_7_0_ECX_AVX512BITALG |
+            CPUID_7_0_ECX_AVX512_VPOPCNTDQ | CPUID_7_0_ECX_LA57 |
+            CPUID_7_0_ECX_RDPID | CPUID_7_0_ECX_MOVDIRI |
+            CPUID_7_0_ECX_MOVDIR64B,
+        .features[FEAT_7_0_EDX] =
+            CPUID_7_0_EDX_FSRM | CPUID_7_0_EDX_AVX512_VP2INTERSECT,
+        .features[FEAT_7_1_EAX] =
+            CPUID_7_1_EAX_AVX_VNNI | CPUID_7_1_EAX_AVX512_BF16,
+        .features[FEAT_8000_0001_ECX] =
+            CPUID_EXT3_OSVW | CPUID_EXT3_3DNOWPREFETCH |
+            CPUID_EXT3_MISALIGNSSE | CPUID_EXT3_SSE4A | CPUID_EXT3_ABM |
+            CPUID_EXT3_CR8LEG | CPUID_EXT3_SVM | CPUID_EXT3_LAHF_LM |
+            CPUID_EXT3_TOPOEXT | CPUID_EXT3_PERFCORE,
+        .features[FEAT_8000_0001_EDX] =
+            CPUID_EXT2_LM | CPUID_EXT2_RDTSCP | CPUID_EXT2_PDPE1GB |
+            CPUID_EXT2_FFXSR | CPUID_EXT2_MMXEXT | CPUID_EXT2_NX |
+            CPUID_EXT2_SYSCALL,
+        .features[FEAT_8000_0007_EBX] =
+            CPUID_8000_0007_EBX_OVERFLOW_RECOV | CPUID_8000_0007_EBX_SUCCOR,
+        .features[FEAT_8000_0008_EBX] =
+            CPUID_8000_0008_EBX_CLZERO | CPUID_8000_0008_EBX_XSAVEERPTR |
+            CPUID_8000_0008_EBX_WBNOINVD | CPUID_8000_0008_EBX_IBPB |
+            CPUID_8000_0008_EBX_IBRS | CPUID_8000_0008_EBX_STIBP |
+            CPUID_8000_0008_EBX_STIBP_ALWAYS_ON |
+            CPUID_8000_0008_EBX_AMD_SSBD | CPUID_8000_0008_EBX_AMD_PSFD,
+        .features[FEAT_8000_0021_EAX] =
+            CPUID_8000_0021_EAX_NO_NESTED_DATA_BP |
+            CPUID_8000_0021_EAX_FS_GS_BASE_NS |
+            CPUID_8000_0021_EAX_LFENCE_ALWAYS_SERIALIZING |
+            CPUID_8000_0021_EAX_NULL_SEL_CLR_BASE |
+            CPUID_8000_0021_EAX_AUTO_IBRS | CPUID_8000_0021_EAX_SBPB |
+            CPUID_8000_0021_EAX_IBPB_BRTYPE |
+            CPUID_8000_0021_EAX_SRSO_USER_KERNEL_NO,
+        .features[FEAT_8000_0022_EAX] =
+            CPUID_8000_0022_EAX_PERFMON_V2,
+        .features[FEAT_XSAVE] =
+            CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC |
+            CPUID_XSAVE_XGETBV1 | CPUID_XSAVE_XSAVES,
+        .features[FEAT_SVM] =
+            CPUID_SVM_NPT | CPUID_SVM_LBRV | CPUID_SVM_NRIPSAVE |
+            CPUID_SVM_TSCSCALE | CPUID_SVM_VMCBCLEAN | CPUID_SVM_FLUSHASID |
+            CPUID_SVM_PAUSEFILTER | CPUID_SVM_PFTHRESHOLD |
+            CPUID_SVM_V_VMSAVE_VMLOAD | CPUID_SVM_VGIF |
+            CPUID_SVM_VNMI | CPUID_SVM_SVME_ADDR_CHK,
+        .xlevel = 0x80000022,
+        .model_id = "AMD EPYC-Turin Processor",
+        .cache_info = &epyc_turin_cache_info,
+    },
 };
 
 /*
-- 
2.34.1


