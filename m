Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D751769313
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 12:27:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQQ6x-0000jp-RK; Mon, 31 Jul 2023 06:26:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qQQ6N-0000ct-B4
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 06:26:12 -0400
Received: from mail-co1nam11on2062e.outbound.protection.outlook.com
 ([2a01:111:f400:7eab::62e]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qQQ6J-0006wY-RK
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 06:26:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aQXCGm9ExXIdMomRDC1cXiAMheYwL0S4qktiqapALv4Udt66yqFNjNAy3C8Z+YN44O1gpRlLkClGX0eyG4lNtTTcV27qD/eH31rEUCrvrjYzgTwkV7xnUIJWo+90VzxXWJkoZtRUTZH03329CzPva8crIdjXZxSJA7BYc8zsw9SYdlmp2De7KpFLAWuqJQUMdNQAkR/aJxia7WgUW4HipsYfTptRYQJfAwESOcHagvmLKTehKOe0QH1cOTEVz6Fyi0U6jrFN4Q3v1p3Dj3sk/tqY6pqhwndOsteA4hUqJDMGhatj3qLYcIiii1xGLIhQcTSQLM7SnLUGZlFn8Kz/uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ACd91EUR986Vkgxd/OiMGSwdK2ShSxIMetErK2wLLtg=;
 b=bn2tZHN/+Y4j7b5+kRSSHGXpKpTtBBzDhD72rdglC+bboYrm+fNZtNTPokvagWnHJtKdDPQ0V1K9EJ5cuq4nafWzQnBnnh5UCApwP+KkqZ03hbs6cPJOBBKbIA4DwxQPqgflIALP/rbFmZXAjSlOC7+wgI5nFOKjk68swubEwCmv/aDwAVIVLOiwZBvGkuo7cCGLoFiVcIL7rRu+sIxtqEYYj0k69tf7A0R7Rdt57KtMOJknqCsTcLfPGrC5c1Vdzfbg4IJIldMWYCrlSUi5D+mV1Ku5hfj1xkzq9z6YC5pe66q/nlHwaaOvc572dwH+2qGqp40kLRtymzpMLq0bGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACd91EUR986Vkgxd/OiMGSwdK2ShSxIMetErK2wLLtg=;
 b=aEYbEvXnYquUxhqNYhL6Lr/yHR6Ivz676RjYT+DCY8V7KYus7fdW+On1fOn4CmuQl+ktH+5IhPdu8Nv2pht87pf++ekzv1GGdr8ZOJC2VsVsAXsQAxnAE/5w9EbegNxKXZiniGiA71R6Zdkelxj9jgyxMe0q3J7tOtpYgHsEj3QUkANs4yo2gF6y8mGUeWwu0K5WqnQYN8Wc087N4d+mG+ftsTysg3dd9qu6lD5iqIptRgbtvbt+EEPhuiAO8JFU4DUtV7k1xYyfs7DBuUJZCoUNSKdvuVoYiRjRsxVy6Q54UyGTmAztpXOcCK4Z8rUtwk4KYybQ7kQyJGUUQvK2aw==
Received: from DS7P222CA0027.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::35) by
 PH0PR12MB7079.namprd12.prod.outlook.com (2603:10b6:510:21d::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.42; Mon, 31 Jul 2023 10:26:01 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::4e) by DS7P222CA0027.outlook.office365.com
 (2603:10b6:8:2e::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44 via Frontend
 Transport; Mon, 31 Jul 2023 10:26:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.43 via Frontend Transport; Mon, 31 Jul 2023 10:26:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 31 Jul 2023
 03:25:43 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 31 Jul
 2023 03:25:43 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Mon, 31 Jul
 2023 03:25:40 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, Yishai Hadas
 <yishaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb
 <maorg@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta
 <targupta@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH for-8.2 v2 5/6] vfio/migration: Add P2P support for VFIO
 migration
Date: Mon, 31 Jul 2023 13:25:20 +0300
Message-ID: <20230731102521.15335-6-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230731102521.15335-1-avihaih@nvidia.com>
References: <20230731102521.15335-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT011:EE_|PH0PR12MB7079:EE_
X-MS-Office365-Filtering-Correlation-Id: 982d1cf0-a698-464c-af57-08db91b089a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PWB+sMg0aekyUHLE2BzFV3f1TmISeDo16v+dqVmVEImjJw5zT4z/OKrVPtiK2WwFprh3wAPkq76xGu4GITU3845RNjA5DG/iBnnBmP8gzjDte6sYFAGyHACcpOgeDuwVWF2VZwUD0LhSmmExPZjkhE9zDgblCzoS5VqP/k74U2++G3m8a1EgiAKxkfSh8NsnbGuslSIoHHgl14wdMDdxVGFFVObbAnpMc7Byc6KgleVthsSoBeNwWxsfS1PWch6wdJVsqER8OfL61bNNihKPQ71SkatrOrVxIyzGwjR8kc7tc+yBqklMtbWGTuOTWXy63kSCV+yQACZnb02Ws3w3YeHk9T8FxDXBaXXceV0i/3oK6AhGclG3ER2wb2bOVqQH7ZWliFNQtmFpWYk/zJfIgd1Ash08zSPvHtLGdHn5eQsECaLoFPXyC1uE2/xOgOOvOGteK+y8WGaxhEmD9XkMSr/tN93mJfDEz027AYYbVNiR+aMtiSioeb717XKn6JriwCmSaYbqPOcrXNEhNksPqF5cT/gNVYX7/wTJRJXM6p7R8uDFr8xCJDGKg9DOA6SMifoJkKIlqpkTEe8JiOwDeDiob91z/fYgrSCJefj4bCjx1Wu8N/kzuFX50m78OWpEupJZ+IDZAvfNsBgbMjFehZCIhhYz000vLm0pVWcu0UBRgYfaJWwskN++webZa+kwAXGRMDYK8nZveCKm24WeNJ9iRfLME4BFrioaSM98KVMyRb7KwEUJsmV3E71EQKW1
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(136003)(396003)(376002)(82310400008)(451199021)(36840700001)(46966006)(40470700004)(47076005)(36860700001)(7696005)(36756003)(40460700003)(40480700001)(2616005)(1076003)(26005)(83380400001)(107886003)(336012)(186003)(426003)(70206006)(70586007)(7636003)(356005)(54906003)(82740400003)(86362001)(316002)(4326008)(5660300002)(6916009)(8676002)(8936002)(41300700001)(2906002)(6666004)(478600001)(30864003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 10:26:01.0997 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 982d1cf0-a698-464c-af57-08db91b089a1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7079
Received-SPF: softfail client-ip=2a01:111:f400:7eab::62e;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
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
 hw/vfio/migration.c           | 47 ++++++++++++++++--
 hw/vfio/trace-events          |  1 +
 4 files changed, 106 insertions(+), 41 deletions(-)

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
index 48f9c23cbe..05b1dac2ed 100644
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
@@ -652,6 +656,43 @@ static const SaveVMHandlers savevm_vfio_handlers = {
 
 /* ---------------------------------------------------------------------- */
 
+static void vfio_vmstate_change_prepare(void *opaque, bool running,
+                                        RunState state)
+{
+    VFIODevice *vbasedev = opaque;
+    VFIOMigration *migration = vbasedev->migration;
+    enum vfio_device_mig_state new_state;
+    int ret;
+
+    if (!(migration->mig_flags & VFIO_MIGRATION_P2P)) {
+        return;
+    }
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
@@ -798,9 +839,9 @@ static int vfio_migration_init(VFIODevice *vbasedev)
     register_savevm_live(id, VMSTATE_INSTANCE_ID_ANY, 1, &savevm_vfio_handlers,
                          vbasedev);
 
-    migration->vm_state = qdev_add_vm_change_state_handler(vbasedev->dev,
-                                                           vfio_vmstate_change,
-                                                           vbasedev);
+    migration->vm_state = qdev_add_vm_change_state_handler_full(
+        vbasedev->dev, vfio_vmstate_change, vfio_vmstate_change_prepare,
+        vbasedev);
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


