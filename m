Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD78F7944E3
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 23:00:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdzc7-0001UP-1W; Wed, 06 Sep 2023 16:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <John.Allen@amd.com>)
 id 1qdzc3-0001UC-Fe
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 16:58:59 -0400
Received: from mail-sn1nam02on2059.outbound.protection.outlook.com
 ([40.107.96.59] helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <John.Allen@amd.com>)
 id 1qdzby-0006L8-Tm
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 16:58:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZbeAf4vpo/O79C2DVtbPHHho4x8E7QcAFXlkumAPmiiHLWFeZF7z92Ldok15Y3fT8NxDCe99/3fdqJc+nfyn1Du+8DlAAIEXO5oeyNGBbwOX1qQcXIfC8fyZUdEFVDtyzlcNiYut3ryEfq6Dfr97OXKriw7/E1k4WQqMaL8fjvydhLr9hDTwgKrWz37QeJ8gtHuOkjF/UIup9QJ7LHPriwC2tgpdrh0XvK6Q87+PQbZ5qxh1xitVeh+V0RvWfNpWwEsSOBlGPlZ7zzqoKt9S3VOBltZX88ToNivSVR9Yhw//UeotsEeWBTrlmOTzQ0A6lfIBwdnpAwMrr3SpJqIB4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DGl1gcmwPwCsiPvs008ffcmp90KOoKwu2XMHv13uOE8=;
 b=MP3sqr1655qvZ2rJfPx6LfZk/Of2JQMvh9QbdsB5qGkHbKtDn+aWUcy0G57M0j8DE86eoIH3CnsuLfezDeqNV6bsRxoNKi/0X9Zyo/V+JlEX/G9tKppHln76YwD30ZsmX7gzpZZYpUekwgyU/L3mdt11WkOcJkWOzm5RGxUkU0XmKGVz0uJE/GHr5g+d8zyd2CEOHbA922S/vwC91bug2A+477i2N7K15l4IU1o6cZNaUp0zDqtfoEy4mpgk9OXNhO8d1xkWu+fFOFML7gS6WWtwPYxOoj3CNssV3Q+ceFArdfwYeTJeQBFWj4Xjrw80Os87/Rf8J5mYg3wP2tNsaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DGl1gcmwPwCsiPvs008ffcmp90KOoKwu2XMHv13uOE8=;
 b=spw88F1Aspybrc+DqMBUdPfPievmXMRlX6pX2QYOdlaJ9sXluKvK30/sPmb1Bq9acgCeonHpPYzoemn2i95DzCoWUmkCYxUMhpdZJzU25YDrHfl5/p6V+ApH+ObaPyGTzgeGZK+0T/sBRabAdmuNtYmGsTqdkzG06YJinhUtmsQ=
Received: from DM5PR07CA0073.namprd07.prod.outlook.com (2603:10b6:4:ad::38) by
 CH3PR12MB8331.namprd12.prod.outlook.com (2603:10b6:610:12f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 20:53:49 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:4:ad:cafe::bc) by DM5PR07CA0073.outlook.office365.com
 (2603:10b6:4:ad::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34 via Frontend
 Transport; Wed, 6 Sep 2023 20:53:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.204) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Wed, 6 Sep 2023 20:53:48 +0000
Received: from jallen-jump-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 6 Sep
 2023 15:53:47 -0500
From: John Allen <john.allen@amd.com>
To: <qemu-devel@nongnu.org>
CC: <yazen.ghannam@amd.com>, <michael.roth@amd.com>, <babu.moger@amd.com>,
 <william.roche@oracle.com>, <joao.m.martins@oracle.com>,
 <pbonzini@redhat.com>, <richard.henderson@linaro.org>, <eduardo@habkost.net>, 
 John Allen <john.allen@amd.com>
Subject: [PATCH v3 1/3] i386: Fix MCE support for AMD hosts
Date: Wed, 6 Sep 2023 20:53:06 +0000
Message-ID: <20230906205308.50334-2-john.allen@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|CH3PR12MB8331:EE_
X-MS-Office365-Filtering-Correlation-Id: 51ed36d4-d5c6-44a9-d81e-08dbaf1b5e8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QrcIHaLgJ7W4aVrSuI48qaQE2LibGrneH3dZ/xf8Fy2WYYNAlisFZgd/lLrNqB0AAcSmNdeNKikmmSRkiZuczV9Wbn+guLCTyC2g7OzY2wpsJB3lM8jDoyi7EVxtSSvUksYWOG3X0QSYnsTuGdG4ziLhHtqjSzRb6br9Hjr+4APrxsxQxoUT6CJK2ZR1VyPVW4WIAPdtlQJGX8036s2sK9RVHkyS5zJMTO8t5ZaWr9XQtMCGv4kiaue5ghSjhiX79KR9RQ59SD/44cntdaMNjFUBP9O88JTQ87NBgYC1rDlJngVbYZkMGGixRjNoPQZz/mdVDZXFncEfrNoDUfVcY7XubEmkDVp9Yu4zk4cb5AAiNJ7f5BjkSl0syL8jgtx7m54oe7I8U0e8GwU76OryHd5RmMOLH/iE1QcZA8sAhGCa0vAnvv1jf/sLU/l1ny1kjPkbT7Qq3SJubue+mDhRr9hUId5pk/NJVGLuOeJrZGb7LmvKo3L3A8TtNBiOvoYfZVBCNd9Q056EmfXImkOigH8+E4l6hvgLwL78zemE/Qa6P9qEyFelcdBQgQQ6pDcFklmkXwSq0qXezTUQpsnyOdfcaYkukOPWON7Im6y+uPnQseeMabsgPvMUA8enA90pOtEzI6inixxZLIJPxjoBVs9iCwAh7swjbevEd7OhWEj1EGSiT7qQtbZb/y5vYEu6/3GB/9xmKWdLNjWzoGGHF9LCaeIChGojs/VcyFadUcrS+7Pmgp0YViBYqysAKXdf7I7T/HoeE2X1tFoswIa1Ww==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(136003)(376002)(39860400002)(82310400011)(451199024)(186009)(1800799009)(46966006)(36840700001)(40470700004)(2906002)(40460700003)(2616005)(86362001)(336012)(426003)(26005)(1076003)(16526019)(6666004)(478600001)(7696005)(36756003)(36860700001)(82740400003)(356005)(81166007)(83380400001)(47076005)(40480700001)(316002)(6916009)(44832011)(5660300002)(41300700001)(4326008)(8676002)(8936002)(54906003)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 20:53:48.7098 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51ed36d4-d5c6-44a9-d81e-08dbaf1b5e8a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8331
Received-SPF: softfail client-ip=40.107.96.59; envelope-from=John.Allen@amd.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

For the most part, AMD hosts can use the same MCE injection code as Intel but,
there are instances where the qemu implementation is Intel specific. First, MCE
deliviery works differently on AMD and does not support broadcast. Second,
kvm_mce_inject generates MCEs that include a number of Intel specific status
bits. Modify kvm_mce_inject to properly generate MCEs on AMD platforms.

Reported-by: William Roche <william.roche@oracle.com>
Signed-off-by: John Allen <john.allen@amd.com>
---
v3:
  - Update to latest qemu code that introduces using MCG_STATUS_RIPV in the
    case of a BUS_MCEERR_AR on a non-AMD machine.
---
 target/i386/helper.c  |  4 ++++
 target/i386/kvm/kvm.c | 17 +++++++++++------
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/target/i386/helper.c b/target/i386/helper.c
index 89aa696c6d..9547e2b09d 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -91,6 +91,10 @@ int cpu_x86_support_mca_broadcast(CPUX86State *env)
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
index 639a242ad8..5fce74aac5 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -590,16 +590,21 @@ static void kvm_mce_inject(X86CPU *cpu, hwaddr paddr, int code)
     CPUState *cs = CPU(cpu);
     CPUX86State *env = &cpu->env;
     uint64_t status = MCI_STATUS_VAL | MCI_STATUS_UC | MCI_STATUS_EN |
-                      MCI_STATUS_MISCV | MCI_STATUS_ADDRV | MCI_STATUS_S;
+                      MCI_STATUS_MISCV | MCI_STATUS_ADDRV;
     uint64_t mcg_status = MCG_STATUS_MCIP;
     int flags = 0;
 
-    if (code == BUS_MCEERR_AR) {
-        status |= MCI_STATUS_AR | 0x134;
-        mcg_status |= MCG_STATUS_RIPV | MCG_STATUS_EIPV;
+    if (!IS_AMD_CPU(env)) {
+        status |= MCI_STATUS_S;
+        if (code == BUS_MCEERR_AR) {
+            status |= MCI_STATUS_AR | 0x134;
+            mcg_status |= MCG_STATUS_RIPV | MCG_STATUS_EIPV;
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


