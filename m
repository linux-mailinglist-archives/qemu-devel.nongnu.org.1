Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2253E7A7E97
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 14:19:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiwAK-0000Nj-T9; Wed, 20 Sep 2023 08:18:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qiwAI-0000D7-OI; Wed, 20 Sep 2023 08:18:46 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qiwAG-0005px-58; Wed, 20 Sep 2023 08:18:46 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C943823A1D;
 Wed, 20 Sep 2023 15:19:01 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 1335F29704;
 Wed, 20 Sep 2023 15:18:42 +0300 (MSK)
Received: (nullmailer pid 106027 invoked by uid 1000);
 Wed, 20 Sep 2023 12:18:41 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.5 59/70] include/exec: Provide the tswap() functions for
 target independent code, too
Date: Wed, 20 Sep 2023 15:18:36 +0300
Message-Id: <20230920121841.106001-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.5-20230920151433@cover.tls.msk.ru>
References: <qemu-stable-8.0.5-20230920151433@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Thomas Huth <thuth@redhat.com>

In some cases of target independent code, it would be useful to have access
to the functions that swap endianess in case it differs between guest and
host. Thus re-implement the tswapXX() functions in a new header that can be
included separately. The check whether the swapping is needed continues to
be done at compile-time for target specific code, while it is done at
run-time in target-independent code.

Message-Id: <20230411183418.1640500-3-thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit 24be3369ad63c3882be42dd510a45bad52816fd1)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(trivial change needed for the next commit 058096f1c5
 "hw/char/riscv_htif: Fix the console syscall on big endian hosts")

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 090922e4a8..ad824fee52 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -21,6 +21,7 @@
 
 #include "exec/cpu-common.h"
 #include "exec/memory.h"
+#include "exec/tswap.h"
 #include "qemu/thread.h"
 #include "hw/core/cpu.h"
 #include "qemu/rcu.h"
@@ -44,69 +45,6 @@
 #define BSWAP_NEEDED
 #endif
 
-#ifdef BSWAP_NEEDED
-
-static inline uint16_t tswap16(uint16_t s)
-{
-    return bswap16(s);
-}
-
-static inline uint32_t tswap32(uint32_t s)
-{
-    return bswap32(s);
-}
-
-static inline uint64_t tswap64(uint64_t s)
-{
-    return bswap64(s);
-}
-
-static inline void tswap16s(uint16_t *s)
-{
-    *s = bswap16(*s);
-}
-
-static inline void tswap32s(uint32_t *s)
-{
-    *s = bswap32(*s);
-}
-
-static inline void tswap64s(uint64_t *s)
-{
-    *s = bswap64(*s);
-}
-
-#else
-
-static inline uint16_t tswap16(uint16_t s)
-{
-    return s;
-}
-
-static inline uint32_t tswap32(uint32_t s)
-{
-    return s;
-}
-
-static inline uint64_t tswap64(uint64_t s)
-{
-    return s;
-}
-
-static inline void tswap16s(uint16_t *s)
-{
-}
-
-static inline void tswap32s(uint32_t *s)
-{
-}
-
-static inline void tswap64s(uint64_t *s)
-{
-}
-
-#endif
-
 #if TARGET_LONG_SIZE == 4
 #define tswapl(s) tswap32(s)
 #define tswapls(s) tswap32s((uint32_t *)(s))
diff --git a/include/exec/tswap.h b/include/exec/tswap.h
new file mode 100644
index 0000000000..68944a880b
--- /dev/null
+++ b/include/exec/tswap.h
@@ -0,0 +1,72 @@
+/*
+ * Macros for swapping a value if the endianness is different
+ * between the target and the host.
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+
+#ifndef TSWAP_H
+#define TSWAP_H
+
+#include "hw/core/cpu.h"
+#include "qemu/bswap.h"
+
+/*
+ * If we're in target-specific code, we can hard-code the swapping
+ * condition, otherwise we have to do (slower) run-time checks.
+ */
+#ifdef NEED_CPU_H
+#define target_needs_bswap()  (HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN)
+#else
+#define target_needs_bswap()  (target_words_bigendian() != HOST_BIG_ENDIAN)
+#endif
+
+static inline uint16_t tswap16(uint16_t s)
+{
+    if (target_needs_bswap()) {
+        return bswap16(s);
+    } else {
+        return s;
+    }
+}
+
+static inline uint32_t tswap32(uint32_t s)
+{
+    if (target_needs_bswap()) {
+        return bswap32(s);
+    } else {
+        return s;
+    }
+}
+
+static inline uint64_t tswap64(uint64_t s)
+{
+    if (target_needs_bswap()) {
+        return bswap64(s);
+    } else {
+        return s;
+    }
+}
+
+static inline void tswap16s(uint16_t *s)
+{
+    if (target_needs_bswap()) {
+        *s = bswap16(*s);
+    }
+}
+
+static inline void tswap32s(uint32_t *s)
+{
+    if (target_needs_bswap()) {
+        *s = bswap32(*s);
+    }
+}
+
+static inline void tswap64s(uint64_t *s)
+{
+    if (target_needs_bswap()) {
+        *s = bswap64(*s);
+    }
+}
+
+#endif  /* TSWAP_H */
-- 
2.39.2


