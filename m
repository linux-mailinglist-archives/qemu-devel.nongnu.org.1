Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 013277409B6
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 09:32:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEPee-0000Kk-3d; Wed, 28 Jun 2023 03:31:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qEPeZ-0000K6-8b
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 03:31:51 -0400
Received: from mail-dm6nam12on20628.outbound.protection.outlook.com
 ([2a01:111:f400:fe59::628]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qEPeW-0006hM-Ky
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 03:31:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kL5nMbrrTFAs8FSFwjjHUO5cUhRdSO5Fxd51wzI+BCjsKCdZr76UAbfLPACVR2Rea8lETLLgR+IJwfPH+H7Qi0g07uO+sE/lyTDIDr4be+MAUIRoO5D5Hxq1VYskmmGS8r3I1+DoaNAH3G++fFHgf9qbZ4PzA5sRJnOaR7jd1aVZIUICHHjzVvQQZZ90kuFz6ys/Dynbo7Fre40rEhEoppE+VjDg2bYGGvBZD8cC3sX7WF4paHVbbeTvYcrNPNKQoz4G5/QPqha2rQBundclMO+/4x29neLSFwZZRZIYK8XBT7VRFjkmo6CWeu2M99SQjMNE3pf1OqcdkVMLYqI7sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FGKhBifCe/Uew7Zw6VCljn1ukb1IorI1JQby5/xH6gA=;
 b=d3Wlfs0j+L1Irs46NL/rsOY57PIEqeofTQI5gxPG9LU1ra8VHEPnQhgUVCz1MaqpCo1inByFeAZdGRQUzr51hQthPgNPk4njY36vDWazggKv7cFJmgRBwYWRBcQ40jbW4c5xe5RoSup9ClNR740d2syuaiDcEfdT5P5wEyf3FNqmsHfBDgImVq5TLKPsIGIbF2hmurnX0Rl6pVuVlET7NZI5xdJY9UKNCAnEvRlMWFTIl6JNQ23J9X6xJUi5ZUNFO/RM1y85+Z1nXF2yJTZPZP6boJ0QZUyJLVi0y5W2+1DD8ci8mboSQBzJCUFQoNnOCufzrexQ3vJwPrhLVPaQTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FGKhBifCe/Uew7Zw6VCljn1ukb1IorI1JQby5/xH6gA=;
 b=owk+5oLpNnYiuhrVjUdgkT65uFnZtyI9R4OVT/edQSQ8b2uoyvoc/Hnp9CJdcdx5X9j+7q3cThXQ1YCs6Lss4NeQKylnC6bDIabPewAhyQwBDq9esdDDDJMKKZmO1LhAQEPfIdONGyTEAPVDFgD65A84HQOYsEyiMvkm5vC8dx7h7/Y+w3VzapC8nfuI00xoMk2k+2wfBeiWFX5lzBR1749E/2xKjMH1FVDRRzlush4r26r6xqD/jmdgF7OoFQLYg4xXK6HCcLMzU2N+v6wLWQyRJRIwH/yZgMeoT/8ZCTdYr9TnROBX7wQ9Si1TZpL9Rro72Wm+GLu+eEOUIhXznQ==
Received: from BYAPR08CA0062.namprd08.prod.outlook.com (2603:10b6:a03:117::39)
 by PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Wed, 28 Jun
 2023 07:31:44 +0000
Received: from DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:117:cafe::f8) by BYAPR08CA0062.outlook.office365.com
 (2603:10b6:a03:117::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.16 via Frontend
 Transport; Wed, 28 Jun 2023 07:31:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT012.mail.protection.outlook.com (10.13.173.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.48 via Frontend Transport; Wed, 28 Jun 2023 07:31:43 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 28 Jun 2023
 00:31:26 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 28 Jun
 2023 00:31:25 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Wed, 28 Jun
 2023 00:31:22 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Juan Quintela
 <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>, Yishai Hadas
 <yishaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb
 <maorg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>, Kirti Wankhede
 <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>, Joao Martins
 <joao.m.martins@oracle.com>
Subject: [PATCH v2 2/2] vfio/migration: Make VFIO migration non-experimental
Date: Wed, 28 Jun 2023 10:31:12 +0300
Message-ID: <20230628073112.7958-3-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230628073112.7958-1-avihaih@nvidia.com>
References: <20230628073112.7958-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT012:EE_|PH7PR12MB5596:EE_
X-MS-Office365-Filtering-Correlation-Id: 3628640f-fd10-4b4a-8b15-08db77a9b8e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RC05RJZ6NAJpS6fEnz8AtZG42QWgZqUqLQlJHedV5vTeJ6SWVB//69oAiM5Ad4db8B670fmaU/t9HoGAoKrWDydH4ymG2HeUVvXWeCcRLB5fVIOg7t3h42krbbgZBRsXVH/yQDfJoT0Q0JhGHZveyoZSTJtZUaNKAxTq1qObqdpWv9vsLIcww7msKEH7WnVHyd93hPdxnp9hUIcV/EFuEYxB4dA3OcRocbGJOyTLRgq488y0esGQs1xK4HCCwcW3hKuK47rIMU1HYJPFUlnuQTTSO3WbJvuM3+NPjjDcBj3al8idfFlCEUrHY3oLOq55gQC0gI0k2IirrDztDjN16m0qDryWhSb5Hj6REy88oYVd8YRKiPxUsSnOxybYd41qS3oRg4RXCOt3LoCUUGQ3P0AZCnsnSBTdJpeJfNc7zErHdBny4K+9O+8u+gJFhac1eKkbdxjkYwmrEYDLninLVVlTDCvqKpQCKiTv8ZIROyDt5t/SVm2OVOl/sXyQAwbBvrJT5PREpH4JaoT1Wfk1neQ/JrW/GrSezFGwt0u7aFfjEA1aUIJ0znAh1osl8nRdhmlr/yNrFpxp32z+t4iDB7WnbO6YntsPw0s3GNFx5LbYbjA8XcF5d5bp1qHroKKz5R4TZWzg7nhNmzThvb4Q4Q1Fvq/lld83NC+KWO03R/Wn+zYmmvxPOOMeS1/PH09ruwH+yMFI7+o0xI4iIJUvOPlaptNT9SH9p7ytenMdWhlU22WFd8mTITdHlgdOqw+3
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(1076003)(5660300002)(70586007)(316002)(36756003)(478600001)(4326008)(6916009)(70206006)(8676002)(8936002)(86362001)(2906002)(54906003)(36860700001)(40460700003)(41300700001)(40480700001)(6666004)(82310400005)(7696005)(186003)(26005)(336012)(426003)(82740400003)(47076005)(356005)(2616005)(83380400001)(7636003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 07:31:43.6905 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3628640f-fd10-4b4a-8b15-08db77a9b8e3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5596
Received-SPF: softfail client-ip=2a01:111:f400:fe59::628;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
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

The major parts of VFIO migration are supported today in QEMU. This
includes basic VFIO migration, device dirty page tracking and precopy
support.

Thus, at this point in time, it seems appropriate to make VFIO migration
non-experimental: remove the x prefix from enable_migration property,
change it to ON_OFF_AUTO and let the default value be AUTO.

In addition, make the following adjustments:
1. When enable_migration is ON and migration is not supported, fail VFIO
   device realization.
2. When enable_migration is AUTO (i.e., not explicitly enabled), require
   device dirty tracking support. This is because device dirty tracking
   is currently the only method to do dirty page tracking, which is
   essential for migrating in a reasonable downtime. Setting
   enable_migration to ON will not require device dirty tracking.
3. Make migration error and blocker messages more elaborate.
4. Remove error prints in vfio_migration_query_flags().
5. Rename trace_vfio_migration_probe() to
   trace_vfio_migration_realize().

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 include/hw/vfio/vfio-common.h |  6 +--
 hw/vfio/common.c              | 16 ++++++-
 hw/vfio/migration.c           | 79 +++++++++++++++++++++++------------
 hw/vfio/pci.c                 |  4 +-
 hw/vfio/trace-events          |  2 +-
 5 files changed, 73 insertions(+), 34 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index b4c28f318f..0ded0e73e2 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -139,7 +139,7 @@ typedef struct VFIODevice {
     bool needs_reset;
     bool no_mmap;
     bool ram_block_discard_allowed;
-    bool enable_migration;
+    OnOffAuto enable_migration;
     VFIODeviceOps *ops;
     unsigned int num_irqs;
     unsigned int num_regions;
@@ -224,9 +224,9 @@ typedef QLIST_HEAD(VFIOGroupList, VFIOGroup) VFIOGroupList;
 extern VFIOGroupList vfio_group_list;
 
 bool vfio_mig_active(void);
-int vfio_block_multiple_devices_migration(Error **errp);
+int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp);
 void vfio_unblock_multiple_devices_migration(void);
-int vfio_block_giommu_migration(Error **errp);
+int vfio_block_giommu_migration(VFIODevice *vbasedev, Error **errp);
 int64_t vfio_mig_bytes_transferred(void);
 void vfio_reset_bytes_transferred(void);
 
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 25801de173..8c73f84581 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -381,7 +381,7 @@ static unsigned int vfio_migratable_device_num(void)
     return device_num;
 }
 
-int vfio_block_multiple_devices_migration(Error **errp)
+int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
 {
     int ret;
 
@@ -390,6 +390,12 @@ int vfio_block_multiple_devices_migration(Error **errp)
         return 0;
     }
 
+    if (vbasedev->enable_migration == ON_OFF_AUTO_ON) {
+        error_setg(errp, "Migration is currently not supported with multiple "
+                         "VFIO devices");
+        return -EINVAL;
+    }
+
     error_setg(&multiple_devices_migration_blocker,
                "Migration is currently not supported with multiple "
                "VFIO devices");
@@ -427,7 +433,7 @@ static bool vfio_viommu_preset(void)
     return false;
 }
 
-int vfio_block_giommu_migration(Error **errp)
+int vfio_block_giommu_migration(VFIODevice *vbasedev, Error **errp)
 {
     int ret;
 
@@ -436,6 +442,12 @@ int vfio_block_giommu_migration(Error **errp)
         return 0;
     }
 
+    if (vbasedev->enable_migration == ON_OFF_AUTO_ON) {
+        error_setg(errp,
+                   "Migration is currently not supported with vIOMMU enabled");
+        return -EINVAL;
+    }
+
     error_setg(&giommu_migration_blocker,
                "Migration is currently not supported with vIOMMU enabled");
     ret = migrate_add_blocker(giommu_migration_blocker, errp);
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 7cf143926c..1db7d52ab2 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -724,14 +724,6 @@ static int vfio_migration_query_flags(VFIODevice *vbasedev, uint64_t *mig_flags)
     feature->argsz = sizeof(buf);
     feature->flags = VFIO_DEVICE_FEATURE_GET | VFIO_DEVICE_FEATURE_MIGRATION;
     if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {
-        if (errno == ENOTTY) {
-            error_report("%s: VFIO migration is not supported in kernel",
-                         vbasedev->name);
-        } else {
-            error_report("%s: Failed to query VFIO migration support, err: %s",
-                         vbasedev->name, strerror(errno));
-        }
-
         return -errno;
     }
 
@@ -810,6 +802,27 @@ static int vfio_migration_init(VFIODevice *vbasedev)
     return 0;
 }
 
+static int vfio_block_migration(VFIODevice *vbasedev, Error *err, Error **errp)
+{
+    int ret;
+
+    if (vbasedev->enable_migration == ON_OFF_AUTO_ON) {
+        error_propagate(errp, err);
+        return -EINVAL;
+    }
+
+    vbasedev->migration_blocker = error_copy(err);
+    error_free(err);
+
+    ret = migrate_add_blocker(vbasedev->migration_blocker, errp);
+    if (ret < 0) {
+        error_free(vbasedev->migration_blocker);
+        vbasedev->migration_blocker = NULL;
+    }
+
+    return ret;
+}
+
 /* ---------------------------------------------------------------------- */
 
 int64_t vfio_mig_bytes_transferred(void)
@@ -824,40 +837,54 @@ void vfio_reset_bytes_transferred(void)
 
 int vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
 {
-    int ret = -ENOTSUP;
+    Error *err = NULL;
+    int ret;
 
-    if (!vbasedev->enable_migration) {
-        goto add_blocker;
+    if (vbasedev->enable_migration == ON_OFF_AUTO_OFF) {
+        error_setg(&err, "%s: Migration is disabled for VFIO device",
+                   vbasedev->name);
+        return vfio_block_migration(vbasedev, err, errp);
     }
 
     ret = vfio_migration_init(vbasedev);
     if (ret) {
-        goto add_blocker;
+        if (ret == -ENOTTY) {
+            error_setg(&err, "%s: VFIO migration is not supported in kernel",
+                       vbasedev->name);
+        } else {
+            error_setg(&err,
+                       "%s: Migration couldn't be initialized for VFIO device, "
+                       "err: %d (%s)",
+                       vbasedev->name, ret, strerror(-ret));
+        }
+
+        return vfio_block_migration(vbasedev, err, errp);
+    }
+
+    if (!vbasedev->dirty_pages_supported) {
+        if (vbasedev->enable_migration == ON_OFF_AUTO_AUTO) {
+            error_setg(&err,
+                       "%s: VFIO device doesn't support device dirty tracking",
+                       vbasedev->name);
+            return vfio_block_migration(vbasedev, err, errp);
+        }
+
+        warn_report("%s: VFIO device doesn't support device dirty tracking",
+                    vbasedev->name);
     }
 
-    ret = vfio_block_multiple_devices_migration(errp);
+    ret = vfio_block_multiple_devices_migration(vbasedev, errp);
     if (ret) {
         return ret;
     }
 
-    ret = vfio_block_giommu_migration(errp);
+    ret = vfio_block_giommu_migration(vbasedev, errp);
     if (ret) {
         return ret;
     }
 
-    trace_vfio_migration_probe(vbasedev->name);
+    trace_vfio_migration_realize(vbasedev->name);
     return 0;
-
-add_blocker:
-    error_setg(&vbasedev->migration_blocker,
-               "VFIO device doesn't support migration");
-
-    ret = migrate_add_blocker(vbasedev->migration_blocker, errp);
-    if (ret < 0) {
-        error_free(vbasedev->migration_blocker);
-        vbasedev->migration_blocker = NULL;
-    }
-    return ret;
 }
 
 void vfio_migration_exit(VFIODevice *vbasedev)
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 73874a94de..48584e3b01 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3347,8 +3347,8 @@ static Property vfio_pci_dev_properties[] = {
                     VFIO_FEATURE_ENABLE_REQ_BIT, true),
     DEFINE_PROP_BIT("x-igd-opregion", VFIOPCIDevice, features,
                     VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
-    DEFINE_PROP_BOOL("x-enable-migration", VFIOPCIDevice,
-                     vbasedev.enable_migration, false),
+    DEFINE_PROP_ON_OFF_AUTO("enable-migration", VFIOPCIDevice,
+                            vbasedev.enable_migration, ON_OFF_AUTO_AUTO),
     DEFINE_PROP_BOOL("x-no-mmap", VFIOPCIDevice, vbasedev.no_mmap, false),
     DEFINE_PROP_BOOL("x-balloon-allowed", VFIOPCIDevice,
                      vbasedev.ram_block_discard_allowed, false),
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index e328d644d2..ee7509e68e 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -155,7 +155,7 @@ vfio_load_cleanup(const char *name) " (%s)"
 vfio_load_device_config_state(const char *name) " (%s)"
 vfio_load_state(const char *name, uint64_t data) " (%s) data 0x%"PRIx64
 vfio_load_state_device_data(const char *name, uint64_t data_size, int ret) " (%s) size 0x%"PRIx64" ret %d"
-vfio_migration_probe(const char *name) " (%s)"
+vfio_migration_realize(const char *name) " (%s)"
 vfio_migration_set_state(const char *name, const char *state) " (%s) state %s"
 vfio_migration_state_notifier(const char *name, const char *state) " (%s) state %s"
 vfio_save_block(const char *name, int data_size) " (%s) data_size %d"
-- 
2.26.3


