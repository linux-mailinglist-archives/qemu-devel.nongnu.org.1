Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D534BDEBF1
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Oct 2025 15:26:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v91SR-0005QI-SL; Wed, 15 Oct 2025 09:22:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v91S9-0005Iy-4H
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 09:22:06 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v91Rw-00030b-QI
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 09:22:04 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:49f:0:640:b99a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 836C888AC9;
 Wed, 15 Oct 2025 16:21:46 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a94::1:15])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id bLQ5oq0N5Os0-Rak7kRhI; Wed, 15 Oct 2025 16:21:46 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760534506;
 bh=hBBLVUnal74IiYpctK3zPNaVGPEhk/xudXLj3q7/EVs=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=R2EEplC0SAaGkl+BCSc+irKPYBCv+2eANII7tIxQhE0CrquQ1Uk62MNX7hR+q+mQL
 YaLyp85cOo+/OViH8euhWYkf6dvqtFvYW1Mq0A8qL/gLB6ApWHFGpAb5pbtNuuAbG3
 8DOBM5uoqS/88Z7acqvmqSN2oKrNvammbV5amb0c=
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
Subject: [PATCH v8 07/19] net/tap: split net_tap_fd_init()
Date: Wed, 15 Oct 2025 16:21:23 +0300
Message-ID: <20251015132136.1083972-8-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251015132136.1083972-1-vsementsov@yandex-team.ru>
References: <20251015132136.1083972-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Split the function into separate net_tap_new() and net_tap_set_fd().

We start move to the following picture:

net_tap_new() - take QAPI @tap parameter, but don't have @fd,
initialize the net client, called during initialization.

net_tap_setup() - don't have @tap (QAPI), but have @fd parameter,
may be called at later point.

In this commit we introduce the first function.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Maksim Davydov <davydov-max@yandex-team.ru>
---
 net/tap.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 17ad561f9c..7cb694e683 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -412,19 +412,20 @@ static NetClientInfo net_tap_info = {
     .get_vhost_net = tap_get_vhost_net,
 };
 
-static TAPState *net_tap_fd_init(NetClientState *peer,
-                                 const char *model,
-                                 const char *name,
-                                 int fd,
-                                 int vnet_hdr)
+static TAPState *net_tap_new(NetClientState *peer, const char *model,
+                             const char *name)
 {
-    NetOffloads ol = {};
-    NetClientState *nc;
-    TAPState *s;
+    NetClientState *nc = qemu_new_net_client(&net_tap_info, peer, model, name);
+    TAPState *s = DO_UPCAST(TAPState, nc, nc);
 
-    nc = qemu_new_net_client(&net_tap_info, peer, model, name);
+    s->fd = -1;
 
-    s = DO_UPCAST(TAPState, nc, nc);
+    return s;
+}
+
+static void net_tap_set_fd(TAPState *s, int fd, int vnet_hdr)
+{
+    NetOffloads ol = {};
 
     s->fd = fd;
     s->host_vnet_hdr_len = vnet_hdr ? sizeof(struct virtio_net_hdr) : 0;
@@ -443,8 +444,6 @@ static TAPState *net_tap_fd_init(NetClientState *peer,
     }
     tap_read_poll(s, true);
     s->vhost_net = NULL;
-
-    return s;
 }
 
 static void close_all_fds_after_fork(int excluded_fd)
@@ -661,7 +660,9 @@ int net_init_bridge(const Netdev *netdev, const char *name,
         close(fd);
         return -1;
     }
-    s = net_tap_fd_init(peer, "bridge", name, fd, vnet_hdr);
+
+    s = net_tap_new(peer, "bridge", name);
+    net_tap_set_fd(s, fd, vnet_hdr);
 
     qemu_set_info_str(&s->nc, "helper=%s,br=%s", helper, br);
 
@@ -702,9 +703,11 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
                              int vnet_hdr, int fd, Error **errp)
 {
     Error *err = NULL;
-    TAPState *s = net_tap_fd_init(peer, model, name, fd, vnet_hdr);
+    TAPState *s = net_tap_new(peer, model, name);
     int vhostfd;
 
+    net_tap_set_fd(s, fd, vnet_hdr);
+
     tap_set_sndbuf(s->fd, tap, &err);
     if (err) {
         error_propagate(errp, err);
-- 
2.48.1


