Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6686E704E0B
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 14:49:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyu6J-0004Lp-Ga; Tue, 16 May 2023 08:48:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1pyu6G-0004J6-5H
 for qemu-devel@nongnu.org; Tue, 16 May 2023 08:48:20 -0400
Received: from mout.kundenserver.de ([212.227.126.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1pyu6C-000639-To
 for qemu-devel@nongnu.org; Tue, 16 May 2023 08:48:19 -0400
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue012
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1N4vFE-1q8qFO0tT2-010vTY; Tue, 16
 May 2023 14:48:14 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 4/9] linux-user: Add open_tree() syscall
Date: Tue, 16 May 2023 14:48:05 +0200
Message-Id: <20230516124810.90494-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230516124810.90494-1-laurent@vivier.eu>
References: <20230516124810.90494-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:yrFHViysuoukes5YHDi9LbE5vvNH/XF2b4wFuDLm4mhSoNfn4Tv
 Lf7DV8hj387zyIvHx80Dfb1p8oWSHQvPIKQR5/85NtgVoJogRoIOXTrE7ZeNp+k6jr1KqYF
 xdIOio5r+337OqpjFEJtWJg4K/oU75T6uMaSqGTIb4RHsboUwBPteM1bBSdB6w0RC7xrK11
 GK59nKvU9mz1kLXlYgUVA==
UI-OutboundReport: notjunk:1;M01:P0:ZTPCWqekgTg=;QDk23tZart92XMSC5XdNe5bXo64
 c82vCopVxUy7VJlb6Cop+s9PRB3RvVNcRABUiSBCSggwy8iQmqIGQdhbjP3v35Dw6xtImy7D/
 BEJ5ft5sq1Fu3EdN+59KWXgR/ES71uPpaQbEIrH5whYFbMTl4vX60R6dSDHPJbWNxLhI4Y4nq
 xhptFFEvyUDtSTl3QcceSWZNOSLdMgBuDKcKffcdogVCSOPxonTHlig1oMz06iimQE8elP5Xs
 VfFeD5aRodDdFMNWaqy6ajgccYnBHjb4dQOklzC8zK65J6zCCfuEAqh6YJ0tUVO2CIWGNhM23
 63J9F74VzKJmpfeamGz4lWbH+OfGcYc63xFvdf2wV4fa4q6MVxSqWC81hq23e9OUxDENroVkA
 nQf+7yUXRR+RLB7D0g9QR8ofeK5T38Ufojb6zqLQs8yOTk39dU5tlOTOjdu7kCOki9k1aMjLE
 ed17ZzSBnGvgmIRN3LU+KT1/iJs9DEKvXhyNqLjMF11Xa/bgnYgbaFAwUVvEcJgKB4qGTyrA7
 JvZ51zI0Wj+U9mp2C+9Gc8Yr1YNYCWKp/8G15ZKDlaEwA6c4OSwaOOUohYA4Zvjh+rIUweYwA
 GaTKch6o2c5GQY75DZjJKKeMqXQSdRt21w1lJEy+A53FA9G9PAX7y4LR6ZPSEf3QvsNhtxGfq
 ERCV8z8nWkbE+z6PZL2ICKdqda5K4QbFw5wh/HOvfg==
Received-SPF: none client-ip=212.227.126.130; envelope-from=laurent@vivier.eu;
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


