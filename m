Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9615BCF694
	for <lists+qemu-devel@lfdr.de>; Sat, 11 Oct 2025 16:13:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7aDt-0004ee-0q; Sat, 11 Oct 2025 10:05:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7aDZ-0004Ko-Ul; Sat, 11 Oct 2025 10:05:06 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7aDN-0005Oh-Bm; Sat, 11 Oct 2025 10:05:04 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 0EBC0C0183;
 Sat, 11 Oct 2025 17:04:47 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a4b::1:3c])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id h4NOTl1FrqM0-5GZTqjOt; Sat, 11 Oct 2025 17:04:46 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760191486;
 bh=0thFphHwZBRGYyoK4iTbQ6WBNY93AwWkUFuAz/JTb9E=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=x6wkFQiKtPv0ONBx1N0S0d97gO73XmfFKG7znb/DnHIxKTCShCqqX4gjSBmZfO2+t
 AkOH2FTn8O7TIZeWxCHNwzrSKs3e+WgbU92LgIYJJIBu3oWqsgCiswZHUUsNZdzcTQ
 Rd0kn3xRU2e7qiWQvx7s4D6Tq/kAt8Wpju/iwMo4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: armbru@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, eblake@redhat.com,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [PATCH v2 05/33] qapi/block-export.json: docs: width=70 and two
 spaces between sentences
Date: Sat, 11 Oct 2025 17:04:11 +0300
Message-ID: <20251011140441.297246-6-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251011140441.297246-1-vsementsov@yandex-team.ru>
References: <20251011140441.297246-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
 qapi/block-export.json | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/qapi/block-export.json b/qapi/block-export.json
index 6878b89dcf..076954ef1a 100644
--- a/qapi/block-export.json
+++ b/qapi/block-export.json
@@ -38,8 +38,8 @@
 ##
 # @NbdServerOptions:
 #
-# Keep this type consistent with the `NbdServerOptionsLegacy` type.  The
-# only intended difference is using `SocketAddress` instead of
+# Keep this type consistent with the `NbdServerOptionsLegacy` type.
+# The only intended difference is using `SocketAddress` instead of
 # `SocketAddressLegacy`.
 #
 # @addr: Address on which to listen (since 4.2).
@@ -51,8 +51,8 @@
 ##
 # @NbdServerOptionsLegacy:
 #
-# Keep this type consistent with the `NbdServerOptions` type.  The only
-# intended difference is using `SocketAddressLegacy` instead of
+# Keep this type consistent with the `NbdServerOptions` type.  The
+# only intended difference is using `SocketAddressLegacy` instead of
 # `SocketAddress`.
 #
 # @addr: Address on which to listen (since 1.3).
@@ -125,8 +125,8 @@
 # A vhost-user-blk block export.
 #
 # @addr: The vhost-user socket on which to listen.  Both 'unix' and
-#     'fd' `SocketAddress` types are supported.  Passed fds must be UNIX
-#     domain sockets.
+#     'fd' `SocketAddress` types are supported.  Passed fds must be
+#     UNIX domain sockets.
 #
 # @logical-block-size: Logical block size in bytes.  Defaults to 512
 #     bytes.
@@ -373,11 +373,12 @@
 #     cannot be moved to the iothread.  The default is false.
 #     (since: 5.2)
 #
-# @allow-inactive: If true, the export allows the exported node to be inactive.
-#     If it is created for an inactive block node, the node remains inactive.  If
-#     the export type doesn't support running on an inactive node, an error is
-#     returned.  If false, inactive block nodes are automatically activated before
-#     creating the export and trying to inactivate them later fails.
+# @allow-inactive: If true, the export allows the exported node to be
+#     inactive.  If it is created for an inactive block node, the node
+#     remains inactive.  If the export type doesn't support running on
+#     an inactive node, an error is returned.  If false, inactive
+#     block nodes are automatically activated before creating the
+#     export and trying to inactivate them later fails.
 #     (since: 10.0; default: false)
 #
 # Since: 4.2
@@ -460,7 +461,8 @@
 # @node-name: The node name of the block node that is exported
 #
 # @shutting-down: True if the export is shutting down (e.g. after a
-#     `block-export-del` command, but before the shutdown has completed)
+#     `block-export-del` command, but before the shutdown has
+#     completed)
 #
 # Since: 5.2
 ##
-- 
2.48.1


