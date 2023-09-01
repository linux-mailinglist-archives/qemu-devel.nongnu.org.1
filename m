Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 869B778FBA8
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 12:14:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc19f-0001NN-8c; Fri, 01 Sep 2023 06:13:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qc19Q-0001KC-Dm
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 06:13:19 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qc19O-0001b3-5v
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 06:13:16 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6247A1E732;
 Fri,  1 Sep 2023 13:13:39 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id A56052506A;
 Fri,  1 Sep 2023 13:13:03 +0300 (MSK)
Received: (nullmailer pid 3618999 invoked by uid 1000);
 Fri, 01 Sep 2023 10:13:02 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Eric Blake <eblake@redhat.com>
Subject: [PATCH 5/8] os-posix.c: move code around
Date: Fri,  1 Sep 2023 13:12:59 +0300
Message-Id: <20230901101302.3618955-6-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230901101302.3618955-1-mjt@tls.msk.ru>
References: <20230901101302.3618955-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

this moves code blocks so that functions and variables which
belongs to the same concept are now close to each other.
There's no actual code changes in there.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 os-posix.c | 49 +++++++++++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/os-posix.c b/os-posix.c
index 4102fcdb5e..340373d972 100644
--- a/os-posix.c
+++ b/os-posix.c
@@ -40,17 +40,6 @@
 #include <sys/prctl.h>
 #endif
 
-/*
- * Must set all three of these at once.
- * Legal combinations are              unset   by name   by uid
- */
-static struct passwd *user_pwd;    /*   NULL   non-NULL   NULL   */
-static uid_t user_uid = (uid_t)-1; /*   -1      -1        >=0    */
-static gid_t user_gid = (gid_t)-1; /*   -1      -1        >=0    */
-
-static const char *chroot_dir;
-static int daemonize;
-static int daemon_pipe;
 
 void os_setup_early_signal_handling(void)
 {
@@ -97,6 +86,15 @@ void os_set_proc_name(const char *s)
 #endif
 }
 
+
+/*
+ * Must set all three of these at once.
+ * Legal combinations are              unset   by name   by uid
+ */
+static struct passwd *user_pwd;    /*   NULL   non-NULL   NULL   */
+static uid_t user_uid = (uid_t)-1; /*   -1      -1        >=0    */
+static gid_t user_gid = (gid_t)-1; /*   -1      -1        >=0    */
+
 /*
  * Prepare to change user ID. optarg can be one of 3 forms:
  *   - a username, in which case user ID will be changed to its uid,
@@ -174,6 +172,9 @@ static void change_process_uid(void)
     }
 }
 
+
+static const char *chroot_dir;
+
 void os_set_chroot(const char *optarg)
 {
     chroot_dir = optarg;
@@ -194,6 +195,21 @@ static void change_root(void)
 
 }
 
+
+static int daemonize;
+static int daemon_pipe;
+
+bool is_daemonized(void)
+{
+    return daemonize;
+}
+
+int os_set_daemonize(bool d)
+{
+    daemonize = d;
+    return 0;
+}
+
 void os_daemonize(void)
 {
     if (daemonize) {
@@ -287,17 +303,6 @@ void os_set_line_buffering(void)
     setvbuf(stdout, NULL, _IOLBF, 0);
 }
 
-bool is_daemonized(void)
-{
-    return daemonize;
-}
-
-int os_set_daemonize(bool d)
-{
-    daemonize = d;
-    return 0;
-}
-
 int os_mlock(void)
 {
 #ifdef HAVE_MLOCKALL
-- 
2.39.2


