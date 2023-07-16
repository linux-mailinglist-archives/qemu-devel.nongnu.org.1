Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A844C754DD3
	for <lists+qemu-devel@lfdr.de>; Sun, 16 Jul 2023 10:17:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKwvV-0007p2-6e; Sun, 16 Jul 2023 04:16:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qKwvS-0007ok-DZ
 for qemu-devel@nongnu.org; Sun, 16 Jul 2023 04:16:18 -0400
Received: from mail-dm6nam04on20614.outbound.protection.outlook.com
 ([2a01:111:f400:7e8b::614]
 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qKwvP-0000r2-TN
 for qemu-devel@nongnu.org; Sun, 16 Jul 2023 04:16:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GnxpqOg6k/O3EpQFCe9y5L2fe46OvbJm0XmidwH6/zIxuirwRLkxhJawCvziY4jMUC1HSoidWidVcJ3X0zpoo1axiqySOJWXzf0x/pyba/luJI3XMdCKN4L98/qMgEQsO9Gz5C/Xb9QsBSdvJYb1Lq4kFJ1CheadD39Uigy2ab4ZlDN89vw8ZI4ERmaNdjB+qe/bBVpeaQklbKtPjUcgGVUWQ3maElcJLXfQ6tNPrV2w1vjC+aSkD11R197AKtLvK3/IbSqanVATm7higpUuwQKVhsFXWg24YeOKOt4ORtpAx+EzrYUAF+S6NqnJKMfS+zZzOGN2rlvMzbGCK/e4Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=II9vSQqvsxX2Oi4hRpElLXN6ilXWgk+/XEEI6yfyTVM=;
 b=drSyIGncpHZC261RmnZimeziFzE4W9pcO/ISpOFr3tVJD8blDHcu+692urNBKP6EFhPow1Q28R+RxST/jIdPEAzWHc3ypU7IJ907JSmOh9RFacLwS+XbzSmKew23PFAZg/YooIrheG5LgDYmzI2MmJGT+AjCeW0Oji3s7A7/mg849RvxfulbB0afgF+C6eegPyNJNbBBSKTSlgmGMrmaYFkr6F4dnrNBCLoSU29N4c5/DfcQ2By/J2DhgDNXrJbvb8jw6idIr0yByiUYtoAeY2Dk1WkcRU+agyrJx+Yv4tbzjw+ZcChqXrzyHBtISMp/4AqRclZmyLDG6DskstQHLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=II9vSQqvsxX2Oi4hRpElLXN6ilXWgk+/XEEI6yfyTVM=;
 b=nvdS+1AGGaEU8c14zgZiExYjVG0iY5Fr+fGsNr5MYf3ZQUxfPvzY5WDYE6jcj/HcIgOQO9CjPnej/oPcNEZKthKGh4NSnZwWn3R4U5r+QL001A0RSYQBxvqlMzqnz8gSrVnNYAKfEKWk7qP14nbKe8t6A5d7QFgPTQGVgkqzUI187fgJvn0DbBbt2EvYcgO9vbenmb5meWax69SnmvU156j7P2yr7Wo50MYWG9euICHQu4IuvHTRDrljGPL6SQOnO+8Fcu8+k74Z55LTFq4agTG6JjiWGHoiRYI73B3x/xlJU1dFjobSG+tz2KJ2zOWUwJZkkgFzzHhaLazWnQfC1A==
Received: from MW4PR03CA0224.namprd03.prod.outlook.com (2603:10b6:303:b9::19)
 by PH8PR12MB6699.namprd12.prod.outlook.com (2603:10b6:510:1ce::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Sun, 16 Jul
 2023 08:16:11 +0000
Received: from CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::d) by MW4PR03CA0224.outlook.office365.com
 (2603:10b6:303:b9::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31 via Frontend
 Transport; Sun, 16 Jul 2023 08:16:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT058.mail.protection.outlook.com (10.13.174.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.31 via Frontend Transport; Sun, 16 Jul 2023 08:16:11 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 16 Jul 2023
 01:16:02 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 16 Jul
 2023 01:16:01 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Sun, 16 Jul
 2023 01:15:58 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, Yishai Hadas
 <yishaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb
 <maorg@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta
 <targupta@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH for-8.2 5/6] vfio/migration: Add P2P support for VFIO migration
Date: Sun, 16 Jul 2023 11:15:40 +0300
Message-ID: <20230716081541.27900-6-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230716081541.27900-1-avihaih@nvidia.com>
References: <20230716081541.27900-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT058:EE_|PH8PR12MB6699:EE_
X-MS-Office365-Filtering-Correlation-Id: c04d89ce-00d2-484e-1d9a-08db85d4ea73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4dYYBr4B+sft3mlK4ybMB3wqy12q0pgP4GXPABSCCOX+QaHYwIQQns6QTOLLFW78tEtSm5Ll1irIXhbWld2BJKrgQllYzhli5G5dR+3VwboxBIVhqBjAMOaQEx/Mexg5lfryzohaawdbHO//+fXdZ9idt8YVRtW666+PR1KOAgwncK6DrVbUd0HGnmkWdOaelUoBvErb1+0tCSon5/D79h2YPvLYAXrXzmKRog8LlQvYmAO+CRHfM4HGF9FF4rkVVus7/D3YwYgGkdOmr/SDQsbx1JiKiN8/sAbA2WRTtEk2bhotidJn9gRsl6dRCzmPyJbVXlePNeVFtWJoN7Ehx5cfN892l1i0LpSF6/v1QFLWhkdmzZgGNLn8Y3RvNeL7KfsoRWhbnxZdoQ5FLK6XCO1y4RD21mF9xmPOl6FR0RH9zJjINku4l9GWhsLu7LcQ6Stc+gI3mbp66epaKmI3qnX3kQThwlHzPwbe1lq+o9hplxx0sid6Nl4mxNnL++kuIWHmOyLL/YTuEtcjGxNTkdHxTOVg00Ln49ozL1OTbCATWoDF3w7asQ3svfdy0ft5tFk2D1x55SS9kV6yU9PWpPGDunHT50wIltGSlkcQKmvJRoxOvjOzskMdPIpTlPMst6QMtpRkGAgLDg6EXPd2szNUeyf1nv/lh6jIz7rWlXBGEKFQtYPWz3It7RwoUwUirQw55R5F2TaVxTbCL2r8eJ+e9BfSzVM5g0fmZWUnBPRaR4wbriXnNJz3RGMidfDI
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(136003)(396003)(346002)(451199021)(82310400008)(36840700001)(46966006)(40470700004)(36756003)(26005)(186003)(2906002)(40460700003)(30864003)(40480700001)(2616005)(5660300002)(1076003)(107886003)(478600001)(426003)(83380400001)(47076005)(336012)(316002)(6666004)(8676002)(41300700001)(54906003)(8936002)(4326008)(70586007)(70206006)(6916009)(36860700001)(7696005)(86362001)(82740400003)(7636003)(356005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2023 08:16:11.4468 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c04d89ce-00d2-484e-1d9a-08db85d4ea73
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6699
Received-SPF: softfail client-ip=2a01:111:f400:7e8b::614;
 envelope-from=avihaih@nvidia.com;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
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

VFIO migration uAPI defines an optional intermediate P2P quiescent
state. While in the P2P quiescent state, P2P DMA transactions cannot be
initiated by the device, but the device can respond to incoming ones.
Additionally, all outstanding P2P transactions are guaranteed to have
been completed by the time the device enters this state.

The purpose of this state is to support migration of multiple devices
that are doing P2P transactions between themselves.

Add support for P2P migration by transitioning all the devices to the
P2P quiescent state before stopping or starting the devices. Use the new
VMChangeStateHandler pre_change_cb to achieve that behavior.

This will allow migration of multiple VFIO devices if all of them
support P2P migration.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 docs/devel/vfio-migration.rst | 93 +++++++++++++++++++++--------------
 hw/vfio/common.c              |  6 ++-
 hw/vfio/migration.c           | 58 +++++++++++++++++-----
 hw/vfio/trace-events          |  2 +-
 4 files changed, 107 insertions(+), 52 deletions(-)

diff --git a/docs/devel/vfio-migration.rst b/docs/devel/vfio-migration.rst
index b433cb5bb2..b9c57ba651 100644
--- a/docs/devel/vfio-migration.rst
+++ b/docs/devel/vfio-migration.rst
@@ -23,9 +23,21 @@ and recommends that the initial bytes are sent and loaded in the destination
 before stopping the source VM. Enabling this migration capability will
 guarantee that and thus, can potentially reduce downtime even further.
 
-Note that currently VFIO migration is supported only for a single device. This
-is due to VFIO migration's lack of P2P support. However, P2P support is planned
-to be added later on.
+To support migration of multiple devices that are doing P2P transactions
+between themselves, VFIO migration uAPI defines an intermediate P2P quiescent
+state. While in the P2P quiescent state, P2P DMA transactions cannot be
+initiated by the device, but the device can respond to incoming ones.
+Additionally, all outstanding P2P transactions are guaranteed to have been
+completed by the time the device enters this state.
+
+All the devices that support P2P migration are first transitioned to the P2P
+quiescent state and only then are they stopped or started. This makes migration
+safe P2P-wise, since starting and stopping the devices is not done atomically
+for all the devices together.
+
+Thus, multiple VFIO devices migration is allowed only if all the devices
+support P2P migration. Single VFIO device migration is allowed regardless of
+P2P migration support.
 
 A detailed description of the UAPI for VFIO device migration can be found in
 the comment for the ``vfio_device_mig_state`` structure in the header file
@@ -132,54 +144,63 @@ will be blocked.
 Flow of state changes during Live migration
 ===========================================
 
-Below is the flow of state change during live migration.
+Below is the state change flow during live migration for a VFIO device that
+supports both precopy and P2P migration. The flow for devices that don't
+support it is similar, except that the relevant states for precopy and P2P are
+skipped.
 The values in the parentheses represent the VM state, the migration state, and
 the VFIO device state, respectively.
-The text in the square brackets represents the flow if the VFIO device supports
-pre-copy.
 
 Live migration save path
 ------------------------
 
 ::
 
-                        QEMU normal running state
-                        (RUNNING, _NONE, _RUNNING)
-                                  |
+                           QEMU normal running state
+                           (RUNNING, _NONE, _RUNNING)
+                                      |
                      migrate_init spawns migration_thread
-                Migration thread then calls each device's .save_setup()
-                  (RUNNING, _SETUP, _RUNNING [_PRE_COPY])
-                                  |
-                  (RUNNING, _ACTIVE, _RUNNING [_PRE_COPY])
-      If device is active, get pending_bytes by .state_pending_{estimate,exact}()
-          If total pending_bytes >= threshold_size, call .save_live_iterate()
-                  [Data of VFIO device for pre-copy phase is copied]
-        Iterate till total pending bytes converge and are less than threshold
-                                  |
-  On migration completion, vCPU stops and calls .save_live_complete_precopy for
-  each active device. The VFIO device is then transitioned into _STOP_COPY state
-                  (FINISH_MIGRATE, _DEVICE, _STOP_COPY)
-                                  |
-     For the VFIO device, iterate in .save_live_complete_precopy until
-                         pending data is 0
-                   (FINISH_MIGRATE, _DEVICE, _STOP)
-                                  |
-                 (FINISH_MIGRATE, _COMPLETED, _STOP)
-             Migraton thread schedules cleanup bottom half and exits
+            Migration thread then calls each device's .save_setup()
+                          (RUNNING, _SETUP, _PRE_COPY)
+                                      |
+                         (RUNNING, _ACTIVE, _PRE_COPY)
+  If device is active, get pending_bytes by .state_pending_{estimate,exact}()
+       If total pending_bytes >= threshold_size, call .save_live_iterate()
+                Data of VFIO device for pre-copy phase is copied
+      Iterate till total pending bytes converge and are less than threshold
+                                      |
+       On migration completion, the vCPUs and the VFIO device are stopped
+              The VFIO device is first put in P2P quiescent state
+                    (FINISH_MIGRATE, _ACTIVE, _PRE_COPY_P2P)
+                                      |
+                Then the VFIO device is put in _STOP_COPY state
+                     (FINISH_MIGRATE, _ACTIVE, _STOP_COPY)
+         .save_live_complete_precopy() is called for each active device
+      For the VFIO device, iterate in .save_live_complete_precopy() until
+                               pending data is 0
+                                      |
+                     (POSTMIGRATE, _COMPLETED, _STOP_COPY)
+            Migraton thread schedules cleanup bottom half and exits
+                                      |
+                           .save_cleanup() is called
+                        (POSTMIGRATE, _COMPLETED, _STOP)
 
 Live migration resume path
 --------------------------
 
 ::
 
-              Incoming migration calls .load_setup for each device
-                       (RESTORE_VM, _ACTIVE, _STOP)
-                                 |
-       For each device, .load_state is called for that device section data
-                       (RESTORE_VM, _ACTIVE, _RESUMING)
-                                 |
-    At the end, .load_cleanup is called for each device and vCPUs are started
-                       (RUNNING, _NONE, _RUNNING)
+             Incoming migration calls .load_setup() for each device
+                          (RESTORE_VM, _ACTIVE, _STOP)
+                                      |
+     For each device, .load_state() is called for that device section data
+                        (RESTORE_VM, _ACTIVE, _RESUMING)
+                                      |
+  At the end, .load_cleanup() is called for each device and vCPUs are started
+              The VFIO device is first put in P2P quiescent state
+                        (RUNNING, _ACTIVE, _RUNNING_P2P)
+                                      |
+                           (RUNNING, _NONE, _RUNNING)
 
 Postcopy
 ========
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 16cf79a76c..7c3d636025 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -441,14 +441,16 @@ bool vfio_device_state_is_running(VFIODevice *vbasedev)
 {
     VFIOMigration *migration = vbasedev->migration;
 
-    return migration->device_state == VFIO_DEVICE_STATE_RUNNING;
+    return migration->device_state == VFIO_DEVICE_STATE_RUNNING ||
+           migration->device_state == VFIO_DEVICE_STATE_RUNNING_P2P;
 }
 
 bool vfio_device_state_is_precopy(VFIODevice *vbasedev)
 {
     VFIOMigration *migration = vbasedev->migration;
 
-    return migration->device_state == VFIO_DEVICE_STATE_PRE_COPY;
+    return migration->device_state == VFIO_DEVICE_STATE_PRE_COPY ||
+           migration->device_state == VFIO_DEVICE_STATE_PRE_COPY_P2P;
 }
 
 static bool vfio_devices_all_dirty_tracking(VFIOContainer *container)
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 48f9c23cbe..02ee99c938 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -71,8 +71,13 @@ static const char *mig_state_to_str(enum vfio_device_mig_state state)
         return "STOP_COPY";
     case VFIO_DEVICE_STATE_RESUMING:
         return "RESUMING";
+    case VFIO_DEVICE_STATE_RUNNING_P2P:
+        return "RUNNING_P2P";
     case VFIO_DEVICE_STATE_PRE_COPY:
         return "PRE_COPY";
+    case VFIO_DEVICE_STATE_PRE_COPY_P2P:
+        return "PRE_COPY_P2P";
+
     default:
         return "UNKNOWN STATE";
     }
@@ -652,20 +657,31 @@ static const SaveVMHandlers savevm_vfio_handlers = {
 
 /* ---------------------------------------------------------------------- */
 
-static void vfio_vmstate_change(void *opaque, bool running, RunState state)
+static void vfio_vmstate_change(VFIODevice *vbasedev, bool running,
+                                RunState state, bool pre_state_change)
 {
-    VFIODevice *vbasedev = opaque;
+    VFIOMigration *migration = vbasedev->migration;
     enum vfio_device_mig_state new_state;
     int ret;
 
-    if (running) {
-        new_state = VFIO_DEVICE_STATE_RUNNING;
+    if (pre_state_change && !(migration->mig_flags & VFIO_MIGRATION_P2P)) {
+        return;
+    }
+
+    if (pre_state_change) {
+        new_state = migration->device_state == VFIO_DEVICE_STATE_PRE_COPY ?
+                        VFIO_DEVICE_STATE_PRE_COPY_P2P :
+                        VFIO_DEVICE_STATE_RUNNING_P2P;
     } else {
-        new_state =
-            (vfio_device_state_is_precopy(vbasedev) &&
-             (state == RUN_STATE_FINISH_MIGRATE || state == RUN_STATE_PAUSED)) ?
-                VFIO_DEVICE_STATE_STOP_COPY :
-                VFIO_DEVICE_STATE_STOP;
+        if (running) {
+            new_state = VFIO_DEVICE_STATE_RUNNING;
+        } else {
+            new_state = (vfio_device_state_is_precopy(vbasedev) &&
+                         (state == RUN_STATE_FINISH_MIGRATE ||
+                          state == RUN_STATE_PAUSED)) ?
+                            VFIO_DEVICE_STATE_STOP_COPY :
+                            VFIO_DEVICE_STATE_STOP;
+        }
     }
 
     /*
@@ -685,7 +701,23 @@ static void vfio_vmstate_change(void *opaque, bool running, RunState state)
     }
 
     trace_vfio_vmstate_change(vbasedev->name, running, RunState_str(state),
-                              mig_state_to_str(new_state));
+                              pre_state_change, mig_state_to_str(new_state));
+}
+
+static void vfio_vmstate_pre_change_handler(void *opaque, bool running,
+                                            RunState state)
+{
+    VFIODevice *vbasedev = opaque;
+
+    vfio_vmstate_change(vbasedev, running, state, true);
+}
+
+static void vfio_vmstate_change_handler(void *opaque, bool running,
+                                        RunState state)
+{
+    VFIODevice *vbasedev = opaque;
+
+    vfio_vmstate_change(vbasedev, running, state, false);
 }
 
 static void vfio_migration_state_notifier(Notifier *notifier, void *data)
@@ -798,9 +830,9 @@ static int vfio_migration_init(VFIODevice *vbasedev)
     register_savevm_live(id, VMSTATE_INSTANCE_ID_ANY, 1, &savevm_vfio_handlers,
                          vbasedev);
 
-    migration->vm_state = qdev_add_vm_change_state_handler(vbasedev->dev,
-                                                           vfio_vmstate_change,
-                                                           vbasedev);
+    migration->vm_state = qdev_add_vm_change_state_handler_full(
+        vbasedev->dev, vfio_vmstate_change_handler,
+        vfio_vmstate_pre_change_handler, vbasedev);
     migration->migration_state.notify = vfio_migration_state_notifier;
     add_migration_state_change_notifier(&migration->migration_state);
 
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index ee7509e68e..efafe613f2 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -166,4 +166,4 @@ vfio_save_iterate(const char *name, uint64_t precopy_init_size, uint64_t precopy
 vfio_save_setup(const char *name, uint64_t data_buffer_size) " (%s) data buffer size 0x%"PRIx64
 vfio_state_pending_estimate(const char *name, uint64_t precopy, uint64_t postcopy, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy 0x%"PRIx64" postcopy 0x%"PRIx64" precopy initial size 0x%"PRIx64" precopy dirty size 0x%"PRIx64
 vfio_state_pending_exact(const char *name, uint64_t precopy, uint64_t postcopy, uint64_t stopcopy_size, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy 0x%"PRIx64" postcopy 0x%"PRIx64" stopcopy size 0x%"PRIx64" precopy initial size 0x%"PRIx64" precopy dirty size 0x%"PRIx64
-vfio_vmstate_change(const char *name, int running, const char *reason, const char *dev_state) " (%s) running %d reason %s device state %s"
+vfio_vmstate_change(const char *name, int running, const char *reason, bool pre_state_change, const char *dev_state) " (%s) running %d reason %s pre state change %d device state %s"
-- 
2.26.3


