Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D0228B99EB5
	for <lists+qemu-devel@lfdr.de>; Wed, 24 Sep 2025 14:46:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1OrJ-0007pb-Hy; Wed, 24 Sep 2025 08:44:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v1OrB-0007pD-R5
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 08:44:25 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v1Or4-0004OD-Mr
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 08:44:25 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:cf2d:0:640:140f:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 04BA080CF4;
 Wed, 24 Sep 2025 15:44:13 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b6c::1:2c])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 8iXHSd0Fn8c0-Th3EqS5q; Wed, 24 Sep 2025 15:44:12 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1758717852;
 bh=Ve9OqhO9WzT5hfbCAe3WrCQl7xRVAYMbpITxwtvvFWM=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=OH0JnR4F50e71rsPSyV/EzHLd3jRMK/2UbrmiqbNxiXirpmhS4JV8fISm+CMadSC2
 gfLtmz34+c3p2SkFcQ1C5yETj5OeWC6E7zk3BEdGGKWvHRiHYV3/gKE1Cl9rKfqqSY
 nHgAW6JyKAhFQ8wNfbNhiSJOrBt491Bn8z7Lb0go=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: armbru@redhat.com
Cc: qemu-devel@nongnu.org, eblake@redhat.com, jasowang@redhat.com,
 devel@lists.libvirt.org, pbonzini@redhat.com, marcandre.lureau@redhat.com,
 yc-core@yandex-team.ru, vsementsov@yandex-team.ru,
 d-tatianin@yandex-team.ru
Subject: [PATCH 2/2] net/stream: remove deprecated 'reconnect' option
Date: Wed, 24 Sep 2025 15:44:06 +0300
Message-ID: <20250924124406.320704-3-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250924124406.320704-1-vsementsov@yandex-team.ru>
References: <20250924124406.320704-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

It was deprecated in 9.2, time to remove.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 docs/about/deprecated.rst       |  9 ---------
 docs/about/removed-features.rst | 10 ++++++++++
 net/stream.c                    | 20 +++++---------------
 qapi/net.json                   | 10 ----------
 4 files changed, 15 insertions(+), 34 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index ba0be97513..4452c08bf5 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -439,15 +439,6 @@ Backend ``memory`` (since 9.0)
 ``memory`` is a deprecated synonym for ``ringbuf``.
 
 
-Net device options
-''''''''''''''''''
-
-Stream ``reconnect`` (since 9.2)
-^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-
-The ``reconnect`` option only allows specifying second granularity timeouts,
-which is not enough for all types of use cases, use ``reconnect-ms`` instead.
-
 CPU device properties
 '''''''''''''''''''''
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index d67928956a..ae7d7287fc 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -1373,4 +1373,14 @@ Character device options
 The ``reconnect`` has been replaced by ``reconnect-ms``, which provides
 better precision.
 
+Net device options
+''''''''''''''''''
+
+Stream ``reconnect`` (removed in 10.2)
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The ``reconnect`` has been replaced by ``reconnect-ms``, which provides
+better precision.
+
+
 .. _Intel discontinuance notification: https://www.intel.com/content/www/us/en/content-details/781327/intel-is-discontinuing-ip-ordering-codes-listed-in-pdn2312-for-nios-ii-ip.html
diff --git a/net/stream.c b/net/stream.c
index 94f823a2a7..ea83f4a763 100644
--- a/net/stream.c
+++ b/net/stream.c
@@ -274,23 +274,13 @@ int net_init_stream(const Netdev *netdev, const char *name,
     sock = &netdev->u.stream;
 
     if (!sock->has_server || !sock->server) {
-        uint32_t reconnect_ms = 0;
-
-        if (sock->has_reconnect && sock->has_reconnect_ms) {
-            error_setg(errp, "'reconnect' and 'reconnect-ms' are mutually "
-                             "exclusive");
-            return -1;
-        } else if (sock->has_reconnect_ms) {
-            reconnect_ms = sock->reconnect_ms;
-        } else if (sock->has_reconnect) {
-            reconnect_ms = sock->reconnect * 1000u;
-        }
-
         return net_stream_client_init(peer, "stream", name, sock->addr,
-                                      reconnect_ms, errp);
+                                      sock->has_reconnect_ms ?
+                                          sock->reconnect_ms : 0,
+                                      errp);
     }
-    if (sock->has_reconnect || sock->has_reconnect_ms) {
-        error_setg(errp, "'reconnect' and 'reconnect-ms' options are "
+    if (sock->has_reconnect_ms) {
+        error_setg(errp, "'reconnect-ms' option is "
                          "incompatible with socket in server mode");
         return -1;
     }
diff --git a/qapi/net.json b/qapi/net.json
index 78bcc9871e..147340dad8 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -770,10 +770,6 @@
 #
 # @server: create server socket (default: false)
 #
-# @reconnect: For a client socket, if a socket is disconnected, then
-#     attempt a reconnect after the given number of seconds.  Setting
-#     this to zero disables this function.  (default: 0) (since 8.0)
-#
 # @reconnect-ms: For a client socket, if a socket is disconnected, then
 #     attempt a reconnect after the given number of milliseconds.  Setting
 #     this to zero disables this function.  This member is mutually
@@ -781,18 +777,12 @@
 #
 # Only `SocketAddress` types 'unix', 'inet' and 'fd' are supported.
 #
-# Features:
-#
-# @deprecated: Member @reconnect is deprecated.  Use @reconnect-ms
-#     instead.
-#
 # Since: 7.2
 ##
 { 'struct': 'NetdevStreamOptions',
   'data': {
     'addr':   'SocketAddress',
     '*server': 'bool',
-    '*reconnect': { 'type': 'int', 'features': [ 'deprecated' ] },
     '*reconnect-ms': 'int' } }
 
 ##
-- 
2.48.1


