Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1943FB89527
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Sep 2025 13:55:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzZfY-00038E-Io; Fri, 19 Sep 2025 07:52:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uzZfP-0002yV-2A
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 07:52:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uzZfG-0000wG-CP
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 07:52:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758282747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JHLoJxwljpLeo0arktfCDo5fN3hVTtZXV5S/bRj7zZo=;
 b=TMNXltkZTi4jpPJvbITlJuvlAZRW4h0V38lUT5d4P4P0zLMvGEvsbreUwMP5f4XicUhJWr
 Tt5GUmQNkcR0yaFwBeVEtZxO6KcUqsIXvEHxKzwuqFuGYhe5LBU4+gODfUN3RH76EpO7gF
 Md3G4DtNAgwHfj6lsCwpg8jgTS1j82w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-D6NsE1Q6M0m18XQDPzxITA-1; Fri,
 19 Sep 2025 07:52:24 -0400
X-MC-Unique: D6NsE1Q6M0m18XQDPzxITA-1
X-Mimecast-MFC-AGG-ID: D6NsE1Q6M0m18XQDPzxITA_1758282742
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E983D180028E; Fri, 19 Sep 2025 11:52:21 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.187])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EDA111955F2D; Fri, 19 Sep 2025 11:52:12 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Jagannathan Raman <jag.raman@oracle.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-block@nongnu.org,
 Peter Xu <peterx@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 John Levon <john.levon@nutanix.com>, Fam Zheng <fam@euphon.net>,
 Alexander Bulekov <alxndr@bu.edu>, Stefan Weil <sw@weilnetz.de>,
 Gerd Hoffmann <kraxel@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Qiuhao Li <Qiuhao.Li@outlook.com>, Michael Roth <michael.roth@amd.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Bandan Das <bsd@redhat.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>
Subject: [PULL 11/16] io/channel-socket: rework qio_channel_socket_copy_fds()
Date: Fri, 19 Sep 2025 12:50:12 +0100
Message-ID: <20250919115017.1536203-12-berrange@redhat.com>
In-Reply-To: <20250919115017.1536203-1-berrange@redhat.com>
References: <20250919115017.1536203-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.105,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

We want to switch from qemu_socket_set_block() to newer
qemu_set_blocking(), which provides return status of operation,
to handle errors.

Still, we want to keep qio_channel_socket_readv() interface clean,
as currently it allocate @fds only on success.

So, in case of error, we should close all incoming fds and keep
user's @fds untouched or zero.

Let's make separate functions qio_channel_handle_fds() and
qio_channel_cleanup_fds(), to achieve what we want.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/io/channel.h |  8 +++---
 io/channel-socket.c  | 67 +++++++++++++++++++++++++++++++++-----------
 2 files changed, 55 insertions(+), 20 deletions(-)

diff --git a/include/io/channel.h b/include/io/channel.h
index 999a8f5f23..0f25ae0069 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -124,8 +124,8 @@ struct QIOChannelClass {
      * incoming fds are set BLOCKING (unless
      * QIO_CHANNEL_READ_FLAG_FD_PRESERVE_BLOCKING flag is set) and
      * CLOEXEC (if available).
-     * @fds and @nfds are set only on success path, and untouched
-     * in case of errors.
+     * @fds and @nfds are set only on success path. Still, setting
+     * @fds and @nfds to zero is acceptable on failure path.
      */
     ssize_t (*io_readv)(QIOChannel *ioc,
                         const struct iovec *iov,
@@ -246,8 +246,8 @@ void qio_channel_set_name(QIOChannel *ioc,
  * to call close() on each file descriptor and to
  * call g_free() on the array pointer in @fds.
  * @fds allocated and set (and @nfds is set too)
- * _only_ on success path. These parameters are
- * untouched in case of errors.
+ * _only_ on success path. Still, @fds and @nfds
+ * may be set to zero on failure path.
  * qio_channel_readv_full() guarantees that all
  * incoming fds are set BLOCKING (unless
  * QIO_CHANNEL_READ_FLAG_FD_PRESERVE_BLOCKING flag
diff --git a/io/channel-socket.c b/io/channel-socket.c
index f7e3cb9742..e53d9ac76f 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -464,8 +464,7 @@ static void qio_channel_socket_finalize(Object *obj)
 
 #ifndef WIN32
 static void qio_channel_socket_copy_fds(struct msghdr *msg,
-                                        int **fds, size_t *nfds,
-                                        bool preserve_blocking)
+                                        int **fds, size_t *nfds)
 {
     struct cmsghdr *cmsg;
 
@@ -473,7 +472,7 @@ static void qio_channel_socket_copy_fds(struct msghdr *msg,
     *fds = NULL;
 
     for (cmsg = CMSG_FIRSTHDR(msg); cmsg; cmsg = CMSG_NXTHDR(msg, cmsg)) {
-        int fd_size, i;
+        int fd_size;
         int gotfds;
 
         if (cmsg->cmsg_len < CMSG_LEN(sizeof(int)) ||
@@ -491,24 +490,53 @@ static void qio_channel_socket_copy_fds(struct msghdr *msg,
         gotfds = fd_size / sizeof(int);
         *fds = g_renew(int, *fds, *nfds + gotfds);
         memcpy(*fds + *nfds, CMSG_DATA(cmsg), fd_size);
+        *nfds += gotfds;
+    }
+}
 
-        for (i = 0; i < gotfds; i++) {
-            int fd = (*fds)[*nfds + i];
-            if (fd < 0) {
-                continue;
-            }
+static bool qio_channel_handle_fds(int *fds, size_t nfds,
+                                   bool preserve_blocking, Error **errp)
+{
+    int *end = fds + nfds, *fd;
+
+#ifdef MSG_CMSG_CLOEXEC
+    if (preserve_blocking) {
+        /* Nothing to do */
+        return true;
+    }
+#endif
 
-            if (!preserve_blocking) {
-                /* O_NONBLOCK is preserved across SCM_RIGHTS so reset it */
-                qemu_socket_set_block(fd);
+    for (fd = fds; fd != end; fd++) {
+        if (*fd < 0) {
+            continue;
+        }
+
+        if (!preserve_blocking) {
+            /* O_NONBLOCK is preserved across SCM_RIGHTS so reset it */
+            if (!qemu_set_blocking(*fd, true, errp)) {
+                return false;
             }
+        }
 
 #ifndef MSG_CMSG_CLOEXEC
-            qemu_set_cloexec(fd);
+        qemu_set_cloexec(*fd);
 #endif
+    }
+
+    return true;
+}
+
+static void qio_channel_cleanup_fds(int **fds, size_t *nfds)
+{
+    for (size_t i = 0; i < *nfds; i++) {
+        if ((*fds)[i] < 0) {
+            continue;
         }
-        *nfds += gotfds;
+        close((*fds)[i]);
     }
+
+    g_clear_pointer(fds, g_free);
+    *nfds = 0;
 }
 
 
@@ -559,9 +587,16 @@ static ssize_t qio_channel_socket_readv(QIOChannel *ioc,
     }
 
     if (fds && nfds) {
-        qio_channel_socket_copy_fds(
-            &msg, fds, nfds,
-            flags & QIO_CHANNEL_READ_FLAG_FD_PRESERVE_BLOCKING);
+        bool preserve_blocking =
+            flags & QIO_CHANNEL_READ_FLAG_FD_PRESERVE_BLOCKING;
+
+        qio_channel_socket_copy_fds(&msg, fds, nfds);
+
+        if (!qio_channel_handle_fds(*fds, *nfds,
+                                    preserve_blocking, errp)) {
+            qio_channel_cleanup_fds(fds, nfds);
+            return -1;
+        }
     }
 
     return ret;
-- 
2.50.1


