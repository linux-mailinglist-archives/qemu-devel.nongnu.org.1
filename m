Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE714824638
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 17:30:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLQba-0007QY-3J; Thu, 04 Jan 2024 11:30:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rLQbX-0007PJ-Ms
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 11:29:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rLQbV-0002Id-Vm
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 11:29:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704385797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PO022ogkCYNvkRsxlXJxq9bB2wwkwHlXSTOlCW9k6Mk=;
 b=M3OHMlvWOEbPu7Vpe2ZseZeoDjCXtuEZlLcVOrjp50sQxj9C2i23AZ1sLg2++0SPuizJoo
 0S3xRS0/zu0JWEUx5VwF/DemhV+/QZ1BFNGNSPaeXyPxXxQnGmcbApzzNwoZrqDsCyYo+o
 opTZ19bpARsoknqenZUdqMmHttfNnbU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-odxg7bIXNNmhRO_Ngh4QDg-1; Thu, 04 Jan 2024 11:29:55 -0500
X-MC-Unique: odxg7bIXNNmhRO_Ngh4QDg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 98046101AA49;
 Thu,  4 Jan 2024 16:29:55 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.113])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 86AB81C060AF;
 Thu,  4 Jan 2024 16:29:53 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4/6] net: add explicit info about connecting/listening state
Date: Thu,  4 Jan 2024 16:29:40 +0000
Message-ID: <20240104162942.211458-5-berrange@redhat.com>
In-Reply-To: <20240104162942.211458-1-berrange@redhat.com>
References: <20240104162942.211458-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.691,
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

When running 'info network', if the stream backend is still in
the process of connecting, or waiting for an incoming connection,
no information is displayed.

There is also no way to distinguish whether the server is still
in the process of setting up the listener socket, or whether it
is ready to accept incoming client connections.

This leads to a race condition in the netdev-socket qtest which
launches a server process followed by a client process. Under
high load conditions it is possible for the client to attempt
to connect before the server is accepting clients. For the
scenarios which do not set the 'reconnect' option, this opens
up a race which can lead to the test scenario failing to reach
the expected state.

Now that 'info network' can distinguish between initialization
phase and the listening phase, the netdev-socket qtest will
correctly synchronize, such that the client QEMU is not spawned
until the server is ready.

This should solve the non-deterministic failures seen with the
netdev-socket qtest.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 net/stream.c                |  5 ++++-
 tests/qtest/netdev-socket.c | 10 +++++-----
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/stream.c b/net/stream.c
index 9204b4c96e..0defb21d45 100644
--- a/net/stream.c
+++ b/net/stream.c
@@ -173,7 +173,7 @@ static gboolean net_stream_send(QIOChannel *ioc,
 
         net_socket_rs_init(&s->rs, net_stream_rs_finalize, false);
         s->nc.link_down = true;
-        qemu_set_info_str(&s->nc, "%s", "");
+        qemu_set_info_str(&s->nc, "listening");
 
         qapi_event_send_netdev_stream_disconnected(s->nc.name);
         net_stream_arm_reconnect(s);
@@ -292,6 +292,7 @@ static void net_stream_server_listening(QIOTask *task, gpointer opaque)
     s->nc.link_down = true;
     s->listener = qio_net_listener_new();
 
+    qemu_set_info_str(&s->nc, "listening");
     net_socket_rs_init(&s->rs, net_stream_rs_finalize, false);
     qio_net_listener_set_client_func(s->listener, net_stream_listen, s, NULL);
     qio_net_listener_add(s->listener, listen_sioc);
@@ -309,6 +310,7 @@ static int net_stream_server_init(NetClientState *peer,
 
     nc = qemu_new_net_client(&net_stream_info, peer, model, name);
     s = DO_UPCAST(NetStreamState, nc, nc);
+    qemu_set_info_str(&s->nc, "initializing");
 
     s->listen_ioc = QIO_CHANNEL(listen_sioc);
     qio_channel_socket_listen_async(listen_sioc, addr, 0,
@@ -400,6 +402,7 @@ static int net_stream_client_init(NetClientState *peer,
 
     nc = qemu_new_net_client(&net_stream_info, peer, model, name);
     s = DO_UPCAST(NetStreamState, nc, nc);
+    qemu_set_info_str(&s->nc, "connecting");
 
     s->ioc = QIO_CHANNEL(sioc);
     s->nc.link_down = true;
diff --git a/tests/qtest/netdev-socket.c b/tests/qtest/netdev-socket.c
index 3fc2ac26d0..91441f7922 100644
--- a/tests/qtest/netdev-socket.c
+++ b/tests/qtest/netdev-socket.c
@@ -127,7 +127,7 @@ static void test_stream_inet_ipv4(void)
                        "addr.ipv4=on,addr.ipv6=off,"
                        "addr.host=127.0.0.1,addr.port=%d", port);
 
-    EXPECT_STATE(qts0, "st0: index=0,type=stream,\r\n", 0);
+    EXPECT_STATE(qts0, "st0: index=0,type=stream,listening\r\n", 0);
 
     qts1 = qtest_initf("-nodefaults -M none "
                        "-netdev stream,server=false,id=st0,addr.type=inet,"
@@ -200,7 +200,7 @@ static void test_stream_unix_reconnect(void)
                        "-netdev stream,id=st0,server=true,addr.type=unix,"
                        "addr.path=%s", path);
 
-    EXPECT_STATE(qts0, "st0: index=0,type=stream,\r\n", 0);
+    EXPECT_STATE(qts0, "st0: index=0,type=stream,listening\r\n", 0);
 
     qts1 = qtest_initf("-nodefaults -M none "
                        "-netdev stream,server=false,id=st0,addr.type=unix,"
@@ -250,7 +250,7 @@ static void test_stream_inet_ipv6(void)
                        "addr.ipv4=off,addr.ipv6=on,"
                        "addr.host=::1,addr.port=%d", port);
 
-    EXPECT_STATE(qts0, "st0: index=0,type=stream,\r\n", 0);
+    EXPECT_STATE(qts0, "st0: index=0,type=stream,listening\r\n", 0);
 
     qts1 = qtest_initf("-nodefaults -M none "
                        "-netdev stream,server=false,id=st0,addr.type=inet,"
@@ -282,7 +282,7 @@ static void test_stream_unix(void)
                        "addr.type=unix,addr.path=%s,",
                        path);
 
-    EXPECT_STATE(qts0, "st0: index=0,type=stream,\r\n", 0);
+    EXPECT_STATE(qts0, "st0: index=0,type=stream,listening\r\n", 0);
 
     qts1 = qtest_initf("-nodefaults -M none "
                        "-netdev stream,id=st0,server=false,"
@@ -314,7 +314,7 @@ static void test_stream_unix_abstract(void)
                        "addr.abstract=on",
                        path);
 
-    EXPECT_STATE(qts0, "st0: index=0,type=stream,\r\n", 0);
+    EXPECT_STATE(qts0, "st0: index=0,type=stream,listening\r\n", 0);
 
     qts1 = qtest_initf("-nodefaults -M none "
                        "-netdev stream,id=st0,server=false,"
-- 
2.43.0


