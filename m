Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE0D730BEB
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 02:06:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9aUS-0005qA-VL; Wed, 14 Jun 2023 20:05:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1q9aUJ-0005ml-CF
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 20:05:19 -0400
Received: from mail-bn7nam10on20615.outbound.protection.outlook.com
 ([2a01:111:f400:7e8a::615]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1q9aUH-0006rd-0t
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 20:05:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJOml4pZ+zH+ZeQOl3dIN9BImJbS/LTN0/CgaiiJQIhhprkvig2kJR2Ko5m5yvLYXOSaQMCX+6PHlpmmanmS4ZobqYDrOgQBJISy1wWS/Wl7vVbgFppuMcFRWEQW8vyJodnYXvWlSAUE8LvMzOfLqFbRSeuUSo53wj7wLpJbUJywE8ANfnAmiRN2m7Elo3oMVt3I9WKIzHkxQ99CnUlLQbilDhp5xGmEMg1ws8nDiRJfLaeGvXR6xtfXyWQ4wavg88zh7ZOntUvGe5JqnayGoRHd8Gv2Jk/jsLzPK7Eww/1BLWqXX/6bQDJOSCpksfVV8O9u2JY+tW3nBJLNgPEX+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1GPFrVwyJAk/wj9M8BzLHdKddZTmQYLu+ViRsYgyOvo=;
 b=XpG1s9rggJklgjhPvtRo27UZ1IDEwo9uvb3gbq2Sim5imk3Dlas1yvIrouP3BxdnKTYi+2O+EeK5zH6rfdd9lh230TJ28ySotJQYlx/yFzbrB5e9if4qHo/r+1vZgkk3vGajxTY0j1frVkauRQ9wMOpzvpYbnPaQvryEMOnoE/B9H2+mwhekIDGmY4Ln07UsgkzSWnoCImiKbdjLo23T7X8XKgPOtTNwT3nJSshzUHf6qaTb1V2sIlG77MxjaZ+WipQgL1WDi/k57YtHNhJm7Tk0/XN7wS7mCM/H51sIznC6aTssX8B+8ZgrtnT7wkSllzbtBhi9GC+Bos0NpChiJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1GPFrVwyJAk/wj9M8BzLHdKddZTmQYLu+ViRsYgyOvo=;
 b=wKf7xqNpiorRjodlxNh7As/n08jKIcrTH81gWaDZy7tNqcRnSXcNRMrPf/7rXWV9PI/y/6VRX4q+wLyd4ysnVd158VVtZT46ZY+/6XlWWybEpAJOgm1ls43GPe/GzPr2cr3zkZHkU/VbzxEdpRaXZ1uuDs818eNfRpeWu/e9EoA=
Received: from MW4PR03CA0032.namprd03.prod.outlook.com (2603:10b6:303:8e::7)
 by MN2PR12MB4406.namprd12.prod.outlook.com (2603:10b6:208:268::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Thu, 15 Jun
 2023 00:05:13 +0000
Received: from CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::11) by MW4PR03CA0032.outlook.office365.com
 (2603:10b6:303:8e::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.38 via Frontend
 Transport; Thu, 15 Jun 2023 00:05:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT051.mail.protection.outlook.com (10.13.174.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.25 via Frontend Transport; Thu, 15 Jun 2023 00:05:12 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 14 Jun
 2023 19:05:01 -0500
Received: from xsjfnuv50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Wed, 14 Jun 2023 19:05:00 -0500
From: Vikram Garhwal <vikram.garhwal@amd.com>
To: <qemu-devel@nongnu.org>
CC: <sstabellini@kernel.org>, Vikram Garhwal <vikram.garhwal@amd.com>, "Thomas
 Huth" <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [QEMU][PATCH v8 11/11] test/qtest: add xepvh to skip list for qtest
Date: Wed, 14 Jun 2023 17:03:39 -0700
Message-ID: <20230615000340.1135-12-vikram.garhwal@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230615000340.1135-1-vikram.garhwal@amd.com>
References: <20230615000340.1135-1-vikram.garhwal@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT051:EE_|MN2PR12MB4406:EE_
X-MS-Office365-Filtering-Correlation-Id: 09d52529-8d58-41f0-fcca-08db6d34309c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kGFeC6Bxi/5PFP8Ez5D9W1uoRs+FSeF7MewCIWHuEZlAwNpcZ75WJEuPMrzYJxHOwq62uJBZ1+XWWET9x8ECwRDvVivoWUHaRL9y0DvSQjWPZNFkpAQti/iRg1Bx1dBCYYkLK9kYV0oGLMalK3ySTtj+m4B0h2MJlnRuC60B+SbM/p8QKfIeH7ZvuBfnSODdBrNq5bhQoN1AIUBw5ShR1yZbvyRp6VKqE8PTYxbSRODUhusZspnIpyYh0n4Fn+7vkjj+rO4YGNhAeA+NiHE+H1Z+8tzrQKB7uTBrqhGOTRX0fi7dn09FvGACdGEwOZvrzEm2Ka0EF1cWG0/XTsFXiV4jt9dqhJlgMUi57Y9yAl16U3eTlChLmDtauP5ejDvxNe+hkabVW43W75IX6NqelM3d1vR184GKmcV4b3wXuNowmIxxcCAmxOaeq7EKg32p/uf8rls3L+8PvY9XLolevKBUcGYCNjm8JjaAg+KqAjTg9w/lPjMgJbg9REsPl2bGnb6arOxeELKhLQQcWhGf+ciK4ChzY+oXzTsuv6cfBJKObQkPSzws1SeL1L9oYLOKz02YZAyH50dEwNINnw8hjg/A8zYPwEJGRwm7+Q+XCjUnQUngVlgNz2/ilbgc+ufx8EbtAYznYm6rVpeVKss4QUMbuhkBmEWAtRSiS6D40pJLAeMs4WKCCS6PNt9kbfGll5goPf7TNzkpl6Q8RZIgVxi3VtcuaaFcF/ctn+3HlkucY50+NCt0zg6f88SR+YSif1yJ/a+1gWgxWxfm70HbQg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(39860400002)(346002)(136003)(451199021)(36840700001)(46966006)(40470700004)(336012)(426003)(36860700001)(83380400001)(40460700003)(47076005)(4744005)(2906002)(2616005)(36756003)(82310400005)(86362001)(356005)(82740400003)(81166007)(40480700001)(54906003)(8936002)(8676002)(316002)(41300700001)(5660300002)(478600001)(70206006)(70586007)(6666004)(6916009)(4326008)(26005)(1076003)(186003)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 00:05:12.2972 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09d52529-8d58-41f0-fcca-08db6d34309c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4406
Received-SPF: softfail client-ip=2a01:111:f400:7e8a::615;
 envelope-from=vikram.garhwal@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
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

Like existing xen machines, xenpvh also cannot be used for qtest.

Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>
---
 tests/qtest/libqtest.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 77de16227f..de03ef5f60 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -1465,7 +1465,8 @@ void qtest_cb_for_every_machine(void (*cb)(const char *machine),
     for (i = 0; machines[i].name != NULL; i++) {
         /* Ignore machines that cannot be used for qtests */
         if (!strncmp("xenfv", machines[i].name, 5) ||
-            g_str_equal("xenpv", machines[i].name)) {
+            g_str_equal("xenpv", machines[i].name) ||
+            g_str_equal("xenpvh", machines[i].name)) {
             continue;
         }
         if (!skip_old_versioned ||
-- 
2.17.1


