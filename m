Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59934B2A8D1
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Aug 2025 16:09:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uo0W1-0001nI-7j; Mon, 18 Aug 2025 10:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uo0Vy-0001mZ-7o
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 10:07:10 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uo0Vw-0002D2-JM
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 10:07:09 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c21:2d8b:0:640:7d49:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id ACDE7807D8;
 Mon, 18 Aug 2025 17:06:53 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b25::1:17])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id k6RC4003YeA0-Y3p4N9j0; Mon, 18 Aug 2025 17:06:53 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1755526013;
 bh=qurO9nCLOGwJkhLe8okvAExVdaifk8VQ87gE0if9bt8=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=eHGnJSwKQk4l5+0QuyRGBvHTyofIejOFRrX4z6QsFUDaHzjz9tJza7Pdm7lar/MEk
 zSrI/h+LSGmB+t+P6KnNdqq3CNpHYi0YdgMGaHDMIkWBDJNyjBksFKvszkqtZYM5Oc
 f6F/QkmHM05xE7DYNQBAVTGq61ZF0PYS/vWKobhk=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org,
	vsementsov@yandex-team.ru
Subject: [PATCH 18/19] net/tap: split net_tap_setup_vhost() separate function
Date: Mon, 18 Aug 2025 17:06:44 +0300
Message-ID: <20250818140645.27904-19-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250818140645.27904-1-vsementsov@yandex-team.ru>
References: <20250818140645.27904-1-vsementsov@yandex-team.ru>
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 net/tap.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 93db3c47f8..fd977b748c 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -93,6 +93,8 @@ static int net_init_tap_one(const Netdev *netdev, NetClientState *peer,
                             const char *ifname, const char *script,
                             const char *downscript, const char *vhostfdname,
                             int vnet_hdr, int fd, Error **errp);
+static int net_tap_setup_vhost(TAPState *s, const NetdevTapOptions *tap,
+                               const char *vhostfdname, Error **errp);
 
 static void tap_update_fd_handler(TAPState *s)
 {
@@ -742,7 +744,7 @@ static int net_init_tap_one(const Netdev *netdev, NetClientState *peer,
 {
     const NetdevTapOptions *tap;
     TAPState *s = net_tap_fd_init(peer, model, name, fd, vnet_hdr);
-    int vhostfd;
+    int ret;
 
     if (netdev->type == NET_CLIENT_DRIVER_BRIDGE) {
         const NetdevBridgeOptions *bridge = &netdev->u.bridge;
@@ -773,9 +775,25 @@ static int net_init_tap_one(const Netdev *netdev, NetClientState *peer,
         }
     }
 
+    ret = net_tap_setup_vhost(s, tap, vhostfdname, errp);
+    if (ret < 0) {
+        goto failed;
+    }
+
+    return 0;
+
+failed:
+    qemu_del_net_client(&s->nc);
+    return -1;
+}
+
+static int net_tap_setup_vhost(TAPState *s, const NetdevTapOptions *tap,
+                               const char *vhostfdname, Error **errp)
+{
     if (tap->has_vhost ? tap->vhost :
         vhostfdname || (tap->has_vhostforce && tap->vhostforce)) {
         VhostNetOptions options;
+        int vhostfd;
 
         options.backend_type = VHOST_BACKEND_TYPE_KERNEL;
         options.net_backend = &s->nc;
@@ -788,20 +806,20 @@ static int net_init_tap_one(const Netdev *netdev, NetClientState *peer,
         if (vhostfdname) {
             vhostfd = monitor_fd_param(monitor_cur(), vhostfdname, errp);
             if (vhostfd == -1) {
-                goto failed;
+                return -1;
             }
             if (!set_fd_nonblocking(vhostfd, vhostfdname, errp)) {
-                goto failed;
+                return -1;
             }
         } else {
             vhostfd = open("/dev/vhost-net", O_RDWR);
             if (vhostfd < 0) {
                 error_setg_errno(errp, errno,
                                  "tap: open vhost char device failed");
-                goto failed;
+                return -1;
             }
             if (!set_fd_nonblocking(vhostfd, "opened /dev/vhost-net", errp)) {
-                goto failed;
+                return -1;
             }
         }
         options.opaque = (void *)(uintptr_t)vhostfd;
@@ -816,15 +834,11 @@ static int net_init_tap_one(const Netdev *netdev, NetClientState *peer,
         if (!s->vhost_net) {
             error_setg(errp,
                        "vhost-net requested but could not be initialized");
-            goto failed;
+            return -1;
         }
     }
 
     return 0;
-
-failed:
-    qemu_del_net_client(&s->nc);
-    return -1;
 }
 
 static int net_tap_from_monitor_fd(const Netdev *netdev, NetClientState *peer,
-- 
2.48.1


