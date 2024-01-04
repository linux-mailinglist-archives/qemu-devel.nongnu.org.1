Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D75FF824639
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 17:30:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLQbh-0007To-SS; Thu, 04 Jan 2024 11:30:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rLQbf-0007T1-1f
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 11:30:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rLQba-0002JH-7U
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 11:30:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704385801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=osu/Rh1SoKvT1kP7US/jM9zDmq2ErI+QYvKDb98yvPU=;
 b=UtnN2X647VFBtBxvQkr+sLJJ9Y5HAagRy3pXd5LEzg5N7P1Uz2dqScV0DFjAKnh9M8m4ZV
 edjHVliJm8adHGZi+McBNg610pe4T3j10CMVWt9VgxyGKsp/Vc/gujF1oVz+3MXU2WN4kh
 smA7s/U0cQXnkSMqG4t0ktHO+K0Kl3U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-Ihe7MNLwPimD1UYNsHaQcA-1; Thu, 04 Jan 2024 11:29:57 -0500
X-MC-Unique: Ihe7MNLwPimD1UYNsHaQcA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 754D1830F97;
 Thu,  4 Jan 2024 16:29:57 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.113])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DD80F1C060AF;
 Thu,  4 Jan 2024 16:29:55 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5/6] net: handle QIOTask completion to report useful error
 message
Date: Thu,  4 Jan 2024 16:29:41 +0000
Message-ID: <20240104162942.211458-6-berrange@redhat.com>
In-Reply-To: <20240104162942.211458-1-berrange@redhat.com>
References: <20240104162942.211458-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The network stream backend uses the async QIO socket APIs for listening
and connecting sockets. It does not check the task object completion
status, however, instead just looking at whether the socket FD is -1
or not.

By checking the task completion, we can set a useful error message for
users instead of the non-actionable "connection error" string.

eg so users will see:

(qemu) info network
net: index=0,type=stream,error: Failed to connect to '/foo.unix': No such file or directory

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
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


