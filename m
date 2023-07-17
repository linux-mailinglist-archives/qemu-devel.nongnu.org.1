Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C428756E2C
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 22:26:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLUmg-0006IV-Gf; Mon, 17 Jul 2023 16:25:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qLUmd-0006G9-5Z; Mon, 17 Jul 2023 16:25:27 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qLUmb-0001R2-HC; Mon, 17 Jul 2023 16:25:26 -0400
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1qLUkx-000js0-0h;
 Mon, 17 Jul 2023 22:25:12 +0200
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: den@openvz.org, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH 6/5] qemu-nbd: make verbose bool and local variable in main()
Date: Mon, 17 Jul 2023 22:25:20 +0200
Message-Id: <20230717202520.236999-1-den@openvz.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230717145544.194786-1-den@openvz.org>
References: <20230717145544.194786-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111; envelope-from=den@openvz.org;
 helo=relay.virtuozzo.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Pass 'verbose' to nbd_client_thread() inside NbdClientOpts which looks
a little bit cleaner and make it bool as it is used as bool actually.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Eric Blake <eblake@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 qemu-nbd.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/qemu-nbd.c b/qemu-nbd.c
index cd0e965705..958e5688c0 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -73,7 +73,6 @@
 
 #define MBR_SIZE 512
 
-static int verbose;
 static char *srcpath;
 static SocketAddress *saddr;
 static int persistent = 0;
@@ -275,6 +274,7 @@ static void *show_parts(void *arg)
 struct NbdClientOpts {
     char *device;
     bool fork_process;
+    bool verbose;
 };
 
 static void *nbd_client_thread(void *arg)
@@ -318,7 +318,7 @@ static void *nbd_client_thread(void *arg)
     /* update partition table */
     pthread_create(&show_parts_thread, NULL, show_parts, opts->device);
 
-    if (verbose && !opts->fork_process) {
+    if (opts->verbose && !opts->fork_process) {
         fprintf(stderr, "NBD device %s is now connected to %s\n",
                 opts->device, srcpath);
     } else {
@@ -583,6 +583,7 @@ int main(int argc, char **argv)
     const char *tlshostname = NULL;
     bool imageOpts = false;
     bool writethrough = false; /* Client will flush as needed. */
+    bool verbose = false;
     bool fork_process = false;
     bool list = false;
     unsigned socket_activation;
@@ -747,7 +748,7 @@ int main(int argc, char **argv)
             }
             break;
         case 'v':
-            verbose = 1;
+            verbose = true;
             break;
         case 'V':
             version(argv[0]);
@@ -1148,6 +1149,7 @@ int main(int argc, char **argv)
         struct NbdClientOpts opts = {
             .device = device,
             .fork_process = fork_process,
+            .verbose = verbose,
         };
 
         ret = pthread_create(&client_thread, NULL, nbd_client_thread, &opts);
-- 
2.34.1


