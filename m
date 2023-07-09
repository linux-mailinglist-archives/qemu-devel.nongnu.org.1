Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F9074C72B
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 20:35:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIZAY-0008Lm-J6; Sun, 09 Jul 2023 14:30:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZAW-0008L2-UF
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:30:00 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZAV-0000IX-04
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:30:00 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-31441bc0092so3559496f8f.1
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 11:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688927398; x=1691519398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rQM76z4rVFfGd1Monlw4rqjrIeX1bgxOaNzHCQOg/vo=;
 b=z0dqgVEmhoBXv7TkTVeLPRUg/0oi9X/kPBMurf16nVj5zCNu9IIYlswS5pf/e58sgh
 qYJW7/+f1dEmMbaiN587XgdloQC8yNZ3JqFhIs77UsQ/2EnDQJWgomjJWJk7vhPcZPiT
 iKlEYS/DSSg5kBBbQt7GW6hN0wgohXN0yitEa+KnFTbyuX6kDIJuvI8zhEaIGXGuleHY
 EFJ+GxWHktDJ6INHSBPzGJ1OhXG0m+yWh1jNudsN8tUXcuEAkB421dSEmauagaUB+r/R
 UYlEa4H+wFIPMOucLxPIJ9wtcrShU+xa60hBeQLZmNAz2JrBa3NBqTnw0tw9wn9vbRfg
 c3lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688927398; x=1691519398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rQM76z4rVFfGd1Monlw4rqjrIeX1bgxOaNzHCQOg/vo=;
 b=EeW/xF/wK/AbuWFABzvELG3u3gtkTjq0QA5uAIuNQQko672sjLtlaDi3cV5Cyolut/
 H7L7rTcHnhn0ztaF69abSLCEx/OWjqYvw2hWVcH141gMYRY0s+pmd1smkv/rYiqQzTaQ
 QlNSliqGoOa4jnrFkqnTPxSNDchuJuDzbMMutZh47WChuTEtVu3hk4HQ+whxeYigZ/q1
 rXZT502tcZCJqKMZsJzaPljObBGZjpV5rKnBercAsDBK5SET5WiOuBFoc/4JXHOy7cl6
 SinihAGjLUKf8NS+HgFryL7wJQcA0LYpaKN8NHhTf50TdBW7qi2QV/CPqD+pxFrVKXGi
 C6mQ==
X-Gm-Message-State: ABy/qLa30ktLwFkxxMd7ylYRZaqgukqJv4cA6NVuzgxcKe4vRgvqamSW
 pHWfEurtpGGs7+J4sUyjM3S4NgvEaEmRSkbBPqr9Sg==
X-Google-Smtp-Source: APBJJlHLfNi6hgNAdSICVW6dOUyzj9i1NVDNi40+IjvWQXYJI7li3I150G9Sd/DWwRlDYV+rPDvb9g==
X-Received: by 2002:adf:f108:0:b0:313:eaf5:515 with SMTP id
 r8-20020adff108000000b00313eaf50515mr7578018wro.6.1688927397720; 
 Sun, 09 Jul 2023 11:29:57 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 q15-20020a7bce8f000000b003fbe791a0e8sm8317108wmj.0.2023.07.09.11.29.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 11:29:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu
Subject: [PULL 13/37] host/include/aarch64: Implement aes-round.h
Date: Sun,  9 Jul 2023 19:28:37 +0100
Message-Id: <20230709182934.309468-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709182934.309468-1-richard.henderson@linaro.org>
References: <20230709182934.309468-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42a.google.com
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

Detect AES in cpuinfo; implement the accel hooks.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 meson.build                                  |   9 +
 host/include/aarch64/host/cpuinfo.h          |   1 +
 host/include/aarch64/host/crypto/aes-round.h | 205 +++++++++++++++++++
 util/cpuinfo-aarch64.c                       |   2 +
 4 files changed, 217 insertions(+)
 create mode 100644 host/include/aarch64/host/crypto/aes-round.h

diff --git a/meson.build b/meson.build
index c77faa0b6e..58413d44a5 100644
--- a/meson.build
+++ b/meson.build
@@ -2665,6 +2665,15 @@ config_host_data.set('CONFIG_AVX512BW_OPT', get_option('avx512bw') \
     int main(int argc, char *argv[]) { return bar(argv[0]); }
   '''), error_message: 'AVX512BW not available').allowed())
 
+# For both AArch64 and AArch32, detect if builtins are available.
+config_host_data.set('CONFIG_ARM_AES_BUILTIN', cc.compiles('''
+    #include <arm_neon.h>
+    #ifndef __ARM_FEATURE_AES
+    __attribute__((target("+crypto")))
+    #endif
+    void foo(uint8x16_t *p) { *p = vaesmcq_u8(*p); }
+  '''))
+
 have_pvrdma = get_option('pvrdma') \
   .require(rdma.found(), error_message: 'PVRDMA requires OpenFabrics libraries') \
   .require(cc.compiles(gnu_source_prefix + '''
diff --git a/host/include/aarch64/host/cpuinfo.h b/host/include/aarch64/host/cpuinfo.h
index 82227890b4..05feeb4f43 100644
--- a/host/include/aarch64/host/cpuinfo.h
+++ b/host/include/aarch64/host/cpuinfo.h
@@ -9,6 +9,7 @@
 #define CPUINFO_ALWAYS          (1u << 0)  /* so cpuinfo is nonzero */
 #define CPUINFO_LSE             (1u << 1)
 #define CPUINFO_LSE2            (1u << 2)
+#define CPUINFO_AES             (1u << 3)
 
 /* Initialized with a constructor. */
 extern unsigned cpuinfo;
diff --git a/host/include/aarch64/host/crypto/aes-round.h b/host/include/aarch64/host/crypto/aes-round.h
new file mode 100644
index 0000000000..8b5f88d50c
--- /dev/null
+++ b/host/include/aarch64/host/crypto/aes-round.h
@@ -0,0 +1,205 @@
+/*
+ * AArch64 specific aes acceleration.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef AARCH64_HOST_CRYPTO_AES_ROUND_H
+#define AARCH64_HOST_CRYPTO_AES_ROUND_H
+
+#include "host/cpuinfo.h"
+#include <arm_neon.h>
+
+#ifdef __ARM_FEATURE_AES
+# define HAVE_AES_ACCEL  true
+#else
+# define HAVE_AES_ACCEL  likely(cpuinfo & CPUINFO_AES)
+#endif
+#if !defined(__ARM_FEATURE_AES) && defined(CONFIG_ARM_AES_BUILTIN)
+# define ATTR_AES_ACCEL  __attribute__((target("+crypto")))
+#else
+# define ATTR_AES_ACCEL
+#endif
+
+static inline uint8x16_t aes_accel_bswap(uint8x16_t x)
+{
+    return vqtbl1q_u8(x, (uint8x16_t){ 15, 14, 13, 12, 11, 10, 9, 8,
+                                        7,  6,  5,  4,  3,  2, 1, 0, });
+}
+
+#ifdef CONFIG_ARM_AES_BUILTIN
+# define aes_accel_aesd            vaesdq_u8
+# define aes_accel_aese            vaeseq_u8
+# define aes_accel_aesmc           vaesmcq_u8
+# define aes_accel_aesimc          vaesimcq_u8
+# define aes_accel_aesd_imc(S, K)  vaesimcq_u8(vaesdq_u8(S, K))
+# define aes_accel_aese_mc(S, K)   vaesmcq_u8(vaeseq_u8(S, K))
+#else
+static inline uint8x16_t aes_accel_aesd(uint8x16_t d, uint8x16_t k)
+{
+    asm(".arch_extension aes\n\t"
+        "aesd %0.16b, %1.16b" : "+w"(d) : "w"(k));
+    return d;
+}
+
+static inline uint8x16_t aes_accel_aese(uint8x16_t d, uint8x16_t k)
+{
+    asm(".arch_extension aes\n\t"
+        "aese %0.16b, %1.16b" : "+w"(d) : "w"(k));
+    return d;
+}
+
+static inline uint8x16_t aes_accel_aesmc(uint8x16_t d)
+{
+    asm(".arch_extension aes\n\t"
+        "aesmc %0.16b, %1.16b" : "=w"(d) : "w"(d));
+    return d;
+}
+
+static inline uint8x16_t aes_accel_aesimc(uint8x16_t d)
+{
+    asm(".arch_extension aes\n\t"
+        "aesimc %0.16b, %1.16b" : "=w"(d) : "w"(d));
+    return d;
+}
+
+/* Most CPUs fuse AESD+AESIMC in the execution pipeline. */
+static inline uint8x16_t aes_accel_aesd_imc(uint8x16_t d, uint8x16_t k)
+{
+    asm(".arch_extension aes\n\t"
+        "aesd %0.16b, %1.16b\n\t"
+        "aesimc %0.16b, %0.16b" : "+w"(d) : "w"(k));
+    return d;
+}
+
+/* Most CPUs fuse AESE+AESMC in the execution pipeline. */
+static inline uint8x16_t aes_accel_aese_mc(uint8x16_t d, uint8x16_t k)
+{
+    asm(".arch_extension aes\n\t"
+        "aese %0.16b, %1.16b\n\t"
+        "aesmc %0.16b, %0.16b" : "+w"(d) : "w"(k));
+    return d;
+}
+#endif /* CONFIG_ARM_AES_BUILTIN */
+
+static inline void ATTR_AES_ACCEL
+aesenc_MC_accel(AESState *ret, const AESState *st, bool be)
+{
+    uint8x16_t t = (uint8x16_t)st->v;
+
+    if (be) {
+        t = aes_accel_bswap(t);
+        t = aes_accel_aesmc(t);
+        t = aes_accel_bswap(t);
+    } else {
+        t = aes_accel_aesmc(t);
+    }
+    ret->v = (AESStateVec)t;
+}
+
+static inline void ATTR_AES_ACCEL
+aesenc_SB_SR_AK_accel(AESState *ret, const AESState *st,
+                      const AESState *rk, bool be)
+{
+    uint8x16_t t = (uint8x16_t)st->v;
+    uint8x16_t z = { };
+
+    if (be) {
+        t = aes_accel_bswap(t);
+        t = aes_accel_aese(t, z);
+        t = aes_accel_bswap(t);
+    } else {
+        t = aes_accel_aese(t, z);
+    }
+    ret->v = (AESStateVec)t ^ rk->v;
+}
+
+static inline void ATTR_AES_ACCEL
+aesenc_SB_SR_MC_AK_accel(AESState *ret, const AESState *st,
+                         const AESState *rk, bool be)
+{
+    uint8x16_t t = (uint8x16_t)st->v;
+    uint8x16_t z = { };
+
+    if (be) {
+        t = aes_accel_bswap(t);
+        t = aes_accel_aese_mc(t, z);
+        t = aes_accel_bswap(t);
+    } else {
+        t = aes_accel_aese_mc(t, z);
+    }
+    ret->v = (AESStateVec)t ^ rk->v;
+}
+
+static inline void ATTR_AES_ACCEL
+aesdec_IMC_accel(AESState *ret, const AESState *st, bool be)
+{
+    uint8x16_t t = (uint8x16_t)st->v;
+
+    if (be) {
+        t = aes_accel_bswap(t);
+        t = aes_accel_aesimc(t);
+        t = aes_accel_bswap(t);
+    } else {
+        t = aes_accel_aesimc(t);
+    }
+    ret->v = (AESStateVec)t;
+}
+
+static inline void ATTR_AES_ACCEL
+aesdec_ISB_ISR_AK_accel(AESState *ret, const AESState *st,
+                        const AESState *rk, bool be)
+{
+    uint8x16_t t = (uint8x16_t)st->v;
+    uint8x16_t z = { };
+
+    if (be) {
+        t = aes_accel_bswap(t);
+        t = aes_accel_aesd(t, z);
+        t = aes_accel_bswap(t);
+    } else {
+        t = aes_accel_aesd(t, z);
+    }
+    ret->v = (AESStateVec)t ^ rk->v;
+}
+
+static inline void ATTR_AES_ACCEL
+aesdec_ISB_ISR_AK_IMC_accel(AESState *ret, const AESState *st,
+                            const AESState *rk, bool be)
+{
+    uint8x16_t t = (uint8x16_t)st->v;
+    uint8x16_t k = (uint8x16_t)rk->v;
+    uint8x16_t z = { };
+
+    if (be) {
+        t = aes_accel_bswap(t);
+        k = aes_accel_bswap(k);
+        t = aes_accel_aesd(t, z);
+        t ^= k;
+        t = aes_accel_aesimc(t);
+        t = aes_accel_bswap(t);
+    } else {
+        t = aes_accel_aesd(t, z);
+        t ^= k;
+        t = aes_accel_aesimc(t);
+    }
+    ret->v = (AESStateVec)t;
+}
+
+static inline void ATTR_AES_ACCEL
+aesdec_ISB_ISR_IMC_AK_accel(AESState *ret, const AESState *st,
+                            const AESState *rk, bool be)
+{
+    uint8x16_t t = (uint8x16_t)st->v;
+    uint8x16_t z = { };
+
+    if (be) {
+        t = aes_accel_bswap(t);
+        t = aes_accel_aesd_imc(t, z);
+        t = aes_accel_bswap(t);
+    } else {
+        t = aes_accel_aesd_imc(t, z);
+    }
+    ret->v = (AESStateVec)t ^ rk->v;
+}
+
+#endif /* AARCH64_HOST_CRYPTO_AES_ROUND_H */
diff --git a/util/cpuinfo-aarch64.c b/util/cpuinfo-aarch64.c
index f99acb7884..ababc39550 100644
--- a/util/cpuinfo-aarch64.c
+++ b/util/cpuinfo-aarch64.c
@@ -56,10 +56,12 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
     unsigned long hwcap = qemu_getauxval(AT_HWCAP);
     info |= (hwcap & HWCAP_ATOMICS ? CPUINFO_LSE : 0);
     info |= (hwcap & HWCAP_USCAT ? CPUINFO_LSE2 : 0);
+    info |= (hwcap & HWCAP_AES ? CPUINFO_AES: 0);
 #endif
 #ifdef CONFIG_DARWIN
     info |= sysctl_for_bool("hw.optional.arm.FEAT_LSE") * CPUINFO_LSE;
     info |= sysctl_for_bool("hw.optional.arm.FEAT_LSE2") * CPUINFO_LSE2;
+    info |= sysctl_for_bool("hw.optional.arm.FEAT_AES") * CPUINFO_AES;
 #endif
 
     cpuinfo = info;
-- 
2.34.1


