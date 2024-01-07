Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD403826344
	for <lists+qemu-devel@lfdr.de>; Sun,  7 Jan 2024 08:21:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMNRM-0002s5-Py; Sun, 07 Jan 2024 02:19:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>)
 id 1rMNRJ-0002r0-UC; Sun, 07 Jan 2024 02:19:22 -0500
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>)
 id 1rMNRH-0002Vx-Tz; Sun, 07 Jan 2024 02:19:21 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id CA891CE0AE8;
 Sun,  7 Jan 2024 07:19:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B233C433C7;
 Sun,  7 Jan 2024 07:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1704611948;
 bh=Bh7liYiHeIx3Vq6CFHeTZMdj0GWBysbr/3QXwBI9eg8=;
 h=Date:From:To:Subject:From;
 b=BeKZjLa6fSxcHsx6wAtabayxlu07/zH4MRP8cbRIpFBoZjhPT9lCLvaAMaG72WFeU
 IRz1VYL7mxNIqLdxvHhLcK3GJRKW2NgO5VOUmIHldW3A8DK87GdMA7SahGhObeTVOy
 QU1gUIdRCz0CrbVJfZpnzSp4yt29gz/dVlMVW3YceDJ0jgzpGZD1viCqwSeL86E23H
 9Tc5swWvkk7MZCItEaqj4Zd4+D/pUlhjRGvqOzKzF7O7TT1kCw2p9ZnvpwzZnc0Adu
 6mSFwLz3uPtchXoBd/O2QmHll4O2mfhw5/Kdi6gJAXv2GjdD4tfLQNjGWFE/VYV/Jk
 eieGd5Ulqml0w==
Date: Sun, 7 Jan 2024 08:19:03 +0100
From: Helge Deller <deller@kernel.org>
To: Laurent Vivier <laurent@vivier.eu>, Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Subject: [PATCH] tcg/tci: Fix TCI on hppa host and update TCI test matrix
Message-ID: <ZZpQZ77s2t81mXIT@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=deller@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Update the TCI interpreter test matrix for big-endian hosts with
big- (hppa, hppa64) and little-endian (x86,x96-64) targets.
I used native ppc64 and hppa hosts for those tests.

Starting TCI on a hppa host crashed immediately, because hppa is
the only archive left where the stack grows upwards.
Write-protecting the stack guard page at the top of the stack
fixes the crash.

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/tcg/tci/README b/tcg/tci/README
index 4a8b5b5401..0c1e50779e 100644
--- a/tcg/tci/README
+++ b/tcg/tci/README
@@ -72,16 +72,16 @@ host and target with same or different endianness.
             | host (le)                     host (be)
             | 32             64             32             64
 ------------+------------------------------------------------------------
-target (le) | s0, u0         s1, u1         s?, u?         s?, u?
+target (le) | s0, u0         s1, u1         s2, u?         s2, u?
 32 bit      |
             |
-target (le) | sc, uc         s1, u1         s?, u?         s?, u?
+target (le) | sc, uc         s1, u1         s2, u?         s2, u?
 64 bit      |
             |
-target (be) | sc, u0         sc, uc         s?, u?         s?, u?
+target (be) | sc, u0         sc, uc         s2, u?         s2, u?
 32 bit      |
             |
-target (be) | sc, uc         sc, uc         s?, u?         s?, u?
+target (be) | sc, uc         sc, uc         s?, u?         s2, u?
 64 bit      |
             |
 
@@ -110,6 +115,10 @@ u1 = linux-user-test works
   A cross compiled QEMU for ppc host works at least partially:
   i386-linux-user/qemu-i386 can run a simple hello-world program
   (tested in a ppc emulation).
+  The big-endian tests were run on native hppa (big-endian, 32-bit) and
+  ppc64 (big-endian, 64-bit) machines. Tested target machines were
+  x86 and x86-64 (little-endian, debian install ISO) and 32- and 64-bit
+  big-endian hppa (NetBSD and Debian install ISOs).
 
 * Some TCG opcodes are either missing in the code generator and/or
   in the interpreter. These opcodes raise a runtime exception, so it is
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index e86fd64e09..e378b71641 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -585,11 +585,8 @@ char *qemu_get_pid_name(pid_t pid)
 
 void *qemu_alloc_stack(size_t *sz)
 {
-    void *ptr;
+    void *ptr, *ptr2;
     int flags;
-#ifdef CONFIG_DEBUG_STACK_USAGE
-    void *ptr2;
-#endif
     size_t pagesz = qemu_real_host_page_size();
 #ifdef _SC_THREAD_STACK_MIN
     /* avoid stacks smaller than _SC_THREAD_STACK_MIN */
@@ -619,7 +616,12 @@ void *qemu_alloc_stack(size_t *sz)
     }
 
     /* Stack grows down -- guard page at the bottom. */
-    if (mprotect(ptr, pagesz, PROT_NONE) != 0) {
+    ptr2 = ptr;
+#if defined(__hppa__)
+    /* but on hppa the stack grows up, so guard the top page instead */
+    ptr2 = ptr + *sz - pagesz;
+#endif
+    if (mprotect(ptr2, pagesz, PROT_NONE) != 0) {
         perror("failed to set up stack guard page");
         abort();
     }

