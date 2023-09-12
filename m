Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BB879DAD3
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 23:29:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgAx0-0000q6-Gx; Tue, 12 Sep 2023 17:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qgAwv-0000eJ-IR
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 17:29:34 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qgAwt-0007YA-1N
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 17:29:33 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-68fac346f6aso2976392b3a.3
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 14:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694554169; x=1695158969; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7HtD+OYfMKelkMTMTh4WfcoKEIkozBhy7qg4sRQ8vPQ=;
 b=EgX70aQjPh1J4XAuJgKL2LNlX7/42+viQflGVkznpQZpj1cyDzy2AG5jNhfH8poabU
 P+RHf6hlY413GX2b5OlBZSTjrxYzpFaUWYohuN9BFXQfKWTqeT5DDQ3fjk4fAflQRPL8
 YTvqr7LEvLRm+GG1ElaFNnxy6dexkqNopWavCvHx4IS5rhbaD6FXKQbh/SZErsD1ln+1
 9/m9BXtg7fpwAWaEBoN+PPjVmIwPxcWPKNjd0Zev+/rnUN+s8f8SGNVDF8iUY2TLTKNI
 dJaT833p06YtfHuwsLANNZZTpM+0PxykrRp9jxJg4szC/J2YagDoEqCxHTxBW13B1ARb
 OBXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694554169; x=1695158969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7HtD+OYfMKelkMTMTh4WfcoKEIkozBhy7qg4sRQ8vPQ=;
 b=NRP9aC3vTqeV5NIRLBnZc+bv0EBpTR1+7Nwoyc/cVtruRSiyE3/BFaHb7RzRVDI9Nb
 rQJmjSLrQcw/TwFKI4jCs/3RJ4pa64bXHYIsfguApXqw0+a+ru2k75eX4hOsrNoiI0ZG
 p79WP2WbU0h+d4NDpebhOfQVSiyZb8AEd19xfGADjlaD+qoD2xEdHBaIAFuj1GOup14c
 EmKC9wurh0IH2y6DBSvtbgfKavx2jD3F7Qo877DOd4Rn6vRY3SpisoUnRi8M17SIiICW
 L5rkn8+QSuMZa4/mwy9CXmM9nboObliwbtLL28NZFhKC4fjrejUd2wJTcCQhoXNnOcy5
 sCPg==
X-Gm-Message-State: AOJu0YwgU/RUDGVXJmSSGI/D6zDZ73VbpeI0q2Vz090szmnbIZeHcteq
 FOgc5WoOoYssb3QpaGmDe/c=
X-Google-Smtp-Source: AGHT+IFYKr01X4Yk7VsGlHcdI1Gtj0S1sJlmfQkvJU1ODOLCSUIe9pBbWvvJMbC0AgiRlxij/x/uMQ==
X-Received: by 2002:a05:6a00:1891:b0:68f:cd71:45d5 with SMTP id
 x17-20020a056a00189100b0068fcd7145d5mr1268758pfh.3.1694554169506; 
 Tue, 12 Sep 2023 14:29:29 -0700 (PDT)
Received: from q1iq-virtual-machine.. ([114.249.236.97])
 by smtp.gmail.com with ESMTPSA id
 u20-20020aa78394000000b0068be4ce33easm7930436pfm.96.2023.09.12.14.29.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 14:29:29 -0700 (PDT)
From: Yeqi Fu <fufuyqqqqqq@gmail.com>
To: alex.bennee@linaro.org
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Yeqi Fu <fufuyqqqqqq@gmail.com>
Subject: [RFC v6 8/9] tests/tcg/multiarch: Add nativecall.c test
Date: Wed, 13 Sep 2023 05:28:41 +0800
Message-Id: <20230912212842.658374-9-fufuyqqqqqq@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912212842.658374-1-fufuyqqqqqq@gmail.com>
References: <20230912212842.658374-1-fufuyqqqqqq@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=fufuyqqqqqq@gmail.com; helo=mail-pf1-x436.google.com
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
 tests/tcg/multiarch/Makefile.target     |  32 ++++++
 tests/tcg/multiarch/native/nativecall.c | 132 ++++++++++++++++++++++++
 2 files changed, 164 insertions(+)
 create mode 100644 tests/tcg/multiarch/native/nativecall.c

diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index 43bddeaf21..8bad8ac0d5 100644
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
 
@@ -138,5 +140,35 @@ run-plugin-semiconsole-with-%:
 TESTS += semihosting semiconsole
 endif
 
+nativecall: LDFLAGS+=-ldl
+nativecall: CFLAGS+=-D_GNU_SOURCE -fPIE
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
index 0000000000..de18718c61
--- /dev/null
+++ b/tests/tcg/multiarch/native/nativecall.c
@@ -0,0 +1,132 @@
+#include <assert.h>
+#include <dlfcn.h>
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
+    char src[30] = "Hello, ";
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
+void test_memset(char *buffer)
+{
+    memset(buffer, 'A', 2000 - 1);
+    for (int i = 0; i < 2000 - 1; i++) {
+        assert(buffer[i] == 'A');
+    }
+}
+
+void test_libnative()
+{
+    Dl_info info;
+    void *memcpy_addr = (void *)memcpy;
+    if (dladdr(memcpy_addr, &info) != 0) {
+        assert(strstr(info.dli_fname, "libnative.so") != NULL);
+    }
+}
+
+/*
+ * When executing execv, an error may occur stating that the shared library
+ * cannot be preloaded.
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
+    for (int i = 0; i < 2000 - 1; i++) {
+        buf[i] = 'A' + (i % 26);
+    }
+    buf[2000 - 1] = '\0';
+    char str1[4] = "abc\0";
+    char str2[4] = "abc\0";
+    char str3[4] = "def\0";
+
+    test_memcpy(buf);
+    test_strncpy(buf);
+    test_strcpy(buf);
+    test_memcmp(str1, str2, str3);
+    test_strncmp(str1, str2, str3);
+    test_strcmp(str1, str2, str3);
+    test_strcat();
+    test_memset(buf);
+    test_libnative();
+    test_execv("echo 111");
+
+    return EXIT_SUCCESS;
+}
-- 
2.34.1


