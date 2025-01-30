Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 29026A22CAE
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Jan 2025 12:47:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdT0D-0000HT-Od; Thu, 30 Jan 2025 06:46:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tdT0B-0000HF-C5; Thu, 30 Jan 2025 06:46:31 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tdT09-0004Sg-Nd; Thu, 30 Jan 2025 06:46:31 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7BF8DE2F8D;
 Thu, 30 Jan 2025 14:45:56 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 4C4871A7E68;
 Thu, 30 Jan 2025 14:46:25 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 41A58523D7; Thu, 30 Jan 2025 14:46:25 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Samuel Thibault <samuel.thibault@gnu.org>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH v2] net/slirp: libslirp 4.8.0 compatibility
Date: Thu, 30 Jan 2025 14:46:21 +0300
Message-Id: <20250130114621.857046-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Update the code in net/slirp.c to be compatible with
libslirp 4.8.0, which deprecated slirp_pollfds_fill()
and started using slirp_os_socket type for sockets
(which is a 64-bit integer on win64) for all callbacks
starting with version 6 of the interface.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
v2: update other callbacks too, use version 6 of the interface

 net/slirp.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/net/slirp.c b/net/slirp.c
index eb9a456ed4..2d2a58a6ee 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -247,7 +247,14 @@ static void net_slirp_timer_mod(void *timer, int64_t expire_timer,
     timer_mod(&t->timer, expire_timer);
 }
 
-static void net_slirp_register_poll_fd(int fd, void *opaque)
+#if !SLIRP_CHECK_VERSION(4,8,0)
+# define slirp_os_socket int
+# define slirp_pollfds_fill_socket slirp_pollfds_fill
+# define register_poll_sock register_poll_fd
+# define unregister_poll_sock unregister_poll_fd
+#endif
+
+static void net_slirp_register_poll_sock(slirp_os_socket fd, void *opaque)
 {
 #ifdef WIN32
     AioContext *ctxt = qemu_get_aio_context();
@@ -260,7 +267,7 @@ static void net_slirp_register_poll_fd(int fd, void *opaque)
 #endif
 }
 
-static void net_slirp_unregister_poll_fd(int fd, void *opaque)
+static void net_slirp_unregister_poll_sock(slirp_os_socket fd, void *opaque)
 {
 #ifdef WIN32
     if (WSAEventSelect(fd, NULL, 0) != 0) {
@@ -286,8 +293,8 @@ static const SlirpCb slirp_cb = {
 #endif
     .timer_free = net_slirp_timer_free,
     .timer_mod = net_slirp_timer_mod,
-    .register_poll_fd = net_slirp_register_poll_fd,
-    .unregister_poll_fd = net_slirp_unregister_poll_fd,
+    .register_poll_socket = net_slirp_register_poll_sock,
+    .unregister_poll_socket = net_slirp_unregister_poll_sock,
     .notify = net_slirp_notify,
 };
 
@@ -314,7 +321,7 @@ static int slirp_poll_to_gio(int events)
     return ret;
 }
 
-static int net_slirp_add_poll(int fd, int events, void *opaque)
+static int net_slirp_add_poll(slirp_os_socket fd, int events, void *opaque)
 {
     GArray *pollfds = opaque;
     GPollFD pfd = {
@@ -363,8 +370,8 @@ static void net_slirp_poll_notify(Notifier *notifier, void *data)
 
     switch (poll->state) {
     case MAIN_LOOP_POLL_FILL:
-        slirp_pollfds_fill(s->slirp, &poll->timeout,
-                           net_slirp_add_poll, poll->pollfds);
+        slirp_pollfds_fill_socket(s->slirp, &poll->timeout,
+                                  net_slirp_add_poll, poll->pollfds);
         break;
     case MAIN_LOOP_POLL_OK:
     case MAIN_LOOP_POLL_ERR:
@@ -629,7 +636,9 @@ static int net_slirp_init(NetClientState *peer, const char *model,
 
     s = DO_UPCAST(SlirpState, nc, nc);
 
-    cfg.version = SLIRP_CHECK_VERSION(4,7,0) ? 4 : 1;
+    cfg.version =
+         SLIRP_CHECK_VERSION(4,8,0) ? 6 :
+         SLIRP_CHECK_VERSION(4,7,0) ? 4 : 1;
     cfg.restricted = restricted;
     cfg.in_enabled = ipv4;
     cfg.vnetwork = net;
-- 
2.39.5


