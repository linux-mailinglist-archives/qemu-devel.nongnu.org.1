Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2287573D997
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 10:25:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDhWU-0004Bs-2Q; Mon, 26 Jun 2023 04:24:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qDhWR-0004Bh-Rx
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 04:24:31 -0400
Received: from mail-dm6nam11on20612.outbound.protection.outlook.com
 ([2a01:111:f400:7eaa::612]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qDhWO-00034g-PS
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 04:24:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YbFp2QWqabhE/eSweGt4Koq4WWZE/81rNBghRupsrYs9+kjckgIeoikxCyu9k0WGozf/bSzB09mVvIGd4A7IA4Swm0OQzDiJhucMnWD9hL6eJOpGRs7il9d7drPeZoKE5xdhresUS0xmWPuzicGW1wHh93XaXho9RwGYcnZ0is1MUfQRo0BH+VRKk5dpnA3Cw8w9d4LS7pGHpnYrQQDXmROnr3ZQM1LDCDUmEKpVefqtW13hkgu/Iwd0kfosRlvLzviESOkFhodig3A5hmgFpJ6dDTZXQqophltKbI+HnqPjVjX2D1MewmZs26039e9t4flRz+IMpxdGykFfu7LBgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lb8EHhPAsEDfLr8hzvZqlDif7Z9MMT/ZERa3VhHC250=;
 b=dJMwkjCGsS8f4lacwi3114qM3X+my9ojL8IqPKm9C2e14XF9qZwpWGKNvQhxcroHLF5hQmDoVM6r8DtahJ32QBR+g3j9LkMZ1BikP8p9Ofet5F/doAfWrk9x/uKkcJySXraOca9qCT/fw79Xiy+v9pigkR9iRYIRS3LVZ/YIZYCp3LqcvvbXPqWqwhn2mr42tJREY79WHY9fYTayo4+oluAURtx6pqGp6fBUPjuEVaCvJ2vYPB9ZjkEwGllZonWTiBP1HvACMab673obWL1SSyPCpH9LlG7XdtA1+evEUXSAgJ3htgDD5RVjVj0svn7/IzCPMHBsYZ7iB8OSKzVMjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lb8EHhPAsEDfLr8hzvZqlDif7Z9MMT/ZERa3VhHC250=;
 b=oj/lNUnYk+9/CByTJK2JpZFTIRJN76cjfpAdvw9ztNsjnnpTV+HYQHdTiJUCUDpqEyEvmA3IUPeAURMz2QeZEHgIi51cwOMsjpzfFNJP5BcCIVSvhZvlkByBnoBH8OHT3kbIYQMHIxcbi6fhVfMMQMEC0ZSq+TsKgig+AKBbpC+mnskJIm3u/X4PH3X32nUfwb0Sz6eD/oMqXEZ5YmLtT6CdIouVzaNnq/3Wpz+5KCKgT20HkD21+SB/Xk1xVuzSsRBgFeyePnt+PZHKqTCLfOeznhaiw+rAM9VCvpDUSNAFXJfBIpogSySb4YcCLD2/NKHa0nQuPXkXeDQB2/Ax0g==
Received: from DS7PR03CA0254.namprd03.prod.outlook.com (2603:10b6:5:3b3::19)
 by SA1PR12MB8723.namprd12.prod.outlook.com (2603:10b6:806:385::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 08:24:24 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b3:cafe::97) by DS7PR03CA0254.outlook.office365.com
 (2603:10b6:5:3b3::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.33 via Frontend
 Transport; Mon, 26 Jun 2023 08:24:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.47 via Frontend Transport; Mon, 26 Jun 2023 08:24:23 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 26 Jun 2023
 01:24:10 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 26 Jun
 2023 01:24:09 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Mon, 26 Jun
 2023 01:24:06 -0700
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
Subject: [PATCH 3/3] vfio/migration: Make VFIO migration non-experimental
Date: Mon, 26 Jun 2023 11:23:53 +0300
Message-ID: <20230626082353.18535-4-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230626082353.18535-1-avihaih@nvidia.com>
References: <20230626082353.18535-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT066:EE_|SA1PR12MB8723:EE_
X-MS-Office365-Filtering-Correlation-Id: 44bebae8-8ec1-46c9-67bb-08db761ebf9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QfriOs1UYJQzr21BjHBtExrffNFNiJkzSK0gn8mS87tgnbU99kOwLMdeucugfuDHMWYBsQsg/FsVjeBml3ajDs6D1+P0yhQO+RHf6TRclvC+hdMHvdR0DsNOjUX9U98/KyROaRYwzX8lotvFKSpaQ7bjLD1DM8bGeJTtCtFzU/XGP8iGPkq6+WYgKW7ye9FUTIL2PckU47pju1V18DtTITfBuKfn1jq65RKFrS6cdaL1E9QOOmzMtFjwnguKYVsX05StXt2vG/qX6BGTB+8M1oHBQECaEZD71kWiicEVP2J5OwZAXR/Z6qpGTsiFiSkibYu9Dhm2RkMcw+Ky353RolJMrFI/5ES74NufJ0iUEQ1LACyp8jEONNI4jQDZ1eH9GFb8x0P2PRCC5wysQDWXEtECMYLJXqxvG2l4CkjM7vBVG1eL0qapz5h73BVmM1Kt3QgplpNwf3zBktzhvsaf8wX0h570LYUfw/kc1FmRZOvYu/kWZhuJ5+tJOUptsUcJHPT3ff4245VKxD6+alGE7tDspggTF/L0QO/DC6g1EUjh3AG8/gg8T/a1RPN3YFy3LzbUYITRogTAsbv7ZiNju0Jr2sqxiZmMNpVX+ZOWFspO24Fk+VHNlAG+3qjBpRkIyHmSkTML42mzYdtH5QoqLNWK6nQ6d4DNTHj27cduyc2f4F4qi0iSruJ1fsguLzh0WXYkA6xDRDkpKRvy1KCbHLJoOFVtYLLRTy23kKvz++DLktMnUtfgF5ktj8f8Kost
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(376002)(136003)(396003)(451199021)(36840700001)(40470700004)(46966006)(82310400005)(36860700001)(2906002)(47076005)(478600001)(426003)(7696005)(54906003)(2616005)(6666004)(83380400001)(336012)(26005)(186003)(1076003)(5660300002)(356005)(40460700003)(36756003)(70206006)(70586007)(82740400003)(7636003)(40480700001)(316002)(4326008)(8936002)(8676002)(41300700001)(86362001)(6916009);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 08:24:23.7486 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44bebae8-8ec1-46c9-67bb-08db761ebf9f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8723
Received-SPF: softfail client-ip=2a01:111:f400:7eaa::612;
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

The major parts of VFIO migration are supported today in QEMU. This
includes basic VFIO migration, device dirty page tracking and precopy
support.

Thus, at this point in time, it seems appropriate to make VFIO migration
non-experimental: remove the x prefix from enable_migration property,
change it to ON_OFF_AUTO and let the default value be AUTO.

In addition, make the following adjustments:
1. Require device dirty tracking support when enable_migration is AUTO
   (i.e., not explicitly enabled). This is because device dirty tracking
   is currently the only method to do dirty page tracking, which is
   essential for migrating in a reasonable downtime. Setting
   enable_migration to ON will not require device dirty tracking.
2. Make migration blocker messages more elaborate.
3. Remove error prints in vfio_migration_query_flags().
4. Remove a redundant assignment in vfio_migration_realize().

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 include/hw/vfio/vfio-common.h |  2 +-
 hw/vfio/migration.c           | 29 ++++++++++++++++-------------
 hw/vfio/pci.c                 |  4 ++--
 3 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index b4c28f318f..387eabde60 100644
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
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 79eb81dfd7..d8e0848635 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -731,14 +731,6 @@ static int vfio_migration_query_flags(VFIODevice *vbasedev, uint64_t *mig_flags)
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
 
@@ -831,14 +823,28 @@ void vfio_reset_bytes_transferred(void)
 
 int vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
 {
-    int ret = -ENOTSUP;
+    int ret;
 
-    if (!vbasedev->enable_migration) {
+    if (vbasedev->enable_migration == ON_OFF_AUTO_OFF) {
+        error_setg(&vbasedev->migration_blocker,
+                   "%s: Migration is disabled for VFIO device", vbasedev->name);
         goto add_blocker;
     }
 
     ret = vfio_migration_init(vbasedev);
     if (ret) {
+        error_setg(&vbasedev->migration_blocker,
+                   "%s: Migration couldn't be initialized for VFIO device, "
+                   "err: %d (%s)",
+                   vbasedev->name, ret, strerror(-ret));
+        goto add_blocker;
+    }
+
+    if (vbasedev->enable_migration == ON_OFF_AUTO_AUTO &&
+        !vbasedev->dirty_pages_supported) {
+        error_setg(&vbasedev->migration_blocker,
+                   "%s: VFIO device doesn't support device dirty tracking",
+                   vbasedev->name);
         goto add_blocker;
     }
 
@@ -856,9 +862,6 @@ int vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
     return 0;
 
 add_blocker:
-    error_setg(&vbasedev->migration_blocker,
-               "VFIO device doesn't support migration");
-
     ret = migrate_add_blocker(vbasedev->migration_blocker, errp);
     if (ret < 0) {
         error_free(vbasedev->migration_blocker);
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
-- 
2.26.3


