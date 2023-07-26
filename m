Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21907764104
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 23:19:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOlLE-0007Ff-AS; Wed, 26 Jul 2023 16:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <John.Allen@amd.com>)
 id 1qOlL0-0007Ek-Ab
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 16:42:28 -0400
Received: from mail-bn8nam11on20600.outbound.protection.outlook.com
 ([2a01:111:f400:7eae::600]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <John.Allen@amd.com>)
 id 1qOlKy-00045t-A0
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 16:42:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EPzwux4kLI6drhOvKLVD2ZF0LobiVAw3BJo2aojVa4DcVnpN32rjNEljZ7wfRxoSoBj4MkQ6y0L+d5v+TrwAPp66QuPEVHxrFPNpbKm7GBkHp6dkYxpRur2iox0bDPajob6UBPlSPAs0ONwJQGcaFawv6VzrknFzA6L+VKnxmfjzpUGcYi5rRFFzm1cYEd85zZfjAX4xN9X5n5EgFtJflIRrBZRi2KWN7eqKkUa72CmW6Uu8H0dHdI1ixgWtBz5QfKaeBjy5nFSB9spZqAq0l58/AlD2mLk0TBizNhsc0AgY5LRtQsVEKhHVJQN1UXTEuYVw197isoln9xgRQZAk+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S/1pW9s2jyqBSByp+0dEh7zqNH053jtVLphU3EZK1rI=;
 b=NqZszbIGdj2ghsHMZRRowc3BO52BoDs9H2HKwNaoaad49UMlSeW/QlqJO7NPghQwO2KoP92w3DYwDYKmCY7AeFmbwpuqminIgSgLs85vuQP/E3ZGalpbXDs+Rmfdd2xKUdynPFfv6MctjJzrLHrzlpyX+oyviCjfn6EUSbBpHtJrNDsnBav/yw6i1lHF5jl3wEWbhHnsKP+M90MbKX3noF1HycNc5FVJS9TauUigwyDMSaBnJ5+0JBAEI0dg5qOP2+IrWTx6lTgLEPfg8H+DiGo4EnDKSmY3LqCwItDFmo6Z3qkjfsnvJEJ+hIl/Vpkd5OvcMLO+8bbXT0b4cmWj3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/1pW9s2jyqBSByp+0dEh7zqNH053jtVLphU3EZK1rI=;
 b=cwxm9aglIcDJCkrTQNhwi9kig1gFTLlI9HBNTzn4JOiw71oiozMtV7uosrNRd5BwkSYG//cEuWZxtMEWG3pnntrHH417DjdUiNSjL7Xs3F2pIIorzb5PMuXRYLVT+GLxtMQQRVGO+Y/g/u7+utTlFKBPJ87Z+KM+Msj9YvLyM+8=
Received: from BN9PR03CA0579.namprd03.prod.outlook.com (2603:10b6:408:10d::14)
 by SA0PR12MB4383.namprd12.prod.outlook.com (2603:10b6:806:94::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 20:42:20 +0000
Received: from BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10d:cafe::5e) by BN9PR03CA0579.outlook.office365.com
 (2603:10b6:408:10d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Wed, 26 Jul 2023 20:42:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT089.mail.protection.outlook.com (10.13.176.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Wed, 26 Jul 2023 20:42:19 +0000
Received: from jallen-jump-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 26 Jul
 2023 15:42:18 -0500
From: John Allen <john.allen@amd.com>
To: <qemu-devel@nongnu.org>
CC: <yazen.ghannam@amd.com>, <michael.roth@amd.com>, <babu.moger@amd.com>,
 <william.roche@oracle.com>, <joao.m.martins@oracle.com>,
 <pbonzini@redhat.com>, <richard.henderson@linaro.org>, <eduardo@habkost.net>, 
 John Allen <john.allen@amd.com>
Subject: [PATCH v2 2/2] i386: Fix MCE support for AMD hosts
Date: Wed, 26 Jul 2023 20:41:57 +0000
Message-ID: <20230726204157.3604531-3-john.allen@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT089:EE_|SA0PR12MB4383:EE_
X-MS-Office365-Filtering-Correlation-Id: 02a1f368-c4d1-4d80-7cd7-08db8e18ce5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P43DqPoZ0RgG+q4J8kObXuFR5dj0GwE0kKdx6OQzERF3RRoYY6AsO3L6BjFJFaDoJyqT9Jrh2H5SN+GONLOcBwFgAewPNyNi+cYpbNuIbLjBTmr4pvrOFYfbttcXk6bOacp3t2qan38VpHEhwgKCJnY7UaZEQ/RzI1WmdPL6/E+Yc68wGoI1e02R4icp20sPrlwWC9nBNlP/6oHOGML+9gb/Uirr+qEfhFZlMBZ16ziVkicre5xkWzoX4RYyCEqPm+AMGhNZioMvAOxVH01ZVn6/iHbdEtKMZdbppWwz5pcgTRZfv5vDSijvmRlgxlbdYr5H4HdJNWYx6VKMQgcNFSMP6U4e2oVv0kFcHFGHOWbLeU3DR0UtNsAq9/NPjCP9fF0TqWLavHPOGFwLqviUm0NLu7nMbEXo5kPdthxdvaybKKorVxrL6UqF2cTm4sy7GLFJGzZ//AZH3naG3ZH2SFaANDWWw8tZGwNtX9cgWJuL1aaVq6fXEM4DTTXlCJPL2/rjyU/+d93/WtYFthacs0O3qVpirJGzoZPOcbSvxuMbT+Q5n1heMxuGnnsawu9vxcpsFc4mo/MXjucfnEhP1y+75MxZmj2R/JuRdgjocPoc1RF4ehs+/wZS4q2nCtb/1+Xu/9Qn8GL3wQPqGHwaxck4/XJ3hYTXKZruFCgOjVTUicv+33R8YOd4UVk4AyXvi4OvQKDcuOCO9qdQnXdHx9qKUfvA1IZvOJRxtyHEDQPiWp8Rk82z5tzmsrR/o9yd56Hl6uwisEutxOKJYOE7mA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(396003)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(54906003)(70206006)(70586007)(426003)(2616005)(36756003)(36860700001)(83380400001)(47076005)(40480700001)(86362001)(82740400003)(356005)(81166007)(478600001)(16526019)(26005)(336012)(186003)(7696005)(1076003)(6666004)(40460700003)(41300700001)(5660300002)(6916009)(316002)(2906002)(4326008)(8936002)(8676002)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 20:42:19.5115 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02a1f368-c4d1-4d80-7cd7-08db8e18ce5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4383
Received-SPF: softfail client-ip=2a01:111:f400:7eae::600;
 envelope-from=John.Allen@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
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
index 4b62138459..87a50c8aaf 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -532,16 +532,21 @@ static void kvm_mce_inject(X86CPU *cpu, hwaddr paddr, int code)
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


