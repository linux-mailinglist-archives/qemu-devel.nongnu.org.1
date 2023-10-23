Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2AB7D3F14
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 20:22:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quzYU-0004H2-GS; Mon, 23 Oct 2023 14:21:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1quzYS-0004F3-5x
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:21:32 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1quzYQ-0001DK-HM
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:21:31 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 56D651FE2F;
 Mon, 23 Oct 2023 18:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698085289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ReqItBZkywcU+Yf4VIMAFHyP1dTE5vJ4ykBLv4YOZLY=;
 b=ePrIX7k8iYkrblMMY72ZJTgRfKhFTxiMmOknqtTLRWzwzk9RtmNfiN33ju0elXTZLrlE+d
 +x/XGov840toU1VYP6+mk1+qF2ES21mwJpzBCdMDvFOgnfqRwE4Vwq/NW1ZvTgLpJdaXB7
 2l+PSylNOb1GhIX78/+A/r45fmqYHGg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698085289;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ReqItBZkywcU+Yf4VIMAFHyP1dTE5vJ4ykBLv4YOZLY=;
 b=//ihfuWINZqemH1eQn2Vvvn1Dnetx2mHgrPUhL18sO7QJuBYIcRMtdPXbglIMmbQzEiVJo
 jRp5vQH2RZPZ0dCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 03977132FD;
 Mon, 23 Oct 2023 18:21:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id OEiHL6W5NmX8ZwAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 23 Oct 2023 18:21:25 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, dgilbert@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, armbru@redhat.com, eblake@redhat.com,
 manish.mishra@nutanix.com, aravind.retnakaran@nutanix.com,
 Het Gala <het.gala@nutanix.com>, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>
Subject: [PATCH v15 08/14] migration: Convert the file backend to the new QAPI
 syntax
Date: Mon, 23 Oct 2023 15:20:47 -0300
Message-Id: <20231023182053.8711-9-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231023182053.8711-1-farosas@suse.de>
References: <20231023182053.8711-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -2.10
X-Spamd-Result: default: False [-2.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_TWELVE(0.00)[13];
 MID_CONTAINS_FROM(1.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
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

Convert the file: URI to accept a FileMigrationArgs to be compatible
with the new migration QAPI.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/file.c      | 22 +++++++---------------
 migration/file.h      |  9 ++++++---
 migration/migration.c | 10 ++++------
 3 files changed, 17 insertions(+), 24 deletions(-)

diff --git a/migration/file.c b/migration/file.c
index ec069ef329..5d4975f43e 100644
--- a/migration/file.c
+++ b/migration/file.c
@@ -36,20 +36,16 @@ int file_parse_offset(char *filespec, uint64_t *offsetp, Error **errp)
     return 0;
 }
 
-void file_start_outgoing_migration(MigrationState *s, const char *filespec,
-                                   Error **errp)
+void file_start_outgoing_migration(MigrationState *s,
+                                   FileMigrationArgs *file_args, Error **errp)
 {
-    g_autofree char *filename = g_strdup(filespec);
     g_autoptr(QIOChannelFile) fioc = NULL;
-    uint64_t offset = 0;
+    g_autofree char *filename = g_strdup(file_args->filename);
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
+    g_autofree char *filename = g_strdup(file_args->filename);
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
index 3888a57105..37d6a08bfc 100644
--- a/migration/file.h
+++ b/migration/file.h
@@ -7,9 +7,12 @@
 
 #ifndef QEMU_MIGRATION_FILE_H
 #define QEMU_MIGRATION_FILE_H
-void file_start_incoming_migration(const char *filename, Error **errp);
 
-void file_start_outgoing_migration(MigrationState *s, const char *filename,
-                                   Error **errp);
+#include "qapi/qapi-types-migration.h"
+
+void file_start_incoming_migration(FileMigrationArgs *file_args, Error **errp);
+
+void file_start_outgoing_migration(MigrationState *s,
+                                   FileMigrationArgs *file_args, Error **errp);
 int file_parse_offset(char *filespec, uint64_t *offsetp, Error **errp);
 #endif
diff --git a/migration/migration.c b/migration/migration.c
index b9ca257c6c..c8b50b1dd5 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -483,7 +483,6 @@ static bool migrate_uri_parse(const char *uri,
 
 static void qemu_start_incoming_migration(const char *uri, Error **errp)
 {
-    const char *p = NULL;
     g_autoptr(MigrationAddress) channel = NULL;
     MigrationIncomingState *mis = migration_incoming_get_current();
 
@@ -526,8 +525,8 @@ static void qemu_start_incoming_migration(const char *uri, Error **errp)
 #endif
     } else if (channel->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
         exec_start_incoming_migration(channel->u.exec.args, errp);
-    } else if (strstart(uri, "file:", &p)) {
-        file_start_incoming_migration(p, errp);
+    } else if (channel->transport == MIGRATION_ADDRESS_TYPE_FILE) {
+        file_start_incoming_migration(&channel->u.file, errp);
     } else {
         error_setg(errp, "unknown migration protocol: %s", uri);
     }
@@ -1765,7 +1764,6 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
     bool resume_requested;
     Error *local_err = NULL;
     MigrationState *s = migrate_get_current();
-    const char *p = NULL;
     g_autoptr(MigrationAddress) channel = NULL;
 
     /* URI is not suitable for migration? */
@@ -1805,8 +1803,8 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
 #endif
     } else if (channel->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
         exec_start_outgoing_migration(s, channel->u.exec.args, &local_err);
-    } else if (strstart(uri, "file:", &p)) {
-        file_start_outgoing_migration(s, p, &local_err);
+    } else if (channel->transport == MIGRATION_ADDRESS_TYPE_FILE) {
+        file_start_outgoing_migration(s, &channel->u.file, &local_err);
     } else {
         error_setg(&local_err, QERR_INVALID_PARAMETER_VALUE, "uri",
                    "a valid migration protocol");
-- 
2.35.3


