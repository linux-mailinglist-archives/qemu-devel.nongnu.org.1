Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE9F76C838
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 10:16:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qR714-0006yf-Ba; Wed, 02 Aug 2023 04:15:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qR711-0006y6-UU
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 04:15:31 -0400
Received: from mail-dm6nam04on20627.outbound.protection.outlook.com
 ([2a01:111:f400:7e8b::627]
 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qR70z-0006Qu-Iw
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 04:15:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KBGkqg3YYKGrZsaJw8N8b2SzTkJCu2q5JQCjOopbERXn6hDSN0Ca4wi3+Gb67+C9eWERtQHnnaA97RgQaQ4C91eDMfZw9HnZa7cJqXLJo8NrjDfB7moPC61hbfYzolMMUmNWw35NRBW2kdnRyPLLZ7f1gglKmN7lEBVOtukj05vHlLRr0SSvfM9gKB8rF/Uaoigt+yTM9YpE92oJm4HaJQBd3vV6GF4Dz+/6rV2OlQ9e15xnEvIk4u4opLYmM8B7mC7x91Goco9Tvl34h+GkKEIRdwElX5tcG7tK32RYg7mv9by2qGcIOpFi/0pF+hviHFYu9jtkdZ5ZnvlRIlB90g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ft7Sg6rR10RiUEMIeD7KXwHGhgXN3kPK7nib4fEn7ME=;
 b=KFYtgX89y1gLQluJP2y2CCQ8e2yIBbpaJ5E0okVmki8VLAaSuiIzd4r+L7Cw8Y/HuHQGUvMj2kRSeuo/BexCaYwMdTskKjaB61827F6hvE2SDJco8nUQWIQJfywgfDnWrfDZsCZIHwV39Ajr6SqsACxgX8P09bzeE9YphVCOWDSZSV44JlHZ0h6U03C6T2ZPiE79eiCYj1LTye+222StzQ4a3zX8lEWNj6XOJ8yp44I9wxXzejncv1fpLmPysYQgEaaYio9yKbiVcYrSUw6uQ/szzu2JnAM+zTXxQzzHduLyS0tpHN146GFfTptlv+Dgb5MbUCy9YR+saBbLKdwk4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ft7Sg6rR10RiUEMIeD7KXwHGhgXN3kPK7nib4fEn7ME=;
 b=lcIRaBV+lrvJANJaNZmWuNJY3y2mJ07IkjuWcwM8wP0hs2nij7DkhtR35bXOnd1lfoWwbjrEoWhB9jv6b4QZfPFt3hzmdtvCFH85ywrJmw1rLwZ6WLMKe8Gp3cWghmL8Prp+YLuh3bevcHornXe9B+IAGncchSY+PGakxhM2JkBKoGFOwB/NosYh9omu4WLwNVTXJ7zSAjj78a7Si2lD1ZgDxsMKQ/Qg6UN6eK2rQ+xUMJmd6tqT/eZH12xDVwDXoFMdNMDdqpzb3HipXeY/tCU4iqumiPHcW4cxUYOy/QGjv/x5Y8VzCc08dhgcEGB5epr8l/zSDZFljWPjz1fkpw==
Received: from CY5P221CA0062.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:4::34) by
 SA3PR12MB7902.namprd12.prod.outlook.com (2603:10b6:806:305::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 08:15:26 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:930:4:cafe::b7) by CY5P221CA0062.outlook.office365.com
 (2603:10b6:930:4::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.19 via Frontend
 Transport; Wed, 2 Aug 2023 08:15:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.141) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Wed, 2 Aug 2023 08:15:25 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 2 Aug 2023
 01:15:13 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 2 Aug 2023
 01:15:12 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Wed, 2 Aug
 2023 01:15:08 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, Yishai Hadas
 <yishaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb
 <maorg@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta
 <targupta@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH for-8.2 v3 5/6] vfio/migration: Add P2P support for VFIO
 migration
Date: Wed, 2 Aug 2023 11:14:48 +0300
Message-ID: <20230802081449.2528-6-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230802081449.2528-1-avihaih@nvidia.com>
References: <20230802081449.2528-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|SA3PR12MB7902:EE_
X-MS-Office365-Filtering-Correlation-Id: e6808c38-85b8-4455-612a-08db9330a051
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rr8AclJK4p3/47tQt9kr2aVTlRch+ecFaKRj8w0+tAAxRsHTzhu7g1vMvH8/lkWnT7RwbykO7h6XONjRwmldJmCdaEvtXFB7LM2FgMYaRumPT2ZdDvhGLOzDeICBbgShFzFWWoIx8Lthhi8Q+s7p3Pa++G+7bNj1hQQM/HDpKGb9tIWhd9Gtr2q3xe6KfxtNRNv+eEy0EqdDsmNncb/SQ7Hms84ivSdGzBVmlISbhpjtMcHeXQcgjzwqdz3X38iMPAET3Lv+3ahcmuMi69BDVfw2q+gjQASkn2B4v7Uu5pyCi8eFYCAuh4pcCucN9f1yC51Rc3QoDSUvbeDX1vtLNzKt6M1fv+nB0x2DUeuZmgjBXS59KBkHzufz8G8icsZsfkgIlCvB01EljsKO8pI/ZyYiIckK5MtmrBckMge4VyYz7nKYXWbpsD+BtnrVlMTanPl7t5Ulx+3LVnb2n5YWlxZfZbSN1pa8aWF5PxkmkA4bKbzPZW86sVHf1zLFYMk32SOv5UEjfdWdGlQeVD5kFIcsR4hOnD4nFsKj2YWs0TwgnIuTSp2cu/9G8/TVHNWIzY8Gtom9Ihoh+9LkljcZrqjY4BBAD8Mz7n2vlM7+7fyiriT0+MUlNZsu72nnNkQ287TMbhJJv/xvIVV4ZNu3mXCz2wwQV2zFYlX3J5sT3bBY1TgqxjfQA34N9MGG/EehZwuk5+6+O6hW07FNyybly4O7Pw2Lh/0jypzTSmgNLSTmjQiY8JDLn2hq2A1QcXyM
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(136003)(376002)(39860400002)(82310400008)(451199021)(40470700004)(46966006)(36840700001)(8936002)(8676002)(426003)(47076005)(30864003)(41300700001)(107886003)(2906002)(5660300002)(83380400001)(36860700001)(40460700003)(2616005)(40480700001)(336012)(186003)(86362001)(7636003)(478600001)(54906003)(316002)(356005)(26005)(1076003)(7696005)(70586007)(70206006)(6666004)(82740400003)(4326008)(6916009)(36756003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 08:15:25.9520 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6808c38-85b8-4455-612a-08db9330a051
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7902
Received-SPF: softfail client-ip=2a01:111:f400:7e8b::627;
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
that might do P2P transactions between themselves.

Add support for P2P migration by transitioning all the devices to the
P2P quiescent state before stopping or starting the devices. Use the new
VMChangeStateHandler prepare_cb to achieve that behavior.

This will allow migration of multiple VFIO devices if all of them
support P2P migration.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 docs/devel/vfio-migration.rst | 93 +++++++++++++++++++++--------------
 hw/vfio/common.c              |  6 ++-
 hw/vfio/migration.c           | 46 +++++++++++++++--
 hw/vfio/trace-events          |  1 +
 4 files changed, 105 insertions(+), 41 deletions(-)

diff --git a/docs/devel/vfio-migration.rst b/docs/devel/vfio-migration.rst
index b433cb5bb2..605fe60e96 100644
--- a/docs/devel/vfio-migration.rst
+++ b/docs/devel/vfio-migration.rst
@@ -23,9 +23,21 @@ and recommends that the initial bytes are sent and loaded in the destination
 before stopping the source VM. Enabling this migration capability will
 guarantee that and thus, can potentially reduce downtime even further.
 
-Note that currently VFIO migration is supported only for a single device. This
-is due to VFIO migration's lack of P2P support. However, P2P support is planned
-to be added later on.
+To support migration of multiple devices that might do P2P transactions between
+themselves, VFIO migration uAPI defines an intermediate P2P quiescent state.
+While in the P2P quiescent state, P2P DMA transactions cannot be initiated by
+the device, but the device can respond to incoming ones. Additionally, all
+outstanding P2P transactions are guaranteed to have been completed by the time
+the device enters this state.
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
index 48f9c23cbe..71855468fe 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -71,8 +71,12 @@ static const char *mig_state_to_str(enum vfio_device_mig_state state)
         return "STOP_COPY";
     case VFIO_DEVICE_STATE_RESUMING:
         return "RESUMING";
+    case VFIO_DEVICE_STATE_RUNNING_P2P:
+        return "RUNNING_P2P";
     case VFIO_DEVICE_STATE_PRE_COPY:
         return "PRE_COPY";
+    case VFIO_DEVICE_STATE_PRE_COPY_P2P:
+        return "PRE_COPY_P2P";
     default:
         return "UNKNOWN STATE";
     }
@@ -652,6 +656,39 @@ static const SaveVMHandlers savevm_vfio_handlers = {
 
 /* ---------------------------------------------------------------------- */
 
+static void vfio_vmstate_change_prepare(void *opaque, bool running,
+                                        RunState state)
+{
+    VFIODevice *vbasedev = opaque;
+    VFIOMigration *migration = vbasedev->migration;
+    enum vfio_device_mig_state new_state;
+    int ret;
+
+    new_state = migration->device_state == VFIO_DEVICE_STATE_PRE_COPY ?
+                    VFIO_DEVICE_STATE_PRE_COPY_P2P :
+                    VFIO_DEVICE_STATE_RUNNING_P2P;
+
+    /*
+     * If setting the device in new_state fails, the device should be reset.
+     * To do so, use ERROR state as a recover state.
+     */
+    ret = vfio_migration_set_state(vbasedev, new_state,
+                                   VFIO_DEVICE_STATE_ERROR);
+    if (ret) {
+        /*
+         * Migration should be aborted in this case, but vm_state_notify()
+         * currently does not support reporting failures.
+         */
+        if (migrate_get_current()->to_dst_file) {
+            qemu_file_set_error(migrate_get_current()->to_dst_file, ret);
+        }
+    }
+
+    trace_vfio_vmstate_change_prepare(vbasedev->name, running,
+                                      RunState_str(state),
+                                      mig_state_to_str(new_state));
+}
+
 static void vfio_vmstate_change(void *opaque, bool running, RunState state)
 {
     VFIODevice *vbasedev = opaque;
@@ -758,6 +795,7 @@ static int vfio_migration_init(VFIODevice *vbasedev)
     char id[256] = "";
     g_autofree char *path = NULL, *oid = NULL;
     uint64_t mig_flags = 0;
+    VMChangeStateHandler *prepare_cb;
 
     if (!vbasedev->ops->vfio_get_object) {
         return -EINVAL;
@@ -798,9 +836,11 @@ static int vfio_migration_init(VFIODevice *vbasedev)
     register_savevm_live(id, VMSTATE_INSTANCE_ID_ANY, 1, &savevm_vfio_handlers,
                          vbasedev);
 
-    migration->vm_state = qdev_add_vm_change_state_handler(vbasedev->dev,
-                                                           vfio_vmstate_change,
-                                                           vbasedev);
+    prepare_cb = migration->mig_flags & VFIO_MIGRATION_P2P ?
+                     vfio_vmstate_change_prepare :
+                     NULL;
+    migration->vm_state = qdev_add_vm_change_state_handler_full(
+        vbasedev->dev, vfio_vmstate_change, prepare_cb, vbasedev);
     migration->migration_state.notify = vfio_migration_state_notifier;
     add_migration_state_change_notifier(&migration->migration_state);
 
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index ee7509e68e..329736a738 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -167,3 +167,4 @@ vfio_save_setup(const char *name, uint64_t data_buffer_size) " (%s) data buffer
 vfio_state_pending_estimate(const char *name, uint64_t precopy, uint64_t postcopy, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy 0x%"PRIx64" postcopy 0x%"PRIx64" precopy initial size 0x%"PRIx64" precopy dirty size 0x%"PRIx64
 vfio_state_pending_exact(const char *name, uint64_t precopy, uint64_t postcopy, uint64_t stopcopy_size, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy 0x%"PRIx64" postcopy 0x%"PRIx64" stopcopy size 0x%"PRIx64" precopy initial size 0x%"PRIx64" precopy dirty size 0x%"PRIx64
 vfio_vmstate_change(const char *name, int running, const char *reason, const char *dev_state) " (%s) running %d reason %s device state %s"
+vfio_vmstate_change_prepare(const char *name, int running, const char *reason, const char *dev_state) " (%s) running %d reason %s device state %s"
-- 
2.26.3


