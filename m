Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6593FB2A8BD
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Aug 2025 16:08:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uo0Vp-0001M1-Ck; Mon, 18 Aug 2025 10:07:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uo0Vl-0001Jx-4y
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 10:06:57 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uo0Vh-0002BR-DM
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 10:06:56 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c21:2d8b:0:640:7d49:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 7D4D4807B6;
 Mon, 18 Aug 2025 17:06:50 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b25::1:17])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id k6RC4003YeA0-iyRSPykr; Mon, 18 Aug 2025 17:06:50 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1755526010;
 bh=cVIuFmKaRA15APjAb94zI55tuavk/4RbFP5EQfNMKho=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=WR/KC6Hi5UQcdDhiEfIY2jv79cJG/s6q8v3t/yeVI6J4b30+7O+mL10xERTRzBmKz
 vnV+J/XOIzFl5YWTH7HmH6a/OHG4xRayzKP1/w7p9gaDWOE4yf6qedaA+HICJ/75MH
 F8ianmolFZNNnsNxK0/sV/d79slkuQzSk6BieMV4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org,
	vsementsov@yandex-team.ru
Subject: [PATCH 09/19] net/tap: use glib strings vector and g_strsplit for fds
 case
Date: Mon, 18 Aug 2025 17:06:35 +0300
Message-ID: <20250818140645.27904-10-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250818140645.27904-1-vsementsov@yandex-team.ru>
References: <20250818140645.27904-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 net/tap.c | 72 +++++++++++--------------------------------------------
 1 file changed, 14 insertions(+), 58 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 80ec54f914..ac8d955050 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -774,32 +774,6 @@ failed:
     return -1;
 }
 
-static int get_fds(char *str, char *fds[], int max)
-{
-    char *ptr = str, *this;
-    size_t len = strlen(str);
-    int i = 0;
-
-    while (i < max && ptr < str + len) {
-        this = strchr(ptr, ':');
-
-        if (this == NULL) {
-            fds[i] = g_strdup(ptr);
-        } else {
-            fds[i] = g_strndup(ptr, this - ptr);
-        }
-
-        i++;
-        if (this == NULL) {
-            break;
-        } else {
-            ptr = this + 1;
-        }
-    }
-
-    return i;
-}
-
 int net_init_tap(const Netdev *netdev, const char *name,
                  NetClientState *peer, Error **errp)
 {
@@ -859,74 +833,56 @@ int net_init_tap(const Netdev *netdev, const char *name,
             return -1;
         }
     } else if (tap->fds) {
-        char **fds;
-        char **vhost_fds;
-        int nfds = 0, nvhosts = 0;
+        g_auto(GStrv) fds = NULL;
+        g_auto(GStrv) vhost_fds = NULL;
+        int nfds;
 
         if (tap->helper || tap->vhostfd) {
             error_setg(errp, "helper= and vhostfd= are invalid with fds=");
             return -1;
         }
 
-        fds = g_new0(char *, MAX_TAP_QUEUES);
-        vhost_fds = g_new0(char *, MAX_TAP_QUEUES);
+        fds = g_strsplit(tap->fds, ":", MAX_TAP_QUEUES);
+        nfds = g_strv_length(fds);
 
-        nfds = get_fds(tap->fds, fds, MAX_TAP_QUEUES);
         if (tap->vhostfds) {
-            nvhosts = get_fds(tap->vhostfds, vhost_fds, MAX_TAP_QUEUES);
-            if (nfds != nvhosts) {
+            vhost_fds = g_strsplit(tap->vhostfds, ":", MAX_TAP_QUEUES);
+            if (nfds != g_strv_length(vhost_fds)) {
                 error_setg(errp, "The number of fds passed does not match "
                            "the number of vhostfds passed");
-                ret = -1;
-                goto free_fail;
+                return -1;
             }
         }
 
         for (i = 0; i < nfds; i++) {
             fd = monitor_fd_param(monitor_cur(), fds[i], errp);
             if (fd == -1) {
-                ret = -1;
-                goto free_fail;
+                return -1;
             }
 
             if (!set_fd_nonblocking(fd, fds[i], errp)) {
-                ret = -1;
-                goto free_fail;
+                return -1;
             }
 
             if (i == 0) {
                 vnet_hdr = tap_probe_vnet_hdr(fd, errp);
                 if (vnet_hdr < 0) {
-                    ret = -1;
-                    goto free_fail;
+                    return -1;
                 }
             } else if (vnet_hdr != tap_probe_vnet_hdr(fd, NULL)) {
                 error_setg(errp,
                            "vnet_hdr not consistent across given tap fds");
-                ret = -1;
-                goto free_fail;
+                return -1;
             }
 
             ret = net_init_tap_one(tap, peer, "tap", name, NULL,
                                    NULL, NULL,
-                                   tap->vhostfds ? vhost_fds[i] : NULL,
+                                   vhost_fds ? vhost_fds[i] : NULL,
                                    vnet_hdr, fd, errp);
             if (ret < 0) {
-                ret = -1;
-                goto free_fail;
+                return -1;
             }
         }
-
-free_fail:
-        for (i = 0; i < nvhosts; i++) {
-            g_free(vhost_fds[i]);
-        }
-        for (i = 0; i < nfds; i++) {
-            g_free(fds[i]);
-        }
-        g_free(fds);
-        g_free(vhost_fds);
-        return ret;
     } else if (tap->helper) {
         if (tap->vhostfds) {
             error_setg(errp, "vhostfds= is invalid with helper=");
-- 
2.48.1


