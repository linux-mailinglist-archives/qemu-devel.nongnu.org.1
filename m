Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E32A3A4A12A
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Feb 2025 19:08:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1to4lv-0005bT-Uz; Fri, 28 Feb 2025 13:07:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1to4ln-0005Yb-NU
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 13:07:32 -0500
Received: from mail-mw2nam12on20603.outbound.protection.outlook.com
 ([2a01:111:f403:200a::603]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1to4ll-0002OL-CY
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 13:07:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZkLi4u+7k7FLBhehrr7Y/7Lk3+VHCrZ3GIjLFrevVashLBvDhTcQyTWlMkjeBi0J+OGAV/XOQc5QJ6UJ1yZhaLtdsIY4wrynSCZQlKvuIUvw6sZvpxQP+1ZEhdBCDvZkw+VL9q5ueBAsmAthTwyVKA7RFdavk61yZzK9KosNUbJKrws4YBNekTmE2zzUgFjoi8/aGPMnK9VnUKTDkwx6hsUq06zwKopooANVp9JaZpA3BbW7RoghL4tAqu3sdjAPa3q6A277xAFnKOZXORJCBFIa9ueLriS2Yf93oCkcyCZj2zIk5XbO4TlLHX90i1fjCe/JemYtTbvHRBf9tDeQrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aWn12FJGh/GHZYdIwhvqHLwqDpV8jfI8J1LlIkT28s0=;
 b=CHwn94C+AA36KwuMI9dUROj3skPtLoDViyeKuIBcnIfHDpHp3Zf+wYHfrTWWcvjDECre+Vgs3/k5Clw3WyjZduZbsHP3RD1l+QCWbTNoeuKYmNpWs1rpdH1VGSMWoWKorkey9XOvaEPx9LY1Awhqi6sNJRs1Q0Ibd64D/3AOLtXivZV7+KJjCK0N1nH5ldBkj8tzLFw7UEGZkTGD3Vh382Jv7wPErBK6rG8hcs7uhGbIbn5fxypmHZc0Uf5x9PnPdl9QP7Uszk48iA24SOSU5gi3j13ZUv44NJoLmUwFMULrf66De8g6NRahlfFFedcLe4o5apzQpCxNcg04xnWhQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWn12FJGh/GHZYdIwhvqHLwqDpV8jfI8J1LlIkT28s0=;
 b=V9XzMuHjw+AYC1uZWx/ubLTqvNHBJQRRM3dLZ4aP5Y2pxw34JZAMhrrLAO3BnqhrzSZacuBmY9r4/i55bsPv0Vo3wWNgWtBkfwn0IAxX/P5UGls7CaSCnwLrSsP5BzU5Lz88+wSftUFKip8o9kmZVA69Wr7JyyaHUZ9POnh7aX0=
Received: from CYXPR03CA0034.namprd03.prod.outlook.com (2603:10b6:930:d2::9)
 by DM4PR12MB6471.namprd12.prod.outlook.com (2603:10b6:8:ba::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Fri, 28 Feb
 2025 18:07:21 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:930:d2:cafe::6c) by CYXPR03CA0034.outlook.office365.com
 (2603:10b6:930:d2::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.18 via Frontend Transport; Fri,
 28 Feb 2025 18:07:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 18:07:21 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 12:07:20 -0600
From: Babu Moger <babu.moger@amd.com>
To: <pbonzini@redhat.com>
CC: <zhao1.liu@intel.com>, <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>,
 <davydov-max@yandex-team.ru>
Subject: [PATCH v6 1/6] target/i386: Update EPYC CPU model for Cache property,
 RAS, SVM feature bits
Date: Fri, 28 Feb 2025 12:07:01 -0600
Message-ID: <8ecfd8751d58811b18fd918a6d13e859217156d4.1740766026.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|DM4PR12MB6471:EE_
X-MS-Office365-Filtering-Correlation-Id: cc1e641c-a97f-4c3f-9689-08dd5822bf2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rjbpuf/LTvXdQbaoP/hNPrW4ctJMcv//7aa/f8/rz9Y0bIvUZhP2CsdIvy/+?=
 =?us-ascii?Q?Fh7zjGg5sf0ggMkUtqILZftSPMXjiVF+5BiHmDpI70jCUH+kRL7rQmPKjAsx?=
 =?us-ascii?Q?0pYf59rN0gE4arJ3Cq4A3vV2BQVQNBRhUMMiQb+VTmO+/OpmHwckwkfQcTHO?=
 =?us-ascii?Q?9B8D5GZ1fRl2LauJxFBAcEevkVgxzRL5wjhFTnS1jAzpDyog07u6PwQ/8Y8c?=
 =?us-ascii?Q?6WoFyOS4KVJkkcr/CnpCo4jSRL+fD2AhiIkHsSEWJarBGW8GXX90Dhn8LwG/?=
 =?us-ascii?Q?uDPpQ/+UCoObMMy+9c5D5sNKZPpvG6vsYn4464HDvdlkn1gUe2upxSSmXFpU?=
 =?us-ascii?Q?LfrT+/+0JQi6aG3Y0SpCJsH6AxCQ0QpLsBQP6KPyecJ/9o38ZQ/wceVo7AJD?=
 =?us-ascii?Q?0nF2VGvfEJpy6czArMJSG42plWamYBPKXoFEnmnQvDYByuQSmKo1buPIYBhA?=
 =?us-ascii?Q?MKfUM7H5Mvk9/V/UNRlYJpCcIs+d/ZuAcEEN/4P7DCJt1xbeCOf6/qa+OO2A?=
 =?us-ascii?Q?cIeHKBjtap8Nhf6XfAxkL+eaikM/vAUWE4WboFpDOS33llroO1ZSRkWxb65T?=
 =?us-ascii?Q?sTgO6rOY2j5ySpCDM6Gp271uSYsy032jryehEtyYZNOgZN20ElgleyLGcb9R?=
 =?us-ascii?Q?zB5bcNwCaYNjHlt3JRdbChJAaXtNsWjnRUwweewtCmn4HF80ORzz9LqGsw9X?=
 =?us-ascii?Q?DD0PYiquF6a+HoczUt+5ICByvYF47L5Fjs2pzHnVGnLh4bcIrMiFubgXewyJ?=
 =?us-ascii?Q?Lh1zdFxrLXlZzvRJNNheyS5HzKCAYh/ZI5CFpcMzTGBEV8bQp/sm2bOBTS7h?=
 =?us-ascii?Q?Qqz38W+DfcnFPF1HhEQMMjOw+MIQuxZYExeETFBlfJBzmDfmjhY1ZATHKK8/?=
 =?us-ascii?Q?j0rg1rIHwICcEiqi+VxixD60KurzMLaoNWFLSwMF/72oRsSWmZ7br/qZKRhS?=
 =?us-ascii?Q?o9Q7p/xG21q0ys9Zj1DPE5NQMJZB9ZpbY/eujnk2SDtBi8FVUDYp0KEgOhuk?=
 =?us-ascii?Q?fHv6DfNcDlF6cThbvxK/7/XwYoxji9g7LKna6tK09f5T+0GjxdA4rrZq7oIc?=
 =?us-ascii?Q?UlvW/0oFXQ399kHUuHAPwTWSGkCU5nO2cjD8F5MiTTmO5oHZHELpmrX6Gs7A?=
 =?us-ascii?Q?U1xeK6+amOsF6vBZsL2WhIyFAPq8R3rMFXGeelznebKS0q9+NSEhDdbOawmz?=
 =?us-ascii?Q?niqZvl2TjTpUqU/bBnw2orJ2Yo0TsxiNKBvzo52E5NhYvA7U4PoW2yoesz09?=
 =?us-ascii?Q?z5a+DDvr3LCT5LpJp2xMyYu9HQBL99Rd8bd7vlzpKH+Qe/cZJYq7fW2U7FFs?=
 =?us-ascii?Q?6R3tDgJLRm0caB0BJa0LyjZcf63a7Qw/4h2TjL/vLt+AhZonRbcdBoD2TDyW?=
 =?us-ascii?Q?s8Glhbbj5ChufHX11rxKW934S4g5YLoi0eAs6HqCQMGJQx1UcL3FWeHxyFG2?=
 =?us-ascii?Q?+T0raE5HBu3Bpsxej8UGPcVBw3/Epyhrt5iSQBCq3LDilDIzxf53ivi7zAj3?=
 =?us-ascii?Q?oMVGlXgoMyDmQV8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 18:07:21.4418 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc1e641c-a97f-4c3f-9689-08dd5822bf2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6471
Received-SPF: permerror client-ip=2a01:111:f403:200a::603;
 envelope-from=Babu.Moger@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
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

Found that some of the cache properties are not set correctly for EPYC models.

l1d_cache.no_invd_sharing should not be true.
l1i_cache.no_invd_sharing should not be true.

L2.self_init should be true.
L2.inclusive should be true.

L3.inclusive should not be true.
L3.no_invd_sharing should be true.

Fix the cache properties.

Also add the missing RAS and SVM features bits on AMD
EPYC CPU models. The SVM feature bits are used in nested guests.

succor		: Software uncorrectable error containment and recovery capability.
overflow-recov	: MCA overflow recovery support.
lbrv		: LBR virtualization
tsc-scale	: MSR based TSC rate control
vmcb-clean	: VMCB clean bits
flushbyasid	: Flush by ASID
pause-filter	: Pause intercept filter
pfthreshold	: PAUSE filter threshold
v-vmsave-vmload	: Virtualized VMLOAD and VMSAVE
vgif		: Virtualized GIF

Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Maksim Davydov <davydov-max@yandex-team.ru>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 72ab147e85..7908b90b77 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2180,6 +2180,60 @@ static CPUCaches epyc_v4_cache_info = {
     },
 };
 
+static CPUCaches epyc_v5_cache_info = {
+    .l1d_cache = &(CPUCacheInfo) {
+        .type = DATA_CACHE,
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
+    .l1i_cache = &(CPUCacheInfo) {
+        .type = INSTRUCTION_CACHE,
+        .level = 1,
+        .size = 64 * KiB,
+        .line_size = 64,
+        .associativity = 4,
+        .partitions = 1,
+        .sets = 256,
+        .lines_per_tag = 1,
+        .self_init = true,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+    },
+    .l2_cache = &(CPUCacheInfo) {
+        .type = UNIFIED_CACHE,
+        .level = 2,
+        .size = 512 * KiB,
+        .line_size = 64,
+        .associativity = 8,
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
+        .size = 8 * MiB,
+        .line_size = 64,
+        .associativity = 16,
+        .partitions = 1,
+        .sets = 8192,
+        .lines_per_tag = 1,
+        .self_init = true,
+        .no_invd_sharing = true,
+        .complex_indexing = false,
+        .share_level = CPU_TOPOLOGY_LEVEL_DIE,
+    },
+};
+
 static const CPUCaches epyc_rome_cache_info = {
     .l1d_cache = &(CPUCacheInfo) {
         .type = DATA_CACHE,
@@ -5207,6 +5261,25 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                 },
                 .cache_info = &epyc_v4_cache_info
             },
+            {
+                .version = 5,
+                .props = (PropValue[]) {
+                    { "overflow-recov", "on" },
+                    { "succor", "on" },
+                    { "lbrv", "on" },
+                    { "tsc-scale", "on" },
+                    { "vmcb-clean", "on" },
+                    { "flushbyasid", "on" },
+                    { "pause-filter", "on" },
+                    { "pfthreshold", "on" },
+                    { "v-vmsave-vmload", "on" },
+                    { "vgif", "on" },
+                    { "model-id",
+                      "AMD EPYC-v5 Processor" },
+                    { /* end of list */ }
+                },
+                .cache_info = &epyc_v5_cache_info
+            },
             { /* end of list */ }
         }
     },
-- 
2.34.1


