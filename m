Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D73D5B5211E
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Sep 2025 21:33:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwQXO-0000oj-RZ; Wed, 10 Sep 2025 15:31:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uwQXL-0000oR-Lg
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 15:31:23 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uwQXJ-0003q6-8I
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 15:31:23 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:999c:0:640:51a7:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 36A2F804CA;
 Wed, 10 Sep 2025 22:31:16 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b48::1:39])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id EVQIl30GrmI0-lbSdqVZf; Wed, 10 Sep 2025 22:31:15 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1757532675;
 bh=6zk2HlwQVu6MiqppbHH1LwEAltQId5nu3DmhF1Zfbf4=;
 h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
 b=VJEeJdxmorXMg6fq2DRqPC1CfND+3H5EEiK7FYB6l/GSjfK51RAIeKje8t5fPLux7
 3fablURFXGN2LOGQQakIxGd9/2Y6Cw3T4js8efVz9aCIKubniuFThUFQOIYsJWNYRA
 rQ2dcfmvLu9SOPfTBfw5QWWXuyTggM2HohtKjrk4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: berrange@redhat.com
Cc: peterx@redhat.com, farosas@suse.de, steven.sistare@oracle.com,
 vsementsov@yandex-team.ru, qemu-devel@nongnu.org
Subject: [PATCH v4 1/2] migration/qemu-file: don't make incoming fds blocking
 again
Date: Wed, 10 Sep 2025 22:31:11 +0300
Message-ID: <20250910193112.1220763-2-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250910193112.1220763-1-vsementsov@yandex-team.ru>
References: <20250910193112.1220763-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
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

In migration we want to pass fd "as is", not changing its
blocking status.

The only current user of these fds is CPR state (through VMSTATE_FD),
which of-course doesn't want to modify fds on target when source is
still running and use these fds.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 include/io/channel.h  |  1 +
 io/channel-socket.c   | 13 +++++++++----
 migration/qemu-file.c |  3 ++-
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/include/io/channel.h b/include/io/channel.h
index 234e5db70d..12266256a8 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -36,6 +36,7 @@ OBJECT_DECLARE_TYPE(QIOChannel, QIOChannelClass,
 
 #define QIO_CHANNEL_READ_FLAG_MSG_PEEK 0x1
 #define QIO_CHANNEL_READ_FLAG_RELAXED_EOF 0x2
+#define QIO_CHANNEL_READ_FLAG_FD_PRESERVE_BLOCKING 0x4
 
 typedef enum QIOChannelFeature QIOChannelFeature;
 
diff --git a/io/channel-socket.c b/io/channel-socket.c
index 3b7ca924ff..21f8f2e0c5 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -464,7 +464,8 @@ static void qio_channel_socket_finalize(Object *obj)
 
 #ifndef WIN32
 static void qio_channel_socket_copy_fds(struct msghdr *msg,
-                                        int **fds, size_t *nfds)
+                                        int **fds, size_t *nfds,
+                                        bool preserve_blocking)
 {
     struct cmsghdr *cmsg;
 
@@ -497,8 +498,10 @@ static void qio_channel_socket_copy_fds(struct msghdr *msg,
                 continue;
             }
 
-            /* O_NONBLOCK is preserved across SCM_RIGHTS so reset it */
-            qemu_socket_set_block(fd);
+            if (!preserve_blocking) {
+                /* O_NONBLOCK is preserved across SCM_RIGHTS so reset it */
+                qemu_socket_set_block(fd);
+            }
 
 #ifndef MSG_CMSG_CLOEXEC
             qemu_set_cloexec(fd);
@@ -556,7 +559,9 @@ static ssize_t qio_channel_socket_readv(QIOChannel *ioc,
     }
 
     if (fds && nfds) {
-        qio_channel_socket_copy_fds(&msg, fds, nfds);
+        qio_channel_socket_copy_fds(
+            &msg, fds, nfds,
+            flags & QIO_CHANNEL_READ_FLAG_FD_PRESERVE_BLOCKING);
     }
 
     return ret;
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index b6ac190034..d5c6e7ec61 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -340,7 +340,8 @@ static ssize_t coroutine_mixed_fn qemu_fill_buffer(QEMUFile *f)
 
     do {
         struct iovec iov = { f->buf + pending, IO_BUF_SIZE - pending };
-        len = qio_channel_readv_full(f->ioc, &iov, 1, pfds, pnfd, 0,
+        len = qio_channel_readv_full(f->ioc, &iov, 1, pfds, pnfd,
+                                     QIO_CHANNEL_READ_FLAG_FD_PRESERVE_BLOCKING,
                                      &local_error);
         if (len == QIO_CHANNEL_ERR_BLOCK) {
             if (qemu_in_coroutine()) {
-- 
2.48.1


