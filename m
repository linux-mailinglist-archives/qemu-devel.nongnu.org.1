Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 502FE7139E7
	for <lists+qemu-devel@lfdr.de>; Sun, 28 May 2023 16:09:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3H3b-00012Z-HL; Sun, 28 May 2023 10:07:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q3H3Z-00012O-D2
 for qemu-devel@nongnu.org; Sun, 28 May 2023 10:07:37 -0400
Received: from mail-co1nam11on2060a.outbound.protection.outlook.com
 ([2a01:111:f400:7eab::60a]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q3H3W-0002jV-BM
 for qemu-devel@nongnu.org; Sun, 28 May 2023 10:07:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cb3sNU3/98CT8pOhKiBbUaJJoCe1+Rr6zP5VQKBJIjO6+SlPm61X/PBcBL/rUMqhY07+1zMzqmb6Mgle+HhZtsioa/jYNfBZqyFrYatVVIqBEdK6PMzwZm7hbxZqgipPLklk/epTmUFgTj10p20Q2Tf9EwiG1Zc6FY5oxYMMEI2xN+ZsGMVVk1gsum9X4Pk7I6XnpB6Zqvan29aNyXE6ms0opU2b6nRBgYbZwIpcVkZKRcT7/Jx5rytyLZNEBLVCOrjRHrpftQdvewMUC6PuhpQ/r4Dn5UoXodddUsebmYPkT5nrmVQmQvqKnGMIghBNT9m4JPLyQ4wmgr/4splPeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ty9CIV2fh2WcvJCAV9AeKyGJqCBOuEfLaT2SmeXbeCY=;
 b=hGHBOBV1JJu/iKdar3fbPU+aODsFCxvYU5UcEM9XXWs7rFf9uCs0wYYhkYkVYmulC4YVMvTLUNAomt4JvPiCk79vKBEGGZCn3PFqzpNmqdjy54NP7P4NJ6ZoADjOqi2vYQikGqwBwwbVAJ7oJIrHf0S9jQL+oW7SgKWwVTE2CGP/6/Dyi6GuxIS4OK4LnCzTkjzgxZapYL6dUvPndBSsD0FVNeBOa434bA5Jl/O5hnsqPbDo7frXmoCskVoQtj66ollN7chcpJd9MjcWbNJ3cMyDKAdOH+UKq5WMZ+vu8PkrNJssL6d7FxfRwHqr7aa21xw63TC7fN+Z86dYmb9oGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ty9CIV2fh2WcvJCAV9AeKyGJqCBOuEfLaT2SmeXbeCY=;
 b=cnrLoGoGAdmGUxgXqL+EkPUnnOB8yDpJidSpVzM2YOkJiukUmF6UHp7th7kV7gTxZb3wGiiO+xsfCtskh+HDOk+LoF94t26f+ZqnzRG4uf9uY60gjU8dgLJnQleb6EPr+DtTZbnt8+mqOqyHU/7a2rfYcbDpmq9iV4WnqGxoWHxta8N3LyLyGBsB3oYoRyIjQsAkXWSwp+QMxqXaZhBxry1SFWx8dknEX0y6ZuML4IS0dE0q1qfwcoHOO/nle/MOHG/CRIixunDTTt4maNc5kbbH9/cNIHcR5VbuQTXiqjYwc8qsAL5RIbiCTD+4BvnZ87YK6yCaYssl8v8jGEFJvw==
Received: from BN0PR03CA0031.namprd03.prod.outlook.com (2603:10b6:408:e7::6)
 by PH7PR12MB7331.namprd12.prod.outlook.com (2603:10b6:510:20e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.21; Sun, 28 May
 2023 14:07:30 +0000
Received: from BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::1e) by BN0PR03CA0031.outlook.office365.com
 (2603:10b6:408:e7::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.21 via Frontend
 Transport; Sun, 28 May 2023 14:07:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT057.mail.protection.outlook.com (10.13.177.49) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.15 via Frontend Transport; Sun, 28 May 2023 14:07:29 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 28 May 2023
 07:07:22 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 28 May
 2023 07:07:22 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Sun, 28 May
 2023 07:07:17 -0700
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
Subject: [PATCH v4 4/9] tests: Add migration switchover ack capability test
Date: Sun, 28 May 2023 17:06:47 +0300
Message-ID: <20230528140652.8693-5-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230528140652.8693-1-avihaih@nvidia.com>
References: <20230528140652.8693-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT057:EE_|PH7PR12MB7331:EE_
X-MS-Office365-Filtering-Correlation-Id: e8af21ee-ce7c-4ac8-1751-08db5f84dfeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qQQSCQw72ZIVycBWdPyzN5qiCVAed4KWayw6rJ1z41XRC8kvpzEr3XYlfQSXakEbE7tn57zGveE7JHqtEX6qx404A3G3ARX3hWm8HSpkTP0tq6VNhoY/GNFQa+rbL6vKFpnZnse1viXa5Tm2fSsMYsLoqWYHur+pJ7K8/vIi7b436t+sNJIcgzY44Aa1wKeBXECHOSEnOMYx15wgpWL+0mw4VdmKg8cB3nhCDKBApBFHvpqEd7AbxvD/m2801cWGX+mSJdB1CNv2MbmFdJTloJECyNJCxFtguE2iatBss6dtcvwDBdrH8Pqtr1nZKllED348Ow9SGa6glr93c7GeAhZt1fnuEmNnizmMmARe+o1n6odzPwA6FHWJkTTYIQTnbddShAvIe0HkYi3S8YCPtXxycjn3MAKAKXTkVm5i6XIQcJE85kD0e12A4Cj1o83vSk4ucfAcfbbLVj7ThMxFW2TqKUcphYdhH0PgpbPgqRz71x2KthAIJad6y18dPjGq9VyMkdqhhwL3DEHBoy1LQIkq6mmYyncjFx6v3+tGo38pgKfFAKzqjdGQxsabmME+Jy3EaIyaLzGhEfKoiQeptMBzqHkC5S1roQdlmJk2HieUQYz9phWn0fdxpWL6Sd6tZ9N3mgP6IYCOlDs7gis9PZoO+XhZIw8ntx7fa9VlzTDv5uQo1ZRZa91dbif5GErhBlXiiLJi7cNc9/FOVtfyPMDoEM452sbosZgXaLUFNwNkLazO97aP8rX+75mOZT6w
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(39860400002)(396003)(136003)(451199021)(40470700004)(46966006)(36840700001)(36860700001)(40460700003)(47076005)(5660300002)(316002)(6666004)(70206006)(70586007)(36756003)(7416002)(6916009)(4326008)(82310400005)(82740400003)(356005)(8676002)(7636003)(41300700001)(7696005)(8936002)(86362001)(40480700001)(54906003)(2906002)(2616005)(186003)(336012)(426003)(478600001)(26005)(1076003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2023 14:07:29.8073 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8af21ee-ce7c-4ac8-1751-08db5f84dfeb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7331
Received-SPF: softfail client-ip=2a01:111:f400:7eab::60a;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.164,
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


