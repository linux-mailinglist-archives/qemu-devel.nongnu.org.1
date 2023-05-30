Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2049F71650D
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 16:50:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q40f4-0003M5-EA; Tue, 30 May 2023 10:49:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q40ew-0002r7-OO
 for qemu-devel@nongnu.org; Tue, 30 May 2023 10:49:14 -0400
Received: from mail-mw2nam04on20613.outbound.protection.outlook.com
 ([2a01:111:f400:7e8c::613]
 helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q40es-0007rH-Tj
 for qemu-devel@nongnu.org; Tue, 30 May 2023 10:49:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ixQ5+CbcXV9g9/HSsGF7Cq3AXKsa4BnAr92dxJZl2NqcGWqbQXCDpAtB8hTDPofZF/m5iJedpCVn88KMX2VI0VlEg/iE5Nrrx2SISxlcMuOsm/VniLld1sK4hQ+g7UT7J4JOwaXgelMB7xQOgqpfFkbfnFJjB7+DzrBCHsIooOqB2kGeV8XPW/pYEwKNqOqoRaSPRbVz6a7L8HArJ2TMLC3Dq5OBRKWm11VhjpagEN5fgEOELGXrfPVJIH2IYVi7ahQ+RaSpOasZ4Seoc0n6XAI3IDYpAJWWtQvX/ocmWxr5Qr8maUTm4DUGDgvtXkX63YysdBs8rWDSduAyJjxsGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ty9CIV2fh2WcvJCAV9AeKyGJqCBOuEfLaT2SmeXbeCY=;
 b=l6RSuSJ9qAPvvYN35vovv4nR2ajzgzcLZsIe2gpCa1W0NRGO1Nb3OARa9b5cpbRMcPCz7/3xoeQd5xUpw7Ysq9gxUobbYM3mvTb1NgceMWqHbnYpzrwbb7thbPgxDs/fntkPTzTt9VMz+8BawRMrf2RRh6+IRaaMqMTHBk9NhfOAGG2/ubtaGW0V40P3g5BooZWTsCmvVuWNNiYDkbYeVU4No6XIRaBJGgcUwbO9UqPtgAsK1IzdPPG5uDlKMgBYb+/k4hJNlkNnmO9866YdG32AkuH+LLuuGPeaN+DMqIml4so80KH02samP68J/xykwFj1J6QmK+lgZ/KZeQt5GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ty9CIV2fh2WcvJCAV9AeKyGJqCBOuEfLaT2SmeXbeCY=;
 b=pn8oLZR9Uz3OKW9N5L4FNFO0/FSfnqGsv1iyrnLIgM/OlnW5sQIKzgwHeDS3zwZPy2XI+2C9y///MLDMvHW0mviJASuYJqieQ6eGvQ5WOy6OwuaEMv1Dl3Gk8avQ4Nx5BGciT5obFvdS9RGxhhDzz1kFxCOgm1RE3aYsKZsg86CRrmDeJI0o+4HL1ureYndidkwOiDBL/fVDxe+3EziUsiA53stOwX3yDOXmpgQlylP/7IEassKolHpP2Inu1srn/5nuqkVGZUHYdtbwWVpSDrksuFw3BmefYT8Nma0t1y56ExMDBnMmoOdP4oWVYa2roQjZDyafHfXwRZKd/hm4pw==
Received: from DM5PR07CA0069.namprd07.prod.outlook.com (2603:10b6:4:ad::34) by
 SA0PR12MB4462.namprd12.prod.outlook.com (2603:10b6:806:95::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.23; Tue, 30 May 2023 14:49:05 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::37) by DM5PR07CA0069.outlook.office365.com
 (2603:10b6:4:ad::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23 via Frontend
 Transport; Tue, 30 May 2023 14:49:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.22 via Frontend Transport; Tue, 30 May 2023 14:49:04 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 30 May 2023
 07:48:50 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 30 May
 2023 07:48:49 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Tue, 30 May
 2023 07:48:44 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Yanan Wang
 <wangyanan55@huawei.com>, Juan Quintela <quintela@redhat.com>, Peter Xu
 <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Thomas Huth
 <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>, Avihai Horon
 <avihaih@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta
 <targupta@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v5 4/9] tests: Add migration switchover ack capability test
Date: Tue, 30 May 2023 17:48:16 +0300
Message-ID: <20230530144821.1557-5-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230530144821.1557-1-avihaih@nvidia.com>
References: <20230530144821.1557-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT032:EE_|SA0PR12MB4462:EE_
X-MS-Office365-Filtering-Correlation-Id: 77f7372c-a24a-45df-f5e1-08db611d03c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h/aEewhVLnkFW+OaOvIwM9QhGprgThlMrh671wvhB1TVbdNYXB1U+6/jvIIy6Z2LRGuLlZY6Bq7hM1oQXdLBJdmdN4Q2pzFAyhjDicp8yuQvXH4v0H7Rl19j3Jpyir6qZk01jhdrzssyxc8MyAGQLvPtNMrugKZLQkTZ8L6u/qsoSCcePVi38dAT34pB8KnzYBPiupVJmLXfpDXVttULUpTHngKd/bYkqQSmOhstTVwZGx9y5hHMnV0FFKLS12UJKiaR/jpXnLCZfvGWFDUPGvggXDoe9q06NqQSJO7235ec0gqsW7aEpY4bwlnUKXl6EIb5DYhyAcDH4XC9NYaKTnjGHu21NxA33rTKDdP2O/lGTHhPygWlvXe8Bb1n6zCLCRzUjMG4NhgoK6mMMY89rcgew+oVYa+BAlovD8i5kMIgUSvUlo6tfh2Z//GGo4XvYFVb88+u1Ecn4cXfBfa8dUdDs1l+QoE19uQibaf1YioG/L13ZddtCNeXdwm90Xb6Jy47X3fbCLHBcwH9ccguug6EG6WeYhqOhxO+4nEXEEP73j3XQYcrr7cVg6PvN9f+Q+0qnF4BiMId4Zpf5SPTI94Y4pENuqEq9rF6aPQxMlE45+3zbZwSoqjqHJl5CeosrOD8ybxeW50u4eUvfMCrJRZxDRaY2RHjjUvRmikZZ6gxFAtFXiC5/bZqFGhl8b3WvUp/t0rQnX6zsPV/k8uzS8LcB4TueBxN5sRCws/LCkat4kShBX0+D5NRhMFL9rUb
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(376002)(396003)(346002)(451199021)(46966006)(40470700004)(36840700001)(82310400005)(86362001)(41300700001)(7696005)(40480700001)(40460700003)(6916009)(6666004)(4326008)(316002)(36756003)(7416002)(70586007)(70206006)(36860700001)(5660300002)(2906002)(186003)(478600001)(26005)(1076003)(2616005)(47076005)(426003)(336012)(8676002)(54906003)(8936002)(82740400003)(356005)(7636003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 14:49:04.6549 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77f7372c-a24a-45df-f5e1-08db611d03c2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4462
Received-SPF: softfail client-ip=2a01:111:f400:7e8c::613;
 envelope-from=avihaih@nvidia.com;
 helo=NAM04-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Add migration switchover ack capability test. The test runs without
devices that support this capability, but is still useful to make sure
it didn't break anything.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration-test.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index b99b49a314..d246a5bbc5 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1648,6 +1648,28 @@ static void test_precopy_tcp_plain(void)
     test_precopy_common(&args);
 }
 
+static void *test_migrate_switchover_ack_start(QTestState *from, QTestState *to)
+{
+
+    migrate_set_capability(from, "return-path", true);
+    migrate_set_capability(to, "return-path", true);
+
+    migrate_set_capability(from, "switchover-ack", true);
+    migrate_set_capability(to, "switchover-ack", true);
+
+    return NULL;
+}
+
+static void test_precopy_tcp_switchover_ack(void)
+{
+    MigrateCommon args = {
+        .listen_uri = "tcp:127.0.0.1:0",
+        .start_hook = test_migrate_switchover_ack_start,
+    };
+
+    test_precopy_common(&args);
+}
+
 #ifdef CONFIG_GNUTLS
 static void test_precopy_tcp_tls_psk_match(void)
 {
@@ -2695,6 +2717,10 @@ int main(int argc, char **argv)
 #endif /* CONFIG_GNUTLS */
 
     qtest_add_func("/migration/precopy/tcp/plain", test_precopy_tcp_plain);
+
+    qtest_add_func("/migration/precopy/tcp/plain/switchover-ack",
+                   test_precopy_tcp_switchover_ack);
+
 #ifdef CONFIG_GNUTLS
     qtest_add_func("/migration/precopy/tcp/tls/psk/match",
                    test_precopy_tcp_tls_psk_match);
-- 
2.26.3


