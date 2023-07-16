Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1767E754DD2
	for <lists+qemu-devel@lfdr.de>; Sun, 16 Jul 2023 10:17:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKwvV-0007p6-G0; Sun, 16 Jul 2023 04:16:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qKwvS-0007ol-EB
 for qemu-devel@nongnu.org; Sun, 16 Jul 2023 04:16:18 -0400
Received: from mail-bn8nam11on20601.outbound.protection.outlook.com
 ([2a01:111:f400:7eae::601]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qKwvQ-0000r9-H6
 for qemu-devel@nongnu.org; Sun, 16 Jul 2023 04:16:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LbG1fc3sEnoi2IUcSeez9npbGVNcnvQZ1YFMzDiJP+zbtC3TUiXV8rCPgdDbsoRPH1hW89gbYwsctomCsYDxiBYunDv0VHbsy9vK3VLOl4hK4ZpgzLe0ieXEkP5rzW00NPIlOQvhoLFLZZpyObD8f6LXPyAzJ6PgesYWKgLXQiqR97hVHOEZYRIAm6D9m+NCnhgkoEObM6+tvKwq1aEo7vf+sYuHmOD5nQUzqrWLez7CCA75A9EFWz0Vm2BYuR4jqF0zqrWCgD+NZu7k517o36lgx/LnvvH2NZ6ZVLd3u3ATlAbl2YEJxZgVTrSYzjyDJ6pcDAqqNwJ5WQLsPIkf3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1aFLT3zsTS4PFGtbASiYCiJoaiMXApHKu5zZo2p1a7Y=;
 b=IPNkWl8LHtTBTVoxKclSCjirJpmV6MOHSvB82jKMMtVMOv3VT4YAB+q8h9bzPDCq5KwJSRQw7VpnYw7J09QdjOWzE+6UJgRGSm3JCuQ9mULiP4I7ujtsnqryWmgDZlxLuVewoDC/xkBUDAN4jMVbdYtZQW1t+oiAxOKm9AkkNmQR8VBjqesVq2r1uhHQw/ri2oK6XxR7ZTem4xpF8TVelEOO5VO7bX06lTSeyg/cmJrD3dak07E4XN/r0XG5BzZxYpXM/hWX2AC+9jhPVUpNb32Vusob7qeJUPqKP23L3PREsfnBncDdd2GO1TD4MhjYUQiUJtthJ7ZjFqAliXq3Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1aFLT3zsTS4PFGtbASiYCiJoaiMXApHKu5zZo2p1a7Y=;
 b=gYRIkk/595KPfg/S2qq0S2rE0dvObWhSapc4lwkQQOnMrWpKluP3TJXMARk4JtSYoLRAwL1y/ciiP+c7b20PTd0EVmzsgW3ldx3+Fjv7BusMh12+HUCb/CQXpjHmUc5jZEl7IxBV8DIbCO3SYC2vnfneLUntl/svrpr2O7fK0jad7lYNmzewIen+IVmpuxCX215NpbBTtm93S1TP9yNAqkWaQPpvJ9g/xu1a8lYckKcIeaUM02El4pG+7HBFUcaW/4ZN89tHYg0zIB0u03tU2tXbDVopJyvDHng3wfBdWC6oVtrQxaQSErDys1Yprd4YRRN/0J+YM+K9+OXHFwMBqA==
Received: from SJ0PR05CA0054.namprd05.prod.outlook.com (2603:10b6:a03:33f::29)
 by MN2PR12MB4240.namprd12.prod.outlook.com (2603:10b6:208:1d3::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Sun, 16 Jul
 2023 08:16:10 +0000
Received: from DM6NAM11FT081.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:33f:cafe::3c) by SJ0PR05CA0054.outlook.office365.com
 (2603:10b6:a03:33f::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.14 via Frontend
 Transport; Sun, 16 Jul 2023 08:16:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT081.mail.protection.outlook.com (10.13.172.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.31 via Frontend Transport; Sun, 16 Jul 2023 08:16:09 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 16 Jul 2023
 01:15:58 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 16 Jul
 2023 01:15:58 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Sun, 16 Jul
 2023 01:15:55 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, Yishai Hadas
 <yishaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb
 <maorg@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta
 <targupta@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH for-8.2 4/6] vfio/migration: Refactor PRE_COPY and RUNNING
 state checks
Date: Sun, 16 Jul 2023 11:15:39 +0300
Message-ID: <20230716081541.27900-5-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230716081541.27900-1-avihaih@nvidia.com>
References: <20230716081541.27900-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT081:EE_|MN2PR12MB4240:EE_
X-MS-Office365-Filtering-Correlation-Id: 1251883b-e41c-426e-6613-08db85d4e990
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +X9KHdbATr0VGEPDd8uHh6Zu7Or/1CKyWt9Aa/TTvaO05cfkXXurSI/pv1GuAt4VLwIa66ulDzVTm0Bi21HNUkQgKaShgz6SMblVRSq/iqADcAy3RVbncKbb7RNAC0ADzLQwTvQubF+AYWy3jwNIpCCbazvUHiweDh6MSQT7/0qd3ZHOgutQqZgh3jrqTrdx2jA73+DY6ENvZo27oS6DcVBfbmAETEv2I+ZgZcEBKN8cil0vgKbs+hWnIH85lAZk+VSI8j2FxTjKrmyvzAF+PUvZxrS814QCfNMw3O9c/MJReDD2t/y6QFOInACXrifJ7S4c8HBFL/BT/AasM1J24/t8diCTxywrZXWsmOV1S9kwTte6eDazBBqgfZDw5x+gFOICg1FErwxwiF0PgvvcCMlEnZwApfw1an7ZrlNBwbjEPJl8GoejgVq9f4j7JXXbe14ilyAoHAkWeUwSqpoJmTCxQEXYLbaRDUA1njz9j58xq68NCSC2f0wXjUcPf18CsF5mILx+mOYXtnkttErUYYvkQ+bVUJzwTTWNiMVTSdF+qZ0f+sZAGgPCGaeP48ZzBdY/VeSsHRYSFEIHfGvjSmZicSGiQl14w/qUuOkp0Ub2jdTCqb6Vgme5+bjVzdL4uDU1cUZjhZPzfH89wR95IxU9CQe8q3d743+LTY2JsKaJAWGgLzQWXU8wVzRTxTIGjRK0ItmD8uuMIx17FA9KNIuP/zrvJCm/t7k+V004GwqXV8ObvXgjEa50/QHI37I8
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(136003)(396003)(376002)(451199021)(82310400008)(46966006)(40470700004)(36840700001)(36860700001)(40460700003)(70586007)(4326008)(70206006)(6916009)(7636003)(356005)(2616005)(86362001)(83380400001)(107886003)(26005)(47076005)(1076003)(426003)(478600001)(36756003)(82740400003)(186003)(336012)(6666004)(7696005)(40480700001)(54906003)(41300700001)(316002)(5660300002)(8936002)(8676002)(2906002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2023 08:16:09.9766 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1251883b-e41c-426e-6613-08db85d4e990
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4240
Received-SPF: softfail client-ip=2a01:111:f400:7eae::601;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
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

From: Joao Martins <joao.m.martins@oracle.com>

Move the PRE_COPY and RUNNING state checks to helper functions.

This is in preparation for adding P2P VFIO migration support, where
these helpers will also test for PRE_COPY_P2P and RUNNING_P2P states.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 include/hw/vfio/vfio-common.h |  2 ++
 hw/vfio/common.c              | 22 ++++++++++++++++++----
 hw/vfio/migration.c           | 10 ++++------
 3 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index da43d27352..e9b8954595 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -230,6 +230,8 @@ void vfio_unblock_multiple_devices_migration(void);
 bool vfio_viommu_preset(VFIODevice *vbasedev);
 int64_t vfio_mig_bytes_transferred(void);
 void vfio_reset_bytes_transferred(void);
+bool vfio_device_state_is_running(VFIODevice *vbasedev);
+bool vfio_device_state_is_precopy(VFIODevice *vbasedev);
 
 #ifdef CONFIG_LINUX
 int vfio_get_region_info(VFIODevice *vbasedev, int index,
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 9aac21abb7..16cf79a76c 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -437,6 +437,20 @@ static void vfio_set_migration_error(int err)
     }
 }
 
+bool vfio_device_state_is_running(VFIODevice *vbasedev)
+{
+    VFIOMigration *migration = vbasedev->migration;
+
+    return migration->device_state == VFIO_DEVICE_STATE_RUNNING;
+}
+
+bool vfio_device_state_is_precopy(VFIODevice *vbasedev)
+{
+    VFIOMigration *migration = vbasedev->migration;
+
+    return migration->device_state == VFIO_DEVICE_STATE_PRE_COPY;
+}
+
 static bool vfio_devices_all_dirty_tracking(VFIOContainer *container)
 {
     VFIOGroup *group;
@@ -457,8 +471,8 @@ static bool vfio_devices_all_dirty_tracking(VFIOContainer *container)
             }
 
             if (vbasedev->pre_copy_dirty_page_tracking == ON_OFF_AUTO_OFF &&
-                (migration->device_state == VFIO_DEVICE_STATE_RUNNING ||
-                 migration->device_state == VFIO_DEVICE_STATE_PRE_COPY)) {
+                (vfio_device_state_is_running(vbasedev) ||
+                 vfio_device_state_is_precopy(vbasedev))) {
                 return false;
             }
         }
@@ -503,8 +517,8 @@ static bool vfio_devices_all_running_and_mig_active(VFIOContainer *container)
                 return false;
             }
 
-            if (migration->device_state == VFIO_DEVICE_STATE_RUNNING ||
-                migration->device_state == VFIO_DEVICE_STATE_PRE_COPY) {
+            if (vfio_device_state_is_running(vbasedev) ||
+                vfio_device_state_is_precopy(vbasedev)) {
                 continue;
             } else {
                 return false;
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 8acd182a8b..48f9c23cbe 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -411,7 +411,7 @@ static void vfio_state_pending_estimate(void *opaque, uint64_t *must_precopy,
     VFIODevice *vbasedev = opaque;
     VFIOMigration *migration = vbasedev->migration;
 
-    if (migration->device_state != VFIO_DEVICE_STATE_PRE_COPY) {
+    if (!vfio_device_state_is_precopy(vbasedev)) {
         return;
     }
 
@@ -444,7 +444,7 @@ static void vfio_state_pending_exact(void *opaque, uint64_t *must_precopy,
     vfio_query_stop_copy_size(vbasedev, &stop_copy_size);
     *must_precopy += stop_copy_size;
 
-    if (migration->device_state == VFIO_DEVICE_STATE_PRE_COPY) {
+    if (vfio_device_state_is_precopy(vbasedev)) {
         vfio_query_precopy_size(migration);
 
         *must_precopy +=
@@ -459,9 +459,8 @@ static void vfio_state_pending_exact(void *opaque, uint64_t *must_precopy,
 static bool vfio_is_active_iterate(void *opaque)
 {
     VFIODevice *vbasedev = opaque;
-    VFIOMigration *migration = vbasedev->migration;
 
-    return migration->device_state == VFIO_DEVICE_STATE_PRE_COPY;
+    return vfio_device_state_is_precopy(vbasedev);
 }
 
 static int vfio_save_iterate(QEMUFile *f, void *opaque)
@@ -656,7 +655,6 @@ static const SaveVMHandlers savevm_vfio_handlers = {
 static void vfio_vmstate_change(void *opaque, bool running, RunState state)
 {
     VFIODevice *vbasedev = opaque;
-    VFIOMigration *migration = vbasedev->migration;
     enum vfio_device_mig_state new_state;
     int ret;
 
@@ -664,7 +662,7 @@ static void vfio_vmstate_change(void *opaque, bool running, RunState state)
         new_state = VFIO_DEVICE_STATE_RUNNING;
     } else {
         new_state =
-            (migration->device_state == VFIO_DEVICE_STATE_PRE_COPY &&
+            (vfio_device_state_is_precopy(vbasedev) &&
              (state == RUN_STATE_FINISH_MIGRATE || state == RUN_STATE_PAUSED)) ?
                 VFIO_DEVICE_STATE_STOP_COPY :
                 VFIO_DEVICE_STATE_STOP;
-- 
2.26.3


