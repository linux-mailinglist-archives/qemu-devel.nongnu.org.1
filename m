Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D14537FAB91
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 21:31:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7iC8-0002jt-Jd; Mon, 27 Nov 2023 15:27:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r7iC5-0002hv-M6
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 15:27:01 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r7iC3-0002oG-UW
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 15:27:01 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6D54221B32;
 Mon, 27 Nov 2023 20:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1701116818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/195pm8KQkPAf9kNkJxFoF+O8UtxYL5GHt4E5CxVLQc=;
 b=Ay2OKCv0GHxhRKCV2ShZGY1Syhsc7V4PN9qt5QpRUqN9/CsmuzVJBs92pxTfwJ9F9D5G2n
 bM1qg2tlC/3MArFtwf6jYVXb0UzwljCVw0sSzCzrz6raBK08L25AfDeIQy1BDHqT6Fdu3X
 gRyTFaMK+J1rnvp0k05rsa7Pbo+a0xU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1701116818;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/195pm8KQkPAf9kNkJxFoF+O8UtxYL5GHt4E5CxVLQc=;
 b=IWQ6YkiKdCNrpJzEZwALTwDMN6jX86dUxdzKJ0oqMgn49WZjK0uvoDl3rPPd3bxoRmBOVF
 yrMD66DWUrAdyfAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5B48F1379A;
 Mon, 27 Nov 2023 20:26:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yP6oCJD7ZGVfIQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 27 Nov 2023 20:26:56 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>
Subject: [RFC PATCH v3 15/30] io: Add a pwritev/preadv version that takes a
 discontiguous iovec
Date: Mon, 27 Nov 2023 17:25:57 -0300
Message-Id: <20231127202612.23012-16-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231127202612.23012-1-farosas@suse.de>
References: <20231127202612.23012-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: 0.90
X-Spamd-Result: default: False [0.90 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_SEVEN(0.00)[7]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

For the upcoming support to fixed-ram migration with multifd, we need
to be able to accept an iovec array with non-contiguous data.

Add a pwritev and preadv version that splits the array into contiguous
segments before writing. With that we can have the ram code continue
to add pages in any order and the multifd code continue to send large
arrays for reading and writing.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
- split the API that was merged into a single function
- use uintptr_t for compatibility with 32-bit
---
 include/io/channel.h | 26 ++++++++++++++++
 io/channel.c         | 70 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 96 insertions(+)

diff --git a/include/io/channel.h b/include/io/channel.h
index 7986c49c71..25383db5aa 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -559,6 +559,19 @@ int qio_channel_close(QIOChannel *ioc,
 ssize_t qio_channel_pwritev(QIOChannel *ioc, const struct iovec *iov,
                             size_t niov, off_t offset, Error **errp);
 
+/**
+ * qio_channel_pwritev_all:
+ * @ioc: the channel object
+ * @iov: the array of memory regions to write data from
+ * @niov: the length of the @iov array
+ * @offset: the iovec offset in the file where to write the data
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Returns: 0 if all bytes were written, or -1 on error
+ */
+int qio_channel_pwritev_all(QIOChannel *ioc, const struct iovec *iov,
+                            size_t niov, off_t offset, Error **errp);
+
 /**
  * qio_channel_pwrite
  * @ioc: the channel object
@@ -595,6 +608,19 @@ ssize_t qio_channel_pwrite(QIOChannel *ioc, char *buf, size_t buflen,
 ssize_t qio_channel_preadv(QIOChannel *ioc, const struct iovec *iov,
                            size_t niov, off_t offset, Error **errp);
 
+/**
+ * qio_channel_preadv_all:
+ * @ioc: the channel object
+ * @iov: the array of memory regions to read data to
+ * @niov: the length of the @iov array
+ * @offset: the iovec offset in the file from where to read the data
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Returns: 0 if all bytes were read, or -1 on error
+ */
+int qio_channel_preadv_all(QIOChannel *ioc, const struct iovec *iov,
+                           size_t niov, off_t offset, Error **errp);
+
 /**
  * qio_channel_pread
  * @ioc: the channel object
diff --git a/io/channel.c b/io/channel.c
index a1f12f8e90..2f1745d052 100644
--- a/io/channel.c
+++ b/io/channel.c
@@ -472,6 +472,69 @@ ssize_t qio_channel_pwritev(QIOChannel *ioc, const struct iovec *iov,
     return klass->io_pwritev(ioc, iov, niov, offset, errp);
 }
 
+static int qio_channel_preadv_pwritev_contiguous(QIOChannel *ioc,
+                                                 const struct iovec *iov,
+                                                 size_t niov, off_t offset,
+                                                 bool is_write, Error **errp)
+{
+    ssize_t ret = -1;
+    int i, slice_idx, slice_num;
+    uintptr_t base, next, file_offset;
+    size_t len;
+
+    slice_idx = 0;
+    slice_num = 1;
+
+    /*
+     * If the iov array doesn't have contiguous elements, we need to
+     * split it in slices because we only have one (file) 'offset' for
+     * the whole iov. Do this here so callers don't need to break the
+     * iov array themselves.
+     */
+    for (i = 0; i < niov; i++, slice_num++) {
+        base = (uintptr_t) iov[i].iov_base;
+
+        if (i != niov - 1) {
+            len = iov[i].iov_len;
+            next = (uintptr_t) iov[i + 1].iov_base;
+
+            if (base + len == next) {
+                continue;
+            }
+        }
+
+        /*
+         * Use the offset of the first element of the segment that
+         * we're sending.
+         */
+        file_offset = offset + (uintptr_t) iov[slice_idx].iov_base;
+
+        if (is_write) {
+            ret = qio_channel_pwritev(ioc, &iov[slice_idx], slice_num,
+                                      file_offset, errp);
+        } else {
+            ret = qio_channel_preadv(ioc, &iov[slice_idx], slice_num,
+                                     file_offset, errp);
+        }
+
+        if (ret < 0) {
+            break;
+        }
+
+        slice_idx += slice_num;
+        slice_num = 0;
+    }
+
+    return (ret < 0) ? -1 : 0;
+}
+
+int qio_channel_pwritev_all(QIOChannel *ioc, const struct iovec *iov,
+                            size_t niov, off_t offset, Error **errp)
+{
+    return qio_channel_preadv_pwritev_contiguous(ioc, iov, niov,
+                                                 offset, true, errp);
+}
+
 ssize_t qio_channel_pwrite(QIOChannel *ioc, char *buf, size_t buflen,
                            off_t offset, Error **errp)
 {
@@ -501,6 +564,13 @@ ssize_t qio_channel_preadv(QIOChannel *ioc, const struct iovec *iov,
     return klass->io_preadv(ioc, iov, niov, offset, errp);
 }
 
+int qio_channel_preadv_all(QIOChannel *ioc, const struct iovec *iov,
+                           size_t niov, off_t offset, Error **errp)
+{
+    return qio_channel_preadv_pwritev_contiguous(ioc, iov, niov,
+                                                 offset, false, errp);
+}
+
 ssize_t qio_channel_pread(QIOChannel *ioc, char *buf, size_t buflen,
                           off_t offset, Error **errp)
 {
-- 
2.35.3


