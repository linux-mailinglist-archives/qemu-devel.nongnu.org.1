Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 444C68CDA77
	for <lists+qemu-devel@lfdr.de>; Thu, 23 May 2024 21:08:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sADmL-0002WZ-VT; Thu, 23 May 2024 15:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sADlq-0002Fi-Sj
 for qemu-devel@nongnu.org; Thu, 23 May 2024 15:06:35 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sADle-0004Jc-3U
 for qemu-devel@nongnu.org; Thu, 23 May 2024 15:06:34 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A779E22B7B;
 Thu, 23 May 2024 19:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716491180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8VFeZYA/tlbO8xdmHq8foYs81r9KIVu31YTivWBguyo=;
 b=McewFK8zqbiOSLaFbb/jo9OJatCvG/ll9gXipuNvt/yCHNqDWtIy7s0fUJOERguHusBtFQ
 BoyNJN+YPJpxEUXfX1/e295eMnYv2W4xce2kMMaQ90ulQfsir4Bj+xZr935ZHVG/CawsrX
 hQZL5qijfC3174EMeHI+eRgvCSfta4I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716491180;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8VFeZYA/tlbO8xdmHq8foYs81r9KIVu31YTivWBguyo=;
 b=UwQBa7n20vpNieeDKwdwqliP4PcbQbyqW47EqDBsASpgHc9srvvY2zCNugRkH5bVU0tA0v
 LnXOqjSxFwVM3fDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=McewFK8z;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=UwQBa7n2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716491180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8VFeZYA/tlbO8xdmHq8foYs81r9KIVu31YTivWBguyo=;
 b=McewFK8zqbiOSLaFbb/jo9OJatCvG/ll9gXipuNvt/yCHNqDWtIy7s0fUJOERguHusBtFQ
 BoyNJN+YPJpxEUXfX1/e295eMnYv2W4xce2kMMaQ90ulQfsir4Bj+xZr935ZHVG/CawsrX
 hQZL5qijfC3174EMeHI+eRgvCSfta4I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716491180;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8VFeZYA/tlbO8xdmHq8foYs81r9KIVu31YTivWBguyo=;
 b=UwQBa7n20vpNieeDKwdwqliP4PcbQbyqW47EqDBsASpgHc9srvvY2zCNugRkH5bVU0tA0v
 LnXOqjSxFwVM3fDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D057C13A6B;
 Thu, 23 May 2024 19:06:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cE57JaqTT2bUEQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 23 May 2024 19:06:18 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>
Subject: [PATCH v2 11/18] migration/multifd: Add direct-io support
Date: Thu, 23 May 2024 16:05:41 -0300
Message-Id: <20240523190548.23977-12-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240523190548.23977-1-farosas@suse.de>
References: <20240523190548.23977-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A779E22B7B
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 RCPT_COUNT_FIVE(0.00)[6]; DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

When multifd is used along with mapped-ram, we can take benefit of a
filesystem that supports the O_DIRECT flag and perform direct I/O in
the multifd threads. This brings a significant performance improvement
because direct-io writes bypass the page cache which would otherwise
be thrashed by the multifd data which is unlikely to be needed again
in a short period of time.

To be able to use a multifd channel opened with O_DIRECT, we must
ensure that a certain aligment is used. Filesystems usually require a
block-size alignment for direct I/O. The way to achieve this is by
enabling the mapped-ram feature, which already aligns its I/O properly
(see MAPPED_RAM_FILE_OFFSET_ALIGNMENT at ram.c).

By setting O_DIRECT on the multifd channels, all writes to the same
file descriptor need to be aligned as well, even the ones that come
from outside multifd, such as the QEMUFile I/O from the main migration
code. This makes it impossible to use the same file descriptor for the
QEMUFile and for the multifd channels. The various flags and metadata
written by the main migration code will always be unaligned by virtue
of their small size. To workaround this issue, we'll require a second
file descriptor to be used exclusively for direct I/O.

The second file descriptor can be obtained by QEMU by re-opening the
migration file (already possible), or by being provided by the user or
management application (support to be added in future patches).

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/file.c      | 31 ++++++++++++++++++++++++++-----
 migration/file.h      |  1 -
 migration/migration.c | 23 +++++++++++++++++++++++
 3 files changed, 49 insertions(+), 6 deletions(-)

diff --git a/migration/file.c b/migration/file.c
index ba5b5c44ff..ac4d206492 100644
--- a/migration/file.c
+++ b/migration/file.c
@@ -50,12 +50,31 @@ void file_cleanup_outgoing_migration(void)
     outgoing_args.fname = NULL;
 }
 
+static void file_enable_direct_io(int *flags)
+{
+#ifdef O_DIRECT
+    if (migrate_direct_io()) {
+        *flags |= O_DIRECT;
+    }
+#else
+    /* it should have been rejected when setting the parameter */
+    g_assert_not_reached();
+#endif
+}
+
 bool file_send_channel_create(gpointer opaque, Error **errp)
 {
     QIOChannelFile *ioc;
     int flags = O_WRONLY;
     bool ret = true;
 
+    /*
+     * Attempt to enable O_DIRECT for the secondary channels. These
+     * are used for sending ram pages and writes should be guaranteed
+     * to be aligned to at least page size.
+     */
+    file_enable_direct_io(&flags);
+
     ioc = qio_channel_file_new_path(outgoing_args.fname, flags, 0, errp);
     if (!ioc) {
         ret = false;
@@ -116,21 +135,23 @@ static gboolean file_accept_incoming_migration(QIOChannel *ioc,
     return G_SOURCE_REMOVE;
 }
 
-void file_create_incoming_channels(QIOChannel *ioc, Error **errp)
+static void file_create_incoming_channels(QIOChannel *ioc, char *filename,
+                                          Error **errp)
 {
-    int i, fd, channels = 1;
+    int i, channels = 1;
     g_autofree QIOChannel **iocs = NULL;
+    int flags = O_RDONLY;
 
     if (migrate_multifd()) {
         channels += migrate_multifd_channels();
+        file_enable_direct_io(&flags);
     }
 
     iocs = g_new0(QIOChannel *, channels);
-    fd = QIO_CHANNEL_FILE(ioc)->fd;
     iocs[0] = ioc;
 
     for (i = 1; i < channels; i++) {
-        QIOChannelFile *fioc = qio_channel_file_new_dupfd(fd, errp);
+        QIOChannelFile *fioc = qio_channel_file_new_path(filename, flags, 0, errp);
 
         if (!fioc) {
             while (i) {
@@ -170,7 +191,7 @@ void file_start_incoming_migration(FileMigrationArgs *file_args, Error **errp)
         return;
     }
 
-    file_create_incoming_channels(QIO_CHANNEL(fioc), errp);
+    file_create_incoming_channels(QIO_CHANNEL(fioc), filename, errp);
 }
 
 int file_write_ramblock_iov(QIOChannel *ioc, const struct iovec *iov,
diff --git a/migration/file.h b/migration/file.h
index 7699c04677..9f71e87f74 100644
--- a/migration/file.h
+++ b/migration/file.h
@@ -20,7 +20,6 @@ void file_start_outgoing_migration(MigrationState *s,
 int file_parse_offset(char *filespec, uint64_t *offsetp, Error **errp);
 void file_cleanup_outgoing_migration(void);
 bool file_send_channel_create(gpointer opaque, Error **errp);
-void file_create_incoming_channels(QIOChannel *ioc, Error **errp);
 int file_write_ramblock_iov(QIOChannel *ioc, const struct iovec *iov,
                             int niov, RAMBlock *block, Error **errp);
 int multifd_file_recv_data(MultiFDRecvParams *p, Error **errp);
diff --git a/migration/migration.c b/migration/migration.c
index e1b269624c..e03c80b3aa 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -155,6 +155,16 @@ static bool migration_needs_seekable_channel(void)
     return migrate_mapped_ram();
 }
 
+static bool migration_needs_extra_fds(void)
+{
+    /*
+     * When doing direct-io, multifd requires two different,
+     * non-duplicated file descriptors so we can use one of them for
+     * unaligned IO.
+     */
+    return migrate_multifd() && migrate_direct_io();
+}
+
 static bool transport_supports_seeking(MigrationAddress *addr)
 {
     if (addr->transport == MIGRATION_ADDRESS_TYPE_FILE) {
@@ -164,6 +174,12 @@ static bool transport_supports_seeking(MigrationAddress *addr)
     return false;
 }
 
+static bool transport_supports_extra_fds(MigrationAddress *addr)
+{
+    /* file: works because QEMU can open it multiple times */
+    return addr->transport == MIGRATION_ADDRESS_TYPE_FILE;
+}
+
 static bool
 migration_channels_and_transport_compatible(MigrationAddress *addr,
                                             Error **errp)
@@ -180,6 +196,13 @@ migration_channels_and_transport_compatible(MigrationAddress *addr,
         return false;
     }
 
+    if (migration_needs_extra_fds() &&
+        !transport_supports_extra_fds(addr)) {
+        error_setg(errp,
+                   "Migration requires a transport that allows for extra fds (e.g. file)");
+        return false;
+    }
+
     return true;
 }
 
-- 
2.35.3


