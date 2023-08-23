Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D616785021
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 07:53:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYgnG-0001Ry-HU; Wed, 23 Aug 2023 01:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qYgn7-0001QF-EP
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 01:52:30 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qYgn3-0007KT-5d
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 01:52:28 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E00041C391
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 08:52:19 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 7DD3221239;
 Wed, 23 Aug 2023 08:52:01 +0300 (MSK)
Received: (nullmailer pid 1917465 invoked by uid 1000);
 Wed, 23 Aug 2023 05:52:00 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 04/24] util: spelling fixes
Date: Wed, 23 Aug 2023 08:51:35 +0300
Message-Id: <20230823055155.1917375-5-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1691405748.git.mjt@tls.msk.ru>
References: <cover.1691405748.git.mjt@tls.msk.ru>
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

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 util/cpuinfo-aarch64.c | 4 ++--
 util/cpuinfo-i386.c    | 4 ++--
 util/cpuinfo-ppc.c     | 2 +-
 util/main-loop.c       | 2 +-
 util/oslib-posix.c     | 2 +-
 util/qdist.c           | 2 +-
 util/qemu-sockets.c    | 2 +-
 util/rcu.c             | 2 +-
 8 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/util/cpuinfo-aarch64.c b/util/cpuinfo-aarch64.c
index ababc39550..7d39f47e3b 100644
--- a/util/cpuinfo-aarch64.c
+++ b/util/cpuinfo-aarch64.c
@@ -1,5 +1,5 @@
 /*
  * SPDX-License-Identifier: GPL-2.0-or-later
- * Host specific cpu indentification for AArch64.
+ * Host specific cpu identification for AArch64.
  */
 
@@ -34,5 +34,5 @@ static bool sysctl_for_bool(const char *name)
      * We might in the future ask for properties not present in older kernels,
      * but we're only asking about static properties, all of which should be
-     * 'int'.  So we shouln't see ENOMEM (val too small), or any of the other
+     * 'int'.  So we shouldn't see ENOMEM (val too small), or any of the other
      * more exotic errors.
      */
diff --git a/util/cpuinfo-i386.c b/util/cpuinfo-i386.c
index 3a7b7e0ad1..b2ed65bb10 100644
--- a/util/cpuinfo-i386.c
+++ b/util/cpuinfo-i386.c
@@ -1,5 +1,5 @@
 /*
  * SPDX-License-Identifier: GPL-2.0-or-later
- * Host specific cpu indentification for x86.
+ * Host specific cpu identification for x86.
  */
 
@@ -75,5 +75,5 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
                  *
                  * AMD has provided an even stronger guarantee that processors
-                 * with AVX provide 16-byte atomicity for all cachable,
+                 * with AVX provide 16-byte atomicity for all cacheable,
                  * naturally aligned single loads and stores, e.g. MOVDQU.
                  *
diff --git a/util/cpuinfo-ppc.c b/util/cpuinfo-ppc.c
index 7212afa45d..1ea3db0ac8 100644
--- a/util/cpuinfo-ppc.c
+++ b/util/cpuinfo-ppc.c
@@ -1,5 +1,5 @@
 /*
  * SPDX-License-Identifier: GPL-2.0-or-later
- * Host specific cpu indentification for ppc.
+ * Host specific cpu identification for ppc.
  */
 
diff --git a/util/main-loop.c b/util/main-loop.c
index 014c795916..797b640c41 100644
--- a/util/main-loop.c
+++ b/util/main-loop.c
@@ -48,5 +48,5 @@
 /*
  * Disable CFI checks.
- * We are going to call a signal hander directly. Such handler may or may not
+ * We are going to call a signal handler directly. Such handler may or may not
  * have been defined in our binary, so there's no guarantee that the pointer
  * used to set the handler is a cfi-valid pointer. Since the handlers are
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 760390b31e..4d583da7ce 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -672,5 +672,5 @@ void qemu_free_stack(void *stack, size_t sz)
 /*
  * Disable CFI checks.
- * We are going to call a signal hander directly. Such handler may or may not
+ * We are going to call a signal handler directly. Such handler may or may not
  * have been defined in our binary, so there's no guarantee that the pointer
  * used to set the handler is a cfi-valid pointer. Since the handlers are
diff --git a/util/qdist.c b/util/qdist.c
index 5f75e24c29..ef3566b03a 100644
--- a/util/qdist.c
+++ b/util/qdist.c
@@ -211,5 +211,5 @@ void qdist_bin__internal(struct qdist *to, const struct qdist *from, size_t n)
         /*
          * To avoid double-counting we capture [left, right) ranges, except for
-         * the righmost bin, which captures a [left, right] range.
+         * the rightmost bin, which captures a [left, right] range.
          */
         while (j < from->n && (from->entries[j].x < right || i == n - 1)) {
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 892d33f5e6..83e84b1186 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -930,5 +930,5 @@ static int unix_listen_saddr(UnixSocketAddress *saddr,
     if (pathbuf != NULL) {
         /*
-         * This dummy fd usage silences the mktemp() unsecure warning.
+         * This dummy fd usage silences the mktemp() insecure warning.
          * Using mkstemp() doesn't make things more secure here
          * though.  bind() complains about existing files, so we have
diff --git a/util/rcu.c b/util/rcu.c
index 30a7e22026..e587bcc483 100644
--- a/util/rcu.c
+++ b/util/rcu.c
@@ -356,5 +356,5 @@ void drain_call_rcu(void)
      * Note that since we have only one global queue of the RCU callbacks,
      * we also end up waiting for most of RCU callbacks that were registered
-     * on the other threads, but this is a side effect that shoudn't be
+     * on the other threads, but this is a side effect that shouldn't be
      * assumed.
      */
-- 
2.39.2


