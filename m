Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A4BC27F06
	for <lists+qemu-devel@lfdr.de>; Sat, 01 Nov 2025 14:15:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFBPk-00078Y-Hi; Sat, 01 Nov 2025 09:13:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vFBPi-00078I-OB; Sat, 01 Nov 2025 09:13:02 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vFBPf-0001ec-87; Sat, 01 Nov 2025 09:13:02 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D2B4C1652E4;
 Sat, 01 Nov 2025 16:12:40 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 97A24309F2B;
 Sat, 01 Nov 2025 16:12:52 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org,
 Rodrigo Dias Correa <r@drigo.nl>, Kostiantyn Kostiuk <kkostiuk@redhat.com>
Subject: [PATCH trivial v2] qga: use access(2) to check for command existance
 instead of questionable stat(2)
Date: Sat,  1 Nov 2025 16:12:46 +0300
Message-ID: <20251101131250.792706-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The code checks existance of a command (halt/poweroff/reboot) by using
stat(2) and immediately checking for S_ISLNK() on the returned stat
struct.  This check will never be true, because stat(2) always follows
symbolic links and hence will either return ENOENT (in case of dangling
symlink) or the properties for the final target file.  It is lstat(2)
which might return information about the symlink itself.  However, even
there, we want to check the final file properties, not the first symlink.

This check - S_ISLNK - is harmful but useless in this case.  However, it
is confusing and it helps the wrong usage of stat(2) to spread, so it is
better to remove it.

Additionally, the code would better to check for the executable bits
of the final file, not check if it's a regular file - it's sort of
dubious to have anything but regular files in /sbin/.

But a POSIX system provides another command which suits the purpose
perfectly: it is access(2).  And it is so simple that it's not
necessary to create a separate function when usin it.

Replace stat(2) with access(X_OK) to check for file existance in
qga/commands-posix.c

Fixes: c5b4afd4d56e "qga: Support guest shutdown of BusyBox-based systems"
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
v2: fix reverse logic of the access() tests.
    I should write code more often :)

 qga/commands-posix.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index c7059857e4..0f4d6d96cc 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -213,12 +213,6 @@ out:
     return retcode;
 }
 
-static bool file_exists(const char *path)
-{
-    struct stat st;
-    return stat(path, &st) == 0 && (S_ISREG(st.st_mode) || S_ISLNK(st.st_mode));
-}
-
 #define POWEROFF_CMD_PATH "/sbin/poweroff"
 #define HALT_CMD_PATH "/sbin/halt"
 #define REBOOT_CMD_PATH "/sbin/reboot"
@@ -245,17 +239,17 @@ void qmp_guest_shutdown(const char *mode, Error **errp)
 
     slog("guest-shutdown called, mode: %s", mode);
     if (!mode || strcmp(mode, "powerdown") == 0) {
-        if (file_exists(POWEROFF_CMD_PATH)) {
+        if (access(POWEROFF_CMD_PATH, X_OK)) {
             shutdown_cmd = POWEROFF_CMD_PATH;
         }
         shutdown_flag = powerdown_flag;
     } else if (strcmp(mode, "halt") == 0) {
-        if (file_exists(HALT_CMD_PATH)) {
+        if (access(HALT_CMD_PATH, X_OK)) {
             shutdown_cmd = HALT_CMD_PATH;
         }
         shutdown_flag = halt_flag;
     } else if (strcmp(mode, "reboot") == 0) {
-        if (file_exists(REBOOT_CMD_PATH)) {
+        if (access(REBOOT_CMD_PATH, X_OK)) {
             shutdown_cmd = REBOOT_CMD_PATH;
         }
         shutdown_flag = reboot_flag;
-- 
2.47.3


