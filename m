Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F73378853D
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 12:49:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZUM7-0006C2-GK; Fri, 25 Aug 2023 06:47:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qZUM6-0006Br-HQ
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 06:47:54 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qZUM4-0001hp-3k
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 06:47:54 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1bc8a2f71eeso6368825ad.0
 for <qemu-devel@nongnu.org>; Fri, 25 Aug 2023 03:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692960471; x=1693565271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+GKPqPE+H3vingc7mI64AgZ1OIf0jhDwNiBtd43MLQU=;
 b=YFoscCK8uJPOHvVC2IYTepmnuViUcUcMoASWQY6qZ7SkkWQ1QJRox3TAEtIU2b4TSb
 As0wyRlXGg4E0SuNwfAN7tbXsnumwOkPkNXAe6Q1T+fHfcEM1xBKkJ72Weeje5bKJE04
 LCUNPE1xndehcFdlnWltwL7hfmKQYV5z5Z+94IoZ6PeSaA4bHBQNE1SINe5Q24qOY0ku
 vMXIOySqE1LJepgYNEXmPXavDeAB2wiBjjYpS8NIJdaju5fJ/pIQgQklXxGzjxJrCW3e
 V/YG5zk4GiHVwIvCsgGLH/aPX7P0H6aiJ8p1jk0yTcojMj8Iob3xNyw/gGwm9Pfa2tVT
 4KYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692960471; x=1693565271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+GKPqPE+H3vingc7mI64AgZ1OIf0jhDwNiBtd43MLQU=;
 b=VpI0AW0PYLkEAR6QPXTgDfSYUSdNrZnYoE5/S0WLyau6JifeWPyUzpKwABDjnpZR/s
 hk2sEFcpPSQFaOc2IW2WdKIxul19/NZ6cZ9qBFqCdwXVoR8N2OQK3SIXM4GvbB8O2rvh
 ONrmYx5Mj5TymCk1zkw4T9aqO5rVOvMAYol2Q5B8jYD4PJ3pdxw0HjDuTzx6GiYZ/1x5
 Ulw6pq7jqswvMCYzWsNbjdqcFrDVXX7vcfQBrPXh8i5nSYzxBO5jEMKeFCHmlrvBRLT+
 ZDaJnr9anyDcA8Z1R/7l7DXeRCge0t76seRxh36za21LZ8JeoV/fdcCC1OBGTadqWys7
 MhdA==
X-Gm-Message-State: AOJu0YyMaaBa48ST2e2MalLWsPCjaJAmuBGxTYNznlv1x+p9dTJzAHY0
 6FIvK+rbn+4lhBuSeBDDWig=
X-Google-Smtp-Source: AGHT+IGIn/3alV3NQer3rukiqW+rM36cI6MhsnLx4YEWEl7FH22pZa5BMy7T725Om5MEimdJEnYKfA==
X-Received: by 2002:a17:902:ec83:b0:1c0:d17a:bfe9 with SMTP id
 x3-20020a170902ec8300b001c0d17abfe9mr3603505plg.46.1692960470711; 
 Fri, 25 Aug 2023 03:47:50 -0700 (PDT)
Received: from localhost.localdomain ([223.104.40.15])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a170902ce8500b001b89891bfc4sm1346985plg.199.2023.08.25.03.47.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Aug 2023 03:47:50 -0700 (PDT)
From: Yeqi Fu <fufuyqqqqqq@gmail.com>
To: alex.bennee@linaro.org
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Yeqi Fu <fufuyqqqqqq@gmail.com>
Subject: [RFC v5 09/10] tests/tcg/multiarch: Add nativecall.c test
Date: Fri, 25 Aug 2023 18:45:25 +0800
Message-Id: <20230825104526.1754950-10-fufuyqqqqqq@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230825104526.1754950-6-fufuyqqqqqq@gmail.com>
References: <20230825104526.1754950-6-fufuyqqqqqq@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=fufuyqqqqqq@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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

Introduce a new test for native calls to ensure their functionality.
The process involves cross-compiling the test cases, building them
as dynamically linked binaries, and running these binaries which
necessitates the addition of the appropriate interpreter prefix.

Signed-off-by: Yeqi Fu <fufuyqqqqqq@gmail.com>
---
 tests/tcg/multiarch/Makefile.target     |  30 ++++++
 tests/tcg/multiarch/native/nativecall.c | 121 ++++++++++++++++++++++++
 2 files changed, 151 insertions(+)
 create mode 100644 tests/tcg/multiarch/native/nativecall.c

diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index 43bddeaf21..4a8d65435b 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -12,7 +12,9 @@ VPATH 	       += $(MULTIARCH_SRC)
 MULTIARCH_SRCS =  $(notdir $(wildcard $(MULTIARCH_SRC)/*.c))
 ifeq ($(filter %-linux-user, $(TARGET)),$(TARGET))
 VPATH 	       += $(MULTIARCH_SRC)/linux
+VPATH          += $(MULTIARCH_SRC)/native
 MULTIARCH_SRCS += $(notdir $(wildcard $(MULTIARCH_SRC)/linux/*.c))
+MULTIARCH_SRCS += $(notdir $(wildcard $(MULTIARCH_SRC)/native/*.c))
 endif
 MULTIARCH_TESTS = $(MULTIARCH_SRCS:.c=)
 
@@ -138,5 +140,33 @@ run-plugin-semiconsole-with-%:
 TESTS += semihosting semiconsole
 endif
 
+nativecall: nativecall.c
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(filter-out -static,$(LDFLAGS))
+
+ifneq ($(LD_PREFIX),)
+ifneq ($(LIBNATIVE),)
+run-nativecall: nativecall
+	$(call run-test, $<, $(QEMU) -L $(LD_PREFIX) \
+		--native-bypass $(LIBNATIVE) $<, "nativecall")
+
+run-plugin-nativecall-with-%:
+	$(call run-test, $@, $(QEMU) $(QEMU_OPTS) \
+		-L $(LD_PREFIX) --native-bypass $(LIBNATIVE) \
+		-plugin $(PLUGIN_LIB)/$(call extract-plugin,$@)$(PLUGIN_ARGS) \
+		 $(call strip-plugin,$<) 2> $<.err, \
+		 $< with $*)
+else
+run-nativecall: nativecall
+	$(call skip-test, $<, "no native library found")
+run-plugin-nativecall-with-%:
+	$(call skip-test, $<, "no native library found")
+endif
+else
+run-nativecall: nativecall
+	$(call skip-test, $<, "no elf interpreter prefix found")
+run-plugin-nativecall-with-%:
+	$(call skip-test, $<, "no elf interpreter prefix found")
+endif
+
 # Update TESTS
 TESTS += $(MULTIARCH_TESTS)
diff --git a/tests/tcg/multiarch/native/nativecall.c b/tests/tcg/multiarch/native/nativecall.c
new file mode 100644
index 0000000000..15dbd5d937
--- /dev/null
+++ b/tests/tcg/multiarch/native/nativecall.c
@@ -0,0 +1,121 @@
+#include <assert.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <unistd.h>
+
+void compare_memory(const void *a, const void *b, size_t n)
+{
+    const unsigned char *p1 = a;
+    const unsigned char *p2 = b;
+    for (size_t i = 0; i < n; i++) {
+        assert(p1[i] == p2[i]);
+    }
+}
+
+void test_memcpy(char *src)
+{
+    char dest[2000];
+    memcpy(dest, src, 2000);
+    compare_memory(dest, src, 2000);
+}
+
+void test_strncpy(char *src)
+{
+    char dest[2000];
+    strncpy(dest, src, 2000);
+    compare_memory(dest, src, 2000);
+}
+
+void test_strcpy(char *src)
+{
+    char dest[2000];
+    strcpy(dest, src);
+    compare_memory(dest, src, 2000);
+}
+
+void test_strcat()
+{
+    char src[20] = "Hello, ";
+    char dest[] = "world!";
+    char str[] = "Hello, world!";
+    strcat(src, dest);
+    compare_memory(src, str, 13);
+}
+
+void test_memcmp(char *str1, char *str2, char *str3)
+{
+    int result1 = memcmp(str1, str2, 3);
+    int result2 = memcmp(str1, str3, 3);
+    int result3 = memcmp(str3, str1, 3);
+    assert(result1 == 0);
+    assert(result2 < 0);
+    assert(result3 > 0);
+}
+
+void test_strncmp(char *str1, char *str2, char *str3)
+{
+    int result1 = strncmp(str1, str2, 3);
+    int result2 = strncmp(str1, str3, 3);
+    int result3 = strncmp(str3, str1, 3);
+    assert(result1 == 0);
+    assert(result2 < 0);
+    assert(result3 > 0);
+}
+
+void test_strcmp(char *str1, char *str2, char *str3)
+{
+    int result1 = strcmp(str1, str2);
+    int result2 = strcmp(str1, str3);
+    int result3 = strcmp(str3, str1);
+    assert(result1 == 0);
+    assert(result2 < 0);
+    assert(result3 > 0);
+}
+
+void test_memset()
+{
+    char buffer[2000];
+    memset(buffer, 'A', 2000);
+    for (int i = 0; i < 2000; i++) {
+        assert(buffer[i] == 'A');
+    }
+}
+
+/*
+ * When executing execv, an error may occur stating that the shared library from
+ * LD_PRELOAD cannot be preloaded.
+ */
+void test_execv(const char *cmd)
+{
+    char *argv[4];
+    argv[0] = (char *)"/bin/sh";
+    argv[1] = (char *)"-c";
+    argv[2] = (char *)cmd;
+    argv[3] = NULL;
+    execv("/bin/sh", argv);
+}
+
+int main()
+{
+    char buf[2000];
+    for (int i = 0; i < 2000; i++) {
+        buf[i] = 'A' + (i % 26);
+    }
+    char str1[] = "abc";
+    char str2[] = "abc";
+    char str3[] = "def";
+
+    test_memcpy(buf);
+    test_strncpy(buf);
+    test_strcpy(buf);
+    test_memcmp(str1, str2, str3);
+    test_strncmp(str1, str2, str3);
+    test_strcmp(str1, str2, str3);
+    test_strcat();
+    test_memset();
+    test_execv("echo 111");
+
+    return EXIT_SUCCESS;
+}
-- 
2.34.1


