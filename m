Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE78F74AD91
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 11:08:14 +0200 (CEST)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHhQu-0003La-HE; Fri, 07 Jul 2023 05:07:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qHhQk-0003KW-U0
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 05:07:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qHhQj-0007LL-CE
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 05:07:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688720828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4saLM+FnxngSylLvfObgVM52BLF+qj2NNfeomGbb3H0=;
 b=DA5e0i22YCb8VLVFPyn5xu9KlorfD+IhDnSv8q8yuKMO4Odu0jEn86rGVCC9NEk0yRgBDB
 k/086acaU6+aVY35eNUCAoU6+EsF51DNYDy8A/gyH+hK+DfrKFxKkuJMLy/ord8pV9mpmj
 noSzU+dHB4Jo22RmgPZzHxcVzrA5DeI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-26-Y4QXsdvZN7OdZLyCjFCyOw-1; Fri, 07 Jul 2023 05:07:07 -0400
X-MC-Unique: Y4QXsdvZN7OdZLyCjFCyOw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BCC1E381D1F7;
 Fri,  7 Jul 2023 09:07:06 +0000 (UTC)
Received: from hp-dl380pg8-01.lab.eng.pek2.redhat.com
 (hp-dl380pg8-01.lab.eng.pek2.redhat.com [10.73.8.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 93AB91121330;
 Fri,  7 Jul 2023 09:07:04 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: Laurent Vivier <lvivier@redhat.com>,
	Jason Wang <jasowang@redhat.com>
Subject: [PULL 12/15] net: socket: move fd type checking to its own function
Date: Fri,  7 Jul 2023 05:06:25 -0400
Message-Id: <20230707090628.2210346-13-jasowang@redhat.com>
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

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/socket.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index 24dcaa5..6b1f0fe 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -446,16 +446,32 @@ static NetSocketState *net_socket_fd_init_stream(NetClientState *peer,
     return s;
 }
 
+static int net_socket_fd_check(int fd, Error **errp)
+{
+    int so_type, optlen = sizeof(so_type);
+
+    if (getsockopt(fd, SOL_SOCKET, SO_TYPE, (char *)&so_type,
+        (socklen_t *)&optlen) < 0) {
+        error_setg(errp, "can't get socket option SO_TYPE");
+        return -1;
+    }
+    if (so_type != SOCK_DGRAM && so_type != SOCK_STREAM) {
+        error_setg(errp, "socket type=%d for fd=%d must be either"
+                   " SOCK_DGRAM or SOCK_STREAM", so_type, fd);
+        return -1;
+    }
+    return so_type;
+}
+
 static NetSocketState *net_socket_fd_init(NetClientState *peer,
                                           const char *model, const char *name,
                                           int fd, int is_connected,
                                           const char *mc, Error **errp)
 {
-    int so_type = -1, optlen=sizeof(so_type);
+    int so_type;
 
-    if(getsockopt(fd, SOL_SOCKET, SO_TYPE, (char *)&so_type,
-        (socklen_t *)&optlen)< 0) {
-        error_setg(errp, "can't get socket option SO_TYPE");
+    so_type = net_socket_fd_check(fd, errp);
+    if (so_type < 0) {
         close(fd);
         return NULL;
     }
@@ -465,10 +481,6 @@ static NetSocketState *net_socket_fd_init(NetClientState *peer,
                                         mc, errp);
     case SOCK_STREAM:
         return net_socket_fd_init_stream(peer, model, name, fd, is_connected);
-    default:
-        error_setg(errp, "socket type=%d for fd=%d must be either"
-                   " SOCK_DGRAM or SOCK_STREAM", so_type, fd);
-        close(fd);
     }
     return NULL;
 }
-- 
2.7.4


