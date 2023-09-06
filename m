Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF86979384D
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 11:33:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdotg-0008MF-QJ; Wed, 06 Sep 2023 05:32:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qdotV-0008Lk-PX; Wed, 06 Sep 2023 05:32:19 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qdotS-0000f4-Ru; Wed, 06 Sep 2023 05:32:17 -0400
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1qdoqL-005qCB-0y;
 Wed, 06 Sep 2023 11:32:00 +0200
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: den@openvz.org, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH 2/8] qemu-nbd: define struct NbdClientOpts when
 HAVE_NBD_DEVICE is not defined
Date: Wed,  6 Sep 2023 11:32:04 +0200
Message-Id: <20230906093210.339585-3-den@openvz.org>
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

This patch also drops definition of some locals in main() to avoid
useless data copy.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Eric Blake <eblake@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 qemu-nbd.c | 60 ++++++++++++++++++++++++------------------------------
 1 file changed, 27 insertions(+), 33 deletions(-)

diff --git a/qemu-nbd.c b/qemu-nbd.c
index 4575e4291e..ebfae4d0b6 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -253,6 +253,12 @@ static int qemu_nbd_client_list(SocketAddress *saddr, QCryptoTLSCreds *tls,
 }
 
 
+struct NbdClientOpts {
+    char *device;
+    bool fork_process;
+    bool verbose;
+};
+
 #if HAVE_NBD_DEVICE
 static void *show_parts(void *arg)
 {
@@ -271,12 +277,6 @@ static void *show_parts(void *arg)
     return NULL;
 }
 
-struct NbdClientOpts {
-    char *device;
-    bool fork_process;
-    bool verbose;
-};
-
 static void *nbd_client_thread(void *arg)
 {
     struct NbdClientOpts *opts = arg;
@@ -519,7 +519,6 @@ int main(int argc, char **argv)
     const char *bindto = NULL;
     const char *port = NULL;
     char *sockpath = NULL;
-    char *device = NULL;
     QemuOpts *sn_opts = NULL;
     const char *sn_id_or_name = NULL;
     const char *sopt = "hVb:o:p:rsnc:dvk:e:f:tl:x:T:D:AB:L";
@@ -582,16 +581,16 @@ int main(int argc, char **argv)
     const char *tlshostname = NULL;
     bool imageOpts = false;
     bool writethrough = false; /* Client will flush as needed. */
-    bool verbose = false;
-    bool fork_process = false;
     bool list = false;
     unsigned socket_activation;
     const char *pid_file_name = NULL;
     const char *selinux_label = NULL;
     BlockExportOptions *export_opts;
-#if HAVE_NBD_DEVICE
-    struct NbdClientOpts opts;
-#endif
+    struct NbdClientOpts opts = {
+        .fork_process = false,
+        .verbose = false,
+        .device = NULL,
+    };
 
 #ifdef CONFIG_POSIX
     os_setup_early_signal_handling();
@@ -719,7 +718,7 @@ int main(int argc, char **argv)
             disconnect = true;
             break;
         case 'c':
-            device = optarg;
+            opts.device = optarg;
             break;
         case 'e':
             if (qemu_strtoi(optarg, NULL, 0, &shared) < 0 ||
@@ -750,7 +749,7 @@ int main(int argc, char **argv)
             }
             break;
         case 'v':
-            verbose = true;
+            opts.verbose = true;
             break;
         case 'V':
             version(argv[0]);
@@ -782,7 +781,7 @@ int main(int argc, char **argv)
             tlsauthz = optarg;
             break;
         case QEMU_NBD_OPT_FORK:
-            fork_process = true;
+            opts.fork_process = true;
             break;
         case 'L':
             list = true;
@@ -802,12 +801,12 @@ int main(int argc, char **argv)
             exit(EXIT_FAILURE);
         }
         if (export_name || export_description || dev_offset ||
-            device || disconnect || fmt || sn_id_or_name || bitmaps ||
+            opts.device || disconnect || fmt || sn_id_or_name || bitmaps ||
             alloc_depth || seen_aio || seen_discard || seen_cache) {
             error_report("List mode is incompatible with per-device settings");
             exit(EXIT_FAILURE);
         }
-        if (fork_process) {
+        if (opts.fork_process) {
             error_report("List mode is incompatible with forking");
             exit(EXIT_FAILURE);
         }
@@ -832,7 +831,8 @@ int main(int argc, char **argv)
         }
     } else {
         /* Using socket activation - check user didn't use -p etc. */
-        const char *err_msg = socket_activation_validate_opts(device, sockpath,
+        const char *err_msg = socket_activation_validate_opts(opts.device,
+                                                              sockpath,
                                                               bindto, port,
                                                               selinux_label,
                                                               list);
@@ -850,7 +850,7 @@ int main(int argc, char **argv)
     }
 
     if (tlscredsid) {
-        if (device) {
+        if (opts.device) {
             error_report("TLS is not supported with a host device");
             exit(EXIT_FAILURE);
         }
@@ -880,7 +880,7 @@ int main(int argc, char **argv)
 
     if (selinux_label) {
 #ifdef CONFIG_SELINUX
-        if (sockpath == NULL && device == NULL) {
+        if (sockpath == NULL && opts.device == NULL) {
             error_report("--selinux-label is not permitted without --socket");
             exit(EXIT_FAILURE);
         }
@@ -897,7 +897,7 @@ int main(int argc, char **argv)
     }
 
 #if !HAVE_NBD_DEVICE
-    if (disconnect || device) {
+    if (disconnect || opts.device) {
         error_report("Kernel /dev/nbdN support not available");
         exit(EXIT_FAILURE);
     }
@@ -919,7 +919,7 @@ int main(int argc, char **argv)
     }
 #endif
 
-    if ((device && !verbose) || fork_process) {
+    if ((opts.device && !opts.verbose) || opts.fork_process) {
 #ifndef WIN32
         g_autoptr(GError) err = NULL;
         int stderr_fd[2];
@@ -1002,9 +1002,9 @@ int main(int argc, char **argv)
 #endif /* WIN32 */
     }
 
-    if (device != NULL && sockpath == NULL) {
+    if (opts.device != NULL && sockpath == NULL) {
         sockpath = g_malloc(128);
-        snprintf(sockpath, 128, SOCKET_PATH, basename(device));
+        snprintf(sockpath, 128, SOCKET_PATH, basename(opts.device));
     }
 
     server = qio_net_listener_new();
@@ -1145,15 +1145,9 @@ int main(int argc, char **argv)
     blk_exp_add(export_opts, &error_fatal);
     qapi_free_BlockExportOptions(export_opts);
 
-    if (device) {
+    if (opts.device) {
 #if HAVE_NBD_DEVICE
         int ret;
-        opts = (struct NbdClientOpts) {
-            .device = device,
-            .fork_process = fork_process,
-            .verbose = verbose,
-        };
-
         ret = pthread_create(&client_thread, NULL, nbd_client_thread, &opts);
         if (ret != 0) {
             error_report("Failed to create client thread: %s", strerror(ret));
@@ -1179,7 +1173,7 @@ int main(int argc, char **argv)
         exit(EXIT_FAILURE);
     }
 
-    if (fork_process) {
+    if (opts.fork_process) {
         if (dup2(STDOUT_FILENO, STDERR_FILENO) < 0) {
             error_report("Could not release pipe to parent: %s",
                          strerror(errno));
@@ -1203,7 +1197,7 @@ int main(int argc, char **argv)
 
     qemu_opts_del(sn_opts);
 
-    if (device) {
+    if (opts.device) {
         void *ret;
         pthread_join(client_thread, &ret);
         exit(ret != NULL);
-- 
2.34.1


