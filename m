Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 79319761A8A
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 15:50:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOINl-0008Gq-S5; Tue, 25 Jul 2023 09:47:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qOINi-00087U-4X; Tue, 25 Jul 2023 09:47:18 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qOINg-0001c1-Fc; Tue, 25 Jul 2023 09:47:17 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8B5C3160FD;
 Tue, 25 Jul 2023 16:45:36 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 2814A194C0;
 Tue, 25 Jul 2023 16:45:34 +0300 (MSK)
Received: (nullmailer pid 3370846 invoked by uid 1000);
 Tue, 25 Jul 2023 13:45:29 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Helge Deller <deller@gmx.de>,
 "Markus F.X.J. Oberhumer" <markus@oberhumer.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.4 21/31] linux-user: Fix signed math overflow in brk()
 syscall
Date: Tue, 25 Jul 2023 16:45:06 +0300
Message-Id: <20230725134517.3370706-21-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.4-20230725164041@cover.tls.msk.ru>
References: <qemu-stable-8.0.4-20230725164041@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Fix the math overflow when calculating the new_malloc_size.

new_host_brk_page and brk_page are unsigned integers. If userspace
reduces the heap, new_host_brk_page is lower than brk_page which results
in a huge positive number (but should actually be negative).

Fix it by adding a proper check and as such make the code more readable.

Signed-off-by: Helge Deller <deller@gmx.de>
Tested-by: "Markus F.X.J. Oberhumer" <markus@oberhumer.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Fixes: 86f04735ac ("linux-user: Fix brk() to release pages")
Cc: qemu-stable@nongnu.org
Buglink: https://github.com/upx/upx/issues/683
(cherry picked from commit eac78a4b0b7da4de2c0a297f4d528ca9cc6256a3)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index e106633837..30a2ac0099 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -860,12 +860,13 @@ abi_long do_brk(abi_ulong brk_val)
      * itself); instead we treat "mapped but at wrong address" as
      * a failure and unmap again.
      */
-    new_alloc_size = new_host_brk_page - brk_page;
-    if (new_alloc_size) {
+    if (new_host_brk_page > brk_page) {
+        new_alloc_size = new_host_brk_page - brk_page;
         mapped_addr = get_errno(target_mmap(brk_page, new_alloc_size,
                                         PROT_READ|PROT_WRITE,
                                         MAP_ANON|MAP_PRIVATE, 0, 0));
     } else {
+        new_alloc_size = 0;
         mapped_addr = brk_page;
     }
 
-- 
2.39.2


