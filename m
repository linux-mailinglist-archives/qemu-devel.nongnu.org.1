Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 492D4B51973
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Sep 2025 16:34:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwLs3-0005Oz-Ax; Wed, 10 Sep 2025 10:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uwLrw-0005ON-1H
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 10:32:20 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uwLrq-0007cj-Iu
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 10:32:19 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 3E6C180800;
 Wed, 10 Sep 2025 17:31:59 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b48::1:39])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id vVLKG00Gp4Y0-8uN2PbIv; Wed, 10 Sep 2025 17:31:58 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1757514718;
 bh=Yx4NTaUcJuKwbjUw/CSobD8Q4iaCeiBNFfAAK0QsBXo=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=N2LA4Xm25H/9QmtZItl515pTXfMYdzJyJXTS8iXBYIAv542dOkG3MIox/cKAG9d0Q
 qXgCHlQ4JSugBq0/zTHKeGrvzuw73/Tw/g50nCZfP1eW9pKKyTz5Gr+Fodj0Y5Rd9q
 v4ZuKLbHGTE+TSU+A8L0413051egYVUfY23eHMTQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: berrange@redhat.com
Cc: qemu-devel@nongnu.org, peterx@redhat.com, farosas@suse.de,
 steven.sistare@oracle.com, vsementsov@yandex-team.ru
Subject: [PATCH v3] migration/qemu-file: don't make incoming fds blocking again
Date: Wed, 10 Sep 2025 17:31:56 +0300
Message-ID: <20250910143156.1053779-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
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

In migration we want to pass fd "as is", not changing its
blocking status.

The only current user of these fds is CPR state (through VMSTATE_FD),
which of-course doesn't want to modify fds on target when source is
still running and use these fds.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---

v3: RESEND, add qemu-devel to CC, sorry for the noise
v2: rework, following Daniel's suggestion to use flag.

 include/io/channel.h  |  1 +
 io/channel-socket.c   | 12 ++++++++----
 io/channel.c          |  2 +-
 migration/qemu-file.c |  3 ++-
 4 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/include/io/channel.h b/include/io/channel.h
index 234e5db70d..5394f50768 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -36,6 +36,7 @@ OBJECT_DECLARE_TYPE(QIOChannel, QIOChannelClass,
 
 #define QIO_CHANNEL_READ_FLAG_MSG_PEEK 0x1
 #define QIO_CHANNEL_READ_FLAG_RELAXED_EOF 0x2
+#define QIO_CHANNEL_READ_FLAG_PRESERVE_BLOCKING 0x4
 
 typedef enum QIOChannelFeature QIOChannelFeature;
 
diff --git a/io/channel-socket.c b/io/channel-socket.c
index 3b7ca924ff..2f6e2d84a3 100644
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
@@ -556,7 +559,8 @@ static ssize_t qio_channel_socket_readv(QIOChannel *ioc,
     }
 
     if (fds && nfds) {
-        qio_channel_socket_copy_fds(&msg, fds, nfds);
+        qio_channel_socket_copy_fds(
+            &msg, fds, nfds, flags & QIO_CHANNEL_READ_FLAG_PRESERVE_BLOCKING);
     }
 
     return ret;
diff --git a/io/channel.c b/io/channel.c
index ebd9322765..50d5f7b10b 100644
--- a/io/channel.c
+++ b/io/channel.c
@@ -58,7 +58,7 @@ ssize_t qio_channel_readv_full(QIOChannel *ioc,
 {
     QIOChannelClass *klass = QIO_CHANNEL_GET_CLASS(ioc);
 
-    if ((fds || nfds) &&
+    if ((fds || nfds || (flags & QIO_CHANNEL_READ_FLAG_PRESERVE_BLOCKING)) &&
         !qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_FD_PASS)) {
         error_setg_errno(errp, EINVAL,
                          "Channel does not support file descriptor passing");
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index b6ac190034..92c7b5678b 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -324,6 +324,7 @@ static ssize_t coroutine_mixed_fn qemu_fill_buffer(QEMUFile *f)
     size_t nfd = 0;
     int **pfds = f->can_pass_fd ? &fds : NULL;
     size_t *pnfd = f->can_pass_fd ? &nfd : NULL;
+    int flags = f->can_pass_fd ? QIO_CHANNEL_READ_FLAG_PRESERVE_BLOCKING : 0;
 
     assert(!qemu_file_is_writable(f));
 
@@ -340,7 +341,7 @@ static ssize_t coroutine_mixed_fn qemu_fill_buffer(QEMUFile *f)
 
     do {
         struct iovec iov = { f->buf + pending, IO_BUF_SIZE - pending };
-        len = qio_channel_readv_full(f->ioc, &iov, 1, pfds, pnfd, 0,
+        len = qio_channel_readv_full(f->ioc, &iov, 1, pfds, pnfd, flags,
                                      &local_error);
         if (len == QIO_CHANNEL_ERR_BLOCK) {
             if (qemu_in_coroutine()) {
-- 
2.48.1


