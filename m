Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACB87DCFA2
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 15:50:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxq23-0004tf-IO; Tue, 31 Oct 2023 10:47:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1qxq1o-00046w-RM
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:47:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1qxq1n-0002mK-6L
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:47:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698763653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nxnwGEmoi14X38yZcEvCDLHVDrHMqJx0/TasZ7cKxxo=;
 b=f1+xp7FFzgtaZJwi+EYadfH9Ac2AKOwKsxQ0vxnxPjPEt1PB5g6gVxxGTeFKC3vBRatLOa
 jL7do2uPTTtugkGji+w6oXCaKoFVIOVMgVaKD5+yjsQSZlM4HvbOpsFmkiSmaSQ7A52kPD
 nNyzfRdgU98HsUbC+XnG9HodRXx5JL4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-567-5R7s9x1nP_e-saoQ4NyBcw-1; Tue,
 31 Oct 2023 10:46:22 -0400
X-MC-Unique: 5R7s9x1nP_e-saoQ4NyBcw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 078D93C1476E
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 14:46:22 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.208.15])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D394EC1290F;
 Tue, 31 Oct 2023 14:46:20 +0000 (UTC)
From: Anthony Harivel <aharivel@redhat.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, berrange@redhat.com,
 Anthony Harivel <aharivel@redhat.com>
Subject: [PATCH v2 1/3] qio: add support for SO_PEERCRED for socket channel
Date: Tue, 31 Oct 2023 15:46:01 +0100
Message-ID: <20231031144605.64822-2-aharivel@redhat.com>
In-Reply-To: <20231031144605.64822-1-aharivel@redhat.com>
References: <20231031144605.64822-1-aharivel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aharivel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The function qio_channel_get_peercred() returns a pointer to the
credentials of the peer process connected to this socket.

This credentials structure is defined in <sys/socket.h> as follows:

struct ucred {
	pid_t pid;    /* Process ID of the sending process */
	uid_t uid;    /* User ID of the sending process */
	gid_t gid;    /* Group ID of the sending process */
};

The use of this function is possible only for connected AF_UNIX stream
sockets and for AF_UNIX stream and datagram socket pairs.

Signed-off-by: Anthony Harivel <aharivel@redhat.com>
---
 include/io/channel.h | 20 ++++++++++++++++++++
 io/channel-socket.c  | 17 +++++++++++++++++
 io/channel.c         | 12 ++++++++++++
 3 files changed, 49 insertions(+)

diff --git a/include/io/channel.h b/include/io/channel.h
index 5f9dbaab65b0..99c02d61c3d9 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -149,6 +149,9 @@ struct QIOChannelClass {
                                   void *opaque);
     int (*io_flush)(QIOChannel *ioc,
                     Error **errp);
+    void (*io_peercred)(QIOChannel *ioc,
+                        struct ucred *cred,
+                        Error **errp);
 };
 
 /* General I/O handling functions */
@@ -898,4 +901,21 @@ int coroutine_mixed_fn qio_channel_writev_full_all(QIOChannel *ioc,
 int qio_channel_flush(QIOChannel *ioc,
                       Error **errp);
 
+/**
+ * qio_channel_get_peercred:
+ * @ioc: the channel object
+ * @cred: pointer to ucred struct
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Returns the credentials of the peer process connected to this socket.
+ *
+ * The use of this function is possible only for connected
+ * AF_UNIX stream sockets and for AF_UNIX stream and datagra
+ * socket pairs.
+ *
+ */
+void qio_channel_get_peercred(QIOChannel *ioc,
+                              struct ucred *cred,
+                              Error **errp);
+
 #endif /* QIO_CHANNEL_H */
diff --git a/io/channel-socket.c b/io/channel-socket.c
index 02ffb51e9957..b8285eb8ae49 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -836,6 +836,22 @@ qio_channel_socket_set_cork(QIOChannel *ioc,
     socket_set_cork(sioc->fd, v);
 }
 
+static void
+qio_channel_socket_get_peercred(QIOChannel *ioc,
+                                struct ucred *cred,
+                                Error **errp)
+{
+    QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(ioc);
+    socklen_t len = sizeof(struct ucred);
+    Error *err = NULL;
+
+    if (getsockopt(sioc->fd,
+               SOL_SOCKET, SO_PEERCRED,
+               cred, &len) == -1) {
+        error_setg_errno(&err, errno, "Unable to get peer credentials");
+        error_propagate(errp, err);
+    }
+}
 
 static int
 qio_channel_socket_close(QIOChannel *ioc,
@@ -933,6 +949,7 @@ static void qio_channel_socket_class_init(ObjectClass *klass,
 #ifdef QEMU_MSG_ZEROCOPY
     ioc_klass->io_flush = qio_channel_socket_flush;
 #endif
+    ioc_klass->io_peercred = qio_channel_socket_get_peercred;
 }
 
 static const TypeInfo qio_channel_socket_info = {
diff --git a/io/channel.c b/io/channel.c
index 86c5834510ff..6dccccba5242 100644
--- a/io/channel.c
+++ b/io/channel.c
@@ -490,6 +490,18 @@ void qio_channel_set_cork(QIOChannel *ioc,
     }
 }
 
+void qio_channel_get_peercred(QIOChannel *ioc,
+                              struct ucred *cred,
+                              Error **errp)
+{
+    QIOChannelClass *klass = QIO_CHANNEL_GET_CLASS(ioc);
+
+    if (!klass->io_peercred) {
+        error_setg(errp, "Channel does not support random access");
+        return;
+    }
+    klass->io_peercred(ioc, cred, errp);
+}
 
 off_t qio_channel_io_seek(QIOChannel *ioc,
                           off_t offset,
-- 
2.41.0


