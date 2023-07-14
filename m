Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 648A97539F9
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 13:46:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKHD6-00064Z-3x; Fri, 14 Jul 2023 07:43:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qKHAp-0002yt-79; Fri, 14 Jul 2023 07:41:25 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qKHAh-0004gi-2Y; Fri, 14 Jul 2023 07:41:17 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 91C0713DA8;
 Fri, 14 Jul 2023 14:38:59 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 89F0314BB7;
 Fri, 14 Jul 2023 14:38:43 +0300 (MSK)
Received: (nullmailer pid 1186280 invoked by uid 1000);
 Fri, 14 Jul 2023 11:38:38 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH, trivial 28/29] tree-wide spelling fixes in comments and some
 messages: qga/
Date: Fri, 14 Jul 2023 14:38:33 +0300
Message-Id: <20230714113834.1186117-30-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230714113834.1186117-1-mjt@tls.msk.ru>
References: <20230714113834.1186117-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
 qga/channel-posix.c       | 2 +-
 qga/commands-posix-ssh.c  | 2 +-
 qga/commands-posix.c      | 2 +-
 qga/commands-win32.c      | 4 ++--
 qga/main.c                | 2 +-
 qga/vss-win32/install.cpp | 4 ++--
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/qga/channel-posix.c b/qga/channel-posix.c
index 0c5175d957..465d688ecb 100644
--- a/qga/channel-posix.c
+++ b/qga/channel-posix.c
@@ -154,3 +154,3 @@ static gboolean ga_channel_open(GAChannel *c, const gchar *path,
          * In the default state channel sends echo of every command to a
-         * client. The client programm doesn't expect this and raises an
+         * client. The client program doesn't expect this and raises an
          * error. Suppress echo by resetting ECHO terminal flag.
diff --git a/qga/commands-posix-ssh.c b/qga/commands-posix-ssh.c
index f3a580b8cc..236f80de44 100644
--- a/qga/commands-posix-ssh.c
+++ b/qga/commands-posix-ssh.c
@@ -384,3 +384,3 @@ test_add_keys(void)
 
-    /*  key2 came first, and should'nt be duplicated */
+    /*  key2 came first, and shouldn't be duplicated */
     test_authorized_keys_equal("algo key2 comments\n"
diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index def857d773..6169bbf7a0 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -3251,3 +3251,3 @@ GuestUserList *qmp_guest_get_users(Error **errp)
 
-/* Replace escaped special characters with theire real values. The replacement
+/* Replace escaped special characters with their real values. The replacement
  * is done in place -- returned value is in the original string.
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index d23875264f..6beae659b7 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -489,3 +489,3 @@ static GuestDiskBusType win2qemu[] = {
     /*
-     * BusTypeSpaces currently is not suported
+     * BusTypeSpaces currently is not supported
      */
@@ -2261,3 +2261,3 @@ static char *ga_get_win_product_name(Error **errp)
     if (err != ERROR_SUCCESS) {
-        error_setg_win32(errp, err, "failed to retrive ProductName");
+        error_setg_win32(errp, err, "failed to retrieve ProductName");
         goto fail;
diff --git a/qga/main.c b/qga/main.c
index 002161a0cc..8668b9f3d3 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -1335,3 +1335,3 @@ static bool check_is_frozen(GAState *s)
      * or reboot may have since unfrozen them), but better to require an
-     * uneeded unfreeze than to risk hanging on start-up
+     * unneeded unfreeze than to risk hanging on start-up
      */
diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
index ae38662a62..84944133f7 100644
--- a/qga/vss-win32/install.cpp
+++ b/qga/vss-win32/install.cpp
@@ -345,3 +345,3 @@ STDAPI COMRegister(void)
 
-    /* Setup roles of the applicaion */
+    /* Setup roles of the application */
 
@@ -441,3 +441,3 @@ STDAPI DllRegisterServer(void)
 
-    /* Add this module to registery */
+    /* Add this module to registry */
 
-- 
2.39.2


