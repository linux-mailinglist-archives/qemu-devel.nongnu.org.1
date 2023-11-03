Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BC77DFF4F
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 08:03:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyoBx-00065g-5L; Fri, 03 Nov 2023 03:02:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qyoBv-00065B-6X
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 03:02:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qyoBs-0000xa-1r
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 03:02:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698994919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=naVkma1I8TWwxMoJt4IYPuegIpP/uso5GkqRyi+ZnDM=;
 b=arxCASPHtE5LwUnshbPq3FXA8BiSbZ+R1Wj1yM6KKP0c3KUVPUinfFu6gtg5hZQ3x7uH69
 lYc1FdtXexVfTe8kRNcHIq/dEJ0z2oefCqxNcaHaRit9g9zpIieuXmLICHl/aJipZXB3RC
 q7oFCPC00yuO3S3ezJ7AgV/d+RqwJXA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-31-ppUCRbciOfCUfcvz9cCCiQ-1; Fri,
 03 Nov 2023 03:01:54 -0400
X-MC-Unique: ppUCRbciOfCUfcvz9cCCiQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DDE9A3C0C107;
 Fri,  3 Nov 2023 07:01:53 +0000 (UTC)
Received: from localhost (unknown [10.39.208.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B6D331121309;
 Fri,  3 Nov 2023 07:01:52 +0000 (UTC)
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
Subject: [PULL 3/8] dump: Add command interface for kdump-raw formats
Date: Fri,  3 Nov 2023 11:01:31 +0400
Message-ID: <20231103070136.437557-4-marcandre.lureau@redhat.com>
In-Reply-To: <20231103070136.437557-1-marcandre.lureau@redhat.com>
References: <20231103070136.437557-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
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

The QMP dump API represents the dump format as an enumeration. Add three
new enumerators, one for each supported kdump compression, each named
"kdump-raw-*".

For the HMP command line, rather than adding a new flag corresponding to
each format, it seems more human-friendly to add a single flag "-R" to
switch the kdump formats to "raw" mode. The choice of "-R" also
correlates nicely to the "makedumpfile -R" option, which would serve to
reassemble a flattened vmcore.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
[ Marc-André: replace loff_t with off_t, indent fixes ]
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20230918233233.1431858-4-stephen.s.brennan@oracle.com>
---
 qapi/dump.json       | 24 ++++++++++++++++++++----
 dump/dump-hmp-cmds.c | 21 +++++++++++++++++----
 dump/dump.c          | 33 ++++++++++++++++++++++++++++++++-
 hmp-commands.hx      |  9 +++++++--
 4 files changed, 76 insertions(+), 11 deletions(-)

diff --git a/qapi/dump.json b/qapi/dump.json
index 4ae1f722a9..5cbc237ad9 100644
--- a/qapi/dump.json
+++ b/qapi/dump.json
@@ -15,11 +15,23 @@
 #
 # @elf: elf format
 #
-# @kdump-zlib: kdump-compressed format with zlib-compressed
+# @kdump-zlib: makedumpfile flattened, kdump-compressed format with zlib
+#     compression
 #
-# @kdump-lzo: kdump-compressed format with lzo-compressed
+# @kdump-lzo: makedumpfile flattened, kdump-compressed format with lzo
+#     compression
 #
-# @kdump-snappy: kdump-compressed format with snappy-compressed
+# @kdump-snappy: makedumpfile flattened, kdump-compressed format with snappy
+#     compression
+#
+# @kdump-raw-zlib: raw assembled kdump-compressed format with zlib compression
+#     (since 8.2)
+#
+# @kdump-raw-lzo: raw assembled kdump-compressed format with lzo compression
+#     (since 8.2)
+#
+# @kdump-raw-snappy: raw assembled kdump-compressed format with snappy
+#     compression (since 8.2)
 #
 # @win-dmp: Windows full crashdump format, can be used instead of ELF
 #     converting (since 2.13)
@@ -27,7 +39,11 @@
 # Since: 2.0
 ##
 { 'enum': 'DumpGuestMemoryFormat',
-  'data': [ 'elf', 'kdump-zlib', 'kdump-lzo', 'kdump-snappy', 'win-dmp' ] }
+  'data': [
+      'elf',
+      'kdump-zlib', 'kdump-lzo', 'kdump-snappy',
+      'kdump-raw-zlib', 'kdump-raw-lzo', 'kdump-raw-snappy',
+      'win-dmp' ] }
 
 ##
 # @dump-guest-memory:
diff --git a/dump/dump-hmp-cmds.c b/dump/dump-hmp-cmds.c
index b038785fee..b428ec33df 100644
--- a/dump/dump-hmp-cmds.c
+++ b/dump/dump-hmp-cmds.c
@@ -19,6 +19,7 @@ void hmp_dump_guest_memory(Monitor *mon, const QDict *qdict)
     bool paging = qdict_get_try_bool(qdict, "paging", false);
     bool zlib = qdict_get_try_bool(qdict, "zlib", false);
     bool lzo = qdict_get_try_bool(qdict, "lzo", false);
+    bool raw = qdict_get_try_bool(qdict, "raw", false);
     bool snappy = qdict_get_try_bool(qdict, "snappy", false);
     const char *file = qdict_get_str(qdict, "filename");
     bool has_begin = qdict_haskey(qdict, "begin");
@@ -40,16 +41,28 @@ void hmp_dump_guest_memory(Monitor *mon, const QDict *qdict)
         dump_format = DUMP_GUEST_MEMORY_FORMAT_WIN_DMP;
     }
 
-    if (zlib) {
-        dump_format = DUMP_GUEST_MEMORY_FORMAT_KDUMP_ZLIB;
+    if (zlib && raw) {
+        if (raw) {
+            dump_format = DUMP_GUEST_MEMORY_FORMAT_KDUMP_RAW_ZLIB;
+        } else {
+            dump_format = DUMP_GUEST_MEMORY_FORMAT_KDUMP_ZLIB;
+        }
     }
 
     if (lzo) {
-        dump_format = DUMP_GUEST_MEMORY_FORMAT_KDUMP_LZO;
+        if (raw) {
+            dump_format = DUMP_GUEST_MEMORY_FORMAT_KDUMP_RAW_LZO;
+        } else {
+            dump_format = DUMP_GUEST_MEMORY_FORMAT_KDUMP_LZO;
+        }
     }
 
     if (snappy) {
-        dump_format = DUMP_GUEST_MEMORY_FORMAT_KDUMP_SNAPPY;
+        if (raw) {
+            dump_format = DUMP_GUEST_MEMORY_FORMAT_KDUMP_RAW_SNAPPY;
+        } else {
+            dump_format = DUMP_GUEST_MEMORY_FORMAT_KDUMP_SNAPPY;
+        }
     }
 
     if (has_begin) {
diff --git a/dump/dump.c b/dump/dump.c
index 0f913e1f5c..44b27fef45 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -2090,6 +2090,7 @@ void qmp_dump_guest_memory(bool paging, const char *file,
     int fd = -1;
     DumpState *s;
     bool detach_p = false;
+    bool kdump_raw = false;
 
     if (runstate_check(RUN_STATE_INMIGRATE)) {
         error_setg(errp, "Dump not allowed during incoming migration.");
@@ -2103,6 +2104,29 @@ void qmp_dump_guest_memory(bool paging, const char *file,
         return;
     }
 
+    /*
+     * externally, we represent kdump-raw-* as separate formats, but internally
+     * they are handled the same, except for the "raw" flag
+     */
+    if (has_format) {
+        switch (format) {
+        case DUMP_GUEST_MEMORY_FORMAT_KDUMP_RAW_ZLIB:
+            format = DUMP_GUEST_MEMORY_FORMAT_KDUMP_ZLIB;
+            kdump_raw = true;
+            break;
+        case DUMP_GUEST_MEMORY_FORMAT_KDUMP_RAW_LZO:
+            format = DUMP_GUEST_MEMORY_FORMAT_KDUMP_LZO;
+            kdump_raw = true;
+            break;
+        case DUMP_GUEST_MEMORY_FORMAT_KDUMP_RAW_SNAPPY:
+            format = DUMP_GUEST_MEMORY_FORMAT_KDUMP_SNAPPY;
+            kdump_raw = true;
+            break;
+        default:
+            break;
+        }
+    }
+
     /*
      * kdump-compressed format need the whole memory dumped, so paging or
      * filter is not supported here.
@@ -2166,6 +2190,10 @@ void qmp_dump_guest_memory(bool paging, const char *file,
         error_setg(errp, QERR_INVALID_PARAMETER, "protocol");
         return;
     }
+    if (kdump_raw && lseek(fd, 0, SEEK_CUR) == (off_t) -1) {
+        error_setg(errp, "kdump-raw formats require a seekable file");
+        return;
+    }
 
     if (!dump_migration_blocker) {
         error_setg(&dump_migration_blocker,
@@ -2186,7 +2214,7 @@ void qmp_dump_guest_memory(bool paging, const char *file,
     dump_state_prepare(s);
 
     dump_init(s, fd, has_format, format, paging, has_begin,
-              begin, length, false, errp);
+              begin, length, kdump_raw, errp);
     if (*errp) {
         qatomic_set(&s->status, DUMP_STATUS_FAILED);
         return;
@@ -2214,15 +2242,18 @@ DumpGuestMemoryCapability *qmp_query_dump_guest_memory_capability(Error **errp)
 
     /* kdump-zlib is always available */
     QAPI_LIST_APPEND(tail, DUMP_GUEST_MEMORY_FORMAT_KDUMP_ZLIB);
+    QAPI_LIST_APPEND(tail, DUMP_GUEST_MEMORY_FORMAT_KDUMP_RAW_ZLIB);
 
     /* add new item if kdump-lzo is available */
 #ifdef CONFIG_LZO
     QAPI_LIST_APPEND(tail, DUMP_GUEST_MEMORY_FORMAT_KDUMP_LZO);
+    QAPI_LIST_APPEND(tail, DUMP_GUEST_MEMORY_FORMAT_KDUMP_RAW_LZO);
 #endif
 
     /* add new item if kdump-snappy is available */
 #ifdef CONFIG_SNAPPY
     QAPI_LIST_APPEND(tail, DUMP_GUEST_MEMORY_FORMAT_KDUMP_SNAPPY);
+    QAPI_LIST_APPEND(tail, DUMP_GUEST_MEMORY_FORMAT_KDUMP_RAW_SNAPPY);
 #endif
 
     if (win_dump_available(NULL)) {
diff --git a/hmp-commands.hx b/hmp-commands.hx
index 63eac22734..c0a27688b6 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1085,14 +1085,16 @@ ERST
 
     {
         .name       = "dump-guest-memory",
-        .args_type  = "paging:-p,detach:-d,windmp:-w,zlib:-z,lzo:-l,snappy:-s,filename:F,begin:l?,length:l?",
-        .params     = "[-p] [-d] [-z|-l|-s|-w] filename [begin length]",
+        .args_type  = "paging:-p,detach:-d,windmp:-w,zlib:-z,lzo:-l,snappy:-s,raw:-R,filename:F,begin:l?,length:l?",
+        .params     = "[-p] [-d] [-z|-l|-s|-w] [-R] filename [begin length]",
         .help       = "dump guest memory into file 'filename'.\n\t\t\t"
                       "-p: do paging to get guest's memory mapping.\n\t\t\t"
                       "-d: return immediately (do not wait for completion).\n\t\t\t"
                       "-z: dump in kdump-compressed format, with zlib compression.\n\t\t\t"
                       "-l: dump in kdump-compressed format, with lzo compression.\n\t\t\t"
                       "-s: dump in kdump-compressed format, with snappy compression.\n\t\t\t"
+                      "-R: when using kdump (-z, -l, -s), use raw rather than makedumpfile-flattened\n\t\t\t"
+                      "    format\n\t\t\t"
                       "-w: dump in Windows crashdump format (can be used instead of ELF-dump converting),\n\t\t\t"
                       "    for Windows x86 and x64 guests with vmcoreinfo driver only.\n\t\t\t"
                       "begin: the starting physical address.\n\t\t\t"
@@ -1115,6 +1117,9 @@ SRST
     dump in kdump-compressed format, with lzo compression.
   ``-s``
     dump in kdump-compressed format, with snappy compression.
+  ``-R``
+    when using kdump (-z, -l, -s), use raw rather than makedumpfile-flattened
+    format
   ``-w``
     dump in Windows crashdump format (can be used instead of ELF-dump converting),
     for Windows x64 guests with vmcoreinfo driver only
-- 
2.41.0


