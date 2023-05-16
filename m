Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7430704E1C
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 14:50:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyu6I-0004Kp-I1; Tue, 16 May 2023 08:48:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1pyu6G-0004J7-5n
 for qemu-devel@nongnu.org; Tue, 16 May 2023 08:48:20 -0400
Received: from mout.kundenserver.de ([212.227.126.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1pyu6C-000637-Sk
 for qemu-devel@nongnu.org; Tue, 16 May 2023 08:48:19 -0400
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue012
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1N79Ey-1qFPpB3OBA-017W6u; Tue, 16
 May 2023 14:48:13 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 3/9] linux-user: Add move_mount() syscall
Date: Tue, 16 May 2023 14:48:04 +0200
Message-Id: <20230516124810.90494-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230516124810.90494-1-laurent@vivier.eu>
References: <20230516124810.90494-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:NYdTDmcMxR00TOQabDtINyPvPAp04l/8GQs9/OP9Cc30x0ZJsqg
 9ysaoFeHikz55sEUSYKcBN1DCOHXPWans/s+41Q9QnmZb5Fom+CcRG5xKMeE0H/Fd+8ItEY
 MHYnx354Fq45DFtSQV/QvUG5UdTMUaC7hZaOuJ7qkCU8AX2ox54J6npZOaf4ed4hmu2QmLZ
 YNV38SaiZQ4BfImef5Asg==
UI-OutboundReport: notjunk:1;M01:P0:ZmfdnubxP9k=;GNZOM4TNpp9pOcUKERTDSzd5nn4
 Pwq03I6a/D1DWiff1ORjewaNss1WoaEfTdn4wNb450hq1LweycJFUEv0dzyX0HBZwJ5KocRSF
 Hnov8wc1paPJHBc/ypOqD/q4pPSo/M+6yccYKKJiISuq5h89xDyhn59nQEYi/jzyW83dq4sxx
 AC8HpQt0vQHtCt3xqdmRz+ix3WmZE0MQO6Nuy1HOYjcHOveaV0iyks+tGnHqN8zGrpF2/3od0
 QmFipgucweIWg6aPPd6pDKOzdn8c93+CzLwcGRPDlxq6kQRc5w6c0I1UQ8tCFSqdtlCfbI6im
 H+FXfhPOyHSfolH1JKSEdWa51xj1m6yTs0/yk1se0Lfly4YwoRnBccQi/PNjNHNcGxghq+631
 Q2/kvUeD01egsb2YKRtZ6/odzlWvFAukB8GuFiNrOG0qri/56d8+w7TbC/EuWv2s/KYFmcDOH
 1yOMUK5pIe8syjeVoP6u0ELzpdqj1hmJMaAf+zUlQm2GKE1Br3LFi5snRPjksYvFqzoYv9fBE
 LZZa5hr3gY0d0vs2Ntt6P5K3mwy6WALSJxevVdGcdB7I8amOj+yPhrUvUUJ9GALEWAh4MZkwU
 ScZbk8X49f0+ZB2mDneEzMbHA0aUQBDfHKR4SM5swT6alm+iCGjHFHyRsfE5AT6yLC78URfh1
 0ko+B9Nph2EIIRwpmllypMBZEfBhi7O3h/Z5ge7BPg==
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


