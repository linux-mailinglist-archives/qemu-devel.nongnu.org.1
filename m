Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9987164F0
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 16:49:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q40f3-0003BD-9F; Tue, 30 May 2023 10:49:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q40et-0002cK-67
 for qemu-devel@nongnu.org; Tue, 30 May 2023 10:49:11 -0400
Received: from mail-bn8nam04on20631.outbound.protection.outlook.com
 ([2a01:111:f400:7e8d::631]
 helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q40en-0007qo-Tq
 for qemu-devel@nongnu.org; Tue, 30 May 2023 10:49:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=diFkmGboWATu2VhqosjNvHZQzFavK5VIg0fq5LHvaZJM5HrBKfu2RPOcj/ugM9OtikqCgKhuJ/QgQSSBRbStjDKdVeJ+KeVbU0JRj2QoTOv9I/osT0okU5DEP+CHDdM+vHE6caBxyrzAKYwS2p9+hVtIKsD9+h1dUJzOkz3CSX5FyT+qywVmmo1flf82GrNEXLKtTenoVtO5rh5IsADDaIsAJa5+cDKnbsXvrNcUOaHpLPMNISMC7jncOEbD2J3WfSydJXomd3ZnSp/crsinLGvslKKk+cNpPEiAiIYzigBQRoo0dTDwPs236+Nq8lrpx9xBkT1n2wnMY4rvqoXtyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h68j4Dm1Q/+H4wT8g4CxjcyAuM4Dnwee3te5mdFcdNY=;
 b=Z8pjTdAN8t1cvzyWYvEYvGnK0vLnxdH+93RxsBFYraT4pgXtcevwkQswjM0KHtpXLBNvbwL2boE+OYOnaE6YE+zOviQwtjE3sQT5LztvJGKbJRomYmPcxsnJFjZiKBxRNGaOGHJnPxTnd9AzWaxqP1dvrYTFPZfV8y6ypk+AfWZ0swV3BIVyeq/gaUJcLwWUbcKdL07lLus1mCrPM8Cr1EnUFuH6BlHbUamVTdUOhu3RG/tdeNEakvrROoouIA5c5ZmWNZRwOEEcEpEVbTI6tJxXNIl9jbFs8VR8FDea2E0Ol2tv1c3HFOtaNxWCw3qP5nFSlbi0EUhqubMh7/fPkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h68j4Dm1Q/+H4wT8g4CxjcyAuM4Dnwee3te5mdFcdNY=;
 b=Df9ddKI5u6Fdx96bu3qIWUpdciJJ2lJQqaannMMugSvykUE3sFMIF0Cw4fAK2a220IUa+LRGU1LK+jkMEA/5LKaTd6S8ieaf0pVMr6MrtDyjsP8TgliFVfHURrVHfvDOZgt76wsA+AFwIB0W6trBfJWJb4/wTzooxA8NurFd94PB3tzHoDmeN3M0ArpB8/142zEDvC9wDWY/HpUCIqubjWmbQACYz62RuAcU2shqscXHfKis5ZsCkfFAwHYhWmNdrz9aMr5O/Lxo4vCiOs+r4QfWaM+t4Di2E2eRSeAoBLimKJw5vsps/0WbAk9WGQrGTOprfJbO1YIA6ToKjiMAmA==
Received: from MW4PR04CA0043.namprd04.prod.outlook.com (2603:10b6:303:6a::18)
 by DM6PR12MB4314.namprd12.prod.outlook.com (2603:10b6:5:211::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 14:49:01 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::7) by MW4PR04CA0043.outlook.office365.com
 (2603:10b6:303:6a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22 via Frontend
 Transport; Tue, 30 May 2023 14:49:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.22 via Frontend Transport; Tue, 30 May 2023 14:49:01 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 30 May 2023
 07:48:55 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 30 May
 2023 07:48:55 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Tue, 30 May
 2023 07:48:50 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Yanan Wang
 <wangyanan55@huawei.com>, Juan Quintela <quintela@redhat.com>, Peter Xu
 <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Thomas Huth
 <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>, Avihai Horon
 <avihaih@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta
 <targupta@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v5 5/9] vfio/migration: Refactor vfio_save_block() to return
 saved data size
Date: Tue, 30 May 2023 17:48:17 +0300
Message-ID: <20230530144821.1557-6-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230530144821.1557-1-avihaih@nvidia.com>
References: <20230530144821.1557-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT042:EE_|DM6PR12MB4314:EE_
X-MS-Office365-Filtering-Correlation-Id: 48838fa7-2e3c-4faa-047f-08db611d01e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5JJ1oRs7AjBcpgTqusncJtVhTTLQxJukAFILpIySNEHlMGW/2hME9h3xpwpn5FVS7vBBj/cMKJmJ4wmXXoaKil/UFlzapDD0FnNA2kavMiGD27B8e+h0lN09PVJL+cYYFqHyLhLH9dAf8hAtL5RssGgABiCeAQBEFSjPGgOn8O1lSLtyXsiGlopFQarJOzW0VHuyKORyu0kyZPjznQmTn4/2OPERopYbwH754YNfJFTy00AdwxFiPCDgGmWgzKzX7IJ4w5w9Ts5CZjM5+QUVD4xet8ILRTJLdRa2CU1dJAFT5x9iOqcJWYjVrbyU52TrwweqZ08F0T0neo1HQMg7i/EO55heP945RqZvhd3mTzhJRZuuViVwgxrDOEEAQYpAIV4JkVFkrY2Vpzky8XI5jGQOIn73PGlOXezMJAwxbVb+HfT7yy9l6mXODoIqais6m4obnB8CLOMP/xzEiukVFUzPa7tJX3YZ8pte+7sA4Dz5DRbiajPlnqxufHiL2+QtRrvA/m5tRAUylEovPLYsYvx6T/6DILWxw+mEYt28p2uMPAp6NBQTgTeMuam8tRddMMJ8uwjXurvLY72sv/Eafm01gfDkbCiOsPzv4Pyt7+FZ+dOCN0zDZ7dFryyq3D9wCut2cwoyNA254sPEs0CskZArtHhailz9T3mLUrCoVBLXuPmezN5IaW/oeTeKerskVaB9UcE9USd67ZT9WK1wyjYhArZgHRVUPqkNyvyx5lUaPtajrtxMvZThXxGVOX7w
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199021)(40470700004)(46966006)(36840700001)(478600001)(40460700003)(54906003)(8936002)(8676002)(7416002)(5660300002)(82310400005)(36756003)(2906002)(86362001)(356005)(4326008)(7636003)(6916009)(70206006)(70586007)(82740400003)(316002)(40480700001)(41300700001)(2616005)(186003)(1076003)(26005)(47076005)(36860700001)(66574015)(6666004)(7696005)(426003)(336012)(83380400001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 14:49:01.6048 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48838fa7-2e3c-4faa-047f-08db611d01e8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4314
Received-SPF: softfail client-ip=2a01:111:f400:7e8d::631;
 envelope-from=avihaih@nvidia.com;
 helo=NAM04-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
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

Refactor vfio_save_block() to return the size of saved data on success
and -errno on error.

This will be used in next patch to implement VFIO migration pre-copy
support.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
---
 hw/vfio/migration.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 6b58dddb88..235978fd68 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -241,8 +241,8 @@ static int vfio_query_stop_copy_size(VFIODevice *vbasedev,
     return 0;
 }
 
-/* Returns 1 if end-of-stream is reached, 0 if more data and -errno if error */
-static int vfio_save_block(QEMUFile *f, VFIOMigration *migration)
+/* Returns the size of saved data on success and -errno on error */
+static ssize_t vfio_save_block(QEMUFile *f, VFIOMigration *migration)
 {
     ssize_t data_size;
 
@@ -252,7 +252,7 @@ static int vfio_save_block(QEMUFile *f, VFIOMigration *migration)
         return -errno;
     }
     if (data_size == 0) {
-        return 1;
+        return 0;
     }
 
     qemu_put_be64(f, VFIO_MIG_FLAG_DEV_DATA_STATE);
@@ -262,7 +262,7 @@ static int vfio_save_block(QEMUFile *f, VFIOMigration *migration)
 
     trace_vfio_save_block(migration->vbasedev->name, data_size);
 
-    return qemu_file_get_error(f);
+    return qemu_file_get_error(f) ?: data_size;
 }
 
 /* ---------------------------------------------------------------------- */
@@ -335,6 +335,7 @@ static void vfio_state_pending_exact(void *opaque, uint64_t *must_precopy,
 static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
 {
     VFIODevice *vbasedev = opaque;
+    ssize_t data_size;
     int ret;
 
     /* We reach here with device state STOP only */
@@ -345,11 +346,11 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
     }
 
     do {
-        ret = vfio_save_block(f, vbasedev->migration);
-        if (ret < 0) {
-            return ret;
+        data_size = vfio_save_block(f, vbasedev->migration);
+        if (data_size < 0) {
+            return data_size;
         }
-    } while (!ret);
+    } while (data_size);
 
     qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
     ret = qemu_file_get_error(f);
-- 
2.26.3


