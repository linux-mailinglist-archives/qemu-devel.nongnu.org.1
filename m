Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FA1BCF676
	for <lists+qemu-devel@lfdr.de>; Sat, 11 Oct 2025 16:11:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7a8P-0006T9-CX; Sat, 11 Oct 2025 09:59:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7a84-0006NR-Oj
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 09:59:25 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7a7c-0004mH-8r
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 09:59:24 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id E8184C00BE;
 Sat, 11 Oct 2025 16:58:20 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a4b::1:3c])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id uvMPBZ1FEOs0-EnKTwD6O; Sat, 11 Oct 2025 16:58:20 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760191100;
 bh=4ZFS7VeU5sKpFc5IFb6anQVAn3TG0buI2JtzIiCbrd4=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=qr4IMI9g5RGC7kuFfmcD70Qe40FXjowDQMuXsJ/qVdaiHIBlLkjK6+YfVsOnl+PsG
 IxnvtGxZHpMmAKrtTP3hGE/XKQNK9QCqAojKOETk1TLReHGhGwWC8GVFUadHLsWmOo
 cW/IhkYws/skdBTlNJy9zr2Ekrw2MBywHS86V140=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: armbru@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, eblake@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 24/33] qapi/sockets.json: docs: width=70 and two spaces
 between sentences
Date: Sat, 11 Oct 2025 16:57:27 +0300
Message-ID: <20251011135754.294521-47-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251011135754.294521-1-vsementsov@yandex-team.ru>
References: <20251011135754.294521-1-vsementsov@yandex-team.ru>
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
 qapi/sockets.json | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/qapi/sockets.json b/qapi/sockets.json
index 32fac51728..473be2ac58 100644
--- a/qapi/sockets.json
+++ b/qapi/sockets.json
@@ -58,24 +58,26 @@
 # @ipv6: whether to accept IPv6 addresses, default try both IPv4 and
 #     IPv6
 #
-# @keep-alive: enable keep-alive when connecting to/listening on this socket.
+# @keep-alive: enable keep-alive when connecting to/listening on this
+#     socket.
 #     (Since 4.2, not supported for listening sockets until 10.1)
 #
-# @keep-alive-count: number of keep-alive packets sent before the connection is
-#     closed.  Only supported for TCP sockets on systems where TCP_KEEPCNT
-#     socket option is defined (this includes Linux, Windows, macOS, FreeBSD,
-#     but not OpenBSD).  When set to 0, system setting is used.  (Since 10.1)
-#
-# @keep-alive-idle: time in seconds the connection needs to be idle before
-#     sending a keepalive packet.  Only supported for TCP sockets on systems
-#     where TCP_KEEPIDLE socket option is defined (this includes Linux,
-#     Windows, macOS, FreeBSD, but not OpenBSD).  When set to 0, system setting
-#     is used.  (Since 10.1)
-#
-# @keep-alive-interval: time in seconds between keep-alive packets.  Only
-#     supported for TCP sockets on systems where TCP_KEEPINTVL is defined (this
-#     includes Linux, Windows, macOS, FreeBSD, but not OpenBSD).  When set to
-#     0, system setting is used.  (Since 10.1)
+# @keep-alive-count: number of keep-alive packets sent before the
+#     connection is closed.  Only supported for TCP sockets on systems
+#     where TCP_KEEPCNT socket option is defined (this includes Linux,
+#     Windows, macOS, FreeBSD, but not OpenBSD).  When set to 0,
+#     system setting is used.  (Since 10.1)
+#
+# @keep-alive-idle: time in seconds the connection needs to be idle
+#     before sending a keepalive packet.  Only supported for TCP
+#     sockets on systems where TCP_KEEPIDLE socket option is defined
+#     (this includes Linux, Windows, macOS, FreeBSD, but not OpenBSD).
+#     When set to 0, system setting is used.  (Since 10.1)
+#
+# @keep-alive-interval: time in seconds between keep-alive packets.
+#     Only supported for TCP sockets on systems where TCP_KEEPINTVL is
+#     defined (this includes Linux, Windows, macOS, FreeBSD, but not
+#     OpenBSD).  When set to 0, system setting is used.  (Since 10.1)
 #
 # @mptcp: enable multi-path TCP.  (Since 6.1)
 #
-- 
2.48.1


