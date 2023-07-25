Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 785A1761C53
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 16:56:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOJSJ-0002vh-10; Tue, 25 Jul 2023 10:56:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qOJS7-0002QZ-23; Tue, 25 Jul 2023 10:55:56 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qOJS5-0000FC-Hk; Tue, 25 Jul 2023 10:55:54 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5F119161C6;
 Tue, 25 Jul 2023 17:55:38 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 0C62919541;
 Tue, 25 Jul 2023 17:55:36 +0300 (MSK)
Received: (nullmailer pid 3375821 invoked by uid 1000);
 Tue, 25 Jul 2023 14:55:34 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 8/8] qapi: Correct "eg." to "e.g." in documentation
Date: Tue, 25 Jul 2023 17:55:32 +0300
Message-Id: <ff62c210165cf61b15f18c8a9835a5a5ce6c5a53.1690294956.git.mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1690294956.git.mjt@tls.msk.ru>
References: <cover.1690294956.git.mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Markus Armbruster <armbru@redhat.com>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 qapi/char.json | 2 +-
 qapi/misc.json | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/qapi/char.json b/qapi/char.json
index e413ac2b70..52aaff25eb 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -18,7 +18,7 @@
 # @filename: the filename of the character device
 #
 # @frontend-open: shows whether the frontend device attached to this
-#     backend (eg. with the chardev=... option) is in open or closed
+#     backend (e.g. with the chardev=... option) is in open or closed
 #     state (since 2.1)
 #
 # Notes: @filename is encoded using the QEMU command line character
diff --git a/qapi/misc.json b/qapi/misc.json
index ff070ec828..cda2effa81 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -18,7 +18,7 @@
 # fail and the FD will be closed.
 #
 # @protocol: protocol name.  Valid names are "vnc", "spice",
-#     "@dbus-display" or the name of a character device (eg. from
+#     "@dbus-display" or the name of a character device (e.g. from
 #     -chardev id=XXXX)
 #
 # @fdname: file descriptor name previously passed via 'getfd' command
-- 
2.39.2


