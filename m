Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D515879853A
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 11:57:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeYE7-0007AJ-O7; Fri, 08 Sep 2023 05:56:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qeYE5-00079n-CI; Fri, 08 Sep 2023 05:56:33 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qeYE2-0006rY-UN; Fri, 08 Sep 2023 05:56:33 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0B8D6200D2;
 Fri,  8 Sep 2023 12:56:47 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 07F9626918;
 Fri,  8 Sep 2023 12:55:58 +0300 (MSK)
Received: (nullmailer pid 275970 invoked by uid 1000);
 Fri, 08 Sep 2023 09:55:56 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Eric Blake <eblake@redhat.com>
Subject: [PULL 10/23] qga/: spelling fixes
Date: Fri,  8 Sep 2023 12:55:07 +0300
Message-Id: <20230908095520.275866-11-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230908095520.275866-1-mjt@tls.msk.ru>
References: <20230908095520.275866-1-mjt@tls.msk.ru>
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
Reviewed-by: Eric Blake <eblake@redhat.com>
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
@@ -152,7 +152,7 @@ static gboolean ga_channel_open(GAChannel *c, const gchar *path,
 #ifdef __FreeBSD__
         /*
          * In the default state channel sends echo of every command to a
-         * client. The client programm doesn't expect this and raises an
+         * client. The client program doesn't expect this and raises an
          * error. Suppress echo by resetting ECHO terminal flag.
          */
         struct termios tio;
diff --git a/qga/commands-posix-ssh.c b/qga/commands-posix-ssh.c
index f3a580b8cc..236f80de44 100644
--- a/qga/commands-posix-ssh.c
+++ b/qga/commands-posix-ssh.c
@@ -382,7 +382,7 @@ test_add_keys(void)
                                       &err);
     g_assert(err == NULL);
 
-    /*  key2 came first, and should'nt be duplicated */
+    /*  key2 came first, and shouldn't be duplicated */
     test_authorized_keys_equal("algo key2 comments\n"
                                "algo key1 comments");
 }
diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index def857d773..6169bbf7a0 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -3249,7 +3249,7 @@ GuestUserList *qmp_guest_get_users(Error **errp)
 
 #endif
 
-/* Replace escaped special characters with theire real values. The replacement
+/* Replace escaped special characters with their real values. The replacement
  * is done in place -- returned value is in the original string.
  */
 static void ga_osrelease_replace_special(gchar *value)
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index d23875264f..6beae659b7 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -487,7 +487,7 @@ static GuestDiskBusType win2qemu[] = {
     [BusTypeVirtual] = GUEST_DISK_BUS_TYPE_VIRTUAL,
     [BusTypeFileBackedVirtual] = GUEST_DISK_BUS_TYPE_FILE_BACKED_VIRTUAL,
     /*
-     * BusTypeSpaces currently is not suported
+     * BusTypeSpaces currently is not supported
      */
     [BusTypeSpaces] = GUEST_DISK_BUS_TYPE_UNKNOWN,
     [BusTypeNvme] = GUEST_DISK_BUS_TYPE_NVME,
@@ -2259,7 +2259,7 @@ static char *ga_get_win_product_name(Error **errp)
         }
     }
     if (err != ERROR_SUCCESS) {
-        error_setg_win32(errp, err, "failed to retrive ProductName");
+        error_setg_win32(errp, err, "failed to retrieve ProductName");
         goto fail;
     }
 
diff --git a/qga/main.c b/qga/main.c
index 002161a0cc..8668b9f3d3 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -1333,7 +1333,7 @@ static bool check_is_frozen(GAState *s)
     /* check if a previous instance of qemu-ga exited with filesystems' state
      * marked as frozen. this could be a stale value (a non-qemu-ga process
      * or reboot may have since unfrozen them), but better to require an
-     * uneeded unfreeze than to risk hanging on start-up
+     * unneeded unfreeze than to risk hanging on start-up
      */
     struct stat st;
     if (stat(s->state_filepath_isfrozen, &st) == -1) {
diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
index ae38662a62..84944133f7 100644
--- a/qga/vss-win32/install.cpp
+++ b/qga/vss-win32/install.cpp
@@ -343,7 +343,7 @@ STDAPI COMRegister(void)
                                    _bstr_t(dllPath), _bstr_t(tlbPath),
                                    _bstr_t("")));
 
-    /* Setup roles of the applicaion */
+    /* Setup roles of the application */
 
     chk(getNameByStringSID(administratorsGroupSID, buffer, &bufferLen));
     chk(pApps->GetCollection(_bstr_t(L"Roles"), key,
@@ -439,7 +439,7 @@ STDAPI DllRegisterServer(void)
         goto out;
     }
 
-    /* Add this module to registery */
+    /* Add this module to registry */
 
     sprintf(key, "CLSID\\%s", g_szClsid);
     if (!CreateRegistryKey(key, NULL, g_szClsid)) {
-- 
2.39.2


