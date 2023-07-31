Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BFC76931A
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 12:28:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQQ6t-0000gl-JG; Mon, 31 Jul 2023 06:26:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qQQ6M-0000cq-IR
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 06:26:12 -0400
Received: from mail-dm6nam10on2060a.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::60a]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qQQ6K-0006wp-L4
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 06:26:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NY9MwYxhW06Oqz2lKQxPmlg79Pjsrpw8fpinFQf+tmkpTAEzGaL+ak7asGx18WaijQCCWwwZvWH7q7Lb+Ognb/amzSF/jfjvfKIV5Jou8CihhmIQ7Lms5BlBTXbO+T78RtysKbxSP8h/23ZS6bsYGRPfEF3hq1X+0zzo5gwW09L1fH9uf6LpXThEmKgOrEO6svffp75+IQu5JJ4dYk3QzMXwEYtsfYpSJjwOWp1RQfS9VQ8OiyKJcFatfmCaPVuSfvThV9JVNV1xUbLFxnGT7P6+9CatxFjsfZopHAyuV3wxKxHx0RxflKS0+fQn+Qv6VcY38ulA+bHTXbxw7mz68A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+2Cpf03ijBTQMum1kFbRQc13/tGU/Zo1ftvlQgxELvw=;
 b=WXEkeqxmwGTxDX6GfAIVad1oA0XKZCJXrLdy9h41v7wnTdR/9mDw0bjx5JBTcSPtc8klEPGlocFB3jT17hy1Ze1fLsbezujr5c984yBvbemvonCuXkC65umY5Yw8X4Kt55Cg42Ac7bL61fMeHEqoYuyq3Dg4Y00VBED63KPy1uxe1qIWp3w0z55bc+EsvySZ9ioeLv3kONvnxpUYy0OGsAonpRK2sFjjlI3aJHMe2SaX/R8cK8Atlgv+sL3AuGaJ3++D1A5WqVjYA1X6IY810ZpQ/4uYvvfXuJJK/XEptGKD1++bDnHVYDHclSvNy+2T8LqbHXKVjHD0hRFVUQ82tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+2Cpf03ijBTQMum1kFbRQc13/tGU/Zo1ftvlQgxELvw=;
 b=th0FT/lBHgYGW0qtUaxQ0k80+8+FAHlMYxpkjFAxzjZ/On0RomG6Sd3CxV/HLObunOBjbYT33TBokoVvv2afbEEM3ipt2fKoROHnkWWVoqWZ3hGqcYkZIQNJufOxUWkcxtEB5ckptNuwQx0v1o8gVTCebGvjhm32GyKUvceBxOLYz3N8dnbRNcPc8AdtAvJIWcIUhMx0cOHJeibeFEJlg2mtZ6JfDRDPIL0aDLp22nXBmsqseiVof5bVbxCHTG/foJsUSdQDW2BikgAJZkAU6auWbgHN2zYVB+X0SoQiuc7oXE/KPCy4nEB44GKIh6ndbyqQGSfbXIByrp7eL21YQQ==
Received: from MW4PR02CA0005.namprd02.prod.outlook.com (2603:10b6:303:16d::14)
 by MW3PR12MB4396.namprd12.prod.outlook.com (2603:10b6:303:59::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Mon, 31 Jul
 2023 10:26:04 +0000
Received: from CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::a2) by MW4PR02CA0005.outlook.office365.com
 (2603:10b6:303:16d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44 via Frontend
 Transport; Mon, 31 Jul 2023 10:26:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT023.mail.protection.outlook.com (10.13.175.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.44 via Frontend Transport; Mon, 31 Jul 2023 10:26:04 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 31 Jul 2023
 03:25:46 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 31 Jul
 2023 03:25:46 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Mon, 31 Jul
 2023 03:25:43 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, Yishai Hadas
 <yishaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb
 <maorg@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta
 <targupta@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH for-8.2 v2 6/6] vfio/migration: Allow migration of multiple
 P2P supporting devices
Date: Mon, 31 Jul 2023 13:25:21 +0300
Message-ID: <20230731102521.15335-7-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230731102521.15335-1-avihaih@nvidia.com>
References: <20230731102521.15335-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT023:EE_|MW3PR12MB4396:EE_
X-MS-Office365-Filtering-Correlation-Id: 121ec098-408e-4a70-9437-08db91b08b7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IzVBQ9yZq9BY3c6m+M/RA54E4T6l/MoiDzZDQgztYSoMfXvUAuYzpt2pdaciG/Ig/UgIlkC64Mimu81F/f7T5OvL9AtvFHLPFcBUcupOYE0eaLQ4XoHeQaL2GFD2U53kB7GO5OARzaeovSzuFfnOZ9hCViR2L+uZL2VboOmQ0D23BrbeTZ5KymTAXFFwdMP26xAEhfswCQ9LzPfCTRhXfAdMySxDyOGpct9lWVbQ6PvNWVnuxSHJ8sp/GhcySJhN7eccs0HAWnf5+CYokuVvROKiXjDK9muWU3FYXp/cP7ZQO6VBk3PCA7ThuIz62kZE0A8/bagvDPpzraa0rXZYaBgsV41L3gY86IRVunvypZcfctL68gkgUuI4Lgj6PSBosFcbwt3U6PeirutzFIcnlELA67xctolaT1HAIUDRHrHGF6S8mm1D+94cx045F1Gsqkrdo9RJkcvIqfBENDhdjlw2pkfM3/Qy0DWblXgZHr44/hgg5i1Z+x2sqgpE19CUY/xR27lHY2MKc+tNQrTU4TIhk7r/AGVus23Z5Dj5SH0OpxBGkH05A5IMzRQzdQiRvD+PE4PKlOTIS7Qw7XgWP3XgwNYYRMQTsSy2Sgco0dL0+8mbCpSEPHtqELyJJ4A2zHgLNDEdqpKT8km7TCHLlyWZKpMC8W/bw8QTWymUJf172t0hmPn18euHkIQ9vDlDgdQxnBvyNLT853NX4qgiQU17SdZmLF1KneCkew64I6g=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(136003)(396003)(346002)(82310400008)(451199021)(40470700004)(46966006)(36840700001)(82740400003)(356005)(7636003)(40480700001)(86362001)(36756003)(40460700003)(6666004)(478600001)(7696005)(2616005)(107886003)(186003)(336012)(26005)(1076003)(8936002)(8676002)(5660300002)(70586007)(70206006)(54906003)(2906002)(41300700001)(6916009)(4326008)(316002)(36860700001)(83380400001)(426003)(47076005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 10:26:04.1832 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 121ec098-408e-4a70-9437-08db91b08b7a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4396
Received-SPF: softfail client-ip=2a01:111:f400:7e88::60a;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
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


