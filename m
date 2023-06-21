Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D9C738236
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 13:13:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBvlU-0007LG-Li; Wed, 21 Jun 2023 07:12:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qBvlS-0007Kk-MY
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 07:12:42 -0400
Received: from mail-dm6nam11on2062c.outbound.protection.outlook.com
 ([2a01:111:f400:7eaa::62c]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qBvlQ-0002We-TU
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 07:12:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dX++p0X3Xb/CxrTFXEEiQwyDGJmW/g5Msxe+BL+zl5+xHCYz4mvLhLYZT/zLpsjchCS/+WnFBXEAZD3EQNsiSgHRrg6QU5lUhXfnlM198pXaZx/huSRpTKCsCzXInLfixzCE/D0RR1cC3BCiMxoRqOI5cE3oN7HzXbiM6HPNG3FjXT6siRQ/Jv/eSqNRaCSmBVaL3OzOIerHXJoKh2FSSAnfMIADPz6lHPp26Dz4vKrGE5Z4Rejr75eIY9e6KX3uHnzJFCjr82i/74LADyjs1ckcjE/xpXHGaPUloTe4pUKBPUeOH2slbFTZxSG93L9n8EqFj/SQQSJif+ElGkaXQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qp9EOiY1w+VKf/IO9gHThKFauztz3H/ct8vopuxXUAU=;
 b=K3tpoWwhC+yPE6fN6wNGbDTWvVadPFtpCWelpOAzIia/qBXbbrv3JnXQZGS6HPJV0ww477MsIr4Ef0z00gp7FtuAFz1A55qatdJ7lt96BxxqJuclzQIPhl/UGN6jvP4goEzhBZ0UGkhJbqHJM7KZ8bjl4al14yJowUpumjPicE1QaKeW6jEu3IrRLBbz+f/hIvh7DBX3cY6vxY+WZD9QANXSmpeVgUhWhlFYHuSBlv8Q/YaD1NBnPv2NrKCmiH1OYlwJnhJzGs09IgXC4RmkpQXur563wlzngJCDVZRsM5FLTAbxsP74yM5sHiotLXaUR/KbXWIbp/dtXWG6RIZECg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qp9EOiY1w+VKf/IO9gHThKFauztz3H/ct8vopuxXUAU=;
 b=Ks1eG/YwCqluoSw11WCdW+3fMFqBjJCrvg3W1Kj5SJrl8wj/CM9Vk2aAghZdgJvzZ80ggKq2QmcBNHkIS7HmxtofhsFFNi6q4ckHUqsJla7iQ6IM1FYo+dodtvA4Y+h9v4Jib74qjkDYHINxiBAbIHVflE/Z3IjP9JZ9ExKdiGCHS4Gli7+TxC7aHkmRLlkSXJxWTwuZ568964irbRsVRKPZF9Z1gYtUjWjzwXmqwLWjrHJ72ZbOXjKqzcs8fGj+wd3xv8G19fASf428g2ISdCl74IT0n1RpLDEoWpwOVYjPCx4bWw54ihfsLTHLjeDQXkPcY0S+64qstwWV06r9pA==
Received: from DS7PR03CA0011.namprd03.prod.outlook.com (2603:10b6:5:3b8::16)
 by SA0PR12MB7090.namprd12.prod.outlook.com (2603:10b6:806:2d5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 11:12:37 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b8:cafe::bc) by DS7PR03CA0011.outlook.office365.com
 (2603:10b6:5:3b8::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21 via Frontend
 Transport; Wed, 21 Jun 2023 11:12:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.38 via Frontend Transport; Wed, 21 Jun 2023 11:12:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 21 Jun 2023
 04:12:26 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 21 Jun
 2023 04:12:25 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Wed, 21 Jun
 2023 04:12:21 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Juan Quintela
 <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Yishai Hadas
 <yishaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb
 <maorg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>, Kirti Wankhede
 <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>, Joao Martins
 <joao.m.martins@oracle.com>
Subject: [PATCH v6 4/8] tests: Add migration switchover ack capability test
Date: Wed, 21 Jun 2023 14:11:57 +0300
Message-ID: <20230621111201.29729-5-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230621111201.29729-1-avihaih@nvidia.com>
References: <20230621111201.29729-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT054:EE_|SA0PR12MB7090:EE_
X-MS-Office365-Filtering-Correlation-Id: b1db685e-31dd-4b43-c77b-08db72486b76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yz7XNBHfO9kBYBF3w18rL4yJMWS38yMruak7bQSScncG4KmL1StBBWpKJ2SehtjZ3uNzGUkVWW++B1t8BPPJH9KRUZ1F41cuE7s2f3vLPVb9zh9O9dLfDuNKQCJIOT/VpKoMQxdkHo9UXo3D6sW3PNPoo6NX9UbNbIMpgmJt3cqK/cqs4loH+SXH02CK0aOsYEs3L7TP8iI88yT2Rk6SIHyXuZGpR5ogsiWSl/dB1Is7hm8HPH1hcg3jTmv/X5+CDSJYY/XWz74kgS2wM0yAvq/IRbjKLYznr82q07wOPCAael5SBQu1GTFYOKgXl8/rDiGMph3T3y2r9RIdmcfgK6b1dP3Yh0O0JyTBf2uMHdqmNtyoOhe2l2VWtBFnDfdw/z8lTyl3Oci8yJx8EPQeXDPZPvZY4mBZQel8V1Hfw2dTOunsu5d7xxoHp4CpwRJZRRv8s+0i2qNxNh1976zIm053Y1LDxFbWa8qW5OMMm7AIGziEhMtVX8gB4sPmBbybHuba4jRRfVUPWafjxSqDBp+90IzTuoYhWYp747QWj4LK4eJpqr8gossnBhjdgtDRTrvoCKZV4pw3iKp0McRXH1HZFjQluXSLxsQ/BIEVwSMJSXuVakgSyqaeJlLT7afK5ni8egzbhpRFe8sXzW7duMtOx3M4THqPcuGb5lSfHibZ4RjSawBdgFnCsDZpuf/wb0BdF5KQGVOpeOp+WghfxYjrX9gMKd0siPXdEyxVIEfATjgDDP+25RKf90Ikw+Z2
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(83380400001)(426003)(336012)(2906002)(186003)(47076005)(36860700001)(6916009)(70586007)(6666004)(54906003)(4326008)(316002)(7696005)(70206006)(26005)(7416002)(5660300002)(478600001)(1076003)(8936002)(41300700001)(8676002)(2616005)(40480700001)(356005)(7636003)(82740400003)(36756003)(86362001)(82310400005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 11:12:36.7809 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1db685e-31dd-4b43-c77b-08db72486b76
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7090
Received-SPF: softfail client-ip=2a01:111:f400:7eaa::62c;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
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
Tested-by: YangHang Liu <yanghliu@redhat.com>
---
 tests/qtest/migration-test.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index b0c355bbd9..b9cc194100 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1693,6 +1693,33 @@ static void test_precopy_tcp_plain(void)
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
+        /*
+         * Source VM must be running in order to consider the switchover ACK
+         * when deciding to do switchover or not.
+         */
+        .live = true,
+    };
+
+    test_precopy_common(&args);
+}
+
 #ifdef CONFIG_GNUTLS
 static void test_precopy_tcp_tls_psk_match(void)
 {
@@ -2737,6 +2764,10 @@ int main(int argc, char **argv)
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


