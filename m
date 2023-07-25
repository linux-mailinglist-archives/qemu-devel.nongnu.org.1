Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DC5761A96
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 15:52:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOINV-0006vQ-QE; Tue, 25 Jul 2023 09:47:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qOINK-00060z-Dm; Tue, 25 Jul 2023 09:46:56 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qOINH-0001bB-OW; Tue, 25 Jul 2023 09:46:54 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 06F36160FB;
 Tue, 25 Jul 2023 16:45:36 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id AA87A194BE;
 Tue, 25 Jul 2023 16:45:33 +0300 (MSK)
Received: (nullmailer pid 3370840 invoked by uid 1000);
 Tue, 25 Jul 2023 13:45:29 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Helge Deller <deller@gmx.de>,
 "Markus F.X.J. Oberhumer" <markus@oberhumer.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.4 19/31] linux-user: Fix qemu brk() to not zero bytes on
 current page
Date: Tue, 25 Jul 2023 16:45:04 +0300
Message-Id: <20230725134517.3370706-19-mjt@tls.msk.ru>
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

The qemu brk() implementation is too aggressive and cleans remaining bytes
on the current page above the last brk address.

But some existing applications are buggy and read/write bytes above their
current heap address. On a phyiscal machine this does not trigger a
runtime error as long as the access happens on the same page. Additionally
the Linux kernel allocates only full pages and does no zeroing on already
allocated pages, even if the brk address is lowered.

Fix qemu to behave the same way as the kernel does. Do not touch already
allocated pages, and - when running with different page sizes of guest and
host - zero out only those memory areas where the host page size is bigger
than the guest page size.

Signed-off-by: Helge Deller <deller@gmx.de>
Tested-by: "Markus F.X.J. Oberhumer" <markus@oberhumer.com>
Fixes: 86f04735ac ("linux-user: Fix brk() to release pages")
Cc: qemu-stable@nongnu.org
Buglink: https://github.com/upx/upx/issues/683
(cherry picked from commit 15ad98536ad9410fb32ddf1ff09389b677643faa)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 57aaa87e30..450487af57 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -829,10 +829,8 @@ abi_long do_brk(abi_ulong brk_val)
 
     /* brk_val and old target_brk might be on the same page */
     if (new_brk == TARGET_PAGE_ALIGN(target_brk)) {
-        if (brk_val > target_brk) {
-            /* empty remaining bytes in (possibly larger) host page */
-            memset(g2h_untagged(target_brk), 0, new_host_brk_page - target_brk);
-        }
+        /* empty remaining bytes in (possibly larger) host page */
+        memset(g2h_untagged(new_brk), 0, new_host_brk_page - new_brk);
         target_brk = brk_val;
         return target_brk;
     }
@@ -840,7 +838,7 @@ abi_long do_brk(abi_ulong brk_val)
     /* Release heap if necesary */
     if (new_brk < target_brk) {
         /* empty remaining bytes in (possibly larger) host page */
-        memset(g2h_untagged(brk_val), 0, new_host_brk_page - brk_val);
+        memset(g2h_untagged(new_brk), 0, new_host_brk_page - new_brk);
 
         /* free unused host pages and set new brk_page */
         target_munmap(new_host_brk_page, brk_page - new_host_brk_page);
@@ -873,7 +871,7 @@ abi_long do_brk(abi_ulong brk_val)
          * come from the remaining part of the previous page: it may
          * contains garbage data due to a previous heap usage (grown
          * then shrunken).  */
-        memset(g2h_untagged(target_brk), 0, brk_page - target_brk);
+        memset(g2h_untagged(brk_page), 0, HOST_PAGE_ALIGN(brk_page) - brk_page);
 
         target_brk = brk_val;
         brk_page = new_host_brk_page;
-- 
2.39.2


