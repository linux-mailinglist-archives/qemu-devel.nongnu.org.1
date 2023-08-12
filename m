Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E91CF77A007
	for <lists+qemu-devel@lfdr.de>; Sat, 12 Aug 2023 14:49:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUo2h-0001Uf-KU; Sat, 12 Aug 2023 08:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qUo2Y-0001SP-1F
 for qemu-devel@nongnu.org; Sat, 12 Aug 2023 08:48:22 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qUo2W-0005nU-Ck
 for qemu-devel@nongnu.org; Sat, 12 Aug 2023 08:48:21 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BBABC19FAD
 for <qemu-devel@nongnu.org>; Sat, 12 Aug 2023 15:48:17 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 0DDA31DF69;
 Sat, 12 Aug 2023 15:48:07 +0300 (MSK)
Received: (nullmailer pid 2881135 invoked by uid 1000);
 Sat, 12 Aug 2023 12:48:06 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH RFC 3/7] os-posix.c: create and export os_set_chroot()
Date: Sat, 12 Aug 2023 15:47:57 +0300
Message-Id: <38d6161dd51a3aa058458c7baa13096d33a9c863.1691843673.git.mjt@tls.msk.ru>
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
 include/sysemu/os-posix.h | 1 +
 os-posix.c                | 9 +++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/sysemu/os-posix.h b/include/sysemu/os-posix.h
index d32630f9e7..8a66763395 100644
--- a/include/sysemu/os-posix.h
+++ b/include/sysemu/os-posix.h
@@ -51,6 +51,7 @@ int os_set_daemonize(bool d);
 bool is_daemonized(void);
 void os_daemonize(void);
 bool os_set_runas(const char *optarg);
+void os_set_chroot(const char *optarg);
 void os_setup_post(void);
 int os_mlock(void);
 
diff --git a/os-posix.c b/os-posix.c
index 0202bb4898..081f3db685 100644
--- a/os-posix.c
+++ b/os-posix.c
@@ -159,7 +159,7 @@ int os_parse_cmd_args(int index, const char *optarg)
         break;
     case QEMU_OPTION_chroot:
         warn_report("option is deprecated, use '-run-with chroot=...' instead");
-        chroot_dir = optarg;
+        os_set_chroot(optarg);
         break;
     case QEMU_OPTION_daemonize:
         daemonize = 1;
@@ -184,7 +184,7 @@ int os_parse_cmd_args(int index, const char *optarg)
 #endif
         str = qemu_opt_get(opts, "chroot");
         if (str) {
-            chroot_dir = str;
+            os_set_chroot(str);
         }
         break;
     }
@@ -232,6 +232,11 @@ static void change_process_uid(void)
     }
 }
 
+void os_set_chroot(const char *optarg)
+{
+    chroot_dir = optarg;
+}
+
 static void change_root(void)
 {
     if (chroot_dir) {
-- 
2.39.2


