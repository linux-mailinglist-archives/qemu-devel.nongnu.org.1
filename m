Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B1978774A
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 19:51:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZEUN-00010i-0N; Thu, 24 Aug 2023 13:51:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qZEUH-0000yd-QN
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 13:51:17 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qZEUD-0005CF-UZ
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 13:51:17 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DA8771CB2B;
 Thu, 24 Aug 2023 20:51:31 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 040BA219EA;
 Thu, 24 Aug 2023 20:51:10 +0300 (MSK)
Received: (nullmailer pid 2999114 invoked by uid 1000);
 Thu, 24 Aug 2023 17:51:09 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH v2] linux-user: ppoll: eliminate large alloca
Date: Thu, 24 Aug 2023 20:51:02 +0300
Message-Id: <20230824175102.2999098-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
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

do_ppoll() in linux-user/syscall.c uses alloca() to
allocate an array of struct pullfds on the stack.
The only upper boundary for number of entries for this
array is so that whole thing fits in INT_MAX. But this
is definitely too much for a stack allocation.  Use
heap allocation instead.

This, together with previous patch for getgroups(),
eliminates all large on-stack allocations from
qemu-user/syscall.c. What's left are actually small
ones.

While at it, also fix missing unlock_user() in two
places, and consolidate target_to_host_timespec*()
calls into time64?_timespec():_timespec64() construct.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
v1: https://patchwork.ozlabs.org/project/qemu-devel/patch/20221216192220.2881898-1-mjt@msgid.tls.msk.ru/
v2: remove alloca() optimization for smaller number of fds

 linux-user/syscall.c | 45 ++++++++++++++++++++------------------------
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 9353268cc1..e79594bcd5 100644
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
@@ -1505,7 +1503,11 @@ static abi_long do_ppoll(abi_long arg1, abi_long arg2, abi_long arg3,
             return -TARGET_EFAULT;
         }
 
-        pfd = alloca(sizeof(struct pollfd) * nfds);
+        pfd = g_try_new(struct pollfd, nfds);
+        if (!pfd) {
+            ret = -TARGET_ENOMEM;
+            goto out;
+        }
         for (i = 0; i < nfds; i++) {
             pfd[i].fd = tswap32(target_pfd[i].fd);
             pfd[i].events = tswap16(target_pfd[i].events);
@@ -1516,16 +1518,11 @@ static abi_long do_ppoll(abi_long arg1, abi_long arg2, abi_long arg3,
         sigset_t *set = NULL;
 
         if (arg3) {
-            if (time64) {
-                if (target_to_host_timespec64(timeout_ts, arg3)) {
-                    unlock_user(target_pfd, arg1, 0);
-                    return -TARGET_EFAULT;
-                }
-            } else {
-                if (target_to_host_timespec(timeout_ts, arg3)) {
-                    unlock_user(target_pfd, arg1, 0);
-                    return -TARGET_EFAULT;
-                }
+            if (time64
+                ? target_to_host_timespec64(timeout_ts, arg3)
+                : target_to_host_timespec(timeout_ts, arg3)) {
+                ret = -TARGET_EFAULT;
+                goto out;
             }
         } else {
             timeout_ts = NULL;
@@ -1534,8 +1531,7 @@ static abi_long do_ppoll(abi_long arg1, abi_long arg2, abi_long arg3,
         if (arg4) {
             ret = process_sigsuspend_mask(&set, arg4, arg5);
             if (ret != 0) {
-                unlock_user(target_pfd, arg1, 0);
-                return ret;
+                goto out;
             }
         }
 
@@ -1546,14 +1542,11 @@ static abi_long do_ppoll(abi_long arg1, abi_long arg2, abi_long arg3,
             finish_sigsuspend_mask(ret);
         }
         if (!is_error(ret) && arg3) {
-            if (time64) {
-                if (host_to_target_timespec64(arg3, timeout_ts)) {
-                    return -TARGET_EFAULT;
-                }
-            } else {
-                if (host_to_target_timespec(arg3, timeout_ts)) {
-                    return -TARGET_EFAULT;
-                }
+            if (time64
+                ? host_to_target_timespec64(arg3, timeout_ts)
+                : host_to_target_timespec(arg3, timeout_ts)) {
+                ret = -TARGET_EFAULT;
+                goto out;
             }
         }
     } else {
@@ -1576,6 +1569,8 @@ static abi_long do_ppoll(abi_long arg1, abi_long arg2, abi_long arg3,
             target_pfd[i].revents = tswap16(pfd[i].revents);
         }
     }
+out:
+    g_free(pfd);
     unlock_user(target_pfd, arg1, sizeof(struct target_pollfd) * nfds);
     return ret;
 }
-- 
2.39.2


