Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78222717DEE
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 13:23:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4Jv1-0008W4-VR; Wed, 31 May 2023 07:23:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>)
 id 1q4Jum-0008U6-AY; Wed, 31 May 2023 07:22:54 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>)
 id 1q4Juj-0006OZ-Bc; Wed, 31 May 2023 07:22:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 3751C62B8D;
 Wed, 31 May 2023 11:22:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28B4CC4339E;
 Wed, 31 May 2023 11:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1685532166;
 bh=CmgtESpaAov4b9gatdrn0WcbuhDN0cK8PVQan2txeW0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SIUwjkDX9OGkU0v93WA+tIL71oUUWu0MLM+ab0uSmeLhAv+KHtHqNhxcPtWF0jVjL
 F1C8f9Q20l4U8Q1hgrcYUV0DHPoHyndQDQiwJG6ca5kO82JGDKiQDHHbi/Rt3hFbvY
 BNvMcql2Vz6qnnoYQfot7pgKdQgLRbCapFA+koW9OFj7H5AyCi9w+oy8ojyhGqhoL4
 owGEfz7Pmy6w+AXc1UfRMLBUNBUQckxSYNdOuJy8A6nhEwmiTalxKLr4mHmumHloav
 6ouP5k4ROFPJm46vEyMrQHU2tX3nrxK5uz6meMOhMaIFxofPt4dhkkHqFmkee6KjJY
 FqDNyFN+/oHUQ==
From: Ard Biesheuvel <ardb@kernel.org>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Ard Biesheuvel <ardb@kernel.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: [PATCH v2 1/2] target/arm: use x86 intrinsics to implement AES
 instructions
Date: Wed, 31 May 2023 13:22:38 +0200
Message-Id: <20230531112239.3164777-2-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531112239.3164777-1-ardb@kernel.org>
References: <20230531112239.3164777-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4305; i=ardb@kernel.org;
 h=from:subject; bh=CmgtESpaAov4b9gatdrn0WcbuhDN0cK8PVQan2txeW0=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIaVc99el322rmW4wnLFa8efPkmwxt/I9kXoCfyfl7o5Pl
 a2eY72so5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAExk9gGG/2UiixvzEltk2X+8
 cDNoVdlz94GsZl/Ajv1HtZI77DQNhRkZrnHM4TPtOSw+pbnqxudj3Z+e8f6YcqNWtl6b4YLH/Zx
 wbgA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp;
 fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=ardb@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

ARM intrinsics for AES deviate from the x86 ones in the way they cover
the different stages of each round, and so mapping one to the other is
not entirely straight-forward. However, with a bit of care, we can still
use the x86 ones to emulate the ARM ones, which makes them constant time
(which is an important property in crypto) and substantially more
efficient.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 host/include/i386/host/cpuinfo.h |  1 +
 target/arm/tcg/crypto_helper.c   | 37 ++++++++++++++++++--
 util/cpuinfo-i386.c              |  1 +
 3 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/host/include/i386/host/cpuinfo.h b/host/include/i386/host/cpuinfo.h
index a6537123cf80ec5b..073d0a426f31487d 100644
--- a/host/include/i386/host/cpuinfo.h
+++ b/host/include/i386/host/cpuinfo.h
@@ -26,6 +26,7 @@
 #define CPUINFO_AVX512VBMI2     (1u << 15)
 #define CPUINFO_ATOMIC_VMOVDQA  (1u << 16)
 #define CPUINFO_ATOMIC_VMOVDQU  (1u << 17)
+#define CPUINFO_AES             (1u << 18)
 
 /* Initialized with a constructor. */
 extern unsigned cpuinfo;
diff --git a/target/arm/tcg/crypto_helper.c b/target/arm/tcg/crypto_helper.c
index d28690321f0b86ea..747c061b5a1b0e5e 100644
--- a/target/arm/tcg/crypto_helper.c
+++ b/target/arm/tcg/crypto_helper.c
@@ -18,10 +18,21 @@
 #include "crypto/sm4.h"
 #include "vec_internal.h"
 
+#ifdef __x86_64__
+#include "host/cpuinfo.h"
+#include <wmmintrin.h>
+#define TARGET_AES  __attribute__((__target__("aes")))
+#else
+#define TARGET_AES
+#endif
+
 union CRYPTO_STATE {
     uint8_t    bytes[16];
     uint32_t   words[4];
     uint64_t   l[2];
+#ifdef __x86_64__
+    __m128i    vec;
+#endif
 };
 
 #if HOST_BIG_ENDIAN
@@ -45,8 +56,8 @@ static void clear_tail_16(void *vd, uint32_t desc)
     clear_tail(vd, opr_sz, max_sz);
 }
 
-static void do_crypto_aese(uint64_t *rd, uint64_t *rn,
-                           uint64_t *rm, bool decrypt)
+static void TARGET_AES do_crypto_aese(uint64_t *rd, uint64_t *rn,
+                                      uint64_t *rm, bool decrypt)
 {
     static uint8_t const * const sbox[2] = { AES_sbox, AES_isbox };
     static uint8_t const * const shift[2] = { AES_shifts, AES_ishifts };
@@ -54,6 +65,16 @@ static void do_crypto_aese(uint64_t *rd, uint64_t *rn,
     union CRYPTO_STATE st = { .l = { rn[0], rn[1] } };
     int i;
 
+#ifdef __x86_64__
+    if (cpuinfo & CPUINFO_AES) {
+        __m128i *d = (__m128i *)rd, z = {};
+
+        *d = decrypt ? _mm_aesdeclast_si128(rk.vec ^ st.vec, z)
+                     : _mm_aesenclast_si128(rk.vec ^ st.vec, z);
+        return;
+    }
+#endif
+
     /* xor state vector with round key */
     rk.l[0] ^= st.l[0];
     rk.l[1] ^= st.l[1];
@@ -78,7 +99,7 @@ void HELPER(crypto_aese)(void *vd, void *vn, void *vm, uint32_t desc)
     clear_tail(vd, opr_sz, simd_maxsz(desc));
 }
 
-static void do_crypto_aesmc(uint64_t *rd, uint64_t *rm, bool decrypt)
+static void TARGET_AES do_crypto_aesmc(uint64_t *rd, uint64_t *rm, bool decrypt)
 {
     static uint32_t const mc[][256] = { {
         /* MixColumns lookup table */
@@ -217,6 +238,16 @@ static void do_crypto_aesmc(uint64_t *rd, uint64_t *rm, bool decrypt)
     union CRYPTO_STATE st = { .l = { rm[0], rm[1] } };
     int i;
 
+#ifdef __x86_64__
+    if (cpuinfo & CPUINFO_AES) {
+        __m128i *d = (__m128i *)rd, z = {};
+
+        *d = decrypt ? _mm_aesimc_si128(st.vec)
+                     : _mm_aesenc_si128(_mm_aesdeclast_si128(st.vec, z), z);
+        return;
+    }
+#endif
+
     for (i = 0; i < 16; i += 4) {
         CR_ST_WORD(st, i >> 2) =
             mc[decrypt][CR_ST_BYTE(st, i)] ^
diff --git a/util/cpuinfo-i386.c b/util/cpuinfo-i386.c
index ab6143d9e77291f1..3043f066c0182dc8 100644
--- a/util/cpuinfo-i386.c
+++ b/util/cpuinfo-i386.c
@@ -39,6 +39,7 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
         info |= (c & bit_SSE4_1 ? CPUINFO_SSE4 : 0);
         info |= (c & bit_MOVBE ? CPUINFO_MOVBE : 0);
         info |= (c & bit_POPCNT ? CPUINFO_POPCNT : 0);
+        info |= (c & bit_AES ? CPUINFO_AES : 0);
 
         /* For AVX features, we must check available and usable. */
         if ((c & bit_AVX) && (c & bit_OSXSAVE)) {
-- 
2.39.2


