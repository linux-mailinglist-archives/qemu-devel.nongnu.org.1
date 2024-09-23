Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 856CF97B3EF
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Sep 2024 20:11:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqcdL-0004Ax-3p; Tue, 17 Sep 2024 14:09:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sqcdH-00043Y-PI; Tue, 17 Sep 2024 14:08:59 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sqcdF-0002NB-TZ; Tue, 17 Sep 2024 14:08:59 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8CE388FBC3;
 Tue, 17 Sep 2024 21:08:26 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1579D13E745;
 Tue, 17 Sep 2024 21:08:42 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Tiago Pasqualini <tiago.pasqualini@canonical.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.14 43/47] crypto: run qcrypto_pbkdf2_count_iters in a new
 thread
Date: Tue, 17 Sep 2024 21:08:32 +0300
Message-Id: <20240917180836.633380-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-7.2.14-20240917210634@cover.tls.msk.ru>
References: <qemu-stable-7.2.14-20240917210634@cover.tls.msk.ru>
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

From: Tiago Pasqualini <tiago.pasqualini@canonical.com>

CPU time accounting in the kernel has been demonstrated to have a
sawtooth pattern[1][2]. This can cause the getrusage system call to
not be as accurate as we are expecting, which can cause this calculation
to stall.

The kernel discussions shows that this inaccuracy happens when CPU time
gets big enough, so this patch changes qcrypto_pbkdf2_count_iters to run
in a fresh thread to avoid this inaccuracy. It also adds a sanity check
to fail the process if CPU time is not accounted.

[1] https://lore.kernel.org/lkml/159231011694.16989.16351419333851309713.tip-bot2@tip-bot2/
[2] https://lore.kernel.org/lkml/20221226031010.4079885-1-maxing.lan@bytedance.com/t/#m1c7f2fdc0ea742776a70fd1aa2a2e414c437f534

Resolves: #2398
Signed-off-by: Tiago Pasqualini <tiago.pasqualini@canonical.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
(cherry picked from commit c72cab5ad9f849bbcfcf4be7952b8b8946cc626e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/crypto/pbkdf.c b/crypto/pbkdf.c
index 8d198c152c..d1c06ef3ed 100644
--- a/crypto/pbkdf.c
+++ b/crypto/pbkdf.c
@@ -19,6 +19,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/thread.h"
 #include "qapi/error.h"
 #include "crypto/pbkdf.h"
 #ifndef _WIN32
@@ -85,12 +86,28 @@ static int qcrypto_pbkdf2_get_thread_cpu(unsigned long long *val_ms,
 #endif
 }
 
-uint64_t qcrypto_pbkdf2_count_iters(QCryptoHashAlgorithm hash,
-                                    const uint8_t *key, size_t nkey,
-                                    const uint8_t *salt, size_t nsalt,
-                                    size_t nout,
-                                    Error **errp)
+typedef struct CountItersData {
+    QCryptoHashAlgorithm hash;
+    const uint8_t *key;
+    size_t nkey;
+    const uint8_t *salt;
+    size_t nsalt;
+    size_t nout;
+    uint64_t iterations;
+    Error **errp;
+} CountItersData;
+
+static void *threaded_qcrypto_pbkdf2_count_iters(void *data)
 {
+    CountItersData *iters_data = (CountItersData *) data;
+    QCryptoHashAlgorithm hash = iters_data->hash;
+    const uint8_t *key = iters_data->key;
+    size_t nkey = iters_data->nkey;
+    const uint8_t *salt = iters_data->salt;
+    size_t nsalt = iters_data->nsalt;
+    size_t nout = iters_data->nout;
+    Error **errp = iters_data->errp;
+
     uint64_t ret = -1;
     g_autofree uint8_t *out = g_new(uint8_t, nout);
     uint64_t iterations = (1 << 15);
@@ -114,7 +131,10 @@ uint64_t qcrypto_pbkdf2_count_iters(QCryptoHashAlgorithm hash,
 
         delta_ms = end_ms - start_ms;
 
-        if (delta_ms > 500) {
+        if (delta_ms == 0) { /* sanity check */
+            error_setg(errp, "Unable to get accurate CPU usage");
+            goto cleanup;
+        } else if (delta_ms > 500) {
             break;
         } else if (delta_ms < 100) {
             iterations = iterations * 10;
@@ -129,5 +149,24 @@ uint64_t qcrypto_pbkdf2_count_iters(QCryptoHashAlgorithm hash,
 
  cleanup:
     memset(out, 0, nout);
-    return ret;
+    iters_data->iterations = ret;
+    return NULL;
+}
+
+uint64_t qcrypto_pbkdf2_count_iters(QCryptoHashAlgorithm hash,
+                                    const uint8_t *key, size_t nkey,
+                                    const uint8_t *salt, size_t nsalt,
+                                    size_t nout,
+                                    Error **errp)
+{
+    CountItersData data = {
+        hash, key, nkey, salt, nsalt, nout, 0, errp
+    };
+    QemuThread thread;
+
+    qemu_thread_create(&thread, "pbkdf2", threaded_qcrypto_pbkdf2_count_iters,
+                       &data, QEMU_THREAD_JOINABLE);
+    qemu_thread_join(&thread);
+
+    return data.iterations;
 }
-- 
2.39.5


