Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 569F179889D
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 16:23:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qecNS-0002gq-7x; Fri, 08 Sep 2023 10:22:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qecNN-0002Ei-Q7
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 10:22:26 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qecNJ-0001mb-A4
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 10:22:25 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 388DxHYV024937; Fri, 8 Sep 2023 14:22:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=KXfRmb0IVI+uthMVm6Wpgc9YhcVdK1bAvDPrJltZO/w=;
 b=X7gmrr/wCOOJwa9Vq0K4trUtkW+d+ClFmctXl0nU1jEparexO3LA4uvTcMZs/OqwTp1K
 3Cs7BPNw1W+o1tOM3xSmMov0Micqvt4afstUH6ej79hUPLYGVCYpKOEP5qAH7PmRtQ20
 cXfWCerOp5Xzya6fzgiPLJFnQckar/LzdAxNdsx64BZBaIHIwa5zgQhMQB9EHIdTenZv
 7aec2hyQnhzLzUc+T5Og/LavzFQ6noPErb4iKDv403Gn5+1Jyced7ArMqkosvyvIPcNA
 9dj//N0YcvSxXBJ+qCmIhPn5HurfHH7f6vGxdofg2Z449i1szMgkzH4tm0ws7PlEQTSs eA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t04sjr3ru-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 08 Sep 2023 14:22:18 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 388EElVf017326; Fri, 8 Sep 2023 14:22:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3suug9q06k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 08 Sep 2023 14:22:12 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 388EMBns013364;
 Fri, 8 Sep 2023 14:22:12 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3suug9q05r-2; Fri, 08 Sep 2023 14:22:12 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Claudio Fontana <cfontana@suse.de>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V5 1/2] migration: file URI
Date: Fri,  8 Sep 2023 07:22:10 -0700
Message-Id: <1694182931-61390-2-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1694182931-61390-1-git-send-email-steven.sistare@oracle.com>
References: <1694182931-61390-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_11,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 phishscore=0 bulkscore=0
 adultscore=0 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309080133
X-Proofpoint-GUID: DfujRKnfErUpc1eGL39DLVb3iKs9u0kM
X-Proofpoint-ORIG-GUID: DfujRKnfErUpc1eGL39DLVb3iKs9u0kM
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
any migration scenario that does not require a reverse path.  It can be
used as an alternative to 'exec:cat > file' in minimized containers that
do not contain /bin/sh, and it is easier to use than the fd:<fdname> URI.
It can be used in HMP commands, and as a qemu command-line parameter.

For best performance, guest ram should be shared and x-ignore-shared
should be true, so guest pages are not written to the file, in which case
the guest may remain running.  If ram is not so configured, then the user
is advised to stop the guest first.  Otherwise, a busy guest may re-dirty
the same page, causing it to be appended to the file multiple times,
and the file may grow unboundedly.  That issue is being addressed in the
"fixed-ram" patch series.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Tested-by: Michael Galaxy <mgalaxy@akamai.com>
Reviewed-by: Michael Galaxy <mgalaxy@akamai.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
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
index 0000000..0a65c43
--- /dev/null
+++ b/migration/file.c
@@ -0,0 +1,62 @@
+/*
+ * Copyright (c) 2021-2023 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
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
index 0000000..90fa484
--- /dev/null
+++ b/migration/file.h
@@ -0,0 +1,14 @@
+/*
+ * Copyright (c) 2021-2023 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
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
index 1ae2852..92b1cc4 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -16,6 +16,7 @@ system_ss.add(files(
   'dirtyrate.c',
   'exec.c',
   'fd.c',
+  'file.c',
   'global_state.c',
   'migration-hmp-cmds.c',
   'migration.c',
diff --git a/migration/migration.c b/migration/migration.c
index 096e819..c612ec1 100644
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
@@ -443,6 +444,8 @@ static void qemu_start_incoming_migration(const char *uri, Error **errp)
         exec_start_incoming_migration(p, errp);
     } else if (strstart(uri, "fd:", &p)) {
         fd_start_incoming_migration(p, errp);
+    } else if (strstart(uri, "file:", &p)) {
+        file_start_incoming_migration(p, errp);
     } else {
         error_setg(errp, "unknown migration protocol: %s", uri);
     }
@@ -1670,6 +1673,8 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
         exec_start_outgoing_migration(s, p, &local_err);
     } else if (strstart(uri, "fd:", &p)) {
         fd_start_outgoing_migration(s, p, &local_err);
+    } else if (strstart(uri, "file:", &p)) {
+        file_start_outgoing_migration(s, p, &local_err);
     } else {
         if (!(has_resume && resume)) {
             yank_unregister_instance(MIGRATION_YANK_INSTANCE);
diff --git a/migration/trace-events b/migration/trace-events
index 5259c10..1d70dcf 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -310,6 +310,10 @@ migration_exec_incoming(const char *cmd) "cmd=%s"
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
index 3a6c7d3..54e28c1 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4626,6 +4626,7 @@ DEF("incoming", HAS_ARG, QEMU_OPTION_incoming, \
     "                prepare for incoming migration, listen on\n" \
     "                specified protocol and socket address\n" \
     "-incoming fd:fd\n" \
+    "-incoming file:filename\n" \
     "-incoming exec:cmdline\n" \
     "                accept incoming migration on given file descriptor\n" \
     "                or from given external command\n" \
@@ -4642,7 +4643,10 @@ SRST
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


