Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDC87290F3
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 09:29:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7WXc-0005oI-5V; Fri, 09 Jun 2023 03:28:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1q7WXZ-0005mB-DW
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 03:28:10 -0400
Received: from mout.kundenserver.de ([212.227.126.135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1q7WXX-0003Eb-I7
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 03:28:09 -0400
Received: from lenovo-t14s.redhat.com ([82.142.8.70]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MlwO3-1pgkce05lj-00j4bB; Fri, 09 Jun 2023 09:27:51 +0200
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Gibson <dgibson@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH 3/3] net: socket: remove net_init_socket()
Date: Fri,  9 Jun 2023 09:27:48 +0200
Message-Id: <20230609072748.4179873-4-lvivier@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230609072748.4179873-1-lvivier@redhat.com>
References: <20230609072748.4179873-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ai+PZTUpg7xPKapldGkX0W2tDQvzP5aFqVCZG2T384nKe8Z0kTD
 jFEjGcCA6G9HJ+ezEmbbNJLskOGI2DdPMaUVSpdM//Xi+tGckzd8bYUg0RzbnhXtBR9sAXG
 XhUGM8oRaih2B5+K/aqRfmz+Sk9TJ6DEvi7+pPWYIARiiAWUx8+C7RMIFZFQ28NXljmoLXT
 Pz93Sr8GKMf2clwHvPtww==
UI-OutboundReport: notjunk:1;M01:P0:YpHilEg/hG4=;a75PTYmP1qnjcr3YD7mD5cX2deZ
 OVWEWLXRRQtSBBOsH7s/yGHTlF3Sln+4W27FCabye5U7IendYnOZzjnGQsC+JadNh99EioyIV
 uj2G89ZYpODDsCyDUMCp9ZQ8CMsx319urtc7i1+RHWWgjveeneiB591H/JYQyOGz4XrsBygT+
 haw7EyNDvayIhf4tZoAl07yWQ2fRjZ18b8RxM/6bwXl4U+rOeTfR/CJn/uMYp+o9/fF/WPm7d
 PtL48J/lErl+/7HSgVV8yQhRaZk6NKb7OYg9AZXvuHdLDWwDlUGkbu34xV+Ei2SRovbubjhTq
 y+gSMd50yX3uYwW91Awozi/bl5DCGOqJuCGCAtB3MQJ3rQaIr/Z1Xhq+BzJ+Ci4Ue8JY3+snd
 hKaBgmOk9iUbOX/HdDse7tCAauuCPPZXBNbya6ehdBPmCwQltwUapFnzWREaX2zE3+O59HgZv
 H5OwJAd72u4JTrxcWbLDwoK5r7lp+c5IQ1hOt4jTjSFCmdvj57ZNGU6+HZzc353p8VXskaQTF
 ayQD6Nzfh7r6+stgw+s/IYoNwddnGtjy0LBrVboBN/CnJjb/zbH8rdrjGqqImhypck1u1oKUD
 a0c3/cT3igi2/Xl2PjNyDqXZ62ENgQa6vc2eSc/dTvTf9yB0nkkvJJS9FKelgICD2zkDgVJwG
 cRKpgLByKTuek/y1VZ1AvuzmaijcobU+i1+8bIzgMA==
Received-SPF: permerror client-ip=212.227.126.135;
 envelope-from=lvivier@redhat.com; helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_FAIL=0.001,
 SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Move the file descriptor type checking before doing anything with it.
If it's not usable, don't close it as it could be in use by another
part of QEMU, only fail and report an error.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 net/socket.c | 43 +++++++++++++++++--------------------------
 1 file changed, 17 insertions(+), 26 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index 6b1f0fec3a10..8e3702e1f3a8 100644
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
2.39.2


