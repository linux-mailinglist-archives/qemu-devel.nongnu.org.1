Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1EF74A488
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 21:47:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHUvF-0000uf-LL; Thu, 06 Jul 2023 15:45:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <John.Allen@amd.com>)
 id 1qHUqR-0000TE-Gb
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 15:40:51 -0400
Received: from mail-bn8nam12on2061d.outbound.protection.outlook.com
 ([2a01:111:f400:fe5b::61d]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <John.Allen@amd.com>)
 id 1qHUqP-00038i-6G
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 15:40:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TguTnZ4SrkQNg/onJjr3kXqcyNEW/Jype5zfds8DltKdv8oOy7FHa/zk1m6iF+qSzSpqVhcctbUyYz1dy1FT0tuluqtuAwcSIKDc5QLd+g8WnfPla5XI29iPtULINTQ7I6blZcU4gHrCHK6BBwUQxi/B+kPp4yb7IFG6mbiGG5GGoAA9qKdWmh/SBZ0t+zZ7c6e7mhrnU8DsCmS24Z4vyYMxUvC06BxC7keqItpx7yPlTfGdIAGMAxKQNbzWp1l4Xuykq5PZQY2LNjk+LXYRbVhMbweIoYCQ5fa1H7angXgDbIym/e//LpJqoo9nn8an8uA2X8rlgPRjFPke63J90g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CKtkNX9FvOay3wpyHU7NilntUV97Ryd5nB+hMkxgDN4=;
 b=mPEvSUqXQrS/Ib9HyXqW1RZJHJvuLun34HveTDgKMiFxEHTxf6MjgCDTovJULWoWgnhOIMx55zpMwam1qYaRH9Md5YXwtYyv0doQhQDtl3HcN2/e88oVqGq1k2AZ6oTMDuEOfHvvXnjzwmaIVNbpvzHHXvoE+jKEwVqns+qMOC1eIxmxr/qKjh+hvvwwapQup1HYCWEVXo+kcsGg/MOI/YwH+2wWjnf3mHtDlahzF8aws5y680rZghGWmxMNuhKdTt7O47zd9FiYHcaxDunYmPNvqqATEISWsS9qEuBrh7aUkoZuec5B+4v6bHsM1YkLLUUDpKD5jOp0MS1vDn7MRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKtkNX9FvOay3wpyHU7NilntUV97Ryd5nB+hMkxgDN4=;
 b=TDGPRIyviesH6ABHuY6AFL9kDzWb0lIRxlm+3tbCu3P20INrLQalCPK7EW9JxhKzANiuheeR6Gefsc1NgQBc8FM89KRoAZbjTN7uN4UTEOEfYXiFB4TioLlvsJtss2PJmivtWlntdcd+k1GOD53mmxkCtF/bjWvX9MHeitdGIcU=
Received: from BN8PR03CA0008.namprd03.prod.outlook.com (2603:10b6:408:94::21)
 by IA1PR12MB7735.namprd12.prod.outlook.com (2603:10b6:208:421::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 19:40:45 +0000
Received: from BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:94:cafe::70) by BN8PR03CA0008.outlook.office365.com
 (2603:10b6:408:94::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24 via Frontend
 Transport; Thu, 6 Jul 2023 19:40:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT073.mail.protection.outlook.com (10.13.177.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Thu, 6 Jul 2023 19:40:45 +0000
Received: from jallen-jump-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 6 Jul
 2023 14:40:44 -0500
From: John Allen <john.allen@amd.com>
To: <qemu-devel@nongnu.org>
CC: <yazen.ghannam@amd.com>, <michael.roth@amd.com>, <babu.moger@amd.com>,
 <william.roche@oracle.com>, <joao.m.martins@oracle.com>, John Allen
 <john.allen@amd.com>
Subject: [PATCH 2/2] i386: Fix MCE support for AMD hosts
Date: Thu, 6 Jul 2023 19:40:22 +0000
Message-ID: <20230706194022.2485195-3-john.allen@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT073:EE_|IA1PR12MB7735:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e65fe20-1070-4a40-23d4-08db7e58e449
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PMVuDsYo85juntsXjr0o7tivoYYHylwN/r/ISfkE34Yk7tS/1w30FGUi4H3s2jCLE5DjgBJzu+QVmydA6I0ZVkgYyeH6Ty6wuy7A3r0jRbtY2zRWnkMv3NcCbOM9p5naSzCIE3TWc4sfJo37C9Bv8GKONj7vHKki6eovUEsyZxf1CtSeB/peLmJ9jb4xalmNnKS9rjdN0XedaZ4+u7XP1G+541RCnasg11egflBZ2M2gJ8FnEhDgP+QSCpbCovJBq4KzfQ19GOfZ1kHJHCT4KmQ3Wxr+HXdvXsUMwOga9hvE2bZG59CnSP4iEc7+FODP46uECI3XrTfwA68H9GU4hbD5BG8yBU10KWYvPUGimmYZyb0VY2wAZSsJifBLiqHFubE18RmsqzXXi1TS/nQMcZaByJ6+rnSB/QaCdTb0tzZk1bLO2LSfLu0YeFYOQ2G8aLEjCHWzS+5Ad6FvU8YIe2Wunm6lraydrgy0Dp9y9AfN/fIEYYo5IvQP9PDllrSr8iN5wcxOLpDkel1Gm3/8jWsFr128zs4/AAAGSveBSaygrqLMbG7/FbjoAeaZljXXQ+tAHYJPTbFTkEW48UCuj+0kEvVMQJN5HZ9ZlBpGYlnQej1vNPnKJwEH9V/GPjm6NslpNEpwdCR3X3gAtaH5R966AQO96Sb55WsrW22RXEuoApbrljNXxacMRqWWI3FU1EJqrbd+Cp8BcaN/iaJZNt9DLWNVfpVivpESxA+eSiRvtwpfFsSO1wtR05CpUEPscLapeHoIWKTSxcmJPoNtPw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199021)(40470700004)(36840700001)(46966006)(7696005)(6666004)(478600001)(70586007)(54906003)(86362001)(36860700001)(336012)(83380400001)(2616005)(47076005)(36756003)(426003)(40480700001)(186003)(2906002)(82310400005)(70206006)(26005)(1076003)(16526019)(40460700003)(82740400003)(81166007)(6916009)(316002)(356005)(8676002)(4326008)(5660300002)(44832011)(8936002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 19:40:45.4808 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e65fe20-1070-4a40-23d4-08db7e58e449
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7735
Received-SPF: softfail client-ip=2a01:111:f400:fe5b::61d;
 envelope-from=John.Allen@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
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

For the most part, AMD hosts can use the same MCE injection code as Intel but,
there are instances where the qemu implementation is Intel specific. First, MCE
deliviery works differently on AMD and does not support broadcast. Second,
kvm_mce_inject generates MCEs that include a number of Intel specific status
bits. Modify kvm_mce_inject to properly generate MCEs on AMD platforms.

Reported-by: William Roche <william.roche@oracle.com>
Signed-off-by: John Allen <john.allen@amd.com>
---
 target/i386/helper.c  |  4 ++++
 target/i386/kvm/kvm.c | 17 +++++++++++------
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/target/i386/helper.c b/target/i386/helper.c
index 533b29cb91..a6523858e0 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -76,6 +76,10 @@ int cpu_x86_support_mca_broadcast(CPUX86State *env)
     int family = 0;
     int model = 0;
 
+    if (IS_AMD_CPU(env)) {
+        return 0;
+    }
+
     cpu_x86_version(env, &family, &model);
     if ((family == 6 && model >= 14) || family > 6) {
         return 1;
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index f25837f63f..63bd7a7d3a 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -530,16 +530,21 @@ static void kvm_mce_inject(X86CPU *cpu, hwaddr paddr, int code)
     CPUState *cs = CPU(cpu);
     CPUX86State *env = &cpu->env;
     uint64_t status = MCI_STATUS_VAL | MCI_STATUS_UC | MCI_STATUS_EN |
-                      MCI_STATUS_MISCV | MCI_STATUS_ADDRV | MCI_STATUS_S;
+                      MCI_STATUS_MISCV | MCI_STATUS_ADDRV;
     uint64_t mcg_status = MCG_STATUS_MCIP;
     int flags = 0;
 
-    if (code == BUS_MCEERR_AR) {
-        status |= MCI_STATUS_AR | 0x134;
-        mcg_status |= MCG_STATUS_EIPV;
+    if (!IS_AMD_CPU(env)) {
+        status |= MCI_STATUS_S;
+        if (code == BUS_MCEERR_AR) {
+            status |= MCI_STATUS_AR | 0x134;
+            mcg_status |= MCG_STATUS_EIPV;
+        } else {
+            status |= 0xc0;
+            mcg_status |= MCG_STATUS_RIPV;
+        }
     } else {
-        status |= 0xc0;
-        mcg_status |= MCG_STATUS_RIPV;
+        mcg_status |= MCG_STATUS_EIPV | MCG_STATUS_RIPV;
     }
 
     flags = cpu_x86_support_mca_broadcast(env) ? MCE_INJECT_BROADCAST : 0;
-- 
2.39.3


