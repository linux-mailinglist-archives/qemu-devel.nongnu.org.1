Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E98BCE240
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Oct 2025 19:46:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7H6t-0008Ky-I9; Fri, 10 Oct 2025 13:40:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7H6j-0008Iq-8z
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 13:40:46 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7H6J-0007TQ-UL
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 13:40:43 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:9297:0:640:61e7:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id F2E1CC0177;
 Fri, 10 Oct 2025 20:40:12 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a89::1:23])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id xdPFQ30FtmI0-GFfeL6ht; Fri, 10 Oct 2025 20:40:12 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760118012;
 bh=nl2+2Bb8Tc8O3k95uaNJdjhEm6v2qoQg7sRCDCKeFb4=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=i6GJBRgKSzliPngBM589FXBgO+c07aCssUGedb87vJsZhy9Z1ZOOePEOAF1CyV8Lk
 n5eYuJw9sq3sr+tZZ9zOiYNxZTXUbaBX8qL5q+VSgLeB78MDN4eqWItPGgvhg1zFFX
 WRJGit/LG5QSF8AwRqd73+7xYxjttCfvafPjImhM=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: peterx@redhat.com, farosas@suse.de, sw@weilnetz.de, eblake@redhat.com,
 armbru@redhat.com, thuth@redhat.com, philmd@linaro.org,
 berrange@redhat.com, qemu-devel@nongnu.org, michael.roth@amd.com,
 steven.sistare@oracle.com, leiyang@redhat.com, davydov-max@yandex-team.ru,
 yc-core@yandex-team.ru, vsementsov@yandex-team.ru,
 raphael.s.norwitz@gmail.com
Subject: [PATCH v7 12/19] net/tap: move vhost fd initialization to
 net_tap_new()
Date: Fri, 10 Oct 2025 20:39:50 +0300
Message-ID: <20251010173957.166759-13-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251010173957.166759-1-vsementsov@yandex-team.ru>
References: <20251010173957.166759-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

Continue the track to avoid dependency on @tap in net_tap_setup(),
no move the vhost fd initialization to net_tap_new(). So in
net_tap_setup() we simply check, do we have and vhostfd at this
point or not.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Maksim Davydov <davydov-max@yandex-team.ru>
---
 net/tap.c | 90 ++++++++++++++++++++++++++++++-------------------------
 1 file changed, 50 insertions(+), 40 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index b01cd4d6c2..d08ef070e9 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -86,11 +86,11 @@ typedef struct TAPState {
 
     bool sndbuf_required;
     int sndbuf;
+    int vhostfd;
+    uint32_t vhost_busyloop_timeout;
 } TAPState;
 
-static bool net_tap_setup(TAPState *s, const NetdevTapOptions *tap,
-                          const char *vhostfdname,
-                          int fd, int vnet_hdr, Error **errp);
+static bool net_tap_setup(TAPState *s, int fd, int vnet_hdr, Error **errp);
 
 static void launch_script(const char *setup_script, const char *ifname,
                           int fd, Error **errp);
@@ -361,6 +361,11 @@ static void tap_cleanup(NetClientState *nc)
     tap_write_poll(s, false);
     close(s->fd);
     s->fd = -1;
+
+    if (s->vhostfd != -1) {
+        close(s->vhostfd);
+        s->vhostfd = -1;
+    }
 }
 
 static void tap_poll(NetClientState *nc, bool enable)
@@ -420,12 +425,14 @@ static NetClientInfo net_tap_info = {
 };
 
 static TAPState *net_tap_new(NetClientState *peer, const char *model,
-                             const char *name, const NetdevTapOptions *tap)
+                             const char *name, const NetdevTapOptions *tap,
+                             const char *vhostfdname, Error **errp)
 {
     NetClientState *nc = qemu_new_net_client(&net_tap_info, peer, model, name);
     TAPState *s = DO_UPCAST(TAPState, nc, nc);
 
     s->fd = -1;
+    s->vhostfd = -1;
 
     if (!tap) {
         return s;
@@ -435,7 +442,36 @@ static TAPState *net_tap_new(NetClientState *peer, const char *model,
     s->sndbuf =
         (tap->has_sndbuf && tap->sndbuf) ? MIN(tap->sndbuf, INT_MAX) : INT_MAX;
 
+    if (tap->has_vhost ? tap->vhost :
+        vhostfdname || (tap->has_vhostforce && tap->vhostforce)) {
+        if (vhostfdname) {
+            s->vhostfd = monitor_fd_param(monitor_cur(), vhostfdname, errp);
+            if (s->vhostfd == -1) {
+                goto failed;
+            }
+            if (!qemu_set_blocking(s->vhostfd, false, errp)) {
+                goto failed;
+            }
+        } else {
+            s->vhostfd = open("/dev/vhost-net", O_RDWR);
+            if (s->vhostfd < 0) {
+                error_setg_errno(errp, errno,
+                                 "tap: open vhost char device failed");
+                goto failed;
+            }
+            if (!qemu_set_blocking(s->vhostfd, false, errp)) {
+                goto failed;
+            }
+        }
+
+        s->vhost_busyloop_timeout = tap->has_poll_us ? tap->poll_us : 0;
+    }
+
     return s;
+
+failed:
+    qemu_del_net_client(&s->nc);
+    return NULL;
 }
 
 static bool net_tap_set_fd(TAPState *s, int fd, int vnet_hdr, Error **errp)
@@ -685,7 +721,7 @@ int net_init_bridge(const Netdev *netdev, const char *name,
         return -1;
     }
 
-    s = net_tap_new(peer, "bridge", name, NULL);
+    s = net_tap_new(peer, "bridge", name, NULL, NULL, &error_abort);
     net_tap_set_fd(s, fd, vnet_hdr, &error_abort);
 
     qemu_set_info_str(&s->nc, "helper=%s,br=%s", helper, br);
@@ -726,7 +762,10 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
                              const char *downscript, const char *vhostfdname,
                              int vnet_hdr, int fd, Error **errp)
 {
-    TAPState *s = net_tap_new(peer, model, name, tap);
+    TAPState *s = net_tap_new(peer, model, name, tap, vhostfdname, errp);
+    if (!s) {
+        return;
+    }
 
     if (tap->fd || tap->fds) {
         qemu_set_info_str(&s->nc, "fd=%d", fd);
@@ -745,53 +784,24 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
         }
     }
 
-    if (!net_tap_setup(s, tap, vhostfdname, fd, vnet_hdr, errp)) {
+    if (!net_tap_setup(s, fd, vnet_hdr, errp)) {
         qemu_del_net_client(&s->nc);
     }
 }
 
-static bool net_tap_setup(TAPState *s, const NetdevTapOptions *tap,
-                          const char *vhostfdname,
-                          int fd, int vnet_hdr, Error **errp)
+static bool net_tap_setup(TAPState *s, int fd, int vnet_hdr, Error **errp)
 {
-    int vhostfd;
-
     if (!net_tap_set_fd(s, fd, vnet_hdr, errp)) {
         return false;
     }
 
-    if (tap->has_vhost ? tap->vhost :
-        vhostfdname || (tap->has_vhostforce && tap->vhostforce)) {
+    if (s->vhostfd != -1) {
         VhostNetOptions options;
 
         options.backend_type = VHOST_BACKEND_TYPE_KERNEL;
         options.net_backend = &s->nc;
-        if (tap->has_poll_us) {
-            options.busyloop_timeout = tap->poll_us;
-        } else {
-            options.busyloop_timeout = 0;
-        }
-
-        if (vhostfdname) {
-            vhostfd = monitor_fd_param(monitor_cur(), vhostfdname, errp);
-            if (vhostfd == -1) {
-                return false;
-            }
-            if (!qemu_set_blocking(vhostfd, false, errp)) {
-                return false;
-            }
-        } else {
-            vhostfd = open("/dev/vhost-net", O_RDWR);
-            if (vhostfd < 0) {
-                error_setg_errno(errp, errno,
-                                 "tap: open vhost char device failed");
-                return false;
-            }
-            if (!qemu_set_blocking(vhostfd, false, errp)) {
-                return false;
-            }
-        }
-        options.opaque = (void *)(uintptr_t)vhostfd;
+        options.busyloop_timeout = s->vhost_busyloop_timeout;
+        options.opaque = (void *)(uintptr_t)s->vhostfd;
         options.nvqs = 2;
         options.feature_bits = kernel_feature_bits;
         options.get_acked_features = NULL;
-- 
2.48.1


