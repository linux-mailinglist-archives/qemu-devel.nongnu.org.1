Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 822077D76B1
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 23:26:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvlNb-0007JH-FM; Wed, 25 Oct 2023 17:25:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1qvlMx-00073x-I3
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 17:24:56 -0400
Received: from mail-co1nam11on2061d.outbound.protection.outlook.com
 ([2a01:111:f400:7eab::61d]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1qvlMt-0006TY-HI
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 17:24:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HUzVRk8IJpwny3AyZpJiV+E7xu124CDPe2cFG54n9/stCYaP+u5UdG1JBC7hKDjKIj/8LYQaZu3ungmZ5kX3V6XYtCK6x3IsViZwiAk8N9eFOA6wPoC1UzFD4Kr5UIX5wdBo6Ku8AQn7XB8dtTXYnwK4XG2YyE1JYme/8s/Zzuena5mHVqh/tNxRVPiArenrrD2649ErILgcUbPEwrQ1M9U05XOp9rU8/e22VJDS5yNoIf0gFCoGFNmQQEOybv4CuBtBOvLPw6QUHaio0umcAGD7mX/ZzidxmFisr9hscrKTK3A55xNz1Q8UMYUx45/dBrWDm35ZZGS9GuxRM33kjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mET7kcl9UXXPRp5J6MoXxeoteODqvxROwm3Ecdt2YHM=;
 b=L54Gsgu9lvYQuOOiRH3Lnd4vuIckJkm63+8Wh8ADL0G84BGqZ+iPu5V9ymyC/QOWjiTpjoEdKG4FacfqYa37ox8EvzDLsVXGCXXtnQZdX9DaDQNKC9ct3o8IZ9k9jphKQBzx8HKzii9rXx9I5G++5gQDDfwKvOADQ3G9ICCIrqmppfP72j1GxAbbmMcuQd+sGhcFxVbQZ11nL86fZ3MNWK+4mh+RGX/Ts5w3ItBCmYycEdhMflVHNxGtVeRViz9u9bFg0xGaQJx4UfhUWfvGw8tLzzvjI8QYMg08FJmog347VQMdnlz2xwmghwGd7ZbXtQSLv1Y4w2S7MeRCq93IKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mET7kcl9UXXPRp5J6MoXxeoteODqvxROwm3Ecdt2YHM=;
 b=LPKxhpH3He1LUk5nz5kJkkKDwXxyR2IkcDmHfhH8BeSDxjm47uqwbstdvzEgXSBVtPc5s06MPVfjKIqVuh7EAE90RJw7m6J2Hd1jNwxbbuGtmP7Z/NefpGegWCtOUH+DImPF7zY5FvlL7B7tSHAbuiaBLjmyu0WuU0YEuETLfow=
Received: from DS7PR03CA0293.namprd03.prod.outlook.com (2603:10b6:5:3ad::28)
 by PH7PR12MB8015.namprd12.prod.outlook.com (2603:10b6:510:26a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 21:24:43 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:5:3ad:cafe::50) by DS7PR03CA0293.outlook.office365.com
 (2603:10b6:5:3ad::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.35 via Frontend
 Transport; Wed, 25 Oct 2023 21:24:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 21:24:43 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 25 Oct
 2023 16:24:38 -0500
Received: from xsjfnuv50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Wed, 25 Oct 2023 16:24:37 -0500
From: Vikram Garhwal <vikram.garhwal@amd.com>
To: <qemu-devel@nongnu.org>
CC: <sstabellini@kernel.org>, <vikram.garhwal@amd.com>, <jgross@suse.com>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>
Subject: [QEMU][PATCHv2 5/8] xen: let xen_ram_addr_from_mapcache() return -1
 in case of not found entry
Date: Wed, 25 Oct 2023 14:24:18 -0700
Message-ID: <20231025212422.30371-6-vikram.garhwal@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231025212422.30371-1-vikram.garhwal@amd.com>
References: <20231025212422.30371-1-vikram.garhwal@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|PH7PR12MB8015:EE_
X-MS-Office365-Filtering-Correlation-Id: eb251ac1-76e0-4082-da4f-08dbd5a0ce6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sBM53jdzwRhG04qo8BJM7dlxyvUqIZpGeYp5zQq+HPm6t1UAJYh4X3NDFrh9tShD87nZ+KfOqgwTe6NCP7uKeMcCehVd/XrhYgv93sdHeQpfX6OsnjuJOtnVsyACsgZhOY8d9Z6qCYd4xKDjOXY42rarB4mXn+S6MLAkfERZBpFcSDxbKOv/voegP80vadrU7VNlKsduMzF1Pe10ynMUXrEePbIiAsM9a1SuJxcy41Oiybz+Sl+fS9orHYT8/SmSm6YwhdwFspctKK9mHeqaySzW1DJSedpL0ENAOQ83jtp9j4cPtAFaaZvIwDK9VKXU50EQwjeMfZYykLB3MhNitlnB9nKfHOmzk8X5/ntvS/5OIBEfvRTy8gt1MkbGPosbTWgw3pRlKXoOd9MeF6IqcCt2jO+sS8kAOKpu2XFsSUvlqb34KOTl0Uy+QqsJLUG/zEAmG8aMNu332FEik0VhiRjoNVkY/pWGI1ilOt/ZhVOpMSn1UznpecgQ69HUWDDpvr3mxlpzJrp1vNi4TcEuYfNS4BUe6uQn/rVs3h6kIpZCYieFxmwdN+As8eKAKoPrmjAZ/jBEc+irkh9LjzoNMgqDg4pLgc79tevsA9osOiFiQvVxc0PrQR/rBxdVDXAr0TqUP1LEiLlJDkdDhpscRRE6ci5r5DxqRDJF3h7/LFjklGlUDRNz4xoRnSzpNgw1gZ51mY6qIvSue7KgFbzuBD4FjEDo9/9ptxK1OvfjNDX0n3Hf7yzK/u6A2zzlJUtEp6Q4aX2qijOv3y40LQOdFw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(82310400011)(186009)(64100799003)(1800799009)(451199024)(46966006)(36840700001)(40470700004)(26005)(41300700001)(2906002)(44832011)(40460700003)(36756003)(5660300002)(4326008)(86362001)(8676002)(8936002)(478600001)(2616005)(6916009)(1076003)(36860700001)(356005)(82740400003)(316002)(70206006)(70586007)(54906003)(6666004)(83380400001)(40480700001)(336012)(47076005)(81166007)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 21:24:43.5749 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb251ac1-76e0-4082-da4f-08dbd5a0ce6c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8015
Received-SPF: softfail client-ip=2a01:111:f400:7eab::61d;
 envelope-from=vikram.garhwal@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
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

From: Juergen Gross <jgross@suse.com>

Today xen_ram_addr_from_mapcache() will either abort() or return 0 in
case it can't find a matching entry for a pointer value. Both cases
are bad, so change that to return an invalid address instead.

Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
 hw/xen/xen-mapcache.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
index 8115c44c00..8a61c7dde6 100644
--- a/hw/xen/xen-mapcache.c
+++ b/hw/xen/xen-mapcache.c
@@ -404,13 +404,8 @@ ram_addr_t xen_ram_addr_from_mapcache(void *ptr)
         }
     }
     if (!found) {
-        fprintf(stderr, "%s, could not find %p\n", __func__, ptr);
-        QTAILQ_FOREACH(reventry, &mapcache->locked_entries, next) {
-            DPRINTF("   "HWADDR_FMT_plx" -> %p is present\n", reventry->paddr_index,
-                    reventry->vaddr_req);
-        }
-        abort();
-        return 0;
+        mapcache_unlock();
+        return RAM_ADDR_INVALID;
     }
 
     entry = &mapcache->entry[paddr_index % mapcache->nr_buckets];
@@ -418,8 +413,7 @@ ram_addr_t xen_ram_addr_from_mapcache(void *ptr)
         entry = entry->next;
     }
     if (!entry) {
-        DPRINTF("Trying to find address %p that is not in the mapcache!\n", ptr);
-        raddr = 0;
+        raddr = RAM_ADDR_INVALID;
     } else {
         raddr = (reventry->paddr_index << MCACHE_BUCKET_SHIFT) +
              ((unsigned long) ptr - (unsigned long) entry->vaddr_base);
-- 
2.17.1


