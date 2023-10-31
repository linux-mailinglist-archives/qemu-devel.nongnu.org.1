Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D79F47DCF42
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 15:33:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxpna-0007u5-Nf; Tue, 31 Oct 2023 10:32:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxpnE-0007ld-As
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:32:35 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxpn1-0008C5-WB
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:32:32 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6b709048d8eso5056099b3a.2
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 07:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698762738; x=1699367538; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2CYGRwQkn3vBbegQZVV/vYVzIasu5qHXxrirxpdWc8M=;
 b=YZvFShhCceI3SC6Itlt4rHgOejRuQKSiFiiKZ6gfX7Oe/ChQo0H4MC2m7Ksux+VVa2
 +3cifE1MVr4mGuk79J5tvMJn19HaethCjm/Fg124r9rALJRbBWe2cxZGjWnhK5i5g3sb
 WTwo4E5MXoPQlCIB30T4t8s7aPhEhRXMfCMbCAz2s97Nz/hFNSgM9g0kbYK0PWIv0/L2
 hkZ0+7/5Vw8QYtAsAfQS0qUGoblRWKLSYHuE2KWx+YCYc/pJwL9kTTAWuAzrHUr/hyCs
 lW2XnwHQ+naEttTjUeRnRtAx0/OzzphXc3sRR5GqIXgt89OfgBNW+DhQ3xa6SNP2Bvlp
 TzJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698762738; x=1699367538;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2CYGRwQkn3vBbegQZVV/vYVzIasu5qHXxrirxpdWc8M=;
 b=WFTNHH0Sa4Gs9ifOl7u8bjQRcwPJb2J43QmcHmhqakrvUwW0nK01jPA+/lI+PpgP58
 KhSxb55ejx/U0laxjr8JYnTPQOdo5kQwo2kityLGTl2YchV/Tg8Su32plunjE9lg7jeS
 OZzZzOnRTgOcjHOe8tlL5TQkZKh/JEib5CcwAMO2nIn+NK7mhfXa3gUgH7TMRE+wKmgt
 aAi7vCW66j6ZYKnYzRXO5RMM7I7BDWIGY67CkWp50XS5v89dsw4V+RZ6GZ61RFGmKj6t
 Gf9fI08Q8EV0Bf/ilwEQ5Ajpi/vJFpLWQW9tf+iZpQJ6JBJjFLKq5hkQyS9I74XZJmGQ
 XEAg==
X-Gm-Message-State: AOJu0YxoV2ftZ+XiDjwRCqayHdMIkry4ZEhR6+ZLt6qm+9majHQAL3yz
 6Jd7Q4e9mx/R+UhabkPPI7by3CPfsbWphhtDOkQ=
X-Google-Smtp-Source: AGHT+IHHwNf2G5J8S5Tr/Dy60jOB7AdDwWZzhC+XbdsFc0IgmbFwg/ObHYYw70c2iI0GPnI2swOhVg==
X-Received: by 2002:a05:6a00:1a93:b0:6b6:7a04:6f9 with SMTP id
 e19-20020a056a001a9300b006b67a0406f9mr11771745pfv.28.1698762737685; 
 Tue, 31 Oct 2023 07:32:17 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 e19-20020a056a001a9300b006be484e5b9asm1321847pfv.188.2023.10.31.07.32.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 07:32:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-stable@nongnu.org
Subject: [PATCH v2] target/arm: Fix SVE STR increment
Date: Tue, 31 Oct 2023 07:32:15 -0700
Message-Id: <20231031143215.29764-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The previous change missed updating one of the increments and
one of the MemOps.  Add a test case for all vector lengths.

Cc: qemu-stable@nongnu.org
Fixes: e6dd5e782be ("target/arm: Use tcg_gen_qemu_{ld, st}_i128 in gen_sve_{ld, st}r")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sve.c    |  5 ++--
 tests/tcg/aarch64/sve-str.c       | 49 +++++++++++++++++++++++++++++++
 tests/tcg/aarch64/Makefile.target |  6 +++-
 3 files changed, 57 insertions(+), 3 deletions(-)
 create mode 100644 tests/tcg/aarch64/sve-str.c

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 7b39962f20..296e7d1ce2 100644
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
diff --git a/tests/tcg/aarch64/sve-str.c b/tests/tcg/aarch64/sve-str.c
new file mode 100644
index 0000000000..551f0d6f18
--- /dev/null
+++ b/tests/tcg/aarch64/sve-str.c
@@ -0,0 +1,49 @@
+#include <stdio.h>
+#include <sys/prctl.h>
+
+#define N  (256+16)
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
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 62b38c792f..c6542b5f1b 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -103,7 +103,11 @@ sha512-sve: CFLAGS=-O3 -march=armv8.1-a+sve
 sha512-sve: sha512.c
 	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
 
-TESTS += sha512-sve
+sve-str: CFLAGS=-O1 -march=armv8.1-a+sve
+sve-str: sve-str.c
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
+
+TESTS += sha512-sve sve-str
 
 ifneq ($(GDB),)
 GDB_SCRIPT=$(SRC_PATH)/tests/guest-debug/run-test.py
-- 
2.34.1


