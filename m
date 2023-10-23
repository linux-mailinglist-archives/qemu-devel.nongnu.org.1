Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3951B7D4121
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 22:41:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qv1g3-00040V-Ij; Mon, 23 Oct 2023 16:37:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qv1fq-0003iS-OG
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 16:37:20 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qv1fk-0001tS-K8
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 16:37:16 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 16A3621B25;
 Mon, 23 Oct 2023 20:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698093431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=91V6Vpi0EQg1XNaw6w4iigg8MpuDSYcENbFQ9e3PdNQ=;
 b=y8VvrYl34JVgIqeccYF0hf/fRSMxhoHtklftnfqbEG9vooDdamixRYGMU2RZ4H4BLw5b3i
 7VZFvTvCSn0mL2HLsQcoM+1o3Zjp0eo1luiLvX4o4S8eyvyJtMbfsgnhXnfKyqr9cQKWZy
 j3Ns6IQtzbtXdRiVbHE37mMRa6FM5g8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698093431;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=91V6Vpi0EQg1XNaw6w4iigg8MpuDSYcENbFQ9e3PdNQ=;
 b=0yBW5+qHEkO5VbeBNY8DQABmvDNeKFfYUKthL+Nz6/2pEKTlGlbtW/JPFMIFPU/6boUN4k
 sS4+OOumnmS+PGBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2B830132FD;
 Mon, 23 Oct 2023 20:37:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id KKTHOXTZNmV1JQAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 23 Oct 2023 20:37:08 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>
Subject: [PATCH v2 22/29] io: Add a pwritev/preadv version that takes a
 discontiguous iovec
Date: Mon, 23 Oct 2023 17:36:01 -0300
Message-Id: <20231023203608.26370-23-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231023203608.26370-1-farosas@suse.de>
References: <20231023203608.26370-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -2.10
X-Spamd-Result: default: False [-2.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_SEVEN(0.00)[7];
 MID_CONTAINS_FROM(1.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
Received-SPF: pass client-ip=195.135.220.28; envelope-from=farosas@suse.de;
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

For the upcoming support to fixed-ram migration with multifd, we need
to be able to accept an iovec array with non-contiguous data.

Add a pwritev and preadv version that splits the array into contiguous
segments before writing. With that we can have the ram code continue
to add pages in any order and the multifd code continue to send large
arrays for reading and writing.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
Since iovs can be non contiguous, we'd need a separate array on the
side to carry an extra file offset for each of them, so I'm relying on
the fact that iovs are all within a same host page and passing in an
encoded offset that takes the host page into account.
---
 include/io/channel.h | 50 +++++++++++++++++++++++++++
 io/channel.c         | 82 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 132 insertions(+)

diff --git a/include/io/channel.h b/include/io/channel.h
index a8181d576a..51a99fb9f6 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -33,8 +33,10 @@ OBJECT_DECLARE_TYPE(QIOChannel, QIOChannelClass,
 #define QIO_CHANNEL_ERR_BLOCK -2
 
 #define QIO_CHANNEL_WRITE_FLAG_ZERO_COPY 0x1
+#define QIO_CHANNEL_WRITE_FLAG_WITH_OFFSET 0x2
 
 #define QIO_CHANNEL_READ_FLAG_MSG_PEEK 0x1
+#define QIO_CHANNEL_READ_FLAG_WITH_OFFSET 0x2
 
 typedef enum QIOChannelFeature QIOChannelFeature;
 
@@ -559,6 +561,30 @@ int qio_channel_close(QIOChannel *ioc,
 ssize_t qio_channel_pwritev_full(QIOChannel *ioc, const struct iovec *iov,
                                  size_t niov, off_t offset, Error **errp);
 
+/**
+ * qio_channel_write_full_all:
+ * @ioc: the channel object
+ * @iov: the array of memory regions to write data from
+ * @niov: the length of the @iov array
+ * @offset: the iovec offset in the file where to write the data
+ * @fds: an array of file handles to send
+ * @nfds: number of file handles in @fds
+ * @flags: write flags (QIO_CHANNEL_WRITE_FLAG_*)
+ * @errp: pointer to a NULL-initialized error object
+ *
+ *
+ * Selects between a writev or pwritev channel writer function.
+ *
+ * If QIO_CHANNEL_WRITE_FLAG_OFFSET is passed in flags, pwritev is
+ * used and @offset is expected to be a meaningful value, @fds and
+ * @nfds are ignored; otherwise uses writev and @offset is ignored.
+ *
+ * Returns: 0 if all bytes were written, or -1 on error
+ */
+int qio_channel_write_full_all(QIOChannel *ioc, const struct iovec *iov,
+                               size_t niov, off_t offset, int *fds, size_t nfds,
+                               int flags, Error **errp);
+
 /**
  * qio_channel_pwritev
  * @ioc: the channel object
@@ -595,6 +621,30 @@ ssize_t qio_channel_pwritev(QIOChannel *ioc, char *buf, size_t buflen,
 ssize_t qio_channel_preadv_full(QIOChannel *ioc, const struct iovec *iov,
                                 size_t niov, off_t offset, Error **errp);
 
+/**
+ * qio_channel_read_full_all:
+ * @ioc: the channel object
+ * @iov: the array of memory regions to read data to
+ * @niov: the length of the @iov array
+ * @offset: the iovec offset in the file from where to read the data
+ * @fds: an array of file handles to send
+ * @nfds: number of file handles in @fds
+ * @flags: read flags (QIO_CHANNEL_READ_FLAG_*)
+ * @errp: pointer to a NULL-initialized error object
+ *
+ *
+ * Selects between a readv or preadv channel reader function.
+ *
+ * If QIO_CHANNEL_READ_FLAG_OFFSET is passed in flags, preadv is
+ * used and @offset is expected to be a meaningful value, @fds and
+ * @nfds are ignored; otherwise uses readv and @offset is ignored.
+ *
+ * Returns: 0 if all bytes were read, or -1 on error
+ */
+int qio_channel_read_full_all(QIOChannel *ioc, const struct iovec *iov,
+                              size_t niov, off_t offset,
+                              int flags, Error **errp);
+
 /**
  * qio_channel_preadv
  * @ioc: the channel object
diff --git a/io/channel.c b/io/channel.c
index 770d61ea00..648b68451d 100644
--- a/io/channel.c
+++ b/io/channel.c
@@ -472,6 +472,76 @@ ssize_t qio_channel_pwritev_full(QIOChannel *ioc, const struct iovec *iov,
     return klass->io_pwritev(ioc, iov, niov, offset, errp);
 }
 
+static int qio_channel_preadv_pwritev_contiguous(QIOChannel *ioc,
+                                                 const struct iovec *iov,
+                                                 size_t niov, off_t offset,
+                                                 bool is_write, Error **errp)
+{
+    ssize_t ret;
+    int i, slice_idx, slice_num;
+    uint64_t base, next, file_offset;
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
+        base = (uint64_t) iov[i].iov_base;
+
+        if (i != niov - 1) {
+            len = iov[i].iov_len;
+            next = (uint64_t) iov[i + 1].iov_base;
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
+        file_offset = offset + (uint64_t) iov[slice_idx].iov_base;
+
+        if (is_write) {
+            ret = qio_channel_pwritev_full(ioc, &iov[slice_idx], slice_num,
+                                           file_offset, errp);
+        } else {
+            ret = qio_channel_preadv_full(ioc, &iov[slice_idx], slice_num,
+                                          file_offset, errp);
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
+int qio_channel_write_full_all(QIOChannel *ioc,
+                                const struct iovec *iov,
+                                size_t niov, off_t offset,
+                                int *fds, size_t nfds,
+                                int flags, Error **errp)
+{
+    if (flags & QIO_CHANNEL_WRITE_FLAG_WITH_OFFSET) {
+        return qio_channel_preadv_pwritev_contiguous(ioc, iov, niov,
+                                                     offset, true, errp);
+    }
+
+    return qio_channel_writev_full_all(ioc, iov, niov, NULL, 0, flags, errp);
+}
+
 ssize_t qio_channel_pwritev(QIOChannel *ioc, char *buf, size_t buflen,
                             off_t offset, Error **errp)
 {
@@ -501,6 +571,18 @@ ssize_t qio_channel_preadv_full(QIOChannel *ioc, const struct iovec *iov,
     return klass->io_preadv(ioc, iov, niov, offset, errp);
 }
 
+int qio_channel_read_full_all(QIOChannel *ioc, const struct iovec *iov,
+                              size_t niov, off_t offset,
+                              int flags, Error **errp)
+{
+    if (flags & QIO_CHANNEL_READ_FLAG_WITH_OFFSET) {
+        return qio_channel_preadv_pwritev_contiguous(ioc, iov, niov,
+                                                     offset, false, errp);
+    }
+
+    return qio_channel_readv_full_all(ioc, iov, niov, NULL, NULL, errp);
+}
+
 ssize_t qio_channel_preadv(QIOChannel *ioc, char *buf, size_t buflen,
                            off_t offset, Error **errp)
 {
-- 
2.35.3


