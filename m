Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5BC89E3AF
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Apr 2024 21:37:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruHGX-0000Zr-0t; Tue, 09 Apr 2024 15:36:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ruHGU-0000ZE-Rb
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 15:36:18 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ruHGT-0004dq-1P
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 15:36:18 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1e3c7549078so26647645ad.0
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 12:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712691376; x=1713296176; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kLktQTH6TNyDdnNQxMnhQfTJfTanNKRfEbSAV10avAE=;
 b=dnh+ZjsJlns20lT2lNHhCO3aGUQdDzne+R01XIRDmXp11Zx70gK8Udc8M9jacuintM
 egkWeZ8hjoAkFDZ73k0sEz+tXFYPT5PvGpjLz9CH14xlX8juey9Q5SOfzsKH4Wtv9YEj
 dSdKVXUaSJ+KGBiOzw+uPDnsiQ84owbQneopjGl/LV8irkDo9byT3KhpCmRAM/my2fLW
 wEkNAqt064IKuFVMGiJxb4VCB7D/UoeMPIG6n5BpEEHJMqAFcz+Tj5Jy/QjhgE4csrdp
 qs7poTN1w45fZFTQPNS8B5G8qHvZmoj8DGFfvowjTF7uTjLd5FsYGJNVrowx83Vti76J
 XL+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712691376; x=1713296176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kLktQTH6TNyDdnNQxMnhQfTJfTanNKRfEbSAV10avAE=;
 b=GRmsMCqPdipiGjnlJa0JQEVwElKv0VncU1vuurwe1TLEscoRrdxSRb6KWYCBHcobQc
 pkzmGb54n94diARiQRBFEABCQkIfVDsHhxb8Xm5oZmaCuJNZDH3aDEJYKzoanL/9j4BX
 P0qA6jUyRnumA+gw6LPCltxPwPODMdkW1BUICx3wR3cE56rgG2l4VCVmi3f8CmtYbkYm
 07sRxQjGDgUYLO68tM+j71tNBmwfHXsN5mBXNW+zlau4e76IvODTU34JdyeZPEu5rcfF
 m2NEgJ1geYQGAM85qaeDL0kenZVoYPTtBsM26KTT3K6+ZnrMB+Ry6odo5wr8Xj5QP3T4
 X+Ww==
X-Gm-Message-State: AOJu0YyHHD9okGOr8X5vEj2xtpxMRhl6MD49wjMg9YJrVpCSu7wSQ3HL
 L5ikuND68Y64vJdGSKrxxmC9ZiJfwkbsK2OQpuEylUnBtDtM0N9n3wccK8JEXjTED4mEHjf1rvv
 l
X-Google-Smtp-Source: AGHT+IECEIj+YK1zuk0EeOj3k2v39VZnGlTGaMJm1A6f0UVEEoErLb4H9mmxad8kZdFM+0TxSfdG0A==
X-Received: by 2002:a17:903:185:b0:1e2:7734:63dd with SMTP id
 z5-20020a170903018500b001e2773463ddmr5742263plg.30.1712691375703; 
 Tue, 09 Apr 2024 12:36:15 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 c17-20020a170902d49100b001e1071cf0bbsm6065843plg.302.2024.04.09.12.36.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 12:36:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zack Buhman <zack@buhman.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v2 07/20] target/sh4: Fix mac.l with saturation enabled
Date: Tue,  9 Apr 2024 09:35:50 -1000
Message-Id: <20240409193603.1703216-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240409193603.1703216-1-richard.henderson@linaro.org>
References: <20240409193603.1703216-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

From: Zack Buhman <zack@buhman.org>

The saturation arithmetic logic in helper_macl is not correct.
I tested and verified this behavior on a SH7091.

Signed-off-by: Zack Buhman <zack@buhman.org>
Message-Id: <20240404162641.27528-2-zack@buhman.org>
[rth: Reformat helper_macl, add a test case.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sh4/helper.h           |  2 +-
 target/sh4/op_helper.c        | 23 ++++++------
 tests/tcg/sh4/test-macl.c     | 67 +++++++++++++++++++++++++++++++++++
 tests/tcg/sh4/Makefile.target |  5 +++
 4 files changed, 86 insertions(+), 11 deletions(-)
 create mode 100644 tests/tcg/sh4/test-macl.c

diff --git a/target/sh4/helper.h b/target/sh4/helper.h
index 8d792f6b55..64056e4a39 100644
--- a/target/sh4/helper.h
+++ b/target/sh4/helper.h
@@ -11,7 +11,7 @@ DEF_HELPER_3(movcal, void, env, i32, i32)
 DEF_HELPER_1(discard_movcal_backup, void, env)
 DEF_HELPER_2(ocbi, void, env, i32)
 
-DEF_HELPER_3(macl, void, env, i32, i32)
+DEF_HELPER_3(macl, void, env, s32, s32)
 DEF_HELPER_3(macw, void, env, i32, i32)
 
 DEF_HELPER_2(ld_fpscr, void, env, i32)
diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
index 4559d0d376..d0bae0cc00 100644
--- a/target/sh4/op_helper.c
+++ b/target/sh4/op_helper.c
@@ -158,20 +158,23 @@ void helper_ocbi(CPUSH4State *env, uint32_t address)
     }
 }
 
-void helper_macl(CPUSH4State *env, uint32_t arg0, uint32_t arg1)
+void helper_macl(CPUSH4State *env, int32_t arg0, int32_t arg1)
 {
+    const int64_t min = -(1ll << 47);
+    const int64_t max = (1ll << 47) - 1;
+    int64_t mul = (int64_t)arg0 * arg1;
+    int64_t mac = env->mac;
     int64_t res;
 
-    res = ((uint64_t) env->mach << 32) | env->macl;
-    res += (int64_t) (int32_t) arg0 *(int64_t) (int32_t) arg1;
-    env->mach = (res >> 32) & 0xffffffff;
-    env->macl = res & 0xffffffff;
-    if (env->sr & (1u << SR_S)) {
-        if (res < 0)
-            env->mach |= 0xffff0000;
-        else
-            env->mach &= 0x00007fff;
+    if (!(env->sr & (1u << SR_S))) {
+        res = mac + mul;
+    } else if (sadd64_overflow(mac, mul, &res)) {
+        res = mac < 0 ? min : max;
+    } else {
+        res = MIN(MAX(res, min), max);
     }
+
+    env->mac = res;
 }
 
 void helper_macw(CPUSH4State *env, uint32_t arg0, uint32_t arg1)
diff --git a/tests/tcg/sh4/test-macl.c b/tests/tcg/sh4/test-macl.c
new file mode 100644
index 0000000000..b66c854365
--- /dev/null
+++ b/tests/tcg/sh4/test-macl.c
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include <stdint.h>
+#include <stdlib.h>
+#include <stdio.h>
+
+#define MACL_S_MIN  (-(1ll << 47))
+#define MACL_S_MAX  ((1ll << 47) - 1)
+
+int64_t mac_l(int64_t mac, const int32_t *a, const int32_t *b)
+{
+    register uint32_t macl __asm__("macl") = mac;
+    register uint32_t mach __asm__("mach") = mac >> 32;
+
+    asm volatile("mac.l @%0+,@%1+"
+                 : "+r"(a), "+r"(b), "+x"(macl), "+x"(mach));
+
+    return ((uint64_t)mach << 32) | macl;
+}
+
+typedef struct {
+    int64_t mac;
+    int32_t a, b;
+    int64_t res[2];
+} Test;
+
+__attribute__((noinline))
+void test(const Test *t, int sat)
+{
+    int64_t res;
+
+    if (sat) {
+        asm volatile("sets");
+    } else {
+        asm volatile("clrs");
+    }
+    res = mac_l(t->mac, &t->a, &t->b);
+
+    if (res != t->res[sat]) {
+        fprintf(stderr, "%#llx + (%#x * %#x) = %#llx -- got %#llx\n",
+                t->mac, t->a, t->b, t->res[sat], res);
+        abort();
+    }
+}
+
+int main()
+{
+    static const Test tests[] = {
+        { 0x00007fff12345678ll, INT32_MAX, INT32_MAX,
+          { 0x40007ffe12345679ll, MACL_S_MAX } },
+        { MACL_S_MIN, -1, 1,
+          { 0xffff7fffffffffffll, MACL_S_MIN } },
+        { INT64_MIN, -1, 1,
+          { INT64_MAX, MACL_S_MIN } },
+        { 0x00007fff00000000ll, INT32_MAX, INT32_MAX,
+          { 0x40007ffe00000001ll, MACL_S_MAX } },
+        { 4, 1, 2, { 6, 6 } },
+        { -4, -1, -2, { -2, -2 } },
+    };
+
+    for (int i = 0; i < sizeof(tests) / sizeof(tests[0]); ++i) {
+        for (int j = 0; j < 2; ++j) {
+            test(&tests[i], j);
+        }
+    }
+    return 0;
+}
diff --git a/tests/tcg/sh4/Makefile.target b/tests/tcg/sh4/Makefile.target
index 16eaa850a8..9a11c10924 100644
--- a/tests/tcg/sh4/Makefile.target
+++ b/tests/tcg/sh4/Makefile.target
@@ -9,3 +9,8 @@ run-signals: signals
 	$(call skip-test, $<, "BROKEN")
 run-plugin-signals-with-%:
 	$(call skip-test, $<, "BROKEN")
+
+VPATH += $(SRC_PATH)/tests/tcg/sh4
+
+test-macl: CFLAGS += -O -g
+TESTS += test-macl
-- 
2.34.1


