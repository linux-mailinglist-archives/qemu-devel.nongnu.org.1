Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC363713992
	for <lists+qemu-devel@lfdr.de>; Sun, 28 May 2023 15:22:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3GKP-0007c8-Br; Sun, 28 May 2023 09:20:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1q3GKK-0007bv-R9
 for qemu-devel@nongnu.org; Sun, 28 May 2023 09:20:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1q3GKJ-00086J-Am
 for qemu-devel@nongnu.org; Sun, 28 May 2023 09:20:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685280050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NUFG6LpDTdzMtRwgpzbhoUfL9DwDLFUSWHTITN63a7s=;
 b=JhnHqY4fIdFIzCvelZ06d16Qcz0Cwt0+bykBPeM9422h0tOi4Skfbsen2NE/H4ZsjG57Dh
 6sMg5grpV4VyaliDOdj3gb08j5fYm1vUEal7c6/QL6J3Bhei1sTMr0wuooyGtjk14n5tno
 cpRRNlHS9AU5P5l9Og6pC6FhQQfNS+8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-269-LMdQ1GMiPHu5cUDBdDIz4Q-1; Sun, 28 May 2023 09:20:46 -0400
X-MC-Unique: LMdQ1GMiPHu5cUDBdDIz4Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6673D85A5A8;
 Sun, 28 May 2023 13:20:46 +0000 (UTC)
Received: from localhost (unknown [10.39.208.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 587B72166B2B;
 Sun, 28 May 2023 13:20:45 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, berrange@redhat.com,
 Eric Blake <eblake@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 06/19] win32: wrap socket close() with an exception handler
Date: Sun, 28 May 2023 17:20:03 +0400
Message-Id: <20230528132016.3218152-7-marcandre.lureau@redhat.com>
In-Reply-To: <20230528132016.3218152-1-marcandre.lureau@redhat.com>
References: <20230528132016.3218152-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.164,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Since commit abe34282 ("win32: avoid mixing SOCKET and file descriptor
space"), we set HANDLE_FLAG_PROTECT_FROM_CLOSE on the socket FD, to
prevent closing the HANDLE with CloseHandle. This raises an exception
which under gdb is fatal, and qemu exits.

Let's catch the expected error instead.

Note: this appears to work, but the mingw64 macro is not well documented
or tested, and it's not obvious how it is meant to be used.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20230515132440.1025315-1-marcandre.lureau@redhat.com>
---
 include/sysemu/os-win32.h |  4 ++++
 util/oslib-win32.c        | 23 +++++++++++++++++------
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/include/sysemu/os-win32.h b/include/sysemu/os-win32.h
index 15c296e0eb..65f6c9ea57 100644
--- a/include/sysemu/os-win32.h
+++ b/include/sysemu/os-win32.h
@@ -259,6 +259,10 @@ ssize_t qemu_recv_wrap(int sockfd, void *buf, size_t len, int flags);
 ssize_t qemu_recvfrom_wrap(int sockfd, void *buf, size_t len, int flags,
                            struct sockaddr *addr, socklen_t *addrlen);
 
+EXCEPTION_DISPOSITION
+win32_close_exception_handler(struct _EXCEPTION_RECORD*, void*,
+                              struct _CONTEXT*, void*);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index a98638729a..fafbab80b4 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -479,6 +479,13 @@ int qemu_bind_wrap(int sockfd, const struct sockaddr *addr,
     return ret;
 }
 
+EXCEPTION_DISPOSITION
+win32_close_exception_handler(struct _EXCEPTION_RECORD*,
+                              void*, struct _CONTEXT*, void*)
+{
+    return EXCEPTION_EXECUTE_HANDLER;
+}
+
 #undef close
 int qemu_close_socket_osfhandle(int fd)
 {
@@ -504,12 +511,16 @@ int qemu_close_socket_osfhandle(int fd)
         return -1;
     }
 
-    /*
-     * close() returns EBADF since we PROTECT_FROM_CLOSE the underlying handle,
-     * but the FD is actually freed
-     */
-    if (close(fd) < 0 && errno != EBADF) {
-        return -1;
+    __try1(win32_close_exception_handler) {
+        /*
+         * close() returns EBADF since we PROTECT_FROM_CLOSE the underlying
+         * handle, but the FD is actually freed
+         */
+        if (close(fd) < 0 && errno != EBADF) {
+            return -1;
+        }
+    }
+    __except1 {
     }
 
     if (!SetHandleInformation((HANDLE)s, flags, flags)) {
-- 
2.40.1


