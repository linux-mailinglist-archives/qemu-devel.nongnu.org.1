Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1D479FD65
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 09:44:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgh17-0001JE-27; Thu, 14 Sep 2023 03:44:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qgh10-00014L-8F
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 03:43:54 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qgh0x-0007pf-Qv
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 03:43:53 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B068121C35
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 10:43:53 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 4217427F6B;
 Thu, 14 Sep 2023 10:43:46 +0300 (MSK)
Received: (nullmailer pid 149930 invoked by uid 1000);
 Thu, 14 Sep 2023 07:43:46 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH v3 3/3] linux-user/syscall.c: do_ppoll: eliminate large alloca
Date: Thu, 14 Sep 2023 10:43:37 +0300
Message-Id: <20230914074337.149897-4-mjt@tls.msk.ru>
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

do_ppoll() in linux-user/syscall.c uses alloca() to allocate
an array of struct pullfds on the stack.  The only upper
boundary for number of entries for this array is so that
whole thing fits in INT_MAX.  This is definitely too much
for stack allocation.

Use heap allocation when large number of entries is requested
(currently 32, arbitrary), and continue to use alloca() for
smaller allocations, to optimize small operations for small
sizes.  The code for this optimization is small, I see no
reason for dropping it.

This eliminates last large user-controlled on-stack allocation
from syscall.c.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 linux-user/syscall.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index eabdf50abc..1dbe28eba4 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1489,7 +1489,7 @@ static abi_long do_ppoll(abi_long arg1, abi_long arg2, abi_long arg3,
 {
     struct target_pollfd *target_pfd = NULL;
     unsigned int nfds = arg2;
-    struct pollfd *pfd = NULL;
+    struct pollfd *pfd = NULL, *heap_pfd = NULL;
     unsigned int i;
     abi_long ret;
 
@@ -1503,7 +1503,17 @@ static abi_long do_ppoll(abi_long arg1, abi_long arg2, abi_long arg3,
             return -TARGET_EFAULT;
         }
 
-        pfd = alloca(sizeof(struct pollfd) * nfds);
+        /* arbitrary "small" number to limit stack usage */
+        if (nfds <= 64) {
+            pfd = alloca(sizeof(struct pollfd) * nfds);
+        } else {
+            heap_pfd = g_try_new(struct pollfd, nfds);
+            if (!heap_pfd) {
+                ret = -TARGET_ENOMEM;
+                goto out;
+            }
+            pfd = heap_pfd;
+        }
         for (i = 0; i < nfds; i++) {
             pfd[i].fd = tswap32(target_pfd[i].fd);
             pfd[i].events = tswap16(target_pfd[i].events);
@@ -1567,6 +1577,7 @@ static abi_long do_ppoll(abi_long arg1, abi_long arg2, abi_long arg3,
     }
 
 out:
+    g_free(heap_pfd);
     unlock_user(target_pfd, arg1, sizeof(struct target_pollfd) * nfds);
     return ret;
 }
-- 
2.39.2


