Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 952A27DF903
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 18:42:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qybfR-0003sr-Rw; Thu, 02 Nov 2023 13:39:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qybei-0003HA-Qn
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:39:00 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qybef-0002sH-Aq
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:38:56 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-32f7c80ab33so705278f8f.0
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 10:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698946731; x=1699551531; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Xl1Sssr8bZ1VD/O15KLMZF+fxbdudckI1BnKAqrNXHo=;
 b=xDf7vfIJb7ZnpOKxmogljLKIVc8qzg+qUNXpkuZQaEpkr+yt0x7439G6vk1sjN03c/
 OvZ73XeBj4Cpa5DOyh4pdvHfg+lCxOm2hlmQFp9DoPXIfIM+SsrChWoyYQN7jsZba/S9
 ufAw+NU3vCydP+RTdrY585oaEmP4ugsOXCL8SLmTJzAbUJUHzTtrItk0aA4jUtfo+8a1
 SIwLeh3CAWDTrzIKhP4593W24r6xTSZUbPKbvN3HdjXUDU9B2DDJ4d0kisSYKVZ/sm7g
 LSR3Ln71LNAIRoKaaZMk2WEVy1xHyms0AxNtAC5hbxPg30yKle+tm1REyQ03MCCnA2G8
 7fWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698946731; x=1699551531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xl1Sssr8bZ1VD/O15KLMZF+fxbdudckI1BnKAqrNXHo=;
 b=YYtQX9c/AqDFVWjV+RITwdhWmzpNZEOaWbOEREFWwnYPaVohDa6+HAmI8oW4UR0LHw
 4yOqPp9RGmvMUqhKE7pOXAMCX8Ga8dMZ+jYH2sp4EVoh/5ikEk1nGqsE+cgrtMNK1bCX
 bTPbpQ2jiBGU3tiCfdt2D0CucoEYKb6KURsDufqI3nBtATuEug6+O4QKUmySneziAtz7
 CBU7ZGLsuKBdTNvCCwOxcAFi58FWpy30ER9Nyp5QZOGNQUlZXk5rRE1N3WCiwuCnpVlk
 fPz+QJ/swbvJKASz1ZO7by4HOSDwiE+zY7y4DRVkLneRyWnOZ1yoBwxXhmIRurzm4T0F
 8N7Q==
X-Gm-Message-State: AOJu0YwAlh8x1C643r1jKaA0wvh5KRq9AsgqU7fC58ZY/9gOxwG7aDKf
 b4NAE4f0iyWuo0c6qmRsrDDjNzYTNpG9kwt4Ug4=
X-Google-Smtp-Source: AGHT+IEQLoEkfecKWfM1GPXGggvL/xYcxeDe0/sT02q9m9J53c8suzwoF1CJIYgbhpXC7VpBn76B4Q==
X-Received: by 2002:adf:f605:0:b0:32d:89b5:7fd9 with SMTP id
 t5-20020adff605000000b0032d89b57fd9mr14318080wrp.56.1698946730889; 
 Thu, 02 Nov 2023 10:38:50 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e16-20020adff350000000b003258934a4bcsm3046805wrp.42.2023.11.02.10.38.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 10:38:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/33] target/arm: Fix SVE STR increment
Date: Thu,  2 Nov 2023 17:38:28 +0000
Message-Id: <20231102173835.609985-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102173835.609985-1-peter.maydell@linaro.org>
References: <20231102173835.609985-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
---
 target/arm/tcg/translate-sve.c    |  5 ++--
 tests/tcg/aarch64/sve-str.c       | 49 +++++++++++++++++++++++++++++++
 tests/tcg/aarch64/Makefile.target |  6 +++-
 3 files changed, 57 insertions(+), 3 deletions(-)
 create mode 100644 tests/tcg/aarch64/sve-str.c

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 7b39962f209..296e7d1ce22 100644
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
index 00000000000..ae271c9d87e
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
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 0c84b61ae0e..cded1d01fcd 100644
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


