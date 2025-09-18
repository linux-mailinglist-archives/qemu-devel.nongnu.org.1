Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D878B2A8AF
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Aug 2025 16:08:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uo0Vn-0001La-W3; Mon, 18 Aug 2025 10:07:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uo0Vl-0001Jy-51
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 10:06:57 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uo0Vh-0002B4-EZ
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 10:06:56 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c21:2d8b:0:640:7d49:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id D74BB807B3;
 Mon, 18 Aug 2025 17:06:47 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b25::1:17])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id k6RC4003YeA0-U1eGjacl; Mon, 18 Aug 2025 17:06:47 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1755526007;
 bh=BU/7VLO6Y70tM+utVxCmAAVDYUvmt005RnlKNFWkZP8=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=exlAvelVPk/iyajEVqPav7czDqDSq9EkKAEOdPSuuuG12C5daRENCjgB9n5Qclvq8
 h2h7DbM/KnNg4/Th1Q0/4rWNI3Esy3lUdoEF8Jun+KxMRYimTMpIUpOX6NOPCjZ+zT
 UD9oBADqcSMKlITopyJzvLBymEb3z7yMDJ5teN/E=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org,
	vsementsov@yandex-team.ru
Subject: [PATCH 01/19] net/tap: net_init_tap_one(): add return value
Date: Mon, 18 Aug 2025 17:06:27 +0300
Message-ID: <20250818140645.27904-2-vsementsov@yandex-team.ru>
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

To avoid error propagation, let's follow common recommendation to
use return value together with errp.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 net/tap.c | 55 +++++++++++++++++++++++++------------------------------
 1 file changed, 25 insertions(+), 30 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index f7df702f97..531ef75e91 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -680,11 +680,11 @@ static int net_tap_init(const NetdevTapOptions *tap, int *vnet_hdr,
 
 #define MAX_TAP_QUEUES 1024
 
-static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
-                             const char *model, const char *name,
-                             const char *ifname, const char *script,
-                             const char *downscript, const char *vhostfdname,
-                             int vnet_hdr, int fd, Error **errp)
+static int net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
+                            const char *model, const char *name,
+                            const char *ifname, const char *script,
+                            const char *downscript, const char *vhostfdname,
+                            int vnet_hdr, int fd, Error **errp)
 {
     Error *err = NULL;
     TAPState *s = net_tap_fd_init(peer, model, name, fd, vnet_hdr);
@@ -765,10 +765,11 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
         goto failed;
     }
 
-    return;
+    return 0;
 
 failed:
     qemu_del_net_client(&s->nc);
+    return -1;
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
@@ -852,12 +852,10 @@ int net_init_tap(const Netdev *netdev, const char *name,
             return -1;
         }
 
-        net_init_tap_one(tap, peer, "tap", name, NULL,
-                         script, downscript,
-                         vhostfdname, vnet_hdr, fd, &err);
-        if (err) {
-            error_propagate(errp, err);
-            close(fd);
+        ret = net_init_tap_one(tap, peer, "tap", name, NULL,
+                               script, downscript,
+                               vhostfdname, vnet_hdr, fd, errp);
+        if (ret < 0) {
             return -1;
         }
     } else if (tap->fds) {
@@ -915,12 +913,11 @@ int net_init_tap(const Netdev *netdev, const char *name,
                 goto free_fail;
             }
 
-            net_init_tap_one(tap, peer, "tap", name, ifname,
-                             script, downscript,
-                             tap->vhostfds ? vhost_fds[i] : NULL,
-                             vnet_hdr, fd, &err);
-            if (err) {
-                error_propagate(errp, err);
+            ret = net_init_tap_one(tap, peer, "tap", name, ifname,
+                                   script, downscript,
+                                   tap->vhostfds ? vhost_fds[i] : NULL,
+                                   vnet_hdr, fd, errp);
+            if (ret < 0) {
                 ret = -1;
                 goto free_fail;
             }
@@ -961,11 +958,10 @@ free_fail:
             return -1;
         }
 
-        net_init_tap_one(tap, peer, "bridge", name, ifname,
-                         script, downscript, vhostfdname,
-                         vnet_hdr, fd, &err);
-        if (err) {
-            error_propagate(errp, err);
+        ret = net_init_tap_one(tap, peer, "bridge", name, ifname,
+                               script, downscript, vhostfdname,
+                               vnet_hdr, fd, errp);
+        if (ret < 0) {
             close(fd);
             return -1;
         }
@@ -1006,12 +1002,11 @@ free_fail:
                 }
             }
 
-            net_init_tap_one(tap, peer, "tap", name, ifname,
-                             i >= 1 ? "no" : script,
-                             i >= 1 ? "no" : downscript,
-                             vhostfdname, vnet_hdr, fd, &err);
-            if (err) {
-                error_propagate(errp, err);
+            ret = net_init_tap_one(tap, peer, "tap", name, ifname,
+                                   i >= 1 ? "no" : script,
+                                   i >= 1 ? "no" : downscript,
+                                   vhostfdname, vnet_hdr, fd, errp);
+            if (ret < 0) {
                 close(fd);
                 return -1;
             }
-- 
2.48.1


