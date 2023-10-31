Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBDB7DCB17
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 11:46:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxmFh-0007Kh-3n; Tue, 31 Oct 2023 06:45:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qxmFe-0007Jx-7p
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 06:45:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qxmFc-0000xC-AI
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 06:45:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698749134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6OsOVQfXxaKRG2G3Gij7SjaNi+O+cFn0M9T+UXaofCM=;
 b=GYJQe2es8TaiLiv5EWeJc14DCyfgOEvBYyamTxToa8iIltFQEwwtIe9X6x2yTutsH12/o1
 Oeado+OlnQZ8flDznXiNsoiAYlCG00HnupX+3nDJjBVZKHzdoUTkYUlKqmMZXslgCGxRRW
 PB6PkeU2+AEJf6yoEnoycPv1Aalny88=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-ECAvUT38Niax-sk7ZKIRAg-1; Tue, 31 Oct 2023 06:45:32 -0400
X-MC-Unique: ECAvUT38Niax-sk7ZKIRAg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9252B89CA42;
 Tue, 31 Oct 2023 10:45:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 711D62166B2A;
 Tue, 31 Oct 2023 10:45:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 323BA21E691F; Tue, 31 Oct 2023 11:45:31 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com,
	philmd@linaro.org
Subject: [PATCH v2 4/5] dump: Improve some dump-guest-memory error messages
Date: Tue, 31 Oct 2023 11:45:30 +0100
Message-ID: <20231031104531.3169721-5-armbru@redhat.com>
In-Reply-To: <20231031104531.3169721-1-armbru@redhat.com>
References: <20231031104531.3169721-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 dump/dump.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/dump/dump.c b/dump/dump.c
index 30fb2cb0c6..66f62d0891 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -1810,7 +1810,7 @@ static void dump_init(DumpState *s, int fd, bool has_format,
 
     s->fd = fd;
     if (has_filter && !length) {
-        error_setg(errp, QERR_INVALID_PARAMETER, "length");
+        error_setg(errp, "parameter 'length' expects a non-zero size");
         goto cleanup;
     }
     s->filter_area_begin = begin;
@@ -2070,7 +2070,7 @@ void qmp_dump_guest_memory(bool paging, const char *protocol,
 {
     ERRP_GUARD();
     const char *p;
-    int fd = -1;
+    int fd;
     DumpState *s;
     bool detach_p = false;
 
@@ -2133,18 +2133,14 @@ void qmp_dump_guest_memory(bool paging, const char *protocol,
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
 
-- 
2.41.0


