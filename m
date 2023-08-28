Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E2978B45B
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 17:24:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qae69-0007Id-Mw; Mon, 28 Aug 2023 11:24:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qae60-0007H0-8E
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 11:24:04 -0400
Received: from mail-dm6nam12on2077.outbound.protection.outlook.com
 ([40.107.243.77] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qae5w-0007rp-Ho
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 11:24:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g3B7hmjuPeR/zbbodQ8wogQb/WBNd7iYzuWg/QkvOZhiVZYXVLi1GAokK6gOI3yRtbepWWWS1e2UlMxbbNYVYIEWAanaWmKCSFxxQUIHz3IKniwdw5auaFe9gYVRmWgmYTcz7iiqq/l2bhZW7G8O/V+h+5O92Sh9QilGaYRZMeUsEPt6l/NtnH++BpN5QLltdL5MO900ioUEBE1GtwgcgUv3hx4fUXb4aLXu15UOda5S1Tra/LwjK57vaMazxK/39yoB1E2FT9w0OCahHJx6d8xDKq6S4byLTsx5KfauhMmrzYpCDikDIKJK0DmSMBhu1p8Klle0gLvkYjVNDNOBDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3HcdPQkHk1jWmoUgP28yTld8g7ZvkZY6IvCwyw/irso=;
 b=LssD9zuWROZEvV9SW/ZxjRCC6qCVroD9IMeYUA8hCT50hbUAUsFz194S25E2cv7hFfL/FEk7u7XjfgP7Iz4nThQlgKFnuWy5uJVp2ZvFGiK2Ukx61avUFzusy/FcsPioNJXWjVOuG7Yt/FCjKuC/YCUeH9dw5Xv7RCVVBtFheJwB/3ZQfxvzfNy2d6e53pRAXx9B32XgVxHdP1SPqYs7Ekwl/Pnp5RF+o0Gxrj4nhF8EMHW1nmIgYCDvwg+PwFUFZZOu+SU3RDCZ1O27syadL3G8tXjEIDUkn/NlueqfRU1/GYsu6MdYl68NdDB3WEMVbiFcFa/3HK+PJPcA12YphA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3HcdPQkHk1jWmoUgP28yTld8g7ZvkZY6IvCwyw/irso=;
 b=CuA2lEttUcQ8Td9XfZIl3ezjgFJMwJFdxJ8ztqi8e9UcZjkNqFdcN+KjAxFNnvcUy0748CUOjlFxfzFcF5C2qF012Pcc6ud7ehYW+JJ6qsu5+gOHFpt+eQpNFLWUvJfU0DkeyqvcOgVN4YeE0DVTLftV36xCbnpas3oIqio+4HNL8vTWvFDudCf5KSb1jdOjg3Pi/6wW4Ov8rqE6q5P62QOlnJ1CdLOSMqwzNb4/fuw/lhak6L3GvHKatjknaHxmzzrzoBruSo1nrUi2kgwzZxN0DuHFhhroVzsv4oK6vbr44ZcnSa475LB8/WnDVJ5sKdXu22bbl6QZdjRjZ04D/w==
Received: from DS7PR06CA0021.namprd06.prod.outlook.com (2603:10b6:8:2a::23) by
 SJ2PR12MB9211.namprd12.prod.outlook.com (2603:10b6:a03:55e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 15:18:56 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:8:2a:cafe::5d) by DS7PR06CA0021.outlook.office365.com
 (2603:10b6:8:2a::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35 via Frontend
 Transport; Mon, 28 Aug 2023 15:18:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.16 via Frontend Transport; Mon, 28 Aug 2023 15:18:55 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 28 Aug 2023
 08:18:48 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 28 Aug 2023 08:18:47 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport;
 Mon, 28 Aug 2023 08:18:45 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Juan Quintela
 <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, Yanghang Liu <yanghliu@redhat.com>, Avihai Horon
 <avihaih@nvidia.com>
Subject: [PATCH 1/6] migration: Add migration prefix to functions in target.c
Date: Mon, 28 Aug 2023 18:18:37 +0300
Message-ID: <20230828151842.11303-2-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230828151842.11303-1-avihaih@nvidia.com>
References: <20230828151842.11303-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|SJ2PR12MB9211:EE_
X-MS-Office365-Filtering-Correlation-Id: efb84bc1-c231-4683-75d6-08dba7da1880
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2WVGeWWWg62djozyLSGVgObUGoXt2aYVLCbgJ3UHMBBFLyUZgbMDQtSyNvyRp0cgxvEesYuOB2nCG8W34Fmeva+IF2gY9DbbjKyhkBlEs8H9Nqx2itU3Q3p7e4wdC7tUM5/dEbcZPRLf0nGc5mqqZguxgFYEexwFUuWSt4cidNdIHT+9FG+8wWCWy9JRLKz8fkJgEuKEsdijn0LQGK6fZ5UQIDvvYc8/xYH2hcj/Vy/9vwh/s/hJZ+zvpjXP87RyrBv9ubP0illbWKDQEXc4FNG3dN0im/xNgNGhniAFoNrK6PzlcqaXKjNCJTxi7KKTJI6Bfw1SSdzAyPIeX/npxMlonfsAmQ++5YtSMuHMIHjoJeyl5bk2ab+wcQMt8tx5zesPlugzuwJrynSgekosyY9oVTkHssiZZjJ7hDK5nbazpe3xKh1T7K4RuzsKmMEM60Pl50iDOatK9bLfT99ThYU2+Ya9Bw4L1YYJ+olkeAgUWmtoKbDbXAcSUzox7OZ2uBgsOIXkbpx9TpE4VxBWYhJ1Qj6xoe3/e2Lzg4uZ3r4ZgWN8R1f7jrLMbU4cB+5IsdA/EQY5+lhcmzFsT29ooMZW4krvo8d1ZPgtQe4rn9F3Mb5bxp5qxxuayBSr6eglV0rkY+bLQr3pFNN/1pBhOD6PRxO2kGdGsu8IiuZHFgCkw+Bk1uPNE2kmrb+33shzfqGYgE7K+LRaXGhUpXUNcRNu6kNCJ1S6M22VJvmM5c9yjfVz1V3Wi9CyF8tYmk57
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(186009)(1800799009)(82310400011)(451199024)(36840700001)(46966006)(40470700004)(36860700001)(40460700003)(41300700001)(356005)(7636003)(82740400003)(6666004)(86362001)(83380400001)(478600001)(47076005)(2616005)(426003)(26005)(336012)(107886003)(1076003)(7696005)(40480700001)(70206006)(70586007)(36756003)(54906003)(6916009)(2906002)(316002)(5660300002)(8676002)(8936002)(4326008);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 15:18:55.7900 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efb84bc1-c231-4683-75d6-08dba7da1880
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9211
Received-SPF: softfail client-ip=40.107.243.77;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, URG_BIZ=0.573 autolearn=no autolearn_force=no
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

The functions in target.c are not static, yet they don't have a proper
migration prefix. Add such prefix.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 migration/migration.h | 4 ++--
 migration/migration.c | 6 +++---
 migration/savevm.c    | 2 +-
 migration/target.c    | 8 ++++----
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index 6eea18db36..c5695de214 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -512,8 +512,8 @@ void migration_consume_urgent_request(void);
 bool migration_rate_limit(void);
 void migration_cancel(const Error *error);
 
-void populate_vfio_info(MigrationInfo *info);
-void reset_vfio_bytes_transferred(void);
+void migration_populate_vfio_info(MigrationInfo *info);
+void migration_reset_vfio_bytes_transferred(void);
 void postcopy_temp_page_reset(PostcopyTmpPage *tmp_page);
 
 #endif
diff --git a/migration/migration.c b/migration/migration.c
index 5528acb65e..92866a8f49 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1039,7 +1039,7 @@ static void fill_source_migration_info(MigrationInfo *info)
         populate_time_info(info, s);
         populate_ram_info(info, s);
         populate_disk_info(info);
-        populate_vfio_info(info);
+        migration_populate_vfio_info(info);
         break;
     case MIGRATION_STATUS_COLO:
         info->has_status = true;
@@ -1048,7 +1048,7 @@ static void fill_source_migration_info(MigrationInfo *info)
     case MIGRATION_STATUS_COMPLETED:
         populate_time_info(info, s);
         populate_ram_info(info, s);
-        populate_vfio_info(info);
+        migration_populate_vfio_info(info);
         break;
     case MIGRATION_STATUS_FAILED:
         info->has_status = true;
@@ -1641,7 +1641,7 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
      */
     memset(&mig_stats, 0, sizeof(mig_stats));
     memset(&compression_counters, 0, sizeof(compression_counters));
-    reset_vfio_bytes_transferred();
+    migration_reset_vfio_bytes_transferred();
 
     return true;
 }
diff --git a/migration/savevm.c b/migration/savevm.c
index a2cb8855e2..5bf8b59a7d 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1622,7 +1622,7 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
     migrate_init(ms);
     memset(&mig_stats, 0, sizeof(mig_stats));
     memset(&compression_counters, 0, sizeof(compression_counters));
-    reset_vfio_bytes_transferred();
+    migration_reset_vfio_bytes_transferred();
     ms->to_dst_file = f;
 
     qemu_mutex_unlock_iothread();
diff --git a/migration/target.c b/migration/target.c
index f39c9a8d88..a6ffa9a5ce 100644
--- a/migration/target.c
+++ b/migration/target.c
@@ -15,7 +15,7 @@
 #endif
 
 #ifdef CONFIG_VFIO
-void populate_vfio_info(MigrationInfo *info)
+void migration_populate_vfio_info(MigrationInfo *info)
 {
     if (vfio_mig_active()) {
         info->vfio = g_malloc0(sizeof(*info->vfio));
@@ -23,16 +23,16 @@ void populate_vfio_info(MigrationInfo *info)
     }
 }
 
-void reset_vfio_bytes_transferred(void)
+void migration_reset_vfio_bytes_transferred(void)
 {
     vfio_reset_bytes_transferred();
 }
 #else
-void populate_vfio_info(MigrationInfo *info)
+void migration_populate_vfio_info(MigrationInfo *info)
 {
 }
 
-void reset_vfio_bytes_transferred(void)
+void migration_reset_vfio_bytes_transferred(void)
 {
 }
 #endif
-- 
2.26.3


