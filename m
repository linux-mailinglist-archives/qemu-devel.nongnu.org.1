Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B4270E080
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 17:31:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1TyA-0006Z5-33; Tue, 23 May 2023 11:30:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paul@redballoonsecurity.com>)
 id 1q1TGK-0008Je-R1
 for qemu-devel@nongnu.org; Tue, 23 May 2023 10:45:21 -0400
Received: from static-162-83-193-36.nycmny.fios.verizon.net ([162.83.193.36]
 helo=smtp10.redballoonsecurity.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paul@redballoonsecurity.com>)
 id 1q1TGJ-0008Qe-6u
 for qemu-devel@nongnu.org; Tue, 23 May 2023 10:45:20 -0400
Received: from localhost (localhost [127.0.0.1])
 by smtp10.redballoonsecurity.com (Postfix) with ESMTP id 8DF951F1AA;
 Tue, 23 May 2023 10:45:12 -0400 (EDT)
Received: from smtp10.redballoonsecurity.com ([127.0.0.1])
 by localhost (smtp10.redballoonsecurity.com [127.0.0.1]) (amavisd-new,
 port 10024)
 with LMTP id cT37CknDTyqZ; Tue, 23 May 2023 10:45:11 -0400 (EDT)
Received: from blade35.omg.redballoonsecurity.com
 (blade35.omg.redballoonsecurity.com [172.17.0.187])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: paul)
 by smtp10.redballoonsecurity.com (Postfix) with ESMTPSA id 47B741F1A2;
 Tue, 23 May 2023 10:45:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=redballoonsecurity.com; s=mail; t=1684853111;
 bh=x7vb0OvBKaLQv5Mx2eiOrgocBuoZeE8NRzQ3RBMLqhA=;
 h=From:To:Cc:Subject:Date:From;
 b=ApBzpL2fBIMIm4O9H+0ZINv4APl76gl8LLd1rC/UxxfS1aN7ZANBlD0L4dP6boXu0
 +yEW0cOsMAtXV0AdVet9URSO1AnIDerHrC2l1QGSF+EwaEAmr40qqHWsZSZ9MfozDc
 Qfh5pGpDfSBDbO6x48QHKoqh3Rg2/EcZTmNbXaqs=
From: Paul Noalhyt <paul@redballoonsecurity.com>
To: qemu-devel@nongnu.org
Cc: Paul Noalhyt <paul@redballoonsecurity.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH] gdbstub user: fix to handle the gdb disconnect command and
 allow reconnecting
Date: Tue, 23 May 2023 14:44:09 +0000
Message-Id: <20230523144408.2278-1-paul@redballoonsecurity.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Signed-off-by: Paul Noalhyt <paul@redballoonsecurity.com>
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=162.83.193.36;
 envelope-from=paul@redballoonsecurity.com; helo=smtp10.redballoonsecurity.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 23 May 2023 11:30:35 -0400
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

Hi,

I'm sending this to patch an issue I noticed in qemu-arm (user mode).
Noticed that when disconnecting gdb (gdb `disconnect` command), the
program would resume execution, instead of staying halted on the current
instruction. I modified the code so that the socket stays open waiting for
future connections.

This is my first contribution to the QEMU codebase.

Paul.

---
 gdbstub/user.c | 50 +++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 39 insertions(+), 11 deletions(-)

diff --git a/gdbstub/user.c b/gdbstub/user.c
index 5b375be1d9..e583d472ae 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -24,6 +24,7 @@
 /* User-mode specific state */
 typedef struct {
     int fd;
+    int tcp_fd;
     char *socket_path;
     int running_state;
 } GDBUserState;
@@ -115,6 +116,10 @@ void gdb_exit(int code)
     }
 }
 
+static bool gdb_accept_tcp(int gdb_fd, bool reopen);
+static bool gdb_accept_socket(int gdb_fd, bool reopen);
+static int gdbserver_open_socket(const char *path);
+
 int gdb_handlesig(CPUState *cpu, int sig)
 {
     char buf[256];
@@ -160,14 +165,29 @@ int gdb_handlesig(CPUState *cpu, int sig)
             }
         } else {
             /*
-             * XXX: Connection closed.  Should probably wait for another
-             * connection before continuing.
+             * Connection closed.  Wait for another connection
+             * before continuing.
              */
             if (n == 0) {
                 close(gdbserver_user_state.fd);
             }
-            gdbserver_user_state.fd = -1;
-            return sig;
+            bool reopen_error = false;
+            if (gdbserver_user_state.socket_path) {
+                unlink(gdbserver_user_state.socket_path);
+                int gdb_fd;
+                gdb_fd =
+                    gdbserver_open_socket(gdbserver_user_state.socket_path);
+                if (gdb_fd < 0 || !gdb_accept_socket(gdb_fd, true)) {
+                    reopen_error = true;
+                }
+            } else if (!gdb_accept_tcp(gdbserver_user_state.tcp_fd, true)) {
+                reopen_error = true;
+            }
+            if (reopen_error) {
+                close(gdbserver_user_state.fd);
+                gdbserver_user_state.fd = -1;
+                return sig;
+            }
         }
     }
     sig = gdbserver_state.signal;
@@ -201,7 +221,7 @@ static void gdb_accept_init(int fd)
     gdb_has_xml = false;
 }
 
-static bool gdb_accept_socket(int gdb_fd)
+static bool gdb_accept_socket(int gdb_fd, bool reopen)
 {
     int fd;
 
@@ -215,8 +235,11 @@ static bool gdb_accept_socket(int gdb_fd)
             break;
         }
     }
-
-    gdb_accept_init(fd);
+    if (reopen) {
+        gdbserver_user_state.fd = fd;
+    } else {
+        gdb_accept_init(fd);
+    }
     return true;
 }
 
@@ -249,7 +272,7 @@ static int gdbserver_open_socket(const char *path)
     return fd;
 }
 
-static bool gdb_accept_tcp(int gdb_fd)
+static bool gdb_accept_tcp(int gdb_fd, bool reopen)
 {
     struct sockaddr_in sockaddr = {};
     socklen_t len;
@@ -274,7 +297,11 @@ static bool gdb_accept_tcp(int gdb_fd)
         return false;
     }
 
-    gdb_accept_init(fd);
+    if (reopen) {
+        gdbserver_user_state.fd = fd;
+    } else {
+        gdb_accept_init(fd);
+    }
     return true;
 }
 
@@ -326,9 +353,10 @@ int gdbserver_start(const char *port_or_path)
         return -1;
     }
 
-    if (port > 0 && gdb_accept_tcp(gdb_fd)) {
+    if (port > 0 && gdb_accept_tcp(gdb_fd, false)) {
+        gdbserver_user_state.tcp_fd = gdb_fd;
         return 0;
-    } else if (gdb_accept_socket(gdb_fd)) {
+    } else if (gdb_accept_socket(gdb_fd, false)) {
         gdbserver_user_state.socket_path = g_strdup(port_or_path);
         return 0;
     }
-- 
2.30.2


