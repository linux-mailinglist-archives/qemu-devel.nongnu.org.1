Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2736977A004
	for <lists+qemu-devel@lfdr.de>; Sat, 12 Aug 2023 14:49:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUo2e-0001TE-UN; Sat, 12 Aug 2023 08:48:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qUo2Y-0001SQ-1P
 for qemu-devel@nongnu.org; Sat, 12 Aug 2023 08:48:22 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qUo2W-0005nP-B9
 for qemu-devel@nongnu.org; Sat, 12 Aug 2023 08:48:21 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 984C719FAC
 for <qemu-devel@nongnu.org>; Sat, 12 Aug 2023 15:48:17 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id D7C141DF68;
 Sat, 12 Aug 2023 15:48:06 +0300 (MSK)
Received: (nullmailer pid 2881132 invoked by uid 1000);
 Sat, 12 Aug 2023 12:48:06 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH RFC 2/7] os-posix: create and export os_set_runas()
Date: Sat, 12 Aug 2023 15:47:56 +0300
Message-Id: <05695b9bacacddd967ce334f3bb34a10869948e7.1691843673.git.mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1691843673.git.mjt@tls.msk.ru>
References: <cover.1691843673.git.mjt@tls.msk.ru>
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

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 include/sysemu/os-posix.h |  1 +
 os-posix.c                | 23 ++++++++++++++++-------
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/include/sysemu/os-posix.h b/include/sysemu/os-posix.h
index 65b9c94e91..d32630f9e7 100644
--- a/include/sysemu/os-posix.h
+++ b/include/sysemu/os-posix.h
@@ -50,6 +50,7 @@ void os_setup_signal_handling(void);
 int os_set_daemonize(bool d);
 bool is_daemonized(void);
 void os_daemonize(void);
+bool os_set_runas(const char *optarg);
 void os_setup_post(void);
 int os_mlock(void);
 
diff --git a/os-posix.c b/os-posix.c
index cfcb96533c..0202bb4898 100644
--- a/os-posix.c
+++ b/os-posix.c
@@ -102,8 +102,14 @@ void os_set_proc_name(const char *s)
 #endif
 }
 
-
-static bool os_parse_runas_uid_gid(const char *optarg)
+/*
+ * Prepare to change user ID. optarg can be one of 3 forms:
+ *   - a username, in which case user ID will be changed to its uid,
+ *     with primary and supplementary groups set up too;
+ *   - a nemeric uid, in which case only the uid will be set;
+ *   - a pair of numeric uid:gid.
+ */
+bool os_set_runas(const char *optarg)
 {
     unsigned long lv;
     const char *ep;
@@ -111,6 +117,13 @@ static bool os_parse_runas_uid_gid(const char *optarg)
     gid_t got_gid;
     int rc;
 
+    user_pwd = getpwnam(optarg);
+    if (user_pwd) {
+        user_uid = -1;
+        user_gid = -1;
+        return true;
+    }
+
     rc = qemu_strtoul(optarg, &ep, 0, &lv);
     got_uid = lv; /* overflow here is ID in C99 */
     if (rc || *ep != ':' || got_uid != lv || got_uid == (uid_t)-1) {
@@ -137,11 +150,7 @@ int os_parse_cmd_args(int index, const char *optarg)
 {
     switch (index) {
     case QEMU_OPTION_runas:
-        user_pwd = getpwnam(optarg);
-        if (user_pwd) {
-            user_uid = -1;
-            user_gid = -1;
-        } else if (!os_parse_runas_uid_gid(optarg)) {
+        if (!os_set_runas(optarg)) {
             error_report("User \"%s\" doesn't exist"
                          " (and is not <uid>:<gid>)",
                          optarg);
-- 
2.39.2


