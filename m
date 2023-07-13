Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5AC752BE9
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 23:16:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qK3ek-0000S1-3U; Thu, 13 Jul 2023 17:15:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qK3eR-0000NA-2g
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 17:15:04 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qK3eO-00019U-PW
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 17:15:02 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3141c3a7547so1322340f8f.2
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 14:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689282899; x=1691874899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=epV34O9DTR5ZBAxnORvbfiEcBH2IbFQIc3x2ZASYHbI=;
 b=LW96DSsnnHGNraV3OFF6ViK62/0drwKKRdgpzRMf2YZdyoXcrNke52sWyhtlzxcVBd
 5W+O8XrO2LyPSr3fKecKWD0e0VLhMNggjUr3bWcRrMPDU4e7J+hyM2jGaReftGTfNfgC
 EYCTaG6qQJ7DXAYK71SYj4jPq4nYyJNwWN7P2fQ+4NLmiwxJdMortOaHpm+T4jckG9gY
 dRbqPu7E8hium8P6Z9d5MbdLqHWaoyXnmzX08Bp5xAQVp+gmfeAisK8TB+eCHx3WONh8
 e0uu6tCUSSPBj8yFQ1axLRvw8K6qCdeFvguhm+7gxkAgp12ilLDydUPj8bmsya7TW4Ak
 J5AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689282899; x=1691874899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=epV34O9DTR5ZBAxnORvbfiEcBH2IbFQIc3x2ZASYHbI=;
 b=FgJlkQZMbzqMgqOnZtXy3ubXoAedPVos3o+jIByGDmETXhwVskNmp6oV7+b4oO61Vk
 Lnem5RBCXTBM7YhvcmeKFvRsaW5zixn502+dQvp5DrD9VaD4s2afCZwePvdTDG2YzjzZ
 SZQA5Ksuo1uh9ZD7utBQqU/KQd90IYhzoVIOXVQq6ww+sHr93KmNQVQR3+eKxwF5XLfQ
 /aZjOU2oIOipeH8JsZQDFHiAF9RbiO4NIlTpABPj5wbKvvUZqxFU3mzoAPpeMPmr8SWX
 DsvOn736aw4eMz96ngFKrmBbLwqd5/sOLwUHnaaWIy/HtaazFDO2LjrPiaMAITKUa5B8
 29mw==
X-Gm-Message-State: ABy/qLYMzZjUAmYzJ1cawAEugECTRcyl+jfbx0BglVtyWt5ou/8AurT2
 lhuPPVBeUmjZtN+e9IITLwOYN4gPKwgwIIzAnEcWCkdm
X-Google-Smtp-Source: APBJJlG+KZPUWl9pKI6Z9vaUwhe0CNeIFRQ8R+rHpLW2Vz1kojmEANFgdZDfpK1rXHi7imfHxa/0iw==
X-Received: by 2002:a5d:4e4d:0:b0:313:eee0:89a4 with SMTP id
 r13-20020a5d4e4d000000b00313eee089a4mr2051943wrt.12.1689282899379; 
 Thu, 13 Jul 2023 14:14:59 -0700 (PDT)
Received: from stoup.. ([85.193.156.66]) by smtp.gmail.com with ESMTPSA id
 n12-20020adff08c000000b0030ada01ca78sm8973747wro.10.2023.07.13.14.14.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jul 2023 14:14:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	ardb@kernel.org
Subject: [PATCH 18/18] host/include/aarch64: Implement clmul.h
Date: Thu, 13 Jul 2023 22:14:35 +0100
Message-Id: <20230713211435.13505-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230713211435.13505-1-richard.henderson@linaro.org>
References: <20230713211435.13505-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x435.google.com
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

Detect PMULL in cpuinfo; implement the accel hooks.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/aarch64/host/cpuinfo.h      |   1 +
 host/include/aarch64/host/crypto/clmul.h | 230 +++++++++++++++++++++++
 util/cpuinfo-aarch64.c                   |   4 +-
 3 files changed, 234 insertions(+), 1 deletion(-)
 create mode 100644 host/include/aarch64/host/crypto/clmul.h

diff --git a/host/include/aarch64/host/cpuinfo.h b/host/include/aarch64/host/cpuinfo.h
index 05feeb4f43..da268dce13 100644
--- a/host/include/aarch64/host/cpuinfo.h
+++ b/host/include/aarch64/host/cpuinfo.h
@@ -10,6 +10,7 @@
 #define CPUINFO_LSE             (1u << 1)
 #define CPUINFO_LSE2            (1u << 2)
 #define CPUINFO_AES             (1u << 3)
+#define CPUINFO_PMULL           (1u << 4)
 
 /* Initialized with a constructor. */
 extern unsigned cpuinfo;
diff --git a/host/include/aarch64/host/crypto/clmul.h b/host/include/aarch64/host/crypto/clmul.h
new file mode 100644
index 0000000000..7fd827898b
--- /dev/null
+++ b/host/include/aarch64/host/crypto/clmul.h
@@ -0,0 +1,230 @@
+/*
+ * AArch64 specific clmul acceleration.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef AARCH64_HOST_CRYPTO_CLMUL_H
+#define AARCH64_HOST_CRYPTO_CLMUL_H
+
+#include "host/cpuinfo.h"
+#include <arm_neon.h>
+
+/* Both FEAT_AES and FEAT_PMULL are covered under the same macro. */
+#ifdef __ARM_FEATURE_AES
+# define HAVE_CLMUL_ACCEL  true
+#else
+# define HAVE_CLMUL_ACCEL  likely(cpuinfo & CPUINFO_PMULL)
+#endif
+#if !defined(__ARM_FEATURE_AES) && defined(CONFIG_ARM_AES_BUILTIN)
+# define ATTR_CLMUL_ACCEL  __attribute__((target("+crypto")))
+#else
+# define ATTR_CLMUL_ACCEL
+#endif
+
+/*
+ * The 8x8->8 pmul and 8x8->16 pmull are available unconditionally.
+ */
+
+static inline uint64_t clmul_8x8_low(uint64_t n, uint64_t m)
+{
+    return (uint64_t)vmul_p8((poly8x8_t)n, (poly8x8_t)m);
+}
+
+static inline Int128 clmul_8x8_packed(uint64_t n, uint64_t m)
+{
+    union { poly16x8_t v; Int128 s; } u;
+    u.v = vmull_p8((poly8x8_t)n, (poly8x8_t)m);
+    return u.s;
+}
+
+static inline Int128 clmul_8x8_even(Int128 n, Int128 m)
+{
+    union { uint16x8_t v; Int128 s; } un, um;
+    uint8x8_t pn, pm;
+
+    un.s = n;
+    um.s = m;
+    pn = vmovn_u16(un.v);
+    pm = vmovn_u16(um.v);
+    return clmul_8x8_packed((uint64_t)pn, (uint64_t)pm);
+}
+
+static inline Int128 clmul_8x8_odd(Int128 n, Int128 m)
+{
+    union { uint8x16_t v; Int128 s; } un, um;
+    uint8x8_t pn, pm;
+
+    un.s = n;
+    um.s = m;
+    pn = vqtbl1_u8(un.v, (uint8x8_t){ 1, 3, 5, 7, 9, 11, 13, 15 });
+    pm = vqtbl1_u8(um.v, (uint8x8_t){ 1, 3, 5, 7, 9, 11, 13, 15 });
+    return clmul_8x8_packed((uint64_t)pn, (uint64_t)pm);
+}
+
+static inline uint64_t clmul_8x4_even(uint64_t n, uint64_t m)
+{
+    return int128_getlo(clmul_8x8_even(int128_make64(n), int128_make64(m)));
+}
+
+static inline uint64_t clmul_8x4_odd(uint64_t n, uint64_t m)
+{
+    return int128_getlo(clmul_8x8_odd(int128_make64(n), int128_make64(m)));
+}
+
+static inline Int128 clmul_16x4_packed_accel(uint16x4_t n, uint16x4_t m)
+{
+    union { uint32x4_t v; Int128 s; } u;
+    uint32x4_t r0, r1, r2;
+
+    /*
+     * Considering the per-byte multiplication:
+     *       ab
+     *       cd
+     *    -----
+     *       bd  << 0
+     *      bc   << 8
+     *      ad   << 8
+     *     ac    << 16
+     *
+     * We get the ac and bd rows of the result for free from the expanding
+     * packed multiply.  Reverse the two bytes in M, repeat, and we get the
+     * ad and bc results, but in the wrong column; shift to fix and sum all.
+     */
+    r0 = (uint32x4_t)vmull_p8((poly8x8_t)n, (poly8x8_t)m);
+    r1 = (uint32x4_t)vmull_p8((poly8x8_t)n, vrev16_p8((poly8x8_t)m));
+    r2 = r1 << 8; /* bc */
+    r1 = r1 >> 8; /* ad */
+    r1 &= (uint32x4_t){ 0x00ffff00, 0x00ffff00, 0x00ffff00, 0x00ffff00 };
+    r2 &= (uint32x4_t){ 0x00ffff00, 0x00ffff00, 0x00ffff00, 0x00ffff00 };
+    r0 = r0 ^ r1 ^ r2;
+
+    u.v = r0;
+    return u.s;
+}
+
+static inline Int128 clmul_16x4_even(Int128 n, Int128 m)
+{
+    union { uint32x4_t v; Int128 s; } um, un;
+    uint16x4_t pn, pm;
+
+    /* Extract even uint16_t. */
+    un.s = n;
+    um.s = m;
+    pn = vmovn_u32(un.v);
+    pm = vmovn_u32(um.v);
+    return clmul_16x4_packed_accel(pn, pm);
+}
+
+static inline Int128 clmul_16x4_odd(Int128 n, Int128 m)
+{
+    union { uint8x16_t v; Int128 s; } um, un;
+    uint16x4_t pn, pm;
+
+    /* Extract odd uint16_t. */
+    un.s = n;
+    um.s = m;
+    pn = (uint16x4_t)vqtbl1_u8(un.v, (uint8x8_t){ 2, 3, 6, 7, 10, 11, 14, 15 });
+    pm = (uint16x4_t)vqtbl1_u8(um.v, (uint8x8_t){ 2, 3, 6, 7, 10, 11, 14, 15 });
+    return clmul_16x4_packed_accel(pn, pm);
+}
+
+static inline uint64_t clmul_16x2_even(uint64_t n, uint64_t m)
+{
+    return int128_getlo(clmul_16x4_even(int128_make64(n), int128_make64(m)));
+}
+
+static inline uint64_t clmul_16x2_odd(uint64_t n, uint64_t m)
+{
+    return int128_getlo(clmul_16x4_odd(int128_make64(n), int128_make64(m)));
+}
+
+/*
+ * The 64x64->128 pmull is available with FEAT_PMULL.
+ */
+
+static inline Int128 ATTR_CLMUL_ACCEL
+clmul_64(uint64_t n, uint64_t m)
+{
+    union { poly128_t v; Int128 s; } u;
+
+    if (!HAVE_CLMUL_ACCEL) {
+        return clmul_64_gen(n, m);
+    }
+
+#ifdef CONFIG_ARM_AES_BUILTIN
+    u.v = vmull_p64((poly64_t)n, (poly64_t)m);
+#else
+    asm(".arch_extension aes\n\t"
+        "pmull %0.1q, %1.1d, %2.1d" : "=w"(u.v) : "w"(n), "w"(m));
+#endif
+    return u.s;
+}
+
+static inline uint64_t ATTR_CLMUL_ACCEL
+clmul_32(uint32_t n, uint32_t m)
+{
+    if (!HAVE_CLMUL_ACCEL) {
+        return clmul_32_gen(n, m);
+    }
+    return int128_getlo(clmul_64(n, m));
+}
+
+static inline Int128 ATTR_CLMUL_ACCEL
+clmul_32x2_even(Int128 n, Int128 m)
+{
+    union { uint64x2_t v; poly64_t h; Int128 s; } um, un, ur;
+    uint64x2_t r0, r2;
+
+    if (!HAVE_CLMUL_ACCEL) {
+        return clmul_32x2_even_gen(n, m);
+    }
+
+    un.s = n;
+    um.s = m;
+    un.v &= (uint64x2_t){ 0xffffffffu, 0xffffffffu };
+    um.v &= (uint64x2_t){ 0xffffffffu, 0xffffffffu };
+
+#ifdef CONFIG_ARM_AES_BUILTIN
+    r0 = (uint64x2_t)vmull_p64(un.h, um.h);
+    r2 = (uint64x2_t)vmull_high_p64((poly64x2_t)un.v, (poly64x2_t)um.v);
+#else
+    asm(".arch_extension aes\n\t"
+        "pmull %0.1q, %2.1d, %3.1d\n\t"
+        "pmull2 %1.1q, %2.2d, %3.2d"
+        : "=&w"(r0), "=w"(r2) : "w"(un.v), "w"(um.v));
+#endif
+
+    ur.v = vzip1q_u64(r0, r2);
+    return ur.s;
+}
+
+static inline Int128 ATTR_CLMUL_ACCEL
+clmul_32x2_odd(Int128 n, Int128 m)
+{
+    union { uint64x2_t v; poly64_t h; Int128 s; } um, un, ur;
+    uint64x2_t r0, r2;
+
+    if (!HAVE_CLMUL_ACCEL) {
+        return clmul_32x2_odd_gen(n, m);
+    }
+
+    un.s = n;
+    um.s = m;
+    un.v &= (uint64x2_t){ 0xffffffff00000000ull, 0xffffffff00000000ull };
+    um.v &= (uint64x2_t){ 0xffffffff00000000ull, 0xffffffff00000000ull };
+
+#ifdef CONFIG_ARM_AES_BUILTIN
+    r0 = (uint64x2_t)vmull_p64(un.h, um.h);
+    r2 = (uint64x2_t)vmull_high_p64((poly64x2_t)un.v, (poly64x2_t)um.v);
+#else
+    asm(".arch_extension aes\n\t"
+        "pmull %0.1q, %2.1d, %3.1d\n\t"
+        "pmull2 %1.1q, %2.2d, %3.2d"
+        : "=&w"(r0), "=w"(r2) : "w"(un.v), "w"(um.v));
+#endif
+
+    ur.v = vzip2q_u64(r0, r2);
+    return ur.s;
+}
+
+#endif /* AARCH64_HOST_CRYPTO_CLMUL_H */
diff --git a/util/cpuinfo-aarch64.c b/util/cpuinfo-aarch64.c
index ababc39550..1d565b8420 100644
--- a/util/cpuinfo-aarch64.c
+++ b/util/cpuinfo-aarch64.c
@@ -56,12 +56,14 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
     unsigned long hwcap = qemu_getauxval(AT_HWCAP);
     info |= (hwcap & HWCAP_ATOMICS ? CPUINFO_LSE : 0);
     info |= (hwcap & HWCAP_USCAT ? CPUINFO_LSE2 : 0);
-    info |= (hwcap & HWCAP_AES ? CPUINFO_AES: 0);
+    info |= (hwcap & HWCAP_AES ? CPUINFO_AES : 0);
+    info |= (hwcap & HWCAP_PMULL ? CPUINFO_PMULL : 0);
 #endif
 #ifdef CONFIG_DARWIN
     info |= sysctl_for_bool("hw.optional.arm.FEAT_LSE") * CPUINFO_LSE;
     info |= sysctl_for_bool("hw.optional.arm.FEAT_LSE2") * CPUINFO_LSE2;
     info |= sysctl_for_bool("hw.optional.arm.FEAT_AES") * CPUINFO_AES;
+    info |= sysctl_for_bool("hw.optional.arm.FEAT_PMULL") * CPUINFO_PMULL;
 #endif
 
     cpuinfo = info;
-- 
2.34.1


