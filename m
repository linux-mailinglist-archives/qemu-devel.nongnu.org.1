Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2B0B52D17
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Sep 2025 11:23:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwdUC-0004YU-BY; Thu, 11 Sep 2025 05:21:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uwdU1-0004TP-Cp; Thu, 11 Sep 2025 05:20:50 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uwdTs-0008SW-1d; Thu, 11 Sep 2025 05:20:47 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c23:36c1:0:640:5f85:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id F38F28073E;
 Thu, 11 Sep 2025 12:20:30 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b3c::1:2f])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id QKHlUI0GnCg0-YcnAtCy2; Thu, 11 Sep 2025 12:20:30 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1757582430;
 bh=n7dziCcRLF/FhHFrF7+cC/0eD7OqS37PxvP9mv4SUpU=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=IOLoAUbI8fYIRqznAgALO1yBmXpidPL9aHPROaCHrjKNLN4RpzbaAiLwjUiH1ge5m
 Ekla/j7xthfdh1IC+5yMKTZnYfJ2kifQ8FYcQApz6x0TfceskjB6ypd7xKo/dPm4L1
 l6rr/Sj1F1+HncQuhOZgoAVQmp4zC7V13R06TlYY=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: berrange@redhat.com
Cc: qemu-devel@nongnu.org, peterx@redhat.com, qemu-block@nongnu.org,
 vsementsov@yandex-team.ru, leiyang@redhat.com, marcandre.lureau@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Coiby Xu <Coiby.Xu@gmail.com>
Subject: [PATCH v2 4/8] util: drop qemu_socket_set_nonblock()
Date: Thu, 11 Sep 2025 12:20:02 +0300
Message-ID: <20250911092007.1370002-5-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250911092007.1370002-1-vsementsov@yandex-team.ru>
References: <20250911092007.1370002-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Use common qemu_set_blocking() instead.

Note that pre-patch the behavior of Win32 and Linux realizations
are inconsistent: we ignore failure for Win32, and assert success
for Linux.

How do we convert the callers?

1. Most of callers call qemu_socket_set_nonblock() on a
freshly created socket fd, in conditions when we may simply
report an error. Seems correct switching to error handling
both for Windows (pre-patch error is ignored) and Linux
(pre-patch we assert success). Anyway, we normally don't
expect errors in these cases.

Still in tests let's use &error_abort for simplicity.

What are exclusions?

2. hw/virtio/vhost-user.c - we are inside #ifdef CONFIG_LINUX,
so no damage in switching to error handling from assertion.

3. io/channel-socket.c: here we convert both old calls to
qemu_socket_set_nonblock() and qemu_socket_set_block() to
one new call. Pre-patch we assert success for Linux in
qemu_socket_set_nonblock(), and ignore all other errors here.
Still, all callers pass errp=NULL to qio_channel_set_blocking(),
so after patch we ignore all errors. Switching from assertion
to ignoring may be not very good, but still acceptable, keeping
in mind that all callers of qio_channel_set_blocking() do
explicitly ignore the error.

4. util/vhost-user-server - compiled only for Linux (see
util/meson.build), so we are safe, switching from assertion to
&error_abort.

Note: In qga/channel-posix.c we use g_warning(), where g_printerr()
would actually be a better choice. Still let's for now follow
common style of qga, where g_warning() is commonly used to print
such messages, and no call to g_printerr(). Converting everything
to use g_printerr() should better be another series.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 contrib/ivshmem-server/ivshmem-server.c |  6 +++++-
 hw/hyperv/syndbg.c                      |  4 +++-
 hw/virtio/vhost-user.c                  |  5 ++++-
 include/qemu/sockets.h                  |  1 -
 io/channel-socket.c                     |  7 +++----
 net/dgram.c                             | 16 +++++++++++++---
 net/l2tpv3.c                            |  5 +++--
 net/socket.c                            | 20 ++++++++++++++++----
 qga/channel-posix.c                     |  7 ++++++-
 tests/unit/socket-helpers.c             |  5 ++++-
 tests/unit/test-crypto-tlssession.c     |  8 ++++----
 util/oslib-posix.c                      |  7 -------
 util/oslib-win32.c                      |  5 -----
 util/vhost-user-server.c                |  4 ++--
 14 files changed, 63 insertions(+), 37 deletions(-)

diff --git a/contrib/ivshmem-server/ivshmem-server.c b/contrib/ivshmem-server/ivshmem-server.c
index 2f3c7320a6..a65943d0b8 100644
--- a/contrib/ivshmem-server/ivshmem-server.c
+++ b/contrib/ivshmem-server/ivshmem-server.c
@@ -146,9 +146,13 @@ ivshmem_server_handle_new_conn(IvshmemServer *server)
         return -1;
     }
 
-    qemu_socket_set_nonblock(newfd);
     IVSHMEM_SERVER_DEBUG(server, "accept()=%d\n", newfd);
 
+    if (!qemu_set_blocking(newfd, false, NULL)) {
+        close(newfd);
+        return -1;
+    }
+
     /* allocate new structure for this peer */
     peer = g_malloc0(sizeof(*peer));
     peer->sock_fd = newfd;
diff --git a/hw/hyperv/syndbg.c b/hw/hyperv/syndbg.c
index ac7e15f6f1..bcdfdf6af7 100644
--- a/hw/hyperv/syndbg.c
+++ b/hw/hyperv/syndbg.c
@@ -338,7 +338,9 @@ static void hv_syndbg_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    qemu_socket_set_nonblock(syndbg->socket);
+    if (!qemu_set_blocking(syndbg->socket, false, errp)) {
+        return;
+    }
 
     syndbg->servaddr.sin_port = htons(syndbg->host_port);
     syndbg->servaddr.sin_family = AF_INET;
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 1e1d6b0d6e..36c9c2e04d 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -2039,7 +2039,10 @@ static int vhost_user_postcopy_advise(struct vhost_dev *dev, Error **errp)
         error_setg(errp, "%s: Failed to get ufd", __func__);
         return -EIO;
     }
-    qemu_socket_set_nonblock(ufd);
+    if (!qemu_set_blocking(ufd, false, errp)) {
+        close(ufd);
+        return -EINVAL;
+    }
 
     /* register ufd with userfault thread */
     u->postcopy_fd.fd = ufd;
diff --git a/include/qemu/sockets.h b/include/qemu/sockets.h
index c562690d89..6477f90b9e 100644
--- a/include/qemu/sockets.h
+++ b/include/qemu/sockets.h
@@ -48,7 +48,6 @@ int socket_set_cork(int fd, int v);
 int socket_set_nodelay(int fd);
 void qemu_socket_set_block(int fd);
 int qemu_socket_try_set_nonblock(int fd);
-void qemu_socket_set_nonblock(int fd);
 int socket_set_fast_reuse(int fd);
 
 #ifdef WIN32
diff --git a/io/channel-socket.c b/io/channel-socket.c
index 21f8f2e0c5..f7e3cb9742 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -825,11 +825,10 @@ qio_channel_socket_set_blocking(QIOChannel *ioc,
 {
     QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(ioc);
 
-    if (enabled) {
-        qemu_socket_set_block(sioc->fd);
-    } else {
-        qemu_socket_set_nonblock(sioc->fd);
+    if (!qemu_set_blocking(sioc->fd, enabled, errp)) {
+        return -1;
     }
+
     return 0;
 }
 
diff --git a/net/dgram.c b/net/dgram.c
index 48f653bceb..fb9ded30df 100644
--- a/net/dgram.c
+++ b/net/dgram.c
@@ -226,7 +226,10 @@ static int net_dgram_mcast_create(struct sockaddr_in *mcastaddr,
         }
     }
 
-    qemu_socket_set_nonblock(fd);
+    if (!qemu_set_blocking(fd, false, errp)) {
+        goto fail;
+    }
+
     return fd;
 fail:
     if (fd >= 0) {
@@ -504,7 +507,11 @@ int net_init_dgram(const Netdev *netdev, const char *name,
             close(fd);
             return -1;
         }
-        qemu_socket_set_nonblock(fd);
+
+        if (!qemu_set_blocking(fd, false, errp)) {
+            close(fd);
+            return -1;
+        }
 
         dest_len = sizeof(raddr_in);
         dest_addr = g_malloc(dest_len);
@@ -551,7 +558,10 @@ int net_init_dgram(const Netdev *netdev, const char *name,
             close(fd);
             return -1;
         }
-        qemu_socket_set_nonblock(fd);
+        if (!qemu_set_blocking(fd, false, errp)) {
+            close(fd);
+            return -1;
+        }
 
         dest_len = sizeof(raddr_un);
         dest_addr = g_malloc(dest_len);
diff --git a/net/l2tpv3.c b/net/l2tpv3.c
index b5547cb917..cdfc641aa6 100644
--- a/net/l2tpv3.c
+++ b/net/l2tpv3.c
@@ -648,6 +648,9 @@ int net_init_l2tpv3(const Netdev *netdev,
         error_setg(errp, "could not bind socket err=%i", errno);
         goto outerr;
     }
+    if (!qemu_set_blocking(fd, false, errp)) {
+        goto outerr;
+    }
 
     freeaddrinfo(result);
 
@@ -709,8 +712,6 @@ int net_init_l2tpv3(const Netdev *netdev,
     s->vec = g_new(struct iovec, MAX_L2TPV3_IOVCNT);
     s->header_buf = g_malloc(s->header_size);
 
-    qemu_socket_set_nonblock(fd);
-
     s->fd = fd;
     s->counter = 0;
 
diff --git a/net/socket.c b/net/socket.c
index 784dda686f..db25e3d9ae 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -295,7 +295,10 @@ static int net_socket_mcast_create(struct sockaddr_in *mcastaddr,
         }
     }
 
-    qemu_socket_set_nonblock(fd);
+    if (!qemu_set_blocking(fd, false, errp)) {
+        goto fail;
+    }
+
     return fd;
 fail:
     if (fd >= 0)
@@ -508,7 +511,10 @@ static int net_socket_listen_init(NetClientState *peer,
         error_setg_errno(errp, errno, "can't create stream socket");
         return -1;
     }
-    qemu_socket_set_nonblock(fd);
+    if (!qemu_set_blocking(fd, false, errp)) {
+        close(fd);
+        return -1;
+    }
 
     socket_set_fast_reuse(fd);
 
@@ -556,7 +562,10 @@ static int net_socket_connect_init(NetClientState *peer,
         error_setg_errno(errp, errno, "can't create stream socket");
         return -1;
     }
-    qemu_socket_set_nonblock(fd);
+    if (!qemu_set_blocking(fd, false, errp)) {
+        close(fd);
+        return -1;
+    }
 
     connected = 0;
     for(;;) {
@@ -671,7 +680,10 @@ static int net_socket_udp_init(NetClientState *peer,
         close(fd);
         return -1;
     }
-    qemu_socket_set_nonblock(fd);
+    if (!qemu_set_blocking(fd, false, errp)) {
+        close(fd);
+        return -1;
+    }
 
     s = net_socket_fd_init_dgram(peer, model, name, fd, 0, NULL, errp);
     if (!s) {
diff --git a/qga/channel-posix.c b/qga/channel-posix.c
index 465d688ecb..9ccc8b7bd1 100644
--- a/qga/channel-posix.c
+++ b/qga/channel-posix.c
@@ -28,6 +28,7 @@ static gboolean ga_channel_listen_accept(GIOChannel *channel,
     GAChannel *c = data;
     int ret, client_fd;
     bool accepted = false;
+    Error *err = NULL;
 
     g_assert(channel != NULL);
 
@@ -36,7 +37,11 @@ static gboolean ga_channel_listen_accept(GIOChannel *channel,
         g_warning("error converting fd to gsocket: %s", strerror(errno));
         goto out;
     }
-    qemu_socket_set_nonblock(client_fd);
+    if (!qemu_set_blocking(client_fd, false, &err)) {
+        g_warning("%s", error_get_pretty(err));
+        error_free(err);
+        goto out;
+    }
     ret = ga_channel_client_add(c, client_fd);
     if (ret) {
         g_warning("error setting up connection");
diff --git a/tests/unit/socket-helpers.c b/tests/unit/socket-helpers.c
index 37db24f72a..1b7e283f24 100644
--- a/tests/unit/socket-helpers.c
+++ b/tests/unit/socket-helpers.c
@@ -88,7 +88,10 @@ static int socket_can_bind_connect(const char *hostname, int family)
         goto cleanup;
     }
 
-    qemu_socket_set_nonblock(cfd);
+    if (!qemu_set_blocking(cfd, false, NULL)) {
+        goto cleanup;
+    }
+
     if (connect(cfd, (struct sockaddr *)&ss, sslen) < 0) {
         if (errno == EINPROGRESS) {
             check_soerr = true;
diff --git a/tests/unit/test-crypto-tlssession.c b/tests/unit/test-crypto-tlssession.c
index 554054e934..61311cbe6e 100644
--- a/tests/unit/test-crypto-tlssession.c
+++ b/tests/unit/test-crypto-tlssession.c
@@ -112,8 +112,8 @@ static void test_crypto_tls_session_psk(void)
      * thread, so we need these non-blocking to avoid deadlock
      * of ourselves
      */
-    qemu_socket_set_nonblock(channel[0]);
-    qemu_socket_set_nonblock(channel[1]);
+    qemu_set_blocking(channel[0], false, &error_abort);
+    qemu_set_blocking(channel[1], false, &error_abort);
 
     clientCreds = test_tls_creds_psk_create(
         QCRYPTO_TLS_CREDS_ENDPOINT_CLIENT,
@@ -264,8 +264,8 @@ static void test_crypto_tls_session_x509(const void *opaque)
      * thread, so we need these non-blocking to avoid deadlock
      * of ourselves
      */
-    qemu_socket_set_nonblock(channel[0]);
-    qemu_socket_set_nonblock(channel[1]);
+    qemu_set_blocking(channel[0], false, &error_abort);
+    qemu_set_blocking(channel[1], false, &error_abort);
 
 #define CLIENT_CERT_DIR "tests/test-crypto-tlssession-client/"
 #define SERVER_CERT_DIR "tests/test-crypto-tlssession-server/"
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index c737701075..599993d40d 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -275,13 +275,6 @@ int qemu_socket_try_set_nonblock(int fd)
     return g_unix_set_fd_nonblocking(fd, true, NULL) ? 0 : -errno;
 }
 
-void qemu_socket_set_nonblock(int fd)
-{
-    int f;
-    f = qemu_socket_try_set_nonblock(fd);
-    assert(f == 0);
-}
-
 int socket_set_fast_reuse(int fd)
 {
     int val = 1, ret;
diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index 03044f5b59..1566eb57e7 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -211,11 +211,6 @@ int qemu_socket_try_set_nonblock(int fd)
     return 0;
 }
 
-void qemu_socket_set_nonblock(int fd)
-{
-    (void)qemu_socket_try_set_nonblock(fd);
-}
-
 int socket_set_fast_reuse(int fd)
 {
     /* Enabling the reuse of an endpoint that was used by a socket still in
diff --git a/util/vhost-user-server.c b/util/vhost-user-server.c
index b19229074a..8dcd32dc65 100644
--- a/util/vhost-user-server.c
+++ b/util/vhost-user-server.c
@@ -78,7 +78,7 @@ static void vmsg_unblock_fds(VhostUserMsg *vmsg)
     }
 
     for (i = 0; i < vmsg->fd_num; i++) {
-        qemu_socket_set_nonblock(vmsg->fds[i]);
+        qemu_set_blocking(vmsg->fds[i], false, &error_abort);
     }
 }
 
@@ -303,7 +303,7 @@ set_watch(VuDev *vu_dev, int fd, int vu_evt,
 
         vu_fd_watch->fd = fd;
         vu_fd_watch->cb = cb;
-        qemu_socket_set_nonblock(fd);
+        qemu_set_blocking(fd, false, &error_abort);
         aio_set_fd_handler(server->ctx, fd, kick_handler,
                            NULL, NULL, NULL, vu_fd_watch);
         vu_fd_watch->vu_dev = vu_dev;
-- 
2.48.1


