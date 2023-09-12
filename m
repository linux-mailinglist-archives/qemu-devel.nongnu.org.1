Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB47079DA9E
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 23:20:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgAmx-0001mD-VP; Tue, 12 Sep 2023 17:19:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <John.Allen@amd.com>)
 id 1qgAmv-0001le-J7
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 17:19:13 -0400
Received: from mail-dm3nam02on20604.outbound.protection.outlook.com
 ([2a01:111:f400:7e83::604]
 helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <John.Allen@amd.com>)
 id 1qgAmh-0004jh-AH
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 17:19:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VRCyDy8F1id8JAur3POZlZQwchRrk6qPD+oc+hJQpwK+EF+Tnx9Yp/DACatgDe6BR1stb/fC6E6H6OKApNAlP0HUoZ00Magz3HhWL95TmbKLAQoE0AxZFhx7ql+HRACxzBLHUSCx3fBeSMzSlgvq0aRrHc4YkgiygiZijoIbjmnOPQt8fW0PdRQBTI0ipjnheYpROQ8mvYRqHPpMymzCidzygHgjFoQSJOxRMlFL4MqCDEN5SzjORESo3AAmJ6eT/VG8f565uAbJwb5yF2zLOdUdbLLvMHTVIKWbOcUH40i6hQIeNYU41KKtWpud3FjG58ZrDI1Gl4S1021afn6ljg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nn2GprZtKfG/n04um13lURkVHmKzUl5lpjZHhuhpOqM=;
 b=WzC85bFhVMVNoKaLmAPbXKZdsTieGGdRHiYdTuElD+/0DxyHGcaotcVeT9yThHz7PZ2qz2FmuoYil0NXTbm/lcAXetgI4C4k/8BzBEn1ReL6eVX+VY+1xzDoxonErEat0LnbvlHsZl1fVoqKfPOTH5oWT7i7mKsfwBO8Wp94gdVrrys0m7xU3EcSHmzOpWQtE++KTaq+oChe2C/ey8SSyGKwOwint/ZxZqupMzrfVdL6LjjVr5ldmdEcVv1AlytRhhPWvm5WNOMb1mOr5Y25Ea6wYZV84loPdGu+Rq6CVbIgK/JCeJzZX5XQPEAhV9I//bubAG2Bxw07n7tzugx0uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nn2GprZtKfG/n04um13lURkVHmKzUl5lpjZHhuhpOqM=;
 b=F5TA3k8atbJFOIL4aOpg2NywGmxsjz2EPVrBrdWu704Hwn3LYcLSRduRJpUBrCvd68yCryH6Hx9sitSIELzAT5uk1BXxf6uSRfKZQSSNt3qDYa0qR2vrpyRWcev07hkDifHc0M0jvwDoCmYbsqVLdW9h10IGFetE+Oot6yGLEZs=
Received: from MN2PR05CA0003.namprd05.prod.outlook.com (2603:10b6:208:c0::16)
 by CH0PR12MB5091.namprd12.prod.outlook.com (2603:10b6:610:be::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Tue, 12 Sep
 2023 21:18:53 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:c0:cafe::32) by MN2PR05CA0003.outlook.office365.com
 (2603:10b6:208:c0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.10 via Frontend
 Transport; Tue, 12 Sep 2023 21:18:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.16 via Frontend Transport; Tue, 12 Sep 2023 21:18:53 +0000
Received: from jallen-jump-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 12 Sep
 2023 16:18:52 -0500
From: John Allen <john.allen@amd.com>
To: <qemu-devel@nongnu.org>
CC: <yazen.ghannam@amd.com>, <michael.roth@amd.com>, <babu.moger@amd.com>,
 <william.roche@oracle.com>, <joao.m.martins@oracle.com>,
 <pbonzini@redhat.com>, <richard.henderson@linaro.org>, <eduardo@habkost.net>, 
 John Allen <john.allen@amd.com>
Subject: [PATCH v4 1/3] i386: Fix MCE support for AMD hosts
Date: Tue, 12 Sep 2023 21:18:22 +0000
Message-ID: <20230912211824.90952-2-john.allen@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|CH0PR12MB5091:EE_
X-MS-Office365-Filtering-Correlation-Id: 0660bd5f-268e-46e8-4533-08dbb3d5ddc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q/hvA08CGUdogxHI6S2AGAcL8pJT00owLn0gkXD/YqlGhUoFeVNEQ7NUgzODIRT1yxL4xVbx9bUG3xMC7W0BjLEcMaq4Pp4j+trgVLURUsKh2EKVSalVpiKc4dcgxzK592rlEc9+0T0lgImEDkfk0gIPdIovAK1vsCCJrBbYkJvjRwv+80yTeanfLpCUpjUO9J9hjHBqJgL2JpmeFQ2R0mhNr1rwpZSDtvc3J5J8iuJRLpR5IB2VWJEEcN41f16kIfk0VPEYqdYFVQG8vCFbanoJkBUnUWC6ojlSy8VJNEfiFbPKHgriEHSCZjSZve4Jx2De9iZ8c9cFIG2Vh17PZw0nYkrxHOi/SQUqxWmn4rlR9yHuX387UxrJEdHw0YbJ9UHnrZCSxnJe9IMZfSxmufncg7TAC5xs5zKqf0GMYFCrZ5TuAfxvlTBcSMoEBlcegqIaB9mwM8AzAB5fwx5ORkdV4ytiY5abThVBsikDMWsPQI/R9UIL6YVSSr3EAf9xN69FK8Kh3+tV+uV7M1grtyE1K5PDQ8DS/amZ2FyDPp2flyZ3ajeVRKxpZco3KFbQ5ab+/7lKPO3OUPS+VUqzavSnrFgkpKYk1jhZhzcob8UU9bbqaOXVG5gMK6Z5d/8lPTyPhcB/vfqwqeUL7EBAFkflM0e3fCqDmC/yzffkreVHKdTT6IgtR3UwWXf607V6Zjs/jcot4M+gyGMgeUsZzX1QKzx2HoDOUzWoPOiPe4+0jWYonhgVrk2ZSbQ85cXh0jOwnbWRQ4S3pddlVvX0FA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(376002)(396003)(346002)(186009)(1800799009)(82310400011)(451199024)(40470700004)(46966006)(36840700001)(83380400001)(7696005)(40460700003)(6666004)(82740400003)(356005)(81166007)(86362001)(36860700001)(47076005)(36756003)(2616005)(40480700001)(426003)(336012)(1076003)(26005)(16526019)(44832011)(6916009)(70586007)(2906002)(70206006)(316002)(54906003)(8676002)(8936002)(4326008)(41300700001)(5660300002)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 21:18:53.2843 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0660bd5f-268e-46e8-4533-08dbb3d5ddc5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5091
Received-SPF: softfail client-ip=2a01:111:f400:7e83::604;
 envelope-from=John.Allen@amd.com;
 helo=NAM02-DM3-obe.outbound.protection.outlook.com
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

For the most part, AMD hosts can use the same MCE injection code as Intel, but
there are instances where the qemu implementation is Intel specific. First, MCE
delivery works differently on AMD and does not support broadcast. Second,
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


