Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9B485CB06
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Feb 2024 23:45:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcYoX-0003G4-Ce; Tue, 20 Feb 2024 17:42:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rcYoS-0003BJ-Ja
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:42:09 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rcYoQ-0006Ka-Se
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:42:08 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 97C0122260;
 Tue, 20 Feb 2024 22:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708468925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7SO+bxJtiGsvDF/g59UKVu7ECe/ndyMpnLx6uJ7EF0c=;
 b=Sc+LfWtFtalcwcBWWs/DurYzmBRinTEvgR3tBzQbRiJOPji2ZdYCOAq60BWy8QMSgyPyXJ
 tesf3Pi3N53Fx/yaIE2KD08uI0zEt1sktX+k+ctjZPeq7OCab8i4DWnj+gCluS6MNBwwoo
 WHYCv8i8QWSwKa1CF0IKL0Y7m+ghjmM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708468925;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7SO+bxJtiGsvDF/g59UKVu7ECe/ndyMpnLx6uJ7EF0c=;
 b=gtCzvQDpckoHMTF8Ey2WHJ02shTjl1VFyEcYPPOWbr8spb5BX7XbFeI47rKrsbZQCK5gNx
 tJKru0ZSOc8rxVCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708468925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7SO+bxJtiGsvDF/g59UKVu7ECe/ndyMpnLx6uJ7EF0c=;
 b=Sc+LfWtFtalcwcBWWs/DurYzmBRinTEvgR3tBzQbRiJOPji2ZdYCOAq60BWy8QMSgyPyXJ
 tesf3Pi3N53Fx/yaIE2KD08uI0zEt1sktX+k+ctjZPeq7OCab8i4DWnj+gCluS6MNBwwoo
 WHYCv8i8QWSwKa1CF0IKL0Y7m+ghjmM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708468925;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7SO+bxJtiGsvDF/g59UKVu7ECe/ndyMpnLx6uJ7EF0c=;
 b=gtCzvQDpckoHMTF8Ey2WHJ02shTjl1VFyEcYPPOWbr8spb5BX7XbFeI47rKrsbZQCK5gNx
 tJKru0ZSOc8rxVCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 02A5E139D0;
 Tue, 20 Feb 2024 22:42:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AFTSLrsq1WUlKwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 20 Feb 2024 22:42:03 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: [PATCH v4 10/34] migration/qemu-file: add utility methods for working
 with seekable channels
Date: Tue, 20 Feb 2024 19:41:14 -0300
Message-Id: <20240220224138.24759-11-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240220224138.24759-1-farosas@suse.de>
References: <20240220224138.24759-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Sc+LfWtF;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=gtCzvQDp
X-Spamd-Result: default: False [-2.31 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 97C0122260
X-Spam-Score: -2.31
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Add utility methods that will be needed when implementing 'fixed-ram'
migration capability.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
- handling EAGAIN and partial reads/writes
- removed the list of functions from the commit message
---
 include/migration/qemu-file-types.h |   2 +
 migration/qemu-file.c               | 106 ++++++++++++++++++++++++++++
 migration/qemu-file.h               |   6 ++
 3 files changed, 114 insertions(+)

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
index 94231ff295..b10c882629 100644
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
@@ -447,6 +452,107 @@ void qemu_put_buffer(QEMUFile *f, const uint8_t *buf, size_t size)
     }
 }
 
+void qemu_put_buffer_at(QEMUFile *f, const uint8_t *buf, size_t buflen,
+                        off_t pos)
+{
+    Error *err = NULL;
+    size_t ret;
+
+    if (f->last_error) {
+        return;
+    }
+
+    qemu_fflush(f);
+    ret = qio_channel_pwrite(f->ioc, (char *)buf, buflen, pos, &err);
+
+    if (err) {
+        qemu_file_set_error_obj(f, -EIO, err);
+        return;
+    }
+
+    if ((ssize_t)ret == QIO_CHANNEL_ERR_BLOCK) {
+        qemu_file_set_error_obj(f, -EAGAIN, NULL);
+        return;
+    }
+
+    if (ret != buflen) {
+        error_setg(&err, "Partial write of size %zu, expected %zu", ret,
+                   buflen);
+        qemu_file_set_error_obj(f, -EIO, err);
+        return;
+    }
+
+    stat64_add(&mig_stats.qemu_file_transferred, buflen);
+
+    return;
+}
+
+
+size_t qemu_get_buffer_at(QEMUFile *f, const uint8_t *buf, size_t buflen,
+                          off_t pos)
+{
+    Error *err = NULL;
+    size_t ret;
+
+    if (f->last_error) {
+        return 0;
+    }
+
+    ret = qio_channel_pread(f->ioc, (char *)buf, buflen, pos, &err);
+
+    if ((ssize_t)ret == -1 || err) {
+        qemu_file_set_error_obj(f, -EIO, err);
+        return 0;
+    }
+
+    if ((ssize_t)ret == QIO_CHANNEL_ERR_BLOCK) {
+        qemu_file_set_error_obj(f, -EAGAIN, NULL);
+        return 0;
+    }
+
+    if (ret != buflen) {
+        error_setg(&err, "Partial read of size %zu, expected %zu", ret, buflen);
+        qemu_file_set_error_obj(f, -EIO, err);
+        return 0;
+    }
+
+    return ret;
+}
+
+void qemu_set_offset(QEMUFile *f, off_t off, int whence)
+{
+    Error *err = NULL;
+    off_t ret;
+
+    if (qemu_file_is_writable(f)) {
+        qemu_fflush(f);
+    } else {
+        /* Drop all cached buffers if existed; will trigger a re-fill later */
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


