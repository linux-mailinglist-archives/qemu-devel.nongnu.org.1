Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D42270AE81
	for <lists+qemu-devel@lfdr.de>; Sun, 21 May 2023 17:20:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0kpm-000897-2o; Sun, 21 May 2023 11:18:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q0kpk-00088k-DE
 for qemu-devel@nongnu.org; Sun, 21 May 2023 11:18:56 -0400
Received: from mail-dm6nam04on20600.outbound.protection.outlook.com
 ([2a01:111:f400:7e8b::600]
 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q0kpi-0000DH-Lv
 for qemu-devel@nongnu.org; Sun, 21 May 2023 11:18:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jKDeY+bqcZDm4IYqsurLcei9oPg7wj8gytSpSC65tnwVAykB+IQS/Ud/0TucVLkQ4z62xUtKThdndvt5n+nfOAa21rdvC+g9Byktmb5pXh/o8UG8fhbUL3IXUQH0Re8vRWuaEgkdTL3fggwS0BYHCLzCZ4VDSsYEiMUm7JK26OBO0mOkWxQfU6140G3DlSBWK2Ox/I3RxrMp/gMkRoTLMXE3VNx6HjIU84ZL4zl+ilsqTNHwMmmzjhc2ncJRUCnTa0bcP5as8RdAQ6VmGFkm9q/UxpdlJmYiN2xYTAnZu7nwCl3muz/NpR1tf3XXP7/lirvhNFB39uv3h7zAPNK3kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ty9CIV2fh2WcvJCAV9AeKyGJqCBOuEfLaT2SmeXbeCY=;
 b=FS9cbTDTGfE2lZ3Xdd17ngo2/4MXsMP6/jNa+azyl5TNiEFQC6gSoc/d82n4DCTKlgh5cSqg6tawOr334wksDMrOfVYatvCvlry05rf0CaEjTrW2oc1IVtcfgRz8ifJnqahyg0Lgfr/ltnKSpMLQFHNZTSfTvbXbLxgaeNHvtW4YtB6f7Lp9bchU8/xt1qcBeTvjho9pcw92ngDgKqygGhz1ZvM2eMaaFPjEbvJ1/Oyim2GFNQoylhRF/K/9VeAsFfOhU8IiF57C03UBVXAKXbSrwwj3RWTfKfc4mLH1+6OOKfWyZNbzb69AzGXsX8ctfaDcb883+epFXmLZOw3HpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ty9CIV2fh2WcvJCAV9AeKyGJqCBOuEfLaT2SmeXbeCY=;
 b=AAdi/K4keUP9izJrC2ZLuqGSb6i+JyLbkyTbrn7LB9cn4Ls0wCdKOIWoHapAlFdBjcGAWueuGJ7j6NwPIK5nOgAEs2N+791fNAekMklQ4OxEVv9jyf9QLoqf+NVLS8ALJlOKGNdeIKF/Zohdgpx65LnTWg7fiUI59wDIPfKAhleD64kUvxd2Qyo8AA25R4RytwGXgqbMtBXM8ch+xn5Rxo9FOpXTuLK+E5PrqVGTKIqZ39e1VFbp2ckefkL3ynEinm8ly96d904gOdO5qYyXK6dEpW33x1PCG73C2q2B1zl6UVEL80/5qey68jFNbHxVgUEMiHVPN0dpSOXxYrDZGQ==
Received: from SJ0PR05CA0109.namprd05.prod.outlook.com (2603:10b6:a03:334::24)
 by PH7PR12MB8779.namprd12.prod.outlook.com (2603:10b6:510:26b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.27; Sun, 21 May
 2023 15:18:50 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:334:cafe::cb) by SJ0PR05CA0109.outlook.office365.com
 (2603:10b6:a03:334::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.12 via Frontend
 Transport; Sun, 21 May 2023 15:18:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.28 via Frontend Transport; Sun, 21 May 2023 15:18:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 21 May 2023
 08:18:37 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 21 May
 2023 08:18:37 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Sun, 21 May
 2023 08:18:32 -0700
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
Subject: [PATCH v3 4/7] tests: Add migration switchover ack capability test
Date: Sun, 21 May 2023 18:18:05 +0300
Message-ID: <20230521151808.24804-5-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230521151808.24804-1-avihaih@nvidia.com>
References: <20230521151808.24804-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT011:EE_|PH7PR12MB8779:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e2db2cd-7f61-4dba-3009-08db5a0eae47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2y5DN+LcUlvFYtBdAA80w516kfpt2LJcFfk8WP3XuLvqSh6ebTynpW20euMCtCW4wlqQShdl1vnyaqLBXuuAFDfXKjxpjVnIP40VpwObDXCEHu1MmaH1feBXlM6wRlSiH1PlzMsuB6JgJGI3cA9t9vsFk8czFtyCSZNcFgl8Q/y495uhP4IyPayZwK99dg4z7VhKip07a5EhOTofSZXi5dGHhsmC/04/F/HsfUP7ehD0KaJ6v1GnJ+p66iE3TVfT5z10IHU/kCDYoZUmjbogqhDPW+Jjy7Pkndce8ocrCUBxSHig3r53CdkRkQiqWFLVPohFlHc5fWB54DUFKGwcK/x2YlpvfjbBNMgqtX3HJLA+X8WYTPAya2HyUu2/cW+9qK6Q/deR5Q+RXzwDjEOK1raxsqRb7o4c3DLAfAFD5ao3vPWsGsYkhEk3M0hGevLeawj4j12WVcHuVxBu+pQXyV1vSr/Br38MKC2uGsJTTxw6VdCG3FYAQ5UOJNM5GZTAx5sa4fRzKF4QH3xEOSZMWqz7s+D+frNheL/jfSNsyiGZfU5tx5dC4cYu/MirUynaaIRIHbtHvJL6h2PETIbWsgB7Ct6Hh0LNicbFEfPy1PXjwfHxwdLeW47h5B3sdYBY27u/wEuHfAFQU1PHBvGAgoCGaySs1qS3jzCdXEFiyIoMFce2RyDgGvJp4M9CY8l3CD3OevGI8NBdGwSUV1/lNta50Sp8Telt1FinALMGkYl7Txr5PLTeK6PHdQNjF3iE
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(39860400002)(396003)(136003)(451199021)(36840700001)(40470700004)(46966006)(54906003)(356005)(7636003)(478600001)(36860700001)(4326008)(70586007)(70206006)(47076005)(6916009)(82310400005)(426003)(336012)(82740400003)(2616005)(2906002)(6666004)(316002)(186003)(26005)(86362001)(1076003)(41300700001)(7696005)(5660300002)(40460700003)(40480700001)(8676002)(8936002)(7416002)(36756003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2023 15:18:50.1593 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e2db2cd-7f61-4dba-3009-08db5a0eae47
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8779
Received-SPF: softfail client-ip=2a01:111:f400:7e8b::600;
 envelope-from=avihaih@nvidia.com;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
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


