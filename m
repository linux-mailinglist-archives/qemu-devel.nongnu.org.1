Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C87482B397
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 18:03:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNyQg-00041s-Nw; Thu, 11 Jan 2024 12:01:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rNyQW-0003rb-Hb
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 12:01:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rNyQU-0003e5-R5
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 12:01:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704992466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RcyeY/MkZHjETcJIu32Fu3aVXWa7llBiMIYJjXJjN0E=;
 b=KfK0rYPK9caT9ww7GBCvbtqTs4CvAH1YSfVYmPq59yrd3HH/y5kvZAbg5Es/82OSTeXIGX
 /Ppkd9/mK+X1eoqPOqtHsoe6cMw76nPGSej1nSOzu263HP/aiQ6zxnxYtTsz7UeXuXZYRT
 wH5pSBrRU2YTYXCrv3VNjZsdeVNu848=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-lVVlRx7PMzasb0meflr2fQ-1; Thu, 11 Jan 2024 12:01:02 -0500
X-MC-Unique: lVVlRx7PMzasb0meflr2fQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5C0DB185A784;
 Thu, 11 Jan 2024 17:01:02 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AB5CC51D5;
 Thu, 11 Jan 2024 17:01:00 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 07/17] net: handle QIOTask completion to report useful error
 message
Date: Thu, 11 Jan 2024 18:00:36 +0100
Message-ID: <20240111170047.909117-8-thuth@redhat.com>
In-Reply-To: <20240111170047.909117-1-thuth@redhat.com>
References: <20240111170047.909117-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.467,
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

From: Daniel P. Berrangé <berrange@redhat.com>

The network stream backend uses the async QIO socket APIs for listening
and connecting sockets. It does not check the task object completion
status, however, instead just looking at whether the socket FD is -1
or not.

By checking the task completion, we can set a useful error message for
users instead of the non-actionable "connection error" string.

eg so users will see:

(qemu) info network
net: index=0,type=stream,error: Failed to connect to '/foo.unix': No such file or directory

Signed-off-by: "Daniel P. Berrangé" <berrange@redhat.com>
Message-ID: <20240104162942.211458-6-berrange@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 net/stream.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/net/stream.c b/net/stream.c
index 0defb21d45..97e6ec6679 100644
--- a/net/stream.c
+++ b/net/stream.c
@@ -165,6 +165,7 @@ static gboolean net_stream_send(QIOChannel *ioc,
             s->ioc_write_tag = 0;
         }
         if (s->listener) {
+            qemu_set_info_str(&s->nc, "listening");
             qio_net_listener_set_client_func(s->listener, net_stream_listen,
                                              s, NULL);
         }
@@ -173,7 +174,6 @@ static gboolean net_stream_send(QIOChannel *ioc,
 
         net_socket_rs_init(&s->rs, net_stream_rs_finalize, false);
         s->nc.link_down = true;
-        qemu_set_info_str(&s->nc, "listening");
 
         qapi_event_send_netdev_stream_disconnected(s->nc.name);
         net_stream_arm_reconnect(s);
@@ -272,9 +272,11 @@ static void net_stream_server_listening(QIOTask *task, gpointer opaque)
     QIOChannelSocket *listen_sioc = QIO_CHANNEL_SOCKET(s->listen_ioc);
     SocketAddress *addr;
     int ret;
+    Error *err = NULL;
 
-    if (listen_sioc->fd < 0) {
-        qemu_set_info_str(&s->nc, "connection error");
+    if (qio_task_propagate_error(task, &err)) {
+        qemu_set_info_str(&s->nc, "error: %s", error_get_pretty(err));
+        error_free(err);
         return;
     }
 
@@ -327,9 +329,11 @@ static void net_stream_client_connected(QIOTask *task, gpointer opaque)
     SocketAddress *addr;
     gchar *uri;
     int ret;
+    Error *err = NULL;
 
-    if (sioc->fd < 0) {
-        qemu_set_info_str(&s->nc, "connection error");
+    if (qio_task_propagate_error(task, &err)) {
+        qemu_set_info_str(&s->nc, "error: %s", error_get_pretty(err));
+        error_free(err);
         goto error;
     }
 
@@ -384,6 +388,7 @@ static gboolean net_stream_reconnect(gpointer data)
 static void net_stream_arm_reconnect(NetStreamState *s)
 {
     if (s->reconnect && s->timer_tag == 0) {
+        qemu_set_info_str(&s->nc, "connecting");
         s->timer_tag = g_timeout_add_seconds(s->reconnect,
                                              net_stream_reconnect, s);
     }
-- 
2.43.0


