Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BBF76C837
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 10:16:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qR711-0006y1-OT; Wed, 02 Aug 2023 04:15:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qR70z-0006xd-Og
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 04:15:29 -0400
Received: from mail-sn1nam02on2060d.outbound.protection.outlook.com
 ([2a01:111:f400:7ea9::60d]
 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qR70x-0006QX-Sa
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 04:15:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EdPsH6NXGId4ePXvpVDaMdzqNxcS3HRZznqR8i/rrv2bxHJOdNoDu+5+jD54P1OxTCO5kTNr3KUD4EKdo2roLHuj0zphy74IDnmhYtCAFOUeP0TdzlZQhO4wsDCKaqrgc5LeB4G9aGSkeVX5sJB8cvUjZl+85u5u1dE2EiVN3nKscyG5uf2pfiAIcmRSD/ZlHRjs88oqhrYNnT6fsPNdjvPeQNIAOPzkfrWDDeYT6bOjQw9gEbw6/VZ/nEENhNrHrJTSwxnb5i+YO1Hp0nE+SGFBcYWZIu+3bJfKPcFffLc/MkAuqjK6CUqZoPu7Kf2cjUC1CuDWNR8ehtCutJwCvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WKp/pmecsHMhRlRbJZqM6zbZwX079spotXBKYXQmioA=;
 b=GN2JVHasSuTJVhTwuIIF4MbX1W3ubLC7xUuiw+qS3rqmiV1STpuKEvqWddnHZktEDk2G5/AEtSXOT+5mxEuLcVbtWYQQBu8qcvo/rM0Rb8DBRXZ1R0PX/ICRd6gJbpppI5M/YSy14eHX6jp4eCqYlvokRWhGGSeQHUoagbsRkXqKeXmAi3gYaQmH+LFeUEhCwUxfn03/MyZ6G4zfU0glIwqWkteuv4D5ZZKyAXdnOKgVQ/sVvh/KG1THnK/87bZkvtqMiyNvuon9i5VQ5lCNk4gO0bNgmf4cZ/CjGuFWg5cMGE0hBO8r6FDtTteR4SYROAjN9fYPeHWDKsVTRzHU/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WKp/pmecsHMhRlRbJZqM6zbZwX079spotXBKYXQmioA=;
 b=eBAnBoLFl8K2eWQYAyWovlYYKV0jAKSMbGhRd9nQchDHO0MDmzH+SRTDXSdTAj4r5rhBQleV8RQUXGTE634nOIZsw0Y4EwZfSGIwBduUnHWEHH0qcFweKJy+LkXrMGLgckAo1r/6g0Dr8hv32Za7UIvb/P7d2xzwL7x9f2wNNix4bCBKTC+rX7ddcDnbgAGvXEyOj70NzNQeW+Ae/0z2Y09WyGwasambslRsDOi3xg1jpnC6l1n8rN4lIIaDCinpI4WCO0YbMuEzr57KyLIgtr1C0M4/1EYxE0GaJf0kHqbP1iWvPpctk7RC0PbWe00ylP2T2A0N7NOUw3wXnq4UWA==
Received: from MW4PR04CA0074.namprd04.prod.outlook.com (2603:10b6:303:6b::19)
 by CY8PR12MB7292.namprd12.prod.outlook.com (2603:10b6:930:53::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 08:15:24 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:303:6b:cafe::7e) by MW4PR04CA0074.outlook.office365.com
 (2603:10b6:303:6b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44 via Frontend
 Transport; Wed, 2 Aug 2023 08:15:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Wed, 2 Aug 2023 08:15:23 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 2 Aug 2023
 01:15:08 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 2 Aug 2023
 01:15:08 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Wed, 2 Aug
 2023 01:15:05 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, Yishai Hadas
 <yishaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb
 <maorg@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta
 <targupta@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH for-8.2 v3 4/6] vfio/migration: Refactor PRE_COPY and RUNNING
 state checks
Date: Wed, 2 Aug 2023 11:14:47 +0300
Message-ID: <20230802081449.2528-5-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230802081449.2528-1-avihaih@nvidia.com>
References: <20230802081449.2528-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|CY8PR12MB7292:EE_
X-MS-Office365-Filtering-Correlation-Id: e442ff78-958f-43b6-5a3c-08db93309eee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PLCi2JpuNPx4lhlxYoRbdAf/Wto+GBj2KIxUqDmqbiKYMFIIcpKLkprNDB8DzvQw16M8LFAttCJnWIqnsSl7imyiqAGg3yQbNas4wiHDFKRt0fHBDcyF6MjNmehYZWIFoTRdRwR+qNk+HyVOMU44aTdUdcvJ49x27y8sL4x88eW+xG7dEK1l7QUHV4DmwELjfjsa8JvBk6Uwe77W1pKPovA8Q7BAnYSiNUFQDi7DDS+mcBGdehRRntSPV8U8lFa1+XC8WrsTH/J9a6AltHN/ebyMEsukzbLlt3LbYv2JsOjwIGdUAmtGth9bKwxD0SWe3q8/HeD4+HpDcfJdZ2PDABTkqD5+H6c67DljrayR1hpTajmuik1d63y+Fv7GtnmdJSYQQFP7xrklsHN2Awnf5605NMghnCTUH1lFXS8PlsbrYvi4y7c7Dvxknl7CwvAW9Sga5pMRRPk7YMMC/nrd+dFkpjcodTYIBm9iB/2ieoMCHEr34D1RIJji22XKxUuiTVTIEn963QxGPFXwFbWHYExoB+9buynglCLxo4Kp5Yf8Cwbn3+ksY+/qKYlR6xNIFzqD5KiFSoHbJ1ZSf8HWz82iIswY/fyjYMdp1XkwBpkhd2StXxhYpvvInQs7kY28LXqdccld4uPQ7i0fIUurA7PWld2GU7PvoNpdJ6iYQIxFyoydkO3lZeOnbx4tJY3CP75l8vD6Rd/7nsg1avlz/+aMywS7HCy/qTxzTWOqPQE2bFY/VZWQnlfNtGEuvFrM
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(136003)(376002)(39860400002)(82310400008)(451199021)(40470700004)(46966006)(36840700001)(186003)(426003)(8936002)(66574015)(83380400001)(8676002)(26005)(41300700001)(107886003)(2906002)(5660300002)(36860700001)(47076005)(40460700003)(336012)(2616005)(40480700001)(478600001)(7636003)(86362001)(54906003)(316002)(1076003)(82740400003)(7696005)(70586007)(70206006)(356005)(6666004)(6916009)(4326008)(36756003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 08:15:23.5628 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e442ff78-958f-43b6-5a3c-08db93309eee
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7292
Received-SPF: softfail client-ip=2a01:111:f400:7ea9::60d;
 envelope-from=avihaih@nvidia.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
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

From: Joao Martins <joao.m.martins@oracle.com>

Move the PRE_COPY and RUNNING state checks to helper functions.

This is in preparation for adding P2P VFIO migration support, where
these helpers will also test for PRE_COPY_P2P and RUNNING_P2P states.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h |  2 ++
 hw/vfio/common.c              | 22 ++++++++++++++++++----
 hw/vfio/migration.c           | 10 ++++------
 3 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index da43d27352..e9b8954595 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -230,6 +230,8 @@ void vfio_unblock_multiple_devices_migration(void);
 bool vfio_viommu_preset(VFIODevice *vbasedev);
 int64_t vfio_mig_bytes_transferred(void);
 void vfio_reset_bytes_transferred(void);
+bool vfio_device_state_is_running(VFIODevice *vbasedev);
+bool vfio_device_state_is_precopy(VFIODevice *vbasedev);
 
 #ifdef CONFIG_LINUX
 int vfio_get_region_info(VFIODevice *vbasedev, int index,
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 9aac21abb7..16cf79a76c 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -437,6 +437,20 @@ static void vfio_set_migration_error(int err)
     }
 }
 
+bool vfio_device_state_is_running(VFIODevice *vbasedev)
+{
+    VFIOMigration *migration = vbasedev->migration;
+
+    return migration->device_state == VFIO_DEVICE_STATE_RUNNING;
+}
+
+bool vfio_device_state_is_precopy(VFIODevice *vbasedev)
+{
+    VFIOMigration *migration = vbasedev->migration;
+
+    return migration->device_state == VFIO_DEVICE_STATE_PRE_COPY;
+}
+
 static bool vfio_devices_all_dirty_tracking(VFIOContainer *container)
 {
     VFIOGroup *group;
@@ -457,8 +471,8 @@ static bool vfio_devices_all_dirty_tracking(VFIOContainer *container)
             }
 
             if (vbasedev->pre_copy_dirty_page_tracking == ON_OFF_AUTO_OFF &&
-                (migration->device_state == VFIO_DEVICE_STATE_RUNNING ||
-                 migration->device_state == VFIO_DEVICE_STATE_PRE_COPY)) {
+                (vfio_device_state_is_running(vbasedev) ||
+                 vfio_device_state_is_precopy(vbasedev))) {
                 return false;
             }
         }
@@ -503,8 +517,8 @@ static bool vfio_devices_all_running_and_mig_active(VFIOContainer *container)
                 return false;
             }
 
-            if (migration->device_state == VFIO_DEVICE_STATE_RUNNING ||
-                migration->device_state == VFIO_DEVICE_STATE_PRE_COPY) {
+            if (vfio_device_state_is_running(vbasedev) ||
+                vfio_device_state_is_precopy(vbasedev)) {
                 continue;
             } else {
                 return false;
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 8acd182a8b..48f9c23cbe 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -411,7 +411,7 @@ static void vfio_state_pending_estimate(void *opaque, uint64_t *must_precopy,
     VFIODevice *vbasedev = opaque;
     VFIOMigration *migration = vbasedev->migration;
 
-    if (migration->device_state != VFIO_DEVICE_STATE_PRE_COPY) {
+    if (!vfio_device_state_is_precopy(vbasedev)) {
         return;
     }
 
@@ -444,7 +444,7 @@ static void vfio_state_pending_exact(void *opaque, uint64_t *must_precopy,
     vfio_query_stop_copy_size(vbasedev, &stop_copy_size);
     *must_precopy += stop_copy_size;
 
-    if (migration->device_state == VFIO_DEVICE_STATE_PRE_COPY) {
+    if (vfio_device_state_is_precopy(vbasedev)) {
         vfio_query_precopy_size(migration);
 
         *must_precopy +=
@@ -459,9 +459,8 @@ static void vfio_state_pending_exact(void *opaque, uint64_t *must_precopy,
 static bool vfio_is_active_iterate(void *opaque)
 {
     VFIODevice *vbasedev = opaque;
-    VFIOMigration *migration = vbasedev->migration;
 
-    return migration->device_state == VFIO_DEVICE_STATE_PRE_COPY;
+    return vfio_device_state_is_precopy(vbasedev);
 }
 
 static int vfio_save_iterate(QEMUFile *f, void *opaque)
@@ -656,7 +655,6 @@ static const SaveVMHandlers savevm_vfio_handlers = {
 static void vfio_vmstate_change(void *opaque, bool running, RunState state)
 {
     VFIODevice *vbasedev = opaque;
-    VFIOMigration *migration = vbasedev->migration;
     enum vfio_device_mig_state new_state;
     int ret;
 
@@ -664,7 +662,7 @@ static void vfio_vmstate_change(void *opaque, bool running, RunState state)
         new_state = VFIO_DEVICE_STATE_RUNNING;
     } else {
         new_state =
-            (migration->device_state == VFIO_DEVICE_STATE_PRE_COPY &&
+            (vfio_device_state_is_precopy(vbasedev) &&
              (state == RUN_STATE_FINISH_MIGRATE || state == RUN_STATE_PAUSED)) ?
                 VFIO_DEVICE_STATE_STOP_COPY :
                 VFIO_DEVICE_STATE_STOP;
-- 
2.26.3


