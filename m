Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B03CF977C89
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Sep 2024 11:47:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp2sq-0006e4-L5; Fri, 13 Sep 2024 05:46:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1sp2sh-0006cn-5P
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 05:46:26 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1sp2sd-0006VX-WA
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 05:46:22 -0400
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:42af:0:640:8187:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 6AFB160D6C;
 Fri, 13 Sep 2024 12:46:12 +0300 (MSK)
Received: from d-tatianin-lin.yandex-team.ru (unknown
 [2a02:6b8:b081:b644::1:2c])
 by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 8khGTP1gweA0-QdbJmDTj; Fri, 13 Sep 2024 12:46:11 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1726220771;
 bh=FK6qn4h8Kpstus0Ea7EXTfjFnpuIfQI2yZTMfG9QD0s=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=G53LAuyJ+EM0Q3BEkZz6HVQPiQESQVu/dn8qGD4lLUvP06v5GKK4O8dGT5PbZmqcI
 3i0c+0PRM0XLvs1kk1ANILwNHcUSm1PFJcrEG02bO0j6fXgxkJZKkOyvJRgREWdGgP
 dokcrxQA1ANqf+/1eAlNP/RPnV52jXI82gcgYfug=
Authentication-Results: mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 devel@lists.libvirt.org, Peter Krempa <pkrempa@redhat.com>,
 Michal Privoznik <mprivozn@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH v2] chardev: introduce 'reconnect-ms' and deprecate 'reconnect'
Date: Fri, 13 Sep 2024 12:46:04 +0300
Message-Id: <20240913094604.269135-1-d-tatianin@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=d-tatianin@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The 'reconnect' option only allows to specify the time in seconds,
which is way too long for certain workflows.

We have a lightweight disk backend server, which takes about 20ms to
live update, but due to this limitation in QEMU, previously the guest
disk controller would hang for one second because it would take this
long for QEMU to reinitialize the socket connection.

Introduce a new option called 'reconnect-ms', which is the same as
'reconnect', except the value is treated as milliseconds. These are
mutually exclusive and specifying both results in an error.

'reconnect' is also deprecated by this commit to make it possible to
remove it in the future as to not keep two options that control the
same thing.

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Acked-by: Peter Krempa <pkrempa@redhat.com>
Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
---

Changes since v0:
- Mention the deprecation in docs (Paolo)

Changes since v1:
- Move option validation to qmp_chardev_validate_socket as qemu_chr_parse_socket
  is only called for the command line and not QMP. (thanks to Markus Armbruster for spotting)

---
 chardev/char-socket.c         | 33 ++++++++++++++++++++++++---------
 chardev/char.c                |  3 +++
 docs/about/deprecated.rst     |  6 ++++++
 include/chardev/char-socket.h |  2 +-
 qapi/char.json                | 17 +++++++++++++++--
 5 files changed, 49 insertions(+), 12 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 1ca9441b1b..91496ceda9 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -74,7 +74,7 @@ static void qemu_chr_socket_restart_timer(Chardev *chr)
     assert(!s->reconnect_timer);
     name = g_strdup_printf("chardev-socket-reconnect-%s", chr->label);
     s->reconnect_timer = qemu_chr_timeout_add_ms(chr,
-                                                 s->reconnect_time * 1000,
+                                                 s->reconnect_time_ms,
                                                  socket_reconnect_timeout,
                                                  chr);
     g_source_set_name(s->reconnect_timer, name);
@@ -481,7 +481,7 @@ static void tcp_chr_disconnect_locked(Chardev *chr)
     if (emit_close) {
         qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
     }
-    if (s->reconnect_time && !s->reconnect_timer) {
+    if (s->reconnect_time_ms && !s->reconnect_timer) {
         qemu_chr_socket_restart_timer(chr);
     }
 }
@@ -1080,9 +1080,9 @@ static int tcp_chr_wait_connected(Chardev *chr, Error **errp)
         } else {
             Error *err = NULL;
             if (tcp_chr_connect_client_sync(chr, &err) < 0) {
-                if (s->reconnect_time) {
+                if (s->reconnect_time_ms) {
                     error_free(err);
-                    g_usleep(s->reconnect_time * 1000ULL * 1000ULL);
+                    g_usleep(s->reconnect_time_ms * 1000ULL);
                 } else {
                     error_propagate(errp, err);
                     return -1;
@@ -1267,13 +1267,13 @@ skip_listen:
 
 
 static int qmp_chardev_open_socket_client(Chardev *chr,
-                                          int64_t reconnect,
+                                          int64_t reconnect_ms,
                                           Error **errp)
 {
     SocketChardev *s = SOCKET_CHARDEV(chr);
 
-    if (reconnect > 0) {
-        s->reconnect_time = reconnect;
+    if (reconnect_ms > 0) {
+        s->reconnect_time_ms = reconnect_ms;
         tcp_chr_connect_client_async(chr);
         return 0;
     } else {
@@ -1354,6 +1354,12 @@ static bool qmp_chardev_validate_socket(ChardevSocket *sock,
         }
     }
 
+    if (sock->has_reconnect_ms && sock->has_reconnect) {
+        error_setg(errp,
+            "'reconnect' and 'reconnect-ms' are mutually exclusive");
+        return false;
+    }
+
     return true;
 }
 
@@ -1371,7 +1377,7 @@ static void qmp_chardev_open_socket(Chardev *chr,
     bool is_tn3270      = sock->has_tn3270  ? sock->tn3270  : false;
     bool is_waitconnect = sock->has_wait    ? sock->wait    : false;
     bool is_websock     = sock->has_websocket ? sock->websocket : false;
-    int64_t reconnect   = sock->has_reconnect ? sock->reconnect : 0;
+    int64_t reconnect_ms = 0;
     SocketAddress *addr;
 
     s->is_listen = is_listen;
@@ -1443,7 +1449,13 @@ static void qmp_chardev_open_socket(Chardev *chr,
             return;
         }
     } else {
-        if (qmp_chardev_open_socket_client(chr, reconnect, errp) < 0) {
+        if (sock->has_reconnect) {
+            reconnect_ms = sock->reconnect * 1000ULL;
+        } else if (sock->has_reconnect_ms) {
+            reconnect_ms = sock->reconnect_ms;
+        }
+
+        if (qmp_chardev_open_socket_client(chr, reconnect_ms, errp) < 0) {
             return;
         }
     }
@@ -1509,6 +1521,9 @@ static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backend,
     sock->wait = qemu_opt_get_bool(opts, "wait", true);
     sock->has_reconnect = qemu_opt_find(opts, "reconnect");
     sock->reconnect = qemu_opt_get_number(opts, "reconnect", 0);
+    sock->has_reconnect_ms = qemu_opt_find(opts, "reconnect-ms");
+    sock->reconnect_ms = qemu_opt_get_number(opts, "reconnect-ms", 0);
+
     sock->tls_creds = g_strdup(qemu_opt_get(opts, "tls-creds"));
     sock->tls_authz = g_strdup(qemu_opt_get(opts, "tls-authz"));
 
diff --git a/chardev/char.c b/chardev/char.c
index ba847b6e9e..35623c78a3 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -888,6 +888,9 @@ QemuOptsList qemu_chardev_opts = {
         },{
             .name = "reconnect",
             .type = QEMU_OPT_NUMBER,
+        },{
+            .name = "reconnect-ms",
+            .type = QEMU_OPT_NUMBER,
         },{
             .name = "telnet",
             .type = QEMU_OPT_BOOL,
diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 88f0f03786..e5db9bc6e9 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -430,6 +430,12 @@ Backend ``memory`` (since 9.0)
 
 ``memory`` is a deprecated synonym for ``ringbuf``.
 
+``reconnect`` (since 9.2)
+^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The ``reconnect`` option only allows specifiying second granularity timeouts,
+which is not enough for all types of use cases, use ``reconnect-ms`` instead.
+
 CPU device properties
 '''''''''''''''''''''
 
diff --git a/include/chardev/char-socket.h b/include/chardev/char-socket.h
index 0708ca6fa9..d6d13ad37f 100644
--- a/include/chardev/char-socket.h
+++ b/include/chardev/char-socket.h
@@ -74,7 +74,7 @@ struct SocketChardev {
     bool is_websock;
 
     GSource *reconnect_timer;
-    int64_t reconnect_time;
+    int64_t reconnect_time_ms;
     bool connect_err_reported;
 
     QIOTask *connect_task;
diff --git a/qapi/char.json b/qapi/char.json
index ef58445cee..7f117438c6 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -273,7 +273,19 @@
 #
 # @reconnect: For a client socket, if a socket is disconnected, then
 #     attempt a reconnect after the given number of seconds.  Setting
-#     this to zero disables this function.  (default: 0) (Since: 2.2)
+#     this to zero disables this function.  The use of this member is
+#     deprecated, use @reconnect-ms instead. (default: 0) (Since: 2.2)
+#
+# @reconnect-ms: For a client socket, if a socket is disconnected,
+#     then attempt a reconnect after the given number of milliseconds.
+#     Setting this to zero disables this function.  This member is
+#     mutually exclusive with @reconnect.
+#     (default: 0) (Since: 9.2)
+#
+# Features:
+#
+# @deprecated: Member @reconnect is deprecated.  Use @reconnect-ms
+#     instead.
 #
 # Since: 1.4
 ##
@@ -287,7 +299,8 @@
             '*telnet': 'bool',
             '*tn3270': 'bool',
             '*websocket': 'bool',
-            '*reconnect': 'int' },
+            '*reconnect': { 'type': 'int', 'features': [ 'deprecated' ] },
+            '*reconnect-ms': 'int' },
   'base': 'ChardevCommon' }
 
 ##
-- 
2.34.1


