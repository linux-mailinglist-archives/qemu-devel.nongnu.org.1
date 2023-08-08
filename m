Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5DD773AB1
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 16:21:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTNYt-0001L4-D8; Tue, 08 Aug 2023 10:19:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qTNYq-0001Kq-BT
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 10:19:48 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qTNYo-0000Ra-Od
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 10:19:48 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-686b9920362so3840039b3a.1
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 07:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691504385; x=1692109185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m8X/U9yzOHTgapxb29qT1DD+OGFIOVrJO+35tPcxDbA=;
 b=I5agK3QEuKQfPbj+FQUfwL/8aXrTvksdCC8ZFKbp/BiN2cUAQrdu8yMv/Uf7KYmFF8
 153F1UJoM0WlVtXIxSpy0pjDXvIOQCh861ulwEApT/qjH8Jm4c5A6ET/tXm7VyS1cg7Y
 V6qysRx/Oe5fMxo4AST/MmJyqDuT1z+EscHrBz9eUiWC65LZ+OdGwpoH+fVo8pDEXQxh
 UF/qaAJSIV+Tp/XvOaun3SQzcQ7kauC87Ca5IIAnqrllJ1i1CITxUbO8OW4uSO/vkx2Q
 b4mPg5jjoQWr23KUN1Ww8cNJmzF+dritk/O1DBmoIjrzeg7Lxh1Gx9Plt7q4b7kC+CHR
 X5gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691504385; x=1692109185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m8X/U9yzOHTgapxb29qT1DD+OGFIOVrJO+35tPcxDbA=;
 b=DqQI+iX9YlUZ9iH/JH6rH/36Y5qoAKFf8TJ5lecFZ+m2uAnCYCc5ihui8EKKwhEAxZ
 V+tZ4Kyx/uu+1Uyof+MabjCw8QzH6imqm0cI8wYKnz9vmcuBlU89r+SftHlcz4hBmGqO
 drlDL5h+0DTV0Q0n4BlQx+qI83ORDmHAEghWV07Sxw6O0c+wS+NfLr0oUdPmOtohuMW2
 Wp2tpmEBW4+dlrMAWYaGXSY1IUrWmOmcO3zFEHCfNg5h3hkT5m1M4A67kgoknOScbue/
 T2pAPHDEVuZ5BT0J+Wtn3FF27BlIrhOInaAlJZbJlydndMNDletxBXCOvDKBSk33AK+o
 bSeg==
X-Gm-Message-State: AOJu0YwxAGXFSvrlge5TzxmGFrhHc52bwk4EXg94FOV+esYYcgmDoRDe
 pqXe3mr4rhueRShdx7VbeycJ/55Kn7WSdmQh
X-Google-Smtp-Source: AGHT+IHzOb8xgzfgVfLYwcVU7QCXQHtRSutc7oT5xEBTMGYjXZTIjUk6HTNizNNdvC3NTXxRXI/o/A==
X-Received: by 2002:a17:903:2281:b0:1bb:c5b5:8353 with SMTP id
 b1-20020a170903228100b001bbc5b58353mr11652023plh.4.1691504385506; 
 Tue, 08 Aug 2023 07:19:45 -0700 (PDT)
Received: from localhost.localdomain ([223.104.41.22])
 by smtp.gmail.com with ESMTPSA id
 c3-20020a170902b68300b001bb1f0605b2sm9043985pls.214.2023.08.08.07.19.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 07:19:45 -0700 (PDT)
From: Yeqi Fu <fufuyqqqqqq@gmail.com>
To: alex.bennee@linaro.org
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Yeqi Fu <fufuyqqqqqq@gmail.com>
Subject: [RFC v4 10/11] tests/tcg/multiarch: Add nativecall.c test
Date: Tue,  8 Aug 2023 22:17:38 +0800
Message-Id: <20230808141739.3110740-11-fufuyqqqqqq@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808141739.3110740-1-fufuyqqqqqq@gmail.com>
References: <20230808141739.3110740-1-fufuyqqqqqq@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=fufuyqqqqqq@gmail.com; helo=mail-pf1-x434.google.com
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
 tests/tcg/multiarch/Makefile.target     | 17 +++++
 tests/tcg/multiarch/native/nativecall.c | 98 +++++++++++++++++++++++++
 2 files changed, 115 insertions(+)
 create mode 100644 tests/tcg/multiarch/native/nativecall.c

diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index 43bddeaf21..5231df34ba 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -138,5 +138,22 @@ run-plugin-semiconsole-with-%:
 TESTS += semihosting semiconsole
 endif
 
+nativecall: native/nativecall.c
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(filter-out -static,$(LDFLAGS))
+
+ifneq ($(LD_PREFIX),)
+ifneq ($(wildcard $(LIBNATIVE)),)
+run-nativecall: nativecall
+	$(call run-test,$<, $(QEMU) -L $(LD_PREFIX) --native-bypass $(LIBNATIVE) $<, "nativecall")
+else
+run-nativecall: nativecall
+	$(call skip-test, $<, "no native library found")
+endif
+else
+run-nativecall: nativecall
+	$(call skip-test, $<, "no elf interpreter prefix found")
+endif
+EXTRA_RUNS += run-nativecall
+
 # Update TESTS
 TESTS += $(MULTIARCH_TESTS)
diff --git a/tests/tcg/multiarch/native/nativecall.c b/tests/tcg/multiarch/native/nativecall.c
new file mode 100644
index 0000000000..d3f6f49ed0
--- /dev/null
+++ b/tests/tcg/multiarch/native/nativecall.c
@@ -0,0 +1,98 @@
+#include <assert.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/mman.h>
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
+void test_memcpy()
+{
+    char src[] = "Hello, world!";
+    char dest[20];
+    memcpy(dest, src, 13);
+    compare_memory(dest, src, 13);
+}
+
+void test_strncpy()
+{
+    char src[] = "Hello, world!";
+    char dest[20];
+    strncpy(dest, src, 13);
+    compare_memory(dest, src, 13);
+}
+
+void test_strcpy()
+{
+    char src[] = "Hello, world!";
+    char dest[20];
+    strcpy(dest, src);
+    compare_memory(dest, src, 13);
+}
+
+void test_strcat()
+{
+    char src[20] = "Hello, ";
+    char dst[] = "world!";
+    char str[] = "Hello, world!";
+    strcat(src, dest);
+    compare_memory(src, str, 13);
+}
+
+void test_memcmp()
+{
+    char str1[] = "abc";
+    char str2[] = "abc";
+    char str3[] = "def";
+    assert(memcmp(str1, str2, 3) == 0);
+    assert(memcmp(str1, str3, 3) != 0);
+}
+
+void test_strncmp()
+{
+    char str1[] = "abc";
+    char str2[] = "abc";
+    char str3[] = "def";
+    assert(strncmp(str1, str2, 2) == 0);
+    assert(strncmp(str1, str3, 2) != 0);
+}
+
+void test_strcmp()
+{
+    char str1[] = "abc";
+    char str2[] = "abc";
+    char str3[] = "def";
+    assert(strcmp(str1, str2) == 0);
+    assert(strcmp(str1, str3) != 0);
+}
+
+void test_memset()
+{
+    char buffer[10];
+    memset(buffer, 'A', 10);
+    int i;
+    for (i = 0; i < 10; i++) {
+        assert(buffer[i] == 'A');
+    }
+}
+
+int main()
+{
+    test_memset();
+    test_memcpy();
+    test_strncpy();
+    test_memcmp();
+    test_strncmp();
+    test_strcpy();
+    test_strcmp();
+    test_strcat();
+
+    return EXIT_SUCCESS;
+}
-- 
2.34.1


