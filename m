Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1730878B442
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 17:20:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qae1S-0002RL-53; Mon, 28 Aug 2023 11:19:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qae1G-00029q-1B
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 11:19:10 -0400
Received: from mail-bn8nam11on20601.outbound.protection.outlook.com
 ([2a01:111:f400:7eae::601]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qae1D-0006vZ-G4
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 11:19:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lmWdtcqfHvI311InJ06ZJcsPwrakmV5nCNSC+CItnkkmUZDmR1Jf4u94Wvmi1YuDtadOor4cq+6ZZfZbXCMUlHbnnUiMiPheVE6KFl81PCad21HJzbhyh5IqxPOJ7uGMHI28xTDetDr5THM1GfmpDrjiAGPAleRAMWDjLi05tnMmfNyg5mhUmmFmd5ZlomxtY/mqdys8oQv4g85C6TQt/CXUJv8O8vNJR4N9alpzmmht/FAbiz710xAQM12LjjlXcK/iSyl0gMxdfhVfYhJXQ8cAXd/NiWxiO7+FTTHKuB/tVWgwu6xftCUNrVNEFCHPpzTIq4kgrOYmoK29mDY9Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ku1KexpIv4gEfzcN4VFmXzotJNNzhBJ7AosgGlJ/DfY=;
 b=afA1MkGvsyo3WlkD/TerKCYzLpIjaWdmqk1U8wxu5zeac58idq7NBeubyps6+iaxfj8dwDynWhY6dWqFVxuUOCDuoE1C/o+rc1MvcgMwiGvYhRJlp9IBzrZkwTmYthUfcmmIIuchsQ3q/Il80dwZMeY7jlT/7ofuXJ15hbPmPn5EgokiiwwvfOBJf/dDLe4uzIpYb2RTffHdd0BsZjP70r3yYO0A2xq9MDZ8PnhBXWvtwsmZnhpHLqfxiKsZB0SziSW6VWLgsu2yBOkPUMlVhDFRndql0BK4RVwJG3eM2/aNoaXCGi5kRQfPxy/kOFLNoPG7i8LzJFb6/oCaqut2xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ku1KexpIv4gEfzcN4VFmXzotJNNzhBJ7AosgGlJ/DfY=;
 b=mlP6KwbXbePa0BR2E6ebeo8ALmLMsAKm0IXK7xnchjuzXhUgcMKZrwXn3pGpmQeEJlRqSyo7gTs668YXqHtM8xYajAYJtvrAKI2akqv3HiyCb1wQyzto0eYYsn/i3UhOwE3UMivSEyifjdX3iqyfBxyxxgTQImdy932elChvXtL2lIPZOgRFvAgMbJ1BuSljoJokJHUGglAtkYKlZ7FdgxEDUHDX6rp83enSoYvTOg8KoORpr9hbGQk0oTKto/EOtRZYeXLw2R51FK1SS1+acWfBwHSO9Aw13aoqQp2BiNBRqkGW6GZhGhh9aOjwSv7oeW0XchiifcVfEz0aDhBtwQ==
Received: from BYAPR11CA0092.namprd11.prod.outlook.com (2603:10b6:a03:f4::33)
 by PH7PR12MB7939.namprd12.prod.outlook.com (2603:10b6:510:278::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 15:19:02 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:f4:cafe::d5) by BYAPR11CA0092.outlook.office365.com
 (2603:10b6:a03:f4::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34 via Frontend
 Transport; Mon, 28 Aug 2023 15:19:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.17 via Frontend Transport; Mon, 28 Aug 2023 15:19:02 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 28 Aug 2023
 08:18:53 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 28 Aug 2023 08:18:52 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport;
 Mon, 28 Aug 2023 08:18:50 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Juan Quintela
 <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, Yanghang Liu <yanghliu@redhat.com>, Avihai Horon
 <avihaih@nvidia.com>
Subject: [PATCH 3/6] vfio/migration: Add vfio_migratable_devices_num()
Date: Mon, 28 Aug 2023 18:18:39 +0300
Message-ID: <20230828151842.11303-4-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230828151842.11303-1-avihaih@nvidia.com>
References: <20230828151842.11303-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|PH7PR12MB7939:EE_
X-MS-Office365-Filtering-Correlation-Id: c7e4f00d-cdb5-4510-7426-08dba7da1c5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jdpH4Ah/18fWy7C1E+3ChpJ2xxjV/gtBJnPJwbBsLJ9hzOfgdxr1bjfW41009xvgwjpX72JOZ+lFyI9PC9Js2qg+5yi3Nl+yQwlcjBJRwBLeoT6VwInJYM6XNVRvPFwIuNNOZ2S3/aZ7bNpioYTZ0yv9TuS81rLHS0rEgPzmkuxFmw/sqYig/X6sqctnJmWWGB34KMb8BauHWjYTiM4SZlqf6uPUWBd3Hkrs/FQaz8XzhxDgv2eoZJtS8NV4QpMzuHUMsbtHxsa15ec/auvJHlyZCr1w8REyuUqPUWjTYh2OQluydB6Sk0XLhlgjlrOUOaBSgGBNjPPBbnjGUtqp4H6SW7D0HtHTTX779zje13NKV2AFRpBLIRSNQR+9CSyyQ2eO+O80LkJdWmUyi2folJUemHSlrXOSow2zeXeMhjamx6EL7afhK69d8HJyALaYNW/kmkPvV0gGPATnp1+yPSM1GX8Pc2dm+4ax4ZXIAe/aiCvL5axl/Z/PVEyxkAhsjKCcdISE6SivI93P0YVZW052MarOjvxZsptzFB44cLOcmqhX5haPD7anyPtzQmjIxO6+0LI/aK3SgLNtFU62zRLLJffDKgOEZBYoiNp8FUE0sKS8hHlR4jCtsLNW6xLPdlGUJ+PFwdteNhVpN/p1nWwe2NVMyT4YwkIIKaBpwB2F4RSzWd34q2ccyggXFDGhupfMnnSLx3dtBqFsfeN4MjlsNdrbcolJ4cvvuranrtY=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(136003)(396003)(346002)(186009)(82310400011)(451199024)(1800799009)(40470700004)(46966006)(36840700001)(7696005)(40460700003)(6666004)(36756003)(40480700001)(86362001)(7636003)(82740400003)(356005)(36860700001)(47076005)(107886003)(2616005)(83380400001)(2906002)(426003)(336012)(26005)(1076003)(478600001)(70586007)(41300700001)(70206006)(8676002)(8936002)(5660300002)(316002)(54906003)(6916009)(4326008);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 15:19:02.2624 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7e4f00d-cdb5-4510-7426-08dba7da1c5e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7939
Received-SPF: softfail client-ip=2a01:111:f400:7eae::601;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
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

Add vfio_migratable_devices_num() function, which returns the number of
VFIO devices that are using VFIO migration, and use it in
vfio_multiple_devices_migration_is_supported().

This is done in preparation for next patches which will block VFIO
migration with postcopy migration or background snapshot, as they are
not compatible together.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 hw/vfio/common.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 237101d038..57a76feab1 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -363,6 +363,23 @@ bool vfio_mig_active(void)
 
 static Error *multiple_devices_migration_blocker;
 
+static unsigned int vfio_migratable_devices_num(void)
+{
+    VFIOGroup *group;
+    VFIODevice *vbasedev;
+    unsigned int device_num = 0;
+
+    QLIST_FOREACH(group, &vfio_group_list, next) {
+        QLIST_FOREACH(vbasedev, &group->device_list, next) {
+            if (vbasedev->migration) {
+                device_num++;
+            }
+        }
+    }
+
+    return device_num;
+}
+
 /*
  * Multiple devices migration is allowed only if all devices support P2P
  * migration. Single device migration is allowed regardless of P2P migration
@@ -372,14 +389,11 @@ static bool vfio_multiple_devices_migration_is_supported(void)
 {
     VFIOGroup *group;
     VFIODevice *vbasedev;
-    unsigned int device_num = 0;
     bool all_support_p2p = true;
 
     QLIST_FOREACH(group, &vfio_group_list, next) {
         QLIST_FOREACH(vbasedev, &group->device_list, next) {
             if (vbasedev->migration) {
-                device_num++;
-
                 if (!(vbasedev->migration->mig_flags & VFIO_MIGRATION_P2P)) {
                     all_support_p2p = false;
                 }
@@ -387,7 +401,7 @@ static bool vfio_multiple_devices_migration_is_supported(void)
         }
     }
 
-    return all_support_p2p || device_num <= 1;
+    return all_support_p2p || vfio_migratable_devices_num() <= 1;
 }
 
 int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
-- 
2.26.3


