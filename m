Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E57BB80CF8
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Sep 2025 17:59:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyqik-0003gQ-Hc; Wed, 17 Sep 2025 07:53:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uyqi1-00035Y-PX
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 07:52:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uyqhw-0003ki-BH
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 07:52:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758109938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ri5RghWLVXRz9tcDloYR8x0uesVdTFc/iLex6qYjpT4=;
 b=BLOzno7EGikzd1ULTjqSN8Tx4l4nf/ygjmhZJwqeNhdRi+A3hrshT+4xD1wOnuN6+RfYna
 sKIWS6ohP7hdtEEzKd7qhHn9AB8VXDvZd7pC080ZLqHVFB8qDn1hHSy7DrJk1jU7MJXyYN
 VI+GnNQOcdOOv8DleunD8m3oc34uxd0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-16-PT1b_-4oP4yswLPBixSJcQ-1; Wed,
 17 Sep 2025 07:52:14 -0400
X-MC-Unique: PT1b_-4oP4yswLPBixSJcQ-1
X-Mimecast-MFC-AGG-ID: PT1b_-4oP4yswLPBixSJcQ_1758109933
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BB1481956046; Wed, 17 Sep 2025 11:52:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.9])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6F1231800577; Wed, 17 Sep 2025 11:52:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5418321E677A; Wed, 17 Sep 2025 13:52:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: odaki@rsg.ci.i.u-tokyo.ac.jp, marcandre.lureau@redhat.com,
 berrange@redhat.com
Subject: [PATCH v2 08/12] util/oslib-win32: Do not treat null @errp as
 &error_warn
Date: Wed, 17 Sep 2025 13:52:03 +0200
Message-ID: <20250917115207.1730186-9-armbru@redhat.com>
In-Reply-To: <20250917115207.1730186-1-armbru@redhat.com>
References: <20250917115207.1730186-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

qemu_socket_select() and its wrapper qemu_socket_unselect() treat a
null @errp as &error_warn.  This is wildly inappropriate.  A caller
passing null @errp specifies that errors are to be ignored.  If
warnings are wanted, the caller must pass &error_warn.

Change callers to do that, and drop the inappropriate treatment of
null @errp.

This assumes that warnings are wanted.  I'm not familiar with the
calling code, so I can't say whether it will work when the socket is
invalid, or WSAEventSelect() fails.  If it doesn't, then this should
be an error instead of a warning.  Invalid socket might even be a
programming error.

These warnings were introduced in commit f5fd677ae7cf (win32/socket:
introduce qemu_socket_select() helper).  I considered reverting to
silence, but Daniel Berrangé asked for the warnings to be preserved.

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 io/channel-socket.c | 4 ++--
 io/channel-watch.c  | 2 +-
 util/aio-win32.c    | 2 +-
 util/oslib-win32.c  | 7 ++-----
 4 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/io/channel-socket.c b/io/channel-socket.c
index 3b7ca924ff..56ef353cd3 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -454,7 +454,7 @@ static void qio_channel_socket_finalize(Object *obj)
             }
         }
 #ifdef WIN32
-        qemu_socket_unselect(ioc->fd, NULL);
+        qemu_socket_unselect(ioc->fd, &error_warn);
 #endif
         close(ioc->fd);
         ioc->fd = -1;
@@ -890,7 +890,7 @@ qio_channel_socket_close(QIOChannel *ioc,
 
     if (sioc->fd != -1) {
 #ifdef WIN32
-        qemu_socket_unselect(sioc->fd, NULL);
+        qemu_socket_unselect(sioc->fd, &error_warn);
 #endif
         if (qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_LISTEN)) {
             socket_listen_cleanup(sioc->fd, errp);
diff --git a/io/channel-watch.c b/io/channel-watch.c
index 64b486e378..ec76bd1ec6 100644
--- a/io/channel-watch.c
+++ b/io/channel-watch.c
@@ -283,7 +283,7 @@ GSource *qio_channel_create_socket_watch(QIOChannel *ioc,
 
     qemu_socket_select(sockfd, ioc->event,
                        FD_READ | FD_ACCEPT | FD_CLOSE |
-                       FD_CONNECT | FD_WRITE | FD_OOB, NULL);
+                       FD_CONNECT | FD_WRITE | FD_OOB, &error_warn);
 
     source = g_source_new(&qio_channel_socket_source_funcs,
                           sizeof(QIOChannelSocketSource));
diff --git a/util/aio-win32.c b/util/aio-win32.c
index 6583d5c5f3..b125924433 100644
--- a/util/aio-win32.c
+++ b/util/aio-win32.c
@@ -121,7 +121,7 @@ void aio_set_fd_handler(AioContext *ctx,
 
         QLIST_INSERT_HEAD_RCU(&ctx->aio_handlers, node, node);
         event = event_notifier_get_handle(&ctx->notifier);
-        qemu_socket_select(fd, event, bitmask, NULL);
+        qemu_socket_select(fd, event, bitmask, &error_warn);
     }
     if (old_node) {
         aio_remove_fd_handler(ctx, old_node);
diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index b7351634ec..df118b164e 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -180,7 +180,8 @@ static int socket_error(void)
 void qemu_socket_set_block(int fd)
 {
     unsigned long opt = 0;
-    qemu_socket_unselect(fd, NULL);
+
+    qemu_socket_unselect(fd, &error_warn);
     ioctlsocket(fd, FIONBIO, &opt);
 }
 
@@ -296,10 +297,6 @@ bool qemu_socket_select(int sockfd, WSAEVENT hEventObject,
 {
     SOCKET s = _get_osfhandle(sockfd);
 
-    if (errp == NULL) {
-        errp = &error_warn;
-    }
-
     if (s == INVALID_SOCKET) {
         error_setg(errp, "invalid socket fd=%d", sockfd);
         return false;
-- 
2.49.0


