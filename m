Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 853D579FD64
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 09:44:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgh14-00018k-H5; Thu, 14 Sep 2023 03:43:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qgh0y-00010Q-5w
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 03:43:52 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qgh0w-0007om-HQ
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 03:43:51 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C8CA021C34
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 10:43:52 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 5AD0927F6A;
 Thu, 14 Sep 2023 10:43:45 +0300 (MSK)
Received: (nullmailer pid 149926 invoked by uid 1000);
 Thu, 14 Sep 2023 07:43:45 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH v3 2/3] linux-user/syscall.c: do_ppoll: consolidate and fix
 the forgotten unlock_user
Date: Thu, 14 Sep 2023 10:43:36 +0300
Message-Id: <20230914074337.149897-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230914074337.149897-1-mjt@tls.msk.ru>
References: <20230914074337.149897-1-mjt@tls.msk.ru>
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

in do_ppoll we've one place where unlock_user isn't done
at all, while other places use 0 for the size of the area
being unlocked instead of the actual size.

Instead of open-coding calls to unlock_user(), jump to the
end of this function and do a single call to unlock there.

Note: original code calls unlock_user() with target_pfd being
NULL in one case (when nfds == 0).   Move initializers to
variable declarations, - I wondered a few times if target_pfd
isn't being initialized at all for unlock_user.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 linux-user/syscall.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 33bf84c205..eabdf50abc 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1487,14 +1487,12 @@ static abi_long do_pselect6(abi_long arg1, abi_long arg2, abi_long arg3,
 static abi_long do_ppoll(abi_long arg1, abi_long arg2, abi_long arg3,
                          abi_long arg4, abi_long arg5, bool ppoll, bool time64)
 {
-    struct target_pollfd *target_pfd;
+    struct target_pollfd *target_pfd = NULL;
     unsigned int nfds = arg2;
-    struct pollfd *pfd;
+    struct pollfd *pfd = NULL;
     unsigned int i;
     abi_long ret;
 
-    pfd = NULL;
-    target_pfd = NULL;
     if (nfds) {
         if (nfds > (INT_MAX / sizeof(struct target_pollfd))) {
             return -TARGET_EINVAL;
@@ -1519,8 +1517,8 @@ static abi_long do_ppoll(abi_long arg1, abi_long arg2, abi_long arg3,
             if (time64
                 ? target_to_host_timespec64(timeout_ts, arg3)
                 : target_to_host_timespec(timeout_ts, arg3)) {
-                unlock_user(target_pfd, arg1, 0);
-                return -TARGET_EFAULT;
+                ret = -TARGET_EFAULT;
+                goto out;
             }
         } else {
             timeout_ts = NULL;
@@ -1529,8 +1527,7 @@ static abi_long do_ppoll(abi_long arg1, abi_long arg2, abi_long arg3,
         if (arg4) {
             ret = process_sigsuspend_mask(&set, arg4, arg5);
             if (ret != 0) {
-                unlock_user(target_pfd, arg1, 0);
-                return ret;
+                goto out;
             }
         }
 
@@ -1544,7 +1541,8 @@ static abi_long do_ppoll(abi_long arg1, abi_long arg2, abi_long arg3,
             if (time64
                 ? host_to_target_timespec64(arg3, timeout_ts)
                 : host_to_target_timespec(arg3, timeout_ts)) {
-                return -TARGET_EFAULT;
+                ret = -TARGET_EFAULT;
+                goto out;
             }
         }
     } else {
@@ -1567,6 +1565,8 @@ static abi_long do_ppoll(abi_long arg1, abi_long arg2, abi_long arg3,
             target_pfd[i].revents = tswap16(pfd[i].revents);
         }
     }
+
+out:
     unlock_user(target_pfd, arg1, sizeof(struct target_pollfd) * nfds);
     return ret;
 }
-- 
2.39.2


