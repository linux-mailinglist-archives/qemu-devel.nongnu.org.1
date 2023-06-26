Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0977673D996
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 10:25:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDhWO-0004BB-Sf; Mon, 26 Jun 2023 04:24:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qDhWL-0004B2-Jp
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 04:24:25 -0400
Received: from mail-dm6nam12on20602.outbound.protection.outlook.com
 ([2a01:111:f400:fe59::602]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qDhWI-00034M-CL
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 04:24:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dTnLtF3ZHXoGH+4VlylYzs1FPEIFl3mFU8AgDIfxPlzTvPC2jLQdR43PPURw/+X0ICt1qZecw24EFAjeXqW0U+eNBckfb0HuN3s+C6vO3zHsCLAJuUoA/gXztKsI4NQqFmGrvqx/oHeMjbZIZikTMKyfPMPqB7NKkBWRPPi0KEGdh0yNdxZzwX2mQnJ7pfYr3sBYhi6lwRCFCxk/QkePu2geJTLCL0m/G51M07MjtLHA/fQE7ztUy3fk4u/dy6P7JvJ/b3U4yYa6hMIEsZxddKDA3dULEd/SkBf6xviCi5iR3BwP1vPhiebmqIbdc9HEx3k4Bb4VMiFbMKtzp7SnVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ltq5nsS59lQoe80rfolg7qjptpZfDkJvzc0TJhRFeDI=;
 b=mhyWqyZ+9dUUS3Pzb6aK4Lcon1tZLjUdG/ucIkE6UXqGwnTHGmjhRDMwxpK7F1DeHHTVqwVymd4HaTfqS/b7QCBEEHf81fVJwZAfmDk3cpf6Krf8qdLwo+5yKk7IT3C5phU4p6X8tHRK7a6Vdtirg1CVoIIcYDNnStZmmRvCaynSf036i6CUJw3vn2De8dvzhviAybFhDidQkzCNfyqPZzwSbBgaSY2SGO/IIGfEp8E1ia2fFJWfLMvCZ5DjZfIi775VDKbovjcnvNHVwDduKJYyABMGKHAqr11mLaO1CfneUWN+levix54zJF4+SGkxVWLjWL/FIazYh+jbaDeWYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltq5nsS59lQoe80rfolg7qjptpZfDkJvzc0TJhRFeDI=;
 b=jcd6LqijIE2HQ3xD4prb2ZTv2GIHRjVExw6J4lgbgpzZ8MAXQUS7/woFrc43P71aHBeYswYQXUaZ1v71dma7qtzqfXHJn2rnNLN/yIHQqWODRk9I5svy1ar3kft/ftIPXixa1rhea8ybDz0PyQluKXxiRuMNNzZAYweR8L+tIoa4nporwmBZuP+tNQE6FPXrazpnm33P10+5xzIUaFZsUs+zydRmnje4P8lI1M6giudyRwkZodub6pKnLQ9NwFHvZfiaMRYcr6AoWGvwQXcgXoTIAvXXSpSSnSTqy6CeNuJh/yDBRlSYTM0vGV1a1IZoSh/ilNCzgZGCBMZlLmQ3Fg==
Received: from BN9P222CA0008.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::13)
 by DS7PR12MB5958.namprd12.prod.outlook.com (2603:10b6:8:7d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Mon, 26 Jun
 2023 08:24:18 +0000
Received: from BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10c:cafe::b2) by BN9P222CA0008.outlook.office365.com
 (2603:10b6:408:10c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.33 via Frontend
 Transport; Mon, 26 Jun 2023 08:24:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT065.mail.protection.outlook.com (10.13.177.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.47 via Frontend Transport; Mon, 26 Jun 2023 08:24:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 26 Jun 2023
 01:24:06 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 26 Jun
 2023 01:24:05 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Mon, 26 Jun
 2023 01:24:02 -0700
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
Subject: [PATCH 2/3] vfio/migration: Reset bytes_transferred properly
Date: Mon, 26 Jun 2023 11:23:52 +0300
Message-ID: <20230626082353.18535-3-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230626082353.18535-1-avihaih@nvidia.com>
References: <20230626082353.18535-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT065:EE_|DS7PR12MB5958:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b4f8f4c-8eb4-4b1b-e8d6-08db761ebc75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wA4N2chcX0iX1DtfKDhQmxJ1xZu/wtv0kL4n/O+tt+4X9eKWs6Fp+WjGPqB6GrFqRiqKMxM+Ou25KTfXkzQReHwv1l6BWMGNCFhUy2uj2YlTLPJm8H77ZdcRMYfczVrNIo0BnbMRPU9lnYR2ggwnDPRreKj1r7TsWzR6LRxXqxb2wzu42/sAEZaE3FCNzXYYOtYWFHbrasPZn5Iia2XiOCqgqC07a2s1CPI+OotrCCrc9T9NZBSGb7hQOsfDq/88NH43slhVveWNobpca+OnaBrqMq4iCa3H12z/zzVuqiXyc4AqJ5kWIRRQUf/t5siXqMiphVJt+KDQxiEX7DHACZ7AN/sHA318hEVYU8s2p/nX2ttTF8PqnCUjP527TWb3sh5ey5nkPfCAHe9RbXzEL2joNrY1BPnhuzCVXm5M5q6QFgX4n0qM83AN0k9NnQSPlUkxclQ6NH2R6/E81SfkVHWwgRxAk24uAQwxeyg2cXxwO6WL0bKVIQkxzLNtklWf+oy1xCAqsBa4G7HOzAwRV6XnTkQMSnMeCNJsI4smihtLgLCrj1WrUOW+wxHGdZvykFozBlAXrnALVPnV8DF3ZYuAnz/gT5aIRuQa2QdUuATBTKvAzYGwxuw1llaWAqSRgokLXvrwSN/HTadwpt3+U1CWg3xGDsRhbP43nWRavZ+xBeZxUZ/SUtcFZxOLtpAHyYmeVIVb68Btac5O5XnrDD7a6k5ZTvVnqzI8CLJEKZYwnwU2K52AVQnuSinw6FL3
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(82310400005)(36860700001)(47076005)(478600001)(426003)(54906003)(2616005)(6666004)(7696005)(336012)(83380400001)(1076003)(26005)(186003)(2906002)(5660300002)(356005)(36756003)(70206006)(40460700003)(70586007)(82740400003)(40480700001)(7636003)(8936002)(8676002)(316002)(86362001)(6916009)(4326008)(41300700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 08:24:18.3966 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b4f8f4c-8eb4-4b1b-e8d6-08db761ebc75
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5958
Received-SPF: softfail client-ip=2a01:111:f400:fe59::602;
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

Currently, VFIO bytes_transferred is not reset properly:
1. bytes_transferred is not reset after a VM snapshot (so a migration
   following a snapshot will report incorrect value).
2. bytes_transferred is a single counter for all VFIO devices, however
   upon migration failure it is reset multiple times, by each VFIO
   device.

Fix it by introducing a new function vfio_reset_bytes_transferred() and
calling it during migration and snapshot start.

Remove existing bytes_transferred reset in VFIO migration state
notifier, which is not needed anymore.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 include/hw/vfio/vfio-common.h |  1 +
 migration/migration.h         |  1 +
 hw/vfio/migration.c           |  6 +++++-
 migration/migration.c         |  1 +
 migration/savevm.c            |  1 +
 migration/target.c            | 17 +++++++++++++++--
 6 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 3dc5f2104c..b4c28f318f 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -228,6 +228,7 @@ int vfio_block_multiple_devices_migration(Error **errp);
 void vfio_unblock_multiple_devices_migration(void);
 int vfio_block_giommu_migration(Error **errp);
 int64_t vfio_mig_bytes_transferred(void);
+void vfio_reset_bytes_transferred(void);
 
 #ifdef CONFIG_LINUX
 int vfio_get_region_info(VFIODevice *vbasedev, int index,
diff --git a/migration/migration.h b/migration/migration.h
index c859a0d35e..a80b22b703 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -514,6 +514,7 @@ bool migration_rate_limit(void);
 void migration_cancel(const Error *error);
 
 void populate_vfio_info(MigrationInfo *info);
+void reset_vfio_bytes_transferred(void);
 void postcopy_temp_page_reset(PostcopyTmpPage *tmp_page);
 
 #endif
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index a8bfbe4b89..79eb81dfd7 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -704,7 +704,6 @@ static void vfio_migration_state_notifier(Notifier *notifier, void *data)
     case MIGRATION_STATUS_CANCELLING:
     case MIGRATION_STATUS_CANCELLED:
     case MIGRATION_STATUS_FAILED:
-        bytes_transferred = 0;
         /*
          * If setting the device in RUNNING state fails, the device should
          * be reset. To do so, use ERROR state as a recover state.
@@ -825,6 +824,11 @@ int64_t vfio_mig_bytes_transferred(void)
     return bytes_transferred;
 }
 
+void vfio_reset_bytes_transferred(void)
+{
+    bytes_transferred = 0;
+}
+
 int vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
 {
     int ret = -ENOTSUP;
diff --git a/migration/migration.c b/migration/migration.c
index 7653787f74..096e8191d1 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1628,6 +1628,7 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
      */
     memset(&mig_stats, 0, sizeof(mig_stats));
     memset(&compression_counters, 0, sizeof(compression_counters));
+    reset_vfio_bytes_transferred();
 
     return true;
 }
diff --git a/migration/savevm.c b/migration/savevm.c
index cdf4793924..95c2abf47c 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1622,6 +1622,7 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
     migrate_init(ms);
     memset(&mig_stats, 0, sizeof(mig_stats));
     memset(&compression_counters, 0, sizeof(compression_counters));
+    reset_vfio_bytes_transferred();
     ms->to_dst_file = f;
 
     qemu_mutex_unlock_iothread();
diff --git a/migration/target.c b/migration/target.c
index 00ca007f97..f39c9a8d88 100644
--- a/migration/target.c
+++ b/migration/target.c
@@ -14,12 +14,25 @@
 #include "hw/vfio/vfio-common.h"
 #endif
 
+#ifdef CONFIG_VFIO
 void populate_vfio_info(MigrationInfo *info)
 {
-#ifdef CONFIG_VFIO
     if (vfio_mig_active()) {
         info->vfio = g_malloc0(sizeof(*info->vfio));
         info->vfio->transferred = vfio_mig_bytes_transferred();
     }
-#endif
 }
+
+void reset_vfio_bytes_transferred(void)
+{
+    vfio_reset_bytes_transferred();
+}
+#else
+void populate_vfio_info(MigrationInfo *info)
+{
+}
+
+void reset_vfio_bytes_transferred(void)
+{
+}
+#endif
-- 
2.26.3


