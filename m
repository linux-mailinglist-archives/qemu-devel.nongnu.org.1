Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D337761A99
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 15:52:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOINZ-0007EA-8h; Tue, 25 Jul 2023 09:47:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qOINK-000610-Ds; Tue, 25 Jul 2023 09:46:56 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qOINH-0001bD-PB; Tue, 25 Jul 2023 09:46:54 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 509D0160FC;
 Tue, 25 Jul 2023 16:45:36 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id DCA68194BF;
 Tue, 25 Jul 2023 16:45:33 +0300 (MSK)
Received: (nullmailer pid 3370843 invoked by uid 1000);
 Tue, 25 Jul 2023 13:45:29 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Helge Deller <deller@gmx.de>,
 "Markus F.X.J. Oberhumer" <markus@oberhumer.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.4 20/31] linux-user: Prohibit brk() to to shrink below
 initial heap address
Date: Tue, 25 Jul 2023 16:45:05 +0300
Message-Id: <20230725134517.3370706-20-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.4-20230725164041@cover.tls.msk.ru>
References: <qemu-stable-8.0.4-20230725164041@cover.tls.msk.ru>
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

From: Helge Deller <deller@gmx.de>

Since commit 86f04735ac ("linux-user: Fix brk() to release pages") it's
possible for userspace applications to reduce their memory footprint by
calling brk() with a lower address and free up memory. Before that commit
guest heap memory was never unmapped.

But the Linux kernel prohibits to reduce brk() below the initial memory
address which is set at startup by the set_brk() function in binfmt_elf.c.
Such a range check was missed in commit 86f04735ac.

This patch adds the missing check by storing the initial brk value in
initial_target_brk and verify any new brk addresses against that value.

Tested with the i386 upx binary from
https://github.com/upx/upx/releases/download/v4.0.2/upx-4.0.2-i386_linux.tar.xz

Signed-off-by: Helge Deller <deller@gmx.de>
Tested-by: "Markus F.X.J. Oberhumer" <markus@oberhumer.com>
Fixes: 86f04735ac ("linux-user: Fix brk() to release pages")
Cc: qemu-stable@nongnu.org
Buglink: https://github.com/upx/upx/issues/683
(cherry picked from commit dfe49864afb06e7e452a4366051697bc4fcfc1a5)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 450487af57..e106633837 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -801,12 +801,13 @@ static inline int host_to_target_sock_type(int host_type)
     return target_type;
 }
 
-static abi_ulong target_brk;
+static abi_ulong target_brk, initial_target_brk;
 static abi_ulong brk_page;
 
 void target_set_brk(abi_ulong new_brk)
 {
     target_brk = TARGET_PAGE_ALIGN(new_brk);
+    initial_target_brk = target_brk;
     brk_page = HOST_PAGE_ALIGN(target_brk);
 }
 
@@ -824,6 +825,11 @@ abi_long do_brk(abi_ulong brk_val)
         return target_brk;
     }
 
+    /* do not allow to shrink below initial brk value */
+    if (brk_val < initial_target_brk) {
+        brk_val = initial_target_brk;
+    }
+
     new_brk = TARGET_PAGE_ALIGN(brk_val);
     new_host_brk_page = HOST_PAGE_ALIGN(brk_val);
 
-- 
2.39.2


