Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCB382C294
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 16:11:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOJB6-0002lR-0w; Fri, 12 Jan 2024 10:10:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rOJAv-0002f8-JO
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 10:10:26 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rOJAo-0006f5-FE
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 10:10:23 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40CEbQsa031073; Fri, 12 Jan 2024 15:10:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=kXQvRPEGCLi+4OOGlOZM5NP0000sHFjucHfMHXrjPcc=;
 b=gVCrmyBU5Y9fNBorkAIrSy6dBr/MXJBuxngfxqn/XOaMMltJwax3FaLULuIQilOoZu/g
 CLdTh4Vfus6IgUR3Uj7v3aNq26l+8Bud37UXBby17zRrj9S0w6H5Zk8YaKt64LzGAG4w
 tu6ECyotuA5iS8AtxZbS+dE21uqtaELVhP/8K6eNfu7M4O4yBLqrGf67LyuJq7DIbWyY
 DSOLrRY9TmDh8GZwclfjT2zy1uvUyVO2fPFJTKrO2ljMxVFWSBvWbcCPzY1U05N9aCgU
 hBoyqTmZvpEs3lIR15oGfwFhYoODiBg+h7ZZ+x2rSVrMJN8O2YlCKn2FNCFpmvhS//xd Zw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vk7bmg3g2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jan 2024 15:10:14 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 40CF2Biu013937; Fri, 12 Jan 2024 15:05:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3vfurgd8n1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jan 2024 15:05:14 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40CF5BoC017833;
 Fri, 12 Jan 2024 15:05:13 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3vfurgd8k6-4; Fri, 12 Jan 2024 15:05:13 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2 03/11] migration: convert to NotifierWithReturn
Date: Fri, 12 Jan 2024 07:05:02 -0800
Message-Id: <1705071910-174321-4-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: FvQk9ppJQOYmcDaqvrcRE7QM-KrApLTp
X-Proofpoint-ORIG-GUID: FvQk9ppJQOYmcDaqvrcRE7QM-KrApLTp
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Change all migration notifiers to type NotifierWithReturn, so notifiers
can return an error status in a future patch.  For now, pass NULL for the
notifier error parameter, and do not check the return value.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/net/virtio-net.c            |  4 +++-
 hw/vfio/migration.c            |  4 +++-
 include/hw/vfio/vfio-common.h  |  2 +-
 include/hw/virtio/virtio-net.h |  2 +-
 include/migration/misc.h       |  6 +++---
 migration/migration.c          | 16 ++++++++--------
 net/vhost-vdpa.c               |  6 ++++--
 ui/spice-core.c                |  8 +++++---
 8 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 7a2846f..9570353 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3529,11 +3529,13 @@ static void virtio_net_handle_migration_primary(VirtIONet *n, MigrationState *s)
     }
 }
 
-static void virtio_net_migration_state_notifier(Notifier *notifier, void *data)
+static int virtio_net_migration_state_notifier(NotifierWithReturn *notifier,
+                                               void *data, Error **errp)
 {
     MigrationState *s = data;
     VirtIONet *n = container_of(notifier, VirtIONet, migration_state);
     virtio_net_handle_migration_primary(n, s);
+    return 0;
 }
 
 static bool failover_hide_primary_device(DeviceListener *listener,
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 70e6b1a..6b6acc4 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -754,7 +754,8 @@ static void vfio_vmstate_change(void *opaque, bool running, RunState state)
                               mig_state_to_str(new_state));
 }
 
-static void vfio_migration_state_notifier(Notifier *notifier, void *data)
+static int vfio_migration_state_notifier(NotifierWithReturn *notifier,
+                                         void *data, Error **errp)
 {
     MigrationState *s = data;
     VFIOMigration *migration = container_of(notifier, VFIOMigration,
@@ -770,6 +771,7 @@ static void vfio_migration_state_notifier(Notifier *notifier, void *data)
     case MIGRATION_STATUS_FAILED:
         vfio_migration_set_state_or_reset(vbasedev, VFIO_DEVICE_STATE_RUNNING);
     }
+    return 0;
 }
 
 static void vfio_migration_free(VFIODevice *vbasedev)
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 9b7ef7d..4a6c262 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -62,7 +62,7 @@ typedef struct VFIORegion {
 typedef struct VFIOMigration {
     struct VFIODevice *vbasedev;
     VMChangeStateEntry *vm_state;
-    Notifier migration_state;
+    NotifierWithReturn migration_state;
     uint32_t device_state;
     int data_fd;
     void *data_buffer;
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index 55977f0..eaee8f4 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -221,7 +221,7 @@ struct VirtIONet {
     DeviceListener primary_listener;
     QDict *primary_opts;
     bool primary_opts_from_json;
-    Notifier migration_state;
+    NotifierWithReturn migration_state;
     VirtioNetRssData rss_data;
     struct NetRxPkt *rx_pkt;
     struct EBPFRSSContext ebpf_rss;
diff --git a/include/migration/misc.h b/include/migration/misc.h
index 5e65c18..b62e351 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -60,9 +60,9 @@ void migration_object_init(void);
 void migration_shutdown(void);
 bool migration_is_idle(void);
 bool migration_is_active(MigrationState *);
-void migration_add_notifier(Notifier *notify,
-                            void (*func)(Notifier *notifier, void *data));
-void migration_remove_notifier(Notifier *notify);
+void migration_add_notifier(NotifierWithReturn *notify,
+                            NotifierWithReturnFunc func);
+void migration_remove_notifier(NotifierWithReturn *notify);
 void migration_call_notifiers(MigrationState *s);
 bool migration_in_setup(MigrationState *);
 bool migration_has_finished(MigrationState *);
diff --git a/migration/migration.c b/migration/migration.c
index 98c5c3e..fa662a5 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -68,8 +68,8 @@
 #include "sysemu/dirtylimit.h"
 #include "qemu/sockets.h"
 
-static NotifierList migration_state_notifiers =
-    NOTIFIER_LIST_INITIALIZER(migration_state_notifiers);
+static NotifierWithReturnList migration_state_notifiers =
+    NOTIFIER_WITH_RETURN_LIST_INITIALIZER(migration_state_notifiers);
 
 /* Messages sent on the return path from destination to source */
 enum mig_rp_message_type {
@@ -1424,24 +1424,24 @@ static void migrate_fd_cancel(MigrationState *s)
     }
 }
 
-void migration_add_notifier(Notifier *notify,
-                            void (*func)(Notifier *notifier, void *data))
+void migration_add_notifier(NotifierWithReturn *notify,
+                            NotifierWithReturnFunc func)
 {
     notify->notify = func;
-    notifier_list_add(&migration_state_notifiers, notify);
+    notifier_with_return_list_add(&migration_state_notifiers, notify);
 }
 
-void migration_remove_notifier(Notifier *notify)
+void migration_remove_notifier(NotifierWithReturn *notify)
 {
     if (notify->notify) {
-        notifier_remove(notify);
+        notifier_with_return_remove(notify);
         notify->notify = NULL;
     }
 }
 
 void migration_call_notifiers(MigrationState *s)
 {
-    notifier_list_notify(&migration_state_notifiers, s);
+    notifier_with_return_list_notify(&migration_state_notifiers, s, 0);
 }
 
 bool migration_in_setup(MigrationState *s)
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 3726ee5..1c00519 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -34,7 +34,7 @@
 typedef struct VhostVDPAState {
     NetClientState nc;
     struct vhost_vdpa vhost_vdpa;
-    Notifier migration_state;
+    NotifierWithReturn migration_state;
     VHostNetState *vhost_net;
 
     /* Control commands shadow buffers */
@@ -322,7 +322,8 @@ static void vhost_vdpa_net_log_global_enable(VhostVDPAState *s, bool enable)
     }
 }
 
-static void vdpa_net_migration_state_notifier(Notifier *notifier, void *data)
+static int vdpa_net_migration_state_notifier(NotifierWithReturn *notifier,
+                                             void *data, Error **errp)
 {
     MigrationState *migration = data;
     VhostVDPAState *s = container_of(notifier, VhostVDPAState,
@@ -333,6 +334,7 @@ static void vdpa_net_migration_state_notifier(Notifier *notifier, void *data)
     } else if (migration_has_failed(migration)) {
         vhost_vdpa_net_log_global_enable(s, false);
     }
+    return 0;
 }
 
 static void vhost_vdpa_net_data_start_first(VhostVDPAState *s)
diff --git a/ui/spice-core.c b/ui/spice-core.c
index 37b277f..b3cd229 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -42,7 +42,7 @@
 /* core bits */
 
 static SpiceServer *spice_server;
-static Notifier migration_state;
+static NotifierWithReturn migration_state;
 static const char *auth = "spice";
 static char *auth_passwd;
 static time_t auth_expires = TIME_MAX;
@@ -568,12 +568,13 @@ static SpiceInfo *qmp_query_spice_real(Error **errp)
     return info;
 }
 
-static void migration_state_notifier(Notifier *notifier, void *data)
+static int migration_state_notifier(NotifierWithReturn *notifier,
+                                    void *data, Error **errp)
 {
     MigrationState *s = data;
 
     if (!spice_have_target_host) {
-        return;
+        return 0;
     }
 
     if (migration_in_setup(s)) {
@@ -586,6 +587,7 @@ static void migration_state_notifier(Notifier *notifier, void *data)
         spice_server_migrate_end(spice_server, false);
         spice_have_target_host = false;
     }
+    return 0;
 }
 
 int qemu_spice_migrate_info(const char *hostname, int port, int tls_port,
-- 
1.8.3.1


