Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E07272690C
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 20:39:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6y45-0003PH-5c; Wed, 07 Jun 2023 14:39:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1q6y42-0003LW-99
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 14:39:22 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1q6y3u-00080b-Md
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 14:39:21 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 357EXSdR013828; Wed, 7 Jun 2023 18:39:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2023-03-30;
 bh=U8iJAY2xVSoc8Va1trP+/r6zV4Jdv5cq9LClGzTFgQ8=;
 b=pttJNQ+z8bnlIogVF8GKyrf8rEnhgY4qostpKGGBbAAGLRIvI4NMCWCSUGPPRJYzyCwz
 DexPSCWekzpD1KmJtTvvSDbN1uXv50hyvMuuxJzELbZuwl3izovGjjNHFd/2r2KuTlLp
 d7pIGNcSQD2ikywwrVthxZyF9ZsNn65aWIadAukJSeq+c24Bb7VBqCX8wH7/49YaZmQi
 Bd0kXtLocwZBsBMNWe9YFi8C+UHdgQD4zi4Xxm786W/yvN9CK6yw1h3Xrwgsn13aCL0U
 r6mTu/+ARLtZ2CiLFuU31z9M9N02hFtj1+4gnGqdr396h4YGtHmODeztX09c7MByiq7+ HA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6utgyt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 07 Jun 2023 18:39:12 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 357GtZjO002892; Wed, 7 Jun 2023 18:39:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3r2a6kn2y6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 07 Jun 2023 18:39:10 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 357IdAZr009292;
 Wed, 7 Jun 2023 18:39:10 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3r2a6kn2rb-1; Wed, 07 Jun 2023 18:39:10 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2] migration: file URI
Date: Wed,  7 Jun 2023 11:38:59 -0700
Message-Id: <1686163139-256654-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_10,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306070161
X-Proofpoint-GUID: OlYHvI399StnA9GBZVkmB6JEqGKIKu87
X-Proofpoint-ORIG-GUID: OlYHvI399StnA9GBZVkmB6JEqGKIKu87
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Extend the migration URI to support file:<filename>.  This can be used for
any migration scenario that does not require a reverse path.  It can be used
as an alternative to 'exec:cat > file' in minimized containers that do not
contain /bin/sh, and it is easier to use than the fd:<fdname> URI.  It can
be used in HMP commands, and as a qemu command-line parameter.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 migration/file.c       | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++
 migration/file.h       | 14 ++++++++++++
 migration/meson.build  |  1 +
 migration/migration.c  |  5 ++++
 migration/trace-events |  4 ++++
 qemu-options.hx        |  6 ++++-
 6 files changed, 91 insertions(+), 1 deletion(-)
 create mode 100644 migration/file.c
 create mode 100644 migration/file.h

diff --git a/migration/file.c b/migration/file.c
new file mode 100644
index 0000000..8e35827
--- /dev/null
+++ b/migration/file.c
@@ -0,0 +1,62 @@
+/*
+ * Copyright (c) 2021-2023 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "channel.h"
+#include "file.h"
+#include "migration.h"
+#include "io/channel-file.h"
+#include "io/channel-util.h"
+#include "trace.h"
+
+void file_start_outgoing_migration(MigrationState *s, const char *filename,
+                                   Error **errp)
+{
+    g_autoptr(QIOChannelFile) fioc = NULL;
+    QIOChannel *ioc;
+
+    trace_migration_file_outgoing(filename);
+
+    fioc = qio_channel_file_new_path(filename, O_CREAT | O_WRONLY | O_TRUNC,
+                                     0600, errp);
+    if (!fioc) {
+        return;
+    }
+
+    ioc = QIO_CHANNEL(fioc);
+    qio_channel_set_name(ioc, "migration-file-outgoing");
+    migration_channel_connect(s, ioc, NULL, NULL);
+}
+
+static gboolean file_accept_incoming_migration(QIOChannel *ioc,
+                                               GIOCondition condition,
+                                               gpointer opaque)
+{
+    migration_channel_process_incoming(ioc);
+    object_unref(OBJECT(ioc));
+    return G_SOURCE_REMOVE;
+}
+
+void file_start_incoming_migration(const char *filename, Error **errp)
+{
+    QIOChannelFile *fioc = NULL;
+    QIOChannel *ioc;
+
+    trace_migration_file_incoming(filename);
+
+    fioc = qio_channel_file_new_path(filename, O_RDONLY, 0, errp);
+    if (!fioc) {
+        return;
+    }
+
+    ioc = QIO_CHANNEL(fioc);
+    qio_channel_set_name(QIO_CHANNEL(ioc), "migration-file-incoming");
+    qio_channel_add_watch_full(ioc, G_IO_IN,
+                               file_accept_incoming_migration,
+                               NULL, NULL,
+                               g_main_context_get_thread_default());
+}
diff --git a/migration/file.h b/migration/file.h
new file mode 100644
index 0000000..841b94a
--- /dev/null
+++ b/migration/file.h
@@ -0,0 +1,14 @@
+/*
+ * Copyright (c) 2021-2023 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef QEMU_MIGRATION_FILE_H
+#define QEMU_MIGRATION_FILE_H
+void file_start_incoming_migration(const char *filename, Error **errp);
+
+void file_start_outgoing_migration(MigrationState *s, const char *filename,
+                                   Error **errp);
+#endif
diff --git a/migration/meson.build b/migration/meson.build
index 8ba6e42..3af817e 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -16,6 +16,7 @@ softmmu_ss.add(files(
   'dirtyrate.c',
   'exec.c',
   'fd.c',
+  'file.c',
   'global_state.c',
   'migration-hmp-cmds.c',
   'migration.c',
diff --git a/migration/migration.c b/migration/migration.c
index dc05c6f..cfbde86 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -20,6 +20,7 @@
 #include "migration/blocker.h"
 #include "exec.h"
 #include "fd.h"
+#include "file.h"
 #include "socket.h"
 #include "sysemu/runstate.h"
 #include "sysemu/sysemu.h"
@@ -442,6 +443,8 @@ static void qemu_start_incoming_migration(const char *uri, Error **errp)
         exec_start_incoming_migration(p, errp);
     } else if (strstart(uri, "fd:", &p)) {
         fd_start_incoming_migration(p, errp);
+    } else if (strstart(uri, "file:", &p)) {
+        file_start_incoming_migration(p, errp);
     } else {
         error_setg(errp, "unknown migration protocol: %s", uri);
     }
@@ -1662,6 +1665,8 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
         exec_start_outgoing_migration(s, p, &local_err);
     } else if (strstart(uri, "fd:", &p)) {
         fd_start_outgoing_migration(s, p, &local_err);
+    } else if (strstart(uri, "file:", &p)) {
+        file_start_outgoing_migration(s, p, &local_err);
     } else {
         if (!(has_resume && resume)) {
             yank_unregister_instance(MIGRATION_YANK_INSTANCE);
diff --git a/migration/trace-events b/migration/trace-events
index cdaef7a..c8c1771 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -307,6 +307,10 @@ migration_exec_incoming(const char *cmd) "cmd=%s"
 migration_fd_outgoing(int fd) "fd=%d"
 migration_fd_incoming(int fd) "fd=%d"
 
+# file.c
+migration_file_outgoing(const char *filename) "filename=%s"
+migration_file_incoming(const char *filename) "filename=%s"
+
 # socket.c
 migration_socket_incoming_accepted(void) ""
 migration_socket_outgoing_connected(const char *hostname) "hostname=%s"
diff --git a/qemu-options.hx b/qemu-options.hx
index b37eb96..b93449d 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4610,6 +4610,7 @@ DEF("incoming", HAS_ARG, QEMU_OPTION_incoming, \
     "                prepare for incoming migration, listen on\n" \
     "                specified protocol and socket address\n" \
     "-incoming fd:fd\n" \
+    "-incoming file:filename\n" \
     "-incoming exec:cmdline\n" \
     "                accept incoming migration on given file descriptor\n" \
     "                or from given external command\n" \
@@ -4626,7 +4627,10 @@ SRST
     Prepare for incoming migration, listen on a given unix socket.
 
 ``-incoming fd:fd``
-    Accept incoming migration from a given filedescriptor.
+    Accept incoming migration from a given file descriptor.
+
+``-incoming file:filename``
+    Accept incoming migration from a given file.
 
 ``-incoming exec:cmdline``
     Accept incoming migration as an output from specified external
-- 
1.8.3.1


