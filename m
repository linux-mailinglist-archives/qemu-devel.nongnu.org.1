Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A93387162AF
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:53:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3zmH-0003ki-R6; Tue, 30 May 2023 09:52:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>)
 id 1q3zm6-0003kP-7s; Tue, 30 May 2023 09:52:34 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>)
 id 1q3zm2-0001Vw-Lc; Tue, 30 May 2023 09:52:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 78FFD6308E;
 Tue, 30 May 2023 13:52:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C30DC433EF;
 Tue, 30 May 2023 13:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1685454736;
 bh=3ndAr36uTBwYjy6I77BBaX0Rj0ALeAnFxLE6q/v9q9w=;
 h=From:To:Cc:Subject:Date:From;
 b=dGa7mlCe1a3Ou8/ZRKcAhDhOSjbuSLTHvFa3ABPMVScDhWK+XkBst/2iNCzpC8JyD
 +fR2K85IaKAiRxmCR8iL/NHvsfgW7NvnTGvTxdYcGpb5rObECbUKdvqTv6hjhedtU4
 GkzJHYunzOa7YciPOancSSN/YBpoYG5iT5VfJjkXZsf94oan9oLXf3embDGYKccgRH
 53NCbluPUOmq5lskUqp2Y7jr4Bz6KN5+0v6beGdayjDBInioSIiy1CIwIW1MLtVTuE
 9O8//us5foMIe1KS69xENnbXHVXXMgwUWNSnhUwAf6BHUBPkiltDi2sPxS+8DPHie0
 NdjponWBDUZjQ==
From: Ard Biesheuvel <ardb@kernel.org>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Ard Biesheuvel <ardb@kernel.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: [RFC PATCH] target/arm: use x86 intrinsics to implement AES
 instructions
Date: Tue, 30 May 2023 15:52:04 +0200
Message-Id: <20230530135204.2903761-1-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2890; i=ardb@kernel.org;
 h=from:subject; bh=3ndAr36uTBwYjy6I77BBaX0Rj0ALeAnFxLE6q/v9q9w=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIaX0f2Mtm1lPQIfLz7Lzf5sPpfVltpTUzFjxJm3uv5NLN
 6ZbRVd2lLIwiHEwyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIlEdDD8j1R8V3zXXUZH/x+f
 XPOVjb/OCvfeX3br2PIppw7+3BF5YAojw/5V/zpN26Z4ymqqPX0542D94rd8rn4RP99WzeH6XjT
 NghMA
X-Developer-Key: i=ardb@kernel.org; a=openpgp;
 fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=ardb@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
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

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Alex Bennée <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
Suggestions welcome on how to make this more generic across targets and
compilers etc.

 target/arm/tcg/crypto_helper.c | 43 ++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/target/arm/tcg/crypto_helper.c b/target/arm/tcg/crypto_helper.c
index d28690321f..961112b6bd 100644
--- a/target/arm/tcg/crypto_helper.c
+++ b/target/arm/tcg/crypto_helper.c
@@ -18,10 +18,32 @@
 #include "crypto/sm4.h"
 #include "vec_internal.h"
 
+#ifdef __x86_64
+#pragma GCC target ("aes")
+#include <cpuid.h>
+#include <wmmintrin.h>
+
+static bool have_aes(void)
+{
+    static int cpuid_have_aes = -1;
+
+    if (cpuid_have_aes == -1) {
+        unsigned int eax, ebx, ecx, edx;
+        int ret = __get_cpuid(0x1, &eax, &ebx, &ecx, &edx);
+
+        cpuid_have_aes = ret && (ecx & bit_AES);
+    }
+    return cpuid_have_aes > 0;
+}
+#endif
+
 union CRYPTO_STATE {
     uint8_t    bytes[16];
     uint32_t   words[4];
     uint64_t   l[2];
+#ifdef __x86_64
+    __m128i    vec;
+#endif
 };
 
 #if HOST_BIG_ENDIAN
@@ -54,6 +76,16 @@ static void do_crypto_aese(uint64_t *rd, uint64_t *rn,
     union CRYPTO_STATE st = { .l = { rn[0], rn[1] } };
     int i;
 
+#ifdef __x86_64__
+    if (have_aes()) {
+        __m128i *d = (__m128i *)rd;
+
+        *d = decrypt ? _mm_aesdeclast_si128(rk.vec ^ st.vec, (__m128i){})
+                     : _mm_aesenclast_si128(rk.vec ^ st.vec, (__m128i){});
+        return;
+    }
+#endif
+
     /* xor state vector with round key */
     rk.l[0] ^= st.l[0];
     rk.l[1] ^= st.l[1];
@@ -217,6 +249,17 @@ static void do_crypto_aesmc(uint64_t *rd, uint64_t *rm, bool decrypt)
     union CRYPTO_STATE st = { .l = { rm[0], rm[1] } };
     int i;
 
+#ifdef __x86_64__
+    if (have_aes()) {
+        __m128i *d = (__m128i *)rd;
+
+        *d = decrypt ? _mm_aesdec_si128(_mm_aesenclast_si128(st.vec, (__m128i){}),
+                                        (__m128i){})
+                     : _mm_aesenc_si128(_mm_aesdeclast_si128(st.vec, (__m128i){}),
+                                        (__m128i){});
+        return;
+    }
+#endif
     for (i = 0; i < 16; i += 4) {
         CR_ST_WORD(st, i >> 2) =
             mc[decrypt][CR_ST_BYTE(st, i)] ^
-- 
2.39.2


