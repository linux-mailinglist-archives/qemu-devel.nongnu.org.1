Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6357F78B444
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 17:20:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qae1P-0002Jn-NS; Mon, 28 Aug 2023 11:19:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qae1J-0002Bb-BK
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 11:19:13 -0400
Received: from mail-dm6nam10on20629.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::629]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qae1G-0006vm-JL
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 11:19:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mw1mQ76OC7abUdTbEK7CJ1Qa0zc2RVRTv1BBXOhUWU9pibWnRAUXTBzn42JUm/2k+GZemx2TVCGQVRZnZA4RwVbe0CpknnKSiRoKexQomjBTj+uD4Nq8ZqSLefa9iTFOhZTvteiOlsUvH4RkHrtgqXRdvtaP1MPodfhHw68XTH4x7pKeqD8VWmGbJc9tnM0BnrfZtiJcoEvVYRw/i7LfgZkWZnI+ooFRmJadV5YWPkwuNTTsiMzIeyp89NTUZ2qBJpGIaQFhGCAcgaCy0VyMaGkjUvK5zA+rzeVD1WwafOv0l1/+jdRT5ScVpajhqmege2J70TG2hKRcXVzEwrQbQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AjFATC057FdvyFfLmeCrAsmdDhG+uHoBwHw9POt5f88=;
 b=S1TRPX7NVYln2+h1GHyjmguQF3F3uY9tIX0osVG0aB7ZBYskV+2KpodllqFDuRveVusZ749QNK9BkLhIgIuC/g6ZnSKnxM6fzluCPc//xsZk4ww0e2xtwpZxtcaO1+m1xQ4NlUV29DPhEcYkJWmw+fWYMvgb/97l9UWtZAYOfDa6Yr20YcPen/cnTQO5VG15+b7xe63PFpUff8LbjHnC9RxaxHD5WEojEF21Wc7tNpKVnd51WyhTDKp4gTUBbQY57X9h/6mQHjdWLK1Tg/iu/xuHi6gLzxXS4wbLsUc/MZApq0bdGez5UlFJ32vMX3V8tdpJ+O6HGKymnWjmVjQ1vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjFATC057FdvyFfLmeCrAsmdDhG+uHoBwHw9POt5f88=;
 b=tYm+96TaTBMga1Fi4goIxom7/CSecmjP5rHPT81bNhFw+aS6ZNfP8ReOceGhLObYagc3Vmza8bLgcNsCZ/zfl5IsieigkJxdqRavO2tLgC4x/znpETYoAUmBRGKl8BRGQ88DimNZHWz67V5UfmyMYvZ9ib5s3EkJ8CLu9ag50xeoGAsaueRzj/pYpW7aUZgqLpvIjflnDUgwQFaDPbdUZijMKKTe3YFGqcogCVyI+8IN0vzFZBtkc1H4nq3e9xPW9ig4GfryIkyzfahQUE13gRAzMqaflWqJNf9G4xUFnCyLvnsuiLrv/jxinJiLP/xWPjnOkfKSZYnjQl+P6Uh3Ew==
Received: from MW4PR04CA0280.namprd04.prod.outlook.com (2603:10b6:303:89::15)
 by IA1PR12MB6092.namprd12.prod.outlook.com (2603:10b6:208:3ec::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Mon, 28 Aug
 2023 15:19:07 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:303:89:cafe::79) by MW4PR04CA0280.outlook.office365.com
 (2603:10b6:303:89::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35 via Frontend
 Transport; Mon, 28 Aug 2023 15:19:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.17 via Frontend Transport; Mon, 28 Aug 2023 15:19:06 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 28 Aug 2023
 08:18:58 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 28 Aug 2023 08:18:57 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport;
 Mon, 28 Aug 2023 08:18:56 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Juan Quintela
 <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, Yanghang Liu <yanghliu@redhat.com>, Avihai Horon
 <avihaih@nvidia.com>
Subject: [PATCH 5/6] vfio/migration: Block VFIO migration with postcopy
 migration
Date: Mon, 28 Aug 2023 18:18:41 +0300
Message-ID: <20230828151842.11303-6-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230828151842.11303-1-avihaih@nvidia.com>
References: <20230828151842.11303-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|IA1PR12MB6092:EE_
X-MS-Office365-Filtering-Correlation-Id: 14e56f21-6e79-4099-d6dd-08dba7da1f00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jpwPijatn17bvbyl5CjG9A6sURQC59EV8HTePJx8vr7Kqy6xfsr6Ww8Q0OQvpZUe+EIM/YWbTyQPupXKeXHWSCIZ6nqv+yl7FjHZmCu2PQ/5t+O6VB+pNroW2MTi6WJCkh3fBNwqdVuZTr2xq5iuBpfr5ONvHEY3TwqbTO/cFicijXsTv7POtm34Lx+CmPzoHpXcm8ILMNIj7J1Ls5uxdM5BdUm/d+Qi7muXqNzndbBm2/INs+AbmsR6sqEDjUuY9uUq/h6Reo9uxCttxrcWpaeD9iBOrNP1XtfEZhxvRcGzJ43YDX+Z6EidwKncgvnQe6irI1CDorsBok9qZkKRGvq5RIZ6GWPrJdMQnkvZVVExiDyXiKWEVZdZQLy1qQjBprnNL+i+/sJ+LIiZvpQf2hfmIylAqf6i8/4qFCIuco8+KLAy0uSBrLxhZAEM8TGY5QLI/Smj3io52LuObwmzJfSHBjwfzC5KevMh59BSgNO9LXA0AWsTqiJF3YBWC6L7cbPwehhSmOCSlrVG6P0rqWhQH9V9uyJRICntRbG4c8RaUf8zJw5i9ll3FXhu1SizGeVkA78DGxdM6C+fiBmsTKxCEnPBi8BImqHrl30g46keqZ7pThuvYq1BRgXCd35MNJvzI519ks5PAPweOcKY2jkuhS9gJUYS59tTRbHXo/AL4TEI0u8ZhnLFFD5PIkYVnhrXCR70KwA9vnj/q+cpyCDKbOQl6ICBw+NDK0G6H+ruxMZWKJTsCFGs9hTbIO5f
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(451199024)(1800799009)(186009)(82310400011)(36840700001)(40470700004)(46966006)(82740400003)(7696005)(6666004)(36756003)(40460700003)(86362001)(7636003)(356005)(40480700001)(36860700001)(47076005)(107886003)(2616005)(1076003)(336012)(2906002)(426003)(26005)(83380400001)(478600001)(70586007)(70206006)(4326008)(8676002)(8936002)(5660300002)(41300700001)(6916009)(54906003)(316002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 15:19:06.7133 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14e56f21-6e79-4099-d6dd-08dba7da1f00
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6092
Received-SPF: softfail client-ip=2a01:111:f400:7e88::629;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
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

VFIO migration is not compatible with postcopy migration. A VFIO device
in the destination can't handle page faults for pages that have not been
sent yet.

Doing such migration will cause the VM to crash in the destination:

qemu-system-x86_64: VFIO_MAP_DMA failed: Bad address
qemu-system-x86_64: vfio_dma_map(0x55a28c7659d0, 0xc0000, 0xb000, 0x7f1b11a00000) = -14 (Bad address)
qemu: hardware error: vfio: DMA mapping failed, unable to continue

To prevent this and to be explicit about supported features, block VFIO
migration with postcopy migration: Fail setting postcopy capability if a
VFIO device is present, and add a migration blocker if a VFIO device is
added when postcopy capability is on.

Reported-by: Yanghang Liu <yanghliu@redhat.com>
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 include/hw/vfio/vfio-common.h |  2 ++
 migration/migration.h         |  2 ++
 hw/vfio/common.c              | 43 +++++++++++++++++++++++++++++++++++
 hw/vfio/migration.c           |  6 +++++
 migration/options.c           | 19 ++++++++++++++++
 migration/target.c            | 19 ++++++++++++++++
 6 files changed, 91 insertions(+)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index e9b8954595..c0b58f2bb7 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -227,6 +227,8 @@ extern VFIOGroupList vfio_group_list;
 bool vfio_mig_active(void);
 int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp);
 void vfio_unblock_multiple_devices_migration(void);
+int vfio_block_postcopy_migration(VFIODevice *vbasedev, Error **errp);
+void vfio_unblock_postcopy_migration(void);
 bool vfio_viommu_preset(VFIODevice *vbasedev);
 int64_t vfio_mig_bytes_transferred(void);
 void vfio_reset_bytes_transferred(void);
diff --git a/migration/migration.h b/migration/migration.h
index c5695de214..21a6423408 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -514,6 +514,8 @@ void migration_cancel(const Error *error);
 
 void migration_populate_vfio_info(MigrationInfo *info);
 void migration_reset_vfio_bytes_transferred(void);
+bool migration_vfio_mig_active(void);
+void migration_vfio_unblock_postcopy_migration(void);
 void postcopy_temp_page_reset(PostcopyTmpPage *tmp_page);
 
 #endif
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 373f6e5932..7461194b2b 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -40,6 +40,7 @@
 #include "trace.h"
 #include "qapi/error.h"
 #include "migration/migration.h"
+#include "migration/options.h"
 #include "migration/misc.h"
 #include "migration/blocker.h"
 #include "migration/qemu-file.h"
@@ -343,6 +344,7 @@ static int vfio_get_dirty_bitmap(VFIOContainer *container, uint64_t iova,
                                  uint64_t size, ram_addr_t ram_addr);
 
 static Error *multiple_devices_migration_blocker;
+static Error *postcopy_migration_blocker;
 
 static unsigned int vfio_migratable_devices_num(void)
 {
@@ -427,6 +429,47 @@ void vfio_unblock_multiple_devices_migration(void)
     multiple_devices_migration_blocker = NULL;
 }
 
+int vfio_block_postcopy_migration(VFIODevice *vbasedev, Error **errp)
+{
+    int ret;
+
+    if (!migrate_postcopy_ram()) {
+        return 0;
+    }
+
+    if (vbasedev->enable_migration == ON_OFF_AUTO_ON) {
+        error_setg(errp,
+                   "VFIO migration is not compatible with postcopy migration");
+        return -EINVAL;
+    }
+
+    if (postcopy_migration_blocker) {
+        return 0;
+    }
+
+    error_setg(&postcopy_migration_blocker,
+               "VFIO migration is not compatible with postcopy migration");
+    ret = migrate_add_blocker(postcopy_migration_blocker, errp);
+    if (ret < 0) {
+        error_free(postcopy_migration_blocker);
+        postcopy_migration_blocker = NULL;
+    }
+
+    return ret;
+}
+
+void vfio_unblock_postcopy_migration(void)
+{
+    if (!postcopy_migration_blocker ||
+        (vfio_migratable_devices_num() && migrate_postcopy_ram())) {
+        return;
+    }
+
+    migrate_del_blocker(postcopy_migration_blocker);
+    error_free(postcopy_migration_blocker);
+    postcopy_migration_blocker = NULL;
+}
+
 bool vfio_mig_active(void)
 {
     return vfio_migratable_devices_num();
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 71855468fe..76406e9ae9 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -856,6 +856,7 @@ static void vfio_migration_deinit(VFIODevice *vbasedev)
     unregister_savevm(VMSTATE_IF(vbasedev->dev), "vfio", vbasedev);
     vfio_migration_free(vbasedev);
     vfio_unblock_multiple_devices_migration();
+    vfio_unblock_postcopy_migration();
 }
 
 static int vfio_block_migration(VFIODevice *vbasedev, Error *err, Error **errp)
@@ -939,6 +940,11 @@ bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
         goto out_deinit;
     }
 
+    ret = vfio_block_postcopy_migration(vbasedev, errp);
+    if (ret) {
+        goto out_deinit;
+    }
+
     if (vfio_viommu_preset(vbasedev)) {
         error_setg(&err, "%s: Migration is currently not supported "
                    "with vIOMMU enabled", vbasedev->name);
diff --git a/migration/options.c b/migration/options.c
index 1d1e1321b0..e201053563 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -499,6 +499,11 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
             error_setg(errp, "Postcopy is not yet compatible with multifd");
             return false;
         }
+
+        if (migration_vfio_mig_active()) {
+            error_setg(errp, "Postcopy is not compatible with VFIO migration");
+            return false;
+        }
     }
 
     if (new_caps[MIGRATION_CAPABILITY_BACKGROUND_SNAPSHOT]) {
@@ -612,6 +617,16 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
     return true;
 }
 
+/*
+ * Devices might have added migration blockers based on migration capabilities
+ * values when those devices were added. Remove such blockers according to new
+ * changes in migration capabilities.
+ */
+static void migration_caps_remove_blockers(void)
+{
+    migration_vfio_unblock_postcopy_migration();
+}
+
 bool migrate_cap_set(int cap, bool value, Error **errp)
 {
     MigrationState *s = migrate_get_current();
@@ -629,6 +644,8 @@ bool migrate_cap_set(int cap, bool value, Error **errp)
         return false;
     }
     s->capabilities[cap] = value;
+    migration_caps_remove_blockers();
+
     return true;
 }
 
@@ -678,6 +695,8 @@ void qmp_migrate_set_capabilities(MigrationCapabilityStatusList *params,
     for (cap = params; cap; cap = cap->next) {
         s->capabilities[cap->value->capability] = cap->value->state;
     }
+
+    migration_caps_remove_blockers();
 }
 
 /* parameters */
diff --git a/migration/target.c b/migration/target.c
index a6ffa9a5ce..690ecb4dd5 100644
--- a/migration/target.c
+++ b/migration/target.c
@@ -27,6 +27,16 @@ void migration_reset_vfio_bytes_transferred(void)
 {
     vfio_reset_bytes_transferred();
 }
+
+bool migration_vfio_mig_active(void)
+{
+    return vfio_mig_active();
+}
+
+void migration_vfio_unblock_postcopy_migration(void)
+{
+    vfio_unblock_postcopy_migration();
+}
 #else
 void migration_populate_vfio_info(MigrationInfo *info)
 {
@@ -35,4 +45,13 @@ void migration_populate_vfio_info(MigrationInfo *info)
 void migration_reset_vfio_bytes_transferred(void)
 {
 }
+
+bool migration_vfio_mig_active(void)
+{
+    return false;
+}
+
+void migration_vfio_unblock_postcopy_migration()
+{
+}
 #endif
-- 
2.26.3


