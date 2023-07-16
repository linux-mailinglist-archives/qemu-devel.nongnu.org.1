Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D86754DD1
	for <lists+qemu-devel@lfdr.de>; Sun, 16 Jul 2023 10:17:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKwvf-0007qK-8c; Sun, 16 Jul 2023 04:16:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qKwvc-0007qB-PR
 for qemu-devel@nongnu.org; Sun, 16 Jul 2023 04:16:28 -0400
Received: from mail-dm6nam11on20601.outbound.protection.outlook.com
 ([2a01:111:f400:7eaa::601]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qKwva-0000sL-Te
 for qemu-devel@nongnu.org; Sun, 16 Jul 2023 04:16:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BedhcfP7vnQ+4mWJAsVEiEutSFGLQuhbswxJ2QdM+bsjBGtM1cujtg06kkx6lDttHac8+adp18aGYy3Jvg72og3Zb1zrJrZ4UqSupzUNDykTjaUdC/ujEmsZym+SWw5D+er3Fb4YjP7fEPrUhFejvWlbGTxzCNem4/nqpkoMoauxsd2Oyj83MHXBvgBF75DjDhxOtJKQo6ohBWHDQYyBdH366dRGwGUEOW1cZbFLBYLg0QZpnOYZLZPL6zSnUC8z7UQpp75jPdJStG+kfT7Fp4X6ohv35TGt1qopYYnOqRF8NDDm/zNhhm/64jWajI1nXAbeG1aBZiOt5eOeNf6ZEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h5MEdRwV72R6OIjCi9arCh3dkqRH9me6j9H6FsOjMuA=;
 b=TG59wPLOLx9VDhnbTBiFj15pYlG/aTq7JaSdR7CjiiHKugn0PDE5HHqiowZZ6EaqhwIW1CM3KNQgeax4ZoqnLzR+fdpbr4N3ksJXMAp+Eay4RQFyUsumfpyXznAYiH47FQy88UAgOKsD0ISz1EdzhQv1fpCz3MAEK+UrnrYzo/1F2MDU7k/YM1V2+SEOaQeaSZBkXbrOhQbZn9LIARAm9QdiLc5shrwvwW8eqZlyuhIcJb5MSSUPjZuRo+0PtLLORm7qpfx0nWvguswo8HRFWoFBLv4+YncZzsVrRKjRMdNqFZumqGd5Cf1lch1y0EzBQjkuD6nkyiNTRpDkjfrfLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h5MEdRwV72R6OIjCi9arCh3dkqRH9me6j9H6FsOjMuA=;
 b=BlZtD8DVzyd5Wk7ozrMgFSNzmQAkUeayio/LkjID1haZaGVK04MKxAvPtACqPenis3cntLnl/lj6LJ3ppbpjhlLXP0zmRk1pJ+YF2kOJfg4S2DSy14amWtTFq0weEp2oRBmOsFuXDip/j577qCgx9tRHLk//SfQovhpH/rSj6hwqWUs8g7ozVJoO1tRKdtvlLJHQ/8tsZJjPv8vH0C6GcTbomkUklAp/VWxhW4BWxrhK8wv7yvxJXkVC7MwwQ8fGa9cV8eWVLknJEmox4tECy+lVEJdGP5zD7h3YGiiJqcZD282A115Oocj1RxHJy+WXYxEuexx55xeKQ9QncywdIQ==
Received: from MW4PR03CA0127.namprd03.prod.outlook.com (2603:10b6:303:8c::12)
 by DS7PR12MB5767.namprd12.prod.outlook.com (2603:10b6:8:76::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Sun, 16 Jul
 2023 08:16:18 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::55) by MW4PR03CA0127.outlook.office365.com
 (2603:10b6:303:8c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32 via Frontend
 Transport; Sun, 16 Jul 2023 08:16:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.28 via Frontend Transport; Sun, 16 Jul 2023 08:16:17 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 16 Jul 2023
 01:16:05 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 16 Jul
 2023 01:16:04 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Sun, 16 Jul
 2023 01:16:02 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, Yishai Hadas
 <yishaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb
 <maorg@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta
 <targupta@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH for-8.2 6/6] vfio/migration: Allow migration of multiple P2P
 supporting devices
Date: Sun, 16 Jul 2023 11:15:41 +0300
Message-ID: <20230716081541.27900-7-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230716081541.27900-1-avihaih@nvidia.com>
References: <20230716081541.27900-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT065:EE_|DS7PR12MB5767:EE_
X-MS-Office365-Filtering-Correlation-Id: b55c7435-7103-4d5f-3d72-08db85d4ee58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7TaTl/99q9M0XPec72DUjAsvq+R3LIPA2QAN7cZX7tnpf7hARy3WkxBkmnRnyJqPnrIXKzLcA0b0pHZ9CNfkg/uehQjvLNN7YayavhBmuWQ6ByXVGzz68vmbmqCIQJJRCQiiEECPF2vYN7hAg1xMG1mzaoN6gaGP3ECJUFxIcKcO5xfKfgmu9o8tmwQyS1BYok/qfjHaMmKWmnF2HwA1vrsYUhqJuUe1Jq3G6o9ln9uUIQxHGFHbp9s1ye/fswOdVfiM9mvNWHsFXR2M+ye8n+MPCdqu07sGrv36CuU5R4ZazEmq/car6vieg0ixwW25u87+6aMKRY/YbBjRRZeENvhEBbmRdecHIh1jtHrH3NvbTl4/hXeG8LmN7zBVOsTj+xXh+Agh+9vq6Ab1ntg3KxiFY855X5aJfIX1c6Q/A75tMr0jdhaUpwp22LQePJdgre9VwcwHsEx+mCpc3pX4MLduK4+ibDRtglYibts5bAUHZOqs8wNOa3F2J7ygba1VRFEWFSpYGv1iLIiUVgth/OohDBq7EXzek+Z4Nrwa1xHQ773cabZUd2yhGmkYlXcPjgcyuNYdTc7oOHqn/q0X3ZrTT79s2F3nCXLhj+REccTjlbDlzaUe/SXYGwSEs8LbCEwWRRI/6pxHMc0pZUVo7DEyCtwZw2PU7gSyKjE4wOOOuLPveJvBTZH2qeuqXiMOqRxWIdRAa7PEQpHoSbFKVpa38UjCm468PfUacHqdRBo=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199021)(82310400008)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(6666004)(7696005)(107886003)(4326008)(70586007)(6916009)(70206006)(478600001)(82740400003)(356005)(7636003)(54906003)(83380400001)(47076005)(426003)(336012)(186003)(1076003)(26005)(36860700001)(2616005)(86362001)(36756003)(2906002)(5660300002)(8676002)(8936002)(41300700001)(316002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2023 08:16:17.9816 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b55c7435-7103-4d5f-3d72-08db85d4ee58
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5767
Received-SPF: softfail client-ip=2a01:111:f400:7eaa::601;
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

Now that P2P support has been added to VFIO migration, allow migration
of multiple devices if all of them support P2P migration.

Single device migration is allowed regardless of P2P migration support.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 hw/vfio/common.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 7c3d636025..753b320739 100644
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
+static bool vfio_should_block_multiple_devices_migration(void)
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
+    return !all_support_p2p && device_num > 1;
 }
 
 int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
@@ -385,19 +395,19 @@ int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
     int ret;
 
     if (multiple_devices_migration_blocker ||
-        vfio_migratable_device_num() <= 1) {
+        !vfio_should_block_multiple_devices_migration()) {
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
+        vfio_should_block_multiple_devices_migration()) {
         return;
     }
 
-- 
2.26.3


