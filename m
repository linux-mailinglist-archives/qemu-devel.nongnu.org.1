Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA569719C38
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 14:34:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4hUv-00062q-6g; Thu, 01 Jun 2023 08:33:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>)
 id 1q4hUs-00062Q-Vh; Thu, 01 Jun 2023 08:33:43 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>)
 id 1q4hUr-0002aZ-C5; Thu, 01 Jun 2023 08:33:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id C445F608D5;
 Thu,  1 Jun 2023 12:33:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3353C4339C;
 Thu,  1 Jun 2023 12:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1685622819;
 bh=ybhCCaRaMtEWM/hqlDKZlEwr5UC1ZUvXv1DqWaYk9MA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LdBq8ScUOELwb9t043Oo96oEIYYaBTlNLZzhG4nhfAVcb52kUYZIjTynJSAd9o46r
 6HzLJI6SwsVNM7VxuQZZNWz6JMyARKEObO5CaDx5iUcoiBkOo7E9fp9NuuhvigtC0t
 ecdDvBCx0HGuvqwcgkXbotefMAXbpj0iQrXZfe+pXOW3uRhxQONBbClWxnLMZBrvwF
 7+WQLEGPy4L9LuTHEtLoArrb+fcxHvrh4Q7WBMllFQ1OasO7IBa4gV4g+OwJ1pcr+z
 YhHz4hyxbOxhA73ZK6QvMuwdS3Mmmpez9Fy6Xqb/l7uOLFfQZZ+CLb4a+0TplRDXcl
 hm0cbzHVqlgxA==
From: Ard Biesheuvel <ardb@kernel.org>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Ard Biesheuvel <ardb@kernel.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: [PATCH 1/2] target/arm: Use x86 intrinsics to implement PMULL.P64
Date: Thu,  1 Jun 2023 14:33:31 +0200
Message-Id: <20230601123332.3297404-2-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230601123332.3297404-1-ardb@kernel.org>
References: <20230601123332.3297404-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2850; i=ardb@kernel.org;
 h=from:subject; bh=ybhCCaRaMtEWM/hqlDKZlEwr5UC1ZUvXv1DqWaYk9MA=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIaViglixxrJ5/yNtmaMur5FTufNlysLajHyX/+emhLWl6
 ig9s3/aUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACZSEcrIsHex0Z1na8PK9BYe
 VgkSTCljm3zOdU/V3KMzHQPs/vCuWsPwVz43oJbD7KbbT4PySzs3nt8qfMdk/cp3zru+TLr8W+z
 rVnYA
X-Developer-Key: i=ardb@kernel.org; a=openpgp;
 fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=ardb@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
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

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 host/include/i386/host/cpuinfo.h |  1 +
 target/arm/tcg/vec_helper.c      | 26 +++++++++++++++++++-
 util/cpuinfo-i386.c              |  1 +
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/host/include/i386/host/cpuinfo.h b/host/include/i386/host/cpuinfo.h
index 073d0a426f31487d..cf4ced844760d28f 100644
--- a/host/include/i386/host/cpuinfo.h
+++ b/host/include/i386/host/cpuinfo.h
@@ -27,6 +27,7 @@
 #define CPUINFO_ATOMIC_VMOVDQA  (1u << 16)
 #define CPUINFO_ATOMIC_VMOVDQU  (1u << 17)
 #define CPUINFO_AES             (1u << 18)
+#define CPUINFO_PMULL           (1u << 19)
 
 /* Initialized with a constructor. */
 extern unsigned cpuinfo;
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index f59d3b26eacf08f8..fb422627588439b3 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -25,6 +25,14 @@
 #include "qemu/int128.h"
 #include "vec_internal.h"
 
+#ifdef __x86_64__
+#include "host/cpuinfo.h"
+#include <wmmintrin.h>
+#define TARGET_PMULL  __attribute__((__target__("pclmul")))
+#else
+#define TARGET_PMULL
+#endif
+
 /*
  * Data for expanding active predicate bits to bytes, for byte elements.
  *
@@ -2010,12 +2018,28 @@ void HELPER(gvec_pmul_b)(void *vd, void *vn, void *vm, uint32_t desc)
  * Because of the lanes are not accessed in strict columns,
  * this probably cannot be turned into a generic helper.
  */
-void HELPER(gvec_pmull_q)(void *vd, void *vn, void *vm, uint32_t desc)
+void TARGET_PMULL HELPER(gvec_pmull_q)(void *vd, void *vn, void *vm, uint32_t desc)
 {
     intptr_t i, j, opr_sz = simd_oprsz(desc);
     intptr_t hi = simd_data(desc);
     uint64_t *d = vd, *n = vn, *m = vm;
 
+#ifdef __x86_64__
+    if (cpuinfo & CPUINFO_PMULL) {
+	switch (hi) {
+	case 0:
+		*(__m128i *)vd = _mm_clmulepi64_si128(*(__m128i *)vm, *(__m128i *)vn, 0x0);
+		break;
+	case 1:
+		*(__m128i *)vd = _mm_clmulepi64_si128(*(__m128i *)vm, *(__m128i *)vn, 0x11);
+		break;
+	default:
+		g_assert_not_reached();
+	}
+        return;
+    }
+#endif
+
     for (i = 0; i < opr_sz / 8; i += 2) {
         uint64_t nn = n[i + hi];
         uint64_t mm = m[i + hi];
diff --git a/util/cpuinfo-i386.c b/util/cpuinfo-i386.c
index 3043f066c0182dc8..8930e13451201a64 100644
--- a/util/cpuinfo-i386.c
+++ b/util/cpuinfo-i386.c
@@ -40,6 +40,7 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
         info |= (c & bit_MOVBE ? CPUINFO_MOVBE : 0);
         info |= (c & bit_POPCNT ? CPUINFO_POPCNT : 0);
         info |= (c & bit_AES ? CPUINFO_AES : 0);
+        info |= (c & bit_PCLMULQDQ ? CPUINFO_PMULL : 0);
 
         /* For AVX features, we must check available and usable. */
         if ((c & bit_AVX) && (c & bit_OSXSAVE)) {
-- 
2.39.2


