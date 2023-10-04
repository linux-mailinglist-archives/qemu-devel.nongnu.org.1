Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 353857B7F79
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 14:42:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo1Bo-00072v-5P; Wed, 04 Oct 2023 08:41:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo1Bh-0006su-Kk
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:41:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo1Bd-0003vR-HF
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:41:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696423264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SOKWqqGPWsA1wyTHCxddaMbgmls6OspXqMLJlrx/ODU=;
 b=NPPsJi0UH84sk1HPbL917qkZ6CYM5GP6ujldjRCZJ8gfM4T38m6/3x1wMlmK/cRmQLla3Z
 cZluUpJw2pz/xKE/SNXCc29oFMx1rZDLL6TF7/COX4SYBfwT2uPlrsIXTskkZr9oQ06OY5
 roDYs1sdM7Sf+dAC7DBXhvc6iKN0yjk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-394-vlhrzyIhN0iMKkZxCvcz_g-1; Wed, 04 Oct 2023 08:41:01 -0400
X-MC-Unique: vlhrzyIhN0iMKkZxCvcz_g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D0ED6801E91;
 Wed,  4 Oct 2023 12:41:00 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3F1612026D4B;
 Wed,  4 Oct 2023 12:40:59 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Leonardo Bras <leobras@redhat.com>, Peter Xu <peterx@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-s390x@nongnu.org, Steve Sistare <steven.sistare@oracle.com>,
 "Daniel P . Berrange" <berrange@redhat.com>
Subject: [PULL 10/11] migration: file URI offset
Date: Wed,  4 Oct 2023 14:40:37 +0200
Message-ID: <20231004124038.16002-11-quintela@redhat.com>
In-Reply-To: <20231004124038.16002-1-quintela@redhat.com>
References: <20231004124038.16002-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Steve Sistare <steven.sistare@oracle.com>

Allow an offset option to be specified as part of the file URI, in
the form "file:filename,offset=offset", where offset accepts the common
size suffixes, or the 0x prefix, but not both.  Migration data is written
to and read from the file starting at offset.  If unspecified, it defaults
to 0.

This is needed by libvirt to store its own data at the head of the file.

Suggested-by: Daniel P. Berrange <berrange@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <1694182931-61390-3-git-send-email-steven.sistare@oracle.com>
---
 migration/file.c | 45 +++++++++++++++++++++++++++++++++++++++++++--
 qemu-options.hx  |  7 ++++---
 2 files changed, 47 insertions(+), 5 deletions(-)

diff --git a/migration/file.c b/migration/file.c
index 0a65c43fdd..cf5b1bf365 100644
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
+            error_setg_errno(errp, -ret, "file URI has bad offset %s", option);
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
index 93e638c097..840b83d237 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4706,7 +4706,7 @@ DEF("incoming", HAS_ARG, QEMU_OPTION_incoming, \
     "                prepare for incoming migration, listen on\n" \
     "                specified protocol and socket address\n" \
     "-incoming fd:fd\n" \
-    "-incoming file:filename\n" \
+    "-incoming file:filename[,offset=offset]\n" \
     "-incoming exec:cmdline\n" \
     "                accept incoming migration on given file descriptor\n" \
     "                or from given external command\n" \
@@ -4725,8 +4725,9 @@ SRST
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
2.41.0


