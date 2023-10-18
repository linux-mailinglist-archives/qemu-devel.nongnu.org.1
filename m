Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6EC7CDFC9
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 16:29:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt7XU-0006W0-Hj; Wed, 18 Oct 2023 10:28:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qt7XT-0006Vo-Ao
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 10:28:47 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qt7XR-0007gz-Cr
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 10:28:47 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BCFEA1F383;
 Wed, 18 Oct 2023 14:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697639322; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z5n3VCOIG1/lAD6HoR2Xafic/L1ZQCAGXaSN45y3Hxc=;
 b=N3IaJQ/nz/RkRj03ucdxY+ZYqNyWCBYU3T73ovYZqCxrLMuOLEAKTTH+r45w3aY92JgTiT
 utBMAZnUNNER52l4Df2uPoy9JrADucOql85c6WpkkvtktCKveo1mdsrEStqQKRaOrzsMjQ
 Voj0vqwzrii4K4H5GhrvatVVvsN1Kgc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697639322;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z5n3VCOIG1/lAD6HoR2Xafic/L1ZQCAGXaSN45y3Hxc=;
 b=FxyKyp+sw6lvOrtK++mtCeulMhLt8bBOUkCDbjiOI9EsSkkJ9e0sihg91Ks1gWjKlda28h
 lgOEzcgjVto2/fCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4CF9013780;
 Wed, 18 Oct 2023 14:28:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id iyz0BprrL2XfWAAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 18 Oct 2023 14:28:42 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Het Gala <het.gala@nutanix.com>, qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
Subject: Re: [PATCH v13 00/10] migration: Modify 'migrate' and
 'migrate-incoming' QAPI commands for migration
In-Reply-To: <9c263a67-4971-418a-a3f7-95998491fb8f@nutanix.com>
References: <20231012151052.154106-1-het.gala@nutanix.com>
 <9c263a67-4971-418a-a3f7-95998491fb8f@nutanix.com>
Date: Wed, 18 Oct 2023 11:28:39 -0300
Message-ID: <87h6modmy0.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -7.10
X-Spamd-Result: default: False [-7.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_SEVEN(0.00)[11];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=195.135.220.29; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Het Gala <het.gala@nutanix.com> writes:

> Fabiano, would your below commits impact this patchset 'make check' 
> tests ? Because you have added tests for file based migration, which is 
> still not included in this patchset.

AFAICS, the tests shouldn't break.

> tests/qtest: migration-test: Add tests for file-based migration
> tests/qtest/migration: Add a test for the analyze-migration script
>
> I have tried to address all the g_autoptr() issues observed eariler, and 
> make check tests failing as a result. All the tests were passing (even 
> -qcow2 181) when the patch was posted for review. What can be the next 
> steps here for us? Do we need to add support for file based migration in 
> these patches or as you said eariler, you will introduce those patches 
> on top of my patches. Please let me know.

Right, your series is next on my queue for reviewing. I'll get to it
soon.

Here's what I was intending to send on top of it:

-->8--
From 0fc533989366a1a1e19737916d65938f64426c9b Mon Sep 17 00:00:00 2001
From: Fabiano Rosas <farosas@suse.de>
Date: Tue, 10 Oct 2023 11:01:32 -0300
Subject: [PATCH] migration: Convert the file transport to new migration api

Convert the file: URI to support the new QAPI syntax.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/file.c      | 22 +++++++---------------
 migration/file.h      |  8 ++++++--
 migration/migration.c | 17 +++++++++++------
 qapi/migration.json   | 20 ++++++++++++++++++--
 4 files changed, 42 insertions(+), 25 deletions(-)

diff --git a/migration/file.c b/migration/file.c
index cf5b1bf365..e67c81dd2c 100644
--- a/migration/file.c
+++ b/migration/file.c
@@ -19,7 +19,7 @@
 
 /* Remove the offset option from @filespec and return it in @offsetp. */
 
-static int file_parse_offset(char *filespec, uint64_t *offsetp, Error **errp)
+int file_parse_offset(char *filespec, uint64_t *offsetp, Error **errp)
 {
     char *option = strstr(filespec, OFFSET_OPTION);
     int ret;
@@ -36,20 +36,16 @@ static int file_parse_offset(char *filespec, uint64_t *offsetp, Error **errp)
     return 0;
 }
 
-void file_start_outgoing_migration(MigrationState *s, const char *filespec,
+void file_start_outgoing_migration(MigrationState *s, FileMigrationArgs *file_args,
                                    Error **errp)
 {
-    g_autofree char *filename = g_strdup(filespec);
     g_autoptr(QIOChannelFile) fioc = NULL;
-    uint64_t offset = 0;
+    g_autofree char *filename = g_strdup(file_args->path);
+    uint64_t offset = file_args->offset;
     QIOChannel *ioc;
 
     trace_migration_file_outgoing(filename);
 
-    if (file_parse_offset(filename, &offset, errp)) {
-        return;
-    }
-
     fioc = qio_channel_file_new_path(filename, O_CREAT | O_WRONLY | O_TRUNC,
                                      0600, errp);
     if (!fioc) {
@@ -73,19 +69,15 @@ static gboolean file_accept_incoming_migration(QIOChannel *ioc,
     return G_SOURCE_REMOVE;
 }
 
-void file_start_incoming_migration(const char *filespec, Error **errp)
+void file_start_incoming_migration(FileMigrationArgs *file_args, Error **errp)
 {
-    g_autofree char *filename = g_strdup(filespec);
+    g_autofree char *filename = g_strdup(file_args->path);
     QIOChannelFile *fioc = NULL;
-    uint64_t offset = 0;
+    uint64_t offset = file_args->offset;
     QIOChannel *ioc;
 
     trace_migration_file_incoming(filename);
 
-    if (file_parse_offset(filename, &offset, errp)) {
-        return;
-    }
-
     fioc = qio_channel_file_new_path(filename, O_RDONLY, 0, errp);
     if (!fioc) {
         return;
diff --git a/migration/file.h b/migration/file.h
index 90fa4849e0..155f6aab45 100644
--- a/migration/file.h
+++ b/migration/file.h
@@ -7,8 +7,12 @@
 
 #ifndef QEMU_MIGRATION_FILE_H
 #define QEMU_MIGRATION_FILE_H
-void file_start_incoming_migration(const char *filename, Error **errp);
 
-void file_start_outgoing_migration(MigrationState *s, const char *filename,
+#include "qapi/qapi-types-migration.h"
+
+void file_start_incoming_migration(FileMigrationArgs *file_args, Error **errp);
+
+void file_start_outgoing_migration(MigrationState *s, FileMigrationArgs *file_args,
                                    Error **errp);
+int file_parse_offset(char *filespec, uint64_t *offsetp, Error **errp);
 #endif
diff --git a/migration/migration.c b/migration/migration.c
index a651106bff..0b07b7343b 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -468,6 +468,13 @@ bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
         }
         addr->u.socket.type = saddr->type;
         addr->u.socket.u = saddr->u;
+    } else if (strstart(uri, "file:", NULL)) {
+        addr->transport = MIGRATION_ADDRESS_TYPE_FILE;
+        addr->u.file.path = g_strdup(uri + strlen("file:"));
+        if (file_parse_offset(addr->u.file.path, &addr->u.file.offset, errp)) {
+            g_free(addr->u.file.path);
+            return false;
+        }
     } else {
         error_setg(errp, "unknown migration protocol: %s", uri);
         return false;
@@ -483,7 +490,6 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
                                           MigrationChannelList *channels,
                                           Error **errp)
 {
-    const char *p = NULL;
     MigrationChannel *channel = NULL;
     MigrationAddress *addr = NULL;
 
@@ -535,8 +541,8 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
  #endif
     } else if (addr->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
         exec_start_incoming_migration(addr->u.exec.args, errp);
-    } else if (strstart(uri, "file:", &p)) {
-        file_start_incoming_migration(p, errp);
+    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_FILE) {
+        file_start_incoming_migration(&addr->u.file, errp);
     } else {
         error_setg(errp, "unknown migration protocol: %s", uri);
     }
@@ -1760,7 +1766,6 @@ void qmp_migrate(const char *uri, bool has_channels,
     bool resume_requested;
     Error *local_err = NULL;
     MigrationState *s = migrate_get_current();
-    const char *p = NULL;
     MigrationChannel *channel = NULL;
     MigrationAddress *addr = NULL;
 
@@ -1824,8 +1829,8 @@ void qmp_migrate(const char *uri, bool has_channels,
 #endif
     } else if (addr->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
         exec_start_outgoing_migration(s, addr->u.exec.args, &local_err);
-    } else if (strstart(uri, "file:", &p)) {
-        file_start_outgoing_migration(s, p, &local_err);
+    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_FILE) {
+        file_start_outgoing_migration(s, &addr->u.file, &local_err);
     } else {
         error_setg(&local_err, QERR_INVALID_PARAMETER_VALUE, "uri",
                    "a valid migration protocol");
diff --git a/qapi/migration.json b/qapi/migration.json
index 7b84c04617..bb0639b9d6 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1489,10 +1489,25 @@
 #
 # @rdma: Migrate via RDMA.
 #
+# @file: Direct the migration stream to a file.
+#
 # Since 8.2
 ##
 { 'enum': 'MigrationAddressType',
-  'data': ['socket', 'exec', 'rdma'] }
+  'data': ['socket', 'exec', 'rdma', 'file'] }
+
+##
+# @FileMigrationArgs:
+#
+# @path: file path
+#
+# @offset: initial offset for the file
+#
+# Since 8.2
+##
+{ 'struct': 'FileMigrationArgs',
+  'data': {'path': 'str',
+           'offset': 'uint64' } }
 
 ##
 # @MigrationExecCommand:
@@ -1517,7 +1532,8 @@
   'data': {
     'socket': 'SocketAddress',
     'exec': 'MigrationExecCommand',
-    'rdma': 'InetSocketAddress' } }
+    'rdma': 'InetSocketAddress',
+    'file': 'FileMigrationArgs' } }
 
 ##
 # @MigrationChannelType:
-- 
2.35.3


