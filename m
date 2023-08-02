Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A8B76C836
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 10:16:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qR716-0006zD-Ur; Wed, 02 Aug 2023 04:15:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qR715-0006yt-8r
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 04:15:35 -0400
Received: from mail-bn7nam10on2060b.outbound.protection.outlook.com
 ([2a01:111:f400:7e8a::60b]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qR713-0006RO-Cy
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 04:15:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HUJWyUfXFkX0685k5WB6f+Ngno1WV/mI1T77Z/q3ete2qZoGtaOXAnbWzp+noL3HQH8r6nr3WbWeERTspqrFSEA6VkMPCNolgFFOetJh/QFqbnLiKZUiGwm2PLXim2r0E27FOQDHF+zWpX3g4mpcH71SRdJQZ7vaKxBvJ3hhDswvvsc/4MhAdMHa32oDK7rDQuDce5BSCCytgA48l9jSmea4pN63TV9HQLHMj+Yn3Uglo2cSFCJARyNRbj2QXoz8xh1l8KHnK3Q2/+D7rb+X5PIJIhzikfDepeUnB2h5Z8n0s8z+T/aEifKq87E/wxYpbi5nxPI9nxqHqJL6vwowBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XOqslVDeYPp1BKRdY4T9f8yy2aeBgRO7yM4QTsRZNBU=;
 b=hpPCKWu5/G5MAf6oZSuHlRnL1f/Caif7Br7MiorUH1PJLSjZj49i9XTg1gL9GMyn82K/yZ/7SlEWTWa8GDw9+Sshj4j2s8rDRlTVA4tsrOdCUEaTC9ojN6cBE8Rs4RTrWONlesDkRFZuHd6cXGSv6wsLoXuoY3zi/lbf4HUhXAOwpaPaNBvFQyoXVuaJTuhM3RLZqMsfPKL0Y+d0pOf5uVhxjbiFMH9cpAvT3x8sqMnRfl7OKitXyW2dsvHJgTr2oQelS8T9J6rixQr1gDzufFSfNN7RAux/V/X7dVgK3almGV4CTOAgmptkCrx2nJHoOhIU0n+bOQuC2UpN7dyGbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOqslVDeYPp1BKRdY4T9f8yy2aeBgRO7yM4QTsRZNBU=;
 b=hi27GxnoWD7GfymkYmygnMUF4CT+Gba2kBDXVMBmqFQRr2ZEkRPuDXw1Pa9/BVuf2yb/otYSlYalR3UqxsiYIMZVByNPJCg0BsHIwSsVk511HyWQIaALB9HPH0KvFJ3nC9/LY3OuQx7KTMGwHfmoToiO0mqsjhalIkQooSL5KP00NI+e/PTSgambp3GxfMIapJSND2WpBfnXzY3k78rLwGrthssPm+mEC68N6zu65OQThAT1XIP8eqoLKhyjUNN8/m/UqT46IVHNA0XW2V4PC25St5d42RP95UUGo9qoPTYTNT4ZPHhxzOattHp3rxelpt4S0p+6SvMNamSYG6riVw==
Received: from CY8PR11CA0002.namprd11.prod.outlook.com (2603:10b6:930:48::9)
 by PH8PR12MB6842.namprd12.prod.outlook.com (2603:10b6:510:1c9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 08:15:29 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:930:48:cafe::15) by CY8PR11CA0002.outlook.office365.com
 (2603:10b6:930:48::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44 via Frontend
 Transport; Wed, 2 Aug 2023 08:15:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.140) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Wed, 2 Aug 2023 08:15:28 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 2 Aug 2023
 01:15:17 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 2 Aug 2023
 01:15:16 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Wed, 2 Aug
 2023 01:15:13 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, Yishai Hadas
 <yishaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb
 <maorg@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta
 <targupta@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH for-8.2 v3 6/6] vfio/migration: Allow migration of multiple
 P2P supporting devices
Date: Wed, 2 Aug 2023 11:14:49 +0300
Message-ID: <20230802081449.2528-7-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230802081449.2528-1-avihaih@nvidia.com>
References: <20230802081449.2528-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|PH8PR12MB6842:EE_
X-MS-Office365-Filtering-Correlation-Id: f7dcac20-52ef-474a-b5ae-08db9330a21f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8YA24Uxwi/bKly+MJPG1q0mfJidQj2aWe2/F43yAN0BEDt/gzjLhC5KA4e1Zcuf+dWb/9BVFP82XceBrr7RvBgf9Rhgcu30bVhSSrALIhwk5R3JGCMf7eQKvbWbHHA3A9X6fL+T1rb4B6ppKcE5azy03x04CtCNrKOrKUoMfOwOavgly825Ysa3BzePJjOp8Ujgq7vl3L4okdc95Qg8eCkbWpRCc84KBTWV5SEHPdHMCpz3XWIvmbbGL4JqGgGZjdvzjKouH3LUMXXC5mSAhtgttpn46gIum7+MEdXY4iXAsLpz/Y1FBahYyHJSSmiv8Dzqe1zez/psdaD3brxJh0LWElfON2F59b/6f5TTive4zZmNouEal2QOXzMyAI8xXUu628UX0MGEyb6dj1qOmce4QO72J/uTBEHjY0wNd0I9NCKGxU5vSaacPCF100AraVHhxRyhznADEi+efuiYjcVz9LXB8DNgLIqx6d1FhpDNDEvI57gReXVE8XUyan0/Qy+tvjjY896wikElCLun9KwdkU8OZNtpPcM9aVlZM7F6ea8ZOQfdYgGPwx9urHpbPyveJ8aNv5D7zgUjxj4SCyf+AZtQkEqGkmGPS+8GJfmn+4UCExF5Iq+U0D3T/Knv8ecUm+YGu57P+7S/oDVha2rLm+ZmnKQmJ/HBZtZMQszX2W5WNYczKFwcn5j3Zfe54Ah9te9S1du71hh3cNdlw1qBCsHrphPYn9qFRBNXaaiQ=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(136003)(376002)(39860400002)(82310400008)(451199021)(36840700001)(46966006)(40470700004)(8936002)(8676002)(5660300002)(426003)(26005)(41300700001)(107886003)(36860700001)(2906002)(83380400001)(1076003)(47076005)(36756003)(40460700003)(336012)(2616005)(40480700001)(478600001)(54906003)(7636003)(316002)(86362001)(82740400003)(7696005)(356005)(70586007)(70206006)(6666004)(4326008)(6916009)(186003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 08:15:28.9664 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7dcac20-52ef-474a-b5ae-08db9330a21f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6842
Received-SPF: softfail client-ip=2a01:111:f400:7e8a::60b;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
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

Now that P2P support has been added to VFIO migration, allow migration
of multiple devices if all of them support P2P migration.

Single device migration is allowed regardless of P2P migration support.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/common.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 7c3d636025..8a8d074e18 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -363,21 +363,31 @@ bool vfio_mig_active(void)
 
 static Error *multiple_devices_migration_blocker;
 
-static unsigned int vfio_migratable_device_num(void)
+/*
+ * Multiple devices migration is allowed only if all devices support P2P
+ * migration. Single device migration is allowed regardless of P2P migration
+ * support.
+ */
+static bool vfio_multiple_devices_migration_is_supported(void)
 {
     VFIOGroup *group;
     VFIODevice *vbasedev;
     unsigned int device_num = 0;
+    bool all_support_p2p = true;
 
     QLIST_FOREACH(group, &vfio_group_list, next) {
         QLIST_FOREACH(vbasedev, &group->device_list, next) {
             if (vbasedev->migration) {
                 device_num++;
+
+                if (!(vbasedev->migration->mig_flags & VFIO_MIGRATION_P2P)) {
+                    all_support_p2p = false;
+                }
             }
         }
     }
 
-    return device_num;
+    return all_support_p2p || device_num <= 1;
 }
 
 int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
@@ -385,19 +395,19 @@ int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
     int ret;
 
     if (multiple_devices_migration_blocker ||
-        vfio_migratable_device_num() <= 1) {
+        vfio_multiple_devices_migration_is_supported()) {
         return 0;
     }
 
     if (vbasedev->enable_migration == ON_OFF_AUTO_ON) {
-        error_setg(errp, "Migration is currently not supported with multiple "
-                         "VFIO devices");
+        error_setg(errp, "Multiple VFIO devices migration is supported only if "
+                         "all of them support P2P migration");
         return -EINVAL;
     }
 
     error_setg(&multiple_devices_migration_blocker,
-               "Migration is currently not supported with multiple "
-               "VFIO devices");
+               "Multiple VFIO devices migration is supported only if all of "
+               "them support P2P migration");
     ret = migrate_add_blocker(multiple_devices_migration_blocker, errp);
     if (ret < 0) {
         error_free(multiple_devices_migration_blocker);
@@ -410,7 +420,7 @@ int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
 void vfio_unblock_multiple_devices_migration(void)
 {
     if (!multiple_devices_migration_blocker ||
-        vfio_migratable_device_num() > 1) {
+        !vfio_multiple_devices_migration_is_supported()) {
         return;
     }
 
-- 
2.26.3


