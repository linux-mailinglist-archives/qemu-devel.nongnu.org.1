Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B53BB706D68
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 17:54:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzJTC-0003vp-HP; Wed, 17 May 2023 11:53:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1pzJSd-0003Rp-T5
 for qemu-devel@nongnu.org; Wed, 17 May 2023 11:53:11 -0400
Received: from mail-mw2nam12on2060b.outbound.protection.outlook.com
 ([2a01:111:f400:fe5a::60b]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1pzJSc-0005zL-6C
 for qemu-devel@nongnu.org; Wed, 17 May 2023 11:53:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oKcG8EVszFmg/YmLirbblsL2nxD0l4hP1i7NukNj1Ls7dk+6hOBh8YJVmEqHcKrtflqTf+zb6PfJaa9KymNLs1GShIIdbBpgG6RvCcaOSjG/L3Uv6qHL+0SMzkK6jlQcSoYEN0pqonavPN9Evj2N1+4KNBGhAK5oebx1xU72v66E7dNKAdPEQ1bhnvudWhq6MUHIf37P+SwRKMQqoqbfBoA01uykRW8106k1wF5POCYNFSrKbOujMZXWf1NYuznzw01xWldjx6G4lyGySw+Ek2rgpZJyxm6rTVy+IqsnJ4rNJaY+8oqq0voWmq8wJfI2fByaQQ0SMlKnwLlB64hPcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vfXTcAeyPGQONDNtgZUGShfRWn5SXn5THvzuYjSEQi8=;
 b=YtpdC0zOVwquwK04C6KJvrcxTBkW18/ZNtyYMLKxYierHnILp0DxmdTQJPPg0a3GFGUCom1fS1Fh9bM91cPw9eYp8a3zx8y/XP/DfACwFBHLlejMm4hf7/anv3RUDPbH5dEFImPjBGFb6hsGHW7BRd562+ZQk3XYaOTAKg742JeA8zECU1YIskp0hvrCvJ+4xsCRaGmXsh05jzIinpzBo6MOv4QRv2Fa5JS0snWGKZJQl0zZEKgK0wxvGxZwuE6G7Y9+rGtlxtkBU8DdBuewr4KJCJsvd0ul5yR2emoixdMm0QtanA0QgEHrMeHxfQmbKbau1fD3cqcDhkP407FL+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vfXTcAeyPGQONDNtgZUGShfRWn5SXn5THvzuYjSEQi8=;
 b=DY2d0e0p/HSVcfXeq/uX/0CZ8xkSjvM4fKcfJiXatTtrP8pE958wuxdh0tONSma3K0U00wMs/VAtyagz7bjelbKiQFEAUxheDNbxsL30fi4H6H9SCK8lKrt+mOajLAtLEvG9WG8nZ6ePnlnUa+ZUEgKoFPAtDF2fNk6LqSCWSYwODU0GDUbziIYzDXFtJcGeenvRn/n6Fkq/TlKcCBTT5Z+SWpjL3POXM0ue0UF7nIHKrYZolqm7ftXL3+qcDJF9FhMUp2g2w6PMVWvVm8xo4NUhism4Iz4mRBZNmJLrf+EpN2PA04kjiX/XTcsiCf10nCT5d0WWVuWwMrRFs5lJcQ==
Received: from DM6PR01CA0007.prod.exchangelabs.com (2603:10b6:5:296::12) by
 CO6PR12MB5459.namprd12.prod.outlook.com (2603:10b6:303:13b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 15:53:02 +0000
Received: from DM6NAM11FT110.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::47) by DM6PR01CA0007.outlook.office365.com
 (2603:10b6:5:296::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17 via Frontend
 Transport; Wed, 17 May 2023 15:53:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM6NAM11FT110.mail.protection.outlook.com (10.13.173.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.18 via Frontend Transport; Wed, 17 May 2023 15:53:01 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 17 May 2023
 08:52:46 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 17 May 2023 08:52:46 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport;
 Wed, 17 May 2023 08:52:41 -0700
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
Subject: [PATCH v2 4/7] tests: Add migration precopy initial data capability
 test
Date: Wed, 17 May 2023 18:52:16 +0300
Message-ID: <20230517155219.10691-5-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230517155219.10691-1-avihaih@nvidia.com>
References: <20230517155219.10691-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT110:EE_|CO6PR12MB5459:EE_
X-MS-Office365-Filtering-Correlation-Id: 64e7af20-ad32-4bd6-ca48-08db56eecb86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sc9CA8orF3mm4IdoVPHQjywYW9htXow0r9/Lq19TfhGVs/EFF/EHw4a0FjNtNV3hB9wCjX4K9fenTldY4lHibq1LucGKoTf2KY3B0Rf8Y/oFSCAjDyyzJMf7wfgRpLrz8v+UeXXtOOY9rhto/rXmLvAsAHtt/yhdL8a4HhdgYMWbZi3A5blDlrDzdqE5FTi1dJY2CigPHQTUGjaxE3hnMFUYcw+Oq1pQ6JAgvZcXoHPabpOv71BtyYQMMAHBQcyJS9RXU82BCCwzztRRX0SFsAzH0pCyuqqpYaj/JAhUuHlWy0+Da5CBqlJOH4ZRk1NbYqf/uPDbcq1YVCQGXl0rIL993ZOzYD0pKcagYevSMzNvaDAkpAV2zSnLVola+pJSLFDVu77NDc0C6i1owLhVW/X6eWIPX3HlTFTKy0jNynGwHkdSTUcxpcl1cMDxKTai0+72rl/kz62VKZysPx+caxozEVjUAzEHNCmJHediecb3JrHmG7h3Ht2gS2YA1yA1gYrHUoCjuzrnuehXfxlxJ05nEkuDbSfDP2ii57bHvwewC+cO4AQk3lewgR7awQSbqYLJq6VmNc0J3/fRgvOLXNypaGIc7Qox7ovOg31JgyfWaqKnde8C9QTVXew3Q6YIEhpOJzuq8thmq7ADibARiX+vxFhy9C/o/MdXux5dIKc21PUgC4bHFoajoBCTWHqKoPpz1Zd2aQl2cWWvlY5EM0F5OYCtIwHzZUxy0HIg3US+k3d/N7QuoUkcSsWIncKj
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(478600001)(86362001)(7696005)(47076005)(40460700003)(6666004)(40480700001)(82740400003)(2616005)(70586007)(316002)(70206006)(6916009)(7636003)(356005)(36756003)(4326008)(7416002)(36860700001)(5660300002)(2906002)(82310400005)(426003)(336012)(41300700001)(8936002)(8676002)(1076003)(26005)(186003)(54906003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 15:53:01.8464 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64e7af20-ad32-4bd6-ca48-08db56eecb86
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT110.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5459
Received-SPF: softfail client-ip=2a01:111:f400:fe5a::60b;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Add migration precopy initial data capability test. The test runs
without migration users that support this capability, but is still
useful to make sure it didn't break anything.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
---
 tests/qtest/migration-test.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index b99b49a314..3b3c806104 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1648,6 +1648,28 @@ static void test_precopy_tcp_plain(void)
     test_precopy_common(&args);
 }
 
+static void *test_migrate_initial_data_start(QTestState *from, QTestState *to)
+{
+
+    migrate_set_capability(from, "return-path", true);
+    migrate_set_capability(to, "return-path", true);
+
+    migrate_set_capability(from, "precopy-initial-data", true);
+    migrate_set_capability(to, "precopy-initial-data", true);
+
+    return NULL;
+}
+
+static void test_precopy_tcp_initial_data(void)
+{
+    MigrateCommon args = {
+        .listen_uri = "tcp:127.0.0.1:0",
+        .start_hook = test_migrate_initial_data_start,
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
+    qtest_add_func("/migration/precopy/tcp/plain/precopy-initial-data",
+                   test_precopy_tcp_initial_data);
+
 #ifdef CONFIG_GNUTLS
     qtest_add_func("/migration/precopy/tcp/tls/psk/match",
                    test_precopy_tcp_tls_psk_match);
-- 
2.26.3


