Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 579F17EDC57
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 08:50:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3X4V-0006VL-Ry; Thu, 16 Nov 2023 02:45:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r3X3l-0005sK-MH; Thu, 16 Nov 2023 02:45:11 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r3X3i-00057Y-Fj; Thu, 16 Nov 2023 02:45:09 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5356733BE1;
 Thu, 16 Nov 2023 10:45:03 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id DFB9F35847;
 Thu, 16 Nov 2023 10:44:41 +0300 (MSK)
Received: (nullmailer pid 3202511 invoked by uid 1000);
 Thu, 16 Nov 2023 07:44:41 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org
Subject: [PULL 08/27] linux-user: spelling fixes: othe, necesary
Date: Thu, 16 Nov 2023 10:44:22 +0300
Message-Id: <20231116074441.3202417-9-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231116074441.3202417-1-mjt@tls.msk.ru>
References: <20231116074441.3202417-1-mjt@tls.msk.ru>
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

Fixes: e34136d93059 "linux-user/ppc: Add vdso"
Fixes: 86f04735ac20 "linux-user: Fix brk() to release pages"
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 linux-user/ppc/vdso.S | 2 +-
 linux-user/syscall.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/linux-user/ppc/vdso.S b/linux-user/ppc/vdso.S
index 689010db13..2e79ea9808 100644
--- a/linux-user/ppc/vdso.S
+++ b/linux-user/ppc/vdso.S
@@ -227,7 +227,7 @@ endf	__kernel_sigtramp_rt
 #ifndef _ARCH_PPC64
 	/*
 	 * The non-rt sigreturn has the same layout at a different offset.
-	 * Move the CFA and leave all othe other descriptions the same.
+	 * Move the CFA and leave all the other descriptions the same.
 	 */
 	.cfi_def_cfa	1, SIGNAL_FRAMESIZE + offsetof_sigframe_mcontext
 	nop
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 65ac3ac796..16ca5ea7b6 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -831,7 +831,7 @@ abi_long do_brk(abi_ulong brk_val)
         return target_brk;
     }
 
-    /* Release heap if necesary */
+    /* Release heap if necessary */
     if (new_brk < old_brk) {
         target_munmap(new_brk, old_brk - new_brk);
 
-- 
2.39.2


