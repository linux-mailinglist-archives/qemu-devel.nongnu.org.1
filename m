Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 531BC78B443
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 17:20:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qae1Q-0002Mt-Vx; Mon, 28 Aug 2023 11:19:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qae1K-0002C2-Fk
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 11:19:16 -0400
Received: from mail-mw2nam10on20615.outbound.protection.outlook.com
 ([2a01:111:f400:7e89::615]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qae1H-0006vw-If
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 11:19:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ae7EWa8UTLxIy8B/sJVcUDp6WKrqkmxdtcXPNRA7lSHR92ALUh7HRVDNBRGn2jtWcuIwTrDKd5r+/Cu3D/YeyK+McXXaZgMyAilKEe/OhhuBg5vKPGPn9IM1nbpmP9NRhG8IRSOOzM66v+u9G6vDjDBFDiNYD45txbXE+Pq80Izw9nW6c+g729hwcVROO0+xI20cAtZAjFgZGZtXw3PVtPnyd1zps5Bq3paUJC4ls/tA5zSag3ukJ3FYu1zGk2kTnfDTdAGKFFojJpcUmZIUTIWkHkyOi3iCcmDdchUuDTzEXirXgH5a2TPJT1S7e4dtj1tjaS7XKA5Q+g9RD7VVsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iYG6rTlMxRTsyWmZW/8xtKd76dgZyAeYF8kh0nulYzQ=;
 b=TkuxLwmkWnUNFpz38EEKf0i8CpIKw7hhSvjxUVz5wVwibJZxlQEgcZLSkybWwkz/DCqkza0Dz4IT38NBxTL65QxhWA5c5Moqp3EJyfoxzmjchu7QwV5FgwixORndrgJnFmGoO4PLfxq63yRJbMptmEapGAoYYvE87Zvkhdc7LQQSw0IrjPpkCVa/uA7Fa6bqsAnJc30j9sY+LkG+kUr0h7XIvFz2u1E3/I2fe4ST0kBDCC3RsIo+SZUDXQZYSM822718Jwis52kFAsKNiB+RPaAJeh4ckNZaYX/C+Sgq40m7li+2x3516MjIsQGfTCZAJokitC122dtJg/8LCkjMgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iYG6rTlMxRTsyWmZW/8xtKd76dgZyAeYF8kh0nulYzQ=;
 b=mBRZqn+DW2nK/x/zVI8xRBc+nJcgg1oJ1pzgFA+s6OesvYtPHxOJFxy99FX590i1GxXiNoI/sXcMQOTtYtecPiWrcAHiFubxczL2xoD40Ah9vM3D/6kFaEy3l+fKS29hCZuinihERpRX6uns3ZlH67IreoUrf0FF0GMkXopR7Gqbak/s2/+mT653NtT6vr25a02rB0xrWs4CxVEOvRUch7Ji2cvmz9HXWBxlFWD0Nn+1kffb05vEkZ/uwqjBNjw+a2lD1RBqf1bsEh2KwWitBSEusOFDgUviVo3qCaAB7VlmkQdkP/KJ7PMzyoPLn54GKJ5AzTPtXkbkc614DGhjHQ==
Received: from DM5PR07CA0074.namprd07.prod.outlook.com (2603:10b6:4:ad::39) by
 SJ1PR12MB6051.namprd12.prod.outlook.com (2603:10b6:a03:48a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 15:19:07 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:4:ad:cafe::9c) by DM5PR07CA0074.outlook.office365.com
 (2603:10b6:4:ad::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35 via Frontend
 Transport; Mon, 28 Aug 2023 15:19:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.17 via Frontend Transport; Mon, 28 Aug 2023 15:19:06 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 28 Aug 2023
 08:19:00 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 28 Aug 2023 08:19:00 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport;
 Mon, 28 Aug 2023 08:18:58 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Juan Quintela
 <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, Yanghang Liu <yanghliu@redhat.com>, Avihai Horon
 <avihaih@nvidia.com>
Subject: [PATCH 6/6] vfio/migration: Block VFIO migration with background
 snapshot
Date: Mon, 28 Aug 2023 18:18:42 +0300
Message-ID: <20230828151842.11303-7-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230828151842.11303-1-avihaih@nvidia.com>
References: <20230828151842.11303-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|SJ1PR12MB6051:EE_
X-MS-Office365-Filtering-Correlation-Id: 18aabe2d-11b7-44eb-b70d-08dba7da1f2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yS3tu09VvA3A1tJnsovhGfJnVYTtyTdX3p5y4LC23ePq0r4+0xlpF4sjG5BpmOukIsVjUXmrcDjMd0kNLovxJWazCbP/Rg1yoe1vUVV783dIw/ahaqxIf/8w5RdStjxP3vzs7nZ8RyqBcXRSS685A3i5BuH5kgK9vNobE49PAG89UOrK37mxeA8AdleWWwU+bULoLGyZyKrH8weMkh0pCpNucj+4d2D4mKC/sJVqKJZRJ3+AWyEV108kAjev8ast2pS6W8FAuLClXOWnNZdcpVxn/UIxWQx5o7qAdHE+xExsyuTzwfKqrZ9HxyTU96xrY9jwDpB7gUUVwQhuXifoa6tbPAVJRmyQekOR/hU4vYY7SLiMZXzinzjosku0eO0FnCEfM0hZvJDVWeGqL4uE3yR1thNPptPSjuGSXTfXXjY7ysFO9vUfRqhQAB8pSA9LEA7Z+pxUjwQ7in2X3INYqu7hgA5YvU/NdTuoOwSV2NavSv0Fm+PVZuKGEp9dz0M9nZbEK1SKpTebLaeOGIs9JWS+k+6ZEzsX6LU6mjaLB2o02q4cD2Kuf3Q6ckT25MWH9jucEj6rwI0jbOijx1ZzRtOBN3jLH0XLnaakk0ePuoW0VkpL+80tWtzoRJhh7LuldhPU/U+UindOk1Ow24cqZBxlWSgnchtMz1WDFXxt+lDcAsTZafRki7EgWloGlShoM2v2h6HpGzl63NFvM9Jgiv4Bs9U5/k4ISrhX6ezu+E26tQ0defFYvDRQPR3rWrGU
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(136003)(39860400002)(376002)(451199024)(1800799009)(82310400011)(186009)(36840700001)(46966006)(40470700004)(83380400001)(478600001)(7636003)(356005)(82740400003)(26005)(426003)(336012)(47076005)(36860700001)(107886003)(1076003)(2616005)(40480700001)(7696005)(6666004)(86362001)(2906002)(316002)(4326008)(6916009)(70206006)(8676002)(70586007)(41300700001)(8936002)(54906003)(36756003)(5660300002)(40460700003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 15:19:06.9984 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18aabe2d-11b7-44eb-b70d-08dba7da1f2e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6051
Received-SPF: softfail client-ip=2a01:111:f400:7e89::615;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
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

Background snapshot allows creating a snapshot of the VM while it's
running and keeping it small by not including dirty RAM pages.

The way it works is by first stopping the VM, saving the non-iterable
devices' state and then starting the VM and saving the RAM while write
protecting it with UFFD. The resulting snapshot represents the VM state
at snapshot start.

VFIO migration is not compatible with background snapshot.
First of all, VFIO device state is not even saved in background snapshot
because only non-iterable device state is saved. But even if it was
saved, after starting the VM, a VFIO device could dirty pages without it
being detected by UFFD write protection. This would corrupt the
snapshot, as the RAM in it would not represent the RAM at snapshot
start.

To prevent this and to be explicit about supported features, block VFIO
migration with background snapshot: Fail setting background snapshot
capability if a VFIO device is present, and add a migration blocker if a
VFIO device is added when background snapshot capability is on.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 include/hw/vfio/vfio-common.h |  2 ++
 migration/migration.h         |  1 +
 hw/vfio/common.c              | 42 +++++++++++++++++++++++++++++++++++
 hw/vfio/migration.c           |  6 +++++
 migration/options.c           |  7 ++++++
 migration/target.c            |  9 ++++++++
 6 files changed, 67 insertions(+)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index c0b58f2bb7..bb94f320f1 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -229,6 +229,8 @@ int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp);
 void vfio_unblock_multiple_devices_migration(void);
 int vfio_block_postcopy_migration(VFIODevice *vbasedev, Error **errp);
 void vfio_unblock_postcopy_migration(void);
+int vfio_block_background_snapshot(VFIODevice *vbasedev, Error **errp);
+void vfio_unblock_background_snapshot(void);
 bool vfio_viommu_preset(VFIODevice *vbasedev);
 int64_t vfio_mig_bytes_transferred(void);
 void vfio_reset_bytes_transferred(void);
diff --git a/migration/migration.h b/migration/migration.h
index 21a6423408..3077ed430b 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -516,6 +516,7 @@ void migration_populate_vfio_info(MigrationInfo *info);
 void migration_reset_vfio_bytes_transferred(void);
 bool migration_vfio_mig_active(void);
 void migration_vfio_unblock_postcopy_migration(void);
+void migration_vfio_unblock_background_snapshot(void);
 void postcopy_temp_page_reset(PostcopyTmpPage *tmp_page);
 
 #endif
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 7461194b2b..4f6bc40cc0 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -345,6 +345,7 @@ static int vfio_get_dirty_bitmap(VFIOContainer *container, uint64_t iova,
 
 static Error *multiple_devices_migration_blocker;
 static Error *postcopy_migration_blocker;
+static Error *background_snapshot_blocker;
 
 static unsigned int vfio_migratable_devices_num(void)
 {
@@ -470,6 +471,47 @@ void vfio_unblock_postcopy_migration(void)
     postcopy_migration_blocker = NULL;
 }
 
+int vfio_block_background_snapshot(VFIODevice *vbasedev, Error **errp)
+{
+    int ret;
+
+    if (!migrate_background_snapshot()) {
+        return 0;
+    }
+
+    if (vbasedev->enable_migration == ON_OFF_AUTO_ON) {
+        error_setg(errp,
+                   "VFIO migration is not compatible with background snapshot");
+        return -EINVAL;
+    }
+
+    if (background_snapshot_blocker) {
+        return 0;
+    }
+
+    error_setg(&background_snapshot_blocker,
+               "VFIO migration is not compatible with background snapshot");
+    ret = migrate_add_blocker(background_snapshot_blocker, errp);
+    if (ret < 0) {
+        error_free(background_snapshot_blocker);
+        background_snapshot_blocker = NULL;
+    }
+
+    return ret;
+}
+
+void vfio_unblock_background_snapshot(void)
+{
+    if (!background_snapshot_blocker ||
+        (vfio_migratable_devices_num() && migrate_background_snapshot())) {
+        return;
+    }
+
+    migrate_del_blocker(background_snapshot_blocker);
+    error_free(background_snapshot_blocker);
+    background_snapshot_blocker = NULL;
+}
+
 bool vfio_mig_active(void)
 {
     return vfio_migratable_devices_num();
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 76406e9ae9..adf98ac8e3 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -857,6 +857,7 @@ static void vfio_migration_deinit(VFIODevice *vbasedev)
     vfio_migration_free(vbasedev);
     vfio_unblock_multiple_devices_migration();
     vfio_unblock_postcopy_migration();
+    vfio_unblock_background_snapshot();
 }
 
 static int vfio_block_migration(VFIODevice *vbasedev, Error *err, Error **errp)
@@ -945,6 +946,11 @@ bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
         goto out_deinit;
     }
 
+    ret = vfio_block_background_snapshot(vbasedev, errp);
+    if (ret) {
+        goto out_deinit;
+    }
+
     if (vfio_viommu_preset(vbasedev)) {
         error_setg(&err, "%s: Migration is currently not supported "
                    "with vIOMMU enabled", vbasedev->name);
diff --git a/migration/options.c b/migration/options.c
index e201053563..2e13363de6 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -537,6 +537,12 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
                 return false;
             }
         }
+
+        if (migration_vfio_mig_active()) {
+            error_setg(errp, "Background-snapshot is not compatible with VFIO "
+                             "migration");
+            return false;
+        }
     }
 
 #ifdef CONFIG_LINUX
@@ -625,6 +631,7 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
 static void migration_caps_remove_blockers(void)
 {
     migration_vfio_unblock_postcopy_migration();
+    migration_vfio_unblock_background_snapshot();
 }
 
 bool migrate_cap_set(int cap, bool value, Error **errp)
diff --git a/migration/target.c b/migration/target.c
index 690ecb4dd5..c2be0b39db 100644
--- a/migration/target.c
+++ b/migration/target.c
@@ -37,6 +37,11 @@ void migration_vfio_unblock_postcopy_migration(void)
 {
     vfio_unblock_postcopy_migration();
 }
+
+void migration_vfio_unblock_background_snapshot(void)
+{
+    vfio_unblock_background_snapshot();
+}
 #else
 void migration_populate_vfio_info(MigrationInfo *info)
 {
@@ -54,4 +59,8 @@ bool migration_vfio_mig_active(void)
 void migration_vfio_unblock_postcopy_migration()
 {
 }
+
+void migration_vfio_unblock_background_snapshot(void)
+{
+}
 #endif
-- 
2.26.3


