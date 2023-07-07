Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 415F474AD89
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 11:07:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHhQw-0003MK-7q; Fri, 07 Jul 2023 05:07:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qHhQo-0003LZ-0p
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 05:07:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qHhQm-0007W2-Fo
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 05:07:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688720831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hngWlh01uggikH8vut+q8NhpbVbDq3xjnBlBtwxG3sI=;
 b=JhR2x0twf8v5WsTp3wbCC+w5ino3GFTIWqIrA6JUBnWCASGyy0QsOZZaylrMeJqwFRCgjM
 WvdkUzNtzbOI+cvERnPl/tDbuY1oTJHmtUjY1rNQy1YT7/eWlCZQhjtKpJbrJggm/mAjeU
 4vR3sdPAHH1EgNsbe+svghlgHdg+s8g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518-Navls_VwMhWhX8n6krCcBg-1; Fri, 07 Jul 2023 05:07:10 -0400
X-MC-Unique: Navls_VwMhWhX8n6krCcBg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1BE5E873239;
 Fri,  7 Jul 2023 09:07:10 +0000 (UTC)
Received: from hp-dl380pg8-01.lab.eng.pek2.redhat.com
 (hp-dl380pg8-01.lab.eng.pek2.redhat.com [10.73.8.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5C68F1121330;
 Fri,  7 Jul 2023 09:07:07 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: Laurent Vivier <lvivier@redhat.com>,
	Jason Wang <jasowang@redhat.com>
Subject: [PULL 13/15] net: socket: remove net_init_socket()
Date: Fri,  7 Jul 2023 05:06:26 -0400
Message-Id: <20230707090628.2210346-14-jasowang@redhat.com>
In-Reply-To: <20230707090628.2210346-1-jasowang@redhat.com>
References: <20230707090628.2210346-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Laurent Vivier <lvivier@redhat.com>

Move the file descriptor type checking before doing anything with it.
If it's not usable, don't close it as it could be in use by another
part of QEMU, only fail and report an error.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/socket.c | 43 +++++++++++++++++--------------------------
 1 file changed, 17 insertions(+), 26 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index 6b1f0fe..8e3702e 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -463,28 +463,6 @@ static int net_socket_fd_check(int fd, Error **errp)
     return so_type;
 }
 
-static NetSocketState *net_socket_fd_init(NetClientState *peer,
-                                          const char *model, const char *name,
-                                          int fd, int is_connected,
-                                          const char *mc, Error **errp)
-{
-    int so_type;
-
-    so_type = net_socket_fd_check(fd, errp);
-    if (so_type < 0) {
-        close(fd);
-        return NULL;
-    }
-    switch(so_type) {
-    case SOCK_DGRAM:
-        return net_socket_fd_init_dgram(peer, model, name, fd, is_connected,
-                                        mc, errp);
-    case SOCK_STREAM:
-        return net_socket_fd_init_stream(peer, model, name, fd, is_connected);
-    }
-    return NULL;
-}
-
 static void net_socket_accept(void *opaque)
 {
     NetSocketState *s = opaque;
@@ -728,21 +706,34 @@ int net_init_socket(const Netdev *netdev, const char *name,
     }
 
     if (sock->fd) {
-        int fd, ret;
+        int fd, ret, so_type;
 
         fd = monitor_fd_param(monitor_cur(), sock->fd, errp);
         if (fd == -1) {
             return -1;
         }
+        so_type = net_socket_fd_check(fd, errp);
+        if (so_type < 0) {
+            return -1;
+        }
         ret = qemu_socket_try_set_nonblock(fd);
         if (ret < 0) {
             error_setg_errno(errp, -ret, "%s: Can't use file descriptor %d",
                              name, fd);
             return -1;
         }
-        if (!net_socket_fd_init(peer, "socket", name, fd, 1, sock->mcast,
-                                errp)) {
-            return -1;
+        switch (so_type) {
+        case SOCK_DGRAM:
+            if (!net_socket_fd_init_dgram(peer, "socket", name, fd, 1,
+                                          sock->mcast, errp)) {
+                return -1;
+            }
+            break;
+        case SOCK_STREAM:
+            if (!net_socket_fd_init_stream(peer, "socket", name, fd, 1)) {
+                return -1;
+            }
+            break;
         }
         return 0;
     }
-- 
2.7.4


