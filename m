Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B4B78B445
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 17:20:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qae1O-0002HE-Fp; Mon, 28 Aug 2023 11:19:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qae1H-0002Aq-Ul
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 11:19:12 -0400
Received: from mail-dm3nam02on20615.outbound.protection.outlook.com
 ([2a01:111:f400:7e83::615]
 helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qae1E-0006va-FI
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 11:19:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ID+2CTLjjIfWGhYcxr1dfy9MCmzFD873ryQ1vvRgVBZGU4jb/7gI5sCw47WMU0tavKUJjASVC5/fl07xdZ6lCfz/zwLv1fF4M5pSFAV5fKogaLWWzJK23/4ePqkemfUrvMkLkuQABm2uHMzIFBlCkXMmUgYerUZUMQr4N5n4yH6z6vD49zbUYVZQHhe9jSM44ZaQ4jvd/9hQHxCJbTTXz4coi5rdQ4dLPuHG/VrBLbaApxu0DLcidkgkUdPIt8+Jzehxso91wyqHMFRTZ+d+XVH1hyn9twYPJE9sIC8hPdKDWcYIK/IXP7kl5UPM5jVD0p2nMCZKI1x0qoNSrCUckw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kq11ZFvI+aodT+I4vYkl5Shj8KeJH+7llckm6cpZyTo=;
 b=Aoaq2MUHUqgymaz28helnCRBYYyDld0+4t58CpewDz809r7oyuwL1rrCzkDUr93C2ZYvPxHWm7coXprEVlQ5aoZAIjDTZgiigDHcUIoforg1pX3XmsQAy3gxsSyoo9aMQYMJu16Xy8rmA2/StnVJOUj3IplQhCig6QQNLFDC6xFZk9L6lP2c5xK+P6cY5Z9rICJjtiWXkAv9uMDbA9b/hKx+jVSmMK8C6aJXL1VTHZfeS6fK9wN63J6FrOoPmhL6RvHCumN+J14g9/EYFcrnYt4Co+DDb+qtxfq7twbM7/f5qgciwtqRtgJcnUdGUxdVuB55PHykMA9Udcvg4aJULw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kq11ZFvI+aodT+I4vYkl5Shj8KeJH+7llckm6cpZyTo=;
 b=QbtWsBYoujLXx/SDm/0r5BVH/+4O3Yf5syNkALch5b8R57QCROF51/F/4TPzR0skpldpG4UXdCmJtnGPjwu9SKT5S7gX+6GSZ9FOMylXiAoBhKLUzXrDFWmrO4Y37clgkDatfKph41aHmfl/EOJqMMtAOp0vO92TpI10xEFQg0ZA5dj/iEaR9KI7ssP5+8rU3GAuqsexFK9muNESKwbZH2L6F0qjGBwCtD3XWxcec7t5X3l4NfWpmupGVzdk1d9p+ZsJFCtf/I4SPK7C2cMt0SJCWXcQ/ccg8t3QDQs8ecFmiXiO/pn6mQk3PK6AfwNNi20AHHialPUde3ezvqr0rQ==
Received: from CY8PR10CA0035.namprd10.prod.outlook.com (2603:10b6:930:4b::20)
 by DM6PR12MB4107.namprd12.prod.outlook.com (2603:10b6:5:218::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 15:19:04 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:930:4b:cafe::1c) by CY8PR10CA0035.outlook.office365.com
 (2603:10b6:930:4b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35 via Frontend
 Transport; Mon, 28 Aug 2023 15:19:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.17 via Frontend Transport; Mon, 28 Aug 2023 15:19:04 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 28 Aug 2023
 08:18:55 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 28 Aug 2023 08:18:55 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport;
 Mon, 28 Aug 2023 08:18:53 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Juan Quintela
 <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, Yanghang Liu <yanghliu@redhat.com>, Avihai Horon
 <avihaih@nvidia.com>
Subject: [PATCH 4/6] vfio/migration: Change vfio_mig_active() semantics
Date: Mon, 28 Aug 2023 18:18:40 +0300
Message-ID: <20230828151842.11303-5-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230828151842.11303-1-avihaih@nvidia.com>
References: <20230828151842.11303-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|DM6PR12MB4107:EE_
X-MS-Office365-Filtering-Correlation-Id: 33556242-a02c-4536-3ed1-08dba7da1d8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v9OGkYid/LkDIQooZi6x0GyFn2qqfDg8EWL0ylaK4YIxEeKmqDHbyydOvcVaiP1YTcv1ioaa3JrKZzgwvTWgYwMAxfRFyQhILoFPfUzVW4P/1IwS0KA1BVFGnNtFLqz5bi5/5Otb3GCPE8skiD+dAhr2WU3Rmzaztv7yNGJuv0s6VqN7+BiZ33RJDwU9XA4aDEVYjbTIkhGnmKmoOFey65EfvLwShjRKirZ0csG1dp5bbH4iAuGQbaO6+R5KI4IP2vUKgquob6e6rGpCns3p7SNnUV66yr/RWHKmC5I2tOTD2Ig8FemkXrrUNWBKxsspv32eiJAU23Ew7MaJcurROe7C7vTc0acTwyi3cUc4Q216+HLjskmNX8rJQP8Ff/xVqfBv9x85wuf5WUNmaq7PRz7M3ZZjT7aegtuS3TqbXWw6Thrd/52Abgo/K8SC0G7CbnrJeOopl9x6ezOt78yIP9Wp5zqtYeomqwRsBtS2S+LegbjqV3E2gcbL67k8/IqdXYU7Kna37gVJK31ejgXRNpllGsoite6EScrfPgviq68eB9hVqL8fNfv581ZzJEgTuTm77oKGSeYGrNjOGIw0xyxLOd6AtbdRAOWsCT3aMfDM+gNSpC8cP0tniTltUia7zEiT2aWe+iFApLybB2j5Cnm06ned1h1t4vbC6fmJ9M6fU84UgxHRF2oHLFb1qjLmsaTjUJYy0PFsbyUe0oBb4akJXgxZFQvICqN5wqdhuAn/E4YWXtsZF9Sfji06wyEF
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(186009)(1800799009)(82310400011)(451199024)(36840700001)(46966006)(40470700004)(36860700001)(40460700003)(41300700001)(356005)(7636003)(82740400003)(6666004)(86362001)(83380400001)(478600001)(47076005)(2616005)(426003)(26005)(336012)(107886003)(1076003)(7696005)(40480700001)(70206006)(70586007)(36756003)(54906003)(6916009)(2906002)(316002)(5660300002)(8676002)(8936002)(4326008);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 15:19:04.2755 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33556242-a02c-4536-3ed1-08dba7da1d8f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4107
Received-SPF: softfail client-ip=2a01:111:f400:7e83::615;
 envelope-from=avihaih@nvidia.com;
 helo=NAM02-DM3-obe.outbound.protection.outlook.com
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

vfio_mig_active() is used by migration_populate_vfio_info() to populate
VFIO migration info when it is active. Currently, VFIO migration is
considered active if there are VFIO devices and none of them has a
migration blocker.

Change that and consider VFIO migration to be active if there is a VFIO
device that is using VFIO migration, regardless of whether a device has
migration blocker or not.

This is done in preparation for next patches which will block VFIO
migration with postcopy migration or background snapshot, as they are
not compatible together. It will allow adding a migration blocker for
such cases even if the VFIO device already has a blocker.

Note that migration_populate_vfio_info() still behaves correctly, as if
there is a VFIO device with migration blocker, migration can't be
started and thus migration_populate_vfio_info() will never be called.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 hw/vfio/common.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 57a76feab1..373f6e5932 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -342,25 +342,6 @@ static int vfio_bitmap_alloc(VFIOBitmap *vbmap, hwaddr size)
 static int vfio_get_dirty_bitmap(VFIOContainer *container, uint64_t iova,
                                  uint64_t size, ram_addr_t ram_addr);
 
-bool vfio_mig_active(void)
-{
-    VFIOGroup *group;
-    VFIODevice *vbasedev;
-
-    if (QLIST_EMPTY(&vfio_group_list)) {
-        return false;
-    }
-
-    QLIST_FOREACH(group, &vfio_group_list, next) {
-        QLIST_FOREACH(vbasedev, &group->device_list, next) {
-            if (vbasedev->migration_blocker) {
-                return false;
-            }
-        }
-    }
-    return true;
-}
-
 static Error *multiple_devices_migration_blocker;
 
 static unsigned int vfio_migratable_devices_num(void)
@@ -446,6 +427,11 @@ void vfio_unblock_multiple_devices_migration(void)
     multiple_devices_migration_blocker = NULL;
 }
 
+bool vfio_mig_active(void)
+{
+    return vfio_migratable_devices_num();
+}
+
 bool vfio_viommu_preset(VFIODevice *vbasedev)
 {
     return vbasedev->group->container->space->as != &address_space_memory;
-- 
2.26.3


