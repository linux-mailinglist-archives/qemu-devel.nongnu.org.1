Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A7076931B
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 12:28:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQQ6t-0000gm-LA; Mon, 31 Jul 2023 06:26:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qQQ6F-0000cK-3q
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 06:26:06 -0400
Received: from mail-dm6nam11on2062a.outbound.protection.outlook.com
 ([2a01:111:f400:7eaa::62a]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qQQ6C-0006vm-M1
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 06:26:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lo37PHd3DfTxku9fdPxWvyCIKMAgtl4lmR3/j67aSgC4tgRMCyUBh2t5INpdqGOUmItUedUXHI9GZ3IBoVH7kiLoW+2Z5lJgDEIhvIzpbUN2WxwH0/Ux5Z+IGzfXm3k+1uvJ6GvqlO+Blo5cbhQK2nKKlEAmmzCGKwYLK5gqGwGzwmlQWnoASso4U0JHahame4j48rKjdFVqCht5sEcHMscbuhN+tAz9xYrZKxWhIqivFXAuCmEQ2TLdHGQBtF90E8y1JcZ1I7gfgoxcovPLNhjWSqz9X08GKeCshNdPQLFklKEs5XmndHosbK2lzYv3tQaalPvdRh3UP2ECyaVS1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WKp/pmecsHMhRlRbJZqM6zbZwX079spotXBKYXQmioA=;
 b=Dieawux1krxDIXspbkSpAzU7JnFl3Jbf/7nUXO+mV2z4UaJds4+QMAykZVgND/fWu2yBeLdLBI4SjJ+7Zr500iKdGg9pWdU+pB+Gylv4FkdMBVVgn/OuMKPcr1Ae9ei1npZbbhw2WwHkh4rmtnwEUl/yYegkwvK2pvFNGNBH+x7Ofl6CzkoFKsvDDT52lrCMSbT7t2xiBnoqjz/UImpSFEVTTtNcvMxG1uwP4cMh0Lao+MYWeNXHB1a6Ouctj+K7Bjt0ke4GremZaRg1omXZCf911jQwkcIFJiMtDrQ71JY5J2JXS3rzOay0z3UMkhMox9EqNHUB95B38zsxuz6GEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WKp/pmecsHMhRlRbJZqM6zbZwX079spotXBKYXQmioA=;
 b=FTEqL6HI5VoGL5N2MT60YTjI3YFBajj+v9w9D47MJDRdPzhTpqmYGLMvLeaIhk9f2SvT3F7KdrjTPMUmsQ5M5H1Ewm4WdpBjiIJ6lLemTu13fULcyYi1/Tgpnq83ovsK+3vFtcfEB5K76O1reiM+fPvlSqXfwzW1oaZoLCJAJvV5eJ1IGZ6YofIdcsG3gz/JuaTNkmPX+d5PPktmXDwwSsqvev245lodZS1WSPiCgx6pYtTYU3NRax3r0B4KN3XCiDHdKJTUgJxzonFLAb8OrZicxWrrguc/mqVV4LjudEqwWLV47AuMXf+Dn7pOqOiNxniq8H4vIqrG1Cx9lAXHWg==
Received: from MW2PR2101CA0019.namprd21.prod.outlook.com (2603:10b6:302:1::32)
 by SJ2PR12MB8111.namprd12.prod.outlook.com (2603:10b6:a03:4fe::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Mon, 31 Jul
 2023 10:25:57 +0000
Received: from CO1NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::d) by MW2PR2101CA0019.outlook.office365.com
 (2603:10b6:302:1::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.9 via Frontend
 Transport; Mon, 31 Jul 2023 10:25:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT082.mail.protection.outlook.com (10.13.175.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.43 via Frontend Transport; Mon, 31 Jul 2023 10:25:56 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 31 Jul 2023
 03:25:40 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 31 Jul
 2023 03:25:39 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Mon, 31 Jul
 2023 03:25:36 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, Yishai Hadas
 <yishaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb
 <maorg@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta
 <targupta@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH for-8.2 v2 4/6] vfio/migration: Refactor PRE_COPY and RUNNING
 state checks
Date: Mon, 31 Jul 2023 13:25:19 +0300
Message-ID: <20230731102521.15335-5-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230731102521.15335-1-avihaih@nvidia.com>
References: <20230731102521.15335-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT082:EE_|SJ2PR12MB8111:EE_
X-MS-Office365-Filtering-Correlation-Id: d961e595-2244-4cad-81b8-08db91b086dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0gXyZzBCsL3TA7rYUXXsMjsIapOpM9uCRt3sJZ54JyjC0/WCdmUTLqUT/UMrKDubafxxCpVNR/42MvSIWANxlqnRBhaYlgtzLCQqq9fcZFErXxI/V0lZZ++uIyxNNOCXZegKcpKXzfLbR9t+6Zap1tywfByhYRim04P1ILyYF48w+xz8bmDVuQ5tp/Vy/5yZdTvAjyMMB/14ZsYhu8QOavUb1uPg82Ww2oKyGkniHV9ypmpfZ6UX7znnXN9YuaecHMKqb466m7g4a+T7kQTePCWLqP4lZYDosg/MNz+wQvt8KUSdN7bh+gIlm426oWgSNI6o56HuMfX80qQvxU71sLDNEvsbaQUA3hiUJXMulJui9TpXkHiYGRZ8rnEsy7JRo+1WpmlIAnMCvo9oyg2kVTbLtC8dojjG3wNgGH2kvPEsTE7/3eX7/yu+b5bdO4grEO7KMM5ipS8/cn1LY6o9dog8OtJY4APcrFgaQBLnJSwieDacVWV2wqNfl3rmSzDTmS6W5jt5qIx6iqgPaaEB6liuDzO71+BzVF2FczOOBn5UW7lamApMFUjcx0tyORo+lkc/phPab7rqTfvERJsZIJAs9du/YEaQ+B0S9VgZNRaNFKo/2l7dxelrQnwWOscZWYbzOObiMVFOAEUf0nFxEAY0IEuJ8DebSBNKvN+4FkqV/x+/YXtYlcymNl/fK96SwGD6/Z4uFCkNehEpd9EX7emf8PjiqdPMI5JcWa5tgQEvWqNi70RrDqyNWRetYLQy
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(39860400002)(396003)(346002)(82310400008)(451199021)(40470700004)(36840700001)(46966006)(66574015)(40460700003)(2616005)(1076003)(26005)(426003)(186003)(41300700001)(47076005)(70206006)(36860700001)(336012)(4326008)(70586007)(6916009)(83380400001)(8936002)(5660300002)(8676002)(316002)(7696005)(6666004)(478600001)(54906003)(2906002)(40480700001)(82740400003)(7636003)(356005)(36756003)(86362001)(107886003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 10:25:56.4364 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d961e595-2244-4cad-81b8-08db91b086dc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8111
Received-SPF: softfail client-ip=2a01:111:f400:7eaa::62a;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
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


