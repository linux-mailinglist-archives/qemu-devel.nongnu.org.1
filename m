Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB506B5973C
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Sep 2025 15:16:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyVXA-0006Ue-RX; Tue, 16 Sep 2025 09:15:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uyVVq-0005Mc-8H; Tue, 16 Sep 2025 09:14:27 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uyVVk-0006Yy-JW; Tue, 16 Sep 2025 09:14:24 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id E5623C025C;
 Tue, 16 Sep 2025 16:14:15 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:16c::1:b])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 5EQRob1Gj0U0-hosGCjbG; Tue, 16 Sep 2025 16:14:15 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1758028455;
 bh=wnQ0IZ7DL77fQvEXOsbqMh7icg1uQk/N/bd4HdRvKWE=;
 h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
 b=BaEd6yF51PHcOJy90jO4vHRHnOt22Iz294X+i4VdVJYXFBxpVCEfw4CbNNJ4Ope8C
 ejTzi5bhxRZEi2Q4AnMFQm7zv0+xIP0y3w8uER6edhbtsCG1PPGyjaCqCwg2a+wd+1
 ntfVhheZy5UsbLsbeJR9GKFUWKYtcd+5lKR0O1sc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: berrange@redhat.com
Cc: qemu-devel@nongnu.org, peterx@redhat.com, qemu-block@nongnu.org,
 vsementsov@yandex-team.ru, leiyang@redhat.com, marcandre.lureau@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>
Subject: [PATCH v5 09/13] util: drop qemu_socket_set_block()
Date: Tue, 16 Sep 2025 16:13:58 +0300
Message-ID: <20250916131403.368343-10-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250916131403.368343-1-vsementsov@yandex-team.ru>
References: <20250916131403.368343-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Now it's unused.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qemu/sockets.h | 1 -
 util/oslib-posix.c     | 6 ------
 util/oslib-win32.c     | 7 -------
 3 files changed, 14 deletions(-)

diff --git a/include/qemu/sockets.h b/include/qemu/sockets.h
index 9512fec514..be351d85f7 100644
--- a/include/qemu/sockets.h
+++ b/include/qemu/sockets.h
@@ -46,7 +46,6 @@ ssize_t qemu_send_full(int s, const void *buf, size_t count)
     G_GNUC_WARN_UNUSED_RESULT;
 int socket_set_cork(int fd, int v);
 int socket_set_nodelay(int fd);
-void qemu_socket_set_block(int fd);
 int socket_set_fast_reuse(int fd);
 
 #ifdef WIN32
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 7654febfa5..14cf94ac03 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -265,12 +265,6 @@ bool qemu_set_blocking(int fd, bool block, Error **errp)
     return true;
 }
 
-void qemu_socket_set_block(int fd)
-{
-    g_unix_set_fd_nonblocking(fd, false, NULL);
-}
-
-
 int socket_set_fast_reuse(int fd)
 {
     int val = 1, ret;
diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index bf5d478c5c..b9ce2f96ee 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -195,13 +195,6 @@ bool qemu_set_blocking(int fd, bool block, Error **errp)
     return true;
 }
 
-void qemu_socket_set_block(int fd)
-{
-    unsigned long opt = 0;
-    qemu_socket_unselect(fd, NULL);
-    ioctlsocket(fd, FIONBIO, &opt);
-}
-
 int socket_set_fast_reuse(int fd)
 {
     /* Enabling the reuse of an endpoint that was used by a socket still in
-- 
2.48.1


