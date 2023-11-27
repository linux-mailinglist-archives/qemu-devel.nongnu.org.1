Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D23427FAB85
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 21:29:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7iBZ-0002RN-GS; Mon, 27 Nov 2023 15:26:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r7iBX-0002R0-Ql
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 15:26:27 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r7iBW-0002jB-AR
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 15:26:27 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3826221B2A;
 Mon, 27 Nov 2023 20:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1701116785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3xOfyGHNhjnJWHtphQ8OBnaMWdX1lLvdQcv8Sfp7HSk=;
 b=TuhxSYxvuEisI/0gsD2kC1SGn61bofQ+zXkX2oXfcc0Oc1OAkP60rbbz3wRTsub9Aw3y60
 ssqCTWV+gx2xwHDnTLoRX1U/Ve1LkukctDVLO5E6b6LF/N32inPwDFvhGUUI7fofqIoJQE
 By5wq7OKKhx4pdgJ4iedBbS0Q8dbgAM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1701116785;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3xOfyGHNhjnJWHtphQ8OBnaMWdX1lLvdQcv8Sfp7HSk=;
 b=sfcvA5hRqeMK9EYcFqdKNyCwTFZbXzuLTJVS9YyAkoRiWRhB81Q3H8zGWwmVbD/sb2v0ft
 Dy36n4hgOvLc0wBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E07DB1379A;
 Mon, 27 Nov 2023 20:26:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CCEhKW77ZGVfIQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 27 Nov 2023 20:26:22 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>,
 Nikolay Borisov <nborisov@suse.com>
Subject: [RFC PATCH v3 03/30] io: implement io_pwritev/preadv for
 QIOChannelFile
Date: Mon, 27 Nov 2023 17:25:45 -0300
Message-Id: <20231127202612.23012-4-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231127202612.23012-1-farosas@suse.de>
References: <20231127202612.23012-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: 3.87
X-Spamd-Result: default: False [3.87 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_SEVEN(0.00)[8]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.03)[55.67%]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

The upcoming 'fixed-ram' feature will require qemu to write data to
(and restore from) specific offsets of the migration file.

Add a minimal implementation of pwritev/preadv and expose them via the
io_pwritev and io_preadv interfaces.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
- check CONFIG_PREADV to avoid breaking Windows
---
 io/channel-file.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/io/channel-file.c b/io/channel-file.c
index f91bf6db1c..a6ad7770c6 100644
--- a/io/channel-file.c
+++ b/io/channel-file.c
@@ -146,6 +146,58 @@ static ssize_t qio_channel_file_writev(QIOChannel *ioc,
     return ret;
 }
 
+#ifdef CONFIG_PREADV
+static ssize_t qio_channel_file_preadv(QIOChannel *ioc,
+                                       const struct iovec *iov,
+                                       size_t niov,
+                                       off_t offset,
+                                       Error **errp)
+{
+    QIOChannelFile *fioc = QIO_CHANNEL_FILE(ioc);
+    ssize_t ret;
+
+ retry:
+    ret = preadv(fioc->fd, iov, niov, offset);
+    if (ret < 0) {
+        if (errno == EAGAIN) {
+            return QIO_CHANNEL_ERR_BLOCK;
+        }
+        if (errno == EINTR) {
+            goto retry;
+        }
+
+        error_setg_errno(errp, errno, "Unable to read from file");
+        return -1;
+    }
+
+    return ret;
+}
+
+static ssize_t qio_channel_file_pwritev(QIOChannel *ioc,
+                                        const struct iovec *iov,
+                                        size_t niov,
+                                        off_t offset,
+                                        Error **errp)
+{
+    QIOChannelFile *fioc = QIO_CHANNEL_FILE(ioc);
+    ssize_t ret;
+
+ retry:
+    ret = pwritev(fioc->fd, iov, niov, offset);
+    if (ret <= 0) {
+        if (errno == EAGAIN) {
+            return QIO_CHANNEL_ERR_BLOCK;
+        }
+        if (errno == EINTR) {
+            goto retry;
+        }
+        error_setg_errno(errp, errno, "Unable to write to file");
+        return -1;
+    }
+    return ret;
+}
+#endif /* CONFIG_PREADV */
+
 static int qio_channel_file_set_blocking(QIOChannel *ioc,
                                          bool enabled,
                                          Error **errp)
@@ -231,6 +283,10 @@ static void qio_channel_file_class_init(ObjectClass *klass,
     ioc_klass->io_writev = qio_channel_file_writev;
     ioc_klass->io_readv = qio_channel_file_readv;
     ioc_klass->io_set_blocking = qio_channel_file_set_blocking;
+#ifdef CONFIG_PREADV
+    ioc_klass->io_pwritev = qio_channel_file_pwritev;
+    ioc_klass->io_preadv = qio_channel_file_preadv;
+#endif
     ioc_klass->io_seek = qio_channel_file_seek;
     ioc_klass->io_close = qio_channel_file_close;
     ioc_klass->io_create_watch = qio_channel_file_create_watch;
-- 
2.35.3


