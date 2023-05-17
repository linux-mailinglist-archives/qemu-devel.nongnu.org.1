Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B277D706D67
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 17:54:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzJTD-00045T-4U; Wed, 17 May 2023 11:53:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1pzJSy-0003j8-86
 for qemu-devel@nongnu.org; Wed, 17 May 2023 11:53:31 -0400
Received: from mail-mw2nam12on20629.outbound.protection.outlook.com
 ([2a01:111:f400:fe5a::629]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1pzJSu-00060y-3E
 for qemu-devel@nongnu.org; Wed, 17 May 2023 11:53:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lJ3rqPWtMyrbLSOYEcose+P8u6DIlQRoXm3p/C6aFOkfkmOshN7isvL36a0+BkSZvyn8zDTrrzFIEEfKwsqsIzuyec93XU2cCB8ekehwQnxFdTb01x9OKRUwV2V9tsh5Iraxqp3YhJY1gQA9XVbgwqaQXHjlsY1aaQeabMtMEyyrWekzdomTS1EGMj7Eif7wsuzkeAcgrcaEHwKgj/4KSFuWKvrJmk90g84MxA1AF/EaZ488SYqisJBoMNkZtE1bMNAeChA4DjKFhDAtU/jjVdUlhm8/Ku0DnJSTTrkY6OgCgQz/2kfTs52OkkQh0/cJY6JGA7OL0DyrgWETktwOlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNySRFimy5WXY/34yt3k3o7IrVL7nFHurF4v6aKSt5E=;
 b=H8Kht51PmatZQNU2yt7teM9ah6n3L54Vh5ggX/nw86VHsg8YjCes9eeY7FdLVhxC7h2v2ynUICmMQ9ijpJ/dH8z6O/kdtmHDBiYaRO8ooWDY39f/RTG3vZouVGTv6TQs5HCyDpih2jrxoAmtFHUDhL46OLA/01UommefrtXXeDQupoHLfy80DW0Z6euAR7W8gh49j5WSsA6q4++SBkgToFKszTJZoKmoS4kZ1jzy3djkQeJZHKfY21Pw6Ra81SF0rChoKPbTjgXg7HQX86hziHWgLfs+HPXHMS1ffTu7gP+k4KArDdEGPSEx23zhxHCHl0oQ6/faerllhMaJKbo3yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNySRFimy5WXY/34yt3k3o7IrVL7nFHurF4v6aKSt5E=;
 b=W/N92qpji3txbBW/uAlYsdHfig8+SI0vcOpz1Bkggp4zvG20UzWF4bOUQ6ZPBCBSX4aPhsJa7lL+dsMRn4YNPjkhVEvK2FrkTrnF3TWut5/IE6C/QbeGtCmTDGvrGscVXLxb8BVli0mhL/1HUSXjzTkzrHt45NpJ1fWNsd3gHysalvLR+cYs7g/vWiooeAvNpXOyN0QKhcey5+DyPob29MXZ2oQxfElcLms7mCOWXfFNvd/Pg5JnfhySQ/xHZ1PEO245gKKhEduq0TQggtQpCs6RVyyun9qCPQ6uzHwkfsRoAygapagc+zkyRmqGa31Vdqy95agdrhndQILlOoTDmg==
Received: from BN0PR07CA0006.namprd07.prod.outlook.com (2603:10b6:408:141::23)
 by MW4PR12MB7383.namprd12.prod.outlook.com (2603:10b6:303:219::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 15:53:17 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:141:cafe::b1) by BN0PR07CA0006.outlook.office365.com
 (2603:10b6:408:141::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17 via Frontend
 Transport; Wed, 17 May 2023 15:53:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.18 via Frontend Transport; Wed, 17 May 2023 15:53:17 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 17 May 2023
 08:53:03 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 17 May 2023 08:53:02 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport;
 Wed, 17 May 2023 08:52:58 -0700
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
Subject: [PATCH v2 7/7] vfio/migration: Add support for precopy initial data
 capability
Date: Wed, 17 May 2023 18:52:19 +0300
Message-ID: <20230517155219.10691-8-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230517155219.10691-1-avihaih@nvidia.com>
References: <20230517155219.10691-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT037:EE_|MW4PR12MB7383:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e55b3be-46ac-418c-7e01-08db56eed4d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6vJYvXvecfkZZa2WrkLIaWnSJqeeMiiQDtuxOxrMFnmxAI685HrVUVcbvqReFE0OEKcY068PaizIv32kugNy7V5qHY003JWgpeIs/1Mdv61waH/OqAwo/Oi+Z4Cxfrmo7YY8DSNOPsdpwJm5AYIOsUjSflqmhailIwq39jxr492mLf5FcoLpupy+3rJhlTDXD6K86qdUS9/lxGqGDaHS2fCat/t8m0I2/KkaX5TZMI5PSSjU3aAKamCbS3ALzov+4TWjNJg1OEJk+Rf8bJH5/5fjAzKDKWWvkXr1VWAOOWgjsBPE6UPObSfyuN7LseV6/y1zT5wj+/kJZhPgWWeIangOjU6ikxnksHGA2zn19HdGetRIXCjL0eF63oufAKQtyt1lBxCj+7FJBl7Q/Gt+LdPuJ7EhndJDp2yRlyC5F2Ix/+iUWO8+Xtic5/91z7A3gvcTssJZ1oO6xZjJKBiqHgcUx0fmhinjiJcSvxVzZUyKOnytykEl48AVm5E7/mxWfbSkNCr7ZcN86vS2j8PgWdM7iNsk9kqUoSJ2n69kdNnKbfE7Q0WJIHl+pP7/oF4+01WLk/dLZjrmFJFeaePlb87P6WqsZmyaxN3d4xQuVaRbCW7ACPa06K+6BZpwmz5eo6g5BDSmpLs5Kour//dQcanht7l2nvYXvi6vQbxtse1LjD1b7V2GeU8832MptJN2iM8bIHhqhC+ORJvWXuafoYdsrCSjWdVZX09F1HYvgPcN6iJo+EE9z5QM1YMXHn/b
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(39860400002)(396003)(376002)(451199021)(46966006)(40470700004)(36840700001)(83380400001)(26005)(40480700001)(1076003)(36756003)(7696005)(186003)(6666004)(36860700001)(47076005)(2616005)(478600001)(336012)(426003)(40460700003)(82740400003)(82310400005)(4326008)(2906002)(316002)(70586007)(70206006)(6916009)(54906003)(8936002)(7416002)(8676002)(86362001)(41300700001)(5660300002)(356005)(7636003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 15:53:17.4148 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e55b3be-46ac-418c-7e01-08db56eed4d5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7383
Received-SPF: softfail client-ip=2a01:111:f400:fe5a::629;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
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

Loading of a VFIO device's data can take a substantial amount of time as
the device may need to allocate resources, prepare internal data
structures, etc. This can increase migration downtime, especially for
VFIO devices with a lot of resources.

To solve this, VFIO migration uAPI defines "initial bytes" as part of
its precopy data stream. Initial bytes can be used in various ways to
improve VFIO migration performance. For example, it can be used to
transfer device metadata to pre-allocate resources in the destination.
However, for this to work we need to make sure that all initial bytes
are sent and loaded in the destination before the source VM is stopped.

Use migration precopy initial data capability to make sure a VFIO
device's initial bytes are sent and loaded in the destination before the
source stops the VM and attempts to complete the migration.
This can significantly reduce migration downtime for some devices.

As precopy support and precopy initial data support come together in
VFIO migration, use x-allow-pre-copy device property to control usage of
this feature as well.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 docs/devel/vfio-migration.rst | 10 +++++++++
 include/hw/vfio/vfio-common.h |  2 ++
 hw/vfio/migration.c           | 42 ++++++++++++++++++++++++++++++++++-
 3 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/docs/devel/vfio-migration.rst b/docs/devel/vfio-migration.rst
index e896b2a673..aebf63b02b 100644
--- a/docs/devel/vfio-migration.rst
+++ b/docs/devel/vfio-migration.rst
@@ -16,6 +16,13 @@ helps to reduce the total downtime of the VM. VFIO devices opt-in to pre-copy
 support by reporting the VFIO_MIGRATION_PRE_COPY flag in the
 VFIO_DEVICE_FEATURE_MIGRATION ioctl.
 
+When pre-copy is supported, it's possible to further reduce downtime by
+enabling "precopy-initial-data" migration capability.
+VFIO migration uAPI defines "initial bytes" as part of its pre-copy data stream
+and recommends that the initial bytes are sent and loaded in the destination
+before stopping the source VM. Enabling this migration capability will
+guarantee that and thus, can potentially reduce downtime even further.
+
 Note that currently VFIO migration is supported only for a single device. This
 is due to VFIO migration's lack of P2P support. However, P2P support is planned
 to be added later on.
@@ -45,6 +52,9 @@ VFIO implements the device hooks for the iterative approach as follows:
 * A ``save_live_iterate`` function that reads the VFIO device's data from the
   vendor driver during iterative pre-copy phase.
 
+* An ``initial_data_advise`` function that advises the VFIO device to use
+  "precopy-initial-data" migration capability if supported.
+
 * A ``save_state`` function to save the device config space if it is present.
 
 * A ``save_live_complete_precopy`` function that sets the VFIO device in
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 5ce7a01d56..698b2b8cc5 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -69,6 +69,8 @@ typedef struct VFIOMigration {
     uint64_t precopy_init_size;
     uint64_t precopy_dirty_size;
     uint64_t mig_flags;
+    bool initial_data_active;
+    bool initial_data_sent;
 } VFIOMigration;
 
 typedef struct VFIOAddressSpace {
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 418efed019..5d98c4cd94 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -18,6 +18,7 @@
 #include "sysemu/runstate.h"
 #include "hw/vfio/vfio-common.h"
 #include "migration/migration.h"
+#include "migration/savevm.h"
 #include "migration/vmstate.h"
 #include "migration/qemu-file.h"
 #include "migration/register.h"
@@ -45,6 +46,7 @@
 #define VFIO_MIG_FLAG_DEV_CONFIG_STATE  (0xffffffffef100002ULL)
 #define VFIO_MIG_FLAG_DEV_SETUP_STATE   (0xffffffffef100003ULL)
 #define VFIO_MIG_FLAG_DEV_DATA_STATE    (0xffffffffef100004ULL)
+#define VFIO_MIG_FLAG_DEV_INIT_DATA_SENT (0xffffffffef100005ULL)
 
 /*
  * This is an arbitrary size based on migration of mlx5 devices, where typically
@@ -380,6 +382,8 @@ static void vfio_save_cleanup(void *opaque)
 
     g_free(migration->data_buffer);
     migration->data_buffer = NULL;
+    migration->initial_data_sent = false;
+    migration->initial_data_active = false;
     vfio_migration_cleanup(vbasedev);
     trace_vfio_save_cleanup(vbasedev->name);
 }
@@ -455,10 +459,17 @@ static int vfio_save_iterate(QEMUFile *f, void *opaque)
     if (data_size < 0) {
         return data_size;
     }
-    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
 
     vfio_update_estimated_pending_data(migration, data_size);
 
+    if (migration->initial_data_active && !migration->precopy_init_size &&
+        !migration->initial_data_sent) {
+        qemu_put_be64(f, VFIO_MIG_FLAG_DEV_INIT_DATA_SENT);
+        migration->initial_data_sent = true;
+    } else {
+        qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
+    }
+
     trace_vfio_save_iterate(vbasedev->name);
 
     /*
@@ -576,6 +587,24 @@ static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
             }
             break;
         }
+        case VFIO_MIG_FLAG_DEV_INIT_DATA_SENT:
+        {
+            if (!vbasedev->migration->initial_data_active) {
+                error_report("%s: Received INIT_DATA_SENT but initial data is "
+                             "not active",
+                             vbasedev->name);
+                return -EINVAL;
+            }
+
+            ret = qemu_loadvm_notify_initial_data_loaded();
+            if (ret) {
+                error_report("%s: qemu_loadvm_notify_initial_data_loaded "
+                             "failed, err=%d (%s)",
+                             vbasedev->name, ret, strerror(-ret));
+            }
+
+            return ret;
+        }
         default:
             error_report("%s: Unknown tag 0x%"PRIx64, vbasedev->name, data);
             return -EINVAL;
@@ -590,6 +619,16 @@ static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
     return ret;
 }
 
+static bool vfio_initial_data_advise(void *opaque)
+{
+    VFIODevice *vbasedev = opaque;
+    VFIOMigration *migration = vbasedev->migration;
+
+    migration->initial_data_active = vfio_precopy_supported(vbasedev);
+
+    return migration->initial_data_active;
+}
+
 static const SaveVMHandlers savevm_vfio_handlers = {
     .save_setup = vfio_save_setup,
     .save_cleanup = vfio_save_cleanup,
@@ -602,6 +641,7 @@ static const SaveVMHandlers savevm_vfio_handlers = {
     .load_setup = vfio_load_setup,
     .load_cleanup = vfio_load_cleanup,
     .load_state = vfio_load_state,
+    .initial_data_advise = vfio_initial_data_advise,
 };
 
 /* ---------------------------------------------------------------------- */
-- 
2.26.3


