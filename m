Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 041D679804B
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 03:38:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeQQ7-0008Uq-0e; Thu, 07 Sep 2023 21:36:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qeQQ4-0008TE-AH
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 21:36:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qeQQ0-0007to-5v
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 21:36:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694136979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=63Ix7Q5D9PN9ujxdrnZSPehQvT/Y89bchGCE2+919r0=;
 b=LnJxqoYT+3wn8gOMhQPqeUplpJbsWACI3apaJ2IQISMwua2UI+ERMaahPzVKVynaQC/DB5
 W3HxVZ3mqqnld+OcKTpOl6mnweOZPeoQ5vQBBtlRCY5Laf42tKF709qoqQRmrnJ65YXVwL
 MEZrZan2EPzLMIPyqzsGiTEC5sALfA8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-473-vH5j-FoAPuuyBdjWvUmXmA-1; Thu, 07 Sep 2023 21:36:17 -0400
X-MC-Unique: vH5j-FoAPuuyBdjWvUmXmA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D3A5C948C01;
 Fri,  8 Sep 2023 01:36:16 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7007240C2070;
 Fri,  8 Sep 2023 01:36:16 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Denis V. Lunev" <den@openvz.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org (open list:Network Block Dev...)
Subject: [PULL 08/13] qemu-nbd: define struct NbdClientOpts when
 HAVE_NBD_DEVICE is not defined
Date: Thu,  7 Sep 2023 20:35:44 -0500
Message-ID: <20230908013535.990731-23-eblake@redhat.com>
In-Reply-To: <20230908013535.990731-15-eblake@redhat.com>
References: <20230908013535.990731-15-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: "Denis V. Lunev" <den@openvz.org>

This patch also drops definition of some locals in main() to avoid
useless data copy.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Eric Blake <eblake@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Message-ID: <20230906093210.339585-3-den@openvz.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qemu-nbd.c | 60 ++++++++++++++++++++++++------------------------------
 1 file changed, 27 insertions(+), 33 deletions(-)

diff --git a/qemu-nbd.c b/qemu-nbd.c
index e2480061a16..acbdc0cd8fd 100644
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
2.41.0


