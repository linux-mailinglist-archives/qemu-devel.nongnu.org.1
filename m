Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A359716508
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 16:50:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q40fP-0005ZV-5i; Tue, 30 May 2023 10:49:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q40fM-0005UP-K1
 for qemu-devel@nongnu.org; Tue, 30 May 2023 10:49:40 -0400
Received: from mail-dm6nam12on20608.outbound.protection.outlook.com
 ([2a01:111:f400:fe59::608]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q40fI-0007yA-ND
 for qemu-devel@nongnu.org; Tue, 30 May 2023 10:49:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lf52lOltIF4qEG7IODhkDzOvK+uhLeUDqr66ZAN5xyUCnFHPZxuOP2gjdc7+JT+hOzP+agTm97TuDjidnrM1hNAem6qSEQgc6o3VLRUOBQYC/8WdUpJ7jfp/3K/LassPudSEOynL0CzerSBaHOE2f6nmhJG3eGAOLDBw0Le5h8r7T3jG6mJBi7qFNkfgxn6GGATZND39+siUjDgwRfXmrGX2IY/GKb2OwMHxzgEcaLpsGTo1M9l7M6UlDPzxUwgfj7UGA4ND+WlsQTYG7jq+YbD4VSnbUSENyNeYNks+tkkveP0nWZk5Vxn8lxnbP2UQaWOysK0Eth5OixPhA8MGBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=27F7Ri/Y0M8H2u+JoESRWW1H0K+P0QrLumfhQi20sNg=;
 b=i9bh9IRpRgpIRXtcQIc59f87Miqo8BG4tpvZKar/CglsEBxytPbdt32yfNuYFW0YVa3h3ZknP5RXce3aA9u/CUbj1etdoPrUyJO0tc/ZRfQHzYsDDNafWA6MXLnzXW0j10GzKDAV30W2M1nU43/k2BP/SeKQbjqKHbb1uRGR/s2bSufMfHNxU+aUOt/uLuAgCALC2/fwOWEx68YzbfVm+BQNp4bZAbRVXYjevRt5t6dHoljDWf/ZJFGhv7PGiozv1brMljiuMHRHRDoGapKsEIEVDZqTHjaXXcY8k6u9t0vpjesvd7N7aeASptOy1hAcejHGpwC8kjBhGO8OLoo4lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=27F7Ri/Y0M8H2u+JoESRWW1H0K+P0QrLumfhQi20sNg=;
 b=VKTdsLjh+15ql7BNoz88NFm0ocyG3hCp2cqycUrd+zWrwtpO2Cy3yEACoK/pp9DLsMt2Y+fyn3aDqwPjiGOEXNcDx8Tn/8cxnurKxLaPygaSTtiGZnNRsCDRndN+1BR7IbukybdK3YsSv42i2eUblYCNtG0XI+7H+IDrN7Lb74MWpr8QVsN4H9Fs/X19iFCk/hil2HEzmrZukTN+ZUtyyuH1x7KpWCY+HREN2rZim+iNPnaW421fwjNo6TMgVR2Kis8Rps9xaEGyrMmQYktBiuvatO8yDnmNKMPkQwNc2PEoSB/6r8ar03DieXx7sWRI6xFoY5SuhccakIVunzsbXg==
Received: from DS7P222CA0001.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::7) by
 DS0PR12MB9037.namprd12.prod.outlook.com (2603:10b6:8:f1::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.23; Tue, 30 May 2023 14:49:33 +0000
Received: from DM6NAM11FT110.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::c9) by DS7P222CA0001.outlook.office365.com
 (2603:10b6:8:2e::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23 via Frontend
 Transport; Tue, 30 May 2023 14:49:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT110.mail.protection.outlook.com (10.13.173.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.22 via Frontend Transport; Tue, 30 May 2023 14:49:32 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 30 May 2023
 07:49:18 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 30 May
 2023 07:49:17 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Tue, 30 May
 2023 07:49:12 -0700
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
Subject: [PATCH v5 9/9] vfio/migration: Add support for switchover ack
 capability
Date: Tue, 30 May 2023 17:48:21 +0300
Message-ID: <20230530144821.1557-10-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230530144821.1557-1-avihaih@nvidia.com>
References: <20230530144821.1557-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT110:EE_|DS0PR12MB9037:EE_
X-MS-Office365-Filtering-Correlation-Id: 453c6842-54cd-4584-8806-08db611d1474
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KpSrLIASNLHba6ISvpwKl7/1Z/Av94/4XQoQph1ZFmEl1JyNt0s7ZsIzZQ2LpNro5e8rcHSmSzECqymblMbZq+t0fYeySFWXRIBKFEbXgJGvAJG7VsqkFNYSolG6uc408rghyzuaUtPfF1wec1Hnj9qZUUT63gdUjAT8pvloClqFfM1uokZArJbqXu+RsXGbXxAyeBqxVdBN+i04C+Ui0ebM6EZhSvhu8SQrdpK/DerMxpwfR/Psm1Z4jHOdQECvSbCLymJTHnojcMvwnXGPSOvYNBsyRAyWWNl7UxJeMMnM2OBUWjZgh8u+4Dtg7iDf87rVKLiXoA1TQSn9zeGzQfDQQAV6wTyW2l8lDuAFL6N3ptYxrnZnvDhXbUMCU6ED7n4gDvNKaxZSxSwjTlIn6pqTtYdCbCWQ/jNcsSiXtvjriGFpDFMhY0RJeV/tpvkhTjo/kMUKMqcagCqkmOQeqHh52anYYODloWjZh1NmNbJ2itvmBAFDu9uPCSw2F8IfzZMxj0kgXd6K+Nm6Sc2S6+F+FFZQKoSURQtRjpQ4x1XMDXkUfR3Jb4UBrfWzadKr4YqGe3iEj/pzcUxcNYlwjaamfCxjpJpOLenLblx5r3s3lEmEu1UBbSUz5fk1DxmoZuahNJ3YdzyOX1BQivG/HUw2LbnJ7zjYVkXqHjsfdIao+sAdOdRAblNBUxJjvBIN+Cwn+PNO625zVe6B13az2R0HXIHANX+fLEjOZEVlMoAK/6XXydHNB3YTKH4CJaNU
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(39860400002)(376002)(396003)(451199021)(40470700004)(36840700001)(46966006)(186003)(2616005)(41300700001)(426003)(336012)(83380400001)(1076003)(26005)(7696005)(6666004)(36860700001)(47076005)(478600001)(40460700003)(54906003)(356005)(7636003)(4326008)(82740400003)(70206006)(70586007)(6916009)(40480700001)(316002)(8936002)(8676002)(5660300002)(7416002)(2906002)(86362001)(82310400005)(36756003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 14:49:32.6778 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 453c6842-54cd-4584-8806-08db611d1474
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT110.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9037
Received-SPF: softfail client-ip=2a01:111:f400:fe59::608;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
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

Use migration switchover ack capability to make sure a VFIO device's
initial bytes are sent and loaded in the destination before the source
stops the VM and attempts to complete the migration.
This can significantly reduce migration downtime for some devices.

As precopy support and precopy initial bytes support come together in
VFIO migration, use x-allow-pre-copy device property to control usage of
this feature as well.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 docs/devel/vfio-migration.rst | 10 +++++++++
 include/hw/vfio/vfio-common.h |  1 +
 hw/vfio/migration.c           | 39 ++++++++++++++++++++++++++++++++++-
 3 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/docs/devel/vfio-migration.rst b/docs/devel/vfio-migration.rst
index e896b2a673..b433cb5bb2 100644
--- a/docs/devel/vfio-migration.rst
+++ b/docs/devel/vfio-migration.rst
@@ -16,6 +16,13 @@ helps to reduce the total downtime of the VM. VFIO devices opt-in to pre-copy
 support by reporting the VFIO_MIGRATION_PRE_COPY flag in the
 VFIO_DEVICE_FEATURE_MIGRATION ioctl.
 
+When pre-copy is supported, it's possible to further reduce downtime by
+enabling "switchover-ack" migration capability.
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
 
+* A ``switchover_ack_needed`` function that checks if the VFIO device uses
+  "switchover-ack" migration capability when this capability is enabled.
+
 * A ``save_state`` function to save the device config space if it is present.
 
 * A ``save_live_complete_precopy`` function that sets the VFIO device in
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index a53ecbe2e0..3677aba4f4 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -69,6 +69,7 @@ typedef struct VFIOMigration {
     uint64_t mig_flags;
     uint64_t precopy_init_size;
     uint64_t precopy_dirty_size;
+    bool initial_data_sent;
 } VFIOMigration;
 
 typedef struct VFIOAddressSpace {
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index cb6923ed3f..53f5787f0e 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -18,6 +18,8 @@
 #include "sysemu/runstate.h"
 #include "hw/vfio/vfio-common.h"
 #include "migration/migration.h"
+#include "migration/options.h"
+#include "migration/savevm.h"
 #include "migration/vmstate.h"
 #include "migration/qemu-file.h"
 #include "migration/register.h"
@@ -45,6 +47,7 @@
 #define VFIO_MIG_FLAG_DEV_CONFIG_STATE  (0xffffffffef100002ULL)
 #define VFIO_MIG_FLAG_DEV_SETUP_STATE   (0xffffffffef100003ULL)
 #define VFIO_MIG_FLAG_DEV_DATA_STATE    (0xffffffffef100004ULL)
+#define VFIO_MIG_FLAG_DEV_INIT_DATA_SENT (0xffffffffef100005ULL)
 
 /*
  * This is an arbitrary size based on migration of mlx5 devices, where typically
@@ -385,6 +388,7 @@ static void vfio_save_cleanup(void *opaque)
     migration->data_buffer = NULL;
     migration->precopy_init_size = 0;
     migration->precopy_dirty_size = 0;
+    migration->initial_data_sent = false;
     vfio_migration_cleanup(vbasedev);
     trace_vfio_save_cleanup(vbasedev->name);
 }
@@ -458,10 +462,17 @@ static int vfio_save_iterate(QEMUFile *f, void *opaque)
     if (data_size < 0) {
         return data_size;
     }
-    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
 
     vfio_update_estimated_pending_data(migration, data_size);
 
+    if (migrate_switchover_ack() && !migration->precopy_init_size &&
+        !migration->initial_data_sent) {
+        qemu_put_be64(f, VFIO_MIG_FLAG_DEV_INIT_DATA_SENT);
+        migration->initial_data_sent = true;
+    } else {
+        qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
+    }
+
     trace_vfio_save_iterate(vbasedev->name, migration->precopy_init_size,
                             migration->precopy_dirty_size);
 
@@ -580,6 +591,24 @@ static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
             }
             break;
         }
+        case VFIO_MIG_FLAG_DEV_INIT_DATA_SENT:
+        {
+            if (!vfio_precopy_supported(vbasedev) ||
+                !migrate_switchover_ack()) {
+                error_report("%s: Received INIT_DATA_SENT but switchover ack "
+                             "is not used", vbasedev->name);
+                return -EINVAL;
+            }
+
+            ret = qemu_loadvm_approve_switchover();
+            if (ret) {
+                error_report(
+                    "%s: qemu_loadvm_approve_switchover failed, err=%d (%s)",
+                    vbasedev->name, ret, strerror(-ret));
+            }
+
+            return ret;
+        }
         default:
             error_report("%s: Unknown tag 0x%"PRIx64, vbasedev->name, data);
             return -EINVAL;
@@ -594,6 +623,13 @@ static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
     return ret;
 }
 
+static bool vfio_switchover_ack_needed(void *opaque)
+{
+    VFIODevice *vbasedev = opaque;
+
+    return vfio_precopy_supported(vbasedev);
+}
+
 static const SaveVMHandlers savevm_vfio_handlers = {
     .save_setup = vfio_save_setup,
     .save_cleanup = vfio_save_cleanup,
@@ -606,6 +642,7 @@ static const SaveVMHandlers savevm_vfio_handlers = {
     .load_setup = vfio_load_setup,
     .load_cleanup = vfio_load_cleanup,
     .load_state = vfio_load_state,
+    .switchover_ack_needed = vfio_switchover_ack_needed,
 };
 
 /* ---------------------------------------------------------------------- */
-- 
2.26.3


