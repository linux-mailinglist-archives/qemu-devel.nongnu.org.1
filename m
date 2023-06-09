Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 080E37290F5
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 09:29:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7WXY-0005jY-KP; Fri, 09 Jun 2023 03:28:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1q7WXP-0005gG-BT
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 03:28:00 -0400
Received: from mout.kundenserver.de ([212.227.126.134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1q7WXM-0003Db-Q9
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 03:27:59 -0400
Received: from lenovo-t14s.redhat.com ([82.142.8.70]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MJmbB-1qRXQd2Mrh-00K4aR; Fri, 09 Jun 2023 09:27:50 +0200
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Gibson <dgibson@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH 2/3] net: socket: move fd type checking to its own function
Date: Fri,  9 Jun 2023 09:27:47 +0200
Message-Id: <20230609072748.4179873-3-lvivier@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230609072748.4179873-1-lvivier@redhat.com>
References: <20230609072748.4179873-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:cztB8MdkBmIykCnvIrcDf518aaMMcFPAiZncFkuXYiUI2DnzNQ6
 hPpOaqxz3Co6Ws6uDw5Z6YHtXm1vZxs6EHBUMvFMdFfVWbgpWXyHcgXO5ujKNyM0hLryMtR
 sPoeeJiMIAzI5qZXenhrn+dOXtJ+5A9TQOtOQm51OFI1vPWT4ffQpQKXVyhq1zMHf4vuuMF
 Is3nJYLOohErY/mpYtbrw==
UI-OutboundReport: notjunk:1;M01:P0:xBiCijUMv7w=;1tMROFDRfC0XhM3Vr60dk9br4lU
 nhUSJPBaF+zwFD4CPUwc9cgTygCERfdvDrF486rXIYe9ruyWUTNqjIxwlNhTDh6IIxPuO6xBr
 h33srMIQcbJfLBCfw9+3wFxAUYWVZDihN11JJZO7JRddemqsc7Zpp+ZApETvJ5MkewWW5LGWD
 CB5Fvfw9ttHlzRSApI9nyTfRDccSNvq3VzKt1vHA2pvFkYzvvTRotvHKhT0sZI7AcTsZZRVdB
 XXYRwZUsYB4k155/6poXgybf8cw1n+RmUfvkDq1hxKHk6Ng1MgzrLFoYuu22zW92yHiNB68+F
 LNZblnoaPuM3G+xRQck3iKkC0viyEcFTrS2Q2a1CidjiXDr7o1CUSELAI91PZKNHSIF63SJU1
 dFl0ZJdpCF+PiQ7yIOLNycjZpx4Knb3PuEw6Kkl0kLN6h1V1YWeAJRICYfHDjoVjxftxoPPRg
 wfZpRfl3OtAmCUJAKGRgpybTwCaL9rAgU8gp5YtjO5wblqMYXUMc7ygKCrUjKHSWV/utNAo1l
 o7ORyRdQYyyz35mNzBscZUeSEY0iS8U5ZiLmkltg3RzYVZVPrupbHtfYwUNjWvYMC5wW4M6EH
 /H3aClMHeYfcB907ZoNK2MXRV2YpaAKecSdw8Xyi3D+6+2sqD4If09WgjAvLeDsTBUnvRJLPO
 091Qigz7nVpZgUDNbxBBPlEeaOkUo4i6F61OWm8sRA==
Received-SPF: permerror client-ip=212.227.126.134;
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

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 net/socket.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index 24dcaa55bc46..6b1f0fec3a10 100644
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
2.39.2


