Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5396074C707
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 20:31:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIZAf-0008QZ-Hr; Sun, 09 Jul 2023 14:30:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZAZ-0008Me-MC
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:30:03 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZAW-0000J5-NO
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:30:03 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3141fa31c2bso3774541f8f.2
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 11:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688927399; x=1691519399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tquFfTdtw0sVSZbN7ZybV+/6BBhwf96oST0EwHIj8d8=;
 b=Ty1GJeCnXoWbk24HmHQ3kaOHMjdo/TqGuBcMtQma2lUSj4vOnlxA49QOqzg6R7HKkH
 RIwTSNbopnXPwKRNa4NoxoFyJKP46wuz+ATKZ1ScGK7ckM58nMBKzeqaVZGGssnmN6Oa
 VW+3E5OML0DZrdz3XrDTSul2pRMhigDqxF4a0OHCiuBGLvgiTu59ZdYO+J1L9Wscli4v
 d3q6MfoxU7DCaDtrYfX7c8wRlmpiftqy67yUj+M4WQcHndOA30B7yT8aZMYI/JwAeY+E
 spmSFKzmOe4jnDzZEGxAnOgbp4LS1lHkvtXGd2jSZROL3o0ZTPYP6Tplt5WOrZu7Q7BB
 NGIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688927399; x=1691519399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tquFfTdtw0sVSZbN7ZybV+/6BBhwf96oST0EwHIj8d8=;
 b=OVs0MswPmfWf9d/Eec+SVFVjD2OxnCulBmhS2H78kdHSxbmIuYYR+lcwFgO8DgFxeO
 nmGOraLw0sW107XiOsSbmDAnzcRvjIgzLG9tJmgJY6V/+oMyZqTkTJrNK1Ou/ZRqhqnN
 fLk+FSYJoRTGgSZCiKUeSbwTFZAmoPab0z3eH1eylYQICsoPxlxnpZsEswQdjWlBJhiD
 mE7DhW8ygTmU01sizPSYkeL1PsMkiIPkZ3kx8YdZqB4hUdwTtG62SrgIUbMH9QicCkdf
 NyJIhlhkoLd0JgnJ/mhYKfOU52OA4N7Ra1gkNRdyH3/41dy2iW3TaheCS4fccn5PN08W
 ykUQ==
X-Gm-Message-State: ABy/qLY9xne+6iaQHS7O2Khby1IQ8DHEjlXO1kvKKuDcFTuP44svOvkr
 qsNuq9p2+Z3THpeRnM9G+/O2D+rCOpI7DwaAvJ32/A==
X-Google-Smtp-Source: APBJJlEebitohvqVoYA/940ALM7N+0vGanTrOYe+GXQ4csDpO1HGj2yIiPCtPCO4EtkM6UZ7KbruvA==
X-Received: by 2002:adf:f40e:0:b0:313:ec5d:95b5 with SMTP id
 g14-20020adff40e000000b00313ec5d95b5mr9850171wro.60.1688927399363; 
 Sun, 09 Jul 2023 11:29:59 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 q15-20020a7bce8f000000b003fbe791a0e8sm8317108wmj.0.2023.07.09.11.29.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 11:29:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: [PULL 14/37] host/include/ppc: Implement aes-round.h
Date: Sun,  9 Jul 2023 19:28:39 +0100
Message-Id: <20230709182934.309468-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709182934.309468-1-richard.henderson@linaro.org>
References: <20230709182934.309468-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x432.google.com
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

Detect CRYPTO in cpuinfo; implement the accel hooks.

Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/ppc/host/cpuinfo.h            |   1 +
 host/include/ppc/host/crypto/aes-round.h   | 182 +++++++++++++++++++++
 host/include/ppc64/host/crypto/aes-round.h |   1 +
 util/cpuinfo-ppc.c                         |   8 +
 4 files changed, 192 insertions(+)
 create mode 100644 host/include/ppc/host/crypto/aes-round.h
 create mode 100644 host/include/ppc64/host/crypto/aes-round.h

diff --git a/host/include/ppc/host/cpuinfo.h b/host/include/ppc/host/cpuinfo.h
index df11e8d417..29ee7f9ef8 100644
--- a/host/include/ppc/host/cpuinfo.h
+++ b/host/include/ppc/host/cpuinfo.h
@@ -16,6 +16,7 @@
 #define CPUINFO_ISEL            (1u << 5)
 #define CPUINFO_ALTIVEC         (1u << 6)
 #define CPUINFO_VSX             (1u << 7)
+#define CPUINFO_CRYPTO          (1u << 8)
 
 /* Initialized with a constructor. */
 extern unsigned cpuinfo;
diff --git a/host/include/ppc/host/crypto/aes-round.h b/host/include/ppc/host/crypto/aes-round.h
new file mode 100644
index 0000000000..8062d2a537
--- /dev/null
+++ b/host/include/ppc/host/crypto/aes-round.h
@@ -0,0 +1,182 @@
+/*
+ * Power v2.07 specific aes acceleration.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef PPC_HOST_CRYPTO_AES_ROUND_H
+#define PPC_HOST_CRYPTO_AES_ROUND_H
+
+#ifdef __ALTIVEC__
+#include "host/cpuinfo.h"
+
+#ifdef __CRYPTO__
+# define HAVE_AES_ACCEL  true
+#else
+# define HAVE_AES_ACCEL  likely(cpuinfo & CPUINFO_CRYPTO)
+#endif
+#define ATTR_AES_ACCEL
+
+/*
+ * While there is <altivec.h>, both gcc and clang "aid" with the
+ * endianness issues in different ways. Just use inline asm instead.
+ */
+
+/* Bytes in memory are host-endian; bytes in register are @be. */
+static inline AESStateVec aes_accel_ld(const AESState *p, bool be)
+{
+    AESStateVec r;
+
+    if (be) {
+        asm("lvx %0, 0, %1" : "=v"(r) : "r"(p), "m"(*p));
+    } else if (HOST_BIG_ENDIAN) {
+        AESStateVec rev = {
+            15, 14, 13, 12, 11, 10, 9, 8, 7,  6,  5,  4,  3,  2,  1,  0,
+        };
+        asm("lvx %0, 0, %1\n\t"
+            "vperm %0, %0, %0, %2"
+            : "=v"(r) : "r"(p), "v"(rev), "m"(*p));
+    } else {
+#ifdef __POWER9_VECTOR__
+        asm("lxvb16x %x0, 0, %1" : "=v"(r) : "r"(p), "m"(*p));
+#else
+        asm("lxvd2x %x0, 0, %1\n\t"
+            "xxpermdi %x0, %x0, %x0, 2"
+            : "=v"(r) : "r"(p), "m"(*p));
+#endif
+    }
+    return r;
+}
+
+static void aes_accel_st(AESState *p, AESStateVec r, bool be)
+{
+    if (be) {
+        asm("stvx %1, 0, %2" : "=m"(*p) : "v"(r), "r"(p));
+    } else if (HOST_BIG_ENDIAN) {
+        AESStateVec rev = {
+            15, 14, 13, 12, 11, 10, 9, 8, 7,  6,  5,  4,  3,  2,  1,  0,
+        };
+        asm("vperm %1, %1, %1, %2\n\t"
+            "stvx %1, 0, %3"
+            : "=m"(*p), "+v"(r) : "v"(rev), "r"(p));
+    } else {
+#ifdef __POWER9_VECTOR__
+        asm("stxvb16x %x1, 0, %2" : "=m"(*p) : "v"(r), "r"(p));
+#else
+        asm("xxpermdi %x1, %x1, %x1, 2\n\t"
+            "stxvd2x %x1, 0, %2"
+            : "=m"(*p), "+v"(r) : "r"(p));
+#endif
+    }
+}
+
+static inline AESStateVec aes_accel_vcipher(AESStateVec d, AESStateVec k)
+{
+    asm("vcipher %0, %0, %1" : "+v"(d) : "v"(k));
+    return d;
+}
+
+static inline AESStateVec aes_accel_vncipher(AESStateVec d, AESStateVec k)
+{
+    asm("vncipher %0, %0, %1" : "+v"(d) : "v"(k));
+    return d;
+}
+
+static inline AESStateVec aes_accel_vcipherlast(AESStateVec d, AESStateVec k)
+{
+    asm("vcipherlast %0, %0, %1" : "+v"(d) : "v"(k));
+    return d;
+}
+
+static inline AESStateVec aes_accel_vncipherlast(AESStateVec d, AESStateVec k)
+{
+    asm("vncipherlast %0, %0, %1" : "+v"(d) : "v"(k));
+    return d;
+}
+
+static inline void
+aesenc_MC_accel(AESState *ret, const AESState *st, bool be)
+{
+    AESStateVec t, z = { };
+
+    t = aes_accel_ld(st, be);
+    t = aes_accel_vncipherlast(t, z);
+    t = aes_accel_vcipher(t, z);
+    aes_accel_st(ret, t, be);
+}
+
+static inline void
+aesenc_SB_SR_AK_accel(AESState *ret, const AESState *st,
+                      const AESState *rk, bool be)
+{
+    AESStateVec t, k;
+
+    t = aes_accel_ld(st, be);
+    k = aes_accel_ld(rk, be);
+    t = aes_accel_vcipherlast(t, k);
+    aes_accel_st(ret, t, be);
+}
+
+static inline void
+aesenc_SB_SR_MC_AK_accel(AESState *ret, const AESState *st,
+                         const AESState *rk, bool be)
+{
+    AESStateVec t, k;
+
+    t = aes_accel_ld(st, be);
+    k = aes_accel_ld(rk, be);
+    t = aes_accel_vcipher(t, k);
+    aes_accel_st(ret, t, be);
+}
+
+static inline void
+aesdec_IMC_accel(AESState *ret, const AESState *st, bool be)
+{
+    AESStateVec t, z = { };
+
+    t = aes_accel_ld(st, be);
+    t = aes_accel_vcipherlast(t, z);
+    t = aes_accel_vncipher(t, z);
+    aes_accel_st(ret, t, be);
+}
+
+static inline void
+aesdec_ISB_ISR_AK_accel(AESState *ret, const AESState *st,
+                        const AESState *rk, bool be)
+{
+    AESStateVec t, k;
+
+    t = aes_accel_ld(st, be);
+    k = aes_accel_ld(rk, be);
+    t = aes_accel_vncipherlast(t, k);
+    aes_accel_st(ret, t, be);
+}
+
+static inline void
+aesdec_ISB_ISR_AK_IMC_accel(AESState *ret, const AESState *st,
+                            const AESState *rk, bool be)
+{
+    AESStateVec t, k;
+
+    t = aes_accel_ld(st, be);
+    k = aes_accel_ld(rk, be);
+    t = aes_accel_vncipher(t, k);
+    aes_accel_st(ret, t, be);
+}
+
+static inline void
+aesdec_ISB_ISR_IMC_AK_accel(AESState *ret, const AESState *st,
+                            const AESState *rk, bool be)
+{
+    AESStateVec t, k, z = { };
+
+    t = aes_accel_ld(st, be);
+    k = aes_accel_ld(rk, be);
+    t = aes_accel_vncipher(t, z);
+    aes_accel_st(ret, t ^ k, be);
+}
+#else
+/* Without ALTIVEC, we can't even write inline assembly. */
+#include "host/include/generic/host/crypto/aes-round.h"
+#endif
+
+#endif /* PPC_HOST_CRYPTO_AES_ROUND_H */
diff --git a/host/include/ppc64/host/crypto/aes-round.h b/host/include/ppc64/host/crypto/aes-round.h
new file mode 100644
index 0000000000..5eeba6dcb7
--- /dev/null
+++ b/host/include/ppc64/host/crypto/aes-round.h
@@ -0,0 +1 @@
+#include "host/include/ppc/host/crypto/aes-round.h"
diff --git a/util/cpuinfo-ppc.c b/util/cpuinfo-ppc.c
index d95adc8ccd..7212afa45d 100644
--- a/util/cpuinfo-ppc.c
+++ b/util/cpuinfo-ppc.c
@@ -48,6 +48,14 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
         /* We only care about the portion of VSX that overlaps Altivec. */
         if (hwcap & PPC_FEATURE_HAS_VSX) {
             info |= CPUINFO_VSX;
+            /*
+             * We use VSX especially for little-endian, but we should
+             * always have both anyway, since VSX came with Power7
+             * and crypto came with Power8.
+             */
+            if (hwcap2 & PPC_FEATURE2_HAS_VEC_CRYPTO) {
+                info |= CPUINFO_CRYPTO;
+            }
         }
     }
 
-- 
2.34.1


