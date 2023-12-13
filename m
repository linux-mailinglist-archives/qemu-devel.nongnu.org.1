Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0AC811C07
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 19:12:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDThz-0000Oc-0U; Wed, 13 Dec 2023 13:11:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rDThu-0000Mr-Tn
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 13:11:42 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rDThq-0001eZ-2A
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 13:11:42 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3BDERBMx006290; Wed, 13 Dec 2023 18:11:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=7xCu+lSEkzgl7slhvVe6r0pQzsdqydNPVvI8C6jmKeY=;
 b=FnzLhxATJDDmRYBTIPtZ23aigf63mDEeRNTohF2bmHNEgmo79qVnDeisi9qM15y4lmyP
 hixgX7rtn5GBmcfYDQHgmxOII+oZO9+HeP/d7d2U5mDFlsAZmf+EAbyrQbNVmMjvHu6B
 JActbRAQkIZLAh2XIbqeci5tqGaz9qynPYlalCBAcd77FNrKMX5TRuaGmU6LTf6xXKOf
 90MGSrnNhmC70N7HPFkIV7FsnKWRrcMD44WpifMICsP/p0Qv4v0XOWcbq3mwE2iYsigr
 +GLIkHdQj41rKjkK2NAZZfIFp+07KGBpEvoaZfT/MBl1FhUXFBFG78MyJwKuTVbuOhal vQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvg9d90wp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Dec 2023 18:11:37 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3BDHTUFd008246; Wed, 13 Dec 2023 18:11:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3uvep8p74j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Dec 2023 18:11:36 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BDIAvtp019890;
 Wed, 13 Dec 2023 18:11:35 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3uvep8p732-2; Wed, 13 Dec 2023 18:11:35 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1 1/3] migration: check mode in notifiers
Date: Wed, 13 Dec 2023 10:11:31 -0800
Message-Id: <1702491093-383782-2-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1702491093-383782-1-git-send-email-steven.sistare@oracle.com>
References: <1702491093-383782-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-13_12,2023-12-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312130130
X-Proofpoint-GUID: TulIHIlmRB9LhBz37zcJNCz5FoDkdMxp
X-Proofpoint-ORIG-GUID: TulIHIlmRB9LhBz37zcJNCz5FoDkdMxp
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The existing notifiers should only apply to normal mode.

No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/net/virtio-net.c      | 4 ++++
 hw/vfio/migration.c      | 3 +++
 include/migration/misc.h | 1 +
 migration/migration.c    | 5 +++++
 net/vhost-vdpa.c         | 4 ++++
 ui/spice-core.c          | 2 +-
 6 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 80c56f0..0fa083d 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3532,6 +3532,10 @@ static void virtio_net_handle_migration_primary(VirtIONet *n, MigrationState *s)
 static void virtio_net_migration_state_notifier(Notifier *notifier, void *data)
 {
     MigrationState *s = data;
+
+    if (migrate_mode_of(s) != MIG_MODE_NORMAL) {
+        return;
+    }
     VirtIONet *n = container_of(notifier, VirtIONet, migration_state);
     virtio_net_handle_migration_primary(n, s);
 }
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 28d422b..814132a 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -763,6 +763,9 @@ static void vfio_migration_state_notifier(Notifier *notifier, void *data)
                                             migration_state);
     VFIODevice *vbasedev = migration->vbasedev;
 
+    if (migrate_mode_of(s) != MIG_MODE_NORMAL) {
+        return;
+    }
     trace_vfio_migration_state_notifier(vbasedev->name,
                                         MigrationStatus_str(s->state));
 
diff --git a/include/migration/misc.h b/include/migration/misc.h
index 1bc8902..901d117 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -61,6 +61,7 @@ void migration_object_init(void);
 void migration_shutdown(void);
 bool migration_is_idle(void);
 bool migration_is_active(MigrationState *);
+MigMode migrate_mode_of(MigrationState *);
 void migration_add_notifier(Notifier *notify,
                             void (*func)(Notifier *notifier, void *data));
 void migration_remove_notifier(Notifier *notify);
diff --git a/migration/migration.c b/migration/migration.c
index 2cc7e2a..d5bfe70 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1559,6 +1559,11 @@ bool migration_is_active(MigrationState *s)
             s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
 }
 
+MigMode migrate_mode_of(MigrationState *s)
+{
+    return s->parameters.mode;
+}
+
 int migrate_init(MigrationState *s, Error **errp)
 {
     int ret;
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index d0614d7..80acc4b 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -336,6 +336,10 @@ static void vdpa_net_migration_state_notifier(Notifier *notifier, void *data)
     VhostVDPAState *s = container_of(notifier, VhostVDPAState,
                                      migration_state);
 
+    if (migrate_mode_of(migration) != MIG_MODE_NORMAL) {
+        return;
+    }
+
     if (migration_in_setup(migration)) {
         vhost_vdpa_net_log_global_enable(s, true);
     } else if (migration_has_failed(migration)) {
diff --git a/ui/spice-core.c b/ui/spice-core.c
index db21db2..0a04eb0 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -572,7 +572,7 @@ static void migration_state_notifier(Notifier *notifier, void *data)
 {
     MigrationState *s = data;
 
-    if (!spice_have_target_host) {
+    if (!spice_have_target_host || migrate_mode_of(s) != MIG_MODE_NORMAL) {
         return;
     }
 
-- 
1.8.3.1


