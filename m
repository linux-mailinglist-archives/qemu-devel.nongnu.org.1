Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5347164F3
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 16:49:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q40f8-0003m2-Al; Tue, 30 May 2023 10:49:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q40f5-0003fW-AB
 for qemu-devel@nongnu.org; Tue, 30 May 2023 10:49:23 -0400
Received: from mail-bn1nam02on2060c.outbound.protection.outlook.com
 ([2a01:111:f400:7eb2::60c]
 helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q40f0-0007tZ-I0
 for qemu-devel@nongnu.org; Tue, 30 May 2023 10:49:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJebkwNbbFzow3DgO8BFmN6hdCGU+1LQk1Q4pke+CeC8FmFnD/H4mWeaA2mhCUenLnMYECtL0x9uXvOVz7WIuSmrR1Bus4nZVt+VxyqpWaU/kSIzKExB2XLPUZeUrG8T8p2UNN0SzCyE6OkBh8wVm8IbwCpjy10WB+ib1Xpsxo/q6dYwuJ8FCA40pgETFevHNB3jL0iTSUYKHJC8LNb7EwGlkVqx/Ne8Z7RXEPcfT32rkYz7wVXO/zVgquXIyHbmmnhwCMT0BrhpwVKVhhI/Gs7P98bqFs7ORwecUuy9eu7ChG+cJyJgSy5k1dQFlcv2/BcjR2b8pe8NSZt3udOr1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/oZU+HNaDXjCE88v99GPoErk1i83ZqSF8dxeplJClB8=;
 b=AtfDN/nxsUjjDEfD17t0Gr78Zhwv5ERwOu68ogyIZa9hRkl9URYIk+YbKN2HuyzO3Sd1txYv3r/iczC8Q4h1Za4VgHALvuMtE/8W3jRG+l2zUF+o5La20joJ7YSSjvTX1kii9pi2X/Y8oBVd9r4RTfhDksFf01zF+9yfe+hMRoYvtbiTE1Y2lvXhtWOaMb2f6FQ0DYBi2EZO6oiZGUvhWOIBtzlsvF7hnQWvirhBwNcTdHIVNZOugvjhzbPNYBbpjTU03fD/MqvkIYJt3CFMLpOBsLHQ5VKNiWBQVeL6GMJUnVXirbcF+ddap02TSiwsqZpOyegi80tzXAmBW2ZzTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/oZU+HNaDXjCE88v99GPoErk1i83ZqSF8dxeplJClB8=;
 b=RSzrvLxn++AmgE2fRpQKWt1ybAo48wlaDZTZY+LdL+IvjlY8zP/euvwXj2hyIbYFs8EkmaBSR2za83JiFBzL/rvt1cFBtpIyGNgJehww+pcWcRtC89/NSLzJnHb+JTzmBFyREICxragbW0kS+5AuDrciFmauQ850SpQEp/Vo0dMwVMhmzAvowJ+rccWi2ldcd21SFQY9DH0CfxGEJKOHVkWBV3If8FKVPeewO+GPtsZwp4quIT749m1HBcRX9k35XMqmAm4DGEwyb5xUgvNVERgd4Kr5nFvs0FnVZd96Yq+9Sg1t+gm4X21wTN5y6OvpybO44XzxpLq/GEjCZqtXUQ==
Received: from BN0PR04CA0209.namprd04.prod.outlook.com (2603:10b6:408:e9::34)
 by IA1PR12MB6114.namprd12.prod.outlook.com (2603:10b6:208:3ea::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 14:49:14 +0000
Received: from BN8NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::d6) by BN0PR04CA0209.outlook.office365.com
 (2603:10b6:408:e9::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22 via Frontend
 Transport; Tue, 30 May 2023 14:49:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT079.mail.protection.outlook.com (10.13.177.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.22 via Frontend Transport; Tue, 30 May 2023 14:49:14 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 30 May 2023
 07:49:07 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 30 May
 2023 07:49:06 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Tue, 30 May
 2023 07:49:01 -0700
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
Subject: [PATCH v5 7/9] vfio/migration: Add VFIO migration pre-copy support
Date: Tue, 30 May 2023 17:48:19 +0300
Message-ID: <20230530144821.1557-8-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230530144821.1557-1-avihaih@nvidia.com>
References: <20230530144821.1557-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT079:EE_|IA1PR12MB6114:EE_
X-MS-Office365-Filtering-Correlation-Id: 970190cf-02ca-4021-9438-08db611d099c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +SZet5DzTV8n2dlQ59Y4O1M4R75I/nL2FWEI+8y5z79cGkpbKDCrjYjmOcR6LxaKKgZYfS/rZi4wklbRDQFln8i/9tV7UA5zlnc+43ZFKweWOiEK6+pOLNULql9/cyJCRn/NAn3YzPaW+hEtoE8nYDw5duMVDAGjyV/ua1vtsPNoURdEd9hQ1krXdMDexZll/vCNzdDnJVIlTA3qK8MPw4vw3SEBq908/cNdEhMnzZFbEk9fJ6fmSdhl5bIF+ajarb62xtjyJhiAd125HjbkReziUZViIOYCwa776eYwlHQxl6zi0eifcHShAPfiNMeEjcwC06oDR0aps+t0lfgV0smKuhn6hVB1NAKXIx+kAZy8Q+03PkV8o3luXcl72avxSf65C12ULcmCLdXwQCScaSeZxjER9TOss7NjJrxU6kouGbmQhMeVE3IakhXr/vqaHjt8L3DKASfSZv6PTjULnu4PU3ELIjE5FDoY6lmudd6k01yaoOzh7pvBKSaov51xVfFFrLv/sokKzuYF06Cm2nucEr+e7z/q81KaVJdI52Wd6heQVnnxbd/feJvmelDOOSA+m1SBMIdr5SNUym1lffiaZ+RCZhp9bbSSEFg8AtRpHiebeypbtdcMlUYdAjrYzN59HfkmINPCcD0JPxHHuHvUH9PY+kFBfx5sL4zMZXB8y6eQfrPQCsWwqECLYlgwtBBnHI+NJKkxZGf+zsaJNniJMMazeX8ilabpsILds88GT/dqTrlIClZ3buQKhbXs
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199021)(40470700004)(46966006)(36840700001)(186003)(2616005)(41300700001)(426003)(336012)(83380400001)(1076003)(26005)(66574015)(7696005)(6666004)(36860700001)(47076005)(478600001)(40460700003)(54906003)(7636003)(4326008)(356005)(82740400003)(70206006)(70586007)(6916009)(40480700001)(316002)(8936002)(8676002)(5660300002)(7416002)(2906002)(86362001)(82310400005)(30864003)(36756003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 14:49:14.4384 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 970190cf-02ca-4021-9438-08db611d099c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6114
Received-SPF: softfail client-ip=2a01:111:f400:7eb2::60c;
 envelope-from=avihaih@nvidia.com;
 helo=NAM02-BN1-obe.outbound.protection.outlook.com
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

Pre-copy support allows the VFIO device data to be transferred while the
VM is running. This helps to accommodate VFIO devices that have a large
amount of data that needs to be transferred, and it can reduce migration
downtime.

Pre-copy support is optional in VFIO migration protocol v2.
Implement pre-copy of VFIO migration protocol v2 and use it for devices
that support it. Full description of it can be found in the following
Linux commit: 4db52602a607 ("vfio: Extend the device migration protocol
with PRE_COPY").

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 docs/devel/vfio-migration.rst |  35 +++++---
 include/hw/vfio/vfio-common.h |   2 +
 hw/vfio/common.c              |   6 +-
 hw/vfio/migration.c           | 165 ++++++++++++++++++++++++++++++++--
 hw/vfio/trace-events          |   4 +-
 5 files changed, 190 insertions(+), 22 deletions(-)

diff --git a/docs/devel/vfio-migration.rst b/docs/devel/vfio-migration.rst
index 1b68ccf115..e896b2a673 100644
--- a/docs/devel/vfio-migration.rst
+++ b/docs/devel/vfio-migration.rst
@@ -7,12 +7,14 @@ the guest is running on source host and restoring this saved state on the
 destination host. This document details how saving and restoring of VFIO
 devices is done in QEMU.
 
-Migration of VFIO devices currently consists of a single stop-and-copy phase.
-During the stop-and-copy phase the guest is stopped and the entire VFIO device
-data is transferred to the destination.
-
-The pre-copy phase of migration is currently not supported for VFIO devices.
-Support for VFIO pre-copy will be added later on.
+Migration of VFIO devices consists of two phases: the optional pre-copy phase,
+and the stop-and-copy phase. The pre-copy phase is iterative and allows to
+accommodate VFIO devices that have a large amount of data that needs to be
+transferred. The iterative pre-copy phase of migration allows for the guest to
+continue whilst the VFIO device state is transferred to the destination, this
+helps to reduce the total downtime of the VM. VFIO devices opt-in to pre-copy
+support by reporting the VFIO_MIGRATION_PRE_COPY flag in the
+VFIO_DEVICE_FEATURE_MIGRATION ioctl.
 
 Note that currently VFIO migration is supported only for a single device. This
 is due to VFIO migration's lack of P2P support. However, P2P support is planned
@@ -29,10 +31,20 @@ VFIO implements the device hooks for the iterative approach as follows:
 * A ``load_setup`` function that sets the VFIO device on the destination in
   _RESUMING state.
 
+* A ``state_pending_estimate`` function that reports an estimate of the
+  remaining pre-copy data that the vendor driver has yet to save for the VFIO
+  device.
+
 * A ``state_pending_exact`` function that reads pending_bytes from the vendor
   driver, which indicates the amount of data that the vendor driver has yet to
   save for the VFIO device.
 
+* An ``is_active_iterate`` function that indicates ``save_live_iterate`` is
+  active only when the VFIO device is in pre-copy states.
+
+* A ``save_live_iterate`` function that reads the VFIO device's data from the
+  vendor driver during iterative pre-copy phase.
+
 * A ``save_state`` function to save the device config space if it is present.
 
 * A ``save_live_complete_precopy`` function that sets the VFIO device in
@@ -111,8 +123,10 @@ Flow of state changes during Live migration
 ===========================================
 
 Below is the flow of state change during live migration.
-The values in the brackets represent the VM state, the migration state, and
+The values in the parentheses represent the VM state, the migration state, and
 the VFIO device state, respectively.
+The text in the square brackets represents the flow if the VFIO device supports
+pre-copy.
 
 Live migration save path
 ------------------------
@@ -124,11 +138,12 @@ Live migration save path
                                   |
                      migrate_init spawns migration_thread
                 Migration thread then calls each device's .save_setup()
-                       (RUNNING, _SETUP, _RUNNING)
+                  (RUNNING, _SETUP, _RUNNING [_PRE_COPY])
                                   |
-                      (RUNNING, _ACTIVE, _RUNNING)
-             If device is active, get pending_bytes by .state_pending_exact()
+                  (RUNNING, _ACTIVE, _RUNNING [_PRE_COPY])
+      If device is active, get pending_bytes by .state_pending_{estimate,exact}()
           If total pending_bytes >= threshold_size, call .save_live_iterate()
+                  [Data of VFIO device for pre-copy phase is copied]
         Iterate till total pending bytes converge and are less than threshold
                                   |
   On migration completion, vCPU stops and calls .save_live_complete_precopy for
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 5f29dab839..1db901c194 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -67,6 +67,8 @@ typedef struct VFIOMigration {
     void *data_buffer;
     size_t data_buffer_size;
     uint64_t mig_flags;
+    uint64_t precopy_init_size;
+    uint64_t precopy_dirty_size;
 } VFIOMigration;
 
 typedef struct VFIOAddressSpace {
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 78358ede27..b73086e17a 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -492,7 +492,8 @@ static bool vfio_devices_all_dirty_tracking(VFIOContainer *container)
             }
 
             if (vbasedev->pre_copy_dirty_page_tracking == ON_OFF_AUTO_OFF &&
-                migration->device_state == VFIO_DEVICE_STATE_RUNNING) {
+                (migration->device_state == VFIO_DEVICE_STATE_RUNNING ||
+                 migration->device_state == VFIO_DEVICE_STATE_PRE_COPY)) {
                 return false;
             }
         }
@@ -537,7 +538,8 @@ static bool vfio_devices_all_running_and_mig_active(VFIOContainer *container)
                 return false;
             }
 
-            if (migration->device_state == VFIO_DEVICE_STATE_RUNNING) {
+            if (migration->device_state == VFIO_DEVICE_STATE_RUNNING ||
+                migration->device_state == VFIO_DEVICE_STATE_PRE_COPY) {
                 continue;
             } else {
                 return false;
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 8d33414379..d8f6a22ae1 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -68,6 +68,8 @@ static const char *mig_state_to_str(enum vfio_device_mig_state state)
         return "STOP_COPY";
     case VFIO_DEVICE_STATE_RESUMING:
         return "RESUMING";
+    case VFIO_DEVICE_STATE_PRE_COPY:
+        return "PRE_COPY";
     default:
         return "UNKNOWN STATE";
     }
@@ -241,6 +243,25 @@ static int vfio_query_stop_copy_size(VFIODevice *vbasedev,
     return 0;
 }
 
+static int vfio_query_precopy_size(VFIOMigration *migration)
+{
+    struct vfio_precopy_info precopy = {
+        .argsz = sizeof(precopy),
+    };
+
+    migration->precopy_init_size = 0;
+    migration->precopy_dirty_size = 0;
+
+    if (ioctl(migration->data_fd, VFIO_MIG_GET_PRECOPY_INFO, &precopy)) {
+        return -errno;
+    }
+
+    migration->precopy_init_size = precopy.initial_bytes;
+    migration->precopy_dirty_size = precopy.dirty_bytes;
+
+    return 0;
+}
+
 /* Returns the size of saved data on success and -errno on error */
 static ssize_t vfio_save_block(QEMUFile *f, VFIOMigration *migration)
 {
@@ -249,6 +270,14 @@ static ssize_t vfio_save_block(QEMUFile *f, VFIOMigration *migration)
     data_size = read(migration->data_fd, migration->data_buffer,
                      migration->data_buffer_size);
     if (data_size < 0) {
+        /*
+         * Pre-copy emptied all the device state for now. For more information,
+         * please refer to the Linux kernel VFIO uAPI.
+         */
+        if (errno == ENOMSG) {
+            return 0;
+        }
+
         return -errno;
     }
     if (data_size == 0) {
@@ -265,6 +294,38 @@ static ssize_t vfio_save_block(QEMUFile *f, VFIOMigration *migration)
     return qemu_file_get_error(f) ?: data_size;
 }
 
+static void vfio_update_estimated_pending_data(VFIOMigration *migration,
+                                               uint64_t data_size)
+{
+    if (!data_size) {
+        /*
+         * Pre-copy emptied all the device state for now, update estimated sizes
+         * accordingly.
+         */
+        migration->precopy_init_size = 0;
+        migration->precopy_dirty_size = 0;
+
+        return;
+    }
+
+    if (migration->precopy_init_size) {
+        uint64_t init_size = MIN(migration->precopy_init_size, data_size);
+
+        migration->precopy_init_size -= init_size;
+        data_size -= init_size;
+    }
+
+    migration->precopy_dirty_size -= MIN(migration->precopy_dirty_size,
+                                         data_size);
+}
+
+static bool vfio_precopy_supported(VFIODevice *vbasedev)
+{
+    VFIOMigration *migration = vbasedev->migration;
+
+    return migration->mig_flags & VFIO_MIGRATION_PRE_COPY;
+}
+
 /* ---------------------------------------------------------------------- */
 
 static int vfio_save_setup(QEMUFile *f, void *opaque)
@@ -285,6 +346,28 @@ static int vfio_save_setup(QEMUFile *f, void *opaque)
         return -ENOMEM;
     }
 
+    if (vfio_precopy_supported(vbasedev)) {
+        int ret;
+
+        switch (migration->device_state) {
+        case VFIO_DEVICE_STATE_RUNNING:
+            ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_PRE_COPY,
+                                           VFIO_DEVICE_STATE_RUNNING);
+            if (ret) {
+                return ret;
+            }
+
+            vfio_query_precopy_size(migration);
+
+            break;
+        case VFIO_DEVICE_STATE_STOP:
+            /* vfio_save_complete_precopy() will go to STOP_COPY */
+            break;
+        default:
+            return -EINVAL;
+        }
+    }
+
     trace_vfio_save_setup(vbasedev->name, migration->data_buffer_size);
 
     qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
@@ -299,26 +382,42 @@ static void vfio_save_cleanup(void *opaque)
 
     g_free(migration->data_buffer);
     migration->data_buffer = NULL;
+    migration->precopy_init_size = 0;
+    migration->precopy_dirty_size = 0;
     vfio_migration_cleanup(vbasedev);
     trace_vfio_save_cleanup(vbasedev->name);
 }
 
+static void vfio_state_pending_estimate(void *opaque, uint64_t *must_precopy,
+                                        uint64_t *can_postcopy)
+{
+    VFIODevice *vbasedev = opaque;
+    VFIOMigration *migration = vbasedev->migration;
+
+    if (migration->device_state != VFIO_DEVICE_STATE_PRE_COPY) {
+        return;
+    }
+
+    *must_precopy +=
+        migration->precopy_init_size + migration->precopy_dirty_size;
+
+    trace_vfio_state_pending_estimate(vbasedev->name, *must_precopy,
+                                      *can_postcopy,
+                                      migration->precopy_init_size,
+                                      migration->precopy_dirty_size);
+}
+
 /*
  * Migration size of VFIO devices can be as little as a few KBs or as big as
  * many GBs. This value should be big enough to cover the worst case.
  */
 #define VFIO_MIG_STOP_COPY_SIZE (100 * GiB)
 
-/*
- * Only exact function is implemented and not estimate function. The reason is
- * that during pre-copy phase of migration the estimate function is called
- * repeatedly while pending RAM size is over the threshold, thus migration
- * can't converge and querying the VFIO device pending data size is useless.
- */
 static void vfio_state_pending_exact(void *opaque, uint64_t *must_precopy,
                                      uint64_t *can_postcopy)
 {
     VFIODevice *vbasedev = opaque;
+    VFIOMigration *migration = vbasedev->migration;
     uint64_t stop_copy_size = VFIO_MIG_STOP_COPY_SIZE;
 
     /*
@@ -328,8 +427,48 @@ static void vfio_state_pending_exact(void *opaque, uint64_t *must_precopy,
     vfio_query_stop_copy_size(vbasedev, &stop_copy_size);
     *must_precopy += stop_copy_size;
 
+    if (migration->device_state == VFIO_DEVICE_STATE_PRE_COPY) {
+        vfio_query_precopy_size(migration);
+
+        *must_precopy +=
+            migration->precopy_init_size + migration->precopy_dirty_size;
+    }
+
     trace_vfio_state_pending_exact(vbasedev->name, *must_precopy, *can_postcopy,
-                                   stop_copy_size);
+                                   stop_copy_size, migration->precopy_init_size,
+                                   migration->precopy_dirty_size);
+}
+
+static bool vfio_is_active_iterate(void *opaque)
+{
+    VFIODevice *vbasedev = opaque;
+    VFIOMigration *migration = vbasedev->migration;
+
+    return migration->device_state == VFIO_DEVICE_STATE_PRE_COPY;
+}
+
+static int vfio_save_iterate(QEMUFile *f, void *opaque)
+{
+    VFIODevice *vbasedev = opaque;
+    VFIOMigration *migration = vbasedev->migration;
+    ssize_t data_size;
+
+    data_size = vfio_save_block(f, migration);
+    if (data_size < 0) {
+        return data_size;
+    }
+    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
+
+    vfio_update_estimated_pending_data(migration, data_size);
+
+    trace_vfio_save_iterate(vbasedev->name, migration->precopy_init_size,
+                            migration->precopy_dirty_size);
+
+    /*
+     * A VFIO device's pre-copy dirty_bytes is not guaranteed to reach zero.
+     * Return 1 so following handlers will not be potentially blocked.
+     */
+    return 1;
 }
 
 static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
@@ -338,7 +477,7 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
     ssize_t data_size;
     int ret;
 
-    /* We reach here with device state STOP only */
+    /* We reach here with device state STOP or STOP_COPY only */
     ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_STOP_COPY,
                                    VFIO_DEVICE_STATE_STOP);
     if (ret) {
@@ -457,7 +596,10 @@ static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
 static const SaveVMHandlers savevm_vfio_handlers = {
     .save_setup = vfio_save_setup,
     .save_cleanup = vfio_save_cleanup,
+    .state_pending_estimate = vfio_state_pending_estimate,
     .state_pending_exact = vfio_state_pending_exact,
+    .is_active_iterate = vfio_is_active_iterate,
+    .save_live_iterate = vfio_save_iterate,
     .save_live_complete_precopy = vfio_save_complete_precopy,
     .save_state = vfio_save_state,
     .load_setup = vfio_load_setup,
@@ -470,13 +612,18 @@ static const SaveVMHandlers savevm_vfio_handlers = {
 static void vfio_vmstate_change(void *opaque, bool running, RunState state)
 {
     VFIODevice *vbasedev = opaque;
+    VFIOMigration *migration = vbasedev->migration;
     enum vfio_device_mig_state new_state;
     int ret;
 
     if (running) {
         new_state = VFIO_DEVICE_STATE_RUNNING;
     } else {
-        new_state = VFIO_DEVICE_STATE_STOP;
+        new_state =
+            (migration->device_state == VFIO_DEVICE_STATE_PRE_COPY &&
+             (state == RUN_STATE_FINISH_MIGRATE || state == RUN_STATE_PAUSED)) ?
+                VFIO_DEVICE_STATE_STOP_COPY :
+                VFIO_DEVICE_STATE_STOP;
     }
 
     /*
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 646e42fd27..4150b59e58 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -162,6 +162,8 @@ vfio_save_block(const char *name, int data_size) " (%s) data_size %d"
 vfio_save_cleanup(const char *name) " (%s)"
 vfio_save_complete_precopy(const char *name, int ret) " (%s) ret %d"
 vfio_save_device_config_state(const char *name) " (%s)"
+vfio_save_iterate(const char *name, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy initial size 0x%"PRIx64" precopy dirty size 0x%"PRIx64
 vfio_save_setup(const char *name, uint64_t data_buffer_size) " (%s) data buffer size 0x%"PRIx64
-vfio_state_pending_exact(const char *name, uint64_t precopy, uint64_t postcopy, uint64_t stopcopy_size) " (%s) precopy 0x%"PRIx64" postcopy 0x%"PRIx64" stopcopy size 0x%"PRIx64
+vfio_state_pending_estimate(const char *name, uint64_t precopy, uint64_t postcopy, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy 0x%"PRIx64" postcopy 0x%"PRIx64" precopy initial size 0x%"PRIx64" precopy dirty size 0x%"PRIx64
+vfio_state_pending_exact(const char *name, uint64_t precopy, uint64_t postcopy, uint64_t stopcopy_size, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy 0x%"PRIx64" postcopy 0x%"PRIx64" stopcopy size 0x%"PRIx64" precopy initial size 0x%"PRIx64" precopy dirty size 0x%"PRIx64
 vfio_vmstate_change(const char *name, int running, const char *reason, const char *dev_state) " (%s) running %d reason %s device state %s"
-- 
2.26.3


