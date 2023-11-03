Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FCB7DFF4D
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 08:03:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyoCN-0006Bz-Uh; Fri, 03 Nov 2023 03:02:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qyoCK-0006A1-6L
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 03:02:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qyoC5-00014a-9S
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 03:02:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698994932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aFAo90F17fRMoMq2T6P+tJGS4tOKEdx+gWjM97sLSFo=;
 b=C09EKZnmpUSIwQvQRRXTWL7CN8BkgsGzKS6PtqMs7YiP2VEC8UuglZlFqrn23ezT5ccr9g
 DZMrVj3hxrayCmR8bIWJ+BmHyBMr/VnuqknpqQX+O1ywNMXGwkgkrqP4HXKmmtZdHgkZyA
 bL5bZjvqjZTnUB6R1NFvOaI0qMUewZw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-s8B0CL8nPQGrEYFOb2CEGg-1; Fri, 03 Nov 2023 03:02:11 -0400
X-MC-Unique: s8B0CL8nPQGrEYFOb2CEGg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D4FE7101A52D;
 Fri,  3 Nov 2023 07:02:10 +0000 (UTC)
Received: from localhost (unknown [10.39.208.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AF6B31121309;
 Fri,  3 Nov 2023 07:02:09 +0000 (UTC)
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
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: [PULL 7/8] dump: Improve some dump-guest-memory error messages
Date: Fri,  3 Nov 2023 11:01:35 +0400
Message-ID: <20231103070136.437557-8-marcandre.lureau@redhat.com>
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
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Markus Armbruster <armbru@redhat.com>

Zero @length is rejected with "Invalid parameter 'length'".  Improve
to "parameter 'length' expects a non-zero length".

qemu_open_old() is a wrapper around qemu_open_internal() that throws
away error information.  Switch to the wrapper that doesn't:
qemu_create().  Example improvement:

    (qemu) dump-guest-memory /dev/fdset/x 0 1
    Error: Could not open '/dev/fdset/x': Invalid argument

becomes

    Error: Could not parse fdset /dev/fdset/x

@protocol values not starting with "fd:" or "file:" are rejected with
"Invalid parameter 'protocol'".  Improve to "parameter 'protocol' must
start with 'file:' or 'fd:'".

While there, make the conditional checking @protocol a little more
obvious.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20231031104531.3169721-5-armbru@redhat.com>
---
 dump/dump.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/dump/dump.c b/dump/dump.c
index 2d0b5bd22b..ec2cfcf9f7 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -1828,7 +1828,7 @@ static void dump_init(DumpState *s, int fd, bool has_format,
 
     s->fd = fd;
     if (has_filter && !length) {
-        error_setg(errp, QERR_INVALID_PARAMETER, "length");
+        error_setg(errp, "parameter 'length' expects a non-zero size");
         goto cleanup;
     }
     s->filter_area_begin = begin;
@@ -2088,7 +2088,7 @@ void qmp_dump_guest_memory(bool paging, const char *protocol,
 {
     ERRP_GUARD();
     const char *p;
-    int fd = -1;
+    int fd;
     DumpState *s;
     bool detach_p = false;
     bool kdump_raw = false;
@@ -2175,18 +2175,14 @@ void qmp_dump_guest_memory(bool paging, const char *protocol,
         if (fd == -1) {
             return;
         }
-    }
-
-    if  (strstart(protocol, "file:", &p)) {
-        fd = qemu_open_old(p, O_WRONLY | O_CREAT | O_TRUNC | O_BINARY, S_IRUSR);
+    } else if  (strstart(protocol, "file:", &p)) {
+        fd = qemu_create(p, O_WRONLY | O_TRUNC | O_BINARY, S_IRUSR, errp);
         if (fd < 0) {
-            error_setg_file_open(errp, errno, p);
             return;
         }
-    }
-
-    if (fd == -1) {
-        error_setg(errp, QERR_INVALID_PARAMETER, "protocol");
+    } else {
+        error_setg(errp,
+                   "parameter 'protocol' must start with 'file:' or 'fd:'");
         return;
     }
     if (kdump_raw && lseek(fd, 0, SEEK_CUR) == (off_t) -1) {
-- 
2.41.0


