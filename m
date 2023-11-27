Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D127FAB52
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 21:27:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7iBm-0002TD-1G; Mon, 27 Nov 2023 15:26:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r7iBd-0002Sm-DJ
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 15:26:33 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r7iBb-0002jx-MA
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 15:26:33 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8CC1521B2A;
 Mon, 27 Nov 2023 20:26:30 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3F2CB1379A;
 Mon, 27 Nov 2023 20:26:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wJCtAXT7ZGVfIQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 27 Nov 2023 20:26:28 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>,
 Nikolay Borisov <nborisov@suse.com>
Subject: [RFC PATCH v3 05/30] migration/qemu-file: add utility methods for
 working with seekable channels
Date: Mon, 27 Nov 2023 17:25:47 -0300
Message-Id: <20231127202612.23012-6-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231127202612.23012-1-farosas@suse.de>
References: <20231127202612.23012-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++
Authentication-Results: smtp-out1.suse.de; dkim=none;
 dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.de
 (policy=none); 
 spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:97 is neither
 permitted nor denied by domain of farosas@suse.de)
 smtp.mailfrom=farosas@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [3.79 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-0.998];
 MIME_GOOD(-0.10)[text/plain]; R_SPF_SOFTFAIL(4.60)[~all:c];
 RCVD_COUNT_THREE(0.00)[3]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[8]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 R_DKIM_NA(2.20)[]; MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%];
 DMARC_POLICY_SOFTFAIL(0.10)[suse.de : No valid SPF, No valid DKIM,none]
X-Spam-Score: 3.79
X-Rspamd-Queue-Id: 8CC1521B2A
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

Add utility methods that will be needed when implementing 'fixed-ram'
migration capability.

qemu_file_is_seekable
qemu_put_buffer_at
qemu_get_buffer_at
qemu_set_offset
qemu_get_offset

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/migration/qemu-file-types.h |  2 +
 migration/qemu-file.c               | 82 +++++++++++++++++++++++++++++
 migration/qemu-file.h               |  6 +++
 3 files changed, 90 insertions(+)

diff --git a/include/migration/qemu-file-types.h b/include/migration/qemu-file-types.h
index 9ba163f333..adec5abc07 100644
--- a/include/migration/qemu-file-types.h
+++ b/include/migration/qemu-file-types.h
@@ -50,6 +50,8 @@ unsigned int qemu_get_be16(QEMUFile *f);
 unsigned int qemu_get_be32(QEMUFile *f);
 uint64_t qemu_get_be64(QEMUFile *f);
 
+bool qemu_file_is_seekable(QEMUFile *f);
+
 static inline void qemu_put_be64s(QEMUFile *f, const uint64_t *pv)
 {
     qemu_put_be64(f, *pv);
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 94231ff295..faf6427b91 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -33,6 +33,7 @@
 #include "options.h"
 #include "qapi/error.h"
 #include "rdma.h"
+#include "io/channel-file.h"
 
 #define IO_BUF_SIZE 32768
 #define MAX_IOV_SIZE MIN_CONST(IOV_MAX, 64)
@@ -255,6 +256,10 @@ static void qemu_iovec_release_ram(QEMUFile *f)
     memset(f->may_free, 0, sizeof(f->may_free));
 }
 
+bool qemu_file_is_seekable(QEMUFile *f)
+{
+    return qio_channel_has_feature(f->ioc, QIO_CHANNEL_FEATURE_SEEKABLE);
+}
 
 /**
  * Flushes QEMUFile buffer
@@ -447,6 +452,83 @@ void qemu_put_buffer(QEMUFile *f, const uint8_t *buf, size_t size)
     }
 }
 
+void qemu_put_buffer_at(QEMUFile *f, const uint8_t *buf, size_t buflen,
+                        off_t pos)
+{
+    Error *err = NULL;
+
+    if (f->last_error) {
+        return;
+    }
+
+    qemu_fflush(f);
+    qio_channel_pwrite(f->ioc, (char *)buf, buflen, pos, &err);
+
+    if (err) {
+        qemu_file_set_error_obj(f, -EIO, err);
+    } else {
+        stat64_add(&mig_stats.qemu_file_transferred, buflen);
+    }
+
+    return;
+}
+
+
+size_t qemu_get_buffer_at(QEMUFile *f, const uint8_t *buf, size_t buflen,
+                          off_t pos)
+{
+    Error *err = NULL;
+    ssize_t ret;
+
+    if (f->last_error) {
+        return 0;
+    }
+
+    ret = qio_channel_pread(f->ioc, (char *)buf, buflen, pos, &err);
+    if (ret == -1 || err) {
+        goto error;
+    }
+
+    return (size_t)ret;
+
+ error:
+    qemu_file_set_error_obj(f, -EIO, err);
+    return 0;
+}
+
+void qemu_set_offset(QEMUFile *f, off_t off, int whence)
+{
+    Error *err = NULL;
+    off_t ret;
+
+    qemu_fflush(f);
+
+    if (!qemu_file_is_writable(f)) {
+        f->buf_index = 0;
+        f->buf_size = 0;
+    }
+
+    ret = qio_channel_io_seek(f->ioc, off, whence, &err);
+    if (ret == (off_t)-1) {
+        qemu_file_set_error_obj(f, -EIO, err);
+    }
+}
+
+off_t qemu_get_offset(QEMUFile *f)
+{
+    Error *err = NULL;
+    off_t ret;
+
+    qemu_fflush(f);
+
+    ret = qio_channel_io_seek(f->ioc, 0, SEEK_CUR, &err);
+    if (ret == (off_t)-1) {
+        qemu_file_set_error_obj(f, -EIO, err);
+    }
+    return ret;
+}
+
+
 void qemu_put_byte(QEMUFile *f, int v)
 {
     if (f->last_error) {
diff --git a/migration/qemu-file.h b/migration/qemu-file.h
index 8aec9fabf7..32fd4a34fd 100644
--- a/migration/qemu-file.h
+++ b/migration/qemu-file.h
@@ -75,6 +75,12 @@ QEMUFile *qemu_file_get_return_path(QEMUFile *f);
 int qemu_fflush(QEMUFile *f);
 void qemu_file_set_blocking(QEMUFile *f, bool block);
 int qemu_file_get_to_fd(QEMUFile *f, int fd, size_t size);
+void qemu_set_offset(QEMUFile *f, off_t off, int whence);
+off_t qemu_get_offset(QEMUFile *f);
+void qemu_put_buffer_at(QEMUFile *f, const uint8_t *buf, size_t buflen,
+                        off_t pos);
+size_t qemu_get_buffer_at(QEMUFile *f, const uint8_t *buf, size_t buflen,
+                          off_t pos);
 
 QIOChannel *qemu_file_get_ioc(QEMUFile *file);
 
-- 
2.35.3


