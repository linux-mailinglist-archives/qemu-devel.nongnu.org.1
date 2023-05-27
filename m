Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F41713523
	for <lists+qemu-devel@lfdr.de>; Sat, 27 May 2023 16:20:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2ulN-0007op-Pz; Sat, 27 May 2023 10:19:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2ulJ-0007ns-1F
 for qemu-devel@nongnu.org; Sat, 27 May 2023 10:19:17 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2ulH-0002GJ-AP
 for qemu-devel@nongnu.org; Sat, 27 May 2023 10:19:16 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1b01d3bb571so7741795ad.2
 for <qemu-devel@nongnu.org>; Sat, 27 May 2023 07:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685197153; x=1687789153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2PeQwKwKV8qp9CY2VpKZ0tpDcxwU9A3roabUSRDXyns=;
 b=CN5yD7Rm0sCYOj9kDa1dcUyVRp6zz8NaTKZWfzIyGTpbxaXZlVhN6VU2/hR9ASDtjv
 J3XNU52c89hcaeL2ZViidb5EzHcahp3D7Lm/hHZYCr3VFbuz4yCgG4CSu9ueFMGTmHjK
 IhuxojQp3lH3fs1N2OboqeI1OkW8jAN1uvM7dCxiVl9gqzE9HFrf164sqpXrvBSdS65C
 KZ2r5n1/vkugZuDY1cAK+hJ8dkfF/W6sDsDVdJSlk3zpjz9IwHnGwchdRPHqevWTbUJw
 QuGUC1wRvwQeiVDkkoWcHWs/P/BFFuWJCGKz/qZncLnbfUI41rYqc3PzG559fhL5L3g/
 q6vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685197153; x=1687789153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2PeQwKwKV8qp9CY2VpKZ0tpDcxwU9A3roabUSRDXyns=;
 b=PulTmdEvV88TwhD0gcBcKrkr8NQCnH80prtl4ZfkVLm9sADnVrUahgQ15FU8iavq64
 3D2qbUEHJf3rdlr9OjEpiRbLe3378l0KallYsXAt/k8ZopbsIQAaj+Veia8FuxGtSLmv
 f+G418xa6Pm8uiuQD0g7VRHT02WmG0+bhljExYAQkqF2MuTVGKGTjymAh5WTnJZNZy0Q
 0uUS0SY86PnH6HdqWxr+2flqBG85Lxs4SEAF0ibFq798CdPOda8DtrzqH/HNmgr/sPzN
 DSnOE5HCt/ftbgBOO7obKjHU1SBmXZKelSoMYg7LtsWgZl6WiCp4IKNzZroiq7z+wAXH
 6Zaw==
X-Gm-Message-State: AC+VfDyfr+fU7djtUNNRiSaTJPTRnozMVgZbyijGXaCCkizLtkgBRiyo
 HVOWavLxd8EYmClkNl/auRZogNna6quF7dq51Yw=
X-Google-Smtp-Source: ACHHUZ55stOFPq8971z+0yqTR2WN42ij8wud05MhmKA3akDAYzpn5jdpDA7mQjNhl6Ue1R5aNOpwjQ==
X-Received: by 2002:a17:902:ce8b:b0:1af:c602:cd52 with SMTP id
 f11-20020a170902ce8b00b001afc602cd52mr6756596plg.67.1685197153632; 
 Sat, 27 May 2023 07:19:13 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:be31:c162:a57e:7431])
 by smtp.gmail.com with ESMTPSA id
 j20-20020a170902759400b001a988a71617sm1258992pll.192.2023.05.27.07.19.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 May 2023 07:19:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: christoph.muellner@vrull.eu,
	alex.bennee@linaro.org
Subject: [PATCH 2/4] tests/tcg/alpha: Add test for cvttq
Date: Sat, 27 May 2023 07:19:08 -0700
Message-Id: <20230527141910.1885950-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230527141910.1885950-1-richard.henderson@linaro.org>
References: <20230527141910.1885950-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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


