Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB197DFF52
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 08:03:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyoBr-000641-4w; Fri, 03 Nov 2023 03:01:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qyoBn-000638-23
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 03:01:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qyoBj-0000w5-Mm
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 03:01:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698994910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JvK2wAaFRVQTY/mBUoloVqKY0St+mXzXhj9d5h4ZicY=;
 b=WMYwzCDexDnVlSSYBdIvp8whmpohQ0AZJEtmLEiGDRzqRiZgdU00wQ6CoedjjnsfQ0nIoY
 2cAdOFYSwE4K6fWHS4+RxVgUhSOhzlWG1IhEb/9iE3CddLlDigLj5ZIEjPo2Zuw9OBj2to
 gPvG8fIFCnhVtPqVLDSTT+Jf4MY0TRY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-p9Ur5iYSNQaYt1o2dJBFeQ-1; Fri, 03 Nov 2023 03:01:45 -0400
X-MC-Unique: p9Ur5iYSNQaYt1o2dJBFeQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1DBCF811E82;
 Fri,  3 Nov 2023 07:01:45 +0000 (UTC)
Received: from localhost (unknown [10.39.208.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B4395492BFA;
 Fri,  3 Nov 2023 07:01:43 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 richard.henderson@linaro.org, Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Stephen Brennan <stephen.s.brennan@oracle.com>
Subject: [PULL 1/8] dump: Pass DumpState to write_ functions
Date: Fri,  3 Nov 2023 11:01:29 +0400
Message-ID: <20231103070136.437557-2-marcandre.lureau@redhat.com>
In-Reply-To: <20231103070136.437557-1-marcandre.lureau@redhat.com>
References: <20231103070136.437557-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Stephen Brennan <stephen.s.brennan@oracle.com>

For the next patch, we need a reference to DumpState when writing data.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20230918233233.1431858-2-stephen.s.brennan@oracle.com>
---
 include/sysemu/dump.h |  2 +-
 dump/dump.c           | 40 ++++++++++++++++++++--------------------
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/include/sysemu/dump.h b/include/sysemu/dump.h
index 7008d43d04..e27af8fb34 100644
--- a/include/sysemu/dump.h
+++ b/include/sysemu/dump.h
@@ -137,7 +137,7 @@ typedef struct QEMU_PACKED KdumpSubHeader64 {
 } KdumpSubHeader64;
 
 typedef struct DataCache {
-    int fd;             /* fd of the file where to write the cached data */
+    DumpState *state;   /* dump state related to this data */
     uint8_t *buf;       /* buffer for cached data */
     size_t buf_size;    /* size of the buf */
     size_t data_size;   /* size of cached data in buf */
diff --git a/dump/dump.c b/dump/dump.c
index d355ada62e..eec34c4738 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -809,7 +809,7 @@ static void create_vmcore(DumpState *s, Error **errp)
     dump_end(s, errp);
 }
 
-static int write_start_flat_header(int fd)
+static int write_start_flat_header(DumpState *s)
 {
     MakedumpfileHeader *mh;
     int ret = 0;
@@ -824,7 +824,7 @@ static int write_start_flat_header(int fd)
     mh->version = cpu_to_be64(VERSION_FLAT_HEADER);
 
     size_t written_size;
-    written_size = qemu_write_full(fd, mh, MAX_SIZE_MDF_HEADER);
+    written_size = qemu_write_full(s->fd, mh, MAX_SIZE_MDF_HEADER);
     if (written_size != MAX_SIZE_MDF_HEADER) {
         ret = -1;
     }
@@ -833,7 +833,7 @@ static int write_start_flat_header(int fd)
     return ret;
 }
 
-static int write_end_flat_header(int fd)
+static int write_end_flat_header(DumpState *s)
 {
     MakedumpfileDataHeader mdh;
 
@@ -841,7 +841,7 @@ static int write_end_flat_header(int fd)
     mdh.buf_size = END_FLAG_FLAT_HEADER;
 
     size_t written_size;
-    written_size = qemu_write_full(fd, &mdh, sizeof(mdh));
+    written_size = qemu_write_full(s->fd, &mdh, sizeof(mdh));
     if (written_size != sizeof(mdh)) {
         return -1;
     }
@@ -849,7 +849,7 @@ static int write_end_flat_header(int fd)
     return 0;
 }
 
-static int write_buffer(int fd, off_t offset, const void *buf, size_t size)
+static int write_buffer(DumpState *s, off_t offset, const void *buf, size_t size)
 {
     size_t written_size;
     MakedumpfileDataHeader mdh;
@@ -857,12 +857,12 @@ static int write_buffer(int fd, off_t offset, const void *buf, size_t size)
     mdh.offset = cpu_to_be64(offset);
     mdh.buf_size = cpu_to_be64(size);
 
-    written_size = qemu_write_full(fd, &mdh, sizeof(mdh));
+    written_size = qemu_write_full(s->fd, &mdh, sizeof(mdh));
     if (written_size != sizeof(mdh)) {
         return -1;
     }
 
-    written_size = qemu_write_full(fd, buf, size);
+    written_size = qemu_write_full(s->fd, buf, size);
     if (written_size != size) {
         return -1;
     }
@@ -982,7 +982,7 @@ static void create_header32(DumpState *s, Error **errp)
 #endif
     dh->status = cpu_to_dump32(s, status);
 
-    if (write_buffer(s->fd, 0, dh, size) < 0) {
+    if (write_buffer(s, 0, dh, size) < 0) {
         error_setg(errp, "dump: failed to write disk dump header");
         goto out;
     }
@@ -1012,7 +1012,7 @@ static void create_header32(DumpState *s, Error **errp)
     kh->offset_note = cpu_to_dump64(s, offset_note);
     kh->note_size = cpu_to_dump32(s, s->note_size);
 
-    if (write_buffer(s->fd, DISKDUMP_HEADER_BLOCKS *
+    if (write_buffer(s, DISKDUMP_HEADER_BLOCKS *
                      block_size, kh, size) < 0) {
         error_setg(errp, "dump: failed to write kdump sub header");
         goto out;
@@ -1027,7 +1027,7 @@ static void create_header32(DumpState *s, Error **errp)
     if (*errp) {
         goto out;
     }
-    if (write_buffer(s->fd, offset_note, s->note_buf,
+    if (write_buffer(s, offset_note, s->note_buf,
                      s->note_size) < 0) {
         error_setg(errp, "dump: failed to write notes");
         goto out;
@@ -1093,7 +1093,7 @@ static void create_header64(DumpState *s, Error **errp)
 #endif
     dh->status = cpu_to_dump32(s, status);
 
-    if (write_buffer(s->fd, 0, dh, size) < 0) {
+    if (write_buffer(s, 0, dh, size) < 0) {
         error_setg(errp, "dump: failed to write disk dump header");
         goto out;
     }
@@ -1123,7 +1123,7 @@ static void create_header64(DumpState *s, Error **errp)
     kh->offset_note = cpu_to_dump64(s, offset_note);
     kh->note_size = cpu_to_dump64(s, s->note_size);
 
-    if (write_buffer(s->fd, DISKDUMP_HEADER_BLOCKS *
+    if (write_buffer(s, DISKDUMP_HEADER_BLOCKS *
                      block_size, kh, size) < 0) {
         error_setg(errp, "dump: failed to write kdump sub header");
         goto out;
@@ -1139,7 +1139,7 @@ static void create_header64(DumpState *s, Error **errp)
         goto out;
     }
 
-    if (write_buffer(s->fd, offset_note, s->note_buf,
+    if (write_buffer(s, offset_note, s->note_buf,
                      s->note_size) < 0) {
         error_setg(errp, "dump: failed to write notes");
         goto out;
@@ -1204,7 +1204,7 @@ static int set_dump_bitmap(uint64_t last_pfn, uint64_t pfn, bool value,
     while (old_offset < new_offset) {
         /* calculate the offset and write dump_bitmap */
         offset_bitmap1 = s->offset_dump_bitmap + old_offset;
-        if (write_buffer(s->fd, offset_bitmap1, buf,
+        if (write_buffer(s, offset_bitmap1, buf,
                          bitmap_bufsize) < 0) {
             return -1;
         }
@@ -1212,7 +1212,7 @@ static int set_dump_bitmap(uint64_t last_pfn, uint64_t pfn, bool value,
         /* dump level 1 is chosen, so 1st and 2nd bitmap are same */
         offset_bitmap2 = s->offset_dump_bitmap + s->len_dump_bitmap +
                          old_offset;
-        if (write_buffer(s->fd, offset_bitmap2, buf,
+        if (write_buffer(s, offset_bitmap2, buf,
                          bitmap_bufsize) < 0) {
             return -1;
         }
@@ -1380,7 +1380,7 @@ out:
 static void prepare_data_cache(DataCache *data_cache, DumpState *s,
                                off_t offset)
 {
-    data_cache->fd = s->fd;
+    data_cache->state = s;
     data_cache->data_size = 0;
     data_cache->buf_size = 4 * dump_bitmap_get_bufsize(s);
     data_cache->buf = g_malloc0(data_cache->buf_size);
@@ -1399,11 +1399,11 @@ static int write_cache(DataCache *dc, const void *buf, size_t size,
     /*
      * if flag_sync is set, synchronize data in dc->buf into vmcore.
      * otherwise check if the space is enough for caching data in buf, if not,
-     * write the data in dc->buf to dc->fd and reset dc->buf
+     * write the data in dc->buf to dc->state->fd and reset dc->buf
      */
     if ((!flag_sync && dc->data_size + size > dc->buf_size) ||
         (flag_sync && dc->data_size > 0)) {
-        if (write_buffer(dc->fd, dc->offset, dc->buf, dc->data_size) < 0) {
+        if (write_buffer(dc->state, dc->offset, dc->buf, dc->data_size) < 0) {
             return -1;
         }
 
@@ -1644,7 +1644,7 @@ static void create_kdump_vmcore(DumpState *s, Error **errp)
      *  +------------------------------------------+
      */
 
-    ret = write_start_flat_header(s->fd);
+    ret = write_start_flat_header(s);
     if (ret < 0) {
         error_setg(errp, "dump: failed to write start flat header");
         return;
@@ -1665,7 +1665,7 @@ static void create_kdump_vmcore(DumpState *s, Error **errp)
         return;
     }
 
-    ret = write_end_flat_header(s->fd);
+    ret = write_end_flat_header(s);
     if (ret < 0) {
         error_setg(errp, "dump: failed to write end flat header");
         return;
-- 
2.41.0


