Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F82B32A5B
	for <lists+qemu-devel@lfdr.de>; Sat, 23 Aug 2025 18:07:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upqip-0005Sy-SQ; Sat, 23 Aug 2025 12:04:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1upqiS-0005LA-Be
 for qemu-devel@nongnu.org; Sat, 23 Aug 2025 12:03:42 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1upqiP-0000Iu-Ta
 for qemu-devel@nongnu.org; Sat, 23 Aug 2025 12:03:40 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c23:36c1:0:640:5f85:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 89FC480781;
 Sat, 23 Aug 2025 19:03:33 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:c91::1:b])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id Q3YUrj0Gl8c0-7Ym0DEOq; Sat, 23 Aug 2025 19:03:33 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1755965013;
 bh=zxe/Qn8qaUIKSb9GVBdarhgmP62+YL/GaisgtgQiiKc=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=ccKMhgYqkIAnm0fBjWaC978fqQjPQjxDunB0vwwZH2Sfm2PVhSyMkbScTY006vLe0
 LS4EZX+dNRKcUqRhdnnXXoURWfieUcavdBVBkuNNjgRrLuChLsYeNxE3Q+saXlQLCE
 MRMDFGaf/pXPCTHtFfbNbJmnZNFt9lpdIwT8+WQU=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, leiyang@redhat.com,
 steven.sistare@oracle.com
Subject: [PATCH v2 12/20] net/tap: net_init_tap_one(): support bridge
Date: Sat, 23 Aug 2025 19:03:15 +0300
Message-ID: <20250823160323.20811-13-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250823160323.20811-1-vsementsov@yandex-team.ru>
References: <20250823160323.20811-1-vsementsov@yandex-team.ru>
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

Use net_init_tap_one() in net_init_bridge().

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 net/tap.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 468dae7004..5acfb128a1 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -88,6 +88,12 @@ static void launch_script(const char *setup_script, const char *ifname,
 static void tap_send(void *opaque);
 static void tap_writable(void *opaque);
 
+static int net_init_tap_one(const Netdev *netdev, NetClientState *peer,
+                            const char *model, const char *name,
+                            const char *ifname, const char *script,
+                            const char *downscript, const char *vhostfdname,
+                            int vnet_hdr, int fd, Error **errp);
+
 static void tap_update_fd_handler(TAPState *s)
 {
     qemu_set_fd_handler(s->fd,
@@ -626,8 +632,7 @@ int net_init_bridge(const Netdev *netdev, const char *name,
 {
     const NetdevBridgeOptions *bridge;
     const char *helper, *br;
-    TAPState *s;
-    int fd, vnet_hdr;
+    int fd, vnet_hdr, ret;
 
     assert(netdev->type == NET_CLIENT_DRIVER_BRIDGE);
     bridge = &netdev->u.bridge;
@@ -648,9 +653,14 @@ int net_init_bridge(const Netdev *netdev, const char *name,
         close(fd);
         return -1;
     }
-    s = net_tap_fd_init(peer, "bridge", name, fd, vnet_hdr);
 
-    qemu_set_info_str(&s->nc, "helper=%s,br=%s", helper, br);
+    ret = net_init_tap_one(netdev, peer, "bridge", name,
+                           NULL, NULL, NULL,
+                           NULL, vnet_hdr, fd, errp);
+    if (ret < 0) {
+        close(fd);
+        return -1;
+    }
 
     return 0;
 }
@@ -698,11 +708,19 @@ static int net_init_tap_one(const Netdev *netdev, NetClientState *peer,
                             const char *downscript, const char *vhostfdname,
                             int vnet_hdr, int fd, Error **errp)
 {
-    const NetdevTapOptions *tap = &netdev->u.tap;
+    const NetdevTapOptions *tap;
     TAPState *s = net_tap_fd_init(peer, model, name, fd, vnet_hdr);
     int vhostfd;
 
+    if (netdev->type == NET_CLIENT_DRIVER_BRIDGE) {
+        const NetdevBridgeOptions *bridge = &netdev->u.bridge;
+        qemu_set_info_str(&s->nc, "helper=%s,br=%s",
+                          bridge->helper, bridge->br);
+        return 0;
+    }
+
     assert(netdev->type == NET_CLIENT_DRIVER_TAP);
+    tap = &netdev->u.tap;
 
     if (tap_set_sndbuf(s->fd, tap, errp) < 0) {
         goto failed;
-- 
2.48.1


