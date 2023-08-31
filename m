Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA2878EDDD
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 14:59:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbhFt-0003C0-HB; Thu, 31 Aug 2023 08:58:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qbhEs-0002lI-FV
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 08:57:35 -0400
Received: from mail-dm6nam11on20614.outbound.protection.outlook.com
 ([2a01:111:f400:7eaa::614]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qbhEl-0005Do-9K
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 08:57:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZHdWEsE8m/ghnWK5t16xLJ+OVORU5aqx8Q7MFoHKbnQS7p2Pu7ZyhfGgmzdMATdtO2nmy3LnFAanycUImMelSPyS8N0k1U6BFZu8RpVM+1rnqtMYJPG9GMAIaRGV5SbWQA2ksA6FbcjeIB5SfRafb18B4J2QAKkVS99v2olSv9LmNfX3+zysyXKOO3rMDlPnSkFU/IR/VKuUYCGoxtmypAzrI9plqE6j5hoqC62DrVOy0ycpVG5Y7l8bqzbpFIZFvQKjbMlu2gOyt2FJZ2a/SVk+vTqGIJna1d9ZCjCz/og5wSt6LHpacz0ZVrB1gso13ftAdYqtOcEP3AtAMrJuZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FotuBtmavqR9dkaD1yotgN9OXacIbAe0HgjsL8Lx8Hk=;
 b=jlc1uOstOKWUB38XnFivSF+QU8pTrEmA7BHCnFzNG7TflPS+MhO3w/jlQQIhwx7SAtg1v0jauBz4HihoVR4NqOnyrf7neEcMZPxyxWppj7gieY2OAUabzKdebVdXE2G8pApKrgjaOLsb/hx0g8laK4FLaKBsrCppU0u+XS64s4w4xUtDu1fpESoFizn2Xt/R8e+APjDJQkw+UsaF9wvPrzYABAg8s9ry+IOet7D3KfEw4ywVNqt61zgL5V/Y6qQqYKa+uqKBVHajjzISP6NzSm51Enoea5Ata7KlTIxEo+VWOjuRLfyvsYZfJ8e1MEyelIzNh6yZTcsBgcPCw5Hk1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FotuBtmavqR9dkaD1yotgN9OXacIbAe0HgjsL8Lx8Hk=;
 b=gtrki8whTLrbU6x9jkkZxrXupdux9opGishH4v8xGf0UPw+nipk0+jX7w+d1Q9eMbEMzXlomNH53Ln6mez/c9PJ/XA9qmmTSuHY7MgNxPZaGp08ZwoQ9TB566OkikGTm8N/3qT9KysJerkw4QUtyVGN2tYydvfoVFp7C7XW9yryIx5KCHG/+o+bGUYm9cmynu6GoZwxXXAWGRe+q7Qvzrzyyc3/ryykytUfydTGAJyn6ClVn4JQzmNz656icI1DSyC+W8lCsqGRkUnfUBH6139z9ozok/uZ9YsTadqAOdkWnLqDY86enH9g2WjRp3rZnVWG2AZARidV2LD1wVO+CUA==
Received: from MW4PR03CA0059.namprd03.prod.outlook.com (2603:10b6:303:8e::34)
 by BL1PR12MB5222.namprd12.prod.outlook.com (2603:10b6:208:31e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.22; Thu, 31 Aug
 2023 12:57:22 +0000
Received: from CO1PEPF000044F9.namprd21.prod.outlook.com
 (2603:10b6:303:8e:cafe::21) by MW4PR03CA0059.outlook.office365.com
 (2603:10b6:303:8e::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21 via Frontend
 Transport; Thu, 31 Aug 2023 12:57:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.2 via Frontend Transport; Thu, 31 Aug 2023 12:57:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 31 Aug 2023
 05:57:10 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 31 Aug
 2023 05:57:10 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Thu, 31 Aug
 2023 05:57:08 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Juan Quintela
 <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, Yanghang Liu <yanghliu@redhat.com>, Avihai Horon
 <avihaih@nvidia.com>
Subject: [PATCH v2 2/5] vfio/migration: Fail adding device with
 enable-migration=on and existing blocker
Date: Thu, 31 Aug 2023 15:56:59 +0300
Message-ID: <20230831125702.11263-3-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230831125702.11263-1-avihaih@nvidia.com>
References: <20230831125702.11263-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F9:EE_|BL1PR12MB5222:EE_
X-MS-Office365-Filtering-Correlation-Id: b4da71d9-231a-4162-a1d7-08dbaa21d0e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xD5usAsbKv4EcWj4rzSezK4RXF+uo/HP9/7qewgXa+nKdOwNRnSzB34StbGKJyhYmVejvN28mZ/RHmI6sb5ngrqDERLoz7niqWDZJtJSOEwoWQpTTSX6HCxoE/4FXkxGAAMaLgL03iRA6zC1cqakzM1IbyQsH4nqrMawEw1pX3I1zrl93cDthstUUB3hCNxwQd6etaMv1pMR4TfzMpf+FqPRAZKDOJdRcx5iCLiYiKcWiYYCpJbgiDGLYalYveAugaySGxaeFcA88zR3MkxStSKrEjEpyjm7h4R4vYg94wjkb1IKNU/8d7/K626qKu5QGL9K+HvXUCAsDCof4rPf6XP5gzd36gMvEILFXDI+a/fLkBog7Lm0b3CpJ3sPbY9kLfPpvE6FNAt7QkOxeK7DWjlH5bVuaJuAvUvjaFGbPkHhWkpzsqAlmFDvguqHqwCKjS+Gx43WXQ/E0hKQW4B8+NexEc2/Cr2A5zvM5wNFoDP89PROvwXd9FZ9EPivJsUESTgxrsNyH6OWAr08F3G3UFJIHZxLw7lkTelKG4vlJZ36Fp75yg4gQYViZcE7oT14VfK1UYeCjb7EV4Bj2eySd2LpfmY6Y0B6L6A6eq26RbFD5wn0/CaXLCbVFw0qeGD745qMVVo/ImyXy1G9TsQyPFxfyzehE0B1GUN0BaFHxvB+yoqL5mDoRnKiW88PKVxz2QtECLLp1plg/hQVtINO/wtYqMoYesL5TlSY2KSRaxr4rnO9Eik2ZFcUmEjgsxP7
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(136003)(396003)(376002)(1800799009)(186009)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(41300700001)(70586007)(70206006)(40460700003)(86362001)(2906002)(6916009)(54906003)(316002)(66574015)(4326008)(8936002)(8676002)(107886003)(2616005)(26005)(1076003)(36756003)(426003)(5660300002)(336012)(40480700001)(83380400001)(82740400003)(7636003)(356005)(6666004)(36860700001)(478600001)(7696005)(47076005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 12:57:21.7512 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4da71d9-231a-4162-a1d7-08dbaa21d0e8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5222
Received-SPF: softfail client-ip=2a01:111:f400:7eaa::614;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
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

If a device with enable-migration=on is added and it causes a migration
blocker, adding the device should fail with a proper error.

This is not the case with multiple device migration blocker when the
blocker already exists. If the blocker already exists and a device with
enable-migration=on is added which causes a migration blocker, adding
the device will succeed.

Fix it by failing adding the device in such case.

Fixes: 8bbcb64a71d8 ("vfio/migration: Make VFIO migration non-experimental")
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/common.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 8a8d074e18..237101d038 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -394,8 +394,7 @@ int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
 {
     int ret;
 
-    if (multiple_devices_migration_blocker ||
-        vfio_multiple_devices_migration_is_supported()) {
+    if (vfio_multiple_devices_migration_is_supported()) {
         return 0;
     }
 
@@ -405,6 +404,10 @@ int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
         return -EINVAL;
     }
 
+    if (multiple_devices_migration_blocker) {
+        return 0;
+    }
+
     error_setg(&multiple_devices_migration_blocker,
                "Multiple VFIO devices migration is supported only if all of "
                "them support P2P migration");
-- 
2.26.3


