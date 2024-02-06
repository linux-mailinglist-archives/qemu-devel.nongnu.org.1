Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5B084BEEC
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Feb 2024 21:50:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXSNV-0004v4-80; Tue, 06 Feb 2024 15:49:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amonakov@ispras.ru>)
 id 1rXSNS-0004uB-Ho
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 15:49:10 -0500
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amonakov@ispras.ru>)
 id 1rXSNN-0001c2-76
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 15:49:10 -0500
Received: from localhost.intra.ispras.ru (unknown [10.10.3.121])
 by mail.ispras.ru (Postfix) with ESMTP id B85CC4076725;
 Tue,  6 Feb 2024 20:48:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru B85CC4076725
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1707252520;
 bh=Y2cpClKJ7CYNoOrL26LehvbpSaAZoGzNt0b2/PjT/uc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=eM+f+3WgQ0IWhT0tlwEJPDY7EbRRy8fabU9agpdDsI8eJf2oRGqMWgjszmFbUHIen
 YWuCmqXQ6jnZHWCaeGraFGWiyufMSJEp0HEuUxrWXAYgg1IXXvh5KeQ8LbdFuIfKvd
 w5/pGAbkD0K4981aK4jVeHRSvRNE6RsApOUmuQZY=
From: Alexander Monakov <amonakov@ispras.ru>
To: qemu-devel@nongnu.org
Cc: Mikhail Romanov <mmromanov@ispras.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Monakov <amonakov@ispras.ru>
Subject: [PATCH v3 1/6] util/bufferiszero: remove SSE4.1 variant
Date: Tue,  6 Feb 2024 23:48:04 +0300
Message-Id: <20240206204809.9859-2-amonakov@ispras.ru>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20240206204809.9859-1-amonakov@ispras.ru>
References: <20240206204809.9859-1-amonakov@ispras.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=83.149.199.84; envelope-from=amonakov@ispras.ru;
 helo=mail.ispras.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The SSE4.1 variant is virtually identical to the SSE2 variant, except
for using 'PTEST+JNZ' in place of 'PCMPEQB+PMOVMSKB+CMP+JNE' for testing
if an SSE register is all zeroes. The PTEST instruction decodes to two
uops, so it can be handled only by the complex decoder, and since
CMP+JNE are macro-fused, both sequences decode to three uops. The uops
comprising the PTEST instruction dispatch to p0 and p5 on Intel CPUs, so
PCMPEQB+PMOVMSKB is comparatively more flexible from dispatch
standpoint.

Hence, the use of PTEST brings no benefit from throughput standpoint.
Its latency is not important, since it feeds only a conditional jump,
which terminates the dependency chain.

I never observed PTEST variants to be faster on real hardware.

Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
Signed-off-by: Mikhail Romanov <mmromanov@ispras.ru>
---
 util/bufferiszero.c | 29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/util/bufferiszero.c b/util/bufferiszero.c
index 3e6a5dfd63..f5a3634f9a 100644
--- a/util/bufferiszero.c
+++ b/util/bufferiszero.c
@@ -100,34 +100,6 @@ buffer_zero_sse2(const void *buf, size_t len)
 }
 
 #ifdef CONFIG_AVX2_OPT
-static bool __attribute__((target("sse4")))
-buffer_zero_sse4(const void *buf, size_t len)
-{
-    __m128i t = _mm_loadu_si128(buf);
-    __m128i *p = (__m128i *)(((uintptr_t)buf + 5 * 16) & -16);
-    __m128i *e = (__m128i *)(((uintptr_t)buf + len) & -16);
-
-    /* Loop over 16-byte aligned blocks of 64.  */
-    while (likely(p <= e)) {
-        __builtin_prefetch(p);
-        if (unlikely(!_mm_testz_si128(t, t))) {
-            return false;
-        }
-        t = p[-4] | p[-3] | p[-2] | p[-1];
-        p += 4;
-    }
-
-    /* Finish the aligned tail.  */
-    t |= e[-3];
-    t |= e[-2];
-    t |= e[-1];
-
-    /* Finish the unaligned tail.  */
-    t |= _mm_loadu_si128(buf + len - 16);
-
-    return _mm_testz_si128(t, t);
-}
-
 static bool __attribute__((target("avx2")))
 buffer_zero_avx2(const void *buf, size_t len)
 {
@@ -221,7 +193,6 @@ select_accel_cpuinfo(unsigned info)
 #endif
 #ifdef CONFIG_AVX2_OPT
         { CPUINFO_AVX2,    128, buffer_zero_avx2 },
-        { CPUINFO_SSE4,     64, buffer_zero_sse4 },
 #endif
         { CPUINFO_SSE2,     64, buffer_zero_sse2 },
         { CPUINFO_ALWAYS,    0, buffer_zero_int },
-- 
2.32.0


