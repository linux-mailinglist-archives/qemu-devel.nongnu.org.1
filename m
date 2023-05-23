Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AE370DA23
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 12:17:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1P4D-0006wo-0z; Tue, 23 May 2023 06:16:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q1P3n-0006mC-LX; Tue, 23 May 2023 06:16:08 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q1P3k-0001t8-8Q; Tue, 23 May 2023 06:16:07 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DD0A07CF9;
 Tue, 23 May 2023 13:15:50 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 231B97289;
 Tue, 23 May 2023 13:15:50 +0300 (MSK)
Received: (nullmailer pid 85511 invoked by uid 1000);
 Tue, 23 May 2023 10:15:48 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [Stable-8.0.1 43/59] linux-user: fix getgroups/setgroups allocations
Date: Tue, 23 May 2023 13:15:03 +0300
Message-Id: <20230523101536.85424-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.1-20230523131351@cover.tls.msk.ru>
References: <qemu-stable-8.0.1-20230523131351@cover.tls.msk.ru>
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

linux-user getgroups(), setgroups(), getgroups32() and setgroups32()
used alloca() to allocate grouplist arrays, with unchecked gidsetsize
coming from the "guest".  With NGROUPS_MAX being 65536 (linux, and it
is common for an application to allocate NGROUPS_MAX for getgroups()),
this means a typical allocation is half the megabyte on the stack.
Which just overflows stack, which leads to immediate SIGSEGV in actual
system getgroups() implementation.

An example of such issue is aptitude, eg
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=811087#72

Cap gidsetsize to NGROUPS_MAX (return EINVAL if it is larger than that),
and use heap allocation for grouplist instead of alloca().  While at it,
fix coding style and make all 4 implementations identical.

Try to not impose random limits - for example, allow gidsetsize to be
negative for getgroups() - just do not allocate negative-sized grouplist
in this case but still do actual getgroups() call.  But do not allow
negative gidsetsize for setgroups() since its argument is unsigned.

Capping by NGROUPS_MAX seems a bit arbitrary, - we can do more, it is
not an error if set size will be NGROUPS_MAX+1. But we should not allow
integer overflow for the array being allocated. Maybe it is enough to
just call g_try_new() and return ENOMEM if it fails.

Maybe there's also no need to convert setgroups() since this one is
usually smaller and known beforehand (KERN_NGROUPS_MAX is actually 63, -
this is apparently a kernel-imposed limit for runtime group set).

The patch fixes aptitude segfault mentioned above.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Message-Id: <20230409105327.1273372-1-mjt@msgid.tls.msk.ru>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
(cherry picked from commit 1e35d327890bdd117a67f79c52e637fb12bb1bf4)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 69f740ff98..333e6b7026 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -11475,39 +11475,58 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
         {
             int gidsetsize = arg1;
             target_id *target_grouplist;
-            gid_t *grouplist;
+            g_autofree gid_t *grouplist = NULL;
             int i;
 
-            grouplist = alloca(gidsetsize * sizeof(gid_t));
+            if (gidsetsize > NGROUPS_MAX) {
+                return -TARGET_EINVAL;
+            }
+            if (gidsetsize > 0) {
+                grouplist = g_try_new(gid_t, gidsetsize);
+                if (!grouplist) {
+                    return -TARGET_ENOMEM;
+                }
+            }
             ret = get_errno(getgroups(gidsetsize, grouplist));
-            if (gidsetsize == 0)
-                return ret;
-            if (!is_error(ret)) {
-                target_grouplist = lock_user(VERIFY_WRITE, arg2, gidsetsize * sizeof(target_id), 0);
-                if (!target_grouplist)
+            if (!is_error(ret) && gidsetsize > 0) {
+                target_grouplist = lock_user(VERIFY_WRITE, arg2,
+                                             gidsetsize * sizeof(target_id), 0);
+                if (!target_grouplist) {
                     return -TARGET_EFAULT;
-                for(i = 0;i < ret; i++)
+                }
+                for (i = 0; i < ret; i++) {
                     target_grouplist[i] = tswapid(high2lowgid(grouplist[i]));
-                unlock_user(target_grouplist, arg2, gidsetsize * sizeof(target_id));
+                }
+                unlock_user(target_grouplist, arg2,
+                            gidsetsize * sizeof(target_id));
             }
+            return ret;
         }
-        return ret;
     case TARGET_NR_setgroups:
         {
             int gidsetsize = arg1;
             target_id *target_grouplist;
-            gid_t *grouplist = NULL;
+            g_autofree gid_t *grouplist = NULL;
             int i;
-            if (gidsetsize) {
-                grouplist = alloca(gidsetsize * sizeof(gid_t));
-                target_grouplist = lock_user(VERIFY_READ, arg2, gidsetsize * sizeof(target_id), 1);
+
+            if (gidsetsize > NGROUPS_MAX || gidsetsize < 0) {
+                return -TARGET_EINVAL;
+            }
+            if (gidsetsize > 0) {
+                grouplist = g_try_new(gid_t, gidsetsize);
+                if (!grouplist) {
+                    return -TARGET_ENOMEM;
+                }
+                target_grouplist = lock_user(VERIFY_READ, arg2,
+                                             gidsetsize * sizeof(target_id), 1);
                 if (!target_grouplist) {
                     return -TARGET_EFAULT;
                 }
                 for (i = 0; i < gidsetsize; i++) {
                     grouplist[i] = low2highgid(tswapid(target_grouplist[i]));
                 }
-                unlock_user(target_grouplist, arg2, 0);
+                unlock_user(target_grouplist, arg2,
+                            gidsetsize * sizeof(target_id));
             }
             return get_errno(setgroups(gidsetsize, grouplist));
         }
@@ -11792,41 +11811,59 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
         {
             int gidsetsize = arg1;
             uint32_t *target_grouplist;
-            gid_t *grouplist;
+            g_autofree gid_t *grouplist = NULL;
             int i;
 
-            grouplist = alloca(gidsetsize * sizeof(gid_t));
+            if (gidsetsize > NGROUPS_MAX) {
+                return -TARGET_EINVAL;
+            }
+            if (gidsetsize > 0) {
+                grouplist = g_try_new(gid_t, gidsetsize);
+                if (!grouplist) {
+                    return -TARGET_ENOMEM;
+                }
+            }
             ret = get_errno(getgroups(gidsetsize, grouplist));
-            if (gidsetsize == 0)
-                return ret;
-            if (!is_error(ret)) {
-                target_grouplist = lock_user(VERIFY_WRITE, arg2, gidsetsize * 4, 0);
+            if (!is_error(ret) && gidsetsize > 0) {
+                target_grouplist = lock_user(VERIFY_WRITE, arg2,
+                                             gidsetsize * 4, 0);
                 if (!target_grouplist) {
                     return -TARGET_EFAULT;
                 }
-                for(i = 0;i < ret; i++)
+                for (i = 0; i < ret; i++) {
                     target_grouplist[i] = tswap32(grouplist[i]);
+                }
                 unlock_user(target_grouplist, arg2, gidsetsize * 4);
             }
+            return ret;
         }
-        return ret;
 #endif
 #ifdef TARGET_NR_setgroups32
     case TARGET_NR_setgroups32:
         {
             int gidsetsize = arg1;
             uint32_t *target_grouplist;
-            gid_t *grouplist;
+            g_autofree gid_t *grouplist = NULL;
             int i;
 
-            grouplist = alloca(gidsetsize * sizeof(gid_t));
-            target_grouplist = lock_user(VERIFY_READ, arg2, gidsetsize * 4, 1);
-            if (!target_grouplist) {
-                return -TARGET_EFAULT;
+            if (gidsetsize > NGROUPS_MAX || gidsetsize < 0) {
+                return -TARGET_EINVAL;
+            }
+            if (gidsetsize > 0) {
+                grouplist = g_try_new(gid_t, gidsetsize);
+                if (!grouplist) {
+                    return -TARGET_ENOMEM;
+                }
+                target_grouplist = lock_user(VERIFY_READ, arg2,
+                                             gidsetsize * 4, 1);
+                if (!target_grouplist) {
+                    return -TARGET_EFAULT;
+                }
+                for (i = 0; i < gidsetsize; i++) {
+                    grouplist[i] = tswap32(target_grouplist[i]);
+                }
+                unlock_user(target_grouplist, arg2, 0);
             }
-            for(i = 0;i < gidsetsize; i++)
-                grouplist[i] = tswap32(target_grouplist[i]);
-            unlock_user(target_grouplist, arg2, 0);
             return get_errno(setgroups(gidsetsize, grouplist));
         }
 #endif
-- 
2.39.2


