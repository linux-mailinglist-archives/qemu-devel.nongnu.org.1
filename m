Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B16FAB0443
	for <lists+qemu-devel@lfdr.de>; Thu,  8 May 2025 22:00:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD7OT-0007fT-UB; Thu, 08 May 2025 15:58:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1uD7OR-0007eg-5B
 for qemu-devel@nongnu.org; Thu, 08 May 2025 15:58:55 -0400
Received: from mail-co1nam11on20603.outbound.protection.outlook.com
 ([2a01:111:f403:2416::603]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1uD7OP-0002C3-0a
 for qemu-devel@nongnu.org; Thu, 08 May 2025 15:58:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NBf8haGl/4zwPJBT9Plgw2nSegHM8VL+TmlgmLYInOAzZAC7dRYdSYUzjtDFHDNdZEkH6NBC5tuFaefwhBbX6GZ9X2mFrNQ5D/UxlDmNx6SE0STyCigXLIRJj5AxJy43joEgm953Y6WMJnkMBSBJ9ZvzMnxF3hQ/7l34kAUOf/qSPJ+OC/pXalHKyGbsa2Dgt2X4n6h3O9fB8vAiP22naJHhyIiyGHx6YKoxo+C8vSBkY+Y06FQBvdneZdPyH/wW3mK2RLsV3/ybjd0pih3w/NilKtyCm1B4no3tsGmC8vZ1UwWVVShQZLiT/m70uZb+OR8u/1prvIs4ALBM1xcpcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G40l36pFUsb97c/dhguMrMaW1ftdmEDmzTLdO1CyN7c=;
 b=QSArg9iBkGEft3sqjlNGtidxHOJzJVOd/amvyrctgALcTlra/rV24io2wWiaPxJdTm3EzLMT0rxR1GfI2VapDiSMA19war4w/qGBZ6k5kVtHiul3VuE/m30bovIjOyNVBPxIDwHNyhVfJEo4Dfep0WY2VYeEjKt/WTUj7Ml9E3LOwC5JH1h9I/aX9Wp0Y3brSbREppK5jZIb4aTrCj6rII0rdTzb442BIGCa5bWXvgoesP8rCYJVRtfvg8y7JqnPn5j/LHmEMQValwNHfwd4M94NekMB6kpg/XaTBj7Qxh21B3BoMspGnpXL7pow/DJdvGxFw81BPmudne4QacTolA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G40l36pFUsb97c/dhguMrMaW1ftdmEDmzTLdO1CyN7c=;
 b=UC+6Cn/GXr8icJROy5fuTo/GTUXSsNWaQgiJcdFXMaIPgdowp/D+Db2urMiGY49NirxZWkVhYLqPPuVAuNPV3cF3StamkjxjAUj2xWb8FLXQaSKr6pYvIR60G/H6x05vHF16upqSSglUe1DyfmlwcoAMIEmn+1aKkQcp7AcQtus=
Received: from DM6PR05CA0057.namprd05.prod.outlook.com (2603:10b6:5:335::26)
 by DS7PR12MB5743.namprd12.prod.outlook.com (2603:10b6:8:72::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Thu, 8 May
 2025 19:58:45 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:5:335:cafe::1) by DM6PR05CA0057.outlook.office365.com
 (2603:10b6:5:335::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.19 via Frontend Transport; Thu,
 8 May 2025 19:58:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Thu, 8 May 2025 19:58:45 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 May
 2025 14:58:45 -0500
From: Babu Moger <babu.moger@amd.com>
To: <pbonzini@redhat.com>
CC: <zhao1.liu@intel.com>, <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>,
 <davydov-max@yandex-team.ru>
Subject: [PATCH v7 5/6] target/i386: Update EPYC-Genoa for Cache property,
 perfmon-v2, RAS and SVM feature bits
Date: Thu, 8 May 2025 14:58:03 -0500
Message-ID: <afe3f05d4116124fd5795f28fc23d7b396140313.1746734284.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1746734284.git.babu.moger@amd.com>
References: <cover.1746734284.git.babu.moger@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|DS7PR12MB5743:EE_
X-MS-Office365-Filtering-Correlation-Id: c05fec1e-2821-4a10-fd84-08dd8e6abdce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VjM/JOLmJ91U0vps74Hn10eUsf5JnkUX0fLgrtq+3anny7OJ5qc55rMvFg2B?=
 =?us-ascii?Q?lUsISQuYxpLxTsOby3zn4PR7Df1py177rBC7np2VtcRGXjYkmixZq1J3sZJU?=
 =?us-ascii?Q?AWGx7xmufkB6S2n+JZk1LndwHvUz86Zi+9H4xSkkmhFbhSTMZY98oWbf2v/8?=
 =?us-ascii?Q?jbePoV53IdrEyF4oM6ytSprKMfbTGtfAa/o3JoiRPu5q2OGAxfZSaxWKdqqk?=
 =?us-ascii?Q?oFr0IfnxOQym7bcL1GqK72TIj7o46pt/wl7/CGsFCL2hOBu++fu/RO3ZRuQj?=
 =?us-ascii?Q?X1BZS05XNxZmqJqAenCk0PDFz+MWud5nypK5gOhrgSp/kf1yK6K75n/Pm3RM?=
 =?us-ascii?Q?TwaVdY6Ez9ORZs4/YCVjLVOLLM+3BfsupLJZlWfybpRqd+dMsqeJN99fINPe?=
 =?us-ascii?Q?HYtRE9xm2TLVohgMR8500cmHa64/1KOHDW5qeorfFbn148kvqabtV5pYH/ZQ?=
 =?us-ascii?Q?dwplRcvDp6daXEDK6KIBCKjJAMM691AmOEJmMarZUrHQk00Gfc6vnfDqUFVz?=
 =?us-ascii?Q?gJtA6QiaLI7GiVMIMEfg407aiQYzOBfnzcrG66BeTNh+PawAsz3kIo6YO738?=
 =?us-ascii?Q?RJDHKylRIMfhi+RW6uBlz5t3+Kqp6E+EtiWGXVL4Rh0Geyxl43ycyG6Ychxa?=
 =?us-ascii?Q?+JIhIgtk/owW+G5Id0rQI/EuYRXDWev3hPPxLwMr/g33aAw9Iw5Z+6VOmgyl?=
 =?us-ascii?Q?oCEyKgXQjH13hQ8THeG6T5ox9IgWXX8eWT3hiuw9NxvWpaN4h7+D1AzzgeJo?=
 =?us-ascii?Q?nDakRss+L+Mju4m65JQvtCJSNWiQzC++yFmiq1ixcBxVzWRXfxmSjYnmPgCX?=
 =?us-ascii?Q?XxlnN4vZDzLcfuM83t+a7irbh7OZiYhyO3Riz7JpHQD5FB2RFvYTNdNobFxb?=
 =?us-ascii?Q?xFA9oM57TIcCOyTO7otKUi0/QQyoRGIqsrbJX9qmEGNRa0MPrFF1vkaNLw+j?=
 =?us-ascii?Q?7SQ7pWLc+Zprq88LI3NHWEf5QaMYU6mdrpWyNK6bk06KSGUZqrg+YWXfD/Y0?=
 =?us-ascii?Q?rGXqmZOIzyc7Y8iqHVTO91DE6OzvIlUcOXZbZhrCzqjYgolrMbqjqBlMTyRh?=
 =?us-ascii?Q?2JbftCppU60SSpiulCKTssVUxqP2nvbA7RBfWxGTs2Ho3isTInoqYE6GpXHH?=
 =?us-ascii?Q?/hpA6y6Hv4MMzCVOvCky4B3G9l+Mv/v7VMyQLDjLZroIFQiSpOF5UbR+f3dD?=
 =?us-ascii?Q?oRzLIvfBxk49cmps0Ph20lq9YOH1M4lrjPDehsyGKT4+AjmlHcl9iD6+345q?=
 =?us-ascii?Q?SZAw/ovYn2p6Z29dLfUkor5tIx3dxAv+Au45yyPW9KvoNXXg/D/l3TZ9vNXD?=
 =?us-ascii?Q?KlN+WF4I/BkP6geRRbqOciv3J9UMj4p60iXZyWZC90uxxwRjRC0GHJJ3l2jD?=
 =?us-ascii?Q?4WgKse8jLA3V8tvw/OyHSmvqgRg3rkKpF0lzLHgcwjEh5xoAxk8KpnRlB+IB?=
 =?us-ascii?Q?q80JIFYsPCqW97aqFZJPOQyOM00vikwxI4Lkxtt4QmCPdf2fl//ajlhFn0o6?=
 =?us-ascii?Q?P1kHbe7GEELj1zelpwup/SfsUyOkhtMQ1sMyiUoSuQTwTRQs0KAT53UmJQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 19:58:45.7807 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c05fec1e-2821-4a10-fd84-08dd8e6abdce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5743
Received-SPF: permerror client-ip=2a01:111:f403:2416::603;
 envelope-from=Babu.Moger@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
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

Fix these cache properties.

Also add the missing RAS and SVM features bits on AMD EPYC-Genoa model.
The SVM feature bits are used in nested guests.

perfmon-v2     : Allow guests to make use of the PerfMonV2 features.
succor         : Software uncorrectable error containment and recovery capability.
overflow-recov : MCA overflow recovery support.
lbrv           : LBR virtualization
tsc-scale      : MSR based TSC rate control
vmcb-clean     : VMCB clean bits
flushbyasid    : Flush by ASID
pause-filter   : Pause intercept filter
pfthreshold    : PAUSE filter threshold
v-vmsave-vmload: Virtualized VMLOAD and VMSAVE
vgif           : Virtualized GIF
fs-gs-base-ns  : WRMSR to {FS,GS,KERNEL_GS}_BASE is non-serializing

The feature details are available in APM listed below [1].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
Publication # 24593 Revision 3.41.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Maksim Davydov <davydov-max@yandex-team.ru>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 78 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 741be0eaa8..8384ad6eff 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2617,6 +2617,59 @@ static const CPUCaches epyc_genoa_cache_info = {
     },
 };
 
+static const CPUCaches epyc_genoa_v2_cache_info = {
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
+        .associativity = 8,
+        .partitions = 1,
+        .sets = 2048,
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
 /* The following VMX features are not supported by KVM and are left out in the
  * CPU definitions:
  *
@@ -5718,6 +5771,31 @@ static const X86CPUDefinition builtin_x86_defs[] = {
         .xlevel = 0x80000022,
         .model_id = "AMD EPYC-Genoa Processor",
         .cache_info = &epyc_genoa_cache_info,
+        .versions = (X86CPUVersionDefinition[]) {
+            { .version = 1 },
+            {
+                .version = 2,
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
+                    { "fs-gs-base-ns", "on" },
+                    { "perfmon-v2", "on" },
+                    { "model-id",
+                      "AMD EPYC-Genoa-v2 Processor" },
+                    { /* end of list */ }
+                },
+                .cache_info = &epyc_genoa_v2_cache_info
+            },
+            { /* end of list */ }
+        }
     },
     {
         .name = "YongFeng",
-- 
2.34.1


