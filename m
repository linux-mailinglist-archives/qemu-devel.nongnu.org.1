Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E21A777FFC
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 20:09:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUA6G-00021K-2n; Thu, 10 Aug 2023 14:09:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUA5q-0001xj-6C
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 14:09:08 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUA5m-0001y2-DX
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 14:09:05 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1bc0d39b52cso8858435ad.2
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 11:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691690935; x=1692295735;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OWzlEvnCZbe3wAuEoxcRs6D4p7xFPp7msfwWBLYlOkc=;
 b=v8KrTjxpBNjVL9pVvfo4PG2aZisELRBVKAsfI2iaRxjXhGFkHAcJZEjNE7pNBdyBYM
 xZwYC3hCfCkeP/MXTWhOl05Fv7b7VUB6WkRgdVH5tEHKj2eym7TFnMkH5h92CIhxNsoR
 LlZkBNC5s3MIEebKWbghZOD6sH7find+OFFyRUAt8tho/j2s1LHSzB+kDO5X0c0iQIDI
 GZmH4GMTqpBrUlS/6/ZIzfQU974VvTRPQUAG1BjsOzR0o94IgaZkWe1KokXeyiHSRpJb
 qN9nEu8cMDQdSqDXIEidUoRDNhNIWsBWuxQ2qz1dIfwCQz8pskQQorsohu2R7B6Lai5Z
 vzJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691690935; x=1692295735;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OWzlEvnCZbe3wAuEoxcRs6D4p7xFPp7msfwWBLYlOkc=;
 b=NDK+v1iQxGa8RVQdI8zB8yLLRts9/pWZV6+rv1pL3pTBK8nvY7BKt+/TlAF7i8lM+c
 muDIu29X1qNJHA8Mlcxq85RyLLSqMifmkLufEVEPPfnZCOYi8xtSzqKgRch9qszTAF2O
 OQWbVn6j80gP9oE8r+XJoU1YYLqbfKRCzik4d7fmA6Cj8tgMPN24jeR6lzv1MyeQX1LM
 MphsdCDnuxhDhaZYqCFU2/N4iKZJY5qf6xXzTKeWpbolHlYjT19zr9yo7cwk6dLij8mx
 n3A6uj1mY33K6wBT5IwT0uguIcnZm4O1cE+Jhs46GUCQRsjvxKoTMg6namXzmHZGhv7g
 v0sw==
X-Gm-Message-State: AOJu0YybOejhQ0pR7NbZ44RyAgifwpl8goSkLfosNHCuluAHGNlwKODf
 WPX0Cm4N/7ngA0T65y0OzysCg12EKTsI0oycTeE=
X-Google-Smtp-Source: AGHT+IHtp41GHigQIZhOqy9VMSLKLp98sql5MYEGLWIjQIyBx0EMoQ0Te6DLmc75HWh3pKKjKTQOXQ==
X-Received: by 2002:a17:903:44c:b0:1bc:6e8c:eef9 with SMTP id
 iw12-20020a170903044c00b001bc6e8ceef9mr2112331plb.51.1691690935568; 
 Thu, 10 Aug 2023 11:08:55 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:9e4d:b830:d4fd:9164])
 by smtp.gmail.com with ESMTPSA id
 b14-20020a170902b60e00b001bd41b70b65sm2085212pls.49.2023.08.10.11.08.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Aug 2023 11:08:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 1/4] accel/tcg: Avoid reading too much in load_atom_{2,4}
Date: Thu, 10 Aug 2023 11:08:49 -0700
Message-Id: <20230810180852.54477-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810180852.54477-1-richard.henderson@linaro.org>
References: <20230810180852.54477-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When load_atom_extract_al16_or_al8 is inexpensive, we want to use
it early, in order to avoid the overhead of required_atomicity.
However, we must not read past the end of the page.

If there are more than 8 bytes remaining, then both the "aligned 16"
and "aligned 8" paths align down so that the read has at least
16 bytes remaining on the page.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/aarch64/lse2-fault.c    | 38 +++++++++++++++++++++++++++++++
 accel/tcg/ldst_atomicity.c.inc    | 10 ++++++--
 tests/tcg/aarch64/Makefile.target |  2 +-
 3 files changed, 47 insertions(+), 3 deletions(-)
 create mode 100644 tests/tcg/aarch64/lse2-fault.c

diff --git a/tests/tcg/aarch64/lse2-fault.c b/tests/tcg/aarch64/lse2-fault.c
new file mode 100644
index 0000000000..2187219a08
--- /dev/null
+++ b/tests/tcg/aarch64/lse2-fault.c
@@ -0,0 +1,38 @@
+#include <sys/mman.h>
+#include <sys/shm.h>
+#include <unistd.h>
+#include <stdio.h>
+
+int main()
+{
+    int psize = getpagesize();
+    int id;
+    void *p;
+
+    /*
+     * We need a shared mapping to enter CF_PARALLEL mode.
+     * The easiest way to get that is shmat.
+     */
+    id = shmget(IPC_PRIVATE, 2 * psize, IPC_CREAT | 0600);
+    if (id < 0) {
+        perror("shmget");
+        return 2;
+    }
+    p = shmat(id, NULL, 0);
+    if (p == MAP_FAILED) {
+        perror("shmat");
+        return 2;
+    }
+
+    /* Protect the second page. */
+    if (mprotect(p + psize, psize, PROT_NONE) < 0) {
+        perror("mprotect");
+        return 2;
+    }
+
+    /*
+     * Load 4 bytes, 6 bytes from the end of the page.
+     * On success this will load 0 from the newly allocated shm.
+     */
+    return *(int *)(p + psize - 6);
+}
diff --git a/accel/tcg/ldst_atomicity.c.inc b/accel/tcg/ldst_atomicity.c.inc
index e5c590a499..1b793e6935 100644
--- a/accel/tcg/ldst_atomicity.c.inc
+++ b/accel/tcg/ldst_atomicity.c.inc
@@ -404,7 +404,10 @@ static uint16_t load_atom_2(CPUArchState *env, uintptr_t ra,
         return load_atomic2(pv);
     }
     if (HAVE_ATOMIC128_RO) {
-        return load_atom_extract_al16_or_al8(pv, 2);
+        intptr_t left_in_page = -(pi | TARGET_PAGE_MASK);
+        if (likely(left_in_page > 8)) {
+            return load_atom_extract_al16_or_al8(pv, 2);
+        }
     }
 
     atmax = required_atomicity(env, pi, memop);
@@ -443,7 +446,10 @@ static uint32_t load_atom_4(CPUArchState *env, uintptr_t ra,
         return load_atomic4(pv);
     }
     if (HAVE_ATOMIC128_RO) {
-        return load_atom_extract_al16_or_al8(pv, 4);
+        intptr_t left_in_page = -(pi | TARGET_PAGE_MASK);
+        if (likely(left_in_page > 8)) {
+            return load_atom_extract_al16_or_al8(pv, 4);
+        }
     }
 
     atmax = required_atomicity(env, pi, memop);
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 617f821613..681dfa077c 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -9,7 +9,7 @@ AARCH64_SRC=$(SRC_PATH)/tests/tcg/aarch64
 VPATH 		+= $(AARCH64_SRC)
 
 # Base architecture tests
-AARCH64_TESTS=fcvt pcalign-a64
+AARCH64_TESTS=fcvt pcalign-a64 lse2-fault
 
 fcvt: LDFLAGS+=-lm
 
-- 
2.34.1


