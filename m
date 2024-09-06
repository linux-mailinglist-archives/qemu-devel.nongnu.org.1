Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FED896E923
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Sep 2024 07:22:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smRNz-00023H-Ir; Fri, 06 Sep 2024 01:19:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smRNp-0000P2-Fn; Fri, 06 Sep 2024 01:19:45 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smRNn-0008MY-D0; Fri, 06 Sep 2024 01:19:45 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 60F5E8C138;
 Fri,  6 Sep 2024 08:15:18 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 102AA13337D;
 Fri,  6 Sep 2024 08:16:36 +0300 (MSK)
Received: (nullmailer pid 10492 invoked by uid 1000);
 Fri, 06 Sep 2024 05:16:34 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eric Blake <eblake@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.14 35/40] nbd/server: CVE-2024-7409: Avoid use-after-free
 when closing server
Date: Fri,  6 Sep 2024 08:16:23 +0300
Message-Id: <20240906051633.10288-35-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.14-20240906080824@cover.tls.msk.ru>
References: <qemu-stable-7.2.14-20240906080824@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Eric Blake <eblake@redhat.com>

Commit 3e7ef738 plugged the use-after-free of the global nbd_server
object, but overlooked a use-after-free of nbd_server->listener.
Although this race is harder to hit, notice that our shutdown path
first drops the reference count of nbd_server->listener, then triggers
actions that can result in a pending client reaching the
nbd_blockdev_client_closed() callback, which in turn calls
qio_net_listener_set_client_func on a potentially stale object.

If we know we don't want any more clients to connect, and have already
told the listener socket to shut down, then we should not be trying to
update the listener socket's associated function.

Reproducer:

> #!/usr/bin/python3
>
> import os
> from threading import Thread
>
> def start_stop():
>     while 1:
>         os.system('virsh qemu-monitor-command VM \'{"execute": "nbd-server-start",
+"arguments":{"addr":{"type":"unix","data":{"path":"/tmp/nbd-sock"}}}}\'')
>         os.system('virsh qemu-monitor-command VM \'{"execute": "nbd-server-stop"}\'')
>
> def nbd_list():
>     while 1:
>         os.system('/path/to/build/qemu-nbd -L -k /tmp/nbd-sock')
>
> def test():
>     sst = Thread(target=start_stop)
>     sst.start()
>     nlt = Thread(target=nbd_list)
>     nlt.start()
>
>     sst.join()
>     nlt.join()
>
> test()

Fixes: CVE-2024-7409
Fixes: 3e7ef738c8 ("nbd/server: CVE-2024-7409: Close stray clients at server-stop")
CC: qemu-stable@nongnu.org
Reported-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-ID: <20240822143617.800419-2-eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
(cherry picked from commit 3874f5f73c441c52f1c699c848d463b0eda01e4c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index fea92a0046..e06c26b0af 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -92,10 +92,13 @@ static void nbd_accept(QIONetListener *listener, QIOChannelSocket *cioc,
 
 static void nbd_update_server_watch(NBDServerData *s)
 {
-    if (!s->max_connections || s->connections < s->max_connections) {
-        qio_net_listener_set_client_func(s->listener, nbd_accept, NULL, NULL);
-    } else {
-        qio_net_listener_set_client_func(s->listener, NULL, NULL, NULL);
+    if (s->listener) {
+        if (!s->max_connections || s->connections < s->max_connections) {
+            qio_net_listener_set_client_func(s->listener, nbd_accept, NULL,
+                                             NULL);
+        } else {
+            qio_net_listener_set_client_func(s->listener, NULL, NULL, NULL);
+        }
     }
 }
 
@@ -113,6 +116,7 @@ static void nbd_server_free(NBDServerData *server)
      */
     qio_net_listener_disconnect(server->listener);
     object_unref(OBJECT(server->listener));
+    server->listener = NULL;
     QLIST_FOREACH_SAFE(conn, &server->conns, next, tmp) {
         qio_channel_shutdown(QIO_CHANNEL(conn->cioc), QIO_CHANNEL_SHUTDOWN_BOTH,
                              NULL);
-- 
2.39.2


