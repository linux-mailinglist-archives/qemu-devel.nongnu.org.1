Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 082F27409B7
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 09:32:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEPeY-0000Jn-0V; Wed, 28 Jun 2023 03:31:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qEPeV-0000JP-8z
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 03:31:47 -0400
Received: from mail-mw2nam10on20630.outbound.protection.outlook.com
 ([2a01:111:f400:7e89::630]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qEPeS-0006gm-Dr
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 03:31:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jNuEv1IlNYPjpmiFeqLFmHLfeGR7EK2WKrRntIPB/LbGaPLu5ohSV97ByowZuhOPrkOdgmNGvOP6uKWPU1h/9dyQYkm6nY94MKbB+R0EljPqfAyKrbtqoh330ABzQRKY8L1ZVFwOp5hHh5fyBIJfzgMVQ9411JAQYVFShreUmmARX3rVyRGVsOSj3uSOK9DfmW3fCv9YKXpeCZux58u52IEWM4jC3EjjC/yGYR5M+DUM+j8U7m5oonPHUKDFlLwiMWzJ/31n653op1PI97s5E8wiPLEtBX5lzCBEupaoBYiJAibyDuhLe0CeId0zOVz2bdT6VAv70ftnULfnO3D3Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pvNFmct47/yRrcN7V3NiGCXPaEN74H+1gbv7eFSpYzw=;
 b=ACRAwBAZh2pcsfiR2MDJWtsUv8iUFHwJLCxNdWBLj1MrRx+32dCwNQJvhrSHqgQwC9YKcK9j5iPc2y6cAKclzH84FJWTr4yjFUjJfkhlkZKR4NMGT/aEvqzk4SRZifH4O5K0syiTsioKP2jVZp1XoqbskD31esGXEJ2jnw3dLVm1nidORQzb/hCAk+oZJOVKpy7evNtBiZCTQI/e2Q/vaaINzp6q1Y7dfGnsBn2EXe4242I6gnFoTE6faNL04Kyf5pfi86TDOB+9qk/xDWCDCJcbkAVxvJtnboZ1sf2KMZYDCd5kLjwiJ1jm1J9VEp+F3Tgedzw3Zm58APeIk3pkBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pvNFmct47/yRrcN7V3NiGCXPaEN74H+1gbv7eFSpYzw=;
 b=Abeq+lJJLLKz9ywD+Mv7a2jGKyLh/nFiZFr9+HXajf8bUoe134++f3OVsZN7uGf5Mu5oCMEEF3pHU/v2UIFfnx0W825Gfz/w0nhIL/vhGT8yqUOYIwWDEGYqjq7Y4COzQOG4WCp6abiP7rSaNArL4fM/C6GUdTCIpsmu1eYkvbTTay07dlgsLDucf80ULgTSIvYWlAOBUPedL821C1ClDUkoQAoubIreCu0jzGBfZ9gZt+ARGstRNG+TosBsfykLXIZSikp52EJu5gkHv1IcOoFhqlJHeIqoy2s3ZOBW467/vK5n4oKPtQzvWQalI0ocapNWNXi9sqDswSy2YAEtqA==
Received: from DM6PR11CA0003.namprd11.prod.outlook.com (2603:10b6:5:190::16)
 by MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 07:31:39 +0000
Received: from DM6NAM11FT114.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::f6) by DM6PR11CA0003.outlook.office365.com
 (2603:10b6:5:190::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.20 via Frontend
 Transport; Wed, 28 Jun 2023 07:31:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT114.mail.protection.outlook.com (10.13.172.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.47 via Frontend Transport; Wed, 28 Jun 2023 07:31:39 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 28 Jun 2023
 00:31:22 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 28 Jun
 2023 00:31:21 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Wed, 28 Jun
 2023 00:31:18 -0700
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
Subject: [PATCH v2 1/2] vfio/migration: Reset bytes_transferred properly
Date: Wed, 28 Jun 2023 10:31:11 +0300
Message-ID: <20230628073112.7958-2-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230628073112.7958-1-avihaih@nvidia.com>
References: <20230628073112.7958-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT114:EE_|MN2PR12MB4373:EE_
X-MS-Office365-Filtering-Correlation-Id: 402500a4-aa81-4b0d-b330-08db77a9b61c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: se9cKPd+KeCXSTkALt/DY9Vn48zcNQ48whYNq4pbsMjcQDU7wO2PLNW+XBApM+b0H3D9DThkc2L8mUkzPu6aMVQwB4fbRssSYY67oC/V9tdX6Y69WbBO3hgC3WMX4i4hxK/cvnXVH3GkDFX9Cpdso2bG+dsW/1TyNw/ZTej1+7qFiaZsD2tX7YTmZ66x+bzM+bxwZd4OuJt6hQds6Tq5TUq36JiIWWafoWn97DOy0HzvDT0LTFzprXWdnFlfK938c1dW6iTN0dSq9719cSyENFhiBOsj8mBwYhXFPlC7QV8wh/ZrtsFl9WGvPkrl+QYyxlpYn3QMEta5wRlXP/hlUEA+mhtXpG+o+uX1Lu2Opis3+5FeHhPug8iR3VLdSfFATqo0dB4q+7TdCFmVKA56Nuav9/CVTa2pg6UdgB7NAFzqwX9d0Ny44xHroghldePlmeiEc0//MpsJFuuAS0+LeQAnUkRkB8Yhvj/vd531v7Ay+76zzQUFLHcOsSXQ9pVN20MHLrI9fxlXHvbJSXHW1wjFE8J3eLmlsz28Mo8Mfyc3dEW2FlYRz8ulyMs5O4bqXJIxMSOplPpozm+eg7c5u71V97HuSEMOL+lCohkpbUuJNuXvkjv1AYY/75jaIHY4yQaHYzKsV26tFAmF6fGotA2vMOYrNcU2OMlK2tG38/VKpGZmeW/MDd8i9v6LNt7JoruTLQF1tRu0p0dLozqfKJW/4g4KGJ6GMEp4sJgr0bYPVuOg/28CV1Ih31ETa0sZ
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(39860400002)(376002)(396003)(451199021)(40470700004)(36840700001)(46966006)(356005)(7636003)(82740400003)(36756003)(47076005)(83380400001)(36860700001)(86362001)(2616005)(54906003)(8936002)(7696005)(40460700003)(6666004)(41300700001)(70206006)(8676002)(70586007)(316002)(1076003)(336012)(6916009)(426003)(26005)(4326008)(186003)(82310400005)(40480700001)(2906002)(478600001)(5660300002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 07:31:39.0163 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 402500a4-aa81-4b0d-b330-08db77a9b61c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT114.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4373
Received-SPF: softfail client-ip=2a01:111:f400:7e89::630;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
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

Fixes: 3710586caa5d ("qapi: Add VFIO devices migration stats in Migration stats")
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
index acbf0bb7ab..7cf143926c 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -697,7 +697,6 @@ static void vfio_migration_state_notifier(Notifier *notifier, void *data)
     case MIGRATION_STATUS_CANCELLING:
     case MIGRATION_STATUS_CANCELLED:
     case MIGRATION_STATUS_FAILED:
-        bytes_transferred = 0;
         /*
          * If setting the device in RUNNING state fails, the device should
          * be reset. To do so, use ERROR state as a recover state.
@@ -818,6 +817,11 @@ int64_t vfio_mig_bytes_transferred(void)
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


