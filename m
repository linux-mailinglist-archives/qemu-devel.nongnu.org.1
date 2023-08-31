Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B79478EDE9
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 15:00:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbhGV-0003l5-Qw; Thu, 31 Aug 2023 08:59:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qbhEp-0002he-BV
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 08:57:31 -0400
Received: from mail-dm6nam04on20608.outbound.protection.outlook.com
 ([2a01:111:f400:7e8b::608]
 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qbhEj-0005DJ-Kq
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 08:57:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JIZhyGAJtb4N6rUlOyBEHuXB4F1fpJ4euAqIKe+ut8GZ5+tlr+R2qyDikD2pvJmBlhjRnFz/ua+BF5tiFgpasAcab/paDdAygjCUzzdgkYt+GYmrSbnGnWFbGLcJeW4TZ4GNYDbSBSfjtq//XZ2NR3PT0N7zrgfx1saKHStUdjlhcATM5G2HhcJTeh2ZUIA9YfIR/7C5TCb8wQc44DKKw/Z9AzEa/oRV5W/Lvo9voT6GHZrM2uo5xD+xQeQNJxllru697IavOah0+ZrzHjb7b5JK+XGpPcNVP9GDBYWb7HCzf7GTsE4EPJCf5EZbkMe87w29GqXzk081FRESyuCivQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvyyngd7FfVNeRyt7xrSL/FW17XxSoEYV8VAx5jok/Q=;
 b=KtmFtbUZOFDNz49dlqUcCjn4p47WvFLN5EI4PfGa5a+b4SIWn8IFK6gJmXTK8qvzh2s29+G+1UGi1i+qoD/YZSUFvjCVTsBnUiz3AGwRPq+gaPT9kg3gJLIJY4oa9BWGTAhAMyb56MRqbEw3mWqrwy71Mib6QYjyij/yYZoO1/TvJRJV6OC22sw5Tw2K/ngCFujgnhXuFv50zjyZMQAqfaUkfZ013R0s51mSQbCl6HvJohWceOGLquic3w/rIsHkcEL2nMLQi9/87dUM1j9Ia6HbOriY4GTkRuTdZQmgp+iEEOeTGv1lk9LBMX5SLnm2bApSTyaKDSxKt6V93WNRjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvyyngd7FfVNeRyt7xrSL/FW17XxSoEYV8VAx5jok/Q=;
 b=nGXKOIBGnuoh67ASDZcN/UxqDymHtBN+PIObF2k/+gXhj1t7pdkSSiWVFbgUKmK3QJ6/PGZHDPcmN4EqytnQDsJse7J+DpLZpgPkqbl+GINam6dGMm6qTwtxQaGkBvrMkKzsB0GKlWPKJ0Pg8QUTz36hYZ6nhQEHKLwwIxfkdzXTpzkSTS1jm/wK7QtQ//ReKaCpbdUf0cw+EhYyuUPgAN71cSt2AVhOUKuEy+26onK6z2W14hF0qTIsXV3Thei7bz1gZI2Q5nfiblj+V/+Om00L8JPe2+WgqiQt/SsgcXiOvNp/oT+ilYcIfA2TcMowrDuqFvjFy9XyV+Kmpcmikw==
Received: from DM6PR17CA0014.namprd17.prod.outlook.com (2603:10b6:5:1b3::27)
 by DS7PR12MB6168.namprd12.prod.outlook.com (2603:10b6:8:97::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.35; Thu, 31 Aug 2023 12:57:21 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:5:1b3:cafe::f7) by DM6PR17CA0014.outlook.office365.com
 (2603:10b6:5:1b3::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20 via Frontend
 Transport; Thu, 31 Aug 2023 12:57:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.17 via Frontend Transport; Thu, 31 Aug 2023 12:57:21 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 31 Aug 2023
 05:57:08 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 31 Aug
 2023 05:57:07 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Thu, 31 Aug
 2023 05:57:05 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Juan Quintela
 <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, Yanghang Liu <yanghliu@redhat.com>, Avihai Horon
 <avihaih@nvidia.com>
Subject: [PATCH v2 1/5] migration: Add migration prefix to functions in
 target.c
Date: Thu, 31 Aug 2023 15:56:58 +0300
Message-ID: <20230831125702.11263-2-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230831125702.11263-1-avihaih@nvidia.com>
References: <20230831125702.11263-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|DS7PR12MB6168:EE_
X-MS-Office365-Filtering-Correlation-Id: b7d33d7b-38a5-41f1-a14e-08dbaa21d0a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5D+6m9KOWUepL8E3/3Z2BjR8/BsVoav/EF83pSE0RjGV5qpmwdy+WZoRBqXVHstRM2prbju9WpIhlGJCk2penxRSMXMNbsF3qBEbFO9ivfPEKSqCPMrxJ2qdx/lRJwFfuOSou2neiJvLiQN0EdofjRJpzwQNf18m6jrYwCqW6LymBoacOIX4Ihv8zcoMhnFIgFcRUP3RlzIg5W4CpjDNShr9aw+Uy8LZF0Y78MuhUNsyCRjw4cJg8uhAruszVfxUKxC5Hiz6rob0pUzUsIEis9zXD8cVwFYeQKI0Yn9dRQpwRwxk05l6ObeclCF7ppElngOElQEcKn750RU97+nwsVDctlZQVWFJJnrWkgVh+Mq31E3Nvezd8o7EyczyTlB+3PsZHpyG/KYW02souFUN30Ew8/cBImgBmzbwKsuOmvmQWSm6PZqPmoJNabi5VxR7lzmJVtR4xwpvNdi1fxTShTuqIniw+MTyC5J3JCfAhqmTvNp++B6plyauVS3s4oPANll5k0ifs2lQ8kf50Ryckoqh34QcFBP9FLqk0oAjXQYZm0B0Tg3ETUdVdSZ4b8NuZmovtsfhnx5GqEhXBdv7qJAkeOOD+kW2/4RoAhjYFZmwin0DcrHL62me6KVCGvP6sndjClQS1OBzznnxJ00sgNMDREJdPtRvNdZub96+uZV2AWPGAD3WZuMCpV10MjS/qHBeSQh/quP72AgW3hej6wIluhF1KEgC3HmDOFQRu3rPrA4hW/GgH0kIwBF1Qx6N
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199024)(82310400011)(1800799009)(186009)(46966006)(36840700001)(40470700004)(40460700003)(41300700001)(316002)(8676002)(4326008)(426003)(66574015)(336012)(2616005)(2906002)(47076005)(86362001)(107886003)(5660300002)(83380400001)(36756003)(1076003)(26005)(36860700001)(6916009)(40480700001)(8936002)(6666004)(82740400003)(7636003)(356005)(7696005)(54906003)(478600001)(70586007)(70206006);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 12:57:21.2743 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7d33d7b-38a5-41f1-a14e-08dbaa21d0a4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6168
Received-SPF: softfail client-ip=2a01:111:f400:7e8b::608;
 envelope-from=avihaih@nvidia.com;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URG_BIZ=0.573 autolearn=no autolearn_force=no
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
Reviewed-by: Cédric Le Goater <clg@redhat.com>
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


