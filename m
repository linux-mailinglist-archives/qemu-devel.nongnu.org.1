Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC421B539A7
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Sep 2025 18:52:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwkVw-0002wE-Uc; Thu, 11 Sep 2025 12:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uwkVt-0002lQ-LE
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 12:51:13 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uwkVq-0004AM-1O
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 12:51:13 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 2F022804CA;
 Thu, 11 Sep 2025 19:51:05 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b3c::1:2f])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 2pOVKM0Fka60-rWf8MZRp; Thu, 11 Sep 2025 19:51:04 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1757609464;
 bh=OyOqvzoRuRR+qR59yZ7B1V6AlEuto7qGRLZU91LQMBk=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=qj+YHDN2zprPRWZdS4mPE7Pp7mNFHmlGKsSB0V+R/GkXuTpON3NiCGJIF6E6NULOU
 i2POXMeqjFehIqJxScqYRfDsV9vYnPKnM1Cs5OS030fZyQAZ9DsIsWNIOteU36Zel0
 x7zuy3Bq++mu3YMTD8gjlTkPQmVNIFWDoWvhL2zA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, leiyang@redhat.com,
 steven.sistare@oracle.com, yc-core@yandex-team.ru,
 davydov-max@yandex-team.ru
Subject: [PATCH v4 1/8] net/tap: net_init_tap_one(): add return value
Date: Thu, 11 Sep 2025 19:50:54 +0300
Message-ID: <20250911165101.1637608-2-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250911165101.1637608-1-vsementsov@yandex-team.ru>
References: <20250911165101.1637608-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
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

To avoid error propagation, let's follow common recommendations
in include/qapi/error.h and use return boolean value together with
errp.

Why do we prefer errp-based functions with return value?
In short with additional return value we get:

- less code to handle error
- don't create and set Error object when it's not required
  (when passed errp=NULL)

More details in commit message of e3fe3988d7851cac3
"error: Document Error API usage rules"

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 net/tap.c | 43 +++++++++++++++++--------------------------
 1 file changed, 17 insertions(+), 26 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index f7df702f97..e023c5f67f 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -680,7 +680,7 @@ static int net_tap_init(const NetdevTapOptions *tap, int *vnet_hdr,
 
 #define MAX_TAP_QUEUES 1024
 
-static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
+static bool net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
                              const char *model, const char *name,
                              const char *ifname, const char *script,
                              const char *downscript, const char *vhostfdname,
@@ -765,10 +765,11 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
         goto failed;
     }
 
-    return;
+    return true;
 
 failed:
     qemu_del_net_client(&s->nc);
+    return false;
 }
 
 static int get_fds(char *str, char *fds[], int max)
@@ -805,7 +806,6 @@ int net_init_tap(const Netdev *netdev, const char *name,
     /* for the no-fd, no-helper case */
     const char *script;
     const char *downscript;
-    Error *err = NULL;
     const char *vhostfdname;
     char ifname[128];
     int ret = 0;
@@ -852,12 +852,9 @@ int net_init_tap(const Netdev *netdev, const char *name,
             return -1;
         }
 
-        net_init_tap_one(tap, peer, "tap", name, NULL,
-                         script, downscript,
-                         vhostfdname, vnet_hdr, fd, &err);
-        if (err) {
-            error_propagate(errp, err);
-            close(fd);
+        if (!net_init_tap_one(tap, peer, "tap", name, NULL,
+                              script, downscript,
+                              vhostfdname, vnet_hdr, fd, errp)) {
             return -1;
         }
     } else if (tap->fds) {
@@ -915,12 +912,10 @@ int net_init_tap(const Netdev *netdev, const char *name,
                 goto free_fail;
             }
 
-            net_init_tap_one(tap, peer, "tap", name, ifname,
-                             script, downscript,
-                             tap->vhostfds ? vhost_fds[i] : NULL,
-                             vnet_hdr, fd, &err);
-            if (err) {
-                error_propagate(errp, err);
+            if (!net_init_tap_one(tap, peer, "tap", name, ifname,
+                                  script, downscript,
+                                  tap->vhostfds ? vhost_fds[i] : NULL,
+                                  vnet_hdr, fd, errp)) {
                 ret = -1;
                 goto free_fail;
             }
@@ -961,11 +956,9 @@ free_fail:
             return -1;
         }
 
-        net_init_tap_one(tap, peer, "bridge", name, ifname,
-                         script, downscript, vhostfdname,
-                         vnet_hdr, fd, &err);
-        if (err) {
-            error_propagate(errp, err);
+        if (!net_init_tap_one(tap, peer, "bridge", name, ifname,
+                              script, downscript, vhostfdname,
+                              vnet_hdr, fd, errp)) {
             close(fd);
             return -1;
         }
@@ -1006,12 +999,10 @@ free_fail:
                 }
             }
 
-            net_init_tap_one(tap, peer, "tap", name, ifname,
-                             i >= 1 ? "no" : script,
-                             i >= 1 ? "no" : downscript,
-                             vhostfdname, vnet_hdr, fd, &err);
-            if (err) {
-                error_propagate(errp, err);
+            if (!net_init_tap_one(tap, peer, "tap", name, ifname,
+                                  i >= 1 ? "no" : script,
+                                  i >= 1 ? "no" : downscript,
+                                  vhostfdname, vnet_hdr, fd, errp)) {
                 close(fd);
                 return -1;
             }
-- 
2.48.1


