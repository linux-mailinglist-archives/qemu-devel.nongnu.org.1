Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CF173D497
	for <lists+qemu-devel@lfdr.de>; Sun, 25 Jun 2023 23:30:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDXGx-0005bZ-O5; Sun, 25 Jun 2023 17:27:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qDXGt-0005aV-IV
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 17:27:47 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qDXGr-0003WH-2j
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 17:27:46 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1b80512a7f2so1702585ad.3
 for <qemu-devel@nongnu.org>; Sun, 25 Jun 2023 14:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687728464; x=1690320464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mnsf664I1dbfqhlUsQXaqr8d9bhL0IvglCtYautfisc=;
 b=QoDA6btioxfXJJ6OXh/uYSeNP6vmRt3dJn47IppYd9IYEDo4zpLzTojTCfdBd/eDl0
 vx/Ey7uDpmNPAcPSfHOkQBI6xZMScxk+6Qwor1c60IrjuPg/w66iQnQejIysY1aNGFuN
 lE2QWmhJ14rg8tyDFem/WyQl3UQKi+71+JHTtGmmi9wEyNRDUwm7ZEneJ0ZVxhDqiKvH
 HKtx5qMkA26N+VpH6stF+1fts7eg/y5kreB4YywWi6k8yhldU6EgHFKqyeXMyJMRS1xr
 2XKg+DlUd+YaN9+GMMaocFN2IbF5CvZ0PpcteIO/IFzkc/wHZ5QOoeDuwlbSngdrYyNc
 5+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687728464; x=1690320464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mnsf664I1dbfqhlUsQXaqr8d9bhL0IvglCtYautfisc=;
 b=Ab+HgNgV7mzloew/1x08H4AUTmrdtOCr/8KuqyNF4snV5GXkT/aoRA1x3MMJhud3E7
 ASnSgFo7IY1o9bINguAcmKUPEyefbK1A57HUFbDH0zqi1+dsF/FG/cPqjtmjygGKA1bD
 ZBpVec2ZLXvN91ic6J/DnCy+j5TNjCSQXOo5Yzvdz+ajn9bwbOGvXt+SkAnhbCSHFTPU
 9FDEjV+RE5LV0bKY94p4yLgI9cBHIeIv0OzNGW19j+Ytc+jsx1FwN+l2pUrzv0oAlbTf
 gAJODGDPZU5+2xEJuWU9KA2E5apot5mk/N/LlZbZEt0VaQE8aVvpVwvdZnKi8s+5v2/w
 40sg==
X-Gm-Message-State: AC+VfDzSqmJ9M8SgbvGEaQ6pcau42xJIKA6snrf8ClQMCu4Yvo+VeB1B
 7LuKFMBuKMUFzWk2qydw1/U=
X-Google-Smtp-Source: ACHHUZ5wIWIyAYRcOrGqAH+eTfsevtq5sK6j+fomue4H+0kuSweLKDEQuSEREP+QRfxd70bhcKfdsg==
X-Received: by 2002:a17:902:d4c7:b0:1b6:9df6:26c2 with SMTP id
 o7-20020a170902d4c700b001b69df626c2mr4094587plg.12.1687728463835; 
 Sun, 25 Jun 2023 14:27:43 -0700 (PDT)
Received: from q1iq-virtual-machine.localdomain ([111.201.135.80])
 by smtp.gmail.com with ESMTPSA id
 je5-20020a170903264500b001b8004ff609sm761343plb.270.2023.06.25.14.27.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jun 2023 14:27:43 -0700 (PDT)
From: Yeqi Fu <fufuyqqqqqq@gmail.com>
To: alex.bennee@linaro.org
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Yeqi Fu <fufuyqqqqqq@gmail.com>
Subject: [RFC v3 10/10] tests/tcg/multiarch: Add nativecalls.c test
Date: Mon, 26 Jun 2023 05:27:07 +0800
Message-Id: <20230625212707.1078951-11-fufuyqqqqqq@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230625212707.1078951-1-fufuyqqqqqq@gmail.com>
References: <20230625212707.1078951-1-fufuyqqqqqq@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=fufuyqqqqqq@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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

Add a test for native calls to verify the functionality of native
functions. This requires cross-compiling test cases and building them
as dynamically linked binaries. Also, introduce necessary system
libraries in QEMU.

Signed-off-by: Yeqi Fu <fufuyqqqqqq@gmail.com>
---
 tests/tcg/multiarch/Makefile.target      |   9 +-
 tests/tcg/multiarch/native/nativecalls.c | 103 +++++++++++++++++++++++
 2 files changed, 111 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/multiarch/native/nativecalls.c

diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index 373db69648..c4ea7117c2 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -128,7 +128,14 @@ run-semiconsole: semiconsole
 run-plugin-semiconsole-with-%:
 	$(call skip-test, $<, "MANUAL ONLY")
 
-TESTS += semihosting semiconsole
+nativecalls: native/nativecalls.c
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(filter-out -static,$(LDFLAGS))
+
+run-nativecalls: nativecalls
+	$(call run-test,$<, $(QEMU) -L /usr/$(subst -gcc,,$(CC)) --native-bypass $(SRC_PATH)/build/common-user/native/$(TARGET)/libnative.so $<, \
+	"native call")
+
+TESTS += semihosting semiconsole nativecalls
 endif
 
 # Update TESTS
diff --git a/tests/tcg/multiarch/native/nativecalls.c b/tests/tcg/multiarch/native/nativecalls.c
new file mode 100644
index 0000000000..2d4ddb3a8e
--- /dev/null
+++ b/tests/tcg/multiarch/native/nativecalls.c
@@ -0,0 +1,103 @@
+#include <assert.h>
+#include <stdlib.h>
+#include <string.h>
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
+void test_memcmp()
+{
+    char str1[] = "abc";
+    char str2[] = "abc";
+    char str3[] = "def";
+    assert(memcmp(str1, str2, 3) == 0);
+    assert(memcmp(str1, str3, 3) != 0);
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
+void test_strncpy()
+{
+    char src[] = "Hello, world!";
+    char dest[20];
+    strncpy(dest, src, 13);
+    compare_memory(dest, src, 13);
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
+
+void test_strcpy()
+{
+    char src[] = "Hello, world!";
+    char dest[20];
+    strcpy(dest, src);
+    compare_memory(dest, src, 13);
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
+void test_memcpy_bad_addr()
+{
+    char src[] = "Hello, world!";
+    char *dst = (char *)0x1;
+    memcpy(dst, src, 13);
+}
+
+void test_memset_bad_addr()
+{
+    char *dst = (char *)0x1;
+    memset(dst, 'A', 10);
+}
+
+int main()
+{
+    test_memcpy();
+    test_memcmp();
+    test_memset();
+    test_strncpy();
+    test_strncmp();
+    test_strcpy();
+    test_strcmp();
+
+    test_memcpy_bad_addr();
+    test_memset_bad_addr();
+
+    return EXIT_SUCCESS;
+}
-- 
2.34.1


