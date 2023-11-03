Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A29D7DFF4C
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 08:03:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyoBs-00064V-2p; Fri, 03 Nov 2023 03:02:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qyoBp-00063l-Ir
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 03:01:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qyoBm-0000wU-IP
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 03:01:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698994913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a/97ELOFFgRZw3+KK7vgHBNgSfLau25BCHwiLcMW7c4=;
 b=YfrR5kIT8ou1a25t+Mlafg1VnI7c3heBaROnys26Qp+CB/Fmt6JtaDyBryLGvrALbJi+JW
 3cumLxsauROe6BPsO25Di6+Qt+njo8Grs0ZPP4gkbuWBYqRtZve9g6SB4Sxxr4sFsO/eXi
 b71sE/GnMGbocOJctS9Wr8Arjnnal38=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-114-DpHo7ow9OCiqKcPbcCj70Q-1; Fri,
 03 Nov 2023 03:01:49 -0400
X-MC-Unique: DpHo7ow9OCiqKcPbcCj70Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6578829AB448;
 Fri,  3 Nov 2023 07:01:49 +0000 (UTC)
Received: from localhost (unknown [10.39.208.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 408CF2166B27;
 Fri,  3 Nov 2023 07:01:47 +0000 (UTC)
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
Subject: [PULL 2/8] dump: Allow directly outputting raw kdump format
Date: Fri,  3 Nov 2023 11:01:30 +0400
Message-ID: <20231103070136.437557-3-marcandre.lureau@redhat.com>
In-Reply-To: <20231103070136.437557-1-marcandre.lureau@redhat.com>
References: <20231103070136.437557-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The flattened format (currently output by QEMU) is used by makedumpfile
only when it is outputting a vmcore to a file which is not seekable. The
flattened format functions essentially as a set of instructions of the
form "seek to the given offset, then write the given bytes out".

The flattened format can be reconstructed using makedumpfile -R, or
makedumpfile-R.pl, but it is a slow process because it requires copying
the entire vmcore. The flattened format can also be directly read by
crash, but still, it requires a lengthy reassembly phase.

To sum up, the flattened format is not an ideal one: it should only be
used on files which are actually not seekable. This is the exact
strategy which makedumpfile uses, as seen in the implementation of
"write_buffer()" in makedumpfile [1]. However, QEMU has always used the
flattened format. For compatibility it is best not to change the default
output format without warning. So, add a flag to DumpState which changes
the output to use the normal (i.e. raw) format. This flag will be added
to the QMP and HMP commands in the next change.

[1]: https://github.com/makedumpfile/makedumpfile/blob/f23bb943568188a2746dbf9b6692668f5a2ac3b6/makedumpfile.c#L5008-L5040

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
[ Marc-André: replace loff_t with off_t ]
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20230918233233.1431858-3-stephen.s.brennan@oracle.com>
---
 include/sysemu/dump.h |  1 +
 dump/dump.c           | 32 +++++++++++++++++++++++++-------
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/include/sysemu/dump.h b/include/sysemu/dump.h
index e27af8fb34..d702854853 100644
--- a/include/sysemu/dump.h
+++ b/include/sysemu/dump.h
@@ -157,6 +157,7 @@ typedef struct DumpState {
     MemoryMappingList list;
     bool resume;
     bool detached;
+    bool kdump_raw;
     hwaddr memory_offset;
     int fd;
 
diff --git a/dump/dump.c b/dump/dump.c
index eec34c4738..0f913e1f5c 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -814,6 +814,10 @@ static int write_start_flat_header(DumpState *s)
     MakedumpfileHeader *mh;
     int ret = 0;
 
+    if (s->kdump_raw) {
+        return 0;
+    }
+
     QEMU_BUILD_BUG_ON(sizeof *mh > MAX_SIZE_MDF_HEADER);
     mh = g_malloc0(MAX_SIZE_MDF_HEADER);
 
@@ -837,6 +841,10 @@ static int write_end_flat_header(DumpState *s)
 {
     MakedumpfileDataHeader mdh;
 
+    if (s->kdump_raw) {
+        return 0;
+    }
+
     mdh.offset = END_FLAG_FLAT_HEADER;
     mdh.buf_size = END_FLAG_FLAT_HEADER;
 
@@ -853,13 +861,21 @@ static int write_buffer(DumpState *s, off_t offset, const void *buf, size_t size
 {
     size_t written_size;
     MakedumpfileDataHeader mdh;
+    off_t seek_loc;
 
-    mdh.offset = cpu_to_be64(offset);
-    mdh.buf_size = cpu_to_be64(size);
+    if (s->kdump_raw) {
+        seek_loc = lseek(s->fd, offset, SEEK_SET);
+        if (seek_loc == (off_t) -1) {
+            return -1;
+        }
+    } else {
+        mdh.offset = cpu_to_be64(offset);
+        mdh.buf_size = cpu_to_be64(size);
 
-    written_size = qemu_write_full(s->fd, &mdh, sizeof(mdh));
-    if (written_size != sizeof(mdh)) {
-        return -1;
+        written_size = qemu_write_full(s->fd, &mdh, sizeof(mdh));
+        if (written_size != sizeof(mdh)) {
+            return -1;
+        }
     }
 
     written_size = qemu_write_full(s->fd, buf, size);
@@ -1775,7 +1791,8 @@ static void vmcoreinfo_update_phys_base(DumpState *s)
 
 static void dump_init(DumpState *s, int fd, bool has_format,
                       DumpGuestMemoryFormat format, bool paging, bool has_filter,
-                      int64_t begin, int64_t length, Error **errp)
+                      int64_t begin, int64_t length, bool kdump_raw,
+                      Error **errp)
 {
     ERRP_GUARD();
     VMCoreInfoState *vmci = vmcoreinfo_find();
@@ -1786,6 +1803,7 @@ static void dump_init(DumpState *s, int fd, bool has_format,
     s->has_format = has_format;
     s->format = format;
     s->written_size = 0;
+    s->kdump_raw = kdump_raw;
 
     /* kdump-compressed is conflict with paging and filter */
     if (has_format && format != DUMP_GUEST_MEMORY_FORMAT_ELF) {
@@ -2168,7 +2186,7 @@ void qmp_dump_guest_memory(bool paging, const char *file,
     dump_state_prepare(s);
 
     dump_init(s, fd, has_format, format, paging, has_begin,
-              begin, length, errp);
+              begin, length, false, errp);
     if (*errp) {
         qatomic_set(&s->status, DUMP_STATUS_FAILED);
         return;
-- 
2.41.0


