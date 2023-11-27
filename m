Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 782317FAB51
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 21:26:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7iBY-0002Qz-4t; Mon, 27 Nov 2023 15:26:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r7iBW-0002QO-A2
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 15:26:26 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r7iBU-0002hY-F6
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 15:26:26 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6C6E91FB79;
 Mon, 27 Nov 2023 20:26:22 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1FD631379A;
 Mon, 27 Nov 2023 20:26:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yPXUNWv7ZGVfIQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 27 Nov 2023 20:26:19 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>,
 Nikolay Borisov <nborisov@suse.com>
Subject: [RFC PATCH v3 02/30] io: Add generic pwritev/preadv interface
Date: Mon, 27 Nov 2023 17:25:44 -0300
Message-Id: <20231127202612.23012-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231127202612.23012-1-farosas@suse.de>
References: <20231127202612.23012-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++++
Authentication-Results: smtp-out2.suse.de; dkim=none;
 dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.de
 (policy=none); 
 spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:97 is neither
 permitted nor denied by domain of farosas@suse.de)
 smtp.mailfrom=farosas@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [7.79 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; R_MISSING_CHARSET(2.50)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 R_SPF_SOFTFAIL(4.60)[~all:c]; NEURAL_HAM_LONG(-1.00)[-0.996];
 RCVD_COUNT_THREE(0.00)[3]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[8]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 R_DKIM_NA(2.20)[]; MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%];
 DMARC_POLICY_SOFTFAIL(0.10)[suse.de : No valid SPF, No valid DKIM,none]
X-Spam-Score: 7.79
X-Rspamd-Queue-Id: 6C6E91FB79
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

From: Nikolay Borisov <nborisov@suse.com>

Introduce basic pwritev/preadv support in the generic channel layer.
Specific implementation will follow for the file channel as this is
required in order to support migration streams with fixed location of
each ram page.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
- fixed naming: s/pwritev_full/pwritev
---
 include/io/channel.h | 82 ++++++++++++++++++++++++++++++++++++++++++++
 io/channel.c         | 58 +++++++++++++++++++++++++++++++
 2 files changed, 140 insertions(+)

diff --git a/include/io/channel.h b/include/io/channel.h
index fcb19fd672..7986c49c71 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -131,6 +131,16 @@ struct QIOChannelClass {
                            Error **errp);
 
     /* Optional callbacks */
+    ssize_t (*io_pwritev)(QIOChannel *ioc,
+                          const struct iovec *iov,
+                          size_t niov,
+                          off_t offset,
+                          Error **errp);
+    ssize_t (*io_preadv)(QIOChannel *ioc,
+                         const struct iovec *iov,
+                         size_t niov,
+                         off_t offset,
+                         Error **errp);
     int (*io_shutdown)(QIOChannel *ioc,
                        QIOChannelShutdown how,
                        Error **errp);
@@ -529,6 +539,78 @@ void qio_channel_set_follow_coroutine_ctx(QIOChannel *ioc, bool enabled);
 int qio_channel_close(QIOChannel *ioc,
                       Error **errp);
 
+/**
+ * qio_channel_pwritev
+ * @ioc: the channel object
+ * @iov: the array of memory regions to write data from
+ * @niov: the length of the @iov array
+ * @offset: offset in the channel where writes should begin
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Not all implementations will support this facility, so may report
+ * an error. To avoid errors, the caller may check for the feature
+ * flag QIO_CHANNEL_FEATURE_SEEKABLE prior to calling this method.
+ *
+ * Behaves as qio_channel_writev_full, apart from not supporting
+ * sending of file handles as well as beginning the write at the
+ * passed @offset
+ *
+ */
+ssize_t qio_channel_pwritev(QIOChannel *ioc, const struct iovec *iov,
+                            size_t niov, off_t offset, Error **errp);
+
+/**
+ * qio_channel_pwrite
+ * @ioc: the channel object
+ * @buf: the memory region to write data into
+ * @buflen: the number of bytes to @buf
+ * @offset: offset in the channel where writes should begin
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Not all implementations will support this facility, so may report
+ * an error. To avoid errors, the caller may check for the feature
+ * flag QIO_CHANNEL_FEATURE_SEEKABLE prior to calling this method.
+ *
+ */
+ssize_t qio_channel_pwrite(QIOChannel *ioc, char *buf, size_t buflen,
+                           off_t offset, Error **errp);
+
+/**
+ * qio_channel_preadv
+ * @ioc: the channel object
+ * @iov: the array of memory regions to read data into
+ * @niov: the length of the @iov array
+ * @offset: offset in the channel where writes should begin
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Not all implementations will support this facility, so may report
+ * an error.  To avoid errors, the caller may check for the feature
+ * flag QIO_CHANNEL_FEATURE_SEEKABLE prior to calling this method.
+ *
+ * Behaves as qio_channel_readv_full, apart from not supporting
+ * receiving of file handles as well as beginning the read at the
+ * passed @offset
+ *
+ */
+ssize_t qio_channel_preadv(QIOChannel *ioc, const struct iovec *iov,
+                           size_t niov, off_t offset, Error **errp);
+
+/**
+ * qio_channel_pread
+ * @ioc: the channel object
+ * @buf: the memory region to write data into
+ * @buflen: the number of bytes to @buf
+ * @offset: offset in the channel where writes should begin
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Not all implementations will support this facility, so may report
+ * an error.  To avoid errors, the caller may check for the feature
+ * flag QIO_CHANNEL_FEATURE_SEEKABLE prior to calling this method.
+ *
+ */
+ssize_t qio_channel_pread(QIOChannel *ioc, char *buf, size_t buflen,
+                          off_t offset, Error **errp);
+
 /**
  * qio_channel_shutdown:
  * @ioc: the channel object
diff --git a/io/channel.c b/io/channel.c
index 86c5834510..a1f12f8e90 100644
--- a/io/channel.c
+++ b/io/channel.c
@@ -454,6 +454,64 @@ GSource *qio_channel_add_watch_source(QIOChannel *ioc,
 }
 
 
+ssize_t qio_channel_pwritev(QIOChannel *ioc, const struct iovec *iov,
+                            size_t niov, off_t offset, Error **errp)
+{
+    QIOChannelClass *klass = QIO_CHANNEL_GET_CLASS(ioc);
+
+    if (!klass->io_pwritev) {
+        error_setg(errp, "Channel does not support pwritev");
+        return -1;
+    }
+
+    if (!qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_SEEKABLE)) {
+        error_setg_errno(errp, EINVAL, "Requested channel is not seekable");
+        return -1;
+    }
+
+    return klass->io_pwritev(ioc, iov, niov, offset, errp);
+}
+
+ssize_t qio_channel_pwrite(QIOChannel *ioc, char *buf, size_t buflen,
+                           off_t offset, Error **errp)
+{
+    struct iovec iov = {
+        .iov_base = buf,
+        .iov_len = buflen
+    };
+
+    return qio_channel_pwritev(ioc, &iov, 1, offset, errp);
+}
+
+ssize_t qio_channel_preadv(QIOChannel *ioc, const struct iovec *iov,
+                           size_t niov, off_t offset, Error **errp)
+{
+    QIOChannelClass *klass = QIO_CHANNEL_GET_CLASS(ioc);
+
+    if (!klass->io_preadv) {
+        error_setg(errp, "Channel does not support preadv");
+        return -1;
+    }
+
+    if (!qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_SEEKABLE)) {
+        error_setg_errno(errp, EINVAL, "Requested channel is not seekable");
+        return -1;
+    }
+
+    return klass->io_preadv(ioc, iov, niov, offset, errp);
+}
+
+ssize_t qio_channel_pread(QIOChannel *ioc, char *buf, size_t buflen,
+                          off_t offset, Error **errp)
+{
+    struct iovec iov = {
+        .iov_base = buf,
+        .iov_len = buflen
+    };
+
+    return qio_channel_preadv(ioc, &iov, 1, offset, errp);
+}
+
 int qio_channel_shutdown(QIOChannel *ioc,
                          QIOChannelShutdown how,
                          Error **errp)
-- 
2.35.3


