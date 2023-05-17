Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7088706269
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 10:11:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzC6y-0003KP-Ed; Wed, 17 May 2023 04:02:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1pzC6m-0002nv-MC
 for qemu-devel@nongnu.org; Wed, 17 May 2023 04:02:05 -0400
Received: from mout.kundenserver.de ([212.227.17.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1pzC6g-0000uB-E7
 for qemu-devel@nongnu.org; Wed, 17 May 2023 04:02:04 -0400
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue106
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MLyzP-1phwCg3VvF-00Hy7O; Wed, 17
 May 2023 10:01:56 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 4/9] linux-user: Add open_tree() syscall
Date: Wed, 17 May 2023 10:01:47 +0200
Message-Id: <20230517080152.108660-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517080152.108660-1-laurent@vivier.eu>
References: <20230517080152.108660-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:nB26NVKetrMmXJOFJGO4fmgeyuLjqBdBC7YVH9UFXjU5PsFJymq
 sidAyqjY7wqIHfS5p0z6/lOfmbhHF4Yxn6d02BV4DYJItm39sQ3Zg+gONGncNJUCubcCWEE
 OMyK7gQom1JOMYzskTnWb90oNdzGRxn8w574H7uinmVKJyHCJwK0uwkxSoEkS7IYIkhA5Iq
 pphQ9QrMRYNZCZ4yDLKXg==
UI-OutboundReport: notjunk:1;M01:P0:pCY10uAE3BQ=;LkNmG9CujVFVok+7wpSF6AFA853
 rKgrGAv4mcEPoNcA/8F/O0hDiNaKH1gSP2C2ui66odQd/XYrFxw/jVXKhFmpKPpWlTB1neRxJ
 y1w/Am4corvyUyuSBzrWG2j0yuDtF8p1k8Usckkiic692XnrsDy/E/RbXQrlHdNBxRlEIFDGi
 9h1E479dzz+DEF6fWAtCiX+cEBxRGZBFXuPaswYwbckySiZC7U+00X5j5EjFz1C+zYSg3+Wlj
 3/h902EUFhUDIKTCsDzKlZnpLeCnt3e8cRrmNcr8YlLsjDuFs8RtrNzyGXiBxZssV94u5u7tI
 eDcNvzxRKzV5SzchG3rgN1LTkNVrbvVjTBI6dtKi45aD/AZaVwJIllBFRG028jjiloe3gs5QO
 gEgVodiIvo8pjoUcRLzmgTipxeFkZFgmfRyd36fZewMi0RRQPJIv6HQW1B/8QKO3bcuP8Zd+K
 aQjDV9l7Pbz9SKUnQt+uqUgfH/V2hcuD3tzIzl9dQ9K0YNYIorOix5vcceekt+BihAX8nZVD9
 XTDzMQBEyzw2YnhDejzTXq2OgYoin7+00BbUeO1//TYhyfJVaZiYhux0WloOxhEJcfOUWWfzp
 mrjtgWalhVwsLPMq7asgHYMTLnd8PKHonte6zRHF73kyjnfrhf9UCN1uDq4Kx2LVw/DHCpdxl
 0lQz9fNnHdwYTzIpdZtGli/Q3EjidYAtUbWq0p/TRA==
Received-SPF: none client-ip=212.227.17.13; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

From: Thomas Weißschuh <thomas@t-8ch.de>

Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20230424153429.276788-2-thomas@t-8ch.de>
[lv: move declaration at the beginning of the block,
     define syscall]
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 9a99e4557367..00a779797efb 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8776,6 +8776,12 @@ static int do_getdents64(abi_long dirfd, abi_long arg2, abi_long count)
 _syscall2(int, pivot_root, const char *, new_root, const char *, put_old)
 #endif
 
+#if defined(TARGET_NR_open_tree) && defined(__NR_open_tree)
+#define __NR_sys_open_tree __NR_open_tree
+_syscall3(int, sys_open_tree, int, __dfd, const char *, __filename,
+          unsigned int, __flags)
+#endif
+
 #if defined(TARGET_NR_move_mount) && defined(__NR_move_mount)
 #define __NR_sys_move_mount __NR_move_mount
 _syscall5(int, sys_move_mount, int, __from_dfd, const char *, __from_pathname,
@@ -9202,6 +9208,33 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
             return ret;
         }
 #endif
+#if defined(TARGET_NR_open_tree) && defined(__NR_open_tree)
+    case TARGET_NR_open_tree:
+        {
+            void *p2;
+            int host_flags;
+
+            if (!arg2) {
+                return -TARGET_EFAULT;
+            }
+
+            p2 = lock_user_string(arg2);
+            if (!p2) {
+                return -TARGET_EFAULT;
+            }
+
+            host_flags = arg3 & ~TARGET_O_CLOEXEC;
+            if (arg3 & TARGET_O_CLOEXEC) {
+                host_flags |= O_CLOEXEC;
+            }
+
+            ret = get_errno(sys_open_tree(arg1, p2, host_flags));
+
+            unlock_user(p2, arg2, 0);
+
+            return ret;
+        }
+#endif
 #ifdef TARGET_NR_stime /* not on alpha */
     case TARGET_NR_stime:
         {
-- 
2.40.1


