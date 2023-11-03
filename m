Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3657DFF50
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 08:03:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyoBz-00066Y-0m; Fri, 03 Nov 2023 03:02:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qyoBx-00065y-As
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 03:02:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qyoBv-0000yB-P3
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 03:02:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698994922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LRzur4oylqkPGhapy1hWxVxSmPaxl2ZmBpNoHMhYIV8=;
 b=J+swQSDBcMR1zcIdWo+PLlvBAi+GIeT7YO0dz8oIFSiklR6LtUbG3Q2PttFctckzDrO0yz
 elpTOzKDKrNFMwu33RaGmdrofnb7odEdyRLL/o+48tNxiRlDCe/r0EbUjtmRh1Q0BJZczj
 1AUN2TulcxAWUEuCwYJdQ1KnCHM+HYY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-WeTZvjIvN6-E87EGXvK52Q-1; Fri, 03 Nov 2023 03:01:58 -0400
X-MC-Unique: WeTZvjIvN6-E87EGXvK52Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 74152101A52D;
 Fri,  3 Nov 2023 07:01:58 +0000 (UTC)
Received: from localhost (unknown [10.39.208.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 67B4C2026D6E;
 Fri,  3 Nov 2023 07:01:57 +0000 (UTC)
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
Subject: [PULL 4/8] dump: Rename qmp_dump_guest_memory() parameter to match
 QAPI schema
Date: Fri,  3 Nov 2023 11:01:32 +0400
Message-ID: <20231103070136.437557-5-marcandre.lureau@redhat.com>
In-Reply-To: <20231103070136.437557-1-marcandre.lureau@redhat.com>
References: <20231103070136.437557-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
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

From: Markus Armbruster <armbru@redhat.com>

The name of the second parameter differs between QAPI schema and C
implementation: it's @protocol in the former and @file in the latter.
Potentially confusing.  Change the C implementation to match the QAPI
schema.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20231031104531.3169721-2-armbru@redhat.com>
---
 dump/dump.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/dump/dump.c b/dump/dump.c
index 44b27fef45..9cdb4a2bf8 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -2079,11 +2079,12 @@ DumpQueryResult *qmp_query_dump(Error **errp)
     return result;
 }
 
-void qmp_dump_guest_memory(bool paging, const char *file,
+void qmp_dump_guest_memory(bool paging, const char *protocol,
                            bool has_detach, bool detach,
-                           bool has_begin, int64_t begin, bool has_length,
-                           int64_t length, bool has_format,
-                           DumpGuestMemoryFormat format, Error **errp)
+                           bool has_begin, int64_t begin,
+                           bool has_length, int64_t length,
+                           bool has_format, DumpGuestMemoryFormat format,
+                           Error **errp)
 {
     ERRP_GUARD();
     const char *p;
@@ -2170,7 +2171,7 @@ void qmp_dump_guest_memory(bool paging, const char *file,
     }
 
 #if !defined(WIN32)
-    if (strstart(file, "fd:", &p)) {
+    if (strstart(protocol, "fd:", &p)) {
         fd = monitor_get_fd(monitor_cur(), p, errp);
         if (fd == -1) {
             return;
@@ -2178,7 +2179,7 @@ void qmp_dump_guest_memory(bool paging, const char *file,
     }
 #endif
 
-    if  (strstart(file, "file:", &p)) {
+    if  (strstart(protocol, "file:", &p)) {
         fd = qemu_open_old(p, O_WRONLY | O_CREAT | O_TRUNC | O_BINARY, S_IRUSR);
         if (fd < 0) {
             error_setg_file_open(errp, errno, p);
-- 
2.41.0


