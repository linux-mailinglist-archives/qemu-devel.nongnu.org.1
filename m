Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAEE7E6BB8
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 14:54:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r15Lr-0004qt-Bj; Thu, 09 Nov 2023 08:45:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15Lg-0003si-Lg; Thu, 09 Nov 2023 08:45:32 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15Le-0001fN-G9; Thu, 09 Nov 2023 08:45:32 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 25EAA31B11;
 Thu,  9 Nov 2023 16:43:13 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 270DB344B7;
 Thu,  9 Nov 2023 16:43:05 +0300 (MSK)
Received: (nullmailer pid 1461836 invoked by uid 1000);
 Thu, 09 Nov 2023 13:43:02 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [Stable-8.1.3 25/55] target/arm: Fix SVE STR increment
Date: Thu,  9 Nov 2023 16:42:29 +0300
Message-Id: <20231109134300.1461632-25-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.3-20231109164030@cover.tls.msk.ru>
References: <qemu-stable-8.1.3-20231109164030@cover.tls.msk.ru>
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

From: Richard Henderson <richard.henderson@linaro.org>

The previous change missed updating one of the increments and
one of the MemOps.  Add a test case for all vector lengths.

Cc: qemu-stable@nongnu.org
Fixes: e6dd5e782be ("target/arm: Use tcg_gen_qemu_{ld, st}_i128 in gen_sve_{ld, st}r")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20231031143215.29764-1-richard.henderson@linaro.org
[PMM: fixed checkpatch nit]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit b11293c212c2927fcea1befc50dabec9baba4fcc)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: context fix in tests/tcg/aarch64/Makefile.target)
Tested-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 2ba5efadfd..90865d8696 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4294,7 +4294,7 @@ void gen_sve_str(DisasContext *s, TCGv_ptr base, int vofs,
         t0 = tcg_temp_new_i64();
         t1 = tcg_temp_new_i64();
         t16 = tcg_temp_new_i128();
-        for (i = 0; i < len_align; i += 8) {
+        for (i = 0; i < len_align; i += 16) {
             tcg_gen_ld_i64(t0, base, vofs + i);
             tcg_gen_ld_i64(t1, base, vofs + i + 8);
             tcg_gen_concat_i64_i128(t16, t0, t1);
@@ -4320,7 +4320,8 @@ void gen_sve_str(DisasContext *s, TCGv_ptr base, int vofs,
         t16 = tcg_temp_new_i128();
         tcg_gen_concat_i64_i128(t16, t0, t1);
 
-        tcg_gen_qemu_st_i128(t16, clean_addr, midx, MO_LEUQ);
+        tcg_gen_qemu_st_i128(t16, clean_addr, midx,
+                             MO_LE | MO_128 | MO_ATOM_NONE);
         tcg_gen_addi_i64(clean_addr, clean_addr, 16);
 
         tcg_gen_brcondi_ptr(TCG_COND_LTU, i, len_align, loop);
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 49e1ffea93..6c2a6d6206 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -100,7 +100,11 @@ sha512-sve: CFLAGS=-O3 -march=armv8.1-a+sve
 sha512-sve: sha512.c
 	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
 
-TESTS += sha512-sve
+sve-str: CFLAGS=-O1 -march=armv8.1-a+sve
+sve-str: sve-str.c
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
+
+TESTS += sha512-sve sve-str
 endif
 
 ifeq ($(HOST_GDB_SUPPORTS_ARCH),y)
diff --git a/tests/tcg/aarch64/sve-str.c b/tests/tcg/aarch64/sve-str.c
new file mode 100644
index 0000000000..ae271c9d87
--- /dev/null
+++ b/tests/tcg/aarch64/sve-str.c
@@ -0,0 +1,49 @@
+#include <stdio.h>
+#include <sys/prctl.h>
+
+#define N  (256 + 16)
+
+static int __attribute__((noinline)) test(int vl)
+{
+    unsigned char buf[N];
+    int err = 0;
+
+    for (int i = 0; i < N; ++i) {
+        buf[i] = (unsigned char)i;
+    }
+
+    asm volatile (
+        "mov z0.b, #255\n\t"
+        "str z0, %0"
+        : : "m" (buf) : "z0", "memory");
+
+    for (int i = 0; i < vl; ++i) {
+        if (buf[i] != 0xff) {
+            fprintf(stderr, "vl %d, index %d, expected 255, got %d\n",
+                    vl, i, buf[i]);
+            err = 1;
+        }
+    }
+
+    for (int i = vl; i < N; ++i) {
+        if (buf[i] != (unsigned char)i) {
+            fprintf(stderr, "vl %d, index %d, expected %d, got %d\n",
+                    vl, i, (unsigned char)i, buf[i]);
+            err = 1;
+        }
+    }
+
+    return err;
+}
+
+int main()
+{
+    int err = 0;
+
+    for (int i = 16; i <= 256; i += 16) {
+        if (prctl(PR_SVE_SET_VL, i, 0, 0, 0, 0) == i) {
+            err |= test(i);
+        }
+    }
+    return err;
+}
-- 
2.39.2


