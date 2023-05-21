Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C84F70AE82
	for <lists+qemu-devel@lfdr.de>; Sun, 21 May 2023 17:20:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0kq1-0008B0-9f; Sun, 21 May 2023 11:19:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q0kpz-0008Ac-IP
 for qemu-devel@nongnu.org; Sun, 21 May 2023 11:19:11 -0400
Received: from mail-dm6nam12on2061e.outbound.protection.outlook.com
 ([2a01:111:f400:fe59::61e]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q0kpx-0000Di-Ia
 for qemu-devel@nongnu.org; Sun, 21 May 2023 11:19:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jrGO7mMCLmXNnf3gmrwDz3zHCVE6I2E+POkPQ/NCOsG7WP9KIXhB/ClCUH+3TICBXxfIXsUzIOt5X4KYd2kQdNV+Yya6uhYN7C9tzxRE6EwzsJRGXELRw43/vV92HJ48/yQ/fVR3hJc05Qy6LlXPvlhNwnKoAhQL9AwUl8NKIL6zF2mUjPzgr7GlQ4qa00jhi4n+fakwlvwmarSEbtVEMs7OYNtWqrAC7RyLPyhoy/glR5vMVkQlRcTeaWXNi1dMj/2xsEiCCbJXJHy4MKN39ZJFDKYyA5EXWUsOH0pX1CHeuGt8/0ik1F/kD4yyEJqzPs6zz06tXWkssvvyHM3K5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Poiqe3+me1PhaOPH9hHkGaB2BUY6p+YVobaeKXeQ+IQ=;
 b=mHKka7pbBbWQy1Klpvp96PTiIQhgMQsCYBDduuPcHQxY0jyruOgubs3JRZW9mS/7d9E0EN+B2jcE7l5DTgaHZYAAzZjTLHgdVP0ECFJTx8pzceUkVg3inqyC1A8JVbtsyW9FiqKlvsgzP/7hSmlidSW2nQXNdOVFJrm/5650Kre2gMuRgpR8UH0JANYLuGNyLv8UExBkYed83mUTgvWlvZpQTVXUbBFBNTui1xvFG8aLv5fJ0udMM0uGfvf7CO+8zCSnEQQYB9E4vfDEr93xvM/gWxI+AnFjfdtEe8ZIDlynlnOBbwauMjnUTFvWtuZ4pulM1m7kK5T/rgz+yo42CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Poiqe3+me1PhaOPH9hHkGaB2BUY6p+YVobaeKXeQ+IQ=;
 b=gS7UaBc+4HxhNauMCW7+vf9gClmm6kQ4eRfk6cDJbvd2I53PlFVtEMJKTBSof5CwvJUNV4i95DwIMKKhSRDnSxq+zy5HY4YuIBJRUlqTt0W0oQB9qZI+DvpIhOVhKIHTxQBJ4HRJFaIOtEd/z9STOk78HjYMadzqXFptJgKyV7vTqXXGbamqnswUR/yoL8KxrUQX/XRrq/2gF8jpMiJMvUGXAFL93rplIxnrcsSTQLL7nRzKBwOvVrz1Y1CPnslC8L8yeEQlNhWY57CbDC4ntThkF+qTWH4Mz+V2JlIjzGiOvNGMCMEOqu+6xjwPzJ5JQS5pAQOLivYoFbr+ogY9sw==
Received: from DS7PR03CA0349.namprd03.prod.outlook.com (2603:10b6:8:55::24) by
 DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.28; Sun, 21 May 2023 15:19:05 +0000
Received: from DM6NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:55:cafe::a4) by DS7PR03CA0349.outlook.office365.com
 (2603:10b6:8:55::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28 via Frontend
 Transport; Sun, 21 May 2023 15:19:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT082.mail.protection.outlook.com (10.13.173.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.28 via Frontend Transport; Sun, 21 May 2023 15:19:05 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 21 May 2023
 08:18:54 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 21 May
 2023 08:18:54 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Sun, 21 May
 2023 08:18:49 -0700
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
Subject: [PATCH v3 7/7] vfio/migration: Add support for switchover ack
 capability
Date: Sun, 21 May 2023 18:18:08 +0300
Message-ID: <20230521151808.24804-8-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230521151808.24804-1-avihaih@nvidia.com>
References: <20230521151808.24804-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT082:EE_|DS7PR12MB6095:EE_
X-MS-Office365-Filtering-Correlation-Id: e3e382c3-5457-4c29-7f7a-08db5a0eb778
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RR5R+Rnyp6t+lE1VIkMdan/f2rDK8dQbpRqNKWI3pO+16M2cJGFqzg+609NIlApP4HhmnOMV8RFpUOm/v72UFpI2DJ521bSlMWDsx2ZhAvgUMWR6s6rLdUVFmm6wNiSITlf1Kt+S44FCZXyAHf+S4lGEl7ccQ3xUsJlk3bfucfwrRQMAUQO2ABv5HFtsZFlmTJo3/ReY5uoPfVJ1HITrV2EGqlGSKE4ixYM2dpEo3WwZH9cO+dIw28DUt+M20lJ7M+A0uq6OYDIxCjisRhKjamiOdpo7RFKNAR4dQufhMgwxxj6pO+nGsQD/9JbH4MoegaWQ5MCvlX5resna1QRugZRwxT6BVN5w8gW3dmazrxr+DmMoSXEU4oY40OhF6munXkn9CMWwgYKttXjr6pSK1Qh4EtxHSsuGGg8KzV0OXdfYBWZRWRuqprGfk3zG2klbhvAPsyjmbbcW36Jk+/P2+Q7feb5OnmhNbSoH6ulQ7a/vk6LODza3pmEZD3bOQnkqKAAva/X5QtvXSfhPzGqN/t7qZBtsmdU3aibXGuYr0ZMpc+cge4ZvKLoUbD8ujiXPjlPltydmq3EUFxxsjXh9yXET6f28oQjr6SsuXLXjcnzam0E8gzsnjHNdQtn+qaLUE/PL8UlnjbcNmHA2amSrFZI9aKU74COYsLuGuaGPWLeQpcELq9Bfr01xbnP92dxgvvjjnagh8ykPaF+OrS2jWTHIk5nEok4a1QoILLVULnRVMnBo+umiLE45Q59FI/d8
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199021)(46966006)(40470700004)(36840700001)(6666004)(478600001)(1076003)(26005)(4326008)(6916009)(316002)(41300700001)(70586007)(70206006)(54906003)(7696005)(40460700003)(8676002)(8936002)(5660300002)(7416002)(82310400005)(86362001)(40480700001)(47076005)(2906002)(83380400001)(36860700001)(82740400003)(7636003)(356005)(186003)(2616005)(36756003)(336012)(426003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2023 15:19:05.5820 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3e382c3-5457-4c29-7f7a-08db5a0eb778
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6095
Received-SPF: softfail client-ip=2a01:111:f400:fe59::61e;
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
 include/hw/vfio/vfio-common.h |  2 ++
 hw/vfio/migration.c           | 42 ++++++++++++++++++++++++++++++++++-
 3 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/docs/devel/vfio-migration.rst b/docs/devel/vfio-migration.rst
index e896b2a673..e75793b76a 100644
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
index 5ce7a01d56..b4a7eb0f9a 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -69,6 +69,8 @@ typedef struct VFIOMigration {
     uint64_t precopy_init_size;
     uint64_t precopy_dirty_size;
     uint64_t mig_flags;
+    bool switchover_ack_needed;
+    bool initial_data_sent;
 } VFIOMigration;
 
 typedef struct VFIOAddressSpace {
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 418efed019..09c669c1d8 100644
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
+    migration->switchover_ack_needed = false;
+    migration->initial_data_sent = false;
     vfio_migration_cleanup(vbasedev);
     trace_vfio_save_cleanup(vbasedev->name);
 }
@@ -455,10 +459,17 @@ static int vfio_save_iterate(QEMUFile *f, void *opaque)
     if (data_size < 0) {
         return data_size;
     }
-    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
 
     vfio_update_estimated_pending_data(migration, data_size);
 
+    if (migration->switchover_ack_needed && !migration->precopy_init_size &&
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
+            if (!vbasedev->migration->switchover_ack_needed) {
+                error_report("%s: Received INIT_DATA_SENT but switchover ack "
+                             "is not needed",
+                             vbasedev->name);
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
@@ -590,6 +619,16 @@ static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
     return ret;
 }
 
+static bool vfio_switchover_ack_needed(void *opaque)
+{
+    VFIODevice *vbasedev = opaque;
+    VFIOMigration *migration = vbasedev->migration;
+
+    migration->switchover_ack_needed = vfio_precopy_supported(vbasedev);
+
+    return migration->switchover_ack_needed;
+}
+
 static const SaveVMHandlers savevm_vfio_handlers = {
     .save_setup = vfio_save_setup,
     .save_cleanup = vfio_save_cleanup,
@@ -602,6 +641,7 @@ static const SaveVMHandlers savevm_vfio_handlers = {
     .load_setup = vfio_load_setup,
     .load_cleanup = vfio_load_cleanup,
     .load_state = vfio_load_state,
+    .switchover_ack_needed = vfio_switchover_ack_needed,
 };
 
 /* ---------------------------------------------------------------------- */
-- 
2.26.3


