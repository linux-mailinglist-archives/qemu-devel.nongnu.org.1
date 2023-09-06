Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE06E793850
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 11:33:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdoto-0000TO-1Z; Wed, 06 Sep 2023 05:32:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qdotY-0008MI-JB; Wed, 06 Sep 2023 05:32:20 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qdotT-0000f9-8K; Wed, 06 Sep 2023 05:32:19 -0400
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1qdoqM-005qCB-0C;
 Wed, 06 Sep 2023 11:32:00 +0200
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: den@openvz.org, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH 4/8] qemu-nbd: put saddr into into struct NbdClientOpts
Date: Wed,  6 Sep 2023 11:32:06 +0200
Message-Id: <20230906093210.339585-5-den@openvz.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230906093210.339585-1-den@openvz.org>
References: <20230906093210.339585-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111; envelope-from=den@openvz.org;
 helo=relay.virtuozzo.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

We pass other parameters into nbd_client_thread() in this way. This patch
makes the code more consistent.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Eric Blake <eblake@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 qemu-nbd.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/qemu-nbd.c b/qemu-nbd.c
index de6c2be590..d0f8d8bad2 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -73,7 +73,6 @@
 
 #define MBR_SIZE 512
 
-static SocketAddress *saddr;
 static int persistent = 0;
 static enum { RUNNING, TERMINATE, TERMINATED } state;
 static int shared = 1;
@@ -255,6 +254,7 @@ static int qemu_nbd_client_list(SocketAddress *saddr, QCryptoTLSCreds *tls,
 struct NbdClientOpts {
     char *device;
     char *srcpath;
+    SocketAddress *saddr;
     bool fork_process;
     bool verbose;
 };
@@ -289,7 +289,7 @@ static void *nbd_client_thread(void *arg)
 
     sioc = qio_channel_socket_new();
     if (qio_channel_socket_connect_sync(sioc,
-                                        saddr,
+                                        opts->saddr,
                                         &local_error) < 0) {
         error_report_err(local_error);
         goto out;
@@ -591,6 +591,7 @@ int main(int argc, char **argv)
         .verbose = false,
         .device = NULL,
         .srcpath = NULL,
+        .saddr = NULL,
     };
 
 #ifdef CONFIG_POSIX
@@ -892,8 +893,8 @@ int main(int argc, char **argv)
     }
 
     if (list) {
-        saddr = nbd_build_socket_address(sockpath, bindto, port);
-        return qemu_nbd_client_list(saddr, tlscreds,
+        opts.saddr = nbd_build_socket_address(sockpath, bindto, port);
+        return qemu_nbd_client_list(opts.saddr, tlscreds,
                                     tlshostname ? tlshostname : bindto);
     }
 
@@ -1024,8 +1025,8 @@ int main(int argc, char **argv)
             exit(EXIT_FAILURE);
         }
 #endif
-        saddr = nbd_build_socket_address(sockpath, bindto, port);
-        if (qio_net_listener_open_sync(server, saddr, backlog,
+        opts.saddr = nbd_build_socket_address(sockpath, bindto, port);
+        if (qio_net_listener_open_sync(server, opts.saddr, backlog,
                                        &local_err) < 0) {
             object_unref(OBJECT(server));
             error_report_err(local_err);
-- 
2.34.1


