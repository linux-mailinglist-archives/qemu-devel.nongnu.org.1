Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A3D73823A
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 13:13:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBvlz-0008VV-P9; Wed, 21 Jun 2023 07:13:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qBvlu-0008EU-6O
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 07:13:10 -0400
Received: from mail-mw2nam10on2060f.outbound.protection.outlook.com
 ([2a01:111:f400:7e89::60f]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qBvlh-0002aG-JF
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 07:13:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RVB4WFG+pbFmjVrOHWZr7bJ6Xi6JsEjcuwCYR0OWhPJFYdHg20S4XQ2GEXcPF3+cLbbF8EWaHOdzqZD2jxxEPh/ptM8f/jOLCTM3b1U+17zaHvhcEyU1hLbPbS5svybW+IL0RusTrXYaiBGudJ3h60Pc1VmE2dCCfluEsAjJdyXcXYNt8afuwHEmewAIk/0ZyRJfyOddMXVWAyTI9fOHzdIgxud6CvQYRnfFLauBzx0pVfrqzaeCGPHpPjIp/AsWJMxxOcBHXTlg3RWTH1Qqkqzya3TaCvTIpPAATqnu048hUB6i0Rk1tp9t5s360o4cN199Z5FN0reKqRKRgPEwLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=go2NA/nyi2HtwKPRDB3OYy2WQbs8bK1OWD8hj4be3QA=;
 b=BEBV/V/jLqekwBjsDnhtuABqvudK5MmGEaJ/kRI9PDcazvd1qaqNGMyuPr12X6XfqtiS5RkoYkl+K3F6zUGEyMe8unag90cpoHKjn67n/8lYCu4LwxWi+0pwydgYZHpI9r508z7V4HYCdLwG7ebzRvdayqmSnvtnW64vosFMohivGVRv+lRi03WFumihuy2u6LQ3yDLp/H93PDucZ1sv9pL/kfrSClXSFB+PPttBgrlYPh+WALWkPASAT25dVmgStOiJBXNA+Ds7jOwP8KZKv056dGB7Xd/k3qq503bzaTykOboYd2eox6Dxh5EPZockCugLpuJqyfWvRiycuJXq7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=go2NA/nyi2HtwKPRDB3OYy2WQbs8bK1OWD8hj4be3QA=;
 b=oam0XSZJDqGCLCGpX8gjVW9rruy/d+F8mYZ8i3TxC1lI5gVHLJl9bdKkkFCWMcp8pwOu3B1mCx2YyfswLE7aZWLKPCnhMqpykTK2OrEyijRGsKyHx2/SCyytGt3+U9IE5rnKfyyIU5hGRGpLGKvTqmlLa8Ar8VbQiU80gkgu2a+0lmtookNb2EVJz2ehy+FeS0cckvhrk6fvsSnvhEwq0BJhS5kI6WPAlM8SPP0eKQKTXL68KRqDeiwOt4qI3L63e1Rqn400nFgYd+aTrVy3qU9BEaaCbmYQhATqcKvFlyo51fq2/Bx90ibh/gD7fLtv7DF0lVrso9CN0mkIbV+ZCw==
Received: from DM6PR08CA0046.namprd08.prod.outlook.com (2603:10b6:5:1e0::20)
 by MN0PR12MB5764.namprd12.prod.outlook.com (2603:10b6:208:377::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 11:12:53 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:5:1e0:cafe::dd) by DM6PR08CA0046.outlook.office365.com
 (2603:10b6:5:1e0::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23 via Frontend
 Transport; Wed, 21 Jun 2023 11:12:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.23 via Frontend Transport; Wed, 21 Jun 2023 11:12:52 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 21 Jun 2023
 04:12:45 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 21 Jun
 2023 04:12:44 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Wed, 21 Jun
 2023 04:12:40 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Juan Quintela
 <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Yishai Hadas
 <yishaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb
 <maorg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>, Kirti Wankhede
 <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>, Joao Martins
 <joao.m.martins@oracle.com>
Subject: [PATCH v6 8/8] vfio/migration: Add support for switchover ack
 capability
Date: Wed, 21 Jun 2023 14:12:01 +0300
Message-ID: <20230621111201.29729-9-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230621111201.29729-1-avihaih@nvidia.com>
References: <20230621111201.29729-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|MN0PR12MB5764:EE_
X-MS-Office365-Filtering-Correlation-Id: c43d76d3-cb3d-40c2-7697-08db724874e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aa7ePa2Et49BW/18Uem/LSCeVqYhokxxMllYmRvNqy60I1bLwdsdnGhAII2qXfhA0oFmM+fUJLpsOuUlCJfZTP/U/mO1h/0FokrYbovFzf2RdLaYgb91O87P93g+skW8O9ux25m2ZNHA6cJ2msLRDA124X4QJVH4HClPtiGur6NsnZ/Yh6DmmaUeuAJMm+JSDc3ioDsSjJpgR12zuddNLlT5OQHIuM0u0nQKNHYliPtbCsd1fV0XzmXUy/peN/AierO+jQA1M6jFGz4VAKCCZE7Y8s7wbsNKXBu1Ous+HwQBQXm7iZjbCetezmkXpEi45USjMnCIUAxsCnLbj8hDyyZDScxDsvr+UdZzy9emfVF+4SqEZOdRZM3y1vyhg8eKnurhhAeZiDLI2PJbJZpAAaOft1ZopezaazLpWc4yijU0pjK0WjVUvQg3NXGQ2QAZL7fAKNbmTkmwJa8j/2OgAJ3VEhCBwKDwvlIkZYS1DS9rjPTW96FMW3AI1TVMkYL3wtgxMhpFu0q86XIKzEEyCqffeH16l4ZPEqLVZJNPGa+z5ly1SB3XBnwCkBRyK/AgAFB/+8oGWjxoJ8o/BEySTxqP6FLWhB0TfhP0W172HJ3XdAy3WZ7aFEJl3cOBfqvI4pOkzzgslUfngL2xbpmTca6vig3cPVXJX4gtyQC66JCGUkszao/VMKxYW9aOHwvDPTgPVJmAcF/4+vI30Y17A2aBvFC6Ebn59WClYY+Txz/H59wlOxjyTVIK1UxrqDYm
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199021)(36840700001)(40470700004)(46966006)(2906002)(8936002)(8676002)(7416002)(86362001)(4326008)(6916009)(70586007)(70206006)(316002)(478600001)(41300700001)(54906003)(5660300002)(82740400003)(82310400005)(83380400001)(6666004)(7696005)(36860700001)(66574015)(426003)(2616005)(47076005)(336012)(36756003)(40460700003)(7636003)(356005)(186003)(1076003)(26005)(40480700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 11:12:52.6057 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c43d76d3-cb3d-40c2-7697-08db724874e5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5764
Received-SPF: softfail client-ip=2a01:111:f400:7e89::60f;
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

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: YangHang Liu <yanghliu@redhat.com>
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
index 1db901c194..3dc5f2104c 100644
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
index d8f6a22ae1..acbf0bb7ab 100644
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
@@ -384,6 +387,7 @@ static void vfio_save_cleanup(void *opaque)
     migration->data_buffer = NULL;
     migration->precopy_init_size = 0;
     migration->precopy_dirty_size = 0;
+    migration->initial_data_sent = false;
     vfio_migration_cleanup(vbasedev);
     trace_vfio_save_cleanup(vbasedev->name);
 }
@@ -457,10 +461,17 @@ static int vfio_save_iterate(QEMUFile *f, void *opaque)
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
 
@@ -579,6 +590,24 @@ static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
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
@@ -593,6 +622,13 @@ static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
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
@@ -605,6 +641,7 @@ static const SaveVMHandlers savevm_vfio_handlers = {
     .load_setup = vfio_load_setup,
     .load_cleanup = vfio_load_cleanup,
     .load_state = vfio_load_state,
+    .switchover_ack_needed = vfio_switchover_ack_needed,
 };
 
 /* ---------------------------------------------------------------------- */
-- 
2.26.3


