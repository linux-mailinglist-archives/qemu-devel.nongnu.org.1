Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C08BA74C499
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 16:04:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIUxk-0000f4-2s; Sun, 09 Jul 2023 10:00:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIUxJ-0000OT-VM
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 10:00:08 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIUxG-0000Oc-DS
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 10:00:05 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-314172bac25so3405012f8f.3
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 06:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688911198; x=1691503198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rQM76z4rVFfGd1Monlw4rqjrIeX1bgxOaNzHCQOg/vo=;
 b=y1Nr3aeCapmEc1j9ngADBQJpdE1MaHbQ8KYp8gg56AkW2ujXomTdYo0H8sJ0GUMA3y
 MuSzx0Y5+rCCciCwbHkQXkYmTJwKKOsvk72eDD+GvlAvznlSPh8DA44Qf8V2gQxtPljw
 SL8MMumVtpV8hQ6m9xAnxHkiYhhOlxdP2HJ3TqHmKee61MqdqPV93QHbyaScvo/EzyyV
 TC4KbFfvzNjghkHtYdjkd+QxQZu1c1QbgjB2ue4o2G3M+5pH1+Inwc0kRWcltIXUujyr
 z0MFw3Hsg2KPsQpb7u6ptKU4JrewS4Z1WsGwdTLOTPvx58B0MD7JE8argZK/Jsb0xSoi
 y2ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688911198; x=1691503198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rQM76z4rVFfGd1Monlw4rqjrIeX1bgxOaNzHCQOg/vo=;
 b=byZbKWmAaU5lqqfnDFVqWtY2O9XxB5kczvQwuyfPEiXUPjZ0UG3ezmR69lsTAiwS4Q
 KtGdcE88KxDkzCXYFUPIaPiON2yGbPhjsI05tGFX2HkPKg3HUvY+ke7fy2yr8+4iuo+9
 UI8xRfh2OR3+2bOvBK4FiSfwVlWDF8r23Oljwvp4QoLBKINV5SnNTp00V+HVNlAp6fKV
 lVan7+veazED8g6HyI3PmRHOutyHP8Fkco/rmI04ut/NEfLmAzPKFeVrozZAXxRpknV4
 KrIV0a5LpEiQxUIqOoOsZV00kw0bSnLhcKjs8Xz4V5x/3gr9oSBbpewflbpw1tCueSlT
 Sf5g==
X-Gm-Message-State: ABy/qLbKRF+lE7GSq0Ltbe7fsgM0+qx59auUaDRohtYgPDql3FTclXsF
 wCHiwxPDslCDaJeU0xxdgLnYX06D8FJ4JJo3+kk2hg==
X-Google-Smtp-Source: APBJJlG4GjwqdUSZ2bO8Rsd3Yz1v9/Q0dZmlUSjr7PIgBD4IAb0E1opypOZ5SFHI9vFOr/I5M+pxfg==
X-Received: by 2002:adf:ee4a:0:b0:314:11d7:c919 with SMTP id
 w10-20020adfee4a000000b0031411d7c919mr8370247wro.49.1688911198149; 
 Sun, 09 Jul 2023 06:59:58 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 v18-20020a5d6792000000b003063a92bbf5sm9239422wru.70.2023.07.09.06.59.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 06:59:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/37] host/include/aarch64: Implement aes-round.h
Date: Sun,  9 Jul 2023 14:59:21 +0100
Message-Id: <20230709135945.250311-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709135945.250311-1-richard.henderson@linaro.org>
References: <20230709135945.250311-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42e.google.com
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


