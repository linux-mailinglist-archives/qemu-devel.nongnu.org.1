Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5B674477A
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 08:57:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFUVu-0007Vj-D3; Sat, 01 Jul 2023 02:55:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFUVs-0007Uo-58
 for qemu-devel@nongnu.org; Sat, 01 Jul 2023 02:55:20 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFUVq-0007FH-DX
 for qemu-devel@nongnu.org; Sat, 01 Jul 2023 02:55:19 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fbc244d307so24076095e9.1
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 23:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688194516; x=1690786516;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mV8nHx5xU3W2QWS3dGtP3xyCoVtszahnj86o5dz8D9I=;
 b=AnxN3oqOfwThmH6eoaLqir2YFZqG0vpIuPWEjoN744ITryrMAkGICfSeyFqxAXRTOi
 ADDm6OG776ZXcjKlERD9WNEyFdz+Se5h/HgByD4oUuzWqWnIe3wkvx0DdkLMFf5RZRkB
 lltM/e4qCW3v4JO9/lqWz5CBX4ARqLpj1vGPMDywBobypvGtDV8YjUpfD01Fkx4C+1zO
 KexsWHpqMuYzllZYtSykzrtmPl67xEjj67QRq6ChV+DYS0e6tUID99y6xM1XPs8vt+3Z
 96+P7m1a0I/UdJA94eLIH5o8j8v5hDWXO7nTkCYfi2PT034u+havJYmCJsqXORKZ6DbG
 Ik0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688194516; x=1690786516;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mV8nHx5xU3W2QWS3dGtP3xyCoVtszahnj86o5dz8D9I=;
 b=BIeuyrQhsdtyRvwvOPYJIFaiCki9Ur5RHDjp1sPumznphYQ6QoaM8Du7YJSDr39S7Z
 vVV4LfIMN9n2gLIykUQM7TFrxCwK46UZyynaKsGl5HKj3ax6X32GpMl4R4T6IWOyLWcM
 0USQHRfXwe4y750gAi+a+Q/ixoaHQJsm0i+J76cI2Mgj43IN6KBGbgdX2Q1dRb/r74Dd
 7zCEnmAbiUnUtRv4jgjlb6PlRO/WnmLSh9MYi5/uZaVCa2Sg+qX3UlsDT/HRphsxuDof
 WOPpQCAz7MtaSfHpyg8pI2hEE66TJRY54ngV7K8MlaUCzI+SO+52RcYnc2VkjyDZylkZ
 bJuA==
X-Gm-Message-State: AC+VfDwViUYqUpZXBu3V2pFUJPRNsMnywLMLfNHLj8l87EhIOncu6//q
 76k4wDNy+c6NeRWu1mkYNhTf7FIDiDz8pC/zIbc0Vg==
X-Google-Smtp-Source: ACHHUZ5QH3lftbp0YitGLqOMpUbNpoYIAxhs5BlvEZgnIOlFubVIfF6MW+KmvUB9/BZosRbjehPOPw==
X-Received: by 2002:a05:600c:b54:b0:3f9:846:d892 with SMTP id
 k20-20020a05600c0b5400b003f90846d892mr3691581wmr.9.1688194516764; 
 Fri, 30 Jun 2023 23:55:16 -0700 (PDT)
Received: from localhost.localdomain ([139.47.41.96])
 by smtp.gmail.com with ESMTPSA id
 w10-20020a1cf60a000000b003f9bd9e3226sm20874918wmc.7.2023.06.30.23.55.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 23:55:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 06/11] tests/tcg/alpha: Add test for cvttq
Date: Sat,  1 Jul 2023 08:55:05 +0200
Message-Id: <20230701065510.514743-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230701065510.514743-1-richard.henderson@linaro.org>
References: <20230701065510.514743-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32e.google.com
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

Test for invalid, integer overflow, and inexact.
Test for proper result, modulo 2**64.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230527141910.1885950-3-richard.henderson@linaro.org>
---
 tests/tcg/alpha/test-cvttq.c    | 78 +++++++++++++++++++++++++++++++++
 tests/tcg/alpha/Makefile.target |  2 +-
 2 files changed, 79 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/alpha/test-cvttq.c

diff --git a/tests/tcg/alpha/test-cvttq.c b/tests/tcg/alpha/test-cvttq.c
new file mode 100644
index 0000000000..d1ad995312
--- /dev/null
+++ b/tests/tcg/alpha/test-cvttq.c
@@ -0,0 +1,78 @@
+#include <stdio.h>
+
+#define FPCR_SUM                (1UL << 63)
+#define FPCR_INED               (1UL << 62)
+#define FPCR_UNFD               (1UL << 61)
+#define FPCR_UNDZ               (1UL << 60)
+#define FPCR_DYN_SHIFT          58
+#define FPCR_DYN_CHOPPED        (0UL << FPCR_DYN_SHIFT)
+#define FPCR_DYN_MINUS          (1UL << FPCR_DYN_SHIFT)
+#define FPCR_DYN_NORMAL         (2UL << FPCR_DYN_SHIFT)
+#define FPCR_DYN_PLUS           (3UL << FPCR_DYN_SHIFT)
+#define FPCR_DYN_MASK           (3UL << FPCR_DYN_SHIFT)
+#define FPCR_IOV                (1UL << 57)
+#define FPCR_INE                (1UL << 56)
+#define FPCR_UNF                (1UL << 55)
+#define FPCR_OVF                (1UL << 54)
+#define FPCR_DZE                (1UL << 53)
+#define FPCR_INV                (1UL << 52)
+#define FPCR_OVFD               (1UL << 51)
+#define FPCR_DZED               (1UL << 50)
+#define FPCR_INVD               (1UL << 49)
+#define FPCR_DNZ                (1UL << 48)
+#define FPCR_DNOD               (1UL << 47)
+#define FPCR_STATUS_MASK        (FPCR_IOV | FPCR_INE | FPCR_UNF \
+                                 | FPCR_OVF | FPCR_DZE | FPCR_INV)
+
+static long test_cvttq(long *ret_e, double d)
+{
+    unsigned long reset = (FPCR_INED | FPCR_UNFD | FPCR_OVFD | FPCR_DZED |
+                           FPCR_INVD | FPCR_DYN_NORMAL);
+    long r, e;
+
+    asm("excb\n\t"
+        "mt_fpcr %3\n\t"
+        "excb\n\t"
+        "cvttq/svic %2, %0\n\t"
+        "excb\n\t"
+        "mf_fpcr %1\n\t"
+        "excb\n\t"
+        : "=f"(r), "=f"(e)
+        : "f"(d), "f"(reset));
+
+    *ret_e = e & FPCR_STATUS_MASK;
+    return r;
+}
+
+int main (void)
+{
+    static const struct {
+        double d;
+        long r;
+        long e;
+    } T[] = {
+        {  1.0,  1, 0 },
+        { -1.0, -1, 0 },
+        {  1.5,  1, FPCR_INE },
+        {  0x1.0p32,   0x0000000100000000ul, 0 },
+        { -0x1.0p63,   0x8000000000000000ul, 0 },
+        {  0x1.0p63,   0x8000000000000000ul, FPCR_IOV | FPCR_INE },
+        {  0x1.0p64,   0x0000000000000000ul, FPCR_IOV | FPCR_INE },
+        {  0x1.cccp64, 0xccc0000000000000ul, FPCR_IOV | FPCR_INE },
+        { __builtin_inf(), 0, FPCR_INV },
+        { __builtin_nan(""), 0, FPCR_INV },
+    };
+
+    int i, err = 0;
+
+    for (i = 0; i < sizeof(T)/sizeof(T[0]); i++) {
+        long e, r = test_cvttq(&e, T[i].d);
+
+        if (r != T[i].r || e != T[i].e) {
+            printf("Fail %a: expect (%016lx : %04lx) got (%016lx : %04lx)\n",
+                   T[i].d, T[i].r, T[i].e >> 48, r, e >> 48);
+            err = 1;
+        }
+    }
+    return err;
+}
diff --git a/tests/tcg/alpha/Makefile.target b/tests/tcg/alpha/Makefile.target
index a585080328..b94500a7d9 100644
--- a/tests/tcg/alpha/Makefile.target
+++ b/tests/tcg/alpha/Makefile.target
@@ -5,7 +5,7 @@
 ALPHA_SRC=$(SRC_PATH)/tests/tcg/alpha
 VPATH+=$(ALPHA_SRC)
 
-ALPHA_TESTS=hello-alpha test-cond test-cmov test-ovf
+ALPHA_TESTS=hello-alpha test-cond test-cmov test-ovf test-cvttq
 TESTS+=$(ALPHA_TESTS)
 
 test-cmov: EXTRA_CFLAGS=-DTEST_CMOV
-- 
2.34.1


