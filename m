Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE74CBCE201
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Oct 2025 19:43:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7H6r-0008Jt-3c; Fri, 10 Oct 2025 13:40:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7H6b-0008Gp-Sz
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 13:40:37 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7H6J-0007Sq-LW
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 13:40:36 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:9297:0:640:61e7:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 254BC807A9;
 Fri, 10 Oct 2025 20:40:12 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a89::1:23])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id xdPFQ30FtmI0-SHDFVDmL; Fri, 10 Oct 2025 20:40:11 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760118011;
 bh=bQt+gPOuzNBNYHmDfV4+WMNfu6qlQ2YEWlgC+gNksfY=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=Q2bflAHJ39jjC+2SsDtFeNDQycL723FbCIA6pIpy4bOZKW0l7JVVBIRWcCrOAPASJ
 V/XfKbCHqaQfo8oLRZDCO/sBDv+2+aE5kUrevXuGQDaXhb9ZsYzWud1JkUaS4mJdJv
 gyGMuw6B9Y1rlZa1b4QlhTpcyIgBN1AjN3nm8fSI=
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
Subject: [PATCH v7 11/19] net/tap: introduce net_tap_setup()
Date: Fri, 10 Oct 2025 20:39:49 +0300
Message-ID: <20251010173957.166759-12-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251010173957.166759-1-vsementsov@yandex-team.ru>
References: <20251010173957.166759-1-vsementsov@yandex-team.ru>
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

Move most of net_init_tap_one() to net_tap_setup() - future pair
for net_tap_new(), for postponed setup.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Maksim Davydov <davydov-max@yandex-team.ru>
---
 net/tap.c | 39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index b5ac856a3d..b01cd4d6c2 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -88,6 +88,10 @@ typedef struct TAPState {
     int sndbuf;
 } TAPState;
 
+static bool net_tap_setup(TAPState *s, const NetdevTapOptions *tap,
+                          const char *vhostfdname,
+                          int fd, int vnet_hdr, Error **errp);
+
 static void launch_script(const char *setup_script, const char *ifname,
                           int fd, Error **errp);
 
@@ -723,11 +727,6 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
                              int vnet_hdr, int fd, Error **errp)
 {
     TAPState *s = net_tap_new(peer, model, name, tap);
-    int vhostfd;
-
-    if (!net_tap_set_fd(s, fd, vnet_hdr, errp)) {
-        goto failed;
-    }
 
     if (tap->fd || tap->fds) {
         qemu_set_info_str(&s->nc, "fd=%d", fd);
@@ -746,6 +745,21 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
         }
     }
 
+    if (!net_tap_setup(s, tap, vhostfdname, fd, vnet_hdr, errp)) {
+        qemu_del_net_client(&s->nc);
+    }
+}
+
+static bool net_tap_setup(TAPState *s, const NetdevTapOptions *tap,
+                          const char *vhostfdname,
+                          int fd, int vnet_hdr, Error **errp)
+{
+    int vhostfd;
+
+    if (!net_tap_set_fd(s, fd, vnet_hdr, errp)) {
+        return false;
+    }
+
     if (tap->has_vhost ? tap->vhost :
         vhostfdname || (tap->has_vhostforce && tap->vhostforce)) {
         VhostNetOptions options;
@@ -761,20 +775,20 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
         if (vhostfdname) {
             vhostfd = monitor_fd_param(monitor_cur(), vhostfdname, errp);
             if (vhostfd == -1) {
-                goto failed;
+                return false;
             }
             if (!qemu_set_blocking(vhostfd, false, errp)) {
-                goto failed;
+                return false;
             }
         } else {
             vhostfd = open("/dev/vhost-net", O_RDWR);
             if (vhostfd < 0) {
                 error_setg_errno(errp, errno,
                                  "tap: open vhost char device failed");
-                goto failed;
+                return false;
             }
             if (!qemu_set_blocking(vhostfd, false, errp)) {
-                goto failed;
+                return false;
             }
         }
         options.opaque = (void *)(uintptr_t)vhostfd;
@@ -789,14 +803,11 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
         if (!s->vhost_net) {
             error_setg(errp,
                        "vhost-net requested but could not be initialized");
-            goto failed;
+            return false;
         }
     }
 
-    return;
-
-failed:
-    qemu_del_net_client(&s->nc);
+    return true;
 }
 
 static int get_fds(char *str, char *fds[], int max)
-- 
2.48.1


