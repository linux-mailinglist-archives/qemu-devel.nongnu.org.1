Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF342761A5C
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 15:47:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOIMV-0005NR-T5; Tue, 25 Jul 2023 09:46:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qOIMD-0005GP-M5; Tue, 25 Jul 2023 09:45:47 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qOIM9-0001Gq-1v; Tue, 25 Jul 2023 09:45:44 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A00F9160EC;
 Tue, 25 Jul 2023 16:45:32 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 451D9194AF;
 Tue, 25 Jul 2023 16:45:30 +0300 (MSK)
Received: (nullmailer pid 3370795 invoked by uid 1000);
 Tue, 25 Jul 2023 13:45:29 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.4 04/31] linux-user: Fix accept4(SOCK_NONBLOCK) syscall
Date: Tue, 25 Jul 2023 16:44:49 +0300
Message-Id: <20230725134517.3370706-4-mjt@tls.msk.ru>
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

The Linux accept4() syscall allows two flags only: SOCK_NONBLOCK and
SOCK_CLOEXEC, and returns -EINVAL if any other bits have been set.

Change the qemu implementation accordingly, which means we can not use
the fcntl_flags_tbl[] translation table which allows too many other
values.

Beside the correction in behaviour, this actually fixes the accept4()
emulation for hppa, mips and alpha targets for which SOCK_NONBLOCK is
different than TARGET_SOCK_NONBLOCK (aka O_NONBLOCK).

The fix can be verified with the testcase of the debian lwt package,
which hangs forever in a read() syscall without this patch.

Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit dca4c8384d68bbf5d67f50a5446865d92d61f032)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 333e6b7026..0901884495 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -3440,7 +3440,17 @@ static abi_long do_accept4(int fd, abi_ulong target_addr,
     abi_long ret;
     int host_flags;
 
-    host_flags = target_to_host_bitmask(flags, fcntl_flags_tbl);
+    if (flags & ~(TARGET_SOCK_CLOEXEC | TARGET_SOCK_NONBLOCK)) {
+        return -TARGET_EINVAL;
+    }
+
+    host_flags = 0;
+    if (flags & TARGET_SOCK_NONBLOCK) {
+        host_flags |= SOCK_NONBLOCK;
+    }
+    if (flags & TARGET_SOCK_CLOEXEC) {
+        host_flags |= SOCK_CLOEXEC;
+    }
 
     if (target_addr == 0) {
         return get_errno(safe_accept4(fd, NULL, NULL, host_flags));
-- 
2.39.2


