Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9EABDEC12
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Oct 2025 15:27:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v91ST-0005S7-Qo; Wed, 15 Oct 2025 09:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v91SK-0005Lb-6l
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 09:22:18 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v91S7-000348-Qz
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 09:22:15 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:49f:0:640:b99a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 329D188AD6;
 Wed, 15 Oct 2025 16:21:49 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a94::1:15])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id bLQ5oq0N5Os0-dJiWNCkq; Wed, 15 Oct 2025 16:21:48 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760534508;
 bh=Rn2HksTFyzmo06oKJaSInOpdhEVFJkUFFxj6tzH9yK8=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=d0BJQ5e0F3buVgVWcLIMS77ErxFTNxwi/HnsxjUthgpniybvG0goMnAZD2iQhqY61
 Ty6sqtlCR5MnUj2AwOruPY3KcK1Q8Dm4uZxZnmX9cGFNfWSjJbZ/bz5gIZsg+gW9aM
 BjV3NGUOh43D54py1NxL1UMtaU6A70OlGllBS6V0=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
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
Subject: [PATCH v8 10/19] net/tap: rework sndbuf handling
Date: Wed, 15 Oct 2025 16:21:26 +0300
Message-ID: <20251015132136.1083972-11-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251015132136.1083972-1-vsementsov@yandex-team.ru>
References: <20251015132136.1083972-1-vsementsov@yandex-team.ru>
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

Continue the main idea: avoid dependency on @tap in net_tap_setup().
So, move QAPI parsing to net_tap_new().
Move setting sndbuf to net_tap_set_fd(), as it's more appropriate place
(other initial fd settings are here).

Note that net_tap_new() and net_tap_set_fd() are shared with
net_init_bridge(), which didn't set sndbuf. Handle this case by sndbuf=0
(we never pass zero to tap_set_sndbuf(), so let this specific value mean
that we don't want touch sndbuf).

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Maksim Davydov <davydov-max@yandex-team.ru>
---
 net/tap.c | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index f5830f4b00..b5ac856a3d 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -83,6 +83,9 @@ typedef struct TAPState {
     VHostNetState *vhost_net;
     unsigned host_vnet_hdr_len;
     Notifier exit;
+
+    bool sndbuf_required;
+    int sndbuf;
 } TAPState;
 
 static void launch_script(const char *setup_script, const char *ifname,
@@ -413,17 +416,25 @@ static NetClientInfo net_tap_info = {
 };
 
 static TAPState *net_tap_new(NetClientState *peer, const char *model,
-                             const char *name)
+                             const char *name, const NetdevTapOptions *tap)
 {
     NetClientState *nc = qemu_new_net_client(&net_tap_info, peer, model, name);
     TAPState *s = DO_UPCAST(TAPState, nc, nc);
 
     s->fd = -1;
 
+    if (!tap) {
+        return s;
+    }
+
+    s->sndbuf_required = tap->has_sndbuf;
+    s->sndbuf =
+        (tap->has_sndbuf && tap->sndbuf) ? MIN(tap->sndbuf, INT_MAX) : INT_MAX;
+
     return s;
 }
 
-static void net_tap_set_fd(TAPState *s, int fd, int vnet_hdr)
+static bool net_tap_set_fd(TAPState *s, int fd, int vnet_hdr, Error **errp)
 {
     NetOffloads ol = {};
 
@@ -444,6 +455,15 @@ static void net_tap_set_fd(TAPState *s, int fd, int vnet_hdr)
     }
     tap_read_poll(s, true);
     s->vhost_net = NULL;
+
+    if (s->sndbuf) {
+        Error **e = s->sndbuf_required ? errp : NULL;
+        if (!tap_set_sndbuf(s->fd, s->sndbuf, e) && s->sndbuf_required) {
+            return false;
+        }
+    }
+
+    return true;
 }
 
 static void close_all_fds_after_fork(int excluded_fd)
@@ -661,8 +681,8 @@ int net_init_bridge(const Netdev *netdev, const char *name,
         return -1;
     }
 
-    s = net_tap_new(peer, "bridge", name);
-    net_tap_set_fd(s, fd, vnet_hdr);
+    s = net_tap_new(peer, "bridge", name, NULL);
+    net_tap_set_fd(s, fd, vnet_hdr, &error_abort);
 
     qemu_set_info_str(&s->nc, "helper=%s,br=%s", helper, br);
 
@@ -702,16 +722,10 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
                              const char *downscript, const char *vhostfdname,
                              int vnet_hdr, int fd, Error **errp)
 {
-    TAPState *s = net_tap_new(peer, model, name);
+    TAPState *s = net_tap_new(peer, model, name, tap);
     int vhostfd;
-    bool sndbuf_required = tap->has_sndbuf;
-    int sndbuf =
-        (tap->has_sndbuf && tap->sndbuf) ? MIN(tap->sndbuf, INT_MAX) : INT_MAX;
-
-    net_tap_set_fd(s, fd, vnet_hdr);
 
-    if (!tap_set_sndbuf(fd, sndbuf, sndbuf_required ? errp : NULL) &&
-        sndbuf_required) {
+    if (!net_tap_set_fd(s, fd, vnet_hdr, errp)) {
         goto failed;
     }
 
-- 
2.48.1


