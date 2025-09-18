Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9A4B2A8D9
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Aug 2025 16:09:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uo0Vn-0001LH-L5; Mon, 18 Aug 2025 10:06:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uo0Vk-0001Ji-MO
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 10:06:56 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uo0Vh-0002BJ-6w
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 10:06:56 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c21:2d8b:0:640:7d49:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 2A802807C6;
 Mon, 18 Aug 2025 17:06:50 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b25::1:17])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id k6RC4003YeA0-2Vnf3E4J; Mon, 18 Aug 2025 17:06:49 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1755526009;
 bh=/jmgRZlvnyx5qMTtkk0yR8vFuAW4SpHDfPYvvSqnSc0=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=I/DDe7Z/skZOSTFBnsbgg2WT8FF9G/2wJdhz5k1SNMJkVnnVtHbEHEZbg2WCUnWhy
 vI02q9RtHQlfOmsDxTrugjXXCu97vSMyrBjKgVtnnYeGQ1TkwGDax1lQPVkfYsmhHk
 dPamml5w0Xgk1NtL11SjgdyQelCyhlM3cDinEz/g=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org,
	vsementsov@yandex-team.ru
Subject: [PATCH 08/19] net/tap: move local variables related to the latter
 case to else branch
Date: Mon, 18 Aug 2025 17:06:34 +0300
Message-ID: <20250818140645.27904-9-vsementsov@yandex-team.ru>
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

This makes more obvious, where the variables make sense.

Note that ifname, script and downscript variables are not used in
net_init_tap_one() for fd/fds/helper cases.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 net/tap.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index ade58826c8..80ec54f914 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -803,19 +803,11 @@ static int get_fds(char *str, char *fds[], int max)
 int net_init_tap(const Netdev *netdev, const char *name,
                  NetClientState *peer, Error **errp)
 {
-    const NetdevTapOptions *tap;
-    int fd, vnet_hdr = 0, i = 0, queues;
-    /* for the no-fd, no-helper case */
-    const char *script;
-    const char *downscript;
-    char ifname[128];
+    const NetdevTapOptions *tap = &netdev->u.tap;
+    int fd, vnet_hdr = 0, i = 0;
     int ret = 0;
 
     assert(netdev->type == NET_CLIENT_DRIVER_TAP);
-    tap = &netdev->u.tap;
-    queues = tap->has_queues ? tap->queues : 1;
-    script = tap->script;
-    downscript = tap->downscript;
 
     /* QEMU hubs do not support multiqueue tap, in this case peer is set.
      * For -netdev, peer is always NULL. */
@@ -861,7 +853,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
         }
 
         ret = net_init_tap_one(tap, peer, "tap", name, NULL,
-                               script, downscript,
+                               NULL, NULL,
                                tap->vhostfd, vnet_hdr, fd, errp);
         if (ret < 0) {
             return -1;
@@ -915,8 +907,8 @@ int net_init_tap(const Netdev *netdev, const char *name,
                 goto free_fail;
             }
 
-            ret = net_init_tap_one(tap, peer, "tap", name, ifname,
-                                   script, downscript,
+            ret = net_init_tap_one(tap, peer, "tap", name, NULL,
+                                   NULL, NULL,
                                    tap->vhostfds ? vhost_fds[i] : NULL,
                                    vnet_hdr, fd, errp);
             if (ret < 0) {
@@ -957,16 +949,21 @@ free_fail:
             return -1;
         }
 
-        ret = net_init_tap_one(tap, peer, "bridge", name, ifname,
-                               script, downscript, tap->vhostfd,
+        ret = net_init_tap_one(tap, peer, "bridge", name, NULL,
+                               NULL, NULL, tap->vhostfd,
                                vnet_hdr, fd, errp);
         if (ret < 0) {
             close(fd);
             return -1;
         }
     } else {
+        const char *script = tap->script;
+        const char *downscript = tap->downscript;
+        int queues = tap->has_queues ? tap->queues : 1;
         g_autofree char *default_script = NULL;
         g_autofree char *default_downscript = NULL;
+        char ifname[128];
+
         if (tap->vhostfds) {
             error_setg(errp, "vhostfds= is invalid if fds= wasn't specified");
             return -1;
-- 
2.48.1


