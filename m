Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2D573A999
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 22:39:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCR3l-0005gL-K6; Thu, 22 Jun 2023 16:37:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qCR3j-0005fa-NS
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 16:37:39 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qCR3g-0002jc-PE
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 16:37:39 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35MIIqOQ005813; Thu, 22 Jun 2023 20:37:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=2WGGN3erxEjBpka7/UVwFBOykCo3aUd/FjoUZ5IgDbI=;
 b=i5iyCtTErH/u1s9JKvZmV1JeFbUifpFW15v8DUhRSMQZelMVpvkcvQ8WIqZvSiFEjWKM
 P9CsNKaJUvBKqNVphzy4EuTuZ4YYep8YI4MbjmlTvKOcoRs00iiEKur8JtwmbABO4mSI
 bn4cx59zohU39BbuZnP4u3vwX4f3Hg+qmYRrDybuJAPHRElhzZjYUlxgGm4SqxIz9upb
 KRnAHMJloS/wKAVVz6RANkwRez4oojcH3H3AzPHEHsoAta4nZUm9Ieh4H4n9GB2OIX5L
 3ghgDTpfLVd1ECVFoiBP+TwvGKGRgAv5Kxx5vS7H3PMAfTotmPVXIDX+n9blywdwwiPw zA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r94vctwm3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Jun 2023 20:37:34 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35MJ5Njc007763; Thu, 22 Jun 2023 20:37:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3r9w18f73e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Jun 2023 20:37:33 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35MKbVQf008226;
 Thu, 22 Jun 2023 20:37:32 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3r9w18f72f-3; Thu, 22 Jun 2023 20:37:32 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V3 2/2] migration: file URI offset
Date: Thu, 22 Jun 2023 13:37:31 -0700
Message-Id: <1687466251-310524-3-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1687466251-310524-1-git-send-email-steven.sistare@oracle.com>
References: <1687466251-310524-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_15,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306220176
X-Proofpoint-GUID: 4XtJGPTQQ_wgXnbPjxgP7uNlLMNvPl_e
X-Proofpoint-ORIG-GUID: 4XtJGPTQQ_wgXnbPjxgP7uNlLMNvPl_e
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

Allow an offset option to be specified as part of the file URI, in
the form "file:filename,offset=offset", where offset accepts the common
size suffixes, or the 0x prefix, but not both.  Migration data is written
to and read from the file starting at offset.  If unspecified, it defaults
to 0.

This is needed by libvirt to store its own data at the head of the file.

Suggested-by: Daniel P. Berrange <berrange@redhat.com>
Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 migration/file.c | 45 +++++++++++++++++++++++++++++++++++++++++++--
 qemu-options.hx  |  7 ++++---
 2 files changed, 47 insertions(+), 5 deletions(-)

diff --git a/migration/file.c b/migration/file.c
index 8e35827..8960be9 100644
--- a/migration/file.c
+++ b/migration/file.c
@@ -6,6 +6,8 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
+#include "qapi/error.h"
 #include "channel.h"
 #include "file.h"
 #include "migration.h"
@@ -13,14 +15,41 @@
 #include "io/channel-util.h"
 #include "trace.h"
 
-void file_start_outgoing_migration(MigrationState *s, const char *filename,
+#define OFFSET_OPTION ",offset="
+
+/* Remove the offset option from @filespec and return it in @offsetp. */
+
+static int file_parse_offset(char *filespec, uint64_t *offsetp, Error **errp)
+{
+    char *option = strstr(filespec, OFFSET_OPTION);
+    int ret;
+
+    if (option) {
+        *option = 0;
+        option += sizeof(OFFSET_OPTION) - 1;
+        ret = qemu_strtosz(option, NULL, offsetp);
+        if (ret) {
+            error_setg_errno(errp, ret, "file URI has bad offset %s", option);
+            return -1;
+        }
+    }
+    return 0;
+}
+
+void file_start_outgoing_migration(MigrationState *s, const char *filespec,
                                    Error **errp)
 {
+    g_autofree char *filename = g_strdup(filespec);
     g_autoptr(QIOChannelFile) fioc = NULL;
+    uint64_t offset = 0;
     QIOChannel *ioc;
 
     trace_migration_file_outgoing(filename);
 
+    if (file_parse_offset(filename, &offset, errp)) {
+        return;
+    }
+
     fioc = qio_channel_file_new_path(filename, O_CREAT | O_WRONLY | O_TRUNC,
                                      0600, errp);
     if (!fioc) {
@@ -28,6 +57,9 @@ void file_start_outgoing_migration(MigrationState *s, const char *filename,
     }
 
     ioc = QIO_CHANNEL(fioc);
+    if (offset && qio_channel_io_seek(ioc, offset, SEEK_SET, errp) < 0) {
+        return;
+    }
     qio_channel_set_name(ioc, "migration-file-outgoing");
     migration_channel_connect(s, ioc, NULL, NULL);
 }
@@ -41,19 +73,28 @@ static gboolean file_accept_incoming_migration(QIOChannel *ioc,
     return G_SOURCE_REMOVE;
 }
 
-void file_start_incoming_migration(const char *filename, Error **errp)
+void file_start_incoming_migration(const char *filespec, Error **errp)
 {
+    g_autofree char *filename = g_strdup(filespec);
     QIOChannelFile *fioc = NULL;
+    uint64_t offset = 0;
     QIOChannel *ioc;
 
     trace_migration_file_incoming(filename);
 
+    if (file_parse_offset(filename, &offset, errp)) {
+        return;
+    }
+
     fioc = qio_channel_file_new_path(filename, O_RDONLY, 0, errp);
     if (!fioc) {
         return;
     }
 
     ioc = QIO_CHANNEL(fioc);
+    if (offset && qio_channel_io_seek(ioc, offset, SEEK_SET, errp) < 0) {
+        return;
+    }
     qio_channel_set_name(QIO_CHANNEL(ioc), "migration-file-incoming");
     qio_channel_add_watch_full(ioc, G_IO_IN,
                                file_accept_incoming_migration,
diff --git a/qemu-options.hx b/qemu-options.hx
index 5aab8fb..5a92210 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4622,7 +4622,7 @@ DEF("incoming", HAS_ARG, QEMU_OPTION_incoming, \
     "                prepare for incoming migration, listen on\n" \
     "                specified protocol and socket address\n" \
     "-incoming fd:fd\n" \
-    "-incoming file:filename\n" \
+    "-incoming file:filename[,offset=offset]\n" \
     "-incoming exec:cmdline\n" \
     "                accept incoming migration on given file descriptor\n" \
     "                or from given external command\n" \
@@ -4641,8 +4641,9 @@ SRST
 ``-incoming fd:fd``
     Accept incoming migration from a given file descriptor.
 
-``-incoming file:filename``
-    Accept incoming migration from a given file.
+``-incoming file:filename[,offset=offset]``
+    Accept incoming migration from a given file starting at offset.
+    offset allows the common size suffixes, or a 0x prefix, but not both.
 
 ``-incoming exec:cmdline``
     Accept incoming migration as an output from specified external
-- 
1.8.3.1


