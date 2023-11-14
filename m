Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 564AD7EB54E
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 18:04:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2wkq-0006ca-Mm; Tue, 14 Nov 2023 11:59:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r2wkc-0006bz-1V; Tue, 14 Nov 2023 11:58:58 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r2wkR-0004m0-Kj; Tue, 14 Nov 2023 11:58:50 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 684EE33267;
 Tue, 14 Nov 2023 19:59:00 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 3563E351EE;
 Tue, 14 Nov 2023 19:58:42 +0300 (MSK)
Received: (nullmailer pid 2949075 invoked by uid 1000);
 Tue, 14 Nov 2023 16:58:42 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Stacey Son <sson@FreeBSD.org>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>
Subject: [PATCH trivial 01/21] bsd-user: spelling fixes: necesary, agrument,
 undocummented
Date: Tue, 14 Nov 2023 19:58:14 +0300
Message-Id: <20231114165834.2949011-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231114165834.2949011-1-mjt@tls.msk.ru>
References: <20231114165834.2949011-1-mjt@tls.msk.ru>
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

Fixes: a99d74034754 "bsd-user: Implement do_obreak function"
Fixes: 8632729060bf "bsd-user: Implement freebsd_exec_common, used in implementing execve/fexecve."
Fixes: bf14f13d8be8 "bsd-user: Implement stat related syscalls"
Cc: Stacey Son <sson@FreeBSD.org>
Cc: Warner Losh <imp@bsdimp.com>
Cc: Kyle Evans <kevans@freebsd.org>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 bsd-user/bsd-mem.h         | 2 +-
 bsd-user/freebsd/os-proc.c | 2 +-
 bsd-user/freebsd/os-stat.h | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index c3e72e3b86..21d9bab889 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -235,7 +235,7 @@ static inline abi_long do_obreak(abi_ulong brk_val)
         return target_brk;
     }
 
-    /* Release heap if necesary */
+    /* Release heap if necessary */
     if (new_brk < old_brk) {
         target_munmap(new_brk, old_brk - new_brk);
 
diff --git a/bsd-user/freebsd/os-proc.c b/bsd-user/freebsd/os-proc.c
index 4e67ae4d56..e0203e259b 100644
--- a/bsd-user/freebsd/os-proc.c
+++ b/bsd-user/freebsd/os-proc.c
@@ -115,7 +115,7 @@ abi_long freebsd_exec_common(abi_ulong path_or_fd, abi_ulong guest_argp,
     }
 
     qarg0 = argp = g_new0(char *, argc + 9);
-    /* save the first agrument for the emulator */
+    /* save the first argument for the emulator */
     *argp++ = (char *)getprogname();
     qargp = argp;
     *argp++ = (char *)getprogname();
diff --git a/bsd-user/freebsd/os-stat.h b/bsd-user/freebsd/os-stat.h
index b20e270774..3bdc66aa98 100644
--- a/bsd-user/freebsd/os-stat.h
+++ b/bsd-user/freebsd/os-stat.h
@@ -146,7 +146,7 @@ static inline abi_long do_freebsd_fstatat(abi_long arg1, abi_long arg2,
     return ret;
 }
 
-/* undocummented nstat(char *path, struct nstat *ub) syscall */
+/* undocumented nstat(char *path, struct nstat *ub) syscall */
 static abi_long do_freebsd11_nstat(abi_long arg1, abi_long arg2)
 {
     abi_long ret;
@@ -162,7 +162,7 @@ static abi_long do_freebsd11_nstat(abi_long arg1, abi_long arg2)
     return ret;
 }
 
-/* undocummented nfstat(int fd, struct nstat *sb) syscall */
+/* undocumented nfstat(int fd, struct nstat *sb) syscall */
 static abi_long do_freebsd11_nfstat(abi_long arg1, abi_long arg2)
 {
     abi_long ret;
@@ -175,7 +175,7 @@ static abi_long do_freebsd11_nfstat(abi_long arg1, abi_long arg2)
     return ret;
 }
 
-/* undocummented nlstat(char *path, struct nstat *ub) syscall */
+/* undocumented nlstat(char *path, struct nstat *ub) syscall */
 static abi_long do_freebsd11_nlstat(abi_long arg1, abi_long arg2)
 {
     abi_long ret;
-- 
2.39.2


