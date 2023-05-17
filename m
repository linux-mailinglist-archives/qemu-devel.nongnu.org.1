Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9915770622A
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 10:04:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzC71-0003T2-J8; Wed, 17 May 2023 04:02:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1pzC6n-0002oQ-JQ
 for qemu-devel@nongnu.org; Wed, 17 May 2023 04:02:05 -0400
Received: from mout.kundenserver.de ([217.72.192.74])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1pzC6g-0000uC-FP
 for qemu-devel@nongnu.org; Wed, 17 May 2023 04:02:05 -0400
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue106
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1Mqro7-1qUBBy1nSj-00mqxe; Wed, 17
 May 2023 10:01:55 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 3/9] linux-user: Add move_mount() syscall
Date: Wed, 17 May 2023 10:01:46 +0200
Message-Id: <20230517080152.108660-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517080152.108660-1-laurent@vivier.eu>
References: <20230517080152.108660-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:KH00k4QrHYFHPdOrGsGq13QWDwUMHCkOxOge9gv/xEf0Riwcieb
 eR7DFVPtKhTcCazzw8sod5dU9LVAV8N9Bq18C3COpzbR6y3noyf0cCb74/1aY14clP9NMqR
 FHeFE4yuGJPYFXqbOOuCnI7PDgkUpe25WzNIKs39Hcvv8FXFOh1aILdiTnXatOpo58ra1B3
 OnUT+G7UQpR8vg+2YkCZg==
UI-OutboundReport: notjunk:1;M01:P0:JUvrKtqZOtw=;T4Grp5wfpwS+Ly9T5O3bA2ErxgV
 jdBeI2sjRdKxegq60eloRJDvEP60oYq/3k/553hggeoeaSVlAaxr2XktFXU5GFPH0KTh74o8g
 bQGdEMcZKNcpnbdMexEEoXaqSj4zGUqeJp1dmrKDmBTThkoth4HMWG1dI3gs71OfrH9XGcFol
 Ak3SvJS9sV3SoZxQFaDtSfY2yswCjedmsFrf6pps+YhUw0N8h/YRpe8YvurOZ085aiCxBPT0b
 ppgXN+87bWptvvL7VkU1ZjHF+Rm/4Nxn3y6m3dGlu+dsqNXAP28+Yjz2L1uCpev/WJNpRKSvx
 WlNIz7dJV8qpmbnEz0r64bJKbirLuXhiYLd30LK7lC6+AIexa120xmW2++OVjS/tdi+IgTvw7
 ozb/78uJlzYnFn1V7Kj79Bl4h65VKSWloos6IHLuwbkKH0MN9g5MUz3ellzL961NmMcmuL4gu
 Iv6O+4ssr/K7bclC+mmqC1DZNx0LpG6Dg837qWS4g6uFYfTCL5B6b8GzETalt3hTvMjGWpnJQ
 +zRuy6t/mkWVtc+/qTRQGzAX8xko5ySwbcYuCVLs3bWiUToelMA974+lrUq6sYq4BupsTfGYA
 7HsGSRtKGvp31nSuElquTBeu/2GOG/CaSpg9+tepryf1zCTlzPmCDCDPjhXSnMA183uPTlJX1
 x1xGDIPvRD2EtMKIksp0tP/tWHUq9aXfAD9NQFrliQ==
Received-SPF: none client-ip=217.72.192.74; envelope-from=laurent@vivier.eu;
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
[lv: define syscall]
Message-Id: <20230424153429.276788-1-thomas@t-8ch.de>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 954ed14df4c0..9a99e4557367 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8776,6 +8776,12 @@ static int do_getdents64(abi_long dirfd, abi_long arg2, abi_long count)
 _syscall2(int, pivot_root, const char *, new_root, const char *, put_old)
 #endif
 
+#if defined(TARGET_NR_move_mount) && defined(__NR_move_mount)
+#define __NR_sys_move_mount __NR_move_mount
+_syscall5(int, sys_move_mount, int, __from_dfd, const char *, __from_pathname,
+           int, __to_dfd, const char *, __to_pathname, unsigned int, flag)
+#endif
+
 /* This is an internal helper for do_syscall so that it is easier
  * to have a single return point, so that actions, such as logging
  * of syscall results, can be performed.
@@ -9169,6 +9175,33 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
         unlock_user(p, arg1, 0);
         return ret;
 #endif
+#if defined(TARGET_NR_move_mount) && defined(__NR_move_mount)
+    case TARGET_NR_move_mount:
+        {
+            void *p2, *p4;
+
+            if (!arg2 || !arg4) {
+                return -TARGET_EFAULT;
+            }
+
+            p2 = lock_user_string(arg2);
+            if (!p2) {
+                return -TARGET_EFAULT;
+            }
+
+            p4 = lock_user_string(arg4);
+            if (!p4) {
+                unlock_user(p2, arg2, 0);
+                return -TARGET_EFAULT;
+            }
+            ret = get_errno(sys_move_mount(arg1, p2, arg3, p4, arg5));
+
+            unlock_user(p2, arg2, 0);
+            unlock_user(p4, arg4, 0);
+
+            return ret;
+        }
+#endif
 #ifdef TARGET_NR_stime /* not on alpha */
     case TARGET_NR_stime:
         {
-- 
2.40.1


