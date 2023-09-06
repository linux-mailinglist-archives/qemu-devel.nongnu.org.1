Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D1B793FFF
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 17:11:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdu9h-0004Mg-Qg; Wed, 06 Sep 2023 11:09:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qdu9e-0004M9-T7
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 11:09:19 -0400
Received: from mail-bn8nam04on20600.outbound.protection.outlook.com
 ([2a01:111:f400:7e8d::600]
 helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qdu9a-0003i4-N9
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 11:09:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=goGciLAie1yMSEyZTR5kVFLH4tFZRFoeP7blO8I0pwkvMVaTaFsLZfBUMRLYH8PTvy0GWYizMdCteC99mivnpg5+cSW98S05ykenuCYIcmRtENtFrNvmGdHfVNO0zPpe9eDxpHvghKGYkWVTq9I9kljGdoj1kk8KwCBflRCMmJ4fYdvF3iL33LdM4GIB9j3p8uW/lnz57N0lCbZmotJcOyD58eNecHuLuSA59+zTV3FE4B+7pp8oD5VJ3vGrtlBbyQSKxeW2SkXMmDXIEu7T5VdVLpLs5YY4o1QO/Got30uigbY+LiiOx7doeUtZMqN4TzdDIIGLFFtMaiDbN9o29Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvyyngd7FfVNeRyt7xrSL/FW17XxSoEYV8VAx5jok/Q=;
 b=jdqmkn9XZFHpVnUMdPHKelt2H33/S0DKOlZz9sNy4D+LMYRdT3NK/kgxi0s8kcvlJO2KDD2jSZ1al/iafzmyx0gPHmumosy0jCZ6yCwOPFHj39i59VZdv/29lcOIiO2PPWMDyMyMYmUy4WLZEoGE4C+Ag2jGaRKfR+bX2+X/YDU9olojc7cyDIO4iLXfa7nTe9YGHN75rdjg3VZxeWf47WaQKpAMpU4kaADGKMQJR/KFc+RDbJVGi6GB0FGKYMBruIKe1wx4WHmW/ULZVcZQ5WA6iRTrwvBzFd420usb/TzbLofOsYWAHLU8FhT/77gSak1PeE9SERyzCbkS+Pat/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvyyngd7FfVNeRyt7xrSL/FW17XxSoEYV8VAx5jok/Q=;
 b=Zdulr8szc+vYtYBhC+hb2GHmNetzyZlewT75GeDewerpnao/A0utIkIRYMz6Wi4h9ocBPMkYTp52fz9t5a8rTfDWJUpghWh8DJSOLEPZ09EIwJEwN3lm4jClgyUjTagRjjk2q+5WIBb9/Oq4DJF3mXYW1y48Izr8Q8WElFDKy5y2f8qjDT/RI0ZBTajZ+GnFHP9ZBP5vpgy/xDS/VUjQ4ERMbZFP/7ch8tsGOR770fzxbDTur++GWxWX01i19CRHp2r4EvS2Lozup7BacKHvZgWfuuTbRVb5ugl3xRgf7NzjOGKwSlTV8lThuBVqHZKtKxkMwxiY1NzxfmPDagtgsw==
Received: from DS7PR05CA0078.namprd05.prod.outlook.com (2603:10b6:8:57::24) by
 CH3PR12MB9343.namprd12.prod.outlook.com (2603:10b6:610:1c0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 15:09:10 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:8:57:cafe::ce) by DS7PR05CA0078.outlook.office365.com
 (2603:10b6:8:57::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.27 via Frontend
 Transport; Wed, 6 Sep 2023 15:09:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.25 via Frontend Transport; Wed, 6 Sep 2023 15:09:10 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 6 Sep 2023
 08:08:59 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 6 Sep 2023
 08:08:59 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Wed, 6 Sep
 2023 08:08:56 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Juan Quintela
 <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, Yanghang Liu <yanghliu@redhat.com>, Avihai Horon
 <avihaih@nvidia.com>
Subject: [PATCH v3 1/6] migration: Add migration prefix to functions in
 target.c
Date: Wed, 6 Sep 2023 18:08:48 +0300
Message-ID: <20230906150853.22176-2-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230906150853.22176-1-avihaih@nvidia.com>
References: <20230906150853.22176-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|CH3PR12MB9343:EE_
X-MS-Office365-Filtering-Correlation-Id: f7cf38b6-3a32-4e19-8b83-08dbaeeb3960
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FPGy6qX/QkprXn2QP/2gHPM96diX0IWG5GPpmEgWfVYZ1FIXNKQzhfxzcf8WdR2ljyce45jxLuoZUM7cKVblwzb+ZFLgb9DNyTPYK8BZosomCrU6oZJZuW1tZq6sZ6A4sph+f091k1s9mU699sZKbCQr7RYGsixJz0lQMoc2Yno9Hw5vq8aOmYQEbM0N+Rca8efxS9lBYlb60VneophcjLL/IXAG2x4ABYXkTArpAUNaLYQ9D3X9X/MG1xRp17gqdaL0ExEsDJZ/X786+2iEB6XGExdQkRSTYodJlVLVvRAYxDZci2oK3gSnkr96nhJiR5kyH81gRhdsdCWdrKVp9G0bV61Ncq5mVcIOlfLVZzWtwzw6JrCN+a5dMiMou3J+pFJZobwtWcc6+O3lDS3BOYaLBsVdQxTWN7WvERbKga0uBnlxnVsLVMySsJ3e1ygGFY0zKswVHosAbWRZJjgM3KtvnzKqpsrtnZD83WitUq4E1QN/XPKqh5RYSASpmfKmT8/4aIdtlnjNf+AP0EvY2IwciuRyN9R1qHmqbjHavLQQ+wY+59bzPvWBTCDLfr+sLBejWg3fZxYigLplBAoeXYHLyS8xY8ucC+h/xhKD6HQlmmq3sFGT10HTuYngxSdY+XxVohw0Fbvp7yNIlzJlOpU6TbdSs6zj4MbNvGYrJ98txk+nqEFYgyHWnHZJSnP5L7IVyBmVmrpwdK919Xi0cDcAWWc3ByKJ+yaYIDBiWRlv5YQcwMWJKwUCA3akds5y
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(396003)(136003)(346002)(451199024)(82310400011)(1800799009)(186009)(36840700001)(46966006)(40470700004)(70206006)(6916009)(316002)(107886003)(2616005)(1076003)(54906003)(8936002)(8676002)(4326008)(82740400003)(40480700001)(356005)(7636003)(7696005)(41300700001)(70586007)(336012)(426003)(26005)(83380400001)(5660300002)(6666004)(478600001)(66574015)(2906002)(47076005)(36860700001)(40460700003)(86362001)(36756003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 15:09:10.4514 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7cf38b6-3a32-4e19-8b83-08dbaeeb3960
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9343
Received-SPF: softfail client-ip=2a01:111:f400:7e8d::600;
 envelope-from=avihaih@nvidia.com;
 helo=NAM04-BN8-obe.outbound.protection.outlook.com
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


