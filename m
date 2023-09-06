Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4AE7944CC
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 22:54:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdzXK-0007jM-Vp; Wed, 06 Sep 2023 16:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <John.Allen@amd.com>)
 id 1qdzXH-0007ix-IL
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 16:54:03 -0400
Received: from mail-mw2nam10on20610.outbound.protection.outlook.com
 ([2a01:111:f400:7e89::610]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <John.Allen@amd.com>)
 id 1qdzXE-0004jX-Iz
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 16:54:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K/BdeHvhByTBrz+6ooLDNAIBIxoMjWpx4M9HIvYnglmiSap3hn0kzyUMXVLp/APRIVqf4OGA1zDpGCwSeoFPyPiJxsONqLa8ysX26xMtPOnTAq+OtKAouyi1xaT/w8CfZ73F3b+5Edqk+UE9ahBDLjI3GAV4Jmy3yjzm7K8XiiHz8Rpv+f+Y5+Gc5dKRZKLgzVX1BXbQDGowJuYygfNKgIkxYINNM/I7m3kLYfwwwar8RZitId06FJkQdWz0t9BkxDq8hRQ02bo84p70OdI8/kHmSHSP8Vk89KLaOSes2pK9klX06OB5Ska1saotUYCtiWo8/nVZ8Cu/EtMVw+lAQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/C7fobXGhVgySTbQ1/Rnt3NjdU6sbnvHrLR37KNjdDU=;
 b=HgRJ6wl1JekW24DpSigLYG5IvHx02aI4Jg1pHXlpBjCpK0hn0Ta7Q65pyJ0+cto5V7VreVDRKvDn9x/CUB0+PIqMs4O0PRXpk0HdBXvGktYa6+71rxsSqgazylh62QfzAZkW1P8SkteBzx3f6lhXCpILaX6+HcnAeqGpcTtVcHDJbMvHSpNn9+NkE/ZM36ZvlWhR9E57XfGfhOfia3k+nTHUFD/Y4vFLL65Ti1wNnyMCwxPUxNLyQsOF3Hh+FMmhC/yQoQglSEyw0CJ2RnZE+7pEHfMgb48r3eYLGp9fSHmZIPadGYocAUCdUyE0WhgsiCbETdGED6XUcgx+R4tnsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/C7fobXGhVgySTbQ1/Rnt3NjdU6sbnvHrLR37KNjdDU=;
 b=5W8k3AbjChAb8E+184iDxzirK0dI8oDQuvV/S1TXUSMz3ILdN2N4D8i6En4qjwd0EBITjRAqPXlTcZjPIUBeHFJaMMOUSLkbqTnyA6Xg/SzzpyjfnC5NePF9pX7L9Zaqyo5cxa5mgebu00V8MLwh/Gs4e5kBZPIHAkPu8zu949U=
Received: from CY5PR19CA0089.namprd19.prod.outlook.com (2603:10b6:930:83::14)
 by PH8PR12MB7136.namprd12.prod.outlook.com (2603:10b6:510:22b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Wed, 6 Sep
 2023 20:53:52 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:930:83:cafe::43) by CY5PR19CA0089.outlook.office365.com
 (2603:10b6:930:83::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.35 via Frontend
 Transport; Wed, 6 Sep 2023 20:53:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.207) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Wed, 6 Sep 2023 20:53:52 +0000
Received: from jallen-jump-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 6 Sep
 2023 15:53:51 -0500
From: John Allen <john.allen@amd.com>
To: <qemu-devel@nongnu.org>
CC: <yazen.ghannam@amd.com>, <michael.roth@amd.com>, <babu.moger@amd.com>,
 <william.roche@oracle.com>, <joao.m.martins@oracle.com>,
 <pbonzini@redhat.com>, <richard.henderson@linaro.org>, <eduardo@habkost.net>
Subject: [PATCH v3 2/3] i386: Explicitly ignore unsupported BUS_MCEERR_AO MCE
 on AMD guest
Date: Wed, 6 Sep 2023 20:53:07 +0000
Message-ID: <20230906205308.50334-3-john.allen@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|PH8PR12MB7136:EE_
X-MS-Office365-Filtering-Correlation-Id: 60fb7738-1732-47ec-a636-08dbaf1b60ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MNe/0wLZr+gav1PXt+Y2AHm4BbrZ9I1aukhU7QdEqf4U2G1wz/2rdCuxqnRcR7SHf05AIOUh22p8f9FDE3+HMX9/xiY37jkYk1UxvcTZyfRvdmxl02jHkLLZ0MDoN5+K0nC3dhWqN5/MfqRnx1rqcBlGtljfgQIJ7gkoBixJ6d0Xjvykqye4s2rl73p3jGHTTGUKfnfeNdjMf+BUX7227ieNb/6j6Jzif6oPkmwgyEyU5ZAFsmcjQwE4BaMP5wyd+lWaRUjacSXJWgiiWaeL1cb4+eoF3XkE073DuGT6KDN6bTuMXih2ZHIJjfoUI32h9+REzFlc7WSyTNxGXRUzq7liOnGYQwX/lhoo0v2r7UQL1xsnWc4EgXY7nBXVs+TcdtofnpLOPiOODNR040udX78OTuX9YnUdN5pvTwH5kzrcOylGXT0ny+g7iHLzo+OWjDpGxqg4/XntFtCr0AXIRmAPOEFvniWXgni3jkrNU1fBnmlv4/iFo+Vy+riiAGBas28ZtdnxF1wCYIXvvVi0DSRKws+mjpl6Hj95yWEFW9xjKMqK4wREGrwRNuOq1PLOdSEBzpjS/NzIwYQrgR06H+EvxBil4ktbrKE3X+t7q78zj3BP+WPie2LRL6iPYYiJddxiz9NNfGqjYTwX/iSBHybcOmPZxgYi7qL6V34NntNWoVhf/cnC/ahtZOANeicsqca822rU57ftbPYvyvbS7q8fcB0sF9oCBufk1UoK2U6D5uMAnslfG0qWl/8Fl64xL8nxFs22AMSBVAT+bHZk5D3HMMpa5GYmvdzSynsmFvU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199024)(82310400011)(186009)(1800799009)(40470700004)(36840700001)(46966006)(66899024)(426003)(1076003)(70206006)(81166007)(36756003)(44832011)(86362001)(2906002)(82740400003)(5660300002)(40460700003)(336012)(356005)(40480700001)(36860700001)(4326008)(83380400001)(41300700001)(8936002)(47076005)(54906003)(16526019)(316002)(26005)(7696005)(8676002)(2616005)(6916009)(70586007)(6666004)(478600001)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 20:53:52.2218 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60fb7738-1732-47ec-a636-08dbaf1b60ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7136
Received-SPF: softfail client-ip=2a01:111:f400:7e89::610;
 envelope-from=John.Allen@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
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

From: William Roche <william.roche@oracle.com>

AMD guests can't currently deal with BUS_MCEERR_AO MCE injection
as it panics the VM kernel. We filter this event and provide a
warning message.

Signed-off-by: William Roche <william.roche@oracle.com>
---
v3:
  - New patch
---
 target/i386/kvm/kvm.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 5fce74aac5..4d42d3ed4c 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -604,6 +604,10 @@ static void kvm_mce_inject(X86CPU *cpu, hwaddr paddr, int code)
             mcg_status |= MCG_STATUS_RIPV;
         }
     } else {
+        if (code == BUS_MCEERR_AO) {
+            /* XXX we don't support BUS_MCEERR_AO injection on AMD yet */
+            return;
+        }
         mcg_status |= MCG_STATUS_EIPV | MCG_STATUS_RIPV;
     }
 
@@ -655,7 +659,9 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
         if (ram_addr != RAM_ADDR_INVALID &&
             kvm_physical_memory_addr_from_host(c->kvm_state, addr, &paddr)) {
             kvm_hwpoison_page_add(ram_addr);
-            kvm_mce_inject(cpu, paddr, code);
+            if (!IS_AMD_CPU(env) || code != BUS_MCEERR_AO) {
+                kvm_mce_inject(cpu, paddr, code);
+            }
 
             /*
              * Use different logging severity based on error type.
@@ -668,8 +674,9 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
                     addr, paddr, "BUS_MCEERR_AR");
             } else {
                  warn_report("Guest MCE Memory Error at QEMU addr %p and "
-                     "GUEST addr 0x%" HWADDR_PRIx " of type %s injected",
-                     addr, paddr, "BUS_MCEERR_AO");
+                     "GUEST addr 0x%" HWADDR_PRIx " of type %s %s",
+                     addr, paddr, "BUS_MCEERR_AO",
+                     IS_AMD_CPU(env) ? "ignored on AMD guest" : "injected");
             }
 
             return;
-- 
2.39.3


