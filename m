Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DED879FD68
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 09:45:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgh12-00015Q-TT; Thu, 14 Sep 2023 03:43:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qgh0w-0000zW-P8
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 03:43:50 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qgh0u-0007nW-Dj
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 03:43:49 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A62CB21C33
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 10:43:51 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 3666B27F69;
 Thu, 14 Sep 2023 10:43:44 +0300 (MSK)
Received: (nullmailer pid 149922 invoked by uid 1000);
 Thu, 14 Sep 2023 07:43:44 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH v3 1/3] linux-user/syscall.c: do_ppoll: simplify time64
 host<=>target conversion expressions
Date: Thu, 14 Sep 2023 10:43:35 +0300
Message-Id: <20230914074337.149897-2-mjt@tls.msk.ru>
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

replace if (time64) { time64-expr } else { time32-expr }
expressions which are difficult to read with a much shorter
and easier to read arithmetic-if constructs.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 linux-user/syscall.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 3521a2d70b..33bf84c205 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1516,16 +1516,11 @@ static abi_long do_ppoll(abi_long arg1, abi_long arg2, abi_long arg3,
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
+                unlock_user(target_pfd, arg1, 0);
+                return -TARGET_EFAULT;
             }
         } else {
             timeout_ts = NULL;
@@ -1546,14 +1541,10 @@ static abi_long do_ppoll(abi_long arg1, abi_long arg2, abi_long arg3,
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
+                return -TARGET_EFAULT;
             }
         }
     } else {
-- 
2.39.2


