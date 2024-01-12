Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCCC82C284
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 16:07:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOJ6h-0001YM-BJ; Fri, 12 Jan 2024 10:06:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rOJ6B-00011D-Vc
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 10:05:32 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rOJ65-0003cX-U4
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 10:05:29 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40CEXrha024852; Fri, 12 Jan 2024 15:05:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=JrO5zkLOQduwIGEc35Uyhjw3dMfBotlqWvhxmQIuC0g=;
 b=m/ygl4ft2qwlwBfdTsT+DpD7+xnFF/xS3As+8bOioMm0fODW4Nu3yQpiTDfIOKtAlpxn
 3ihpSu2Iuwqjq0lHx2FzHQYp37SFaLRXi/HfIu+VSdftBaPOGIY+D63o0rvzUvzqVfSh
 wFp8xMBFMoLJgkp+dBhrFWL3iI8QdDZJJHDBjI03faWlzbDIo4HA4iiiXq4CzPuF98R+
 kuOA1n0Nu1iK9tQbKbxN0jVgx+UyeHD0MKXxCgMEIO5jEj4qMKV3asnyrLUeoDlHxtVM
 D4qynVaZG0iGt9/xN2b9DzbMPEQ8f7HWf9UQ4QL4/Oqb1TigtGhIU4WthDeeWv5yRJUG tg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vk68306fw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jan 2024 15:05:21 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 40CDqvaP013971; Fri, 12 Jan 2024 15:05:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3vfurgd8ta-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jan 2024 15:05:20 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40CF5BoS017833;
 Fri, 12 Jan 2024 15:05:19 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3vfurgd8k6-12; Fri, 12 Jan 2024 15:05:19 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2 11/11] vfio: allow cpr-reboot migration if suspended
Date: Fri, 12 Jan 2024 07:05:10 -0800
Message-Id: <1705071910-174321-12-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1705071910-174321-1-git-send-email-steven.sistare@oracle.com>
References: <1705071910-174321-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-12_06,2024-01-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401120117
X-Proofpoint-GUID: 2Mqs_0vYqCf0b63VTBRAg1ji1r6xIooT
X-Proofpoint-ORIG-GUID: 2Mqs_0vYqCf0b63VTBRAg1ji1r6xIooT
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Allow cpr-reboot for vfio if the guest is in the suspended runstate.  The
guest drivers' suspend methods flush outstanding requests and re-initialize
the devices, and thus there is no device state to save and restore.  The
user is responsible for suspending the guest before initiating cpr, such as
by issuing guest-suspend-ram to the qemu guest agent.

Relax the vfio blocker so it does not apply to cpr, and add a notifier that
verifies the guest is suspended.  Skip dirty page tracking, which is N/A for
cpr, to avoid ioctl errors.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/common.c              |  2 +-
 hw/vfio/cpr.c                 | 20 ++++++++++++++++++++
 hw/vfio/migration.c           |  2 +-
 include/hw/vfio/vfio-common.h |  1 +
 migration/ram.c               |  9 +++++----
 5 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 0b3352f..09af934 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -128,7 +128,7 @@ int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
     error_setg(&multiple_devices_migration_blocker,
                "Multiple VFIO devices migration is supported only if all of "
                "them support P2P migration");
-    ret = migrate_add_blocker(&multiple_devices_migration_blocker, errp);
+    ret = migrate_add_blocker_normal(&multiple_devices_migration_blocker, errp);
 
     return ret;
 }
diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
index bbd1c7a..9f4b1fe 100644
--- a/hw/vfio/cpr.c
+++ b/hw/vfio/cpr.c
@@ -7,13 +7,33 @@
 
 #include "qemu/osdep.h"
 #include "hw/vfio/vfio-common.h"
+#include "migration/misc.h"
 #include "qapi/error.h"
+#include "sysemu/runstate.h"
+
+static int vfio_cpr_reboot_notifier(NotifierWithReturn *notifier,
+                                    MigrationEvent *e, Error **errp)
+{
+    if (e->state == MIGRATION_STATUS_SETUP &&
+        !runstate_check(RUN_STATE_SUSPENDED)) {
+
+        error_setg(errp,
+            "VFIO device only supports cpr-reboot for runstate suspended");
+
+        return -1;
+    }
+    return 0;
+}
 
 int vfio_cpr_register_container(VFIOContainer *container, Error **errp)
 {
+    migration_add_notifier_mode(&container->cpr_reboot_notifier,
+                                vfio_cpr_reboot_notifier,
+                                MIG_MODE_CPR_REBOOT);
     return 0;
 }
 
 void vfio_cpr_unregister_container(VFIOContainer *container)
 {
+    migration_remove_notifier(&container->cpr_reboot_notifier);
 }
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 534fddf..488905d 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -895,7 +895,7 @@ static int vfio_block_migration(VFIODevice *vbasedev, Error *err, Error **errp)
     vbasedev->migration_blocker = error_copy(err);
     error_free(err);
 
-    return migrate_add_blocker(&vbasedev->migration_blocker, errp);
+    return migrate_add_blocker_normal(&vbasedev->migration_blocker, errp);
 }
 
 /* ---------------------------------------------------------------------- */
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 1add5b7..7a46e24 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -78,6 +78,7 @@ struct VFIOGroup;
 typedef struct VFIOContainer {
     VFIOContainerBase bcontainer;
     int fd; /* /dev/vfio/vfio, empowered by the attached groups */
+    NotifierWithReturn cpr_reboot_notifier;
     unsigned iommu_type;
     QLIST_HEAD(, VFIOGroup) group_list;
 } VFIOContainer;
diff --git a/migration/ram.c b/migration/ram.c
index 1923366..44ad324 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2392,8 +2392,8 @@ static void ram_save_cleanup(void *opaque)
     RAMState **rsp = opaque;
     RAMBlock *block;
 
-    /* We don't use dirty log with background snapshots */
-    if (!migrate_background_snapshot()) {
+    /* We don't use dirty log with background snapshots or cpr */
+    if (!migrate_background_snapshot() && migrate_mode() == MIG_MODE_NORMAL) {
         /* caller have hold BQL or is in a bh, so there is
          * no writing race against the migration bitmap
          */
@@ -2804,8 +2804,9 @@ static void ram_init_bitmaps(RAMState *rs)
 
     WITH_RCU_READ_LOCK_GUARD() {
         ram_list_init_bitmaps();
-        /* We don't use dirty log with background snapshots */
-        if (!migrate_background_snapshot()) {
+        /* We don't use dirty log with background snapshots or cpr */
+        if (!migrate_background_snapshot() &&
+            migrate_mode() == MIG_MODE_NORMAL) {
             memory_global_dirty_log_start(GLOBAL_DIRTY_MIGRATION);
             migration_bitmap_sync_precopy(rs, false);
         }
-- 
1.8.3.1


