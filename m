Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8867566FC
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 16:59:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLPdv-0002RP-G9; Mon, 17 Jul 2023 10:56:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qLPdj-0002PV-Ja; Mon, 17 Jul 2023 10:55:55 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qLPde-0003kT-FJ; Mon, 17 Jul 2023 10:55:54 -0400
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1qLPc0-00HTc0-2D;
 Mon, 17 Jul 2023 16:55:38 +0200
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: den@openvz.org, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-stable@nongnu.org
Subject: [PATCH 1/5] qemu-nbd: pass structure into nbd_client_thread instead
 of plain char*
Date: Mon, 17 Jul 2023 16:55:40 +0200
Message-Id: <20230717145544.194786-2-den@openvz.org>
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

We are going to pass additional flag inside next patch.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Eric Blake <eblake@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: <qemu-stable@nongnu.org>
---
 qemu-nbd.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/qemu-nbd.c b/qemu-nbd.c
index 4276163564..77f98c736b 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -272,9 +272,13 @@ static void *show_parts(void *arg)
     return NULL;
 }
 
+struct NbdClientOpts {
+    char *device;
+};
+
 static void *nbd_client_thread(void *arg)
 {
-    char *device = arg;
+    struct NbdClientOpts *opts = arg;
     NBDExportInfo info = { .request_sizes = false, .name = g_strdup("") };
     QIOChannelSocket *sioc;
     int fd = -1;
@@ -298,10 +302,10 @@ static void *nbd_client_thread(void *arg)
         goto out;
     }
 
-    fd = open(device, O_RDWR);
+    fd = open(opts->device, O_RDWR);
     if (fd < 0) {
         /* Linux-only, we can use %m in printf.  */
-        error_report("Failed to open %s: %m", device);
+        error_report("Failed to open %s: %m", opts->device);
         goto out;
     }
 
@@ -311,11 +315,11 @@ static void *nbd_client_thread(void *arg)
     }
 
     /* update partition table */
-    pthread_create(&show_parts_thread, NULL, show_parts, device);
+    pthread_create(&show_parts_thread, NULL, show_parts, opts->device);
 
     if (verbose) {
         fprintf(stderr, "NBD device %s is now connected to %s\n",
-                device, srcpath);
+                opts->device, srcpath);
     } else {
         /* Close stderr so that the qemu-nbd process exits.  */
         dup2(STDOUT_FILENO, STDERR_FILENO);
@@ -1125,8 +1129,11 @@ int main(int argc, char **argv)
     if (device) {
 #if HAVE_NBD_DEVICE
         int ret;
+        struct NbdClientOpts opts = {
+            .device = device,
+        };
 
-        ret = pthread_create(&client_thread, NULL, nbd_client_thread, device);
+        ret = pthread_create(&client_thread, NULL, nbd_client_thread, &opts);
         if (ret != 0) {
             error_report("Failed to create client thread: %s", strerror(ret));
             exit(EXIT_FAILURE);
-- 
2.34.1


