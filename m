Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 521C7B42007
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Sep 2025 14:53:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utmw6-000631-9Z; Wed, 03 Sep 2025 08:50:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utmvv-0005vv-5G
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 08:49:51 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utmvq-0000lU-HE
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 08:49:50 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id C4E23C0183;
 Wed, 03 Sep 2025 15:49:40 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b8f::1:11])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id anf8gZ3GnW20-sAVMNNfX; Wed, 03 Sep 2025 15:49:40 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1756903780;
 bh=NnzofHuEacNUQzhe3IlBSzP81JoN8oFO+l7H6mikaOs=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=Ub2qmVpPbF9yWFXIcEJKcPMSrh1LBZF8m+sVlJetPStr4XFoSg4sQyExYBoTvIcII
 kCkgPDOsMr0EsULNgUMmPqGsPBqSf5DfAzeqGKfoLWP2SWfnBZKWIyTI8leimFffok
 Sgt6+PxRmQUw4Evmh0NcUFhyBblyU0PlMw+XX5og=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, leiyang@redhat.com,
 steven.sistare@oracle.com, yc-core@yandex-team.ru
Subject: [PATCH v3 06/19] net/tap: net_init_tap(): drop extra variable
 vhostfdname
Date: Wed,  3 Sep 2025 15:49:20 +0300
Message-ID: <20250903124934.1169899-7-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250903124934.1169899-1-vsementsov@yandex-team.ru>
References: <20250903124934.1169899-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Tested-by: Lei Yang <leiyang@redhat.com>
---
 net/tap.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 23ea57d6d9..8e6a276e4b 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -795,14 +795,12 @@ int net_init_tap(const Netdev *netdev, const char *name,
     /* for the no-fd, no-helper case */
     const char *script;
     const char *downscript;
-    const char *vhostfdname;
     char ifname[128];
     int ret = 0;
 
     assert(netdev->type == NET_CLIENT_DRIVER_TAP);
     tap = &netdev->u.tap;
     queues = tap->has_queues ? tap->queues : 1;
-    vhostfdname = tap->vhostfd;
     script = tap->script;
     downscript = tap->downscript;
 
@@ -851,7 +849,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
 
         ret = net_init_tap_one(tap, peer, "tap", name, NULL,
                                script, downscript,
-                               vhostfdname, vnet_hdr, fd, errp);
+                               tap->vhostfd, vnet_hdr, fd, errp);
         if (ret < 0) {
             return -1;
         }
@@ -947,7 +945,7 @@ free_fail:
         }
 
         ret = net_init_tap_one(tap, peer, "bridge", name, ifname,
-                               script, downscript, vhostfdname,
+                               script, downscript, tap->vhostfd,
                                vnet_hdr, fd, errp);
         if (ret < 0) {
             close(fd);
@@ -993,7 +991,7 @@ free_fail:
             ret = net_init_tap_one(tap, peer, "tap", name, ifname,
                                    i >= 1 ? "no" : script,
                                    i >= 1 ? "no" : downscript,
-                                   vhostfdname, vnet_hdr, fd, errp);
+                                   tap->vhostfd, vnet_hdr, fd, errp);
             if (ret < 0) {
                 close(fd);
                 return -1;
-- 
2.48.1


