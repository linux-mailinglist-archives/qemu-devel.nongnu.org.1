Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB60FB42001
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Sep 2025 14:53:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utmw3-0005zM-8D; Wed, 03 Sep 2025 08:49:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utmvy-0005x4-Rs
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 08:49:54 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utmvu-0000nt-Ta
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 08:49:53 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 9DE31C01BF;
 Wed, 03 Sep 2025 15:49:46 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b8f::1:11])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id anf8gZ3GnW20-4TZATJdV; Wed, 03 Sep 2025 15:49:46 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1756903786;
 bh=Ch4+tq/Yb8WQR2RXOcDXz2HjNbPLNzY4cDu2k8VkayM=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=skIhtBVDfbv86TwbyH9cekVRs7rXekNkiF/VOI4uaVUMJKQGcdisi4h3aTOfXrNWj
 4Jf4sEEniZOO37Z/J5K/+6+PxLNbKrx5Gqot2daTLEtZAT33oz3yDazH+nkV94Q6JK
 izs22QpkI2gWrNuDTlW58CrwWSohSAc/6mWggIHs=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, leiyang@redhat.com,
 steven.sistare@oracle.com, yc-core@yandex-team.ru
Subject: [PATCH v3 17/19] net/tap: split net_tap_setup_vhost() separate
 function
Date: Wed,  3 Sep 2025 15:49:31 +0300
Message-ID: <20250903124934.1169899-18-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250903124934.1169899-1-vsementsov@yandex-team.ru>
References: <20250903124934.1169899-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Tested-by: Lei Yang <leiyang@redhat.com>
---
 net/tap.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 0802da7d58..bc46839584 100644
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
@@ -730,7 +732,7 @@ static int net_init_tap_one(const Netdev *netdev, NetClientState *peer,
 {
     const NetdevTapOptions *tap;
     TAPState *s = net_tap_fd_init(peer, model, name, fd, vnet_hdr);
-    int vhostfd;
+    int ret;
 
     if (netdev->type == NET_CLIENT_DRIVER_BRIDGE) {
         const NetdevBridgeOptions *bridge = &netdev->u.bridge;
@@ -761,9 +763,25 @@ static int net_init_tap_one(const Netdev *netdev, NetClientState *peer,
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
@@ -776,20 +794,20 @@ static int net_init_tap_one(const Netdev *netdev, NetClientState *peer,
         if (vhostfdname) {
             vhostfd = monitor_fd_param(monitor_cur(), vhostfdname, errp);
             if (vhostfd == -1) {
-                goto failed;
+                return -1;
             }
             if (!qemu_set_blocking(vhostfd, false, errp)) {
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
             if (!qemu_set_blocking(vhostfd, false, errp)) {
-                goto failed;
+                return -1;
             }
         }
         options.opaque = (void *)(uintptr_t)vhostfd;
@@ -804,15 +822,11 @@ static int net_init_tap_one(const Netdev *netdev, NetClientState *peer,
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


