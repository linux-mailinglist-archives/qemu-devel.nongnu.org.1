Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17675B41A6C
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Sep 2025 11:47:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utk2f-0006AK-IE; Wed, 03 Sep 2025 05:44:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utk2U-00066L-DQ; Wed, 03 Sep 2025 05:44:27 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utk2R-0007vZ-KU; Wed, 03 Sep 2025 05:44:26 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c21:2d8b:0:640:7d49:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id B5CE9807AC;
 Wed, 03 Sep 2025 12:44:21 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b8f::1:11])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id EicMoq3GhCg0-hpyxFrqc; Wed, 03 Sep 2025 12:44:21 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1756892661;
 bh=irwXYky4BmEjlrsjMDSVpln+Q+lnheCMLPQaCIlhUzM=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=w5B7JgqwY6g/+pvIDeKt0/rQr/lBLcYiMQVObewhQUk1zSswFrN7V4w4EfjS8P8+V
 0pOjn+bYXzD5dbVcLSyHlmx1/7qzl08gazY0TvLMgJBLMzTriUZ1RXMyosYxEzIgbm
 H5vzGKEkntj4kYYO4XkYI5dY59P+YSPFtk7oUs+s=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: berrange@redhat.com
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, peterx@redhat.com,
 vsementsov@yandex-team.ru,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Bandan Das <bsd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Darren Kenny <darren.kenny@oracle.com>, Qiuhao Li <Qiuhao.Li@outlook.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH 07/10] use qemu_set_blocking instead of
 g_unix_set_fd_nonblocking
Date: Wed,  3 Sep 2025 12:44:07 +0300
Message-ID: <20250903094411.1029449-8-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250903094411.1029449-1-vsementsov@yandex-team.ru>
References: <20250903094411.1029449-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Instead of open-coded g_unix_set_fd_nonblocking() calls, use
QEMU wrapper qemu_socket_set_nonblock().

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 chardev/char-fd.c                  |  4 ++--
 chardev/char-pty.c                 |  3 +--
 chardev/char-serial.c              |  3 +--
 chardev/char-stdio.c               |  3 +--
 hw/input/virtio-input-host.c       |  3 +--
 hw/misc/ivshmem-flat.c             |  4 +++-
 hw/misc/ivshmem-pci.c              |  8 +++++++-
 hw/virtio/vhost-vsock.c            |  8 ++------
 io/channel-command.c               |  9 ++++++---
 io/channel-file.c                  |  3 +--
 net/tap-bsd.c                      | 12 ++++++++++--
 net/tap-linux.c                    |  8 +++++++-
 net/tap-solaris.c                  |  7 ++++++-
 net/tap.c                          | 21 ++++++---------------
 qga/commands-posix.c               |  3 +--
 tests/qtest/fuzz/virtio_net_fuzz.c |  2 +-
 tests/qtest/vhost-user-test.c      |  3 +--
 tests/unit/test-iov.c              |  5 +++--
 ui/input-linux.c                   |  3 +--
 util/event_notifier-posix.c        |  5 +++--
 util/main-loop.c                   |  6 +++++-
 21 files changed, 69 insertions(+), 54 deletions(-)

diff --git a/chardev/char-fd.c b/chardev/char-fd.c
index 6f03adf872..739dc68c36 100644
--- a/chardev/char-fd.c
+++ b/chardev/char-fd.c
@@ -212,8 +212,8 @@ void qemu_chr_open_fd(Chardev *chr,
     FDChardev *s = FD_CHARDEV(chr);
     g_autofree char *name = NULL;
 
-    if (fd_out >= 0 && !g_unix_set_fd_nonblocking(fd_out, true, NULL)) {
-        assert(!"Failed to set FD nonblocking");
+    if (fd_out >= 0) {
+        qemu_set_blocking(fd_out, false, &error_abort);
     }
 
     if (fd_out == fd_in && fd_in >= 0) {
diff --git a/chardev/char-pty.c b/chardev/char-pty.c
index 674e9b3f14..fe6bfb043d 100644
--- a/chardev/char-pty.c
+++ b/chardev/char-pty.c
@@ -349,8 +349,7 @@ static void char_pty_open(Chardev *chr,
     }
 
     close(slave_fd);
-    if (!g_unix_set_fd_nonblocking(master_fd, true, NULL)) {
-        error_setg_errno(errp, errno, "Failed to set FD nonblocking");
+    if (!qemu_set_blocking(master_fd, false, errp)) {
         return;
     }
 
diff --git a/chardev/char-serial.c b/chardev/char-serial.c
index 0a68b4b4e0..1ff31dcde3 100644
--- a/chardev/char-serial.c
+++ b/chardev/char-serial.c
@@ -271,8 +271,7 @@ static void qmp_chardev_open_serial(Chardev *chr,
     if (fd < 0) {
         return;
     }
-    if (!g_unix_set_fd_nonblocking(fd, true, NULL)) {
-        error_setg_errno(errp, errno, "Failed to set FD nonblocking");
+    if (!qemu_set_blocking(fd, false, errp)) {
         return;
     }
     tty_serial_init(fd, 115200, 'N', 8, 1);
diff --git a/chardev/char-stdio.c b/chardev/char-stdio.c
index 48db8d2f30..193727e807 100644
--- a/chardev/char-stdio.c
+++ b/chardev/char-stdio.c
@@ -107,8 +107,7 @@ static void qemu_chr_open_stdio(Chardev *chr,
     old_fd0_flags = fcntl(0, F_GETFL);
     old_fd1_flags = fcntl(1, F_GETFL);
     tcgetattr(0, &oldtty);
-    if (!g_unix_set_fd_nonblocking(0, true, NULL)) {
-        error_setg_errno(errp, errno, "Failed to set FD nonblocking");
+    if (!qemu_set_blocking(0, false, errp)) {
         return;
     }
     atexit(term_exit);
diff --git a/hw/input/virtio-input-host.c b/hw/input/virtio-input-host.c
index bbfee9d3b9..9f62532559 100644
--- a/hw/input/virtio-input-host.c
+++ b/hw/input/virtio-input-host.c
@@ -114,8 +114,7 @@ static void virtio_input_host_realize(DeviceState *dev, Error **errp)
         error_setg_file_open(errp, errno, vih->evdev);
         return;
     }
-    if (!g_unix_set_fd_nonblocking(vih->fd, true, NULL)) {
-        error_setg_errno(errp, errno, "Failed to set FD nonblocking");
+    if (!qemu_set_blocking(vih->fd, false, errp)) {
         goto err_close;
     }
 
diff --git a/hw/misc/ivshmem-flat.c b/hw/misc/ivshmem-flat.c
index fe4be6be17..29f298bbcb 100644
--- a/hw/misc/ivshmem-flat.c
+++ b/hw/misc/ivshmem-flat.c
@@ -12,6 +12,7 @@
 #include "qemu/units.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
+#include "qemu/sockets.h"
 #include "qapi/error.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties-system.h"
@@ -154,7 +155,8 @@ static void ivshmem_flat_add_vector(IvshmemFTState *s, IvshmemPeer *peer,
      * peer.
      */
     peer->vector[peer->vector_counter].id = peer->vector_counter;
-    g_unix_set_fd_nonblocking(vector_fd, true, NULL);
+    /* WARNING: qemu_socket_set_nonblock() return code ignored */
+    qemu_set_blocking(vector_fd, false, NULL);
     event_notifier_init_fd(&peer->vector[peer->vector_counter].event_notifier,
                            vector_fd);
 
diff --git a/hw/misc/ivshmem-pci.c b/hw/misc/ivshmem-pci.c
index d47ae739d6..b7da89fe3a 100644
--- a/hw/misc/ivshmem-pci.c
+++ b/hw/misc/ivshmem-pci.c
@@ -21,6 +21,7 @@
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "qemu/cutils.h"
+#include "qemu/sockets.h"
 #include "hw/pci/pci.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
@@ -540,7 +541,12 @@ static void process_msg_connect(IVShmemState *s, uint16_t posn, int fd,
 
     IVSHMEM_DPRINTF("eventfds[%d][%d] = %d\n", posn, vector, fd);
     event_notifier_init_fd(&peer->eventfds[vector], fd);
-    g_unix_set_fd_nonblocking(fd, true, NULL); /* msix/irqfd poll non block */
+
+    /* msix/irqfd poll non block */
+    if (!qemu_set_blocking(fd, false, errp)) {
+        close(fd);
+        return;
+    }
 
     if (posn == s->vm_id) {
         setup_interrupt(s, vector, errp);
diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index 6e4088831f..107d88babe 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -147,9 +147,7 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
             return;
         }
 
-        if (!g_unix_set_fd_nonblocking(vhostfd, true, NULL)) {
-            error_setg_errno(errp, errno,
-                             "vhost-vsock: unable to set non-blocking mode");
+        if (!qemu_set_blocking(vhostfd, false, errp)) {
             return;
         }
     } else {
@@ -160,9 +158,7 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
             return;
         }
 
-        if (!g_unix_set_fd_nonblocking(vhostfd, true, NULL)) {
-            error_setg_errno(errp, errno,
-                             "Failed to set FD nonblocking");
+        if (!qemu_set_blocking(vhostfd, false, errp)) {
             return;
         }
     }
diff --git a/io/channel-command.c b/io/channel-command.c
index 8966dd3a2b..8ae9a026b3 100644
--- a/io/channel-command.c
+++ b/io/channel-command.c
@@ -277,9 +277,12 @@ static int qio_channel_command_set_blocking(QIOChannel *ioc,
     cioc->blocking = enabled;
 #else
 
-    if ((cioc->writefd >= 0 && !g_unix_set_fd_nonblocking(cioc->writefd, !enabled, NULL)) ||
-        (cioc->readfd >= 0 && !g_unix_set_fd_nonblocking(cioc->readfd, !enabled, NULL))) {
-        error_setg_errno(errp, errno, "Failed to set FD nonblocking");
+    if (cioc->writefd >= 0 &&
+        !qemu_set_blocking(cioc->writefd, enabled, errp)) {
+        return -1;
+    }
+    if (cioc->readfd >= 0 &&
+        !qemu_set_blocking(cioc->readfd, enabled, errp)) {
         return -1;
     }
 #endif
diff --git a/io/channel-file.c b/io/channel-file.c
index ca3f180cc2..5cef75a67c 100644
--- a/io/channel-file.c
+++ b/io/channel-file.c
@@ -223,8 +223,7 @@ static int qio_channel_file_set_blocking(QIOChannel *ioc,
 #else
     QIOChannelFile *fioc = QIO_CHANNEL_FILE(ioc);
 
-    if (!g_unix_set_fd_nonblocking(fioc->fd, !enabled, NULL)) {
-        error_setg_errno(errp, errno, "Failed to set FD nonblocking");
+    if (!qemu_set_blocking(fioc->fd, enabled, errp)) {
         return -1;
     }
     return 0;
diff --git a/net/tap-bsd.c b/net/tap-bsd.c
index b4c84441ba..2e444e59b5 100644
--- a/net/tap-bsd.c
+++ b/net/tap-bsd.c
@@ -98,7 +98,12 @@ int tap_open(char *ifname, int ifname_size, int *vnet_hdr,
             return -1;
         }
     }
-    g_unix_set_fd_nonblocking(fd, true, NULL);
+
+    if (!qemu_set_blocking(fd, false, errp) {
+        close(fd);
+        return -1;
+    }
+
     return fd;
 }
 
@@ -189,7 +194,10 @@ int tap_open(char *ifname, int ifname_size, int *vnet_hdr,
         goto error;
     }
 
-    g_unix_set_fd_nonblocking(fd, true, NULL);
+    if (!qemu_set_blocking(fd, false, errp) {
+        goto error;
+    }
+
     return fd;
 
 error:
diff --git a/net/tap-linux.c b/net/tap-linux.c
index 22ec2f45d2..786f339c13 100644
--- a/net/tap-linux.c
+++ b/net/tap-linux.c
@@ -34,6 +34,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/cutils.h"
+#include "qemu/sockets.h"
 
 #define PATH_NET_TUN "/dev/net/tun"
 
@@ -124,7 +125,12 @@ int tap_open(char *ifname, int ifname_size, int *vnet_hdr,
         return -1;
     }
     pstrcpy(ifname, ifname_size, ifr.ifr_name);
-    g_unix_set_fd_nonblocking(fd, true, NULL);
+
+    if (!qemu_set_blocking(fd, false, NULL)) {
+        close(fd);
+        return -1;
+    }
+
     return fd;
 }
 
diff --git a/net/tap-solaris.c b/net/tap-solaris.c
index 51b7830bef..02709590c1 100644
--- a/net/tap-solaris.c
+++ b/net/tap-solaris.c
@@ -198,7 +198,12 @@ int tap_open(char *ifname, int ifname_size, int *vnet_hdr,
             return -1;
         }
     }
-    g_unix_set_fd_nonblocking(fd, true, NULL);
+
+    if (!qemu_set_blocking(fd, false NULL)) {
+        close(fd);
+        return -1;
+    }
+
     return fd;
 }
 
diff --git a/net/tap.c b/net/tap.c
index f7df702f97..f37133e301 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -627,8 +627,7 @@ int net_init_bridge(const Netdev *netdev, const char *name,
         return -1;
     }
 
-    if (!g_unix_set_fd_nonblocking(fd, true, NULL)) {
-        error_setg_errno(errp, errno, "Failed to set FD nonblocking");
+    if (!qemu_set_blocking(fd, false, errp)) {
         return -1;
     }
     vnet_hdr = tap_probe_vnet_hdr(fd, errp);
@@ -729,9 +728,7 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
                 error_propagate(errp, err);
                 goto failed;
             }
-            if (!g_unix_set_fd_nonblocking(vhostfd, true, NULL)) {
-                error_setg_errno(errp, errno, "%s: Can't use file descriptor %d",
-                                 name, fd);
+            if (!qemu_set_blocking(vhostfd, false, errp)) {
                 goto failed;
             }
         } else {
@@ -741,8 +738,7 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
                                  "tap: open vhost char device failed");
                 goto failed;
             }
-            if (!g_unix_set_fd_nonblocking(vhostfd, true, NULL)) {
-                error_setg_errno(errp, errno, "Failed to set FD nonblocking");
+            if (!qemu_set_blocking(vhostfd, false, errp)) {
                 goto failed;
             }
         }
@@ -839,9 +835,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
             return -1;
         }
 
-        if (!g_unix_set_fd_nonblocking(fd, true, NULL)) {
-            error_setg_errno(errp, errno, "%s: Can't use file descriptor %d",
-                             name, fd);
+        if (!qemu_set_blocking(fd, false, errp)) {
             close(fd);
             return -1;
         }
@@ -895,10 +889,8 @@ int net_init_tap(const Netdev *netdev, const char *name,
                 goto free_fail;
             }
 
-            if (!g_unix_set_fd_nonblocking(fd, true, NULL)) {
+            if (!qemu_set_blocking(fd, false, errp)) {
                 ret = -1;
-                error_setg_errno(errp, errno, "%s: Can't use file descriptor %d",
-                                 name, fd);
                 goto free_fail;
             }
 
@@ -951,8 +943,7 @@ free_fail:
             return -1;
         }
 
-        if (!g_unix_set_fd_nonblocking(fd, true, NULL)) {
-            error_setg_errno(errp, errno, "Failed to set FD nonblocking");
+        if (!qemu_set_blocking(fd, false, errp)) {
             return -1;
         }
         vnet_hdr = tap_probe_vnet_hdr(fd, errp);
diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 12bc086d79..5070f27d75 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -503,9 +503,8 @@ int64_t qmp_guest_file_open(const char *path, const char *mode,
     /* set fd non-blocking to avoid common use cases (like reading from a
      * named pipe) from hanging the agent
      */
-    if (!g_unix_set_fd_nonblocking(fileno(fh), true, NULL)) {
+    if (!qemu_set_blocking(fileno(fh), false, errp)) {
         fclose(fh);
-        error_setg_errno(errp, errno, "Failed to set FD nonblocking");
         return -1;
     }
 
diff --git a/tests/qtest/fuzz/virtio_net_fuzz.c b/tests/qtest/fuzz/virtio_net_fuzz.c
index e239875e3b..e9b13d3e4f 100644
--- a/tests/qtest/fuzz/virtio_net_fuzz.c
+++ b/tests/qtest/fuzz/virtio_net_fuzz.c
@@ -132,7 +132,7 @@ static void *virtio_net_test_setup_socket(GString *cmd_line, void *arg)
 {
     int ret = socketpair(PF_UNIX, SOCK_STREAM, 0, sockfds);
     g_assert_cmpint(ret, !=, -1);
-    g_unix_set_fd_nonblocking(sockfds[0], true, NULL);
+    qemu_set_blocking(sockfds[0], false, &error_abort);
     sockfds_initialized = true;
     g_string_append_printf(cmd_line, " -netdev socket,fd=%d,id=hs0 ",
                            sockfds[1]);
diff --git a/tests/qtest/vhost-user-test.c b/tests/qtest/vhost-user-test.c
index 75cb3e44b2..ba70bf997c 100644
--- a/tests/qtest/vhost-user-test.c
+++ b/tests/qtest/vhost-user-test.c
@@ -472,8 +472,7 @@ static void chr_read(void *opaque, const uint8_t *buf, int size)
          * The receive function forces it to be blocking,
          * so revert it back to non-blocking.
          */
-        g_unix_set_fd_nonblocking(fd, true, &err);
-        g_assert_no_error(err);
+        qemu_set_blocking(fd, false, &error_abort);
         break;
 
     case VHOST_USER_SET_LOG_BASE:
diff --git a/tests/unit/test-iov.c b/tests/unit/test-iov.c
index 75bc3be005..63e2b1583c 100644
--- a/tests/unit/test-iov.c
+++ b/tests/unit/test-iov.c
@@ -1,4 +1,5 @@
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "qemu/iov.h"
 #include "qemu/sockets.h"
 
@@ -186,7 +187,7 @@ static void test_io(void)
 
        close(sv[0]);
        FD_SET(sv[1], &fds);
-       g_unix_set_fd_nonblocking(sv[1], true, NULL);
+       qemu_set_blocking(sv[1], false, &error_abort);
        r = g_test_rand_int_range(sz / 2, sz);
        setsockopt(sv[1], SOL_SOCKET, SO_SNDBUF, &r, sizeof(r));
 
@@ -222,7 +223,7 @@ static void test_io(void)
 
        close(sv[1]);
        FD_SET(sv[0], &fds);
-       g_unix_set_fd_nonblocking(sv[0], true, NULL);
+       qemu_set_blocking(sv[0], false, &error_abort);
        r = g_test_rand_int_range(sz / 2, sz);
        setsockopt(sv[0], SOL_SOCKET, SO_RCVBUF, &r, sizeof(r));
        usleep(500000);
diff --git a/ui/input-linux.c b/ui/input-linux.c
index 92e1a1aa64..44d0c15a9b 100644
--- a/ui/input-linux.c
+++ b/ui/input-linux.c
@@ -316,8 +316,7 @@ static void input_linux_complete(UserCreatable *uc, Error **errp)
         error_setg_file_open(errp, errno, il->evdev);
         return;
     }
-    if (!g_unix_set_fd_nonblocking(il->fd, true, NULL)) {
-        error_setg_errno(errp, errno, "Failed to set FD nonblocking");
+    if (!qemu_set_blocking(il->fd, false, errp)) {
         return;
     }
 
diff --git a/util/event_notifier-posix.c b/util/event_notifier-posix.c
index 76420c5b56..8c05e0d528 100644
--- a/util/event_notifier-posix.c
+++ b/util/event_notifier-posix.c
@@ -14,6 +14,7 @@
 #include "qemu/cutils.h"
 #include "qemu/event_notifier.h"
 #include "qemu/main-loop.h"
+#include "qemu/sockets.h"
 
 #ifdef CONFIG_EVENTFD
 #include <sys/eventfd.h>
@@ -52,11 +53,11 @@ int event_notifier_init(EventNotifier *e, int active)
         if (!g_unix_open_pipe(fds, FD_CLOEXEC, NULL)) {
             return -errno;
         }
-        if (!g_unix_set_fd_nonblocking(fds[0], true, NULL)) {
+        if (!qemu_set_blocking(fds[0], false, NULL)) {
             ret = -errno;
             goto fail;
         }
-        if (!g_unix_set_fd_nonblocking(fds[1], true, NULL)) {
+        if (!qemu_set_blocking(fds[1], false, NULL)) {
             ret = -errno;
             goto fail;
         }
diff --git a/util/main-loop.c b/util/main-loop.c
index 51aeb2432e..6885be688c 100644
--- a/util/main-loop.c
+++ b/util/main-loop.c
@@ -34,6 +34,7 @@
 #include "block/thread-pool.h"
 #include "qemu/error-report.h"
 #include "qemu/queue.h"
+#include "qemu/sockets.h"
 #include "qom/object.h"
 
 #ifndef _WIN32
@@ -114,7 +115,10 @@ static int qemu_signal_init(Error **errp)
         return -errno;
     }
 
-    g_unix_set_fd_nonblocking(sigfd, true, NULL);
+    if (!qemu_set_blocking(sigfd, false, errp)) {
+        close(sigfd);
+        return -EINVAL;
+    }
 
     qemu_set_fd_handler(sigfd, sigfd_handler, NULL, (void *)(intptr_t)sigfd);
 
-- 
2.48.1


